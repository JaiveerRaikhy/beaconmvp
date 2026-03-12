import { Card, CardContent } from '@/components/ui/card'
import { SkeletonPulse } from '@/components/ui/skeleton'

export default function HomeLoading() {
  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <SkeletonPulse className="h-8 w-64 mb-2" />
        <SkeletonPulse className="h-4 w-80" />
      </div>

      {/* Stats Cards */}
      <div className="grid gap-4 sm:grid-cols-2">
        <Card>
          <CardContent className="py-6">
            <SkeletonPulse className="h-4 w-32 mb-3" />
            <SkeletonPulse className="h-8 w-12" />
          </CardContent>
        </Card>
        <Card>
          <CardContent className="py-6">
            <SkeletonPulse className="h-4 w-32 mb-3" />
            <SkeletonPulse className="h-8 w-12" />
          </CardContent>
        </Card>
      </div>

      {/* Activity Feed */}
      <Card>
        <CardContent className="py-6 space-y-4">
          <SkeletonPulse className="h-5 w-36 mb-4" />
          {[1, 2, 3].map(i => (
            <div key={i} className="flex items-center gap-3">
              <SkeletonPulse className="h-10 w-10 rounded-full flex-shrink-0" />
              <div className="flex-1">
                <SkeletonPulse className="h-4 w-48 mb-2" />
                <SkeletonPulse className="h-3 w-32" />
              </div>
            </div>
          ))}
        </CardContent>
      </Card>
    </div>
  )
}
