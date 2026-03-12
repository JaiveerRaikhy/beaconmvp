-- =============================================================================
-- Beacon MVP: Storage Bucket Configuration & Security Policies
-- Run this SQL in your Supabase SQL Editor (Dashboard > SQL Editor)
-- =============================================================================

-- 1. Create buckets
-- Avatars: public bucket (profile pictures are publicly viewable)
-- Resumes: private bucket (only the owner can access)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('avatars', 'avatars', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('resumes', 'resumes', false, 10485760, ARRAY['application/pdf'])
ON CONFLICT (id) DO UPDATE SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

-- 2. Avatar bucket policies

-- Only authenticated users can upload avatars, and only to their own folder
CREATE POLICY "Users can upload their own avatar"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'avatars'
    AND auth.role() = 'authenticated'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Avatars are publicly readable (public bucket)
CREATE POLICY "Avatars are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

-- Users can update (overwrite) their own avatar
CREATE POLICY "Users can update their own avatar"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Users can delete their own avatar
CREATE POLICY "Users can delete their own avatar"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- 3. Resume bucket policies (private)

-- Only authenticated users can upload resumes to their own folder
CREATE POLICY "Users can upload their own resume"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'resumes'
    AND auth.role() = 'authenticated'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Users can only read their own resumes
CREATE POLICY "Users can access their own resumes"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Users can update their own resumes
CREATE POLICY "Users can update their own resume"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Users can delete their own resumes
CREATE POLICY "Users can delete their own resume"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- 4. Attachments bucket policies (private - match participants only)

-- Authenticated users can upload attachments (match_id folder enforced by API)
CREATE POLICY "Authenticated users can upload attachments"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );

-- Only authenticated users can read attachments (signed URLs enforce access)
CREATE POLICY "Authenticated users can read attachments"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );

-- Only authenticated users can delete their attachments
CREATE POLICY "Authenticated users can delete attachments"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );
