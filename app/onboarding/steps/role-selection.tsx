'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { Card } from '@/components/ui/card'
import { CheckCircle2, Search, Heart } from 'lucide-react'
import { cn } from '@/lib/utils'

export function RoleSelection() {
  const { isSeeker, isGiver, updateField } = useOnboarding()

  return (
    <div className="space-y-4">
      <p className="text-muted-foreground text-center">
        Select how you&apos;d like to use Beacon. You can choose both!
      </p>

      <div className="grid gap-4">
        <Card
          className={cn(
            'p-6 cursor-pointer transition-all hover:shadow-md',
            isSeeker && 'ring-2 ring-emerald-500 bg-emerald-500/10'
          )}
          onClick={() => updateField('isSeeker', !isSeeker)}
        >
          <div className="flex items-start gap-4">
            <div className={cn(
              'w-10 h-10 rounded-full flex items-center justify-center shrink-0',
              isSeeker ? 'bg-emerald-500 text-white' : 'bg-stone-300/60 text-muted-foreground'
            )}>
              {isSeeker ? <CheckCircle2 className="w-5 h-5" /> : <Search className="w-5 h-5" />}
            </div>
            <div>
              <h3 className="font-semibold text-lg">I want to receive advice</h3>
              <p className="text-sm text-muted-foreground mt-1">
                Connect with experienced professionals who can help guide your career.
                Get resume reviews, interview prep, career path advice, and more.
              </p>
            </div>
          </div>
        </Card>

        <Card
          className={cn(
            'p-6 cursor-pointer transition-all hover:shadow-md',
            isGiver && 'ring-2 ring-emerald-500 bg-emerald-500/10'
          )}
          onClick={() => updateField('isGiver', !isGiver)}
        >
          <div className="flex items-start gap-4">
            <div className={cn(
              'w-10 h-10 rounded-full flex items-center justify-center shrink-0',
              isGiver ? 'bg-emerald-500 text-white' : 'bg-stone-300/60 text-muted-foreground'
            )}>
              {isGiver ? <CheckCircle2 className="w-5 h-5" /> : <Heart className="w-5 h-5" />}
            </div>
            <div>
              <h3 className="font-semibold text-lg">I want to give advice</h3>
              <p className="text-sm text-muted-foreground mt-1">
                Share your experience and help others navigate their careers.
                Mentor students and early-career professionals in your field.
              </p>
            </div>
          </div>
        </Card>
      </div>

      {!isSeeker && !isGiver && (
        <p className="text-sm text-orange-700 text-center">
          Please select at least one role to continue
        </p>
      )}
    </div>
  )
}
