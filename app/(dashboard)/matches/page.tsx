import { createClient } from '@/lib/supabase/server'
import { Card, CardContent } from '@/components/ui/card'
import { ChevronRight, Search, Users, UserCheck, Archive } from 'lucide-react'
import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Matches',
}

export default async function MatchesPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  // Fetch profile and all counts in parallel
  const [
    { data: profile },
    { count: gettingAdviceCount },
    { count: givingAdviceCount },
    { count: archivedCount },
  ] = await Promise.all([
    supabase
      .from('profiles')
      .select('is_seeker, is_giver')
      .eq('id', user?.id)
      .single(),
    supabase
      .from('matches')
      .select('*', { count: 'exact', head: true })
      .eq('seeker_id', user?.id)
      .eq('status', 'accepted'),
    supabase
      .from('matches')
      .select('*', { count: 'exact', head: true })
      .eq('giver_id', user?.id)
      .eq('status', 'accepted'),
    supabase
      .from('matches')
      .select('*', { count: 'exact', head: true })
      .or(`giver_id.eq.${user?.id},seeker_id.eq.${user?.id}`)
      .eq('status', 'archived'),
  ])

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Matches</h1>

      {/* Find New Prospects - Only for Givers */}
      {profile?.is_giver && (
        <Link href="/matches/browse">
          <Card className="bg-primary text-primary-foreground hover:bg-primary/90 transition-colors cursor-pointer">
            <CardContent className="flex items-center justify-center gap-2 py-6">
              <Search className="w-5 h-5" />
              <span className="font-medium">Find New Prospects</span>
            </CardContent>
          </Card>
        </Link>
      )}

      <div className="space-y-3">
        {/* Getting Advice Section - Only for Seekers */}
        {profile?.is_seeker && (
          <Link href="/matches/getting-advice">
            <Card className="hover:bg-accent/50 transition-colors cursor-pointer">
              <CardContent className="flex items-center justify-between py-4">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
                    <Users className="w-5 h-5 text-primary" />
                  </div>
                  <div>
                    <p className="font-medium">Getting Advice ({gettingAdviceCount || 0})</p>
                    <p className="text-sm text-muted-foreground">People helping you</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-muted-foreground" />
              </CardContent>
            </Card>
          </Link>
        )}

        {/* Giving Advice Section - Only for Givers */}
        {profile?.is_giver && (
          <Link href="/matches/giving-advice">
            <Card className="hover:bg-accent/50 transition-colors cursor-pointer">
              <CardContent className="flex items-center justify-between py-4">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-emerald-500/10 flex items-center justify-center">
                    <UserCheck className="w-5 h-5 text-emerald-500" />
                  </div>
                  <div>
                    <p className="font-medium">Giving Advice ({givingAdviceCount || 0})</p>
                    <p className="text-sm text-muted-foreground">People you&apos;re helping</p>
                  </div>
                </div>
                <ChevronRight className="w-5 h-5 text-muted-foreground" />
              </CardContent>
            </Card>
          </Link>
        )}

        {/* Archived Section */}
        <Link href="/matches/archived">
          <Card className="hover:bg-accent/50 transition-colors cursor-pointer">
            <CardContent className="flex items-center justify-between py-4">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-slate-700/50 flex items-center justify-center">
                  <Archive className="w-5 h-5 text-muted-foreground" />
                </div>
                <div>
                  <p className="font-medium">Archived ({archivedCount || 0})</p>
                  <p className="text-sm text-muted-foreground">Past connections</p>
                </div>
              </div>
              <ChevronRight className="w-5 h-5 text-muted-foreground" />
            </CardContent>
          </Card>
        </Link>
      </div>
    </div>
  )
}
