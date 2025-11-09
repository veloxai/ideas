# Feature #12: Clinical Trial Matching & Research Participation

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 backend developer, 1 frontend developer, 1 clinical research coordinator, 0.25 FTE medical director

---

## Executive Summary

AATD is a rare disease with ongoing research into new treatments (gene therapy, RNA interference, oral medications). Many ZZ patients are eligible for clinical trials but never learn about them. Fair Underwriting sits at the intersection of patients and researchers - we have genotype data, medical history, and location information that could match patients to relevant trials. This feature builds a clinical trial matching platform that identifies eligible patients, notifies them of relevant studies, facilitates enrollment, and tracks research participation.

**Key Value Propositions**:

- **Automated Trial Matching**: Match patients to 50+ active AATD trials using ClinicalTrials.gov API
- **Eligibility Pre-Screening**: Check inclusion/exclusion criteria automatically
- **Patient Notifications**: Alert patients when they qualify for trials (gene therapy, new augmentation therapies)
- **Research Registry**: Opt-in registry of AATD patients willing to be contacted for studies
- **Trial Site Finder**: Show nearby trial locations with distance/contact info
- **Participation Tracking**: Track which patients enrolled, outcomes, compensation

**Business Impact**:

- Enable pharma partnerships: $50-250K/trial for patient recruitment fees
- Accelerate AATD research: Connect 200+ patients to trials annually
- Patient value-add: 85% of ZZ patients want trial information
- Competitive differentiation: Only AATD platform with integrated trial matching
- Data partnerships: De-identified registry data for epidemiology research ($100K+/year)

---

## Problem Statement

### Current Gaps

**Scenario 1: ZZ Patient Unaware of Gene Therapy Trial**

> "I'm ZZ with declining FEV1 (62%). I just learned there's a gene therapy trial at University of Florida that could cure AATD. I live in Tampa - 2 hours away. The trial started 6 months ago and is almost full. Why didn't anyone tell me about this?"

**No clinical trial matching** ❌

**Scenario 2: Patient Wastes Time on Ineligible Trial**

> "I spent 2 hours filling out a trial screening form only to be rejected because I'm on augmentation therapy. The exclusion criteria were buried on page 8. I wish I knew upfront if I qualified."

**No automated eligibility checking** ❌

**Scenario 3: Researcher Can't Find ZZ Patients**

> "I'm a principal investigator starting an AATD trial. I need 50 ZZ patients aged 30-60 with FEV1 40-80%. It takes 2 years to recruit from pulmonology clinics. I wish there was a registry of patients interested in research."

**No patient registry for recruitment** ❌

**Scenario 4: MZ Carrier Missing Prevention Trial**

> "I'm MZ and smoke. There's a trial for early intervention (anti-protease therapy for carriers). I'd love to participate but I don't know how to find trials relevant to carriers."

**No trial filtering by genotype** ❌

**Scenario 5: Patient Doesn't Know Trial Benefits**

> "I got invited to a clinical trial but I don't know if it's worth it. What are the risks? Will I get paid? Do I still get my regular treatment?"

**No trial education/transparency** ❌

---

## Feature Specifications

### 1. ClinicalTrials.gov Integration

**Automated Trial Discovery**:

