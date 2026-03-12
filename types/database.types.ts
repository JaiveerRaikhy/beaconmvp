export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string
          email: string
          full_name: string | null
          profile_picture_url: string | null
          location_city: string | null
          location_state: string | null
          bio: string | null
          is_seeker: boolean
          is_giver: boolean
          onboarding_completed: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          email: string
          full_name?: string | null
          profile_picture_url?: string | null
          location_city?: string | null
          location_state?: string | null
          bio?: string | null
          is_seeker?: boolean
          is_giver?: boolean
          onboarding_completed?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          email?: string
          full_name?: string | null
          profile_picture_url?: string | null
          location_city?: string | null
          location_state?: string | null
          bio?: string | null
          is_seeker?: boolean
          is_giver?: boolean
          onboarding_completed?: boolean
          created_at?: string
          updated_at?: string
        }
      }
      education: {
        Row: {
          id: string
          user_id: string
          school_name: string
          degree_type: string | null
          major: string | null
          graduation_year: number | null
          gpa: number | null
          gpa_scale: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          school_name: string
          degree_type?: string | null
          major?: string | null
          graduation_year?: number | null
          gpa?: number | null
          gpa_scale?: number
        }
        Update: {
          school_name?: string
          degree_type?: string | null
          major?: string | null
          graduation_year?: number | null
          gpa?: number | null
          gpa_scale?: number
        }
      }
      experiences: {
        Row: {
          id: string
          user_id: string
          company_name: string
          job_title: string
          start_date: string | null
          end_date: string | null
          is_current: boolean
          is_internship: boolean
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          company_name: string
          job_title: string
          start_date?: string | null
          end_date?: string | null
          is_current?: boolean
          is_internship?: boolean
          description?: string | null
        }
        Update: {
          company_name?: string
          job_title?: string
          start_date?: string | null
          end_date?: string | null
          is_current?: boolean
          is_internship?: boolean
          description?: string | null
        }
      }
      matches: {
        Row: {
          id: string
          giver_id: string
          seeker_id: string
          match_score: number | null
          llm_reason: string | null
          status: string
          accepted_at: string | null
          first_message_at: string | null
          expires_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          giver_id: string
          seeker_id: string
          match_score?: number | null
          llm_reason?: string | null
          status?: string
          accepted_at?: string | null
          first_message_at?: string | null
          expires_at?: string | null
        }
        Update: {
          match_score?: number | null
          llm_reason?: string | null
          status?: string
          accepted_at?: string | null
          first_message_at?: string | null
          expires_at?: string | null
        }
      }
      messages: {
        Row: {
          id: string
          match_id: string
          sender_id: string
          content: string
          attachments: Json | null
          read_at: string | null
          created_at: string
        }
        Insert: {
          id?: string
          match_id: string
          sender_id: string
          content: string
          attachments?: Json | null
          read_at?: string | null
        }
        Update: {
          content?: string
          attachments?: Json | null
          read_at?: string | null
        }
      }
      universities: {
        Row: {
          id: string
          name: string
          location: string
          tier: number
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          location: string
          tier: number
        }
        Update: {
          name?: string
          location?: string
          tier?: number
        }
      }
    }
  }
}
