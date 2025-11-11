# Document #14: Patient Registry & Outcomes Tracking

## Mark Egly Foundation - Phase 2 Expansion

**Document Type:** Data Management & Research Infrastructure
**Priority:** MEDIUM
**Estimated Budget:** $25,000 - $100,000 setup, $10,000 - $30,000 annual
**Timeline:** 6-12 months to launch, ongoing operations
**Dependencies:** IRB approval, HIPAA compliance, IT infrastructure
**Last Updated:** November 2025

---

## Executive Summary

This document outlines the development and operation of a patient registry to track Alpha-1 Antitrypsin Deficiency outcomes, support research, and improve patient care. A well-designed registry provides longitudinal data critical for understanding disease progression, treatment effectiveness, and quality of life.

**Registry Objectives:**

- Track clinical outcomes and disease progression for Alpha-1 patients
- Create research-ready dataset for investigators
- Identify gaps in care and opportunities for intervention
- Demonstrate program impact to funders and stakeholders
- Enable comparative effectiveness research
- Build collaborative research network

**Year 1 Goals:**

- Enroll 100-200 patients (50% of Foundation contacts)
- Collect baseline data on all enrolled patients
- Complete 6-month follow-up on 50% of enrollees
- Establish data governance and access policies
- Secure IRB approval (if applicable)
- Partner with 2-3 Alpha-1 clinics for recruitment

**Resource Requirements:**

- Registry Coordinator (0.5 FTE): $25,000-$35,000
- REDCap or similar platform: $0-$5,000/year
- IRB fees and compliance: $2,000-$5,000
- Data collection incentives: $3,000-$10,000
- Consultant support: $5,000-$15,000

---

## Part 1: Registry Design & Purpose

### 1.1 Registry Types

**Observational Patient Registry (RECOMMENDED):**

- **Purpose:** Natural history study, track outcomes over time
- **Design:** Longitudinal cohort, minimal intervention
- **Data:** Patient-reported + clinical data from providers
- **Commitment:** Annual surveys, optional medical records
- **Advantages:** Lower cost, easier recruitment, broad participation
- **Disadvantages:** Incomplete data, loss to follow-up

**Clinical Research Registry:**

- **Purpose:** Support specific research studies
- **Design:** Standardized protocols, strict inclusion/exclusion
- **Data:** Detailed clinical measures, lab results, imaging
- **Commitment:** Regular clinic visits, extensive testing
- **Advantages:** High-quality data, research-ready
- **Disadvantages:** Higher cost, limited enrollment, regulatory burden

**Hybrid Model (RECOMMENDED START):**

- Begin with observational registry (easier, lower cost)
- Add clinical research components for interested subset
- Partner with Alpha-1 Foundation AlphaNet registry where possible
- Focus on Foundation-specific outcomes (financial assistance impact, quality of life)

### 1.2 Core Research Questions

**Primary Questions:**

1. What is the natural history of Alpha-1 in our patient population?
2. How does early diagnosis impact clinical outcomes?
3. What are the barriers to accessing augmentation therapy?
4. What is the impact of financial assistance on treatment adherence?
5. How does quality of life change over time with support services?

**Secondary Questions:** 6. What are the most common comorbidities in Alpha-1 patients? 7. At what stage are patients typically diagnosed? 8. What percentage of family members complete cascade testing? 9. How do employment and insurance status affect outcomes? 10. What support services are most valued by patients?

### 1.3 Outcome Measures

**Clinical Outcomes (from medical records or patient report):**

| Measure                     | Data Source     | Frequency      | Purpose                        |
| --------------------------- | --------------- | -------------- | ------------------------------ |
| FEV1 (lung function)        | Medical records | Annual         | Track lung disease progression |
| Liver enzymes (ALT, AST)    | Medical records | Annual         | Monitor liver disease          |
| Hospitalizations            | Patient report  | Every 6 months | Healthcare utilization         |
| Emergency visits            | Patient report  | Every 6 months | Disease severity               |
| Pulmonary exacerbations     | Patient report  | Every 6 months | Disease control                |
| Augmentation therapy status | Patient report  | Every 6 months | Treatment adherence            |

**Patient-Reported Outcomes (PROs):**

