-- =============================================================================
-- Beacon MVP: Fix Missing Profile Content
-- Run in Supabase SQL Editor AFTER all seed scripts
-- Updates 50 seeker profiles (s16-s65) with bio, location_city, location_state
-- =============================================================================
--
-- CONTEXT: The expanded seed script creates auth.users for s16-s65, which
-- triggers auto-creation of minimal profiles (id, email, full_name only).
-- However, unlike givers (g16-g65) and both (b01-b30), the seeker profiles
-- were never populated with bio and location data. This script fixes that.
-- =============================================================================

BEGIN;

-- s16: Olivia Tran — UC Berkeley, CS, wants PM at Google/Meta/Apple
UPDATE public.profiles SET
  bio = 'Senior at UC Berkeley studying Computer Science with a focus on human-computer interaction. Built a productivity app that reached 10K users during a class project. Looking to transition into product management at a top tech company.',
  location_city = 'Berkeley',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000016';

-- s17: James Adebayo — Columbia, Economics, wants IB at GS/MS/JPM
UPDATE public.profiles SET
  bio = 'Columbia University senior studying Economics with a concentration in financial markets. Active member of the Columbia Investment Banking Society and completed a spring insight week at a bulge bracket firm. Eager to break into investment banking.',
  location_city = 'New York',
  location_state = 'NY'
WHERE id = 'a0000002-0000-0000-0000-000000000017';

-- s18: Catalina Reyes — UT Austin, Business Admin, wants consulting at MBB
UPDATE public.profiles SET
  bio = 'UT Austin senior in Business Administration with a minor in Data Analytics. Led a consulting project for a local nonprofit through our campus consulting club. Passionate about strategy consulting and helping organizations solve complex problems.',
  location_city = 'Austin',
  location_state = 'TX'
WHERE id = 'a0000002-0000-0000-0000-000000000018';

-- s19: Wei Lin — MIT, Math + CS, wants quant research at Citadel/Two Sigma/Jane Street
UPDATE public.profiles SET
  bio = 'MIT senior double-majoring in Mathematics and Computer Science. Placed in the top 10% at the Putnam Competition and built algorithmic trading models for our quantitative finance club. Seeking a quantitative research role at a top hedge fund.',
  location_city = 'Cambridge',
  location_state = 'MA'
WHERE id = 'a0000002-0000-0000-0000-000000000019';

-- s20: Destiny Williams — Spelman, Biology, exploring healthcare consulting
UPDATE public.profiles SET
  bio = 'Spelman College senior majoring in Biology with a pre-health focus. First-generation college student passionate about healthcare equity and access. Exploring healthcare consulting as a way to drive systemic change before potentially pursuing medical school.',
  location_city = 'Atlanta',
  location_state = 'GA'
WHERE id = 'a0000002-0000-0000-0000-000000000020';

-- s21: Patrick O'Brien — Northwestern, Finance, wants PE at Blackstone/KKR/Apollo
UPDATE public.profiles SET
  bio = 'Northwestern senior studying Finance with a focus on private markets and ESG investing. Completed a summer analyst program at a middle-market bank and interned with a family office. Looking to break into private equity.',
  location_city = 'Evanston',
  location_state = 'IL'
WHERE id = 'a0000002-0000-0000-0000-000000000021';

-- s22: Fatima Al-Rashid — UW, Computer Engineering, wants SWE at Amazon/Microsoft/Google
UPDATE public.profiles SET
  bio = 'University of Washington senior in Computer Engineering with hands-on experience in full-stack development and cloud computing. Contributed to open-source projects and completed two software engineering internships. Ready to launch my career at a major tech company.',
  location_city = 'Seattle',
  location_state = 'WA'
WHERE id = 'a0000002-0000-0000-0000-000000000022';

-- s23: Kofi Mensah — Howard, Political Science, wants policy analyst role
UPDATE public.profiles SET
  bio = 'Howard University senior studying Political Science with a focus on domestic policy and governance. First-generation college student who interned on Capitol Hill and organized voter registration drives. Want to build a career in government consulting and public policy.',
  location_city = 'Washington',
  location_state = 'DC'
