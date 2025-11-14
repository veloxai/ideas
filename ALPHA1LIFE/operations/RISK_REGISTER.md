# Alpha1Life.com - Risk Register

**Project**: Alpha1Life.com Patient-Facing Platform
**Organization**: Mark Egly Foundation for Alpha-1 Awareness
**Document Type**: Risk Management & Mitigation
**Created**: November 13, 2025
**Status**: Planning Phase
**Review Frequency**: Quarterly

---

## 🎯 Executive Summary

This Risk Register identifies, assesses, and provides mitigation strategies for **potential risks** that could impact the successful launch and operation of Alpha1Life.com. Risks are categorized by type, rated by likelihood and impact, and assigned owners responsible for monitoring and response.

**Risk Categories**:

1. Technical Risks (platform, security, infrastructure)
2. Operational Risks (staffing, processes, capacity)
3. Financial Risks (funding, sustainability, budgets)
4. Compliance/Legal Risks (HIPAA, liability, copyright)
5. Reputational Risks (community, trust, brand)
6. Strategic Risks (competition, relevance, mission drift)

**Risk Rating Scale**:

- **Likelihood**: Low (1), Medium (2), High (3)
- **Impact**: Low (1), Medium (2), High (3)
- **Risk Score**: Likelihood × Impact (1-9, where 6-9 = High Priority)

---

## 🔴 Critical Risks (Score 6-9)

### RISK-001: Data Breach / Security Incident

**Category**: Technical - Security
**Risk Score**: 6 (Likelihood: 2, Impact: 3)
**Owner**: IT Director / External Security Consultant

**Description**: Unauthorized access to patient data, forum posts, or donation information could result from hacking, malware, or insider threat.

**Impact if Occurs**:

- Loss of patient trust (catastrophic for health community)
- Legal liability (HIPAA violations, state privacy laws)
- Financial cost (breach notification, legal fees, fines)
- Reputational damage (media coverage, donor loss)
- Potential shutdown of platform

**Likelihood Factors**:

- WordPress is common target for hackers
- Patient health data is attractive to bad actors
- Small nonprofit may lack robust security resources

**Mitigation Strategies**:

**Prevention**:

1. **Managed WordPress Hosting**: Use HIPAA-compliant host (Kinsta, WP Engine) with built-in security
2. **SSL Certificate**: Enforce HTTPS across entire site
3. **Strong Authentication**: Require strong passwords, implement 2FA for admin accounts
4. **Security Plugins**: Wordfence or Sucuri for firewall, malware scanning, intrusion detection
5. **Regular Updates**: Auto-update WordPress core, themes, plugins within 24 hours of release
6. **Principle of Least Privilege**: Limit admin access to only necessary staff
7. **Security Audits**: Annual penetration testing by external firm ($3K-$5K)
8. **Staff Training**: Quarterly security awareness training (phishing, social engineering)

**Detection**:

1. **Monitoring**: 24/7 server monitoring with alerts for suspicious activity
2. **Logs**: Review access logs weekly for anomalies
3. **Intrusion Detection**: Automated alerts for failed login attempts, file changes

**Response Plan**:

1. **Incident Response Team**: Pre-identified (Executive Director, IT, Legal, Board Chair)
2. **Communication Plan**: Template for notifying affected users, donors, public
3. **Breach Notification**: Process for complying with HIPAA (60-day notification)
4. **Insurance**: Cyber liability insurance ($1M coverage, ~$2K/year)

**Monitoring**: Monthly security reports, quarterly vulnerability scans

---

### RISK-002: Low User Adoption / Engagement

**Category**: Strategic - Market Fit
**Risk Score**: 6 (Likelihood: 2, Impact: 3)
**Owner**: Executive Director / Community Manager

**Description**: Patients don't find value in Alpha1Life.com, prefer existing resources (Alpha-1 Foundation, Facebook groups), and don't sign up or engage regularly.

**Impact if Occurs**:

- Platform fails to reach critical mass (empty forum, no activity)
- Waste of development investment ($50K-$75K)
- Inability to fundraise (no users = no donors)
- Mission failure (not helping AATD community)
- Board/donor loss of confidence

**Likelihood Factors**:

- Competitive landscape (established Alpha-1 Foundation, Facebook groups)
- Patient inertia (comfortable with current resources)
- Unclear value proposition (why Alpha1Life vs. others?)

**Mitigation Strategies**:

**Prevention**:

