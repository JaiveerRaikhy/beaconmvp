-- =============================================================================
-- Beacon MVP: Seed Test Users
-- Run in Supabase SQL Editor after supabase-schema.sql and seed-interests.sql
-- Creates 30 realistic test profiles: 15 Seekers + 15 Givers
-- =============================================================================

-- NOTE: In production Supabase, auth.users rows are created via the Auth API.
-- For local/test seeding, we insert directly into auth.users.
-- Passwords are all set to 'TestPassword123!' (bcrypt hash below).

-- =============================================================================
-- HELPER: Store the bcrypt hash for 'TestPassword123!'
-- =============================================================================
-- All test users use the same password for convenience.
-- $2a$10$ prefix = bcrypt with cost factor 10

DO $$
DECLARE
  pw_hash TEXT := '$2a$10$PwVcQFll3v0SUNQZ8axzVuYdeFMXOGYlwQp2jMfNn.1IwJSEbOpQC';

  -- Seeker UUIDs (s01-s15)
  s01 UUID := 'a0000001-0000-0000-0000-000000000001';
  s02 UUID := 'a0000001-0000-0000-0000-000000000002';
  s03 UUID := 'a0000001-0000-0000-0000-000000000003';
  s04 UUID := 'a0000001-0000-0000-0000-000000000004';
  s05 UUID := 'a0000001-0000-0000-0000-000000000005';
  s06 UUID := 'a0000001-0000-0000-0000-000000000006';
  s07 UUID := 'a0000001-0000-0000-0000-000000000007';
  s08 UUID := 'a0000001-0000-0000-0000-000000000008';
  s09 UUID := 'a0000001-0000-0000-0000-000000000009';
  s10 UUID := 'a0000001-0000-0000-0000-000000000010';
  s11 UUID := 'a0000001-0000-0000-0000-000000000011';
  s12 UUID := 'a0000001-0000-0000-0000-000000000012';
  s13 UUID := 'a0000001-0000-0000-0000-000000000013';
  s14 UUID := 'a0000001-0000-0000-0000-000000000014';
  s15 UUID := 'a0000001-0000-0000-0000-000000000015';

  -- Giver UUIDs (g01-g15)
  g01 UUID := 'b0000001-0000-0000-0000-000000000001';
  g02 UUID := 'b0000001-0000-0000-0000-000000000002';
  g03 UUID := 'b0000001-0000-0000-0000-000000000003';
  g04 UUID := 'b0000001-0000-0000-0000-000000000004';
  g05 UUID := 'b0000001-0000-0000-0000-000000000005';
  g06 UUID := 'b0000001-0000-0000-0000-000000000006';
  g07 UUID := 'b0000001-0000-0000-0000-000000000007';
  g08 UUID := 'b0000001-0000-0000-0000-000000000008';
  g09 UUID := 'b0000001-0000-0000-0000-000000000009';
  g10 UUID := 'b0000001-0000-0000-0000-000000000010';
  g11 UUID := 'b0000001-0000-0000-0000-000000000011';
  g12 UUID := 'b0000001-0000-0000-0000-000000000012';
  g13 UUID := 'b0000001-0000-0000-0000-000000000013';
  g14 UUID := 'b0000001-0000-0000-0000-000000000014';
  g15 UUID := 'b0000001-0000-0000-0000-000000000015';

BEGIN

-- =============================================================================
-- AUTH.USERS: Create auth entries for all 30 test users
-- =============================================================================

