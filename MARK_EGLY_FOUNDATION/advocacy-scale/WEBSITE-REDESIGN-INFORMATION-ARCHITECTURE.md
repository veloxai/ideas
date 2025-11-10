# Website Redesign & Information Architecture

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Marketing Officer
**Purpose**: Complete redesign strategy for MarkEglyFoundation.org to serve as the central hub for AATD patients, families, healthcare professionals, donors, and researchers—optimized for user experience, accessibility, and mission impact

---

## 📋 Table of Contents

1. [Current State Assessment](#current-state-assessment)
2. [User Personas & Needs](#user-personas-needs)
3. [Information Architecture](#information-architecture)
4. [Homepage Strategy](#homepage-strategy)
5. [Key User Journeys](#key-user-journeys)
6. [Content Strategy](#content-strategy)
7. [Technical Requirements](#technical-requirements)
8. [Design Principles](#design-principles)
9. [Budget & Timeline](#budget-timeline)
10. [Success Metrics](#success-metrics)

---

## Current State Assessment

### Foundation Doesn't Exist Yet (Greenfield Website)

**Opportunity**: Build from scratch with modern best practices (no legacy constraints—avoid technical debt, design for users from day one)

**Competitive Analysis** (Similar Foundation Websites):

**CF Foundation (CFF.org)** - Best-in-Class:

- ✅ Clear audience segmentation (homepage buttons: "I have CF," "I'm a caregiver," "I'm a researcher"—direct paths)
- ✅ Comprehensive resources (800+ pages—treatment info, clinical trials, care center locator, highly organized)
- ✅ Strong calls-to-action (donate, volunteer, advocate—visible on every page)
- ⚠️ Dense (overwhelming—too much content, difficult navigation for new visitors)

**Michael J. Fox Foundation (MichaelJFox.org)**:

- ✅ Clean design (modern, visual—appeals to broad audience beyond patients)
- ✅ Research transparency (Fox Trial Finder prominent—15K+ participants, user-friendly)
- ✅ Celebrity leverage (Michael's story front-and-center—personal, emotional connection)
- ⚠️ Donor-focused (website optimized for fundraising—patient resources less prominent, imbalanced)

**PHA (PHAssociation.org)** - Similar-Size Model:

- ✅ Support group focus (250 groups—directory prominent, community-driven)
- ✅ Advocacy center (clear legislative priorities—"Take Action" buttons, easy participation)
- ✅ Patient stories (video testimonials—humanize disease, build connection)
- ⚠️ Dated design (2010s aesthetic—functional but not modern, mobile experience poor)

**Foundation's Goal**: Combine best of all three (CF's comprehensive resources + MJF's modern design + PHA's community focus), avoid weaknesses (CF's density, MJF's donor bias, PHA's dated UX)

---

## User Personas & Needs

### Persona 1: Newly Diagnosed Patient (Sarah, 38)

**Background**:

- Diagnosed 2 weeks ago (primary care physician ordered AAT test after abnormal CT scan—low AAT, confirmed Pi\*ZZ)
- Scared & confused ("What is Alpha-1? Will I die? Can I work? Have kids?")
- Information overload (Googled AATD—found outdated medical articles, patient forums with horror stories, overwhelmed)

**Needs from Website**:

1. **"What is AATD?" basics** (simple explanation—not medical jargon, "You have genetic condition, here's what it means")
2. **Treatment options** ("Augmentation therapy can slow lung damage, liver monitoring important, here's what to expect")
3. **Find a doctor** (specialist locator—pulmonologists experienced in AATD, not general pulmonologists)
4. **Connect with others** (support groups—"You're not alone, 10,000 others in US, join local group")
5. **Reassurance** (hopeful tone—"AATD is manageable, you can live full life, we'll help you")

**Sarah's User Journey**:

1. Lands on homepage (Google: "Alpha-1 antitrypsin deficiency"—Foundation ranks #1)
2. Clicks "I was just diagnosed" (prominent button—designed for her)
3. Reads "Your First 90 Days" guide (step-by-step—Week 1: learn, Week 2: find doctor, Week 4: start treatment, calm structured approach)
4. Watches patient testimonial (3-minute video—"I was diagnosed 5 years ago, here's my life today," seeing is believing)
5. Joins support group (submits form—Foundation connects her to local group, first meeting next week)
6. **Result**: Sarah feels supported, has clear action plan, Foundation becomes trusted resource

---

### Persona 2: Family Member (David, 42, sibling of AATD patient)

**Background**:

- Sister diagnosed with Pi\*ZZ AATD (told David he should get tested—"You might have it too")
- Asymptomatic (no lung/liver problems—feels healthy, tempted to ignore)
- Concerned but busy (3 kids, full-time job—hard to prioritize testing)

**Needs from Website**:

1. **Why should I get tested?** ("Even if you feel fine, knowing status important—early treatment prevents damage, family planning implications")
2. **How easy is testing?** ("Mail-in kit, 2-minute cheek swab, free through Foundation—no excuse not to test")
3. **What if I'm positive?** ("If Pi\*ZZ, start monitoring now—catch problems early, if carrier, know for your kids")

**David's User Journey**:

1. Sister sends link (MarkEglyFoundation.org/FamilyTesting)
2. Reads "Should My Family Get Tested?" (5-minute read—inheritance explained, statistics, case studies)
3. Convinced by data (siblings of Pi\*ZZ have 25% chance—not zero, realizes risk real)
4. Orders free test kit (clicks "Order Kit" button—fills out form, kit arrives 3 days)
5. Tests + receives results (Pi\*MZ carrier—not affected but important to know, informs his kids when they're older)
6. **Result**: David tested (wouldn't have without easy website path), Foundation fulfilled cascade screening mission

---

### Persona 3: Healthcare Professional (Dr. Emily, pulmonologist)

**Background**:

- Sees 2-3 COPD patients/day (most are smokers—typical COPD, routine)
- Rarely thinks of AATD (only seen 2 cases in 15-year career—rare, not top of mind)
- Wants to provide good care (but busy—doesn't have time to become AATD expert)

**Needs from Website**:

1. **When to test?** (clinical decision support—"Test if: COPD age <50, non-smoker with emphysema, family history, unexplained liver disease")
2. **How to test?** (step-by-step—"Order AAT level + genotype, use Quest reflex protocol, send to Foundation specialist if positive")
3. **Patient resources** ("Download brochure—'Living with Alpha-1,' give to diagnosed patients, Foundation handles education")
4. **CME credit** ("1-hour online module—'AATD Diagnosis & Management,' free, 1.0 CME, stay current")

**Dr. Emily's User Journey**:

1. Patient presentation (38-year-old non-smoker with emphysema—red flag, thinks "Could be Alpha-1?")
2. Googles "Alpha-1 testing guidelines" (Foundation SEO optimized—ranks #1)
3. Reads "Healthcare Professional Guide" (4-page PDF—when to test, how to test, specialist referrals)
4. Orders test (Quest reflex protocol—AAT level + genotype, results confirm Pi\*ZZ)
5. Refers patient to Foundation (gives patient website link—Foundation connects to specialist, support group)
6. Takes CME course (1 hour—learns AATD management, earns credit, improves care for future patients)
7. **Result**: Dr. Emily diagnosed patient (wouldn't have without Foundation resources), patient connected to care, win-win

---

### Persona 4: Major Donor (Robert, 55, philanthropist)

**Background**:

- No personal AATD connection (healthy, no family history—altruistic donor)
- Interested in rare disease (believes underserved—wants to make impact where need is greatest)
- Evaluating multiple charities (considering Mark Egly Foundation, LAM Foundation, PHA—deciding where $100K gift goes)

**Needs from Website**:

1. **Mission clarity** ("What does Foundation do?"—crystal clear, jargon-free)
2. **Impact proof** ("Show me results—how many patients helped, research funded, outcomes achieved")
3. **Financial transparency** ("Where does money go?"—overhead %, program breakdown, Form 990 accessible)
4. **Donation ease** ("How do I give?"—one-click donate, major gift contact, planned giving info)

**Robert's User Journey**:

1. Lands on homepage (link from wealth advisor—"Consider this rare disease charity")
2. Clicks "About Us" (reads mission—"Increase diagnosis, accelerate research, support patients," clear and compelling)
3. Reviews "Our Impact" (dashboard—"5,000 patients supported, 15 research grants funded, 50% diagnosis rate increase," quantified results)
4. Checks financials ("85% to programs, 15% overhead"—efficient, Charity Navigator 4-star rated)
5. Reads "Why AATD?" (compelling case—"90% undiagnosed, no cure yet, transformational opportunity," big need + solvable problem = attractive to donor)
6. Submits major gift inquiry (form: "Interested in $100K gift, want to discuss"—Development Director calls next day)
7. **Result**: Robert becomes donor (website convinced him—clear mission, proven impact, easy to give), Foundation secures major gift

---

### Persona 5: Researcher (Dr. James, academic scientist)

**Background**:

- Studies protein misfolding diseases (AAT is interest—similar to CF, Alzheimer's, potential insights)
- Needs patient data (can't do research without patients—registry access essential)
- Writing grant proposal (NIH R01—needs preliminary data, patient cohort, letter of support)

**Needs from Website**:

1. **Registry access** ("How do I access patient data?"—application process, governance, timelines)
2. **Research priorities** ("What does Foundation want to fund?"—align proposal with priorities, increase approval odds)
3. **Collaboration opportunities** ("Does Foundation co-fund research?"—leverage funding, shared resources)
4. **Contact** ("Who do I talk to?"—direct email to Science Director, not generic contact@)

**Dr. James' User Journey**:

1. Lands on "Research" page (Google: "Alpha-1 patient registry"—Foundation ranks #1)
2. Reads registry overview (5,000 patients, clinical + genetic data, biospecimens available—exactly what he needs)
3. Reviews data access policy (IRB approval required, application to Scientific Advisory Board, 60-day review—clear process)
4. Downloads application (PDF form—research proposal, data needs, publications plan—standard academic requirements)
5. Emails Science Director (direct contact—"I'm writing NIH grant, want to discuss collaboration")
6. Foundation provides letter of support (commits registry access if grant funded—strengthens NIH proposal)
7. **Result**: Dr. James includes Foundation in grant (mutual benefit—he gets data, Foundation gets research without full cost), partnership formed

---

## Information Architecture

### Site Map (7 Main Sections)

**1. HOME** (MarkEglyFoundation.org)

- Hero: "You're Not Alone in Your Alpha-1 Journey" (patient-centric—Foundation is helper, not authority figure)
- Quick paths: "I was just diagnosed," "I'm a family member," "I'm a healthcare professional," "I want to donate," "I'm a researcher" (5 buttons—direct to most common user journeys)

---

**2. ABOUT ALPHA-1** (Learn)

- What is AATD? (basics—genetics, symptoms, diagnosis, treatment, 5-minute read)
- Who gets it? (inheritance, carrier screening, family risk—interactive pedigree tool)
- Lung disease in AATD (emphysema, bronchiectasis, how AAT protects lungs—explained simply)
- Liver disease in AATD (cirrhosis, liver cancer, monitoring recommendations—often overlooked, Foundation emphasizes)
- Diagnosis process (AAT level, genotype, phenotype—step-by-step testing guide)
- Treatment options (augmentation therapy, lung transplant, liver transplant, emerging therapies like gene therapy—comprehensive)
- Living with AATD (lifestyle, exercise, diet, smoking cessation, pregnancy—practical tips)

---

**3. SUPPORT & RESOURCES** (Patient-Facing)

- Find a specialist (pulmonologist directory—200+ AATD-experienced doctors, searchable by ZIP)
- Support groups (250+ local groups—in-person + virtual, join near you)
- Patient navigation (free service—"Need help? Talk to Navigator," schedule call)
- Educational materials (brochures, videos, webinars—downloadable, shareable)
- Financial assistance (co-pay support, travel grants for clinic visits, application portal)
- Patient stories (video testimonials—15 stories, 3-5 minutes each, diverse patients [age, severity, background])
- FAQ (100+ questions—"Can I have kids?", "Can I fly?", "What jobs should I avoid?", comprehensive)

---

**4. FOR HEALTHCARE PROFESSIONALS** (Clinical Audience)

- Diagnosis guidelines (when to test—clinical decision tree, downloadable poster for clinic)
- Testing protocols (how to order—Quest, LabCorp, Mayo, insurance coverage tips)
- Treatment guidelines (augmentation therapy indications, dosing, monitoring—evidence-based)
- Specialist directory (refer patients—Foundation network of 200+ pulmonologists, hepatologists)
- CME opportunities ("AATD 101" course—1 hour, 1.0 credit, free, annual conference sessions)
- Clinical trials (current enrolling trials—Foundation-supported, help patients enroll)
- Resources to share (patient brochures, handouts—give to diagnosed patients, Foundation-branded)

---

**5. RESEARCH** (Scientific Community)

- Registry overview (5,000 patients, data types, enrollment criteria—researcher pitch)
- Data access (application process, governance, timelines—transparent, accessible)
- Funded research (current grants, past projects, publications—show Foundation impact)
- Research priorities (diagnostics 20%, therapeutics 40%, outcomes 20%, basic science 20%—guide proposals)
- Apply for funding (RFP calendar, application forms, FAQ—make it easy to apply)
- Scientific Advisory Board (bios, contact—establish credibility)
- Collaboration opportunities (co-funding, registry access, trial support—partnership models)

---

**6. GET INVOLVED** (Engagement)

- Donate (one-time, monthly, major gifts, planned giving—multiple entry points)
- Fundraise (peer-to-peer campaigns—birthday fundraisers, athletic challenges, DIY events)
- Volunteer (opportunities—support groups, events, advocacy, skilled volunteers [graphic design, legal])
- Advocate (legislative priorities—contact Congress, sign petitions, share stories, grassroots)
- Events (Breathe Easy Walk, Annual Conference, Galas—calendar, registration, sponsorships)
- Corporate partnerships (employee giving, sponsorships, research collaborations—B2B pitch)
- Shop (merchandise—T-shirts, wristbands, "Alpha-1 Awareness" gear, proceeds to Foundation)

---

**7. ABOUT US** (Organizational Info)

- Our story (Mark Egly's legacy—personal, emotional, founder's story drives connection)
- Mission & vision (clear—increase diagnosis, accelerate research, support patients)
- Leadership (Board, staff, advisors—faces + bios, humanize organization)
- Financials (Annual Report, Form 990, budget breakdown—transparency builds trust)
- Impact (dashboard—patients served, research funded, diagnosis rate change, visual metrics)
- News (press releases, media coverage, blog—keep updated, 2-4 posts/month)
- Contact (general inquiries, media, partnerships—multiple contact methods [email, phone, form])

---

### Navigation Structure

**Primary Navigation** (Top Menu, Visible on All Pages):

- About Alpha-1 (dropdown: What is AATD?, Diagnosis, Treatment, Living with AATD)
- Support & Resources (dropdown: Find Specialist, Support Groups, Patient Navigation, Materials)
- For Professionals (dropdown: Guidelines, CME, Clinical Trials, Resources)
- Research (dropdown: Registry, Data Access, Apply for Funding)
- Get Involved (dropdown: Donate, Fundraise, Volunteer, Advocate, Events)
- About Us (dropdown: Our Story, Leadership, Financials, Impact, News, Contact)

**Secondary Navigation** (Footer, All Pages):

- Quick links: FAQ, Donate, Contact, Privacy Policy, Terms of Use
- Social media: Facebook, Instagram, Twitter, LinkedIn, YouTube (icons link to profiles)
- Contact: Phone, email, address (make it easy to reach Foundation)

**Sticky Donate Button** (Right Side, Visible on Scroll):

- Prominent on every page (except donation pages—avoid redundancy)
- "Donate" button follows user down page (constant reminder, low friction)

---

## Homepage Strategy

### Above the Fold (First Thing Visitors See)

**Hero Section**:

- **Large, Emotional Image** (patient smiling, active—conveys hope, not despair, avoid "sick patient in hospital bed")
- **Headline**: "You're Not Alone in Your Alpha-1 Journey" (patient-centric, supportive tone)
- **Subheadline**: "The Mark Egly Foundation connects Alpha-1 patients to diagnosis, treatment, and support—and funds research for a cure."
- **Call-to-Action Buttons**:
  - "I was just diagnosed" (leads to "Your First 90 Days" guide)
  - "I want to donate" (leads to donation page—always visible, high-priority action)
  - "Learn about Alpha-1" (leads to "What is AATD?" page—education for general audience)

---

### Homepage Sections (Below Hero, Scroll Down)

**Section 1: Quick Path Buttons** (5 Large Buttons, Icon-Based)

- 🩺 "I was just diagnosed" → Your First 90 Days guide
- 👨‍👩‍👧‍👦 "I'm a family member" → Family Testing page
- 🏥 "I'm a healthcare professional" → For Professionals hub
- ❤️ "I want to donate" → Donation page
- 🔬 "I'm a researcher" → Research hub

**Why This Works**: Users self-identify (know immediately where to go—reduce cognitive load, skip navigation)

---

**Section 2: What We Do** (3 Pillars, Icon + Text)

- **Increase Diagnosis** (icon: magnifying glass + DNA) - "Only 10% of AATD patients are diagnosed. We partner with genetic testing companies to find the missing 90%."
- **Accelerate Research** (icon: lab beaker) - "We fund cutting-edge research—from gene therapy to rapid diagnostics—to bring us closer to a cure."
- **Support Patients** (icon: helping hands) - "We connect patients to specialists, support groups, and financial assistance—so no one faces Alpha-1 alone."

**Visual**: 3 columns, icons at top, 2-sentence descriptions, "Learn More" links (each to detailed page)

---

**Section 3: Our Impact** (Data Dashboard, Numbers + Icons)

- **5,000 Patients Supported** (icon: person + heart) - "Connected to specialists, support groups, and resources"
- **15 Research Grants Funded** ($2M total) - "Advancing diagnostics, treatments, and potential cures"
- **50% Diagnosis Rate Increase** (from 10% to 15% in Year 1) - "Finding undiagnosed patients through genetic testing"
- **250 Support Groups** (nationwide) - "Building community and reducing isolation"

**Visual**: 4 boxes, large numbers (5,000, 15, 50%, 250), icons, brief descriptions (update annually—Year 5 these numbers much larger)

---

**Section 4: Patient Story (Video Testimonial)**

- **Headline**: "Meet Sarah" (or rotating—4-5 patient stories, change monthly)
- **Video** (3-5 minutes—Sarah tells diagnosis story, treatment journey, how Foundation helped, hopeful ending)
- **Text Overlay**: "Diagnosed at 38, now thriving on augmentation therapy"
- **Below Video**: "Read More Stories" button (links to full patient stories library)

**Why This Works**: Humanizes disease (data = head, stories = heart, need both to connect), video >>> text (people watch, don't read, higher engagement)

---

**Section 5: Latest News** (3 Recent Blog Posts)

- **Post 1**: "23andMe Partnership Identifies 30,000 Undiagnosed Patients" (news—Foundation's big wins)
- **Post 2**: "New Gene Therapy Trial Enrolling" (research updates—keep community informed)
- **Post 3**: "Join Us for Breathe Easy Walk 2026" (events—drive participation)

**Visual**: 3 cards (image, headline, 2-sentence summary, "Read More"), scrollable carousel if more posts (show 3, arrow to see more)

---

**Section 6: Get Involved** (4 Action Boxes)

- **Donate**: "Your gift funds research and patient support" → Donate page
- **Fundraise**: "Start a birthday fundraiser on Facebook" → Peer-to-Peer page
- **Volunteer**: "Join a local support group or event" → Volunteer page
- **Advocate**: "Tell Congress to fund AATD research" → Advocacy page

**Visual**: 4 equal boxes, icons, short text, prominent buttons (make it EASY to engage—low friction)

---

## Key User Journeys

### Journey 1: Newly Diagnosed Patient (Sarah)

**Entry**: Google "Alpha-1 antitrypsin deficiency" → Foundation ranks #1 → Lands on homepage

**Path**:

1. Homepage → Clicks "I was just diagnosed" button (hero section, can't miss it)
2. Your First 90 Days page (reads 10-minute guide—Week 1: learn, Week 2: find doctor, Week 4: treatment, Week 8: support group, Week 12: genetic counseling for family)
3. Watches "Meet Sarah" video (3 minutes—patient testimonial, relates to her situation, feels less alone)
4. Clicks "Find a Specialist" (enters ZIP—finds 3 pulmonologists within 20 miles, experienced in AATD)
5. Clicks "Join Support Group" (fills out form—Foundation connects her to local group, first meeting next week)
6. Downloads "Living with Alpha-1" brochure (PDF—20 pages, comprehensive, shares with family)
7. Subscribes to newsletter (email signup—receives monthly updates, educational content, event invitations)

**Outcome**: Sarah feels supported, has action plan, Foundation becomes lifelong resource (donor, volunteer, advocate in future)

**Conversion Metrics**: 70% of "just diagnosed" visitors complete at least 3 actions (watch video, find specialist, join support group—high engagement = good UX)

---

### Journey 2: Healthcare Professional Diagnosing First Patient (Dr. Emily)

**Entry**: Sees 38-year-old non-smoker with emphysema → Googles "when to test for Alpha-1" → Foundation ranks #1 → Lands on "Diagnosis Guidelines" page

**Path**:

1. Diagnosis Guidelines page (reads 2-page PDF—clinical decision tree, patient profile matches, decides to test)
2. Clicks "How to Test" (reads testing protocols—Quest reflex protocol, order AAT level, genotype runs automatically if low)
3. Orders test through Quest (uses Foundation's protocol—patient tests positive, Pi\*ZZ)
4. Clicks "What to Do Next" (reads post-diagnosis management—refer to specialist, start augmentation if indicated, family cascade screening)
5. Downloads "Patient Brochure" (gives to patient—"Living with Alpha-1," Foundation resource, patient appreciates)
6. Refers patient to Foundation specialist (uses specialist locator—finds Dr. Robert Sandhaus [if Colorado], Dr. James Stoller [if Ohio], patient scheduled)
7. Takes CME course (1 hour—"AATD Diagnosis & Management," earns 1.0 credit, better prepared for next patient)

**Outcome**: Dr. Emily diagnosed patient (wouldn't have without Foundation resources), patient connected to expert care, physician educated (will diagnose more in future)

**Conversion Metrics**: 60% of HCP visitors download at least one resource (guidelines, brochure, CME), 30% refer patient to Foundation (measurable via referral tracking form)

---

### Journey 3: Major Donor Evaluating Charities (Robert)

**Entry**: Wealth advisor sends link → Lands on homepage → Evaluating whether to donate

**Path**:

1. Homepage → Scrolls (reviews "What We Do," impressed by 3-pillar mission)
2. Clicks "Our Impact" (dashboard—5,000 patients, 15 grants, 50% diagnosis increase, quantified results = credibility)
3. Clicks "Financials" (downloads Annual Report—85% to programs, 15% overhead, efficient)
4. Reads "Why AATD?" (compelling case—90% undiagnosed, transformational opportunity, solvable problem = attractive)
5. Clicks "Major Gifts" (reads benefits—naming opportunities, Board meetings invitation, direct impact)
6. Submits inquiry form ("Interested in $100K gift, want to discuss"—includes name, email, phone, preferred contact time)
7. Development Director calls next day (30-minute conversation—discusses gift designation [research? patient support?], pledges $100K over 2 years)

**Outcome**: Robert becomes major donor ($100K—significant gift for Year 1-2 Foundation), wealth advisor impressed (refers other clients)

**Conversion Metrics**: 15% of major gift page visitors submit inquiry (high-intent audience—came to give, Foundation makes it easy), 50% of inquiries convert to gifts (Development Director follow-up effective)

---

## Content Strategy

### Voice & Tone

**Foundation's Voice**: Supportive, hopeful, credible

- ✅ **Supportive**: "You're not alone," "We're here to help," "Together we can…" (never: "Patients suffer from AATD"—avoid victim language)
- ✅ **Hopeful**: "Treatment is available," "Research is advancing," "A cure is possible" (never: "AATD is incurable, progressive disease"—avoid doom)
- ✅ **Credible**: Evidence-based (cite studies, quote experts, transparent data—never: "Miracle cure," "Revolutionary breakthrough"—avoid hype)

**Tone Adjustments by Audience**:

- **Patients**: Warm, empathetic (imagine talking to newly diagnosed Sarah—scared, needs reassurance)
- **Professionals**: Authoritative, clinical (imagine talking to Dr. Emily—busy, wants facts fast, no fluff)
- **Donors**: Inspirational, results-focused (imagine talking to Robert—wants to know impact, ROI on donation)
- **Researchers**: Collaborative, data-rich (imagine talking to Dr. James—academic, values rigor, partnerships)

---

### Content Types

**1. Educational Articles** (50-70 articles at launch)

- Topics: What is AATD?, Genetics, Lung disease, Liver disease, Treatment, Living with AATD, Family planning, etc.
- Length: 800-1,500 words (thorough but readable—not medical textbook, not Tweet-length)
- SEO-optimized (target keywords—"Alpha-1 antitrypsin deficiency," "AATD treatment," "AAT genetic testing")
- Updated annually (medical info changes—review all articles yearly, update with latest evidence)

**2. Patient Stories** (15 video testimonials at launch, add 10/year)

- Format: 3-5 minute videos (professionally shot—good lighting, audio, editing, but authentic feel, not overly produced)
- Diversity: Age (20s-70s), severity (mild-severe), geography (urban-rural), demographics (race, gender)
- Script: Diagnosis story → Treatment journey → How Foundation helped → Hopeful message (consistent arc—relatable)
- Distribution: YouTube (embed on website), social media (clips on Instagram/Facebook), email (link in newsletter)

**3. Healthcare Professional Resources** (10-15 downloadable PDFs)

- Diagnosis guidelines (2-page clinical decision tree)
- Testing protocols (1-page—Quest, LabCorp, Mayo instructions)
- Treatment guidelines (5-page evidence-based recommendations)
- Patient brochures (20-page "Living with Alpha-1"—give to diagnosed patients)
- Posters (clinic wall—"Test for Alpha-1 If…," visual checklist)

**4. Research Reports** (Annual, 20-30 pages)

- Funded grants (list all, describe each—PI, institution, goal, progress, publications)
- Registry update (# enrolled, demographics, data available—researcher recruitment)
- Scientific publications (list all Foundation-supported papers—demonstrate output)
- Future priorities (next year's RFP—guide potential applicants)

**5. Blog / News** (2-4 posts/month, 300-800 words)

- Research updates ("New gene therapy trial," "Study shows augmentation effective")
- Event announcements ("Register for Breathe Easy Walk," "Conference early-bird pricing")
- Patient spotlights (text version of video stories—for readers who prefer articles)
- Advocacy wins ("Congress funds $5M AATD research," "Insurance company expands coverage")

---

### Multimedia Content

**Videos** (High Priority—Video >>> Text for Engagement):

- Patient testimonials (15 at launch, 3-5 minutes each)
- "What is AATD?" explainer (2-minute animated video—use motion graphics, simplify genetics)
- Treatment overview (4-minute video—show augmentation infusion, interview physician, demystify)
- How to use website (1-minute tutorial—especially for older patients, less tech-savvy)

**Infographics** (Visual Learning):

- AATD inheritance (Punnett square—visual genetics, easier to understand than text)
- Diagnosis pathway (flowchart—symptoms → testing → diagnosis → treatment)
- "AATD by the Numbers" (statistics—100K patients, 10% diagnosed, $150K/year treatment cost, visual)

**Podcasts** (Future—Year 2-3):

- "Life with Alpha-1" series (monthly—interview patients, physicians, researchers, 30 minutes, iTunes/Spotify)

---

## Technical Requirements

### Platform Selection

**Option 1: WordPress (Recommended)**

- **Pros**:
  - ✅ User-friendly (staff can update content—no developer needed for every change)
  - ✅ Plugins (donation forms [GiveWP], events [Events Calendar], SEO [Yoast], security [Wordfence]—extend functionality easily)
  - ✅ Themes (nonprofit themes available—Charity, GiveWP theme, mobile-responsive, accessible)
  - ✅ Cost-effective ($5K-$15K setup vs. $50K-$100K custom build)
- **Cons**:
  - ⚠️ Security (WordPress = hacking target—mitigate with security plugins, regular updates, hosting with security features)
  - ⚠️ Performance (can be slow if not optimized—use caching, CDN, quality hosting)

**Recommended Tech Stack**:

- **CMS**: WordPress 6.x (latest stable)
- **Theme**: Custom theme based on nonprofit starter (Astra, GeneratePress—lightweight, accessible)
- **Hosting**: WP Engine or Kinsta ($300-$500/month—managed WordPress, security, backups, performance)
- **Plugins**:
  - Donation: GiveWP ($300/year—donor management, recurring gifts, reporting)
  - Events: Events Calendar Pro ($200/year—event registration, ticketing)
  - SEO: Yoast Premium ($99/year—SEO optimization, schema markup)
  - Security: Wordfence Premium ($100/year—firewall, malware scanning)
  - Forms: Gravity Forms ($200/year—contact, volunteer, inquiry forms)
  - Email: Mailchimp for WordPress (free—newsletter signups, automation)

---

**Option 2: Custom Build (Not Recommended for Year 1-2)**

- **Pros**:
  - ✅ Fully customized (exact design, no theme constraints)
  - ✅ Performance (built for speed—no plugin bloat)
- **Cons**:
  - ❌ Expensive ($50K-$100K development—Foundation Year 1-2 can't afford)
  - ❌ Ongoing maintenance (every change requires developer—$10K-$20K/year, not sustainable)
  - ❌ Staff can't update (no CMS—founder can't add blog post without dev, bottleneck)

**Recommendation**: Start with WordPress (Year 1-3), consider custom rebuild Year 5+ if budget allows and needs justify ($10M+ annual budget, complex functionality beyond WordPress capabilities)

---

### Key Features

**1. Donation Platform**

- One-time + recurring (monthly, annual—encourage recurring with 10% premium [give $100/month vs. $1,000 one-time, highlight sustained impact])
- Multiple levels (preset amounts $25, $50, $100, $250, $500, $1,000, custom—make it easy to choose)
- Donor portal (login—view giving history, update payment method, download tax receipts)
- Integration with Salesforce or similar CRM (track donors, automate acknowledgments, segment for campaigns)

**2. Event Registration**

- Calendar (all Foundation events—Walks, Galas, Webinars, filterable by type, date, location)
- Online registration (secure payment—ticket purchase, donation add-ons, team formation)
- Fundraising pages (peer-to-peer—registrants create personal pages, share, collect donations from friends/family)

**3. Specialist Directory**

- Searchable database (200+ pulmonologists, hepatologists—filter by ZIP, distance, insurance accepted)
- Profiles (physician name, credentials, clinic address, phone, website, AATD patient volume [if available])
- User-submitted reviews (optional—patients rate doctors, like Yelp, helps others choose, controversial—may offend doctors, pilot carefully)

**4. Support Group Finder**

- Map-based (interactive map—pins for each group, click for details)
- List view (searchable by ZIP, state—shows in-person + virtual groups)
- Contact info (group leader email/phone—Foundation connects user to leader, leader invites to meeting)

**5. Registry Portal**

- Patient enrollment (online form—consent, demographics, medical history, submit to join registry)
- Data dashboard (participants see own data—genetic results, clinical measures over time, visual graphs)
- Study recruitment (notify patients of trials—"You may qualify for gene therapy trial, click here," increase enrollment)

**6. Researcher Application Portal**

- Online submission (upload proposal, budget, CV—no email submissions, trackable)
- Status tracking (applicants log in—see "Under Review," "Approved," "Funded," transparent process)
- Data use agreement (electronic signature—DocuSign integration, legally binding, no paper)

---

### Accessibility (WCAG 2.1 AA Compliance)

**Why It Matters**: Many AATD patients have disabilities (lung disease = oxygen use, fatigue, mobility issues—website must work for everyone)

**Requirements**:

- ✅ **Screen reader compatible** (alt text on all images, proper heading structure [H1, H2, H3], ARIA labels—blind users can navigate)
- ✅ **Keyboard navigation** (all functions accessible without mouse—tab through links, enter to click, users with tremors, motor impairments)
- ✅ **Color contrast** (text vs. background must meet 4.5:1 ratio—low-vision users can read)
- ✅ **Captions on videos** (all videos subtitled—deaf/hard-of-hearing users, also helps non-native English speakers)
- ✅ **Resizable text** (users can zoom 200%—website still functional, doesn't break layout)

**Testing**: Hire accessibility consultant ($5K-$10K—audit site pre-launch, fix issues, get WCAG certificate, avoid lawsuits)

---

### Mobile-First Design

**Why It Matters**: 60%+ of website traffic will be mobile (patients Googling on phones—"Alpha-1 symptoms," "find doctor near me," must work perfectly on small screens)

**Requirements**:

- ✅ **Responsive design** (layout adapts—desktop 3-column → mobile 1-column, images resize, menus collapse)
- ✅ **Touch-friendly** (buttons large enough to tap—44px minimum, not 10px, avoid tiny links close together)
- ✅ **Fast load** (mobile networks slow—optimize images, lazy load, page loads <3 seconds on 4G)
- ✅ **Simplified navigation** (hamburger menu—collapses primary nav into icon, fewer clicks to reach content)

---

## Design Principles

### Visual Identity

**Color Palette** (Aligned with Mark Egly's Legacy):

- **Primary**: Deep blue (#003366—trust, stability, medical/professional associations)
- **Secondary**: Teal/turquoise (#00A9A5—hope, breath/air [tie to lung disease], modern)
- **Accent**: Warm orange (#FF6F3C—energy, optimism, calls-to-action [Donate buttons], contrasts blue)
- **Neutrals**: Grays (#F5F5F5 light gray for backgrounds, #333333 dark gray for text)

**Logo**: Mark Egly Foundation (custom—incorporate lungs + DNA helix imagery, symbolize AATD's lung/genetic nature, professional, recognizable)

---

### Typography

**Headings**: Open Sans or Montserrat (sans-serif—modern, clean, readable on screens)
**Body Text**: Lora or Georgia (serif—traditional, readable for long-form content, slight contrast with sans-serif headings)
**Font Size**: 16-18px body text minimum (not 12px—readable for older adults, low-vision users)

---

### Imagery

**Photos** (High Quality, Authentic):

- ✅ **Real patients** (with permission—consent forms, releases, authentic, relatable)
- ✅ **Diverse representation** (age, race, gender, severity—reflect AATD's broad patient base)
- ✅ **Hopeful tone** (patients smiling, active [hiking, playing with kids], not "sick in hospital bed"—avoid despair)
- ❌ **Stock photos discouraged** (generic "doctor with stethoscope" feels fake—use sparingly, prefer real Foundation photos)

**Video Production**:

- Professional but authentic (good lighting, audio, editing—but not "pharmaceutical ad" overproduced, feels genuine)
- Budget: $2K-$5K per video (videographer day rate $1K-$2K, editing $1K-$3K—15 videos at launch = $30K-$75K)

---

### User Experience (UX) Principles

**1. Clarity Over Cleverness**

- ✅ "Find a Doctor" (clear—users know exactly what button does)
- ❌ "Connect to Care" (vague—what does that mean? Doctor? Support group? Ambiguous)

**2. Minimize Clicks**

- ✅ Homepage button → Destination (1 click—"I was just diagnosed" goes directly to guide)
- ❌ Homepage → About → Resources → Patients → Guide (4 clicks—users abandon, frustration)

**3. Progressive Disclosure**

- ✅ Show basics first, details on demand ("What is AATD?"—2-minute read, "Learn More" → 10-page deep dive)
- ❌ Dump everything at once (overwhelming—users leave, don't know where to start)

**4. Consistent Layout**

- ✅ All pages same navigation, same footer, same button styles (users learn once, navigate easily)
- ❌ Every page different layout (confusing—users relearn each page, high cognitive load)

---

## Budget & Timeline

### Development Budget

**Phase 1: Discovery & Strategy** (Months 1-2, $10K-$15K)

- Stakeholder interviews (Board, advisors, patients—gather needs, priorities)
- Competitive analysis (review 10 peer foundation websites—identify best practices, gaps)
- User persona development (5 personas—patient, family, HCP, donor, researcher, detailed as above)
- Sitemap & wireframes (IA + low-fidelity mockups—structure before design)

**Phase 2: Design** (Months 3-4, $15K-$25K)

- Visual design (homepage + 5 key templates [About, Resources, Donation, Event, Blog post])
- Design system (color palette, typography, button styles, iconography—reusable components)
- Revisions (2-3 rounds—Board approval, stakeholder feedback, refine)

**Phase 3: Development** (Months 5-7, $25K-$40K)

- WordPress setup (hosting, theme development, plugins)
- Custom functionality (donation forms, event registration, specialist directory, support group finder)
- Content migration (write/upload 70 articles, 15 videos, 20 resources—Foundation staff + copywriter)
- Testing (QA—functionality, cross-browser [Chrome, Firefox, Safari], mobile, accessibility)

**Phase 4: Launch & Training** (Month 8, $5K-$10K)

- Staff training (Foundation team learns WordPress—add blog posts, update content, manage donations)
- Soft launch (beta test—invite 100 patients, get feedback, fix bugs)
- Public launch (press release, social media announcement, email to mailing list)

**Total Development Cost**: $55K-$90K (Year 1—one-time, includes strategy, design, build, launch)

---

### Annual Maintenance Budget

**Hosting & Plugins**: $5K-$8K/year (WP Engine hosting $4K, plugins $1K, domain/SSL $500)
**Content Updates**: $10K-$15K/year (0.25 FTE staff time—add blog posts, update resources, refresh annually, or outsource to copywriter $50-$100/hour)
**Security & Backups**: $2K-$3K/year (Wordfence Premium, daily backups, annual security audit)
**Design Refreshes**: $5K-$10K/year (minor updates—new photos, seasonal banners, keep fresh, major redesign every 5 years $50K)

**Total Ongoing Cost**: $22K-$36K/year

---

### Timeline

**Month 1-2**: Discovery (personas, IA, wireframes—Foundation knows what to build)
**Month 3-4**: Design (visual mockups—Foundation approves look/feel)
**Month 5-7**: Development (build site—WordPress, content, features)
**Month 8**: Launch (go live—soft launch, fix bugs, public launch)

**Total Timeline**: 8 months from kickoff to public launch (typical for nonprofit website—complex features [donation, events, registry], extensive content, realistic)

---

## Success Metrics

### Traffic Metrics (Google Analytics)

**Year 1 Targets**:

- **Unique visitors**: 50,000/year (baseline—new Foundation, building awareness)
- **Pageviews**: 200,000/year (4 pages/visit average—users exploring, not bouncing immediately)
- **Bounce rate**: <50% (industry average 60%—Foundation's clear CTAs, engaging content keep users on site)
- **Avg. session duration**: 3-5 minutes (users reading—not just glancing, finding valuable info)

**Year 5 Targets**:

- **Unique visitors**: 250,000/year (5x growth—SEO matured, Foundation known, organic traffic)
- **Pageviews**: 1,250,000/year (same 5 pages/visit—users diving deep into resources)

---

### Conversion Metrics

**Donations**:

- **Online donations**: $100K Year 1 (20% of $500K total budget—website-driven), $500K Year 5 (20% of $2.5M budget—scales with organization)
- **Donor acquisition**: 500 new donors Year 1 ($200 avg. gift), 2,500 Year 5 (website primary acquisition channel)

**Patient Engagement**:

- **Support group signups**: 500 Year 1 (10% of 5,000 visitors to Support Group page convert)
- **Specialist directory searches**: 2,000 Year 1 (patients finding doctors—measure clicks, conversions)
- **Registry enrollments**: 1,000 Year 1 (website-driven—20% of diagnosed patients enroll, critical for research)

**Healthcare Professional Engagement**:

- **CME enrollments**: 1,000 Year 1 (physicians taking online course—website drives, improves diagnosis rates)
- **Resource downloads**: 5,000 downloads Year 1 (brochures, guidelines—physicians using Foundation materials)

**Researcher Engagement**:

- **Grant applications**: 50 Year 1 (website makes it easy to apply—online portal, clear RFP, high applicant volume)
- **Data access requests**: 20 Year 1 (researchers applying for registry access—website streamlines process)

---

### SEO Metrics

**Keyword Rankings** (Google Top 10):

- "Alpha-1 antitrypsin deficiency" (Year 1 #3, Year 5 #1—primary keyword, high volume)
- "AATD treatment" (Year 1 #5, Year 5 #1-2)
- "Alpha-1 genetic testing" (Year 1 #8, Year 5 #1-3)
- "AATD support groups" (Year 1 #2, Year 5 #1—long-tail, high intent)

**Backlinks**: 100 Year 1 → 500 Year 5 (quality links—medical schools, hospitals, news sites, improves SEO authority)

---

## Summary

**MarkEglyFoundation.org = Central Hub for Entire AATD Community**:

- ✅ **User-Centric**: 5 personas (patient, family, HCP, donor, researcher—direct paths for each, intuitive UX)
- ✅ **Comprehensive**: 7 main sections, 70+ articles, 15 videos, 20 downloadable resources (one-stop shop—users don't need other sites)
- ✅ **Accessible**: WCAG 2.1 AA compliant, mobile-first, works for all users (oxygen-dependent patients, low-vision, non-tech-savvy)
- ✅ **Measurable**: Analytics, conversion tracking (know what works—optimize annually, data-driven decisions)

**Investment**: $55K-$90K development (Year 1), $22K-$36K/year ongoing (maintenance, content, hosting—sustainable)

**Impact**: 50,000 visitors Year 1 → 250,000 Year 5, 500 support group signups → 2,500, $100K online donations → $500K (website = growth engine for Foundation)

**"A great website doesn't just inform—it connects, supports, and inspires action."**

---

**Website Development Inquiries**

**Mark Egly Foundation**
📧 Email: web@markeglyfoundation.org
📞 Phone: (XXX) XXX-XXXX

---

**Approved by**: Board of Directors
**Effective Date**: January 1, 2026
**Review Date**: Annually (redesign every 5 years)
**Version**: 1.0

---

_"Connecting the AATD community, one click at a time."_

**— Mark Egly Foundation**
