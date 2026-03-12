'use client'

import { useState, useRef } from 'react'
import { useOnboarding } from '@/hooks/use-onboarding'
import { createClient } from '@/lib/supabase/client'
import { uploadResume } from '@/lib/storage/supabase-storage'
import { Button } from '@/components/ui/button'
import { FileText, Upload, Loader2, Check, X } from 'lucide-react'

export function Resume() {
  const { resumeUrl, updateField } = useOnboarding()
  const [uploading, setUploading] = useState(false)
  const [fileName, setFileName] = useState<string | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)
  const supabase = createClient()

  const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    if (file.type !== 'application/pdf') {
      alert('Please upload a PDF file')
      return
    }

    if (file.size > 10 * 1024 * 1024) {
      alert('File must be less than 10MB')
      return
    }

    setUploading(true)

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) throw new Error('Not authenticated')

      const path = await uploadResume(user.id, file)
      updateField('resumeUrl', path)
      setFileName(file.name)
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to upload resume'
      alert(message)
    } finally {
      setUploading(false)
    }
  }

  const handleRemove = () => {
    updateField('resumeUrl', null)
    setFileName(null)
    if (fileInputRef.current) {
      fileInputRef.current.value = ''
    }
  }

  return (
    <div className="space-y-4">
      <p className="text-sm text-muted-foreground text-center">
        Upload your resume so mentors can review it. This step is optional.
      </p>

      {resumeUrl ? (
        <div className="flex items-center gap-3 p-4 rounded-lg border border-[rgba(16,185,129,0.2)] bg-emerald-500/10">
          <Check className="w-5 h-5 text-emerald-500 shrink-0" />
          <div className="flex-1">
            <p className="text-sm font-medium text-emerald-500">Resume uploaded</p>
            <p className="text-xs text-emerald-500">{fileName || 'resume.pdf'}</p>
          </div>
          <Button
            variant="ghost"
            size="sm"
            onClick={handleRemove}
            className="text-red-500 hover:text-red-700"
          >
            <X className="w-4 h-4" />
          </Button>
        </div>
      ) : (
        <div
          className="flex flex-col items-center gap-4 p-8 rounded-lg border-2 border-dashed border-slate-400/20 hover:border-emerald-500 cursor-pointer transition-colors"
          onClick={() => fileInputRef.current?.click()}
        >
          {uploading ? (
            <Loader2 className="w-10 h-10 text-emerald-500 animate-spin" />
          ) : (
            <>
              <div className="w-16 h-16 rounded-full bg-slate-700/50 flex items-center justify-center">
                <FileText className="w-8 h-8 text-muted-foreground" />
              </div>
              <div className="text-center">
                <p className="text-sm font-medium">Click to upload your resume</p>
                <p className="text-xs text-muted-foreground mt-1">PDF format, max 10MB</p>
              </div>
              <Button variant="outline" size="sm" disabled={uploading}>
                <Upload className="w-4 h-4 mr-2" />
                Choose File
              </Button>
            </>
          )}
        </div>
      )}

      <input
        ref={fileInputRef}
        type="file"
        accept="application/pdf"
        className="hidden"
        onChange={handleUpload}
        disabled={uploading}
      />
    </div>
  )
}
