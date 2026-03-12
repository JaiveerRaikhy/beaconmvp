import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

const ALLOWED_REDIRECT_PATHS = ['/home', '/profile', '/matches', '/messages', '/onboarding']

function getSafeRedirectPath(next: string | null): string {
  if (!next) return '/home'

  // Decode to catch encoded bypass attempts (e.g. /%2f -> //)
  let decoded: string
  try {
    decoded = decodeURIComponent(next)
  } catch {
    return '/home'
  }

  // Must be a relative path, block protocol-relative URLs and schemes
  if (!decoded.startsWith('/') || decoded.startsWith('//')) return '/home'
  if (/^[a-z]+:/i.test(decoded)) return '/home'

  // Normalize path traversal (e.g. /home/../evil -> /evil)
  // Use URL constructor to resolve the path safely
  let normalizedPath: string
  try {
    const url = new URL(decoded, 'http://localhost')
    normalizedPath = url.pathname
  } catch {
    return '/home'
  }

  // Validate the normalized path against the allowlist
  const isAllowed = ALLOWED_REDIRECT_PATHS.some(
    (allowed) => normalizedPath === allowed || normalizedPath.startsWith(allowed + '/')
  )
  return isAllowed ? normalizedPath : '/home'
}

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url)
  const code = searchParams.get('code')
  const next = getSafeRedirectPath(searchParams.get('next'))

  if (code) {
    const supabase = await createClient()
    const { error } = await supabase.auth.exchangeCodeForSession(code)

    if (!error) {
      const { data: { user } } = await supabase.auth.getUser()

      if (user) {
        const { data: profile } = await supabase
          .from('profiles')
          .select('onboarding_completed')
          .eq('id', user.id)
          .single()

        if (profile && !profile.onboarding_completed) {
          return NextResponse.redirect(`${origin}/onboarding`)
        }
      }

      return NextResponse.redirect(`${origin}${next}`)
    }
  }

  return NextResponse.redirect(`${origin}/login?error=auth_callback_error`)
}
