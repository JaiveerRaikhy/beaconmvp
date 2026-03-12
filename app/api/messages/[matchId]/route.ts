import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

const DEFAULT_LIMIT = 50
const MAX_LIMIT = 100

export async function GET(
  request: Request,
  { params }: { params: Promise<{ matchId: string }> }
) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const { matchId } = await params
  const url = new URL(request.url)
  const cursor = url.searchParams.get('cursor') // ISO timestamp of oldest message loaded
  const limitParam = parseInt(url.searchParams.get('limit') || '', 10)
  const limit = Math.min(
    Number.isFinite(limitParam) && limitParam > 0 ? limitParam : DEFAULT_LIMIT,
    MAX_LIMIT
  )

  // Verify user is part of this match
  const { data: match } = await supabase
    .from('matches')
    .select('giver_id, seeker_id')
    .eq('id', matchId)
    .single()

  if (!match || (match.giver_id !== user.id && match.seeker_id !== user.id)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  // Build query - fetch messages in descending order for cursor-based pagination,
  // then reverse for chronological display
  let query = supabase
    .from('messages')
    .select(`
      *,
      sender:profiles!messages_sender_id_fkey(
        id, full_name, profile_picture_url
      )
    `)
    .eq('match_id', matchId)
    .order('created_at', { ascending: false })
    .limit(limit + 1) // Fetch one extra to determine if there are more

  // If cursor is provided, fetch messages before that timestamp
  if (cursor) {
    query = query.lt('created_at', cursor)
  }

  const { data: messages, error } = await query

  if (error) {
    return NextResponse.json({ error: 'Failed to fetch messages' }, { status: 500 })
  }

  const hasMore = (messages?.length ?? 0) > limit
  const page = hasMore ? messages!.slice(0, limit) : (messages ?? [])

  // Reverse to return in chronological order (oldest first)
  page.reverse()

  const nextCursor = hasMore && page.length > 0 ? page[0].created_at : null

  return NextResponse.json({
    messages: page,
    nextCursor,
    hasMore,
  })
}
