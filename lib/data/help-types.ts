export const HELP_TYPE_CATEGORIES = [
  {
    id: 'job-search',
    name: 'Job Search & Applications',
    types: [
      { id: 'resume-review', name: 'Resume Review' },
      { id: 'interview-prep', name: 'Interview Prep' },
      { id: 'job-search-strategy', name: 'Job Search Strategy' },
      { id: 'portfolio-review', name: 'Portfolio/Work Sample Review' },
    ],
  },
  {
    id: 'career-decisions',
    name: 'Career Decisions',
    types: [
      { id: 'career-path', name: 'Career Path Advice' },
      { id: 'career-switching', name: 'Career Switching' },
      { id: 'first-job', name: 'First Job Guidance' },
      { id: 'grad-school', name: 'Graduate School Advice' },
    ],
  },
  {
    id: 'compensation',
    name: 'Compensation & Negotiation',
    types: [
      { id: 'salary-negotiation', name: 'Salary Negotiation' },
      { id: 'offer-evaluation', name: 'Offer Evaluation' },
      { id: 'equity-benefits', name: 'Equity/Benefits Understanding' },
    ],
  },
  {
    id: 'growth',
    name: 'Growth & Advancement',
    types: [
      { id: 'getting-promoted', name: 'Getting Promoted' },
      { id: 'leadership', name: 'Leadership Development' },
      { id: 'executive-presence', name: 'Building Executive Presence' },
      { id: 'managing-up', name: 'Managing Up' },
    ],
  },
  {
    id: 'industry',
    name: 'Industry/Company Specific',
    types: [
      { id: 'industry-insights', name: 'Industry Insights' },
      { id: 'company-culture', name: 'Company Culture' },
      { id: 'breaking-in', name: 'Breaking Into Industry' },
      { id: 'day-to-day', name: 'Day-to-Day Reality' },
    ],
  },
  {
    id: 'skills',
    name: 'Skills & Development',
    types: [
      { id: 'technical-skills', name: 'Technical Skills' },
      { id: 'communication', name: 'Communication/Presentation Skills' },
      { id: 'networking', name: 'Networking Strategy' },
      { id: 'personal-branding', name: 'Personal Branding' },
    ],
  },
  {
    id: 'work-style',
    name: 'Work Style',
    types: [
      { id: 'work-life-balance', name: 'Work-Life Balance' },
      { id: 'remote-hybrid', name: 'Remote/Hybrid Navigation' },
      { id: 'international', name: 'International/Relocation Careers' },
      { id: 'freelancing', name: 'Freelancing/Consulting' },
    ],
  },
  {
    id: 'entrepreneurship',
    name: 'Entrepreneurship',
    types: [
      { id: 'starting-business', name: 'Starting a Business' },
      { id: 'side-projects', name: 'Side Projects' },
      { id: 'fundraising', name: 'Fundraising/Investors' },
    ],
  },
]

export const ALL_HELP_TYPES = HELP_TYPE_CATEGORIES.flatMap(cat => cat.types)
