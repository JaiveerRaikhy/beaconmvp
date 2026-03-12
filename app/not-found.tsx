import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center gradient-primary">
      <div className="text-center space-y-6 px-4 max-w-md">
        <div className="text-6xl font-bold text-muted-foreground">404</div>
        <div>
          <h1 className="text-2xl font-bold">Page not found</h1>
          <p className="text-muted-foreground mt-2">
            The page you&apos;re looking for doesn&apos;t exist or has been moved.
          </p>
        </div>
        <Link href="/">
          <Button>Go home</Button>
        </Link>
      </div>
    </div>
  )
}
