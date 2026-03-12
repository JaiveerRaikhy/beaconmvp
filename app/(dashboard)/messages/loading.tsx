import { Card, CardContent } from '@/components/ui/card'
import { SkeletonPulse } from '@/components/ui/skeleton'

export default function MessagesLoading() {
  return (
    <div className="space-y-4">
      <SkeletonPulse className="h-8 w-32" />

      {/* Search bar */}
      <SkeletonPulse className="h-10 w-full rounded-md" />

      {/* Conversation list */}
      <div className="space-y-2">
        {[1, 2, 3, 4].map(i => (
          <Card key={i}>
            <CardContent className="flex items-center gap-3 py-3">
              <SkeletonPulse className="h-12 w-12 rounded-full flex-shrink-0" />
              <div className="flex-1 min-w-0">
                <div className="flex justify-between items-center mb-2">
                  <SkeletonPulse className="h-4 w-28" />
                  <SkeletonPulse className="h-3 w-16" />
                </div>
                <SkeletonPulse className="h-3 w-48" />
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
