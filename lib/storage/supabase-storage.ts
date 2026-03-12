import { createClient } from '@/lib/supabase/client'
import { sanitizeUserId, validateFileExtension } from '@/lib/security/sanitize'

const AVATAR_MAX_SIZE = 5 * 1024 * 1024 // 5MB
const RESUME_MAX_SIZE = 10 * 1024 * 1024 // 10MB
const ALLOWED_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/webp']
const ALLOWED_IMAGE_EXTENSIONS = ['jpg', 'jpeg', 'png', 'webp']

export async function uploadProfilePicture(
  userId: string,
  file: File
): Promise<string> {
  // Validate userId to prevent path traversal
  const safeUserId = sanitizeUserId(userId)

  // Server-side file type validation
  if (!ALLOWED_IMAGE_TYPES.includes(file.type)) {
    throw new Error('Invalid file type. Allowed: JPEG, PNG, WebP')
  }

  // Server-side file extension validation
  if (!validateFileExtension(file.name, ALLOWED_IMAGE_EXTENSIONS)) {
    throw new Error('Invalid file extension. Allowed: jpg, jpeg, png, webp')
  }

  // Server-side size validation
  if (file.size > AVATAR_MAX_SIZE) {
    throw new Error('File too large. Maximum size is 5MB')
  }

  if (file.size === 0) {
    throw new Error('File is empty')
  }

  const supabase = createClient()

  // Use a safe extension derived from the validated MIME type
  const extMap: Record<string, string> = {
    'image/jpeg': 'jpg',
    'image/png': 'png',
    'image/webp': 'webp',
  }
  const fileExt = extMap[file.type] || 'jpg'
  const fileName = `${safeUserId}/avatar.${fileExt}`

  const { error } = await supabase.storage
    .from('avatars')
    .upload(fileName, file, {
      cacheControl: '3600',
      upsert: true,
    })

  if (error) throw error

  const { data } = supabase.storage
    .from('avatars')
    .getPublicUrl(fileName)

  return data.publicUrl
}

export async function uploadResume(
  userId: string,
  file: File
): Promise<string> {
  // Validate userId to prevent path traversal
  const safeUserId = sanitizeUserId(userId)

  // Server-side file type validation
  if (file.type !== 'application/pdf') {
    throw new Error('Invalid file type. Only PDF files are allowed')
  }

  // Server-side file extension validation
  if (!validateFileExtension(file.name, ['pdf'])) {
    throw new Error('Invalid file extension. Only .pdf files are allowed')
  }

  // Server-side size validation
  if (file.size > RESUME_MAX_SIZE) {
    throw new Error('File too large. Maximum size is 10MB')
  }

  if (file.size === 0) {
    throw new Error('File is empty')
  }

  const supabase = createClient()

  const fileName = `${safeUserId}/resume.pdf`

  const { error } = await supabase.storage
    .from('resumes')
    .upload(fileName, file, {
      cacheControl: '3600',
      upsert: true,
    })

  if (error) throw error

  return fileName
}

export async function getResumeUrl(path: string): Promise<string> {
  // Validate path format to prevent traversal
  if (path.includes('..') || path.startsWith('/')) {
    throw new Error('Invalid file path')
  }

  const supabase = createClient()

  const { data, error } = await supabase.storage
    .from('resumes')
    .createSignedUrl(path, 3600)

  if (error) throw error

  return data.signedUrl
}

export async function deleteFile(
  bucket: 'avatars' | 'resumes',
  path: string
): Promise<void> {
  // Validate path format to prevent traversal
  if (path.includes('..') || path.startsWith('/')) {
    throw new Error('Invalid file path')
  }

  const supabase = createClient()

  const { error } = await supabase.storage
    .from(bucket)
    .remove([path])

  if (error) throw error
}
