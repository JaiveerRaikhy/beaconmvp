-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.education ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.experiences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.extracurriculars ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.seeker_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.giver_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_interests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.impact_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.impact_tags ENABLE ROW LEVEL SECURITY;

-- Profiles: Users can read all, but only update their own
CREATE POLICY "Profiles are viewable by everyone" ON public.profiles
  FOR SELECT USING (true);

CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Education: Authenticated users can view all, owners can modify
CREATE POLICY "Education viewable by authenticated users" ON public.education
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own education" ON public.education
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own education" ON public.education
  FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own education" ON public.education
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- Experiences: Authenticated users can view all, owners can modify
CREATE POLICY "Experiences viewable by authenticated users" ON public.experiences
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own experiences" ON public.experiences
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own experiences" ON public.experiences
  FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own experiences" ON public.experiences
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- Extracurriculars: Authenticated users can view all, owners can modify
CREATE POLICY "Extracurriculars viewable by authenticated users" ON public.extracurriculars
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own extracurriculars" ON public.extracurriculars
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own extracurriculars" ON public.extracurriculars
  FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own extracurriculars" ON public.extracurriculars
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- Seeker profiles: Authenticated users can view all (for matching), owners can modify
CREATE POLICY "Seeker profiles viewable by authenticated users" ON public.seeker_profiles
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own seeker profile" ON public.seeker_profiles
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own seeker profile" ON public.seeker_profiles
  FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own seeker profile" ON public.seeker_profiles
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- Giver profiles: Authenticated users can view all (for matching), owners can modify
CREATE POLICY "Giver profiles viewable by authenticated users" ON public.giver_profiles
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own giver profile" ON public.giver_profiles
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own giver profile" ON public.giver_profiles
  FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own giver profile" ON public.giver_profiles
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- User interests: Authenticated users can view all, owners can modify
CREATE POLICY "User interests viewable by authenticated users" ON public.user_interests
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can insert own interests" ON public.user_interests
  FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete own interests" ON public.user_interests
  FOR DELETE TO authenticated USING (auth.uid() = user_id);

-- Matches: Participants can view their own matches
CREATE POLICY "Users can view own matches" ON public.matches
  FOR SELECT USING (auth.uid() = giver_id OR auth.uid() = seeker_id);

CREATE POLICY "Givers can insert matches" ON public.matches
  FOR INSERT WITH CHECK (auth.uid() = giver_id);

CREATE POLICY "Participants can update own matches" ON public.matches
  FOR UPDATE USING (auth.uid() = giver_id OR auth.uid() = seeker_id);

-- Messages: Match participants can manage messages
CREATE POLICY "Match participants can view messages" ON public.messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.matches
      WHERE matches.id = messages.match_id
      AND (matches.giver_id = auth.uid() OR matches.seeker_id = auth.uid())
    )
  );

CREATE POLICY "Match participants can send messages" ON public.messages
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.matches
      WHERE matches.id = match_id
      AND (matches.giver_id = auth.uid() OR matches.seeker_id = auth.uid())
    )
  );

-- Impact events: Seekers can manage their own
CREATE POLICY "Seekers can manage own impact events" ON public.impact_events
  FOR ALL USING (auth.uid() = seeker_id);

-- Impact tags: Givers can view their own tags
CREATE POLICY "Givers can view own tags" ON public.impact_tags
  FOR SELECT USING (auth.uid() = giver_id);
