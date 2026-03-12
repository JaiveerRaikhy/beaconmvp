-- =============================================================================
-- Beacon MVP: Seed Test Users - EXPANSION (Part 1 of 4)
-- Run in Supabase SQL Editor AFTER supabase-seed-test-users.sql
-- Creates 130 additional test profiles: 50 Seekers + 50 Givers + 30 Both
-- =============================================================================

-- NOTE: This expansion adds users s16-s65, g16-g65, and b01-b30.
-- The original seed file already created s01-s15 and g01-g15.
-- Passwords are all set to 'TestPassword123!' (bcrypt hash below).

-- =============================================================================
-- PART 1: Auth Users + Identities
-- =============================================================================

DO $$
DECLARE
  pw_hash TEXT := '$2a$10$PwVcQFll3v0SUNQZ8axzVuYdeFMXOGYlwQp2jMfNn.1IwJSEbOpQC';

  -- Seeker UUIDs (s16-s65)
  s16 UUID := 'a0000002-0000-0000-0000-000000000016';
  s17 UUID := 'a0000002-0000-0000-0000-000000000017';
  s18 UUID := 'a0000002-0000-0000-0000-000000000018';
  s19 UUID := 'a0000002-0000-0000-0000-000000000019';
  s20 UUID := 'a0000002-0000-0000-0000-000000000020';
  s21 UUID := 'a0000002-0000-0000-0000-000000000021';
  s22 UUID := 'a0000002-0000-0000-0000-000000000022';
  s23 UUID := 'a0000002-0000-0000-0000-000000000023';
  s24 UUID := 'a0000002-0000-0000-0000-000000000024';
  s25 UUID := 'a0000002-0000-0000-0000-000000000025';
  s26 UUID := 'a0000002-0000-0000-0000-000000000026';
  s27 UUID := 'a0000002-0000-0000-0000-000000000027';
  s28 UUID := 'a0000002-0000-0000-0000-000000000028';
  s29 UUID := 'a0000002-0000-0000-0000-000000000029';
  s30 UUID := 'a0000002-0000-0000-0000-000000000030';
  s31 UUID := 'a0000002-0000-0000-0000-000000000031';
  s32 UUID := 'a0000002-0000-0000-0000-000000000032';
  s33 UUID := 'a0000002-0000-0000-0000-000000000033';
  s34 UUID := 'a0000002-0000-0000-0000-000000000034';
  s35 UUID := 'a0000002-0000-0000-0000-000000000035';
  s36 UUID := 'a0000002-0000-0000-0000-000000000036';
  s37 UUID := 'a0000002-0000-0000-0000-000000000037';
  s38 UUID := 'a0000002-0000-0000-0000-000000000038';
  s39 UUID := 'a0000002-0000-0000-0000-000000000039';
  s40 UUID := 'a0000002-0000-0000-0000-000000000040';
  s41 UUID := 'a0000002-0000-0000-0000-000000000041';
  s42 UUID := 'a0000002-0000-0000-0000-000000000042';
  s43 UUID := 'a0000002-0000-0000-0000-000000000043';
  s44 UUID := 'a0000002-0000-0000-0000-000000000044';
  s45 UUID := 'a0000002-0000-0000-0000-000000000045';
  s46 UUID := 'a0000002-0000-0000-0000-000000000046';
  s47 UUID := 'a0000002-0000-0000-0000-000000000047';
  s48 UUID := 'a0000002-0000-0000-0000-000000000048';
  s49 UUID := 'a0000002-0000-0000-0000-000000000049';
  s50 UUID := 'a0000002-0000-0000-0000-000000000050';
  s51 UUID := 'a0000002-0000-0000-0000-000000000051';
  s52 UUID := 'a0000002-0000-0000-0000-000000000052';
  s53 UUID := 'a0000002-0000-0000-0000-000000000053';
  s54 UUID := 'a0000002-0000-0000-0000-000000000054';
  s55 UUID := 'a0000002-0000-0000-0000-000000000055';
  s56 UUID := 'a0000002-0000-0000-0000-000000000056';
  s57 UUID := 'a0000002-0000-0000-0000-000000000057';
  s58 UUID := 'a0000002-0000-0000-0000-000000000058';
  s59 UUID := 'a0000002-0000-0000-0000-000000000059';
  s60 UUID := 'a0000002-0000-0000-0000-000000000060';
  s61 UUID := 'a0000002-0000-0000-0000-000000000061';
  s62 UUID := 'a0000002-0000-0000-0000-000000000062';
  s63 UUID := 'a0000002-0000-0000-0000-000000000063';
  s64 UUID := 'a0000002-0000-0000-0000-000000000064';
  s65 UUID := 'a0000002-0000-0000-0000-000000000065';

  -- Giver UUIDs (g16-g65)
  g16 UUID := 'b0000002-0000-0000-0000-000000000016';
  g17 UUID := 'b0000002-0000-0000-0000-000000000017';
  g18 UUID := 'b0000002-0000-0000-0000-000000000018';
  g19 UUID := 'b0000002-0000-0000-0000-000000000019';
  g20 UUID := 'b0000002-0000-0000-0000-000000000020';
  g21 UUID := 'b0000002-0000-0000-0000-000000000021';
  g22 UUID := 'b0000002-0000-0000-0000-000000000022';
  g23 UUID := 'b0000002-0000-0000-0000-000000000023';
  g24 UUID := 'b0000002-0000-0000-0000-000000000024';
  g25 UUID := 'b0000002-0000-0000-0000-000000000025';
  g26 UUID := 'b0000002-0000-0000-0000-000000000026';
  g27 UUID := 'b0000002-0000-0000-0000-000000000027';
  g28 UUID := 'b0000002-0000-0000-0000-000000000028';
  g29 UUID := 'b0000002-0000-0000-0000-000000000029';
  g30 UUID := 'b0000002-0000-0000-0000-000000000030';
  g31 UUID := 'b0000002-0000-0000-0000-000000000031';
  g32 UUID := 'b0000002-0000-0000-0000-000000000032';
  g33 UUID := 'b0000002-0000-0000-0000-000000000033';
  g34 UUID := 'b0000002-0000-0000-0000-000000000034';
  g35 UUID := 'b0000002-0000-0000-0000-000000000035';
  g36 UUID := 'b0000002-0000-0000-0000-000000000036';
  g37 UUID := 'b0000002-0000-0000-0000-000000000037';
  g38 UUID := 'b0000002-0000-0000-0000-000000000038';
  g39 UUID := 'b0000002-0000-0000-0000-000000000039';
  g40 UUID := 'b0000002-0000-0000-0000-000000000040';
  g41 UUID := 'b0000002-0000-0000-0000-000000000041';
  g42 UUID := 'b0000002-0000-0000-0000-000000000042';
  g43 UUID := 'b0000002-0000-0000-0000-000000000043';
  g44 UUID := 'b0000002-0000-0000-0000-000000000044';
  g45 UUID := 'b0000002-0000-0000-0000-000000000045';
  g46 UUID := 'b0000002-0000-0000-0000-000000000046';
  g47 UUID := 'b0000002-0000-0000-0000-000000000047';
  g48 UUID := 'b0000002-0000-0000-0000-000000000048';
  g49 UUID := 'b0000002-0000-0000-0000-000000000049';
  g50 UUID := 'b0000002-0000-0000-0000-000000000050';
  g51 UUID := 'b0000002-0000-0000-0000-000000000051';
  g52 UUID := 'b0000002-0000-0000-0000-000000000052';
  g53 UUID := 'b0000002-0000-0000-0000-000000000053';
  g54 UUID := 'b0000002-0000-0000-0000-000000000054';
  g55 UUID := 'b0000002-0000-0000-0000-000000000055';
  g56 UUID := 'b0000002-0000-0000-0000-000000000056';
  g57 UUID := 'b0000002-0000-0000-0000-000000000057';
  g58 UUID := 'b0000002-0000-0000-0000-000000000058';
  g59 UUID := 'b0000002-0000-0000-0000-000000000059';
  g60 UUID := 'b0000002-0000-0000-0000-000000000060';
  g61 UUID := 'b0000002-0000-0000-0000-000000000061';
  g62 UUID := 'b0000002-0000-0000-0000-000000000062';
  g63 UUID := 'b0000002-0000-0000-0000-000000000063';
  g64 UUID := 'b0000002-0000-0000-0000-000000000064';
  g65 UUID := 'b0000002-0000-0000-0000-000000000065';

  -- Both UUIDs (b01-b30)
  b01 UUID := 'c0000001-0000-0000-0000-000000000001';
  b02 UUID := 'c0000001-0000-0000-0000-000000000002';
  b03 UUID := 'c0000001-0000-0000-0000-000000000003';
  b04 UUID := 'c0000001-0000-0000-0000-000000000004';
  b05 UUID := 'c0000001-0000-0000-0000-000000000005';
  b06 UUID := 'c0000001-0000-0000-0000-000000000006';
  b07 UUID := 'c0000001-0000-0000-0000-000000000007';
  b08 UUID := 'c0000001-0000-0000-0000-000000000008';
  b09 UUID := 'c0000001-0000-0000-0000-000000000009';
  b10 UUID := 'c0000001-0000-0000-0000-000000000010';
  b11 UUID := 'c0000001-0000-0000-0000-000000000011';
  b12 UUID := 'c0000001-0000-0000-0000-000000000012';
  b13 UUID := 'c0000001-0000-0000-0000-000000000013';
  b14 UUID := 'c0000001-0000-0000-0000-000000000014';
  b15 UUID := 'c0000001-0000-0000-0000-000000000015';
  b16 UUID := 'c0000001-0000-0000-0000-000000000016';
  b17 UUID := 'c0000001-0000-0000-0000-000000000017';
  b18 UUID := 'c0000001-0000-0000-0000-000000000018';
  b19 UUID := 'c0000001-0000-0000-0000-000000000019';
  b20 UUID := 'c0000001-0000-0000-0000-000000000020';
  b21 UUID := 'c0000001-0000-0000-0000-000000000021';
  b22 UUID := 'c0000001-0000-0000-0000-000000000022';
  b23 UUID := 'c0000001-0000-0000-0000-000000000023';
  b24 UUID := 'c0000001-0000-0000-0000-000000000024';
  b25 UUID := 'c0000001-0000-0000-0000-000000000025';
  b26 UUID := 'c0000001-0000-0000-0000-000000000026';
  b27 UUID := 'c0000001-0000-0000-0000-000000000027';
  b28 UUID := 'c0000001-0000-0000-0000-000000000028';
  b29 UUID := 'c0000001-0000-0000-0000-000000000029';
  b30 UUID := 'c0000001-0000-0000-0000-000000000030';

BEGIN

-- =============================================================================
-- AUTH.USERS: Create auth entries for all 130 expansion test users
-- =============================================================================

