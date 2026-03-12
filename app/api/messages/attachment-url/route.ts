import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

const SIGNED_URL_EXPIRY = 3600 // 1 hour

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

  const { path, matchId } = body as Record<string, unknown>

  if (!path || typeof path !== 'string' || !matchId || typeof matchId !== 'string') {
    return NextResponse.json({ error: 'Missing path or matchId' }, { status: 400 })
  }

  // Prevent path traversal
  if (path.includes('..') || path.startsWith('/') || path.includes('\0')) {
    return NextResponse.json({ error: 'Invalid path' }, { status: 400 })
  }

  // Verify user is a participant in the match
  const { data: match } = await supabase
    .from('matches')
    .select('giver_id, seeker_id')
    .eq('id', matchId)
    .single()

  if (!match || (match.giver_id !== user.id && match.seeker_id !== user.id)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  // Verify the file belongs to this match (path starts with matchId/)
  if (!path.startsWith(`${matchId}/`)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  const { data, error } = await supabase.storage
    .from('attachments')
    .createSignedUrl(path, SIGNED_URL_EXPIRY)

  if (error || !data) {
    return NextResponse.json({ error: 'Failed to generate URL' }, { status: 500 })
  }

  return NextResponse.json({ url: data.signedUrl })
}
