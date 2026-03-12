import { createClient } from '@/lib/supabase/server'
import { generateProspectsForGiver } from '@/lib/matching/generate-prospects'
import { NextResponse } from 'next/server'

const PROSPECT_LIMIT = 6

export async function GET() {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  // Verify user is a giver
  const { data: profile } = await supabase
    .from('profiles')
    .select('is_giver')
    .eq('id', user.id)
    .single()

  if (!profile?.is_giver) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  try {
    const prospects = await generateProspectsForGiver(user.id, PROSPECT_LIMIT)
    return NextResponse.json({
      prospects,
      count: prospects.length,
      limit: PROSPECT_LIMIT,
    })
  } catch (error) {
    console.error('Error generating prospects:', error)
    return NextResponse.json(
      { error: 'Something went wrong. Please try again later.' },
      { status: 500 }
    )
  }
}
