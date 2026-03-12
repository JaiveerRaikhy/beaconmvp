import { getCsrfToken } from '@/lib/security/csrf'
import { NextResponse } from 'next/server'

export async function GET() {
  const token = await getCsrfToken()
  return NextResponse.json({ token })
}
