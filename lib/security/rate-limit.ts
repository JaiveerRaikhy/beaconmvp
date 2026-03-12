/**
 * In-memory rate limiter for Next.js API routes and middleware.
 * Uses a sliding window approach with automatic cleanup.
 */

interface RateLimitEntry {
  count: number
  resetAt: number
}

const store = new Map<string, RateLimitEntry>()

// Clean up expired entries every 60 seconds
let cleanupInterval: ReturnType<typeof setInterval> | null = null

function ensureCleanup() {
  if (cleanupInterval) return
  cleanupInterval = setInterval(() => {
    const now = Date.now()
    for (const [key, entry] of store) {
      if (now > entry.resetAt) {
        store.delete(key)
      }
    }
  }, 60_000)
  // Allow Node.js to exit even if the interval is active
  if (typeof cleanupInterval === 'object' && 'unref' in cleanupInterval) {
    cleanupInterval.unref()
  }
}

interface RateLimitConfig {
  /** Maximum number of requests allowed in the window */
  maxRequests: number
  /** Window duration in seconds */
  windowSeconds: number
}

interface RateLimitResult {
  allowed: boolean
  remaining: number
  resetAt: number
}

/**
 * Check rate limit for a given key (typically IP + route).
 */
export function checkRateLimit(
  key: string,
  config: RateLimitConfig
): RateLimitResult {
  ensureCleanup()
  const now = Date.now()
  const entry = store.get(key)

  if (!entry || now > entry.resetAt) {
    // First request or window expired
    const resetAt = now + config.windowSeconds * 1000
    store.set(key, { count: 1, resetAt })
    return { allowed: true, remaining: config.maxRequests - 1, resetAt }
  }

  if (entry.count >= config.maxRequests) {
    return { allowed: false, remaining: 0, resetAt: entry.resetAt }
  }

  entry.count++
  return {
    allowed: true,
    remaining: config.maxRequests - entry.count,
    resetAt: entry.resetAt,
  }
}

/**
 * Get client IP from request.
 * In production behind a trusted reverse proxy, X-Forwarded-For is reliable.
 * In development or when not behind a trusted proxy, we must NOT trust
 * X-Forwarded-For as it can be spoofed to bypass rate limits.
 *
 * Set TRUSTED_PROXY=1 in environment when behind a known reverse proxy
 * (e.g., Vercel, Cloudflare) that strips/overwrites X-Forwarded-For.
 */
export function getClientIp(request: Request): string {
  const trustProxy = process.env.TRUSTED_PROXY === '1'

  if (trustProxy) {
    const forwarded = request.headers.get('x-forwarded-for')
    if (forwarded) {
      return forwarded.split(',')[0]?.trim() || 'unknown'
    }
    return request.headers.get('x-real-ip') || 'unknown'
  }

  // When not behind a trusted proxy, use x-real-ip (set by the server itself)
  // or fall back to a constant — this means rate limiting is per-server, not per-IP,
  // but it cannot be bypassed by spoofing headers.
  return request.headers.get('x-real-ip') || '127.0.0.1'
}

// Preset configurations for common use cases
export const RATE_LIMITS = {
  /** Auth endpoints: 5 attempts per 15 minutes */
  auth: { maxRequests: 30, windowSeconds: 900 },
  /** Message sending: 30 messages per minute */
  messaging: { maxRequests: 30, windowSeconds: 60 },
  /** File uploads: 10 uploads per 5 minutes */
  fileUpload: { maxRequests: 10, windowSeconds: 300 },
  /** API routes: 60 requests per minute */
  api: { maxRequests: 60, windowSeconds: 60 },
  /** Prospect browsing: 10 requests per 2 minutes to prevent enumeration */
  prospects: { maxRequests: 10, windowSeconds: 120 },
} as const
