# Opportunity #10: Clinical Trial Matching Service

Project: Alpha1Life.com Enhancement
Opportunity: Clinical Trial Matching & Recruitment Platform
Owner: Mark Egly Foundation
Created: November 11, 2025
Priority: High (accelerates research, ties into Patient Registry & Genetic DB)

---

## Executive Summary

Clinical trials are the lifeblood of therapeutic progress for rare diseases like Alpha-1 antitrypsin deficiency (AATD). Yet many eligible patients never learn about trials that could help them and advance science. A dedicated Clinical Trial Matching Service for Alpha1Life will 1) centralize trial data, 2) match patients to relevant trials using clinical, genetic and wearable-derived eligibility criteria, 3) streamline consent and referral workflows, and 4) provide sponsors actionable recruitment funnels — dramatically increasing trial enrollment rates and accelerating treatment development.

Problem: Trials fail or are delayed due to insufficient recruitment; rare disease trials are especially vulnerable. Patients lack a single place to discover trials and understand eligibility. Sponsors waste time filtering through unsuitable leads.

Solution: Build a trial-matching platform that pulls authoritative trial metadata (ClinicalTrials.gov, EU CTR, sponsor feeds), normalizes eligibility criteria into computable rules, integrates with the Patient Registry / EHR data / genetic database / wearables signals, and provides a privacy-preserving matchmaking pipeline plus sponsor dashboard and participant-facing enrollment flow.

Impact:

- Increase matched, contactable eligible patients by 3x in Year 1
- Reduce sponsor pre-screening time by 60%
- Add 200+ trial enrollments Year 1 (scalable)
- Strengthen research partnerships and unlock potential sponsor revenue

---

## Business Case

### Investment Required (estimate)

One-Time Development: $140,000 - $220,000

- Trial ingestion & normalization pipeline: $30k-$45k
- Eligibility parsing & computable criteria engine: $35k-$60k
- Patient matching engine + consent flow: $25k-$40k
- EHR/Registry integrations & connectors: $20k-$35k
- Sponsor & internal dashboards (reporting, analytics): $15k-$25k
- Security, HIPAA, QA & testing: $15k-$20k
- Project management & documentation: $10k

Annual Operating: $40,000 - $70,000

- Hosting & infra (APIs, queueing, DB): $12k-$18k
- Data provider fees (ClinicalTrials.gov is free; sponsor feeds may cost): $5k-$15k
- Monitoring & support: $8k-$12k
- Legal & compliance (IRB, contracts): $5k-$10k
- Outreach & CRO coordination (sponsor partnerships): $10k

3-Year Cost: $260k - $430k

### Revenue & Value

Direct Revenue Streams:

- Subscription or connection fees from sponsors/CROs for recruitment analytics/dashboard: $15k - $50k/year per sponsor (pilot agreements possible)
- Premium listing & featured recruitment campaigns: $5k - $15k per campaign
- Sponsored trial funnel management service (end-to-end recruitment service): $25k-$75k per trial (depending on scope)

Indirect / Societal Value:

- Faster trial completion ⇒ faster drug approvals and patient access
- Increased research funding from sponsor partnerships
- Improved patient outcomes through earlier access to novel therapies

ROI: With 3-5 engaged sponsors and a modest per-trial fee, the service can cover operating costs in Year 1/2 and become profitable in Year 2 with ongoing client acquisition.

---

## Market Opportunity

Alpha-1 is a rare disease but globally distributed; there are active clinical programs for augmentation therapy, gene therapy, liver disease, pulmonary symptom management and supportive treatments. Sponsors running Alpha-1 trials include biotech firms, academic consortia, and major pharma. Recruitment for rare disease trials is a known bottleneck that our platform directly addresses.

Key stakeholders:

- Patients & caregivers seeking trials
- Trial sponsors / CROs needing qualified participants
- Investigative sites and academic centers seeking local enrollment
- Regulators & IRBs looking for compliant recruitment workflows
- Researchers using the Patient Registry for feasibility studies

Competitive landscape:

- ClinicalTrials.gov: authoritative registry, but not a patient-friendly matching service
- TrialJunkie, Antidote (trial matching services): broader focus; not Alpha-1 specific
- Disease foundations often run lists but lack computable matching and automation

Alpha1Life's advantage:

