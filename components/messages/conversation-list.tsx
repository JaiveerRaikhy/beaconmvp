'use client'

import { useState } from 'react'
import Link from 'next/link'
import { Card } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { User, Search, MessageSquare } from 'lucide-react'
import { formatDistanceToNow } from 'date-fns'
import { cn } from '@/lib/utils'

interface Conversation {
  matchId: string
  otherPerson: {
    id: string
    full_name: string
    profile_picture_url: string | null
  }
  lastMessage?: {
    content: string
    created_at: string
    sender_id: string
  }
  unreadCount: number
}

interface ConversationListProps {
  conversations: Conversation[]
  currentUserId: string
}

export function ConversationList({ conversations, currentUserId }: ConversationListProps) {
  const [search, setSearch] = useState('')

  const totalUnread = conversations.reduce((sum, c) => sum + c.unreadCount, 0)

  const filtered = search.trim()
    ? conversations.filter(c =>
        c.otherPerson.full_name.toLowerCase().includes(search.toLowerCase()) ||
        c.lastMessage?.content.toLowerCase().includes(search.toLowerCase())
      )
    : conversations

  if (conversations.length === 0) {
    return (
      <Card className="p-8 text-center">
        <div className="flex flex-col items-center gap-2">
          <MessageSquare className="w-10 h-10 text-muted-foreground" aria-hidden="true" />
          <p className="text-muted-foreground font-medium">No conversations yet</p>
          <p className="text-sm text-muted-foreground">
            When you connect with someone, your conversations will appear here
          </p>
        </div>
      </Card>
    )
  }

  return (
    <div className="space-y-3">
      {/* Search + unread badge */}
      <div className="flex items-center gap-3">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" aria-hidden="true" />
          <Input
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search conversations..."
            className="pl-9"
            aria-label="Search conversations"
          />
        </div>
        {totalUnread > 0 && (
          <div className="flex items-center gap-1.5 bg-primary/10 text-primary rounded-full px-3 py-1.5 text-sm font-medium flex-shrink-0">
            <MessageSquare className="w-4 h-4" />
            {totalUnread} unread
          </div>
        )}
      </div>

      {/* Conversation list */}
      {filtered.length === 0 ? (
        <div className="py-8 text-center">
          <p className="text-muted-foreground text-sm">
            No conversations match &quot;{search}&quot;
          </p>
        </div>
      ) : (
        <div className="space-y-2">
          {filtered.map(({ matchId, otherPerson, lastMessage, unreadCount }) => (
            <Link key={matchId} href={`/messages/${matchId}`} aria-label={`Conversation with ${otherPerson.full_name}${unreadCount > 0 ? `, ${unreadCount} unread` : ''}`}>
              <Card className={cn(
                'p-4 hover:bg-accent/50 transition-colors cursor-pointer',
                unreadCount > 0 && 'bg-primary/5 border-primary/20'
              )}>
                <div className="flex items-center gap-3">
                  {/* Avatar */}
                  <div className="relative flex-shrink-0">
                    <div className="w-12 h-12 rounded-full bg-stone-300/60 overflow-hidden">
                      {otherPerson.profile_picture_url ? (
                        <img
                          src={otherPerson.profile_picture_url}
                          alt=""
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center text-muted-foreground">
                          <User className="w-6 h-6" />
                        </div>
                      )}
                    </div>
                    {/* Unread dot on avatar */}
                    {unreadCount > 0 && (
                      <div className="absolute -top-0.5 -right-0.5 w-4 h-4 rounded-full bg-primary border-2 border-background" />
                    )}
                  </div>

                  {/* Content */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between">
                      <p className={cn(
                        'font-medium truncate',
                        unreadCount > 0 && 'font-semibold'
                      )}>
                        {otherPerson.full_name}
                      </p>
                      {lastMessage && (
                        <p className="text-xs text-muted-foreground flex-shrink-0 ml-2">
                          {formatDistanceToNow(new Date(lastMessage.created_at), { addSuffix: true })}
                        </p>
                      )}
                    </div>

                    {lastMessage ? (
                      <p className={cn(
                        'text-sm truncate mt-0.5',
                        unreadCount > 0 ? 'text-foreground font-medium' : 'text-muted-foreground'
                      )}>
                        {lastMessage.sender_id === currentUserId && (
                          <span className="text-muted-foreground">You: </span>
                        )}
                        {lastMessage.content}
                      </p>
                    ) : (
                      <p className="text-sm text-muted-foreground italic mt-0.5">
                        No messages yet
                      </p>
                    )}
                  </div>

                  {/* Unread count badge */}
                  {unreadCount > 0 && (
                    <div className="w-6 h-6 rounded-full bg-primary text-primary-foreground text-xs font-medium flex items-center justify-center flex-shrink-0">
                      {unreadCount > 9 ? '9+' : unreadCount}
                    </div>
                  )}
                </div>
              </Card>
            </Link>
          ))}
        </div>
      )}
    </div>
  )
}