```typescript
interface ClinicalTrial {
  nctId: string; // NCT identifier, e.g., 'NCT04520555'

  // Basic info
  title: string;
  officialTitle: string;
  briefSummary: string;
  detailedDescription: string;

  // Study details
  phase: 'Early Phase 1' | 'Phase 1' | 'Phase 2' | 'Phase 3' | 'Phase 4';
  studyType: 'Interventional' | 'Observational' | 'Expanded Access';
  interventionType:
    | 'Drug'
    | 'Biological'
    | 'Gene Therapy'
    | 'Device'
    | 'Behavioral';

  // Conditions
  conditions: string[]; // ['Alpha-1 Antitrypsin Deficiency', 'COPD', 'Emphysema']

  // Intervention
  interventions: {
    type: string;
    name: string;
    description: string;
  }[];

  // Eligibility
  eligibility: {
    sex: 'All' | 'Male' | 'Female';
    minimumAge: string; // '18 Years'
    maximumAge: string; // '75 Years'
    healthyVolunteers: boolean;

    // Inclusion criteria (free text)
    inclusionCriteria: string[];

    // Exclusion criteria (free text)
    exclusionCriteria: string[];
  };

  // Locations
  locations: {
    facility: string;
    city: string;
    state: string;
    zip: string;
    country: string;
    status: 'Recruiting' | 'Active, not recruiting' | 'Completed' | 'Suspended';
    contactName?: string;
    contactPhone?: string;
    contactEmail?: string;
    latitude?: number;
    longitude?: number;
  }[];

  // Status
  overallStatus:
    | 'Recruiting'
    | 'Active, not recruiting'
    | 'Completed'
    | 'Withdrawn'
    | 'Suspended';
  startDate: Date;
  completionDate: Date;

  // Enrollment
  enrollmentCount: number;
  enrollmentType: 'Actual' | 'Anticipated';

  // Sponsor
  leadSponsor: string; // 'Grifols', 'University of Florida'
  collaborators: string[];

  // Contact
  centralContact?: {
    name: string;
    phone: string;
    email: string;
  };

  // Study design
  primaryPurpose: 'Treatment' | 'Prevention' | 'Diagnostic' | 'Basic Science';
  allocation: 'Randomized' | 'Non-Randomized';
  interventionModel: 'Parallel Assignment' | 'Single Group' | 'Crossover';
  masking: 'None' | 'Single' | 'Double' | 'Triple' | 'Quadruple';

  // Outcomes
  primaryOutcomes: string[];
  secondaryOutcomes: string[];

  // More info
  studyDocuments: {
    type:
      | 'Study Protocol'
      | 'Informed Consent Form'
      | 'Statistical Analysis Plan';
    url: string;
  }[];

  clinicalTrialsGovUrl: string;
}

class ClinicalTrialsService {
  private clinicalTrialsApiUrl = 'https://clinicaltrials.gov/api/query';

  async fetchAAATDTrials(): Promise<ClinicalTrial[]> {
    // Query ClinicalTrials.gov API for AATD studies
    const response = await axios.get(this.clinicalTrialsApiUrl, {
      params: {
        expr: 'Alpha-1 Antitrypsin Deficiency OR AATD',
        fmt: 'json',
        min_rnk: 1,
        max_rnk: 100
      }
    });

    const studies = response.data.StudyFieldsResponse.StudyFields;

    // Parse and normalize trial data
    return studies.map((study) => this.parseTrial(study));
  }

  async syncTrials(): Promise<void> {
    // Run nightly to sync latest trials
    const trials = await this.fetchAAATDTrials();

    for (const trial of trials) {
      // Upsert trial data
      await this.db.query(
        `
        INSERT INTO clinical_trials (
          nct_id, title, phase, status, eligibility, locations
        ) VALUES ($1, $2, $3, $4, $5, $6)
        ON CONFLICT (nct_id) DO UPDATE SET
          title = EXCLUDED.title,
          phase = EXCLUDED.phase,
          status = EXCLUDED.status,
          eligibility = EXCLUDED.eligibility,
          locations = EXCLUDED.locations,
          last_synced_at = NOW()
      `,
        [
          trial.nctId,
          trial.title,
          trial.phase,
          trial.overallStatus,
          JSON.stringify(trial.eligibility),
          JSON.stringify(trial.locations)
        ]
      );

      // Geocode locations for distance calculations
      await this.geocodeTrialLocations(trial);
    }
  }

  async geocodeTrialLocations(trial: ClinicalTrial): Promise<void> {
    for (const location of trial.locations) {
      if (!location.latitude || !location.longitude) {
        // Geocode using Google Maps API
        const geocoded = await this.googleMapsClient.geocode({
          address: `${location.facility}, ${location.city}, ${location.state} ${location.zip}`
        });

        if (geocoded.results.length > 0) {
          location.latitude = geocoded.results[0].geometry.location.lat;
          location.longitude = geocoded.results[0].geometry.location.lng;
        }
      }
    }
  }
}
```

### 2. Intelligent Trial Matching

**AI-Powered Eligibility Screening**:

