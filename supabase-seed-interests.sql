-- =============================================================================
-- Beacon MVP: Seed Professional Interests
-- Run in Supabase SQL Editor after supabase-schema.sql
-- Populates the interests reference table used for matching.
-- =============================================================================

INSERT INTO public.interests (name, category) VALUES
  -- Technology
  ('Software Engineering',       'Technology'),
  ('Data Science',               'Technology'),
  ('Machine Learning',           'Technology'),
  ('Cybersecurity',              'Technology'),
  ('Cloud Computing',            'Technology'),
  ('Product Management',         'Technology'),
  ('UX Design',                  'Technology'),
  ('Mobile Development',         'Technology'),
  ('DevOps',                     'Technology'),
  ('Blockchain',                 'Technology'),

  -- Finance
  ('Investment Banking',         'Finance'),
  ('Private Equity',             'Finance'),
  ('Venture Capital',            'Finance'),
  ('Wealth Management',          'Finance'),
  ('Financial Planning',         'Finance'),
  ('Quantitative Finance',       'Finance'),
  ('Corporate Finance',          'Finance'),

  -- Consulting
  ('Management Consulting',      'Consulting'),
  ('Strategy Consulting',        'Consulting'),
  ('Technology Consulting',      'Consulting'),
  ('Operations Consulting',      'Consulting'),

  -- Healthcare
  ('Healthcare Administration',  'Healthcare'),
  ('Biotech Research',           'Healthcare'),
  ('Public Health',              'Healthcare'),
  ('Pharmaceuticals',            'Healthcare'),
  ('Health Informatics',         'Healthcare'),

  -- Business & Marketing
  ('Marketing Strategy',         'Business'),
  ('Brand Management',           'Business'),
  ('Business Development',       'Business'),
  ('Sales Strategy',             'Business'),
  ('E-Commerce',                 'Business'),
  ('Entrepreneurship',           'Business'),
  ('Supply Chain Management',    'Business'),

  -- Law & Policy
  ('Corporate Law',              'Law & Policy'),
  ('Intellectual Property',      'Law & Policy'),
  ('Public Policy',              'Law & Policy'),
  ('Regulatory Compliance',      'Law & Policy'),

  -- Creative & Media
  ('Content Creation',           'Creative & Media'),
  ('Journalism',                 'Creative & Media'),
  ('Film & Video Production',    'Creative & Media'),
  ('Graphic Design',             'Creative & Media'),

  -- Engineering & Sciences
  ('Mechanical Engineering',     'Engineering & Sciences'),
  ('Civil Engineering',          'Engineering & Sciences'),
  ('Environmental Science',      'Engineering & Sciences'),
  ('Renewable Energy',           'Engineering & Sciences'),

  -- Education & Non-Profit
  ('Higher Education',           'Education & Non-Profit'),
  ('Non-Profit Management',      'Education & Non-Profit'),
  ('Social Impact',              'Education & Non-Profit'),

  -- Real Estate & Construction
  ('Real Estate Development',    'Real Estate'),
  ('Commercial Real Estate',     'Real Estate'),

  -- Government & Defense
  ('Government Affairs',         'Government'),
  ('Defense & Aerospace',        'Government')

ON CONFLICT (name) DO NOTHING;
