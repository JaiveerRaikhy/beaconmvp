import { Card, CardContent } from '@/components/ui/card'
import { SkeletonPulse } from '@/components/ui/skeleton'

export default function MatchesLoading() {
  return (
    <div className="space-y-6">
      <SkeletonPulse className="h-8 w-32" />

      {/* Browse card */}
      <Card>
        <CardContent className="py-6">
          <SkeletonPulse className="h-5 w-40 mx-auto" />
        </CardContent>
      </Card>

      {/* Match sections */}
      <div className="space-y-3">
        {[1, 2, 3].map(i => (
          <Card key={i}>
            <CardContent className="flex items-center justify-between py-4">
              <div className="flex items-center gap-3">
                <SkeletonPulse className="h-10 w-10 rounded-full" />
                <div>
                  <SkeletonPulse className="h-4 w-36 mb-2" />
                  <SkeletonPulse className="h-3 w-24" />
                </div>
              </div>
              <SkeletonPulse className="h-5 w-5" />
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