1. **Beta Testing**: 50-100 beta testers provide feedback before public launch
2. **User Research**: Interviews with 20+ AATD patients to understand needs
3. **Unique Value Proposition**: Focus on what others don't offer (integrated platform, personalized support, modern UX)
4. **Partnership with Alpha-1 Foundation**: Collaborate, not compete (cross-promotion, complementary services)
5. **Compelling Content**: 20+ high-quality patient stories at launch
6. **SEO Strategy**: Rank for "Alpha-1 support" before launch (6 months content marketing)

**Detection**:

1. **KPI Dashboard**: Monitor signups, MAU, forum posts weekly
2. **Benchmark Targets**: If Month 3 < 500 users, trigger review
3. **User Surveys**: NPS score, reasons for not engaging

**Response Plan**:

1. **Pivot Assessment** (Month 3): If adoption is low, conduct user interviews to identify barriers
2. **Feature Adjustments**: Add/remove features based on feedback
3. **Marketing Boost**: Increase outreach (webinars, events, partnerships)
4. **Incentives**: Gamification, recognition programs to boost engagement
5. **Go/No-Go Decision** (Month 6): If still low adoption, evaluate pivot vs. shutdown

**Monitoring**: Weekly KPI review for first 6 months, monthly thereafter

---

### RISK-003: Key Staff Departure

**Category**: Operational - Staffing
**Risk Score**: 6 (Likelihood: 2, Impact: 3)
**Owner**: Board Chair / Executive Director

**Description**: Loss of Executive Director, Community Manager, or IT Director during critical launch phase could disrupt operations, relationships, and momentum.

**Impact if Occurs**:

- Loss of institutional knowledge (especially ED)
- Disruption to donor relationships (ED departure)
- Community management gap (CM departure)
- Technical knowledge loss (IT departure)
- Delayed launch or feature rollout
- Staff morale impact

**Likelihood Factors**:

- Nonprofit salaries may be below market rate
- Burnout risk (small team, high workload)
- Better opportunities elsewhere

**Mitigation Strategies**:

**Prevention**:

1. **Competitive Compensation**: Benchmark salaries to 50th percentile for nonprofit sector
2. **Professional Development**: $2K/year per staff for training, conferences
3. **Work-Life Balance**: Flexible schedules, remote work options, generous PTO
4. **Clear Career Paths**: Growth opportunities within MEF
5. **Retention Bonuses**: 1-year retention bonus for ED/CM/IT tied to launch milestones
6. **Regular Check-Ins**: Monthly 1-on-1s to address concerns before they escalate

**Detection**:

1. **Stay Interviews**: Quarterly conversations about job satisfaction, concerns
2. **Warning Signs**: Disengagement, decreased performance, complaints

**Response Plan**:

1. **Cross-Training**: Document processes, train backup staff for critical roles
2. **Succession Plan**: Identify internal/external candidates for key roles
3. **Knowledge Transfer**: 30-day notice period required, structured handoff
4. **Consultant Support**: Budget for interim consultants during transition ($10K-$20K)
5. **Board Involvement**: Board members step in temporarily for critical relationships

**Monitoring**: Quarterly staff satisfaction surveys

---

### RISK-004: Insufficient Funding / Fundraising Shortfall

**Category**: Financial - Sustainability
**Risk Score**: 6 (Likelihood: 3, Impact: 2)
**Owner**: Executive Director / Board Treasurer

**Description**: Donations don't meet projections, forcing cuts to staff, features, or operations. Unable to sustain platform long-term.

**Impact if Occurs**:

- Staff reductions (reduce service quality)
- Feature cuts (reduce value proposition)
- Reduced marketing (reduce user acquisition)
- Platform shutdown (worst case, Year 2-3)
- Damage to MEF reputation

**Likelihood Factors**:

- Unproven fundraising model (donation-driven community platform)
- Economic downturn (recession impacts donations)
- Donor fatigue (competing asks from Alpha-1 Foundation, AlphaNet)
- Low user base (small donor pool)

**Mitigation Strategies**:

**Prevention**:

1. **Diversified Revenue**: Multiple sources (individual, corporate, grants, events)
2. **Conservative Projections**: Budget assumes 70% of revenue projections
3. **Cash Reserve**: Build 6-month operating reserve by Year 2 ($150K)
4. **Grant Applications**: Apply for 5-10 health/rare disease grants (Year 1: $50K-$100K)
5. **Corporate Sponsorships**: Target pharma companies (Grifols, CSL Behring) for $25K-$50K
6. **Major Donors**: Cultivate 5-10 major donors ($5K+ per year)
7. **Monthly Giving**: Focus on recurring donations (predictable revenue)

