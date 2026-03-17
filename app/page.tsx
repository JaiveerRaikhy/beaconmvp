import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default function LandingPage() {
  return (
    <div className="min-h-screen flex flex-col">
      <a href="#main-content" className="sr-only focus:not-sr-only focus:absolute focus:top-2 focus:left-2 focus:z-50 bg-primary text-primary-foreground px-4 py-2 rounded-md text-sm font-medium">
        Skip to main content
      </a>
      <header className="border-b border-orange-200/30 glass" role="banner">
        <nav className="container mx-auto flex h-14 items-center justify-between px-4" aria-label="Main navigation">
          <Link href="/" aria-label="Beacon home" className="text-2xl font-bold text-[#c8612a]">
            Beacon
          </Link>
          <div className="flex items-center gap-3">
            <Link href="/login">
              <Button variant="ghost">Sign in</Button>
            </Link>
            <Link href="/signup">
              <Button>Get started</Button>
            </Link>
          </div>
        </nav>
      </header>

      <main id="main-content" className="flex-1 flex items-center justify-center gradient-primary relative overflow-hidden" role="main">
        {/* Subtle background glow */}
        <div className="absolute inset-0 overflow-hidden" aria-hidden="true">
          <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-[#c8612a] rounded-full opacity-5 blur-3xl" />
          <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-[#a84e20] rounded-full opacity-5 blur-3xl" />
        </div>

        <div className="text-center space-y-8 px-4 max-w-2xl relative z-10">
          <h1 className="text-5xl font-bold tracking-tight sm:text-6xl text-foreground" style={{ letterSpacing: '-0.025em' }}>
            Find your
            <span className="block bg-gradient-to-r from-[#c8612a] to-[#a84e20] bg-clip-text text-transparent">career mentor</span>
          </h1>
          <p className="text-xl text-muted-foreground max-w-lg mx-auto leading-relaxed">
            Beacon connects aspiring professionals with experienced mentors
            who&apos;ve walked the path before. Get matched, get guidance, get ahead.
          </p>
          <div className="flex gap-4 justify-center">
            <Link href="/signup">
              <Button size="lg" className="text-base px-8">
                Join as a Seeker
              </Button>
            </Link>
            <Link href="/signup">
              <Button size="lg" variant="outline" className="text-base px-8">
                Give as a Mentor
              </Button>
            </Link>
          </div>
        </div>
      </main>

      <footer className="border-t border-orange-200/30 bg-background py-6">
        <div className="container mx-auto px-4 text-center text-sm text-muted-foreground">
          Beacon MVP &mdash; Connecting seekers with givers
        </div>
      </footer>
    </div>
  )
}