```typescript
interface PatientProfile {
  userId: string;

  // Demographics
  age: number;
  gender: 'M' | 'F';
  location: {
    city: string;
    state: string;
    zip: string;
    latitude: number;
    longitude: number;
  };

  // AATD-specific
  genotype: 'MM' | 'MZ' | 'ZZ' | 'MS' | 'SZ' | 'SS';
  aatLevel: number; // mg/dL
  diagnosisDate: Date;

  // Clinical
  fev1Percent?: number; // Lung function
  hasLiverDisease: boolean;
  hasCOPD: boolean;
  hasEmphysema: boolean;

  // Medications
  onAugmentationTherapy: boolean;
  augmentationTherapyType?: 'Prolastin' | 'Aralast' | 'Zemaira';
  otherMedications: string[];

  // Lifestyle
  smokingStatus: 'never' | 'former' | 'current';
  packYears?: number;

  // Other
  hasOtherLungDisease: boolean;
  hasActiveCancer: boolean;
  isPregnant: boolean;

  // Preferences
  maxTravelDistance: number; // miles
  willingToTravelForTrial: boolean;
  interestedInTrialTypes: (
    | 'drug'
    | 'gene_therapy'
    | 'device'
    | 'behavioral'
    | 'observational'
  )[];
}

class TrialMatchingEngine {
  async findMatchingTrials(patient: PatientProfile): Promise<TrialMatch[]> {
    // Get all active AATD trials
    const trials = await this.db.query(`
      SELECT * FROM clinical_trials
      WHERE status = 'Recruiting'
      AND (conditions @> '["Alpha-1 Antitrypsin Deficiency"]'::jsonb
           OR conditions @> '["AATD"]'::jsonb)
      ORDER BY start_date DESC
    `);

    const matches: TrialMatch[] = [];

    for (const trial of trials) {
      // Calculate match score
      const matchResult = await this.calculateMatch(patient, trial);

      if (matchResult.matchScore > 50) {
        // Threshold
        matches.push(matchResult);
      }
    }

    // Sort by match score (best matches first)
    return matches.sort((a, b) => b.matchScore - a.matchScore);
  }

  async calculateMatch(
    patient: PatientProfile,
    trial: ClinicalTrial
  ): Promise<TrialMatch> {
    let matchScore = 100; // Start at perfect match
    const reasons: string[] = [];
    const barriers: string[] = [];

    // Age eligibility
    const minAge = parseInt(trial.eligibility.minimumAge);
    const maxAge = parseInt(trial.eligibility.maximumAge);
    if (patient.age < minAge || patient.age > maxAge) {
      matchScore -= 100; // Ineligible
      barriers.push(`Age ${patient.age} outside range ${minAge}-${maxAge}`);
    } else {
      reasons.push('Age eligible');
    }

    // Gender eligibility
    if (
      trial.eligibility.sex !== 'All' &&
      trial.eligibility.sex !== patient.gender
    ) {
      matchScore -= 100; // Ineligible
      barriers.push(`Study requires ${trial.eligibility.sex} participants`);
    }

    // Location - find nearest trial site
    const nearestLocation = this.findNearestLocation(
      patient.location,
      trial.locations
    );
    const distance = nearestLocation.distance;

    if (distance > patient.maxTravelDistance) {
      matchScore -= 30; // Possible barrier
      barriers.push(
        `Nearest site is ${distance} miles away (you indicated ${patient.maxTravelDistance} miles max)`
      );
    } else if (distance < 25) {
      matchScore += 20; // Bonus for nearby
      reasons.push(`Trial site only ${distance} miles away`);
    }

    // Use GPT-4 to parse complex inclusion/exclusion criteria
    const aiEligibility = await this.checkEligibilityWithAI(patient, trial);
    matchScore += aiEligibility.adjustedScore;
    reasons.push(...aiEligibility.reasons);
    barriers.push(...aiEligibility.barriers);

    // Genotype matching
    if (trial.title.toLowerCase().includes('zz') && patient.genotype !== 'ZZ') {
      matchScore -= 50;
      barriers.push('Study requires ZZ genotype');
    }

    // Augmentation therapy
    if (
      trial.eligibility.exclusionCriteria.some(
        (c) =>
          c.toLowerCase().includes('augmentation therapy') ||
          c.toLowerCase().includes('alpha-1 proteinase inhibitor')
      )
    ) {
      if (patient.onAugmentationTherapy) {
        matchScore -= 100; // Excluded
        barriers.push('Study excludes patients on augmentation therapy');
      }
    }

    // Smoking status
    if (
      trial.eligibility.exclusionCriteria.some((c) =>
        c.toLowerCase().includes('current smoker')
      )
    ) {
      if (patient.smokingStatus === 'current') {
        matchScore -= 100;
        barriers.push('Study excludes current smokers');
      }
    }

    // FEV1 criteria
    const fev1Criteria = trial.eligibility.inclusionCriteria.find((c) =>
      c.toLowerCase().includes('fev1')
    );
    if (fev1Criteria && patient.fev1Percent) {
      // Parse "FEV1 between 35% and 70% predicted"
      const fev1Match = fev1Criteria.match(/(\d+).*?(\d+)/);
      if (fev1Match) {
        const minFev1 = parseInt(fev1Match[1]);
        const maxFev1 = parseInt(fev1Match[2]);
        if (patient.fev1Percent < minFev1 || patient.fev1Percent > maxFev1) {
          matchScore -= 80;
          barriers.push(
            `FEV1 ${patient.fev1Percent}% outside required range ${minFev1}-${maxFev1}%`
          );
        } else {
          reasons.push(`FEV1 ${patient.fev1Percent}% meets criteria`);
        }
      }
    }

    // Pregnancy
    if (
      patient.isPregnant &&
      trial.eligibility.exclusionCriteria.some(
        (c) =>
          c.toLowerCase().includes('pregnant') ||
          c.toLowerCase().includes('pregnancy')
      )
    ) {
      matchScore -= 100;
      barriers.push('Study excludes pregnant women');
    }

    // Cancer
    if (
      patient.hasActiveCancer &&
      trial.eligibility.exclusionCriteria.some(
        (c) =>
          c.toLowerCase().includes('cancer') ||
          c.toLowerCase().includes('malignancy')
      )
    ) {
      matchScore -= 100;
      barriers.push('Study excludes patients with active cancer');
    }

    return {
      trialId: trial.nctId,
      trial,
      matchScore: Math.max(matchScore, 0),
      eligibilityStatus:
        matchScore >= 70
          ? 'likely_eligible'
          : matchScore >= 40
            ? 'possibly_eligible'
            : 'likely_ineligible',
      reasons,
      barriers,
      nearestLocation: nearestLocation.location,
      distanceMiles: distance
    };
  }

  async checkEligibilityWithAI(
    patient: PatientProfile,
    trial: ClinicalTrial
  ): Promise<AIEligibilityResult> {
    // Use GPT-4 to interpret complex eligibility criteria
    const prompt = `