INSERT INTO auth.users (id, instance_id, email, encrypted_password, email_confirmed_at, created_at, updated_at, raw_app_meta_data, raw_user_meta_data, aud, role)
VALUES
  -- Seekers
  (s01, '00000000-0000-0000-0000-000000000000', 'jordan.chen@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jordan Chen"}',       'authenticated', 'authenticated'),
  (s02, '00000000-0000-0000-0000-000000000000', 'maya.patel@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Maya Patel"}',        'authenticated', 'authenticated'),
  (s03, '00000000-0000-0000-0000-000000000000', 'alex.washington@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Alex Washington"}',   'authenticated', 'authenticated'),
  (s04, '00000000-0000-0000-0000-000000000000', 'sofia.rodriguez@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sofia Rodriguez"}',   'authenticated', 'authenticated'),
  (s05, '00000000-0000-0000-0000-000000000000', 'ethan.kim@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ethan Kim"}',         'authenticated', 'authenticated'),
  (s06, '00000000-0000-0000-0000-000000000000', 'amara.okafor@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Amara Okafor"}',      'authenticated', 'authenticated'),
  (s07, '00000000-0000-0000-0000-000000000000', 'liam.murphy@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Liam Murphy"}',       'authenticated', 'authenticated'),
  (s08, '00000000-0000-0000-0000-000000000000', 'priya.sharma@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Priya Sharma"}',      'authenticated', 'authenticated'),
  (s09, '00000000-0000-0000-0000-000000000000', 'diego.herrera@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Diego Herrera"}',     'authenticated', 'authenticated'),
  (s10, '00000000-0000-0000-0000-000000000000', 'rachel.goldstein@test.com',  pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Rachel Goldstein"}',  'authenticated', 'authenticated'),
  (s11, '00000000-0000-0000-0000-000000000000', 'tyler.brooks@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tyler Brooks"}',      'authenticated', 'authenticated'),
  (s12, '00000000-0000-0000-0000-000000000000', 'nina.zhang@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Nina Zhang"}',        'authenticated', 'authenticated'),
  (s13, '00000000-0000-0000-0000-000000000000', 'marcus.johnson@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Marcus Johnson"}',    'authenticated', 'authenticated'),
  (s14, '00000000-0000-0000-0000-000000000000', 'anika.gupta@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Anika Gupta"}',       'authenticated', 'authenticated'),
  (s15, '00000000-0000-0000-0000-000000000000', 'sean.otoole@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sean O''Toole"}',     'authenticated', 'authenticated'),

  -- Givers
  (g01, '00000000-0000-0000-0000-000000000000', 'sarah.mitchell@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sarah Mitchell"}',    'authenticated', 'authenticated'),
  (g02, '00000000-0000-0000-0000-000000000000', 'david.nguyen@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"David Nguyen"}',      'authenticated', 'authenticated'),
  (g03, '00000000-0000-0000-0000-000000000000', 'jessica.thompson@test.com',  pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jessica Thompson"}',  'authenticated', 'authenticated'),
  (g04, '00000000-0000-0000-0000-000000000000', 'raj.kapoor@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Raj Kapoor"}',        'authenticated', 'authenticated'),
  (g05, '00000000-0000-0000-0000-000000000000', 'amanda.foster@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Amanda Foster"}',     'authenticated', 'authenticated'),
  (g06, '00000000-0000-0000-0000-000000000000', 'michael.park@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Michael Park"}',      'authenticated', 'authenticated'),
  (g07, '00000000-0000-0000-0000-000000000000', 'elena.martinez@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Elena Martinez"}',    'authenticated', 'authenticated'),
  (g08, '00000000-0000-0000-0000-000000000000', 'brian.callahan@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Brian Callahan"}',    'authenticated', 'authenticated'),
  (g09, '00000000-0000-0000-0000-000000000000', 'lisa.yamamoto@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Lisa Yamamoto"}',     'authenticated', 'authenticated'),
  (g10, '00000000-0000-0000-0000-000000000000', 'kevin.wright@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kevin Wright"}',      'authenticated', 'authenticated'),
  (g11, '00000000-0000-0000-0000-000000000000', 'stephanie.lee@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Stephanie Lee"}',     'authenticated', 'authenticated'),
  (g12, '00000000-0000-0000-0000-000000000000', 'omar.hassan@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Omar Hassan"}',       'authenticated', 'authenticated'),
  (g13, '00000000-0000-0000-0000-000000000000', 'catherine.blake@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Catherine Blake"}',   'authenticated', 'authenticated'),
  (g14, '00000000-0000-0000-0000-000000000000', 'anthony.russo@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Anthony Russo"}',     'authenticated', 'authenticated'),
  (g15, '00000000-0000-0000-0000-000000000000', 'danielle.abrams@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Danielle Abrams"}',   'authenticated', 'authenticated')
ON CONFLICT (id) DO NOTHING;

-- Also create identities for each user (required by Supabase Auth)
INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, created_at, updated_at, last_sign_in_at)
SELECT id, id, raw_user_meta_data, 'email', id::text, NOW(), NOW(), NOW()
FROM auth.users
WHERE id IN (s01,s02,s03,s04,s05,s06,s07,s08,s09,s10,s11,s12,s13,s14,s15,
             g01,g02,g03,g04,g05,g06,g07,g08,g09,g10,g11,g12,g13,g14,g15)
ON CONFLICT DO NOTHING;


-- =============================================================================
-- PROFILES
-- =============================================================================

INSERT INTO public.profiles (id, email, full_name, location_city, location_state, bio, is_seeker, is_giver, onboarding_completed) VALUES

  -- ---- SEEKERS ----
  (s01, 'jordan.chen@test.com',      'Jordan Chen',        'San Francisco', 'California',
   'CS senior at Stanford passionate about AI/ML. Built a computer vision project that won our department hackathon. Looking to break into top tech companies as a machine learning engineer.',
   true, false, true),

  (s02, 'maya.patel@test.com',       'Maya Patel',         'New York',      'New York',
   'Junior at Columbia studying Economics and Math. Interested in investment banking and the intersection of finance and technology. Active in the Columbia Finance Society.',
   true, false, true),

  (s03, 'alex.washington@test.com',  'Alex Washington',    'Atlanta',       'Georgia',
   'First-gen college student at Spelman. Double majoring in Biology and Public Health. Passionate about healthcare equity and dream of attending medical school.',
   true, false, true),

  (s04, 'sofia.rodriguez@test.com',  'Sofia Rodriguez',    'Austin',        'Texas',
   'Recent grad from UT Austin with a degree in Marketing. Currently freelancing while looking for my first full-time role in brand strategy or digital marketing at a startup.',
   true, false, true),

  (s05, 'ethan.kim@test.com',        'Ethan Kim',          'Boston',        'Massachusetts',
   'MIT senior studying Electrical Engineering and Computer Science. Co-founded a robotics club and interned at Tesla. Exploring career paths in hardware engineering vs. software.',
   true, false, true),

  (s06, 'amara.okafor@test.com',     'Amara Okafor',       'Chicago',       'Illinois',
   'Northwestern junior studying Journalism and Political Science. Editor-in-chief of our campus newspaper. Want to transition into media strategy or communications consulting.',
   true, false, true),

  (s07, 'liam.murphy@test.com',      'Liam Murphy',        'Philadelphia',  'Pennsylvania',
   'Wharton senior interested in private equity and venture capital. Completed a summer analyst program at a middle-market PE firm. Looking to understand different paths in finance.',
   true, false, true),

  (s08, 'priya.sharma@test.com',     'Priya Sharma',       'Seattle',       'Washington',
   'UW senior in Computer Science with a minor in Business. Interned at Amazon and a YC startup. Torn between joining a big tech company or an early-stage startup after graduation.',
   true, false, true),

  (s09, 'diego.herrera@test.com',    'Diego Herrera',      'Los Angeles',   'California',
   'UCLA senior studying Mechanical Engineering. Passionate about sustainable energy and electric vehicles. Looking to work in cleantech or at a company like Rivian or Lucid.',
   true, false, true),

  (s10, 'rachel.goldstein@test.com', 'Rachel Goldstein',   'Washington',    'District of Columbia',
   'Georgetown junior double majoring in International Relations and Arabic. Interested in public policy, think tanks, or government roles focused on Middle East policy.',
   true, false, true),

  (s11, 'tyler.brooks@test.com',     'Tyler Brooks',       'Nashville',     'Tennessee',
   'Vanderbilt senior studying Human and Organizational Development. Interested in management consulting, specifically in healthcare and life sciences practice areas.',
   true, false, true),

  (s12, 'nina.zhang@test.com',       'Nina Zhang',         'Durham',        'North Carolina',
   'Duke junior studying Biomedical Engineering and Computer Science. Researching computational genomics. Considering both industry roles in biotech and pursuing a PhD.',
   true, false, true),

  (s13, 'marcus.johnson@test.com',   'Marcus Johnson',     'Ann Arbor',     'Michigan',
   'Michigan senior studying Information Science. Built several web apps and contributed to open source. Interested in product management roles at mid-size tech companies.',
   true, false, true),

  (s14, 'anika.gupta@test.com',      'Anika Gupta',        'Palo Alto',     'California',
   'Stanford junior studying Management Science & Engineering. Previously interned at a Series B fintech startup. Interested in the intersection of tech and financial services.',
   true, false, true),

  (s15, 'sean.otoole@test.com',      'Sean O''Toole',      'Denver',        'Colorado',
   'CU Boulder senior studying Environmental Science. Led our campus sustainability initiative. Want to work in environmental consulting or corporate sustainability programs.',
   true, false, true),

  -- ---- GIVERS ----
  (g01, 'sarah.mitchell@test.com',   'Sarah Mitchell',     'San Francisco', 'California',
   'Senior Software Engineer at Google with 8 years of experience. Stanford CS alum. I mentor because someone helped me navigate my first job search and I want to pay it forward.',
   false, true, true),

  (g02, 'david.nguyen@test.com',     'David Nguyen',       'New York',      'New York',
   'VP at Goldman Sachs in the Technology Division. 10 years in investment banking and fintech. Columbia MBA grad. Happy to help with finance recruiting and career transitions.',
   false, true, true),

  (g03, 'jessica.thompson@test.com', 'Jessica Thompson',   'Boston',        'Massachusetts',
   'Partner at McKinsey & Company specializing in healthcare and life sciences. 12 years in consulting. Love helping students figure out if consulting is right for them.',
   false, true, true),

  (g04, 'raj.kapoor@test.com',       'Raj Kapoor',         'Seattle',       'Washington',
   'Principal Product Manager at Amazon. 9 years across startups and big tech. Berkeley EECS grad. Passionate about helping underrepresented students break into product management.',
   false, true, true),

  (g05, 'amanda.foster@test.com',    'Amanda Foster',      'Chicago',       'Illinois',
   'Director of Marketing at Salesforce. 11 years in B2B marketing and brand strategy. Northwestern Medill alum. Love helping young marketers develop their career roadmap.',
   false, true, true),

  (g06, 'michael.park@test.com',     'Michael Park',       'San Francisco', 'California',
   'Co-founder and CTO of a Series C AI startup (prev. Facebook, Stripe). MIT CSAIL alum. 7 years experience. Happy to chat about startup life, engineering leadership, or founding.',
   false, true, true),

  (g07, 'elena.martinez@test.com',   'Elena Martinez',     'Houston',       'Texas',
   'Senior Associate at Bain Capital Private Equity. 8 years in PE and consulting. Wharton MBA. First-gen college grad who loves helping students from similar backgrounds.',
   false, true, true),

  (g08, 'brian.callahan@test.com',   'Brian Callahan',     'Washington',    'District of Columbia',
   'Senior Policy Advisor at the White House Office of Science and Technology. Georgetown SFS alum. 13 years in government and policy. Can help with public service career paths.',
   false, true, true),

  (g09, 'lisa.yamamoto@test.com',    'Lisa Yamamoto',      'San Diego',     'California',
   'Director of Research at Illumina (genomics). 10 years in biotech. Duke BME PhD. Happy to talk about biotech careers, industry vs. academia, and the PhD-to-industry transition.',
   false, true, true),

  (g10, 'kevin.wright@test.com',     'Kevin Wright',       'Austin',        'Texas',
   'Engineering Manager at Tesla working on battery technology. 9 years in cleantech and automotive. Michigan ME grad. Passionate about mentoring engineers in sustainable energy.',
   false, true, true),

  (g11, 'stephanie.lee@test.com',    'Stephanie Lee',      'New York',      'New York',
   'Senior UX Designer at Figma (prev. Airbnb, IDEO). 8 years in design. RISD and Stanford d.school. Love helping aspiring designers build their portfolios and find their niche.',
   false, true, true),

  (g12, 'omar.hassan@test.com',      'Omar Hassan',        'Atlanta',       'Georgia',
   'Attending Physician at Emory University Hospital. 6 years post-residency. Howard University undergrad, Johns Hopkins MD. Mentor pre-med students through the application process.',
   false, true, true),

  (g13, 'catherine.blake@test.com',  'Catherine Blake',    'Denver',        'Colorado',
   'Principal at an environmental consulting firm. 14 years in sustainability and ESG consulting. Yale School of the Environment alum. Helping the next generation of climate leaders.',
   false, true, true),

  (g14, 'anthony.russo@test.com',    'Anthony Russo',      'New York',      'New York',
   'Managing Director at Lazard. 15 years in M&A advisory and restructuring. Penn undergrad, Harvard MBA. Can help with investment banking recruiting, deal experience, and career growth.',
   false, true, true),

  (g15, 'danielle.abrams@test.com',  'Danielle Abrams',   'Los Angeles',   'California',
   'VP of Content Strategy at Netflix. 11 years in media, entertainment, and digital content. USC Annenberg alum. Passionate about helping diverse voices break into the entertainment industry.',
   false, true, true)

ON CONFLICT (id) DO NOTHING;


-- =============================================================================
-- EDUCATION
-- =============================================================================

INSERT INTO public.education (user_id, school_name, degree_type, major, graduation_year, gpa, gpa_scale) VALUES

  -- Seekers
  (s01, 'Stanford University',                          'bs',   'Computer Science',                     2026, 3.85, 4.0),
  (s02, 'Columbia University',                          'ba',   'Economics & Mathematics',              2027, 3.78, 4.0),
  (s03, 'Spelman College',                              'bs',   'Biology',                              2026, 3.92, 4.0),
  (s03, 'Spelman College',                              'ba',   'Public Health',                        2026, 3.92, 4.0),
  (s04, 'University of Texas at Austin',                'bba',  'Marketing',                            2025, 3.55, 4.0),
  (s05, 'Massachusetts Institute of Technology',        'bs',   'Electrical Engineering & Computer Science', 2026, 3.90, 4.0),
  (s06, 'Northwestern University',                      'ba',   'Journalism',                           2027, 3.72, 4.0),
  (s07, 'University of Pennsylvania',                   'bs',   'Finance',                              2026, 3.80, 4.0),
  (s08, 'University of Washington',                     'bs',   'Computer Science',                     2026, 3.75, 4.0),
  (s09, 'University of California, Los Angeles',        'bs',   'Mechanical Engineering',               2026, 3.65, 4.0),
  (s10, 'Georgetown University',                        'ba',   'International Relations',              2027, 3.88, 4.0),
  (s11, 'Vanderbilt University',                        'ba',   'Human & Organizational Development',   2026, 3.70, 4.0),
  (s12, 'Duke University',                              'beng', 'Biomedical Engineering',               2027, 3.95, 4.0),
  (s13, 'University of Michigan',                       'bs',   'Information Science',                  2026, 3.60, 4.0),
  (s14, 'Stanford University',                          'bs',   'Management Science & Engineering',     2027, 3.82, 4.0),
  (s15, 'University of Colorado Boulder',               'bs',   'Environmental Science',                2026, 3.50, 4.0),

  -- Givers (undergrad)
  (g01, 'Stanford University',                          'bs',   'Computer Science',                     2018, 3.88, 4.0),
  (g02, 'University of California, Berkeley',           'ba',   'Economics',                            2012, 3.70, 4.0),
  (g03, 'Duke University',                              'ba',   'Public Policy',                        2010, 3.90, 4.0),
  (g04, 'University of California, Berkeley',           'bs',   'Electrical Engineering & Computer Science', 2013, 3.75, 4.0),
  (g05, 'Northwestern University',                      'ba',   'Journalism',                           2011, 3.65, 4.0),
  (g06, 'Massachusetts Institute of Technology',        'bs',   'Computer Science',                     2015, 3.92, 4.0),
  (g07, 'Rice University',                              'ba',   'Economics',                            2014, 3.85, 4.0),
  (g08, 'Georgetown University',                        'ba',   'Government & International Relations', 2009, 3.80, 4.0),
  (g09, 'Duke University',                              'beng', 'Biomedical Engineering',               2012, 3.95, 4.0),
  (g10, 'University of Michigan',                       'bs',   'Mechanical Engineering',               2013, 3.72, 4.0),
  (g11, 'Rhode Island School of Design',                'ba',   'Graphic Design',                       2014, 3.80, 4.0),
  (g12, 'Howard University',                            'bs',   'Biology',                              2010, 3.90, 4.0),
  (g13, 'Yale University',                              'ba',   'Environmental Studies',                2008, 3.78, 4.0),
  (g14, 'University of Pennsylvania',                   'bs',   'Finance',                              2007, 3.82, 4.0),
  (g15, 'University of Southern California',            'ba',   'Communication',                        2011, 3.68, 4.0);

-- Givers: Graduate degrees
INSERT INTO public.education (user_id, school_name, degree_type, major, graduation_year, gpa, gpa_scale) VALUES
  (g02, 'Columbia University',                          'mba',  'Finance & Strategy',                   2016, 3.80, 4.0),
  (g03, 'Harvard University',                           'mba',  'General Management',                   2014, 3.85, 4.0),
  (g05, 'Northwestern University',                      'ms',   'Integrated Marketing Communications',  2013, 3.75, 4.0),
  (g06, 'Massachusetts Institute of Technology',        'ms',   'Artificial Intelligence',              2017, 3.90, 4.0),
  (g07, 'University of Pennsylvania',                   'mba',  'Finance',                              2018, 3.88, 4.0),
  (g08, 'Georgetown University',                        'ma',   'Security Studies',                     2011, 3.82, 4.0),
  (g09, 'Duke University',                              'phd',  'Computational Biology',                2016, 3.95, 4.0),
  (g11, 'Stanford University',                          'ms',   'Design',                               2016, 3.85, 4.0),
  (g12, 'Johns Hopkins University',                     'md',   'Medicine',                             2014, 3.90, 4.0),
  (g13, 'Yale University',                              'ms',   'Environmental Management',             2010, 3.80, 4.0),
  (g14, 'Harvard University',                           'mba',  'Finance',                              2011, 3.78, 4.0);


-- =============================================================================
-- EXPERIENCES
-- =============================================================================

INSERT INTO public.experiences (user_id, company_name, job_title, start_date, end_date, is_current, is_internship, description) VALUES

  -- ---- SEEKER EXPERIENCES (internships & part-time) ----
  (s01, 'Google',         'Machine Learning Engineering Intern', '2025-06-01', '2025-08-31', false, true,
   'Worked on the Google Photos team improving image classification models. Reduced false positive rate by 12% on content moderation pipeline.'),
  (s01, 'Stanford AI Lab', 'Research Assistant',                 '2024-09-01', NULL,         true,  false,
   'Conducting research on few-shot learning for medical image analysis under Professor Li.'),

  (s02, 'Morgan Stanley',  'Investment Banking Summer Analyst',  '2025-06-01', '2025-08-31', false, true,
   'TMT group coverage. Built financial models and pitch books for 3 M&A transactions totaling $2.1B.'),
  (s02, 'Columbia Investment Management', 'Equity Research Analyst', '2024-09-01', NULL, true, false,
   'Lead analyst covering fintech sector. Manage portfolio of 5 stock pitches.'),

  (s03, 'Centers for Disease Control', 'Public Health Intern',  '2025-05-15', '2025-08-15', false, true,
   'Analyzed epidemiological data on maternal health outcomes across rural Georgia counties.'),

  (s04, 'Bumble',          'Social Media Marketing Intern',     '2024-06-01', '2024-08-31', false, true,
   'Created and managed social media campaigns reaching 500K+ impressions. Grew TikTok engagement 35%.'),
  (s04, 'Freelance',       'Brand Strategy Consultant',         '2025-01-01', NULL,         true,  false,
   'Working with 3 Austin-based startups on brand positioning, social strategy, and content creation.'),

  (s05, 'Tesla',           'Hardware Engineering Intern',        '2025-06-01', '2025-08-31', false, true,
   'Designed PCB layouts for next-gen battery management system. Filed 1 provisional patent.'),
  (s05, 'MIT Lincoln Laboratory', 'Research Intern',             '2024-06-01', '2024-08-31', false, true,
   'Worked on autonomous systems for defense applications. Developed sensor fusion algorithms.'),

  (s06, 'Chicago Tribune', 'Reporting Intern',                   '2025-06-01', '2025-08-31', false, true,
   'Covered local government and education beats. Published 15 bylined articles during summer internship.'),

  (s07, 'Charlesbank Capital Partners', 'Private Equity Summer Analyst', '2025-06-01', '2025-08-15', false, true,
   'Performed due diligence on 2 potential acquisitions in the healthcare services sector. Built LBO models.'),

  (s08, 'Amazon',          'Software Development Engineering Intern', '2025-06-01', '2025-08-31', false, true,
   'Built an internal tool for AWS monitoring that reduced on-call response time by 20%. Used TypeScript and React.'),
  (s08, 'Cascadia AI (YC S24)', 'Software Engineering Intern',  '2024-06-01', '2024-08-31', false, true,
   'Full-stack development on AI-powered customer support platform. Worked directly with founders.'),

  (s09, 'SpaceX',          'Mechanical Engineering Intern',      '2025-06-01', '2025-08-31', false, true,
   'Thermal analysis team for Raptor engine components. Ran FEA simulations and designed test fixtures.'),

  (s10, 'Brookings Institution', 'Research Intern',              '2025-06-01', '2025-08-31', false, true,
   'Supported senior fellows on Middle East policy research. Co-authored policy brief on U.S.-Gulf relations.'),

  (s11, 'Deloitte',        'Summer Consulting Analyst',          '2025-06-01', '2025-08-15', false, true,
   'Healthcare & Life Sciences practice. Developed market entry strategy for pharmaceutical client in rare diseases.'),

  (s12, 'Genentech',       'Research Intern',                    '2025-06-01', '2025-08-31', false, true,
   'Computational biology team. Developed a pipeline for analyzing single-cell RNA sequencing data in oncology.'),

  (s13, 'Spotify',         'Product Management Intern',          '2025-06-01', '2025-08-31', false, true,
   'Discovery team. Designed and ran A/B test for new podcast recommendation feature. Improved click-through by 8%.'),
  (s13, 'Open Source',     'Contributing Developer',             '2024-01-01', NULL,         true,  false,
   'Active contributor to React ecosystem. Maintainer of a popular UI component library with 2K+ GitHub stars.'),

  (s14, 'Stripe',          'Business Operations Intern',         '2025-06-01', '2025-08-31', false, true,
   'Analyzed merchant onboarding funnel. Built dashboards and identified $3M revenue opportunity from reducing drop-off.'),

  (s15, 'Rocky Mountain Institute', 'Sustainability Intern',     '2025-06-01', '2025-08-31', false, true,
   'Researched corporate carbon offset programs and analyzed their effectiveness. Presented findings to leadership.'),

  -- ---- GIVER EXPERIENCES ----
  -- g01: Sarah Mitchell - Senior SWE at Google
  (g01, 'Google',          'Senior Software Engineer',           '2021-03-01', NULL,         true,  false,
   'Tech lead on Google Cloud AI platform. Lead team of 6 engineers building ML infrastructure serving 10K+ customers.'),
  (g01, 'Google',          'Software Engineer',                  '2018-07-01', '2021-02-28', false, false,
   'Core contributor to TensorFlow serving infrastructure. Optimized model serving latency by 40%.'),

  -- g02: David Nguyen - VP at Goldman Sachs
  (g02, 'Goldman Sachs',   'Vice President, Technology Division','2020-01-01', NULL,         true,  false,
   'Lead fintech platform strategy and engineering. Manage team of 12 building next-gen trading systems.'),
  (g02, 'Goldman Sachs',   'Associate',                          '2016-07-01', '2019-12-31', false, false,
   'Investment Banking Division, TMT group. Executed 15+ M&A and IPO transactions totaling $8B+.'),
  (g02, 'J.P. Morgan',     'Analyst',                            '2012-07-01', '2014-06-30', false, false,
   'Investment Banking Analyst in Leveraged Finance. Built financial models and supported deal execution.'),

  -- g03: Jessica Thompson - Partner at McKinsey
  (g03, 'McKinsey & Company', 'Partner',                         '2022-01-01', NULL,         true,  false,
   'Lead the West Coast healthcare and life sciences practice. Oversee $40M+ in annual client engagements.'),
  (g03, 'McKinsey & Company', 'Associate Partner',               '2018-01-01', '2021-12-31', false, false,
   'Led strategy engagements for top-10 pharma companies on commercial launches and R&D portfolio optimization.'),
  (g03, 'McKinsey & Company', 'Associate',                       '2014-09-01', '2017-12-31', false, false,
   'Core member of healthcare practice. Led workstreams on hospital operations and payer strategy projects.'),
  (g03, 'Boston Children''s Hospital', 'Strategy Analyst',       '2010-07-01', '2012-06-30', false, false,
   'Internal strategy team supporting hospital leadership on expansion and service line planning.'),

  -- g04: Raj Kapoor - Principal PM at Amazon
  (g04, 'Amazon',          'Principal Product Manager',           '2020-06-01', NULL,         true,  false,
   'Leading product strategy for Alexa Smart Home. Own P&L for $500M+ product line across 8 countries.'),
  (g04, 'Facebook',        'Senior Product Manager',              '2017-03-01', '2020-05-31', false, false,
   'Led Facebook Marketplace growth. Grew monthly active users from 500M to 1B during tenure.'),
  (g04, 'Intuit',          'Product Manager',                     '2013-08-01', '2017-02-28', false, false,
   'Owned QuickBooks Online invoicing and payments. Shipped features that increased small business adoption 25%.'),

  -- g05: Amanda Foster - Director of Marketing at Salesforce
  (g05, 'Salesforce',      'Director of Marketing',               '2021-02-01', NULL,         true,  false,
   'Lead brand and content strategy for Salesforce Platform products. Manage team of 15 across brand, content, and digital.'),
  (g05, 'HubSpot',         'Senior Marketing Manager',            '2017-06-01', '2021-01-31', false, false,
   'Built and scaled the partner marketing program from scratch. Grew partner-sourced revenue 300% in 3 years.'),
  (g05, 'Leo Burnett',     'Account Executive',                   '2013-09-01', '2017-05-31', false, false,
   'Managed campaigns for Fortune 500 clients including P&G and Samsung. Won 2 Cannes Lions.'),

  -- g06: Michael Park - CTO/Co-founder (prev. Facebook, Stripe)
  (g06, 'Nexus AI (own startup)', 'Co-founder & CTO',            '2022-01-01', NULL,         true,  false,
   'Building AI-powered enterprise search. Raised $45M Series C. Team of 60+ engineers.'),
  (g06, 'Stripe',          'Staff Engineer',                      '2019-06-01', '2021-12-31', false, false,
   'Core payments infrastructure team. Architected system handling $100B+ in annual payment volume.'),
  (g06, 'Facebook',        'Software Engineer',                   '2017-07-01', '2019-05-31', false, false,
   'Instagram backend team. Built real-time content recommendation systems serving 500M+ daily users.'),

  -- g07: Elena Martinez - Senior Associate at Bain Capital PE
  (g07, 'Bain Capital Private Equity', 'Senior Associate',       '2021-06-01', NULL,         true,  false,
   'Healthcare and technology investing. Sourced and executed 3 platform acquisitions totaling $2B+.'),
  (g07, 'Bain & Company',  'Consultant',                          '2014-09-01', '2016-06-30', false, false,
   'Healthcare and financial services cases. Led workstreams on cost reduction and growth strategy.'),
  (g07, 'Credit Suisse',   'Investment Banking Analyst',           '2012-07-01', '2014-06-30', false, false,
   'Healthcare M&A group. Supported execution of 8 transactions including IPOs and leveraged buyouts.'),

  -- g08: Brian Callahan - Senior Policy Advisor
  (g08, 'White House OSTP', 'Senior Policy Advisor',              '2021-01-01', NULL,         true,  false,
   'Advise on technology policy including AI regulation, cybersecurity, and digital infrastructure.'),
  (g08, 'U.S. Department of State', 'Policy Analyst',             '2015-03-01', '2020-12-31', false, false,
   'Bureau of Near Eastern Affairs. Developed policy recommendations on U.S.-Middle East technology cooperation.'),
  (g08, 'RAND Corporation', 'Research Associate',                  '2011-09-01', '2015-02-28', false, false,
   'National security and technology policy research. Published 6 peer-reviewed reports.'),

  -- g09: Lisa Yamamoto - Director of Research at Illumina
  (g09, 'Illumina',        'Director of Research, Computational Genomics', '2021-08-01', NULL, true, false,
   'Lead a team of 20 computational biologists developing next-gen sequencing analysis tools.'),
  (g09, 'Genentech',       'Senior Scientist',                    '2016-09-01', '2021-07-31', false, false,
   'Developed computational pipelines for oncology drug target discovery. 12 published papers.'),

  -- g10: Kevin Wright - Engineering Manager at Tesla
  (g10, 'Tesla',           'Engineering Manager, Battery Technology', '2020-01-01', NULL,     true,  false,
   'Lead team of 15 engineers on next-gen battery cell design. Delivered 18% energy density improvement.'),
  (g10, 'Tesla',           'Senior Mechanical Engineer',           '2017-06-01', '2019-12-31', false, false,
   'Thermal management systems for Model 3 battery pack. Filed 3 patents.'),
  (g10, 'General Motors',  'Mechanical Engineer',                  '2013-07-01', '2017-05-31', false, false,
   'Powertrain team. Designed components for Chevrolet Bolt EV battery system.'),

  -- g11: Stephanie Lee - Senior UX Designer at Figma
  (g11, 'Figma',           'Senior UX Designer',                   '2022-03-01', NULL,        true,  false,
   'Design systems team. Leading the redesign of Figma''s component library and design token system.'),
  (g11, 'Airbnb',          'UX Designer',                          '2018-09-01', '2022-02-28', false, false,
   'Guest experience team. Redesigned the booking flow, improving conversion by 15%.'),
  (g11, 'IDEO',            'Interaction Designer',                  '2016-07-01', '2018-08-31', false, false,
   'Worked on design thinking projects for healthcare and financial services clients.'),

  -- g12: Omar Hassan - Attending Physician at Emory
  (g12, 'Emory University Hospital', 'Attending Physician, Internal Medicine', '2020-07-01', NULL, true, false,
   'Board-certified internist. Clinical focus on health equity and chronic disease management in underserved communities.'),
  (g12, 'Johns Hopkins Hospital', 'Resident, Internal Medicine',   '2017-07-01', '2020-06-30', false, false,
   'Completed 3-year residency. Chief resident in final year. Research on social determinants of health.'),

  -- g13: Catherine Blake - Principal, Environmental Consulting
  (g13, 'EcoVerde Consulting', 'Principal & Founder',              '2018-01-01', NULL,        true,  false,
   'Founded ESG and sustainability consulting firm. Advise Fortune 500 companies on climate strategy and carbon reduction.'),
  (g13, 'Environmental Defense Fund', 'Senior Analyst',            '2012-06-01', '2017-12-31', false, false,
   'Led corporate partnerships program. Helped 20+ companies set science-based emissions targets.'),
  (g13, 'EPA',             'Environmental Scientist',               '2010-09-01', '2012-05-31', false, false,
   'Office of Air Quality. Analyzed emissions data and supported Clean Air Act implementation.'),

  -- g14: Anthony Russo - Managing Director at Lazard
  (g14, 'Lazard',          'Managing Director, M&A Advisory',      '2020-01-01', NULL,        true,  false,
   'Lead advisor on cross-border M&A transactions. Closed 25+ deals totaling $50B+ over career.'),
  (g14, 'Lazard',          'Director',                              '2016-01-01', '2019-12-31', false, false,
   'Restructuring and M&A advisory. Led execution on several landmark restructuring mandates.'),
  (g14, 'Morgan Stanley',  'Vice President',                        '2013-01-01', '2015-12-31', false, false,
   'M&A group covering industrials and technology sectors. Managed teams of 5-8 analysts and associates.'),
  (g14, 'Morgan Stanley',  'Analyst',                               '2007-07-01', '2009-06-30', false, false,
   'Investment Banking Analyst in M&A. Financial modeling, due diligence, and client presentation preparation.'),

  -- g15: Danielle Abrams - VP Content Strategy at Netflix
  (g15, 'Netflix',         'VP of Content Strategy',                '2021-06-01', NULL,        true,  false,
   'Lead content strategy for original programming. Oversee data-driven approach to greenlighting and audience development.'),
  (g15, 'Netflix',         'Director of Content Analytics',         '2018-03-01', '2021-05-31', false, false,
   'Built the content performance analytics function. Developed models predicting content success with 85% accuracy.'),
  (g15, 'NBCUniversal',    'Senior Manager, Digital Strategy',      '2014-09-01', '2018-02-28', false, false,
   'Led digital content strategy for Peacock launch. Managed cross-platform content distribution.'),
  (g15, 'William Morris Endeavor', 'Agent Trainee / Junior Agent', '2011-07-01', '2014-08-31', false, false,
   'Started in the mailroom, worked up to junior agent. Represented emerging writers and directors.');


-- =============================================================================
-- SEEKER PROFILES
-- =============================================================================

INSERT INTO public.seeker_profiles (user_id, target_industry, target_role, target_companies, goal_type, goal_text, help_types_needed, is_first_gen, is_underrepresented, received_financial_aid) VALUES

  (s01, 'Information Technology', 'Machine Learning Engineer',
   ARRAY['Google', 'OpenAI', 'Anthropic', 'Meta AI', 'DeepMind'],
   'first-job', NULL,
   ARRAY['resume-review', 'interview-prep', 'industry-insights', 'technical-skills'],
   false, false, false),

  (s02, 'Investment Banking', 'Investment Banking Analyst',
   ARRAY['Goldman Sachs', 'Morgan Stanley', 'J.P. Morgan', 'Evercore'],
   'first-job', NULL,
   ARRAY['interview-prep', 'industry-insights', 'day-to-day', 'salary-negotiation'],
   false, false, false),

  (s03, 'Healthcare', 'Public Health Researcher / Pre-Med',
   ARRAY['CDC', 'NIH', 'Johns Hopkins', 'Mayo Clinic'],
   'figure-direction', NULL,
   ARRAY['career-path', 'grad-school', 'first-job', 'networking'],
   true, true, true),

  (s04, 'Marketing', 'Brand Strategist',
   ARRAY['Nike', 'Patagonia', 'Glossier', 'Warby Parker'],
   'first-job', NULL,
   ARRAY['resume-review', 'job-search-strategy', 'portfolio-review', 'personal-branding'],
   false, false, false),

  (s05, 'Information Technology', 'Hardware Engineer or Software Engineer',
   ARRAY['Tesla', 'Apple', 'NVIDIA', 'Boston Dynamics'],
   'figure-direction', NULL,
   ARRAY['career-path', 'industry-insights', 'offer-evaluation', 'day-to-day'],
   false, false, false),

  (s06, 'Media', 'Media Strategist / Communications Consultant',
   ARRAY['Edelman', 'BCG', 'New York Times', 'Axios'],
   'switch-industries', NULL,
   ARRAY['career-switching', 'breaking-in', 'networking', 'interview-prep'],
   false, false, false),

  (s07, 'Private Equity', 'Private Equity Analyst',
   ARRAY['KKR', 'Blackstone', 'Bain Capital', 'Warburg Pincus'],
   'first-job', NULL,
   ARRAY['interview-prep', 'industry-insights', 'salary-negotiation', 'career-path'],
   false, false, false),

  (s08, 'Information Technology', 'Software Engineer',
   ARRAY['Google', 'Stripe', 'Notion', 'Linear'],
   'figure-direction', NULL,
   ARRAY['career-path', 'offer-evaluation', 'day-to-day', 'starting-business'],
   false, false, false),

  (s09, 'Automotive', 'Mechanical Engineer - Clean Energy',
   ARRAY['Rivian', 'Lucid', 'Tesla', 'Northvolt'],
   'first-job', NULL,
   ARRAY['resume-review', 'interview-prep', 'industry-insights', 'job-search-strategy'],
   false, true, true),

  (s10, 'Government', 'Policy Analyst',
   ARRAY['Brookings', 'CSIS', 'State Department', 'RAND'],
   'first-job', NULL,
   ARRAY['first-job', 'networking', 'industry-insights', 'career-path'],
   false, false, false),

  (s11, 'Consulting', 'Management Consultant',
   ARRAY['McKinsey', 'Bain', 'BCG', 'Deloitte'],
   'first-job', NULL,
   ARRAY['interview-prep', 'resume-review', 'breaking-in', 'day-to-day'],
   false, false, false),

  (s12, 'Biotechnology', 'Computational Biologist',
   ARRAY['Genentech', 'Illumina', 'Moderna', '23andMe'],
   'figure-direction', NULL,
   ARRAY['career-path', 'grad-school', 'industry-insights', 'day-to-day'],
   false, false, false),

  (s13, 'Information Technology', 'Product Manager',
   ARRAY['Spotify', 'Figma', 'Notion', 'Stripe'],
   'first-job', NULL,
   ARRAY['resume-review', 'interview-prep', 'career-path', 'portfolio-review'],
   true, true, true),

  (s14, 'Finance', 'Fintech Product Manager / Strategy',
   ARRAY['Stripe', 'Robinhood', 'Plaid', 'Block'],
   'break-into-company', NULL,
   ARRAY['breaking-in', 'industry-insights', 'interview-prep', 'offer-evaluation'],
   false, false, false),

  (s15, 'Environmental', 'Environmental Consultant / Sustainability Analyst',
   ARRAY['McKinsey Sustainability', 'EDF', 'Rocky Mountain Institute', 'Patagonia'],
   'first-job', NULL,
   ARRAY['job-search-strategy', 'resume-review', 'breaking-in', 'networking'],
   true, false, true)

ON CONFLICT (user_id) DO NOTHING;


-- =============================================================================
-- GIVER PROFILES
-- =============================================================================

INSERT INTO public.giver_profiles (user_id, industries_can_advise, help_types_offered, factor_rankings, prioritize_underrepresented, experience_level) VALUES

  (g01, ARRAY['Information Technology', 'Internet'],
   ARRAY['interview-prep', 'resume-review', 'technical-skills', 'career-path', 'offer-evaluation'],
   '{"location": 5, "shared_university": 3, "prestige": 4, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}',
   true, 8),

  (g02, ARRAY['Investment Banking', 'Finance', 'Information Technology'],
   ARRAY['interview-prep', 'career-path', 'salary-negotiation', 'industry-insights', 'career-switching'],
   '{"location": 6, "shared_university": 1, "prestige": 2, "gpa": 3, "industry_alignment": 4, "shared_interests": 5}',
   false, 14),

  (g03, ARRAY['Consulting', 'Healthcare', 'Pharmaceuticals'],
   ARRAY['interview-prep', 'career-path', 'breaking-in', 'day-to-day', 'getting-promoted'],
   '{"location": 6, "shared_university": 4, "prestige": 5, "gpa": 3, "industry_alignment": 1, "shared_interests": 2}',
   true, 16),

  (g04, ARRAY['Information Technology', 'Internet', 'Consumer Goods'],
   ARRAY['interview-prep', 'resume-review', 'career-path', 'breaking-in', 'first-job'],
   '{"location": 5, "shared_university": 6, "prestige": 4, "gpa": 3, "industry_alignment": 2, "shared_interests": 1}',
   true, 13),

  (g05, ARRAY['Marketing', 'Advertising', 'Information Technology'],
   ARRAY['resume-review', 'career-path', 'personal-branding', 'job-search-strategy', 'portfolio-review'],
   '{"location": 4, "shared_university": 2, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 3}',
   false, 15),

  (g06, ARRAY['Information Technology', 'Internet'],
   ARRAY['technical-skills', 'career-path', 'starting-business', 'interview-prep', 'leadership'],
   '{"location": 6, "shared_university": 3, "prestige": 2, "gpa": 5, "industry_alignment": 1, "shared_interests": 4}',
   false, 11),

  (g07, ARRAY['Private Equity', 'Finance', 'Consulting', 'Healthcare'],
   ARRAY['interview-prep', 'industry-insights', 'salary-negotiation', 'career-switching', 'breaking-in'],
   '{"location": 5, "shared_university": 2, "prestige": 1, "gpa": 3, "industry_alignment": 4, "shared_interests": 6}',
   true, 12),

  (g08, ARRAY['Government', 'Defense'],
   ARRAY['career-path', 'industry-insights', 'networking', 'first-job', 'international'],
   '{"location": 3, "shared_university": 1, "prestige": 4, "gpa": 5, "industry_alignment": 2, "shared_interests": 6}',
   false, 17),

  (g09, ARRAY['Biotechnology', 'Healthcare', 'Pharmaceuticals'],
   ARRAY['career-path', 'grad-school', 'industry-insights', 'day-to-day', 'technical-skills'],
   '{"location": 6, "shared_university": 3, "prestige": 4, "gpa": 2, "industry_alignment": 1, "shared_interests": 5}',
   false, 14),

  (g10, ARRAY['Automotive', 'Energy', 'Engineering'],
   ARRAY['interview-prep', 'resume-review', 'career-path', 'industry-insights', 'technical-skills'],
   '{"location": 4, "shared_university": 1, "prestige": 5, "gpa": 6, "industry_alignment": 2, "shared_interests": 3}',
   true, 13),

  (g11, ARRAY['Information Technology', 'Entertainment', 'Fashion'],
   ARRAY['portfolio-review', 'career-path', 'personal-branding', 'interview-prep', 'breaking-in'],
   '{"location": 5, "shared_university": 6, "prestige": 4, "gpa": 3, "industry_alignment": 2, "shared_interests": 1}',
   true, 10),

  (g12, ARRAY['Healthcare'],
   ARRAY['grad-school', 'career-path', 'first-job', 'networking', 'day-to-day'],
   '{"location": 4, "shared_university": 1, "prestige": 3, "gpa": 2, "industry_alignment": 5, "shared_interests": 6}',
   true, 12),

  (g13, ARRAY['Environmental', 'Consulting', 'Energy'],
   ARRAY['career-path', 'breaking-in', 'industry-insights', 'job-search-strategy', 'starting-business'],
   '{"location": 3, "shared_university": 4, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}',
   true, 18),

  (g14, ARRAY['Investment Banking', 'Finance', 'Private Equity'],
   ARRAY['interview-prep', 'salary-negotiation', 'getting-promoted', 'career-path', 'leadership'],
   '{"location": 6, "shared_university": 1, "prestige": 2, "gpa": 3, "industry_alignment": 4, "shared_interests": 5}',
   false, 19),

  (g15, ARRAY['Entertainment', 'Media', 'Marketing'],
   ARRAY['career-path', 'breaking-in', 'industry-insights', 'networking', 'personal-branding'],
   '{"location": 5, "shared_university": 4, "prestige": 6, "gpa": 3, "industry_alignment": 2, "shared_interests": 1}',
   true, 15)

ON CONFLICT (user_id) DO NOTHING;


-- =============================================================================
-- USER INTERESTS (link to seeded interests)
-- =============================================================================

-- Helper: Insert user_interests by interest name
-- We'll join against the interests table to get the UUIDs

INSERT INTO public.user_interests (user_id, interest_id)
SELECT uid, i.id
FROM (VALUES
  -- s01: Jordan Chen - AI/ML engineer
  (s01, 'Software Engineering'), (s01, 'Machine Learning'), (s01, 'Data Science'),
  (s01, 'Cloud Computing'), (s01, 'Product Management'),

  -- s02: Maya Patel - Finance
  (s02, 'Investment Banking'), (s02, 'Quantitative Finance'), (s02, 'Corporate Finance'),
  (s02, 'Venture Capital'), (s02, 'Entrepreneurship'),

  -- s03: Amara Okafor - Healthcare
  (s03, 'Public Health'), (s03, 'Healthcare Administration'), (s03, 'Biotech Research'),
  (s03, 'Social Impact'),

  -- s04: Sofia Rodriguez - Marketing
  (s04, 'Marketing Strategy'), (s04, 'Brand Management'), (s04, 'E-Commerce'),
  (s04, 'Content Creation'), (s04, 'Entrepreneurship'),

  -- s05: Ethan Kim - Engineering
  (s05, 'Software Engineering'), (s05, 'Machine Learning'), (s05, 'Cybersecurity'),
  (s05, 'Renewable Energy'), (s05, 'DevOps'),

  -- s06: Amara Okafor - Journalism/Media
  (s06, 'Journalism'), (s06, 'Content Creation'), (s06, 'Marketing Strategy'),
  (s06, 'Public Policy'),

  -- s07: Liam Murphy - Finance/PE
  (s07, 'Private Equity'), (s07, 'Investment Banking'), (s07, 'Venture Capital'),
  (s07, 'Corporate Finance'), (s07, 'Entrepreneurship'),

  -- s08: Priya Sharma - Tech
  (s08, 'Software Engineering'), (s08, 'Product Management'), (s08, 'Cloud Computing'),
  (s08, 'Entrepreneurship'), (s08, 'Mobile Development'),

  -- s09: Diego Herrera - CleanTech
  (s09, 'Mechanical Engineering'), (s09, 'Renewable Energy'), (s09, 'Environmental Science'),
  (s09, 'Supply Chain Management'),

  -- s10: Rachel Goldstein - Policy
  (s10, 'Public Policy'), (s10, 'Government Affairs'), (s10, 'Social Impact'),
  (s10, 'Journalism'),

  -- s11: Tyler Brooks - Consulting
  (s11, 'Management Consulting'), (s11, 'Strategy Consulting'), (s11, 'Healthcare Administration'),
  (s11, 'Business Development'),

  -- s12: Nina Zhang - Biotech
  (s12, 'Biotech Research'), (s12, 'Data Science'), (s12, 'Pharmaceuticals'),
  (s12, 'Machine Learning'), (s12, 'Health Informatics'),

  -- s13: Marcus Johnson - Product Management
  (s13, 'Product Management'), (s13, 'Software Engineering'), (s13, 'UX Design'),
  (s13, 'E-Commerce'), (s13, 'Mobile Development'),

  -- s14: Anika Gupta - Fintech
  (s14, 'Financial Planning'), (s14, 'Software Engineering'), (s14, 'Product Management'),
  (s14, 'Venture Capital'), (s14, 'Entrepreneurship'),

  -- s15: Sean O'Toole - Environment
  (s15, 'Environmental Science'), (s15, 'Renewable Energy'), (s15, 'Public Policy'),
  (s15, 'Social Impact'), (s15, 'Non-Profit Management'),

  -- g01: Sarah Mitchell - Google SWE
  (g01, 'Software Engineering'), (g01, 'Machine Learning'), (g01, 'Cloud Computing'),
  (g01, 'DevOps'), (g01, 'Data Science'),

  -- g02: David Nguyen - Goldman Sachs
  (g02, 'Investment Banking'), (g02, 'Corporate Finance'), (g02, 'Quantitative Finance'),
  (g02, 'Software Engineering'),

  -- g03: Jessica Thompson - McKinsey
  (g03, 'Management Consulting'), (g03, 'Strategy Consulting'), (g03, 'Healthcare Administration'),
  (g03, 'Pharmaceuticals'), (g03, 'Business Development'),

  -- g04: Raj Kapoor - Amazon PM
  (g04, 'Product Management'), (g04, 'Software Engineering'), (g04, 'E-Commerce'),
  (g04, 'Mobile Development'), (g04, 'UX Design'),

  -- g05: Amanda Foster - Salesforce Marketing
  (g05, 'Marketing Strategy'), (g05, 'Brand Management'), (g05, 'Business Development'),
  (g05, 'Content Creation'), (g05, 'Sales Strategy'),

  -- g06: Michael Park - Startup CTO
  (g06, 'Software Engineering'), (g06, 'Machine Learning'), (g06, 'Entrepreneurship'),
  (g06, 'Cloud Computing'), (g06, 'Venture Capital'),

  -- g07: Elena Martinez - Bain Capital PE
  (g07, 'Private Equity'), (g07, 'Investment Banking'), (g07, 'Management Consulting'),
  (g07, 'Healthcare Administration'), (g07, 'Corporate Finance'),

  -- g08: Brian Callahan - Policy Advisor
  (g08, 'Public Policy'), (g08, 'Government Affairs'), (g08, 'Defense & Aerospace'),
  (g08, 'Cybersecurity'),

  -- g09: Lisa Yamamoto - Illumina
  (g09, 'Biotech Research'), (g09, 'Data Science'), (g09, 'Pharmaceuticals'),
  (g09, 'Health Informatics'), (g09, 'Machine Learning'),

  -- g10: Kevin Wright - Tesla
  (g10, 'Mechanical Engineering'), (g10, 'Renewable Energy'), (g10, 'Environmental Science'),
  (g10, 'Supply Chain Management'),

  -- g11: Stephanie Lee - Figma
  (g11, 'UX Design'), (g11, 'Product Management'), (g11, 'Graphic Design'),
  (g11, 'Software Engineering'),

  -- g12: Omar Hassan - Emory Physician
  (g12, 'Healthcare Administration'), (g12, 'Public Health'), (g12, 'Social Impact'),
  (g12, 'Biotech Research'),

  -- g13: Catherine Blake - Environmental Consulting
  (g13, 'Environmental Science'), (g13, 'Renewable Energy'), (g13, 'Management Consulting'),
  (g13, 'Public Policy'), (g13, 'Non-Profit Management'),

  -- g14: Anthony Russo - Lazard
  (g14, 'Investment Banking'), (g14, 'Corporate Finance'), (g14, 'Private Equity'),
  (g14, 'Venture Capital'),

  -- g15: Danielle Abrams - Netflix
  (g15, 'Content Creation'), (g15, 'Film & Video Production'), (g15, 'Marketing Strategy'),
  (g15, 'Brand Management'), (g15, 'Journalism')

) AS v(uid, interest_name)
JOIN public.interests i ON i.name = v.interest_name
ON CONFLICT (user_id, interest_id) DO NOTHING;

END $$;
