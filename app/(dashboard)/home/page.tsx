import { createClient } from '@/lib/supabase/server'
import { StatsCards } from '@/components/home/stats-cards'
import { ActivityFeed } from '@/components/home/activity-feed'
import { ImpactSection } from '@/components/home/impact-section'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Home',
}

function sanitizeDisplayName(name: string | null | undefined): string {
  if (!name) return 'there'
  const firstName = name.split(' ')[0] ?? ''
  const sanitized = firstName.replace(/[^\p{L}\p{N}\s\-']/gu, '').trim()
  return sanitized || 'there'
}

export default async function HomePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: profile } = await supabase
    .from('profiles')
    .select('*, giver_profiles(*)')
    .eq('id', user?.id)
    .single()

  const displayName = sanitizeDisplayName(profile?.full_name)

  // Fetch stats, activity, and impact events in parallel
  const [
    { count: activeConnections },
    { count: totalMessages },
    { data: recentMatches },
    { data: impactEvents },
  ] = await Promise.all([
    supabase
      .from('matches')
      .select('*', { count: 'exact', head: true })
      .or(`giver_id.eq.${user?.id},seeker_id.eq.${user?.id}`)
      .eq('status', 'accepted'),
    supabase
      .from('messages')
      .select('*', { count: 'exact', head: true })
      .eq('sender_id', user?.id),
    supabase
      .from('matches')
      .select(`
        *,
        giver:profiles!matches_giver_id_fkey(full_name, profile_picture_url),
        seeker:profiles!matches_seeker_id_fkey(full_name, profile_picture_url)
      `)
      .or(`giver_id.eq.${user?.id},seeker_id.eq.${user?.id}`)
      .order('created_at', { ascending: false })
      .limit(5),
    supabase
      .from('impact_tags')
      .select(`
        *,
        impact_event:impact_events(*)
      `)
      .eq('giver_id', user?.id)
      .order('created_at', { ascending: false })
      .limit(5),
  ])

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">
          Welcome back, {displayName}
        </h1>
        <p className="text-muted-foreground">
          Here&apos;s what&apos;s happening with your connections
        </p>
      </div>

      <StatsCards
        activeConnections={activeConnections || 0}
        totalMessages={totalMessages || 0}
      />

      <ActivityFeed
        matches={recentMatches || []}
        currentUserId={user?.id || ''}
      />

      {profile?.is_giver && (
        <ImpactSection events={impactEvents || []} />
      )}
    </div>
  )
}