Evaluate if this patient is eligible for this clinical trial.

PATIENT:
- Age: ${patient.age}, Gender: ${patient.gender}
- Genotype: ${patient.genotype}, AAT level: ${patient.aatLevel} mg/dL
- FEV1: ${patient.fev1Percent || 'unknown'}%
- COPD: ${patient.hasCOPD ? 'Yes' : 'No'}
- Augmentation therapy: ${patient.onAugmentationTherapy ? 'Yes' : 'No'}
- Smoking: ${patient.smokingStatus}
- Liver disease: ${patient.hasLiverDisease ? 'Yes' : 'No'}

TRIAL INCLUSION CRITERIA:
${trial.eligibility.inclusionCriteria.join('\n')}

TRIAL EXCLUSION CRITERIA:
${trial.eligibility.exclusionCriteria.join('\n')}

Provide:
1. Eligibility score adjustment (-50 to +50)
2. List of reasons why patient qualifies
3. List of barriers/concerns
4. Confidence level (0-100)
    `;

    const response = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [{ role: 'user', content: prompt }],
      temperature: 0.3 // Lower temperature for factual analysis
    });

    return this.parseAIResponse(response.choices[0].message.content);
  }

  findNearestLocation(
    patientLocation: Location,
    trialLocations: TrialLocation[]
  ): NearestLocationResult {
    let nearest = trialLocations[0];
    let minDistance = this.calculateDistance(
      patientLocation.latitude,
      patientLocation.longitude,
      trialLocations[0].latitude,
      trialLocations[0].longitude
    );

    for (const location of trialLocations.slice(1)) {
      const distance = this.calculateDistance(
        patientLocation.latitude,
        patientLocation.longitude,
        location.latitude,
        location.longitude
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = location;
      }
    }

    return { location: nearest, distance: Math.round(minDistance) };
  }

  calculateDistance(
    lat1: number,
    lon1: number,
    lat2: number,
    lon2: number
  ): number {
    // Haversine formula
    const R = 3959; // Earth's radius in miles
    const dLat = this.toRadians(lat2 - lat1);
    const dLon = this.toRadians(lon2 - lon1);

    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.toRadians(lat1)) *
        Math.cos(this.toRadians(lat2)) *
        Math.sin(dLon / 2) *
        Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }
}

interface TrialMatch {
  trialId: string;
  trial: ClinicalTrial;
  matchScore: number; // 0-100
  eligibilityStatus:
    | 'likely_eligible'
    | 'possibly_eligible'
    | 'likely_ineligible';
  reasons: string[]; // Why patient is a good match
  barriers: string[]; // Potential eligibility issues
  nearestLocation: TrialLocation;
  distanceMiles: number;
}

interface AIEligibilityResult {
  adjustedScore: number; // -50 to +50
  reasons: string[];
  barriers: string[];
  confidence: number; // 0-100
}
```

