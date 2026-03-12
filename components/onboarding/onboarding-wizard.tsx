'use client'

import { useMemo } from 'react'
import { useOnboarding } from '@/hooks/use-onboarding'
import { ProgressBar } from './progress-bar'
import { StepWrapper } from './step-wrapper'
import { NavigationButtons } from './navigation-buttons'

import { RoleSelection } from '@/app/onboarding/steps/role-selection'
import { BasicInfo } from '@/app/onboarding/steps/basic-info'
import { Education } from '@/app/onboarding/steps/education'
import { Experience } from '@/app/onboarding/steps/experience'
import { Extracurriculars } from '@/app/onboarding/steps/extracurriculars'
import { SeekerGoals } from '@/app/onboarding/steps/seeker-goals'
import { SeekerHelp } from '@/app/onboarding/steps/seeker-help'
import { GiverExpertise } from '@/app/onboarding/steps/giver-expertise'
import { GiverPreferences } from '@/app/onboarding/steps/giver-preferences'
import { Interests } from '@/app/onboarding/steps/interests'
import { Bio } from '@/app/onboarding/steps/bio'
import { Resume } from '@/app/onboarding/steps/resume'

interface StepConfig {
  component: React.ComponentType
  title: string
  subtitle?: string
  optional?: boolean
}

export function OnboardingWizard() {
  const { currentStep, isSeeker, isGiver } = useOnboarding()

  const steps = useMemo(() => {
    const allSteps: StepConfig[] = [
      { component: RoleSelection, title: 'Choose Your Role', subtitle: 'How would you like to use Beacon?' },
      { component: BasicInfo, title: 'Basic Information', subtitle: 'Tell us a bit about yourself' },
      { component: Education, title: 'Education', subtitle: 'Add your schools and degrees' },
      { component: Experience, title: 'Experience', subtitle: 'Add jobs, internships, or projects' },
      { component: Extracurriculars, title: 'Activities', subtitle: 'Clubs, organizations, or volunteer work', optional: true },
    ]

    if (isSeeker) {
      allSteps.push(
        { component: SeekerGoals, title: 'Your Goals', subtitle: 'What are you looking for?' },
        { component: SeekerHelp, title: 'Help You Need', subtitle: 'Select the types of help you want' },
      )
    }

    if (isGiver) {
      allSteps.push(
        { component: GiverExpertise, title: 'Your Expertise', subtitle: 'What can you advise on?' },
        { component: GiverPreferences, title: 'Preferences', subtitle: 'How should we match you?' },
      )
    }

    allSteps.push(
      { component: Interests, title: 'Interests', subtitle: 'Help us find better matches' },
      { component: Bio, title: 'About You', subtitle: 'Write a short bio' },
    )

    if (isSeeker) {
      allSteps.push(
        { component: Resume, title: 'Resume', subtitle: 'Upload your resume (optional)', optional: true },
      )
    }

    return allSteps
  }, [isSeeker, isGiver])

  const stepIndex = Math.min(currentStep - 1, steps.length - 1)
  const currentStepData = steps[stepIndex]
  const StepComponent = currentStepData.component
  const progress = ((stepIndex + 1) / steps.length) * 100

  const canContinue = currentStep === 1 ? (isSeeker || isGiver) : true

  return (
    <div className="min-h-screen bg-background pt-2">
      <ProgressBar progress={progress} />

      <div className="container max-w-2xl mx-auto px-4 py-8">
        <p className="text-sm text-muted-foreground text-center mb-6">
          Step {stepIndex + 1} of {steps.length}
          {currentStepData.optional && ' (optional)'}
        </p>

        <StepWrapper title={currentStepData.title} subtitle={currentStepData.subtitle}>
          <StepComponent />
        </StepWrapper>

        <NavigationButtons
          isFirstStep={currentStep === 1}
          isLastStep={stepIndex === steps.length - 1}
          canContinue={canContinue}
        />
      </div>
    </div>
  )
}
