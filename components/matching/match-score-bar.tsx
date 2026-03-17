import { cn } from '@/lib/utils'

interface MatchScoreBarProps {
  score: number
  tier: 'high' | 'good' | 'fair'
}

const tierConfig = {
  high: { label: 'High Match', color: 'bg-emerald-500' },
  good: { label: 'Good Match', color: 'bg-orange-600' },
  fair: { label: 'Fair Match', color: 'bg-muted-foreground' },
}

export function MatchScoreBar({ score, tier }: MatchScoreBarProps) {
  const config = tierConfig[tier]

  return (
    <div className="space-y-1">
      <div className="flex justify-between text-xs">
        <span className="text-muted-foreground">{config.label}</span>
        <span className="text-muted-foreground">{score}%</span>
      </div>
      <div className="h-2 bg-stone-200 rounded-full overflow-hidden">
        <div
          className={cn('h-full rounded-full transition-all', config.color)}
          style={{ width: `${score}%` }}
        />
      </div>
    </div>
  )
}
