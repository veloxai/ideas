# Chapter 9: Risk & Mitigation

**Comprehensive Risk Management Framework**

---

## TL;DR

**Top 5 Risks**:

1. Pilot churn (40% likelihood) → Mitigation: Dedicated CSM, QBRs, success playbook
2. Sales execution failure (30%) → Mitigation: Hire experienced VP Sales Month 6, fractional advisor Month 0-6
3. FDA reclassification (20%) → Mitigation: Pre-submission meeting, legal review, CLIA-certified labs
4. Key person dependency (15%) → Mitigation: Key person insurance, co-founder vesting, IP assignment
5. Data breach (5%) → Mitigation: Penetration testing, SOC 2, cyber insurance $1M policy

**Risk Budget**: $500K contingency (10-15% of total budget)

---

## Risk Management Framework

### Risk Scoring Methodology

**Likelihood** (1-5):

- 1 = Very Unlikely (<10% chance)
- 2 = Unlikely (10-25%)
- 3 = Possible (25-50%)
- 4 = Likely (50-75%)
- 5 = Very Likely (>75%)

**Impact** (1-5):

- 1 = Minimal (delays <1 month, costs <$25K)
- 2 = Low (delays 1-3 months, costs $25K-100K)
- 3 = Moderate (delays 3-6 months, costs $100K-250K)
- 4 = High (delays 6-12 months, costs $250K-500K, threatens viability)
- 5 = Critical (business failure, bankruptcy, regulatory shutdown)

**Risk Score** = Likelihood × Impact (max 25)

**Priority**:

- **Critical** (16-25): Address immediately, allocate budget
- **High** (11-15): Monitor closely, have mitigation plan
- **Medium** (6-10): Track quarterly, contingency plan
- **Low** (1-5): Accept risk, no active mitigation

---

## Technical Risks

### Risk T1: EHR Integration Complexity

**Description**: Epic, Cerner, and other EHR systems are notoriously difficult to integrate. FHIR APIs are immature, inconsistent, and require custom work per health system.

**Likelihood**: 4 (Likely)
**Impact**: 3 (Moderate, delays provider portal 3-6 months)
**Score**: 12 (High)

**Mitigation**:

- **Phase 1**: Start with manual CSV upload (Month 1-6, workaround for pilots)
- **Phase 2**: Epic FHIR integration only (Month 7-12, Epic has 30% market share)
- **Phase 3**: Cerner/Meditech integrations (Month 13-24, expand coverage)
- **Hire**: EHR integration specialist (Month 6, $150K salary, has built Epic integrations before)
- **Vendor**: Use Redox or 1upHealth middleware ($50K-100K/year, simplifies integrations)
- **Fallback**: If EHR integration fails, offer standalone provider portal (CSV upload, manual data entry)

**Cost**: $200K (EHR specialist salary + middleware $100K)
**Timeline Impact**: 3-6 month delay if no mitigation, <1 month with mitigation

---

### Risk T2: Mobile App Fragmentation (iOS/Android)

**Description**: React Native apps must work on 100+ device types (iPhone 11-15, Samsung Galaxy, Pixel, etc.). Testing is time-consuming, and bugs slip through.

**Likelihood**: 3 (Possible)
**Impact**: 2 (Low, delays mobile launch 1-3 months)
**Score**: 6 (Medium)

**Mitigation**:

- **Testing**: Use BrowserStack or Sauce Labs device cloud ($500/month, test on 50+ real devices)
- **Beta Program**: Launch closed beta with 50-100 users (Month 4-5, collect feedback before public launch)
- **MVP Scope**: Support only iOS 15+ and Android 12+ (covers 80% of users, skip old devices)
- **Crash Monitoring**: Sentry or Crashlytics (free tier, catch production bugs fast)
- **Fallback**: If mobile apps have critical bugs, launch web app first (responsive mobile web, 80% feature parity)

