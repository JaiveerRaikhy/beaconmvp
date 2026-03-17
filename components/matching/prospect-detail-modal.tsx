'use client'

import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { MatchScoreBar } from './match-score-bar'
import { formatHelpType } from '@/lib/utils'
import type { ProspectData } from './prospect-card'
import { useState, useEffect } from 'react'

interface ProspectDetailModalProps {
  prospect: ProspectData | null
  onClose: () => void
  onAccept: (id: string, score: number) => Promise<void>
  onReject: (id: string) => Promise<void>
  isDecided?: boolean
}

export function ProspectDetailModal({
  prospect,
  onClose,
  onAccept,
  onReject,
  isDecided,
}: ProspectDetailModalProps) {
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (prospect) {
      document.body.style.overflow = 'hidden'
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [prospect])

  if (!prospect) return null

  const handleAccept = async () => {
    setLoading(true)
    try {
      await onAccept(prospect.id, prospect.match_score)
      onClose()
    } finally {
      setLoading(false)
    }
  }

  const handleReject = async () => {
    setLoading(true)
    try {
      await onReject(prospect.id)
      onClose()
    } finally {
      setLoading(false)
    }
  }

  const currentPosition = prospect.experiences.find((e) => e.is_current)

  return (
    <div
      className="fixed inset-0 z-50 flex items-end sm:items-center justify-center"
      onClick={onClose}
    >
      {/* Backdrop */}
      <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" />

      {/* Modal */}
      <div
        className="relative bg-card rounded-t-xl sm:rounded-xl w-full sm:max-w-lg max-h-[85vh] overflow-y-auto border border-orange-200/30"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="sticky top-0 bg-card border-b border-orange-200/30 px-4 py-3 flex items-center justify-between">
          <h2 className="font-semibold">Prospect Profile</h2>
          <button
            onClick={onClose}
            className="text-muted-foreground hover:text-foreground text-lg leading-none"
          >
            &times;
          </button>
        </div>

        <div className="p-4 space-y-5">
          {/* Profile header */}
          <div className="flex items-start gap-4">
            <div className="w-16 h-16 rounded-full bg-stone-300/60 overflow-hidden flex-shrink-0 flex items-center justify-center">
              {prospect.profile_picture_url ? (
                <img
                  src={prospect.profile_picture_url}
                  alt=""
                  className="w-full h-full object-cover"
                />
              ) : (
                <span className="text-xl font-medium text-muted-foreground">
                  {prospect.full_name.charAt(0).toUpperCase()}
                </span>
              )}
            </div>
            <div className="flex-1 min-w-0">
              <h3 className="text-lg font-semibold">{prospect.full_name}</h3>
              {currentPosition ? (
                <p className="text-sm text-muted-foreground">
                  {currentPosition.job_title} @ {currentPosition.company_name}
                </p>
              ) : (
                <p className="text-sm text-muted-foreground">Student</p>
              )}
              {(prospect.location_city || prospect.location_state) && (
                <p className="text-sm text-muted-foreground">
                  {[prospect.location_city, prospect.location_state]
                    .filter(Boolean)
                    .join(', ')}
                </p>
              )}
            </div>
          </div>

          {/* Match score */}
          <MatchScoreBar
            score={prospect.match_score}
            tier={prospect.match_tier}
          />

          {/* Bio */}
          {prospect.bio && (
            <div>
              <h4 className="text-sm font-medium mb-1">About</h4>
              <p className="text-sm text-muted-foreground">{prospect.bio}</p>
            </div>
          )}

          {/* Target */}
          <div>
            <h4 className="text-sm font-medium mb-1">Career Target</h4>
            <p className="text-sm">
              {prospect.seeker_profile.target_role && (
                <span>{prospect.seeker_profile.target_role} in </span>
              )}
              <span className="font-medium">
                {prospect.seeker_profile.target_industry}
              </span>
            </p>
          </div>

          {/* Help needed */}
          <div>
            <h4 className="text-sm font-medium mb-2">Needs Help With</h4>
            <div className="flex flex-wrap gap-1.5">
              {prospect.seeker_profile.help_types_needed.map((type) => (
                <Badge key={type} variant="secondary" className="text-xs">
                  {formatHelpType(type)}
                </Badge>
              ))}
            </div>
          </div>

          {/* Education */}
          {prospect.education.length > 0 && (
            <div>
              <h4 className="text-sm font-medium mb-2">Education</h4>
              <div className="space-y-2">
                {prospect.education.map((edu, i) => (
                  <div key={i} className="text-sm">
                    <p className="font-medium">{edu.school_name}</p>
                    {(edu.degree_type || edu.major) && (
                      <p className="text-muted-foreground">
                        {[edu.degree_type, edu.major].filter(Boolean).join(' in ')}
                      </p>
                    )}
                    {edu.graduation_year && (
                      <p className="text-muted-foreground text-xs">
                        Class of {edu.graduation_year}
                      </p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Experience */}
          {prospect.experiences.length > 0 && (
            <div>
              <h4 className="text-sm font-medium mb-2">Experience</h4>
              <div className="space-y-2">
                {prospect.experiences.map((exp, i) => (
                  <div key={i} className="text-sm">
                    <p className="font-medium">
                      {exp.job_title}
                      {exp.is_current && (
                        <Badge variant="outline" className="ml-2 text-[10px]">
                          Current
                        </Badge>
                      )}
                    </p>
                    <p className="text-muted-foreground">{exp.company_name}</p>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Interests */}
          {prospect.interests && prospect.interests.length > 0 && (
            <div>
              <h4 className="text-sm font-medium mb-2">Interests</h4>
              <div className="flex flex-wrap gap-1.5">
                {prospect.interests.map((interest) => (
                  <Badge key={interest} variant="outline" className="text-xs">
                    {interest}
                  </Badge>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Actions */}
        {!isDecided && (
          <div className="sticky bottom-0 bg-card border-t border-orange-200/30 px-4 py-3 flex gap-3">
            <Button
              variant="outline"
              className="flex-1"
              onClick={handleReject}
              disabled={loading}
            >
              Pass
            </Button>
            <Button
              className="flex-1"
              onClick={handleAccept}
              disabled={loading}
            >
              Accept
            </Button>
          </div>
        )}
      </div>
    </div>
  )
}
