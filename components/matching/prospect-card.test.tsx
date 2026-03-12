import { describe, it, expect, vi } from 'vitest'
import { render, screen, waitFor } from '@/test/utils'
import { ProspectCard, type ProspectData } from './prospect-card'

// Mock MatchScoreBar since it's a separate component
vi.mock('./match-score-bar', () => ({
  MatchScoreBar: ({ score, tier }: { score: number; tier: string }) => (
    <div data-testid="match-score-bar">
      <span>{score}%</span>
      <span>{tier}</span>
    </div>
  ),
}))

function makeProspect(overrides: Partial<ProspectData> = {}): ProspectData {
  return {
    id: 'prospect-1',
    full_name: 'Jane Smith',
    profile_picture_url: null,
    location_city: 'New York',
    location_state: 'NY',
    bio: 'Software engineer looking for career guidance',
    education: [
      {
        school_name: 'MIT',
        degree_type: 'BS',
        major: 'Computer Science',
        graduation_year: 2024,
      },
    ],
    experiences: [
      {
        company_name: 'Google',
        job_title: 'Software Engineer Intern',
        is_current: false,
      },
    ],
    seeker_profile: {
      target_industry: 'Technology',
      target_role: 'Software Engineer',
      help_types_needed: ['resume-review', 'mock-interview', 'career-strategy'],
      resume_url: null,
    },
    interests: ['coding', 'hiking'],
    match_score: 85,
    match_tier: 'high',
    ...overrides,
  }
}

describe('ProspectCard', () => {
  const mockOnAccept = vi.fn().mockResolvedValue(undefined)
  const mockOnReject = vi.fn().mockResolvedValue(undefined)
  const mockOnView = vi.fn()

  it('renders prospect name', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Jane Smith')).toBeInTheDocument()
  })

  it('renders school name and graduation year', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText("MIT '24")).toBeInTheDocument()
  })

  it('renders avatar initial when no profile picture', () => {
    render(
      <ProspectCard
        prospect={makeProspect({ profile_picture_url: null })}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('J')).toBeInTheDocument()
  })

  it('renders profile image when URL provided', () => {
    render(
      <ProspectCard
        prospect={makeProspect({ profile_picture_url: 'https://example.com/photo.jpg' })}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    const img = document.querySelector('img')
    expect(img).toBeTruthy()
    expect(img!.getAttribute('src')).toBe('https://example.com/photo.jpg')
  })

  it('renders target role', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Software Engineer')).toBeInTheDocument()
  })

  it('renders help types as badges (max 3)', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Resume Review')).toBeInTheDocument()
    expect(screen.getByText('Mock Interview')).toBeInTheDocument()
    expect(screen.getByText('Career Strategy')).toBeInTheDocument()
  })

  it('renders match score bar', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByTestId('match-score-bar')).toBeInTheDocument()
    expect(screen.getByText('85%')).toBeInTheDocument()
  })

  it('renders Accept and Pass buttons', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByRole('button', { name: /accept/i })).toBeInTheDocument()
    expect(screen.getByRole('button', { name: /pass/i })).toBeInTheDocument()
  })

  it('renders View button when onView is provided', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
        onView={mockOnView}
      />
    )
    expect(screen.getByRole('button', { name: /view/i })).toBeInTheDocument()
  })

  it('does not render View button when onView is not provided', () => {
    render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.queryByRole('button', { name: /view/i })).not.toBeInTheDocument()
  })

  it('calls onAccept with id and score when Accept clicked', async () => {
    const onAccept = vi.fn().mockResolvedValue(undefined)
    const { user } = render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={onAccept}
        onReject={mockOnReject}
      />
    )
    await user.click(screen.getByRole('button', { name: /accept/i }))
    await waitFor(() => {
      expect(onAccept).toHaveBeenCalledWith('prospect-1', 85)
    })
  })

  it('calls onReject with id when Pass clicked', async () => {
    const onReject = vi.fn().mockResolvedValue(undefined)
    const { user } = render(
      <ProspectCard
        prospect={makeProspect()}
        onAccept={mockOnAccept}
        onReject={onReject}
      />
    )
    await user.click(screen.getByRole('button', { name: /pass/i }))
    await waitFor(() => {
      expect(onReject).toHaveBeenCalledWith('prospect-1')
    })
  })

  it('calls onView with prospect when View clicked', async () => {
    const onView = vi.fn()
    const prospect = makeProspect()
    const { user } = render(
      <ProspectCard
        prospect={prospect}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
        onView={onView}
      />
    )
    await user.click(screen.getByRole('button', { name: /view/i }))
    expect(onView).toHaveBeenCalledWith(prospect)
  })

  it('shows "Student" when no current position', () => {
    const prospect = makeProspect({
      experiences: [
        { company_name: 'Google', job_title: 'Intern', is_current: false },
      ],
    })
    render(
      <ProspectCard
        prospect={prospect}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Student')).toBeInTheDocument()
  })

  it('shows current position when available', () => {
    const prospect = makeProspect({
      experiences: [
        { company_name: 'Meta', job_title: 'Product Manager', is_current: true },
      ],
    })
    render(
      <ProspectCard
        prospect={prospect}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Product Manager @ Meta')).toBeInTheDocument()
  })

  it('falls back to target industry when no target role', () => {
    const prospect = makeProspect({
      seeker_profile: {
        target_industry: 'Technology',
        target_role: '',
        help_types_needed: ['resume-review'],
        resume_url: null,
      },
    })
    render(
      <ProspectCard
        prospect={prospect}
        onAccept={mockOnAccept}
        onReject={mockOnReject}
      />
    )
    expect(screen.getByText('Technology')).toBeInTheDocument()
  })
})
