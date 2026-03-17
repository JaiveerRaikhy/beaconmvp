'use client'

import { useState, useRef, useCallback, useEffect } from 'react'
import { Button } from '@/components/ui/button'
import { Paperclip, Calendar, Send, X } from 'lucide-react'
import { cn } from '@/lib/utils'

interface Attachment {
  file: File
  preview?: string
}

interface MessageInputProps {
  onSend: (content: string, attachments?: File[]) => void
  onSchedule: () => void
  onTyping?: (isTyping: boolean) => void
  disabled?: boolean
}

export function MessageInput({ onSend, onSchedule, onTyping, disabled }: MessageInputProps) {
  const [content, setContent] = useState('')
  const [attachments, setAttachments] = useState<Attachment[]>([])
  const fileInputRef = useRef<HTMLInputElement>(null)
  const textareaRef = useRef<HTMLTextAreaElement>(null)
  const typingTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null)
  const isTypingRef = useRef(false)

  // Cleanup typing timeout on unmount
  useEffect(() => {
    return () => {
      if (typingTimeoutRef.current) {
        clearTimeout(typingTimeoutRef.current)
      }
      // Revoke attachment preview URLs
      attachments.forEach(a => {
        if (a.preview) URL.revokeObjectURL(a.preview)
      })
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleTyping = useCallback(() => {
    if (!onTyping) return

    if (!isTypingRef.current) {
      isTypingRef.current = true
      onTyping(true)
    }

    // Reset the timeout
    if (typingTimeoutRef.current) {
      clearTimeout(typingTimeoutRef.current)
    }

    typingTimeoutRef.current = setTimeout(() => {
      isTypingRef.current = false
      onTyping(false)
    }, 2000)
  }, [onTyping])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()

    if (!content.trim() && attachments.length === 0) return

    // Stop typing indicator
    if (isTypingRef.current && onTyping) {
      isTypingRef.current = false
      onTyping(false)
      if (typingTimeoutRef.current) {
        clearTimeout(typingTimeoutRef.current)
      }
    }

    const files = attachments.map(a => a.file)
    onSend(content, files.length > 0 ? files : undefined)
    setContent('')

    // Revoke preview URLs
    attachments.forEach(a => {
      if (a.preview) URL.revokeObjectURL(a.preview)
    })
    setAttachments([])

    // Reset textarea height
    if (textareaRef.current) {
      textareaRef.current.style.height = 'auto'
    }
  }

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault()
      handleSubmit(e)
    }
  }

  const handleChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setContent(e.target.value)
    handleTyping()

    // Auto-resize textarea
    const textarea = textareaRef.current
    if (textarea) {
      textarea.style.height = 'auto'
      textarea.style.height = Math.min(textarea.scrollHeight, 120) + 'px'
    }
  }

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || [])
    const newAttachments: Attachment[] = files.map(file => ({
      file,
      preview: file.type.startsWith('image/') ? URL.createObjectURL(file) : undefined,
    }))
    setAttachments(prev => [...prev, ...newAttachments])
    // Reset input so the same file can be selected again
    if (fileInputRef.current) fileInputRef.current.value = ''
  }

  const removeAttachment = (index: number) => {
    setAttachments(prev => {
      const removed = prev[index]
      if (removed.preview) URL.revokeObjectURL(removed.preview)
      return prev.filter((_, i) => i !== index)
    })
  }

  return (
    <form onSubmit={handleSubmit} className="border-t pt-3">
      {/* Attachments preview */}
      {attachments.length > 0 && (
        <div className="flex flex-wrap gap-2 mb-2 px-1">
          {attachments.map((attachment, i) => (
            <div
              key={i}
              className="relative group"
            >
              {attachment.preview ? (
                <div className="relative w-16 h-16 rounded-lg overflow-hidden border border-border">
                  <img
                    src={attachment.preview}
                    alt=""
                    className="w-full h-full object-cover"
                  />
                  <button
                    type="button"
                    onClick={() => removeAttachment(i)}
                    className="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-destructive text-destructive-foreground flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity"
                  >
                    <X className="w-3 h-3" />
                  </button>
                </div>
              ) : (
                <div className="flex items-center gap-1 bg-stone-100/60 rounded px-2 py-1 text-sm">
                  <span className="truncate max-w-[120px]">{attachment.file.name}</span>
                  <button
                    type="button"
                    onClick={() => removeAttachment(i)}
                    className="text-muted-foreground hover:text-foreground ml-1"
                  >
                    <X className="w-3 h-3" />
                  </button>
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      <div className="flex items-end gap-2">
        {/* Attachment button */}
        <Button
          type="button"
          variant="ghost"
          size="icon"
          className="flex-shrink-0"
          onClick={() => fileInputRef.current?.click()}
        >
          <Paperclip className="w-5 h-5" />
        </Button>
        <input
          ref={fileInputRef}
          type="file"
          multiple
          className="hidden"
          onChange={handleFileSelect}
          accept=".pdf,.doc,.docx,.txt,.jpg,.jpeg,.png,.gif"
        />

        {/* Schedule button */}
        <Button
          type="button"
          variant="ghost"
          size="icon"
          className="flex-shrink-0"
          onClick={onSchedule}
        >
          <Calendar className="w-5 h-5" />
        </Button>

        {/* Text input */}
        <textarea
          ref={textareaRef}
          value={content}
          onChange={handleChange}
          onKeyDown={handleKeyDown}
          placeholder="Type a message..."
          disabled={disabled}
          rows={1}
          className={cn(
            'flex-1 min-h-[44px] max-h-[120px] resize-none rounded-xl border border-input bg-background px-4 py-2.5 text-sm',
            'focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2',
            'placeholder:text-muted-foreground disabled:opacity-50'
          )}
        />

        {/* Send button */}
        <Button
          type="submit"
          size="icon"
          className="flex-shrink-0"
          disabled={disabled || (!content.trim() && attachments.length === 0)}
        >
          <Send className="w-4 h-4" />
        </Button>
      </div>
    </form>
  )
}
