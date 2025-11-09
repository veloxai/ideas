# Fair Underwriting - Risk Register

**Last Updated**: November 7, 2025
**Purpose**: Comprehensive risk identification, assessment, and mitigation strategies
**Status**: Living Document (Updated Quarterly)

---

## Executive Summary

This risk register identifies **potential threats** to Fair Underwriting's success across **clinical, regulatory, business, technical, and reputational** domains, with corresponding **mitigation strategies** and **contingency plans**.

**Risk Management Framework**:

- **Likelihood**: Low (10-30%), Medium (30-70%), High (>70%)
- **Impact**: Low (minor setback), Medium (significant setback), High (business-threatening)
- **Risk Score**: Likelihood × Impact (1-9 scale)
- **Priority**: Critical (8-9), High (5-7), Medium (3-4), Low (1-2)

**Risk Categories**:

1. **Clinical Risks** (test accuracy, counseling quality, adverse events)
2. **Regulatory Risks** (FDA, HIPAA, GINA, state laws)
3. **Business Risks** (partner acquisition, enrollment, pricing, competition)
4. **Technical Risks** (platform, integrations, data breaches)
5. **Reputational Risks** (privacy concerns, negative press, customer dissatisfaction)
6. **Financial Risks** (capital, cash flow, unit economics)
7. **Operational Risks** (lab capacity, counseling capacity, supply chain)

---

## Risk Management Process

### 1. Risk Identification (Ongoing)

**Sources**:

- Leadership team brainstorming (quarterly)
- Customer feedback (NPS surveys, support tickets)
- Partner feedback (business reviews)
- Industry trends (conferences, news, competitor analysis)
- Regulatory updates (FDA, CMS, state laws)

---

### 2. Risk Assessment (Quarterly)

**Criteria**:

- **Likelihood**: What's the probability this risk will materialize?
- **Impact**: If it happens, how bad is it?
- **Velocity**: How quickly could this risk escalate?
- **Detectability**: How early can we detect warning signs?

---

### 3. Risk Mitigation (Proactive)

**Strategies**:

