'use client'

import Link from 'next/link'
import Image from 'next/image'
import { usePathname, useRouter } from 'next/navigation'
import { Home, Users, MessageSquare, User, LogOut } from 'lucide-react'
import { cn } from '@/lib/utils'
import { createClient } from '@/lib/supabase/client'

const navItems = [
  { href: '/home', label: 'Home', icon: Home },
  { href: '/matches', label: 'Matches', icon: Users },
  { href: '/messages', label: 'Messages', icon: MessageSquare },
  { href: '/profile', label: 'Profile', icon: User },
]

interface SidebarProps {
  user: {
    full_name: string | null
    profile_picture_url: string | null
  }
}

export function Sidebar({ user }: SidebarProps) {
  const pathname = usePathname()
  const router = useRouter()
  const supabase = createClient()

  const handleLogout = async () => {
    localStorage.removeItem('beacon-onboarding')
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <aside className="hidden md:flex flex-col w-64 min-h-screen bg-background border-r border-amber-200/30" role="complementary" aria-label="Sidebar navigation">
      {/* Logo */}
      <div className="p-6">
        <Link href="/home" aria-label="Beacon home" className="h-24 w-24 relative block">
          <Image src="/logo.png" alt="Beacon" fill className="object-contain" />
        </Link>
      </div>

      {/* Navigation */}
      <nav className="flex-1 px-3" aria-label="Main navigation">
        <ul className="space-y-1">
          {navItems.map((item) => {
            const isActive = pathname.startsWith(item.href)
            const Icon = item.icon

            return (
              <li key={item.href}>
                <Link
                  href={item.href}
                  aria-current={isActive ? 'page' : undefined}
                  className={cn(
                    'flex items-center gap-3 px-4 py-2.5 rounded-lg text-sm transition-all duration-200',
                    isActive
                      ? 'bg-primary/10 text-primary font-medium'
                      : 'text-muted-foreground hover:bg-amber-200/10 hover:text-foreground'
                  )}
                >
                  <Icon className="w-5 h-5" aria-hidden="true" />
                  {item.label}
                </Link>
              </li>
            )
          })}
        </ul>
      </nav>

      {/* User section */}
      <div className="p-4 border-t border-amber-200/30">
        <div className="flex items-center gap-3 mb-4">
          <div className="w-10 h-10 rounded-full bg-slate-700/50 overflow-hidden flex-shrink-0">
            {user.profile_picture_url ? (
              <img
                src={user.profile_picture_url}
                alt=""
                className="w-full h-full object-cover"
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center text-muted-foreground">
                <User className="w-5 h-5" />
              </div>
            )}
          </div>
          <div className="flex-1 min-w-0">
            <p className="font-medium truncate text-sm text-foreground">
              {user.full_name || 'User'}
            </p>
          </div>
        </div>

        <button
          onClick={handleLogout}
          className="flex items-center gap-2 text-sm text-muted-foreground hover:text-foreground transition-colors duration-200"
          aria-label="Log out of your account"
        >
          <LogOut className="w-4 h-4" aria-hidden="true" />
          Log out
        </button>
      </div>
    </aside>
  )
}
