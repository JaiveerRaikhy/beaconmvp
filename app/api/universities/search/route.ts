import { createClient } from '@/lib/supabase/server'
import { sanitizeSearchQuery } from '@/lib/security/sanitize'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  const q = request.nextUrl.searchParams.get('q')

  if (!q || q.length < 2) {
    return NextResponse.json([])
  }

  const sanitized = sanitizeSearchQuery(q)
  if (!sanitized) {
    return NextResponse.json([])
  }

  const supabase = await createClient()

  const { data, error } = await supabase
    .from('universities')
    .select('id, name, location')
    .ilike('name', `%${sanitized}%`)
    .limit(10)

  if (error) {
    return NextResponse.json(
      { error: 'Failed to search universities' },
      { status: 500 }
    )
  }

  return NextResponse.json(data)
}
