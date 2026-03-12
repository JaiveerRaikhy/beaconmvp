-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- USERS TABLE (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  profile_picture_url TEXT,
  location_city TEXT,
  location_state TEXT,
  bio TEXT,
  is_seeker BOOLEAN DEFAULT false,
  is_giver BOOLEAN DEFAULT false,
  onboarding_completed BOOLEAN DEFAULT false,
  typing_indicators_enabled BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- EDUCATION TABLE
CREATE TABLE IF NOT EXISTS public.education (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  school_name TEXT NOT NULL,
  university_id UUID REFERENCES public.universities(id) ON DELETE SET NULL,
  degree_type TEXT,
  major TEXT,
  graduation_year INTEGER,
  gpa DECIMAL(3,2),
  gpa_scale DECIMAL(4,1) DEFAULT 4.0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- EXPERIENCES TABLE
CREATE TABLE IF NOT EXISTS public.experiences (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  company_name TEXT NOT NULL,
  job_title TEXT NOT NULL,
  start_date DATE,
  end_date DATE,
  is_current BOOLEAN DEFAULT false,
  is_internship BOOLEAN DEFAULT false,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- EXTRACURRICULARS TABLE
CREATE TABLE IF NOT EXISTS public.extracurriculars (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  organization_name TEXT NOT NULL,
  role TEXT,
  start_date DATE,
  end_date DATE,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- SEEKER PROFILE
CREATE TABLE IF NOT EXISTS public.seeker_profiles (
  user_id UUID PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  target_industry TEXT,
  target_role TEXT,
  target_companies TEXT[],
  goal_type TEXT,
  goal_text TEXT,
  help_types_needed TEXT[],
  resume_url TEXT,
  is_first_gen BOOLEAN DEFAULT false,
  is_underrepresented BOOLEAN DEFAULT false,
  received_financial_aid BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- GIVER PROFILE
CREATE TABLE IF NOT EXISTS public.giver_profiles (
  user_id UUID PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  industries_can_advise TEXT[],
  companies_can_advise TEXT[],
  help_types_offered TEXT[],
  factor_rankings JSONB,
  prioritize_underrepresented BOOLEAN DEFAULT false,
  experience_level INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- INTERESTS (Reference Table)
CREATE TABLE IF NOT EXISTS public.interests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  category TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- USER INTERESTS (Join Table)
CREATE TABLE IF NOT EXISTS public.user_interests (
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  interest_id UUID NOT NULL REFERENCES public.interests(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, interest_id)
);

-- MATCHES TABLE
CREATE TABLE IF NOT EXISTS public.matches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  giver_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  seeker_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  match_score INTEGER,
  llm_reason TEXT,
  status TEXT DEFAULT 'pending',
  accepted_at TIMESTAMPTZ,
  first_message_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(giver_id, seeker_id)
);

-- MESSAGES TABLE
CREATE TABLE IF NOT EXISTS public.messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  match_id UUID NOT NULL REFERENCES public.matches(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  attachments JSONB,
  read_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- IMPACT EVENTS TABLE
CREATE TABLE IF NOT EXISTS public.impact_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  seeker_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL,
  message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- IMPACT TAGS
CREATE TABLE IF NOT EXISTS public.impact_tags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  impact_event_id UUID NOT NULL REFERENCES public.impact_events(id) ON DELETE CASCADE,
  giver_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  notified_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
