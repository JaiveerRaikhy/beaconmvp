'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { X } from 'lucide-react'

interface CalendarModalProps {
  onClose: () => void
  otherPersonName: string
}

export function CalendarModal({ onClose, otherPersonName }: CalendarModalProps) {
  const [date, setDate] = useState('')
  const [time, setTime] = useState('')
  const [duration, setDuration] = useState('30')
  const [title, setTitle] = useState(`Beacon Call with ${otherPersonName}`)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()

    // Create .ics file content
    const startDate = new Date(`${date}T${time}`)
    const endDate = new Date(startDate.getTime() + parseInt(duration) * 60000)

    const formatIcsDate = (d: Date) => {
      return d.toISOString().replace(/[-:]/g, '').split('.')[0] + 'Z'
    }

    const icsContent = `BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Beacon//Call//EN
BEGIN:VEVENT
UID:${Date.now()}@beacon.app
DTSTART:${formatIcsDate(startDate)}
DTEND:${formatIcsDate(endDate)}
SUMMARY:${title}
DESCRIPTION:Scheduled via Beacon
END:VEVENT
END:VCALENDAR`

    // Download .ics file
    const blob = new Blob([icsContent], { type: 'text/calendar' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = 'beacon-call.ics'
    a.click()
    URL.revokeObjectURL(url)

    onClose()
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <Card className="w-full max-w-md">
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-4">
          <CardTitle className="text-lg">Schedule a Call</CardTitle>
          <Button variant="ghost" size="icon" onClick={onClose}>
            <X className="w-5 h-5" />
          </Button>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="cal-title">Meeting Title</Label>
              <Input
                id="cal-title"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="cal-date">Date</Label>
                <Input
                  id="cal-date"
                  type="date"
                  value={date}
                  onChange={(e) => setDate(e.target.value)}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="cal-time">Time</Label>
                <Input
                  id="cal-time"
                  type="time"
                  value={time}
                  onChange={(e) => setTime(e.target.value)}
                  required
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="cal-duration">Duration</Label>
              <select
                id="cal-duration"
                value={duration}
                onChange={(e) => setDuration(e.target.value)}
                className="w-full h-10 px-3 rounded-md border border-input bg-background text-sm"
              >
                <option value="15">15 minutes</option>
                <option value="30">30 minutes</option>
                <option value="45">45 minutes</option>
                <option value="60">1 hour</option>
              </select>
            </div>

            <div className="flex gap-2 pt-2">
              <Button type="button" variant="outline" onClick={onClose} className="flex-1">
                Cancel
              </Button>
              <Button type="submit" className="flex-1">
                Download Invite
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
