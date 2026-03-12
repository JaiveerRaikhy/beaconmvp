import { createClient } from '@/lib/supabase/server'
import { applyHardFilters } from './hard-filters'
import { calculateMatchScore, getMatchTier, MATCH_THRESHOLDS } from './scoring'
import { calculateExperienceLevel } from './experience-level'

export interface Prospect {
  id: string
  user_id: string
  full_name: string
  profile_picture_url: string | null
  location_city: string | null
  location_state: string | null
  bio: string | null
  education: Array<{
    school_name: string
    degree_type: string | null
    major: string | null
    graduation_year: number | null
    gpa: number | null
    gpa_scale: number
  }>
  experiences: Array<{
    company_name: string
    job_title: string
    is_current: boolean
  }>
  seeker_profile: {
    target_industry: string
    target_role: string
    help_types_needed: string[]
    resume_url: string | null
    is_first_gen: boolean
    is_underrepresented: boolean
    received_financial_aid: boolean
  }
  interests: string[]
  match_score: number
  match_tier: 'high' | 'good' | 'fair'
}

export async function generateProspectsForGiver(
  giverId: string,
  limit: number = 6
): Promise<Prospect[]> {
  const supabase = await createClient()

  // Get giver profile with preferences and related data
  const { data: giverProfile } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', giverId)
    .single()

  if (!giverProfile) {
    throw new Error('Giver profile not found')
  }

  const { data: giverData } = await supabase
    .from('giver_profiles')
    .select('*')
    .eq('user_id', giverId)
    .single()

  if (!giverData) {
    throw new Error('Giver preferences not found')
  }

  const { data: giverExperiences } = await supabase
    .from('experiences')
    .select('*')
    .eq('user_id', giverId)

  const { data: giverEducation } = await supabase
    .from('education')
    .select('*')
    .eq('user_id', giverId)

  const { data: giverInterestRows } = await supabase
    .from('user_interests')
    .select('interest_id, interests(name)')
    .eq('user_id', giverId)

  const giverExperienceLevel = calculateExperienceLevel(giverExperiences || [])
  const giverInterests =
    giverInterestRows?.map((r) => {
      const interest = r.interests as unknown as { name: string } | null
      return interest?.name
    }).filter((n): n is string => Boolean(n)) || []

  // Get IDs of seekers already matched/rejected by this giver
  const { data: existingMatches } = await supabase
    .from('matches')
    .select('seeker_id')
    .eq('giver_id', giverId)

  const excludedIds = new Set([
    giverId,
    ...(existingMatches?.map((m) => m.seeker_id) || []),
  ])

  // Get all seekers who completed onboarding
  const { data: seekerProfiles } = await supabase
    .from('profiles')
    .select('*')
    .eq('is_seeker', true)
    .eq('onboarding_completed', true)

  if (!seekerProfiles || seekerProfiles.length === 0) {
    return []
  }

  // Filter out already matched/rejected seekers
  const candidateProfiles = seekerProfiles.filter(
    (p) => !excludedIds.has(p.id)
  )

  if (candidateProfiles.length === 0) {
    return []
  }

  // Fetch seeker details in parallel for all candidates
  const candidateIds = candidateProfiles.map((p) => p.id)

  const [seekerDataResult, seekerExpResult, seekerEduResult, seekerIntResult] =
    await Promise.all([
      supabase
        .from('seeker_profiles')
        .select('*')
        .in('user_id', candidateIds),
      supabase
        .from('experiences')
        .select('*')
        .in('user_id', candidateIds),
      supabase
        .from('education')
        .select('*')
        .in('user_id', candidateIds),
      supabase
        .from('user_interests')
        .select('user_id, interests(name)')
        .in('user_id', candidateIds),
    ])

  // Index data by user_id for fast lookups
  const seekerDataMap = new Map(
    (seekerDataResult.data || []).map((d) => [d.user_id, d])
  )
  const seekerExpMap = new Map<string, typeof seekerExpResult.data>()
  for (const exp of seekerExpResult.data || []) {
    const existing = seekerExpMap.get(exp.user_id) || []
    existing.push(exp)
    seekerExpMap.set(exp.user_id, existing)
  }
  const seekerEduMap = new Map<string, typeof seekerEduResult.data>()
  for (const edu of seekerEduResult.data || []) {
    const existing = seekerEduMap.get(edu.user_id) || []
    existing.push(edu)
    seekerEduMap.set(edu.user_id, existing)
  }
  const seekerIntMap = new Map<string, string[]>()
  for (const row of seekerIntResult.data || []) {
    const interest = row.interests as unknown as { name: string } | null
    const name = interest?.name
    if (name) {
      const existing = seekerIntMap.get(row.user_id) || []
      existing.push(name)
      seekerIntMap.set(row.user_id, existing)
    }
  }

  // Apply hard filters and score each candidate
  const prospects: Prospect[] = []

  for (const seekerProfile of candidateProfiles) {
    const seekerData = seekerDataMap.get(seekerProfile.id)
    if (!seekerData) continue

    const seekerExperiences = seekerExpMap.get(seekerProfile.id) || []
    const seekerEducation = seekerEduMap.get(seekerProfile.id) || []
    const seekerInterests = seekerIntMap.get(seekerProfile.id) || []

    const seekerExperienceLevel = calculateExperienceLevel(seekerExperiences)

    // Apply hard filters
    const filterResult = applyHardFilters(
      {
        user_id: giverId,
        help_types_offered: giverData.help_types_offered || [],
        industries_can_advise: giverData.industries_can_advise || [],
        experience_level: giverExperienceLevel,
      },
      {
        user_id: seekerProfile.id,
        help_types_needed: seekerData.help_types_needed || [],
        target_industry: seekerData.target_industry || '',
        experience_level: seekerExperienceLevel,
      }
    )

    if (!filterResult.passes) continue

    // Calculate score
    const { score } = calculateMatchScore(
      {
        user_id: giverId,
        location_city: giverProfile.location_city,
        location_state: giverProfile.location_state,
        interests: giverInterests,
        education: (giverEducation || []).map((e) => ({
          school_name: e.school_name,
          gpa: e.gpa ? Number(e.gpa) : null,
          gpa_scale: Number(e.gpa_scale),
        })),
      },
      {
        factor_rankings: (giverData.factor_rankings as Record<string, number>) || {},
        prioritize_underrepresented: giverData.prioritize_underrepresented,
      },
      {
        user_id: seekerProfile.id,
        location_city: seekerProfile.location_city,
        location_state: seekerProfile.location_state,
        interests: seekerInterests,
        education: seekerEducation.map((e) => ({
          school_name: e.school_name,
          gpa: e.gpa ? Number(e.gpa) : null,
          gpa_scale: Number(e.gpa_scale),
        })),
      },
      {
        is_first_gen: seekerData.is_first_gen,
        is_underrepresented: seekerData.is_underrepresented,
        received_financial_aid: seekerData.received_financial_aid,
        target_industry: seekerData.target_industry || '',
      }
    )

    // Only include Fair match or better
    if (score < MATCH_THRESHOLDS.MIN_VISIBLE) continue

    prospects.push({
      id: seekerProfile.id,
      user_id: seekerProfile.id,
      full_name: seekerProfile.full_name || 'Anonymous',
      profile_picture_url: seekerProfile.profile_picture_url,
      location_city: seekerProfile.location_city,
      location_state: seekerProfile.location_state,
      bio: seekerProfile.bio,
      education: seekerEducation.map((e) => ({
        school_name: e.school_name,
        degree_type: e.degree_type,
        major: e.major,
        graduation_year: e.graduation_year,
        gpa: e.gpa ? Number(e.gpa) : null,
        gpa_scale: Number(e.gpa_scale),
      })),
      experiences: seekerExperiences.map((e) => ({
        company_name: e.company_name,
        job_title: e.job_title,
        is_current: e.is_current,
      })),
      seeker_profile: {
        target_industry: seekerData.target_industry || '',
        target_role: seekerData.target_role || '',
        help_types_needed: seekerData.help_types_needed || [],
        resume_url: seekerData.resume_url,
        is_first_gen: seekerData.is_first_gen,
        is_underrepresented: seekerData.is_underrepresented,
        received_financial_aid: seekerData.received_financial_aid,
      },
      interests: seekerInterests,
      match_score: score,
      match_tier: getMatchTier(score),
    })
  }

  // Sort by score descending, take top N
  return prospects.sort((a, b) => b.match_score - a.match_score).slice(0, limit)
}
