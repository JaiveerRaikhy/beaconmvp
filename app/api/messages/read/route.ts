import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

const MAX_MESSAGE_IDS = 100

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

  const { messageIds } = body as Record<string, unknown>

  if (!messageIds || !Array.isArray(messageIds) || messageIds.length === 0) {
    return NextResponse.json({ error: 'Missing messageIds' }, { status: 400 })
  }

  // Limit array size to prevent abuse
  if (messageIds.length > MAX_MESSAGE_IDS) {
    return NextResponse.json(
      { error: `Too many messageIds (max ${MAX_MESSAGE_IDS})` },
      { status: 400 }
    )
  }

  // Validate all IDs are strings
  if (!messageIds.every((id: unknown) => typeof id === 'string')) {
    return NextResponse.json({ error: 'Invalid messageIds format' }, { status: 400 })
  }

  // Mark messages as read (only messages sent by others)
  const { error } = await supabase
    .from('messages')
    .update({ read_at: new Date().toISOString() })
    .in('id', messageIds)
    .neq('sender_id', user.id)
    .is('read_at', null)

  if (error) {
    return NextResponse.json({ error: 'Failed to mark as read' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}
