import { createClient } from '@/lib/supabase/server'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { ProfileHeader } from '@/components/profile/profile-header'
import { ProfileSection } from '@/components/profile/profile-section'
import {
  GraduationCap,
  Briefcase,
  Target,
  Heart,
  FileText,
  Settings,
  Edit,
} from 'lucide-react'
import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Profile',
}

export default async function ProfilePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: profile } = await supabase
    .from('profiles')
    .select(`
      *,
      education(*),
      experiences(*),
      seeker_profiles(*),
      giver_profiles(*),
      user_interests(interest:interests(name))
    `)
    .eq('id', user?.id)
    .single()

  const interests = profile?.user_interests?.map(
    (ui: { interest: { name: string } }) => ui.interest.name
  ) || []

  return (
    <div className="space-y-6">
      {/* Header */}
      <ProfileHeader profile={profile} />

      {/* Edit Button */}
      <Link href="/profile/edit">
        <Button variant="outline" className="w-full">
          <Edit className="w-4 h-4 mr-2" />
          Edit Profile
        </Button>
      </Link>

      {/* Education */}
      <ProfileSection
        icon={GraduationCap}
        title="Education"
        editHref="/profile/edit?section=education"
      >
        {profile?.education?.length > 0 ? (
          <div className="space-y-3">
            {profile.education.map((edu: {
              id: string
              school_name: string
              degree_type: string
              major: string
              graduation_year: number
              gpa: number | null
              gpa_scale: number | null
            }) => (
              <div key={edu.id}>
                <p className="font-medium">{edu.school_name}</p>
                <p className="text-sm text-muted-foreground">
                  {edu.degree_type} in {edu.major}, {edu.graduation_year}
                </p>
                {edu.gpa && (
                  <p className="text-sm text-muted-foreground">
                    GPA: {edu.gpa}/{edu.gpa_scale || 4.0}
                  </p>
                )}
              </div>
            ))}
          </div>
        ) : (
          <p className="text-muted-foreground text-sm">No education added</p>
        )}
      </ProfileSection>

      {/* Experience */}
      <ProfileSection
        icon={Briefcase}
        title="Experience"
        editHref="/profile/edit?section=experience"
      >
        {profile?.experiences?.length > 0 ? (
          <div className="space-y-3">
            {profile.experiences.map((exp: {
              id: string
              job_title: string
              company_name: string
              is_current: boolean
            }) => (
              <div key={exp.id}>
                <p className="font-medium">{exp.job_title}</p>
                <p className="text-sm text-muted-foreground">
                  {exp.company_name}
                  {exp.is_current && ' \u2022 Present'}
                </p>
              </div>
            ))}
          </div>
        ) : (
          <p className="text-muted-foreground text-sm">No experience added</p>
        )}
      </ProfileSection>

      {/* Career Goals (Seekers) */}
      {profile?.is_seeker && profile?.seeker_profiles && (
        <ProfileSection
          icon={Target}
          title="Career Goals"
          editHref="/profile/edit?section=goals"
        >
          <div className="space-y-2">
            {profile.seeker_profiles.target_industry && (
              <p className="text-sm">
                <span className="text-muted-foreground">Target Industry:</span>{' '}
                {profile.seeker_profiles.target_industry}
              </p>
            )}
            {profile.seeker_profiles.target_role && (
              <p className="text-sm">
                <span className="text-muted-foreground">Target Role:</span>{' '}
                {profile.seeker_profiles.target_role}
              </p>
            )}
            {profile.seeker_profiles.goal_text && (
              <p className="text-sm">{profile.seeker_profiles.goal_text}</p>
            )}
          </div>
        </ProfileSection>
      )}

      {/* Interests */}
      <ProfileSection
        icon={Heart}
        title="Interests"
        editHref="/profile/edit?section=interests"
      >
        {interests.length > 0 ? (
          <div className="flex flex-wrap gap-2">
            {interests.map((interest: string) => (
              <span
                key={interest}
                className="px-3 py-1 bg-slate-400/10 rounded-full text-sm"
              >
                {interest}
              </span>
            ))}
          </div>
        ) : (
          <p className="text-muted-foreground text-sm">No interests added</p>
        )}
      </ProfileSection>

      {/* Bio */}
      <ProfileSection
        icon={FileText}
        title="About"
        editHref="/profile/edit?section=bio"
      >
        <p className="text-sm whitespace-pre-wrap">
          {profile?.bio || 'No bio added'}
        </p>
      </ProfileSection>

      {/* Settings Link */}
      <Card>
        <CardContent className="py-0">
          <Link
            href="/profile/settings"
            className="flex items-center justify-between py-4 cursor-pointer hover:opacity-80 transition-opacity"
          >
            <div className="flex items-center gap-3">
              <Settings className="w-5 h-5 text-muted-foreground" />
              <span>Account Settings</span>
            </div>
          </Link>
        </CardContent>
      </Card>
    </div>
  )
}
