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
