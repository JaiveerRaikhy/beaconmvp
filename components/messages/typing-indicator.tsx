'use client'

import { cn } from '@/lib/utils'

interface TypingIndicatorProps {
  name: string
  className?: string
}

export function TypingIndicator({ name, className }: TypingIndicatorProps) {
  return (
    <div className={cn('flex items-center gap-2', className)}>
      <div className="flex gap-1 bg-slate-700/50 rounded-2xl rounded-bl-sm px-4 py-3">
        <span className="w-2 h-2 bg-muted-foreground/60 rounded-full animate-bounce [animation-delay:0ms]" />
        <span className="w-2 h-2 bg-muted-foreground/60 rounded-full animate-bounce [animation-delay:150ms]" />
        <span className="w-2 h-2 bg-muted-foreground/60 rounded-full animate-bounce [animation-delay:300ms]" />
      </div>
      <span className="text-xs text-muted-foreground">{name} is typing...</span>
    </div>
  )
}
