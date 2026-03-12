import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'
import { sanitizeText } from '@/lib/security/sanitize'

const MAX_MESSAGE_LENGTH = 5000

export async function POST(request: Request) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  let body: unknown
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid request body' }, { status: 400 })
  }

  if (!body || typeof body !== 'object' || Array.isArray(body)) {
    return NextResponse.json({ error: 'Invalid request body' }, { status: 400 })
  }

  const { matchId, content, attachments } = body as Record<string, unknown>

  if (!matchId || typeof matchId !== 'string') {
    return NextResponse.json({ error: 'Missing required fields' }, { status: 400 })
  }

  if (!content || typeof content !== 'string' || !content.trim()) {
    return NextResponse.json({ error: 'Missing required fields' }, { status: 400 })
  }

  // Enforce message length limit
  if (content.length > MAX_MESSAGE_LENGTH) {
    return NextResponse.json(
      { error: `Message too long (max ${MAX_MESSAGE_LENGTH} characters)` },
      { status: 400 }
    )
  }

  const sanitizedContent = sanitizeText(content)
  if (!sanitizedContent) {
    return NextResponse.json({ error: 'Invalid message content' }, { status: 400 })
  }

  // Validate attachments shape if provided
  let sanitizedAttachments = null
  if (attachments !== null && attachments !== undefined) {
    if (!Array.isArray(attachments)) {
      return NextResponse.json({ error: 'Invalid attachments format' }, { status: 400 })
    }
    if (attachments.length > 10) {
      return NextResponse.json({ error: 'Too many attachments (max 10)' }, { status: 400 })
    }
    for (const att of attachments) {
      if (!att || typeof att !== 'object') {
        return NextResponse.json({ error: 'Invalid attachment entry' }, { status: 400 })
      }
      const { url, path, filename, size, type } = att as Record<string, unknown>
      if (typeof filename !== 'string' || typeof size !== 'number' || typeof type !== 'string') {
        return NextResponse.json({ error: 'Invalid attachment entry' }, { status: 400 })
      }
      if (typeof url !== 'string' && typeof path !== 'string') {
        return NextResponse.json({ error: 'Invalid attachment entry' }, { status: 400 })
      }
    }
    sanitizedAttachments = attachments
  }

  // Verify user is part of this match and match is active
  const { data: match } = await supabase
    .from('matches')
    .select('giver_id, seeker_id, status, first_message_at, expires_at')
    .eq('id', matchId)
    .single()

  if (!match || (match.giver_id !== user.id && match.seeker_id !== user.id)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  // Prevent messaging on non-accepted or expired matches
  if (match.status !== 'accepted') {
    return NextResponse.json({ error: 'This match is not active' }, { status: 403 })
  }

  if (match.expires_at && new Date(match.expires_at) < new Date()) {
    return NextResponse.json({ error: 'This match has expired' }, { status: 403 })
  }

  // Insert message
  const { data: message, error } = await supabase
    .from('messages')
    .insert({
      match_id: matchId,
      sender_id: user.id,
      content: sanitizedContent,
      attachments: sanitizedAttachments,
    })
    .select(`
      *,
      sender:profiles!messages_sender_id_fkey(
        id, full_name, profile_picture_url
      )
    `)
    .single()

  if (error) {
    console.error('Error sending message:', error)
    return NextResponse.json({ error: 'Failed to send message' }, { status: 500 })
  }

  // Update first_message_at if this is the first message
  if (!match.first_message_at) {
    await supabase
      .from('matches')
      .update({ first_message_at: new Date().toISOString() })
      .eq('id', matchId)
  }

  return NextResponse.json({ message })
}
