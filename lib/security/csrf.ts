import { cookies } from 'next/headers'

const CSRF_COOKIE_NAME = 'beacon-csrf-token'
const CSRF_HEADER_NAME = 'x-csrf-token'

/**
 * Generate a cryptographically random CSRF token.
 */
function generateToken(): string {
  const array = new Uint8Array(32)
  crypto.getRandomValues(array)
  return Array.from(array, (b) => b.toString(16).padStart(2, '0')).join('')
}

/**
 * Get or create a CSRF token, stored in an HttpOnly cookie.
 * Call this in server components/actions that render forms.
 */
export async function getCsrfToken(): Promise<string> {
  const cookieStore = await cookies()
  const existing = cookieStore.get(CSRF_COOKIE_NAME)

  if (existing?.value) {
    return existing.value
  }

  const token = generateToken()
  cookieStore.set(CSRF_COOKIE_NAME, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    path: '/',
    maxAge: 60 * 60, // 1 hour
  })

  return token
}

/**
 * Validate a CSRF token from request headers against the cookie.
 * Use in server actions and API routes.
 */
export async function validateCsrfToken(request: Request): Promise<boolean> {
  const cookieStore = await cookies()
  const cookieToken = cookieStore.get(CSRF_COOKIE_NAME)?.value
  const headerToken = request.headers.get(CSRF_HEADER_NAME)

  if (!cookieToken || !headerToken) {
    return false
  }

  // Constant-time comparison to prevent timing attacks
  if (cookieToken.length !== headerToken.length) {
    return false
  }

  const encoder = new TextEncoder()
  const a = encoder.encode(cookieToken)
  const b = encoder.encode(headerToken)

  if (a.byteLength !== b.byteLength) {
    return false
  }

  // Use XOR-based comparison for constant time
  let result = 0
  for (let i = 0; i < a.byteLength; i++) {
    result |= a[i]! ^ b[i]!
  }

  return result === 0
}
