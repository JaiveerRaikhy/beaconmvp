import { createClient } from '@/lib/supabase/server'
import { ConversationList } from '@/components/messages/conversation-list'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Messages',
}

export default async function MessagesPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  // Fetch all accepted matches with their messages
  const { data: matches } = await supabase
    .from('matches')
    .select(`
      id,
      giver_id,
      seeker_id,
      status,
      giver:profiles!matches_giver_id_fkey(
        id, full_name, profile_picture_url
      ),
      seeker:profiles!matches_seeker_id_fkey(
        id, full_name, profile_picture_url
      ),
      messages(
        id, content, sender_id, created_at, read_at
      )
    `)
    .or(`giver_id.eq.${user?.id},seeker_id.eq.${user?.id}`)
    .eq('status', 'accepted')
    .order('updated_at', { ascending: false })

  // Process conversations with last message and unread count
  const conversations = matches?.map(match => {
    const isGiver = match.giver_id === user?.id
    const otherPerson = (isGiver ? match.seeker : match.giver) as unknown as {
      id: string
      full_name: string
      profile_picture_url: string | null
    }
    const messages = match.messages || []
    const sortedMessages = [...messages].sort((a, b) =>
      new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
    )
    const lastMessage = sortedMessages[0]
    const unreadCount = messages.filter(m =>
      m.sender_id !== user?.id && !m.read_at
    ).length

    return {
      matchId: match.id,
      otherPerson,
      lastMessage,
      unreadCount,
    }
  }) || []

  return (
    <div className="space-y-4">
      <h1 className="text-2xl font-bold">Messages</h1>

      <ConversationList
        conversations={conversations}
        currentUserId={user?.id || ''}
      />
    </div>
  )
}
