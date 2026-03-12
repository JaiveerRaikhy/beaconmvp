import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'
import { checkRateLimit, getClientIp, RATE_LIMITS } from '@/lib/security/rate-limit'

function generateNonce(): string {
  const array = new Uint8Array(16)
  crypto.getRandomValues(array)
  return btoa(String.fromCharCode(...array))
}

function buildCspHeader(nonce: string): string {
  return [
    "default-src 'self'",
    `script-src 'self' 'nonce-${nonce}' 'strict-dynamic'`,
    "style-src 'self' 'unsafe-inline'",
    "img-src 'self' data: blob: https://*.supabase.co",
    "font-src 'self'",
    "connect-src 'self' https://*.supabase.co wss://*.supabase.co",
    "frame-ancestors 'none'",
    "base-uri 'self'",
    "form-action 'self'",
  ].join('; ')
}

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl

  // Generate CSP nonce for this request
  const nonce = generateNonce()
  const requestHeaders = new Headers(request.headers)
  requestHeaders.set('x-nonce', nonce)

  // --- Rate limiting ---
  // Skip rate limiting during E2E tests to avoid false failures
  const skipRateLimit = process.env.PLAYWRIGHT_TEST === '1'
  const clientIp = getClientIp(request)

  // Rate limit auth pages (login, signup, forgot-password) on POST-like activity
  // These pages use client-side Supabase SDK, so we rate limit page loads
  const authRoutes = ['/login', '/signup', '/forgot-password']
  const isAuthRoute = authRoutes.some(route => pathname.startsWith(route))

  // Rate limit API routes
  const isMatchingApi = pathname.startsWith('/api/matching/')
  const isMessageApi = pathname.startsWith('/api/messages')
  const isUploadApi = pathname.startsWith('/api/upload') || pathname === '/api/messages/upload'

  if (!skipRateLimit) {
    if (isAuthRoute) {
      const result = checkRateLimit(`auth:${clientIp}`, RATE_LIMITS.auth)
      if (!result.allowed) {
        return new NextResponse('Too many requests. Please try again later.', {
          status: 429,
          headers: {
            'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
          },
        })
      }
    }

    if (isMessageApi) {
      const result = checkRateLimit(`msg:${clientIp}`, RATE_LIMITS.messaging)
      if (!result.allowed) {
        return NextResponse.json(
          { error: 'Too many messages. Please slow down.' },
          {
            status: 429,
            headers: {
              'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
            },
          }
        )
      }
    }

    if (isUploadApi) {
      const result = checkRateLimit(`upload:${clientIp}`, RATE_LIMITS.fileUpload)
      if (!result.allowed) {
        return NextResponse.json(
          { error: 'Too many uploads. Please try again later.' },
          {
            status: 429,
            headers: {
              'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
            },
          }
        )
      }
    }

    // Stricter rate limit for prospect browsing to prevent enumeration
    const isProspectsApi = pathname === '/api/matching/prospects'
    if (isProspectsApi) {
      const result = checkRateLimit(`prospects:${clientIp}`, RATE_LIMITS.prospects)
      if (!result.allowed) {
        return NextResponse.json(
          { error: 'Too many requests. Please try again later.' },
          {
            status: 429,
            headers: {
              'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
            },
          }
        )
      }
    }

    if (isMatchingApi) {
      const result = checkRateLimit(`api:${clientIp}`, RATE_LIMITS.api)
      if (!result.allowed) {
        return NextResponse.json(
          { error: 'Too many requests. Please try again later.' },
          {
            status: 429,
            headers: {
              'Retry-After': String(Math.ceil((result.resetAt - Date.now()) / 1000)),
            },
          }
        )
      }
    }
  }

  // --- Supabase auth session sync ---
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error(
      'Missing Supabase environment variables. Ensure NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY are set.'
    )
  }

  const cspHeader = buildCspHeader(nonce)

  let supabaseResponse = NextResponse.next({
    request: {
      headers: requestHeaders,
    },
  })
  supabaseResponse.headers.set('Content-Security-Policy', cspHeader)

  const supabase = createServerClient(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value))
          supabaseResponse = NextResponse.next({
            request: {
              headers: requestHeaders,
            },
          })
          supabaseResponse.headers.set('Content-Security-Policy', cspHeader)
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  const {
    data: { user },
  } = await supabase.auth.getUser()

  // Protected routes
  const protectedRoutes = ['/home', '/matches', '/messages', '/profile', '/onboarding']
  const isProtectedRoute = protectedRoutes.some(route =>
    pathname.startsWith(route)
  )

  if (isProtectedRoute && !user) {
    const url = request.nextUrl.clone()
    url.pathname = '/login'
    return NextResponse.redirect(url)
  }

  if (isAuthRoute && user) {
    const url = request.nextUrl.clone()
    url.pathname = '/home'
    return NextResponse.redirect(url)
  }

  return supabaseResponse
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
