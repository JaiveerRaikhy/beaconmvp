import Link from 'next/link'
import './landing.css'

export default function LandingPage() {
  return (
    <div className="landing-page">

      {/* ── Hero ─────────────────────────────────── */}
      <section className="l-hero">
        <div className="l-light-cone" aria-hidden="true" />
        <div className="l-orb" aria-hidden="true" />

        <nav className="l-nav" aria-label="Main navigation">
          <Link href="/" className="l-logo" aria-label="Beacon home">
            <svg className="l-logo-icon" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
              <path d="M14 2L14 8" stroke="#c8612a" strokeWidth="2" strokeLinecap="round"/>
              <path d="M14 8C14 8 8 12 8 18C8 21.3137 10.6863 24 14 24C17.3137 24 20 21.3137 20 18C20 12 14 8 14 8Z" fill="rgba(200,97,42,0.2)" stroke="#c8612a" strokeWidth="1.5"/>
              <circle cx="14" cy="18" r="3" fill="#c8612a"/>
              <path d="M6 7L8.5 9.5" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round" opacity="0.5"/>
              <path d="M22 7L19.5 9.5" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round" opacity="0.5"/>
              <path d="M4 14H7" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round" opacity="0.4"/>
              <path d="M24 14H21" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round" opacity="0.4"/>
            </svg>
            <span className="l-logo-text">Beacon</span>
          </Link>

          <ul className="l-nav-links">
            <li><a href="#how-it-works">How it works</a></li>
            <li><a href="#showcase">For mentors</a></li>
            <li><a href="#cta">Stories</a></li>
            <li><Link href="/login" className="l-nav-signin">Sign in</Link></li>
            <li><Link href="/join" className="l-nav-cta">Get matched</Link></li>
          </ul>
        </nav>

        <div className="l-hero-content">
          <p className="l-eyebrow">Mentorship, reimagined</p>
          <h1 className="l-hero-headline">
            Find the mentor who<br /><em>changes everything</em>
          </h1>
          <p className="l-hero-sub">
            Beacon uses intelligent matching to connect you with mentors who&apos;ve walked your path — and can light the way forward.
          </p>
          <div className="l-hero-actions">
            <Link href="/join" className="l-btn-primary">Find your mentor →</Link>
            <a href="#how-it-works" className="l-btn-ghost">
              See how it works <span className="l-arrow-icon">↗</span>
            </a>
          </div>
        </div>

        <div className="l-scroll-hint" aria-hidden="true">
          <div className="l-scroll-line" />
          <span>Scroll</span>
        </div>
      </section>

      {/* ── Stats bar ────────────────────────────── */}
      <div className="l-stats-bar" aria-label="Platform statistics">
        <div className="l-stat">
          <span className="l-stat-number">1,200+</span>
          <span className="l-stat-label">Expert Mentors</span>
        </div>
        <div className="l-stat">
          <span className="l-stat-number">94%</span>
          <span className="l-stat-label">Match satisfaction</span>
        </div>
        <div className="l-stat">
          <span className="l-stat-number">6 min</span>
          <span className="l-stat-label">Avg. time to match</span>
        </div>
        <div className="l-stat">
          <span className="l-stat-number">48 hrs</span>
          <span className="l-stat-label">First session booked</span>
        </div>
      </div>

      {/* ── How it works ─────────────────────────── */}
      <div id="how-it-works" className="l-section">
        <p className="l-section-label">The process</p>
        <h2 className="l-section-title">Three steps to the right mentor</h2>
        <div className="l-steps">
          <div className="l-step">
            <span className="l-step-num" aria-hidden="true">01</span>
            <div className="l-step-icon" aria-hidden="true">
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
                <path d="M11 3C11 3 5 6 5 13C5 16.3137 7.68629 19 11 19C14.3137 19 17 16.3137 17 13C17 6 11 3 11 3Z" stroke="#c8612a" strokeWidth="1.5"/>
              </svg>
            </div>
            <h3>Tell us your story</h3>
            <p>Share your goals, background, and the challenges you&apos;re navigating. The more honest, the better the match.</p>
          </div>
          <div className="l-step">
            <span className="l-step-num" aria-hidden="true">02</span>
            <div className="l-step-icon" aria-hidden="true">
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
                <circle cx="8" cy="8" r="4" stroke="#c8612a" strokeWidth="1.5"/>
                <circle cx="14" cy="14" r="4" stroke="#c8612a" strokeWidth="1.5"/>
                <path d="M11 11L11 11" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round"/>
              </svg>
            </div>
            <h3>We find your match</h3>
            <p>Our algorithm considers expertise, lived experience, availability, and communication style — not just job titles.</p>
          </div>
          <div className="l-step">
            <span className="l-step-num" aria-hidden="true">03</span>
            <div className="l-step-icon" aria-hidden="true">
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
                <rect x="3" y="5" width="16" height="12" rx="3" stroke="#c8612a" strokeWidth="1.5"/>
                <path d="M7 9H15M7 13H12" stroke="#c8612a" strokeWidth="1.5" strokeLinecap="round"/>
              </svg>
            </div>
            <h3>Start the conversation</h3>
            <p>Message your mentor directly, schedule sessions, and build a relationship at your own pace.</p>
          </div>
        </div>
      </div>

      {/* ── Match showcase ───────────────────────── */}
      <div id="showcase" className="l-showcase">
        <div className="l-showcase-inner">
          <div style={{ position: 'relative' }}>
            {/* Mentee card */}
            <div className="l-match-card" style={{ marginBottom: '1.5rem' }}>
              <div className="l-match-header">
                <div className="l-avatar l-avatar-b" aria-hidden="true">AP</div>
                <div>
                  <div className="l-match-name">Arjun Patel</div>
                  <div className="l-match-role">M.S. Data Science student → looking for direction</div>
                </div>
              </div>
              <div className="l-match-tags">
                <span className="l-tag l-tag-highlight">Data Engineering</span>
                <span className="l-tag l-tag-highlight">Career pivot</span>
                <span className="l-tag">Visa navigation</span>
                <span className="l-tag">Product thinking</span>
              </div>
              <div className="l-match-divider" />
              <p className="l-match-message">&ldquo;I want to work at the intersection of data and product — but I&apos;m not sure how to get there.&rdquo;</p>
            </div>

            {/* Connector */}
            <div className="l-match-connector">
              <div className="l-match-connector-line" />
              <div className="l-match-connector-badge">98% MATCH</div>
            </div>

            {/* Mentor card */}
            <div className="l-match-card" style={{ marginTop: '1.5rem' }}>
              <div className="l-match-header">
                <div className="l-avatar l-avatar-a" aria-hidden="true">SK</div>
                <div>
                  <div className="l-match-name">Sanya Kapoor</div>
                  <div className="l-match-role">Senior Data PM @ Stripe · formerly Goldman</div>
                </div>
              </div>
              <div className="l-match-tags">
                <span className="l-tag l-tag-highlight">Data strategy</span>
                <span className="l-tag l-tag-highlight">International careers</span>
                <span className="l-tag">Product growth</span>
                <span className="l-tag">Analytics</span>
              </div>
              <div className="l-match-divider" />
              <p className="l-match-message">&ldquo;I navigated the same crossroads. I know exactly what Arjun needs to hear — and do.&rdquo;</p>
            </div>
          </div>

          <div className="l-showcase-copy">
            <p className="l-section-label">Intelligent matching</p>
            <h2 className="l-section-title">
              Not just who&apos;s available.<br />Who&apos;s <em style={{ color: '#c8612a' }}>right</em>.
            </h2>
            <p>
              Most platforms match on keywords. Beacon matches on context — your career stage, your obstacles, the kind of guidance you actually need. We look at 40+ signals to make each connection count.
            </p>
            <Link href="/join" className="l-btn-primary">See your matches</Link>
          </div>
        </div>
      </div>

      {/* ── Testimonial ──────────────────────────── */}
      <div className="l-testimonial">
        <span className="l-quote-mark" aria-hidden="true">&ldquo;</span>
        <p className="l-testimonial-text">
          I applied to 200 jobs and heard nothing. Three sessions with my Beacon mentor, and I had a strategy — and an offer — within six weeks.
        </p>
        <div className="l-testimonial-author">
          <div className="l-author-avatar" aria-hidden="true">NR</div>
          <div className="l-author-info">
            <strong>Nadia Romero</strong>
            <span>Data Analyst, Amsterdam · BU grad 2025</span>
          </div>
        </div>
      </div>

      {/* ── CTA ──────────────────────────────────── */}
      <div id="cta" className="l-cta">
        <div className="l-cta-glow" aria-hidden="true" />
        <p className="l-section-label">Ready?</p>
        <h2>Your mentor is<br />already on Beacon</h2>
        <p>Join thousands finding clarity, connection, and momentum.</p>
        <Link href="/join" className="l-btn-primary" style={{ fontSize: '1rem', padding: '1rem 2.5rem' }}>
          Get matched for free →
        </Link>
      </div>

      {/* ── Footer ───────────────────────────────── */}
      <footer className="l-footer">
        <div className="l-logo">
          <span className="l-logo-text">Beacon</span>
        </div>
        <p>© 2025 Beacon. Built to guide.</p>
      </footer>

    </div>
  )
}
