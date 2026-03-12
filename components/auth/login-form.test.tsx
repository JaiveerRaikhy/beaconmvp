import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, waitFor } from '@/test/utils'

// Mock Supabase before importing the component
const mockSignInWithPassword = vi.fn()
const mockGetUser = vi.fn()
const mockSignInWithOAuth = vi.fn()

vi.mock('@/lib/supabase/client', () => ({
  createClient: () => ({
    auth: {
      signInWithPassword: mockSignInWithPassword,
      signInWithOAuth: mockSignInWithOAuth,
      getUser: mockGetUser,
    },
  }),
}))

// Mock sonner toast
vi.mock('sonner', () => ({
  toast: {
    error: vi.fn(),
    success: vi.fn(),
  },
}))

import { LoginForm } from './login-form'

describe('LoginForm', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockSignInWithPassword.mockResolvedValue({ data: { user: { id: 'test' } }, error: null })
    mockGetUser.mockResolvedValue({ data: { user: { id: 'test' } }, error: null })
  })

  it('renders email and password fields', () => {
    render(<LoginForm />)
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument()
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument()
  })

  it('renders submit button', () => {
    render(<LoginForm />)
    expect(screen.getByRole('button', { name: /sign in/i })).toBeInTheDocument()
  })

  it('shows error when email is empty', async () => {
    const { user } = render(<LoginForm />)
    await user.click(screen.getByRole('button', { name: /sign in/i }))
    expect(screen.getByText('Email is required')).toBeInTheDocument()
  })

  it('shows error for invalid email format', async () => {
    const { user } = render(<LoginForm />)
    await user.type(screen.getByLabelText(/email/i), 'invalid-email')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /sign in/i }))
    expect(screen.getByText('Please enter a valid email address')).toBeInTheDocument()
  })

  it('shows error when password is empty', async () => {
    const { user } = render(<LoginForm />)
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.click(screen.getByRole('button', { name: /sign in/i }))
    expect(screen.getByText('Password is required')).toBeInTheDocument()
  })

  it('clears email error on input change', async () => {
    const { user } = render(<LoginForm />)
    await user.click(screen.getByRole('button', { name: /sign in/i }))
    expect(screen.getByText('Email is required')).toBeInTheDocument()

    await user.type(screen.getByLabelText(/email/i), 'a')
    expect(screen.queryByText('Email is required')).not.toBeInTheDocument()
  })

  it('clears password error on input change', async () => {
    const { user } = render(<LoginForm />)
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.click(screen.getByRole('button', { name: /sign in/i }))
    expect(screen.getByText('Password is required')).toBeInTheDocument()

    await user.type(screen.getByLabelText(/password/i), 'a')
    expect(screen.queryByText('Password is required')).not.toBeInTheDocument()
  })

  it('calls supabase signInWithPassword on valid submit', async () => {
    const { user } = render(<LoginForm />)
    await user.type(screen.getByLabelText(/email/i), 'test@example.com')
    await user.type(screen.getByLabelText(/password/i), 'password123')
    await user.click(screen.getByRole('button', { name: /sign in/i }))

    await waitFor(() => {
      expect(mockSignInWithPassword).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123',
      })
    })
  })

  it('has proper aria attributes for accessibility', () => {
    render(<LoginForm />)
    const emailInput = screen.getByLabelText(/email/i)
    expect(emailInput).toHaveAttribute('type', 'email')
    expect(emailInput).toHaveAttribute('autocomplete', 'email')

    const passwordInput = screen.getByLabelText(/password/i)
    expect(passwordInput).toHaveAttribute('type', 'password')
    expect(passwordInput).toHaveAttribute('autocomplete', 'current-password')
  })

  it('uses noValidate on the form', () => {
    render(<LoginForm />)
    const form = screen.getByLabelText(/email/i).closest('form')
    expect(form).toHaveAttribute('novalidate')
  })
})
