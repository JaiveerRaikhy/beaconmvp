-- =============================================================================
-- Fix RLS Policies for Education, Experiences, Extracurriculars
-- These need to be viewable by authenticated users for matching/profiles
-- =============================================================================

-- Drop existing restrictive policies
DROP POLICY IF EXISTS "Users can manage own education" ON public.education;
DROP POLICY IF EXISTS "Users can manage own experiences" ON public.experiences;
DROP POLICY IF EXISTS "Users can manage own extracurriculars" ON public.extracurriculars;
DROP POLICY IF EXISTS "Users can manage own seeker profile" ON public.seeker_profiles;
DROP POLICY IF EXISTS "Users can manage own giver profile" ON public.giver_profiles;
DROP POLICY IF EXISTS "Users can manage own interests" ON public.user_interests;

-- =============================================================================
-- EDUCATION: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "Education viewable by authenticated users"
  ON public.education FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own education"
  ON public.education FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own education"
  ON public.education FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own education"
  ON public.education FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- EXPERIENCES: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "Experiences viewable by authenticated users"
  ON public.experiences FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own experiences"
  ON public.experiences FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own experiences"
  ON public.experiences FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own experiences"
  ON public.experiences FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- EXTRACURRICULARS: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "Extracurriculars viewable by authenticated users"
  ON public.extracurriculars FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own extracurriculars"
  ON public.extracurriculars FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own extracurriculars"
  ON public.extracurriculars FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own extracurriculars"
  ON public.extracurriculars FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- SEEKER PROFILES: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "Seeker profiles viewable by authenticated users"
  ON public.seeker_profiles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own seeker profile"
  ON public.seeker_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own seeker profile"
  ON public.seeker_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own seeker profile"
  ON public.seeker_profiles FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- GIVER PROFILES: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "Giver profiles viewable by authenticated users"
  ON public.giver_profiles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own giver profile"
  ON public.giver_profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own giver profile"
  ON public.giver_profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own giver profile"
  ON public.giver_profiles FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- USER INTERESTS: Anyone authenticated can view, owners can modify
-- =============================================================================
CREATE POLICY "User interests viewable by authenticated users"
  ON public.user_interests FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert own interests"
  ON public.user_interests FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own interests"
  ON public.user_interests FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- =============================================================================
-- Verify changes
-- =============================================================================
-- Run: SELECT tablename, policyname FROM pg_policies WHERE schemaname = 'public';
