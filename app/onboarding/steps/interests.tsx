'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { InterestsSelector } from '@/components/forms/interests-selector'

export function Interests() {
  const { interests, updateField } = useOnboarding()

  return (
    <div className="space-y-4">
      <p className="text-sm text-muted-foreground text-center">
        Add interests to help us find better matches. Shared interests make for stronger connections.
      </p>

      <InterestsSelector
        selected={interests}
        onChange={(newInterests) => updateField('interests', newInterests)}
        max={15}
      />
    </div>
  )
}