- **Avoid**: Eliminate risk entirely (e.g., don't operate in states with strict genetic testing laws)
- **Reduce**: Minimize likelihood or impact (e.g., insurance, redundancy, quality controls)
- **Transfer**: Shift risk to third party (e.g., lab partner, insurance company)
- **Accept**: Acknowledge risk, monitor, have contingency plan (e.g., low-likelihood, low-impact risks)

---

### 4. Risk Monitoring (Ongoing)

**Key Risk Indicators (KRIs)**:

- Test error rate (clinical quality)
- Enrollment rate (business viability)
- Partner churn rate (business sustainability)
- System uptime (technical reliability)
- NPS scores (customer satisfaction, reputational risk)
- Regulatory inquiries (compliance risk)

---

## Section 1: Clinical Risks

### Risk 1.1: Test Result Error (False Positive/Negative)

**Description**: Laboratory incorrectly reports genotype (e.g., reports MZ when actually MM, or MM when actually MZ)

**Likelihood**: Low (10-20%)

- Quest/LabCorp CLIA/CAP-certified, 99.9% accuracy
- Multiple quality controls (duplicate testing, positive/negative controls)

**Impact**: High

- **False positive (reports MZ when MM)**: Customer unnecessary anxiety, interventions (smoking cessation, annual tests), family screening—but ultimately unnecessary
- **False negative (reports MM when MZ)**: Customer misses opportunity for intervention, may develop preventable COPD/liver disease
- **Legal liability**: Malpractice lawsuit, regulatory action

**Risk Score**: 2 (Low Likelihood × High Impact = Medium-Low Priority)

**Mitigation**:

- ✅ **Contract with reputable labs** (Quest, LabCorp—CLIA/CAP-certified, proven track record)
- ✅ **Quality control protocols**: Labs run positive/negative controls with each batch
- ✅ **Confirmatory testing**: For discordant results (genotype doesn't match AAT level), repeat testing from new sample
- ✅ **Lab liability**: Contract requires lab to carry professional liability insurance, indemnify Fair Underwriting for testing errors
- ✅ **Transparent communication**: If error discovered, immediately notify customer, offer free confirmatory testing, apologize, document in portal

**Contingency Plan**:

- If test error discovered: (1) Notify customer within 24 hours, (2) Apologize and explain, (3) Offer free confirmatory testing, (4) Provide free genetic counseling to address anxiety, (5) Document incident, (6) Review with lab partner to prevent recurrence

**KRI**: Test error rate (<0.1% target)

---

### Risk 1.2: Genetic Counseling Quality Issues

**Description**: Genetic counselor provides incorrect information, poor communication, or insensitive delivery—customer confused, anxious, or dissatisfied

**Likelihood**: Medium (30-40%)

- Counselors are human—variability in communication skills, knowledge, empathy
- High-volume scaling → pressure to rush sessions

**Impact**: Medium

- Customer dissatisfaction (low NPS)
- Poor outcomes (MZ carrier doesn't quit smoking because counselor didn't effectively motivate)
- Reputation damage (negative reviews, partner dissatisfaction)

**Risk Score**: 5 (Medium Likelihood × Medium Impact = High Priority)

**Mitigation**:

- ✅ **Hire qualified counselors**: Licensed genetic counselors (ABGC-certified), experience with AATD
- ✅ **Training**: Standardized training on MZ carrier counseling (scripts, role-plays, feedback)
- ✅ **Quality assurance**: Record sessions (with consent), review 10% randomly for quality, provide feedback
- ✅ **NPS tracking**: Survey customers after counseling session, identify low scores for follow-up
- ✅ **Supervision**: Senior genetic counselor reviews cases, provides mentorship for junior counselors

**Contingency Plan**:

- If customer complaint: (1) Apologize, (2) Offer second counseling session with senior counselor (free), (3) Document feedback, (4) Review session recording, (5) Provide counselor coaching, (6) If pattern of complaints, terminate counselor

**KRI**: Genetic counseling NPS (target >60)

---

### Risk 1.3: Adverse Event (Customer Harm)

**Description**: Customer experiences physical or psychological harm related to Fair Underwriting services (e.g., panic attack upon learning MZ result, suicide ideation, incorrect medical decision based on results)

**Likelihood**: Low (10-20%)

- Genetic results can cause anxiety, but rarely lead to severe psychological harm
- Medical decisions should involve doctors, not just genetic counselors

**Impact**: High

- Legal liability (malpractice, wrongful death lawsuit)
- Reputation damage (media coverage, partner termination)
- Regulatory scrutiny (FDA, state health department investigation)

**Risk Score**: 3 (Low Likelihood × High Impact = Medium Priority)

**Mitigation**:

- ✅ **Crisis protocols**: Genetic counselors trained to identify suicidal ideation, refer to crisis hotline (988) or emergency services
- ✅ **Physician involvement**: Results include recommendation to "discuss with your doctor"—we don't provide medical advice
- ✅ **Informed consent**: Clear disclosure of risks (anxiety, impact on family), right to decline testing
- ✅ **Psychological support**: Partner with mental health professionals (therapist referrals for customers who need more support)
- ✅ **Insurance**: Professional liability insurance ($2M per claim, $5M aggregate) covers malpractice claims

**Contingency Plan**:

- If adverse event: (1) Ensure customer safe (call 911 if immediate danger), (2) Document incident, (3) Notify insurance carrier, (4) Notify legal counsel, (5) Cooperate with investigations, (6) Review protocols to prevent recurrence

**KRI**: Adverse event count (target: 0)

---

## Section 2: Regulatory Risks

### Risk 2.1: FDA Regulation of SERPINA1 Test

**Description**: FDA reclassifies SERPINA1 testing from Laboratory Developed Test (LDT) to Class II/III device, requiring 510(k) or PMA approval—expensive, time-consuming

**Likelihood**: Medium (40-50%)

- FDA has proposed LDT regulation (2023 rule), but implementation timeline uncertain
- SERPINA1 is established clinical test (ATS/ERS guidelines) → likely Class II (510(k), moderate burden)

**Impact**: High

- **510(k) approval**: $100K-300K cost, 6-12 months timeline, requires clinical validation
- **Delay to market**: If regulation goes into effect before approval, must halt testing
- **Competitive advantage loss**: Larger competitors (Quest, LabCorp) have resources to navigate FDA—Fair Underwriting at disadvantage

**Risk Score**: 7 (Medium Likelihood × High Impact = High Priority)

**Mitigation**:

- ✅ **Monitor FDA**: Track LDT rulemaking (Federal Register, industry associations like ACMG)
- ✅ **Partner with labs**: Quest/LabCorp responsible for FDA compliance (they offer SERPINA1 testing, would obtain 510(k) if required)
- ✅ **Budget for 510(k)**: Set aside $200K-300K (Year 2-3) in case Fair Underwriting needs to sponsor 510(k) application
- ✅ **Lobby**: Join industry coalitions (ACMG, ACLA) advocating for reasonable LDT regulation
- ✅ **Grandfathering**: If rule includes grandfather clause (tests performed before effective date exempt), launch ASAP to qualify

**Contingency Plan**:

- If FDA requires 510(k): (1) Engage regulatory consultant ($50K-100K), (2) Compile clinical validation data, (3) Submit 510(k) application, (4) Maintain operations during review (if grandfathered), or (5) Pause new enrollments if not grandfathered, (6) Communicate transparently with partners ("temporary pause due to FDA regulatory requirements")

**KRI**: FDA rulemaking status (monitor quarterly)

---

### Risk 2.2: HIPAA Breach / Data Privacy Violation

**Description**: Unauthorized access, disclosure, or loss of Protected Health Information (PHI)—customer genetic data, health info

**Likelihood**: Low-Medium (20-30%)

- Cyberattacks increasingly common (healthcare sector targeted)
- Human error (employee accidentally emails PHI to wrong recipient, leaves laptop unencrypted)

**Impact**: High

- **Legal penalties**: $100-$50,000 per violation (HIPAA civil penalties), up to $1.5M per year for identical violations
- **Customer harm**: Identity theft, genetic discrimination, emotional distress
- **Reputation damage**: Media coverage ("Fair Underwriting leaked genetic data"), partner terminations
- **Business disruption**: Lawsuits, regulatory investigations, customer churn

**Risk Score**: 6-7 (Low-Medium Likelihood × High Impact = High Priority)

**Mitigation**:

- ✅ **Encryption**: AES-256 at rest, TLS 1.3 in transit (all PHI encrypted)
- ✅ **Access controls**: Role-based access (RBAC), multi-factor authentication (MFA), least privilege principle
- ✅ **Audit logging**: All PHI access logged, retained 7 years, reviewed monthly for anomalies
- ✅ **Security assessments**: Annual risk assessments (HIPAA Security Rule), penetration testing (3rd party)
- ✅ **Employee training**: Annual HIPAA training (all employees), phishing simulations (quarterly)
- ✅ **Incident response plan**: Written plan (detect, contain, investigate, notify, remediate)
- ✅ **Cyber insurance**: $5M per incident, $10M aggregate (covers breach response costs, legal fees, settlements)
- ✅ **Business Associate Agreements**: All vendors handling PHI sign BAAs (AWS, Cloudflare, labs, counseling firms)

**Contingency Plan**:

- If breach: (1) Contain breach (disable compromised accounts, patch vulnerabilities), (2) Investigate (forensics—what data accessed? how many customers affected?), (3) Notify customers within 60 days (HIPAA Breach Notification Rule), (4) Notify HHS (if >500 customers affected, submit breach report), (5) Notify partners, (6) Notify media (if >500 customers, post on website), (7) Offer credit monitoring/identity theft protection (Experian, LifeLock—$50-100/customer/year), (8) Cooperate with investigations (HHS OCR, state AGs), (9) Review security controls, fix gaps

**KRI**: Security incidents (target: 0 breaches), penetration test vulnerabilities (target: 0 critical, <5 high-severity)

---

### Risk 2.3: State-Level Genetic Testing Restrictions

**Description**: State laws prohibit or heavily restrict genetic testing (e.g., NY requires genetic counselor in-state, genetic testing lab located in-state)

**Likelihood**: Medium (30-40%)

- Some states (NY, CA, MA, RI, NJ) have strict genetic testing laws
- Laws evolving (could become more or less restrictive)

**Impact**: Medium

- **Geographic limitation**: Can't operate in certain states (reduces addressable market by 10-30%)
- **Compliance costs**: Hire in-state genetic counselors, contract with in-state labs (higher costs)
- **Partner limitations**: Can't partner with insurers in restricted states

**Risk Score**: 5 (Medium Likelihood × Medium Impact = High Priority)

**Mitigation**:

- ✅ **3-tier strategy** (from Regulatory Compliance Guide):
  - **Tier 1 (favorable states)**: Launch first (IA, NE, TX, FL—minimal restrictions)
  - **Tier 2 (moderate states)**: Expand second (CA, MA—compliance feasible)
  - **Tier 3 (strict states)**: Defer until scale (NY—complex, expensive compliance)
- ✅ **Legal analysis**: Engage healthcare attorney to analyze each state's laws before entering market
- ✅ **Compliance budget**: Set aside $50K-100K/year for state-specific compliance (in-state counselors, labs, legal filings)
- ✅ **Advocacy**: Work with industry associations (NSGC, ACMG) to advocate for genetic testing access

**Contingency Plan**:

- If state law prohibits operation: (1) Don't enter that state (focus on favorable states), (2) Partner with insurers in other states, (3) Monitor law changes (could be repealed/relaxed), (4) Consider lobbying (if large partner in that state wants Fair Underwriting)

**KRI**: State law tracking (review quarterly)

---

## Section 3: Business Risks

### Risk 3.1: Low Partner Acquisition (Can't Close Pilots)

**Description**: Insurers not interested in partnering—don't see value, too busy, legal/compliance concerns

**Likelihood**: Medium-High (50-60%)

- Insurers risk-averse, slow decision-making (6-12 month sales cycles)
- Competing priorities (many wellness vendors pitching)
- Uncertain ROI (longevity benefits take years to materialize)

**Impact**: High

- **No pilots → no proof → no scale**: Business model depends on pilots to build case studies
- **Burn cash**: If can't close pilots within 6-9 months, burn through Seed funding without revenue

**Risk Score**: 8-9 (Medium-High Likelihood × High Impact = CRITICAL Priority)

**Mitigation**:

- ✅ **Target selection**: Focus on ideal partners (see Pilot Program Design—wellness-forward, mid-size, innovation culture)
- ✅ **Warm intros**: Leverage networks (investors, advisors, conferences) for introductions (vs. cold outreach)
- ✅ **Compelling value prop**: Emphasize MZ detection (1 in 25-40 policyholders), smoking cessation ROI, differentiation
- ✅ **Reduce friction**: Pilot-friendly terms (per-test pricing, 6-month pilot, easy exit), pre-vetted legal docs (MSA, BAA, DPA)
- ✅ **Social proof**: Once 1st pilot signed, leverage as reference for others ("Join [Northwestern Mutual] in pioneering genetic wellness")
- ✅ **Multiple approaches**: Life insurance (longevity focus), health insurance (medical cost savings), disability insurance (disability prevention)
- ✅ **Conferences**: Exhibit at LIMRA, AHIP (face-to-face relationship building, 1000+ insurance execs attend)

**Contingency Plan**:

- If can't close 2-3 pilots by Month 9: (1) **Pivot to DTC** (direct-to-consumer model—sell directly to individuals at $99-199/test), (2) **Lower pricing** (offer first 3 pilots at breakeven or loss-leader—$50/test), (3) **Extended Seed raise** ($1M-2M bridge financing to extend runway), (4) **Partner with labs** (white-label for Quest/LabCorp—they sell to insurers, Fair Underwriting provides technology), (5) **Acquihire** (sell IP/team to larger player if business not viable)

**KRI**: Partner pipeline (target: 5-10 active prospects), pilot conversion rate (target: 20-30% of proposals → signed contracts)

---

### Risk 3.2: Low Enrollment Rate (Customers Don't Sign Up)

**Description**: Eligible customers don't enroll in testing—don't see value, too busy, privacy concerns, genetic testing stigma

**Likelihood**: Medium (40-50%)

- Wellness programs typically see 5-15% engagement
- Genetic testing more personal, potentially scary (higher barrier)

**Impact**: High

- **Failed pilots**: If enrollment <3%, partner dissatisfied, won't renew, bad case study
- **Unproven model**: Can't demonstrate value if no customers enroll
- **Revenue shortfall**: Per-test pricing means low enrollment = low revenue

**Risk Score**: 7-8 (Medium Likelihood × High Impact = High Priority)

**Mitigation**:

- ✅ **Compelling messaging**: Emphasize "1 in 25-40 have genetic risk, most don't know" (create urgency)
- ✅ **Privacy assurance**: "Patent-protected privacy—your insurer will NOT see your results" (reduce fear)
- ✅ **Ease of use**: At-home kit (mail to door, drop in mailbox), 5-min enrollment, no doctor visit required
- ✅ **Incentives** (if needed): Raffle ($500 gift card), charitable donation ($10 to American Lung Association per enrollment), gamification (badges, leaderboards)
- ✅ **Multi-channel campaign**: Email (primary), SMS (reminders), portal banner (always visible), webinars (Q&A with genetic counselor)
- ✅ **A/B testing**: Test subject lines, messaging (fear-based vs. benefit-based), incentives
- ✅ **Partner engagement**: Partner sends emails (higher open rates than Fair Underwriting), partner CEO endorsement ("I encourage all members to take advantage...")

**Contingency Plan**:

- If enrollment <3% in first month of pilot: (1) **Extended timeline** (give 4 more weeks), (2) **Add incentives** (raffle, gift cards), (3) **Targeted outreach** (narrow to high-risk subset—smokers, family history of COPD), (4) **Webinar** (live Q&A with genetic counselor addresses concerns), (5) **Partner collaboration** (ask partner to send additional emails, promote in newsletter), (6) **Refine messaging** (A/B test new subject lines, landing page copy)

**KRI**: Enrollment rate (target: 5-15%), funnel conversion (track drop-off at each stage—email open, link click, enrollment start, enrollment complete, sample order)

---

### Risk 3.3: Competition (Larger Players Enter Market)

**Description**: Quest, LabCorp, 23andMe, or insurer (e.g., Kaiser) launches competing AATD screening program

**Likelihood**: Medium (30-40%)

- AATD screening not yet mainstream, but could become standard of care (ATS/ERS guidelines support testing)
- If Fair Underwriting succeeds, competitors may copy

**Impact**: Medium-High

- **Price pressure**: Competitors undercut pricing (Fair Underwriting forced to lower fees → worse margins)
- **Partner loss**: Partners switch to competitor (larger brand, more established)
- **Reduced differentiation**: Fair Underwriting's unique value (privacy framework, MZ focus) becomes commoditized

**Risk Score**: 5-6 (Medium Likelihood × Medium-High Impact = High Priority)

**Mitigation**:

- ✅ **Patent moat**: US 20220165374 protects privacy framework (insurer cannot access individual results)—Fair Underwriting can license or litigate
- ✅ **First-mover advantage**: Build case studies, partnerships before competitors enter → incumbency advantage
- ✅ **Specialization**: Deep focus on AATD, MZ carriers (vs. competitors' broad genetic panels) → subject matter expertise
- ✅ **Customer experience**: Superior portal, genetic counseling, education → higher NPS → partner loyalty
- ✅ **Platform expansion**: Beyond AATD (add other genetic tests, lifestyle programs) → become genetic wellness platform, not just AATD screener
- ✅ **Partner lock-in**: Multi-year contracts, high switching costs (SSO integration, change management)

**Contingency Plan**:

- If competitor launches: (1) **Double down on differentiation** (patent-protected privacy, MZ expertise), (2) **Competitive pricing** (match or undercut if necessary), (3) **Accelerate product roadmap** (add features competitors lack—mobile app, API, family screening), (4) **Strategic partnerships** (co-branding with Alpha-1 Foundation, ALA for credibility), (5) **Consider acquisition** (if competitor is larger, consider selling Fair Underwriting to them as acquihire)

**KRI**: Competitor activity (monitor quarterly—track news, conference presentations, patent filings)

---

## Section 4: Technical Risks

### Risk 4.1: Platform Downtime / Outage

**Description**: Fair Underwriting portal/website unavailable—customers can't enroll, view results, book counseling

**Likelihood**: Low-Medium (20-30%)

- AWS 99.99% uptime (rare outages, but possible)
- Code bugs, DDoS attacks, human error (accidental deletion)

**Impact**: Medium

- **Customer dissatisfaction**: Can't access results (anxiety, frustration), poor NPS
- **Enrollment disruption**: If outage during pilot launch, enrollment rate suffers
- **Revenue loss**: If prolonged (>24 hours), customers may give up
- **Reputation damage**: "Fair Underwriting is unreliable"

**Risk Score**: 4-5 (Low-Medium Likelihood × Medium Impact = High-Medium Priority)

**Mitigation**:

- ✅ **Cloud infrastructure**: AWS (99.99% SLA), multi-AZ deployment (automatic failover)
- ✅ **Monitoring**: Uptime monitoring (Pingdom, UptimeRobot), alerts (Slack, PagerDuty) if downtime detected
- ✅ **Incident response**: On-call DevOps engineer (24/7), runbooks for common issues
- ✅ **Backups**: Daily database backups (AWS RDS automated backups), 30-day retention
- ✅ **DDoS protection**: Cloudflare (mitigates DDoS attacks)
- ✅ **Load testing**: Pre-launch load testing (simulate 10x traffic), identify bottlenecks

**Contingency Plan**:

- If outage: (1) **Detect quickly** (monitoring alerts), (2) **Diagnose** (check AWS status, logs, code), (3) **Fix** (rollback code, increase capacity, contact AWS support), (4) **Communicate** (status page, email to customers: "We're experiencing technical issues, working to resolve ASAP"), (5) **Post-mortem** (root cause analysis, fix underlying issue, prevent recurrence)

**KRI**: Uptime (target: 99.5%), mean time to resolution (MTTR—target: <2 hours)

---

### Risk 4.2: Integration Failures (SSO, Data Feeds)

**Description**: SSO (single sign-on) or data feeds to partner systems break—customers can't log in, partner can't access dashboard data

**Likelihood**: Medium (30-40%)

- Integrations are complex, many moving parts (partner IT changes on their end, breaking integration)

**Impact**: Medium

- **Customer friction**: Can't log in with partner credentials, must create separate Fair Underwriting account (reduces enrollment)
- **Partner dissatisfaction**: Can't access dashboard data, perceive Fair Underwriting as unreliable

**Risk Score**: 5 (Medium Likelihood × Medium Impact = High-Medium Priority)

**Mitigation**:

- ✅ **Testing**: Thorough testing before launch (UAT with partner IT team)
- ✅ **Monitoring**: Alerts if SSO or data feeds fail (detect within minutes)
- ✅ **Documentation**: Clear integration guides for partner IT teams
- ✅ **Support**: Dedicated DevOps engineer for integration troubleshooting
- ✅ **Fallback**: Manual process (if SSO fails, customers can still enroll directly on Fair Underwriting site; if data feed fails, send reports via email)

**Contingency Plan**:

- If integration fails: (1) **Detect** (monitoring alert), (2) **Diagnose** (work with partner IT to identify issue—their change or ours?), (3) **Fix** (update code, coordinate with partner IT), (4) **Communicate** (notify partner: "We're aware of the issue, working to resolve"), (5) **Fallback** (if fix takes >24 hours, implement manual workaround)

**KRI**: Integration uptime (target: 99%), partner support tickets related to integrations (target: <5/month)

---

## Section 5: Reputational Risks

### Risk 5.1: Privacy Breach / Genetic Discrimination Scandal

**Description**: Media reports "Fair Underwriting shares genetic data with insurers" or "MZ carrier denied coverage due to Fair Underwriting test"—even if false or unrelated, Fair Underwriting's reputation damaged

**Likelihood**: Low (10-20%)

- Fair Underwriting's patent-protected privacy framework prevents data sharing with insurers
- GINA (federal law) prohibits genetic discrimination in health insurance and employment
- However, misperception or edge case (e.g., customer voluntarily shares, then claims discrimination) could generate negative press

**Impact**: High

- **Customer churn**: Existing customers delete accounts, demand data deletion
- **Enrollment collapse**: New customers afraid to enroll ("I don't want my insurer to know")
- **Partner terminations**: Insurers distance themselves ("We can't be associated with genetic discrimination")
- **Business failure**: Reputation is everything in privacy-sensitive genetic testing—scandal could be fatal

**Risk Score**: 3-4 (Low Likelihood × High Impact = Medium Priority)

**Mitigation**:

- ✅ **Privacy by design**: Patent-protected framework (US 20220165374) ensures insurer cannot access individual results
- ✅ **Transparency**: Clear privacy policy, informed consent, FAQ ("Will my insurer see my results? NO.")
- ✅ **Legal protections**: GINA, state laws (educate customers on protections)
- ✅ **Monitoring**: Google Alerts for "Fair Underwriting" + "genetic discrimination", social media monitoring (Twitter, Reddit)
- ✅ **Crisis comms plan**: Prepared statements, media spokesperson (CEO), rapid response team
- ✅ **Proactive PR**: Thought leadership (articles, conference talks) positioning Fair Underwriting as privacy champion

**Contingency Plan**:

- If scandal: (1) **Assess** (is it true? partial truth? completely false?), (2) **Respond quickly** (within 6-24 hours—silence looks like guilt), (3) **Transparency** (if mistake on our part, acknowledge, apologize, explain fix; if false, clarify facts), (4) **Media outreach** (proactive interviews with fair reporters—WSJ, NYT, healthcare trade press), (5) **Customer communication** (email all customers: "Your data is safe, here's what happened and how we're protecting you"), (6) **Partner communication** (reassure partners, provide talking points), (7) **Monitor sentiment** (track social media, NPS, partner feedback), (8) **Long-term reputation repair** (case studies showing privacy protection, third-party audits, certifications)

**KRI**: Media mentions (track sentiment—positive, neutral, negative), customer NPS (target: >40), partner NPS (target: >50)

---

### Risk 5.2: Low Customer Satisfaction (Poor NPS)

**Description**: Customers have bad experience—confusing portal, long wait for results, unhelpful genetic counseling, poor support → low NPS (<20)

**Likelihood**: Medium (30-40%)

- Startups often have rough edges (bugs, incomplete features, overwhelmed support)
- Genetic testing is high-stakes, emotional—small issues feel big

**Impact**: Medium

- **Poor word-of-mouth**: Customers tell friends/family "Don't bother with Fair Underwriting"
- **Low enrollment**: Family members don't sign up (viral growth doesn't work)
- **Partner dissatisfaction**: Partners see low NPS, perceive Fair Underwriting as low-quality, don't renew

**Risk Score**: 5 (Medium Likelihood × Medium Impact = High-Medium Priority)

**Mitigation**:

- ✅ **User testing**: Test portal with 10-20 beta users before launch, iterate based on feedback
- ✅ **Customer support**: Responsive support (email, chat, phone), <24 hour response time
- ✅ **NPS surveys**: After enrollment, after results, after genetic counseling (identify pain points quickly)
- ✅ **Genetic counselor training**: Standardized training, quality assurance (session recordings reviewed)
- ✅ **Proactive outreach**: Check-in emails at 1 week, 1 month, 3 months ("How are you doing? Need help?")
- ✅ **Rapid iteration**: Fix bugs, improve UX based on feedback (2-week sprint cycles)

**Contingency Plan**:

- If NPS drops below 20: (1) **Root cause analysis** (what's driving dissatisfaction? portal? counseling? results delivery?), (2) **Fix issues** (prioritize top 3 pain points, sprint to fix), (3) **Win-back campaign** (email dissatisfied customers: "We heard you, here's what we've improved"), (4) **Incentives** (offer free service upgrade or gift card to dissatisfied customers who give us second chance)

**KRI**: NPS (target: >40 overall, >60 for genetic counseling), customer support volume (target: <10% of customers contact support)

---

## Section 6: Financial Risks

### Risk 6.1: Inability to Raise Capital (Seed, Series A)

**Description**: Can't raise Seed ($2-3M) or Series A ($10-15M) funding—investors not interested, market downturn, Fair Underwriting hasn't proven traction

**Likelihood**: Medium (30-50%)

- Biotech/healthtech fundraising challenging (capital-intensive, long time to revenue, regulatory risk)
- Market conditions (interest rates, recession, investor risk appetite) fluctuate

**Impact**: High

- **Runway runs out**: Can't pay employees, shut down operations
- **Business failure**: Without capital, can't scale pilots → no proof → no revenue → game over

**Risk Score**: 6-8 (Medium Likelihood × High Impact = High Priority)

**Mitigation**:

- ✅ **Strong pitch deck**: Compelling narrative (large market, unmet need, patent moat, experienced team)
- ✅ **Traction before fundraise**: Close 1-2 pilots before Series A (proves concept, de-risks investment)
- ✅ **Investor targeting**: Healthcare/biotech VCs (familiar with long sales cycles, regulatory complexity), impact investors (social mission—lives saved)
- ✅ **Warm intros**: Leverage networks (advisors, board, existing investors) for introductions (cold emails rarely work)
- ✅ **Multiple lead options**: Talk to 20-30 VCs, expect 2-3 term sheets (don't count on one)
- ✅ **Bridge financing**: If Series A delayed, raise $1M-2M bridge (from existing investors, angels) to extend runway

**Contingency Plan**:

- If can't raise Series A: (1) **Extend runway** (cut OpEx by 30-50%—lay off non-essential staff, reduce marketing spend), (2) **Revenue focus** (shift to revenue-generating activities—charge higher pilot fees, upsell subscriptions), (3) **Alternative funding** (grants—NIH SBIR, CDC, patient foundations; revenue-based financing), (4) **Strategic acquisition** (sell to larger player if business not viable independently—Quest, LabCorp, pharma company), (5) **Pivot** (DTC model requires less capital than B2B2C)

**KRI**: Cash runway (target: >12 months at all times), fundraising pipeline (target: 10-20 active VC conversations before runway drops below 18 months)

---

### Risk 6.2: Negative Unit Economics (LTV < CAC)

**Description**: Customer lifetime value (LTV) is lower than customer acquisition cost (CAC)—business model unprofitable, can't scale

**Likelihood**: Medium (30-40%)

- One-time test model (vs. subscription) has low LTV ($15-75 gross profit per customer if test-only)
- Partner acquisition expensive ($50K-200K per partner)
- If enrollment rate low (<5%), CAC per customer high ($30-50)

**Impact**: High

- **Unsustainable growth**: Each new customer loses money → more customers = more losses
- **Investor concern**: VCs want LTV:CAC >3x → if <2x, hard to raise next round

**Risk Score**: 5-6 (Medium Likelihood × High Impact = High Priority)

**Mitigation**:

- ✅ **Subscription model**: Shift to annual subscriptions ($10-30/year for monitoring) → LTV $100-250 (vs. $15-75 test-only)
- ✅ **Increase pricing**: Raise per-test fee from $75 to $100-150 (if market supports)
- ✅ **Reduce COGS**: Negotiate lab discounts ($25-40 → $20-30 with volume), improve genetic counseling efficiency (group sessions, automated pre-counseling education)
- ✅ **Improve enrollment**: Higher enrollment rate (10% vs. 5%) → lower per-customer CAC (partner acquisition cost spread over more customers)
- ✅ **Viral growth**: Family screening (MZ carriers refer relatives) → CAC $0 for referred customers

**Contingency Plan**:

- If LTV:CAC <2x after Year 2: (1) **Pivot to subscription-first model** (annual genetic wellness membership $150-300/year), (2) **Increase pricing** (test fee $150-200), (3) **Cut partner acquisition costs** (focus on organic referrals from existing partners vs. outbound sales), (4) **Expand platform** (add other genetic tests, health coaching → increase LTV to $500-1,000)

**KRI**: LTV:CAC ratio (target: 3-6x), CAC payback period (target: 12-24 months), gross margin (target: 30-50% blended)

---

## Section 7: Operational Risks

### Risk 7.1: Lab Capacity Shortage

**Description**: Quest/LabCorp can't process tests fast enough—long turnaround times (>14 days), customer dissatisfaction

**Likelihood**: Low-Medium (20-30%)

- Labs have capacity, but if Fair Underwriting scales faster than expected (e.g., 10K tests/month vs. expected 1K), labs may struggle

**Impact**: Medium

- **Delayed results**: Customers wait 3-4 weeks (vs. promised 2 weeks) → poor NPS
- **Partner dissatisfaction**: Slow results reflect poorly on Fair Underwriting

**Risk Score**: 3-4 (Low-Medium Likelihood × Medium Impact = Medium Priority)

**Mitigation**:

- ✅ **Dual lab partnerships**: Contract with Quest AND LabCorp (load balance, backup if one has capacity issues)
- ✅ **Volume forecasting**: Share enrollment projections with labs monthly (allows them to plan capacity)
- ✅ **SLA penalties**: Contract includes penalties if turnaround time >14 days for >10% of tests (e.g., 10% fee reduction)
- ✅ **Alternative labs**: Identify backup labs (regional labs, specialty AATD labs) if Quest/LabCorp both fail

**Contingency Plan**:

- If lab delays: (1) **Communicate proactively** (email customers: "Your results are taking longer than expected, we're working to expedite"), (2) **Escalate with lab** (account manager, vice president of operations), (3) **Split volume** (shift some tests to backup lab), (4) **Offer compensation** (free AAT monitoring for 1 year, $25 gift card) to dissatisfied customers

**KRI**: Lab turnaround time (target: median 7-10 days, 90th percentile <14 days), % tests >14 days (target: <10%)

---

### Risk 7.2: Genetic Counseling Capacity Shortage

**Description**: Not enough genetic counselors to meet demand—MZ carriers wait >7 days for counseling session (vs. target 48 hours for urgent, 7 days for standard)

**Likelihood**: Medium (30-40%)

- Genetic counselors are in short supply (ABGC reports 80% employment rate, high demand)
- If Fair Underwriting scales rapidly, counselor hiring may lag

**Impact**: Medium

- **Customer dissatisfaction**: MZ carriers anxious, want immediate counseling, frustrated by wait
- **Poor outcomes**: Delayed counseling → MZ carriers don't get smoking cessation support quickly → less effective intervention

**Risk Score**: 5 (Medium Likelihood × Medium Impact = High-Medium Priority)

**Mitigation**:

- ✅ **Hire ahead of demand**: Onboard 2-3 genetic counselors before pilot launch, add 1-2 per 1,000 tests/month
- ✅ **Contract with counseling firms**: Partner with telehealth genetic counseling companies (e.g., InformedDNA, Genetic Counseling Services) for overflow capacity
- ✅ **Group counseling**: Offer group sessions for normal results (MM, MS)—10-20 customers per session, 30 min → reduces counselor time
- ✅ **Automated pre-counseling**: Video education, interactive modules (customers self-serve common questions before counseling) → reduces session time from 45 to 30 min
- ✅ **Triage**: Urgent cases (ZZ, SZ) get priority scheduling (within 48 hours), MZ carriers within 7 days, normal results (MM, MS) optional counseling

**Contingency Plan**:

- If counseling backlog: (1) **Hire contract counselors** (temporary, part-time), (2) **Extend hours** (evenings, weekends), (3) **Prioritize** (ZZ/SZ first, MZ second, MM/MS last), (4) **Communicate** (email MZ carriers: "High demand for counseling—your session will be scheduled within 10 days"), (5) **Offer alternatives** (recorded video counseling, written Q&A, phone support as interim)

**KRI**: Genetic counseling wait time (target: median 2-3 days for MZ, <5% wait >7 days), counselor utilization (target: 70-85%—if >85%, hire more; if <70%, reduce capacity)

---

## Risk Summary Dashboard

| **Risk ID** | **Risk**                   | **Likelihood** | **Impact** | **Score** | **Priority** | **Mitigation Status**                                     |
| ----------- | -------------------------- | -------------- | ---------- | --------- | ------------ | --------------------------------------------------------- |
| **1.1**     | Test result error          | Low            | High       | 2         | Medium-Low   | ✅ Mitigated (CLIA/CAP labs, QC protocols)                |
| **1.2**     | Genetic counseling quality | Medium         | Medium     | 5         | High         | ✅ Mitigated (training, QA, NPS tracking)                 |
| **1.3**     | Adverse event              | Low            | High       | 3         | Medium       | ✅ Mitigated (crisis protocols, insurance)                |
| **2.1**     | FDA regulation             | Medium         | High       | 7         | High         | ⚠️ Monitoring (FDA LDT rule, 510(k) budget)               |
| **2.2**     | HIPAA breach               | Low-Med        | High       | 6-7       | High         | ✅ Mitigated (encryption, audits, insurance)              |
| **2.3**     | State restrictions         | Medium         | Medium     | 5         | High         | ✅ Mitigated (3-tier strategy, legal analysis)            |
| **3.1**     | Low partner acquisition    | Med-High       | High       | **8-9**   | **CRITICAL** | ⚠️ Active (target partners, warm intros, value prop)      |
| **3.2**     | Low enrollment             | Medium         | High       | 7-8       | High         | ⚠️ Active (messaging, incentives, A/B testing)            |
| **3.3**     | Competition                | Medium         | Med-High   | 5-6       | High         | ✅ Mitigated (patent moat, first-mover, specialization)   |
| **4.1**     | Platform downtime          | Low-Med        | Medium     | 4-5       | Med-High     | ✅ Mitigated (AWS 99.99% SLA, monitoring, backups)        |
| **4.2**     | Integration failures       | Medium         | Medium     | 5         | Med-High     | ✅ Mitigated (testing, monitoring, fallback)              |
| **5.1**     | Privacy scandal            | Low            | High       | 3-4       | Medium       | ✅ Mitigated (privacy by design, crisis comms plan)       |
| **5.2**     | Low customer NPS           | Medium         | Medium     | 5         | Med-High     | ✅ Mitigated (user testing, support, iteration)           |
| **6.1**     | Can't raise capital        | Medium         | High       | 6-8       | High         | ⚠️ Active (strong pitch, traction, investor targeting)    |
| **6.2**     | Negative unit economics    | Medium         | High       | 5-6       | High         | ⚠️ Active (subscription model, pricing, COGS reduction)   |
| **7.1**     | Lab capacity               | Low-Med        | Medium     | 3-4       | Medium       | ✅ Mitigated (dual labs, SLA penalties)                   |
| **7.2**     | Counseling capacity        | Medium         | Medium     | 5         | Med-High     | ✅ Mitigated (hire ahead, contract firms, group sessions) |

---

## Risk Review Process

**Quarterly Risk Review** (Board Meeting):

- Review risk register (update likelihoods, impacts based on latest data)
- Discuss critical/high-priority risks (mitigation progress, contingency plans)
- Identify new risks (emerging threats, industry changes)
- Update mitigation strategies

**Monthly Risk Monitoring** (Leadership Team):

- Review KRIs (Key Risk Indicators)
- Flag risks trending in wrong direction (e.g., enrollment rate dropping, NPS declining)
- Rapid response for emerging issues

**Annual Risk Refresh**:

- Comprehensive review of all risks
- Retire resolved risks, add new risks
- Update risk framework (likelihood/impact criteria)

---

## Conclusion

This **Risk Register** provides Fair Underwriting with **comprehensive risk management framework** covering:

- **17 major risks** across clinical, regulatory, business, technical, reputational, financial, and operational domains
- **Likelihood, impact, and priority** ratings for each risk
- **Mitigation strategies** (proactive actions to reduce risk)
- **Contingency plans** (reactive actions if risk materializes)
- **Key Risk Indicators (KRIs)** for ongoing monitoring

**Top 3 Critical/High Risks** (focus areas):

1. **Partner acquisition** (Risk 3.1): Can't close pilots → business fails → Mitigation: target selection, warm intros, compelling value prop
2. **Enrollment rate** (Risk 3.2): Customers don't sign up → failed pilots → Mitigation: messaging, incentives, A/B testing
3. **Capital raising** (Risk 6.1): Can't raise funding → run out of cash → Mitigation: strong pitch, traction, investor targeting

**Next Steps**:

1. **Share with board** (governance oversight)
2. **Assign risk owners** (each risk has executive owner responsible for mitigation)
3. **Implement KRI tracking** (dashboard with real-time risk indicators)
4. **Quarterly reviews** (update risk register based on progress)

---

**Document Owner**: CEO + COO + Board of Directors
**Review Frequency**: Quarterly (comprehensive), Monthly (KRI monitoring)
**Last Updated**: November 7, 2025
**Next Review**: February 7, 2026
