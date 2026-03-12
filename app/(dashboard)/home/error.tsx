'use client'

import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { AlertTriangle, RefreshCw } from 'lucide-react'

export default function HomeError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Welcome back</h1>
      <Card>
        <CardContent className="py-12 text-center space-y-4">
          <div className="w-14 h-14 mx-auto rounded-full bg-red-500/10 flex items-center justify-center">
            <AlertTriangle className="w-7 h-7 text-red-500" />
          </div>
          <div>
            <h2 className="text-lg font-semibold">Couldn&apos;t load your dashboard</h2>
            <p className="text-muted-foreground mt-1 text-sm">
              There was a problem loading your data.
            </p>
          </div>
          <Button onClick={reset} variant="outline" size="sm">
            <RefreshCw className="w-4 h-4 mr-2" />
            Retry
          </Button>
        </CardContent>
      </Card>
    </div>
  )
}
