# ALPHA1LIFE.COM RESEARCH PLATFORM

## Research Strategy - Part 2 (Aims 4-5)

_[Continued from Part 1]_

---

## AIM 4: CLINICAL TRIAL ACCELERATION

### Background & Rationale

Clinical trials for Alpha-1 therapies face severe recruitment challenges:

- **Small eligible population**: Only ~3,000 diagnosed ZZ patients in US meet typical trial criteria (FEV₁ 30-65%, non-smoker, age 18-65)
- **Geographic dispersion**: Patients scattered across US, often >500 miles from trial sites
- **Slow recruitment**: Industry trials take 2-4 years to recruit 200 patients
- **High screen failure rate**: 70% of patients screened don't meet eligibility criteria

**Current recruitment pathway** (inefficient):

1. Trial sponsor posts to ClinicalTrials.gov
2. Patients search manually (if aware of trial)
3. Patients call site coordinator → phone screening → often ineligible
4. **Result**: 50-100 phone calls to enroll 1 patient, $30K cost per enrollment

**Alpha1Life.com solution**: Automated trial matching using registry data, enabling:

- **Proactive recruitment**: System identifies eligible patients automatically
- **Pre-screening**: Electronic eligibility check before patient contact (reduces screen failures)
- **One-click consent**: Patient opts in with single button, coordinator receives referral
- **Multi-trial recruitment**: Same infrastructure supports 10+ concurrent trials

**Impact**: Reduce recruitment time from 3 years to 9 months, reduce cost from $30K to $3K per patient.

---

### Aim 4 Overview

**Objective**: Deploy a clinical trial matching algorithm that accelerates enrollment from 3 years to 9 months per trial by proactively identifying and recruiting eligible Alpha1Life.com registry participants.

**Hypothesis**: Automated electronic pre-screening using registry data will reduce screen failure rate from 70% to <20%, enabling 3× faster recruitment at 1/10th the cost.

**Expected Outcomes**:

- Enroll 5,000+ patients across 10 trials (Years 2-5)
- Reduce recruitment time by 75% (3 years → 9 months)
- Reduce recruitment cost by 90% ($30K → $3K per patient)
- Generate $2M-$5M in revenue (trial enrollment fees)

**Budget**: $1.2M-$1.8M (Years 2-5)

---

### Aim 4 Methods

#### 4.1 Trial Matching Algorithm

**Input Data Sources**:

1. **ClinicalTrials.gov API**:
   - Pull all Alpha-1 trials (search: "alpha-1 antitrypsin deficiency")
   - Extract: Inclusion/exclusion criteria, trial locations, contact info
   - **Frequency**: Daily automated pull (new trials added weekly)

2. **Pharmaceutical Partner Trials** (Direct Feed):
   - Genentech (gene therapy trials)
   - CSL Behring (augmentation therapy trials)
   - Vertex Pharmaceuticals (CFTR modulators for Alpha-1)
   - **MOU**: Companies provide trial criteria pre-publication for early recruitment

3. **Alpha1Life.com Registry Data**:
   - Demographics: Age, sex, location (ZIP code)
   - Genotype: ZZ, SZ, MZ
   - Lung function: FEV₁ percent predicted, FEV₁/FVC ratio
   - Liver status: ALT, AST, bilirubin, cirrhosis diagnosis
   - Smoking: Current, former, never (pack-years)
   - Medications: Augmentation therapy, other treatments
   - Comorbidities: Diabetes, heart disease, cancer (often exclusions)

**Eligibility Parsing** (Natural Language Processing):

- **Challenge**: Trial criteria written in free text, not structured
- **Example**: "Adults 18-65 with FEV₁ 30-65% predicted, non-smoker for ≥12 months, on augmentation therapy ≥6 months"

**Parsing Steps**:

1. **Text Extraction**: OCR from ClinicalTrials.gov PDFs
2. **Entity Recognition** (spaCy, SciSpaCy):
   - Age: Extract "18-65" → min_age=18, max_age=65
   - FEV₁: Extract "30-65%" → fev1_min=30, fev1_max=65
   - Smoking: Extract "non-smoker ≥12 months" → smoking_status="former", months_quit≥12
3. **Logical Rules**: Convert to IF-THEN statements
   - IF age≥18 AND age≤65 AND fev1≥30 AND fev1≤65 AND smoking_status="never" THEN eligible=TRUE

