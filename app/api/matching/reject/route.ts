import { createClient } from '@/lib/supabase/server'
import { validateCsrfToken } from '@/lib/security/csrf'
import { rejectMatchSchema } from '@/lib/matching/schemas'
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

  const parsed = rejectMatchSchema.safeParse(body)
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid request data' }, { status: 400 })
  }

  const { seekerId } = parsed.data

  // Verify the user is a giver
  const { data: profile } = await supabase
    .from('profiles')
    .select('is_giver')
    .eq('id', user.id)
    .single()

  if (!profile?.is_giver) {
    return NextResponse.json({ error: 'Only givers can reject matches' }, { status: 403 })
  }

  // Prevent self-rejection
  if (seekerId === user.id) {
    return NextResponse.json({ error: 'Invalid operation' }, { status: 400 })
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

  // Record rejection so this seeker won't appear again
  const { error } = await supabase.from('matches').insert({
    giver_id: user.id,
    seeker_id: seekerId,
    status: 'rejected',
  })

  if (error) {
    // Handle unique constraint violation (concurrent duplicate)
    if (error.code === '23505') {
      return NextResponse.json(
        { error: 'A match decision already exists for this seeker' },
        { status: 409 }
      )
    }
    console.error('Error creating rejection:', error)
    return NextResponse.json(
      { error: 'Something went wrong. Please try again later.' },
      { status: 500 }
    )
  }

  return NextResponse.json({ success: true })
}