WHERE id = 'a0000002-0000-0000-0000-000000000023';

-- s24: Isabella Costa — Florida State, Marketing, wants brand manager role at tech co
UPDATE public.profiles SET
  bio = 'Florida State junior studying Marketing with a minor in Digital Media. Led social media campaigns for campus organizations that doubled engagement. Looking to pivot my CPG marketing experience into a brand management role at a consumer tech company.',
  location_city = 'Tallahassee',
  location_state = 'FL'
WHERE id = 'a0000002-0000-0000-0000-000000000024';

-- s25: Yuki Tanaka — USC, Film Studies + CS, wants PM at Netflix/Spotify/Disney
UPDATE public.profiles SET
  bio = 'USC senior double-majoring in Film Studies and Computer Science. Developed a short film recommendation engine as a capstone project and interned at a streaming startup. Want to combine my passion for storytelling and technology as a product manager in media.',
  location_city = 'Los Angeles',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000025';

-- s26: Andre Baptiste — Duke, Biomedical Engineering, wants medical device role
UPDATE public.profiles SET
  bio = 'Duke University senior in Biomedical Engineering with research experience in cardiovascular device design. Completed a co-op at a medical device startup working on next-gen stent technology. Seeking a full-time role in medical device product development.',
  location_city = 'Durham',
  location_state = 'NC'
WHERE id = 'a0000002-0000-0000-0000-000000000026';

-- s27: Hannah Schwartz — UPenn, Economics, wants MBB consulting
UPDATE public.profiles SET
  bio = 'Recent Penn grad with a degree in Economics from the Wharton School. President of the Penn Consulting Group and led pro bono projects for Philadelphia nonprofits. Looking to land an MBB offer and build a career in strategy consulting.',
  location_city = 'Philadelphia',
  location_state = 'PA'
WHERE id = 'a0000002-0000-0000-0000-000000000027';

-- s28: Ravi Krishnan — Stanford, CS, deciding startup vs big tech
UPDATE public.profiles SET
  bio = 'Stanford senior in Computer Science with deep experience in systems programming and distributed computing. Built a real-time collaboration tool used by 500+ students on campus. Weighing opportunities between joining an early-stage AI startup and a major tech company.',
  location_city = 'Stanford',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000028';

-- s29: Camille Dupont — Reed College, Environmental Science, wants sustainability consulting
UPDATE public.profiles SET
  bio = 'Reed College senior studying Environmental Science with a thesis on urban carbon offset programs. Volunteered with local conservation groups and completed an internship at an environmental policy nonprofit. Passionate about climate strategy consulting.',
  location_city = 'Portland',
  location_state = 'OR'
WHERE id = 'a0000002-0000-0000-0000-000000000029';

-- s30: Elijah Carter — UMich, Mechanical Engineering, wants EV engineer role
UPDATE public.profiles SET
  bio = 'University of Michigan senior in Mechanical Engineering with a specialization in vehicle dynamics and powertrain systems. Led our Formula SAE Electric team and interned at an automotive OEM. Looking to work on next-generation electric vehicle technology.',
  location_city = 'Ann Arbor',
  location_state = 'MI'
WHERE id = 'a0000002-0000-0000-0000-000000000030';

-- s31: Mei-Ling Wu — Harvard, Applied Mathematics, wants MBB consulting
UPDATE public.profiles SET
  bio = 'Harvard senior studying Applied Mathematics with coursework in optimization and decision science. First-generation college student who founded a peer tutoring network serving 200+ students. Want to bring analytical rigor to strategy consulting at a top firm.',
  location_city = 'Cambridge',
  location_state = 'MA'
WHERE id = 'a0000002-0000-0000-0000-000000000031';

-- s32: Samuel Osei — Rice, Finance, wants IB analyst in energy group
UPDATE public.profiles SET
  bio = 'Rice University senior studying Finance with a focus on energy markets and valuation. Completed a summer analyst program at a Houston-based energy investment bank. Seeking a full-time IBD role in an energy and power group.',
  location_city = 'Houston',
  location_state = 'TX'
