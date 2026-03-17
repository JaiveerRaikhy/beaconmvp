'use client'

import { useState, useRef } from 'react'
import { createClient } from '@/lib/supabase/client'
import { uploadProfilePicture } from '@/lib/storage/supabase-storage'
import { Button } from '@/components/ui/button'
import { Camera, Loader2 } from 'lucide-react'
import { toast } from 'sonner'
import Image from 'next/image'

interface ProfilePictureUploadProps {
  currentUrl: string | null
  onUpload: (url: string) => void
}

export function ProfilePictureUpload({
  currentUrl,
  onUpload
}: ProfilePictureUploadProps) {
  const [uploading, setUploading] = useState(false)
  const fileInputRef = useRef<HTMLInputElement>(null)
  const supabase = createClient()

  const handleUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    if (!file.type.startsWith('image/')) {
      toast.error('Please upload an image file')
      return
    }

    if (file.size > 5 * 1024 * 1024) {
      toast.error('Image must be less than 5MB')
      return
    }

    setUploading(true)

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) throw new Error('Not authenticated')

      const url = await uploadProfilePicture(user.id, file)
      onUpload(url)
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to upload image'
      toast.error(message)
    } finally {
      setUploading(false)
    }
  }

  return (
    <div className="relative">
      <div
        className="w-32 h-32 rounded-full bg-orange-100/30 flex items-center justify-center overflow-hidden cursor-pointer border-2 border-dashed border-orange-300/30 hover:border-primary transition-colors"
        onClick={() => fileInputRef.current?.click()}
      >
        {currentUrl ? (
          <Image
            src={currentUrl}
            alt="Profile"
            width={128}
            height={128}
            className="object-cover w-full h-full"
          />
        ) : (
          <Camera className="w-8 h-8 text-muted-foreground" />
        )}

        {uploading && (
          <div className="absolute inset-0 bg-black/50 flex items-center justify-center rounded-full">
            <Loader2 className="w-6 h-6 text-white animate-spin" />
          </div>
        )}
      </div>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/jpeg,image/png,image/webp"
        className="hidden"
        onChange={handleUpload}
        disabled={uploading}
      />

      <Button
        size="sm"
        variant="outline"
        className="absolute bottom-0 right-0 rounded-full w-8 h-8 p-0"
        onClick={() => fileInputRef.current?.click()}
        disabled={uploading}
      >
        <Camera className="w-4 h-4" />
      </Button>
    </div>
  )
}