- Deep disease-specific data (genotype, AAT levels, PFTs) in the Patient Registry
- Integration with genetic counseling & wearable/remote monitoring (unique biomarkers for eligibility)
- Trust within the Alpha-1 community
- Ability to operate as a HIPAA-compliant recruitment partner for sponsors

---

## Core Features

1. Trial Ingestion & Normalization

- Periodic fetch from authoritative sources:
  - ClinicalTrials.gov API (U.S. and international records)
  - EU Clinical Trials Register (EU CTR)
  - Sponsor-supplied feeds (CSV/JSON/HAPI) and TrialScope/Synapse as partners
- Normalize into canonical trial model: trial_id, title, sponsors, phase, indication, trial sites, eligibility_criteria (free text + structured), enrollment target, status
- Update cadence: every 24 hours with delta checks

2. Computable Eligibility Engine

- Parse free-text eligibility into structured, computable rules (age ranges, lab values, genotypes, FEV1 percent, smoking status, comorbidities)
- Use hybrid approach:
  - Rule-based NLP extraction (regular expressions, heuristics for common patterns)
  - Human-in-the-loop curation for edge cases (sponsor review UI)
  - Optional ML classifier trained on curated eligibility→structured dataset for improved extraction
- Represent eligibility as JSON logic or a small domain-specific language (DSL) that can be evaluated against patient data

Example eligibility JSON:
{
"and": [
{"age": {"gte": 18, "lte": 75}},
{"fev1_pct": {"gte": 30, "lte": 80}},
{"genotype": {"in": ["PI*ZZ"]}},
{"smoker_history": {"max_pack_years": 10}}
]
}

3. Patient Data Connectors

- Patient Registry integration (direct DB or API): demographic data, genotype, AAT level, PFT results, previous trial participation
- EHR connectors (SMART on FHIR + Epic/Cerner) to fetch up-to-date clinical info during consented matches
- Genetic DB queries (de-identified for research/feasibility; identifiable for recruitment when consent is present)
- Wearables & RPM signals for active monitoring-based eligibility (e.g., stable SpO2 profile, recent exacerbation window)

4. Privacy-Preserving Match & Consent Flow

- Two-tiered discovery model:
  - Feasibility matched (de-identified counts per site) for sponsors/researchers
  - Contactable matches (identified patients) only if patient consented to be contacted for trials
- Consent management module with granular opt-ins (research contact, sponsor contact, third-party sharing)
- Smart notifications: match alerts to patients with 1-click "Share my profile with study team" or "Book pre-screening"

5. Patient-Facing Experience

- Trial profile pages with plain-language summaries
- Personalized matches dashboard: why you're eligible (key criteria matched), next steps
- Pre-screen questionnaire (collect more data to confirm eligibility)
- Tele-pre-screen appointment booking (connect with site coordinator)

6. Sponsor & Site Dashboards

- Feasibility analytics: counts of potential matches (de-identified) across geography and genotype strata
- Recruitment funnel: matched → contacted → pre-screened → consented → randomized
- Site referral workflow, messaging tools, bulk outreach via IRB-approved templates
- Exportable CSVs and APIs for site management and EDC integration

7. Workflow Automation & Monitoring

- Automated follow-ups for pending consents
- Schedulers for site feasibility notifications (daily/weekly)
- A/B testing for outreach messaging and CTAs
- Robust logging and audit trail (HIPAA + 21 CFR Part 11 considerations)

8. Integration with Existing Alpha1Life Services

- EHR & Registry: use for eligibility; updates after trial enrollment feed back to clinical history
- Genetic Counseling: help pre-screen carriers and coordinate genetic eligibility
- Wearables & RPM: provide longitudinal monitoring data to support eligibility or safety monitoring

---

## Technical Implementation

### High-Level Architecture

```
                             +------------------+
                             |  ClinicalTrials   |
                             |    Sources        |
                             | (ClinicalTrials)  |
                             +---+---------+-----+
                                 |         |
                     ingest/normalize|         |sponsor feeds
                                 v         v
                     +-----------------------------------+
                     |  Trial Ingestion & Normalization  |
                     +----------------+------------------+
                                      |
                                      v
                     +-----------------------------------+
                     |  Eligibility Parsing & DSL        |
                     +----------------+------------------+
                                      |
                                      v
    +--------------------------+   +----------------+   +----------------+
    | Patient Data Connectors  |-->| Matching Engine |-->| Consent & CRM   |
    | (Registry/EHR/Genomics)  |   | (evaluates DSL) |   | (notifications) |
    +--------------------------+   +----------------+   +----------------+
                                      |
                                      v
                     +-----------------------------------+
                     |  Sponsor / Site Dashboard & APIs  |
                     +-----------------------------------+
```

