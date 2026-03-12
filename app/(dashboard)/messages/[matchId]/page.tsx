'use client'

import { useEffect, useState } from 'react'
import { useParams, useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { ChatThread } from '@/components/messages/chat-thread'

interface Message {
  id: string
  content: string
  sender_id: string
  created_at: string
  read_at: string | null
  attachments: { url: string; filename: string; size: number; type: string }[] | null
  sender: {
    id: string
    full_name: string
    profile_picture_url: string | null
  }
}

interface OtherPerson {
  id: string
  full_name: string
  profile_picture_url: string | null
}

export default function ConversationPage() {
  const params = useParams()
  const router = useRouter()
  const matchId = params.matchId as string
  const supabase = createClient()

  const [otherPerson, setOtherPerson] = useState<OtherPerson | null>(null)
  const [currentUserId, setCurrentUserId] = useState<string>('')
  const [initialMessages, setInitialMessages] = useState<Message[]>([])
  const [typingEnabled, setTypingEnabled] = useState(true)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function loadConversation() {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        router.push('/login')
        return
      }
      setCurrentUserId(user.id)

      // Fetch user's typing indicator preference
      const { data: profile } = await supabase
        .from('profiles')
        .select('typing_indicators_enabled')
        .eq('id', user.id)
        .single()

      if (profile) {
        setTypingEnabled(profile.typing_indicators_enabled ?? true)
      }

      // Fetch match details
      const { data: match } = await supabase
        .from('matches')
        .select(`
          id,
          giver_id,
          seeker_id,
          giver:profiles!matches_giver_id_fkey(id, full_name, profile_picture_url),
          seeker:profiles!matches_seeker_id_fkey(id, full_name, profile_picture_url)
        `)
        .eq('id', matchId)
        .single()

      if (!match) {
        router.push('/messages')
        return
      }

      // Verify current user is a participant in this match
      if (match.giver_id !== user.id && match.seeker_id !== user.id) {
        router.push('/messages')
        return
      }

      const isGiver = match.giver_id === user.id
      setOtherPerson(
        (isGiver ? match.seeker : match.giver) as unknown as OtherPerson
      )

      // Fetch messages with sender info
      const { data: msgs } = await supabase
        .from('messages')
        .select(`
          *,
          sender:profiles!messages_sender_id_fkey(
            id, full_name, profile_picture_url
          )
        `)
        .eq('match_id', matchId)
        .order('created_at', { ascending: true })

      setInitialMessages((msgs || []) as unknown as Message[])
      setLoading(false)
    }

    loadConversation()
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [matchId])

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    )
  }

  if (!otherPerson || !currentUserId) {
    return null
  }

  return (
    <ChatThread
      matchId={matchId}
      currentUserId={currentUserId}
      otherPerson={otherPerson}
      initialMessages={initialMessages}
      typingEnabled={typingEnabled}
    />
  )
}
