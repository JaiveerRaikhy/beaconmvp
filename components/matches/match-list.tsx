import { MatchCard } from './match-card'
import { Card, CardContent } from '@/components/ui/card'
import { Users } from 'lucide-react'

interface Match {
  id: string
  created_at: string
  person: {
    full_name: string | null
    profile_picture_url: string | null
  }
  hasMessages: boolean
  matchScore?: number | null
  expiresAt?: string | null
}

interface MatchListProps {
  matches: Match[]
  emptyMessage: string
}

export function MatchList({ matches, emptyMessage }: MatchListProps) {
  if (matches.length === 0) {
    return (
      <Card>
        <CardContent className="py-12 text-center">
          <div className="flex flex-col items-center gap-3">
            <div className="w-12 h-12 rounded-full bg-muted flex items-center justify-center">
              <Users className="w-6 h-6 text-muted-foreground" />
            </div>
            <p className="text-muted-foreground text-sm max-w-xs">{emptyMessage}</p>
          </div>
        </CardContent>
      </Card>
    )
  }

  return (
    <div className="space-y-3">
      {matches.map((match) => (
        <MatchCard
          key={match.id}
          matchId={match.id}
          person={match.person}
          matchedAt={match.created_at}
          hasMessages={match.hasMessages}
          matchScore={match.matchScore}
          expiresAt={match.expiresAt}
        />
      ))}
    </div>
  )
}
