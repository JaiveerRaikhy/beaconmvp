import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Trophy, TrendingUp, PartyPopper } from 'lucide-react'
import { formatDistanceToNow } from 'date-fns'

interface ImpactEvent {
  id: string
  created_at: string
  impact_event: {
    event_type: string
    message: string | null
  }
}

interface ImpactSectionProps {
  events: ImpactEvent[]
}

const EVENT_ICONS: Record<string, typeof TrendingUp> = {
  offer: PartyPopper,
  landed_role: Trophy,
  progress: TrendingUp,
}

const EVENT_LABELS: Record<string, string> = {
  offer: 'Got an offer',
  landed_role: 'Landed a role',
  progress: 'Made progress',
}

export function ImpactSection({ events }: ImpactSectionProps) {
  if (events.length === 0) {
    return null
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Your Impact</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {events.map((event) => {
            const Icon = EVENT_ICONS[event.impact_event.event_type] || TrendingUp
            const label = EVENT_LABELS[event.impact_event.event_type] || 'Update'

            return (
              <div key={event.id} className="flex items-start gap-3">
                <div className="w-8 h-8 rounded-full bg-emerald-500/10 flex items-center justify-center flex-shrink-0">
                  <Icon className="w-4 h-4 text-emerald-500" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium">{label}</p>
                  {event.impact_event.message && (
                    <p className="text-sm text-muted-foreground">
                      &ldquo;{event.impact_event.message}&rdquo;
                    </p>
                  )}
                  <p className="text-xs text-muted-foreground">
                    {formatDistanceToNow(new Date(event.created_at), { addSuffix: true })}
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
