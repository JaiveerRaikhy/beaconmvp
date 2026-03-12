'use client'

import { useState } from 'react'
import { useOnboarding } from '@/hooks/use-onboarding'
import { Button } from '@/components/ui/button'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { sanitizeText, sanitizeName } from '@/lib/security/sanitize'
import { toast } from 'sonner'
import { Loader2 } from 'lucide-react'

interface NavigationButtonsProps {
  isFirstStep: boolean
  isLastStep: boolean
  canContinue?: boolean
  onBeforeNext?: () => boolean
}

export function NavigationButtons({
  isFirstStep,
  isLastStep,
  canContinue = true,
  onBeforeNext,
}: NavigationButtonsProps) {
  const { nextStep, prevStep } = useOnboarding()
  const router = useRouter()
  const [saving, setSaving] = useState(false)

  const handleNext = () => {
    if (onBeforeNext && !onBeforeNext()) return
    nextStep()
  }

  const handleComplete = async () => {
    setSaving(true)
    try {
      const state = useOnboarding.getState()
      const supabase = createClient()

      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      // Update profile (sanitize all text inputs before saving)
      await supabase.from('profiles').update({
        profile_picture_url: state.profilePictureUrl,
        location_city: sanitizeName(state.locationCity),
        location_state: sanitizeName(state.locationState),
        bio: sanitizeText(state.bio),
        is_seeker: state.isSeeker,
        is_giver: state.isGiver,
        onboarding_completed: true,
      }).eq('id', user.id)

      // Insert education entries
      if (state.education.length > 0) {
        await supabase.from('education').insert(
          state.education.map(e => ({
            user_id: user.id,
            school_name: sanitizeName(e.schoolName),
            university_id: e.universityId || null,
            degree_type: sanitizeText(e.degreeType),
            major: sanitizeName(e.major),
            graduation_year: e.graduationYear,
            gpa: e.gpa,
            gpa_scale: e.gpaScale,
          }))
        )
      }

      // Insert experience entries
      if (state.experiences.length > 0) {
        await supabase.from('experiences').insert(
          state.experiences.map(e => ({
            user_id: user.id,
            company_name: sanitizeName(e.companyName),
            job_title: sanitizeName(e.jobTitle),
            start_date: e.startDate,
            end_date: e.endDate,
            is_current: e.isCurrent,
            is_internship: e.isInternship,
            description: sanitizeText(e.description),
          }))
        )
      }

      // Insert extracurriculars
      if (state.extracurriculars.length > 0) {
        await supabase.from('extracurriculars').insert(
          state.extracurriculars.map(e => ({
            user_id: user.id,
            organization_name: sanitizeName(e.organizationName),
            role: sanitizeName(e.role),
            start_date: e.startDate,
            end_date: e.endDate,
            description: sanitizeText(e.description),
          }))
        )
      }

      // Insert seeker profile
      if (state.isSeeker) {
        await supabase.from('seeker_profiles').upsert({
          user_id: user.id,
          target_industry: sanitizeText(state.targetIndustry),
          target_role: sanitizeName(state.targetRole),
          target_companies: state.targetCompanies.map(c => sanitizeName(c)),
          goal_type: sanitizeText(state.goalType),
          goal_text: sanitizeText(state.goalText),
          help_types_needed: state.helpTypesNeeded,
          resume_url: state.resumeUrl,
          is_first_gen: state.isFirstGen,
          is_underrepresented: state.isUnderrepresented,
          received_financial_aid: state.receivedFinancialAid,
        })
      }

      // Insert giver profile
      if (state.isGiver) {
        await supabase.from('giver_profiles').upsert({
          user_id: user.id,
          industries_can_advise: state.industriesCanAdvise,
          help_types_offered: state.helpTypesOffered,
          factor_rankings: state.factorRankings,
          prioritize_underrepresented: state.prioritizeUnderrepresented,
        })
      }

      // Save user interests
      if (state.interests.length > 0) {
        // Look up interest IDs by name
        const { data: interestRows } = await supabase
          .from('interests')
          .select('id, name')
          .in('name', state.interests)

        if (interestRows && interestRows.length > 0) {
          await supabase.from('user_interests').insert(
            interestRows.map(i => ({
              user_id: user.id,
              interest_id: i.id,
            }))
          )
        }
      }

      // Clear onboarding state
      useOnboarding.getState().reset()

      // Redirect to home
      router.push('/home')
    } catch {
      toast.error('Something went wrong saving your profile. Please try again.')
      setSaving(false)
    }
  }

  return (
    <div className="flex justify-between mt-6">
      <Button
        variant="outline"
        onClick={prevStep}
        disabled={isFirstStep}
      >
        Back
      </Button>

      {isLastStep ? (
        <Button onClick={handleComplete} disabled={saving}>
          {saving && <Loader2 className="w-4 h-4 mr-2 animate-spin" />}
          Complete Profile
        </Button>
      ) : (
        <Button onClick={handleNext} disabled={!canContinue}>
          Continue
        </Button>
      )}
    </div>
  )
}