### 3. Patient Research Registry

**Opt-In Registry for Research Recruitment**:

```typescript
interface ResearchRegistryProfile {
  userId: string;

  // Consent
  consentedAt: Date;
  consentVersion: string;
  allowContact: boolean;

  // Research preferences
  interestedInTrialTypes: string[];
  maxTravelDistance: number;
  preferredContactMethod: 'email' | 'phone' | 'portal';
  contactFrequency: 'immediate' | 'weekly_digest' | 'monthly_digest';

  // Clinical data (de-identified for researchers)
  genotype: string;
  ageRange: '18-30' | '31-45' | '46-60' | '61-75' | '76+';
  region: string; // State or region, not exact location

  diagnosisYear: number;
  fev1Range?: '0-30' | '31-50' | '51-70' | '71-100';
  onAugmentationTherapy: boolean;
  comorbidities: string[];

  // Participation history
  previousTrials: {
    nctId: string;
    trialName: string;
    status: 'completed' | 'withdrawn' | 'ongoing';
    startDate: Date;
    endDate?: Date;
  }[];

  // Status
  status: 'active' | 'inactive' | 'withdrawn';
  withdrawnDate?: Date;
  withdrawnReason?: string;
}

class ResearchRegistryService {
  async enrollInRegistry(
    userId: string,
    preferences: RegistryPreferences
  ): Promise<void> {
    // Store consent
    await this.db.insert('research_registry', {
      user_id: userId,
      consented_at: new Date(),
      consent_version: '2025-v1',
      allow_contact: true,
      preferences: preferences,
      status: 'active'
    });

    // Send welcome email
    await this.emailService.send({
      to: user.email,
      subject: 'Welcome to the AATD Research Registry',
      body: this.renderWelcomeEmail(user, preferences)
    });

    // Check for immediate trial matches
    await this.sendInitialTrialMatches(userId);
  }

  async findEligiblePatients(
    trialCriteria: TrialRecruitmentCriteria
  ): Promise<PatientMatch[]> {
    // Researchers can search registry for eligible patients
    const patients = await this.db.query(
      `
      SELECT
        user_id,
        genotype,
        age_range,
        region,
        fev1_range,
        on_augmentation_therapy
      FROM research_registry
      WHERE status = 'active'
      AND allow_contact = true
      AND genotype = ANY($1)
      AND region = ANY($2)
      ${trialCriteria.excludeAugmentationTherapy ? 'AND on_augmentation_therapy = false' : ''}
    `,
      [trialCriteria.genotypes, trialCriteria.regions]
    );

    return patients.map((p) => ({
      userId: p.user_id,
      matchScore: this.calculateRegistryMatchScore(p, trialCriteria)
    }));
  }

  async notifyPatientsOfNewTrial(trialId: string): Promise<void> {
    // When new trial is added, notify matching patients
    const trial = await this.getTrial(trialId);
    const registryPatients = await this.getActiveRegistryPatients();

    for (const patient of registryPatients) {
      const patientProfile = await this.getPatientProfile(patient.userId);
      const match = await this.trialMatchingEngine.calculateMatch(
        patientProfile,
        trial
      );

      if (match.matchScore >= 70) {
        // High match - send notification
        await this.sendTrialNotification(patient, match);
      }
    }
  }
}
```

### 4. Database Schema

