'use client'

import { Card, CardContent } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { MatchScoreBar } from './match-score-bar'
import { formatHelpType } from '@/lib/utils'
import { useState } from 'react'

interface ProspectEducation {
  school_name: string
  degree_type: string | null
  major: string | null
  graduation_year: number | null
}

interface ProspectExperience {
  company_name: string
  job_title: string
  is_current: boolean
}

export interface ProspectData {
  id: string
  full_name: string
  profile_picture_url: string | null
  location_city: string | null
  location_state: string | null
  bio: string | null
  education: ProspectEducation[]
  experiences: ProspectExperience[]
  seeker_profile: {
    target_industry: string
    target_role: string
    help_types_needed: string[]
    resume_url: string | null
  }
  interests: string[]
  match_score: number
  match_tier: 'high' | 'good' | 'fair'
}

interface ProspectCardProps {
  prospect: ProspectData
  onAccept: (id: string, score: number) => Promise<void>
  onReject: (id: string) => Promise<void>
  onView?: (prospect: ProspectData) => void
}

export function ProspectCard({
  prospect,
  onAccept,
  onReject,
  onView,
}: ProspectCardProps) {
  const [loading, setLoading] = useState(false)

  const currentEducation = prospect.education[0]
  const currentPosition = prospect.experiences.find((e) => e.is_current)

  const handleAccept = async () => {
    setLoading(true)
    try {
      await onAccept(prospect.id, prospect.match_score)
    } finally {
      setLoading(false)
    }
  }

  const handleReject = async () => {
    setLoading(true)
    try {
      await onReject(prospect.id)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Card>
      <CardContent className="space-y-4">
        {/* Header */}
        <div className="flex items-start gap-3">
          <div className="w-14 h-14 rounded-full bg-stone-300/60 overflow-hidden flex-shrink-0 flex items-center justify-center">
            {prospect.profile_picture_url ? (
              <img
                src={prospect.profile_picture_url}
                alt=""
                className="w-full h-full object-cover"
              />
            ) : (
              <span className="text-lg font-medium text-muted-foreground">
                {prospect.full_name.charAt(0).toUpperCase()}
              </span>
            )}
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="font-semibold truncate">{prospect.full_name}</h3>
            {currentEducation && (
              <p className="text-sm text-muted-foreground">
                {currentEducation.school_name}
                {currentEducation.graduation_year
                  ? ` '${String(currentEducation.graduation_year).slice(-2)}`
                  : ''}
              </p>
            )}
            {currentPosition ? (
              <p className="text-sm text-muted-foreground">
                {currentPosition.job_title} @ {currentPosition.company_name}
              </p>
            ) : (
              <p className="text-sm text-muted-foreground">Student</p>
            )}
          </div>
        </div>

        {/* Target */}
        <div>
          <p className="text-sm">
            <span className="text-muted-foreground">Target:</span>{' '}
            <span className="font-medium">
              {prospect.seeker_profile.target_role ||
                prospect.seeker_profile.target_industry}
            </span>
          </p>
        </div>

        {/* Help types */}
        <div>
          <p className="text-xs text-muted-foreground mb-1.5">
            Needs help with:
          </p>
          <div className="flex flex-wrap gap-1">
            {prospect.seeker_profile.help_types_needed
              .slice(0, 3)
              .map((type) => (
                <Badge key={type} variant="secondary" className="text-xs">
                  {formatHelpType(type)}
                </Badge>
              ))}
          </div>
        </div>

        {/* Match score */}
        <MatchScoreBar
          score={prospect.match_score}
          tier={prospect.match_tier}
        />

        {/* Actions */}
        <div className="flex gap-2">
          {onView && (
            <Button
              variant="outline"
              size="sm"
              className="flex-1"
              onClick={() => onView(prospect)}
            >
              View
            </Button>
          )}
          <Button
            variant="outline"
            size="sm"
            className="flex-1"
            onClick={handleReject}
            disabled={loading}
          >
            Pass
          </Button>
          <Button
            size="sm"
            className="flex-1"
            onClick={handleAccept}
            disabled={loading}
          >
            Accept
          </Button>
        </div>
      </CardContent>
    </Card>
  )
}