WHERE id = 'a0000002-0000-0000-0000-000000000032';

-- s33: Ava Petrov — UC San Diego, Cognitive Science, wants UX researcher role
UPDATE public.profiles SET
  bio = 'UCSD junior studying Cognitive Science with a specialization in design and interaction. Conducted user research for three campus apps and built a portfolio of UX case studies. Looking to transition into industry UX research at a major tech company.',
  location_city = 'San Diego',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000033';

-- s34: Carlos Mendoza — ASU, CS, wants security engineer at Google/Meta/Cloudflare
UPDATE public.profiles SET
  bio = 'Arizona State senior in Computer Science with a concentration in cybersecurity. Won our university CTF competition and completed a security internship at a cloud services provider. Looking to build a career in security engineering at a major tech company.',
  location_city = 'Tempe',
  location_state = 'AZ'
WHERE id = 'a0000002-0000-0000-0000-000000000034';

-- s35: Grace Nakamura — UW, Business Admin, wants strategy consulting at Deloitte/PwC/EY
UPDATE public.profiles SET
  bio = 'University of Washington senior in Business Administration with a focus on corporate strategy. Led case competition teams to regional finals and interned at a Big Four advisory practice. Interested in corporate strategy consulting with a long-term move to in-house strategy.',
  location_city = 'Seattle',
  location_state = 'WA'
WHERE id = 'a0000002-0000-0000-0000-000000000035';

-- s36: Jamal Robinson — UC Berkeley, Data Science, wants data science for edtech
UPDATE public.profiles SET
  bio = 'UC Berkeley senior in Data Science passionate about using analytics for social impact. Built a machine learning model predicting student dropout risk for a local school district. Want to apply data science to education technology and improve learning outcomes.',
  location_city = 'Berkeley',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000036';

-- s37: Sana Malik — UMich, Industrial Engineering, wants product ops at startup
UPDATE public.profiles SET
  bio = 'University of Michigan senior in Industrial Engineering with experience in process optimization and operations research. Interned at a logistics startup where I improved warehouse throughput by 15%. Looking to break into product operations at a high-growth tech company.',
  location_city = 'Ann Arbor',
  location_state = 'MI'
WHERE id = 'a0000002-0000-0000-0000-000000000037';

-- s38: Luca Romano — NYU, Finance + CS, wants fintech engineering at Stripe/Coinbase/Robinhood
UPDATE public.profiles SET
  bio = 'NYU senior double-majoring in Finance and Computer Science at Stern and CAS. Built a decentralized finance prototype for a blockchain hackathon and interned at a payments startup. Passionate about cryptocurrency and financial infrastructure technology.',
  location_city = 'New York',
  location_state = 'NY'
WHERE id = 'a0000002-0000-0000-0000-000000000038';

-- s39: Nadia Volkov — UNC Chapel Hill, Statistics, wants pharma data science
UPDATE public.profiles SET
  bio = 'UNC Chapel Hill senior studying Statistics with a focus on biostatistics and clinical trial design. Completed a summer research fellowship at a pharmaceutical company analyzing drug efficacy data. Looking to apply statistical modeling to pharmaceutical research.',
  location_city = 'Chapel Hill',
  location_state = 'NC'
WHERE id = 'a0000002-0000-0000-0000-000000000039';

-- s40: Darnell Washington — Morehouse, Business Admin, wants VC analyst role
UPDATE public.profiles SET
  bio = 'Morehouse College senior studying Business Administration with a passion for entrepreneurship and venture investing. First-generation college student who launched a campus startup and placed in national pitch competitions. Want to break into venture capital.',
  location_city = 'Atlanta',
  location_state = 'GA'
WHERE id = 'a0000002-0000-0000-0000-000000000040';

-- s41: Ximena Flores — UCLA, Economics, wants impact investing
UPDATE public.profiles SET
  bio = 'UCLA senior studying Economics with a focus on development economics and microfinance. Volunteered with a microfinance organization in Latin America and researched impact measurement frameworks. Seeking a role in impact investing focused on emerging markets.',
  location_city = 'Los Angeles',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000041';

