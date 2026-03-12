'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { FACTOR_OPTIONS } from '@/lib/data/degree-types'
import { cn } from '@/lib/utils'
import { GripVertical, ArrowUp, ArrowDown } from 'lucide-react'

export function GiverPreferences() {
  const { factorRankings, prioritizeUnderrepresented, updateField } = useOnboarding()

  // Build ranked list from factorRankings or default order
  const rankedFactors = [...FACTOR_OPTIONS].sort((a, b) => {
    const rankA = factorRankings[a.id] ?? FACTOR_OPTIONS.indexOf(a)
    const rankB = factorRankings[b.id] ?? FACTOR_OPTIONS.indexOf(b)
    return rankA - rankB
  })

  const moveUp = (index: number) => {
    if (index === 0) return
    const newOrder = [...rankedFactors]
    ;[newOrder[index - 1], newOrder[index]] = [newOrder[index], newOrder[index - 1]]
    const newRankings: Record<string, number> = {}
    newOrder.forEach((f, i) => { newRankings[f.id] = i })
    updateField('factorRankings', newRankings)
  }

  const moveDown = (index: number) => {
    if (index === rankedFactors.length - 1) return
    const newOrder = [...rankedFactors]
    ;[newOrder[index], newOrder[index + 1]] = [newOrder[index + 1], newOrder[index]]
    const newRankings: Record<string, number> = {}
    newOrder.forEach((f, i) => { newRankings[f.id] = i })
    updateField('factorRankings', newRankings)
  }

  return (
    <div className="space-y-6">
      <div className="space-y-3">
        <h3 className="font-medium">Rank what matters most to you in a match</h3>
        <p className="text-sm text-muted-foreground">
          Use the arrows to reorder. Top = most important.
        </p>

        <div className="space-y-2">
          {rankedFactors.map((factor, index) => (
            <div
              key={factor.id}
              className={cn(
                'flex items-center gap-3 p-3 rounded-lg border bg-card transition-colors',
                index === 0 && 'border-[rgba(16,185,129,0.3)] bg-emerald-500/10'
              )}
            >
              <GripVertical className="w-4 h-4 text-muted-foreground shrink-0" />

              <span className="text-sm font-medium text-muted-foreground w-6 shrink-0">
                {index + 1}.
              </span>

              <div className="flex-1">
                <p className="text-sm font-medium">{factor.label}</p>
                <p className="text-xs text-muted-foreground">{factor.description}</p>
              </div>

              <div className="flex flex-col gap-1 shrink-0">
                <button
                  onClick={() => moveUp(index)}
                  disabled={index === 0}
                  className="p-1 rounded hover:bg-accent/50 disabled:opacity-30"
                >
                  <ArrowUp className="w-3 h-3" />
                </button>
                <button
                  onClick={() => moveDown(index)}
                  disabled={index === rankedFactors.length - 1}
                  className="p-1 rounded hover:bg-accent/50 disabled:opacity-30"
                >
                  <ArrowDown className="w-3 h-3" />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="pt-4 border-t">
        <label className="flex items-start gap-3 cursor-pointer">
          <input
            type="checkbox"
            checked={prioritizeUnderrepresented}
            onChange={(e) => updateField('prioritizeUnderrepresented', e.target.checked)}
            className="rounded border-slate-400/20 mt-0.5"
          />
          <div>
            <p className="text-sm font-medium">Prioritize underrepresented students</p>
            <p className="text-xs text-muted-foreground">
              Boost matching with first-gen, underrepresented, and financial-aid recipients
            </p>
          </div>
        </label>
      </div>
    </div>
  )
}
