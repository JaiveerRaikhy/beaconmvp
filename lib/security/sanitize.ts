/**
 * Input sanitization utilities for preventing XSS and injection attacks.
 * These functions strip dangerous content from user inputs before storage/display.
 */

/**
 * Strip HTML tags and script content from a string.
 * Use for all free-text user inputs (bio, descriptions, company names, etc.)
 */
export function sanitizeText(input: string): string {
  let text = input
    // Remove null bytes that could bypass filters
    .replace(/\0/g, '')
    // Remove HTML tags (including malformed/unclosed)
    .replace(/<[^>]*>?/g, '')
    // Remove HTML entities that could encode dangerous chars
    .replace(/&#x?[0-9a-f]+;?/gi, '')
    // Remove javascript: protocol URLs (handles whitespace/newlines between chars)
    .replace(/j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:/gi, '')
    // Remove vbscript: protocol
    .replace(/v\s*b\s*s\s*c\s*r\s*i\s*p\s*t\s*:/gi, '')
    // Remove data: protocol URIs (can execute JS in some contexts)
    .replace(/data\s*:/gi, '')
    // Remove event handlers (onerror=, onclick=, etc.)
    .replace(/on\w+\s*=/gi, '')
    // Normalize whitespace (collapse multiple spaces/newlines)
    .replace(/\s+/g, (match) => {
      // Preserve single newlines for textarea content
      if (match.includes('\n')) return '\n'
      return ' '
    })
    .trim()

  // Second pass: re-check after normalization in case bypass assembled a dangerous pattern
  text = text
    .replace(/<[^>]*>?/g, '')
    .replace(/javascript\s*:/gi, '')
    .replace(/on\w+\s*=/gi, '')

  return text
}

/**
 * Strict sanitization for names (person names, school names, company names).
 * Allows letters, numbers, spaces, hyphens, apostrophes, periods, commas, ampersands.
 */
export function sanitizeName(input: string): string {
  return input
    .replace(/[^\p{L}\p{N}\s\-'.,&()]/gu, '')
    .trim()
    .slice(0, 200)
}

/**
 * Sanitize search query input to prevent SQL injection through
 * Supabase's ilike filter. Escapes SQL wildcards and special characters.
 */
export function sanitizeSearchQuery(input: string): string {
  return input
    // Remove HTML tags
    .replace(/<[^>]*>/g, '')
    // Escape SQL LIKE wildcards that the user might inject
    .replace(/[%_\\]/g, (char) => `\\${char}`)
    // Remove null bytes
    .replace(/\0/g, '')
    .trim()
    .slice(0, 100) // Limit search query length
}

/**
 * Validate and sanitize a userId to prevent path traversal.
 * UUIDs should only contain hex characters and hyphens.
 */
export function sanitizeUserId(userId: string): string {
  const sanitized = userId.replace(/[^a-f0-9-]/gi, '')
  // Validate UUID v4 format
  if (!/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(sanitized)) {
    throw new Error('Invalid user ID format')
  }
  return sanitized
}

/**
 * Validate file extension against an allowlist.
 */
export function validateFileExtension(
  filename: string,
  allowedExtensions: string[]
): boolean {
  const ext = filename.split('.').pop()?.toLowerCase()
  return ext !== undefined && allowedExtensions.includes(ext)
}

/**
 * Validate and constrain a numeric value to a range.
 */
export function sanitizeNumber(
  value: number,
  min: number,
  max: number
): number {
  if (isNaN(value)) return min
  return Math.max(min, Math.min(max, value))
}