### Technologies & Stack

- Backend: Node.js (TypeScript) services, Fastify or Nest.js
- Data store: PostgreSQL for canonical trial metadata; ElasticSearch for full-text criteria search; Redis for caching and match queues
- Eligibility evaluation: JSON logic engine in Node.js (json-logic-js) or custom DSL interpreter
- NLP: spaCy (Python) + rule-based extractors; AWS Comprehend Medical optional for clinical entity extraction (cost consideration)
- EHR: SMART on FHIR for real-time data, bulk FHIR exports when available
- Message queue: RabbitMQ or AWS SQS for match processing jobs
- Hosting: AWS (ECS/Fargate) or managed Kubernetes; RDS Postgres
- Security: TLS 1.3, AES-256 encryption at rest, VPC private subnets for DBs
- Monitoring: Prometheus + Grafana; Sentry for exceptions
- Audit/Compliance: Immutable audit tables, exportable logs, IRB-ready data handling

---

### Trial Ingestion & Normalization

1. ClinicalTrials.gov ingestion

- Use ClinicalTrials.gov API / AACT dataset (bulk download daily) for U.S. trials
- Parse XML/JSON fields: nct_id, brief_title, official_title, conditions, interventions, enrollment, study_type, phases, eligibility
- Extract sites & contacts (investigator name, phone, email, location)

2. Sponsor feeds

- Build small adapter layer that accepts CSV/JSON via SFTP or API webhooks
- Validate feed schemas, reconcile duplicates with canonical nct_id where possible

3. Normalization rules

- Conditions normalization via UMLS / SNOMED mapping (map 'alpha-1 antitrypsin deficiency' to canonical code)
- Intervention mapping to standard ontologies (RxNorm when drug-based)

4. Eligibility parsing

- Tokenize the eligibility free-text into inclusion/exclusion sections
- Apply regular expressions for common patterns:
  - Age: "Ages 18-75" → {age: {gte:18, lte:75}}
  - FEV1: "FEV1 30-80% predicted" → {fev1_pct: {gte:30, lte:80}}
  - Genotype: "PI ZZ" or "homozygous Z" → {genotype: {in:["PI*ZZ"]}}
- For ambiguous statements, flag for human curation in the trial editor

5. Curation UI for trial managers

- Allow staff to view parsed criteria, adjust threshold values, and approve computable representation
- All changes tracked with audit logs

---

### Matching Engine

1. Pre-screening counts (feasibility)

- Evaluate eligible counts per trial without revealing PHI: run the DSL against de-identified patient profiles (e.g., age bucket, genotype bucket, PFT bucket)
- Provide geo-aggregates per site (e.g., 125 eligible within 100 miles)

2. Identifiable matches

- For patients who consent to trial contact, run the same DSL against identifiable records and produce match lists for site coordinators
- Include match rationale: which criteria matched and missing pieces

3. Match prioritization & scoring

- Score candidate matches by closeness to ideal criteria:
  - Exact genotype match: +30
  - PFT within range: +20
  - No smoking history: +15
  - Recent exacerbation in last 3 months (for trials excluding recent exacerbation): -50
- Site-specific preferences (e.g., travel reimbursement, telehealth-friendly) can add/subtract

4. Batch & streaming matching

- Support both: scheduled nightly batch matches and real-time streaming matches as new patient data arrives (EHR refresh or wearable events)

5. Throttling & rate limits

- Respect sponsor site capacities (per-site enrollment caps)
- Rate-limit outbound contact requests to patients (avoid spam)

---

### Consent & Privacy Model

1. Granular consent settings

- Users can opt-in to: contact by research, share de-identified data for feasibility, share contact for sponsor outreach, share data for safety monitoring
- Consent stored in immutable ledger (timestamped, versioned)

2. Re-identification flow

