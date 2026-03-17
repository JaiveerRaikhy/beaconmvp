'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { Label } from '@/components/ui/label'

export function Bio() {
  const { bio, updateField } = useOnboarding()

  return (
    <div className="space-y-4">
      <p className="text-sm text-muted-foreground text-center">
        Write a short bio to introduce yourself. This will be visible on your profile.
      </p>

      <div className="space-y-2">
        <Label htmlFor="bio">Bio</Label>
        <textarea
          id="bio"
          className="w-full min-h-[150px] px-3 py-2 rounded-md border border-input bg-background text-sm resize-y"
          placeholder="Tell people a little about yourself — your background, what you're passionate about, what you're looking for..."
          value={bio}
          onChange={(e) => updateField('bio', e.target.value)}
          maxLength={1000}
        />
        <p className="text-xs text-muted-foreground text-right">
          {bio.length}/1000 characters
        </p>
      </div>

      <div className="bg-stone-100/50 rounded-lg p-4 space-y-2">
        <p className="text-sm font-medium">Tips for a great bio:</p>
        <ul className="text-sm text-muted-foreground space-y-1 list-disc list-inside">
          <li>Mention your background or what you studied</li>
          <li>Share what you&apos;re passionate about</li>
          <li>Describe what you hope to gain from Beacon</li>
          <li>Keep it authentic and conversational</li>
        </ul>
      </div>
    </div>
  )
}
