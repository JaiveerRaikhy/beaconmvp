'use client'

import Link from 'next/link'
import Image from 'next/image'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { LogOut } from 'lucide-react'

interface NavbarProps {
  user: {
    full_name: string | null
    email: string
  }
}

export function Navbar({ user }: NavbarProps) {
  const router = useRouter()
  const supabase = createClient()

  const handleSignOut = async () => {
    // Clear persisted onboarding data on logout
    localStorage.removeItem('beacon-onboarding')
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <header className="sticky top-0 z-50 border-b border-amber-200/30 glass" role="banner">
      <div className="container mx-auto flex h-14 items-center justify-between px-4">
        <Link href="/home" aria-label="Beacon home" className="h-12 w-12 relative">
          <Image src="/logo.png" alt="Beacon" fill className="object-contain" />
        </Link>

        <div className="flex items-center gap-4">
          <span className="hidden text-sm text-muted-foreground md:block">
            {user.full_name || user.email}
          </span>
          <Button variant="ghost" size="icon" onClick={handleSignOut} aria-label="Sign out">
            <LogOut className="h-4 w-4" aria-hidden="true" />
          </Button>
        </div>
      </div>
    </header>
  )
}
