import { createClient } from '@/lib/supabase/server'
import { Card, CardContent } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ArrowLeft, User } from 'lucide-react'
import Link from 'next/link'
import { formatDistanceToNow } from 'date-fns'

interface JoinedPerson {
  full_name: string | null
  profile_picture_url: string | null
}

export default async function ArchivedMatchesPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const { data: matches } = await supabase
    .from('matches')
    .select(`
      id,
      created_at,
      giver_id,
      seeker_id,
      giver:profiles!matches_giver_id_fkey(full_name, profile_picture_url),
      seeker:profiles!matches_seeker_id_fkey(full_name, profile_picture_url)
    `)
    .or(`giver_id.eq.${user?.id},seeker_id.eq.${user?.id}`)
    .eq('status', 'archived')
    .order('created_at', { ascending: false })

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Link href="/matches">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="w-5 h-5" />
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl font-bold">Archived</h1>
          <p className="text-muted-foreground text-sm">Past connections</p>
        </div>
      </div>

      {(!matches || matches.length === 0) ? (
        <Card>
          <CardContent className="py-8 text-center">
            <p className="text-muted-foreground">No archived connections</p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-3">
          {matches.map((match) => {
            const isGiver = match.giver_id === user?.id
            const person = (isGiver ? match.seeker : match.giver) as unknown as JoinedPerson

            return (
              <Card key={match.id} className="opacity-75">
                <CardContent className="flex items-center gap-4 py-4">
                  <div className="w-12 h-12 rounded-full bg-slate-700/50 overflow-hidden flex-shrink-0">
                    {person.profile_picture_url ? (
                      <img
                        src={person.profile_picture_url}
                        alt=""
                        className="w-full h-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full flex items-center justify-center text-muted-foreground">
                        <User className="w-6 h-6" />
                      </div>
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium truncate">{person.full_name || 'User'}</p>
                    <p className="text-xs text-muted-foreground">
                      Archived {formatDistanceToNow(new Date(match.created_at), { addSuffix: true })}
                    </p>
                  </div>
                </CardContent>
              </Card>
            )
          })}
        </div>
      )}
    </div>
  )
}
