'use client'

import { useState, useEffect, useCallback, useMemo } from 'react'
import {
  ProspectCard,
  type ProspectData,
} from '@/components/matching/prospect-card'
import { ProspectFilters } from '@/components/matching/prospect-filters'
import { ProspectDetailModal } from '@/components/matching/prospect-detail-modal'
import { Button } from '@/components/ui/button'
import { Card, CardContent } from '@/components/ui/card'
import { cn } from '@/lib/utils'
import { toast } from 'sonner'
import { useRouter } from 'next/navigation'
import { useCsrf } from '@/hooks/use-csrf'

export default function BrowsePage() {
  const [prospects, setProspects] = useState<ProspectData[]>([])
  const [loading, setLoading] = useState(true)
  const [decisions, setDecisions] = useState<
    Record<string, 'accepted' | 'rejected'>
  >({})
  const [selectedProspect, setSelectedProspect] = useState<ProspectData | null>(
    null
  )

  // Filters
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedTier, setSelectedTier] = useState<string | null>(null)
  const [selectedIndustry, setSelectedIndustry] = useState<string | null>(null)

  const router = useRouter()
  const csrfToken = useCsrf()

  const fetchProspects = useCallback(async () => {
    setLoading(true)
    try {
      const res = await fetch('/api/matching/prospects')
      const data = await res.json()
      setProspects(data.prospects || [])
      setDecisions({})
    } catch {
      toast.error('Failed to load prospects. Please try again.')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchProspects()
  }, [fetchProspects])

  // Derive unique industries from prospects
  const industries = useMemo(() => {
    const set = new Set(
      prospects.map((p) => p.seeker_profile.target_industry).filter(Boolean)
    )
    return Array.from(set).sort()
  }, [prospects])

  // Apply client-side filters
  const filteredProspects = useMemo(() => {
    let result = prospects

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase()
      result = result.filter((p) => {
        const nameMatch = p.full_name.toLowerCase().includes(q)
        const schoolMatch = p.education.some((e) =>
          e.school_name.toLowerCase().includes(q)
        )
        const roleMatch =
          p.seeker_profile.target_role?.toLowerCase().includes(q)
        const companyMatch = p.experiences.some((e) =>
          e.company_name.toLowerCase().includes(q)
        )
        return nameMatch || schoolMatch || roleMatch || companyMatch
      })
    }

    if (selectedTier) {
      result = result.filter((p) => p.match_tier === selectedTier)
    }

    if (selectedIndustry) {
      result = result.filter(
        (p) => p.seeker_profile.target_industry === selectedIndustry
      )
    }

    return result
  }, [prospects, searchQuery, selectedTier, selectedIndustry])

  const hasActiveFilters =
    searchQuery.trim() !== '' ||
    selectedTier !== null ||
    selectedIndustry !== null

  const resetFilters = () => {
    setSearchQuery('')
    setSelectedTier(null)
    setSelectedIndustry(null)
  }

  const handleAccept = async (id: string, score: number) => {
    try {
      const res = await fetch('/api/matching/accept', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          ...(csrfToken ? { 'x-csrf-token': csrfToken } : {}),
        },
        body: JSON.stringify({ seekerId: id, matchScore: score }),
      })

      if (res.ok) {
        setDecisions((prev) => ({ ...prev, [id]: 'accepted' }))
      } else {
        toast.error('Failed to accept prospect. Please try again.')
      }
    } catch {
      toast.error('Failed to accept prospect. Please try again.')
    }
  }

  const handleReject = async (id: string) => {
    try {
      const res = await fetch('/api/matching/reject', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          ...(csrfToken ? { 'x-csrf-token': csrfToken } : {}),
        },
        body: JSON.stringify({ seekerId: id }),
      })

      if (res.ok) {
        setDecisions((prev) => ({ ...prev, [id]: 'rejected' }))
      } else {
        toast.error('Failed to pass on prospect. Please try again.')
      }
    } catch {
      toast.error('Failed to pass on prospect. Please try again.')
    }
  }

  const undecidedCount = filteredProspects.filter(
    (p) => !decisions[p.id]
  ).length
  const allDecided = prospects.length > 0 && undecidedCount === 0

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="w-6 h-6 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  if (prospects.length === 0) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold">Find New Prospects</h1>
          <Button variant="outline" onClick={() => router.back()}>
            Back
          </Button>
        </div>

        <Card>
          <CardContent className="py-12 text-center">
            <p className="text-muted-foreground">
              No new prospects right now. Check back later as new students join.
            </p>
            <Button
              variant="outline"
              className="mt-4"
              onClick={fetchProspects}
            >
              Refresh
            </Button>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold">Find New Prospects</h1>
          <p className="text-sm text-muted-foreground mt-1">
            {filteredProspects.length} prospect
            {filteredProspects.length !== 1 ? 's' : ''} found
            {hasActiveFilters ? ' (filtered)' : ''}
          </p>
        </div>
        <Button variant="outline" onClick={() => router.back()}>
          Back
        </Button>
      </div>

      {/* Filters */}
      <ProspectFilters
        searchQuery={searchQuery}
        onSearchChange={setSearchQuery}
        selectedTier={selectedTier}
        onTierChange={setSelectedTier}
        selectedIndustry={selectedIndustry}
        onIndustryChange={setSelectedIndustry}
        industries={industries}
        onReset={resetFilters}
        hasActiveFilters={hasActiveFilters}
      />

      <p className="text-muted-foreground text-sm">
        Review these students and decide who you&apos;d like to help.
      </p>

      {filteredProspects.length === 0 ? (
        <Card>
          <CardContent className="py-8 text-center">
            <p className="text-muted-foreground">
              No prospects match your filters.
            </p>
            <Button
              variant="ghost"
              size="sm"
              className="mt-2"
              onClick={resetFilters}
            >
              Clear filters
            </Button>
          </CardContent>
        </Card>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {filteredProspects.map((prospect) => (
            <div
              key={prospect.id}
              className={cn(
                'transition-opacity',
                decisions[prospect.id] && 'opacity-50 pointer-events-none'
              )}
            >
              <ProspectCard
                prospect={prospect}
                onAccept={handleAccept}
                onReject={handleReject}
                onView={setSelectedProspect}
              />
              {decisions[prospect.id] && (
                <p className="text-center text-sm mt-2 font-medium">
                  {decisions[prospect.id] === 'accepted'
                    ? 'Accepted'
                    : 'Passed'}
                </p>
              )}
            </div>
          ))}
        </div>
      )}

      {allDecided && (
        <div className="text-center">
          <Button onClick={fetchProspects}>Load More Prospects</Button>
        </div>
      )}

      {/* Detail Modal */}
      <ProspectDetailModal
        prospect={selectedProspect}
        onClose={() => setSelectedProspect(null)}
        onAccept={handleAccept}
        onReject={handleReject}
        isDecided={
          selectedProspect ? Boolean(decisions[selectedProspect.id]) : false
        }
      />
    </div>
  )
}
