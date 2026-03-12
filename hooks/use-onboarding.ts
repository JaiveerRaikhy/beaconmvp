'use client'

import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export interface EducationEntry {
  id: string
  schoolName: string
  universityId: string | null
  degreeType: string
  major: string
  graduationYear: number
  gpa: number
  gpaScale: number
}

export interface ExperienceEntry {
  id: string
  companyName: string
  jobTitle: string
  startDate: string
  endDate: string | null
  isCurrent: boolean
  isInternship: boolean
  description: string
}

export interface ExtracurricularEntry {
  id: string
  organizationName: string
  role: string
  startDate: string
  endDate: string | null
  description: string
}

interface OnboardingState {
  currentStep: number

  // Role selection
  isSeeker: boolean
  isGiver: boolean

  // Basic info
  profilePictureUrl: string | null
  locationCity: string
  locationState: string

  // Education
  education: EducationEntry[]

  // Experience
  experiences: ExperienceEntry[]

  // Extracurriculars
  extracurriculars: ExtracurricularEntry[]

  // Seeker specific
  targetIndustry: string
  targetRole: string
  targetCompanies: string[]
  goalType: string
  goalText: string
  helpTypesNeeded: string[]
  resumeUrl: string | null
  isFirstGen: boolean
  isUnderrepresented: boolean
  receivedFinancialAid: boolean

  // Giver specific
  industriesCanAdvise: string[]
  helpTypesOffered: string[]
  factorRankings: Record<string, number>
  prioritizeUnderrepresented: boolean

  // Shared
  interests: string[]
  bio: string

  // Actions
  setStep: (step: number) => void
  nextStep: () => void
  prevStep: () => void
  updateField: <K extends keyof OnboardingState>(
    field: K,
    value: OnboardingState[K]
  ) => void
  addEducation: (entry: EducationEntry) => void
  removeEducation: (id: string) => void
  addExperience: (entry: ExperienceEntry) => void
  removeExperience: (id: string) => void
  addExtracurricular: (entry: ExtracurricularEntry) => void
  removeExtracurricular: (id: string) => void
  reset: () => void
}

const initialState = {
  currentStep: 1,
  isSeeker: false,
  isGiver: false,
  profilePictureUrl: null,
  locationCity: '',
  locationState: '',
  education: [] as EducationEntry[],
  experiences: [] as ExperienceEntry[],
  extracurriculars: [] as ExtracurricularEntry[],
  targetIndustry: '',
  targetRole: '',
  targetCompanies: [] as string[],
  goalType: '',
  goalText: '',
  helpTypesNeeded: [] as string[],
  resumeUrl: null,
  isFirstGen: false,
  isUnderrepresented: false,
  receivedFinancialAid: false,
  industriesCanAdvise: [] as string[],
  helpTypesOffered: [] as string[],
  factorRankings: {} as Record<string, number>,
  prioritizeUnderrepresented: false,
  interests: [] as string[],
  bio: '',
}

export const useOnboarding = create<OnboardingState>()(
  persist(
    (set, get) => ({
      ...initialState,

      setStep: (step) => set({ currentStep: step }),

      nextStep: () => {
        const { currentStep } = get()
        set({ currentStep: currentStep + 1 })
      },

      prevStep: () => {
        const { currentStep } = get()
        if (currentStep > 1) {
          set({ currentStep: currentStep - 1 })
        }
      },

      updateField: (field, value) => set({ [field]: value } as Partial<OnboardingState>),

      addEducation: (entry) => set((state) => ({
        education: [...state.education, entry]
      })),

      removeEducation: (id) => set((state) => ({
        education: state.education.filter((e) => e.id !== id)
      })),

      addExperience: (entry) => set((state) => ({
        experiences: [...state.experiences, entry]
      })),

      removeExperience: (id) => set((state) => ({
        experiences: state.experiences.filter((e) => e.id !== id)
      })),

      addExtracurricular: (entry) => set((state) => ({
        extracurriculars: [...state.extracurriculars, entry]
      })),

      removeExtracurricular: (id) => set((state) => ({
        extracurriculars: state.extracurriculars.filter((e) => e.id !== id)
      })),

      reset: () => set(initialState),
    }),
    {
      name: 'beacon-onboarding',
      // Exclude sensitive fields from localStorage persistence
      partialize: (state) => ({
        currentStep: state.currentStep,
        isSeeker: state.isSeeker,
        isGiver: state.isGiver,
        profilePictureUrl: state.profilePictureUrl,
        locationCity: state.locationCity,
        locationState: state.locationState,
        education: state.education,
        experiences: state.experiences,
        extracurriculars: state.extracurriculars,
        targetIndustry: state.targetIndustry,
        targetRole: state.targetRole,
        targetCompanies: state.targetCompanies,
        goalType: state.goalType,
        goalText: state.goalText,
        helpTypesNeeded: state.helpTypesNeeded,
        // resumeUrl excluded - contains file path
        isFirstGen: state.isFirstGen,
        isUnderrepresented: state.isUnderrepresented,
        receivedFinancialAid: state.receivedFinancialAid,
        industriesCanAdvise: state.industriesCanAdvise,
        helpTypesOffered: state.helpTypesOffered,
        factorRankings: state.factorRankings,
        prioritizeUnderrepresented: state.prioritizeUnderrepresented,
        interests: state.interests,
        bio: state.bio,
      }),
      // Validate state on hydration to prevent corrupted/tampered data
      onRehydrateStorage: () => (state) => {
        if (!state) return
        // Validate currentStep is a reasonable number
        if (typeof state.currentStep !== 'number' || state.currentStep < 1 || state.currentStep > 20) {
          state.currentStep = 1
        }
        // Validate arrays are actually arrays
        const arrayFields = [
          'education', 'experiences', 'extracurriculars',
          'targetCompanies', 'helpTypesNeeded', 'industriesCanAdvise',
          'helpTypesOffered', 'interests'
        ] as const
        for (const field of arrayFields) {
          if (!Array.isArray(state[field])) {
            (state as unknown as Record<string, unknown>)[field] = []
          }
        }
      },
      version: 1,
    }
  )
)