INSERT INTO auth.users (id, instance_id, email, encrypted_password, email_confirmed_at, created_at, updated_at, raw_app_meta_data, raw_user_meta_data, aud, role)
VALUES
  -- ---- SEEKERS (s16-s65) ----
  (s16, '00000000-0000-0000-0000-000000000000', 'olivia.tran@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Olivia Tran"}',         'authenticated', 'authenticated'),
  (s17, '00000000-0000-0000-0000-000000000000', 'james.adebayo@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"James Adebayo"}',       'authenticated', 'authenticated'),
  (s18, '00000000-0000-0000-0000-000000000000', 'catalina.reyes@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Catalina Reyes"}',      'authenticated', 'authenticated'),
  (s19, '00000000-0000-0000-0000-000000000000', 'wei.lin@test.com',             pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Wei Lin"}',             'authenticated', 'authenticated'),
  (s20, '00000000-0000-0000-0000-000000000000', 'destiny.williams@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Destiny Williams"}',    'authenticated', 'authenticated'),
  (s21, '00000000-0000-0000-0000-000000000000', 'patrick.obrien@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Patrick O''Brien"}',    'authenticated', 'authenticated'),
  (s22, '00000000-0000-0000-0000-000000000000', 'fatima.alrashid@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Fatima Al-Rashid"}',    'authenticated', 'authenticated'),
  (s23, '00000000-0000-0000-0000-000000000000', 'kofi.mensah@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kofi Mensah"}',         'authenticated', 'authenticated'),
  (s24, '00000000-0000-0000-0000-000000000000', 'isabella.costa@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Isabella Costa"}',      'authenticated', 'authenticated'),
  (s25, '00000000-0000-0000-0000-000000000000', 'yuki.tanaka@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Yuki Tanaka"}',         'authenticated', 'authenticated'),
  (s26, '00000000-0000-0000-0000-000000000000', 'andre.baptiste@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Andre Baptiste"}',      'authenticated', 'authenticated'),
  (s27, '00000000-0000-0000-0000-000000000000', 'hannah.schwartz@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Hannah Schwartz"}',     'authenticated', 'authenticated'),
  (s28, '00000000-0000-0000-0000-000000000000', 'ravi.krishnan@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ravi Krishnan"}',       'authenticated', 'authenticated'),
  (s29, '00000000-0000-0000-0000-000000000000', 'camille.dupont@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Camille Dupont"}',      'authenticated', 'authenticated'),
  (s30, '00000000-0000-0000-0000-000000000000', 'elijah.carter@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Elijah Carter"}',       'authenticated', 'authenticated'),
  (s31, '00000000-0000-0000-0000-000000000000', 'meiling.wu@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Mei-Ling Wu"}',         'authenticated', 'authenticated'),
  (s32, '00000000-0000-0000-0000-000000000000', 'samuel.osei@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Samuel Osei"}',         'authenticated', 'authenticated'),
  (s33, '00000000-0000-0000-0000-000000000000', 'ava.petrov@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ava Petrov"}',          'authenticated', 'authenticated'),
  (s34, '00000000-0000-0000-0000-000000000000', 'carlos.mendoza@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Carlos Mendoza"}',      'authenticated', 'authenticated'),
  (s35, '00000000-0000-0000-0000-000000000000', 'grace.nakamura@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Grace Nakamura"}',      'authenticated', 'authenticated'),
  (s36, '00000000-0000-0000-0000-000000000000', 'jamal.robinson@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jamal Robinson"}',      'authenticated', 'authenticated'),
  (s37, '00000000-0000-0000-0000-000000000000', 'sana.malik@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sana Malik"}',          'authenticated', 'authenticated'),
  (s38, '00000000-0000-0000-0000-000000000000', 'luca.romano@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Luca Romano"}',         'authenticated', 'authenticated'),
  (s39, '00000000-0000-0000-0000-000000000000', 'nadia.volkov@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Nadia Volkov"}',        'authenticated', 'authenticated'),
  (s40, '00000000-0000-0000-0000-000000000000', 'darnell.washington@test.com',  pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Darnell Washington"}',  'authenticated', 'authenticated'),
  (s41, '00000000-0000-0000-0000-000000000000', 'ximena.flores@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ximena Flores"}',       'authenticated', 'authenticated'),
  (s42, '00000000-0000-0000-0000-000000000000', 'brendan.kelly@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Brendan Kelly"}',       'authenticated', 'authenticated'),
  (s43, '00000000-0000-0000-0000-000000000000', 'aisling.brennan@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Aisling Brennan"}',     'authenticated', 'authenticated'),
  (s44, '00000000-0000-0000-0000-000000000000', 'omar.diallo@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Omar Diallo"}',         'authenticated', 'authenticated'),
  (s45, '00000000-0000-0000-0000-000000000000', 'leah.goldberg@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Leah Goldberg"}',       'authenticated', 'authenticated'),
  (s46, '00000000-0000-0000-0000-000000000000', 'tenzin.dorje@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tenzin Dorje"}',        'authenticated', 'authenticated'),
  (s47, '00000000-0000-0000-0000-000000000000', 'aaliyah.jackson@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Aaliyah Jackson"}',     'authenticated', 'authenticated'),
  (s48, '00000000-0000-0000-0000-000000000000', 'pavel.novak@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Pavel Novak"}',         'authenticated', 'authenticated'),
  (s49, '00000000-0000-0000-0000-000000000000', 'mireya.santos@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Mireya Santos"}',       'authenticated', 'authenticated'),
  (s50, '00000000-0000-0000-0000-000000000000', 'devon.marshall@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Devon Marshall"}',      'authenticated', 'authenticated'),
  (s51, '00000000-0000-0000-0000-000000000000', 'shreya.iyer@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Shreya Iyer"}',         'authenticated', 'authenticated'),
  (s52, '00000000-0000-0000-0000-000000000000', 'tobias.engstrom@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tobias Engstr\u00f6m"}',     'authenticated', 'authenticated'),
  (s53, '00000000-0000-0000-0000-000000000000', 'chidera.eze@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Chidera Eze"}',         'authenticated', 'authenticated'),
  (s54, '00000000-0000-0000-0000-000000000000', 'rosa.martinez@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Rosa Martinez"}',       'authenticated', 'authenticated'),
  (s55, '00000000-0000-0000-0000-000000000000', 'kai.nakamura@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kai Nakamura"}',        'authenticated', 'authenticated'),
  (s56, '00000000-0000-0000-0000-000000000000', 'jasmine.lee@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jasmine Lee"}',         'authenticated', 'authenticated'),
  (s57, '00000000-0000-0000-0000-000000000000', 'alejandro.vega@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Alejandro Vega"}',      'authenticated', 'authenticated'),
  (s58, '00000000-0000-0000-0000-000000000000', 'ingrid.larsen@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ingrid Larsen"}',       'authenticated', 'authenticated'),
  (s59, '00000000-0000-0000-0000-000000000000', 'kwame.asante@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kwame Asante"}',        'authenticated', 'authenticated'),
  (s60, '00000000-0000-0000-0000-000000000000', 'sienna.walsh@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sienna Walsh"}',        'authenticated', 'authenticated'),
  (s61, '00000000-0000-0000-0000-000000000000', 'haruki.sato@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Haruki Sato"}',         'authenticated', 'authenticated'),
  (s62, '00000000-0000-0000-0000-000000000000', 'zara.ahmed@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Zara Ahmed"}',          'authenticated', 'authenticated'),
  (s63, '00000000-0000-0000-0000-000000000000', 'declan.fitzgerald@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Declan Fitzgerald"}',   'authenticated', 'authenticated'),
  (s64, '00000000-0000-0000-0000-000000000000', 'priscilla.okonkwo@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Priscilla Okonkwo"}',   'authenticated', 'authenticated'),
  (s65, '00000000-0000-0000-0000-000000000000', 'mateo.rivera@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Mateo Rivera"}',        'authenticated', 'authenticated'),

  -- ---- GIVERS (g16-g65) ----
  (g16, '00000000-0000-0000-0000-000000000000', 'victoria.chang@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Victoria Chang"}',      'authenticated', 'authenticated'),
  (g17, '00000000-0000-0000-0000-000000000000', 'robert.okafor@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Robert Okafor"}',       'authenticated', 'authenticated'),
  (g18, '00000000-0000-0000-0000-000000000000', 'maria.gutierrez@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Maria Gutierrez"}',     'authenticated', 'authenticated'),
  (g19, '00000000-0000-0000-0000-000000000000', 'takeshi.yamada@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Takeshi Yamada"}',      'authenticated', 'authenticated'),
  (g20, '00000000-0000-0000-0000-000000000000', 'lauren.davis@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Lauren Davis"}',        'authenticated', 'authenticated'),
  (g21, '00000000-0000-0000-0000-000000000000', 'niall.mccarthy@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Niall McCarthy"}',      'authenticated', 'authenticated'),
  (g22, '00000000-0000-0000-0000-000000000000', 'aisha.bello@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Aisha Bello"}',         'authenticated', 'authenticated'),
  (g23, '00000000-0000-0000-0000-000000000000', 'marcus.chen@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Marcus Chen"}',         'authenticated', 'authenticated'),
  (g24, '00000000-0000-0000-0000-000000000000', 'francesca.dimaggio@test.com',  pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Francesca DiMaggio"}',  'authenticated', 'authenticated'),
  (g25, '00000000-0000-0000-0000-000000000000', 'hiroshi.watanabe@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Hiroshi Watanabe"}',    'authenticated', 'authenticated'),
  (g26, '00000000-0000-0000-0000-000000000000', 'tamara.jefferson@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tamara Jefferson"}',    'authenticated', 'authenticated'),
  (g27, '00000000-0000-0000-0000-000000000000', 'daniel.strauss@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Daniel Strauss"}',      'authenticated', 'authenticated'),
  (g28, '00000000-0000-0000-0000-000000000000', 'sunita.reddy@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sunita Reddy"}',        'authenticated', 'authenticated'),
  (g29, '00000000-0000-0000-0000-000000000000', 'pierre.laurent@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Pierre Laurent"}',      'authenticated', 'authenticated'),
  (g30, '00000000-0000-0000-0000-000000000000', 'keisha.thompson@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Keisha Thompson"}',     'authenticated', 'authenticated'),
  (g31, '00000000-0000-0000-0000-000000000000', 'andrew.kim@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Andrew Kim"}',          'authenticated', 'authenticated'),
  (g32, '00000000-0000-0000-0000-000000000000', 'nana.amoako@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Nana Amoako"}',         'authenticated', 'authenticated'),
  (g33, '00000000-0000-0000-0000-000000000000', 'elena.popov@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Elena Popov"}',         'authenticated', 'authenticated'),
  (g34, '00000000-0000-0000-0000-000000000000', 'javier.morales@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Javier Morales"}',      'authenticated', 'authenticated'),
  (g35, '00000000-0000-0000-0000-000000000000', 'rebecca.stern@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Rebecca Stern"}',       'authenticated', 'authenticated'),
  (g36, '00000000-0000-0000-0000-000000000000', 'deshawn.harris@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Deshawn Harris"}',      'authenticated', 'authenticated'),
  (g37, '00000000-0000-0000-0000-000000000000', 'fatou.diop@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Fatou Diop"}',          'authenticated', 'authenticated'),
  (g38, '00000000-0000-0000-0000-000000000000', 'giovanni.bianchi@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Giovanni Bianchi"}',    'authenticated', 'authenticated'),
  (g39, '00000000-0000-0000-0000-000000000000', 'olga.kuznetsova@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Olga Kuznetsova"}',     'authenticated', 'authenticated'),
  (g40, '00000000-0000-0000-0000-000000000000', 'terrence.jackson@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Terrence Jackson"}',    'authenticated', 'authenticated'),
  (g41, '00000000-0000-0000-0000-000000000000', 'luz.delgado@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Luz Delgado"}',         'authenticated', 'authenticated'),
  (g42, '00000000-0000-0000-0000-000000000000', 'sean.gallagher@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sean Gallagher"}',      'authenticated', 'authenticated'),
  (g43, '00000000-0000-0000-0000-000000000000', 'amina.ibrahim@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Amina Ibrahim"}',       'authenticated', 'authenticated'),
  (g44, '00000000-0000-0000-0000-000000000000', 'philippe.moreau@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Philippe Moreau"}',     'authenticated', 'authenticated'),
  (g45, '00000000-0000-0000-0000-000000000000', 'janet.obi@test.com',           pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Janet Obi"}',           'authenticated', 'authenticated'),
  (g46, '00000000-0000-0000-0000-000000000000', 'mingyu.zhang@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Mingyu Zhang"}',        'authenticated', 'authenticated'),
  (g47, '00000000-0000-0000-0000-000000000000', 'courtney.brooks@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Courtney Brooks"}',     'authenticated', 'authenticated'),
  (g48, '00000000-0000-0000-0000-000000000000', 'viktor.petrov@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Viktor Petrov"}',       'authenticated', 'authenticated'),
  (g49, '00000000-0000-0000-0000-000000000000', 'carmen.herrera@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Carmen Herrera"}',      'authenticated', 'authenticated'),
  (g50, '00000000-0000-0000-0000-000000000000', 'walter.freeman@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Walter Freeman"}',      'authenticated', 'authenticated'),
  (g51, '00000000-0000-0000-0000-000000000000', 'deepika.sharma@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Deepika Sharma"}',      'authenticated', 'authenticated'),
  (g52, '00000000-0000-0000-0000-000000000000', 'lars.eriksen@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Lars Eriksen"}',        'authenticated', 'authenticated'),
  (g53, '00000000-0000-0000-0000-000000000000', 'abena.owusu@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Abena Owusu"}',         'authenticated', 'authenticated'),
  (g54, '00000000-0000-0000-0000-000000000000', 'gabriela.santos@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Gabriela Santos"}',     'authenticated', 'authenticated'),
  (g55, '00000000-0000-0000-0000-000000000000', 'kentaro.fujimoto@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kentaro Fujimoto"}',    'authenticated', 'authenticated'),
  (g56, '00000000-0000-0000-0000-000000000000', 'michelle.park@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Michelle Park"}',       'authenticated', 'authenticated'),
  (g57, '00000000-0000-0000-0000-000000000000', 'eduardo.ramirez@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Eduardo Ramirez"}',     'authenticated', 'authenticated'),
  (g58, '00000000-0000-0000-0000-000000000000', 'astrid.nielsen@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Astrid Nielsen"}',      'authenticated', 'authenticated'),
  (g59, '00000000-0000-0000-0000-000000000000', 'kwesi.appiah@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Kwesi Appiah"}',        'authenticated', 'authenticated'),
  (g60, '00000000-0000-0000-0000-000000000000', 'sandra.kowalski@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sandra Kowalski"}',     'authenticated', 'authenticated'),
  (g61, '00000000-0000-0000-0000-000000000000', 'tomohiro.ito@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tomohiro Ito"}',        'authenticated', 'authenticated'),
  (g62, '00000000-0000-0000-0000-000000000000', 'naima.hassan@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Naima Hassan"}',        'authenticated', 'authenticated'),
  (g63, '00000000-0000-0000-0000-000000000000', 'conor.murphy@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Conor Murphy"}',        'authenticated', 'authenticated'),
  (g64, '00000000-0000-0000-0000-000000000000', 'folake.adeyemi@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Folake Adeyemi"}',      'authenticated', 'authenticated'),
  (g65, '00000000-0000-0000-0000-000000000000', 'ricardo.alonso@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ricardo Alonso"}',      'authenticated', 'authenticated'),

  -- ---- BOTH (b01-b30) ----
  (b01, '00000000-0000-0000-0000-000000000000', 'jessica.hwang@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jessica Hwang"}',       'authenticated', 'authenticated'),
  (b02, '00000000-0000-0000-0000-000000000000', 'emeka.nwosu@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Emeka Nwosu"}',         'authenticated', 'authenticated'),
  (b03, '00000000-0000-0000-0000-000000000000', 'sophia.andersson@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Sophia Andersson"}',    'authenticated', 'authenticated'),
  (b04, '00000000-0000-0000-0000-000000000000', 'rafael.torres@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Rafael Torres"}',       'authenticated', 'authenticated'),
  (b05, '00000000-0000-0000-0000-000000000000', 'amara.diallo@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Amara Diallo"}',        'authenticated', 'authenticated'),
  (b06, '00000000-0000-0000-0000-000000000000', 'nathan.bernstein@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Nathan Bernstein"}',    'authenticated', 'authenticated'),
  (b07, '00000000-0000-0000-0000-000000000000', 'yuna.park@test.com',           pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Yuna Park"}',           'authenticated', 'authenticated'),
  (b08, '00000000-0000-0000-0000-000000000000', 'isaiah.brown@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Isaiah Brown"}',        'authenticated', 'authenticated'),
  (b09, '00000000-0000-0000-0000-000000000000', 'luisa.fernandez@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Luisa Fernandez"}',     'authenticated', 'authenticated'),
  (b10, '00000000-0000-0000-0000-000000000000', 'arjun.mehta@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Arjun Mehta"}',         'authenticated', 'authenticated'),
  (b11, '00000000-0000-0000-0000-000000000000', 'clare.sullivan@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Clare Sullivan"}',      'authenticated', 'authenticated'),
  (b12, '00000000-0000-0000-0000-000000000000', 'dmitri.volkov@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Dmitri Volkov"}',       'authenticated', 'authenticated'),
  (b13, '00000000-0000-0000-0000-000000000000', 'blessing.okafor@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Blessing Okafor"}',     'authenticated', 'authenticated'),
  (b14, '00000000-0000-0000-0000-000000000000', 'marco.rossi@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Marco Rossi"}',         'authenticated', 'authenticated'),
  (b15, '00000000-0000-0000-0000-000000000000', 'hana.kimura@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Hana Kimura"}',         'authenticated', 'authenticated'),
  (b16, '00000000-0000-0000-0000-000000000000', 'malik.henderson@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Malik Henderson"}',     'authenticated', 'authenticated'),
  (b17, '00000000-0000-0000-0000-000000000000', 'elif.yilmaz@test.com',         pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Elif Yilmaz"}',         'authenticated', 'authenticated'),
  (b18, '00000000-0000-0000-0000-000000000000', 'christian.wagner@test.com',    pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Christian Wagner"}',    'authenticated', 'authenticated'),
  (b19, '00000000-0000-0000-0000-000000000000', 'zainab.osman@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Zainab Osman"}',        'authenticated', 'authenticated'),
  (b20, '00000000-0000-0000-0000-000000000000', 'ryan.doyle@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Ryan Doyle"}',          'authenticated', 'authenticated'),
  (b21, '00000000-0000-0000-0000-000000000000', 'mia.johansson@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Mia Johansson"}',       'authenticated', 'authenticated'),
  (b22, '00000000-0000-0000-0000-000000000000', 'tunde.bakare@test.com',        pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tunde Bakare"}',        'authenticated', 'authenticated'),
  (b23, '00000000-0000-0000-0000-000000000000', 'anastasia.smirnov@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Anastasia Smirnov"}',   'authenticated', 'authenticated'),
  (b24, '00000000-0000-0000-0000-000000000000', 'julian.castillo@test.com',     pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Julian Castillo"}',     'authenticated', 'authenticated'),
  (b25, '00000000-0000-0000-0000-000000000000', 'priyanka.chopradesai@test.com', pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Priyanka Chopra-Desai"}', 'authenticated', 'authenticated'),
  (b26, '00000000-0000-0000-0000-000000000000', 'owen.mcnamara@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Owen McNamara"}',       'authenticated', 'authenticated'),
  (b27, '00000000-0000-0000-0000-000000000000', 'esther.mensah@test.com',       pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Esther Mensah"}',       'authenticated', 'authenticated'),
  (b28, '00000000-0000-0000-0000-000000000000', 'stefan.mueller@test.com',      pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Stefan Mueller"}',      'authenticated', 'authenticated'),
  (b29, '00000000-0000-0000-0000-000000000000', 'nneka.igwe@test.com',          pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Nneka Igwe"}',          'authenticated', 'authenticated'),
  (b30, '00000000-0000-0000-0000-000000000000', 'leonardo.bautista@test.com',   pw_hash, NOW(), NOW(), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Leonardo Bautista"}',   'authenticated', 'authenticated')
ON CONFLICT (id) DO NOTHING;

-- Also create identities for each user (required by Supabase Auth)
INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, created_at, updated_at, last_sign_in_at)
SELECT id, id, raw_user_meta_data, 'email', id::text, NOW(), NOW(), NOW()
FROM auth.users
WHERE id IN (s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,
             s31,s32,s33,s34,s35,s36,s37,s38,s39,s40,s41,s42,s43,s44,s45,
             s46,s47,s48,s49,s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s60,
             s61,s62,s63,s64,s65,
             g16,g17,g18,g19,g20,g21,g22,g23,g24,g25,g26,g27,g28,g29,g30,
             g31,g32,g33,g34,g35,g36,g37,g38,g39,g40,g41,g42,g43,g44,g45,
             g46,g47,g48,g49,g50,g51,g52,g53,g54,g55,g56,g57,g58,g59,g60,
             g61,g62,g63,g64,g65,
             b01,b02,b03,b04,b05,b06,b07,b08,b09,b10,b11,b12,b13,b14,b15,
             b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27,b28,b29,b30)
ON CONFLICT DO NOTHING;

-- =============================================
-- PROFILES
-- =============================================

-- Seeker profiles (s16-s65)


-- Giver profiles (g16-g65)
INSERT INTO public.profiles (id, email, full_name, location_city, location_state, bio, is_seeker, is_giver, onboarding_completed) VALUES
(g16, 'victoria.chang@test.com', 'Victoria Chang', 'San Francisco', 'CA', 'Senior product manager at a leading tech company with 12 years of experience building consumer and enterprise products. Passionate about helping early-career professionals navigate the tech industry.', false, true, true),
(g17, 'robert.okafor@test.com', 'Robert Okafor', 'New York', 'NY', 'Investment banking VP with expertise in M&A and capital markets across healthcare and technology sectors. Love mentoring students interested in breaking into finance.', false, true, true),
(g18, 'maria.gutierrez@test.com', 'Maria Gutierrez', 'Houston', 'TX', 'Management consultant specializing in energy and sustainability transformations. Excited to share insights from 9 years of strategy work across Fortune 500 clients.', false, true, true),
(g19, 'takeshi.yamada@test.com', 'Takeshi Yamada', 'Seattle', 'WA', 'Software engineering manager with deep expertise in cloud infrastructure and distributed systems. Happy to help aspiring engineers develop technical and leadership skills.', false, true, true),
(g20, 'lauren.davis@test.com', 'Lauren Davis', 'Boston', 'MA', 'Healthcare administrator and policy advisor with 15 years navigating hospital operations and health policy. Committed to mentoring the next generation of healthcare leaders.', false, true, true),
(g21, 'niall.mccarthy@test.com', 'Niall McCarthy', 'Chicago', 'IL', 'Private equity principal focused on middle-market buyouts and operational value creation. Enjoy coaching candidates on finance careers and deal execution.', false, true, true),
(g22, 'aisha.bello@test.com', 'Aisha Bello', 'Atlanta', 'GA', 'Marketing director with expertise in brand strategy and digital transformation for consumer goods companies. Passionate about developing diverse talent in marketing.', false, true, true),
(g23, 'marcus.chen@test.com', 'Marcus Chen', 'San Jose', 'CA', 'Venture capital investor focused on early-stage enterprise software and AI companies. Love helping entrepreneurs and those interested in VC careers.', false, true, true),
(g24, 'francesca.dimaggio@test.com', 'Francesca DiMaggio', 'Los Angeles', 'CA', 'Entertainment industry executive with 13 years in film production and content strategy. Excited to mentor creatives navigating the media landscape.', false, true, true),
(g25, 'hiroshi.watanabe@test.com', 'Hiroshi Watanabe', 'Austin', 'TX', 'Automotive engineering director specializing in electric vehicle systems and autonomous driving technology. Happy to guide engineers entering the mobility sector.', false, true, true),
(g26, 'tamara.jefferson@test.com', 'Tamara Jefferson', 'Washington', 'DC', 'Senior policy advisor with experience across education and civil rights in federal government. Committed to mentoring those pursuing public service careers.', false, true, true),
(g27, 'daniel.strauss@test.com', 'Daniel Strauss', 'Philadelphia', 'PA', 'Corporate attorney specializing in securities law and corporate governance. Enjoy helping law students and junior attorneys develop their practice.', false, true, true),
(g28, 'sunita.reddy@test.com', 'Sunita Reddy', 'San Diego', 'CA', 'Biotechnology research director with expertise in oncology drug development. Passionate about mentoring scientists pursuing biotech careers.', false, true, true),
(g29, 'pierre.laurent@test.com', 'Pierre Laurent', 'Miami', 'FL', 'International business development leader with 16 years expanding companies into European and Latin American markets. Love advising on global career opportunities.', false, true, true),
(g30, 'keisha.thompson@test.com', 'Keisha Thompson', 'Detroit', 'MI', 'Manufacturing operations executive focused on lean processes and supply chain optimization. Committed to mentoring engineers and operations professionals.', false, true, true),
(g31, 'andrew.kim@test.com', 'Andrew Kim', 'Dallas', 'TX', 'Technology consultant specializing in digital transformation and cloud migration strategies. Happy to help those breaking into consulting or tech.', false, true, true),
(g32, 'nana.amoako@test.com', 'Nana Amoako', 'Phoenix', 'AZ', 'Real estate development director with expertise in mixed-use and affordable housing projects. Passionate about mentoring the next generation of urban developers.', false, true, true),
(g33, 'elena.popov@test.com', 'Elena Popov', 'Denver', 'CO', 'Energy sector analyst focused on renewable energy markets and policy. Excited to guide students interested in sustainability and clean energy careers.', false, true, true),
(g34, 'javier.morales@test.com', 'Javier Morales', 'Portland', 'OR', 'Software product designer with 11 years creating user experiences for consumer and enterprise applications. Love helping designers develop their craft and careers.', false, true, true),
(g35, 'rebecca.stern@test.com', 'Rebecca Stern', 'Minneapolis', 'MN', 'Pharmaceutical regulatory affairs director with deep expertise in FDA approval processes. Committed to mentoring those entering pharma and healthcare.', false, true, true),
(g36, 'deshawn.harris@test.com', 'Deshawn Harris', 'Charlotte', 'NC', 'Commercial banking relationship manager specializing in middle-market corporate clients. Happy to advise on finance careers and relationship management.', false, true, true),
(g37, 'fatou.diop@test.com', 'Fatou Diop', 'Nashville', 'TN', 'Human resources executive focused on talent development and organizational culture. Passionate about coaching professionals on career advancement and leadership.', false, true, true),
(g38, 'giovanni.bianchi@test.com', 'Giovanni Bianchi', 'Salt Lake City', 'UT', 'Management consultant specializing in healthcare strategy and hospital operations. Enjoy mentoring consultants and healthcare administrators.', false, true, true),
(g39, 'olga.kuznetsova@test.com', 'Olga Kuznetsova', 'Raleigh', 'NC', 'Data science manager leading analytics teams in financial services. Excited to help aspiring data scientists and analysts develop technical and business skills.', false, true, true),
(g40, 'terrence.jackson@test.com', 'Terrence Jackson', 'Baltimore', 'MD', 'Defense contractor program manager with expertise in systems engineering and government contracting. Committed to mentoring engineers in defense and aerospace.', false, true, true),
(g41, 'luz.delgado@test.com', 'Luz Delgado', 'San Antonio', 'TX', 'Marketing analytics director specializing in customer insights and digital marketing measurement. Love helping marketers leverage data for strategic decisions.', false, true, true),
(g42, 'sean.gallagher@test.com', 'Sean Gallagher', 'Milwaukee', 'WI', 'Corporate strategy director with 14 years leading M&A and strategic planning initiatives. Happy to mentor those interested in corporate development and strategy.', false, true, true),
(g43, 'amina.ibrahim@test.com', 'Amina Ibrahim', 'Columbus', 'OH', 'Technology project manager with expertise in agile delivery and digital transformation. Passionate about helping PMs and engineers advance their careers.', false, true, true),
(g44, 'philippe.moreau@test.com', 'Philippe Moreau', 'Indianapolis', 'IN', 'Pharmaceutical sales director with extensive experience in specialty therapeutics. Excited to mentor sales professionals and those entering pharma commercial roles.', false, true, true),
(g45, 'janet.obi@test.com', 'Janet Obi', 'Kansas City', 'MO', 'Environmental engineer leading sustainability initiatives for manufacturing companies. Committed to guiding engineers passionate about environmental impact.', false, true, true),
(g46, 'mingyu.zhang@test.com', 'Mingyu Zhang', 'Pittsburgh', 'PA', 'Artificial intelligence researcher with focus on machine learning applications in healthcare. Love mentoring aspiring AI engineers and researchers.', false, true, true),
(g47, 'courtney.brooks@test.com', 'Courtney Brooks', 'Las Vegas', 'NV', 'Hospitality and entertainment operations executive with 12 years managing large venues. Happy to advise on careers in events, hospitality, and entertainment.', false, true, true),
(g48, 'viktor.petrov@test.com', 'Viktor Petrov', 'Richmond', 'VA', 'Cybersecurity director protecting critical infrastructure and financial services systems. Passionate about developing the next generation of security professionals.', false, true, true),
(g49, 'carmen.herrera@test.com', 'Carmen Herrera', 'Tampa', 'FL', 'Fashion and retail merchandising director with expertise in e-commerce and brand development. Excited to mentor those pursuing creative commerce careers.', false, true, true),
(g50, 'walter.freeman@test.com', 'Walter Freeman', 'St. Louis', 'MO', 'Financial planning and analysis director with experience across healthcare and manufacturing. Committed to helping finance professionals develop analytical and strategic skills.', false, true, true),
(g51, 'deepika.sharma@test.com', 'Deepika Sharma', 'Orlando', 'FL', 'Consulting manager specializing in technology strategy and digital operations. Love coaching consultants and those breaking into strategy consulting.', false, true, true),
(g52, 'lars.eriksen@test.com', 'Lars Eriksen', 'Sacramento', 'CA', 'Renewable energy project developer focused on solar and wind infrastructure. Happy to mentor engineers and developers in the clean energy transition.', false, true, true),
(g53, 'abena.owusu@test.com', 'Abena Owusu', 'Jacksonville', 'FL', 'Public health program director with expertise in community health and health equity initiatives. Passionate about mentoring future public health leaders.', false, true, true),
(g54, 'gabriela.santos@test.com', 'Gabriela Santos', 'Louisville', 'KY', 'Supply chain director optimizing logistics and procurement for consumer goods companies. Excited to guide operations and supply chain professionals.', false, true, true),
(g55, 'kentaro.fujimoto@test.com', 'Kentaro Fujimoto', 'Tucson', 'AZ', 'Mechanical engineer specializing in aerospace systems and advanced manufacturing. Committed to mentoring engineers entering aerospace and defense.', false, true, true),
(g56, 'michelle.park@test.com', 'Michelle Park', 'Oklahoma City', 'OK', 'Investment analyst covering energy and industrials sectors for asset management firm. Happy to advise on finance careers and equity research.', false, true, true),
(g57, 'eduardo.ramirez@test.com', 'Eduardo Ramirez', 'Albuquerque', 'NM', 'Government relations director managing policy advocacy and stakeholder engagement. Love mentoring those interested in government affairs and public policy.', false, true, true),
(g58, 'astrid.nielsen@test.com', 'Astrid Nielsen', 'Omaha', 'NE', 'Insurance underwriting director with expertise in commercial risk assessment. Passionate about developing talent in insurance and risk management.', false, true, true),
(g59, 'kwesi.appiah@test.com', 'Kwesi Appiah', 'Memphis', 'TN', 'Media production executive with experience in documentary filmmaking and streaming content. Excited to mentor creatives navigating modern media careers.', false, true, true),
(g60, 'sandra.kowalski@test.com', 'Sandra Kowalski', 'Fresno', 'CA', 'Agricultural technology manager leading precision farming and sustainability initiatives. Committed to mentoring engineers and entrepreneurs in agtech.', false, true, true),
(g61, 'tomohiro.ito@test.com', 'Tomohiro Ito', 'Mesa', 'AZ', 'Semiconductor engineer with expertise in chip design and manufacturing processes. Happy to guide engineers entering the semiconductor industry.', false, true, true),
(g62, 'naima.hassan@test.com', 'Naima Hassan', 'New Orleans', 'LA', 'Social impact consultant working with nonprofits and foundations on program strategy. Passionate about mentoring those pursuing purpose-driven careers.', false, true, true),
(g63, 'conor.murphy@test.com', 'Conor Murphy', 'Cleveland', 'OH', 'Commercial real estate broker specializing in office and industrial properties. Love advising on real estate careers and deal structuring.', false, true, true),
(g64, 'folake.adeyemi@test.com', 'Folake Adeyemi', 'Boise', 'ID', 'Technology sales leader managing enterprise software accounts and team development. Excited to mentor sales professionals and those entering SaaS.', false, true, true),
(g65, 'ricardo.alonso@test.com', 'Ricardo Alonso', 'Burlington', 'VT', 'Environmental policy analyst focused on climate adaptation and conservation strategies. Committed to guiding those passionate about environmental careers.', false, true, true)
ON CONFLICT DO NOTHING;

-- Both profiles (b01-b30)
INSERT INTO public.profiles (id, email, full_name, location_city, location_state, bio, is_seeker, is_giver, onboarding_completed) VALUES
(b01, 'jessica.hwang@test.com', 'Jessica Hwang', 'San Francisco', 'CA', 'Product manager with 5 years in tech looking to transition into venture capital. I''ve led cross-functional teams and shipped several products, and I''m eager to help others break into product management while I explore the VC world.', true, true, true),
(b02, 'emeka.nwosu@test.com', 'Emeka Nwosu', 'Chicago', 'IL', 'Investment banking analyst transitioning to tech. I have 4 years of M&A experience and can advise on breaking into finance, but I''m now exploring roles in tech strategy and business development.', true, true, true),
(b03, 'sophia.andersson@test.com', 'Sophia Andersson', 'Seattle', 'WA', 'Healthcare consultant pivoting to biotechnology. I''ve spent 6 years advising hospital systems and pharma companies, and I''m passionate about mentoring new consultants while I transition to a more technical biotech role.', true, true, true),
(b04, 'rafael.torres@test.com', 'Rafael Torres', 'Austin', 'TX', 'Marketing manager exploring product management. With 5 years in brand marketing and growth, I love helping marketers level up their careers while I learn the ins and outs of product development.', true, true, true),
(b05, 'amara.diallo@test.com', 'Amara Diallo', 'Atlanta', 'GA', 'Environmental engineer seeking to break into climate tech venture capital. I have 7 years of experience in sustainable infrastructure and enjoy mentoring engineers while exploring the VC landscape.', true, true, true),
(b06, 'nathan.bernstein@test.com', 'Nathan Bernstein', 'Boston', 'MA', 'Software engineer transitioning to management consulting. I''ve worked in tech for 6 years and can help with coding interviews and career growth, but I''m now pivoting to strategy consulting.', true, true, true),
(b07, 'yuna.park@test.com', 'Yuna Park', 'New York', 'NY', 'Private equity associate exploring opportunities in tech startups. I have 4 years in PE and love advising on finance careers, but I''m ready to join the startup world and build something new.', true, true, true),
(b08, 'isaiah.brown@test.com', 'Isaiah Brown', 'Detroit', 'MI', 'Mechanical engineer pivoting to renewable energy. With 5 years in automotive engineering, I mentor aspiring engineers while learning about the clean energy sector.', true, true, true),
(b09, 'luisa.fernandez@test.com', 'Luisa Fernandez', 'Miami', 'FL', 'Advertising creative director transitioning to entertainment. I''ve led campaigns for 6 years and can help with portfolio reviews and creative careers, but I''m now pursuing opportunities in film and TV production.', true, true, true),
(b10, 'arjun.mehta@test.com', 'Arjun Mehta', 'San Jose', 'CA', 'Data scientist exploring product management roles. I have 5 years of ML experience and enjoy mentoring in technical skills, but I''m now interested in leading product strategy.', true, true, true),
(b11, 'clare.sullivan@test.com', 'Clare Sullivan', 'Philadelphia', 'PA', 'Government policy analyst transitioning to nonprofit leadership. With 7 years in public policy, I advise on government careers while exploring executive roles in social impact organizations.', true, true, true),
(b12, 'dmitri.volkov@test.com', 'Dmitri Volkov', 'Denver', 'CO', 'Management consultant pivoting to real estate development. I have 6 years in strategy consulting and love helping consultants navigate their careers, but I''m now learning about real estate investing and development.', true, true, true),
(b13, 'blessing.okafor@test.com', 'Blessing Okafor', 'Houston', 'TX', 'Pharmaceutical sales rep exploring healthcare administration. With 4 years in pharma sales, I mentor on breaking into the industry while pursuing my interest in hospital operations and healthcare policy.', true, true, true),
(b14, 'marco.rossi@test.com', 'Marco Rossi', 'Portland', 'OR', 'UX designer transitioning to product management. I''ve designed digital products for 5 years and can help with portfolio reviews and design careers, but I want to own the full product vision.', true, true, true),
(b15, 'hana.kimura@test.com', 'Hana Kimura', 'Los Angeles', 'CA', 'Entertainment lawyer exploring venture capital. I have 6 years negotiating deals in media and entertainment, and I''m eager to mentor aspiring lawyers while I transition to investing in startups.', true, true, true),
(b16, 'malik.henderson@test.com', 'Malik Henderson', 'Charlotte', 'NC', 'Financial analyst pivoting to fintech product roles. With 5 years in corporate finance, I advise on breaking into finance while exploring product opportunities in financial technology.', true, true, true),
(b17, 'elif.yilmaz@test.com', 'Elif Yilmaz', 'Phoenix', 'AZ', 'Civil engineer transitioning to construction tech. I have 7 years of infrastructure experience and mentor engineers, but I''m now interested in building software for the construction industry.', true, true, true),
(b18, 'christian.wagner@test.com', 'Christian Wagner', 'Minneapolis', 'MN', 'Digital marketing specialist exploring consulting. With 4 years in performance marketing and analytics, I help marketers grow their careers while I pursue strategy consulting opportunities.', true, true, true),
(b19, 'zainab.osman@test.com', 'Zainab Osman', 'Dallas', 'TX', 'Biotech researcher transitioning to healthcare venture capital. I''ve worked in drug discovery for 6 years and love mentoring scientists, but I''m now exploring investment roles in life sciences.', true, true, true),
(b20, 'ryan.doyle@test.com', 'Ryan Doyle', 'Nashville', 'TN', 'Account executive pivoting to startup operations. With 5 years in enterprise sales, I mentor on sales careers and interview prep while learning about scaling early-stage companies.', true, true, true),
(b21, 'mia.johansson@test.com', 'Mia Johansson', 'San Diego', 'CA', 'Management consultant exploring product marketing. I have 6 years in healthcare consulting and enjoy advising consultants, but I''m now interested in bringing products to market in tech.', true, true, true),
(b22, 'tunde.bakare@test.com', 'Tunde Bakare', 'Baltimore', 'MD', 'Software engineer transitioning to developer relations. With 5 years of backend development experience, I mentor on technical interviews while exploring roles that blend engineering and community building.', true, true, true),
(b23, 'anastasia.smirnov@test.com', 'Anastasia Smirnov', 'Raleigh', 'NC', 'Investment banker exploring private equity. I have 4 years in M&A and advise on breaking into banking, but I''m now pursuing buy-side investment opportunities.', true, true, true),
(b24, 'julian.castillo@test.com', 'Julian Castillo', 'Sacramento', 'CA', 'Energy analyst pivoting to climate tech startups. With 6 years in the oil and gas sector, I mentor on energy careers while transitioning to renewable energy and sustainability roles.', true, true, true),
(b25, 'priyanka.chopradesai@test.com', 'Priyanka Chopra-Desai', 'Columbus', 'OH', 'HR business partner exploring organizational development consulting. I have 5 years in talent management and love advising on career development, but I''m now pursuing external consulting opportunities.', true, true, true),
(b26, 'owen.mcnamara@test.com', 'Owen McNamara', 'Tampa', 'FL', 'Real estate analyst transitioning to proptech. With 7 years in commercial real estate, I mentor on real estate careers while exploring technology solutions for the industry.', true, true, true),
(b27, 'esther.mensah@test.com', 'Esther Mensah', 'Indianapolis', 'IN', 'Public health program manager pivoting to health tech. I''ve worked in community health for 6 years and can advise on nonprofit and government careers, but I''m now interested in digital health innovation.', true, true, true),
(b28, 'stefan.mueller@test.com', 'Stefan Mueller', 'Salt Lake City', 'UT', 'Media strategist exploring entertainment production. With 4 years planning media campaigns, I help marketers and creatives while pursuing opportunities in content creation and production.', true, true, true),
(b29, 'nneka.igwe@test.com', 'Nneka Igwe', 'Richmond', 'VA', 'Corporate lawyer transitioning to startup legal counsel. I have 5 years at a law firm and mentor aspiring lawyers, but I''m eager to work in-house at a high-growth tech company.', true, true, true),
(b30, 'leonardo.bautista@test.com', 'Leonardo Bautista', 'Kansas City', 'MO', 'Operations manager exploring supply chain consulting. With 6 years optimizing logistics and operations, I advise on operations careers while pursuing consulting opportunities.', true, true, true)
ON CONFLICT DO NOTHING;

-- =============================================
-- EDUCATION
-- =============================================

-- Seeker education (s16-s65)
-- ============================================================
INSERT INTO public.education (user_id, school_name, degree_type, major, graduation_year, gpa, gpa_scale) VALUES
(s16, 'UC Berkeley', 'bs', 'Computer Science', 2026, 3.78, 4.0),
(s17, 'Columbia University', 'ba', 'Economics', 2026, 3.65, 4.0),
(s18, 'University of Texas at Austin', 'bba', 'Business Administration', 2026, 3.52, 4.0),
(s19, 'MIT', 'bs', 'Mathematics', 2026, 3.92, 4.0),
(s19, 'MIT', 'bs', 'Computer Science', 2026, 3.92, 4.0),
(s20, 'Spelman College', 'bs', 'Biology', 2026, 3.71, 4.0),
(s21, 'Northwestern University', 'bs', 'Finance', 2026, 3.68, 4.0),
(s22, 'University of Washington', 'beng', 'Computer Engineering', 2026, 3.55, 4.0),
(s23, 'Howard University', 'ba', 'Political Science', 2026, 3.73, 4.0),
(s24, 'Florida State University', 'ba', 'Marketing', 2027, 3.49, 4.0),
(s25, 'USC', 'ba', 'Film Studies', 2026, 3.61, 4.0),
(s25, 'USC', 'bs', 'Computer Science', 2026, 3.61, 4.0),
(s26, 'Duke University', 'bs', 'Biomedical Engineering', 2026, 3.82, 4.0),
(s27, 'University of Pennsylvania', 'bs', 'Economics', 2025, 3.88, 4.0),
(s28, 'Stanford University', 'bs', 'Computer Science', 2026, 3.91, 4.0),
(s29, 'Reed College', 'bs', 'Environmental Science', 2026, 3.57, 4.0),
(s30, 'University of Michigan', 'bs', 'Mechanical Engineering', 2026, 3.64, 4.0),
(s31, 'Harvard University', 'ba', 'Applied Mathematics', 2026, 3.85, 4.0),
(s32, 'Rice University', 'bs', 'Finance', 2026, 3.72, 4.0),
(s33, 'UC San Diego', 'bs', 'Cognitive Science', 2027, 3.59, 4.0),
(s34, 'Arizona State University', 'bs', 'Computer Science', 2026, 3.48, 4.0),
(s35, 'University of Washington', 'bba', 'Business Administration', 2026, 3.66, 4.0),
(s36, 'UC Berkeley', 'bs', 'Data Science', 2026, 3.74, 4.0),
(s37, 'University of Michigan', 'bs', 'Industrial Engineering', 2026, 3.62, 4.0),
(s38, 'NYU', 'bs', 'Finance', 2026, 3.79, 4.0),
(s38, 'NYU', 'bs', 'Computer Science', 2026, 3.79, 4.0),
(s39, 'UNC Chapel Hill', 'bs', 'Statistics', 2026, 3.69, 4.0),
(s40, 'Morehouse College', 'bba', 'Business Administration', 2026, 3.58, 4.0),
(s41, 'UCLA', 'ba', 'Economics', 2026, 3.67, 4.0),
(s42, 'Boston University', 'bs', 'Computer Science', 2027, 3.54, 4.0),
(s43, 'Vanderbilt University', 'ba', 'Marketing', 2026, 3.63, 4.0),
(s44, 'University of Minnesota', 'bs', 'Electrical Engineering', 2026, 3.56, 4.0),
(s45, 'Brown University', 'ba', 'Public Health', 2026, 3.76, 4.0),
(s46, 'University of Colorado', 'bs', 'Environmental Engineering', 2026, 3.51, 4.0),
(s47, 'University of Chicago', 'ba', 'Psychology', 2026, 3.81, 4.0),
(s48, 'Carnegie Mellon University', 'bs', 'Robotics Engineering', 2026, 3.87, 4.0),
(s49, 'University of Texas at Austin', 'ba', 'Communications', 2027, 3.46, 4.0),
(s50, 'UNC Chapel Hill', 'bs', 'Finance', 2026, 3.7, 4.0),
(s51, 'Georgia Tech', 'bs', 'Computer Science', 2026, 3.83, 4.0),
(s52, 'University of Wisconsin', 'bs', 'Biochemistry', 2026, 3.68, 4.0),
(s53, 'Ohio State University', 'bs', 'Information Systems', 2026, 3.53, 4.0),
(s54, 'University of Denver', 'ba', 'Journalism', 2026, 3.6, 4.0),
(s54, 'University of Denver', 'bba', 'Business', 2026, 3.6, 4.0),
(s55, 'Stanford University', 'bs', 'Electrical Engineering', 2025, 3.89, 4.0),
(s56, 'UC Irvine', 'bs', 'Business Analytics', 2027, 3.57, 4.0),
(s57, 'SMU', 'bba', 'Accounting', 2026, 3.65, 4.0),
(s57, 'SMU', 'bs', 'Finance', 2026, 3.65, 4.0),
(s58, 'Bowdoin College', 'bs', 'Marine Biology', 2026, 3.72, 4.0),
(s59, 'Tulane University', 'bs', 'Civil Engineering', 2026, 3.55, 4.0),
(s60, 'University of Utah', 'ba', 'Marketing', 2026, 3.5, 4.0),
(s61, 'UC Berkeley', 'bs', 'Physics', 2026, 3.86, 4.0),
(s61, 'UC Berkeley', 'bs', 'Computer Science', 2026, 3.86, 4.0),
(s62, 'NC State University', 'bs', 'Bioengineering', 2026, 3.64, 4.0),
(s63, 'Purdue University', 'bs', 'Supply Chain Management', 2026, 3.58, 4.0),
(s64, 'University of Virginia', 'ba', 'Economics', 2026, 3.75, 4.0),
(s65, 'University of Arizona', 'bs', 'Aerospace Engineering', 2026, 3.62, 4.0)
ON CONFLICT DO NOTHING;

-- ============================================================

-- Giver education (g16-g65)
INSERT INTO public.education (user_id, school_name, degree_type, major, graduation_year, gpa, gpa_scale) VALUES
(g16, 'Stanford University', 'bs', 'Computer Science', 2009, 3.78, 4.0),
(g16, 'Stanford University', 'mba', 'Business Administration', 2015, 3.82, 4.0),
(g17, 'University of Pennsylvania', 'bs', 'Economics', 2010, 3.71, 4.0),
(g17, 'Columbia University', 'mba', 'Finance', 2016, 3.85, 4.0),
(g18, 'Georgetown University', 'ba', 'International Relations', 2011, 3.66, 4.0),
(g18, 'MIT', 'ms', 'Engineering Management', 2017, 3.79, 4.0),
(g19, 'University of Washington', 'bs', 'Computer Engineering', 2008, 3.74, 4.0),
(g20, 'Harvard University', 'ba', 'Biology', 2005, 3.81, 4.0),
(g20, 'Harvard University', 'mph', 'Health Policy', 2011, 3.88, 4.0),
(g21, 'University of Chicago', 'bs', 'Economics', 2009, 3.83, 4.0),
(g21, 'Harvard Business School', 'mba', 'Business Administration', 2014, 3.91, 4.0),
(g22, 'Northwestern University', 'ba', 'Marketing', 2010, 3.68, 4.0),
(g23, 'MIT', 'bs', 'Electrical Engineering', 2007, 3.87, 4.0),
(g23, 'Stanford University', 'mba', 'Business Administration', 2013, 3.89, 4.0),
(g24, 'USC', 'ba', 'Cinema-Television', 2009, 3.62, 4.0),
(g25, 'Georgia Tech', 'bs', 'Mechanical Engineering', 2008, 3.76, 4.0),
(g25, 'Stanford University', 'ms', 'Mechanical Engineering', 2010, 3.84, 4.0),
(g26, 'Yale University', 'ba', 'Political Science', 2006, 3.79, 4.0),
(g26, 'Georgetown University', 'ma', 'Public Policy', 2012, 3.86, 4.0),
(g27, 'Duke University', 'ba', 'Economics', 2008, 3.72, 4.0),
(g27, 'University of Pennsylvania', 'jd', 'Law', 2011, 3.78, 4.0),
(g28, 'UC Berkeley', 'bs', 'Molecular Biology', 2007, 3.81, 4.0),
(g28, 'MIT', 'phd', 'Biological Engineering', 2014, 3.92, 4.0),
(g29, 'Boston University', 'bba', 'International Business', 2006, 3.64, 4.0),
(g30, 'University of Michigan', 'bs', 'Industrial Engineering', 2009, 3.73, 4.0),
(g31, 'Carnegie Mellon', 'bs', 'Information Systems', 2010, 3.77, 4.0),
(g32, 'Howard University', 'ba', 'Urban Studies', 2009, 3.69, 4.0),
(g32, 'Columbia University', 'ms', 'Real Estate Development', 2015, 3.75, 4.0),
(g33, 'University of Colorado', 'bs', 'Environmental Engineering', 2011, 3.71, 4.0),
(g34, 'Rhode Island School of Design', 'ba', 'Graphic Design', 2010, 3.58, 4.0),
(g35, 'UNC Chapel Hill', 'bs', 'Chemistry', 2008, 3.82, 4.0),
(g35, 'Johns Hopkins University', 'ms', 'Regulatory Science', 2014, 3.86, 4.0),
(g36, 'Wake Forest University', 'bs', 'Finance', 2011, 3.66, 4.0),
(g37, 'Emory University', 'ba', 'Psychology', 2009, 3.74, 4.0),
(g37, 'Cornell University', 'ma', 'Industrial & Labor Relations', 2015, 3.81, 4.0),
(g38, 'Northwestern University', 'bs', 'Economics', 2008, 3.79, 4.0),
(g38, 'University of Chicago', 'mba', 'Healthcare Management', 2013, 3.84, 4.0),
(g39, 'NYU', 'bs', 'Mathematics', 2010, 3.85, 4.0),
(g39, 'Columbia University', 'ms', 'Data Science', 2016, 3.88, 4.0),
(g40, 'Virginia Tech', 'bs', 'Aerospace Engineering', 2007, 3.68, 4.0),
(g41, 'UT Austin', 'ba', 'Advertising', 2009, 3.71, 4.0),
(g42, 'University of Wisconsin', 'bs', 'Business', 2008, 3.76, 4.0),
(g42, 'Northwestern Kellogg', 'mba', 'Strategy', 2014, 3.83, 4.0),
(g43, 'Spelman College', 'bs', 'Computer Science', 2010, 3.72, 4.0),
(g44, 'University of Michigan', 'bs', 'Biology', 2009, 3.64, 4.0),
(g45, 'Tufts University', 'bs', 'Environmental Engineering', 2010, 3.77, 4.0),
(g46, 'UC Berkeley', 'bs', 'Computer Science', 2009, 3.89, 4.0),
(g46, 'Stanford University', 'phd', 'Artificial Intelligence', 2016, 3.94, 4.0),
(g47, 'UNLV', 'bba', 'Hospitality Management', 2011, 3.59, 4.0),
(g48, 'Carnegie Mellon', 'bs', 'Computer Science', 2008, 3.84, 4.0),
(g48, 'MIT', 'ms', 'Cybersecurity', 2013, 3.87, 4.0),
(g49, 'Parsons School of Design', 'ba', 'Fashion Marketing', 2010, 3.61, 4.0),
(g50, 'Washington University', 'bs', 'Accounting', 2009, 3.73, 4.0),
(g51, 'Rice University', 'bs', 'Engineering', 2011, 3.78, 4.0),
(g52, 'University of Colorado', 'bs', 'Mechanical Engineering', 2009, 3.69, 4.0),
(g53, 'Morehouse College', 'ba', 'Public Health', 2010, 3.75, 4.0),
(g53, 'Johns Hopkins University', 'mph', 'Epidemiology', 2016, 3.83, 4.0),
(g54, 'Penn State', 'bs', 'Supply Chain Management', 2009, 3.68, 4.0),
(g55, 'Georgia Tech', 'bs', 'Aerospace Engineering', 2008, 3.81, 4.0),
(g56, 'Vanderbilt University', 'bs', 'Economics', 2012, 3.74, 4.0),
(g57, 'Georgetown University', 'ba', 'Government', 2010, 3.72, 4.0),
(g58, 'University of Nebraska', 'bs', 'Finance', 2011, 3.66, 4.0),
(g59, 'UCLA', 'ba', 'Film & Television', 2010, 3.63, 4.0),
(g60, 'UC Davis', 'bs', 'Agricultural Engineering', 2009, 3.71, 4.0),
(g60, 'Stanford University', 'ms', 'Environmental Systems', 2014, 3.79, 4.0),
(g61, 'UC Berkeley', 'bs', 'Electrical Engineering', 2007, 3.86, 4.0),
(g62, 'Howard University', 'ba', 'Sociology', 2011, 3.69, 4.0),
(g62, 'Harvard Kennedy School', 'mpa', 'Public Administration', 2017, 3.82, 4.0),
(g63, 'Ohio State University', 'bs', 'Business', 2010, 3.58, 4.0),
(g64, 'University of Washington', 'bs', 'Business Administration', 2010, 3.67, 4.0),
(g65, 'Yale University', 'ba', 'Environmental Studies', 2011, 3.76, 4.0),
(g65, 'MIT', 'ms', 'Environmental Policy', 2017, 3.84, 4.0)
ON CONFLICT DO NOTHING;

-- Both education (b01-b30)
INSERT INTO public.education (user_id, school_name, degree_type, major, graduation_year, gpa, gpa_scale) VALUES
(b01, 'University of California Berkeley', 'bs', 'Computer Science', 2018, 3.7, 4.0),
(b01, 'Stanford University', 'ms', 'Management Science and Engineering', 2020, 3.8, 4.0),
(b02, 'University of Pennsylvania', 'ba', 'Economics', 2019, 3.6, 4.0),
(b03, 'Duke University', 'bs', 'Biology', 2017, 3.8, 4.0),
(b03, 'Northwestern University', 'mba', 'Healthcare Management', 2021, 3.7, 4.0),
(b04, 'University of Texas at Austin', 'bba', 'Marketing', 2018, 3.5, 4.0),
(b05, 'Georgia Institute of Technology', 'beng', 'Environmental Engineering', 2016, 3.9, 4.0),
(b06, 'Massachusetts Institute of Technology', 'bs', 'Computer Science', 2017, 3.8, 4.0),
(b07, 'New York University', 'ba', 'Finance', 2019, 3.6, 4.0),
(b07, 'Columbia University', 'mba', 'Finance', 2022, 3.8, 4.0),
(b08, 'University of Michigan', 'beng', 'Mechanical Engineering', 2018, 3.7, 4.0),
(b09, 'University of Miami', 'ba', 'Advertising', 2017, 3.5, 4.0),
(b10, 'Carnegie Mellon University', 'bs', 'Statistics', 2018, 3.9, 4.0),
(b10, 'Stanford University', 'ms', 'Computer Science', 2020, 3.8, 4.0),
(b11, 'Georgetown University', 'ba', 'Political Science', 2016, 3.6, 4.0),
(b11, 'Harvard Kennedy School', 'ma', 'Public Policy', 2019, 3.7, 4.0),
(b12, 'University of Chicago', 'ba', 'Economics', 2017, 3.8, 4.0),
(b13, 'Howard University', 'bs', 'Biology', 2019, 3.4, 4.0),
(b14, 'Rhode Island School of Design', 'ba', 'Graphic Design', 2018, 3.6, 4.0),
(b15, 'University of Southern California', 'ba', 'Political Science', 2017, 3.7, 4.0),
(b15, 'UCLA School of Law', 'ma', 'Law', 2020, 3.6, 4.0),
(b16, 'University of North Carolina', 'bs', 'Business Administration', 2018, 3.5, 4.0),
(b17, 'Arizona State University', 'beng', 'Civil Engineering', 2016, 3.7, 4.0),
(b18, 'University of Wisconsin Madison', 'ba', 'Marketing', 2019, 3.4, 4.0),
(b19, 'Johns Hopkins University', 'bs', 'Molecular Biology', 2017, 3.9, 4.0),
(b19, 'University of California San Francisco', 'ms', 'Biomedical Sciences', 2020, 3.8, 4.0),
(b20, 'Vanderbilt University', 'ba', 'Communication Studies', 2018, 3.5, 4.0),
(b21, 'Boston University', 'ba', 'Economics', 2017, 3.7, 4.0),
(b21, 'INSEAD', 'mba', 'Business Administration', 2021, 3.6, 4.0),
(b22, 'University of Maryland', 'bs', 'Computer Science', 2018, 3.6, 4.0),
(b23, 'Emory University', 'ba', 'Finance', 2020, 3.8, 4.0),
(b24, 'University of California Davis', 'bs', 'Environmental Science', 2017, 3.5, 4.0),
(b25, 'Ohio State University', 'ba', 'Psychology', 2018, 3.7, 4.0),
(b25, 'Cornell University', 'ms', 'Industrial and Labor Relations', 2020, 3.6, 4.0),
(b26, 'University of Florida', 'bba', 'Real Estate', 2016, 3.4, 4.0),
(b27, 'Indiana University', 'bs', 'Public Health', 2017, 3.8, 4.0),
(b27, 'Emory University', 'ma', 'Public Health', 2020, 3.7, 4.0),
(b28, 'University of Utah', 'ba', 'Communications', 2020, 3.3, 4.0),
(b29, 'University of Virginia', 'ba', 'Political Science', 2018, 3.7, 4.0),
(b29, 'University of Virginia School of Law', 'ma', 'Law', 2021, 3.6, 4.0),
(b30, 'University of Missouri', 'bs', 'Industrial Engineering', 2017, 3.5, 4.0)
ON CONFLICT DO NOTHING;

-- =============================================
-- EXPERIENCES
-- =============================================

-- Seeker experiences (s16-s65)
-- ============================================================
INSERT INTO public.experiences (user_id, company_name, job_title, start_date, end_date, is_current, is_internship, description) VALUES
(s16, 'Google', 'Software Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Developed ML features for Google Maps using TensorFlow and contributed to routing optimization algorithms that improved ETA accuracy by 12%.'),
(s16, 'UC Berkeley AI Lab', 'Research Assistant', '2024-01-15', '2025-05-31', true, false, 'Conducting research on healthcare applications of computer vision under Professor Chen, focusing on medical imaging classification models.'),
(s17, 'JPMorgan Chase', 'Investment Banking Summer Analyst', '2024-06-01', '2024-08-31', false, true, 'Supported M&A transactions in Technology sector, built financial models, and prepared pitch materials for $2B+ deals.'),
(s18, 'Meta', 'Marketing Intern', '2024-06-01', '2024-08-31', false, true, 'Managed user acquisition campaigns for Instagram Reels, analyzed campaign performance data, and presented insights to senior leadership.'),
(s18, 'UT Austin McCombs', 'Student Consulting Project', '2024-09-01', '2024-12-15', false, false, 'Led team consulting project for Austin tech startup, developing go-to-market strategy that resulted in 3 new enterprise clients.'),
(s19, 'Citadel', 'Quantitative Research Intern', '2024-06-01', '2024-08-31', false, true, 'Developed statistical arbitrage trading strategies using Python and backtested on high-frequency market data achieving 2.1 Sharpe ratio.'),
(s20, 'Emory Healthcare', 'Clinical Research Intern', '2024-06-01', '2024-08-31', false, true, 'Assisted with oncology clinical trials, managed patient data, and contributed to research paper on immunotherapy outcomes.'),
(s20, 'Spelman Biology Dept', 'Teaching Assistant', '2024-08-15', '2025-05-31', true, false, 'Lead weekly lab sessions for Molecular Biology course, grade assignments, and hold office hours for 45 students.'),
(s21, 'Goldman Sachs', 'Investment Banking Summer Analyst', '2024-06-01', '2024-08-31', false, true, 'Worked in Natural Resources group covering renewable energy transactions, built DCF and LBO models for solar and wind projects.'),
(s22, 'Amazon Web Services', 'Cloud Support Intern', '2024-06-01', '2024-08-31', false, true, 'Provided technical support for enterprise AWS customers, resolved 200+ support tickets, and created internal documentation for EC2 troubleshooting.'),
(s22, 'UW Computer Lab', 'IT Support Specialist', '2024-09-01', '2025-05-31', true, false, 'Manage campus computer lab infrastructure, assist students with technical issues, and maintain network security protocols.'),
(s23, 'Deloitte', 'Government Consulting Intern', '2024-06-01', '2024-08-31', false, true, 'Supported federal agency transformation project, conducted stakeholder interviews, and developed policy recommendations for digital services.'),
(s24, 'Procter & Gamble', 'Brand Management Intern', '2024-06-01', '2024-08-31', false, true, 'Assisted with Tide brand marketing campaigns, analyzed consumer research data, and contributed to product launch strategy for new detergent line.'),
(s25, 'Netflix', 'Product Management Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on personalization team to improve content recommendation algorithms, conducted user research, and defined product requirements for new features.'),
(s26, 'Medtronic', 'Biomedical Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Supported design and testing of cardiac device prototypes, conducted failure analysis, and contributed to FDA submission documentation.'),
(s27, 'McKinsey & Company', 'Business Analyst Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on retail strategy case for Fortune 500 client, conducted market analysis, and presented recommendations to C-suite executives.'),
(s28, 'Stripe', 'Software Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Built payment fraud detection features using machine learning, improving fraud catch rate by 18% while reducing false positives.'),
(s28, 'Stanford AI Lab', 'Research Assistant', '2024-09-01', '2025-05-31', true, false, 'Researching reinforcement learning applications for robotics under Professor Williams, focusing on sim-to-real transfer learning.'),
(s29, 'Tesla Energy', 'Sustainability Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed solar panel installation data across 15 states, identified efficiency improvements, and contributed to renewable energy expansion strategy.'),
(s30, 'Ford Motor Company', 'Electric Vehicle Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on battery thermal management system for F-150 Lightning, conducted testing simulations, and optimized cooling algorithms.'),
(s31, 'Boston Consulting Group', 'Summer Associate Intern', '2024-06-01', '2024-08-31', false, true, 'Staffed on healthcare and financial services cases, built data models in Python, and presented strategic recommendations to clients.'),
(s32, 'Morgan Stanley', 'Investment Banking Summer Analyst', '2024-06-01', '2024-08-31', false, true, 'Covered oil and gas sector in Houston office, built merger models, and supported $4B energy infrastructure acquisition.'),
(s33, 'Spotify', 'UX Research Intern', '2024-06-01', '2024-08-31', false, true, 'Conducted user interviews and usability studies for podcast discovery features, synthesized insights that informed product roadmap.'),
(s34, 'Palo Alto Networks', 'Cybersecurity Intern', '2024-06-01', '2024-08-31', false, true, 'Developed security automation scripts for threat detection, analyzed network traffic patterns, and contributed to SOC playbook documentation.'),
(s35, 'Microsoft', 'Business Program Manager Intern', '2024-06-01', '2024-08-31', false, true, 'Supported Azure supply chain operations, optimized procurement processes, and presented efficiency recommendations to leadership.'),
(s36, 'Khan Academy', 'Data Analytics Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed student learning outcomes data, built dashboards in Tableau, and identified engagement patterns that informed content strategy.'),
(s37, 'Apple', 'Operations Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on iPhone supply chain operations team, analyzed manufacturing data, and contributed to yield improvement initiatives.'),
(s38, 'Coinbase', 'Software Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Built cryptocurrency trading features using React and Node.js, implemented real-time price update system handling 10K requests/second.'),
(s39, 'Pfizer', 'Biostatistics Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed clinical trial data for Phase III oncology drug, performed statistical modeling in R, and contributed to regulatory submission reports.'),
(s40, 'Andreessen Horowitz', 'Venture Capital Intern', '2024-06-01', '2024-08-31', false, true, 'Sourced early-stage fintech and consumer startups, conducted market research, and supported due diligence on 12 investment opportunities.'),
(s41, 'World Bank', 'Development Economics Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed microfinance programs in Latin America, built impact assessment models, and contributed to policy brief on financial inclusion.'),
(s42, 'Salesforce', 'Business Development Intern', '2024-06-01', '2024-08-31', false, true, 'Supported enterprise sales team, conducted prospect research, and contributed to deals totaling $8M in annual contract value.'),
(s43, 'Warner Music Group', 'Marketing Intern', '2024-06-01', '2024-08-31', false, true, 'Managed social media campaigns for emerging artists, analyzed streaming data, and coordinated with creative teams on release strategies.'),
(s44, 'Intel', 'Hardware Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on chip design verification team, wrote testbenches in SystemVerilog, and identified 15 critical bugs in pre-silicon validation.'),
(s45, 'Cleveland Clinic', 'Healthcare Administration Intern', '2024-06-01', '2024-08-31', false, true, 'Supported hospital operations team, analyzed patient flow data, and contributed to process improvement initiatives reducing wait times by 20%.'),
(s46, 'Rivian', 'Environmental Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Assessed environmental impact of battery manufacturing processes, conducted lifecycle analysis, and recommended sustainability improvements.'),
(s47, 'Google', 'People Analytics Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed employee survey data, built predictive retention models, and presented insights on improving workplace culture to HR leadership.'),
(s48, 'Boston Dynamics', 'Robotics Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Developed motion planning algorithms for quadruped robots, implemented path optimization in C++, and conducted hardware testing.'),
(s49, 'Adobe', 'Communications Intern', '2024-06-01', '2024-08-31', false, true, 'Managed internal communications for Creative Cloud product launches, wrote executive messaging, and coordinated cross-functional announcements.'),
(s50, 'Blackstone', 'Real Estate Private Equity Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed commercial real estate investment opportunities, built property valuation models, and supported $200M multifamily acquisition.'),
(s51, 'OpenAI', 'ML Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Fine-tuned large language models for specialized applications, optimized training pipelines, and contributed to model evaluation frameworks.'),
(s52, 'Moderna', 'Research Intern', '2024-06-01', '2024-08-31', false, true, 'Supported mRNA vaccine development research, conducted laboratory experiments, and analyzed protein expression data.'),
(s53, 'Deloitte', 'Technology Consulting Intern', '2024-06-01', '2024-08-31', false, true, 'Implemented Salesforce CRM for financial services client, conducted requirements gathering, and delivered user training sessions.'),
(s54, 'BuzzFeed', 'Content Strategy Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed content performance metrics, identified trending topics, and contributed to editorial strategy for viral content creation.'),
(s55, 'Tesla', 'Power Electronics Intern', '2024-06-01', '2024-08-31', false, true, 'Designed inverter circuits for Powerwall energy storage systems, conducted simulations in SPICE, and validated prototype performance.'),
(s56, 'Uber', 'Product Analytics Intern', '2024-06-01', '2024-08-31', false, true, 'Analyzed rider behavior data using SQL and Python, built experimentation frameworks, and informed product decisions through A/B test insights.'),
(s57, 'ExxonMobil', 'Corporate Finance Intern', '2024-06-01', '2024-08-31', false, true, 'Supported FP&A team with quarterly forecasting, built financial models for capital projects, and presented variance analysis to executives.'),
(s58, 'Ocean Conservancy', 'Marine Policy Intern', '2024-06-01', '2024-08-31', false, true, 'Researched ocean plastic pollution policies, conducted stakeholder analysis, and contributed to advocacy campaign for marine protection legislation.'),
(s59, 'AECOM', 'Civil Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Supported urban infrastructure projects including highway design, performed traffic flow simulations, and contributed to proposal development.'),
(s60, 'Airbnb', 'Growth Marketing Intern', '2024-06-01', '2024-08-31', false, true, 'Managed paid acquisition campaigns across Google and Meta platforms, optimized for CAC reduction, and achieved 25% improvement in conversion rates.'),
(s61, 'IBM Quantum', 'Quantum Research Intern', '2024-06-01', '2024-08-31', false, true, 'Developed quantum algorithms for optimization problems, implemented circuits on quantum hardware, and analyzed performance vs classical methods.'),
(s62, 'Johnson & Johnson', 'Regulatory Affairs Intern', '2024-06-01', '2024-08-31', false, true, 'Supported FDA 510(k) submissions for medical devices, compiled technical documentation, and coordinated with cross-functional teams.'),
(s63, 'Amazon Logistics', 'Supply Chain Intern', '2024-06-01', '2024-08-31', false, true, 'Optimized warehouse picking routes using data analysis, implemented process improvements reducing fulfillment time by 15%.'),
(s64, 'United Nations', 'International Development Intern', '2024-06-01', '2024-08-31', false, true, 'Conducted research on sustainable development goals in Sub-Saharan Africa, analyzed program data, and contributed to impact reports.'),
(s65, 'SpaceX', 'Aerospace Engineering Intern', '2024-06-01', '2024-08-31', false, true, 'Worked on Starship propulsion systems team, conducted structural analysis simulations, and contributed to engine testing protocols.'),
(s65, 'University of Arizona', 'Research Assistant', '2024-09-01', '2025-05-31', true, false, 'Conducting research on satellite orbital mechanics under Professor Martinez, analyzing trajectory optimization for CubeSat missions.')
ON CONFLICT DO NOTHING;

-- ============================================================

-- Giver experiences (g16-g65)
INSERT INTO public.experiences (user_id, company_name, job_title, start_date, end_date, is_current, is_internship, description) VALUES
(g16, 'Meta', 'Associate Product Manager', '2009-07-01', '2013-04-30', false, false, 'Launched new features for Facebook Messenger reaching 500M users. Led cross-functional teams of engineers and designers.'),
(g16, 'Airbnb', 'Senior Product Manager', '2013-05-01', '2019-08-31', false, false, 'Drove growth strategy for host onboarding and retention. Shipped trust and safety features improving platform quality.'),
(g16, 'Stripe', 'Product Lead', '2019-09-01', NULL, true, false, 'Leading payments infrastructure product team. Managing $50M+ product portfolio serving enterprise customers.'),
(g17, 'Goldman Sachs', 'Investment Banking Analyst', '2010-08-01', '2014-07-31', false, false, 'Executed M&A transactions and capital raises totaling $8B across healthcare and technology sectors.'),
(g17, 'J.P. Morgan', 'Vice President, Healthcare Investment Banking', '2016-09-01', NULL, true, false, 'Leading M&A advisory for mid-cap healthcare companies. Closed 12 transactions totaling $3.5B in deal value.'),
(g18, 'McKinsey & Company', 'Business Analyst', '2011-09-01', '2015-06-30', false, false, 'Advised Fortune 500 energy clients on operational improvement and digital transformation initiatives.'),
(g18, 'Deloitte', 'Manager, Strategy & Operations', '2017-08-01', NULL, true, false, 'Leading sustainability strategy projects for oil & gas and utilities clients. Managing teams of 4-6 consultants.'),
(g19, 'Amazon', 'Software Development Engineer', '2008-09-01', '2013-03-31', false, false, 'Built distributed systems for AWS EC2 infrastructure. Designed high-availability services processing millions of requests daily.'),
(g19, 'Microsoft', 'Senior Software Engineer', '2013-04-01', '2018-11-30', false, false, 'Led Azure platform engineering initiatives. Mentored junior engineers and drove architecture decisions.'),
(g19, 'Snowflake', 'Engineering Manager', '2018-12-01', NULL, true, false, 'Managing team of 8 engineers building data warehouse features. Shipped capabilities supporting enterprise customers.'),
(g20, 'Massachusetts General Hospital', 'Administrative Fellow', '2011-08-01', '2013-07-31', false, false, 'Supported hospital operations and strategic planning initiatives. Led quality improvement projects.'),
(g20, 'Partners HealthCare', 'Director of Operations', '2013-08-01', '2019-05-31', false, false, 'Managed multi-site ambulatory care operations with $120M budget. Improved patient satisfaction scores by 18%.'),
(g20, 'Brigham and Women''s Hospital', 'VP of Strategy & Operations', '2019-06-01', NULL, true, false, 'Leading strategic planning and business development for academic medical center. Overseeing new service line expansion.'),
(g21, 'Bain & Company', 'Associate Consultant', '2009-09-01', '2012-07-31', false, false, 'Conducted due diligence and operational assessments for private equity clients. Analyzed investment opportunities across industries.'),
(g21, 'KKR', 'Associate', '2014-09-01', '2018-12-31', false, false, 'Sourced and executed middle-market buyouts in industrial and business services sectors. Managed portfolio company value creation.'),
(g21, 'Advent International', 'Principal', '2019-01-01', NULL, true, false, 'Leading investments in manufacturing and distribution companies. Managing $800M portfolio across 5 platform investments.'),
(g22, 'Procter & Gamble', 'Brand Manager', '2010-08-01', '2015-06-30', false, false, 'Led marketing strategy for $200M+ consumer products brand. Launched digital campaigns driving 25% e-commerce growth.'),
(g22, 'Unilever', 'Marketing Director', '2015-07-01', NULL, true, false, 'Leading brand portfolio strategy for personal care division. Driving digital transformation and DTC initiatives.'),
(g23, 'Google Ventures', 'Investment Associate', '2013-09-01', '2017-11-30', false, false, 'Sourced and diligenced enterprise software investments. Supported portfolio companies with product and GTM strategy.'),
(g23, 'Sequoia Capital', 'Partner', '2017-12-01', NULL, true, false, 'Leading early-stage investments in AI and infrastructure software. Managing $450M portfolio across 18 companies.'),
(g24, 'Warner Bros', 'Production Coordinator', '2009-09-01', '2013-08-31', false, false, 'Coordinated film production logistics and schedules. Managed budgets and vendor relationships for major releases.'),
(g24, 'Netflix', 'Director of Content Strategy', '2013-09-01', '2019-04-30', false, false, 'Developed content acquisition and original programming strategy. Launched 15+ original series across genres.'),
(g24, 'Paramount Pictures', 'VP of Production', '2019-05-01', NULL, true, false, 'Overseeing theatrical and streaming film slate. Managing relationships with producers and talent.'),
(g25, 'Tesla', 'Powertrain Engineer', '2010-08-01', '2015-12-31', false, false, 'Designed electric motor and battery systems for Model S and Model X. Improved efficiency and performance metrics.'),
(g25, 'GM Cruise', 'Senior Engineering Manager', '2016-01-01', NULL, true, false, 'Leading autonomous vehicle sensor fusion and controls team. Managing engineering roadmap for self-driving technology.'),
(g26, 'U.S. Department of Education', 'Policy Analyst', '2012-09-01', '2017-01-31', false, false, 'Analyzed federal education policy and funding programs. Supported legislative and regulatory initiatives.'),
(g26, 'Congressional Black Caucus Foundation', 'Senior Policy Advisor', '2017-02-01', NULL, true, false, 'Advising on education equity and civil rights policy. Leading advocacy campaigns and stakeholder engagement.'),
(g27, 'Skadden Arps', 'Associate Attorney', '2011-09-01', '2018-08-31', false, false, 'Advised public companies on securities offerings, M&A, and corporate governance matters. Drafted registration statements and proxy materials.'),
(g27, 'Comcast', 'Senior Corporate Counsel', '2018-09-01', NULL, true, false, 'Managing securities compliance and corporate governance for Fortune 50 company. Supporting Board of Directors.'),
(g28, 'Genentech', 'Research Scientist', '2014-09-01', '2019-06-30', false, false, 'Led oncology drug discovery programs. Published research on novel therapeutic targets in top-tier journals.'),
(g28, 'Bristol Myers Squibb', 'Associate Director, R&D', '2019-07-01', NULL, true, false, 'Leading immunotherapy development programs. Managing cross-functional teams advancing candidates through clinical trials.'),
(g29, 'Coca-Cola', 'International Business Manager', '2006-09-01', '2012-05-31', false, false, 'Drove market expansion across Latin America. Launched distribution partnerships in 8 new markets.'),
(g29, 'Unilever', 'Regional Director, EMEA', '2012-06-01', '2018-03-31', false, false, 'Led European business unit with €500M revenue. Managed commercial teams across 15 countries.'),
(g29, 'PepsiCo', 'VP of International Development', '2018-04-01', NULL, true, false, 'Overseeing global expansion strategy for snacks division. Leading market entry and M&A initiatives.'),
(g30, 'Ford Motor Company', 'Manufacturing Engineer', '2009-09-01', '2014-12-31', false, false, 'Optimized assembly line operations and quality processes. Implemented lean manufacturing reducing costs by 15%.'),
(g30, 'General Electric', 'Operations Director', '2015-01-01', NULL, true, false, 'Managing multi-plant operations for industrial equipment division. Leading $300M manufacturing network transformation.'),
(g31, 'Accenture', 'Technology Consultant', '2010-09-01', '2016-06-30', false, false, 'Led cloud migration and digital transformation projects for Fortune 500 clients. Managed technical delivery teams.'),
(g31, 'KPMG', 'Senior Manager, Technology Advisory', '2016-07-01', NULL, true, false, 'Leading enterprise architecture and cloud strategy engagements. Managing consulting teams across multiple client accounts.'),
(g32, 'Related Companies', 'Development Associate', '2009-09-01', '2013-11-30', false, false, 'Supported mixed-use development projects totaling $400M. Conducted market research and financial analysis.'),
(g32, 'Brookfield Properties', 'Development Director', '2015-10-01', NULL, true, false, 'Leading affordable housing and mixed-use developments. Managing $200M project pipeline across Southwest region.'),
(g33, 'National Renewable Energy Laboratory', 'Research Analyst', '2011-09-01', '2016-08-31', false, false, 'Conducted renewable energy market analysis and policy research. Published reports on solar and wind economics.'),
(g33, 'NextEra Energy', 'Senior Strategy Analyst', '2016-09-01', NULL, true, false, 'Analyzing renewable energy investment opportunities and regulatory trends. Supporting $2B annual capital deployment.'),
(g34, 'Adobe', 'Product Designer', '2010-09-01', '2015-12-31', false, false, 'Designed user interfaces for Creative Cloud applications. Led design systems work across product portfolio.'),
(g34, 'Figma', 'Senior Product Designer', '2016-01-01', NULL, true, false, 'Leading design for collaboration features. Conducting user research and defining product vision.'),
(g35, 'Pfizer', 'Regulatory Affairs Associate', '2014-10-01', '2019-05-31', false, false, 'Managed FDA submissions for new drug applications. Coordinated regulatory strategy across development teams.'),
(g35, 'Johnson & Johnson', 'Director, Regulatory Affairs', '2019-06-01', NULL, true, false, 'Leading global regulatory strategy for pharmaceutical division. Managing team supporting 20+ development programs.'),
(g36, 'Bank of America', 'Commercial Banking Associate', '2011-09-01', '2016-03-31', false, false, 'Managed lending relationships with middle-market companies. Structured credit facilities up to $100M.'),
(g36, 'Wells Fargo', 'Relationship Manager', '2016-04-01', NULL, true, false, 'Managing portfolio of 25 corporate clients with $800M in deposits and credit. Leading cross-sell of treasury services.'),
(g37, 'IBM', 'HR Business Partner', '2015-09-01', '2020-02-29', false, false, 'Partnered with technology division on talent strategy and organizational design. Led performance management transformation.'),
(g37, 'Salesforce', 'VP of People Operations', '2020-03-01', NULL, true, false, 'Leading talent development and culture initiatives. Overseeing learning programs and diversity strategy.'),
(g38, 'Boston Consulting Group', 'Associate', '2008-09-01', '2011-07-31', false, false, 'Advised healthcare providers and payers on strategy and operations. Conducted market analysis and operational assessments.'),
(g38, 'Optum', 'Senior Manager, Strategy', '2013-09-01', NULL, true, false, 'Leading healthcare delivery transformation projects. Advising health systems on value-based care models.'),
(g39, 'Citigroup', 'Quantitative Analyst', '2010-09-01', '2014-12-31', false, false, 'Built risk models and trading algorithms for fixed income desk. Analyzed market data to identify investment opportunities.'),
(g39, 'Capital One', 'Manager, Data Science', '2016-10-01', NULL, true, false, 'Leading analytics team building credit risk and fraud detection models. Deploying machine learning in production.'),
(g40, 'Lockheed Martin', 'Systems Engineer', '2007-09-01', '2013-06-30', false, false, 'Designed avionics systems for military aircraft programs. Led integration testing and requirements analysis.'),
(g40, 'Raytheon Technologies', 'Program Manager', '2013-07-01', NULL, true, false, 'Managing $150M defense contract portfolio. Leading cross-functional teams delivering aerospace systems.'),
(g41, 'Target', 'Marketing Analyst', '2009-09-01', '2014-04-30', false, false, 'Analyzed customer data to optimize marketing campaigns. Built measurement frameworks tracking ROAS and customer lifetime value.'),
(g41, 'Walmart', 'Director of Marketing Analytics', '2014-05-01', NULL, true, false, 'Leading analytics organization supporting $5B+ marketing spend. Driving insights for media optimization and personalization.'),
(g42, 'Abbott Laboratories', 'Corporate Strategy Analyst', '2008-09-01', '2012-07-31', false, false, 'Supported M&A due diligence and strategic planning. Analyzed market opportunities in medical devices and diagnostics.'),
(g42, 'Cardinal Health', 'Director of Corporate Development', '2014-09-01', NULL, true, false, 'Leading M&A and strategic partnerships. Closed 6 acquisitions totaling $800M over past 3 years.'),
(g43, 'Deloitte Digital', 'Technology Consultant', '2010-09-01', '2016-05-31', false, false, 'Led agile software delivery projects for clients across industries. Managed development teams and stakeholder relationships.'),
(g43, 'Kaiser Permanente', 'Senior Project Manager', '2016-06-01', NULL, true, false, 'Managing digital health technology implementations. Leading enterprise-wide platform modernization initiative.'),
(g44, 'Merck', 'Sales Representative', '2009-09-01', '2014-11-30', false, false, 'Built relationships with physicians and healthcare providers. Consistently exceeded sales targets by 15%+.'),
(g44, 'AbbVie', 'Regional Sales Director', '2014-12-01', NULL, true, false, 'Leading sales team of 25 representatives across Southeast region. Managing $200M territory for immunology products.'),
(g45, 'CH2M Hill', 'Environmental Engineer', '2010-09-01', '2016-03-31', false, false, 'Designed environmental remediation and sustainability projects. Managed air quality and water treatment systems.'),
(g45, 'Cummins', 'Senior Environmental Engineer', '2016-04-01', NULL, true, false, 'Leading corporate sustainability initiatives reducing carbon emissions. Managing environmental compliance programs.'),
(g46, 'Apple', 'Machine Learning Engineer', '2016-09-01', '2020-08-31', false, false, 'Built computer vision and NLP models for iOS features. Optimized models for on-device inference.'),
(g46, 'OpenAI', 'AI Research Scientist', '2020-09-01', NULL, true, false, 'Conducting research on large language models and reinforcement learning. Publishing work advancing state-of-the-art AI.'),
(g47, 'MGM Resorts', 'Operations Manager', '2011-09-01', '2017-04-30', false, false, 'Managed venue operations for convention and entertainment facilities. Oversaw teams of 50+ event staff.'),
(g47, 'Caesars Entertainment', 'VP of Operations', '2017-05-01', NULL, true, false, 'Leading hospitality operations across 3 Las Vegas properties. Managing $80M operational budget and 400 employees.'),
(g48, 'Booz Allen Hamilton', 'Cybersecurity Consultant', '2013-10-01', '2018-12-31', false, false, 'Assessed security posture for government and financial services clients. Designed security architectures and incident response plans.'),
(g48, 'JPMorgan Chase', 'Director of Cybersecurity', '2019-01-01', NULL, true, false, 'Leading security operations protecting critical financial systems. Managing team of 40 security engineers and analysts.'),
(g49, 'Ralph Lauren', 'Merchandising Analyst', '2010-09-01', '2015-06-30', false, false, 'Analyzed sales trends and inventory data to optimize product assortments. Supported buying decisions across categories.'),
(g49, 'Macy''s', 'Director of E-commerce Merchandising', '2015-07-01', NULL, true, false, 'Leading digital merchandising strategy for fashion categories. Driving online sales growth and margin improvement.'),
(g50, 'Express Scripts', 'Financial Analyst', '2009-09-01', '2014-12-31', false, false, 'Built financial models and conducted variance analysis. Supported budgeting and forecasting processes.'),
(g50, 'Medtronic', 'Director of FP&A', '2015-01-01', NULL, true, false, 'Leading financial planning for $3B cardiovascular division. Partnering with business leaders on strategic decisions.'),
(g51, 'EY', 'Technology Consultant', '2011-09-01', '2017-05-31', false, false, 'Led digital transformation and IT strategy projects. Advised clients on technology roadmaps and operating models.'),
(g51, 'PwC', 'Manager, Digital Operations', '2017-06-01', NULL, true, false, 'Managing consulting engagements focused on automation and cloud transformation. Leading teams of 6-8 consultants.'),
(g52, 'SunPower', 'Project Engineer', '2009-09-01', '2015-03-31', false, false, 'Designed utility-scale solar installations. Managed engineering and construction for 50MW+ projects.'),
(g52, 'First Solar', 'Senior Project Developer', '2015-04-01', NULL, true, false, 'Leading development of renewable energy projects across Western U.S. Managing $500M project pipeline.'),
(g53, 'CDC', 'Public Health Analyst', '2016-10-01', '2021-06-30', false, false, 'Analyzed epidemiological data and supported disease prevention programs. Led community health initiatives.'),
(g53, 'Florida Department of Health', 'Program Director', '2021-07-01', NULL, true, false, 'Managing statewide maternal and child health programs. Overseeing $25M budget and partnerships with community organizations.'),
(g54, 'Nestle', 'Supply Chain Analyst', '2009-09-01', '2014-08-31', false, false, 'Optimized distribution network and inventory planning. Reduced logistics costs by 12% through process improvements.'),
(g54, 'Mondelez International', 'Supply Chain Director', '2014-09-01', NULL, true, false, 'Leading end-to-end supply chain for snacks category. Managing procurement, manufacturing, and distribution operations.'),
(g55, 'Boeing', 'Aerospace Engineer', '2008-09-01', '2014-12-31', false, false, 'Designed structural systems for commercial aircraft. Conducted stress analysis and certification testing.'),
(g55, 'Northrop Grumman', 'Engineering Manager', '2015-01-01', NULL, true, false, 'Managing engineering team developing next-generation fighter aircraft systems. Leading technical roadmap and deliverables.'),
(g56, 'Fidelity Investments', 'Equity Research Analyst', '2012-09-01', '2018-04-30', false, false, 'Covered energy and industrial companies. Published research and stock recommendations for portfolio managers.'),
(g56, 'BlackRock', 'Investment Analyst', '2018-05-01', NULL, true, false, 'Analyzing energy sector investments for $8B equity fund. Conducting company due diligence and valuation modeling.'),
(g57, 'Chamber of Commerce', 'Policy Associate', '2010-09-01', '2015-11-30', false, false, 'Tracked federal legislation and regulatory developments. Coordinated advocacy campaigns on business issues.'),
(g57, 'Raytheon Technologies', 'Director of Government Relations', '2015-12-01', NULL, true, false, 'Managing federal and state government affairs. Leading advocacy on defense and aerospace policy priorities.'),
(g58, 'State Farm', 'Underwriter', '2011-09-01', '2017-02-28', false, false, 'Evaluated commercial insurance risks and set pricing. Analyzed loss data and market trends.'),
(g58, 'Berkshire Hathaway', 'Underwriting Director', '2017-03-01', NULL, true, false, 'Leading commercial underwriting organization. Managing $400M premium book across multiple product lines.'),
(g59, 'Vice Media', 'Production Coordinator', '2010-09-01', '2015-06-30', false, false, 'Coordinated documentary production logistics and schedules. Managed budgets and vendor relationships.'),
(g59, 'HBO', 'Executive Producer', '2015-07-01', NULL, true, false, 'Developing and producing documentary series and films. Overseeing creative direction and production operations.'),
(g60, 'John Deere', 'Agricultural Engineer', '2009-09-01', '2012-05-31', false, false, 'Designed precision agriculture equipment and technologies. Developed sensor systems for farm machinery.'),
(g60, 'The Climate Corporation', 'Product Manager', '2014-10-01', NULL, true, false, 'Leading agricultural analytics platform development. Partnering with farmers to deliver data-driven insights.'),
(g61, 'Intel', 'Process Engineer', '2007-09-01', '2013-12-31', false, false, 'Developed semiconductor manufacturing processes for advanced nodes. Improved chip yields and production efficiency.'),
(g61, 'NVIDIA', 'Senior Design Engineer', '2014-01-01', NULL, true, false, 'Designing GPU architectures for AI and gaming applications. Leading technical teams developing next-generation chips.'),
(g62, 'Urban Institute', 'Research Analyst', '2017-10-01', '2021-03-31', false, false, 'Conducted policy research on education and social programs. Analyzed data and published findings in policy briefs.'),
(g62, 'Bill & Melinda Gates Foundation', 'Program Officer', '2021-04-01', NULL, true, false, 'Managing grantmaking for education equity initiatives. Supporting nonprofit partners with strategy and evaluation.'),
(g63, 'CBRE', 'Real Estate Broker', '2010-09-01', '2017-06-30', false, false, 'Represented tenants and landlords in office and industrial leasing. Closed transactions totaling 2M+ square feet.'),
(g63, 'JLL', 'Senior Vice President', '2017-07-01', NULL, true, false, 'Leading commercial real estate brokerage team. Managing client relationships and $500M+ transaction pipeline.'),
(g64, 'Oracle', 'Sales Representative', '2010-09-01', '2016-04-30', false, false, 'Sold enterprise software to Fortune 500 accounts. Consistently achieved 120%+ of quota.'),
(g64, 'Workday', 'Sales Director', '2016-05-01', NULL, true, false, 'Leading sales team selling HCM and finance cloud software. Managing $40M territory and developing team of 8 reps.'),
(g65, 'Environmental Defense Fund', 'Policy Analyst', '2017-10-01', '2022-01-31', false, false, 'Analyzed climate policy and conservation strategies. Supported advocacy campaigns on clean energy and land use.'),
(g65, 'U.S. Forest Service', 'Environmental Policy Director', '2022-02-01', NULL, true, false, 'Leading climate adaptation and forest conservation programs. Managing stakeholder engagement and policy development.')
ON CONFLICT DO NOTHING;

-- Both experiences (b01-b30)
INSERT INTO public.experiences (user_id, company_name, job_title, start_date, end_date, is_current, is_internship, description) VALUES
(b01, 'Google', 'Associate Product Manager', '2018-07-01', '2021-03-01', false, false, 'Led product development for Google Maps features, collaborating with engineering and design teams to ship features used by millions of users daily.'),
(b01, 'Meta', 'Product Manager', '2021-04-01', NULL, true, false, 'Managing marketplace product initiatives, defining roadmaps, and working cross-functionally to drive user growth and engagement.'),
(b02, 'Goldman Sachs', 'Investment Banking Analyst', '2019-07-01', '2022-08-01', false, false, 'Executed M&A transactions in the technology sector, conducted financial modeling, prepared pitch materials, and supported deal negotiations.'),
(b02, 'Stripe', 'Corporate Development Associate', '2022-09-01', NULL, true, false, 'Leading strategic partnerships and evaluating acquisition targets to support company growth initiatives in fintech.'),
(b03, 'McKinsey & Company', 'Business Analyst', '2017-09-01', '2019-06-01', false, false, 'Advised pharmaceutical and healthcare clients on operational improvement, market entry strategies, and organizational transformation.'),
(b03, 'Deloitte Consulting', 'Senior Consultant', '2021-08-01', NULL, true, false, 'Leading healthcare consulting engagements focused on hospital systems optimization, value-based care, and digital health strategy.'),
(b04, 'Nike', 'Marketing Coordinator', '2018-06-01', '2020-11-01', false, false, 'Managed digital marketing campaigns, analyzed consumer insights, and coordinated product launches across multiple channels.'),
(b04, 'Airbnb', 'Marketing Manager', '2020-12-01', NULL, true, false, 'Leading growth marketing initiatives for Experiences product line, developing go-to-market strategies and optimizing conversion funnels.'),
(b05, 'AECOM', 'Environmental Engineer', '2016-08-01', '2020-05-01', false, false, 'Designed sustainable infrastructure projects, conducted environmental impact assessments, and managed client relationships for transportation and water projects.'),
(b05, 'Tesla', 'Senior Environmental Engineer', '2020-06-01', NULL, true, false, 'Leading environmental compliance and sustainability initiatives for Gigafactory operations, focusing on renewable energy integration and waste reduction.'),
(b06, 'Amazon', 'Software Development Engineer', '2017-08-01', '2021-01-01', false, false, 'Built scalable backend services for AWS, designed APIs, and improved system reliability through infrastructure automation.'),
(b06, 'Spotify', 'Senior Software Engineer', '2021-02-01', NULL, true, false, 'Developing personalization algorithms and leading technical architecture for recommendation systems serving millions of users.'),
(b07, 'Blackstone', 'Private Equity Analyst', '2019-08-01', '2022-07-01', false, false, 'Evaluated investment opportunities in consumer and retail sectors, performed due diligence, and supported portfolio company operations.'),
(b07, 'KKR', 'Private Equity Associate', '2022-08-01', NULL, true, false, 'Managing investments in technology and healthcare sectors, leading deal sourcing, and working with portfolio companies on value creation.'),
(b08, 'Ford Motor Company', 'Mechanical Engineer', '2018-06-01', '2021-09-01', false, false, 'Designed powertrain components, conducted testing and validation, and collaborated with manufacturing teams to optimize production.'),
(b08, 'General Motors', 'Senior Mechanical Engineer', '2021-10-01', NULL, true, false, 'Leading electric vehicle battery system design and development, managing cross-functional engineering teams.'),
(b09, 'Ogilvy', 'Junior Art Director', '2017-08-01', '2020-02-01', false, false, 'Created advertising campaigns for consumer brands, developed creative concepts, and presented to clients.'),
(b09, 'Wieden+Kennedy', 'Creative Director', '2020-03-01', NULL, true, false, 'Leading creative teams on major brand campaigns, overseeing concept development through production, and managing client relationships.'),
(b10, 'Facebook', 'Data Scientist', '2018-09-01', '2021-06-01', false, false, 'Built machine learning models for ads ranking, conducted A/B testing, and provided insights to inform product decisions.'),
(b10, 'Uber', 'Senior Data Scientist', '2021-07-01', NULL, true, false, 'Leading ML initiatives for pricing optimization and demand forecasting, mentoring junior data scientists, and partnering with product teams.'),
(b11, 'U.S. Department of State', 'Policy Analyst', '2016-09-01', '2019-12-01', false, false, 'Analyzed international development policies, prepared briefing materials for senior leadership, and coordinated with foreign governments.'),
(b11, 'Environmental Protection Agency', 'Senior Policy Analyst', '2020-01-01', NULL, true, false, 'Leading climate policy initiatives, developing regulatory frameworks, and managing stakeholder engagement across federal and state agencies.'),
(b12, 'Boston Consulting Group', 'Associate Consultant', '2017-09-01', '2020-08-01', false, false, 'Led strategic projects for Fortune 500 clients across industries, conducting market research, financial analysis, and operational diagnostics.'),
(b12, 'Bain & Company', 'Senior Associate', '2020-09-01', NULL, true, false, 'Managing client engagements in retail and real estate sectors, leading case teams, and developing growth strategies for private equity clients.'),
(b13, 'Pfizer', 'Pharmaceutical Sales Representative', '2019-08-01', '2021-11-01', false, false, 'Built relationships with healthcare providers, achieved sales targets for cardiovascular medications, and conducted product training.'),
(b13, 'Johnson & Johnson', 'Senior Sales Representative', '2021-12-01', NULL, true, false, 'Managing key accounts for medical devices division, developing territory strategies, and mentoring new sales representatives.'),
(b14, 'Adobe', 'UX Designer', '2018-07-01', '2021-04-01', false, false, 'Designed user interfaces for Creative Cloud products, conducted user research, and collaborated with product managers and engineers.'),
(b14, 'Shopify', 'Senior UX Designer', '2021-05-01', NULL, true, false, 'Leading design for merchant-facing features, establishing design systems, and mentoring junior designers across product teams.'),
(b15, 'CAA', 'Entertainment Associate', '2017-09-01', '2020-07-01', false, false, 'Negotiated talent contracts, supported client development, and analyzed deal structures for film and television projects.'),
(b15, 'Warner Bros', 'Entertainment Lawyer', '2020-08-01', NULL, true, false, 'Managing legal affairs for film production, negotiating distribution agreements, and advising on intellectual property matters.'),
(b16, 'Bank of America', 'Financial Analyst', '2018-07-01', '2021-03-01', false, false, 'Performed financial modeling and analysis for corporate clients, supported M&A advisory, and prepared investment committee materials.'),
(b16, 'JPMorgan Chase', 'Senior Financial Analyst', '2021-04-01', NULL, true, false, 'Leading financial planning and analysis for retail banking division, developing forecasting models, and supporting strategic initiatives.'),
(b17, 'Bechtel', 'Civil Engineer', '2016-08-01', '2020-01-01', false, false, 'Designed transportation infrastructure projects, managed construction oversight, and coordinated with contractors and stakeholders.'),
(b17, 'Turner Construction', 'Senior Civil Engineer', '2020-02-01', NULL, true, false, 'Managing commercial building projects, leading structural design teams, and ensuring compliance with safety and quality standards.'),
(b18, 'HubSpot', 'Digital Marketing Specialist', '2019-08-01', '2022-02-01', false, false, 'Executed digital advertising campaigns, optimized SEO and SEM strategies, and analyzed marketing performance metrics.'),
(b18, 'Salesforce', 'Marketing Manager', '2022-03-01', NULL, true, false, 'Leading demand generation programs for enterprise segment, managing marketing automation, and collaborating with sales teams.'),
(b19, 'Genentech', 'Research Scientist', '2017-09-01', '2020-11-01', false, false, 'Conducted drug discovery research for oncology therapeutics, designed experiments, and published findings in peer-reviewed journals.'),
(b19, 'Moderna', 'Senior Scientist', '2020-12-01', NULL, true, false, 'Leading research programs for mRNA vaccine development, managing lab teams, and collaborating with clinical development groups.'),
(b20, 'Salesforce', 'Account Executive', '2018-07-01', '2021-05-01', false, false, 'Sold CRM solutions to enterprise clients, managed sales pipeline, and consistently exceeded quarterly revenue targets.'),
(b20, 'MongoDB', 'Senior Account Executive', '2021-06-01', NULL, true, false, 'Managing strategic accounts in technology sector, closing complex enterprise deals, and mentoring junior sales representatives.'),
(b21, 'Accenture', 'Healthcare Consultant', '2017-09-01', '2021-02-01', false, false, 'Led digital transformation projects for healthcare clients, implemented EHR systems, and improved patient care delivery models.'),
(b21, 'PwC', 'Senior Consultant', '2021-03-01', NULL, true, false, 'Managing healthcare consulting engagements, advising on value-based care initiatives, and leading teams on population health strategies.'),
(b22, 'Microsoft', 'Software Engineer', '2018-08-01', '2021-10-01', false, false, 'Developed cloud infrastructure services for Azure, built REST APIs, and improved system scalability and performance.'),
(b22, 'GitHub', 'Senior Software Engineer', '2021-11-01', NULL, true, false, 'Building developer tools and platform features, contributing to open source projects, and supporting GitHub community initiatives.'),
(b23, 'Morgan Stanley', 'Investment Banking Analyst', '2020-08-01', '2023-07-01', false, false, 'Executed M&A and financing transactions across healthcare and technology sectors, performed valuation analysis, and prepared pitch books.'),
(b23, 'Credit Suisse', 'Investment Banking Associate', '2023-08-01', NULL, true, false, 'Leading deal execution for leveraged buyouts, managing client relationships, and mentoring junior analysts.'),
(b24, 'ExxonMobil', 'Energy Analyst', '2017-08-01', '2020-10-01', false, false, 'Analyzed energy markets, developed financial models for oil and gas projects, and supported strategic planning initiatives.'),
(b24, 'Chevron', 'Senior Energy Analyst', '2020-11-01', NULL, true, false, 'Leading energy transition strategy projects, evaluating renewable energy investments, and advising on portfolio optimization.'),
(b25, 'Procter & Gamble', 'HR Coordinator', '2018-07-01', '2020-09-01', false, false, 'Supported talent acquisition, managed employee onboarding programs, and coordinated leadership development initiatives.'),
(b25, 'Salesforce', 'HR Business Partner', '2020-10-01', NULL, true, false, 'Partnering with engineering and product teams on talent strategy, driving performance management, and leading diversity initiatives.'),
(b26, 'CBRE', 'Real Estate Analyst', '2016-09-01', '2019-12-01', false, false, 'Analyzed commercial real estate investments, performed financial modeling, and supported client advisory on acquisitions.'),
(b26, 'Cushman & Wakefield', 'Senior Real Estate Analyst', '2020-01-01', NULL, true, false, 'Leading valuation and investment analysis for office and retail properties, managing client relationships, and advising on market strategy.'),
(b27, 'Centers for Disease Control', 'Public Health Specialist', '2017-09-01', '2020-06-01', false, false, 'Managed community health programs, analyzed health data, and coordinated with local health departments on disease prevention.'),
(b27, 'Kaiser Permanente', 'Program Manager', '2020-07-01', NULL, true, false, 'Leading population health initiatives, managing cross-functional teams, and implementing value-based care programs.'),
(b28, 'Omnicom Media Group', 'Media Planner', '2020-08-01', '2022-11-01', false, false, 'Developed media strategies for consumer brands, negotiated with media vendors, and optimized campaign performance.'),
(b28, 'GroupM', 'Senior Media Strategist', '2022-12-01', NULL, true, false, 'Leading integrated media planning for major clients, managing agency relationships, and driving digital transformation initiatives.'),
(b29, 'Latham & Watkins', 'Corporate Associate', '2021-08-01', '2023-09-01', false, false, 'Advised on corporate transactions, drafted and negotiated contracts, and supported M&A due diligence for Fortune 500 clients.'),
(b29, 'Wilson Sonsini', 'Corporate Counsel', '2023-10-01', NULL, true, false, 'Providing legal counsel on venture capital financings, M&A transactions, and corporate governance for technology startups.'),
(b30, 'Amazon', 'Operations Coordinator', '2017-08-01', '2020-05-01', false, false, 'Managed fulfillment center operations, optimized logistics workflows, and led process improvement projects to reduce costs.'),
(b30, 'Target', 'Operations Manager', '2020-06-01', NULL, true, false, 'Leading supply chain operations for regional distribution centers, managing teams of 100+ employees, and driving operational excellence.')
ON CONFLICT DO NOTHING;

-- =============================================
-- SEEKER_PROFILES
-- =============================================

-- Seeker profiles (s16-s65)
-- ============================================================
INSERT INTO public.seeker_profiles (user_id, target_industry, target_role, target_companies, goal_type, goal_text, help_types_needed, is_first_gen, is_underrepresented, received_financial_aid) VALUES
(s16, 'Information Technology', 'Product Manager', ARRAY['Google','Meta','Apple'], 'break-into-company', 'I want to transition from SWE to PM at a top tech company and learn how to build products that impact millions of users.', ARRAY['career-switching','interview-prep','industry-insights','resume-review','networking'], false, false, true),
(s17, 'Investment Banking', 'Investment Banking Analyst', ARRAY['Goldman Sachs','Morgan Stanley','JPMorgan'], 'first-job', 'Looking to secure a full-time analyst position in investment banking and navigate the recruiting process successfully.', ARRAY['first-job','interview-prep','resume-review','networking','breaking-in'], true, true, true),
(s18, 'Consulting', 'Management Consultant', ARRAY['McKinsey','BCG','Bain'], 'switch-industries', 'Want to pivot from marketing to strategy consulting and learn how to break into MBB firms.', ARRAY['career-switching','interview-prep','case-prep','resume-review','industry-insights'], false, false, false),
(s19, 'Finance', 'Quantitative Researcher', ARRAY['Citadel','Two Sigma','Jane Street'], 'break-into-company', 'Seeking to land a quant research role at a top hedge fund and understand what separates successful candidates.', ARRAY['technical-skills','interview-prep','breaking-in','resume-review','day-to-day'], false, false, false),
(s20, 'Healthcare', 'Healthcare Consultant', ARRAY['McKinsey','BCG','Deloitte'], 'figure-direction', 'Exploring healthcare consulting as alternative to med school and need guidance on whether it''s the right path.', ARRAY['career-path','industry-insights','day-to-day','interview-prep','first-job'], true, true, true),
(s21, 'Private Equity', 'Private Equity Associate', ARRAY['Blackstone','KKR','Apollo'], 'break-into-company', 'Want to break into private equity with focus on ESG investing after banking analyst program.', ARRAY['breaking-in','career-path','industry-insights','networking','interview-prep'], false, false, false),
(s22, 'Information Technology', 'Software Engineer', ARRAY['Amazon','Microsoft','Google'], 'first-job', 'Looking to secure new grad SWE offer and improve my technical interviewing skills for system design rounds.', ARRAY['first-job','technical-skills','interview-prep','resume-review','offer-evaluation'], false, false, true),
(s23, 'Government', 'Policy Analyst', ARRAY['Deloitte','Booz Allen','RAND'], 'first-job', 'Want to work in government consulting focused on public policy and understand career progression in this field.', ARRAY['first-job','breaking-in','industry-insights','career-path','networking'], true, true, true),
(s24, 'Marketing', 'Brand Manager', ARRAY['Apple','Google','Meta'], 'break-into-company', 'Seeking brand management role at consumer tech company and need help positioning my CPG experience for tech.', ARRAY['resume-review','interview-prep','personal-branding','career-switching','networking'], false, false, false),
(s25, 'Media', 'Product Manager', ARRAY['Netflix','Spotify','Disney'], 'break-into-company', 'Want to work on streaming platform products and leverage my dual background in film and CS.', ARRAY['resume-review','interview-prep','career-path','personal-branding','networking'], false, false, false),
(s26, 'Biotechnology', 'Product Development Engineer', ARRAY['Medtronic','Boston Scientific','Abbott'], 'first-job', 'Looking for full-time role in medical device development and understanding regulatory approval processes.', ARRAY['first-job','industry-insights','interview-prep','technical-skills','career-path'], false, false, true),
(s27, 'Consulting', 'Business Analyst', ARRAY['McKinsey','Bain','BCG'], 'first-job', 'Want to land MBB offer and learn how to excel in case interviews and fit discussions.', ARRAY['first-job','interview-prep','breaking-in','resume-review','networking'], false, false, false),
(s28, 'Information Technology', 'Founding Engineer', ARRAY['Stripe','Anthropic','Scale AI'], 'figure-direction', 'Deciding between joining early-stage startup vs established tech company for maximum learning and growth.', ARRAY['career-path','industry-insights','offer-evaluation','day-to-day','salary-negotiation'], false, false, false),
(s29, 'Environmental', 'Sustainability Consultant', ARRAY['McKinsey','BCG','Bain'], 'break-into-company', 'Want to work on climate and sustainability strategy at top consulting firm.', ARRAY['breaking-in','career-switching','interview-prep','resume-review','industry-insights'], false, false, true),
(s30, 'Automotive', 'Electric Vehicle Engineer', ARRAY['Tesla','Rivian','Lucid'], 'first-job', 'Looking to break into EV industry and work on next-generation automotive technology.', ARRAY['first-job','breaking-in','technical-skills','interview-prep','industry-insights'], false, false, false),
(s31, 'Consulting', 'Consultant', ARRAY['McKinsey','BCG','Bain'], 'first-job', 'Want to secure MBB offer and learn how to navigate recruiting as first-gen college student.', ARRAY['first-job','interview-prep','resume-review','networking','breaking-in'], true, false, true),
(s32, 'Investment Banking', 'Investment Banking Analyst', ARRAY['Goldman Sachs','JPMorgan','Citi'], 'first-job', 'Looking to secure energy and power group IBD role and understand deal execution process.', ARRAY['first-job','interview-prep','industry-insights','networking','resume-review'], false, false, false),
(s33, 'Information Technology', 'UX Researcher', ARRAY['Google','Meta','Microsoft'], 'switch-industries', 'Want to transition from academia to industry UX research and build relevant portfolio.', ARRAY['career-switching','portfolio-review','interview-prep','personal-branding','resume-review'], false, false, true),
(s34, 'Information Technology', 'Security Engineer', ARRAY['Google','Meta','Cloudflare'], 'first-job', 'Looking to break into cybersecurity at major tech company and develop specialized technical skills.', ARRAY['first-job','technical-skills','interview-prep','career-path','resume-review'], false, false, true),
(s35, 'Consulting', 'Strategy Consultant', ARRAY['Deloitte','PwC','EY'], 'first-job', 'Want to work in corporate strategy consulting and eventually move into internal strategy roles.', ARRAY['first-job','career-path','interview-prep','industry-insights','resume-review'], false, false, false),
(s36, 'Information Technology', 'Data Scientist', ARRAY['Khan Academy','Duolingo','Coursera'], 'break-into-company', 'Want to use data science for social impact in education technology sector.', ARRAY['breaking-in','technical-skills','interview-prep','personal-branding','resume-review'], false, false, true),
(s37, 'Information Technology', 'Product Operations Manager', ARRAY['Stripe','Airbnb','Uber'], 'first-job', 'Looking to break into product operations at high-growth startup and understand the role.', ARRAY['first-job','breaking-in','industry-insights','day-to-day','career-path'], false, false, false),
(s38, 'Finance', 'Fintech Engineer', ARRAY['Stripe','Coinbase','Robinhood'], 'break-into-company', 'Want to work on cryptocurrency and blockchain technology at leading fintech company.', ARRAY['breaking-in','technical-skills','interview-prep','industry-insights','resume-review'], false, false, false),
(s39, 'Healthcare', 'Data Scientist', ARRAY['Pfizer','Moderna','Johnson & Johnson'], 'first-job', 'Looking to apply statistical modeling to pharmaceutical research and drug development.', ARRAY['first-job','technical-skills','industry-insights','interview-prep','career-path'], false, false, true),
(s40, 'Private Equity', 'Venture Capital Analyst', ARRAY['Andreessen Horowitz','Sequoia','Benchmark'], 'break-into-company', 'Want to break into venture capital and eventually start my own company.', ARRAY['breaking-in','networking','industry-insights','starting-business','career-path'], true, true, true),
(s41, 'Finance', 'Impact Investor', ARRAY['TPG Rise','Bain Capital Double Impact','Bridges Fund'], 'break-into-company', 'Looking to work in impact investing focused on emerging markets and microfinance.', ARRAY['breaking-in','industry-insights','networking','career-path','interview-prep'], false, true, false),
(s42, 'Information Technology', 'Sales Engineer', ARRAY['Salesforce','Microsoft','Oracle'], 'switch-industries', 'Want to transition from SWE to technical sales and understand career trajectory.', ARRAY['career-switching','industry-insights','interview-prep','day-to-day','salary-negotiation'], false, false, false),
(s43, 'Media', 'Marketing Manager', ARRAY['Warner Music','Universal Music','Sony'], 'first-job', 'Looking to break into music industry marketing and understand how to position myself.', ARRAY['first-job','breaking-in','industry-insights','resume-review','networking'], false, false, true),
(s44, 'Information Technology', 'Hardware Engineer', ARRAY['Intel','NVIDIA','AMD'], 'first-job', 'Want to work on cutting-edge chip design and semiconductor technology.', ARRAY['first-job','technical-skills','interview-prep','industry-insights','career-path'], false, false, false),
(s45, 'Healthcare', 'Healthcare Administrator', ARRAY['Cleveland Clinic','Mayo Clinic','Kaiser'], 'switch-industries', 'Exploring healthcare administration as alternative to clinical practice.', ARRAY['career-switching','industry-insights','career-path','interview-prep','day-to-day'], false, false, true),
(s46, 'Environmental', 'Clean Tech Engineer', ARRAY['Tesla Energy','Rivian','Sunrun'], 'first-job', 'Want to work on renewable energy technology and environmental sustainability solutions.', ARRAY['first-job','breaking-in','technical-skills','industry-insights','resume-review'], false, false, false),
(s47, 'Consulting', 'HR Tech Consultant', ARRAY['Deloitte','PwC','Accenture'], 'break-into-company', 'Looking to work in people analytics and organizational development consulting.', ARRAY['breaking-in','career-switching','interview-prep','industry-insights','resume-review'], false, false, true),
(s48, 'Automotive', 'Robotics Engineer', ARRAY['Tesla','Boston Dynamics','Waymo'], 'first-job', 'Want to work on autonomous systems and robotics at leading automotive or robotics company.', ARRAY['first-job','technical-skills','interview-prep','breaking-in','industry-insights'], false, false, false),
(s49, 'Information Technology', 'Corporate Communications Manager', ARRAY['Google','Apple','Microsoft'], 'break-into-company', 'Looking to transition into tech industry communications and PR roles.', ARRAY['breaking-in','career-switching','resume-review','interview-prep','personal-branding'], false, false, false),
(s50, 'Private Equity', 'Real Estate Investor', ARRAY['Blackstone','Brookfield','Starwood'], 'first-job', 'Want to work in commercial real estate private equity and understand deal sourcing.', ARRAY['first-job','industry-insights','breaking-in','interview-prep','networking'], false, false, false),
(s51, 'Information Technology', 'ML Engineer', ARRAY['OpenAI','Anthropic','DeepMind'], 'break-into-company', 'Looking to work on frontier AI research and applied ML at leading AI lab.', ARRAY['breaking-in','technical-skills','interview-prep','research-skills','resume-review'], false, false, true),
(s52, 'Biotechnology', 'Research Scientist', ARRAY['Moderna','Pfizer','Regeneron'], 'first-job', 'Want to work in pharmaceutical R&D on drug discovery and development.', ARRAY['first-job','technical-skills','industry-insights','career-path','interview-prep'], false, false, true),
(s53, 'Consulting', 'Technology Consultant', ARRAY['Deloitte','Accenture','PwC'], 'first-job', 'Looking to work in IT consulting and eventually specialize in cloud transformation.', ARRAY['first-job','interview-prep','technical-skills','career-path','resume-review'], false, false, false),
(s54, 'Media', 'Content Strategist', ARRAY['BuzzFeed','Vice','Vox'], 'break-into-company', 'Want to work in digital media and learn how to create viral content at scale.', ARRAY['breaking-in','career-switching','portfolio-review','interview-prep','personal-branding'], true, true, true),
(s55, 'Environmental', 'Power Systems Engineer', ARRAY['Tesla','GE Renewable','Siemens'], 'first-job', 'Looking to work on grid modernization and clean energy infrastructure.', ARRAY['first-job','technical-skills','industry-insights','interview-prep','career-path'], false, false, false),
(s56, 'Information Technology', 'Product Analyst', ARRAY['Meta','Google','Amazon'], 'first-job', 'Want to work in product analytics at consumer tech company and inform data-driven decisions.', ARRAY['first-job','technical-skills','interview-prep','resume-review','day-to-day'], false, false, true),
(s57, 'Finance', 'FP&A Analyst', ARRAY['Microsoft','Google','Amazon'], 'first-job', 'Looking to work in corporate finance and financial planning at major tech company.', ARRAY['first-job','interview-prep','industry-insights','technical-skills','career-path'], false, false, false),
(s58, 'Environmental', 'Marine Conservationist', ARRAY['Ocean Conservancy','The Nature Conservancy','WWF'], 'break-into-company', 'Want to work on ocean conservation policy and marine ecosystem protection.', ARRAY['breaking-in','career-path','industry-insights','networking','interview-prep'], false, false, true),
(s59, 'Consulting', 'Infrastructure Consultant', ARRAY['AECOM','Bechtel','Jacobs'], 'first-job', 'Looking to work on urban infrastructure projects and transportation planning.', ARRAY['first-job','technical-skills','industry-insights','interview-prep','career-path'], false, false, false),
(s60, 'Marketing', 'Growth Marketer', ARRAY['Airbnb','Uber','DoorDash'], 'first-job', 'Want to work in growth marketing at consumer tech startup and scale user acquisition.', ARRAY['first-job','interview-prep','technical-skills','resume-review','networking'], false, false, false),
(s61, 'Information Technology', 'Quantum Engineer', ARRAY['IBM Quantum','Google Quantum','IonQ'], 'first-job', 'Looking to work on quantum computing hardware and algorithm development.', ARRAY['first-job','technical-skills','breaking-in','industry-insights','career-path'], false, false, true),
(s62, 'Healthcare', 'Regulatory Affairs Specialist', ARRAY['Medtronic','Johnson & Johnson','Abbott'], 'first-job', 'Want to work in medical device regulatory affairs and navigate FDA approval processes.', ARRAY['first-job','industry-insights','technical-skills','interview-prep','career-path'], false, false, false),
(s63, 'Information Technology', 'Operations Manager', ARRAY['Amazon','Walmart','Target'], 'first-job', 'Looking to work in e-commerce operations and supply chain optimization.', ARRAY['first-job','interview-prep','technical-skills','industry-insights','resume-review'], false, false, true),
(s64, 'Government', 'International Development Specialist', ARRAY['World Bank','IMF','USAID'], 'break-into-company', 'Want to work on international development programs focused on economic empowerment.', ARRAY['breaking-in','networking','industry-insights','career-path','interview-prep'], true, false, true),
(s65, 'Automotive', 'Aerospace Engineer', ARRAY['SpaceX','Blue Origin','Boeing'], 'first-job', 'Looking to work on spacecraft propulsion systems and space exploration technology.', ARRAY['first-job','technical-skills','breaking-in','interview-prep','industry-insights'], false, false, false)
ON CONFLICT (user_id) DO NOTHING;

-- Both users as seekers (b01-b30)
INSERT INTO public.seeker_profiles (user_id, target_industry, target_role, target_companies, goal_type, goal_text, help_types_needed, is_first_gen, is_underrepresented, received_financial_aid) VALUES
(b01, 'Venture Capital', 'Venture Capital Investor', ARRAY['Sequoia Capital', 'Andreessen Horowitz', 'Kleiner Perkins'], 'switch-industries', 'I want to transition from product management in tech to venture capital, leveraging my experience building products to evaluate early-stage startups.', ARRAY['industry-insights', 'networking', 'breaking-in', 'interview-prep'], false, true, false),
(b02, 'Information Technology', 'Product Manager', ARRAY['Google', 'Microsoft', 'Stripe'], 'switch-industries', 'Looking to pivot from investment banking to product management in tech, where I can apply my analytical skills to building products users love.', ARRAY['career-switching', 'industry-insights', 'resume-review', 'interview-prep'], true, false, true),
(b03, 'Biotechnology', 'Biotech Product Manager', ARRAY['Genentech', 'Moderna', 'Illumina'], 'switch-industries', 'Transitioning from healthcare consulting to biotechnology product management, combining my healthcare knowledge with a more hands-on role in drug development.', ARRAY['career-switching', 'technical-skills', 'networking', 'interview-prep'], false, false, false),
(b04, 'Information Technology', 'Product Manager', ARRAY['Airbnb', 'Uber', 'Doordash'], 'switch-industries', 'Pivoting from marketing to product management to own the full product lifecycle and make strategic decisions about what we build.', ARRAY['career-switching', 'industry-insights', 'interview-prep', 'day-to-day'], false, true, false),
(b05, 'Venture Capital', 'Climate Tech Investor', ARRAY['Breakthrough Energy Ventures', 'Energy Impact Partners', 'Fifth Wall'], 'switch-industries', 'Moving from engineering to climate tech venture capital to invest in solutions addressing the climate crisis at scale.', ARRAY['breaking-in', 'networking', 'industry-insights', 'career-switching'], false, true, true),
(b06, 'Consulting', 'Management Consultant', ARRAY['McKinsey & Company', 'Boston Consulting Group', 'Bain & Company'], 'switch-industries', 'Transitioning from software engineering to management consulting to work on broader business strategy problems across industries.', ARRAY['career-switching', 'interview-prep', 'resume-review', 'industry-insights'], true, false, true),
(b07, 'Information Technology', 'Startup Operator', ARRAY['early-stage tech startups'], 'switch-industries', 'Leaving private equity to join an early-stage tech startup where I can wear multiple hats and help build something from the ground up.', ARRAY['breaking-in', 'job-search-strategy', 'networking', 'offer-evaluation'], false, false, false),
(b08, 'Energy', 'Renewable Energy Engineer', ARRAY['Tesla', 'NextEra Energy', 'Sunrun'], 'switch-industries', 'Pivoting from automotive engineering to renewable energy to work on solar, wind, and battery storage technologies.', ARRAY['industry-insights', 'networking', 'technical-skills', 'job-search-strategy'], true, false, true),
(b09, 'Entertainment', 'Film Producer', ARRAY['A24', 'Warner Bros', 'Netflix'], 'switch-industries', 'Transitioning from advertising to film and television production to tell stories that reach audiences in more meaningful ways.', ARRAY['breaking-in', 'networking', 'career-switching', 'day-to-day'], false, true, false),
(b10, 'Information Technology', 'Product Manager', ARRAY['Meta', 'Netflix', 'Spotify'], 'switch-industries', 'Moving from data science to product management to have broader impact on product strategy and user experience.', ARRAY['career-switching', 'interview-prep', 'industry-insights', 'resume-review'], false, false, false),
(b11, 'Government', 'Nonprofit Executive Director', ARRAY['nonprofit organizations'], 'figure-direction', 'Exploring nonprofit leadership roles where I can drive social impact at an organizational level rather than policy level.', ARRAY['career-path', 'networking', 'leadership', 'job-search-strategy'], true, true, true),
(b12, 'Real Estate', 'Real Estate Developer', ARRAY['Related Companies', 'Tishman Speyer', 'Brookfield Properties'], 'switch-industries', 'Pivoting from management consulting to real estate development to build communities and shape the built environment.', ARRAY['breaking-in', 'industry-insights', 'networking', 'career-switching'], false, false, false),
(b13, 'Healthcare', 'Healthcare Administrator', ARRAY['Mayo Clinic', 'Cleveland Clinic', 'Kaiser Permanente'], 'switch-industries', 'Transitioning from pharma sales to healthcare administration to work on hospital operations and healthcare delivery systems.', ARRAY['career-switching', 'grad-school', 'industry-insights', 'networking'], true, true, true),
(b14, 'Information Technology', 'Product Manager', ARRAY['Figma', 'Notion', 'Linear'], 'switch-industries', 'Moving from UX design to product management to own the full product vision and strategy beyond just the design.', ARRAY['career-switching', 'interview-prep', 'industry-insights', 'resume-review'], false, false, false),
(b15, 'Venture Capital', 'Venture Capital Investor', ARRAY['Andreessen Horowitz', 'Lightspeed', 'Benchmark'], 'switch-industries', 'Transitioning from entertainment law to venture capital to invest in media, entertainment, and consumer tech startups.', ARRAY['breaking-in', 'networking', 'industry-insights', 'career-switching'], false, true, false),
(b16, 'Information Technology', 'Fintech Product Manager', ARRAY['Stripe', 'Plaid', 'Chime'], 'switch-industries', 'Pivoting from corporate finance to fintech product roles to build innovative financial products and services.', ARRAY['career-switching', 'technical-skills', 'interview-prep', 'industry-insights'], false, false, true),
(b17, 'Information Technology', 'Construction Tech Product Manager', ARRAY['Procore', 'Autodesk', 'PlanGrid'], 'switch-industries', 'Transitioning from civil engineering to construction tech to build software solutions for the construction industry.', ARRAY['career-switching', 'technical-skills', 'breaking-in', 'networking'], true, false, true),
(b18, 'Consulting', 'Strategy Consultant', ARRAY['McKinsey & Company', 'Bain & Company', 'Oliver Wyman'], 'switch-industries', 'Moving from digital marketing to management consulting to solve complex business problems across different industries.', ARRAY['interview-prep', 'career-switching', 'resume-review', 'industry-insights'], false, true, false),
(b19, 'Venture Capital', 'Life Sciences Investor', ARRAY['Third Rock Ventures', 'Atlas Venture', 'Flagship Pioneering'], 'switch-industries', 'Transitioning from biotech research to healthcare venture capital to fund the next generation of therapeutic innovations.', ARRAY['breaking-in', 'networking', 'career-switching', 'interview-prep'], false, false, false),
(b20, 'Information Technology', 'Startup Chief of Staff', ARRAY['early-stage tech startups'], 'switch-industries', 'Pivoting from enterprise sales to startup operations roles where I can help founders scale their companies.', ARRAY['breaking-in', 'job-search-strategy', 'networking', 'career-switching'], true, true, true),
(b21, 'Marketing', 'Product Marketing Manager', ARRAY['Notion', 'Figma', 'Databricks'], 'switch-industries', 'Transitioning from healthcare consulting to product marketing in tech to bring innovative products to market.', ARRAY['career-switching', 'industry-insights', 'interview-prep', 'resume-review'], false, false, false),
(b22, 'Information Technology', 'Developer Advocate', ARRAY['Stripe', 'Twilio', 'Vercel'], 'figure-direction', 'Exploring developer relations roles that combine technical expertise with community building and content creation.', ARRAY['career-path', 'industry-insights', 'networking', 'day-to-day'], false, true, false),
(b23, 'Private Equity', 'Private Equity Investor', ARRAY['Blackstone', 'KKR', 'Apollo'], 'switch-industries', 'Moving from investment banking to private equity to work on the buy-side and drive value creation in portfolio companies.', ARRAY['breaking-in', 'interview-prep', 'networking', 'career-switching'], false, false, false),
(b24, 'Energy', 'Climate Tech Product Manager', ARRAY['Tesla', 'Rivian', 'Sunrun'], 'switch-industries', 'Pivoting from traditional energy to climate tech startups to accelerate the clean energy transition.', ARRAY['career-switching', 'breaking-in', 'networking', 'industry-insights'], true, false, true),
(b25, 'Consulting', 'Organizational Development Consultant', ARRAY['Korn Ferry', 'Deloitte', 'PwC'], 'switch-industries', 'Transitioning from internal HR to external consulting to advise multiple organizations on talent and culture.', ARRAY['career-switching', 'interview-prep', 'networking', 'industry-insights'], false, true, false),
(b26, 'Information Technology', 'Proptech Product Manager', ARRAY['Zillow', 'Opendoor', 'Compass'], 'switch-industries', 'Moving from real estate analysis to proptech to build technology solutions that transform the real estate industry.', ARRAY['career-switching', 'technical-skills', 'breaking-in', 'interview-prep'], false, false, false),
(b27, 'Healthcare', 'Health Tech Product Manager', ARRAY['Included Health', 'Devoted Health', 'Oscar Health'], 'switch-industries', 'Pivoting from public health to digital health tech to scale healthcare solutions through technology.', ARRAY['career-switching', 'technical-skills', 'industry-insights', 'networking'], true, true, true),
(b28, 'Entertainment', 'Content Producer', ARRAY['Netflix', 'HBO', 'A24'], 'switch-industries', 'Transitioning from media planning to entertainment production to create original content and tell compelling stories.', ARRAY['breaking-in', 'networking', 'career-switching', 'job-search-strategy'], false, false, false),
(b29, 'Information Technology', 'Startup Legal Counsel', ARRAY['high-growth tech startups'], 'switch-industries', 'Moving from law firm to in-house legal at a tech startup to be part of building something transformative.', ARRAY['break-into-company', 'networking', 'offer-evaluation', 'day-to-day'], false, true, false),
(b30, 'Consulting', 'Supply Chain Consultant', ARRAY['McKinsey & Company', 'Bain & Company', 'Kearney'], 'switch-industries', 'Transitioning from internal operations to consulting to advise companies on supply chain optimization and logistics strategy.', ARRAY['career-switching', 'interview-prep', 'resume-review', 'industry-insights'], true, false, true)
ON CONFLICT DO NOTHING;

-- =============================================
-- GIVER_PROFILES
-- =============================================

-- Giver profiles (g16-g65)
INSERT INTO public.giver_profiles (user_id, industries_can_advise, help_types_offered, factor_rankings, prioritize_underrepresented, experience_level) VALUES
(g16, ARRAY['Information Technology', 'Internet', 'Consumer Goods'], ARRAY['resume-review', 'interview-prep', 'career-path', 'networking', 'getting-promoted', 'leadership'], '{"location": 4, "shared_university": 2, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 3}', true, 15),
(g17, ARRAY['Investment Banking', 'Finance', 'Healthcare'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'salary-negotiation'], '{"location": 5, "shared_university": 3, "prestige": 1, "gpa": 2, "industry_alignment": 4, "shared_interests": 6}', false, 14),
(g18, ARRAY['Consulting', 'Energy', 'Environmental'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'career-switching'], '{"location": 3, "shared_university": 4, "prestige": 2, "gpa": 5, "industry_alignment": 1, "shared_interests": 6}', true, 13),
(g19, ARRAY['Information Technology', 'Internet'], ARRAY['technical-skills', 'career-path', 'industry-insights', 'leadership', 'getting-promoted', 'networking'], '{"location": 6, "shared_university": 2, "prestige": 4, "gpa": 5, "industry_alignment": 1, "shared_interests": 3}', false, 16),
(g20, ARRAY['Healthcare', 'Government'], ARRAY['industry-insights', 'career-path', 'leadership', 'grad-school', 'career-switching', 'networking'], '{"location": 2, "shared_university": 1, "prestige": 3, "gpa": 4, "industry_alignment": 5, "shared_interests": 6}', true, 19),
(g21, ARRAY['Private Equity', 'Finance', 'Investment Banking'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'breaking-in', 'salary-negotiation', 'offer-evaluation'], '{"location": 4, "shared_university": 3, "prestige": 1, "gpa": 2, "industry_alignment": 5, "shared_interests": 6}', false, 15),
(g22, ARRAY['Marketing', 'Advertising', 'Consumer Goods'], ARRAY['resume-review', 'career-path', 'industry-insights', 'personal-branding', 'networking', 'career-switching'], '{"location": 5, "shared_university": 4, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', true, 14),
(g23, ARRAY['Venture Capital', 'Information Technology', 'Internet'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'starting-business', 'career-switching'], '{"location": 3, "shared_university": 2, "prestige": 1, "gpa": 5, "industry_alignment": 4, "shared_interests": 6}', false, 17),
(g24, ARRAY['Media', 'Entertainment'], ARRAY['resume-review', 'industry-insights', 'career-path', 'networking', 'portfolio-review', 'breaking-in'], '{"location": 2, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 4}', true, 15),
(g25, ARRAY['Automotive', 'Engineering'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'grad-school', 'leadership', 'getting-promoted'], '{"location": 4, "shared_university": 3, "prestige": 2, "gpa": 5, "industry_alignment": 1, "shared_interests": 6}', false, 16),
(g26, ARRAY['Government', 'Education'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'career-switching', 'grad-school'], '{"location": 1, "shared_university": 2, "prestige": 4, "gpa": 5, "industry_alignment": 3, "shared_interests": 6}', true, 18),
(g27, ARRAY['Finance', 'Investment Banking'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'grad-school', 'salary-negotiation'], '{"location": 5, "shared_university": 3, "prestige": 1, "gpa": 2, "industry_alignment": 4, "shared_interests": 6}', false, 17),
(g28, ARRAY['Biotechnology', 'Pharmaceuticals', 'Healthcare'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'grad-school', 'research', 'breaking-in'], '{"location": 3, "shared_university": 2, "prestige": 4, "gpa": 1, "industry_alignment": 5, "shared_interests": 6}', true, 18),
(g29, ARRAY['Consumer Goods', 'Marketing', 'International'], ARRAY['industry-insights', 'career-path', 'international', 'networking', 'leadership', 'getting-promoted'], '{"location": 2, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 4}', false, 20),
(g30, ARRAY['Automotive', 'Engineering', 'Manufacturing'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'leadership', 'getting-promoted', 'career-switching'], '{"location": 4, "shared_university": 3, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', true, 15),
(g31, ARRAY['Information Technology', 'Consulting'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'technical-skills'], '{"location": 5, "shared_university": 2, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 4}', false, 14),
(g32, ARRAY['Real Estate', 'Finance'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'starting-business', 'grad-school'], '{"location": 3, "shared_university": 4, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', true, 15),
(g33, ARRAY['Energy', 'Environmental', 'Engineering'], ARRAY['industry-insights', 'career-path', 'technical-skills', 'career-switching', 'networking', 'grad-school'], '{"location": 2, "shared_university": 3, "prestige": 5, "gpa": 4, "industry_alignment": 1, "shared_interests": 6}', true, 13),
(g34, ARRAY['Information Technology', 'Internet', 'Media'], ARRAY['portfolio-review', 'career-path', 'industry-insights', 'networking', 'personal-branding', 'getting-promoted'], '{"location": 4, "shared_university": 5, "prestige": 6, "gpa": 3, "industry_alignment": 1, "shared_interests": 2}', false, 14),
(g35, ARRAY['Pharmaceuticals', 'Healthcare', 'Biotechnology'], ARRAY['industry-insights', 'career-path', 'technical-skills', 'grad-school', 'breaking-in', 'career-switching'], '{"location": 3, "shared_university": 2, "prestige": 4, "gpa": 1, "industry_alignment": 5, "shared_interests": 6}', false, 16),
(g36, ARRAY['Finance', 'Banking'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'salary-negotiation', 'networking'], '{"location": 5, "shared_university": 4, "prestige": 2, "gpa": 3, "industry_alignment": 1, "shared_interests": 6}', true, 13),
(g37, ARRAY['Human Resources', 'Consulting'], ARRAY['career-path', 'leadership', 'getting-promoted', 'networking', 'salary-negotiation', 'personal-branding'], '{"location": 2, "shared_university": 3, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 4}', true, 15),
(g38, ARRAY['Consulting', 'Healthcare'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'case-prep'], '{"location": 4, "shared_university": 2, "prestige": 1, "gpa": 3, "industry_alignment": 5, "shared_interests": 6}', false, 16),
(g39, ARRAY['Finance', 'Information Technology'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'breaking-in', 'grad-school', 'career-switching'], '{"location": 3, "shared_university": 4, "prestige": 2, "gpa": 1, "industry_alignment": 5, "shared_interests": 6}', true, 14),
(g40, ARRAY['Defense', 'Aerospace', 'Engineering'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'breaking-in', 'leadership', 'getting-promoted'], '{"location": 5, "shared_university": 3, "prestige": 4, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 17),
(g41, ARRAY['Marketing', 'Advertising', 'Consumer Goods'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'networking', 'getting-promoted', 'career-switching'], '{"location": 4, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 15),
(g42, ARRAY['Finance', 'Healthcare', 'Consulting'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'networking'], '{"location": 3, "shared_university": 2, "prestige": 1, "gpa": 4, "industry_alignment": 5, "shared_interests": 6}', true, 16),
(g43, ARRAY['Information Technology', 'Healthcare', 'Consulting'], ARRAY['resume-review', 'technical-skills', 'career-path', 'industry-insights', 'leadership', 'networking'], '{"location": 5, "shared_university": 4, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', true, 14),
(g44, ARRAY['Pharmaceuticals', 'Healthcare'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'salary-negotiation', 'getting-promoted'], '{"location": 2, "shared_university": 5, "prestige": 4, "gpa": 6, "industry_alignment": 1, "shared_interests": 3}', false, 15),
(g45, ARRAY['Environmental', 'Engineering', 'Energy'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'career-switching', 'networking', 'grad-school'], '{"location": 3, "shared_university": 4, "prestige": 5, "gpa": 2, "industry_alignment": 1, "shared_interests": 6}', true, 14),
(g46, ARRAY['Information Technology', 'Biotechnology', 'Healthcare'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'grad-school', 'research', 'breaking-in'], '{"location": 4, "shared_university": 2, "prestige": 3, "gpa": 1, "industry_alignment": 5, "shared_interests": 6}', false, 15),
(g47, ARRAY['Entertainment', 'Hospitality'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'leadership', 'getting-promoted'], '{"location": 1, "shared_university": 5, "prestige": 6, "gpa": 4, "industry_alignment": 2, "shared_interests": 3}', true, 13),
(g48, ARRAY['Information Technology', 'Finance', 'Cybersecurity'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'breaking-in', 'grad-school', 'career-switching'], '{"location": 5, "shared_university": 3, "prestige": 2, "gpa": 4, "industry_alignment": 1, "shared_interests": 6}', false, 16),
(g49, ARRAY['Fashion', 'Consumer Goods', 'Internet'], ARRAY['industry-insights', 'career-path', 'portfolio-review', 'networking', 'personal-branding', 'breaking-in'], '{"location": 3, "shared_university": 6, "prestige": 5, "gpa": 4, "industry_alignment": 1, "shared_interests": 2}', true, 14),
(g50, ARRAY['Finance', 'Healthcare'], ARRAY['resume-review', 'technical-skills', 'industry-insights', 'career-path', 'salary-negotiation', 'getting-promoted'], '{"location": 4, "shared_university": 3, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 15),
(g51, ARRAY['Consulting', 'Information Technology'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'breaking-in', 'technical-skills'], '{"location": 5, "shared_university": 4, "prestige": 2, "gpa": 6, "industry_alignment": 1, "shared_interests": 3}', false, 13),
(g52, ARRAY['Energy', 'Environmental', 'Engineering'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'career-switching', 'networking', 'starting-business'], '{"location": 2, "shared_university": 3, "prestige": 5, "gpa": 6, "industry_alignment": 1, "shared_interests": 4}', true, 15),
(g53, ARRAY['Healthcare', 'Government'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'grad-school', 'networking', 'career-switching'], '{"location": 3, "shared_university": 2, "prestige": 4, "gpa": 5, "industry_alignment": 1, "shared_interests": 6}', true, 14),
(g54, ARRAY['Consumer Goods', 'Manufacturing', 'Logistics'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'leadership', 'getting-promoted', 'networking'], '{"location": 4, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 15),
(g55, ARRAY['Aerospace', 'Defense', 'Engineering'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'breaking-in', 'grad-school', 'leadership'], '{"location": 5, "shared_university": 3, "prestige": 2, "gpa": 4, "industry_alignment": 1, "shared_interests": 6}', false, 16),
(g56, ARRAY['Finance', 'Energy', 'Investment Banking'], ARRAY['resume-review', 'industry-insights', 'career-path', 'technical-skills', 'breaking-in', 'salary-negotiation'], '{"location": 3, "shared_university": 4, "prestige": 1, "gpa": 2, "industry_alignment": 5, "shared_interests": 6}', true, 12),
(g57, ARRAY['Government', 'Defense'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'career-switching', 'grad-school'], '{"location": 1, "shared_university": 3, "prestige": 4, "gpa": 5, "industry_alignment": 2, "shared_interests": 6}', false, 14),
(g58, ARRAY['Finance', 'Insurance'], ARRAY['industry-insights', 'career-path', 'technical-skills', 'breaking-in', 'leadership', 'getting-promoted'], '{"location": 4, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 13),
(g59, ARRAY['Media', 'Entertainment'], ARRAY['industry-insights', 'career-path', 'portfolio-review', 'networking', 'breaking-in', 'personal-branding'], '{"location": 2, "shared_university": 6, "prestige": 4, "gpa": 5, "industry_alignment": 1, "shared_interests": 3}', true, 14),
(g60, ARRAY['Environmental', 'Engineering', 'Agriculture'], ARRAY['industry-insights', 'technical-skills', 'career-path', 'grad-school', 'career-switching', 'starting-business'], '{"location": 3, "shared_university": 2, "prestige": 5, "gpa": 4, "industry_alignment": 1, "shared_interests": 6}', true, 15),
(g61, ARRAY['Engineering', 'Information Technology'], ARRAY['technical-skills', 'industry-insights', 'career-path', 'breaking-in', 'leadership', 'getting-promoted'], '{"location": 5, "shared_university": 3, "prestige": 2, "gpa": 1, "industry_alignment": 4, "shared_interests": 6}', false, 17),
(g62, ARRAY['Government', 'Nonprofit'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'grad-school', 'networking', 'career-switching'], '{"location": 2, "shared_university": 3, "prestige": 4, "gpa": 5, "industry_alignment": 1, "shared_interests": 6}', true, 13),
(g63, ARRAY['Real Estate', 'Finance'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'networking', 'salary-negotiation', 'getting-promoted'], '{"location": 1, "shared_university": 5, "prestige": 4, "gpa": 6, "industry_alignment": 2, "shared_interests": 3}', false, 14),
(g64, ARRAY['Information Technology', 'Internet'], ARRAY['resume-review', 'industry-insights', 'career-path', 'salary-negotiation', 'leadership', 'networking'], '{"location": 4, "shared_university": 5, "prestige": 3, "gpa": 6, "industry_alignment": 1, "shared_interests": 2}', false, 14),
(g65, ARRAY['Environmental', 'Government', 'Energy'], ARRAY['industry-insights', 'career-path', 'breaking-in', 'grad-school', 'networking', 'career-switching'], '{"location": 2, "shared_university": 3, "prestige": 4, "gpa": 5, "industry_alignment": 1, "shared_interests": 6}', true, 13)
ON CONFLICT DO NOTHING;

-- Both users as givers (b01-b30)
INSERT INTO public.giver_profiles (user_id, industries_can_advise, help_types_offered, factor_rankings, prioritize_underrepresented, experience_level) VALUES
(b01, ARRAY['Information Technology'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'day-to-day', 'personal-branding'], '{"location": 5, "shared_university": 3, "prestige": 6, "gpa": 4, "industry_alignment": 1, "shared_interests": 2}'::jsonb, true, 5),
(b02, ARRAY['Investment Banking', 'Finance'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'breaking-in', 'career-path', 'salary-negotiation'], '{"location": 4, "shared_university": 2, "prestige": 1, "gpa": 3, "industry_alignment": 6, "shared_interests": 5}'::jsonb, false, 4),
(b03, ARRAY['Consulting', 'Healthcare'], ARRAY['interview-prep', 'industry-insights', 'career-path', 'day-to-day', 'career-switching', 'networking'], '{"location": 3, "shared_university": 1, "prestige": 5, "gpa": 6, "industry_alignment": 2, "shared_interests": 4}'::jsonb, true, 6),
(b04, ARRAY['Marketing', 'Advertising'], ARRAY['resume-review', 'portfolio-review', 'industry-insights', 'personal-branding', 'career-path', 'day-to-day'], '{"location": 6, "shared_university": 4, "prestige": 2, "gpa": 5, "industry_alignment": 1, "shared_interests": 3}'::jsonb, true, 5),
(b05, ARRAY['Engineering', 'Environmental'], ARRAY['resume-review', 'interview-prep', 'technical-skills', 'industry-insights', 'career-path', 'first-job'], '{"location": 2, "shared_university": 5, "prestige": 3, "gpa": 1, "industry_alignment": 4, "shared_interests": 6}'::jsonb, true, 7),
(b06, ARRAY['Information Technology'], ARRAY['technical-skills', 'interview-prep', 'resume-review', 'career-path', 'getting-promoted', 'leadership'], '{"location": 4, "shared_university": 6, "prestige": 1, "gpa": 2, "industry_alignment": 3, "shared_interests": 5}'::jsonb, false, 6),
(b07, ARRAY['Private Equity', 'Finance'], ARRAY['interview-prep', 'industry-insights', 'breaking-in', 'career-path', 'salary-negotiation', 'networking'], '{"location": 1, "shared_university": 3, "prestige": 2, "gpa": 4, "industry_alignment": 5, "shared_interests": 6}'::jsonb, false, 4),
(b08, ARRAY['Engineering'], ARRAY['technical-skills', 'resume-review', 'interview-prep', 'industry-insights', 'career-path', 'day-to-day'], '{"location": 5, "shared_university": 2, "prestige": 6, "gpa": 3, "industry_alignment": 1, "shared_interests": 4}'::jsonb, true, 5),
(b09, ARRAY['Advertising', 'Marketing'], ARRAY['portfolio-review', 'resume-review', 'industry-insights', 'personal-branding', 'networking', 'getting-promoted'], '{"location": 3, "shared_university": 1, "prestige": 4, "gpa": 6, "industry_alignment": 2, "shared_interests": 5}'::jsonb, true, 6),
(b10, ARRAY['Information Technology'], ARRAY['technical-skills', 'interview-prep', 'resume-review', 'career-path', 'day-to-day', 'getting-promoted'], '{"location": 6, "shared_university": 4, "prestige": 1, "gpa": 5, "industry_alignment": 2, "shared_interests": 3}'::jsonb, false, 5),
(b11, ARRAY['Government'], ARRAY['resume-review', 'industry-insights', 'career-path', 'networking', 'breaking-in', 'day-to-day'], '{"location": 2, "shared_university": 3, "prestige": 5, "gpa": 1, "industry_alignment": 6, "shared_interests": 4}'::jsonb, true, 7),
(b12, ARRAY['Consulting'], ARRAY['interview-prep', 'resume-review', 'industry-insights', 'breaking-in', 'career-path', 'salary-negotiation'], '{"location": 4, "shared_university": 1, "prestige": 2, "gpa": 6, "industry_alignment": 3, "shared_interests": 5}'::jsonb, false, 6),
(b13, ARRAY['Pharmaceuticals'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'breaking-in', 'day-to-day', 'networking'], '{"location": 1, "shared_university": 5, "prestige": 3, "gpa": 4, "industry_alignment": 2, "shared_interests": 6}'::jsonb, true, 4),
(b14, ARRAY['Information Technology'], ARRAY['portfolio-review', 'resume-review', 'industry-insights', 'technical-skills', 'personal-branding', 'day-to-day'], '{"location": 5, "shared_university": 2, "prestige": 4, "gpa": 6, "industry_alignment": 1, "shared_interests": 3}'::jsonb, false, 5),
(b15, ARRAY['Entertainment', 'Media'], ARRAY['resume-review', 'industry-insights', 'networking', 'breaking-in', 'career-path', 'salary-negotiation'], '{"location": 3, "shared_university": 6, "prestige": 1, "gpa": 5, "industry_alignment": 2, "shared_interests": 4}'::jsonb, true, 6),
(b16, ARRAY['Finance'], ARRAY['resume-review', 'interview-prep', 'technical-skills', 'industry-insights', 'career-path', 'first-job'], '{"location": 6, "shared_university": 3, "prestige": 2, "gpa": 1, "industry_alignment": 4, "shared_interests": 5}'::jsonb, false, 5),
(b17, ARRAY['Engineering'], ARRAY['technical-skills', 'resume-review', 'interview-prep', 'industry-insights', 'career-path', 'day-to-day'], '{"location": 2, "shared_university": 4, "prestige": 5, "gpa": 3, "industry_alignment": 1, "shared_interests": 6}'::jsonb, true, 7),
(b18, ARRAY['Marketing', 'Advertising'], ARRAY['resume-review', 'industry-insights', 'personal-branding', 'technical-skills', 'career-path', 'networking'], '{"location": 4, "shared_university": 1, "prestige": 6, "gpa": 2, "industry_alignment": 3, "shared_interests": 5}'::jsonb, true, 4),
(b19, ARRAY['Biotechnology', 'Pharmaceuticals'], ARRAY['technical-skills', 'resume-review', 'industry-insights', 'career-path', 'grad-school', 'day-to-day'], '{"location": 1, "shared_university": 5, "prestige": 2, "gpa": 6, "industry_alignment": 3, "shared_interests": 4}'::jsonb, false, 6),
(b20, ARRAY['Information Technology'], ARRAY['resume-review', 'interview-prep', 'salary-negotiation', 'career-path', 'networking', 'personal-branding'], '{"location": 5, "shared_university": 3, "prestige": 4, "gpa": 1, "industry_alignment": 2, "shared_interests": 6}'::jsonb, true, 5),
(b21, ARRAY['Consulting', 'Healthcare'], ARRAY['interview-prep', 'resume-review', 'industry-insights', 'career-path', 'breaking-in', 'day-to-day'], '{"location": 3, "shared_university": 2, "prestige": 1, "gpa": 4, "industry_alignment": 6, "shared_interests": 5}'::jsonb, false, 6),
(b22, ARRAY['Information Technology'], ARRAY['technical-skills', 'interview-prep', 'resume-review', 'career-path', 'day-to-day', 'personal-branding'], '{"location": 6, "shared_university": 4, "prestige": 3, "gpa": 5, "industry_alignment": 1, "shared_interests": 2}'::jsonb, true, 5),
(b23, ARRAY['Investment Banking', 'Finance'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'breaking-in', 'salary-negotiation', 'networking'], '{"location": 2, "shared_university": 1, "prestige": 3, "gpa": 6, "industry_alignment": 4, "shared_interests": 5}'::jsonb, false, 4),
(b24, ARRAY['Energy'], ARRAY['resume-review', 'industry-insights', 'technical-skills', 'career-path', 'day-to-day', 'networking'], '{"location": 4, "shared_university": 5, "prestige": 6, "gpa": 2, "industry_alignment": 1, "shared_interests": 3}'::jsonb, true, 6),
(b25, ARRAY['Information Technology'], ARRAY['resume-review', 'career-path', 'networking', 'getting-promoted', 'leadership', 'personal-branding'], '{"location": 1, "shared_university": 6, "prestige": 4, "gpa": 3, "industry_alignment": 2, "shared_interests": 5}'::jsonb, true, 5),
(b26, ARRAY['Real Estate'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'breaking-in', 'career-path', 'networking'], '{"location": 5, "shared_university": 2, "prestige": 1, "gpa": 4, "industry_alignment": 3, "shared_interests": 6}'::jsonb, false, 7),
(b27, ARRAY['Healthcare', 'Government'], ARRAY['resume-review', 'industry-insights', 'career-path', 'leadership', 'networking', 'day-to-day'], '{"location": 3, "shared_university": 4, "prestige": 2, "gpa": 6, "industry_alignment": 1, "shared_interests": 5}'::jsonb, true, 6),
(b28, ARRAY['Media', 'Advertising'], ARRAY['resume-review', 'portfolio-review', 'industry-insights', 'personal-branding', 'networking', 'career-path'], '{"location": 6, "shared_university": 3, "prestige": 5, "gpa": 1, "industry_alignment": 2, "shared_interests": 4}'::jsonb, false, 4),
(b29, ARRAY['Information Technology'], ARRAY['resume-review', 'industry-insights', 'career-path', 'salary-negotiation', 'networking', 'breaking-in'], '{"location": 2, "shared_university": 1, "prestige": 3, "gpa": 5, "industry_alignment": 4, "shared_interests": 6}'::jsonb, true, 5),
(b30, ARRAY['Information Technology'], ARRAY['resume-review', 'interview-prep', 'industry-insights', 'career-path', 'leadership', 'getting-promoted'], '{"location": 4, "shared_university": 6, "prestige": 1, "gpa": 2, "industry_alignment": 3, "shared_interests": 5}'::jsonb, false, 6)
ON CONFLICT DO NOTHING;

-- =============================================
-- USER_INTERESTS
-- =============================================

-- All 130 users (s16-s65, g16-g65, b01-b30)
INSERT INTO public.user_interests (user_id, interest_id)
SELECT uid, i.id
FROM (VALUES
  (s16, 'Data Science'), (s16, 'Machine Learning'), (s16, 'Software Engineering'), (s16, 'Cloud Computing'),
  (s17, 'Investment Banking'), (s17, 'Corporate Finance'), (s17, 'Financial Planning'), (s17, 'Wealth Management'),
  (s18, 'Public Health'), (s18, 'Healthcare Administration'), (s18, 'Health Informatics'), (s18, 'Pharmaceuticals'),
  (s19, 'Machine Learning'), (s19, 'Software Engineering'), (s19, 'Data Science'), (s19, 'Cloud Computing'),
  (s20, 'Management Consulting'), (s20, 'Strategy Consulting'), (s20, 'Operations Consulting'), (s20, 'Business Development'),
  (s21, 'Private Equity'), (s21, 'Investment Banking'), (s21, 'Venture Capital'), (s21, 'Corporate Finance'),
  (s22, 'Biotech Research'), (s22, 'Pharmaceuticals'), (s22, 'Healthcare Administration'), (s22, 'Public Health'),
  (s23, 'Software Engineering'), (s23, 'Cloud Computing'), (s23, 'Mobile Development'), (s23, 'DevOps'),
  (s24, 'Marketing Strategy'), (s24, 'Brand Management'), (s24, 'E-Commerce'), (s24, 'Content Creation'),
  (s25, 'Mechanical Engineering'), (s25, 'Software Engineering'), (s25, 'Renewable Energy'), (s25, 'Civil Engineering'),
  (s26, 'Venture Capital'), (s26, 'Private Equity'), (s26, 'Investment Banking'), (s26, 'Entrepreneurship'),
  (s27, 'Corporate Law'), (s27, 'Public Policy'), (s27, 'Regulatory Compliance'), (s27, 'Intellectual Property'),
  (s28, 'Cloud Computing'), (s28, 'Software Engineering'), (s28, 'DevOps'), (s28, 'Cybersecurity'),
  (s29, 'Strategy Consulting'), (s29, 'Management Consulting'), (s29, 'Business Development'), (s29, 'Operations Consulting'),
  (s30, 'Content Creation'), (s30, 'Journalism'), (s30, 'Film & Video Production'), (s30, 'Marketing Strategy'),
  (s31, 'Cybersecurity'), (s31, 'Software Engineering'), (s31, 'Cloud Computing'), (s31, 'Data Science'),
  (s32, 'Healthcare Administration'), (s32, 'Public Health'), (s32, 'Health Informatics'), (s32, 'Pharmaceuticals'),
  (s33, 'Quantitative Finance'), (s33, 'Data Science'), (s33, 'Investment Banking'), (s33, 'Machine Learning'),
  (s34, 'Civil Engineering'), (s34, 'Mechanical Engineering'), (s34, 'Environmental Science'), (s34, 'Renewable Energy'),
  (s35, 'UX Design'), (s35, 'Product Management'), (s35, 'Software Engineering'), (s35, 'Mobile Development'),
  (s36, 'Entrepreneurship'), (s36, 'Business Development'), (s36, 'Marketing Strategy'), (s36, 'E-Commerce'),
  (s37, 'Pharmaceuticals'), (s37, 'Biotech Research'), (s37, 'Healthcare Administration'), (s37, 'Health Informatics'),
  (s38, 'Investment Banking'), (s38, 'Corporate Finance'), (s38, 'Private Equity'), (s38, 'Quantitative Finance'),
  (s39, 'Machine Learning'), (s39, 'Data Science'), (s39, 'Software Engineering'), (s39, 'Cloud Computing'),
  (s40, 'Operations Consulting'), (s40, 'Management Consulting'), (s40, 'Supply Chain Management'), (s40, 'Business Development'),
  (s41, 'E-Commerce'), (s41, 'Marketing Strategy'), (s41, 'Brand Management'), (s41, 'Business Development'),
  (s42, 'Renewable Energy'), (s42, 'Environmental Science'), (s42, 'Mechanical Engineering'), (s42, 'Civil Engineering'),
  (s43, 'Corporate Law'), (s43, 'Intellectual Property'), (s43, 'Regulatory Compliance'), (s43, 'Public Policy'),
  (s44, 'Mobile Development'), (s44, 'Software Engineering'), (s44, 'UX Design'), (s44, 'Cloud Computing'),
  (s45, 'Journalism'), (s45, 'Content Creation'), (s45, 'Film & Video Production'), (s45, 'Marketing Strategy'),
  (s46, 'Non-Profit Management'), (s46, 'Social Impact'), (s46, 'Public Policy'), (s46, 'Higher Education'),
  (s47, 'Public Health'), (s47, 'Healthcare Administration'), (s47, 'Health Informatics'), (s47, 'Social Impact'),
  (s48, 'DevOps'), (s48, 'Cloud Computing'), (s48, 'Software Engineering'), (s48, 'Cybersecurity'),
  (s49, 'Supply Chain Management'), (s49, 'Operations Consulting'), (s49, 'Business Development'), (s49, 'E-Commerce'),
  (s50, 'Wealth Management'), (s50, 'Financial Planning'), (s50, 'Investment Banking'), (s50, 'Private Equity'),
  (s51, 'Product Management'), (s51, 'UX Design'), (s51, 'Software Engineering'), (s51, 'Business Development'),
  (s52, 'Mechanical Engineering'), (s52, 'Civil Engineering'), (s52, 'Renewable Energy'), (s52, 'Environmental Science'),
  (s53, 'Technology Consulting'), (s53, 'Management Consulting'), (s53, 'Software Engineering'), (s53, 'Cloud Computing'),
  (s54, 'Public Policy'), (s54, 'Government Affairs'), (s54, 'Regulatory Compliance'), (s54, 'Social Impact'),
  (s55, 'Blockchain'), (s55, 'Software Engineering'), (s55, 'Cybersecurity'), (s55, 'Data Science'),
  (s56, 'Brand Management'), (s56, 'Marketing Strategy'), (s56, 'Content Creation'), (s56, 'E-Commerce'),
  (s57, 'Real Estate Development'), (s57, 'Commercial Real Estate'), (s57, 'Business Development'), (s57, 'Corporate Finance'),
  (s58, 'Environmental Science'), (s58, 'Renewable Energy'), (s58, 'Civil Engineering'), (s58, 'Public Policy'),
  (s59, 'Corporate Finance'), (s59, 'Investment Banking'), (s59, 'Financial Planning'), (s59, 'Quantitative Finance'),
  (s60, 'Content Creation'), (s60, 'Graphic Design'), (s60, 'Film & Video Production'), (s60, 'Marketing Strategy'),
  (s61, 'Software Engineering'), (s61, 'Cloud Computing'), (s61, 'Mobile Development'), (s61, 'Data Science'),
  (s62, 'Health Informatics'), (s62, 'Healthcare Administration'), (s62, 'Data Science'), (s62, 'Public Health'),
  (s63, 'Management Consulting'), (s63, 'Strategy Consulting'), (s63, 'Business Development'), (s63, 'Operations Consulting'),
  (s64, 'Higher Education'), (s64, 'Non-Profit Management'), (s64, 'Social Impact'), (s64, 'Public Policy'),
  (s65, 'Civil Engineering'), (s65, 'Mechanical Engineering'), (s65, 'Environmental Science'), (s65, 'Renewable Energy'),
  (g16, 'Product Management'), (g16, 'Software Engineering'), (g16, 'UX Design'), (g16, 'Business Development'),
  (g17, 'Investment Banking'), (g17, 'Corporate Finance'), (g17, 'Private Equity'), (g17, 'Quantitative Finance'),
  (g18, 'Healthcare Administration'), (g18, 'Public Health'), (g18, 'Health Informatics'), (g18, 'Pharmaceuticals'),
  (g19, 'Machine Learning'), (g19, 'Data Science'), (g19, 'Software Engineering'), (g19, 'Cloud Computing'),
  (g20, 'Strategy Consulting'), (g20, 'Management Consulting'), (g20, 'Business Development'), (g20, 'Operations Consulting'),
  (g21, 'Private Equity'), (g21, 'Investment Banking'), (g21, 'Venture Capital'), (g21, 'Corporate Finance'),
  (g22, 'Biotech Research'), (g22, 'Pharmaceuticals'), (g22, 'Healthcare Administration'), (g22, 'Public Health'),
  (g23, 'Software Engineering'), (g23, 'Cloud Computing'), (g23, 'Mobile Development'), (g23, 'DevOps'),
  (g24, 'Brand Management'), (g24, 'Marketing Strategy'), (g24, 'Content Creation'), (g24, 'E-Commerce'),
  (g25, 'Mechanical Engineering'), (g25, 'Civil Engineering'), (g25, 'Renewable Energy'), (g25, 'Environmental Science'),
  (g26, 'Corporate Law'), (g26, 'Intellectual Property'), (g26, 'Regulatory Compliance'), (g26, 'Public Policy'),
  (g27, 'Venture Capital'), (g27, 'Private Equity'), (g27, 'Investment Banking'), (g27, 'Entrepreneurship'),
  (g28, 'Public Health'), (g28, 'Healthcare Administration'), (g28, 'Health Informatics'), (g28, 'Social Impact'),
  (g29, 'Operations Consulting'), (g29, 'Management Consulting'), (g29, 'Supply Chain Management'), (g29, 'Business Development'),
  (g30, 'Content Creation'), (g30, 'Journalism'), (g30, 'Film & Video Production'), (g30, 'Marketing Strategy'),
  (g31, 'Cloud Computing'), (g31, 'Software Engineering'), (g31, 'DevOps'), (g31, 'Cybersecurity'),
  (g32, 'Wealth Management'), (g32, 'Financial Planning'), (g32, 'Investment Banking'), (g32, 'Private Equity'),
  (g33, 'Cybersecurity'), (g33, 'Software Engineering'), (g33, 'Cloud Computing'), (g33, 'Data Science'),
  (g34, 'Civil Engineering'), (g34, 'Mechanical Engineering'), (g34, 'Environmental Science'), (g34, 'Renewable Energy'),
  (g35, 'Intellectual Property'), (g35, 'Corporate Law'), (g35, 'Regulatory Compliance'), (g35, 'Public Policy'),
  (g36, 'Entrepreneurship'), (g36, 'Business Development'), (g36, 'Marketing Strategy'), (g36, 'E-Commerce'),
  (g37, 'Pharmaceuticals'), (g37, 'Biotech Research'), (g37, 'Healthcare Administration'), (g37, 'Health Informatics'),
  (g38, 'Quantitative Finance'), (g38, 'Investment Banking'), (g38, 'Data Science'), (g38, 'Machine Learning'),
  (g39, 'Data Science'), (g39, 'Machine Learning'), (g39, 'Software Engineering'), (g39, 'Cloud Computing'),
  (g40, 'Management Consulting'), (g40, 'Strategy Consulting'), (g40, 'Operations Consulting'), (g40, 'Business Development'),
  (g41, 'E-Commerce'), (g41, 'Marketing Strategy'), (g41, 'Brand Management'), (g41, 'Business Development'),
  (g42, 'Government Affairs'), (g42, 'Defense & Aerospace'), (g42, 'Public Policy'), (g42, 'Regulatory Compliance'),
  (g43, 'Higher Education'), (g43, 'Non-Profit Management'), (g43, 'Social Impact'), (g43, 'Public Policy'),
  (g44, 'Corporate Finance'), (g44, 'Investment Banking'), (g44, 'Financial Planning'), (g44, 'Quantitative Finance'),
  (g45, 'Healthcare Administration'), (g45, 'Public Health'), (g45, 'Health Informatics'), (g45, 'Pharmaceuticals'),
  (g46, 'Machine Learning'), (g46, 'Data Science'), (g46, 'Software Engineering'), (g46, 'Cloud Computing'),
  (g47, 'Sales Strategy'), (g47, 'Business Development'), (g47, 'Marketing Strategy'), (g47, 'E-Commerce'),
  (g48, 'Renewable Energy'), (g48, 'Environmental Science'), (g48, 'Mechanical Engineering'), (g48, 'Civil Engineering'),
  (g49, 'Regulatory Compliance'), (g49, 'Corporate Law'), (g49, 'Public Policy'), (g49, 'Intellectual Property'),
  (g50, 'Real Estate Development'), (g50, 'Commercial Real Estate'), (g50, 'Business Development'), (g50, 'Corporate Finance'),
  (g51, 'UX Design'), (g51, 'Product Management'), (g51, 'Software Engineering'), (g51, 'Mobile Development'),
  (g52, 'Environmental Science'), (g52, 'Renewable Energy'), (g52, 'Civil Engineering'), (g52, 'Mechanical Engineering'),
  (g53, 'Strategy Consulting'), (g53, 'Management Consulting'), (g53, 'Business Development'), (g53, 'Operations Consulting'),
  (g54, 'Film & Video Production'), (g54, 'Content Creation'), (g54, 'Journalism'), (g54, 'Marketing Strategy'),
  (g55, 'DevOps'), (g55, 'Cloud Computing'), (g55, 'Software Engineering'), (g55, 'Cybersecurity'),
  (g56, 'Private Equity'), (g56, 'Investment Banking'), (g56, 'Venture Capital'), (g56, 'Corporate Finance'),
  (g57, 'Mechanical Engineering'), (g57, 'Civil Engineering'), (g57, 'Renewable Energy'), (g57, 'Environmental Science'),
  (g58, 'Biotech Research'), (g58, 'Pharmaceuticals'), (g58, 'Healthcare Administration'), (g58, 'Public Health'),
  (g59, 'Supply Chain Management'), (g59, 'Operations Consulting'), (g59, 'Business Development'), (g59, 'E-Commerce'),
  (g60, 'Public Policy'), (g60, 'Government Affairs'), (g60, 'Regulatory Compliance'), (g60, 'Social Impact'),
  (g61, 'Blockchain'), (g61, 'Software Engineering'), (g61, 'Cybersecurity'), (g61, 'Data Science'),
  (g62, 'Public Health'), (g62, 'Healthcare Administration'), (g62, 'Health Informatics'), (g62, 'Social Impact'),
  (g63, 'Technology Consulting'), (g63, 'Management Consulting'), (g63, 'Software Engineering'), (g63, 'Cloud Computing'),
  (g64, 'Social Impact'), (g64, 'Non-Profit Management'), (g64, 'Higher Education'), (g64, 'Public Policy'),
  (g65, 'Investment Banking'), (g65, 'Corporate Finance'), (g65, 'Private Equity'), (g65, 'Quantitative Finance'),
  (b01, 'Product Management'), (b01, 'Software Engineering'), (b01, 'Venture Capital'), (b01, 'Entrepreneurship'),
  (b02, 'Investment Banking'), (b02, 'Corporate Finance'), (b02, 'Software Engineering'), (b02, 'Entrepreneurship'),
  (b03, 'Strategy Consulting'), (b03, 'Management Consulting'), (b03, 'Product Management'), (b03, 'Software Engineering'),
  (b04, 'Mechanical Engineering'), (b04, 'Civil Engineering'), (b04, 'Corporate Finance'), (b04, 'Investment Banking'),
  (b05, 'Healthcare Administration'), (b05, 'Public Health'), (b05, 'Biotech Research'), (b05, 'Entrepreneurship'),
  (b06, 'Corporate Law'), (b06, 'Intellectual Property'), (b06, 'Software Engineering'), (b06, 'Entrepreneurship'),
  (b07, 'UX Design'), (b07, 'Product Management'), (b07, 'Software Engineering'), (b07, 'Entrepreneurship'),
  (b08, 'Government Affairs'), (b08, 'Public Policy'), (b08, 'Management Consulting'), (b08, 'Strategy Consulting'),
  (b09, 'Marketing Strategy'), (b09, 'Brand Management'), (b09, 'Product Management'), (b09, 'Software Engineering'),
  (b10, 'Software Engineering'), (b10, 'Cloud Computing'), (b10, 'Venture Capital'), (b10, 'Entrepreneurship'),
  (b11, 'Content Creation'), (b11, 'Journalism'), (b11, 'Product Management'), (b11, 'Software Engineering'),
  (b12, 'Data Science'), (b12, 'Machine Learning'), (b12, 'Healthcare Administration'), (b12, 'Health Informatics'),
  (b13, 'Higher Education'), (b13, 'Non-Profit Management'), (b13, 'Software Engineering'), (b13, 'Product Management'),
  (b14, 'Private Equity'), (b14, 'Investment Banking'), (b14, 'Real Estate Development'), (b14, 'Commercial Real Estate'),
  (b15, 'Biotech Research'), (b15, 'Pharmaceuticals'), (b15, 'Strategy Consulting'), (b15, 'Management Consulting'),
  (b16, 'Management Consulting'), (b16, 'Strategy Consulting'), (b16, 'Entrepreneurship'), (b16, 'Business Development'),
  (b17, 'Mechanical Engineering'), (b17, 'Civil Engineering'), (b17, 'Environmental Science'), (b17, 'Renewable Energy'),
  (b18, 'Corporate Finance'), (b18, 'Investment Banking'), (b18, 'Public Policy'), (b18, 'Government Affairs'),
  (b19, 'Healthcare Administration'), (b19, 'Public Health'), (b19, 'Public Policy'), (b19, 'Regulatory Compliance'),
  (b20, 'DevOps'), (b20, 'Cloud Computing'), (b20, 'Software Engineering'), (b20, 'Mechanical Engineering'),
  (b21, 'Marketing Strategy'), (b21, 'Brand Management'), (b21, 'UX Design'), (b21, 'Product Management'),
  (b22, 'Renewable Energy'), (b22, 'Environmental Science'), (b22, 'Venture Capital'), (b22, 'Entrepreneurship'),
  (b23, 'Cybersecurity'), (b23, 'Software Engineering'), (b23, 'Defense & Aerospace'), (b23, 'Government Affairs'),
  (b24, 'Business Development'), (b24, 'Marketing Strategy'), (b24, 'Social Impact'), (b24, 'Non-Profit Management'),
  (b25, 'Healthcare Administration'), (b25, 'Public Health'), (b25, 'Entrepreneurship'), (b25, 'Business Development'),
  (b26, 'Corporate Finance'), (b26, 'Investment Banking'), (b26, 'Real Estate Development'), (b26, 'Commercial Real Estate'),
  (b27, 'Higher Education'), (b27, 'Social Impact'), (b27, 'Non-Profit Management'), (b27, 'Public Policy'),
  (b28, 'Mechanical Engineering'), (b28, 'Civil Engineering'), (b28, 'Software Engineering'), (b28, 'Machine Learning'),
  (b29, 'Corporate Law'), (b29, 'Regulatory Compliance'), (b29, 'Government Affairs'), (b29, 'Public Policy'),
  (b30, 'Content Creation'), (b30, 'Film & Video Production'), (b30, 'Product Management'), (b30, 'Software Engineering')
) AS v(uid, interest_name)
JOIN public.interests i ON i.name = v.interest_name
ON CONFLICT (user_id, interest_id) DO NOTHING;

END $$;