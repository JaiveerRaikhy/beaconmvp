-- =============================================================================
-- Beacon MVP: Storage Bucket Setup & RLS Policies
-- Run in Supabase SQL Editor (Dashboard > SQL Editor)
-- =============================================================================

-- 1. Create storage buckets
-- Avatars: public (profile pictures viewable by anyone)
-- Resumes: private (only the owner can access)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('avatars', 'avatars', true,  5242880,  ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('resumes', 'resumes', false, 10485760, ARRAY['application/pdf']),
  ('attachments', 'attachments', false, 10485760, ARRAY[
    'image/jpeg', 'image/png', 'image/gif',
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'text/plain'
  ])
ON CONFLICT (id) DO UPDATE SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

-- =============================================================================
-- 2. Avatars bucket policies (public read, owner write)
-- =============================================================================

-- Upload: authenticated users to their own folder (e.g. avatars/<user_id>/photo.jpg)
CREATE POLICY "Users can upload their own avatar"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'avatars'
    AND auth.role() = 'authenticated'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Read: anyone can view avatars (public bucket)
CREATE POLICY "Avatars are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

-- Update: owner only
CREATE POLICY "Users can update their own avatar"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Delete: owner only
CREATE POLICY "Users can delete their own avatar"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'avatars'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- =============================================================================
-- 3. Resumes bucket policies (private, owner-only access)
-- =============================================================================

-- Upload: authenticated users to their own folder
CREATE POLICY "Users can upload their own resume"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'resumes'
    AND auth.role() = 'authenticated'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Read: owner only
CREATE POLICY "Users can access their own resumes"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Update: owner only
CREATE POLICY "Users can update their own resume"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- Delete: owner only
CREATE POLICY "Users can delete their own resume"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'resumes'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- =============================================================================
-- 4. Attachments bucket policies (private, auth-required, signed URLs for access)
-- =============================================================================

-- Upload: authenticated users (match ownership enforced at API layer)
CREATE POLICY "Authenticated users can upload attachments"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );

-- Read: authenticated users only (signed URLs enforce match-level access)
CREATE POLICY "Authenticated users can read attachments"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );

-- Delete: authenticated users
CREATE POLICY "Authenticated users can delete attachments"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'attachments'
    AND auth.role() = 'authenticated'
  );
