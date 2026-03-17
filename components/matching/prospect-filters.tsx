'use client'

import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'

interface ProspectFiltersProps {
  searchQuery: string
  onSearchChange: (query: string) => void
  selectedTier: string | null
  onTierChange: (tier: string | null) => void
  selectedIndustry: string | null
  onIndustryChange: (industry: string | null) => void
  industries: string[]
  onReset: () => void
  hasActiveFilters: boolean
}

const TIERS = [
  { value: 'high', label: 'High Match', color: 'bg-emerald-500' },
  { value: 'good', label: 'Good Match', color: 'bg-orange-600' },
  { value: 'fair', label: 'Fair Match', color: 'bg-muted-foreground' },
]

export function ProspectFilters({
  searchQuery,
  onSearchChange,
  selectedTier,
  onTierChange,
  selectedIndustry,
  onIndustryChange,
  industries,
  onReset,
  hasActiveFilters,
}: ProspectFiltersProps) {
  return (
    <div className="space-y-3">
      {/* Search */}
      <Input
        type="text"
        placeholder="Search by name, school, or role..."
        value={searchQuery}
        onChange={(e) => onSearchChange(e.target.value)}
      />

      {/* Tier filter */}
      <div className="flex flex-wrap items-center gap-2">
        <span className="text-xs text-muted-foreground mr-1">Match:</span>
        {TIERS.map((tier) => (
          <button
            key={tier.value}
            onClick={() =>
              onTierChange(selectedTier === tier.value ? null : tier.value)
            }
            className={cn(
              'inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 text-xs font-medium transition-colors',
              selectedTier === tier.value
                ? 'border-primary bg-primary/10 text-primary'
                : 'border-border text-muted-foreground hover:border-primary/50'
            )}
          >
            <span
              className={cn('w-2 h-2 rounded-full', tier.color)}
            />
            {tier.label}
          </button>
        ))}
      </div>

      {/* Industry filter */}
      {industries.length > 1 && (
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-xs text-muted-foreground mr-1">Industry:</span>
          {industries.map((industry) => (
            <button
              key={industry}
              onClick={() =>
                onIndustryChange(
                  selectedIndustry === industry ? null : industry
                )
              }
              className={cn(
                'rounded-full border px-2.5 py-1 text-xs font-medium transition-colors',
                selectedIndustry === industry
                  ? 'border-primary bg-primary/10 text-primary'
                  : 'border-border text-muted-foreground hover:border-primary/50'
              )}
            >
              {industry}
            </button>
          ))}
        </div>
      )}

      {/* Reset */}
      {hasActiveFilters && (
        <Button variant="ghost" size="sm" onClick={onReset} className="text-xs">
          Clear filters
        </Button>
      )}
    </div>
  )
}
