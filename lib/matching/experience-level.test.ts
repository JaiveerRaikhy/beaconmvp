import { describe, it, expect } from 'vitest'
import { calculateExperienceLevel, meetsExperienceRequirement } from './experience-level'

describe('calculateExperienceLevel', () => {
  it('returns 0 for empty experiences', () => {
    expect(calculateExperienceLevel([])).toBe(0)
  })

  it('returns 0 for null/undefined experiences', () => {
    expect(calculateExperienceLevel(null as unknown as never[])).toBe(0)
    expect(calculateExperienceLevel(undefined as unknown as never[])).toBe(0)
  })

  it('returns 1 for 1 internship', () => {
    const experiences = [
      {
        is_internship: true,
        is_current: false,
        start_date: '2023-06-01',
        end_date: '2023-08-31',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(1)
  })

  it('returns 1 for 2 internships', () => {
    const experiences = [
      { is_internship: true, is_current: false, start_date: '2023-06-01', end_date: '2023-08-31' },
      { is_internship: true, is_current: false, start_date: '2024-06-01', end_date: '2024-08-31' },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(1)
  })

  it('returns 2 for 3+ internships', () => {
    const experiences = [
      { is_internship: true, is_current: false, start_date: '2022-06-01', end_date: '2022-08-31' },
      { is_internship: true, is_current: false, start_date: '2023-06-01', end_date: '2023-08-31' },
      { is_internship: true, is_current: false, start_date: '2024-06-01', end_date: '2024-08-31' },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(2)
  })

  it('returns 2 for 1-2 years full-time', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: false,
        start_date: '2023-01-01',
        end_date: '2024-06-01',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(2)
  })

  it('returns 3 for 3-5 years full-time', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: false,
        start_date: '2020-01-01',
        end_date: '2023-06-01',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(3)
  })

  it('returns 4 for 5-10 years full-time', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: false,
        start_date: '2018-01-01',
        end_date: '2024-01-01',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(4)
  })

  it('returns 5 for 10+ years full-time', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: false,
        start_date: '2010-01-01',
        end_date: '2024-01-01',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(5)
  })

  it('handles current positions correctly', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: true,
        start_date: '2020-01-01',
        end_date: null,
      },
    ]
    // With start date in 2020 and current=true, should calculate from start to now
    const level = calculateExperienceLevel(experiences)
    expect(level).toBeGreaterThanOrEqual(3)
  })

  it('skips entries without start_date', () => {
    const experiences = [
      { is_internship: true, is_current: false, start_date: null, end_date: null },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(0)
  })

  it('returns 1 for < 1 year full-time', () => {
    const experiences = [
      {
        is_internship: false,
        is_current: false,
        start_date: '2024-01-01',
        end_date: '2024-06-01',
      },
    ]
    expect(calculateExperienceLevel(experiences)).toBe(1)
  })
})

describe('meetsExperienceRequirement', () => {
  it('returns true when giver level > seeker level', () => {
    expect(meetsExperienceRequirement(3, 1)).toBe(true)
    expect(meetsExperienceRequirement(5, 4)).toBe(true)
  })

  it('returns false when levels are equal', () => {
    expect(meetsExperienceRequirement(2, 2)).toBe(false)
  })

  it('returns false when giver level < seeker level', () => {
    expect(meetsExperienceRequirement(1, 3)).toBe(false)
  })
})
