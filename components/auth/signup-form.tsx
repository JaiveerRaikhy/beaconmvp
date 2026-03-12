'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { sanitizeName } from '@/lib/security/sanitize'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { toast } from 'sonner'
import { OAuthButtons } from './oauth-buttons'
import { Loader2 } from 'lucide-react'

export function SignupForm() {
  const [fullName, setFullName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [errors, setErrors] = useState<{ name?: string; email?: string; password?: string }>({})
  const router = useRouter()
  const supabase = createClient()

  const validate = (): boolean => {
    const newErrors: { name?: string; email?: string; password?: string } = {}

    if (!fullName.trim()) {
      newErrors.name = 'Full name is required'
    } else if (fullName.trim().length < 2) {
      newErrors.name = 'Name must be at least 2 characters'
    }

    if (!email.trim()) {
      newErrors.email = 'Email is required'
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      newErrors.email = 'Please enter a valid email address'
    }

    if (!password) {
      newErrors.password = 'Password is required'
    } else if (password.length < 6) {
      newErrors.password = 'Password must be at least 6 characters'
    }

    setErrors(newErrors)
    return Object.keys(newErrors).length === 0
  }

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!validate()) return

    setLoading(true)

    const sanitizedName = sanitizeName(fullName)
    if (!sanitizedName) {
      setErrors(prev => ({ ...prev, name: 'Please enter a valid name' }))
      setLoading(false)
      return
    }

    const { data, error } = await supabase.auth.signUp({
      email: email.trim(),
      password,
      options: {
        data: {
          full_name: sanitizedName,
        },
        emailRedirectTo: `${window.location.origin}/auth/callback`,
      },
    })

    if (error) {
      toast.error(error.message)
      setLoading(false)
      return
    }

    // Verify signup response before navigating
    if (!data.user) {
      toast.error('Signup failed. Please try again.')
      setLoading(false)
      return
    }

    // Check if user was auto-confirmed (session exists) vs needs email confirmation
    if (data.session) {
      // Auto-confirm is enabled - user is logged in immediately
      toast.success('Account created! Welcome to Beacon.')
      router.push('/onboarding')
      router.refresh()
    } else {
      // Email confirmation required
      toast.success('Check your email to confirm your account')
      router.push('/login')
    }
  }

  const clearError = (field: 'name' | 'email' | 'password') => {
    if (errors[field]) setErrors(prev => ({ ...prev, [field]: undefined }))
  }

  return (
    <div className="space-y-6">
      <OAuthButtons />

      <div className="flex items-center gap-3">
        <div className="flex-1 h-px bg-border" />
        <span className="text-xs uppercase text-muted-foreground">
          Or continue with email
        </span>
        <div className="flex-1 h-px bg-border" />
      </div>

      <form onSubmit={handleSignup} className="space-y-4" noValidate>
        <div className="space-y-2">
          <Label htmlFor="signup-fullName">Full Name</Label>
          <Input
            id="signup-fullName"
            type="text"
            placeholder="John Doe"
            value={fullName}
            onChange={(e) => { setFullName(e.target.value); clearError('name') }}
            required
            maxLength={200}
            autoComplete="name"
            aria-invalid={!!errors.name}
            aria-describedby={errors.name ? 'signup-name-error' : undefined}
          />
          {errors.name && (
            <p id="signup-name-error" className="text-xs text-destructive" role="alert">
              {errors.name}
            </p>
          )}
        </div>

        <div className="space-y-2">
          <Label htmlFor="signup-email">Email</Label>
          <Input
            id="signup-email"
            type="email"
            placeholder="you@example.com"
            value={email}
            onChange={(e) => { setEmail(e.target.value); clearError('email') }}
            required
            autoComplete="email"
            aria-invalid={!!errors.email}
            aria-describedby={errors.email ? 'signup-email-error' : undefined}
          />
          {errors.email && (
            <p id="signup-email-error" className="text-xs text-destructive" role="alert">
              {errors.email}
            </p>
          )}
        </div>

        <div className="space-y-2">
          <Label htmlFor="signup-password">Password</Label>
          <Input
            id="signup-password"
            type="password"
            placeholder="At least 6 characters"
            value={password}
            onChange={(e) => { setPassword(e.target.value); clearError('password') }}
            required
            minLength={6}
            autoComplete="new-password"
            aria-invalid={!!errors.password}
            aria-describedby={errors.password ? 'signup-password-error' : 'signup-password-hint'}
          />
          {errors.password ? (
            <p id="signup-password-error" className="text-xs text-destructive" role="alert">
              {errors.password}
            </p>
          ) : (
            <p id="signup-password-hint" className="text-xs text-muted-foreground">
              Must be at least 6 characters
            </p>
          )}
        </div>

        <Button type="submit" className="w-full" disabled={loading} data-testid="signup-submit">
          {loading ? (
            <>
              <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              Creating account...
            </>
          ) : (
            'Create account'
          )}
        </Button>
      </form>
    </div>
  )
}