| Measure                | Tool                                          | Frequency                    | Purpose              |
| ---------------------- | --------------------------------------------- | ---------------------------- | -------------------- |
| **Quality of Life**    | SGRQ (St. George's Respiratory Questionnaire) | Baseline, 6 months, annually | Disease-specific QoL |
| **Symptom Burden**     | CAT (COPD Assessment Test)                    | Every 6 months               | Symptom tracking     |
| **Functional Status**  | 6-Minute Walk Distance (self-reported)        | Baseline, annually           | Physical function    |
| **Anxiety/Depression** | PHQ-4 (brief screener)                        | Baseline, annually           | Mental health        |
| **Healthcare Access**  | Custom questions                              | Baseline, annually           | Barriers to care     |
| **Financial Toxicity** | COST-FACIT (brief)                            | Baseline, annually           | Financial burden     |

**Sociodemographic Data (Baseline):**

- Age, gender, race/ethnicity, education
- Employment status, insurance type
- Geographic location (ZIP code)
- Family history of Alpha-1
- Smoking history
- Alpha-1 genotype (if known)

**Foundation Service Utilization:**

- Financial assistance received (type, amount)
- Events attended
- Support groups participated in
- Resources accessed
- Volunteer activities

### 1.4 Inclusion & Exclusion Criteria

**Inclusion Criteria:**

- Confirmed Alpha-1 Antitrypsin Deficiency (genotype confirmed OR serum AAT level <100 mg/dL)
- Age 18+ (adult registry; separate pediatric considerations)
- Able to provide informed consent
- Willing to participate in annual follow-up
- United States resident (for start; international expansion possible)

**Exclusion Criteria:**

- Unable to read/understand English (Year 1; add Spanish Year 2)
- Severe cognitive impairment preventing consent
- Unwilling to share medical information

**Special Populations:**

- **Liver-only manifestation:** Include (important subgroup)
- **Asymptomatic carriers (MZ):** Optional separate registry (lower priority)
- **Pediatric patients:** Defer to Year 2-3 (requires separate IRB, parental consent)

---

## Part 2: Technology Platform

### 2.1 Platform Comparison

| Platform                  | Best For                                   | Cost                                              | Key Features                                           | Limitations                                                       |
| ------------------------- | ------------------------------------------ | ------------------------------------------------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| **REDCap**                | Academic registries, HIPAA-compliant, free | FREE (university hosted) or $5K-$10K/year (cloud) | Secure, validated, surveys, data exports, audit trails | Requires institutional affiliation or paid cloud hosting          |
| **Qualtrics**             | Survey-focused, less clinical              | $0-$3,000/year                                    | Easy survey building, distribution, analytics          | Not designed for medical data, less structured                    |
| **Castor EDC**            | Clinical trials, European                  | $5,000-$20,000/year                               | eCRF, GCP compliance, mobile app                       | Expensive, overkill for observational registry                    |
| **SurveyMonkey**          | Simple surveys, low cost                   | $300-$1,200/year                                  | Easy to use, familiar interface                        | Not HIPAA-compliant (requires upgrade), limited clinical features |
| **Microsoft Excel/Forms** | Very small pilots                          | FREE                                              | Familiar, accessible                                   | Not secure, no audit trail, not scalable, NOT HIPAA-COMPLIANT     |

### 2.2 Recommendation: REDCap

**Why REDCap:**

- Industry standard for patient registries and research
- HIPAA-compliant with proper setup
- Free if hosted by university partner (Pitt, CMU, UPMC possible)
- Robust features: branching logic, data validation, calculated fields
- Secure data collection with audit trails
- Easy export to SPSS, SAS, R, Excel for analysis
- Widely used by researchers (easier data sharing)

**REDCap Setup Options:**

**Option 1: University Partnership (RECOMMENDED - FREE)**

- Partner with University of Pittsburgh, CMU, or Penn State (all have REDCap)
- Host registry on their secure server
- May require IRB approval through their institution
- Cost: $0 (or small administrative fee)
- Timeline: 2-4 months to establish partnership and setup

**Option 2: Cloud REDCap Hosting ($5,000-$10,000/year)**

- Providers: REDCap Cloud, Vanderbilt (official), others
- Fully managed, HIPAA-compliant hosting
- No university affiliation needed
- Cost: $5,000-$10,000/year depending on data volume
- Timeline: 1-2 months to setup

**Option 3: Self-Hosted (NOT RECOMMENDED)**

- Requires IT infrastructure, security expertise
- Ongoing maintenance burden
- Cost: $15,000-$30,000 setup + $5,000-$10,000/year
- Timeline: 4-6 months

**Recommendation:** Start with Option 1 (university partnership) to minimize costs. Transition to Option 2 (cloud hosting) if university partnership ends or growth exceeds capacity.

### 2.3 Data Security & HIPAA Compliance

**Protected Health Information (PHI) Considerations:**

**Direct Identifiers (MUST be secured):**

- Name, address, dates (birth, death, admission)
- Phone/fax numbers, email addresses
- Social Security Number, Medical Record Number
- Account numbers, biometric identifiers
- Photos, IP addresses

**Registry Approach:**

- **Option A: De-Identified Registry** - Collect only de-identified data (no PHI), easier compliance
- **Option B: Limited Data Set** - Remove direct identifiers, keep ZIP codes and dates
- **Option C: Fully Identifiable** - Collect PHI for linkage, requires full HIPAA compliance

**Recommendation: Option B (Limited Data Set)** - Balance between privacy and research utility.

**HIPAA Safeguards:**

- Business Associate Agreement (BAA) with REDCap host
- Encrypted data transmission (SSL/TLS)
- Encrypted data storage (AES-256)
- Access controls (unique logins, role-based permissions)
- Audit logs (track all data access and changes)
- Breach notification procedures
- Annual security risk assessment

**Participant Consent:**

- Informed consent document explaining data use
- HIPAA authorization to collect medical records
- Clear explanation of privacy protections
- Right to withdraw at any time
- Certificate of Confidentiality (if federally funded research)

---

## Part 3: Data Collection Procedures

### 3.1 Enrollment Process

**Recruitment Channels:**

1. **Foundation Email List (Primary):**
   - Email invitation to existing contacts (800-1,200 patients/families)
   - Emphasize contribution to research, low burden
   - Incentive: $25 Amazon gift card for baseline completion
   - Expected: 30-40% enrollment rate = 240-480 interested, 100-200 enrolled

2. **Website Signup:**
   - Prominent "Join Our Registry" button on homepage
   - Landing page explaining benefits, time commitment
   - Online screening form (inclusion/exclusion)
   - Expected: 10-20 signups/month

3. **Events:**
   - Recruit at Annual Gala, walks, support groups
   - Paper/tablet signup with immediate baseline survey
   - Expected: 20-40 enrollments from major events

4. **Healthcare Provider Referrals:**
   - Partner with 2-3 Alpha-1 clinics
   - Providers recommend registry to patients
   - Provide clinic with brochures/QR codes
   - Expected: 10-20 enrollments from provider referrals

5. **Social Media:**
   - Facebook/Instagram ads targeting Alpha-1 community
   - "Help advance Alpha-1 research - join our registry"
   - Expected: 5-10 signups/month

**Enrollment Steps:**

1. **Screening:** Online form confirms eligibility (2 minutes)
2. **Consent:** Electronic consent with checkbox acknowledgment (5-10 minutes to read)
3. **Baseline Survey:** Complete initial questionnaire (30-45 minutes)
4. **Confirmation:** Welcome email with registry ID, next steps, incentive delivery

**Incentives:**

- **Baseline:** $25 Amazon/Visa gift card (digital delivery)
- **6-Month Follow-Up:** $15 gift card
- **Annual Follow-Up:** $25 gift card
- **Total Year 1 per patient:** $65 (baseline + 6-month + 12-month)
- **Budget:** 150 patients x $65 = $9,750 Year 1

### 3.2 Data Collection Schedule

| Timepoint                 | Data Collected                                                                                                                                                                               | Estimated Time | Completion Mode        |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ---------------------- |
| **Baseline (Enrollment)** | Demographics, medical history, genotype, current symptoms (SGRQ, CAT), mental health (PHQ-4), FEV1 (if known), medication list, healthcare utilization (past year), Foundation services used | 30-45 minutes  | Online survey (REDCap) |
| **6 Months**              | Current symptoms (CAT), healthcare utilization (past 6 months), medication changes, Foundation services, treatment adherence                                                                 | 15-20 minutes  | Online survey or phone |
| **12 Months (Annual)**    | Full repeat of baseline measures (SGRQ, CAT, PHQ-4), updated FEV1, healthcare utilization (past year), quality of life, financial burden (COST-FACIT)                                        | 30-40 minutes  | Online survey          |
| **24, 36, 48+ Months**    | Same as 12-month                                                                                                                                                                             | 30-40 minutes  | Online survey          |

**Retention Strategy:**

- Email reminder 2 weeks before due date
- Email reminder on due date
- Email reminder 1 week after due date
- Phone call 2 weeks after due date (if no response)
- Text message option for reminders (if opted in)
- Flexible window: ±4 weeks from target date

### 3.3 Medical Record Abstraction (Optional)

**For Interested Subset:**

- Request medical records from pulmonologist or PCP
- HIPAA authorization signed at enrollment
- Collect: FEV1 values, liver enzymes, hospitalizations, imaging reports
- Staff time: 30-60 minutes per patient record review
- Expected: 25-50 patients (25-50%) consent to record abstraction Year 1

**Medical Record Data Points:**

- Spirometry (FEV1, FVC, FEV1/FVC ratio) - past 5 years
- Liver function tests (ALT, AST, bilirubin) - past 5 years
- Alpha-1 genotype confirmation (from lab report)
- Chest CT findings (if available)
- Hospitalization dates and diagnoses
- Augmentation therapy prescription dates

---

## Part 4: Data Governance & Access

### 4.1 Governance Structure

**Registry Steering Committee:**

- **Chair:** Medical Director or Board member with research background
- **Members:**
  - Executive Director (Foundation perspective)
  - 2-3 clinician researchers (pulmonologists, hepatologists)
  - 1-2 patient advocates (lived experience)
  - Biostatistician or epidemiologist (data analysis expertise)
  - Registry Coordinator (staff liaison, non-voting)

**Responsibilities:**

- Review and approve data access requests
- Oversee data quality and completeness
- Guide research priorities
- Approve protocol changes
- Review annual registry reports
- Resolve disputes or ethical issues

**Meeting Schedule:** Quarterly (4 times/year)

### 4.2 Data Access Policies

**Data Access Tiers:**

**Tier 1: Public Summary Data (No Approval Needed)**

- Aggregate statistics (number enrolled, demographics)
- Summary reports on website or annual report
- No patient-level data
- Available to anyone

**Tier 2: Limited Dataset (Committee Approval)**

- De-identified patient-level data
- For approved research projects
- Requires IRB approval (if academic)
- Data Use Agreement signed
- Available to qualified researchers (internal or external)

**Tier 3: Identifiable Data (Restricted)**

- Full dataset with identifiers
- Only for linkage with other datasets (e.g., Medicare claims)
- Requires IRB approval and special justification
- Available to approved collaborators only

**Data Request Process:**

1. **Submit Application:** Complete data request form
   - Research question and aims
   - Variables needed
   - Analytic plan
   - IRB approval letter (if applicable)
   - Funding source

2. **Committee Review:** Steering Committee reviews (30 days)
   - Scientific merit
   - Feasibility with available data
   - Alignment with registry mission
   - Researcher qualifications

3. **Approval & Agreement:** If approved:
   - Data Use Agreement executed
   - Data Security Plan reviewed
   - Timeline established (6-12 months for analysis)

4. **Data Delivery:** De-identified dataset provided
   - CSV or statistical software format
   - Data dictionary included
   - Support from Registry Coordinator

5. **Publication:**
   - Researchers submit manuscript draft to Committee before submission
   - Acknowledge Mark Egly Foundation and registry participants
   - Share findings with community (lay summary)

### 4.3 Data Quality Assurance

**Quality Control Measures:**

**During Data Entry:**

- Range checks (e.g., age 18-100, FEV1 0-120% predicted)
- Required fields (cannot skip critical variables)
- Logic checks (e.g., if no COPD, skip COPD medication questions)
- Branching logic to reduce burden

**After Data Collection:**

- Monthly data quality reports (missing data, outliers)
- Quarterly data audits (10% random sample for verification)
- Annual completeness assessment (% of expected follow-ups completed)

**Missing Data Management:**

- Flag missing data reasons (refused, don't know, technical error)
- Re-contact participants for critical missing data
- Document loss to follow-up (moved, deceased, withdrew)

**Data Cleaning:**

- Annual comprehensive data cleaning
- Resolve outliers and inconsistencies
- Document all changes in audit log

---

## Part 5: Analysis & Reporting

### 5.1 Statistical Analysis Plan

**Descriptive Analyses:**

- Baseline characteristics of enrolled patients (demographics, disease severity, comorbidities)
- Frequency distributions and summary statistics
- Comparison to Alpha-1 Foundation registry (if data available)

**Longitudinal Analyses:**

- Change in FEV1 over time (linear mixed models)
- Quality of life trajectories (SGRQ, CAT scores)
- Predictors of disease progression (age, smoking, genotype, treatment)
- Healthcare utilization trends (hospitalizations, exacerbations)

**Impact Evaluation:**

- Financial assistance recipients vs. non-recipients (propensity score matching)
- Treatment adherence among assistance recipients
- Quality of life improvement with support services

**Survival Analyses:**

- Time to first hospitalization
- Time to transplant (if applicable)
- Predictors of adverse events

### 5.2 Reporting Cadence

**Monthly (Internal):**

- Enrollment numbers and retention rates
- Data completeness statistics
- Issues and troubleshooting

**Quarterly (Steering Committee):**

- Enrollment update and projections
- Data quality report
- Retention analysis (lost to follow-up)
- Preliminary findings (if any)

**Annual (Public):**

- Comprehensive registry report
- Key findings (descriptive statistics, preliminary analyses)
- Participant demographics
- Impact stories
- Publications and presentations
- Plans for next year

**Ad Hoc (As Needed):**

- Grant applications (provide registry data)
- Partnership discussions (share summary statistics)
- Conference presentations (abstracts, posters)
- Peer-reviewed publications (manuscripts)

### 5.3 Dissemination Strategy

**To Registry Participants:**

- Annual email with summary findings ("Here's what we learned")
- Patient-friendly infographics
- Invitation to webinar discussing results
- Acknowledgment of their contribution

**To Scientific Community:**

- Presentations at Alpha-1 conferences (AATD Annual Meeting, ATS)
- Manuscripts in respiratory journals (Chest, AJRCCM, Orphanet)
- Collaboration opportunities announced

**To Stakeholders:**

- Board of Directors annual report
- Funders and grant applications
- Healthcare providers and clinics
- Policy makers (if relevant findings)

---

## Part 6: Ethical & Legal Considerations

### 6.1 Institutional Review Board (IRB)

**IRB Determination:**

**Scenario A: Research Registry (IRB Required)**

- If data will be used for generalizable knowledge (publications, presentations)
- If federally funded or involves vulnerable populations
- Requires full IRB application and approval

**Scenario B: Quality Improvement (IRB May Be Exempt)**

- If primary purpose is internal Foundation program evaluation
- If data used only for quality improvement, not publication
- May qualify for IRB exemption

**Recommendation:** Submit for IRB review to be safe. Exemption or expedited review likely.

**IRB Options:**

1. **University IRB (if partnered for REDCap):**
   - Use partner university's IRB (Pitt, CMU, Penn State)
   - Reliance agreement (single IRB)
   - Cost: $0-$2,000

2. **Independent IRB:**
   - WCG IRB (formerly WIRB), Advarra, others
   - Commercial IRBs for non-academic organizations
   - Cost: $3,000-$10,000 initial + $1,000-$3,000 annual renewal

3. **Defer IRB:**
   - Start as quality improvement (QI) project
   - Seek IRB approval later if research publication desired
   - Risk: May limit publication options

**Recommendation:** Seek IRB approval from university partner (lowest cost) or independent IRB if needed.

### 6.2 Informed Consent

**Consent Elements (Required):**

- Purpose of registry (research and program evaluation)
- Procedures (surveys, optional medical records)
- Time commitment (30-45 min baseline, 15-40 min follow-ups)
- Risks (minimal - breach of confidentiality, emotional distress from health questions)
- Benefits (advance Alpha-1 research, contribute to community, small incentive)
- Confidentiality protections (encryption, secure storage, limited access)
- Voluntary participation (can withdraw anytime without penalty)
- Who to contact with questions (Registry Coordinator, IRB)

**Consent Format:**

- **Electronic consent (e-consent)** - Checkboxes, signature box, timestamp
- **Paper consent** - For events or phone enrollments, mail/email signed copy

**Special Consent Situations:**

- **Medical records:** Separate HIPAA authorization form
- **Genetic data:** Extra sensitivity, special consent language
- **Photos/videos:** Separate consent for use in marketing
- **Minors:** Parental consent + child assent (if adding pediatric registry)

### 6.3 Certificate of Confidentiality

**What It Is:**

- Legal protection from forced disclosure of research data
- Prevents subpoena of identifiable research data
- Issued by NIH (if federally funded) or institutional

**When Needed:**

- If collecting sensitive information (genetic data, substance use, mental health)
- If identifiable data collected
- Recommended for any research with identifiable health information

**How to Obtain:**

- Automatic with NIH funding
- Can request independently through institution
- Reference in consent form

---

## Part 7: Budget & Staffing

### 7.1 Detailed Year 1 Budget

**Personnel:**
| Role | Time | Annual Cost |
|------|------|-------------|
| Registry Coordinator (Part-time) | 0.5 FTE (20 hrs/week) | $25,000-$35,000 |
| Data entry assistance (if needed) | 0.1 FTE or contract | $2,000-$5,000 |
| Biostatistician consultant | 20-40 hours | $3,000-$8,000 |
| **Personnel Subtotal** | | **$30,000-$48,000** |

**Technology & Software:**
| Item | Annual Cost |
|------|-------------|
| REDCap hosting (cloud option) | $0-$10,000 |
| Survey incentives (150 patients x $65) | $9,750 |
| Data storage/backup (if self-hosted) | $0-$1,000 |
| **Technology Subtotal** | **$9,750-$20,750** |

**Compliance & Ethics:**
| Item | Cost |
|------|------|
| IRB application fee | $2,000-$5,000 |
| IRB annual renewal | $1,000-$3,000 |
| HIPAA compliance audit | $1,000-$3,000 |
| Legal consultation (consent, BAA) | $2,000-$5,000 |
| **Compliance Subtotal** | **$6,000-$16,000** |

**Outreach & Recruitment:**
| Item | Cost |
|------|------|
| Recruitment materials (brochures, posters) | $500-$1,500 |
| Facebook/Instagram ads | $1,000-$3,000 |
| Provider engagement (site visits, meals) | $1,000-$2,000 |
| **Outreach Subtotal** | **$2,500-$6,500** |

**Professional Development:**
| Item | Cost |
|------|------|
| Registry training for staff | $500-$1,500 |
| Conference attendance (present findings) | $1,000-$2,500 |
| **Development Subtotal** | **$1,500-$4,000** |

### 7.2 Budget Scenarios

**Minimal Budget ($25,000-$35,000):**

- Part-time Registry Coordinator (0.3 FTE): $15,000-$20,000
- REDCap FREE (university partnership): $0
- IRB through university: $0-$2,000
- Incentives (50 patients): $3,250
- Minimal recruitment: $500
- Biostatistician (volunteer or intern): $0-$2,000
- **Total: ~$18,750-$27,250**

**Moderate Budget ($40,000-$60,000) - RECOMMENDED:**

- Registry Coordinator (0.5 FTE): $25,000-$35,000
- REDCap cloud hosting: $5,000
- Independent IRB: $3,000-$5,000
- Incentives (150 patients): $9,750
- Recruitment and outreach: $2,500
- Biostatistician: $3,000-$5,000
- Training and conference: $1,500
- **Total: ~$49,750-$62,250**

**Optimal Budget ($75,000-$100,000):**

- Registry Coordinator (0.75 FTE): $35,000-$45,000
- REDCap + advanced features: $10,000
- Independent IRB + legal: $8,000
- Incentives (250 patients): $16,250
- Robust recruitment campaign: $6,500
- Dedicated biostatistician: $8,000
- Medical record abstraction: $5,000
- Training, conferences, publications: $4,000
- **Total: ~$92,750-$102,750**

**Recommendation:** Start with moderate budget ($40K-$60K), scale up as registry matures.

### 7.3 Ongoing Costs (Years 2-5)

**Annual Operating Budget:**

- Registry Coordinator: $25,000-$35,000
- REDCap hosting: $0-$10,000
- IRB renewal: $1,000-$3,000
- Follow-up incentives (200-300 surveys x $15-$25): $4,000-$7,500
- Recruitment (replacement for lost to follow-up): $1,000-$3,000
- Analysis and reporting: $3,000-$8,000
- **Total Years 2-5: $34,000-$66,500/year**

**Five-Year Total:** $200,000-$300,000 (assuming moderate growth)

### 7.4 Funding Sources

**Internal Foundation Budget:**

- Allocate from general operating funds
- Grant restricted funds to registry operations

**External Grants:**

- NIH R03 Small Research Grant: $50,000/year for 2 years
- PCORI Patient-Centered Outcomes Research: $50,000-$500,000
- Alpha-1 Foundation research grants: $25,000-$100,000
- Pharmaceutical company research support: $50,000-$150,000 (maintain independence)

**Partnerships:**

- Cost-sharing with academic institutions
- In-kind support (REDCap hosting, IRB, statistician)
- Pharmaceutical companies may fund specific analyses (with safeguards)

---

## Part 8: Launch Timeline

### 8.1 Planning Phase (Months 1-3)

**Month 1: Foundation & Team**

- Hire Registry Coordinator (0.5 FTE)
- Form Steering Committee (recruit 5-7 members)
- Define registry scope and objectives
- Select technology platform (REDCap)

**Month 2: Design & Development**

- Finalize research questions and outcome measures
- Design data collection forms (baseline, follow-up)
- Build REDCap database (surveys, logic, validations)
- Draft informed consent document
- Create recruitment materials

**Month 3: Ethics & Compliance**

- Submit IRB application
- Establish data governance policies
- Execute Business Associate Agreement (BAA) with REDCap host
- Conduct HIPAA compliance training
- Test REDCap database (pilot with 5-10 volunteers)

### 8.2 Launch Phase (Months 4-6)

**Month 4: Soft Launch**

- IRB approval received
- Launch registry website landing page
- Pilot enrollment with 10-20 Foundation board/staff/volunteers
- Gather feedback and refine surveys
- Train staff on enrollment procedures

**Month 5: Public Launch**

- Email invitation to Foundation list (800-1,200 patients)
- Social media announcement campaign
- Provider outreach to 2-3 Alpha-1 clinics
- Goal: 50-75 enrollments Month 5

**Month 6: Early Recruitment**

- Continued email and social media outreach
- Present at support group meetings
- Recruit at Foundation events (if scheduled)
- Goal: 100 total enrollments by end of Month 6

### 8.3 Growth Phase (Months 7-12)

**Month 7-9:**

- Steady recruitment (10-20 enrollments/month)
- First 6-month follow-up surveys begin
- Monthly data quality reviews
- Steering Committee meeting (review progress)

**Month 10-12:**

- Goal: 150-200 total enrollments by Year 1 end
- Complete 6-month follow-ups for early enrollees
- Annual report preparation
- Plan Year 2 recruitment and follow-up

### 8.4 Maturity Phase (Years 2-5)

**Year 2:**

- Maintain enrollment (new patients replacing lost to follow-up)
- Complete annual follow-ups for Year 1 cohort
- First data analysis and manuscript preparation
- Consider adding Spanish language option

**Year 3:**

- 300-400 total enrolled (cumulative)
- Multiple follow-up timepoints (6, 12, 24 months)
- First peer-reviewed publication
- Present findings at Alpha-1 or ATS conference

**Year 4-5:**

- Mature dataset with 3-5 years longitudinal data
- Multiple publications demonstrating impact
- External researcher data requests
- Consider expanding to include MZ carriers or pediatric patients

---

## Part 9: Partnership & Collaboration

### 9.1 Academic Partnerships

**Potential University Partners:**

- **University of Pittsburgh:** Strong pulmonary research, Alpha-1 clinic, REDCap access
- **Penn State Hershey Medical Center:** Alpha-1 research, REDCap consortium
- **Carnegie Mellon University:** Data science, analytics support

**Partnership Benefits:**

- FREE or low-cost REDCap hosting
- IRB services
- Biostatistical support (graduate students, faculty consultants)
- Credibility and visibility
- Co-authorship opportunities

**Partnership Structure:**

- Memorandum of Understanding (MOU)
- Define roles and responsibilities
- Data ownership and publication rights
- Cost-sharing arrangements
- Term: 3-5 years with renewal option

### 9.2 Alpha-1 Foundation Collaboration

**Alignment Opportunities:**

- AlphaNet disease management registry (20,000+ patients)
- Alpha-1 Research Registry (clinical research)
- Avoid duplication, focus on Foundation-specific outcomes

**Potential Collaboration:**

- Cross-reference patients (with consent) for data linkage
- Share aggregate findings
- Joint publications on financial assistance impact
- Harmonize data elements where possible

**Maintaining Independence:**

- Mark Egly Foundation registry focuses on quality of life, financial toxicity, service utilization
- Complementary to, not competing with, Alpha-1 Foundation registries
- Separate governance and data access policies

### 9.3 Healthcare Provider Networks

**Recruiting Provider Partners:**

- Alpha-1 clinics at UPMC, Penn State, Cleveland Clinic
- Community pulmonologists treating Alpha-1 patients
- Value proposition: Contribute to research, track patient outcomes, free patient resources

**Provider Engagement:**

- Site visits to explain registry
- Provide patient brochures and QR codes
- Monthly enrollment updates
- Offer co-authorship on publications
- CME credit for participation (if applicable)

---

## Part 10: Risk Management

### 10.1 Potential Risks & Mitigation

**Risk 1: Low Enrollment (<50% target)**
**Mitigation:**

- Increase incentives ($50 baseline, $25 follow-up)
- Simplify surveys (reduce time to 20-30 min)
- Offer phone enrollment option
- Partner with more providers
- Leverage events for in-person recruitment

**Risk 2: High Loss to Follow-Up (>30%)**
**Mitigation:**

- Multiple reminder methods (email, phone, text)
- Flexible follow-up windows (±4 weeks)
- Interim check-ins (3-month brief survey)
- Engagement activities (webinars, newsletters)
- Exit interviews to understand why participants leave

**Risk 3: Data Quality Issues (missing data, errors)**
**Mitigation:**

- Extensive data validation in REDCap
- Real-time data quality reports
- Quarterly audits and cleaning
- Staff training on data collection
- Participant instructions and examples

**Risk 4: Privacy Breach**
**Mitigation:**

- Encrypted data storage and transmission
- Limited access (role-based permissions)
- Regular security audits
- Incident response plan
- Cyber insurance

**Risk 5: Lack of Funding for Years 2-5**
**Mitigation:**

- Apply for external grants (NIH, PCORI, Alpha-1 Foundation)
- Demonstrate value early (Year 1 report)
- Budget for registry in Foundation strategic plan
- Explore pharmaceutical company partnerships (with COI safeguards)
- Reduce scope if needed (annual follow-up only, no incentives)

**Risk 6: Ethical Concerns or Participant Complaints**
**Mitigation:**

- Clear consent process
- Responsive Registry Coordinator
- Steering Committee oversight
- IRB reporting of adverse events
- Participant advisory board

### 10.2 Contingency Planning

**If Enrollment Falls Short:**

- Extend enrollment period to 18 months
- Lower target to 75-100 patients (still valuable for Foundation program evaluation)
- Focus on quality over quantity

**If Funding Runs Out:**

- Pause active recruitment, maintain follow-up for enrolled patients
- Reduce incentives (offer only to completers, not all participants)
- Seek emergency bridge funding from board
- Archive data for future use

**If Key Staff Leave:**

- Cross-train multiple staff on registry operations
- Document all procedures (SOP manual)
- Maintain relationship with Steering Committee
- Budget for consultant coverage if needed

---

## Appendix A: Sample Consent Form (Abbreviated)

**INFORMED CONSENT TO PARTICIPATE IN RESEARCH**

**Title:** Mark Egly Foundation Patient Registry and Outcomes Study

**Principal Investigator:** [Registry Coordinator Name, Title]

**Purpose:** You are invited to participate in a patient registry to track health outcomes and quality of life for people with Alpha-1 Antitrypsin Deficiency. The information collected will help us understand how the disease affects people over time and how Foundation services make a difference.

**Procedures:** If you agree to participate:

- You will complete an online survey at enrollment (30-45 minutes)
- You will complete follow-up surveys every 6-12 months (15-40 minutes)
- With your permission, we may request medical records from your doctor
- You may be contacted for additional studies in the future

**Time Commitment:** Approximately 1-2 hours per year

**Risks:** Risks are minimal. You may experience emotional distress when answering health questions. There is a small risk of privacy breach, but we use secure systems to protect your information.

**Benefits:** You will contribute to Alpha-1 research and help improve care for future patients. You will receive a small incentive ($25-$65/year) for completing surveys.

**Confidentiality:** Your information will be kept confidential. Only authorized research staff will have access. Data may be shared with other researchers in de-identified form.

**Voluntary:** Participation is voluntary. You may withdraw at any time without penalty.

**Questions:** Contact [Registry Coordinator] at [email] or [phone] with questions.

**Consent:** By checking the box below, I confirm:

- ☐ I have read and understand this consent form
- ☐ I voluntarily agree to participate
- ☐ I am at least 18 years old

[Electronic Signature Box]
[Date]

---

## Appendix B: Baseline Survey Outline

**Section 1: Demographics (5 minutes)**

- Age, gender, race/ethnicity
- Education level, employment status
- Insurance type, household income
- ZIP code
- Marital status, household size

**Section 2: Alpha-1 Diagnosis & History (10 minutes)**

- Year of diagnosis
- How diagnosed (symptoms, screening, family testing)
- Genotype (ZZ, SZ, MZ, other)
- Serum AAT level (if known)
- Smoking history (pack-years)
- Family members with Alpha-1

**Section 3: Clinical Status (10 minutes)**

- Lung disease presence and severity (emphysema, COPD)
- Liver disease presence (cirrhosis, hepatitis)
- Most recent FEV1 (% predicted, if known)
- Augmentation therapy (yes/no, start date, frequency)
- Other medications (inhaled steroids, bronchodilators, oxygen)
- Comorbidities (asthma, diabetes, heart disease, etc.)

**Section 4: Healthcare Utilization (Past Year) (5 minutes)**

- Pulmonologist visits (number)
- Hospitalizations (number, reason)
- Emergency room visits
- Pulmonary rehabilitation (yes/no)
- Lung transplant (yes/no, waitlist status)

**Section 5: Quality of Life - SGRQ (8 minutes)**

- St. George's Respiratory Questionnaire
- 50 items, validated for COPD/Alpha-1
- Scores: Symptoms, Activity, Impacts, Total

**Section 6: Symptom Burden - CAT (2 minutes)**

- COPD Assessment Test
- 8 items, quick screener
- Score 0-40 (higher = worse symptoms)

**Section 7: Mental Health - PHQ-4 (1 minute)**

- 4-item depression and anxiety screener
- Scores: 0-12 (≥3 suggests issue)

**Section 8: Financial Burden - COST-FACIT Brief (3 minutes)**

- Financial toxicity of healthcare
- 6-item validated scale
- Scores: 0-24 (lower = higher burden)

**Section 9: Foundation Services (5 minutes)**

- Aware of Foundation? (yes/no)
- Services used: (checkboxes)
  - ☐ Financial assistance (type, amount)
  - ☐ Events attended (Annual Gala, walks)
  - ☐ Support groups
  - ☐ Educational resources
  - ☐ Volunteer activities
  - ☐ Other
- Satisfaction with services (1-5 scale)
- Unmet needs (open text)

**Total Time:** 30-45 minutes

---

## Appendix C: Six-Month Follow-Up Survey Outline

**Section 1: Current Symptom Burden - CAT (2 minutes)**

- COPD Assessment Test (8 items)

**Section 2: Healthcare Utilization (Past 6 Months) (3 minutes)**

- Doctor visits, hospitalizations, ER visits
- Changes in medications

**Section 3: Treatment Adherence (2 minutes)**

- Currently on augmentation therapy? (yes/no)
- If yes, how often do you miss doses? (never, rarely, sometimes, often)
- If no, why not? (not prescribed, too expensive, side effects, other)

**Section 4: Foundation Services (Past 6 Months) (3 minutes)**

- Services used since last survey
- Financial assistance received

**Section 5: Life Changes (5 minutes)**

- Change in employment, insurance, living situation
- New Alpha-1 diagnoses in family (cascade testing)
- Any major life events affecting health

**Total Time:** 15-20 minutes

---

## Document Approval

**Prepared by:** VLX AI Assistant
**Date:** November 2025
**Version:** 1.0
**Next Review:** Upon IRB approval and 6 months post-launch

**Approvers:**

- [ ] Executive Director
- [ ] Medical Director / Clinical Advisor
- [ ] Registry Steering Committee Chair
- [ ] Board Chair (for budget approval)
- [ ] Legal Counsel (for consent and compliance)

---

_This document is part of the Mark Egly Foundation Phase 2 Expansion series. For related strategies, see:_

- _Document #15: Research Data Management (upcoming - final document)_
- _Document #9: Genetic Testing Company Partnerships_
- _Document #8: Pharmaceutical Company Partnership Framework_