-- s42: Brendan Kelly — Boston University, CS, wants technical sales at Salesforce/Microsoft/Oracle
UPDATE public.profiles SET
  bio = 'Boston University junior in Computer Science with strong communication skills and a knack for explaining technical concepts. Worked as a campus IT consultant and interned at an enterprise software company. Interested in transitioning from engineering to technical sales.',
  location_city = 'Boston',
  location_state = 'MA'
WHERE id = 'a0000002-0000-0000-0000-000000000042';

-- s43: Aisling Brennan — Vanderbilt, Marketing, wants music industry marketing
UPDATE public.profiles SET
  bio = 'Vanderbilt senior studying Marketing with a minor in Music Industry. Managed social media campaigns for independent artists and organized campus concerts. Looking to break into marketing at a major record label and combine my love of music with strategic marketing.',
  location_city = 'Nashville',
  location_state = 'TN'
WHERE id = 'a0000002-0000-0000-0000-000000000043';

-- s44: Omar Diallo — University of Minnesota, Electrical Engineering, wants chip design at Intel/NVIDIA/AMD
UPDATE public.profiles SET
  bio = 'University of Minnesota senior in Electrical Engineering with research experience in VLSI design and semiconductor physics. Completed a co-op at a chip fabrication facility and presented research at IEEE. Want to work on cutting-edge chip design and semiconductor technology.',
  location_city = 'Minneapolis',
  location_state = 'MN'
WHERE id = 'a0000002-0000-0000-0000-000000000044';

-- s45: Leah Goldberg — Brown, Public Health, exploring healthcare administration
UPDATE public.profiles SET
  bio = 'Brown University senior studying Public Health with a focus on health systems management. Interned at a community health center and conducted research on health equity initiatives. Exploring healthcare administration as a way to improve patient outcomes at scale.',
  location_city = 'Providence',
  location_state = 'RI'
WHERE id = 'a0000002-0000-0000-0000-000000000045';

-- s46: Tenzin Dorje — University of Colorado, Environmental Engineering, wants clean tech
UPDATE public.profiles SET
  bio = 'University of Colorado senior in Environmental Engineering passionate about renewable energy and climate solutions. Designed a solar microgrid for an off-grid community as a capstone project. Looking to work on clean energy technology and sustainability infrastructure.',
  location_city = 'Boulder',
  location_state = 'CO'
WHERE id = 'a0000002-0000-0000-0000-000000000046';

-- s47: Aaliyah Jackson — University of Chicago, Psychology, wants HR tech consulting
UPDATE public.profiles SET
  bio = 'University of Chicago senior studying Psychology with a focus on organizational behavior and people analytics. Led a research project on employee motivation and completed a summer internship at an HR tech startup. Looking to work in people analytics and organizational development.',
  location_city = 'Chicago',
  location_state = 'IL'
WHERE id = 'a0000002-0000-0000-0000-000000000047';

-- s48: Pavel Novak — Carnegie Mellon, Robotics Engineering, wants robotics at Tesla/Boston Dynamics/Waymo
UPDATE public.profiles SET
  bio = 'Carnegie Mellon senior in Robotics Engineering with hands-on experience in perception systems and motion planning. Built an autonomous drone for our senior design project and interned at a robotics R&D lab. Seeking a role in autonomous systems at a leading robotics company.',
  location_city = 'Pittsburgh',
  location_state = 'PA'
WHERE id = 'a0000002-0000-0000-0000-000000000048';

-- s49: Mireya Santos — UT Austin, Communications, wants corporate comms at tech co
UPDATE public.profiles SET
  bio = 'UT Austin junior studying Communications with a minor in Business. Managed PR campaigns for campus organizations and freelanced for a digital marketing agency. Interested in transitioning into corporate communications and public relations at a major tech company.',
  location_city = 'Austin',
  location_state = 'TX'
WHERE id = 'a0000002-0000-0000-0000-000000000049';