- Sponsors request identified matches through site PI only; platform can push site-specific match list after verifying IRB/DUA
- For commercial sponsors, require signed DUA/contract and IRB approval references

3. Audit & traceability

- Every data access for trial recruitment is logged: who, why, what data fields
- Emails and outreach templates stored with version

---

## Database Schema (summary)

```sql
-- trials
CREATE TABLE trials (
  id SERIAL PRIMARY KEY,
  nct_id VARCHAR(50) UNIQUE,
  title TEXT,
  brief_summary TEXT,
  official_title TEXT,
  phase VARCHAR(50),
  status VARCHAR(50),
  enrollment INTEGER,
  conditions TEXT[],
  interventions TEXT[],
  raw_eligibility TEXT,
  eligibility_json JSONB,
  sites JSONB,
  sponsors JSONB,
  last_synced TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- trial_feasibility_cache (de-identified counts)
CREATE TABLE trial_feasibility (
  id SERIAL PRIMARY KEY,
  trial_id INTEGER REFERENCES trials(id),
  region VARCHAR(100), -- e.g., state or zipcode bucket
  eligible_count INTEGER,
  last_checked TIMESTAMP
);

-- trial_matches
CREATE TABLE trial_matches (
  id SERIAL PRIMARY KEY,
  trial_id INTEGER REFERENCES trials(id),
  patient_user_id INTEGER REFERENCES wp_users(ID),
  match_score INTEGER,
  matched_on TIMESTAMP DEFAULT NOW(),
  rationale JSONB, -- which criteria matched
  status VARCHAR(20), -- "matched", "contacted", "pre-screened", "excluded"
  created_at TIMESTAMP DEFAULT NOW()
);

-- trial_requests (sponsor side requests)
CREATE TABLE trial_requests (
  id SERIAL PRIMARY KEY,
  sponsor_id INTEGER,
  trial_id INTEGER REFERENCES trials(id),
  request_type VARCHAR(50), -- "feasibility", "identified_matches"
  status VARCHAR(20), -- "pending", "approved", "rejected"
  created_at TIMESTAMP DEFAULT NOW(),
  reviewed_by INTEGER REFERENCES wp_users(ID)
);
```

---

## APIs & Sample Code

### 1) Fetch Trials (Ingestion)

Node.js (example using axios):

```javascript
const axios = require('axios');

async function fetchClinicalTrials(query) {
  // ClinicalTrials.gov REST API (example)
  const url = `https://clinicaltrials.gov/api/query/full_studies?expr=${encodeURIComponent(query)}&min_rnk=1&max_rnk=100&fmt=json`;
  const res = await axios.get(url);
  const studies = res.data.FullStudiesResponse.FullStudies || [];
  // Map to canonical model
  return studies.map((s) => ({
    nct_id: s.Study.ProtocolSection.IdentificationModule.NCTId,
    title: s.Study.ProtocolSection.IdentificationModule.BriefTitle,
    eligibility: s.Study.ProtocolSection.EligibilityModule,
    contacts: s.Study.ProtocolSection.ContactsLocationsModule,
    raw: s
  }));
}
```

### 2) Evaluate Eligibility DSL Against Patient Object (Node)

```javascript
const jsonLogic = require('json-logic-js');

// Example patient object (partial)
const patient = {
  age: 52,
  genotype: 'PI*ZZ',
  fev1_pct: 58,
  smoking_pack_years: 0
};

const eligibility = {
  and: [
    { '<=': [{ var: 'age' }, 75] },
    { '>=': [{ var: 'age' }, 18] },
    { in: [{ var: 'genotype' }, ['PI*ZZ']] },
    { '>=': [{ var: 'fev1_pct' }, 30] }
  ]
};

