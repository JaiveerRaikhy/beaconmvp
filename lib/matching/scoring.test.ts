import { describe, it, expect } from 'vitest'
import { calculateMatchScore, getMatchTier, MATCH_THRESHOLDS } from './scoring'

// Helper to create a base profile
function makeProfile(overrides: Record<string, unknown> = {}) {
  return {
    user_id: 'giver-1',
    location_city: null as string | null,
    location_state: null as string | null,
    interests: [] as string[],
    education: [] as Array<{ school_name: string; gpa: number | null; gpa_scale: number }>,
    ...overrides,
  }
}

function makeGiverPrefs(overrides: Record<string, unknown> = {}) {
  return {
    factor_rankings: {} as Record<string, number>,
    prioritize_underrepresented: false,
    ...overrides,
  }
}

function makeSeekerData(overrides: Record<string, unknown> = {}) {
  return {
    is_first_gen: false,
    is_underrepresented: false,
    received_financial_aid: false,
    target_industry: 'Technology',
    weeks_without_match: 0,
    ...overrides,
  }
}

describe('calculateMatchScore', () => {
  describe('location scoring', () => {
    it('awards 15 points for same city', () => {
      const giver = makeProfile({ location_city: 'New York', location_state: 'NY' })
      const seeker = makeProfile({ user_id: 'seeker-1', location_city: 'New York', location_state: 'NY' })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.location).toBe(15)
    })

    it('awards 8 points for same state, different city', () => {
      const giver = makeProfile({ location_city: 'Buffalo', location_state: 'NY' })
      const seeker = makeProfile({ user_id: 'seeker-1', location_city: 'Albany', location_state: 'NY' })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.location).toBe(8)
    })

    it('awards 0 points for different state', () => {
      const giver = makeProfile({ location_city: 'New York', location_state: 'NY' })
      const seeker = makeProfile({ user_id: 'seeker-1', location_city: 'Los Angeles', location_state: 'CA' })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.location).toBe(0)
    })

    it('is case-insensitive for location comparison', () => {
      const giver = makeProfile({ location_city: 'new york', location_state: 'ny' })
      const seeker = makeProfile({ user_id: 'seeker-1', location_city: 'New York', location_state: 'NY' })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.location).toBe(15)
    })

    it('awards 0 when either location is null', () => {
      const giver = makeProfile({ location_city: null })
      const seeker = makeProfile({ user_id: 'seeker-1', location_city: 'New York' })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.location).toBe(0)
    })
  })

  describe('shared university scoring', () => {
    it('awards 15 points for shared school', () => {
      const giver = makeProfile({
        education: [{ school_name: 'MIT', gpa: null, gpa_scale: 4 }],
      })
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'MIT', gpa: 3.8, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedUniversity).toBe(15)
    })

    it('awards 0 points for different schools', () => {
      const giver = makeProfile({
        education: [{ school_name: 'Stanford', gpa: null, gpa_scale: 4 }],
      })
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'Yale', gpa: 3.5, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedUniversity).toBe(0)
    })

    it('handles substring matching for school names', () => {
      const giver = makeProfile({
        education: [{ school_name: 'University of Michigan', gpa: null, gpa_scale: 4 }],
      })
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'michigan', gpa: 3.0, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedUniversity).toBe(15)
    })
  })

  describe('university prestige scoring', () => {
    it('awards 10 points for top-20 school', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'Harvard University', gpa: 3.9, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.universityPrestige).toBe(10)
    })

    it('awards 7 points for top-50 school', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'NYU', gpa: 3.5, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.universityPrestige).toBe(7)
    })

    it('awards 4 points for other schools', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'State University', gpa: 3.0, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.universityPrestige).toBe(4)
    })

    it('uses highest prestige when seeker has multiple schools', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [
          { school_name: 'State University', gpa: 3.0, gpa_scale: 4 },
          { school_name: 'Stanford', gpa: 3.8, gpa_scale: 4 },
        ],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.universityPrestige).toBe(10)
    })
  })

  describe('GPA scoring', () => {
    it('awards proportional points based on GPA', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'Test U', gpa: 4.0, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.gpa).toBe(10) // 4.0/4.0 * 10 = 10
    })

    it('normalizes GPA to 4.0 scale', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'Test U', gpa: 5.0, gpa_scale: 5 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.gpa).toBe(10) // 5.0/5.0 * 4.0 / 4.0 * 10 = 10
    })

    it('awards 0 for null GPA', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        education: [{ school_name: 'Test U', gpa: null, gpa_scale: 4 }],
      })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.gpa).toBe(0)
    })
  })

  describe('industry alignment', () => {
    it('always awards 20 points (assumed to pass hard filter)', () => {
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), makeSeekerData())
      expect(components.industryAlignment).toBe(20)
    })
  })

  describe('shared interests scoring', () => {
    it('awards 3 points per shared interest up to 15', () => {
      const giver = makeProfile({ interests: ['hiking', 'reading', 'coding'] })
      const seeker = makeProfile({ user_id: 'seeker-1', interests: ['hiking', 'reading'] })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedInterests).toBe(6) // 2 * 3 = 6
    })

    it('caps at 15 points with many shared interests', () => {
      const interests = ['a', 'b', 'c', 'd', 'e', 'f']
      const giver = makeProfile({ interests })
      const seeker = makeProfile({ user_id: 'seeker-1', interests })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedInterests).toBe(15)
    })

    it('is case-insensitive', () => {
      const giver = makeProfile({ interests: ['Hiking'] })
      const seeker = makeProfile({ user_id: 'seeker-1', interests: ['hiking'] })
      const { components } = calculateMatchScore(giver, makeGiverPrefs(), seeker, makeSeekerData())
      expect(components.sharedInterests).toBe(3)
    })
  })

  describe('underrepresented boost', () => {
    it('awards 10 points when giver opts in and seeker qualifies', () => {
      const giverPrefs = makeGiverPrefs({ prioritize_underrepresented: true })
      const seekerData = makeSeekerData({ is_first_gen: true })
      const { components } = calculateMatchScore(makeProfile(), giverPrefs, makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.underrepBoost).toBe(10)
    })

    it('awards 0 when giver does not opt in', () => {
      const seekerData = makeSeekerData({ is_first_gen: true })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.underrepBoost).toBe(0)
    })

    it('awards 0 when seeker does not qualify', () => {
      const giverPrefs = makeGiverPrefs({ prioritize_underrepresented: true })
      const { components } = calculateMatchScore(makeProfile(), giverPrefs, makeProfile({ user_id: 'seeker-1' }), makeSeekerData())
      expect(components.underrepBoost).toBe(0)
    })

    it('qualifies for is_underrepresented flag', () => {
      const giverPrefs = makeGiverPrefs({ prioritize_underrepresented: true })
      const seekerData = makeSeekerData({ is_underrepresented: true })
      const { components } = calculateMatchScore(makeProfile(), giverPrefs, makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.underrepBoost).toBe(10)
    })

    it('qualifies for received_financial_aid flag', () => {
      const giverPrefs = makeGiverPrefs({ prioritize_underrepresented: true })
      const seekerData = makeSeekerData({ received_financial_aid: true })
      const { components } = calculateMatchScore(makeProfile(), giverPrefs, makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.underrepBoost).toBe(10)
    })
  })

  describe('exposure boost', () => {
    it('awards 10 points for 2 weeks without match', () => {
      const seekerData = makeSeekerData({ weeks_without_match: 2 })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.exposureBoost).toBe(10)
    })

    it('awards 15 points for 3+ weeks without match', () => {
      const seekerData = makeSeekerData({ weeks_without_match: 3 })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.exposureBoost).toBe(15)
    })

    it('awards 0 for less than 2 weeks without match', () => {
      const seekerData = makeSeekerData({ weeks_without_match: 1 })
      const { components } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), seekerData)
      expect(components.exposureBoost).toBe(0)
    })
  })

  describe('factor rankings weighting', () => {
    it('applies higher weight to rank 1 factors', () => {
      const seeker = makeProfile({
        user_id: 'seeker-1',
        location_city: 'New York',
        location_state: 'NY',
        education: [{ school_name: 'Test U', gpa: null, gpa_scale: 4 }],
      })
      const giver = makeProfile({ location_city: 'New York', location_state: 'NY' })

      // Location ranked #1 (weight 1.5x)
      const prefsHighLocation = makeGiverPrefs({ factor_rankings: { location: 1 } })
      const { score: scoreHigh } = calculateMatchScore(giver, prefsHighLocation, seeker, makeSeekerData())

      // Location ranked #6 (weight 0.75x)
      const prefsLowLocation = makeGiverPrefs({ factor_rankings: { location: 6 } })
      const { score: scoreLow } = calculateMatchScore(giver, prefsLowLocation, seeker, makeSeekerData())

      expect(scoreHigh).toBeGreaterThan(scoreLow)
    })
  })

  describe('score capping', () => {
    it('caps final score at 100', () => {
      const giver = makeProfile({
        location_city: 'New York',
        location_state: 'NY',
        interests: ['a', 'b', 'c', 'd', 'e', 'f'],
        education: [{ school_name: 'Harvard', gpa: null, gpa_scale: 4 }],
      })
      const seeker = makeProfile({
        user_id: 'seeker-1',
        location_city: 'New York',
        location_state: 'NY',
        interests: ['a', 'b', 'c', 'd', 'e', 'f'],
        education: [{ school_name: 'Harvard', gpa: 4.0, gpa_scale: 4 }],
      })
      const giverPrefs = makeGiverPrefs({ prioritize_underrepresented: true })
      const seekerData = makeSeekerData({
        is_first_gen: true,
        weeks_without_match: 5,
      })
      const { score } = calculateMatchScore(giver, giverPrefs, seeker, seekerData)
      expect(score).toBeLessThanOrEqual(100)
    })

    it('returns an integer score', () => {
      const { score } = calculateMatchScore(makeProfile(), makeGiverPrefs(), makeProfile({ user_id: 'seeker-1' }), makeSeekerData())
      expect(Number.isInteger(score)).toBe(true)
    })
  })
})

describe('getMatchTier', () => {
  it('returns "high" for scores >= 80', () => {
    expect(getMatchTier(80)).toBe('high')
    expect(getMatchTier(95)).toBe('high')
    expect(getMatchTier(100)).toBe('high')
  })

  it('returns "good" for scores >= 60 and < 80', () => {
    expect(getMatchTier(60)).toBe('good')
    expect(getMatchTier(75)).toBe('good')
    expect(getMatchTier(79)).toBe('good')
  })

  it('returns "fair" for scores < 60', () => {
    expect(getMatchTier(0)).toBe('fair')
    expect(getMatchTier(40)).toBe('fair')
    expect(getMatchTier(59)).toBe('fair')
  })
})

describe('MATCH_THRESHOLDS', () => {
  it('has correct threshold values', () => {
    expect(MATCH_THRESHOLDS.HIGH).toBe(80)
    expect(MATCH_THRESHOLDS.GOOD).toBe(60)
    expect(MATCH_THRESHOLDS.MIN_VISIBLE).toBe(40)
    expect(MATCH_THRESHOLDS.MAX_BASE).toBe(85)
    expect(MATCH_THRESHOLDS.MAX_SCORE).toBe(100)
  })
})
