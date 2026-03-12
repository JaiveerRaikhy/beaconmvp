import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'
import { validateFileExtension } from '@/lib/security/sanitize'

const ALLOWED_EXTENSIONS = ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png', 'gif']
const MAX_FILE_SIZE = 10 * 1024 * 1024 // 10MB
const SIGNED_URL_EXPIRY = 3600 // 1 hour

// Magic byte signatures for allowed file types
const MAGIC_BYTES: { mime: string; bytes: number[]; offset?: number }[] = [
  { mime: 'image/jpeg', bytes: [0xFF, 0xD8, 0xFF] },
  { mime: 'image/png', bytes: [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A] },
  { mime: 'image/gif', bytes: [0x47, 0x49, 0x46, 0x38] },
  { mime: 'application/pdf', bytes: [0x25, 0x50, 0x44, 0x46] }, // %PDF
  // MS Office (doc/docx) - ZIP-based or OLE compound
  { mime: 'application/zip', bytes: [0x50, 0x4B, 0x03, 0x04] }, // ZIP (docx)
  { mime: 'application/msword', bytes: [0xD0, 0xCF, 0x11, 0xE0] }, // OLE (doc)
]

// Map file extensions to expected MIME categories
const EXTENSION_MIME_MAP: Record<string, string[]> = {
  jpg: ['image/jpeg'],
  jpeg: ['image/jpeg'],
  png: ['image/png'],
  gif: ['image/gif'],
  pdf: ['application/pdf'],
  doc: ['application/msword'],
  docx: ['application/zip'],
  txt: [], // text files have no reliable magic bytes
}

function detectMimeFromBytes(buffer: ArrayBuffer): string | null {
  const bytes = new Uint8Array(buffer)
  for (const sig of MAGIC_BYTES) {
    const offset = sig.offset ?? 0
    if (bytes.length < offset + sig.bytes.length) continue
    const match = sig.bytes.every((b, i) => bytes[offset + i] === b)
    if (match) return sig.mime
  }
  return null
}

export async function POST(request: Request) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const formData = await request.formData()
  const file = formData.get('file') as File
  const matchId = formData.get('matchId') as string

  if (!file || !matchId) {
    return NextResponse.json({ error: 'Missing file or matchId' }, { status: 400 })
  }

  // Validate empty file
  if (file.size === 0) {
    return NextResponse.json({ error: 'File is empty' }, { status: 400 })
  }

  // Validate file size
  if (file.size > MAX_FILE_SIZE) {
    return NextResponse.json({ error: 'File too large (10MB max)' }, { status: 400 })
  }

  // Validate file extension
  if (!validateFileExtension(file.name, ALLOWED_EXTENSIONS)) {
    return NextResponse.json({ error: 'File type not allowed' }, { status: 400 })
  }

  // Validate actual content via magic bytes
  const ext = file.name.split('.').pop()?.toLowerCase() ?? ''
  const expectedMimes = EXTENSION_MIME_MAP[ext] ?? []

  if (expectedMimes.length > 0) {
    const buffer = await file.arrayBuffer()
    const detectedMime = detectMimeFromBytes(buffer)

    if (!detectedMime || !expectedMimes.includes(detectedMime)) {
      return NextResponse.json(
        { error: 'File content does not match declared type' },
        { status: 400 }
      )
    }
  }

  // Verify user is part of this match
  const { data: match } = await supabase
    .from('matches')
    .select('giver_id, seeker_id')
    .eq('id', matchId)
    .single()

  if (!match || (match.giver_id !== user.id && match.seeker_id !== user.id)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  // Sanitize filename: strip path separators, null bytes, and dangerous chars
  const sanitizedFilename = file.name
    .replace(/[/\\:\0]/g, '') // Remove path separators and null bytes
    .replace(/\.\./g, '')     // Remove path traversal sequences
    .replace(/[<>"|?*]/g, '') // Remove chars unsafe on some filesystems
    .slice(0, 200)            // Limit filename length
    || 'unnamed'              // Fallback if filename becomes empty

  // Upload to attachments bucket
  const fileName = `${matchId}/${Date.now()}-${sanitizedFilename}`

  const { error } = await supabase.storage
    .from('attachments')
    .upload(fileName, file)

  if (error) {
    console.error('Upload error:', error)
    return NextResponse.json({ error: 'Upload failed' }, { status: 500 })
  }

  // Generate signed URL instead of public URL
  const { data: urlData, error: signError } = await supabase.storage
    .from('attachments')
    .createSignedUrl(fileName, SIGNED_URL_EXPIRY)

  if (signError || !urlData) {
    console.error('Signed URL error:', signError)
    return NextResponse.json({ error: 'Upload failed' }, { status: 500 })
  }

  return NextResponse.json({
    url: urlData.signedUrl,
    path: fileName,
    filename: sanitizedFilename,
    size: file.size,
    type: file.type,
  })
}