const match = jsonLogic.apply(eligibility, patient);
console.log('Matched?', match);
```

### 3) Sponsor Feasibility API (example)

Request: POST /api/v1/feasibility
Body: { "trial_id": "NCT01234567", "region": {"zip": "02139", "radius_miles": 100} }

Response:

```json
{
  "trial_id": "NCT01234567",
  "region": { "zip": "02139", "radius": 100 },
  "estimated_eligible_count": 124,
  "breakdown": [
    { "genotype": "PI*ZZ", "count": 34 },
    { "genotype": "PI*MZ", "count": 45 },
    { "age_18_30": 12, "age_31_50": 48, "age_51_75": 64 }
  ]
}
```

---

## Development Phases & Timeline

Total estimated timeline: 28-36 weeks (7-9 months)

Phase 0: Preparation (2 weeks)

- Stakeholder interviews (sponsors, sites), finalize success metrics
- IRB/legal review of recruitment pathways

Phase 1: Trial Ingestion & Basic Matching (8 weeks)

- Implement ClinicalTrials.gov ingestion
- Normalize basic trial metadata
- Build trial editor UI and curation workflow
- Simple rule-based eligibility extraction for common patterns

Phase 2: Patient Data Connectors (6 weeks)

- Integrate with Patient Registry
- Build de-identified feasibility queries & caching
- Consent flow for contactable matches

Phase 3: Eligibility Engine & Matching (6 weeks)

- Implement JSON logic DSL & evaluation engine
- Scoring, site preference, and prioritized match lists
- Sponsor feasibility endpoints & dashboards

Phase 4: Sponsor Integration & Workflow (4 weeks)

- Sponsor dashboard, request workflows, DUA/contract checks
- Email templates, pre-screening automation

Phase 5: EHR SMART on FHIR integration & advanced features (6-8 weeks)

- SMART on FHIR flows for real-time data pulls
- Wearable data integration for eligibility signals
- ML-based eligibility extraction improvements

Phase 6: Pilot & Iteration (4 weeks)

- Pilot with 2-3 investigators / sponsors
- Iterate based on sponsor feedback & metrics
- Prepare go-to-market materials

---

## Budget Breakdown (detailed)

| Component                         | Dev hrs | Rate   | Cost         |
| --------------------------------- | ------- | ------ | ------------ |
| Trial ingestion & normalization   | 320     | $100   | $32,000      |
| Eligibility parsing & DSL         | 420     | $100   | $42,000      |
| Matching engine & scoring         | 280     | $100   | $28,000      |
| Patient connectors (Registry/EHR) | 240     | $100   | $24,000      |
| Sponsor dashboard                 | 160     | $100   | $16,000      |
| Security & compliance             | 120     | $100   | $12,000      |
| QA & testing                      | 160     | $85    | $13,600      |
| PM & Documentation                | 120     | $85    | $10,200      |
| Contingency (15%)                 | -       | -      | $23,820      |
| **Total**                         | **--**  | **--** | **$221,620** |

Operational (Annual):

- Hosting & infra: $18,000
- Support & monitoring: $12,000
- Legal/IRB & DUAs: $7,000
- Data provider costs: $8,000
- Outreach & CRO coordination: $5,000
- **Total/year**: $50,000

---

## KPIs & Success Metrics

Primary KPIs (Year 1):

- Trials ingested & normalized: 100% of active Alpha-1 relevant trials in major registries
- Feasibility queries run: 200
- Identified, consented matches: 600
- Enrollments through platform: 200
- Sponsor partners: 3-6
- Time to first recruit per trial: reduced by 40%

Secondary KPIs:

- Patient opt-in rate for trial contact: 25-40%
- Conversion from match→pre-screened→enrolled: 35%
- Average match score of enrolled patients: 78/100
- Sponsor satisfaction (NPS): +40

Monitoring & dashboards:

- Real-time funnel metrics per trial
- Geographic heatmaps for eligible patients
- Match pipeline latency & throughput

---

## Risks & Mitigation

1. Eligibility Parsing Errors (false positives/negatives)

- Mitigation: conservative initial parsing rules, human-in-loop curation, confidence scoring, monitoring false match rate

2. Privacy / IRB / Legal constraints

- Mitigation: robust consent model, legal review, DUAs for sponsors, platform logs and audit trail, opt-in only for identified matching

3. Sponsor engagement slow

- Mitigation: pilot program with 1-2 lead sponsors offering free feasibility reports; showcase success stories and time-to-enroll improvements

4. Data freshness & quality issues

- Mitigation: caching policy, daily refresh, duplicate detection, manual curation for high-impact trials

5. Patient fatigue / outreach overload

- Mitigation: rate limit outreach, personalized messaging, opt-out, allow patients to schedule follow-ups rather than repeated unsolicited contact

6. Resource constraints for site visits (travel/logistics)

- Mitigation: prioritize trials with telehealth pre-screening and remote participation options; flag travel reimbursement in match UI

---

## Go-to-Market & Partnerships

Target launch partners (pilot sponsors):

- Academic centers running Alpha-1 studies (e.g., select university hospitals)
- Biotech sponsors with upcoming Phase 2 gene therapy or augmentation trials
- CROs doing recruitment for rare disease trials

Pilot outreach plan:

- Reach out to 5 prospective sponsors with capability statement and pilot offer (free feasibility + 100 contactable matches)
- Run 2 pilot trials (1 academic, 1 industry) to demonstrate efficiency gains
- Collect case studies and metrics for PR

Marketing & community outreach:

- Patient webinars explaining the platform and consent process
- Feature in Alpha1Life newsletter and social channels
- Co-branded outreach with sponsors (IRB-approved templates)

Commercial model:

- Subscription for sponsor dashboard (monthly)
- Per-trial recruitment management fee (flat or tiered)
- Premium services (end-to-end recruitment, prescreening calls) as concierge add-ons

---

## Operational Plan & Roles

Team (initial):

- Product Manager (0.2 FTE during dev, then 0.1 FTE)
- Backend Engineer (1.0 FTE for 6 months)
- NLP Engineer (0.5 FTE for parsing engine)
- Frontend Engineer (0.6 FTE for dashboards)
- QA/Tester (0.3 FTE)
- Clinical Liaison / Trial Manager (0.5 FTE) — manages sponsor relationships and IRB coordination
- Legal & Compliance advisor (on-call)

Operational tasks:

- Weekly sponsor check-ins
- Monthly feasibility report generation
- Quarterly reviews with advisory board

---

## Pilot Metrics & Success Criteria (90-day pilot)

A successful pilot (90 days) will meet at least 2 of the following:

- Deliver 100 de-identified feasibility counts across 3 sponsors
- Obtain 100 patients who consent to be contacted for trials
- Convert 20 consented patients into pre-screenings
- Secure 1 paid sponsor contract

If pilot meets or exceeds these, proceed to broader rollout.

---

## Implementation Examples & Code Snippets

### Eligibility extraction rule examples (Regex)

- Age: /Ages?\s*(\d{1,2})\s*-\s\*(\d{1,2})/i
- FEV1: /(FEV1[^\d]_)(\d{1,3})\s_%/i
- Genotype: /PI\s*\*?\s*([A-Z]{1,3})/i

### Simple Python snippet for regex extraction

```python
import re