**Detection**:

1. **Monthly Budget Review**: Actual vs. projected revenue/expenses
2. **Red Flag Triggers**:
   - Revenue 20% below projection for 2 consecutive months
   - Cash reserves below 3 months operating expenses
3. **Quarterly Financial Reports** to Board

**Response Plan**:

1. **Phase 1 Cuts** (if revenue 20% below): Reduce marketing spend, delay non-critical hires
2. **Phase 2 Cuts** (if revenue 30% below): Freeze hiring, cut discretionary expenses
3. **Phase 3 Cuts** (if revenue 40+ below): Staff reductions, feature cuts, consider platform pause
4. **Emergency Fundraising**: Board launches emergency appeal to major donors
5. **Strategic Partnerships**: Explore merger/acquisition by Alpha-1 Foundation

**Monitoring**: Monthly financial dashboard review with Board Treasurer

---

### RISK-005: HIPAA Compliance Violation

**Category**: Compliance/Legal - Privacy
**Risk Score**: 6 (Likelihood: 2, Impact: 3)
**Owner**: Executive Director / Legal Counsel

**Description**: Unintentional violation of HIPAA due to misunderstanding of rules, staff error, or vendor non-compliance. Could result from improper data storage, sharing, or lack of Business Associate Agreements.

**Impact if Occurs**:

- Legal penalties (HHS fines: $100-$50K per violation, up to $1.5M/year)
- Loss of patient trust (catastrophic)
- Media scrutiny
- Potential lawsuits
- Platform shutdown

**Likelihood Factors**:

- Complex HIPAA regulations (easy to misinterpret)
- Staff not trained in healthcare privacy
- Vendors (hosting, email) may not be HIPAA-compliant
- User-generated content (patients may overshare PHI in forum)

**Mitigation Strategies**:

**Prevention**:

1. **Legal Guidance**: Retain healthcare attorney for HIPAA review ($5K-$10K)
2. **HIPAA-Compliant Hosting**: Use host with BAA (Kinsta Health, WP Engine)
3. **Business Associate Agreements (BAAs)**: Execute with ALL vendors handling data (hosting, email, analytics)
4. **Privacy Policy**: Attorney-drafted, HIPAA-compliant, posted prominently
5. **Terms of Service**: Users agree not to post PHI about others
6. **Staff Training**: Annual HIPAA training for all staff (online course, $100/person)
7. **De-Identification**: Forum posts don't require real names (usernames encouraged)
8. **Data Minimization**: Only collect necessary data (don't ask for medical records, diagnoses in profiles)

**Detection**:

1. **Compliance Audits**: Annual HIPAA risk assessment ($3K-$5K)
2. **User Flagging**: Users can flag posts with PHI for review
3. **Moderator Training**: Recognize and address PHI in forum posts

**Response Plan**:

1. **Breach Protocol**: Report to HHS within 60 days if PHI breach >500 individuals
2. **Legal Counsel**: Immediately engage attorney if violation suspected
3. **Remediation**: Correct violation, implement safeguards
4. **Documentation**: Maintain records of compliance efforts (defense against penalties)

**Monitoring**: Annual compliance audit, quarterly policy review

---

## 🟡 Moderate Risks (Score 3-5)

### RISK-006: Website Downtime / Technical Failure

**Category**: Technical - Infrastructure
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: IT Director

**Description**: Website goes down due to server failure, DDoS attack, hosting issues, or plugin conflict.

**Impact**: User frustration, lost engagement, lost donations during downtime (e.g., downtime during AATD Awareness Month fundraising campaign).

**Mitigation**:

- **Managed Hosting**: 99.9% uptime SLA (Kinsta, WP Engine)
- **Monitoring**: Uptime monitoring with alerts (UptimeRobot, Pingdom)
- **Backup**: Daily automated backups, 30-day retention
- **DDoS Protection**: Cloudflare or host-provided DDoS mitigation
- **Response**: 24/7 host support, escalation protocol, status page for users

**Monitoring**: Uptime logs reviewed monthly

---

### RISK-007: Negative Community Behavior (Trolls, Spam, Toxicity)

**Category**: Reputational - Community
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Community Manager

**Description**: Trolls, spammers, or toxic users disrupt forum, post misinformation, or harass members.

**Impact**: Patients feel unsafe, disengage from forum, negative word-of-mouth, moderation burden.

**Mitigation**:

- **Community Guidelines**: Clear rules, prominently posted, enforced consistently
- **Moderation**: Active moderation (daily review, <1 hour response to flags)
- **User Reporting**: Easy flagging system for inappropriate content
- **Account Verification**: Email verification required to post
- **Spam Filters**: Akismet or similar anti-spam plugin
- **Bans**: Clear escalation (warning → temporary ban → permanent ban)
- **Tone Modeling**: Staff/moderators model positive, supportive tone

**Monitoring**: Weekly moderation reports (flags, bans, response time)

---

### RISK-008: Competitor Launch (Facebook, Alpha-1 Foundation)

**Category**: Strategic - Competition
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Executive Director

**Description**: Alpha-1 Foundation or Facebook launches similar community platform, reducing Alpha1Life's differentiation.

**Impact**: Reduced user adoption, harder to fundraise, forced to pivot or compete directly.

**Mitigation**:

- **Partnership Strategy**: Collaborate with Alpha-1 Foundation (not compete)
- **Unique Value**: Focus on integrated, patient-centered experience (vs. clinical focus of Foundation)
- **First-Mover Advantage**: Launch early, build loyal community before competitors
- **Brand Loyalty**: Build strong emotional connection (patient stories, support)
- **Continuous Innovation**: Regularly add features based on user feedback

**Monitoring**: Quarterly competitive analysis (scan for new platforms, features)

---

### RISK-009: Key Vendor Failure (Hosting, Payment Processor)

**Category**: Operational - Vendor
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: IT Director

**Description**: Hosting provider, payment processor (GiveWP/Stripe), or email service (Mailchimp) goes down, changes pricing, or shuts down.

**Impact**: Service disruption, migration costs, lost donations.

**Mitigation**:

- **Reputable Vendors**: Use established, financially stable vendors (Kinsta, Stripe, Mailchimp)
- **Contracts**: Annual contracts with service-level agreements
- **Backup Plans**: Identify backup vendors (e.g., if Kinsta fails, migrate to WP Engine)
- **Data Portability**: Ensure we own and can export all data (mailing lists, content, user data)
- **Diversification**: Don't rely on single vendor for critical services

**Monitoring**: Quarterly vendor health check (financial news, service status)

---

### RISK-010: Scope Creep / Feature Bloat

**Category**: Operational - Project Management
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Executive Director / Project Manager

**Description**: Team adds too many features, trying to be everything to everyone, losing focus on core value proposition.

**Impact**: Delayed launch, budget overruns, complex UX (confuses users), maintenance burden.

**Mitigation**:

- **MVP Mindset**: Launch with core features, add iteratively based on user feedback
- **Feature Prioritization**: Use MoSCoW method (Must-have, Should-have, Could-have, Won't-have)
- **User Feedback**: Only add features users actually request (not assumptions)
- **Roadmap Discipline**: Quarterly roadmap review, limit to 3-5 major features per quarter
- **Saying No**: Executive Director empowered to decline feature requests

**Monitoring**: Monthly project status review (scope, timeline, budget)

---

### RISK-011: Legal Liability (User-Generated Content)

**Category**: Compliance/Legal - Liability
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Executive Director / Legal Counsel

**Description**: User posts illegal content (copyright infringement, medical advice, defamation) or harmful information (e.g., discouraging treatment), creating legal liability for MEF.

**Impact**: Lawsuits, legal fees, reputational damage.

**Mitigation**:

- **Section 230 Protection**: Terms of Service clarify MEF is not publisher of user content
- **DMCA Policy**: Clear process for copyright takedown requests
- **Medical Disclaimer**: Prominent disclaimer that forum is peer support, not medical advice
- **Moderation**: Review flagged content, remove illegal/harmful content promptly
- **Terms of Service**: Users agree to guidelines, acknowledge MEF can remove content
- **Insurance**: General liability insurance ($2M coverage, ~$1.5K/year)

**Monitoring**: Weekly review of flagged content

---

### RISK-012: Mission Drift (Loss of Focus on AATD Community)

**Category**: Strategic - Mission
**Risk Score**: 3 (Likelihood: 1, Impact: 3)
**Owner**: Board of Directors

**Description**: Platform expands to serve other rare diseases or broader audiences, diluting focus on AATD community and expertise.

**Impact**: Loss of niche value proposition, alienates core AATD community, resources spread thin.

**Mitigation**:

- **Mission Statement**: Clear focus on AATD community in charter
- **Board Oversight**: Annual strategic review to ensure mission alignment
- **Community Input**: Patient Advisory Council reviews major strategic decisions
- **Stay Criteria**: Before expanding, must achieve success with AATD (5K+ MAU, financial sustainability)

**Monitoring**: Annual board strategic review

---

### RISK-013: Staff Burnout (Small Team, High Workload)

**Category**: Operational - Staffing
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Executive Director

**Description**: Small team (3-5 FTEs) tries to manage platform, community, fundraising, leading to burnout.

**Impact**: Decreased quality, staff turnover, health issues, poor decision-making.

**Mitigation**:

- **Realistic Workload**: Don't over-commit on features, events, or campaigns
- **Volunteers**: Recruit volunteers for moderation, content creation (reduce staff burden)
- **Automation**: Use tools to automate repetitive tasks (email, social posting, reports)
- **PTO Policy**: Generous PTO (20+ days), enforce taking time off
- **Mental Health Support**: EAP (Employee Assistance Program) for counseling
- **Check-Ins**: Monthly 1-on-1s to assess workload, stress levels

**Monitoring**: Quarterly staff satisfaction surveys, track overtime hours

---

### RISK-014: Economic Downturn / Recession

**Category**: Financial - External
**Risk Score**: 4 (Likelihood: 2, Impact: 2)
**Owner**: Board Treasurer

**Description**: Economic recession reduces individual and corporate donations.

**Impact**: Revenue shortfall, budget cuts, reduced services.

**Mitigation**:

- **Cash Reserve**: 6-month operating reserve by Year 2
- **Diversified Revenue**: Less reliance on individual donations (grants, corporate, events)
- **Monthly Giving**: Recurring donations are more resilient in recession
- **Value Communication**: Emphasize impact, ROI of donations during tough times
- **Cost Controls**: Maintain lean operations, flexible cost structure

**Monitoring**: Monthly economic indicators (unemployment, GDP, nonprofit sector trends)

---

## 🟢 Low Risks (Score 1-2)

### RISK-015: Trademark/Brand Conflict

**Category**: Legal - Intellectual Property
**Risk Score**: 2 (Likelihood: 1, Impact: 2)
**Owner**: Legal Counsel

**Description**: Another organization claims trademark on "Alpha1Life" or similar name.

**Impact**: Forced rebrand, legal fees, loss of brand equity.

**Mitigation**:

- **Trademark Search**: Conduct search before launch
- **Trademark Registration**: File trademark for "Alpha1Life" ($350-$500)
- **Domain Ownership**: Secure Alpha1Life.com and related domains

**Monitoring**: One-time trademark search and registration

---

### RISK-016: Adverse Media Coverage

**Category**: Reputational - Public Relations
**Risk Score**: 2 (Likelihood: 1, Impact: 2)
**Owner**: Executive Director

**Description**: Negative media story about MEF, Alpha1Life, or AATD community.

**Impact**: Damaged reputation, reduced donations, user trust.

**Mitigation**:

- **Media Training**: ED and Board Chair trained in media relations
- **Crisis Communication Plan**: Pre-written templates for common crises
- **Transparency**: Proactive communication, acknowledge mistakes quickly
- **Positive PR**: Build relationships with healthcare journalists, tell positive patient stories

**Monitoring**: Google Alerts for "Alpha1Life" and "Mark Egly Foundation"

---

## 📋 Risk Management Process

### Quarterly Risk Review (Board + Executive Team)

**Agenda**:

1. Review existing risks (any changes in likelihood or impact?)
2. Identify new risks (what's emerged since last review?)
3. Evaluate mitigation effectiveness (are controls working?)
4. Update risk register (document changes)
5. Assign action items (who does what by when?)

**Documentation**: Updated risk register shared with Board

---

### Risk Escalation Protocol

**Low Risk (1-2)**: Community Manager or IT Director handles, inform ED monthly
**Moderate Risk (3-5)**: Executive Director handles, inform Board Chair
**High Risk (6-9)**: Executive Director + Board Chair handle, inform full Board immediately

---

## 🎯 Success Criteria

**Risk management is effective if**:

1. **No Surprises**: Board is informed of major risks before they become crises
2. **Mitigation Works**: Controls prevent or minimize impact of risks that occur
3. **Learning**: Post-incident reviews improve future risk management
4. **Culture**: Team proactively identifies and reports risks (not hidden)

---

**Next Document**: TEAM_HIRING_PLAN.md (Staffing roadmap and job descriptions)
