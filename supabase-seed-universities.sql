-- =============================================================================
-- Beacon MVP: Seed Universities
-- Run in Supabase SQL Editor after supabase-schema.sql
-- Populates the universities reference table used for education autocomplete.
-- =============================================================================

-- Create universities table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.universities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  location TEXT NOT NULL,
  tier INTEGER NOT NULL CHECK (tier BETWEEN 1 AND 5),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.universities ENABLE ROW LEVEL SECURITY;

-- Everyone can read universities
CREATE POLICY "Universities are viewable by everyone"
  ON public.universities FOR SELECT
  USING (true);

-- Create index for autocomplete search
CREATE INDEX IF NOT EXISTS idx_universities_name_trgm
  ON public.universities USING gin (name gin_trgm_ops);

-- Fallback B-tree index if pg_trgm extension not available
CREATE INDEX IF NOT EXISTS idx_universities_name
  ON public.universities (name);

-- Seed data
INSERT INTO public.universities (name, location, tier) VALUES

  -- =========================================================================
  -- TIER 1: Ivy League & Top 10 National Universities
  -- =========================================================================
  ('Harvard University', 'Cambridge, MA', 1),
  ('Yale University', 'New Haven, CT', 1),
  ('Princeton University', 'Princeton, NJ', 1),
  ('Columbia University', 'New York, NY', 1),
  ('University of Pennsylvania', 'Philadelphia, PA', 1),
  ('Brown University', 'Providence, RI', 1),
  ('Dartmouth College', 'Hanover, NH', 1),
  ('Cornell University', 'Ithaca, NY', 1),
  ('Stanford University', 'Stanford, CA', 1),
  ('Massachusetts Institute of Technology', 'Cambridge, MA', 1),
  ('California Institute of Technology', 'Pasadena, CA', 1),
  ('University of Chicago', 'Chicago, IL', 1),
  ('Duke University', 'Durham, NC', 1),
  ('Johns Hopkins University', 'Baltimore, MD', 1),
  ('Northwestern University', 'Evanston, IL', 1),

  -- =========================================================================
  -- TIER 2: Top 25 National Universities & Top Liberal Arts
  -- =========================================================================
  ('Rice University', 'Houston, TX', 2),
  ('Vanderbilt University', 'Nashville, TN', 2),
  ('Washington University in St. Louis', 'St. Louis, MO', 2),
  ('Emory University', 'Atlanta, GA', 2),
  ('Georgetown University', 'Washington, DC', 2),
  ('University of Notre Dame', 'Notre Dame, IN', 2),
  ('Carnegie Mellon University', 'Pittsburgh, PA', 2),
  ('University of Virginia', 'Charlottesville, VA', 2),
  ('University of California, Los Angeles', 'Los Angeles, CA', 2),
  ('University of California, Berkeley', 'Berkeley, CA', 2),
  ('University of Michigan', 'Ann Arbor, MI', 2),
  ('University of Southern California', 'Los Angeles, CA', 2),
  ('New York University', 'New York, NY', 2),
  ('Tufts University', 'Medford, MA', 2),
  ('University of North Carolina at Chapel Hill', 'Chapel Hill, NC', 2),
  ('Wake Forest University', 'Winston-Salem, NC', 2),
  ('Williams College', 'Williamstown, MA', 2),
  ('Amherst College', 'Amherst, MA', 2),
  ('Swarthmore College', 'Swarthmore, PA', 2),
  ('Pomona College', 'Claremont, CA', 2),
  ('Wellesley College', 'Wellesley, MA', 2),
  ('Bowdoin College', 'Brunswick, ME', 2),
  ('Middlebury College', 'Middlebury, VT', 2),
  ('Claremont McKenna College', 'Claremont, CA', 2),
  ('Georgia Institute of Technology', 'Atlanta, GA', 2),

  -- =========================================================================
  -- TIER 3: Top 50 National Universities & Strong Regionals
  -- =========================================================================
  ('Boston College', 'Chestnut Hill, MA', 3),
  ('Boston University', 'Boston, MA', 3),
  ('Brandeis University', 'Waltham, MA', 3),
  ('Case Western Reserve University', 'Cleveland, OH', 3),
  ('College of William & Mary', 'Williamsburg, VA', 3),
  ('Lehigh University', 'Bethlehem, PA', 3),
  ('Northeastern University', 'Boston, MA', 3),
  ('Pepperdine University', 'Malibu, CA', 3),
  ('Rensselaer Polytechnic Institute', 'Troy, NY', 3),
  ('Santa Clara University', 'Santa Clara, CA', 3),
  ('Southern Methodist University', 'Dallas, TX', 3),
  ('Syracuse University', 'Syracuse, NY', 3),
  ('Tulane University', 'New Orleans, LA', 3),
  ('University of California, San Diego', 'La Jolla, CA', 3),
  ('University of California, Santa Barbara', 'Santa Barbara, CA', 3),
  ('University of California, Davis', 'Davis, CA', 3),
  ('University of California, Irvine', 'Irvine, CA', 3),
  ('University of Florida', 'Gainesville, FL', 3),
  ('University of Georgia', 'Athens, GA', 3),
  ('University of Illinois Urbana-Champaign', 'Champaign, IL', 3),
  ('University of Maryland, College Park', 'College Park, MD', 3),
  ('University of Miami', 'Coral Gables, FL', 3),
  ('University of Rochester', 'Rochester, NY', 3),
  ('University of Texas at Austin', 'Austin, TX', 3),
  ('University of Washington', 'Seattle, WA', 3),
  ('University of Wisconsin-Madison', 'Madison, WI', 3),
  ('Villanova University', 'Villanova, PA', 3),
  ('Virginia Tech', 'Blacksburg, VA', 3),
  ('Colgate University', 'Hamilton, NY', 3),
  ('Davidson College', 'Davidson, NC', 3),
  ('Grinnell College', 'Grinnell, IA', 3),
  ('Hamilton College', 'Clinton, NY', 3),
  ('Harvey Mudd College', 'Claremont, CA', 3),
  ('Haverford College', 'Haverford, PA', 3),
  ('Vassar College', 'Poughkeepsie, NY', 3),
  ('Washington and Lee University', 'Lexington, VA', 3),
  ('Wesleyan University', 'Middletown, CT', 3),
  ('Colby College', 'Waterville, ME', 3),
  ('Bates College', 'Lewiston, ME', 3),
  ('Bucknell University', 'Lewisburg, PA', 3),
  ('Purdue University', 'West Lafayette, IN', 3),
  ('Ohio State University', 'Columbus, OH', 3),
  ('Penn State University', 'University Park, PA', 3),
  ('University of Minnesota', 'Minneapolis, MN', 3),
  ('Indiana University Bloomington', 'Bloomington, IN', 3),
  ('Michigan State University', 'East Lansing, MI', 3),

  -- =========================================================================
  -- TIER 4: Good State Schools & Well-Known Privates
  -- =========================================================================
  ('American University', 'Washington, DC', 4),
  ('Auburn University', 'Auburn, AL', 4),
  ('Baylor University', 'Waco, TX', 4),
  ('Clemson University', 'Clemson, SC', 4),
  ('Colorado School of Mines', 'Golden, CO', 4),
  ('Connecticut College', 'New London, CT', 4),
  ('Creighton University', 'Omaha, NE', 4),
  ('Denison University', 'Granville, OH', 4),
  ('DePauw University', 'Greencastle, IN', 4),
  ('Drexel University', 'Philadelphia, PA', 4),
  ('Elon University', 'Elon, NC', 4),
  ('Fordham University', 'New York, NY', 4),
  ('Furman University', 'Greenville, SC', 4),
  ('George Washington University', 'Washington, DC', 4),
  ('Gonzaga University', 'Spokane, WA', 4),
  ('Howard University', 'Washington, DC', 4),
  ('Iowa State University', 'Ames, IA', 4),
  ('James Madison University', 'Harrisonburg, VA', 4),
  ('Loyola Marymount University', 'Los Angeles, CA', 4),
  ('Loyola University Chicago', 'Chicago, IL', 4),
  ('Marquette University', 'Milwaukee, WI', 4),
  ('North Carolina State University', 'Raleigh, NC', 4),
  ('Occidental College', 'Los Angeles, CA', 4),
  ('Providence College', 'Providence, RI', 4),
  ('Rutgers University', 'New Brunswick, NJ', 4),
  ('Skidmore College', 'Saratoga Springs, NY', 4),
  ('Spelman College', 'Atlanta, GA', 4),
  ('Stevens Institute of Technology', 'Hoboken, NJ', 4),
  ('Stony Brook University', 'Stony Brook, NY', 4),
  ('Texas A&M University', 'College Station, TX', 4),
  ('The College of New Jersey', 'Ewing, NJ', 4),
  ('Trinity College', 'Hartford, CT', 4),
  ('Trinity University', 'San Antonio, TX', 4),
  ('University of Alabama', 'Tuscaloosa, AL', 4),
  ('University of Arizona', 'Tucson, AZ', 4),
  ('University of California, Riverside', 'Riverside, CA', 4),
  ('University of California, Santa Cruz', 'Santa Cruz, CA', 4),
  ('University of Colorado Boulder', 'Boulder, CO', 4),
  ('University of Connecticut', 'Storrs, CT', 4),
  ('University of Delaware', 'Newark, DE', 4),
  ('University of Denver', 'Denver, CO', 4),
  ('University of Iowa', 'Iowa City, IA', 4),
  ('University of Kansas', 'Lawrence, KS', 4),
  ('University of Kentucky', 'Lexington, KY', 4),
  ('University of Massachusetts Amherst', 'Amherst, MA', 4),
  ('University of Missouri', 'Columbia, MO', 4),
  ('University of Nebraska-Lincoln', 'Lincoln, NE', 4),
  ('University of Oklahoma', 'Norman, OK', 4),
  ('University of Oregon', 'Eugene, OR', 4),
  ('University of Pittsburgh', 'Pittsburgh, PA', 4),
  ('University of South Carolina', 'Columbia, SC', 4),
  ('University of Tennessee', 'Knoxville, TN', 4),
  ('University of Utah', 'Salt Lake City, UT', 4),
  ('University of Vermont', 'Burlington, VT', 4),
  ('Worcester Polytechnic Institute', 'Worcester, MA', 4),

  -- =========================================================================
  -- TIER 5: Solid Regional Schools & Smaller Institutions
  -- =========================================================================
  ('Appalachian State University', 'Boone, NC', 5),
  ('Arizona State University', 'Tempe, AZ', 5),
  ('Ball State University', 'Muncie, IN', 5),
  ('Belmont University', 'Nashville, TN', 5),
  ('Boise State University', 'Boise, ID', 5),
  ('Bowling Green State University', 'Bowling Green, OH', 5),
  ('Butler University', 'Indianapolis, IN', 5),
  ('California State University, Long Beach', 'Long Beach, CA', 5),
  ('Central Michigan University', 'Mount Pleasant, MI', 5),
  ('Chapman University', 'Orange, CA', 5),
  ('College of Charleston', 'Charleston, SC', 5),
  ('Colorado State University', 'Fort Collins, CO', 5),
  ('Drake University', 'Des Moines, IA', 5),
  ('East Carolina University', 'Greenville, NC', 5),
  ('Florida State University', 'Tallahassee, FL', 5),
  ('George Mason University', 'Fairfax, VA', 5),
  ('Georgia State University', 'Atlanta, GA', 5),
  ('Hofstra University', 'Hempstead, NY', 5),
  ('Illinois State University', 'Normal, IL', 5),
  ('Kansas State University', 'Manhattan, KS', 5),
  ('Kent State University', 'Kent, OH', 5),
  ('Louisiana State University', 'Baton Rouge, LA', 5),
  ('Marist College', 'Poughkeepsie, NY', 5),
  ('Miami University (Ohio)', 'Oxford, OH', 5),
  ('Mississippi State University', 'Starkville, MS', 5),
  ('Montana State University', 'Bozeman, MT', 5),
  ('New Mexico State University', 'Las Cruces, NM', 5),
  ('Northern Arizona University', 'Flagstaff, AZ', 5),
  ('Old Dominion University', 'Norfolk, VA', 5),
  ('Oregon State University', 'Corvallis, OR', 5),
  ('Quinnipiac University', 'Hamden, CT', 5),
  ('Rowan University', 'Glassboro, NJ', 5),
  ('San Diego State University', 'San Diego, CA', 5),
  ('San Francisco State University', 'San Francisco, CA', 5),
  ('San Jose State University', 'San Jose, CA', 5),
  ('Seton Hall University', 'South Orange, NJ', 5),
  ('Temple University', 'Philadelphia, PA', 5),
  ('Texas Tech University', 'Lubbock, TX', 5),
  ('Towson University', 'Towson, MD', 5),
  ('University of Akron', 'Akron, OH', 5),
  ('University of Arkansas', 'Fayetteville, AR', 5),
  ('University of Central Florida', 'Orlando, FL', 5),
  ('University of Cincinnati', 'Cincinnati, OH', 5),
  ('University of Hawaii at Manoa', 'Honolulu, HI', 5),
  ('University of Houston', 'Houston, TX', 5),
  ('University of Idaho', 'Moscow, ID', 5),
  ('University of Louisville', 'Louisville, KY', 5),
  ('University of Memphis', 'Memphis, TN', 5),
  ('University of Mississippi', 'Oxford, MS', 5),
  ('University of Montana', 'Missoula, MT', 5),
  ('University of Nevada, Las Vegas', 'Las Vegas, NV', 5),
  ('University of New Hampshire', 'Durham, NH', 5),
  ('University of New Mexico', 'Albuquerque, NM', 5),
  ('University of North Texas', 'Denton, TX', 5),
  ('University of Rhode Island', 'Kingston, RI', 5),
  ('University of San Diego', 'San Diego, CA', 5),
  ('University of South Florida', 'Tampa, FL', 5),
  ('University of Wyoming', 'Laramie, WY', 5),
  ('Virginia Commonwealth University', 'Richmond, VA', 5),
  ('Washington State University', 'Pullman, WA', 5),
  ('West Virginia University', 'Morgantown, WV', 5),
  ('Western Michigan University', 'Kalamazoo, MI', 5)

ON CONFLICT (name) DO NOTHING;