-- s50: Devon Marshall — UNC Chapel Hill, Finance, wants real estate PE
UPDATE public.profiles SET
  bio = 'UNC Chapel Hill senior studying Finance with a concentration in real estate. Completed a summer analyst program at a commercial real estate firm and built financial models for multifamily property acquisitions. Looking to break into real estate private equity.',
  location_city = 'Chapel Hill',
  location_state = 'NC'
WHERE id = 'a0000002-0000-0000-0000-000000000050';

-- s51: Shreya Iyer — Georgia Tech, CS, wants ML engineer at OpenAI/Anthropic/DeepMind
UPDATE public.profiles SET
  bio = 'Georgia Tech senior in Computer Science specializing in machine learning and natural language processing. Published a paper on transformer architectures and contributed to open-source ML frameworks. Passionate about working on frontier AI research at a leading AI lab.',
  location_city = 'Atlanta',
  location_state = 'GA'
WHERE id = 'a0000002-0000-0000-0000-000000000051';

-- s52: Tobias Engström — University of Wisconsin, Biochemistry, wants pharma R&D
UPDATE public.profiles SET
  bio = 'University of Wisconsin senior studying Biochemistry with two years of lab research in protein engineering. Completed a summer fellowship at a pharmaceutical company working on antibody drug conjugates. Seeking a research scientist role in drug discovery and development.',
  location_city = 'Madison',
  location_state = 'WI'
WHERE id = 'a0000002-0000-0000-0000-000000000052';

-- s53: Chidera Eze — Ohio State, Information Systems, wants IT consulting
UPDATE public.profiles SET
  bio = 'Ohio State senior studying Information Systems with certifications in AWS and cloud architecture. Led a student IT consulting team that built a CRM system for a local business. Looking to work in technology consulting specializing in cloud transformation.',
  location_city = 'Columbus',
  location_state = 'OH'
WHERE id = 'a0000002-0000-0000-0000-000000000053';

-- s54: Rosa Martinez — University of Denver, Journalism + Business, wants digital media content
UPDATE public.profiles SET
  bio = 'University of Denver senior double-majoring in Journalism and Business. First-generation college student who launched a campus digital publication reaching 5K monthly readers. Want to work in digital media creating compelling content at scale.',
  location_city = 'Denver',
  location_state = 'CO'
WHERE id = 'a0000002-0000-0000-0000-000000000054';

-- s55: Kai Nakamura — Stanford, Electrical Engineering, wants power systems engineering
UPDATE public.profiles SET
  bio = 'Recent Stanford grad with a degree in Electrical Engineering and a focus on power systems and energy storage. Completed research on grid-scale battery optimization and interned at a renewable energy company. Passionate about clean energy infrastructure and grid modernization.',
  location_city = 'Palo Alto',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000055';

-- s56: Jasmine Lee — UC Irvine, Business Analytics, wants product analyst at Meta/Google/Amazon
UPDATE public.profiles SET
  bio = 'UC Irvine junior studying Business Analytics with strong skills in SQL, Python, and data visualization. Completed a data analytics internship at an e-commerce company where I built dashboards tracking user behavior. Want to work in product analytics at a consumer tech company.',
  location_city = 'Irvine',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000056';

-- s57: Alejandro Vega — SMU, Accounting + Finance, wants FP&A at tech co
UPDATE public.profiles SET
  bio = 'SMU senior double-majoring in Accounting and Finance. Interned at a Big Four firm in audit and discovered a passion for financial planning and analysis. Looking to work in corporate finance at a major technology company.',
  location_city = 'Dallas',
  location_state = 'TX'
WHERE id = 'a0000002-0000-0000-0000-000000000057';

-- s58: Ingrid Larsen — Bowdoin, Marine Biology, wants ocean conservation
UPDATE public.profiles SET
  bio = 'Bowdoin College senior studying Marine Biology with fieldwork experience in coastal ecosystem research. Spent a semester studying coral reef conservation in Belize and interned at a marine policy nonprofit. Passionate about ocean conservation and marine ecosystem protection.',
  location_city = 'Brunswick',
  location_state = 'ME'
