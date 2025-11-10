# Medical Records Management Portal for AATD Patients

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Technology Officer
**Purpose**: Provide secure, centralized platform for AATD patients to store, organize, and share comprehensive medical records—empowering patients to coordinate care across multiple providers, track disease progression, and maintain control of their health data

---

## 📋 Table of Contents

1. [Portal Overview](#portal-overview)
2. [Why Medical Records Management Matters](#why-medical-records-management-matters)
3. [Portal Features](#portal-features)
4. [Data Integration](#data-integration)
5. [Care Coordination Tools](#care-coordination-tools)
6. [Disease Tracking & Analytics](#disease-tracking--analytics)
7. [Implementation Plan](#implementation-plan)
8. [Success Metrics](#success-metrics)

---

## Portal Overview

### What We Offer

**Mark Egly Foundation Medical Records Portal** is a secure, patient-controlled platform for managing AATD health data:

**Core Features**:

- ✅ **Centralized Records Storage**: Upload and store all medical records (test results, imaging, doctor notes, hospital records—lifetime history in one place)
- ✅ **Automated Data Capture**: Connect to EHR systems (auto-import data from Epic, Cerner, VA, Kaiser—no manual entry)
- ✅ **Organized by Category**: Records sorted by type (lung function tests, liver labs, imaging, medications, hospitalizations)
- ✅ **Disease Tracking Dashboard**: Visualize trends (FEV1 over time, AAT levels, exacerbation frequency—charts, graphs)
- ✅ **Care Team Management**: Directory of all providers (pulmonologist, PCP, hepatologist, genetic counselor—contact info, visit history)
- ✅ **Easy Sharing**: Share records with any provider (secure link, PDF export, fax—HIPAA-compliant)
- ✅ **Mobile App**: Access records on phone (iOS, Android—helpful at doctor visits, ER)
- ✅ **Reminders & Alerts**: Upcoming appointments, medication refills, annual tests (FEV1, liver enzymes)

**Who Can Use**:

- AATD patients (any genotype, any age)
- Caregivers (with patient's permission—manage loved one's records)
- **Free**: No cost (Foundation-funded)

---

### Program Goals

**Year 1** (2026):

- 1,000 patients using portal
- 50,000 documents uploaded (medical records, test results, imaging)
- 5 EHR integrations (Epic, Cerner, VA, Kaiser, AllScripts—auto-import data)

**Year 3** (2028):

- 10,000 patients using portal
- Integration with AATD Centers of Excellence (all major centers auto-sync data to portal)
- Mobile app (iOS, Android—download records on phone)

**Year 5** (2030):

- 25,000 patients using portal (50% of US AATD population)
- AI-powered insights (algorithm analyzes records, identifies trends, predicts exacerbations, flags abnormal results)
- Research integration (patients can donate data to Foundation registry—consent-based, privacy-protected)

---

## Why Medical Records Management Matters

### Fragmented Care & Lost Records

**Problem**: AATD patients see many doctors (pulmonologist, PCP, hepatologist, genetic counselor, transplant team) → records scattered across systems

**Consequences**:

- ❌ **Duplicate tests**: New doctor orders tests already done (patient can't produce records—wastes time, money, radiation exposure from repeat CT scans)
- ❌ **Medication errors**: ER doctor doesn't know patient's medications (patient forgot to bring list—prescribes wrong drug, drug interaction)
- ❌ **Delayed treatment**: Specialist needs records from PCP (takes 2-4 weeks to get—delays diagnosis, treatment decisions)
- ❌ **Poor coordination**: Doctors don't communicate (pulmonologist adjusts inhaler, PCP doesn't know—patient confused about which meds to take)

---

### Current Solutions (Inadequate)

**Patient Portals (Hospital-Specific)**:

- Each hospital has own portal (MyChart for Epic, FollowMyHealth for AllScripts, etc.)
- **Problem**: Patient sees doctors at 3 different hospitals → 3 separate portals, 3 logins, 3 incomplete record sets (no single view)

**Personal Health Records (PHRs)**:

- Microsoft HealthVault (discontinued 2019), Google Health (discontinued 2011), Apple Health (limited—mostly fitness tracking, not comprehensive medical records)
- **Problem**: Low adoption (< 5% of patients use), limited functionality (can't connect to most EHRs, manual data entry only)

**Paper Records**:

- Patient requests paper copies (from each doctor—mails or faxes to new doctor)
- **Problem**: Time-consuming (takes weeks), easy to lose, not searchable (can't find specific test result in 500-page stack)

**Mark Egly Foundation Portal Solves These Problems**:

- ✅ **Single centralized platform** (all records in one place—regardless of which hospital/doctor)
- ✅ **Automated data capture** (connect to EHRs—no manual entry)
- ✅ **AATD-specific** (organized for AATD patients—track FEV1, AAT levels, liver enzymes, treatments)
- ✅ **Easy sharing** (send records to any doctor—secure, HIPAA-compliant)

---

### Patient Stories

**Story 1: Emergency Room Visit**:

- 60-year-old male, ZZ AATD, travels to Florida (vacation)
- Develops exacerbation (fever, increased cough, shortness of breath)
- Goes to local ER (doctor doesn't know patient, never heard of AATD)
- Patient can't remember medications (left list at home), doesn't have recent test results (FEV1, AAT level)
- ER doctor orders tests (repeat CT scan—radiation exposure), prescribes wrong antibiotic (doesn't know patient allergic to penicillin—listed in records, but patient forgot)
- **With Portal**: Patient opens app on phone → shows ER doctor complete record (medication list, allergies, recent FEV1, CT scan from 2 months ago, AATD diagnosis) → doctor makes informed decisions (correct antibiotic, no repeat CT), better care

**Story 2: Specialist Referral**:

- 45-year-old female, ZZ AATD, sees pulmonologist in rural town (not AATD specialist)
- Pulmonologist refers to AATD Center of Excellence (Cleveland Clinic—300 miles away)
- Cleveland Clinic requests records (patient calls rural pulmonologist's office—"We'll fax records, takes 2-4 weeks")
- 3 weeks later: Cleveland Clinic says "We never received fax" → patient calls rural office again → 2 more weeks
- **Total**: 5 weeks to get records (delayed specialist appointment, frustrated patient)
- **With Portal**: Patient logs in → clicks "Share Records" → enters Cleveland Clinic doctor's email → doctor receives secure link (1 minute) → reviews records same day → schedules appointment (next week vs. 5 weeks later)

**Story 3: Tracking Disease Progression**:

- 50-year-old male, ZZ AATD, started augmentation therapy 5 years ago (FEV1 60%)
- Wonders: "Is augmentation therapy working? Is my lung function stable?"
- Has FEV1 tests from past 5 years (scattered—some at PCP, some at pulmonologist, some at hospital)
- Can't easily see trend (would need to gather all results, manually plot on graph)
- **With Portal**: All FEV1 results auto-imported (from EHRs) → dashboard shows graph (FEV1 over time) → clear trend: FEV1 stable (60% → 58% over 5 years—very slow decline) → **Insight**: "Augmentation therapy is working—my decline is minimal"

---

## Portal Features

### 1. Document Storage & Organization

**Upload Records**:

- **Methods**:
  - Manual upload (PDF, JPEG, PNG—scan paper records, photos from phone)
  - Fax-to-portal (patient gives providers fax number—records automatically imported)
  - Email-to-portal (patient forwards records from doctor—auto-uploaded)
  - EHR integration (auto-import from Epic, Cerner, etc.)

**Automatic Categorization** (AI-Powered):

- Portal scans documents (OCR—optical character recognition), identifies type:
  - **Pulmonary Function Tests** (FEV1, DLCO, spirometry reports)
  - **Lab Results** (AAT level, liver enzymes, CBC, CMP)
  - **Imaging** (chest X-ray, CT scan, ultrasound, MRI)
  - **Doctor Notes** (visit summaries, consultation reports)
  - **Medications** (prescriptions, medication lists)
  - **Hospitalizations** (discharge summaries, ER visits)
  - **Procedures** (bronchoscopy, liver biopsy, transplant surgery)
  - **Genetic Testing** (AATD genotype, carrier status)

**Search & Filter**:

- Search by keyword ("FEV1", "augmentation therapy", "Denver hospital")
- Filter by date range (show records from 2023-2025)
- Filter by provider (show only records from Dr. Smith, pulmonologist)
- Filter by category (show only lab results, or only imaging)

**Version Control**:

- Multiple versions of same document (e.g., PFT from Jan 2024, PFT from June 2024—both saved, easily compare)

---

### 2. Disease Tracking Dashboard

**Lung Function Tracking**:

- **FEV1 Graph**: Line chart (FEV1 % predicted over time—visualize decline or stability)
- **DLCO Graph**: Track gas exchange (correlates with emphysema progression)
- **6-Minute Walk Distance**: Track exercise capacity (important for transplant evaluation)

**Lab Tracking**:

- **AAT Level Graph**: Track augmentation therapy effectiveness (should be > 11 μM)
- **Liver Enzymes Graph**: AST, ALT, alkaline phosphatase (monitor liver disease)
- **Inflammatory Markers**: CRP, ESR (elevated during exacerbations)

**Exacerbation Tracking**:

- Log exacerbations (date, symptoms, severity—mild, moderate, severe)
- Track frequency (# of exacerbations per year—goal: reduce over time)
- Identify triggers (smoking, pollution, viral infection—patient notes patterns)

**Medication Adherence**:

- Log augmentation therapy infusions (date, location, brand)
- Track adherence (% of scheduled infusions received—goal: > 90%)
- Missed doses (flag—patient can review why, discuss with doctor)

**Hospitalizations**:

- Log hospital admissions (date, reason, length of stay, complications)
- Track frequency (goal: reduce hospitalizations—sign of better disease control)

---

### 3. Care Team Management

**Provider Directory**:

- List all providers (name, specialty, contact info, address)
- Categories: Pulmonologist, PCP, Hepatologist, Genetic Counselor, Respiratory Therapist, Transplant Team, Pharmacist

**Visit History**:

- Track appointments (date, provider, reason, outcomes—"Adjusted inhaler dose", "Ordered CT scan")
- Upcoming appointments (syncs with calendar—reminders)

**Communication Log**:

- Record phone calls, messages (date, provider, summary—"Called Dr. Smith about shortness of breath, advised to increase oxygen")

---

### 4. Medication Management

**Current Medications**:

- List all meds (name, dose, frequency, prescribing doctor)
- Include: Augmentation therapy, inhalers, oxygen, supplements, over-the-counter meds

**Medication History**:

- Track changes (started augmentation therapy Jan 2020, increased albuterol dose June 2023)
- Discontinued meds (with reason—"Stopped prednisone—side effects")

**Refill Reminders**:

- Alert 7 days before prescription runs out (email, text—"Time to refill albuterol")

**Drug Interactions**:

- Check for interactions (algorithm flags—"Warfarin + NSAIDs = bleeding risk")

---

### 5. Sharing & Portability

**Share with Provider** (Secure Link):

- Patient clicks "Share" → enters doctor's email → doctor receives secure link (expires in 30 days)
- Doctor views records (read-only—can't edit), downloads PDF (full record set or specific documents)

**Export Options**:

- **PDF**: Full record set (all documents compiled into single PDF—500+ pages if long history)
- **Summary PDF**: 2-page summary (demographics, diagnoses, current medications, recent test results—for quick review)
- **CCD (Continuity of Care Document)**: Standard format (XML—can import into any EHR system)

**Fax to Provider**:

- Enter provider's fax number → portal faxes records (HIPAA-compliant)

**Print**:

- Print individual documents (or full record set—bring to appointments)

---

### 6. Mobile App

**Features**:

- View records (on phone—helpful at doctor visits, ER)
- Upload documents (take photo of paper record, upload instantly)
- Medication list (always accessible—show pharmacist, ER doctor)
- Appointment reminders (push notifications)
- Quick share (send records to doctor—tap button, enter email)

**Offline Access**:

- Download key documents (stored on phone—access even without internet)

---

## Data Integration

### EHR Integration (Auto-Import Data)

**Supported EHR Systems** (Year 1—Target 5):

1. **Epic**: 30% of US hospitals (largest EHR vendor)
2. **Cerner**: 25% of US hospitals
3. **VA VistA**: Veterans Affairs system (many AATD patients are veterans)
4. **Kaiser Permanente**: 12 million members (integrated system)
5. **AllScripts**: Community hospitals, private practices

**How It Works**:

- Patient logs into portal → clicks "Connect EHR" → selects health system (e.g., "Cleveland Clinic—Epic")
- Portal redirects to Cleveland Clinic login (patient enters credentials)
- Patient authorizes data sharing (consent—"Allow Mark Egly Foundation Portal to access my records")
- Portal imports data (test results, doctor notes, medications, allergies—everything in EHR)
- **Auto-sync**: Every 24 hours, portal checks for new data (pulls updates automatically—patient doesn't need to do anything)

**Benefits**:

- **No manual entry**: Patient doesn't upload documents 1-by-1 (time-consuming, error-prone)
- **Complete records**: Everything in EHR is in portal (comprehensive)
- **Always up-to-date**: Auto-sync ensures latest data (real-time)

---

### FHIR (Fast Healthcare Interoperability Resources)

**Standard API**:

- FHIR = modern healthcare data standard (like REST API for medical records)
- All major EHRs support FHIR (Epic, Cerner, AllScripts—mandated by federal law—21st Century Cures Act)

**Portal Uses FHIR**:

- Connect to any FHIR-enabled EHR (not just 5 systems above—eventually hundreds of systems)
- Ensures interoperability (data flows seamlessly between systems)

---

### Wearables & Devices

**Integration with Medical Devices** (Year 3+):

- **Pulse Oximeters**: Auto-log oxygen saturation (SpO2—track over time, identify desaturation episodes)
- **Fitness Trackers**: Import step count, exercise data (Fitbit, Apple Watch—track activity level, correlate with symptoms)
- **Home Spirometers**: Auto-upload FEV1 measurements (daily home monitoring—detect decline early)

---

## Care Coordination Tools

### Appointment Scheduler

**Features**:

- Log upcoming appointments (date, time, provider, location, reason)
- Reminders (email, text—7 days before, 1 day before, 1 hour before)
- Sync with calendar (Google Calendar, Outlook—avoid double-booking)

**Pre-Visit Prep**:

- Generate visit summary (recent test results, medication changes, symptoms since last visit—give to doctor at appointment)
- Question list (patient writes questions before visit—ensures doesn't forget to ask)

---

### Care Plan

**Collaborative Care Plan** (Patient + Providers):

- **Goals**: E.g., "Maintain FEV1 > 50%", "Reduce exacerbations to < 2/year", "Exercise 30 min/day"
- **Action Steps**: E.g., "Take inhalers twice daily", "Attend pulmonary rehab 3x/week", "Get flu shot annually"
- **Responsible Party**: E.g., "Patient: take meds", "Pulmonologist: monitor FEV1 quarterly", "PCP: manage comorbidities"
- **Progress Tracking**: Check off completed tasks (visualize adherence)

---

### Secure Messaging

**Message Providers** (Through Portal):

- Send non-urgent questions ("Should I increase oxygen flow?", "Can I travel by plane?")
- Providers respond within 24-48 hours (secure, HIPAA-compliant)

**Message Care Team**:

- Alert multiple providers at once ("Hospitalized for exacerbation—please coordinate discharge plan")

---

## Disease Tracking & Analytics

### Predictive Analytics (Year 5—AI-Powered)

**Algorithm Analyzes Data**:

- FEV1 decline rate (predict when patient will reach FEV1 < 25%—transplant evaluation threshold)
- Exacerbation risk (identify patterns—e.g., "Patient gets exacerbation every winter" → proactive antibiotics)
- Medication adherence (flag missed infusions—alert patient, Navigator)

**Alerts**:

- **Abnormal Results**: "Your AST is elevated—contact hepatologist"
- **Decline Detected**: "Your FEV1 dropped 10% in 6 months—see pulmonologist sooner"
- **Missed Appointments**: "You haven't seen pulmonologist in 12 months—schedule visit"

---

### Benchmarking

**Compare to Other AATD Patients**:

- "Your FEV1 decline rate is 35 mL/year—average for ZZ patients on augmentation is 30 mL/year (slightly faster)"
- "Your exacerbation frequency is 1/year—average for ZZ patients is 2/year (you're doing better)"

**Purpose**: Help patients understand their disease course (are they stable? declining fast? doing well?)

---

### Research Contribution

**Donate Data to Registry** (Optional):

- Patient consents (one-time—"Allow Foundation to use my portal data for research")
- Portal auto-sends data to Foundation registry (de-identified—researchers don't see patient name)
- **Benefit**: Accelerate research (more data = better studies, faster cures)

---

## Implementation Plan

### Phase 1: Platform Development (Months 1-6)

**Technology Stack**:

- **Backend**: FHIR-compliant (HL7 FHIR standard—ensures interoperability)
- **Cloud Hosting**: AWS HIPAA-compliant (secure, scalable)
- **Encryption**: AES-256 (data encrypted at rest, in transit—military-grade security)
- **Authentication**: Multi-factor authentication (MFA—password + code sent to phone)

**Core Features Build**:

- Document upload, storage, categorization
- EHR integration (FHIR API—Epic, Cerner)
- Disease tracking dashboard (FEV1 graph, lab tracking)
- Care team management
- Sharing (secure link, PDF export)

**Cost**: $150K (software development—hire developers, UX designer)

---

### Phase 2: Beta Testing (Months 7-9)

**Recruit 50 Beta Users**:

- AATD patients (diverse—ZZ, SZ, young, old, tech-savvy, tech-averse)
- Test portal (upload records, connect EHRs, use dashboard, share with doctors)
- Gather feedback (usability issues, bugs, feature requests)

**Iterate**:

- Fix bugs (technical issues)
- Improve UX (simplify navigation, clarify instructions)
- Add requested features (e.g., beta users say "I want medication refill reminders"—build it)

---

### Phase 3: Launch (Month 10)

**Public Launch**:

- Announce to Foundation mailing list (10K patients)
- PR campaign (press release, social media, email newsletter)
- Marketing (Facebook ads, patient group posts)

**Onboarding Support**:

- Video tutorials (how to create account, upload records, connect EHR, use dashboard)
- Webinars (live demos—Q&A)
- Help desk (phone, email—patient support)

---

### Phase 4: EHR Expansion (Year 2-3)

**Add 20 More EHR Systems**:

- Partner with regional hospitals (Intermountain, Geisinger, Partners HealthCare)
- Eventually: Connect to 90% of US healthcare systems

---

### Phase 5: Mobile App (Year 3)

**Develop iOS & Android Apps**:

- Full portal functionality (on mobile—view records, upload, share, dashboard)
- Offline access (download key documents—access without internet)

**Cost**: $100K (mobile development)

---

### Phase 6: AI & Advanced Analytics (Year 5)

**Predictive Models**:

- FEV1 decline prediction
- Exacerbation risk algorithm
- Medication adherence tracking

**Cost**: $200K (data science team, algorithm development)

---

## Success Metrics

### Track Quarterly

**Adoption**:

- # of registered users (total, per month)
- # of active users (logged in within past 30 days)
- % of Foundation patients using portal (goal: 50% by Year 5)

**Engagement**:

- # of documents uploaded (per user, total)
- # of EHR connections (per user—how many health systems connected)
- # of shares (how often patients share records with providers)
- Dashboard usage (% of users who view FEV1 graph, lab tracking)

**Impact**:

- Patient-reported outcomes (survey: "Has portal improved your care?" "Do you feel more organized?" "Have you avoided duplicate tests?")
- Provider feedback (survey doctors: "Do patients who use portal come more prepared?" "Are records easier to access?")

**Technical**:

- Uptime (goal: 99.9%—minimal downtime)
- Data security (# of breaches—goal: zero)

---

### Year 1 Targets

**Adoption**:

- 1,000 registered users
- 500 active users (monthly)

**Engagement**:

- 50,000 documents uploaded
- 1,000 EHR connections
- 5,000 shares (records shared with providers)

**Impact**:

- 80% of users report "portal improved my care"
- 90% of users would recommend to other AATD patients

---

## Summary

**Mark Egly Foundation Medical Records Portal**:

- ✅ **Centralized Storage** (all medical records in one place—lifetime history)
- ✅ **Automated Data Capture** (connect to EHRs—auto-import, no manual entry)
- ✅ **Disease Tracking Dashboard** (FEV1 graphs, lab trends, exacerbation tracking)
- ✅ **Easy Sharing** (send records to any provider—secure, HIPAA-compliant)
- ✅ **Mobile App** (access records on phone—helpful at appointments, ER)
- ✅ **Free** (Foundation-funded—no cost to patients)

**This portal will transform AATD care**:

- **Better coordination** (all providers see complete picture—fewer duplicate tests, fewer errors, better decisions)
- **Empowered patients** (own your data, understand your disease, advocate for yourself)
- **Improved outcomes** (track trends, detect decline early, optimize treatment)

**"Your health, your data, your control."**

---

**Ready to Get Organized?**

**Mark Egly Foundation Medical Records Portal**
📞 Phone: 1-800-AATD-DATA
📧 Email: portal@markeglyfoundation.org
🌐 Website: MyAAT DRecords.org

---

**Approved by**: Board of Directors
**Effective Date**: January 1, 2026
**Review Date**: Annually
**Version**: 1.0

---

_"Organized records = better care."_

**— Mark Egly Foundation**
