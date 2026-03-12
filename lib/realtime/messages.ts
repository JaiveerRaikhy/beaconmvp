import { createClient } from '@/lib/supabase/client'
import { RealtimeChannel } from '@supabase/supabase-js'

/**
 * Verify the current user is a participant in the given match.
 * Must be called before subscribing to any match-scoped channel.
 */
export async function verifyMatchParticipant(matchId: string): Promise<boolean> {
  const supabase = createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return false

  const { data: match } = await supabase
    .from('matches')
    .select('giver_id, seeker_id')
    .eq('id', matchId)
    .single()

  if (!match) return false
  return match.giver_id === user.id || match.seeker_id === user.id
}

/**
 * Subscribe to new messages in a conversation.
 * Listens for INSERT events on the messages table filtered by match_id.
 * Caller must verify match participation before calling.
 */
export function subscribeToMessages(
  matchId: string,
  onMessage: (message: Record<string, unknown>) => void
): RealtimeChannel {
  const supabase = createClient()

  const channel = supabase
    .channel(`messages:${matchId}`)
    .on(
      'postgres_changes',
      {
        event: 'INSERT',
        schema: 'public',
        table: 'messages',
        filter: `match_id=eq.${matchId}`,
      },
      (payload) => {
        onMessage(payload.new as Record<string, unknown>)
      }
    )
    .on(
      'postgres_changes',
      {
        event: 'UPDATE',
        schema: 'public',
        table: 'messages',
        filter: `match_id=eq.${matchId}`,
      },
      (payload) => {
        onMessage(payload.new as Record<string, unknown>)
      }
    )
    .subscribe()

  return channel
}

/**
 * Subscribe to typing indicators using Supabase Realtime broadcast.
 * This uses ephemeral broadcast events (not persisted to DB).
 * Caller must verify match participation before calling.
 */
export function subscribeToTyping(
  matchId: string,
  onTyping: (userId: string, isTyping: boolean) => void
): RealtimeChannel {
  const supabase = createClient()

  const channel = supabase
    .channel(`typing:${matchId}`)
    .on('broadcast', { event: 'typing' }, (payload) => {
      const { userId, isTyping } = payload.payload as { userId: string; isTyping: boolean }
      onTyping(userId, isTyping)
    })
    .subscribe()

  return channel
}

/**
 * Send a typing indicator broadcast event.
 */
export function sendTypingIndicator(
  channel: RealtimeChannel,
  userId: string,
  isTyping: boolean
) {
  channel.send({
    type: 'broadcast',
    event: 'typing',
    payload: { userId, isTyping },
  })
}

/**
 * Unsubscribe from a realtime channel.
 */
export function unsubscribeFromChannel(channel: RealtimeChannel) {
  const supabase = createClient()
  supabase.removeChannel(channel)
}
