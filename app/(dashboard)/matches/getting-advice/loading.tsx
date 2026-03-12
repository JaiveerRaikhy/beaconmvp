import { Card, CardContent } from '@/components/ui/card'
import { SkeletonPulse } from '@/components/ui/skeleton'

export default function GettingAdviceLoading() {
  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <SkeletonPulse className="h-10 w-10 rounded-md" />
        <div>
          <SkeletonPulse className="h-7 w-40 mb-1" />
          <SkeletonPulse className="h-4 w-28" />
        </div>
      </div>

      <div className="space-y-3">
        {[1, 2, 3].map(i => (
          <Card key={i}>
            <CardContent className="flex items-center gap-4 py-4">
              <SkeletonPulse className="h-12 w-12 rounded-full flex-shrink-0" />
              <div className="flex-1">
                <SkeletonPulse className="h-4 w-32 mb-2" />
                <SkeletonPulse className="h-3 w-24" />
              </div>
              <SkeletonPulse className="h-8 w-20 rounded-md" />
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
