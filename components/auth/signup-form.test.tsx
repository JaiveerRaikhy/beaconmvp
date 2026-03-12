import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, waitFor } from '@/test/utils'

const mockSignUp = vi.fn()
const mockSignInWithOAuth = vi.fn()

vi.mock('@/lib/supabase/client', () => ({
  createClient: () => ({
    auth: {
      signUp: mockSignUp,
      signInWithOAuth: mockSignInWithOAuth,
    },
  }),
}))

vi.mock('sonner', () => ({
  toast: {
    error: vi.fn(),
    success: vi.fn(),
  },
}))

import { SignupForm } from './signup-form'

describe('SignupForm', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockSignUp.mockResolvedValue({ data: { user: { id: 'test' } }, error: null })
  })

  it('renders name, email, and password fields', () => {
    render(<SignupForm />)
    expect(screen.getByLabelText(/full name/i)).toBeInTheDocument()
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument()
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument()
  })

  it('renders create account button', () => {
    render(<SignupForm />)
    expect(screen.getByRole('button', { name: /create account/i })).toBeInTheDocument()
  })

  it('shows error when name is empty', async () => {
    const { user } = render(<SignupForm />)
    await user.click(screen.getByRole('button', { name: /create account/i }))
    expect(screen.getByText('Full name is required')).toBeInTheDocument()
  })

  it('shows error when name is too short', async () => {
    const { user } = render(<SignupForm />)
    await user.type(screen.getByLabelText(/full name/i), 'A')
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /create account/i }))
    expect(screen.getByText('Name must be at least 2 characters')).toBeInTheDocument()
  })

  it('shows error for invalid email', async () => {
    const { user } = render(<SignupForm />)
    await user.type(screen.getByLabelText(/full name/i), 'John Doe')
    await user.type(screen.getByLabelText(/email/i), 'invalid')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /create account/i }))
    expect(screen.getByText('Please enter a valid email address')).toBeInTheDocument()
  })

  it('shows error when password is too short', async () => {
    const { user } = render(<SignupForm />)
    await user.type(screen.getByLabelText(/full name/i), 'John Doe')
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.type(screen.getByLabelText(/password/i), '12345')
    await user.click(screen.getByRole('button', { name: /create account/i }))
    expect(screen.getByText('Password must be at least 6 characters')).toBeInTheDocument()
  })

  it('shows password hint when no error', () => {
    render(<SignupForm />)
    expect(screen.getByText('Must be at least 6 characters')).toBeInTheDocument()
  })

  it('calls supabase signUp on valid submit', async () => {
    const { user } = render(<SignupForm />)
    await user.type(screen.getByLabelText(/full name/i), 'John Doe')
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /create account/i }))

    await waitFor(() => {
      expect(mockSignUp).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123',
        options: expect.objectContaining({
          data: { full_name: 'John Doe' },
        }),
      })
    })
  })

  it('sanitizes name before sending to supabase', async () => {
    const { user } = render(<SignupForm />)
    await user.type(screen.getByLabelText(/full name/i), 'John <script>alert(1)</script> Doe')
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /create account/i }))

    await waitFor(() => {
      expect(mockSignUp).toHaveBeenCalledWith(
        expect.objectContaining({
          options: expect.objectContaining({
            data: { full_name: expect.not.stringContaining('<script>') },
          }),
        })
      )
    })
  })

  it('clears errors on field input change', async () => {
    const { user } = render(<SignupForm />)
    await user.click(screen.getByRole('button', { name: /create account/i }))
    expect(screen.getByText('Full name is required')).toBeInTheDocument()

    await user.type(screen.getByLabelText(/full name/i), 'J')
    expect(screen.queryByText('Full name is required')).not.toBeInTheDocument()
  })

  it('has proper accessibility attributes', () => {
    render(<SignupForm />)
    expect(screen.getByLabelText(/full name/i)).toHaveAttribute('autocomplete', 'name')
    expect(screen.getByLabelText(/email/i)).toHaveAttribute('autocomplete', 'email')
    expect(screen.getByLabelText(/password/i)).toHaveAttribute('autocomplete', 'new-password')
  })
})
