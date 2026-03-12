'use client'

import { useState, useEffect, useRef, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { MessageBubble } from './message-bubble'
import { MessageInput } from './message-input'
import { TypingIndicator } from './typing-indicator'
import { CalendarModal } from './calendar-modal'
import {
  subscribeToMessages,
  subscribeToTyping,
  sendTypingIndicator,
  unsubscribeFromChannel,
  verifyMatchParticipant,
} from '@/lib/realtime/messages'
import { ArrowLeft, User } from 'lucide-react'
import { format, isToday, isYesterday, isSameDay } from 'date-fns'
import Link from 'next/link'
import { sanitizeText } from '@/lib/security/sanitize'

interface Attachment {
  url: string
  filename: string
  size: number
  type: string
}

interface Message {
  id: string
  content: string
  sender_id: string
  created_at: string
  read_at: string | null
  attachments: Attachment[] | null
  sender: {
    id: string
    full_name: string
    profile_picture_url: string | null
  }
}

interface ChatThreadProps {
  matchId: string
  currentUserId: string
  otherPerson: {
    id: string
    full_name: string
    profile_picture_url: string | null
  }
  initialMessages: Message[]
  typingEnabled?: boolean
}

function formatDateSeparator(date: Date): string {
  if (isToday(date)) return 'Today'
  if (isYesterday(date)) return 'Yesterday'
  return format(date, 'MMMM d, yyyy')
}

/**
 * Determine whether a message should show its avatar.
 * Show avatar only for the last message in a consecutive group from the same sender.
 */
function shouldShowAvatar(messages: Message[], index: number): boolean {
  const msg = messages[index]
  const next = messages[index + 1]
  // Show avatar if this is the last message, or next message is from a different sender,
  // or more than 5 minutes gap
  if (!next) return true
  if (next.sender_id !== msg.sender_id) return true
  const gap = new Date(next.created_at).getTime() - new Date(msg.created_at).getTime()
  return gap > 5 * 60 * 1000
}

export function ChatThread({
  matchId,
  currentUserId,
  otherPerson,
  initialMessages,
  typingEnabled = true,
}: ChatThreadProps) {
  const [messages, setMessages] = useState<Message[]>(initialMessages)
  const [sending, setSending] = useState(false)
  const [showCalendar, setShowCalendar] = useState(false)
  const [otherTyping, setOtherTyping] = useState(false)
  const messagesEndRef = useRef<HTMLDivElement>(null)
  const typingChannelRef = useRef<ReturnType<typeof subscribeToTyping> | null>(null)
  const otherTypingTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  // Subscribe to realtime messages and typing after verifying participation
  useEffect(() => {
    let messageChannel: ReturnType<typeof subscribeToMessages> | null = null
    let typingChannel: ReturnType<typeof subscribeToTyping> | null = null
    let cancelled = false

    async function setupSubscriptions() {
      // Verify user is a participant before subscribing to any channel
      const isParticipant = await verifyMatchParticipant(matchId)
      if (!isParticipant || cancelled) return

      messageChannel = subscribeToMessages(matchId, (newMessage) => {
        const incoming = newMessage as unknown as Message

        setMessages(prev => {
          // Avoid duplicates
          if (prev.some(m => m.id === incoming.id)) {
            // This might be an UPDATE event (e.g. read_at changed)
            return prev.map(m => m.id === incoming.id ? { ...m, ...incoming } : m)
          }

          // Enrich with sender info if missing
          const enriched: Message = {
            ...incoming,
            sender: incoming.sender || (incoming.sender_id === currentUserId
              ? { id: currentUserId, full_name: 'You', profile_picture_url: null }
              : { id: otherPerson.id, full_name: otherPerson.full_name, profile_picture_url: otherPerson.profile_picture_url }
            ),
          }
          return [...prev, enriched]
        })
      })

      typingChannel = subscribeToTyping(matchId, (userId, isTyping) => {
        if (userId !== currentUserId) {
          setOtherTyping(isTyping)

          // Auto-clear typing indicator after 3 seconds as a safety net
          if (isTyping) {
            if (otherTypingTimeoutRef.current) {
              clearTimeout(otherTypingTimeoutRef.current)
            }
            otherTypingTimeoutRef.current = setTimeout(() => {
              setOtherTyping(false)
            }, 3000)
          }
        }
      })
      typingChannelRef.current = typingChannel
    }

    setupSubscriptions()

    return () => {
      cancelled = true
      if (messageChannel) unsubscribeFromChannel(messageChannel)
      if (typingChannel) unsubscribeFromChannel(typingChannel)
      if (otherTypingTimeoutRef.current) {
        clearTimeout(otherTypingTimeoutRef.current)
      }
    }
  }, [matchId, currentUserId, otherPerson])

  // Scroll to bottom on new messages
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages, otherTyping])

  // Mark messages as read
  useEffect(() => {
    const unreadIds = messages
      .filter(m => m.sender_id !== currentUserId && !m.read_at)
      .map(m => m.id)

    if (unreadIds.length > 0) {
      fetch('/api/messages/read', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ messageIds: unreadIds }),
      })

      // Optimistically mark as read locally
      setMessages(prev =>
        prev.map(m =>
          unreadIds.includes(m.id) ? { ...m, read_at: new Date().toISOString() } : m
        )
      )
    }
  }, [messages, currentUserId])

  const handleTyping = useCallback((isTyping: boolean) => {
    if (typingEnabled && typingChannelRef.current) {
      sendTypingIndicator(typingChannelRef.current, currentUserId, isTyping)
    }
  }, [currentUserId, typingEnabled])

  const handleSend = async (content: string, files?: File[]) => {
    setSending(true)

    try {
      // Upload attachments if any
      let attachments: Attachment[] | undefined
      if (files && files.length > 0) {
        attachments = []
        for (const file of files) {
          const formData = new FormData()
          formData.append('file', file)
          formData.append('matchId', matchId)

          const uploadRes = await fetch('/api/messages/upload', {
            method: 'POST',
            body: formData,
          })

          if (uploadRes.ok) {
            const data = await uploadRes.json()
            attachments.push(data)
          }
        }
      }

      const sanitizedContent = sanitizeText(content)
      if (!sanitizedContent && (!attachments || attachments.length === 0)) {
        setSending(false)
        return
      }

      // Send via API
      const res = await fetch('/api/messages/send', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          matchId,
          content: sanitizedContent || '(attachment)',
          attachments: attachments || null,
        }),
      })

      if (res.ok) {
        const { message } = await res.json()
        // The realtime subscription will add the message, but we also add it optimistically
        setMessages(prev => {
          if (prev.some(m => m.id === message.id)) return prev
          return [...prev, message]
        })
      }
    } catch (error) {
      console.error('Error sending message:', error)
    } finally {
      setSending(false)
    }
  }

  // Group messages by date
  const dateGroups: { date: Date; messages: Message[] }[] = []
  let currentGroup: { date: Date; messages: Message[] } | null = null

  for (const message of messages) {
    const msgDate = new Date(message.created_at)
    if (!currentGroup || !isSameDay(currentGroup.date, msgDate)) {
      currentGroup = { date: msgDate, messages: [] }
      dateGroups.push(currentGroup)
    }
    currentGroup.messages.push(message)
  }

  return (
    <div className="flex flex-col h-[calc(100vh-8rem)] md:h-[calc(100vh-4rem)]">
      {/* Header */}
      <div className="flex items-center gap-3 pb-4 border-b">
        <Link href="/messages">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="w-5 h-5" />
          </Button>
        </Link>

        <div className="w-10 h-10 rounded-full bg-slate-700/50 overflow-hidden flex-shrink-0">
          {otherPerson.profile_picture_url ? (
            <img
              src={otherPerson.profile_picture_url}
              alt=""
              className="w-full h-full object-cover"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-muted-foreground">
              <User className="w-5 h-5" />
            </div>
          )}
        </div>

        <div className="flex-1 min-w-0">
          <p className="font-medium truncate">{otherPerson.full_name}</p>
          {otherTyping && (
            <p className="text-xs text-primary animate-pulse">typing...</p>
          )}
        </div>

        <Link href={`/profile/${otherPerson.id}`}>
          <Button variant="ghost" size="sm">
            View Profile
          </Button>
        </Link>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto py-4">
        {messages.length === 0 ? (
          <div className="text-center py-8">
            <p className="text-muted-foreground text-sm">
              No messages yet. Say hello!
            </p>
          </div>
        ) : (
          dateGroups.map((group) => (
            <div key={group.date.toISOString()}>
              {/* Date separator */}
              <div className="flex items-center gap-3 my-4">
                <div className="flex-1 h-px bg-border" />
                <span className="text-xs text-muted-foreground font-medium">
                  {formatDateSeparator(group.date)}
                </span>
                <div className="flex-1 h-px bg-border" />
              </div>

              {/* Messages in this date group */}
              {group.messages.map((message, idx) => (
                <MessageBubble
                  key={message.id}
                  matchId={matchId}
                  message={message}
                  isOwn={message.sender_id === currentUserId}
                  showAvatar={shouldShowAvatar(group.messages, idx)}
                />
              ))}
            </div>
          ))
        )}

        {/* Typing indicator */}
        {otherTyping && (
          <div className="ml-10 mt-2">
            <TypingIndicator name={otherPerson.full_name} />
          </div>
        )}

        <div ref={messagesEndRef} />
      </div>

      {/* Input */}
      <MessageInput
        onSend={handleSend}
        onSchedule={() => setShowCalendar(true)}
        onTyping={handleTyping}
        disabled={sending}
      />

      {/* Calendar Modal */}
      {showCalendar && (
        <CalendarModal
          onClose={() => setShowCalendar(false)}
          otherPersonName={otherPerson.full_name}
        />
      )}
    </div>
  )
}
