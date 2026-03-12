'use client'

import { useEffect, useState } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { ArrowLeft, Save, Loader2 } from 'lucide-react'
import { sanitizeText, sanitizeName } from '@/lib/security/sanitize'
import { toast } from 'sonner'
import Link from 'next/link'
import { ProfilePictureUpload } from '@/components/profile/profile-picture-upload'

interface ProfileData {
  full_name: string
  bio: string
  location_city: string
  location_state: string
  profile_picture_url: string | null
  is_seeker: boolean
  is_giver: boolean
}

interface SeekerData {
  target_industry: string
  target_role: string
  goal_text: string
}

export default function ProfileEditPage() {
  const router = useRouter()
  const searchParams = useSearchParams()
  const section = searchParams.get('section')
  const supabase = createClient()

  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [userId, setUserId] = useState('')
  const [profile, setProfile] = useState<ProfileData>({
    full_name: '',
    bio: '',
    location_city: '',
    location_state: '',
    profile_picture_url: null,
    is_seeker: false,
    is_giver: false,
  })
  const [seekerData, setSeekerData] = useState<SeekerData>({
    target_industry: '',
    target_role: '',
    goal_text: '',
  })

  useEffect(() => {
    async function loadProfile() {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        router.push('/login')
        return
      }
      setUserId(user.id)

      const { data } = await supabase
        .from('profiles')
        .select('*, seeker_profiles(*)')
        .eq('id', user.id)
        .single()

      if (data) {
        setProfile({
          full_name: data.full_name || '',
          bio: data.bio || '',
          location_city: data.location_city || '',
          location_state: data.location_state || '',
          profile_picture_url: data.profile_picture_url,
          is_seeker: data.is_seeker,
          is_giver: data.is_giver,
        })

        if (data.seeker_profiles) {
          setSeekerData({
            target_industry: data.seeker_profiles.target_industry || '',
            target_role: data.seeker_profiles.target_role || '',
            goal_text: data.seeker_profiles.goal_text || '',
          })
        }
      }

      setLoading(false)
    }

    loadProfile()
  }, [router, supabase])

  const handleSave = async () => {
    setSaving(true)

    const sanitizedProfile = {
      full_name: sanitizeName(profile.full_name),
      bio: sanitizeText(profile.bio),
      location_city: sanitizeName(profile.location_city),
      location_state: sanitizeName(profile.location_state),
      profile_picture_url: profile.profile_picture_url,
    }

    const { error: profileError } = await supabase
      .from('profiles')
      .update(sanitizedProfile)
      .eq('id', userId)

    if (profileError) {
      toast.error('Failed to save profile')
      setSaving(false)
      return
    }

    // Update seeker data if applicable
    if (profile.is_seeker) {
      const sanitizedSeeker = {
        target_industry: sanitizeText(seekerData.target_industry),
        target_role: sanitizeText(seekerData.target_role),
        goal_text: sanitizeText(seekerData.goal_text),
      }

      const { error: seekerError } = await supabase
        .from('seeker_profiles')
        .update(sanitizedSeeker)
        .eq('user_id', userId)

      if (seekerError) {
        toast.error('Failed to save career goals')
        setSaving(false)
        return
      }
    }

    toast.success('Profile updated')
    setSaving(false)
    router.push('/profile')
    router.refresh()
  }

  const handleProfilePictureChange = (url: string | null) => {
    setProfile(prev => ({ ...prev, profile_picture_url: url }))
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    )
  }

  const showSection = (name: string) => !section || section === name

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <Link href="/profile">
            <Button variant="ghost" size="icon">
              <ArrowLeft className="w-5 h-5" />
            </Button>
          </Link>
          <h1 className="text-2xl font-bold">Edit Profile</h1>
        </div>
        <Button onClick={handleSave} disabled={saving}>
          {saving ? (
            <Loader2 className="w-4 h-4 mr-2 animate-spin" />
          ) : (
            <Save className="w-4 h-4 mr-2" />
          )}
          Save
        </Button>
      </div>

      {/* Profile Picture */}
      {showSection('basic') && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Profile Picture</CardTitle>
          </CardHeader>
          <CardContent>
            <ProfilePictureUpload
              currentUrl={profile.profile_picture_url}
              onUpload={(url: string) => handleProfilePictureChange(url)}
            />
          </CardContent>
        </Card>
      )}

      {/* Basic Info */}
      {showSection('basic') && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Basic Information</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="full_name">Full Name</Label>
              <Input
                id="full_name"
                value={profile.full_name}
                onChange={(e) => setProfile(prev => ({
                  ...prev,
                  full_name: e.target.value,
                }))}
                maxLength={200}
              />
            </div>

            <div className="grid gap-4 sm:grid-cols-2">
              <div>
                <Label htmlFor="city">City</Label>
                <Input
                  id="city"
                  value={profile.location_city}
                  onChange={(e) => setProfile(prev => ({
                    ...prev,
                    location_city: e.target.value,
                  }))}
                  maxLength={100}
                />
              </div>
              <div>
                <Label htmlFor="state">State</Label>
                <Input
                  id="state"
                  value={profile.location_state}
                  onChange={(e) => setProfile(prev => ({
                    ...prev,
                    location_state: e.target.value,
                  }))}
                  maxLength={100}
                />
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Bio */}
      {showSection('bio') && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">About</CardTitle>
          </CardHeader>
          <CardContent>
            <div>
              <Label htmlFor="bio">Bio</Label>
              <textarea
                id="bio"
                value={profile.bio}
                onChange={(e) => setProfile(prev => ({
                  ...prev,
                  bio: e.target.value,
                }))}
                className="flex min-h-[120px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
                maxLength={1000}
                placeholder="Tell people about yourself..."
              />
              <p className="text-xs text-muted-foreground mt-1">
                {profile.bio.length}/1000 characters
              </p>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Career Goals (Seekers) */}
      {profile.is_seeker && showSection('goals') && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Career Goals</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="target_industry">Target Industry</Label>
              <Input
                id="target_industry"
                value={seekerData.target_industry}
                onChange={(e) => setSeekerData(prev => ({
                  ...prev,
                  target_industry: e.target.value,
                }))}
                maxLength={200}
              />
            </div>
            <div>
              <Label htmlFor="target_role">Target Role</Label>
              <Input
                id="target_role"
                value={seekerData.target_role}
                onChange={(e) => setSeekerData(prev => ({
                  ...prev,
                  target_role: e.target.value,
                }))}
                maxLength={200}
              />
            </div>
            <div>
              <Label htmlFor="goal_text">Goal Description</Label>
              <textarea
                id="goal_text"
                value={seekerData.goal_text}
                onChange={(e) => setSeekerData(prev => ({
                  ...prev,
                  goal_text: e.target.value,
                }))}
                className="flex min-h-[80px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
                maxLength={500}
                placeholder="Describe your career goals..."
              />
            </div>
          </CardContent>
        </Card>
      )}

      {/* Bottom Save Button */}
      <Button onClick={handleSave} disabled={saving} className="w-full">
        {saving ? (
          <Loader2 className="w-4 h-4 mr-2 animate-spin" />
        ) : (
          <Save className="w-4 h-4 mr-2" />
        )}
        Save Changes
      </Button>
    </div>
  )
}
