import { MapPin, User } from 'lucide-react'

interface ProfileHeaderProps {
  profile: {
    full_name: string | null
    profile_picture_url: string | null
    location_city: string | null
    location_state: string | null
    is_seeker: boolean
    is_giver: boolean
  } | null
}

export function ProfileHeader({ profile }: ProfileHeaderProps) {
  const roles = []
  if (profile?.is_seeker) roles.push('Seeker')
  if (profile?.is_giver) roles.push('Giver')

  return (
    <div className="flex flex-col items-center text-center">
      <div className="w-24 h-24 rounded-full bg-stone-300/60 overflow-hidden mb-4">
        {profile?.profile_picture_url ? (
          <img
            src={profile.profile_picture_url}
            alt=""
            className="w-full h-full object-cover"
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center text-muted-foreground">
            <User className="w-10 h-10" />
          </div>
        )}
      </div>

      <h1 className="text-xl font-bold">
        {profile?.full_name || 'User'}
      </h1>

      {(profile?.location_city || profile?.location_state) && (
        <p className="text-muted-foreground flex items-center gap-1 mt-1">
          <MapPin className="w-4 h-4" />
          {[profile.location_city, profile.location_state].filter(Boolean).join(', ')}
        </p>
      )}

      {roles.length > 0 && (
        <div className="flex gap-2 mt-2">
          {roles.map(role => (
            <span
              key={role}
              className="px-3 py-1 bg-primary/10 text-primary rounded-full text-sm"
            >
              {role}
            </span>
          ))}
        </div>
      )}
    </div>
  )
}
