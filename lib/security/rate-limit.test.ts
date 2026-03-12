import { describe, it, expect, beforeEach, vi, afterEach } from 'vitest'
import { checkRateLimit, getClientIp, RATE_LIMITS } from './rate-limit'

describe('checkRateLimit', () => {
  beforeEach(() => {
    vi.useFakeTimers()
  })

  afterEach(() => {
    vi.useRealTimers()
  })

  it('allows first request', () => {
    const result = checkRateLimit('test-first', { maxRequests: 5, windowSeconds: 60 })
    expect(result.allowed).toBe(true)
    expect(result.remaining).toBe(4)
  })

  it('decrements remaining on subsequent requests', () => {
    const config = { maxRequests: 5, windowSeconds: 60 }
    const key = 'test-decrement'

    checkRateLimit(key, config)
    const result = checkRateLimit(key, config)
    expect(result.remaining).toBe(3)
  })

  it('blocks after reaching limit', () => {
    const config = { maxRequests: 3, windowSeconds: 60 }
    const key = 'test-block'

    checkRateLimit(key, config)
    checkRateLimit(key, config)
    checkRateLimit(key, config)

    const result = checkRateLimit(key, config)
    expect(result.allowed).toBe(false)
    expect(result.remaining).toBe(0)
  })

  it('resets after window expires', () => {
    const config = { maxRequests: 2, windowSeconds: 60 }
    const key = 'test-reset'

    checkRateLimit(key, config)
    checkRateLimit(key, config)

    // Should be blocked
    expect(checkRateLimit(key, config).allowed).toBe(false)

    // Advance past the window
    vi.advanceTimersByTime(61_000)

    // Should be allowed again
    const result = checkRateLimit(key, config)
    expect(result.allowed).toBe(true)
    expect(result.remaining).toBe(1)
  })

  it('uses separate counters for different keys', () => {
    const config = { maxRequests: 2, windowSeconds: 60 }

    checkRateLimit('key-a', config)
    checkRateLimit('key-a', config)

    // key-a exhausted, but key-b should still be available
    const resultB = checkRateLimit('key-b', config)
    expect(resultB.allowed).toBe(true)
    expect(resultB.remaining).toBe(1)
  })

  it('returns resetAt timestamp', () => {
    const now = Date.now()
    vi.setSystemTime(now)

    const result = checkRateLimit('test-reset-at', { maxRequests: 5, windowSeconds: 120 })
    expect(result.resetAt).toBe(now + 120_000)
  })
})

describe('getClientIp', () => {
  const originalEnv = process.env

  beforeEach(() => {
    process.env = { ...originalEnv }
  })

  afterEach(() => {
    process.env = originalEnv
  })

  it('returns x-forwarded-for when TRUSTED_PROXY=1', () => {
    process.env.TRUSTED_PROXY = '1'
    const request = new Request('http://localhost', {
      headers: { 'x-forwarded-for': '192.168.1.1, 10.0.0.1' },
    })
    expect(getClientIp(request)).toBe('192.168.1.1')
  })

  it('returns x-real-ip when trusted proxy but no x-forwarded-for', () => {
    process.env.TRUSTED_PROXY = '1'
    const request = new Request('http://localhost', {
      headers: { 'x-real-ip': '192.168.1.1' },
    })
    expect(getClientIp(request)).toBe('192.168.1.1')
  })

  it('returns "unknown" when trusted proxy and no IP headers', () => {
    process.env.TRUSTED_PROXY = '1'
    const request = new Request('http://localhost')
    expect(getClientIp(request)).toBe('unknown')
  })

  it('ignores x-forwarded-for when not behind trusted proxy', () => {
    delete process.env.TRUSTED_PROXY
    const request = new Request('http://localhost', {
      headers: { 'x-forwarded-for': '1.2.3.4' },
    })
    // Should NOT use spoofable x-forwarded-for
    expect(getClientIp(request)).toBe('127.0.0.1')
  })

  it('uses x-real-ip when not behind trusted proxy', () => {
    delete process.env.TRUSTED_PROXY
    const request = new Request('http://localhost', {
      headers: { 'x-real-ip': '10.0.0.1' },
    })
    expect(getClientIp(request)).toBe('10.0.0.1')
  })

  it('falls back to 127.0.0.1 when not trusted and no x-real-ip', () => {
    delete process.env.TRUSTED_PROXY
    const request = new Request('http://localhost')
    expect(getClientIp(request)).toBe('127.0.0.1')
  })
})

describe('RATE_LIMITS presets', () => {
  it('has correct auth configuration', () => {
    expect(RATE_LIMITS.auth).toEqual({ maxRequests: 30, windowSeconds: 900 })
  })

  it('has correct messaging configuration', () => {
    expect(RATE_LIMITS.messaging).toEqual({ maxRequests: 30, windowSeconds: 60 })
  })

  it('has correct fileUpload configuration', () => {
    expect(RATE_LIMITS.fileUpload).toEqual({ maxRequests: 10, windowSeconds: 300 })
  })

  it('has correct api configuration', () => {
    expect(RATE_LIMITS.api).toEqual({ maxRequests: 60, windowSeconds: 60 })
  })

  it('has correct prospects configuration', () => {
    expect(RATE_LIMITS.prospects).toEqual({ maxRequests: 10, windowSeconds: 120 })
  })
})
