'use client'

import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { AlertTriangle, RefreshCw } from 'lucide-react'

export default function DashboardError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="flex items-center justify-center min-h-[60vh]">
      <Card className="max-w-md w-full">
        <CardContent className="py-12 text-center space-y-4">
          <div className="w-14 h-14 mx-auto rounded-full bg-red-500/10 flex items-center justify-center">
            <AlertTriangle className="w-7 h-7 text-red-500" />
          </div>
          <div>
            <h2 className="text-xl font-semibold">Something went wrong</h2>
            <p className="text-muted-foreground mt-2 text-sm">
              We couldn&apos;t load this page. Please try again.
            </p>
          </div>
          <Button onClick={reset} variant="outline">
            <RefreshCw className="w-4 h-4 mr-2" />
            Try again
          </Button>
        </CardContent>
      </Card>
    </div>
  )
}
