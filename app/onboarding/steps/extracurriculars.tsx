'use client'

import { useState } from 'react'
import { useOnboarding, type ExtracurricularEntry } from '@/hooks/use-onboarding'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card } from '@/components/ui/card'
import { Plus, Trash2, Users } from 'lucide-react'

export function Extracurriculars() {
  const { extracurriculars, addExtracurricular, removeExtracurricular } = useOnboarding()
  const [showForm, setShowForm] = useState(false)

  const [orgName, setOrgName] = useState('')
  const [role, setRole] = useState('')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')
  const [description, setDescription] = useState('')

  const resetForm = () => {
    setOrgName('')
    setRole('')
    setStartDate('')
    setEndDate('')
    setDescription('')
  }

  const handleAdd = () => {
    if (!orgName || !role) return

    const entry: ExtracurricularEntry = {
      id: crypto.randomUUID(),
      organizationName: orgName,
      role,
      startDate: startDate || '',
      endDate: endDate || null,
      description,
    }

    addExtracurricular(entry)
    resetForm()
    setShowForm(false)
  }

  return (
    <div className="space-y-4">
      <p className="text-sm text-muted-foreground text-center">
        This step is optional. Add clubs, organizations, or volunteer activities.
      </p>

      {extracurriculars.map((entry) => (
        <Card key={entry.id} className="p-4">
          <div className="flex items-start justify-between">
            <div className="flex gap-3">
              <Users className="w-5 h-5 text-emerald-500 mt-0.5 shrink-0" />
              <div>
                <p className="font-medium">{entry.organizationName}</p>
                <p className="text-sm text-muted-foreground">{entry.role}</p>
                {(entry.startDate || entry.endDate) && (
                  <p className="text-sm text-muted-foreground">
                    {entry.startDate || '?'} — {entry.endDate || 'Present'}
                  </p>
                )}
                {entry.description && (
                  <p className="text-sm mt-1 line-clamp-2">{entry.description}</p>
                )}
              </div>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => removeExtracurricular(entry.id)}
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
              <Label htmlFor="orgName">Organization *</Label>
              <Input
                id="orgName"
                placeholder="Debate Club"
                value={orgName}
                onChange={(e) => setOrgName(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="role">Your Role *</Label>
              <Input
                id="role"
                placeholder="President"
                value={role}
                onChange={(e) => setRole(e.target.value)}
              />
            </div>
          </div>

          <div className="grid gap-4 sm:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="ecStartDate">Start Date</Label>
              <Input
                id="ecStartDate"
                type="month"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="ecEndDate">End Date</Label>
              <Input
                id="ecEndDate"
                type="month"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="ecDescription">Description (optional)</Label>
            <textarea
              id="ecDescription"
              className="w-full min-h-[60px] px-3 py-2 rounded-md border border-input bg-background text-sm resize-y"
              placeholder="What did you do?"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              maxLength={300}
            />
          </div>

          <div className="flex gap-2 justify-end">
            <Button variant="outline" onClick={() => { resetForm(); setShowForm(false) }}>
              Cancel
            </Button>
            <Button
              onClick={handleAdd}
              disabled={!orgName || !role}
            >
              Add Activity
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
          Add Activity
        </Button>
      )}
    </div>
  )
}
