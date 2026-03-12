const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

const supabase = createClient(supabaseUrl, serviceRoleKey);

async function runVerificationQueries() {
    console.log('🔍 BEACON PROFILE VERIFICATION STARTING...');
    console.log('================================================');
    
    try {
        // Query 1: Profile Count & Completeness
        console.log('\n1. PROFILE COUNT & COMPLETENESS:');
        
        const totalProfilesResult = await supabase
            .from('profiles')
            .select('*', { count: 'exact', head: true })
            .like('email', '%@test.com');
            
        console.log(`Total test profiles: ${totalProfilesResult.count}`);
        
        const completeBiosResult = await supabase
            .from('profiles')
            .select('*', { count: 'exact', head: true })
            .like('email', '%@test.com')
            .not('bio', 'is', null)
            .neq('bio', '');
            
        console.log(`Profiles with complete bios: ${completeBiosResult.count}`);
        
        const completeCitiesResult = await supabase
            .from('profiles')
            .select('*', { count: 'exact', head: true })
            .like('email', '%@test.com')
            .not('location_city', 'is', null)
            .neq('location_city', '');
            
        console.log(`Profiles with complete cities: ${completeCitiesResult.count}`);
        
        const completeStatesResult = await supabase
            .from('profiles')
            .select('*', { count: 'exact', head: true })
            .like('email', '%@test.com')
            .not('location_state', 'is', null)
            .neq('location_state', '');
            
        console.log(`Profiles with complete states: ${completeStatesResult.count}`);
        
        // Query 2: Bio Quality Sample
        console.log('\n2. BIO QUALITY SAMPLE:');
        
        const bioSampleResult = await supabase
            .from('profiles')
            .select('full_name, is_seeker, is_giver, bio')
            .like('email', '%@test.com')
            .limit(5);
            
        if (bioSampleResult.data) {
            bioSampleResult.data.forEach((profile, idx) => {
                console.log(`\nSample ${idx + 1}:`);
                console.log(`  Name: ${profile.full_name}`);
                console.log(`  Seeker: ${profile.is_seeker}, Giver: ${profile.is_giver}`);
                console.log(`  Bio: ${profile.bio ? profile.bio.substring(0, 100) + '...' : 'NULL'}`);
            });
        }
        
        // Query 3: Role Distribution
        console.log('\n3. ROLE DISTRIBUTION:');
        
        const allProfilesResult = await supabase
            .from('profiles')
            .select('is_seeker, is_giver')
            .like('email', '%@test.com');
            
        if (allProfilesResult.data) {
            const seekersOnly = allProfilesResult.data.filter(p => p.is_seeker === true && p.is_giver === false).length;
            const giversOnly = allProfilesResult.data.filter(p => p.is_seeker === false && p.is_giver === true).length;
            const both = allProfilesResult.data.filter(p => p.is_seeker === true && p.is_giver === true).length;
            
            console.log(`Seekers only: ${seekersOnly}`);
            console.log(`Givers only: ${giversOnly}`);
            console.log(`Both roles: ${both}`);
            console.log(`Total: ${seekersOnly + giversOnly + both}`);
        }
        
        // Query 4: Data Integrity Check
        console.log('\n4. DATA INTEGRITY CHECK:');
        
        // Check for orphaned seeker_profiles
        const seekerIntegrityResult = await supabase
            .from('seeker_profiles')
            .select(`
                profile_id,
                profiles!inner(id)
            `, { count: 'exact' });
            
        const allSeekersResult = await supabase
            .from('seeker_profiles')
            .select('*', { count: 'exact', head: true });
            
        const orphanedSeekers = (allSeekersResult.count || 0) - (seekerIntegrityResult.count || 0);
        console.log(`Orphaned seeker_profiles: ${orphanedSeekers}`);
        
        // Check for orphaned giver_profiles
        const giverIntegrityResult = await supabase
            .from('giver_profiles')
            .select(`
                profile_id,
                profiles!inner(id)
            `, { count: 'exact' });
            
        const allGiversResult = await supabase
            .from('giver_profiles')
            .select('*', { count: 'exact', head: true });
            
        const orphanedGivers = (allGiversResult.count || 0) - (giverIntegrityResult.count || 0);
        console.log(`Orphaned giver_profiles: ${orphanedGivers}`);
        
        console.log('\n================================================');
        console.log('🔍 VERIFICATION COMPLETE');
        
    } catch (error) {
        console.error('❌ Error running verification:', error);
        process.exit(1);
    }
}

runVerificationQueries();