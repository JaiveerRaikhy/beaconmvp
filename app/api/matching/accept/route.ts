import { createClient } from '@/lib/supabase/server'
import { validateCsrfToken } from '@/lib/security/csrf'
import { acceptMatchSchema } from '@/lib/matching/schemas'
import { NextResponse } from 'next/server'

export async function POST(request: Request) {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const csrfValid = await validateCsrfToken(request)
  if (!csrfValid) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  let body: unknown
  try {
    body = await request.json()
  } catch {
    return NextResponse.json({ error: 'Invalid request body' }, { status: 400 })
  }

  const parsed = acceptMatchSchema.safeParse(body)
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid request data' }, { status: 400 })
  }

  const { seekerId, matchScore } = parsed.data

  // Verify the user is a giver
  const { data: profile } = await supabase
    .from('profiles')
    .select('is_giver')
    .eq('id', user.id)
    .single()

  if (!profile?.is_giver) {
    return NextResponse.json({ error: 'Only givers can accept matches' }, { status: 403 })
  }

  // Prevent self-matching
  if (seekerId === user.id) {
    return NextResponse.json({ error: 'Cannot match with yourself' }, { status: 400 })
  }

  // Check for existing match to prevent race condition duplicates
  const { data: existing } = await supabase
    .from('matches')
    .select('id')
    .eq('giver_id', user.id)
    .eq('seeker_id', seekerId)
    .maybeSingle()

  if (existing) {
    return NextResponse.json(
      { error: 'A match decision already exists for this seeker' },
      { status: 409 }
    )
  }

  // 15-day expiration from acceptance
  const expiresAt = new Date()
  expiresAt.setDate(expiresAt.getDate() + 15)

  const { data: match, error } = await supabase
    .from('matches')
    .insert({
      giver_id: user.id,
      seeker_id: seekerId,
      match_score: matchScore ?? null,
      status: 'accepted',
      accepted_at: new Date().toISOString(),
      expires_at: expiresAt.toISOString(),
    })
    .select()
    .single()

  if (error) {
    // Handle unique constraint violation (concurrent duplicate)
    if (error.code === '23505') {
      return NextResponse.json(
        { error: 'A match decision already exists for this seeker' },
        { status: 409 }
      )
    }
    console.error('Error creating match:', error)
    return NextResponse.json(
      { error: 'Something went wrong. Please try again later.' },
      { status: 500 }
    )
  }

  return NextResponse.json({ match })
}
