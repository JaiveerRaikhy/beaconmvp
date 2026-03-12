import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { UserPlus } from 'lucide-react'
import { formatDistanceToNow } from 'date-fns'

interface Match {
  id: string
  status: string
  created_at: string
  giver_id: string
  seeker_id: string
  giver: { full_name: string; profile_picture_url: string | null }
  seeker: { full_name: string; profile_picture_url: string | null }
}

interface ActivityFeedProps {
  matches: Match[]
  currentUserId: string
}

export function ActivityFeed({ matches, currentUserId }: ActivityFeedProps) {
  if (matches.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Activity</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col items-center gap-2 py-4">
            <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
              <UserPlus className="w-5 h-5 text-primary" />
            </div>
            <p className="text-muted-foreground text-sm text-center">
              No recent activity yet. Start connecting with people to see updates here.
            </p>
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Recent Activity</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {matches.map((match) => {
            const isGiver = match.giver_id === currentUserId
            const otherPerson = isGiver ? match.seeker : match.giver

            return (
              <div key={match.id} className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                  <UserPlus className="w-4 h-4 text-primary" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-sm">
                    {isGiver ? 'You connected with ' : ''}
                    <span className="font-medium">{otherPerson.full_name}</span>
                    {!isGiver ? ' wants to connect with you' : ''}
                  </p>
                  <p className="text-xs text-muted-foreground">
                    {formatDistanceToNow(new Date(match.created_at), { addSuffix: true })}
                  </p>
                </div>
              </div>
            )
          })}
        </div>
      </CardContent>
    </Card>
  )
}
