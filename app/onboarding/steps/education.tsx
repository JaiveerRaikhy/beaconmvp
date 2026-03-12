'use client'

import { useState } from 'react'
import { useOnboarding, type EducationEntry } from '@/hooks/use-onboarding'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card } from '@/components/ui/card'
import { DEGREE_TYPES, GPA_SCALES } from '@/lib/data/degree-types'
import { UniversityAutocomplete } from '@/components/forms/university-autocomplete'
import { Plus, Trash2, GraduationCap } from 'lucide-react'

export function Education() {
  const { education, addEducation, removeEducation } = useOnboarding()
  const [showForm, setShowForm] = useState(education.length === 0)

  const [schoolName, setSchoolName] = useState('')
  const [universityId, setUniversityId] = useState<string | null>(null)
  const [degreeType, setDegreeType] = useState('')
  const [major, setMajor] = useState('')
  const [graduationYear, setGraduationYear] = useState('')
  const [gpa, setGpa] = useState('')
  const [gpaScale, setGpaScale] = useState('4.0')

  const resetForm = () => {
    setSchoolName('')
    setUniversityId(null)
    setDegreeType('')
    setMajor('')
    setGraduationYear('')
    setGpa('')
    setGpaScale('4.0')
  }

  const handleAdd = () => {
    if (!schoolName || !degreeType || !major || !graduationYear) return

    const entry: EducationEntry = {
      id: crypto.randomUUID(),
      schoolName,
      universityId,
      degreeType,
      major,
      graduationYear: parseInt(graduationYear),
      gpa: gpa ? parseFloat(gpa) : 0,
      gpaScale: parseFloat(gpaScale),
    }

    addEducation(entry)
    resetForm()
    setShowForm(false)
  }

  const currentYear = new Date().getFullYear()
  const years = Array.from({ length: 10 }, (_, i) => currentYear + 5 - i)

  return (
    <div className="space-y-4">
      {education.map((entry) => (
        <Card key={entry.id} className="p-4">
          <div className="flex items-start justify-between">
            <div className="flex gap-3">
              <GraduationCap className="w-5 h-5 text-emerald-500 mt-0.5 shrink-0" />
              <div>
                <p className="font-medium">{entry.schoolName}</p>
                <p className="text-sm text-muted-foreground">
                  {DEGREE_TYPES.find(d => d.id === entry.degreeType)?.label || entry.degreeType} in {entry.major}
                </p>
                <p className="text-sm text-muted-foreground">
                  Class of {entry.graduationYear}
                  {entry.gpa > 0 && ` · ${entry.gpa}/${entry.gpaScale} GPA`}
                </p>
              </div>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={() => removeEducation(entry.id)}
              className="text-red-500 hover:text-red-700"
            >
              <Trash2 className="w-4 h-4" />
            </Button>
          </div>
        </Card>
      ))}

      {showForm ? (
        <Card className="p-4 space-y-4 border-dashed">
          <div className="space-y-2">
            <Label htmlFor="school">School Name *</Label>
            <UniversityAutocomplete
              id="school"
              value={schoolName}
              onChange={(name, uniId) => {
                setSchoolName(name)
                setUniversityId(uniId)
              }}
              placeholder="Search for your university..."
            />
          </div>

          <div className="grid gap-4 sm:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="degree">Degree *</Label>
              <select
                id="degree"
                className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
                value={degreeType}
                onChange={(e) => setDegreeType(e.target.value)}
              >
                <option value="">Select degree</option>
                {DEGREE_TYPES.map(d => (
                  <option key={d.id} value={d.id}>{d.label}</option>
                ))}
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="major">Major/Field of Study *</Label>
              <Input
                id="major"
                placeholder="Computer Science"
                value={major}
                onChange={(e) => setMajor(e.target.value)}
              />
            </div>
          </div>

          <div className="grid gap-4 sm:grid-cols-3">
            <div className="space-y-2">
              <Label htmlFor="gradYear">Graduation Year *</Label>
              <select
                id="gradYear"
                className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
                value={graduationYear}
                onChange={(e) => setGraduationYear(e.target.value)}
              >
                <option value="">Select year</option>
                {years.map(y => (
                  <option key={y} value={y}>{y}</option>
                ))}
              </select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="gpa">GPA (optional)</Label>
              <Input
                id="gpa"
                type="number"
                step="0.01"
                min="0"
                placeholder="3.80"
                value={gpa}
                onChange={(e) => setGpa(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="gpaScale">Scale</Label>
              <select
                id="gpaScale"
                className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
                value={gpaScale}
                onChange={(e) => setGpaScale(e.target.value)}
              >
                {GPA_SCALES.map(s => (
                  <option key={s.value} value={s.value}>{s.label}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="flex gap-2 justify-end">
            {education.length > 0 && (
              <Button variant="outline" onClick={() => { resetForm(); setShowForm(false) }}>
                Cancel
              </Button>
            )}
            <Button
              onClick={handleAdd}
              disabled={!schoolName || !degreeType || !major || !graduationYear}
            >
              Add Education
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
          Add Another School
        </Button>
      )}
    </div>
  )
}
