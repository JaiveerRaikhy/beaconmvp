/**
 * Experience Level Scale (from PRD v3.0):
 * 0 = Student with no internships
 * 1 = 1-2 internships OR <1 year full-time
 * 2 = 3+ internships OR 1-2 years full-time
 * 3 = 3-5 years full-time
 * 4 = 5-10 years full-time
 * 5 = 10+ years full-time
 */

interface Experience {
  is_internship: boolean
  is_current: boolean
  start_date: string | null
  end_date: string | null
}

export function calculateExperienceLevel(experiences: Experience[]): number {
  if (!experiences || experiences.length === 0) return 0

  let internshipCount = 0
  let fullTimeMonths = 0

  const now = new Date()

  for (const exp of experiences) {
    if (!exp.start_date) continue

    const startDate = new Date(exp.start_date)
    const endDate = exp.is_current
      ? now
      : exp.end_date
        ? new Date(exp.end_date)
        : now

    const months =
      (endDate.getFullYear() - startDate.getFullYear()) * 12 +
      (endDate.getMonth() - startDate.getMonth())

    if (exp.is_internship) {
      internshipCount++
    } else {
      fullTimeMonths += Math.max(0, months)
    }
  }

  const fullTimeYears = fullTimeMonths / 12

  if (fullTimeYears >= 10) return 5
  if (fullTimeYears >= 5) return 4
  if (fullTimeYears >= 3) return 3
  if (internshipCount >= 3 || fullTimeYears >= 1) return 2
  if (internshipCount >= 1 || fullTimeMonths > 0) return 1
  return 0
}

export function meetsExperienceRequirement(
  giverLevel: number,
  seekerLevel: number
): boolean {
  return giverLevel > seekerLevel
}
