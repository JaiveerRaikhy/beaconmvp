import { meetsExperienceRequirement } from './experience-level'

interface GiverProfile {
  user_id: string
  help_types_offered: string[]
  industries_can_advise: string[]
  experience_level: number
}

interface SeekerProfile {
  user_id: string
  help_types_needed: string[]
  target_industry: string
  experience_level: number
}

interface FilterResult {
  passes: boolean
  reason?: string
}

/**
 * Hard Filters (from PRD v3.0):
 * 1. Help Type + Industry must align
 * 2. Giver Experience Level > Seeker Experience Level
 */
export function applyHardFilters(
  giver: GiverProfile,
  seeker: SeekerProfile
): FilterResult {
  // Can't match with yourself
  if (giver.user_id === seeker.user_id) {
    return { passes: false, reason: 'same_user' }
  }

  // Check help type overlap
  const helpTypeMatch = giver.help_types_offered.some((type) =>
    seeker.help_types_needed.includes(type)
  )
  if (!helpTypeMatch) {
    return { passes: false, reason: 'no_help_type_match' }
  }

  // Check industry alignment (relaxed for MVP - any industry overlap OR giver advises in seeker's target)
  const industryMatch = giver.industries_can_advise.length === 0 || 
    giver.industries_can_advise.some(
      (industry) =>
        industry.toLowerCase() === seeker.target_industry?.toLowerCase()
    )
  if (!industryMatch) {
    return { passes: false, reason: 'no_industry_match' }
  }

  // Check experience gap (relaxed for MVP - skip if giver has 0 experience logged)
  if (
    giver.experience_level > 0 &&
    !meetsExperienceRequirement(giver.experience_level, seeker.experience_level)
  ) {
    return { passes: false, reason: 'insufficient_experience_gap' }
  }

  return { passes: true }
}

export function filterSeekers(
  giver: GiverProfile,
  seekers: SeekerProfile[]
): SeekerProfile[] {
  return seekers.filter((seeker) => applyHardFilters(giver, seeker).passes)
}
