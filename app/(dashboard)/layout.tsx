import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import { Sidebar } from '@/components/layout/sidebar'
import { Navbar } from '@/components/layout/navbar'
import { BottomNav } from '@/components/layout/bottom-nav'

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  const { data: profile } = await supabase
    .from('profiles')
    .select('*, seeker_profiles(*), giver_profiles(*)')
    .eq('id', user.id)
    .single()

  if (!profile?.onboarding_completed) {
    redirect('/onboarding')
  }

  return (
    <div className="min-h-screen bg-background flex">
      <a href="#main-content" className="sr-only focus:not-sr-only focus:absolute focus:top-2 focus:left-2 focus:z-50 bg-primary text-primary-foreground px-4 py-2 rounded-md text-sm font-medium">
        Skip to main content
      </a>

      {/* Desktop Sidebar */}
      <Sidebar user={profile} />

      {/* Main Content */}
      <div className="flex-1 flex flex-col min-h-screen">
        {/* Mobile Top Nav */}
        <div className="md:hidden">
          <Navbar user={profile} />
        </div>

        {/* Page Content */}
        <main id="main-content" className="flex-1 container mx-auto px-4 py-6 pb-20 md:pb-6 max-w-4xl" role="main">
          {children}
        </main>

        {/* Mobile Bottom Nav */}
        <BottomNav />
      </div>
    </div>
  )
}