WHERE id = 'a0000002-0000-0000-0000-000000000058';

-- s59: Kwame Asante — Tulane, Civil Engineering, wants infrastructure consulting
UPDATE public.profiles SET
  bio = 'Tulane University senior in Civil Engineering with experience in structural analysis and transportation planning. Completed a co-op with an engineering firm working on urban infrastructure projects in New Orleans. Looking to work on large-scale infrastructure development.',
  location_city = 'New Orleans',
  location_state = 'LA'
WHERE id = 'a0000002-0000-0000-0000-000000000059';

-- s60: Sienna Walsh — University of Utah, Marketing, wants growth marketing at startup
UPDATE public.profiles SET
  bio = 'University of Utah senior studying Marketing with a focus on digital growth strategies. Ran paid acquisition campaigns for a D2C startup that grew monthly revenue by 40%. Looking to work in growth marketing at a consumer tech startup and scale user acquisition.',
  location_city = 'Salt Lake City',
  location_state = 'UT'
WHERE id = 'a0000002-0000-0000-0000-000000000060';

-- s61: Haruki Sato — UC Berkeley, Physics + CS, wants quantum computing
UPDATE public.profiles SET
  bio = 'UC Berkeley senior double-majoring in Physics and Computer Science with research in quantum error correction. Published work on topological qubits and interned at a quantum computing startup. Seeking a role in quantum computing hardware or algorithm development.',
  location_city = 'Berkeley',
  location_state = 'CA'
WHERE id = 'a0000002-0000-0000-0000-000000000061';

-- s62: Zara Ahmed — NC State, Bioengineering, wants regulatory affairs at medical device co
UPDATE public.profiles SET
  bio = 'NC State senior studying Bioengineering with a focus on medical device regulation and quality systems. Interned at a medical device company in their regulatory affairs department and learned FDA submission processes. Want to build a career in medical device regulatory affairs.',
  location_city = 'Raleigh',
  location_state = 'NC'
WHERE id = 'a0000002-0000-0000-0000-000000000062';

-- s63: Declan Fitzgerald — Purdue, Supply Chain Management, wants e-commerce ops
UPDATE public.profiles SET
  bio = 'Purdue senior studying Supply Chain Management with internship experience in logistics optimization and warehouse operations. Built a supply chain simulation model that reduced shipping costs in a case competition. Looking to work in e-commerce operations at a major retailer.',
  location_city = 'West Lafayette',
  location_state = 'IN'
WHERE id = 'a0000002-0000-0000-0000-000000000063';

-- s64: Priscilla Okonkwo — UVA, Economics, wants international development at World Bank/IMF/USAID
UPDATE public.profiles SET
  bio = 'University of Virginia senior studying Economics with a focus on development economics and international policy. First-generation college student who interned at a global development organization in East Africa. Want to work on economic empowerment programs at an international institution.',
  location_city = 'Charlottesville',
  location_state = 'VA'
WHERE id = 'a0000002-0000-0000-0000-000000000064';

-- s65: Mateo Rivera — University of Arizona, Aerospace Engineering, wants SpaceX/Blue Origin/Boeing
UPDATE public.profiles SET
  bio = 'University of Arizona senior in Aerospace Engineering with research experience in spacecraft propulsion and orbital mechanics. Led our rocketry club to a national competition podium finish and interned at a defense aerospace contractor. Dreaming of working on space exploration technology.',
  location_city = 'Tucson',
  location_state = 'AZ'
WHERE id = 'a0000002-0000-0000-0000-000000000065';

-- =============================================================================
-- VERIFICATION: Run after the updates to confirm all profiles are populated
-- =============================================================================
-- SELECT count(*) AS total_profiles FROM public.profiles;
-- SELECT count(*) AS profiles_with_bio FROM public.profiles WHERE bio IS NOT NULL AND bio != '';
-- SELECT count(*) AS profiles_with_city FROM public.profiles WHERE location_city IS NOT NULL AND location_city != '';
-- SELECT count(*) AS profiles_missing_bio FROM public.profiles WHERE bio IS NULL OR bio = '';

COMMIT;
