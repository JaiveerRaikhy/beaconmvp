import { z } from 'zod'

const uuidPattern = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

export const acceptMatchSchema = z.object({
  seekerId: z.string().regex(uuidPattern, 'Invalid seeker ID format'),
  matchScore: z.number().min(0).max(100).optional(),
})

export const rejectMatchSchema = z.object({
  seekerId: z.string().regex(uuidPattern, 'Invalid seeker ID format'),
})
