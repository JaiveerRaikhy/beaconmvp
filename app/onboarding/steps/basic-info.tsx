'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { ProfilePictureUpload } from '@/components/profile/profile-picture-upload'

const US_STATES = [
  'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
  'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
  'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
  'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
  'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
  'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
  'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
  'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
  'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
  'West Virginia', 'Wisconsin', 'Wyoming'
]

export function BasicInfo() {
  const {
    profilePictureUrl,
    locationCity,
    locationState,
    updateField
  } = useOnboarding()

  return (
    <div className="space-y-6">
      <div className="flex flex-col items-center">
        <ProfilePictureUpload
          currentUrl={profilePictureUrl}
          onUpload={(url) => updateField('profilePictureUrl', url)}
        />
        <p className="text-sm text-muted-foreground mt-2">
          Upload a professional photo
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-2">
          <Label htmlFor="city">City</Label>
          <Input
            id="city"
            placeholder="New York"
            value={locationCity}
            onChange={(e) => updateField('locationCity', e.target.value)}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="state">State</Label>
          <select
            id="state"
            className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
            value={locationState}
            onChange={(e) => updateField('locationState', e.target.value)}
          >
            <option value="">Select state</option>
            {US_STATES.map(state => (
              <option key={state} value={state}>{state}</option>
            ))}
          </select>
        </div>
      </div>
    </div>
  )
}
