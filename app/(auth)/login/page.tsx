import { LoginForm } from '@/components/auth/login-form'
import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Sign In',
  description: 'Sign in to your Beacon account to connect with mentors and mentees.',
}

export default function LoginPage() {
  return (
    <div className="space-y-6">
      <div className="text-center">
        <h1 className="text-3xl font-bold">Welcome back</h1>
        <p className="text-muted-foreground mt-2">
          Sign in to continue to Beacon
        </p>
      </div>

      <LoginForm />

      <div className="text-center text-sm text-muted-foreground space-y-2">
        <p>
          Don&apos;t have an account?{' '}
          <Link href="/signup" className="text-primary hover:underline font-medium">
            Sign up
          </Link>
        </p>
        <p>
          <Link href="/forgot-password" className="text-primary hover:underline">
            Forgot your password?
          </Link>
        </p>
      </div>
    </div>
  )
}
