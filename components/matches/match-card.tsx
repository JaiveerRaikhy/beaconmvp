import { Card, CardContent } from '@/components/ui/card'
import { User, MessageSquare } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { MATCH_THRESHOLDS } from '@/lib/matching/scoring'
import Link from 'next/link'
import { formatDistanceToNow, differenceInDays } from 'date-fns'

const EXPIRY_WARNING_DAYS = 5

interface MatchCardProps {
  matchId: string
  person: {
    full_name: string | null
    profile_picture_url: string | null
  }
  matchedAt: string
  hasMessages: boolean
  matchScore?: number | null
  expiresAt?: string | null
}

export function MatchCard({
  matchId,
  person,
  matchedAt,
  hasMessages,
  matchScore,
  expiresAt,
}: MatchCardProps) {
  const daysLeft = expiresAt
    ? differenceInDays(new Date(expiresAt), new Date())
    : null

  return (
    <Card>
      <CardContent className="flex items-center gap-4 py-4">
        {/* Avatar */}
        <div className="w-12 h-12 rounded-full bg-slate-700/50 overflow-hidden flex-shrink-0">
          {person.profile_picture_url ? (
            <img
              src={person.profile_picture_url}
              alt=""
              className="w-full h-full object-cover"
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-muted-foreground">
              <User className="w-6 h-6" />
            </div>
          )}
        </div>

        {/* Info */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <p className="font-medium truncate">
              {person.full_name || 'User'}
            </p>
            {matchScore != null && matchScore > 0 && (
              <Badge
                variant={
                  matchScore >= MATCH_THRESHOLDS.HIGH
                    ? 'default'
                    : matchScore >= MATCH_THRESHOLDS.GOOD
                      ? 'secondary'
                      : 'outline'
                }
                className="text-[10px] flex-shrink-0"
              >
                {matchScore}%
              </Badge>
            )}
          </div>
          <p className="text-xs text-muted-foreground">
            Connected{' '}
            {formatDistanceToNow(new Date(matchedAt), { addSuffix: true })}
          </p>
          {daysLeft != null && daysLeft <= EXPIRY_WARNING_DAYS && daysLeft >= 0 && (
            <p className="text-xs text-amber-500 font-medium">
              {daysLeft === 0 ? 'Expires today' : `${daysLeft}d left`}
            </p>
          )}
        </div>

        {/* Action */}
        <Link href={`/messages/${matchId}`}>
          <Button variant="outline" size="sm">
            <MessageSquare className="w-4 h-4 mr-1" />
            {hasMessages ? 'Chat' : 'Message'}
          </Button>
        </Link>
      </CardContent>
    </Card>
  )
}
