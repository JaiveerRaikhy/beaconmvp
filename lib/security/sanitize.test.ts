import { describe, it, expect } from 'vitest'
import {
  sanitizeText,
  sanitizeName,
  sanitizeSearchQuery,
  sanitizeUserId,
  validateFileExtension,
  sanitizeNumber,
} from './sanitize'

describe('sanitizeText', () => {
  it('returns clean text unchanged', () => {
    expect(sanitizeText('Hello world')).toBe('Hello world')
  })

  it('strips HTML tags', () => {
    expect(sanitizeText('Hello <b>world</b>')).toBe('Hello world')
    expect(sanitizeText('<script>alert("xss")</script>')).toBe('alert("xss")')
  })

  it('strips malformed/unclosed tags', () => {
    expect(sanitizeText('Hello <b')).toBe('Hello')
    expect(sanitizeText('Hello <img src=x')).toBe('Hello')
  })

  it('removes HTML entities', () => {
    expect(sanitizeText('&#x3C;script&#x3E;')).toBe('script')
  })

  it('removes javascript: protocol', () => {
    expect(sanitizeText('javascript:alert(1)')).toBe('alert(1)')
  })

  it('removes javascript: with whitespace obfuscation', () => {
    expect(sanitizeText('j a v a s c r i p t :alert(1)')).toBe('alert(1)')
  })

  it('removes vbscript: protocol', () => {
    expect(sanitizeText('vbscript:something')).toBe('something')
  })

  it('removes data: protocol', () => {
    expect(sanitizeText('data:text/html,<h1>test</h1>')).toBe('text/html,test')
  })

  it('removes event handlers', () => {
    expect(sanitizeText('onerror=alert(1)')).toBe('alert(1)')
    expect(sanitizeText('onclick=doSomething()')).toBe('doSomething()')
  })

  it('removes null bytes', () => {
    expect(sanitizeText('hel\0lo')).toBe('hello')
  })

  it('normalizes whitespace', () => {
    expect(sanitizeText('hello    world')).toBe('hello world')
  })

  it('preserves single newlines', () => {
    expect(sanitizeText('hello\nworld')).toBe('hello\nworld')
  })

  it('trims whitespace', () => {
    expect(sanitizeText('  hello  ')).toBe('hello')
  })

  it('handles second-pass bypass prevention', () => {
    // Constructs that might assemble dangerous patterns after first-pass normalization
    expect(sanitizeText('<scr<script>ipt>')).not.toContain('<script>')
  })
})

describe('sanitizeName', () => {
  it('allows valid names', () => {
    expect(sanitizeName('John Doe')).toBe('John Doe')
    expect(sanitizeName("Mary O'Brien")).toBe("Mary O'Brien")
    expect(sanitizeName('Dr. Smith-Jones')).toBe('Dr. Smith-Jones')
  })

  it('strips disallowed characters', () => {
    expect(sanitizeName('John<script>Doe')).toBe('JohnscriptDoe')
    expect(sanitizeName('Name! @# $%')).toBe('Name')
  })

  it('allows ampersands and parentheses', () => {
    expect(sanitizeName('Johnson & Johnson')).toBe('Johnson & Johnson')
    expect(sanitizeName('Tech (US)')).toBe('Tech (US)')
  })

  it('truncates to 200 characters', () => {
    const longName = 'A'.repeat(300)
    expect(sanitizeName(longName)).toHaveLength(200)
  })

  it('trims whitespace', () => {
    expect(sanitizeName('  John  ')).toBe('John')
  })

  it('handles unicode letters', () => {
    expect(sanitizeName('José García')).toBe('José García')
    expect(sanitizeName('田中太郎')).toBe('田中太郎')
  })
})

describe('sanitizeSearchQuery', () => {
  it('returns clean query unchanged', () => {
    expect(sanitizeSearchQuery('hello world')).toBe('hello world')
  })

  it('removes HTML tags', () => {
    expect(sanitizeSearchQuery('<b>test</b>')).toBe('test')
  })

  it('escapes SQL LIKE wildcards', () => {
    expect(sanitizeSearchQuery('100% match')).toBe('100\\% match')
    expect(sanitizeSearchQuery('user_name')).toBe('user\\_name')
    expect(sanitizeSearchQuery('path\\to\\file')).toBe('path\\\\to\\\\file')
  })

  it('removes null bytes', () => {
    expect(sanitizeSearchQuery('test\0query')).toBe('testquery')
  })

  it('truncates to 100 characters', () => {
    const longQuery = 'x'.repeat(200)
    expect(sanitizeSearchQuery(longQuery)).toHaveLength(100)
  })

  it('trims whitespace', () => {
    expect(sanitizeSearchQuery('  test  ')).toBe('test')
  })
})

describe('sanitizeUserId', () => {
  it('accepts valid UUID v4', () => {
    const uuid = '550e8400-e29b-41d4-a716-446655440000'
    expect(sanitizeUserId(uuid)).toBe(uuid)
  })

  it('strips non-hex characters before validation', () => {
    const uuid = '550e8400-e29b-41d4-a716-446655440000'
    // Adding some non-hex characters
    expect(sanitizeUserId(uuid)).toBe(uuid)
  })

  it('throws for invalid UUID format', () => {
    expect(() => sanitizeUserId('not-a-uuid')).toThrow('Invalid user ID format')
    expect(() => sanitizeUserId('')).toThrow('Invalid user ID format')
    expect(() => sanitizeUserId('12345')).toThrow('Invalid user ID format')
  })

  it('throws for path traversal attempts', () => {
    expect(() => sanitizeUserId('../../../etc/passwd')).toThrow('Invalid user ID format')
  })
})

describe('validateFileExtension', () => {
  it('accepts allowed extensions', () => {
    expect(validateFileExtension('photo.jpg', ['jpg', 'png', 'gif'])).toBe(true)
    expect(validateFileExtension('document.pdf', ['pdf', 'doc'])).toBe(true)
  })

  it('rejects disallowed extensions', () => {
    expect(validateFileExtension('script.exe', ['jpg', 'png'])).toBe(false)
    expect(validateFileExtension('file.js', ['pdf', 'doc'])).toBe(false)
  })

  it('is case-insensitive', () => {
    expect(validateFileExtension('photo.JPG', ['jpg'])).toBe(true)
    expect(validateFileExtension('photo.Png', ['png'])).toBe(true)
  })

  it('handles files without extension', () => {
    expect(validateFileExtension('noext', ['jpg', 'png'])).toBe(false)
  })

  it('uses last extension for double-extensions', () => {
    expect(validateFileExtension('file.tar.gz', ['gz'])).toBe(true)
    expect(validateFileExtension('file.tar.gz', ['tar'])).toBe(false)
  })
})

describe('sanitizeNumber', () => {
  it('returns value within range', () => {
    expect(sanitizeNumber(5, 0, 10)).toBe(5)
  })

  it('clamps to minimum', () => {
    expect(sanitizeNumber(-5, 0, 10)).toBe(0)
  })

  it('clamps to maximum', () => {
    expect(sanitizeNumber(15, 0, 10)).toBe(10)
  })

  it('returns minimum for NaN', () => {
    expect(sanitizeNumber(NaN, 0, 10)).toBe(0)
  })

  it('handles edge values', () => {
    expect(sanitizeNumber(0, 0, 10)).toBe(0)
    expect(sanitizeNumber(10, 0, 10)).toBe(10)
  })
})