**Manual Validation**:

- Research coordinator reviews all parsed criteria (QC)
- Ambiguous criteria flagged → contact trial sponsor for clarification

---

#### 4.2 Matching Process (Monthly)

**Step 1**: Load all active trials (N=10-20 at any time)

**Step 2**: For each trial, query registry:

```sql
SELECT patient_id, name, email, phone
FROM registry
WHERE age BETWEEN trial.min_age AND trial.max_age
  AND fev1 BETWEEN trial.fev1_min AND trial.fev1_max
  AND smoking_status = trial.smoking_status
  AND genotype IN trial.genotypes
  AND distance_to_site(zip_code, trial.site_zip) < 100 miles
  AND NOT EXISTS (SELECT 1 FROM trial_history WHERE patient_id = registry.patient_id AND trial_id = trial.id AND declined = TRUE)
```

**Step 3**: Generate match list (typically 50-200 patients per trial)

**Step 4**: Send automated email:

- **Subject**: "You may be eligible for a clinical trial"
- **Body**: Trial description, phase, duration, compensation, site location
- **Call-to-Action**: [Learn More] [Express Interest] [Not Interested]

**Step 5**: Patient clicks "Express Interest" → coordinator receives referral with pre-filled data

---

#### 4.3 Patient Communication Workflow

**Email Notification** (Example):

```
Hi [FirstName],

Good news! There's a new Alpha-1 clinical trial that you may be eligible for:

TRIAL: Gene Therapy for Alpha-1 Antitrypsin Deficiency (Phase 2)
SPONSOR: Genentech
SITES: Cleveland Clinic, National Jewish Health, Temple University (5 others)
DURATION: 3 years (monthly visits Year 1, quarterly Years 2-3)
COMPENSATION: $100/visit + travel reimbursement

WHY YOU MATCH:
✓ Age: 45 (trial requires 18-65)
✓ FEV₁: 52% predicted (trial requires 30-70%)
✓ Genotype: ZZ (required)
✓ Distance: 38 miles to Cleveland Clinic

WHAT HAPPENS NEXT:
If you're interested, our coordinator will call to discuss details and confirm eligibility.

[EXPRESS INTEREST] [LEARN MORE] [NOT INTERESTED]

Questions? Reply to this email or call 1-800-ALPHA-1.

- The Alpha1Life.com Team
```

**Consent Process**:

- Patient clicks "Express Interest" → HIPAA authorization to share data with trial site
- Digital signature (DocuSign)
- Data transmitted to site coordinator via secure portal

---

#### 4.4 Pilot Trials (Years 2-5)

**Trial 1: Augmentation Therapy Dose-Ranging Study**

- **Sponsor**: CSL Behring
- **Phase**: 3
- **Target**: 300 patients (ZZ, FEV₁ 30-65%)
- **Timeline**: 18 months (vs. 36 months traditional)
- **Alpha1Life.com Contribution**: 200 of 300 patients (67%)

**Trial 2: Gene Therapy (AAV8-hAAT)**

- **Sponsor**: Genentech
- **Phase**: 2
- **Target**: 100 patients (ZZ, FEV₁ 35-60%, no liver disease)
- **Timeline**: 12 months (vs. 30 months traditional)
- **Alpha1Life.com Contribution**: 75 of 100 patients (75%)

**Trial 3: Anti-Fibrotic for Liver Disease**

- **Sponsor**: Intercept Pharmaceuticals
- **Phase**: 2
- **Target**: 50 patients (ZZ, liver fibrosis F2-F3)
- **Timeline**: 9 months (vs. 24 months traditional)
- **Alpha1Life.com Contribution**: 40 of 50 patients (80%)

**Additional Trials** (Years 3-5):

- CFTR modulators (Vertex)
- JAK inhibitors (Incyte)
- Augmentation therapy adherence study (investigator-initiated)
- Natural history study (Alpha-1 Foundation)

**Total Enrollment** (Years 2-5):

- 10 trials × 500 patients average = **5,000 patients enrolled**

---

#### 4.5 Success Metrics

**Primary Metrics**:

1. **Recruitment Time**: Days from trial launch to full enrollment
   - **Goal**: <270 days (9 months) vs. 1,095 days (3 years) baseline
2. **Screen Failure Rate**: % of patients who fail eligibility after phone screen
   - **Goal**: <20% vs. 70% baseline