```sql
-- Clinical trials (synced from ClinicalTrials.gov)
CREATE TABLE clinical_trials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nct_id VARCHAR(20) UNIQUE NOT NULL, -- NCT number

  -- Basic info
  title TEXT NOT NULL,
  official_title TEXT,
  brief_summary TEXT,
  detailed_description TEXT,

  -- Study details
  phase VARCHAR(20),
  study_type VARCHAR(30),
  intervention_type VARCHAR(50),
  conditions TEXT[],

  -- Eligibility (JSONB for flexibility)
  eligibility JSONB,
  /*
  {
    "sex": "All",
    "minimumAge": "18 Years",
    "maximumAge": "75 Years",
    "inclusionCriteria": ["ZZ genotype", "FEV1 35-70%"],
    "exclusionCriteria": ["Current smoker", "On augmentation therapy"]
  }
  */

  -- Locations (JSONB array)
  locations JSONB,
  /*
  [
    {
      "facility": "University of Florida",
      "city": "Gainesville",
      "state": "FL",
      "status": "Recruiting",
      "latitude": 29.6516,
      "longitude": -82.3248
    }
  ]
  */

  -- Status
  overall_status VARCHAR(50),
  start_date DATE,
  completion_date DATE,

  -- Enrollment
  enrollment_count INTEGER,

  -- Sponsor
  lead_sponsor VARCHAR(300),
  collaborators TEXT[],

  -- Contact
  central_contact JSONB,

  -- Design
  primary_purpose VARCHAR(50),
  allocation VARCHAR(50),
  intervention_model VARCHAR(100),
  masking VARCHAR(50),

  -- URLs
  clinicaltrials_gov_url TEXT,

  -- Sync tracking
  last_synced_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),

  CONSTRAINT valid_nct_id CHECK (nct_id ~ '^NCT\d{8}$')
);

CREATE INDEX idx_clinical_trials_status ON clinical_trials(overall_status) WHERE overall_status = 'Recruiting';
CREATE INDEX idx_clinical_trials_conditions ON clinical_trials USING GIN(conditions);

-- Trial matches (patient -> trial matches)
CREATE TABLE trial_matches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  trial_id UUID NOT NULL,

  -- Match details
  match_score INTEGER NOT NULL, -- 0-100
  eligibility_status VARCHAR(30), -- 'likely_eligible', 'possibly_eligible', 'likely_ineligible'

  -- Reasons (JSONB arrays)
  reasons TEXT[],
  barriers TEXT[],

  -- Location
  nearest_location JSONB,
  distance_miles INTEGER,

  -- Patient engagement
  viewed_at TIMESTAMPTZ,
  interested BOOLEAN,
  interest_marked_at TIMESTAMPTZ,
  contacted_site BOOLEAN DEFAULT false,
  contacted_site_date TIMESTAMPTZ,

  -- Status
  status VARCHAR(30) DEFAULT 'matched',
  -- 'matched', 'viewed', 'interested', 'contacted', 'screened', 'enrolled', 'declined', 'ineligible'

  -- Enrollment tracking
  screened_date DATE,
  enrolled_date DATE,
  withdrawn_date DATE,
  completion_date DATE,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (trial_id) REFERENCES clinical_trials(id),
  UNIQUE (user_id, trial_id)
);

CREATE INDEX idx_trial_matches_user ON trial_matches(user_id, match_score DESC);
CREATE INDEX idx_trial_matches_status ON trial_matches(status, created_at DESC);

-- Research registry
CREATE TABLE research_registry (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID UNIQUE NOT NULL,
  tenant_id UUID NOT NULL,

  -- Consent
  consented_at TIMESTAMPTZ NOT NULL,
  consent_version VARCHAR(20),
  allow_contact BOOLEAN DEFAULT true,

  -- Preferences (JSONB)
  preferences JSONB,
  /*
  {
    "interestedInTrialTypes": ["gene_therapy", "drug"],
    "maxTravelDistance": 100,
    "preferredContactMethod": "email",
    "contactFrequency": "immediate"
  }
  */

  -- Clinical data (de-identified ranges for privacy)
  genotype VARCHAR(10),
  age_range VARCHAR(10), -- '46-60'
  region VARCHAR(50), -- State or region
  diagnosis_year INTEGER,
  fev1_range VARCHAR(10), -- '51-70'
  on_augmentation_therapy BOOLEAN,
  comorbidities TEXT[],

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'inactive', 'withdrawn'
  withdrawn_date TIMESTAMPTZ,
  withdrawn_reason TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_research_registry_status ON research_registry(status) WHERE status = 'active';
CREATE INDEX idx_research_registry_genotype ON research_registry(genotype, status);

-- Trial notifications (sent to patients)
CREATE TABLE trial_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  trial_id UUID NOT NULL,

  -- Notification details
  notification_type VARCHAR(30), -- 'new_match', 'enrollment_reminder', 'trial_update'
  message TEXT,

  -- Delivery
  sent_via_email BOOLEAN DEFAULT false,
  sent_via_sms BOOLEAN DEFAULT false,
  sent_via_push BOOLEAN DEFAULT false,
  sent_at TIMESTAMPTZ,

  -- Engagement
  opened_at TIMESTAMPTZ,
  clicked_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (trial_id) REFERENCES clinical_trials(id)
);

CREATE INDEX idx_trial_notifications_user ON trial_notifications(user_id, sent_at DESC);

-- Trial participation (tracking patient involvement)
CREATE TABLE trial_participation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  trial_id UUID NOT NULL,

  -- Enrollment
  enrollment_date DATE NOT NULL,
  enrollment_status VARCHAR(30) DEFAULT 'active',
  -- 'active', 'completed', 'withdrawn', 'terminated'

  -- Site
  site_name VARCHAR(200),
  site_location VARCHAR(200),
  principal_investigator VARCHAR(200),

  -- Participation details
  study_arm VARCHAR(100), -- 'Treatment', 'Placebo', 'Control'
  visits_scheduled INTEGER,
  visits_completed INTEGER DEFAULT 0,

  -- Compensation
  compensation_amount DECIMAL(10, 2),
  compensation_paid DECIMAL(10, 2) DEFAULT 0.00,

  -- Completion
  completion_date DATE,
  withdrawal_date DATE,
  withdrawal_reason TEXT,

  -- Outcomes (optional, patient-reported)
  patient_reported_outcomes JSONB,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (trial_id) REFERENCES clinical_trials(id)
);

CREATE INDEX idx_trial_participation_user ON trial_participation(user_id);
CREATE INDEX idx_trial_participation_status ON trial_participation(enrollment_status, enrollment_date);
```

