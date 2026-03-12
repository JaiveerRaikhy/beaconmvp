'use client'

import { useOnboarding } from '@/hooks/use-onboarding'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { INDUSTRIES, GOAL_TYPES } from '@/lib/data/industries'
import { cn } from '@/lib/utils'
import { X } from 'lucide-react'

export function SeekerGoals() {
  const {
    targetIndustry,
    targetRole,
    targetCompanies,
    goalType,
    goalText,
    isFirstGen,
    isUnderrepresented,
    receivedFinancialAid,
    updateField,
  } = useOnboarding()

  const addCompany = (company: string) => {
    if (company && !targetCompanies.includes(company)) {
      updateField('targetCompanies', [...targetCompanies, company])
    }
  }

  const removeCompany = (company: string) => {
    updateField('targetCompanies', targetCompanies.filter(c => c !== company))
  }

  return (
    <div className="space-y-6">
      <div className="space-y-2">
        <Label htmlFor="goalType">What&apos;s your primary goal?</Label>
        <div className="grid gap-2 sm:grid-cols-2">
          {GOAL_TYPES.map(goal => (
            <button
              key={goal.id}
              className={cn(
                'text-left px-4 py-3 rounded-lg border text-sm transition-colors',
                goalType === goal.id
                  ? 'border-emerald-500 bg-emerald-500/10 text-emerald-500'
                  : 'border-input hover:bg-accent/50'
              )}
              onClick={() => updateField('goalType', goal.id)}
            >
              {goal.label}
            </button>
          ))}
        </div>
      </div>

      {goalType === 'other' && (
        <div className="space-y-2">
          <Label htmlFor="goalText">Describe your goal</Label>
          <Input
            id="goalText"
            placeholder="I want to..."
            value={goalText}
            onChange={(e) => updateField('goalText', e.target.value)}
          />
        </div>
      )}

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-2">
          <Label htmlFor="targetIndustry">Target Industry</Label>
          <select
            id="targetIndustry"
            className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
            value={targetIndustry}
            onChange={(e) => updateField('targetIndustry', e.target.value)}
          >
            <option value="">Select industry</option>
            {INDUSTRIES.map(industry => (
              <option key={industry} value={industry}>{industry}</option>
            ))}
          </select>
        </div>

        <div className="space-y-2">
          <Label htmlFor="targetRole">Target Role</Label>
          <Input
            id="targetRole"
            placeholder="Product Manager"
            value={targetRole}
            onChange={(e) => updateField('targetRole', e.target.value)}
          />
        </div>
      </div>

      <div className="space-y-2">
        <Label>Target Companies (optional)</Label>
        <div className="flex gap-2">
          <Input
            placeholder="Add a company and press Enter"
            onKeyDown={(e) => {
              if (e.key === 'Enter') {
                e.preventDefault()
                addCompany((e.target as HTMLInputElement).value.trim())
                ;(e.target as HTMLInputElement).value = ''
              }
            }}
          />
        </div>
        {targetCompanies.length > 0 && (
          <div className="flex flex-wrap gap-2 mt-2">
            {targetCompanies.map(company => (
              <span
                key={company}
                className="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-slate-400/10 text-sm"
              >
                {company}
                <X className="w-3 h-3 cursor-pointer" onClick={() => removeCompany(company)} />
              </span>
            ))}
          </div>
        )}
      </div>

      <div className="space-y-3 pt-4 border-t">
        <p className="text-sm font-medium">Background (optional, helps with matching)</p>
        <label className="flex items-center gap-2 text-sm cursor-pointer">
          <input
            type="checkbox"
            checked={isFirstGen}
            onChange={(e) => updateField('isFirstGen', e.target.checked)}
            className="rounded border-slate-400/20"
          />
          First-generation college student
        </label>
        <label className="flex items-center gap-2 text-sm cursor-pointer">
          <input
            type="checkbox"
            checked={isUnderrepresented}
            onChange={(e) => updateField('isUnderrepresented', e.target.checked)}
            className="rounded border-slate-400/20"
          />
          From an underrepresented background
        </label>
        <label className="flex items-center gap-2 text-sm cursor-pointer">
          <input
            type="checkbox"
            checked={receivedFinancialAid}
            onChange={(e) => updateField('receivedFinancialAid', e.target.checked)}
            className="rounded border-slate-400/20"
          />
          Received financial aid
        </label>
      </div>
    </div>
  )
}
