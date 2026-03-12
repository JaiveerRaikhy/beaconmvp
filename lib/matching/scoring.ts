/** Score thresholds for match tiers */
export const MATCH_THRESHOLDS = {
  HIGH: 80,
  GOOD: 60,
  /** Minimum score to include in prospect results */
  MIN_VISIBLE: 40,
  /** Maximum base score before boosts are applied */
  MAX_BASE: 85,
  MAX_SCORE: 100,
} as const

/** Number of match score weight ranks and their scale */
const WEIGHT_SCALE = { MAX: 1.5, STEP: 0.15, DEFAULT_RANK: 3 } as const

interface Profile {
  user_id: string
  location_city: string | null
  location_state: string | null
  interests: string[]
  education: Array<{
    school_name: string
    gpa: number | null
    gpa_scale: number
  }>
}

interface GiverPreferences {
  factor_rankings: Record<string, number>
  prioritize_underrepresented: boolean
}

interface SeekerData {
  is_first_gen: boolean
  is_underrepresented: boolean
  received_financial_aid: boolean
  target_industry: string
  weeks_without_match?: number
}

interface ScoreComponents {
  location: number
  sharedUniversity: number
  universityPrestige: number
  gpa: number
  industryAlignment: number
  sharedInterests: number
  underrepBoost: number
  exposureBoost: number
}

const TOP_20_SCHOOLS = [
  'harvard',
  'stanford',
  'mit',
  'yale',
  'princeton',
  'columbia',
  'university of chicago',
  'duke',
  'northwestern',
  'caltech',
  'johns hopkins',
  'dartmouth',
  'brown',
  'cornell',
  'rice',
  'vanderbilt',
  'notre dame',
  'ucla',
  'uc berkeley',
  'georgetown',
]

const TOP_50_SCHOOLS = [
  'nyu',
  'usc',
  'michigan',
  'unc',
  'virginia',
  'wake forest',
  'tufts',
  'boston college',
  'william and mary',
  'georgia tech',
  'carnegie mellon',
  'emory',
  'uchicago',
  'washington university',
  'boston university',
]

function getPrestigeTier(schoolName: string): number {
  const normalized = schoolName.toLowerCase()
  if (TOP_20_SCHOOLS.some((s) => normalized.includes(s))) return 1.0
  if (TOP_50_SCHOOLS.some((s) => normalized.includes(s))) return 0.7
  return 0.4
}

function normalizeGpa(gpa: number | null, scale: number): number {
  if (!gpa) return 0
  return (gpa / scale) * 4.0
}

/**
 * Calculate match score (0-100) using algorithm only (no LLM).
 *
 * Scoring dimensions and max points:
 *   - Location:           15 pts (same city=15, same state=8)
 *   - Shared University:  15 pts (any overlapping school)
 *   - University Prestige:10 pts (top-20=10, top-50=7, other=4)
 *   - GPA:                10 pts (normalized to 4.0 scale)
 *   - Industry Alignment: 20 pts (guaranteed by hard filter)
 *   - Shared Interests:   15 pts (3 pts per overlap, max 15)
 *   - Underrep Boost:    +10 pts (if giver opts in & seeker qualifies)
 *   - Exposure Boost:    +10-15 pts (seekers waiting 2-3+ weeks)
 *
 * Factor rankings from giver preferences weight each dimension
 * (rank 1 = 1.5x weight, rank 6 = 0.75x weight).
 *
 * Base score is capped at 85 before boosts, final score capped at 100.
 */
