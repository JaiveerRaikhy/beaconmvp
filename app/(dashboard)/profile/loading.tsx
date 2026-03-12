import { Card, CardContent } from '@/components/ui/card'
import { SkeletonPulse } from '@/components/ui/skeleton'

export default function ProfileLoading() {
  return (
    <div className="space-y-6">
      {/* Profile Header */}
      <div className="flex items-center gap-4">
        <SkeletonPulse className="h-20 w-20 rounded-full flex-shrink-0" />
        <div className="flex-1">
          <SkeletonPulse className="h-6 w-40 mb-2" />
          <SkeletonPulse className="h-4 w-28 mb-1" />
          <SkeletonPulse className="h-3 w-20" />
        </div>
      </div>

      {/* Edit Button */}
      <SkeletonPulse className="h-10 w-full rounded-md" />

      {/* Sections */}
      {[1, 2, 3, 4].map(i => (
        <Card key={i}>
          <CardContent className="py-4 space-y-3">
            <SkeletonPulse className="h-5 w-28" />
            <SkeletonPulse className="h-4 w-full" />
            <SkeletonPulse className="h-4 w-3/4" />
          </CardContent>
        </Card>
      ))}
    </div>
  )
}
