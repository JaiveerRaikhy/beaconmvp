import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Edit } from 'lucide-react'
import Link from 'next/link'
import type { LucideIcon } from 'lucide-react'

interface ProfileSectionProps {
  icon: LucideIcon
  title: string
  editHref: string
  children: React.ReactNode
}

export function ProfileSection({
  icon: Icon,
  title,
  editHref,
  children
}: ProfileSectionProps) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between py-4">
        <div className="flex items-center gap-2">
          <Icon className="w-5 h-5 text-muted-foreground" />
          <CardTitle className="text-base">{title}</CardTitle>
        </div>
        <Link href={editHref}>
          <Button variant="ghost" size="sm">
            <Edit className="w-4 h-4" />
          </Button>
        </Link>
      </CardHeader>
      <CardContent className="pt-0">
        {children}
      </CardContent>
    </Card>
  )
}