export function calculateMatchScore(
  giver: Profile,
  giverPrefs: GiverPreferences,
  seeker: Profile,
  seekerData: SeekerData
): { score: number; components: ScoreComponents } {
  const components: ScoreComponents = {
    location: 0,
    sharedUniversity: 0,
    universityPrestige: 0,
    gpa: 0,
    industryAlignment: 0,
    sharedInterests: 0,
    underrepBoost: 0,
    exposureBoost: 0,
  }

  // 1. Location scoring (max 15 points)
  if (giver.location_city && seeker.location_city) {
    if (
      giver.location_city.toLowerCase() === seeker.location_city.toLowerCase()
    ) {
      components.location = 15
    } else if (
      giver.location_state &&
      seeker.location_state &&
      giver.location_state.toLowerCase() ===
        seeker.location_state.toLowerCase()
    ) {
      components.location = 8
    }
  }

  // 2. Shared University (max 15 points)
  if (giver.education.length > 0 && seeker.education.length > 0) {
    const giverSchools = giver.education.map((e) =>
      e.school_name.toLowerCase()
    )
    const seekerSchools = seeker.education.map((e) =>
      e.school_name.toLowerCase()
    )
    const sharedSchool = giverSchools.some((gs) =>
      seekerSchools.some((ss) => gs.includes(ss) || ss.includes(gs))
    )
    if (sharedSchool) {
      components.sharedUniversity = 15
    }
  }

  // 3. University Prestige (max 10 points)
  if (seeker.education.length > 0) {
    const seekerBestPrestige = Math.max(
      ...seeker.education.map((e) => getPrestigeTier(e.school_name))
    )
    components.universityPrestige = seekerBestPrestige * 10
  }

  // 4. GPA (max 10 points)
  const seekerGpas = seeker.education
    .filter((e) => e.gpa)
    .map((e) => normalizeGpa(e.gpa, e.gpa_scale))
  if (seekerGpas.length > 0) {
    const avgGpa = seekerGpas.reduce((a, b) => a + b, 0) / seekerGpas.length
    components.gpa = (avgGpa / 4.0) * 10
  }

  // 5. Industry Alignment (max 20 points) — already passed hard filter
  components.industryAlignment = 20

  // 6. Shared Interests (max 15 points)
  const giverInterests = new Set(giver.interests.map((i) => i.toLowerCase()))
  const sharedCount = seeker.interests.filter((i) =>
    giverInterests.has(i.toLowerCase())
  ).length
  components.sharedInterests = Math.min(sharedCount * 3, 15)

  // 7. Underrepresented boost (+10 if applicable)
  if (giverPrefs.prioritize_underrepresented) {
    if (
      seekerData.is_first_gen ||
      seekerData.is_underrepresented ||
      seekerData.received_financial_aid
    ) {
      components.underrepBoost = 10
    }
  }

  // 8. Exposure boost (+10-15 for underexposed seekers)
  if (seekerData.weeks_without_match && seekerData.weeks_without_match >= 2) {
    components.exposureBoost = seekerData.weeks_without_match >= 3 ? 15 : 10
  }

  // Apply factor rankings as weights
  const rankings = giverPrefs.factor_rankings || {}
  const factorMap: Record<string, keyof ScoreComponents> = {
    location: 'location',
    university: 'sharedUniversity',
    prestige: 'universityPrestige',
    gpa: 'gpa',
    industry: 'industryAlignment',
    interests: 'sharedInterests',
  }

  // Weighted: rank 1 = 1.5x, rank 6 = 0.75x
  let weightedScore = 0
  for (const [factor, componentKey] of Object.entries(factorMap)) {
    const rank = rankings[factor] || WEIGHT_SCALE.DEFAULT_RANK
    const weight = WEIGHT_SCALE.MAX - (rank - 1) * WEIGHT_SCALE.STEP
    weightedScore += components[componentKey] * weight
  }

  // Normalize to 0-100 and add boosts
  const normalizedScore = Math.min(weightedScore / WEIGHT_SCALE.MAX, MATCH_THRESHOLDS.MAX_BASE)
  const finalScore =
    normalizedScore + components.underrepBoost + components.exposureBoost

  return {
    score: Math.min(Math.round(finalScore), MATCH_THRESHOLDS.MAX_SCORE),
    components,
  }
}

export function getMatchTier(score: number): 'high' | 'good' | 'fair' {
  if (score >= MATCH_THRESHOLDS.HIGH) return 'high'
  if (score >= MATCH_THRESHOLDS.GOOD) return 'good'
  return 'fair'
}
