# Fair Underwriting - Go-to-Market Playbook

**Last Updated**: November 7, 2025
**Timeline**: 18-Month Launch & Scale Plan (Q1 2026 - Q2 2027)
**Status**: Execution Roadmap

---

## Executive Summary

This playbook provides the **tactical execution plan** for Fair Underwriting's market entry and first 18 months of operations. It transforms the business strategy into specific, actionable steps with clear owners, timelines, and success metrics.

**Go-to-Market Philosophy**: Start narrow, prove value, scale systematically.

**Primary Strategy**: Launch with 1-2 pilot insurance partners, demonstrate clinical and economic value, then scale to broader market with proven case studies.

---

## Phase Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                    18-MONTH GTM TIMELINE                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                    │
│  Phase 1: Foundation (Months 1-3)                                │
│  └─ Product: MVP Development                                      │
│  └─ Team: Core hires                                             │
│  └─ Market: Pilot partner selection                              │
│                                                                    │
│  Phase 2: Pilot Launch (Months 4-9)                             │
│  └─ Product: Pilot deployment                                     │
│  └─ Team: Customer success & medical                             │
│  └─ Market: 1-2 pilot partners, 500-2,500 customers             │
│                                                                    │
│  Phase 3: Proof of Concept (Months 10-12)                       │
│  └─ Product: Iterate based on feedback                           │
│  └─ Team: Expand sales & marketing                              │
│  └─ Market: Case studies, 2-3 additional partners               │
│                                                                    │
│  Phase 4: Scale (Months 13-18)                                  │
│  └─ Product: Platform optimization                                │
│  └─ Team: Regional sales teams                                   │
│  └─ Market: 8-12 total partners, 50K-100K customers             │
│                                                                    │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Foundation (Months 1-3, Q1 2026)

### Objectives

- ✅ Complete MVP platform development
- ✅ Hire core team (5-7 people)
- ✅ Identify and qualify 10 potential pilot partners
- ✅ Establish lab partnerships (Quest and/or LabCorp)
- ✅ Complete regulatory compliance (HIPAA, GINA)
- ✅ Create sales materials (deck, one-pager, demo)

---

### Product Development (Month 1-3)

**MVP Features** (Must-Have):

- Customer portal (login, test results display, educational content)
- Partner dashboard (aggregated stats, enrollment management)
- Test ordering system (integration with lab partner)
- HIPAA-compliant data storage
- Genetic counseling scheduling
- Basic reporting and analytics

**Deferred to Post-MVP** (Nice-to-Have):

- Mobile app (web-responsive first)
- Advanced analytics and ML
- API for partner integrations
- Badge certification program
- Full DNA sequencing

**Tech Stack**:

- Frontend: Next.js, React, Tailwind CSS (leverage Velox.AI patterns)
- Backend: Node.js/NestJS
- Database: PostgreSQL + Redis
- Auth: Leverage auth.vlx.io
- Hosting: AWS

**Development Timeline**:

- Week 1-2: Architecture finalization, database schema
- Week 3-6: Core portal development (customer + partner)
- Week 7-9: Lab integration, test ordering workflow
- Week 10-11: Testing, security audit, HIPAA compliance verification
- Week 12: Beta deployment, internal testing

**Owner**: CTO + 2-3 engineers

---

### Team Building (Month 1-3)

**Priority Hires** (Close by Month 3):

1. **CTO** (Week 1-4)
   - Owns technical architecture and MVP delivery
   - Experience: Health tech, HIPAA, scalable systems
   - Equity: 3-5%

2. **Head of Business Development / VP Sales** (Week 2-6)
   - Owns pilot partner outreach and sales process
   - Experience: Insurance industry relationships, B2B sales
   - Equity: 1-2%

3. **Genetic Counselor** (part-time/contract, Week 4-8)
   - Provides customer consultations
   - Creates educational content
   - Experience: AATD/respiratory genetics preferred
   - Compensation: $75-100/hr, 10-20 hours/week initially

4. **Head of Marketing / CMO** (Week 6-10)
   - Owns website, content, positioning, partner materials
   - Experience: Health tech marketing, B2B2C
   - Equity: 1-1.5%

5. **Software Engineer** (Week 4-8)
   - Works with CTO on MVP development
   - Full-stack capabilities
   - Equity: 0.5-1%

6. **Designer** (contract, Week 2-4)
   - UI/UX for portals
   - Marketing materials and brand identity
   - Compensation: $100-150/hr, project-based

**Recruiting Strategy**:

- CTO: Personal network, Sequoia/a16z talent networks, AngelList
- BD/Sales: Insurance industry recruiters, LinkedIn, Trade association contacts
- Genetic Counselor: NSGC (National Society of Genetic Counselors) job board
- Marketing: Health tech marketing recruiters, portfolio companies
- Engineer: Vetted.ai, Triplebyte, YC Work at a Startup

**Budget**: $150K-250K for first 3 months (salaries + recruiting fees)

---

### Pilot Partner Selection & Outreach (Month 1-3)

**Target Profile for Pilot Partner**:

**Ideal Characteristics**:

- Mid-size regional insurer (500K-5M policyholders)
- Progressive/innovative (wellness programs, early adopter)
- Life insurance or health insurance with wellness focus
- Strong executive sponsor (CMO, Chief Medical Officer, Head of Wellness)
- Willing to co-invest in pilot (subsidize testing)
- Open to case study and PR

**Avoid**:

- Top 5 national insurers (too bureaucratic for pilot)
- Very small insurers (<100K policyholders, insufficient scale)
- Companies with negative press on customer data/privacy