3. **Cost per Enrollment**: Coordinator time + patient travel
   - **Goal**: $3K vs. $30K baseline

**Secondary Metrics**: 4. **Patient Satisfaction**: Survey (5-point scale)

- **Goal**: ≥4.5 average ("very satisfied")

5. **Trial Diversity**: % non-white participants
   - **Goal**: ≥30% (vs. 10% typical Alpha-1 trial)
6. **Retention Rate**: % completing trial
   - **Goal**: ≥90% (vs. 70% typical)

---

#### 4.6 Revenue Model

**Trial Enrollment Fees**:

- Sponsor pays Foundation $5K per enrolled patient
- **Rationale**: Foundation provides recruitment infrastructure, reduces sponsor costs by $25K/patient
- **Revenue** (Years 2-5): 5,000 patients × $5K = **$25M total** → **$2M/year Foundation share** (rest to sites)

**Revenue Allocation**:

- 60% to trial sites ($3K/patient compensation for coordinator time)
- 40% to Foundation ($2K/patient for platform operations)

**Sustainability**: Trial revenue funds 70% of platform operating costs by Year 5

---

#### 4.7 Regulatory & Ethical Considerations

**IRB Oversight**:

- Trial matching activity covered under registry IRB protocol
- No additional IRB approval needed (recruitment activity, not research)

**HIPAA Compliance**:

- Patient consent includes: "You may be contacted about clinical trials"
- Opt-out option: Patients can decline future trial notifications
- Data sharing: Only with patient's explicit consent (per-trial authorization)

**Conflict of Interest**:

- Foundation receives enrollment fees → potential bias toward recruitment
- **Mitigation**: Patient education (trials are voluntary, no pressure), independent data safety monitoring

**Equity**:

- Algorithm doesn't filter by race, insurance, socioeconomic status
- Travel support provided (eliminates financial barrier)
- Materials translated (Spanish, Chinese for diverse populations)

---

### Aim 4 Timeline

| Quarter  | Milestone                                                    |
| -------- | ------------------------------------------------------------ |
| Y2 Q1    | Algorithm development (NLP for eligibility parsing)          |
| Y2 Q2    | Pilot trial 1 launched (CSL Behring augmentation study)      |
| Y2 Q3    | Enroll first 100 patients (validate 9-month timeline)        |
| Y2 Q4    | Refine algorithm based on feedback                           |
| Y3 Q1    | Pilot trial 2 (Genentech gene therapy)                       |
| Y3 Q2-Q4 | Scale to 5 concurrent trials                                 |
| Y4-Y5    | Sustain 10 concurrent trials, 1,000 patients/year enrollment |

---

### Aim 4 Budget

| Category              | Amount    | Justification                                                                                   |
| --------------------- | --------- | ----------------------------------------------------------------------------------------------- |
| Personnel             | $400K     | Clinical research coordinator (1 FTE × 4 years), trial matching coordinator (0.5 FTE × 4 years) |
| Technology            | $200K     | Trial matching software, NLP development, ClinicalTrials.gov API integration                    |
| Patient Travel        | $75K      | 500 patients × $150 average (partial travel support for site visits)                            |
| Recruitment Materials | $25K      | Brochures, videos, email templates                                                              |
| **Total**             | **$700K** | _Plus $25M in trial enrollment fees (offsetting costs)_                                         |

---

### Aim 4 Potential Pitfalls & Mitigation

**Pitfall 1**: Patients don't respond to trial notifications (low click-through rate)

- **Mitigation**: A/B test email designs, personalize messages, offer phone call option

**Pitfall 2**: Eligibility criteria too complex to parse (NLP fails)

- **Mitigation**: Manual review by coordinator, contact sponsor for clarification

**Pitfall 3**: Patients eligible but decline trial (too burdensome)

- **Mitigation**: Offer travel support, flexible visit schedules, telemedicine for some visits

**Pitfall 4**: Trial sponsors don't pay enrollment fees (unwilling to partner)

- **Mitigation**: Demonstrate ROI (75% faster recruitment, 90% cost reduction), offer pilot trial for free

**Pitfall 5**: Regulatory burden (FDA audits, IRB concerns)

- **Mitigation**: Legal review of all MOUs, annual IRB audits, document all patient consents

---

## AIM 5: PATIENT ENGAGEMENT

### Background & Rationale