**Cost**: $10K (device testing tools + beta program incentives)
**Timeline Impact**: 1-2 month delay if no mitigation, <2 weeks with mitigation

---

### Risk T3: AI Health Assistant Accuracy

**Description**: GPT-4 chatbot may give incorrect medical advice, leading to patient harm or liability.

**Likelihood**: 3 (Possible)
**Impact**: 4 (High, lawsuit, regulatory action, patient harm)
**Score**: 12 (High)

**Mitigation**:

- **Disclaimers**: "This is educational content, not medical advice. Consult a genetic counselor." (display on every response)
- **Guardrails**: Limit chatbot to educational topics only (no diagnosis, no treatment recommendations)
- **Human Review**: All high-risk questions escalate to genetic counselor (e.g., "Should I get tested?" → auto-escalate)
- **Content Review**: Medical director reviews chatbot training data (Month 1-3, 100+ hours)
- **Liability Insurance**: $2M-5M professional liability insurance ($50K-100K/year premium)
- **Fallback**: If accuracy is too low (<90%), disable chatbot and use human-only support

**Cost**: $150K (insurance $100K/year + medical director review 100 hours × $200/hr + engineer time $50K)
**Timeline Impact**: 1-2 month delay (if medical director rejects training data), or feature cut (if liability too high)

---

### Risk T4: Platform Scalability (10K+ Users)

**Description**: AWS infrastructure may not scale to 10K+ concurrent users (Year 3), leading to slow load times or downtime.

**Likelihood**: 2 (Unlikely)
**Impact**: 3 (Moderate, performance issues, customer complaints)
**Score**: 6 (Medium)

**Mitigation**:

- **Load Testing**: Artillery or Locust (Month 6, 9, 12, 18, 24, 30, simulate 10K users)
- **Auto-Scaling**: Kubernetes HPA (horizontal pod autoscaling, auto-add servers when load increases)
- **CDN**: CloudFront for static assets (images, videos, reduce server load)
- **Database Optimization**: PostgreSQL read replicas, query optimization, caching with Redis
- **Monitoring**: Datadog APM (application performance monitoring, catch slow queries)
- **Fallback**: If scalability fails, rate-limit non-critical features (e.g., analytics dashboard) to prioritize core workflows (testing, counseling)

**Cost**: $100K (engineer time for optimization + load testing tools $10K + AWS costs $50K higher at scale)
**Timeline Impact**: 1-2 month delay (if major refactor needed), zero impact if proactive

---

### Risk T5: Security Breach (HIPAA Violation)

**Description**: Hackers access patient genetic data, leading to HIPAA violation, lawsuits, reputation damage, and potential OCR fines ($50K-1.5M per violation).

**Likelihood**: 1 (Very Unlikely, if mitigated properly)
**Impact**: 5 (Critical, business-ending)
**Score**: 5 (Low, but catastrophic if occurs)

**Mitigation**:

- **Penetration Testing**: Quarterly pen tests by third-party firm (Cobalt, HackerOne, $25K per test)
- **SOC 2 Type II**: Audit by Month 12 ($50K-100K, proves security controls work)
- **Bug Bounty**: HackerOne program ($10K budget, ethical hackers find vulnerabilities before bad actors)
- **Encryption**: AES-256 at rest, TLS 1.3 in transit (standard practice, no incremental cost)
- **Access Controls**: Role-based access control (RBAC), multi-factor authentication (MFA), least privilege principle
- **Incident Response Plan**: Documented playbook (detect → contain → notify → remediate within 72 hours per HIPAA Breach Notification Rule)
- **Cyber Insurance**: $1M-5M policy ($50K-100K/year premium, covers breach costs, legal fees, OCR fines)
- **Fallback**: If breach occurs, immediate disclosure to affected patients (per HIPAA), hire forensics firm (Mandiant, $200K-500K), offer credit monitoring ($1M-5M depending on # patients), pay OCR fines ($50K-1.5M per violation), potential business shutdown if trust lost

**Cost**: $300K over 3 years (pen tests $100K/year + SOC 2 $100K + bug bounty $30K + insurance $70K/year = $100K+$100K+$30K+$70K/year = $300K)
**Timeline Impact**: Zero (security is built-in from Day 1, not bolted on later)

---

## Regulatory Risks

### Risk R1: FDA Reclassification (Genetic Tests as Medical Devices)

**Description**: FDA currently allows most genetic tests as Laboratory Developed Tests (LDTs) under CLIA. However, FDA has proposed reclassifying LDTs as Class II/III medical devices, requiring premarket approval (510(k) or PMA), which costs $1M-10M and takes 1-3 years.

**Likelihood**: 2 (Unlikely in next 3 years, but possible long-term)
**Impact**: 5 (Critical, could shut down testing operations)
**Score**: 10 (Medium, but watch closely)

**Mitigation**:

- **CLIA-Certified Labs**: Partner with Quest/LabCorp (already CLIA-certified, not us)
- **Lab Developed Tests (LDTs)**: Position tests as LDTs (Quest/LabCorp's tests, not Fair Underwriting's tests)
- **Pre-Submission Meeting**: FDA pre-sub meeting (Month 6-12, $10K, get FDA feedback on regulatory pathway)
- **Legal Counsel**: FDA regulatory attorney (Hyman, Phelps & McNamara or similar, $50K retainer)
- **Industry Coalition**: Join AdvaMedDx or ACLA (lobbying groups, $25K/year membership, fight FDA overreach)
- **Backup Plan**: If FDA reclassifies, pivot to "wellness" genetic testing (23andMe model, claim "informational use only, not diagnostic")
- **Fallback**: If FDA bans AATD testing, pivot business to genetic counseling-only platform (no testing, just counseling for patients who tested elsewhere)

**Cost**: $100K (legal counsel $50K + pre-sub meeting $10K + lobbying group $25K/year × 2 years)
**Timeline Impact**: 6-18 month delay if FDA reclassification happens (need 510(k) approval), or business pivot

---

### Risk R2: State Genetic Counselor Licensing

**Description**: Some states require genetic counselors to be licensed (e.g., California, Utah, New York). Telemedicine across state lines is complex (counselor licensed in California may not be able to counsel patient in Texas).

**Likelihood**: 3 (Possible, already true in 10+ states)
**Impact**: 2 (Low, limits addressable market 10-20%)
**Score**: 6 (Medium)

**Mitigation**:

- **Hire Multi-State Counselors**: Genetic counselors licensed in 3-5 states each (most states recognize NSGC certification, but some require state license)
- **Partner with Local Counselors**: Contract with genetic counselors in states where we don't have licenses (1099 contractors, $150/hr)
- **Telepractice Exceptions**: Many states have COVID-era telepractice exceptions (counselor can practice across state lines during pandemic), lobby to make permanent
- **Wellness Model**: If licensing too restrictive, position counseling as "wellness coaching" not "medical counseling" (avoid licensing, but lose reimbursement)
- **Fallback**: If state licensing blocks expansion, focus on 40 states with no licensing requirements (still 80% of US population)

**Cost**: $50K (legal research $20K + licensing fees $5K per counselor × 3 counselors × 2 states = $30K)
**Timeline Impact**: 1-2 month delay (if need to hire counselors in specific states)

---

### Risk R3: HIPAA Violation (Business Associate Agreement Breach)

**Description**: Fair Underwriting is a Business Associate (BA) under HIPAA. If we violate HIPAA (e.g., data breach, unauthorized disclosure), insurance partners terminate contracts and OCR fines us $50K-1.5M per violation.

**Likelihood**: 2 (Unlikely if proper controls in place)
**Impact**: 5 (Critical, lose all partners + fines)
**Score**: 10 (Medium, but catastrophic if occurs)

**Mitigation**:

- **HIPAA Compliance Program**: Designate Privacy Officer and Security Officer (CTO is Security Officer, Legal is Privacy Officer)
- **BAA with All Vendors**: AWS, Twilio, Salesforce, etc. all sign Business Associate Agreements (required by HIPAA)
- **Annual Risk Assessments**: HIPAA security risk assessment (required annually, $25K external audit)
- **Employee Training**: Annual HIPAA training for all employees (1 hour, pass quiz with 90%+)
- **Breach Notification Plan**: If breach occurs, notify OCR within 60 days and affected patients within 60 days (per HIPAA Breach Notification Rule)
- **Cyber Insurance**: $1M-5M policy covers HIPAA fines, legal fees, notification costs
- **Fallback**: If HIPAA violation occurs, immediate remediation (fire responsible employee, fix vulnerability, notify OCR), pay fines, potential business shutdown if partners lose trust

**Cost**: $100K over 3 years (HIPAA audits $25K/year × 3 = $75K + training $5K/year = $15K + insurance $10K/year = $100K)
**Timeline Impact**: Zero (HIPAA compliance is Day 1 requirement, not optional)

---

### Risk R4: International Expansion (GDPR, PIPEDA Compliance)

**Description**: Expanding to Canada (PIPEDA) and UK (GDPR) requires new privacy controls (right to erasure, data portability, explicit consent). Fines are 4% of global revenue (€20M max under GDPR).

**Likelihood**: 3 (Possible, if expand internationally Year 3)
**Impact**: 3 (Moderate, delays international launch 3-6 months)
**Score**: 9 (Medium)

**Mitigation**:

- **GDPR Compliance**: Data Processing Agreement (DPA) with all vendors, appoint EU representative, conduct Data Protection Impact Assessment (DPIA)
- **PIPEDA Compliance**: Privacy Impact Assessment (PIA), consent management, data residency in Canada
- **Legal Counsel**: International privacy attorney (DLA Piper, Hogan Lovells, $50K retainer)
- **Tech Changes**: Add "right to erasure" button (delete my account), data export (download my data as JSON), consent management (granular opt-in)
- **Fallback**: If international compliance too expensive, delay Canada/UK launch to Year 4-5 (focus on US only Year 1-3)

**Cost**: $150K (legal counsel $50K + engineer time $100K for GDPR/PIPEDA features)
**Timeline Impact**: 3-6 month delay if not planned ahead, zero impact if budgeted in Year 3 roadmap

---

## Business Risks

### Risk B1: Pilot Partner Churn

**Description**: 1-2 of 5 pilot partners churn after Year 1 (don't renew contracts). Reasons: budget cuts, M&A, dissatisfaction with product, lack of ROI, change in HR/benefits strategy.

**Likelihood**: 4 (Likely, 20-40% churn is normal for SaaS startups)
**Impact**: 3 (Moderate, lose $150K-300K ARR, delays profitability 3-6 months)
**Score**: 12 (High)

**Mitigation**:

- **Customer Success Manager**: Dedicated CSM hired Month 9 ($90K salary, manages QBRs, tracks NPS, proactively identifies churn risk)
- **QBRs**: Quarterly Business Reviews with pilot partners (present ROI, patient uptake, cost savings, NPS, plan Year 2)
- **Health Scoring**: Red/yellow/green health scores (low uptake <30% = red, low NPS <50 = red, champion left company = red)
- **Intervention Plan**: If partner goes "red", CEO + CSM visit on-site (within 2 weeks), conduct member surveys, adjust marketing, offer pilot extension (3-6 months free)
- **Success Playbook**: Document what works (co-branded emails get 40% uptake, lunch-and-learn events get 60% attendance), replicate across pilots
- **Fallback**: If 2 of 5 pilots churn, extend other 3 pilots (offer Year 2 discount 10-15%), focus sales on replacing churned pilots (need 2 new logos to replace)

**Cost**: $150K (CSM salary $90K + travel $10K + pilot extensions/discounts $50K)
**Timeline Impact**: 3-6 month delay to profitability (if churn >20%), revenue shortfall $300K

---

### Risk B2: Sales Execution Failure (Can't Close Pilots)

**Description**: CEO/founder is great at product and fundraising, but not at enterprise B2B sales. Sales cycle takes 12-18 months instead of 6-9 months. Only close 2 pilots instead of 5 by Month 12.

**Likelihood**: 3 (Possible, common founder mistake is underestimating sales difficulty)
**Impact**: 4 (High, miss Year 1 revenue target, delays Series A, potential down round)
**Score**: 12 (High)

**Mitigation**:

- **Hire VP Sales Early**: Month 6 (not Month 12), experienced enterprise B2B sales leader (10+ years, healthcare industry, $200K base + $100K commission)
- **Fractional Sales Advisor**: Month 0-6, hire fractional VP Sales ($5K-10K/month, 10-20 hours/month, coaches CEO on sales strategy, reviews pitch deck, joins key meetings)
- **Sales Training**: CEO takes MEDDPICC or Challenger Sales training (Month 1-3, $5K, learn enterprise sales methodology)
- **Pipeline Discipline**: Use Salesforce CRM from Day 1 (track 25-50 leads, forecast close dates, identify blockers early)
- **Pilot Program Design**: Make pilot offer irresistible ($150K for 12 months, 100-200 members, guaranteed 3:1 ROI or money back)
- **Fallback**: If only close 2 pilots by Month 9, extend fundraise timeline (raise bridge round $500K-1M), cut costs (reduce headcount 10-20%), or pivot to direct-to-consumer (DTC) model

**Cost**: $300K (VP Sales Year 1 salary/commission $200K + fractional advisor $60K + training $5K + bridge round if needed $500K dilution)
**Timeline Impact**: 3-6 month delay to Year 1 milestones, revenue shortfall $450K (3 pilots missed × $150K each)

---

### Risk B3: Market Timing (Too Early or Too Late)

**Description**: **Too Early**: Insurers not ready for genetic testing programs (privacy concerns, regulatory uncertainty, cost concerns). **Too Late**: Competitors (23andMe, Color, Invitae) already captured market share.

**Likelihood**: 2 (Unlikely, market timing seems good based on 2020-2024 trends)
**Impact**: 4 (High, delays revenue 12-18 months, need to pivot)
**Score**: 8 (Medium)

**Mitigation**:

- **Customer Discovery**: Talk to 50 benefits leaders before building product (validate problem, willingness to pay)
- **Competitive Positioning**: Privacy-first differentiation (23andMe had data breach, Color is cancer-focused, Invitae is bankrupt)
- **Market Tailwinds**: Telemedicine normalization post-COVID, genetic testing costs declining 50% (2020 → 2024), value-based care adoption
- **Fallback Too Early**: If insurers not ready, pivot to direct-to-consumer (DTC) model ($199 test, sell directly to patients, slower growth but proves market)
- **Fallback Too Late**: If competitors dominate, focus on AATD niche (specialize vs. generalize), or sell to competitor (acquihire, $10M-30M)

**Cost**: $50K (customer discovery travel/meals $20K + pivot costs if needed $30K)
**Timeline Impact**: 6-12 month delay if market not ready, or business pivot

---

### Risk B4: Funding Gap (Can't Raise Series A)

**Description**: Pilots succeed, but can't raise Series A (investors skeptical of B2B2C model, genetic testing fatigue after 23andMe/Invitae failures, macro environment down market).

**Likelihood**: 2 (Unlikely if pilots proven, but possible in bad macro environment)
**Impact**: 4 (High, run out of cash Month 15-18, need to cut costs or shut down)
**Score**: 8 (Medium)

**Mitigation**:

- **Seed Extension**: If Series A hard to raise, raise $1M-2M seed extension (from existing investors, 6-9 month runway extension)
- **Revenue-Based Financing**: Pipe, Clearco, or Lighter Capital (non-dilutive debt, repay from revenue, 10-20% of MRR)
- **Cut Burn**: Reduce headcount 20-30% (cut sales/marketing, freeze eng hiring), extend profitability timeline by 6-12 months
- **Bridge Loan**: Venture debt from Silicon Valley Bank or WTI ($1M-2M, 10-12% interest, 2-3 year repayment)
- **Fallback**: If can't raise any capital, achieve profitability on seed only (slower growth, 10 partners instead of 20 by Year 3, cut team to 30 instead of 50)

**Cost**: $0 (mitigation is cost reduction, not cost increase)
**Timeline Impact**: 6-12 month delay to growth milestones, lower Year 3 revenue ($6M instead of $10M)

---

### Risk B5: Key Person Dependency (Founder Leaves or Dies)

**Description**: CEO or CTO leaves company (quits, fired, health issue, death), creating leadership vacuum.

**Likelihood**: 1 (Very Unlikely, but possible)
**Impact**: 4 (High, company stalls 3-6 months, potential down round or shutdown)
**Score**: 4 (Low, but plan for it)

**Mitigation**:

- **Co-Founder Vesting**: 4-year vesting with 1-year cliff (if co-founder leaves before Year 1, forfeit all equity)
- **Key Person Insurance**: $1M-5M life insurance policy on CEO and CTO ($5K-10K/year premium, company is beneficiary)
- **Succession Plan**: Document succession plan (if CEO leaves, CTO becomes interim CEO, hire new CEO within 6 months)
- **IP Assignment**: All code, patents, designs owned by company (not individuals), prevent key person taking IP
- **Fallback**: If founder leaves, board hires executive search firm (Spencer Stuart, Heidrick & Struggles, $100K fee), hire new CEO/CTO within 3-6 months

**Cost**: $50K (key person insurance $10K/year × 3 years + search firm $20K if needed)
**Timeline Impact**: 3-6 month delay if founder leaves, potential revenue/fundraising impact

---

## Operational Risks

### Risk O1: Lab Partner Failure (Quest/LabCorp)

**Description**: Quest or LabCorp terminates partnership (contract dispute, company bankruptcy, pricing change), leaving Fair Underwriting without testing capability.

**Likelihood**: 1 (Very Unlikely, Quest/LabCorp are stable $10B+ companies)
**Impact**: 4 (High, can't deliver tests, lose all partners within 1-3 months)
**Score**: 4 (Low, but catastrophic if occurs)

**Mitigation**:

- **Dual Lab Partners**: Contract with both Quest AND LabCorp (redundancy, if one fails, switch to other within 1-2 weeks)
- **Multi-Year Contracts**: Lock in 3-year pricing with Quest/LabCorp ($50/test fixed price, protect from price increases)
- **Backup Labs**: Identify 2-3 backup labs (Invitae, PreventionGenetics, Baylor Genetics), pre-negotiate standby contracts (can activate within 30 days)
- **Insurance**: Business interruption insurance ($50K/year, covers lost revenue if lab fails)
- **Fallback**: If all labs fail (extremely unlikely), pivot to saliva sample collection only (send samples to patients, patients send to labs directly, Fair Underwriting becomes software-only platform)

**Cost**: $100K (dual lab contracts $50K/year × 2 labs = $100K over 3 years)
**Timeline Impact**: 1-2 month delay if primary lab fails and need to switch to backup

---

### Risk O2: Genetic Counselor Shortage

**Description**: Can't hire enough genetic counselors (only 5,000 certified counselors in US, high demand, competitive market). Delays pilot launches because not enough counselors to deliver pre-test/results counseling.

**Likelihood**: 3 (Possible, common problem in genetic testing startups)
**Impact**: 3 (Moderate, delays pilot launches 1-3 months)
**Score**: 9 (Medium)

**Mitigation**:

- **Competitive Compensation**: Pay top 25% of market ($80K-90K for counselors, vs. industry average $70K-75K)
- **Remote Work**: Hire counselors anywhere in US (not just SF Bay Area), 10× larger talent pool
- **Training Program**: Hire new grads from genetic counseling programs (UC Irvine, Stanford, USC), train them for 3-6 months (junior counselors $60K-70K)
- **1099 Contractors**: Contract with freelance genetic counselors ($150-200/hr, use for overflow during busy periods)
- **AI Augmentation**: Use AI health assistant to handle simple questions (reduces counselor workload 20-30%, counselors focus on complex cases)
- **Fallback**: If can't hire counselors, delay pilot launches by 1-3 months (extend sales cycle), or partner with external genetic counseling firms (InformedDNA, GeneDx, outsource counseling $200-300/session)

**Cost**: $100K (higher salaries $10K/year × 5 counselors = $50K + training program $20K + contractors $30K)
**Timeline Impact**: 1-3 month delay if shortage acute, zero impact if proactive hiring

---

### Risk O3: Customer Support Overload

**Description**: Patient support tickets exceed capacity (100+ tickets/day by Year 3, only 2-3 support staff). Long wait times (>24 hours) lead to low NPS, partner complaints.

**Likelihood**: 3 (Possible, common scaling problem)
**Impact**: 2 (Low, low NPS, churn risk, but not business-ending)
**Score**: 6 (Medium)

**Mitigation**:

- **Self-Service**: FAQ, knowledge base, video tutorials (Zendesk Help Center, covers 60-70% of common questions)
- **AI Chatbot**: GPT-4 chatbot handles Tier 1 support (password resets, billing questions, appointment scheduling), escalates complex questions to humans
- **Tiered Support**: Tier 1 (chatbot), Tier 2 (support staff), Tier 3 (genetic counselors for clinical questions)
- **Support Metrics**: Track ticket volume, response time (SLA <4 hours for critical, <24 hours for normal), CSAT (customer satisfaction)
- **Staffing**: Hire 1 support person per 2,000 patients (Year 1: 500 patients = 0-1 support, Year 3: 5,000-10,000 patients = 3-5 support staff)
- **Fallback**: If support overload, temporarily extend response times (SLA 24-48 hours), hire temp contractors (Upwork, $20-30/hr), or pause new partner launches until staffing catches up

**Cost**: $200K (support staff $60K/year × 3 = $180K + chatbot $10K + Zendesk $10K)
**Timeline Impact**: Low NPS (<60), partner churn risk (5-10% higher), but not fatal

---

### Risk O4: Data Quality Issues (Registry)

**Description**: Research registry data is incomplete or inaccurate (patients forget to wear wearables, skip surveys, enter wrong information). Pharma partners reject data, refuse to pay for studies.

**Likelihood**: 3 (Possible, data quality is perennial problem in research)
**Impact**: 3 (Moderate, lose $200K-500K pharma revenue/year)
**Score**: 9 (Medium)

**Mitigation**:

- **Automated Data Collection**: Wearables auto-sync (Apple Health, Google Fit), EHR integration (Epic FHIR), reduce manual entry
- **Data Validation**: Real-time validation (e.g., can't enter birthdate in future, weight must be 50-500 lbs), catch errors immediately
- **Incentives**: Pay patients $50-200 to complete surveys (increases response rate 70% → 90%+)
- **Data Quality Dashboard**: Monitor completeness (% missing fields), accuracy (% outliers), timeliness (% <24hr latency)
- **QA Team**: Hire data operations specialist (Month 18, $70K salary, audits data quality, fixes issues)
- **Fallback**: If data quality too low, manually audit 10-20% of records (hire temp contractors, $25/hr × 100 hours = $2.5K per audit)

**Cost**: $150K (patient incentives $50K/year + QA specialist $70K + manual audits $30K)
**Timeline Impact**: Delay pharma partnerships 3-6 months if data quality issues severe

---

### Risk O5: Vendor Dependency (AWS, Twilio, Salesforce)

**Description**: Critical vendor (AWS, Twilio, Salesforce) has outage, price increase, or policy change (e.g., AWS bans genetic testing apps). Fair Underwriting platform goes down or costs spike.

**Likelihood**: 2 (Unlikely, but AWS outages happen 1-2×/year)
**Impact**: 3 (Moderate, platform downtime 1-8 hours, revenue loss minimal but reputation hit)
**Score**: 6 (Medium)

**Mitigation**:

- **Multi-Region**: Deploy AWS infrastructure in 2 regions (us-east-1 + us-west-2), auto-failover if one region goes down
- **Vendor Diversification**: If AWS bans genetic testing (unlikely), migrate to Google Cloud or Azure within 1-3 months (Docker containers make migration easier)
- **Cost Management**: AWS Reserved Instances (30-50% discount vs. on-demand), monitor costs weekly (set budget alerts), optimize queries/storage
- **Service Credits**: If vendor outage >1 hour, claim SLA credits (AWS gives 10-25% refund for outages)
- **Fallback**: If vendor costs spike 50%+, migrate to cheaper alternative (e.g., AWS → Hetzner or DigitalOcean for non-HIPAA workloads)

**Cost**: $50K (multi-region adds 20-30% AWS costs, $50K over 3 years)
**Timeline Impact**: 1-8 hour outage if single-region, <1 hour if multi-region with auto-failover

---

## Risk Monitoring Dashboard

### Quarterly Risk Review (CEO + CFO + CTO)

**Process**:

1. Review all 20 risks (update likelihood/impact scores)
2. Identify new risks (market changes, competitor moves, regulatory updates)
3. Allocate contingency budget ($500K over 3 years, ~10-15% of total budget)
4. Assign risk owners (who monitors each risk, who executes mitigation)

**Risk Dashboard** (Track Monthly):
| Risk | Likelihood | Impact | Score | Status | Owner | Mitigation Budget | Next Review |
|------|------------|--------|-------|--------|-------|-------------------|-------------|
| Pilot Churn | 4 | 3 | 12 | 🟡 Yellow | CSM | $150K | Monthly |
| Sales Failure | 3 | 4 | 12 | 🟡 Yellow | CEO/VP Sales | $300K | Monthly |
| FDA Reclassification | 2 | 5 | 10 | 🟢 Green | Legal | $100K | Quarterly |
| Data Breach | 1 | 5 | 5 | 🟢 Green | CTO | $300K | Monthly |
| Key Person | 1 | 4 | 4 | 🟢 Green | CEO | $50K | Annual |

**Status Colors**:

- 🔴 **Red**: Risk materializing now (immediate action needed)
- 🟡 **Yellow**: Risk possible (monitor closely, mitigation active)
- 🟢 **Green**: Risk low or mitigated (quarterly check-in sufficient)

---

## Contingency Budget

**Total Risk Budget**: $500K over 3 years (~10-15% of $3.5M product budget)

**Allocation by Category**:

- **Technical Risks**: $150K (EHR integration $100K, AI/security $50K)
- **Regulatory Risks**: $200K (FDA $100K, HIPAA/GDPR $100K)
- **Business Risks**: $100K (sales failure fractional advisor $60K, market timing pivot $40K)
- **Operational Risks**: $50K (support/data quality $50K)

**Unallocated Buffer**: $100K (for unknown unknowns)

---

**Continue Reading**: [Chapter 10: Investment Opportunity →](./10_INVESTMENT_OPPORTUNITY.md)

**Previous Chapter**: [← Chapter 8: Financial Model](./08_FINANCIAL_MODEL.md)

**Back to**: [← Whitepaper Home](./README.md)