**Target Companies** (Priority Order):

**Life Insurance**:

1. **Northwestern Mutual** ⭐ TOP PRIORITY
   - Size: #3 in US life insurance
   - Innovation: Known for wellness programs
   - Strategy: Mutual company = customer-centric
   - Contact: Head of Innovation, CMO
   - HQ: Milwaukee, WI

2. **MassMutual**
   - Size: Top 10 US life insurer
   - Innovation: Venture arm (MM Catalyst Fund)
   - Strategy: Health & wellness focus
   - Contact: MM Catalyst, Chief Wellness Officer
   - HQ: Springfield, MA

3. **Pacific Life**
   - Size: Mid-large regional
   - Innovation: Digital transformation focus
   - Contact: EVP Marketing & Innovation
   - HQ: Newport Beach, CA

4. **Mutual of Omaha**
   - Size: Mid-size national
   - Geography: Midwest (Johnston, IA nearby = Mark Egly local)
   - Contact: Chief Medical Officer
   - HQ: Omaha, NE

**Health Insurance**:

5. **Cambia Health Solutions** (Regence BCBS)
   - Size: 2.5M members (Northwest region)
   - Innovation: Innovation center, venture fund
   - Strategy: Value-based care focus
   - Contact: Chief Health Officer, Innovation Lead
   - HQ: Portland, OR

6. **Highmark Health**
   - Size: 6M members (PA, WV, DE)
   - Innovation: Integrated delivery system
   - Contact: Chief Medical Officer
   - HQ: Pittsburgh, PA

7. **Blue Cross Blue Shield of North Carolina**
   - Size: 4M members
   - Innovation: Population health initiatives
   - Contact: VP Population Health
   - HQ: Durham, NC

**Wellness Organizations / Associations**:

8. **YMCA of the USA** (insurance partnerships)
   - Members: 64M globally, 22M in US
   - Model: Corporate wellness programs
   - Contact: VP Health & Well-Being
   - HQ: Chicago, IL

9. **American Heart Association** (employer wellness)
   - Programs: CEO Roundtable, Workplace Health
   - Contact: VP Corporate Relations
   - HQ: Dallas, TX

10. **National Safety Council** (employer programs)
    - Focus: Occupational health
    - Contact: VP Workplace Programs
    - HQ: Itasca, IL

---

### Outreach Strategy (Month 1-3)

**Multi-Channel Approach**:

**1. Warm Introductions** (Best ROI)

- Leverage board/advisors for insurance industry connections
- VC firms often have insurance LPs (portfolio support)
- Trade association introductions (LIMRA, AHIP)
- LinkedIn 2nd-degree connections

**2. Conference Networking**

- **LIMRA Annual Conference** (April 2026) - Life insurance marketing
- **AHIP Institute** (June 2026) - Health insurance
- **Health 2.0 Conference** (Q2 2026) - Digital health
- **Booth or sponsor?** Probably too early; attend and network

**3. Direct Outreach** (Cold but Targeted)

- Personalized emails to Chief Medical Officers, VPs of Innovation
- LinkedIn InMail to decision-makers
- Reference patent, Mark Egly (inventor credibility)

**4. Thought Leadership**

- Publish article: "Why MZ Carriers Need to Know Their Status"
- Interview Mark Egly on health tech podcast
- LinkedIn posts about genetic privacy + insurance wellness

**Outreach Timeline**:

- **Month 1**: Build target list (50 companies), research decision-makers
- **Month 2**: Begin outreach (5-10/week), secure 15-20 meetings
- **Month 3**: Deep discovery calls, narrow to 5 finalists, select 2 pilots

**Qualification Criteria** (Score 1-5 each):

- Strategic fit (wellness focus, innovation culture)
- Executive sponsorship (engaged CMO/CMO?)
- Budget availability (can they pay for pilot?)
- Speed to decision (can they commit by Month 4?)
- Partnership mindset (collaborative vs. vendor relationship)
- Case study willingness (will they let us publicize?)

**Target**: Select 2 pilot partners by end of Month 3

**Owner**: Head of BD/Sales + CEO

---

### Sales Materials Creation (Month 2-3)

**Deliverables**:

1. **Executive Pitch Deck** (15-20 slides)
   - Problem (genetic discrimination + undiagnosed AATD/MZ)
   - Solution (privacy-protected testing)
   - Market opportunity (MZ = 2-3% of population)
   - Business model (B2B2C, pricing)
   - Competitive advantages (patent, privacy, clinical value)
   - How it works (workflow diagrams)
   - Pilot program overview
   - Team + founder story
   - Case study vision (outcomes we'll measure)
   - Appendix (tech stack, FAQs, patent summary)

2. **One-Pager** (PDF, print-ready)
   - Elevator pitch version
   - Key stats and value prop
   - Use at conferences, leave-behinds

3. **Product Demo** (clickable prototype or video)
   - Customer portal flow
   - Partner dashboard screenshots
   - Test results example (anonymized)

4. **ROI Calculator** (Excel/Google Sheet)
   - Input: # of policyholders, smoking rate, MZ prevalence
   - Output: Lives saved, life expectancy increase, premium collection increase
   - Conservative assumptions, sensitivity analysis

5. **FAQ Document** (10-15 pages)
   - Clinical (What is MZ? Why does it matter?)
   - Privacy (How is data protected? Can we use for underwriting?)
   - Legal (Patent implications, GINA compliance)
   - Commercial (Pricing, contract terms, pilot structure)
   - Technical (Integration requirements, timelines)

6. **Video Explainer** (2-3 minutes)
   - Animated or founder-narrated
   - "What is Fair Underwriting?" for internal champion to share
   - Post on website, use in emails

**Owner**: Head of Marketing + CEO + Designer

---

### Lab Partnership Establishment (Month 2-3)

**Strategy**: Partner with 1 primary lab + 1 backup

**Priority Partners**:

1. **Quest Diagnostics** (Primary Target)
   - Reason: Largest footprint, established AATD testing, physician network
   - Contact: VP Strategic Partnerships, Lab Director
   - Negotiation: Volume pricing, integration, turnaround time SLAs

2. **LabCorp** (Backup or Co-Primary)
   - Reason: #2 in market, competitive to Quest
   - Use as leverage in Quest negotiations

3. **Regional Labs** (Future)
   - Consider for specific markets or backup capacity

**Partnership Terms to Negotiate**:

- **Pricing**: $100-150 per SERPINA1 test (volume discounts at 1K, 5K, 10K tests)
- **AAT Level Testing**: $30-50 per test
- **Turnaround Time**: 7-10 business days for SERPINA1, 3-5 days for AAT levels
- **Sample Collection**: At-home blood spot or saliva + phlebotomy locations
- **Reporting**: Electronic results via API (HL7 or FHIR)
- **CLIA/CAP Certification**: Verify lab compliance
- **Exclusivity**: None (we retain ability to use multiple labs)

**Timeline**:

- Month 2: Initial outreach, NDA, discovery
- Month 3: Negotiate terms, execute contract, technical integration planning

**Owner**: CTO (technical) + CEO (commercial)

---

### Regulatory & Compliance (Month 1-3)

**HIPAA Compliance**:

- ✅ Complete HIPAA Security Risk Assessment
- ✅ Implement required safeguards (encryption, access controls, audit logs)
- ✅ Draft HIPAA policies and procedures
- ✅ Execute Business Associate Agreements (BAAs) with lab partners, hosting providers
- ✅ Employee HIPAA training

**GINA Compliance**:

- ✅ Review patent claims for GINA alignment (Claim 34 is key)
- ✅ Ensure partner contracts prohibit actuarial use of genetic data
- ✅ Legal review of customer consent forms and privacy policy

**State Regulations**:

- ✅ Research genetic testing regulations in pilot partner states
- ✅ Identify any additional licensing requirements (varies by state)
- ✅ Some states require genetic counselor involvement (ensure coverage)

**Insurance Licensing** (if applicable):

- Confirm: Are we a "covered entity" or just a service provider?
- If partnering with insurers (not selling insurance), likely no licensing needed
- Legal counsel review

**FDA/LDT**:

- SERPINA1 testing is established LDT (Laboratory Developed Test)
- Partner labs are CLIA-certified (they handle FDA compliance)
- Monitor FDA LDT regulations (proposed changes)

**Owner**: CEO + outside legal counsel (health law firm)

**Budget**: $25K-50K for legal/compliance

---

### Funding & Financial Management (Month 1-3)

**Seed Round Closure** (if not already complete):

- **Amount**: $2-3M
- **Use of Funds**: Team (60%), product development (25%), operations (15%)
- **Timeline**: Close by end of Month 1 (prerequisite for execution)

**Budget Allocation** (First 3 Months):

- Salaries: $150K-250K (CEO, CTO, BD, Engineering, Marketing, Counselor)
- Product Development: $50K-75K (contractors, tools, AWS)
- Legal/Compliance: $25K-50K (HIPAA, contracts, incorporation)
- Sales/Marketing: $25K-40K (materials, travel, website)
- Operations: $15K-25K (office, software, misc)
- **Total**: $265K-440K

**Burn Rate**: ~$90K-150K/month (Month 1-3)

**Owner**: CEO + CFO (if hired) or fractional CFO

---

### Success Metrics (Phase 1)

| Metric                          | Target                            | Owner     |
| ------------------------------- | --------------------------------- | --------- |
| MVP Completion                  | 100% by Month 3                   | CTO       |
| Core Team Hired                 | 5-7 people                        | CEO       |
| Pilot Partner Qualified Leads   | 50 companies                      | BD        |
| Pilot Partner Finalist Meetings | 15-20 meetings                    | BD        |
| Pilot Partners Selected         | 2 signed LOIs                     | CEO + BD  |
| Lab Partnership                 | 1-2 contracts signed              | CEO       |
| HIPAA Compliance                | Audit complete, no major findings | CTO       |
| Sales Materials                 | All 6 deliverables complete       | Marketing |
| Seed Funding                    | $2-3M closed                      | CEO       |

---

## Phase 2: Pilot Launch (Months 4-9, Q2-Q3 2026)

### Objectives

- ✅ Launch with 2 pilot partners
- ✅ Enroll 500-2,500 customers total across pilots
- ✅ Achieve 20%+ MZ detection rate (proving clinical value)
- ✅ Collect clinical outcomes data (smoking cessation, PFT improvements)
- ✅ Iterate product based on feedback
- ✅ Maintain <10% customer churn/dissatisfaction

---

### Pilot Program Structure

**Pilot Duration**: 6 months (Month 4-9)

**Pilot Pricing** (Discounted):

- **Option A**: Fixed fee per pilot: $25K-50K (covers up to 1,000 tests)
- **Option B**: Per-test pricing: $75-100/test (vs. $120-180 at scale)
- **Rationale**: Subsidized to secure partnership, prove value, gather case study

**Pilot Enrollment**:

- **Target**: 500-1,500 customers per pilot partner (1,000-3,000 total)
- **Enrollment Method**:
  - Email campaign to policy holders (partner sends)
  - Wellness portal integration (if partner has existing platform)
  - Open enrollment period (2-4 weeks)
- **Eligibility**: All adult policyholders (age 18+)
- **Incentive**: Free test (usually $150-250 value), early health insight

**Pilot Success Metrics** (Measured at 6 months):

1. **Enrollment Rate**: % of eligible policyholders who enroll (target: 5-15%)
2. **Completion Rate**: % enrolled who complete testing (target: >80%)
3. **MZ Detection Rate**: # of MZ carriers identified (expect: 2-3% of tested)
4. **Genetic Counseling Utilization**: % of MZ carriers who complete counseling (target: >60%)
5. **Smoking Cessation**: % of MZ smokers who enroll in cessation program (target: >30%)
6. **Customer Satisfaction**: NPS score (target: >50)
7. **Partner Satisfaction**: Partner NPS, willingness to continue (target: "very likely" 9-10/10)

---

### Pilot Partner Onboarding (Month 4)

**Week 1-2: Contract Execution**

- Finalize pilot agreement (legal review, signatures)
- Execute BAA (HIPAA)
- Payment terms (upfront or milestone-based)

**Week 3-4: Technical Integration**

- SSO setup (if partner has existing auth system)
- Data exchange protocols (eligibility lists, enrollment status)
- Partner dashboard access provisioning
- Training for partner team (wellness coordinator, CMO, customer service)

**Week 4: Marketing Preparation**

- Co-branded email templates (Fair Underwriting + Partner)
- FAQ for partner customer service team
- Educational materials (What is AATD?, Why test?, Privacy protection)
- Press release coordination (if pilot partners agree to PR)

**Month 4, Week 4: Pilot Launch** 🚀

---

### Customer Enrollment & Testing (Month 4-9)

**Enrollment Workflow**:

1. **Awareness**: Partner sends email/portal message to eligible policyholders
2. **Sign-Up**: Customer clicks link → Fair Underwriting portal → creates account
3. **Consent**: Customer reviews informed consent, privacy policy → electronic signature
4. **Test Kit Order**: Customer selects sample collection method:
   - At-home blood spot kit (mailed to home)
   - Lab visit (Quest/LabCorp location finder)
5. **Sample Collection**: Customer collects sample, mails back (or visits lab)
6. **Lab Processing**: Lab receives sample → SERPINA1 analysis → results to Fair Underwriting
7. **Results Delivery**: Customer receives secure email → logs in to portal → views results
8. **Genetic Counseling** (if MZ, SZ, or ZZ): Customer schedules consultation with genetic counselor
9. **Action Plan**: Customer receives personalized recommendations (lifestyle, monitoring, family screening)

**Timeline**: 2-4 weeks from enrollment to results

---

### Results Interpretation & Counseling (Month 4-9)

**Results Categories**:

1. **Normal (MM, MS)**: ~95-97% of customers
   - Result: "You have normal AAT levels and no AATD variants"
   - Action: Standard health maintenance
   - Counseling: Optional (FAQ-based, automated)

2. **MZ Carrier**: ~2-3% of customers ⭐ **KEY VALUE**
   - Result: "You have one Z variant (MZ). This increases risk of lung and liver disease."
   - Action: Genetic counseling (scheduled), lifestyle modifications, monitoring
   - Counseling: Required (30-45 min session with genetic counselor)
   - Follow-Up: Smoking cessation resources, family screening guidance

3. **SZ or ZZ (Severe AATD)**: ~0.1-0.5% of customers
   - Result: "You have significant AAT deficiency and should consult a pulmonologist/hepatologist."
   - Action: Referral to specialist, genetic counseling, consider augmentation therapy
   - Counseling: Required (60 min session)
   - Follow-Up: Referral to AlphaNet or AATD specialist center

**Genetic Counselor Workload**:

- Assume 3% MZ detection rate
- 1,000 customers → 30 MZ carriers → 30 counseling sessions (15-20 hours/week for 2-3 weeks)
- Assume 0.3% SZ/ZZ → 3 severe cases → 3 hours counseling
- **Total**: ~20-25 counseling hours per 1,000 customers

**Genetic Counselor Hiring**:

- **Pilot Phase**: 1 part-time genetic counselor (20-30 hours/week)
- **Scale Phase**: Add 1 FTE genetic counselor per 5,000-10,000 customers

---

### Data Collection & Analysis (Month 4-9)

**Primary Outcomes** (Pilot Case Study):

1. **MZ Detection Rate**: How many MZ carriers did we identify?
2. **Previously Undiagnosed**: How many had no prior AATD knowledge?
3. **Smoking Status**: % of MZ carriers who smoke
4. **Intervention Uptake**: % who enroll in smoking cessation, pulmonology visit, family screening
5. **Customer Satisfaction**: NPS, testimonials
6. **Partner ROI**: Estimated lives saved, life expectancy increase (actuarial model)

**Secondary Outcomes**:

- Portal engagement (logins, time spent, content viewed)
- Genetic counseling effectiveness (customer feedback)
- Test completion rate and drop-off points
- Customer demographics (age, gender, geography)

**Data Collection Methods**:

- Automated (portal analytics, test results database)
- Surveys (post-result NPS, 3-month follow-up)
- Interviews (select customers for testimonials)
- Partner feedback (monthly check-ins)

**Analysis Timeline**:

- **Month 6**: Mid-pilot review (preliminary data)
- **Month 9**: Final pilot analysis (complete data)
- **Month 10**: Case study write-up

---

### Product Iteration (Month 5-9)

**Expected Learnings & Iterations**:

**Common Issues** (from beta testing):

1. **Low enrollment rate** → Improve messaging, add incentives
2. **Test kit confusion** → Better instructions, video tutorial
3. **Results anxiety** → Pre-result education, expectation setting
4. **Genetic counseling bottleneck** → Scale capacity, async options (recorded videos + Q&A)
5. **Partner dashboard lacks key metrics** → Add requested reports

**Iteration Cadence**:

- **Weekly**: Bug fixes, minor UI improvements
- **Bi-weekly**: Feature releases based on feedback
- **Monthly**: Partner review meeting (demo improvements, gather feedback)

**Engineering Team**: CTO + 2 engineers (add 1 more in Month 5 if needed)

---

### Success Metrics (Phase 2)

| Metric                       | Target                              | Measurement          | Owner      |
| ---------------------------- | ----------------------------------- | -------------------- | ---------- |
| Pilot Partners Launched      | 2                                   | Signed contracts     | CEO        |
| Customers Enrolled           | 1,000-3,000                         | Portal registrations | BD         |
| Tests Completed              | 800-2,400 (80%+ completion)         | Lab reports          | Operations |
| MZ Carriers Detected         | 20-75 (2-3% of tested)              | Genetic results      | Medical    |
| Genetic Counseling Sessions  | 20-75 (100% of MZ)                  | Scheduling data      | Medical    |
| Smoking Cessation Enrollment | 6-22 (30%+ of MZ smokers)           | Referral tracking    | Medical    |
| Customer NPS                 | >50                                 | Post-result survey   | Marketing  |
| Partner NPS                  | 9-10/10 ("very likely to continue") | Partner survey       | BD         |
| Product Iterations           | 8-12 releases                       | Dev velocity         | CTO        |

---

## Phase 3: Proof of Concept (Months 10-12, Q4 2026)

### Objectives

- ✅ Complete pilot case studies (2 detailed write-ups)
- ✅ Sign 2-3 additional partners (expanding beyond pilots)
- ✅ Achieve 5,000-10,000 total customers
- ✅ Raise Series A funding ($10-15M)
- ✅ Expand team (12-15 total employees)

---

### Case Study Development (Month 10-11)

**Case Study Structure** (per pilot partner):

1. **Executive Summary** (1 page)
   - Partner profile
   - Pilot overview (timeline, enrollment)
   - Key results (MZ detection, interventions, ROI)

2. **Background** (1-2 pages)
   - Partner challenges (health outcomes, costs)
   - Why Fair Underwriting?
   - Pilot objectives

3. **Implementation** (2-3 pages)
   - Enrollment strategy
   - Customer communication
   - Technical integration
   - Timeline and milestones

4. **Results** (3-4 pages)
   - MZ detection rate and total carriers identified
   - Customer demographics and risk factors
   - Intervention uptake (smoking cessation, specialist visits)
   - Customer satisfaction (NPS, testimonials)
   - Partner satisfaction and feedback

5. **ROI Analysis** (2-3 pages)
   - Cost of pilot ($25K-50K)
   - Value delivered:
     - Lives saved (actuarial model)
     - Life expectancy increase (years added)
     - Premium collection increase (estimated $)
   - Cost per MZ detected
   - Comparison to alternative interventions

6. **Customer Stories** (1-2 pages)
   - 2-3 anonymized testimonials
   - "I didn't know I had MZ. Now I've quit smoking and I'm monitoring my lung function."

7. **Lessons Learned & Next Steps** (1 page)
   - What worked well
   - What to improve
   - Partner's plans for continued/expanded program

**Total Length**: 10-15 pages per case study

**Deliverables**:

- PDF for sales use
- Web version for marketing site
- Press release (if partner approves)
- Conference presentation (LIMRA, AHIP)

**Timeline**:

- Month 10: Data analysis, draft writing
- Month 11: Partner review and approval, finalization
- Month 12: Publication, PR, sales enablement

**Owner**: Head of Marketing + CEO, with partner collaboration

---

### Partner Expansion (Month 10-12)

**Target**: Sign 2-3 new partners (beyond the 2 pilots)

**Outreach Strategy**:

- **Leverage case studies**: "Here's proof it works with [Pilot Partner A]"
- **Warm introductions**: Pilots can refer peer insurers
- **Conference presentations**: LIMRA, AHIP (Q4 2026/Q1 2027)
- **Press coverage**: "Fair Underwriting detects 50 MZ carriers in [Pilot Partner] program"

**Target Partner Profiles**:

- Mid-to-large regional insurers (same as pilot criteria)
- Diversify by geography (if pilots are Midwest, add West Coast partner)
- Consider 1 health insurer + 2 life insurers (or vice versa)

**Sales Process** (Month 10-12):

1. **Lead Generation**: 20-30 new qualified leads (conferences, case study interest)
2. **Discovery Calls**: 15-20 meetings (demonstrate pilot results)
3. **Proposals**: 5-8 formal proposals
4. **Negotiations**: 3-5 in final negotiations
5. **Contracts Signed**: 2-3 new partners by end of Month 12

**Pricing** (Post-Pilot):

- Transition from pilot pricing ($75-100/test) to standard pricing ($120-180/test)
- Annual minimums or volume commitments
- Multi-year contracts (2-3 years preferred)

**Owner**: Head of BD/Sales

---

### Series A Fundraising (Month 10-12)

**Timing**: Raise Series A during/after pilot completion (proof of concept)

**Amount**: $10-15M

**Valuation**: $40-60M post-money (based on traction, market potential)

**Use of Funds**:

- Sales & Marketing (40%): Expand BD team, marketing, conferences
- Product Development (25%): Enhance platform, mobile app, API integrations
- Operations (20%): Genetic counselors, customer success, lab capacity
- General & Administrative (15%): Finance, HR, legal, office

**Investor Targeting**:

- **Healthcare-focused VCs**: Andreessen Horowitz (Bio + Health), Khosla Ventures, Section 32, Foresite Capital
- **Insurance-focused VCs**: Montage Ventures (insurtech), Aquiline Capital
- **Strategic Investors**: Insurance companies (corporate VC arms), Lab companies (Quest, LabCorp)

**Fundraising Materials**:

- Updated pitch deck (now with pilot results)
- Case studies (proof of concept)
- Financial model (updated with actuals from pilot)
- Investor data room (legal docs, contracts, IP)

**Timeline**:

- Month 10: Begin investor outreach, prep data room
- Month 11: Partner meetings, due diligence
- Month 12: Term sheets, close Series A

**Owner**: CEO + CFO (if hired)

---

### Team Expansion (Month 10-12)

**Additional Hires** (Close by Month 12):

7. **VP Sales** (if Head of BD transitions to CEO role) or **Sales Manager**
   - Owns partner pipeline, sales process, revenue targets
   - Experience: B2B enterprise sales, preferably insurance
   - Equity: 0.5-1%

8. **Customer Success Manager**
   - Owns partner onboarding, support, retention
   - Experience: B2B customer success, health tech
   - Equity: 0.25-0.5%

9. **Full-Time Genetic Counselor** (transition from part-time)
   - Increases capacity for growing customer base
   - Salary: $75K-95K + benefits

10. **Product Manager**
    - Owns product roadmap, feature prioritization, user research
    - Experience: B2B2C products, health tech
    - Equity: 0.5-0.75%

11. **Data Analyst / Scientist**
    - Analyzes clinical outcomes, ROI, cohort studies
    - Builds predictive models (risk stratification)
    - Salary: $100K-130K

**Total Headcount by Month 12**: 12-15 employees

**Owner**: CEO (hiring) + Heads of Departments (managing)

---

### Success Metrics (Phase 3)

| Metric                              | Target                   | Owner     |
| ----------------------------------- | ------------------------ | --------- |
| Case Studies Published              | 2 complete               | Marketing |
| New Partners Signed                 | 2-3 contracts            | BD        |
| Total Customers Enrolled            | 5,000-10,000 cumulative  | BD        |
| MZ Carriers Detected                | 100-300 cumulative       | Medical   |
| Series A Funding Raised             | $10-15M closed           | CEO       |
| Team Headcount                      | 12-15 employees          | CEO       |
| Revenue (Pilot Fees + New Partners) | $150K-400K ARR           | CEO       |
| Customer NPS                        | >60                      | Marketing |
| Partner Retention                   | 100% (both pilots renew) | BD        |

---

## Phase 4: Scale (Months 13-18, Q1-Q2 2027)

### Objectives

- ✅ Scale to 8-12 total partners
- ✅ Enroll 50,000-100,000 total customers
- ✅ Achieve $5M-12M ARR
- ✅ Expand to 25-35 employees
- ✅ Launch mobile app and API integrations
- ✅ Begin international expansion planning (Canada, UK)

---

### Partner Acquisition at Scale (Month 13-18)

**Target**: Add 4-6 new partners (beyond the 4-5 from Phases 2-3)

**Sales Team Expansion**:

- VP Sales + 2-3 Account Executives (AEs)
- 1 Sales Engineer (technical demos, integration scoping)
- 1 Sales Operations / BizOps (CRM, pipeline management, forecasting)

**Sales Process Optimization**:

- **Avg Sales Cycle**: 3-6 months (from first meeting to signed contract)
- **Conversion Rate**: 20-30% (from qualified lead to signed contract)
- **Pipeline Coverage**: 3-4x (e.g., need $12M pipeline for $3M ARR target)

**Marketing & Lead Generation**:

- **Inbound**: Website, SEO, content marketing, webinars
- **Outbound**: Conference sponsorships, industry partnerships, direct outreach
- **Referrals**: Existing partners refer peers (incentivize with discounts or co-marketing)

**Target Partners** (Expand Beyond Initial Focus):

- Large national insurers (now that we have proof of concept)
- International insurers (Canada, UK pilot)
- Self-insured employers (direct wellness programs)

**Partner Onboarding Process** (Systematized):

- Weeks 1-2: Contract execution, payment, kickoff meeting
- Weeks 3-4: Technical integration (SSO, data feeds, dashboard setup)
- Weeks 5-6: Marketing preparation (co-branded materials, training)
- Week 7: Launch enrollment campaign
- Weeks 8-12: Monitor enrollment, optimize messaging
- Month 3+: Ongoing support, quarterly business reviews

**Owner**: VP Sales + Customer Success Manager

---

### Product Enhancements (Month 13-18)

**Major Features to Launch**:

1. **Mobile App** (iOS + Android)
   - Native app for better customer engagement
   - Push notifications for results, appointments
   - Easier access to genetic counseling

2. **Partner API**
   - RESTful API for partner systems integration
   - Eligibility checks, enrollment status, aggregated analytics
   - Documentation and developer portal

3. **Advanced Analytics Dashboard**
   - Predictive modeling (which customers most likely to benefit from intervention?)
   - Cohort analysis (compare outcomes across demographics)
   - Cost-benefit calculator (real-time ROI for partners)

4. **Certification Badge Program**
   - Launch Bronze/Silver/Gold/Platinum tiers
   - Embeddable widgets for partner websites
   - Public verification page

5. **Family Screening Module**
   - MZ carriers can invite family members to test
   - Discounted testing for relatives
   - Family tree visualization

**Engineering Team Expansion**:

- Add 2-3 more engineers (frontend, backend, mobile)
- Total engineering team: 5-6 engineers + CTO

**Owner**: CTO + Product Manager

---

### Operational Scaling (Month 13-18)

**Genetic Counseling Scale**:

- **Workload**: 50K-100K customers → 1,000-3,000 MZ carriers
- **Counseling Hours**: 1,000-3,000 sessions × 30-45 min = 500-2,250 hours
- **Team**: Hire 2-3 additional genetic counselors (FTE)
- **Efficiency**: Develop pre-recorded educational videos, group webinars, async FAQ

**Lab Partnership Scale**:

- **Volume**: 50K-100K tests (up from 5K-10K in Phase 3)
- **Negotiate**: Volume discounts (e.g., $90/test at 50K volume)
- **Capacity**: Ensure Quest/LabCorp can handle surge; add 2nd lab if needed
- **Turnaround**: Monitor and improve (target 7 days → 5 days)

**Customer Support**:

- **Hire**: 2-3 customer support specialists
- **Tools**: Zendesk or Intercom for ticketing
- **SLA**: <24 hour response time, <90% satisfaction

**Owner**: VP Operations (new hire, Month 13-15)

---

### Financial Management & Metrics (Month 13-18)

**Revenue Targets**:

- **ARR**: $5M-12M (8-12 partners × $400K-1M per partner)
- **Customer Base**: 50K-100K enrolled
- **ARPU**: $100-120 per customer (blended across partners)

**Unit Economics**:

- **CAC** (Customer Acquisition Cost): $50-100 per customer (partner-paid enrollment marketing + our sales cost allocated)
- **LTV** (Lifetime Value): $300-500 per customer (3-5 years retention × $100-120/year)
- **LTV:CAC Ratio**: 3-5x (healthy SaaS metric)

**Burn Rate**: $500K-800K/month (Month 13-18)

- Series A funding ($10-15M) provides 12-18 month runway
- Plan Series B for Month 20-24

**KPIs to Track** (Weekly/Monthly):

- MRR/ARR (Monthly/Annual Recurring Revenue)
- Net New MRR (new partners + expansions - churn)
- Customer Acquisition (new enrollments)
- MZ Detection Rate (clinical outcomes)
- Customer NPS (satisfaction)
- Partner NPS (retention leading indicator)
- Gross Margin (revenue - COGS, target 70-80%)
- Burn Multiple (cash burned / net new ARR, target <1.5x)

**Owner**: CFO (hire in Month 13-15)

---

### Marketing & Brand Building (Month 13-18)

**Content Marketing**:

- Blog: 2-3 posts/week (AATD education, genetic privacy, partner stories)
- Webinars: Monthly for prospects (insurers, employers)
- Podcasts: Founder interviews, thought leadership
- Research: Publish outcomes data (anonymized, aggregated)

**PR & Media**:

- Press releases: Funding, partnerships, milestones
- Media coverage: Healthcare, insurance, genetics publications
- Awards: Apply for innovation awards (insurtech, digital health)

**Conferences & Trade Shows**:

- **Sponsor**: LIMRA, AHIP, Health 2.0
- **Speak**: Submit speaking proposals (CMO, CEO, Medical Director)
- **Booth**: Demo product, collect leads

**Website Optimization**:

- SEO: Rank for "AATD testing", "MZ carrier", "genetic testing insurance"
- Conversion Rate Optimization: A/B test landing pages, CTAs
- Case Studies: Publish on site, gated for lead generation

**Social Media**:

- LinkedIn: Company page, founder thought leadership
- Twitter: Engage with genetics, insurance, healthtech communities
- YouTube: Explainer videos, customer testimonials

**Owner**: Head of Marketing + 1-2 Marketing Coordinators

---

### International Expansion Planning (Month 16-18)

**Target Markets** (for future expansion):

1. **Canada** (Highest Priority)
   - Similar insurance market, cultural proximity
   - Universal healthcare + private supplemental insurance
   - Genetic non-discrimination laws (GINA equivalent)

2. **United Kingdom**
   - NHS + private health insurance
   - Strong genetic privacy protections
   - Established AATD research community

3. **Australia**
   - Similar to Canada/UK
   - Growing insurtech market

**Month 16-18 Activities**:

- ✅ Market research (insurance landscape, regulations, competitors)
- ✅ Legal review (data privacy, genetic testing laws, insurance regulations)
- ✅ Identify potential pilot partners (1-2 insurers per country)
- ✅ Adapt product (language, units, local lab partnerships)
- ✅ Plan launch for Month 24-30 (post-Series B)

**Owner**: CEO + VP International (future hire)

---

### Success Metrics (Phase 4)

| Metric                   | Target                        | Owner             |
| ------------------------ | ----------------------------- | ----------------- |
| Total Partners           | 8-12                          | Sales             |
| Total Customers Enrolled | 50K-100K cumulative           | Sales + Marketing |
| MZ Carriers Detected     | 1,000-3,000 cumulative        | Medical           |
| ARR                      | $5M-12M                       | CEO               |
| Gross Margin             | 70-80%                        | CFO               |
| Customer NPS             | >65                           | Marketing         |
| Partner Retention        | >90%                          | Customer Success  |
| Team Headcount           | 25-35 employees               | CEO               |
| Mobile App Launch        | iOS + Android live            | Product           |
| API Launch               | Public API + 2-3 integrations | Product           |

---

## Key Roles & Responsibilities (GTM Team)

| Role                         | Primary Responsibilities                                      | Hire Timeline                                   |
| ---------------------------- | ------------------------------------------------------------- | ----------------------------------------------- |
| **CEO**                      | Strategy, fundraising, partnerships, culture                  | Founder                                         |
| **CTO**                      | Product development, technical architecture, engineering team | Month 1                                         |
| **Head of BD/Sales**         | Pilot partner acquisition, sales strategy, pipeline           | Month 2                                         |
| **VP Sales**                 | Scale partner acquisition, sales team management              | Month 10                                        |
| **Head of Marketing**        | Brand, content, website, demand generation                    | Month 3                                         |
| **Genetic Counselor(s)**     | Customer consultations, educational content                   | Month 2 (PT), Month 10 (FT), Month 15 (2-3 FTE) |
| **Customer Success Manager** | Partner onboarding, support, retention                        | Month 10                                        |
| **Product Manager**          | Product roadmap, feature prioritization, user research        | Month 11                                        |
| **CFO**                      | Financial management, fundraising, board reporting            | Month 13                                        |
| **VP Operations**            | Lab partnerships, customer support, operational scaling       | Month 14                                        |

---

## Budget Summary (18 Months)

| Phase                   | Duration     | Headcount | Burn Rate     | Total Spend | Cumulative Revenue | Net Cash       |
| ----------------------- | ------------ | --------- | ------------- | ----------- | ------------------ | -------------- |
| **Phase 1: Foundation** | Months 1-3   | 5-7       | $90K-150K/mo  | $270K-450K  | $0                 | -$270K-450K    |
| **Phase 2: Pilot**      | Months 4-9   | 7-10      | $150K-250K/mo | $900K-1.5M  | $50K-100K          | -$850K-1.4M    |
| **Phase 3: Proof**      | Months 10-12 | 12-15     | $250K-400K/mo | $750K-1.2M  | $100K-300K         | -$650K-900K    |
| **Phase 4: Scale**      | Months 13-18 | 25-35     | $500K-800K/mo | $3M-4.8M    | $2M-6M             | -$1M to +$1.2M |
| **Total**               | 18 months    | 5 → 35    | —             | $4.9M-7.95M | $2.15M-6.4M        | -$2.77M-1.55M  |

**Funding Required**:

- **Seed**: $2-3M (covers Phase 1-2, part of Phase 3)
- **Series A**: $10-15M (covers Phase 3-4, + runway into Series B)

**Revenue by Month 18**: $5M-12M ARR (annualized)

---

## Risk Mitigation Strategies

### Risk: Pilot Partners Don't Renew

**Mitigation**:

- Set clear expectations upfront (pilot is 6 months, renewal based on outcomes)
- Over-communicate during pilot (monthly check-ins, share early data)
- Build strong relationships with multiple stakeholders (not just one champion)
- Deliver ROI: Even if small scale, show proof of value (MZ detection, interventions)

### Risk: Low Customer Enrollment (<5%)

**Mitigation**:

- Partner with marketing experts on enrollment campaigns
- Test multiple messaging approaches (fear-based, benefit-based, free health insight)
- Incentivize enrollment (raffle for Apple Watch, $25 gift card)
- Simplify enrollment process (1-click from email)

### Risk: MZ Detection Rate Lower Than Expected (<2%)

**Mitigation**:

- This is biological reality; set expectations with partners (2-3% is the science)
- Emphasize even 1-2% is meaningful (600-1,200 MZ carriers per 50K customers)
- Highlight other value (ZZ detection, customer engagement, health education)

### Risk: Regulatory Delays (FDA, State Laws)

**Mitigation**:

- Work with experienced regulatory counsel from Day 1
- Use established lab partners (Quest, LabCorp) who handle CLIA/FDA compliance
- Stay current on FDA LDT regulations (propose d changes)
- Start in states with favorable genetic testing laws, expand gradually

### Risk: Competitor Launches Similar Offering

**Mitigation**:

- Patent protection (Claim 34 is defensible)
- First-mover advantage (by the time competitor launches, we have case studies and partnerships)
- Deep partnerships (harder to displace than transactional vendor)
- Continuous innovation (stay ahead on product features)

---

## Conclusion: 18-Month Roadmap Summary

**Month 1-3**: Build foundation (product, team, pilot partner selection)
**Month 4-9**: Launch pilots, prove clinical + economic value
**Month 10-12**: Case studies, expand to 2-3 more partners, raise Series A
**Month 13-18**: Scale to 8-12 partners, 50K-100K customers, $5M-12M ARR

**By Month 18**:

- ✅ Proven business model (pilot results, case studies)
- ✅ Scaled operations (25-35 employees, robust platform)
- ✅ Strong market position (8-12 insurance partners, thought leadership)
- ✅ Funded for growth (Series A in bank, Series B in sight)
- ✅ Clear path to $100M+ ARR (continue partner acquisition, international expansion)

**Next Milestone**: Series B fundraising (Month 20-24) to accelerate to 50+ partners and international markets.

---

**Document Owner**: CEO + Head of BD/Sales
**Review Frequency**: Monthly (adjust based on actual progress)
**Last Updated**: November 7, 2025
**Next Review**: December 7, 2025 (after Phase 1 Month 1 completion)
