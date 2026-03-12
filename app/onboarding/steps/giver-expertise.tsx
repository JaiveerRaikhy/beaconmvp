'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { INDUSTRIES } from '@/lib/data/industries'
import { HELP_TYPE_CATEGORIES } from '@/lib/data/help-types'
import { cn } from '@/lib/utils'
import { Check } from 'lucide-react'

export function GiverExpertise() {
  const { industriesCanAdvise, helpTypesOffered, updateField } = useOnboarding()

  const toggleIndustry = (industry: string) => {
    if (industriesCanAdvise.includes(industry)) {
      updateField('industriesCanAdvise', industriesCanAdvise.filter(i => i !== industry))
    } else {
      updateField('industriesCanAdvise', [...industriesCanAdvise, industry])
    }
  }

  const toggleHelpType = (typeId: string) => {
    if (helpTypesOffered.includes(typeId)) {
      updateField('helpTypesOffered', helpTypesOffered.filter(t => t !== typeId))
    } else {
      updateField('helpTypesOffered', [...helpTypesOffered, typeId])
    }
  }

  return (
    <div className="space-y-6">
      <div className="space-y-3">
        <h3 className="font-medium">Industries you can advise on</h3>
        <p className="text-sm text-muted-foreground">Select all that apply</p>
        <div className="grid gap-2 grid-cols-2 sm:grid-cols-3">
          {INDUSTRIES.map(industry => {
            const isSelected = industriesCanAdvise.includes(industry)
            return (
              <button
                key={industry}
                className={cn(
                  'text-left px-3 py-2 rounded-lg border text-sm transition-colors',
                  isSelected
                    ? 'border-emerald-500 bg-emerald-500/10 text-emerald-500'
                    : 'border-input hover:bg-accent/50'
                )}
                onClick={() => toggleIndustry(industry)}
              >
                {industry}
              </button>
            )
          })}
        </div>
      </div>

      <div className="space-y-3 pt-4 border-t">
        <h3 className="font-medium">Types of help you can offer</h3>
        <p className="text-sm text-muted-foreground">Select all that apply</p>
        {HELP_TYPE_CATEGORIES.map(category => (
          <div key={category.id} className="space-y-2">
            <h4 className="text-sm font-semibold text-muted-foreground">{category.name}</h4>
            <div className="grid gap-2 sm:grid-cols-2">
              {category.types.map(type => {
                const isSelected = helpTypesOffered.includes(type.id)
                return (
                  <button
                    key={type.id}
                    className={cn(
                      'flex items-center gap-2 text-left px-3 py-2 rounded-lg border text-sm transition-colors',
                      isSelected
                        ? 'border-emerald-500 bg-emerald-500/10 text-emerald-500'
                        : 'border-input hover:bg-accent/50'
                    )}
                    onClick={() => toggleHelpType(type.id)}
                  >
                    <div className={cn(
                      'w-4 h-4 rounded border flex items-center justify-center shrink-0',
                      isSelected ? 'bg-emerald-500 border-emerald-500' : 'border-slate-400/20'
                    )}>
                      {isSelected && <Check className="w-3 h-3 text-white" />}
                    </div>
                    {type.name}
                  </button>
                )
              })}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
