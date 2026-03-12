import { createClient } from '@/lib/supabase/server'
import { MatchList } from '@/components/matches/match-list'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-react'
import Link from 'next/link'

interface JoinedPerson {
  full_name: string | null
  profile_picture_url: string | null
}

export default async function GettingAdvicePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: matches } = await supabase
    .from('matches')
    .select(`
      id,
      created_at,
      match_score,
      expires_at,
      giver:profiles!matches_giver_id_fkey(full_name, profile_picture_url),
      messages(id)
    `)
    .eq('seeker_id', user?.id)
    .eq('status', 'accepted')
    .order('created_at', { ascending: false })

  const formattedMatches = matches?.map((m) => ({
    id: m.id,
    created_at: m.created_at,
    person: m.giver as unknown as JoinedPerson,
    hasMessages: (m.messages?.length || 0) > 0,
    matchScore: m.match_score,
    expiresAt: m.expires_at,
  })) || []

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Link href="/matches">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="w-5 h-5" />
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl font-bold">Getting Advice</h1>
          <p className="text-muted-foreground text-sm">People helping you</p>
        </div>
      </div>

      <MatchList
        matches={formattedMatches}
        emptyMessage="No mentors yet. You'll be matched with advisors who can help you reach your goals."
      />
    </div>
  )
}