elig_text = "Inclusion: Ages 18-75. FEV1 30-80% predicted. Genotype: PI*ZZ."
age_match = re.search(r"Ages?\s*(\d{1,2})\s*-\s*(\d{1,2})", elig_text)
if age_match:
    age_min, age_max = int(age_match.group(1)), int(age_match.group(2))

fev1_match = re.search(r"FEV1[^\d]*(\d{1,3})\s*%", elig_text)
if fev1_match:
    fev1 = int(fev1_match.group(1))

geno_match = re.search(r"PI\s*\*?\s*([A-Z]{1,3})", elig_text)
if geno_match:
    genotype = f"PI*{geno_match.group(1)}"
```

---

## Next Steps

Phase 0 (2 weeks):

- Finalize success metrics and pilot sponsors
- IRB/legal check on recruitment workflow and consent language
- Data sharing templates and DUA draft

Phase 1 (8 weeks):

- Implement ingestion & normalization
- Build trial editor and human curation workflow
- Integrate Patient Registry for de-identified feasibility

Phase 2 (6-8 weeks):

- Implement identified matches & consented workflows
- Sponsor dashboard and request flows
- Pilot with 2-3 studies

Deliverables:

- Working ingestion pipeline
- Feasibility dashboard and CSV export
- Pilot case study and metrics report

---

## Why This Matters

Clinical trials are the fastest path to new therapies for Alpha-1. By offering a dedicated, disease-specific matching service that leverages the unique datasets Alpha1Life owns (genetics, registry PFTs, wearables), the foundation enables more trials to be completed on time, helps patients access novel therapies, and strengthens ties with the research community—unlocking both scientific and financial returns.

---

Document Owner: VLX (GitHub Copilot)
Last Updated: November 11, 2025
Status: Ready for Board Review / Feedback
