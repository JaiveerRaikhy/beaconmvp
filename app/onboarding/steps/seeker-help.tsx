'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { HELP_TYPE_CATEGORIES } from '@/lib/data/help-types'
import { cn } from '@/lib/utils'
import { Check } from 'lucide-react'

export function SeekerHelp() {
  const { helpTypesNeeded, updateField } = useOnboarding()

  const toggleType = (typeId: string) => {
    if (helpTypesNeeded.includes(typeId)) {
      updateField('helpTypesNeeded', helpTypesNeeded.filter(t => t !== typeId))
    } else {
      updateField('helpTypesNeeded', [...helpTypesNeeded, typeId])
    }
  }

  return (
    <div className="space-y-6">
      <p className="text-sm text-muted-foreground text-center">
        Select all the types of help you&apos;re looking for. This helps us match you with the right mentors.
      </p>

      {HELP_TYPE_CATEGORIES.map(category => (
        <div key={category.id} className="space-y-2">
          <h3 className="text-sm font-semibold text-foreground">{category.name}</h3>
          <div className="grid gap-2 sm:grid-cols-2">
            {category.types.map(type => {
              const isSelected = helpTypesNeeded.includes(type.id)
              return (
                <button
                  key={type.id}
                  className={cn(
                    'flex items-center gap-2 text-left px-3 py-2 rounded-lg border text-sm transition-colors',
                    isSelected
                      ? 'border-emerald-500 bg-emerald-500/10 text-emerald-500'
                      : 'border-input hover:bg-accent/50'
                  )}
                  onClick={() => toggleType(type.id)}
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

      <p className="text-sm text-muted-foreground text-center">
        {helpTypesNeeded.length} selected
        {helpTypesNeeded.length === 0 && ' — select at least one to continue'}
      </p>
    </div>
  )
}
