'use client'

import { useState } from 'react'
import { useOnboarding, type ExperienceEntry } from '@/hooks/use-onboarding'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card } from '@/components/ui/card'
import { Plus, Trash2, Briefcase } from 'lucide-react'

export function Experience() {
  const { experiences, addExperience, removeExperience } = useOnboarding()
  const [showForm, setShowForm] = useState(experiences.length === 0)

  const [companyName, setCompanyName] = useState('')
  const [jobTitle, setJobTitle] = useState('')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')
  const [isCurrent, setIsCurrent] = useState(false)
  const [isInternship, setIsInternship] = useState(false)
  const [description, setDescription] = useState('')

  const resetForm = () => {
    setCompanyName('')
    setJobTitle('')
    setStartDate('')
    setEndDate('')
    setIsCurrent(false)
    setIsInternship(false)
    setDescription('')
  }

  const handleAdd = () => {
    if (!companyName || !jobTitle || !startDate) return

    const entry: ExperienceEntry = {
      id: crypto.randomUUID(),
      companyName,
      jobTitle,
      startDate,
      endDate: isCurrent ? null : endDate || null,
      isCurrent,
      isInternship,
      description,
    }

    addExperience(entry)
    resetForm()
    setShowForm(false)
  }

  return (
    <div className="space-y-4">
      {experiences.length === 0 && !showForm && (
        <p className="text-sm text-muted-foreground text-center py-4">
          No experience added yet. Add jobs, internships, or relevant projects.
        </p>
      )}

      {experiences.map((entry) => (
        <Card key={entry.id} className="p-4">
          <div className="flex items-start justify-between">
            <div className="flex gap-3">
              <Briefcase className="w-5 h-5 text-emerald-500 mt-0.5 shrink-0" />
              <div>
                <p className="font-medium">{entry.jobTitle}</p>
                <p className="text-sm text-muted-foreground">
                  {entry.companyName}
                  {entry.isInternship && ' · Internship'}
                </p>
                <p className="text-sm text-muted-foreground">
                  {entry.startDate} — {entry.isCurrent ? 'Present' : entry.endDate || 'N/A'}
                </p>
                {entry.description && (
                  <p className="text-sm mt-1 line-clamp-2">{entry.description}</p>
                )}
              </div>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => removeExperience(entry.id)}
              className="text-red-500 hover:text-red-700"
            >
              <Trash2 className="w-4 h-4" />
            </Button>
          </div>
        </Card>
      ))}

      {showForm ? (
        <Card className="p-4 space-y-4 border-dashed">
          <div className="grid gap-4 sm:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="company">Company *</Label>
              <Input
                id="company"
                placeholder="Google"
                value={companyName}
                onChange={(e) => setCompanyName(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="jobTitle">Job Title *</Label>
              <Input
                id="jobTitle"
                placeholder="Software Engineer"
                value={jobTitle}
                onChange={(e) => setJobTitle(e.target.value)}
              />
            </div>
          </div>

          <div className="flex gap-4">
            <label className="flex items-center gap-2 text-sm cursor-pointer">
              <input
                type="checkbox"
                checked={isInternship}
                onChange={(e) => setIsInternship(e.target.checked)}
                className="rounded border-slate-400/20"
              />
              Internship
            </label>
            <label className="flex items-center gap-2 text-sm cursor-pointer">
              <input
                type="checkbox"
                checked={isCurrent}
                onChange={(e) => setIsCurrent(e.target.checked)}
                className="rounded border-slate-400/20"
              />
              I currently work here
            </label>
          </div>

          <div className="grid gap-4 sm:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="startDate">Start Date *</Label>
              <Input
                id="startDate"
                type="month"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
              />
            </div>

            {!isCurrent && (
              <div className="space-y-2">
                <Label htmlFor="endDate">End Date</Label>
                <Input
                  id="endDate"
                  type="month"
                  value={endDate}
                  onChange={(e) => setEndDate(e.target.value)}
                />
              </div>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="description">Description (optional)</Label>
            <textarea
              id="description"
              className="w-full min-h-[80px] px-3 py-2 rounded-md border border-input bg-background text-sm resize-y"
              placeholder="What did you do? What did you learn?"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              maxLength={500}
            />
            <p className="text-xs text-muted-foreground text-right">{description.length}/500</p>
          </div>

          <div className="flex gap-2 justify-end">
            {experiences.length > 0 && (
              <Button variant="outline" onClick={() => { resetForm(); setShowForm(false) }}>
                Cancel
              </Button>
            )}
            <Button
              onClick={handleAdd}
              disabled={!companyName || !jobTitle || !startDate}
            >
              Add Experience
            </Button>
          </div>
        </Card>
      ) : (
        <Button
          variant="outline"
          onClick={() => setShowForm(true)}
          className="w-full border-dashed"
        >
          <Plus className="w-4 h-4 mr-2" />
          Add {experiences.length > 0 ? 'Another' : ''} Experience
        </Button>
      )}

      {experiences.length === 0 && (
        <p className="text-xs text-muted-foreground text-center">
          Don&apos;t have work experience yet? No problem — you can skip this step.
        </p>
      )}
    </div>
  )
}
