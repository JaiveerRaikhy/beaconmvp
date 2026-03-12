'use client'

import { Button } from '@/components/ui/button'
import { AlertTriangle, RefreshCw } from 'lucide-react'

export default function AuthError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="text-center space-y-6">
      <div className="w-14 h-14 mx-auto rounded-full bg-red-500/10 flex items-center justify-center">
        <AlertTriangle className="w-7 h-7 text-red-500" />
      </div>
      <div>
        <h2 className="text-xl font-semibold">Authentication Error</h2>
        <p className="text-muted-foreground mt-2 text-sm">
          Something went wrong. Please try again.
        </p>
      </div>
      <Button onClick={reset} variant="outline">
        <RefreshCw className="w-4 h-4 mr-2" />
        Try again
      </Button>
    </div>
  )
}
