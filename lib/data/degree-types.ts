export const DEGREE_TYPES = [
  { id: 'hs', label: 'High School Diploma' },
  { id: 'associate', label: 'Associate Degree' },
  { id: 'bs', label: 'Bachelor of Science (BS)' },
  { id: 'ba', label: 'Bachelor of Arts (BA)' },
  { id: 'bba', label: 'Bachelor of Business Administration (BBA)' },
  { id: 'beng', label: 'Bachelor of Engineering (BEng)' },
  { id: 'ms', label: 'Master of Science (MS)' },
  { id: 'ma', label: 'Master of Arts (MA)' },
  { id: 'mba', label: 'Master of Business Administration (MBA)' },
  { id: 'meng', label: 'Master of Engineering (MEng)' },
  { id: 'jd', label: 'Juris Doctor (JD)' },
  { id: 'md', label: 'Doctor of Medicine (MD)' },
  { id: 'phd', label: 'Doctor of Philosophy (PhD)' },
  { id: 'other', label: 'Other' },
]

export const GPA_SCALES = [
  { value: 4.0, label: '4.0 scale' },
  { value: 5.0, label: '5.0 scale' },
  { value: 10.0, label: '10.0 scale' },
  { value: 100, label: '100 scale' },
]

export const FACTOR_OPTIONS = [
  { id: 'location', label: 'Location/Proximity', description: 'Prefer students in my area' },
  { id: 'university', label: 'Shared University', description: 'Prefer alumni from my school' },
  { id: 'prestige', label: 'University Prestige', description: 'Prefer students from top schools' },
  { id: 'gpa', label: 'GPA', description: 'Prefer students with higher GPAs' },
  { id: 'industry', label: 'Industry Alignment', description: 'Prefer students targeting my industry' },
  { id: 'interests', label: 'Shared Interests', description: 'Prefer students with similar interests' },
]