Alpha-1 is an isolating disease:

- **Rare**: Most patients don't know anyone else with Alpha-1
- **Misunderstood**: Providers, family, employers often unfamiliar
- **Psychosocial burden**: Anxiety (67% of patients), depression (45%), genetic guilt (passing to children)

**Current support landscape** (inadequate):

- Alpha-1 Foundation offers annual conference (1,000 attendees, once/year)
- Facebook groups (informal, unmoderated, misinformation risk)
- No structured mentorship programs
- No mental health resources specific to Alpha-1

**Consequences of poor engagement**:

- **Low treatment adherence**: Only 40% of patients on augmentation therapy take it consistently
- **High registry attrition**: 40% drop out by Year 5 (can't complete longitudinal studies)
- **Poor quality of life**: Mental health worse than many other chronic diseases

**Alpha1Life.com solution**: Comprehensive engagement programs (support groups, mentorship, conference, advocacy) to:

1. Reduce patient isolation
2. Improve mental health (PHQ-9, GAD-7 scores)
3. Increase treatment adherence (+25%)
4. Maximize registry retention (95% at 5 years)

---

### Aim 5 Overview

**Objective**: Deploy patient engagement tools (support groups, mentorship, conference, advocacy) that improve mental health by ≥30% and registry retention to 95% at 5 years.

**Hypothesis**: Structured peer support will reduce depression/anxiety scores, improve treatment adherence, and increase registry retention compared to usual care (no structured support).

**Expected Outcomes**:

- Engage 2,500 participants in support programs (Years 2-5)
- Improve PHQ-9 (depression) by 30% (8.5 → 6.0 average)
- Improve GAD-7 (anxiety) by 30% (9.2 → 6.5 average)
- Increase augmentation therapy adherence from 40% to 65%
- Achieve 95% registry retention at 5 years (vs. 60% typical)

**Budget**: $1.4M-$1.6M (Years 2-5)

---

### Aim 5 Methods

#### 5.1 Virtual Support Groups

**7 Support Group Types** (Monthly Meetings):

1. **Newly Diagnosed** (Target: 500 participants):
   - **Purpose**: Emotional support, education about Alpha-1
   - **Format**: 90-minute Zoom sessions, first Thursday of month
   - **Facilitator**: Licensed social worker (LCSW) + patient peer leader
   - **Topics**: Understanding diagnosis, treatment options, family screening, coping strategies

2. **Caregivers & Family** (Target: 300 participants):
   - **Purpose**: Support for spouses, children, parents of Alpha-1 patients
   - **Format**: 60-minute sessions, second Tuesday
   - **Topics**: Communication, managing stress, respite care, genetic counseling for children

3. **Lung Transplant** (Target: 100 participants):
   - **Purpose**: Pre-/post-transplant support
   - **Format**: 90-minute sessions, third Monday
   - **Facilitator**: Transplant nurse + patient who has undergone transplant
   - **Topics**: Evaluation process, surgery recovery, immunosuppression, life after transplant

4. **Liver Disease** (Target: 200 participants):
   - **Purpose**: Support for patients with Alpha-1 liver involvement
   - **Format**: 60-minute sessions, fourth Wednesday
   - **Topics**: Managing cirrhosis, portal hypertension, liver transplant, hepatocellular carcinoma screening

5. **Parenting with Alpha-1** (Target: 400 participants):
   - **Purpose**: Raising children while managing chronic illness
   - **Format**: 60-minute sessions, first Saturday (family-friendly time)
   - **Topics**: Talking to kids about Alpha-1, family planning, genetic testing for children

6. **Young Adults (18-35)** (Target: 300 participants):
   - **Purpose**: Peer support for younger patients
   - **Format**: 60-minute sessions, second Thursday evening
   - **Topics**: Dating/relationships, career decisions, insurance/financial concerns, family planning

7. **End-of-Life & Palliative Care** (Target: 100 participants):
   - **Purpose**: Support for patients with advanced disease
   - **Format**: 60-minute sessions, third Wednesday
   - **Facilitator**: Palliative care nurse + hospice social worker
   - **Topics**: Advance directives, symptom management, hospice, legacy planning

**Recruitment**:

- All registry participants invited via email
- Monthly reminders with Zoom links
- Recorded sessions available for those who can't attend live

**Facilitator Training**:

- 20-hour training program (mental health first aid, group facilitation, Alpha-1 education)
- Quarterly supervision with licensed psychologist
- Compensation: $200/session

---

#### 5.2 Mentor Matching Program

**Model**: 1-on-1 mentorship pairing experienced Alpha-1 patients ("Alphas") with newly diagnosed patients ("Mentees")

**Eligibility**:

**Mentors**:

- Diagnosed ≥2 years ago
- Stable disease (not in crisis)
- Complete 10-hour training program (active listening, boundaries, crisis management)
- Pass background check

**Mentees**:

- Diagnosed within 6 months
- Voluntarily request mentor
- Commit to ≥3 months of monthly calls

**Matching Algorithm**:

- Demographics: Age (±10 years), sex, geography (for potential in-person meetups)
- Clinical: Lung vs. liver involvement, similar disease severity
- Psychosocial: Parenting status, employment, smoking history

**Format**:

- Monthly phone/video calls (30-60 minutes)
- Mentors check in via text between calls
- Duration: Minimum 3 months, average 12 months

**Goals**:

- Reduce mentee anxiety/depression
- Improve knowledge about Alpha-1
- Increase engagement with care (appointments, medication adherence)
- Mentor benefits: Sense of purpose, altruism

**Scale**:

- Year 2: 100 mentees paired
- Year 3: 200 mentees
- Year 4: 300 mentees
- Year 5: 500 mentees
- **Total**: 1,100 mentees over 4 years

**Outcomes Tracking**:

- Mentees complete PHQ-9, GAD-7 at baseline, 3 months, 6 months
- Mentors complete burnout survey quarterly

---

#### 5.3 Annual Alpha1Life.com Conference

**Purpose**: In-person gathering for education, networking, advocacy

**Format**:

- 2-day conference (Friday-Saturday)
- Keynote speakers (researchers, clinicians, patients)
- Breakout sessions (lung/liver disease, genetics, clinical trials, advocacy)
- Exhibit hall (sponsors, vendors, support organizations)
- Saturday evening gala (fundraising, awards)

**Scale**:

- Year 3: 200 attendees (pilot)
- Year 4: 350 attendees
- Year 5: 500 attendees

**Locations** (Rotate Annually):

- Year 3: Cleveland, OH (near Cleveland Clinic)
- Year 4: Denver, CO (near National Jewish Health)
- Year 5: Orlando, FL (central location, family-friendly)

**Revenue Model**:

- Attendee registration: $100/person (covers 30% of costs)
- Sponsor exhibits: $250K (pharma, biotech companies)
- Fundraising gala: $100K (individual donors)
- Foundation subsidy: $140K (Year 3), $200K (Year 4), $250K (Year 5)

**Programming**:

- **Friday Morning**: Research updates (gene therapy, precision medicine)
- **Friday Afternoon**: Clinical sessions (managing exacerbations, liver transplant)
- **Friday Evening**: Welcome reception (networking)
- **Saturday Morning**: Advocacy training (how to contact legislators)
- **Saturday Afternoon**: Breakout groups (lung, liver, newly diagnosed, caregivers)
- **Saturday Evening**: Gala (awards for patient advocates, researchers)

**Scholarships**: 50 patients receive full travel reimbursement (prioritize low-income, rural)

---

#### 5.4 Advocacy & Policy Tools

**Advocacy Hub** (Alpha1Life.com/Advocacy):

1. **Legislative Tracker**:
   - Bills related to Alpha-1 (newborn screening, gene therapy coverage)
   - State-by-state status
   - Action alerts ("Your senator needs to hear from you!")

2. **Sample Letters**:
   - Templates for contacting legislators
   - Personalized with patient's story
   - One-click send via Quorum platform

3. **Patient Stories**:
   - Video library (patients sharing experiences)
   - Used for advocacy campaigns, media outreach

4. **Policy Priorities** (Foundation-led):
   - **Priority 1**: Universal newborn screening (all 50 states by 2030)
   - **Priority 2**: Medicare/Medicaid coverage for gene therapy
   - **Priority 3**: Workplace protections (ADA enforcement)

**Advocacy Training** (Annual Conference):

- 3-hour workshop on Friday afternoon
- Teach: How to tell your story, meeting with legislators, media interviews
- Mock sessions (practice elevator pitch)

**Lobbying Days**:

- Annual trip to Washington, DC (20 patients)
- Meet with congresspersons, FDA officials
- Foundation covers travel + hotel

**Impact Goals** (Years 2-5):

- 10 states adopt newborn screening for Alpha-1
- 3 insurance policies expand gene therapy coverage
- 50 media placements (TV, newspaper, podcasts)

---

#### 5.5 Employer Education Program

**Purpose**: Reduce workplace discrimination, educate employers about Alpha-1

**Target Audience**: HR directors, occupational health nurses

**Materials**:

- **Employer Toolkit** (PDF, 20 pages):
  - What is Alpha-1?
  - ADA protections (reasonable accommodations)
  - Common misconceptions ("It's contagious" - FALSE)
  - Case studies (successful accommodations)

**Webinars** (Quarterly):

- 1-hour lunch-and-learn for employers
- CME credit for occupational health professionals
- Q&A with employment lawyer

**Partnerships**:

- Society for Human Resource Management (SHRM)
- American College of Occupational & Environmental Medicine (ACOEM)

**Reach**: 500 employers (1M employees) by Year 5

---

### Aim 5 Outcomes

#### Primary Outcome: Mental Health Improvement

**Measures**:

- **PHQ-9** (Patient Health Questionnaire-9): Depression screening (0-27 scale)
- **GAD-7** (Generalized Anxiety Disorder-7): Anxiety screening (0-21 scale)

**Baseline** (Alpha-1 patients, national average):

- PHQ-9: 8.5 (mild depression)
- GAD-7: 9.2 (moderate anxiety)

**Target** (Participants in support programs):

- PHQ-9: 6.0 (minimal depression) - **30% improvement**
- GAD-7: 6.5 (mild anxiety) - **29% improvement**

**Analysis**:

- Compare participants vs. non-participants (registry controls)
- Adjust for: Age, sex, disease severity, baseline mental health
- Model: Linear mixed effects (repeated measures at 0, 6, 12 months)

---

#### Secondary Outcomes

**1. Treatment Adherence**:

- **Measure**: Self-reported augmentation therapy adherence (% of doses taken)
- **Baseline**: 40% (national average, based on pharmacy refill data)
- **Target**: 65% (support group participants)
- **Impact**: 25% improvement, translates to slower FEV₁ decline

**2. Registry Retention**:

- **Measure**: % of participants completing Year 5 surveys
- **Baseline**: 60% (typical longitudinal registry)
- **Target**: 95% (Alpha1Life.com with engagement programs)
- **Impact**: Complete data for 95% of cohort (enables robust analyses)

**3. Quality of Life**:

- **Measure**: SF-36 (Short Form-36 Health Survey)
- **Target**: 10-point improvement in mental health component score

**4. Social Connectedness**:

- **Measure**: UCLA Loneliness Scale
- **Target**: 20% reduction in loneliness scores

**5. Patient Activation**:

- **Measure**: PAM-13 (Patient Activation Measure)
- **Target**: Shift from Level 2 (passive) to Level 3 (taking action)

---

### Aim 5 Timeline

| Quarter | Milestone                                                          |
| ------- | ------------------------------------------------------------------ |
| Y2 Q1   | Recruit facilitators, develop curriculum                           |
| Y2 Q2   | Launch 7 support groups (pilot with 100 participants)              |
| Y2 Q3   | Launch mentor matching (100 pairs)                                 |
| Y2 Q4   | Evaluate pilot, refine based on feedback                           |
| Y3 Q1   | Scale support groups (500 participants)                            |
| Y3 Q2   | Scale mentor matching (200 pairs)                                  |
| Y3 Q3   | Plan annual conference                                             |
| Y3 Q4   | Conference #1 (Cleveland, 200 attendees)                           |
| Y4      | Sustain programs, Conference #2 (Denver, 350 attendees)            |
| Y5      | Full scale (2,500 engaged), Conference #3 (Orlando, 500 attendees) |

---

### Aim 5 Budget

| Category            | Amount      | Justification                                            |
| ------------------- | ----------- | -------------------------------------------------------- |
| Personnel           | $400K       | Community engagement specialist (1 FTE × 4 years)        |
| Facilitators        | $460K       | $200/session × 4 sessions/month × 7 groups × 48 months   |
| Mentor Training     | $60K        | $15K/year × 4 years (trainers, materials)                |
| Conference          | $590K       | Year 3 ($140K), Year 4 ($200K), Year 5 ($250K)           |
| Technology          | $50K        | Zoom licenses, conference platform (Whova)               |
| Travel Scholarships | $75K        | 50 patients × $1,500 average × 3 conferences (Years 3-5) |
| **Total**           | **$1.635M** |                                                          |

---

### Aim 5 Potential Pitfalls & Mitigation

**Pitfall 1**: Low participation (patients don't attend support groups)

- **Mitigation**: A/B test times, offer recordings, incentivize (gift cards for first-time attendees)

**Pitfall 2**: Mentor-mentee mismatches (conflict, poor rapport)

- **Mitigation**: Careful matching algorithm, allow re-matching, quarterly check-ins

**Pitfall 3**: Facilitator burnout (emotional toll)

- **Mitigation**: Quarterly supervision, peer support for facilitators, limit to 2 groups/facilitator

**Pitfall 4**: Conference doesn't attract attendees (low registration)

- **Mitigation**: Early bird discounts, keynote speakers (celebrities, politicians), family-friendly activities

**Pitfall 5**: Mental health improvements not sustained (short-term effect)

- **Mitigation**: Ongoing engagement (not one-time), booster sessions, link to community mental health resources

---

## TIMELINE & MILESTONES

### Year-by-Year Overview

| Year  | Aim 1                                   | Aim 2                           | Aim 3                    | Aim 4                  | Aim 5                         |
| ----- | --------------------------------------- | ------------------------------- | ------------------------ | ---------------------- | ----------------------------- |
| **1** | Registry launch (5K patients)           | -                               | -                        | -                      | -                             |
| **2** | Registry grows (15K patients)           | -                               | -                        | Algorithm dev, Trial 1 | Support groups launch         |
| **3** | Registry complete (25K), Biobank launch | -                               | WGS begins               | Trials 2-3             | Mentor matching, Conference 1 |
| **4** | Biobank grows (10K samples)             | AI development, EHR integration | GWAS analysis            | Trials 4-7             | Conference 2                  |
| **5** | Biobank complete (20K samples)          | AI deployment (10 sites)        | PRS validation, PGx test | Trials 8-10            | Conference 3, Advocacy wins   |

---

### Quarterly Milestones (Detailed)

**YEAR 1**:

- Q1: IRB approval, REDCap setup, hire staff
- Q2: Registry launch (media campaign, patient recruitment begins)
- Q3: 2,500 patients enrolled
- Q4: 5,000 patients enrolled (interim analysis, refine recruitment)

**YEAR 2**:

- Q1: 7,500 patients (support groups launch)
- Q2: 10,000 patients (trial matching algorithm pilot)
- Q3: 12,500 patients (first trial enrollment begins)
- Q4: 15,000 patients (mentor matching launches)

**YEAR 3**:

- Q1: 17,500 patients
- Q2: 20,000 patients (biobank launch, MOU with Alpha-1 Foundation)
- Q3: 22,500 patients (conference planning)
- Q4: 25,000 patients (COMPLETE AIM 1), WGS begins, Conference #1 (Cleveland)

**YEAR 4**:

- Q1: Biobank 2,500 samples, AI training data assembled
- Q2: Biobank 5,000 samples, AI model development
- Q3: Biobank 7,500 samples, GWAS analysis (discover 20+ loci)
- Q4: Biobank 10,000 samples, EHR integration pilot (5 sites), Conference #2 (Denver)

**YEAR 5**:

- Q1: Biobank 12,500 samples, AI deployment (10 sites)
- Q2: Biobank 15,000 samples, PRS development
- Q3: Biobank 17,500 samples, PGx analysis
- Q4: Biobank 20,000 samples (COMPLETE AIM 1), AI validation, Conference #3 (Orlando)

---

## RIGOR & REPRODUCIBILITY

### Statistical Power

**Aim 1 (Registry/Biobank)**:

- 25,000 patients: 90% power to detect genetic modifiers (OR≥1.3, MAF≥5%, α=5×10⁻⁸)

**Aim 2 (AI Diagnostic)**:

- Training: 10,000 cases + 100,000 controls → adequate for deep learning (>10K samples/class)
- Validation: 1,000 patients (prospective) → 80% power to detect PPV≥80% (α=0.05)

**Aim 3 (GWAS)**:

- 10,000 WGS: 90% power to detect SNP explaining ≥0.5% variance (α=5×10⁻⁸)
- Replication: 2,000 patients → 80% power to confirm OR≥1.3 (α=0.05)

**Aim 4 (Clinical Trials)**:

- 10 trials × 50-300 patients: Sufficient to demonstrate 75% reduction in recruitment time (paired t-test, α=0.05)

**Aim 5 (Engagement)**:

- 2,500 participants: 90% power to detect 30% improvement in PHQ-9 (SD=5, α=0.05)

---

### Data Quality & Management

**Registry Data Quality**:

- Automated validation (REDCap): Range checks, logic checks, required fields
- Manual review: 5% random sample audited quarterly
- Patient-reported outcomes: Validated instruments (PHQ-9, GAD-7, SF-36)
- Adjudication: Discrepancies reviewed by PI, coordinator

**Biobank Sample Quality**:

- Standard operating procedures (SOPs): Alpha-1 Foundation Biobank SOPs (ISO 9001:2015)
- Sample tracking: Barcodes, chain of custody documented
- Quality metrics: DNA integrity (DIN≥7.0), concentration (≥50 ng/µL)
- Reject criteria: Hemolyzed samples, insufficient volume

**Genomics Data Quality**:

- Pre-sequencing QC: DNA concentration, integrity
- Post-sequencing QC: Mean coverage ≥25×, call rate ≥95%, Ti/Tv ratio 2.0-2.1
- Variant QC: Hardy-Weinberg equilibrium (p>10⁻⁶), minor allele frequency ≥1%

---

### Reproducibility Measures

**Code Sharing**:

- All analysis code (GWAS, AI models) deposited in GitHub (public repository)
- Jupyter notebooks for figures, tables

**Data Sharing**:

- De-identified genomic + phenotypic data → dbGaP (12 months after final data collection)
- Summary statistics → GWAS Catalog (immediate upon publication)

**Protocol Registration**:

- ClinicalTrials.gov: Registry study (NCT########)
- Open Science Framework: Analysis plan pre-registered (prevent p-hacking)

**Blinding**:

- AI model validation: Reviewers blinded to model predictions
- Mental health outcomes: Assessors blinded to engagement status (where feasible)

---

## FUTURE DIRECTIONS

### Years 6-10 (Post-Grant)

**Aim 1 (Registry/Biobank)**:

- Maintain longitudinal follow-up (annual surveys, link to EHR for mortality)
- Add 10,000 patients (total: 35,000)
- Expand biobank to 50,000 samples (for emerging omics technologies)

**Aim 2 (AI Diagnostic)**:

- Scale to 100 health systems (screen 50M patients, identify 29,000+ cases)
- International deployment (Europe, Latin America)
- Adapt algorithm for other rare diseases (cystic fibrosis, sickle cell)

**Aim 3 (Precision Medicine)**:

- Pharmacogenomic trials (validate PRS-guided dosing in RCT)
- Multi-omic studies (integrate proteomics, metabolomics with genomics)
- CRISPR functional validation (top 10 genetic modifiers)

**Aim 4 (Clinical Trials)**:

- Support 20+ trials/year (including Foundation-sponsored trials)
- Real-world evidence studies (post-market surveillance)
- Global trial network (sites in 10 countries)

**Aim 5 (Engagement)**:

- Peer support app (mobile, not just web)
- In-person regional meetups (20 cities/year)
- Virtual reality support groups (Meta Horizon Worlds)

---

### The Cure Initiative (Years 11-15)

**Alpha1Life.com as Foundation for Cure**:

- **Registry** → Identify patients for gene therapy trials
- **Biobank** → Support gene therapy R&D (cell lines, organoids)
- **AI Diagnostic** → Find patients early (before irreversible damage)
- **Precision Medicine** → Predict who will benefit from gene therapy
- **Clinical Trials** → Rapid enrollment in pivotal gene therapy trials

**Goal**: FDA-approved gene therapy by 2030, 10,000 patients treated by 2035

**Mark Egly's Legacy**: From diagnosis to cure in one generation.

---

**END OF RESEARCH STRATEGY**

**Summary**: Five integrated aims building the world's most comprehensive Alpha-1 research platform, enabling discoveries from diagnosis to cure. Years 1-5 establish infrastructure; Years 6-15 deliver impact at scale.

**For Mark. For the 100,000 Americans living with Alpha-1. For the cure.**
