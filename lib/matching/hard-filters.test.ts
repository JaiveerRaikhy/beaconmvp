import { describe, it, expect } from 'vitest'
import { applyHardFilters, filterSeekers } from './hard-filters'

function makeGiver(overrides: Record<string, unknown> = {}) {
  return {
    user_id: 'giver-1',
    help_types_offered: ['resume-review', 'mock-interview'],
    industries_can_advise: ['Technology'],
    experience_level: 3,
    ...overrides,
  }
}

function makeSeeker(overrides: Record<string, unknown> = {}) {
  return {
    user_id: 'seeker-1',
    help_types_needed: ['resume-review'],
    target_industry: 'Technology',
    experience_level: 1,
    ...overrides,
  }
}

describe('applyHardFilters', () => {
  it('passes when all criteria are met', () => {
    const result = applyHardFilters(makeGiver(), makeSeeker())
    expect(result.passes).toBe(true)
    expect(result.reason).toBeUndefined()
  })

  describe('same user filter', () => {
    it('rejects self-matching', () => {
      const result = applyHardFilters(
        makeGiver({ user_id: 'same-user' }),
        makeSeeker({ user_id: 'same-user' })
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('same_user')
    })
  })

  describe('help type filter', () => {
    it('passes when at least one help type overlaps', () => {
      const result = applyHardFilters(
        makeGiver({ help_types_offered: ['resume-review', 'mock-interview'] }),
        makeSeeker({ help_types_needed: ['mock-interview', 'career-strategy'] })
      )
      expect(result.passes).toBe(true)
    })

    it('rejects when no help types overlap', () => {
      const result = applyHardFilters(
        makeGiver({ help_types_offered: ['resume-review'] }),
        makeSeeker({ help_types_needed: ['salary-negotiation'] })
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('no_help_type_match')
    })

    it('rejects when giver has empty help types', () => {
      const result = applyHardFilters(
        makeGiver({ help_types_offered: [] }),
        makeSeeker()
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('no_help_type_match')
    })
  })

  describe('industry filter', () => {
    it('passes with matching industry', () => {
      const result = applyHardFilters(
        makeGiver({ industries_can_advise: ['Technology', 'Finance'] }),
        makeSeeker({ target_industry: 'Finance' })
      )
      expect(result.passes).toBe(true)
    })

    it('is case-insensitive', () => {
      const result = applyHardFilters(
        makeGiver({ industries_can_advise: ['technology'] }),
        makeSeeker({ target_industry: 'Technology' })
      )
      expect(result.passes).toBe(true)
    })

    it('rejects when industry does not match', () => {
      const result = applyHardFilters(
        makeGiver({ industries_can_advise: ['Healthcare'] }),
        makeSeeker({ target_industry: 'Technology' })
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('no_industry_match')
    })
  })

  describe('experience gap filter', () => {
    it('passes when giver has higher experience level', () => {
      const result = applyHardFilters(
        makeGiver({ experience_level: 3 }),
        makeSeeker({ experience_level: 1 })
      )
      expect(result.passes).toBe(true)
    })

    it('rejects when giver has equal experience level', () => {
      const result = applyHardFilters(
        makeGiver({ experience_level: 2 }),
        makeSeeker({ experience_level: 2 })
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('insufficient_experience_gap')
    })

    it('rejects when giver has lower experience level', () => {
      const result = applyHardFilters(
        makeGiver({ experience_level: 1 }),
        makeSeeker({ experience_level: 3 })
      )
      expect(result.passes).toBe(false)
      expect(result.reason).toBe('insufficient_experience_gap')
    })
  })

  describe('filter priority', () => {
    it('checks same_user before other filters', () => {
      const result = applyHardFilters(
        makeGiver({ user_id: 'same', help_types_offered: [], experience_level: 0 }),
        makeSeeker({ user_id: 'same' })
      )
      expect(result.reason).toBe('same_user')
    })
  })
})

describe('filterSeekers', () => {
  it('returns only seekers that pass all filters', () => {
    const giver = makeGiver()
    const seekers = [
      makeSeeker({ user_id: 'seeker-1' }),
      makeSeeker({ user_id: 'seeker-2', target_industry: 'Healthcare' }), // fails industry
      makeSeeker({ user_id: 'seeker-3' }),
    ]
    const result = filterSeekers(giver, seekers)
    expect(result).toHaveLength(2)
    expect(result.map((s) => s.user_id)).toEqual(['seeker-1', 'seeker-3'])
  })

  it('returns empty array when no seekers pass', () => {
    const giver = makeGiver({ help_types_offered: ['nonexistent-type'] })
    const seekers = [
      makeSeeker({ user_id: 'seeker-1' }),
      makeSeeker({ user_id: 'seeker-2' }),
    ]
    const result = filterSeekers(giver, seekers)
    expect(result).toHaveLength(0)
  })

  it('returns empty array for empty seeker list', () => {
    const result = filterSeekers(makeGiver(), [])
    expect(result).toHaveLength(0)
  })
})