### 5. Patient Trial Portal

**Patient View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  🔬 Clinical Trials - John Doe (ZZ, Age 52)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🎯 YOUR TRIAL MATCHES (3 Highly Relevant)                      │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🌟 HIGHLY MATCHED (95/100)                                │  │
│  │                                                            │  │
│  │ Gene Therapy for Alpha-1 Antitrypsin Deficiency           │  │
│  │ NCT04520555 | Phase 2 | University of Florida             │  │
│  │                                                            │  │
│  │ 📍 LOCATION: Gainesville, FL (87 miles from you)          │  │
│  │    Contact: Dr. Sarah Miller | 352-555-1234               │  │
│  │                                                            │  │
│  │ 💉 WHAT IT IS:                                            │  │
│  │ One-time AAV gene therapy to restore AAT production.      │  │
│  │ Potential cure for AATD. 24-month follow-up.              │  │
│  │                                                            │  │
│  │ ✅ WHY YOU'RE A MATCH:                                    │  │
│  │ • Age 52 (requires 30-65)                                 │  │
│  │ • ZZ genotype (required)                                  │  │
│  │ • FEV1 62% (requires 40-80%)                              │  │
│  │ • Not currently on augmentation therapy (required)        │  │
│  │ • Within 100 miles of trial site                          │  │
│  │                                                            │  │
│  │ 📋 WHAT TO EXPECT:                                        │  │
│  │ • Screening visit (blood tests, lung function)            │  │
│  │ • Gene therapy infusion (1 hour)                          │  │
│  │ • 12 follow-up visits over 24 months                      │  │
│  │ • Compensation: $2,400 ($100/visit)                       │  │
│  │                                                            │  │
│  │ ⚠️  IMPORTANT REQUIREMENTS:                               │  │
│  │ • Cannot start augmentation therapy during study          │  │
│  │ • Must use contraception (if applicable)                  │  │
│  │ • Weekly phone check-ins first 3 months                   │  │
│  │                                                            │  │
│  │ [I'm Interested] [Learn More] [Not For Me]               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🟡 GOOD MATCH (78/100)                                    │  │
│  │                                                            │  │
│  │ New Oral Medication for AATD                              │  │
│  │ NCT05123456 | Phase 3 | Boston Medical Center             │  │
│  │                                                            │  │
│  │ 📍 LOCATION: Boston, MA (1,245 miles - Telemedicine OK)   │  │
│  │                                                            │  │
│  │ 💊 WHAT IT IS:                                            │  │
│  │ Daily pill to increase AAT levels. Alternative to IV      │  │
│  │ augmentation therapy. 12-month study.                     │  │
│  │                                                            │  │
│  │ ⚠️  POTENTIAL BARRIERS:                                   │  │
│  │ • Distance to site (1,245 miles), but most visits can     │  │
│  │   be done via telemedicine                                │  │
│  │ • Requires 4 in-person visits (screening, month 3, 6, 12)│  │
│  │                                                            │  │
│  │ [Learn More] [Dismiss]                                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📚 LEARN ABOUT CLINICAL TRIALS                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • What are clinical trials? [Video: 5 min]                │  │
│  │ • What are the phases? (Phase 1, 2, 3, 4)                 │  │
│  │ • What are my rights as a participant?                    │  │
│  │ • Can I leave a trial early? (Yes, always)                │  │
│  │ • Will I get paid? (Usually $50-200 per visit)            │  │
│  │ • What are the risks?                                     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🔔 TRIAL NOTIFICATIONS                                         │
│  Get notified when new trials match your profile                │
│  Frequency: [Immediate ▼] [Update Preferences]                 │
│                                                                  │
│  📝 RESEARCH REGISTRY                                           │
│  You're enrolled in the AATD Research Registry                  │
│  Status: Active | Opted in: Nov 7, 2025                         │
│  [Manage Registry Settings] [Withdraw from Registry]            │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Patient Engagement

- **Registry Enrollment**: 40% of ZZ patients opt into research registry (600+ patients)
- **Trial Awareness**: 85% of eligible patients notified of relevant trials
- **Trial Screening**: 25% of notified patients complete screening
- **Trial Enrollment**: 10% of screened patients enroll (60+ patients/year)

### Researcher Impact

- **Recruitment Time**: 6 months average (vs. 18 months traditional)
- **Recruitment Cost**: $2,000/patient (vs. $8,000 traditional)
- **Pharma Partnerships**: 5 partnerships at $50-250K/trial
- **Registry Queries**: 50+ researcher queries/year

### Business Impact

- **Partnership Revenue**: $200K/year (recruitment fees from 3-4 trials)
- **Data Licensing**: $100K/year (de-identified registry data)
- **Patient Retention**: 15% improvement (engaged patients stay longer)
- **Competitive Advantage**: Only AATD platform with trial matching

### Research Acceleration

- **AATD Trials Accelerated**: 8-12 trials/year reach enrollment faster
- **Patient Diversity**: 30% improvement in geographic diversity of trial participants
- **Trial Completion Rate**: 85% (vs. 70% industry average with better-matched patients)

---

## Budget Estimate

### Development (4-5 months)

- **Backend Developer** (ClinicalTrials.gov API, matching engine): $140K/year × 0.42 years = $58,800
- **Frontend Developer** (patient portal, trial displays): $140K/year × 0.33 years = $46,200
- **Clinical Research Coordinator** (registry design, IRB): $85K/year × 0.33 years = $28,050

**Total Development**: ~$133,050

### Annual Operations

- **Clinical Research Coordinator** (0.5 FTE, registry management): $85K/year × 0.5 = $42,500
- **Medical Director** (0.25 FTE, trial oversight): $200K/year × 0.25 = $50,000
- **Patient Navigator** (0.25 FTE, trial support): $65K/year × 0.25 = $16,250

**Total Operations**: ~$108,750/year

### Annual Infrastructure

- **GPT-4 API** (eligibility screening): $4,800/year
- **Google Maps API** (geocoding, distance): $2,400/year
- **Email/SMS Notifications**: $3,600/year
- **Database & Storage**: $2,400/year

**Total Infrastructure**: ~$13,200/year

### **GRAND TOTAL (First Year)**: ~$255,000

### **Ongoing (Year 2+)**: ~$122,000/year

**Revenue**: $200K/year (trial recruitment fees) + $100K/year (data licensing) = $300K/year
**Net Profit (Year 2+)**: +$178,000/year (revenue-positive!)

---

## Risks & Mitigations

### Risk 1: Low Registry Enrollment

**Impact**: Not enough patients for researchers to find
**Mitigation**: Incentivize enrollment ($25 gift card), emphasize patient empowerment ("help find a cure"), partner with AlphaNet

### Risk 2: Patient Disappointment if Ineligible

**Impact**: Patients excited about trial but screened out
**Mitigation**: Clear upfront eligibility indicators, educational content on why criteria exist, alternative trial suggestions

### Risk 3: Liability if Patient Harmed in Trial

**Impact**: Legal exposure if we recommended trial
**Mitigation**: Clear disclaimers (patients enroll independently), informed consent education, we facilitate connection only (not enrolling)

### Risk 4: Data Privacy (De-Identified Registry)

**Impact**: Risk of re-identification in small patient populations
**Mitigation**: Aggregate data only (age ranges, regions not exact location), IRB approval, HIPAA expert consultation

### Risk 5: ClinicalTrials.gov API Changes

**Impact**: Sync breaks if API changes
**Mitigation**: Monitor API changelog, fallback to web scraping, partner with ClinicalTrials.gov team

---

**Document Owner**: Chief Medical Officer, Director of Research Operations
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
