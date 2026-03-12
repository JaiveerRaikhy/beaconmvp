'use client'

import { useState, useEffect, useRef } from 'react'
import { cn } from '@/lib/utils'
import { format } from 'date-fns'
import { Check, CheckCheck, FileText } from 'lucide-react'

interface Attachment {
  url: string
  path?: string
  filename: string
  size: number
  type: string
}

interface MessageBubbleProps {
  matchId: string
  message: {
    id: string
    content: string
    created_at: string
    read_at: string | null
    attachments: Attachment[] | null
    sender: {
      full_name: string
      profile_picture_url: string | null
    }
  }
  isOwn: boolean
  showAvatar: boolean
}

export function MessageBubble({ matchId, message, isOwn, showAvatar }: MessageBubbleProps) {
  const time = format(new Date(message.created_at), 'h:mm a')
  const [signedUrls, setSignedUrls] = useState<Record<string, string>>({})
  const fetchedPaths = useRef(new Set<string>())

  useEffect(() => {
    if (!message.attachments) return
    let cancelled = false

    const toResolve = message.attachments.filter(
      (a) => a.path && !fetchedPaths.current.has(a.path)
    )
    if (toResolve.length === 0) return

    for (const a of toResolve) {
      fetchedPaths.current.add(a.path!)
    }

    async function resolveAll() {
      const results: Record<string, string> = {}
      await Promise.all(
        toResolve.map(async (attachment) => {
          try {
            const res = await fetch('/api/messages/attachment-url', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ path: attachment.path, matchId }),
            })
            if (res.ok) {
              const { url } = await res.json()
              results[attachment.path!] = url
            }
          } catch {
            // Fall back to stored URL
          }
        })
      )
      if (!cancelled && Object.keys(results).length > 0) {
        setSignedUrls((prev) => ({ ...prev, ...results }))
      }
    }

    resolveAll()
    return () => { cancelled = true }
  }, [message.attachments, matchId])

  function getAttachmentUrl(attachment: Attachment): string {
    if (attachment.path && signedUrls[attachment.path]) {
      return signedUrls[attachment.path]
    }
    return attachment.url
  }

  return (
    <div className={cn(
      'flex gap-2 mb-1',
      isOwn ? 'flex-row-reverse' : 'flex-row'
    )}>
      {/* Avatar spacer or avatar */}
      {!isOwn && (
        <div className="w-8 flex-shrink-0">
          {showAvatar && (
            <div className="w-8 h-8 rounded-full bg-slate-700/50 overflow-hidden">
              {message.sender.profile_picture_url ? (
                <img
                  src={message.sender.profile_picture_url}
                  alt=""
                  className="w-full h-full object-cover"
                />
              ) : (
                <div className="w-full h-full flex items-center justify-center text-xs font-medium text-muted-foreground">
                  {message.sender.full_name?.charAt(0)?.toUpperCase() || '?'}
                </div>
              )}
            </div>
          )}
        </div>
      )}

      <div className={cn(
        'max-w-[70%] flex flex-col',
        isOwn ? 'items-end' : 'items-start'
      )}>
        {/* Message bubble */}
        <div className={cn(
          'rounded-2xl px-4 py-2',
          isOwn
            ? 'bg-primary text-primary-foreground rounded-br-sm'
            : 'bg-slate-700/50 text-foreground rounded-bl-sm'
        )}>
          <p className="text-sm whitespace-pre-wrap break-words">{message.content}</p>

          {/* Attachments */}
          {message.attachments && message.attachments.length > 0 && (
            <div className="mt-2 space-y-1">
              {message.attachments.map((attachment, i) => {
                const resolvedUrl = getAttachmentUrl(attachment)
                const isImage = attachment.type?.startsWith('image/')
                if (isImage) {
                  return (
                    <a
                      key={i}
                      href={resolvedUrl}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block"
                    >
                      <img
                        src={resolvedUrl}
                        alt={attachment.filename}
                        className="rounded-lg max-w-full max-h-48 object-cover"
                      />
                    </a>
                  )
                }
                return (
                  <a
                    key={i}
                    href={resolvedUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className={cn(
                      'flex items-center gap-2 text-sm underline',
                      isOwn ? 'text-primary-foreground/80' : 'text-primary'
                    )}
                  >
                    <FileText className="w-4 h-4 flex-shrink-0" />
                    <span className="truncate">{attachment.filename}</span>
                  </a>
                )
              })}
            </div>
          )}
        </div>

        {/* Time + read receipt */}
        <div className={cn(
          'flex items-center gap-1 mt-0.5',
          isOwn ? 'flex-row-reverse' : 'flex-row'
        )}>
          <p className="text-[10px] text-muted-foreground">{time}</p>
          {isOwn && (
            message.read_at ? (
              <CheckCheck className="w-3.5 h-3.5 text-primary" />
            ) : (
              <Check className="w-3.5 h-3.5 text-muted-foreground" />
            )
          )}
        </div>
      </div>
    </div>
  )
}
