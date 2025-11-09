# Feature #21A-2: Patient Registry System

**Part of Feature #21: Research Participation Platform (Core Infrastructure)**

---

## Overview

The Patient Registry System is the foundational data repository for all research activities within Fair Underwriting. Unlike traditional disease registries that collect static enrollment snapshots, this registry implements **continuous, multi-source data collection** with automatic updates from EHR, genetic tests, insurance claims, patient-reported outcomes, and wearables. The registry serves as the **single source of truth** for AATD patient data, enabling rapid cohort identification, longitudinal analyses, and real-world evidence generation.

---

## Registry Data Model

### Core Entities

```typescript
interface RegistryParticipant {
  // Identity
  participantId: string; // UUID
  userId: string; // Link to Fair Underwriting user account
  enrollmentDate: Date;
  enrollmentSource:
    | 'self_enrollment'
    | 'provider_referral'
    | 'study_recruitment';

  // Demographics
  demographics: {
    dateOfBirth: Date;
    ageAtEnrollment: number;
    sex: 'male' | 'female' | 'other' | 'prefer_not_to_say';
    race: string[]; // Multiple selections allowed
    ethnicity: 'hispanic_latino' | 'not_hispanic_latino' | 'unknown';
    countryOfBirth: string; // ISO 3166-1 alpha-3
    primaryLanguage: string; // ISO 639-1
  };

  // AATD-Specific Data
  aatdData: {
    // Genetic
    phenotype: 'ZZ' | 'SZ' | 'MZ' | 'MS' | 'SS' | 'ZNull' | 'other' | 'unknown';
    allele1: string; // e.g., 'Pi*Z', 'Pi*S', 'Pi*M'
    allele2: string;
    geneticTestDate: Date;
    geneticTestLab: string;
    geneticTestMethod: 'genotyping' | 'sequencing' | 'isoelectric_focusing';

    // Serum AAT Level
    aatLevels: {
      date: Date;
      value: number; // mg/dL
      lab: string;
      method: 'nephelometry' | 'immunoassay';
    }[];

    // Diagnosis
    diagnosisDate: Date;
    diagnosisAge: number;
    diagnosticDelay: number; // Years from symptom onset to diagnosis
    howDiagnosed:
      | 'family_screening'
      | 'copd_workup'
      | 'liver_disease'
      | 'routine_testing'
      | 'newborn_screening'
      | 'other';
  };

  // Clinical Status
  clinicalStatus: {
    // Lung Disease
    lungDisease: {
      present: boolean;
      copdStage: 'gold_0' | 'gold_1' | 'gold_2' | 'gold_3' | 'gold_4' | 'none';
      emphysemaType: 'panacinar' | 'centrilobular' | 'mixed' | 'none';

      // Spirometry (most recent)
      lastSpirometry: {
        date: Date;
        fev1_ml: number;
        fev1_percent: number; // % predicted
        fvc_ml: number;
        fvc_percent: number;
        fev1_fvc_ratio: number;
      };

      // Exacerbations (past 12 months)
      exacerbationsPerYear: number;
      hospitalizationsPerYear: number;

      // Oxygen Use
      oxygenTherapy: boolean;
      oxygenStartDate?: Date;
    };

    // Liver Disease
    liverDisease: {
      present: boolean;
      type: 'cirrhosis' | 'hepatitis' | 'fibrosis' | 'steatosis' | 'none';
      childPughScore?: number; // 5-15 (if cirrhosis)

      // Liver Enzymes (most recent)
      lastLiverPanel: {
        date: Date;
        alt: number; // U/L
        ast: number;
        alkPhos: number;
        bilirubin: number; // mg/dL
      };

      // Complications
      portalHypertension: boolean;
      varices: boolean;
      ascites: boolean;
    };

    // Other Manifestations
    otherManifestations: {
      panniculitis: boolean;
      vasculitis: boolean;
      bronchiectasis: boolean;
    };
  };

  // Treatment History
  treatments: {
    // Augmentation Therapy
    augmentationTherapy: {
      currentlyOn: boolean;
      startDate?: Date;
      endDate?: Date;
      brand: 'prolastin' | 'aralast' | 'glassia' | 'zemaira' | 'other';
      route: 'iv' | 'subcutaneous';
      frequency: 'weekly' | 'biweekly' | 'other';
      infusionLocation:
        | 'home'
        | 'infusion_center'
        | 'hospital'
        | 'physician_office';

      // Side Effects
      sideEffects: string[];
      tolerability: 'excellent' | 'good' | 'fair' | 'poor';
    };

    // COPD Medications
    copdMedications: {
      name: string;
      class:
        | 'laba'
        | 'lama'
        | 'ics'
        | 'laba_lama'
        | 'laba_ics'
        | 'triple'
        | 'other';
      startDate: Date;
      endDate?: Date;
      adherence?: number; // 0-100%
    }[];

    // Transplant
    transplant: {
      received: boolean;
      type?: 'lung' | 'liver' | 'lung_liver';
      date?: Date;
      institution?: string;
    };
  };

  // Lifestyle Factors
  lifestyle: {
    smokingStatus: 'never' | 'former' | 'current';
    packYears?: number;
    smokingQuitDate?: Date;

    alcoholUse: 'none' | 'occasional' | 'moderate' | 'heavy';

    occupationalExposures: {
      type: 'dust' | 'chemicals' | 'fumes' | 'asbestos' | 'other';
      duration: number; // Years
      ended: boolean;
    }[];

    residentialHistory: {
      zipCode: string;
      startDate: Date;
      endDate?: Date;
      airQualityIndex?: number;
    }[];
  };

  // Research Participation
  researchStatus: {
    registryEnrollmentDate: Date;
    activeStudies: string[]; // Study IDs
    completedStudies: string[];

    // Data Contributions
    dataCompleteness: number; // 0-100%
    lastDataUpdate: Date;

    // Engagement
    surveysCompleted: number;
    surveysDeclined: number;
    lastSurveyDate: Date;
    retentionRisk: 'low' | 'medium' | 'high'; // Predicted dropout risk
  };

  // Consent (references consent management system)
  consentStatus: {
    registryConsent: boolean;
    registryConsentDate: Date;
    dataSharing: {
      geneticData: boolean;
      clinicalData: boolean;
      biosampleUse: boolean;
      recontact: boolean;
    };
  };

  // Data Provenance
  dataProvenance: {
    lastEhrSync: Date;
    lastClaimsSync: Date;
    lastWearableSync: Date;
    lastPatientUpdate: Date;
  };

  created_at: Date;
  updated_at: Date;
}
```

### Database Schema

```sql
-- Main registry participants table
CREATE TABLE registry_participants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID UNIQUE NOT NULL,

  -- Enrollment
  enrollment_date DATE NOT NULL,
  enrollment_source VARCHAR(50),

  -- Demographics (JSONB for flexibility)
  demographics JSONB NOT NULL,
  /*
  {
    "dateOfBirth": "1975-03-15",
    "sex": "male",
    "race": ["white", "asian"],
    "ethnicity": "not_hispanic_latino",
    "countryOfBirth": "USA",
    "primaryLanguage": "en"
  }
  */

  -- AATD data
  phenotype VARCHAR(20),
  allele1 VARCHAR(50),
  allele2 VARCHAR(50),
  genetic_test_date DATE,
  diagnosis_date DATE,

  -- Clinical status (JSONB for complex nested data)
  clinical_status JSONB,
  /*
  {
    "lungDisease": {
      "present": true,
      "copdStage": "gold_2",
      "lastSpirometry": {
        "date": "2024-10-15",
        "fev1_ml": 2100,
        "fev1_percent": 62
      }
    },
    "liverDisease": {
      "present": false
    }
  }
  */

  -- Treatment (JSONB)
  treatments JSONB,

  -- Lifestyle (JSONB)
  lifestyle JSONB,

  -- Research participation
  registry_enrollment_date DATE NOT NULL,
  active_studies TEXT[],
  data_completeness NUMERIC(3,1), -- 0.0-100.0
  retention_risk VARCHAR(20),

  -- Consent
  registry_consent BOOLEAN DEFAULT false,
  registry_consent_date DATE,
  data_sharing_preferences JSONB,

  -- Provenance
  last_ehr_sync TIMESTAMPTZ,
  last_claims_sync TIMESTAMPTZ,
  last_wearable_sync TIMESTAMPTZ,
  last_patient_update TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_registry_participants_user ON registry_participants(user_id);
CREATE INDEX idx_registry_participants_phenotype ON registry_participants(phenotype);
CREATE INDEX idx_registry_participants_enrollment ON registry_participants(enrollment_date);
CREATE INDEX idx_registry_participants_completeness ON registry_participants(data_completeness);

-- GIN index for JSONB queries
CREATE INDEX idx_registry_participants_clinical ON registry_participants USING GIN(clinical_status);
CREATE INDEX idx_registry_participants_treatments ON registry_participants USING GIN(treatments);

-- Longitudinal spirometry data (time-series)
CREATE TABLE registry_spirometry (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,

  test_date DATE NOT NULL,

  -- Pre-bronchodilator
  pre_fev1_ml INTEGER,
  pre_fev1_percent NUMERIC(4,1),
  pre_fvc_ml INTEGER,
  pre_fvc_percent NUMERIC(4,1),
  pre_fev1_fvc_ratio NUMERIC(3,2),

  -- Post-bronchodilator
  post_fev1_ml INTEGER,
  post_fev1_percent NUMERIC(4,1),
  post_fvc_ml INTEGER,
  post_fvc_percent NUMERIC(4,1),
  post_fev1_fvc_ratio NUMERIC(3,2),

  -- Quality metrics
  quality_grade VARCHAR(1), -- A, B, C, D, F
  reproducibility_met BOOLEAN,

  -- Context
  test_location VARCHAR(50), -- 'clinic', 'hospital', 'home'
  technician_id UUID,

  -- Data source
  source VARCHAR(30), -- 'ehr', 'manual_entry', 'home_spirometer', 'study'
  source_record_id VARCHAR(100),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id) ON DELETE CASCADE
);

CREATE INDEX idx_registry_spirometry_participant ON registry_spirometry(participant_id, test_date DESC);
CREATE INDEX idx_registry_spirometry_date ON registry_spirometry(test_date);

-- Longitudinal AAT level data
CREATE TABLE registry_aat_levels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,

  test_date DATE NOT NULL,
  aat_level NUMERIC(5,1), -- mg/dL

  lab_name VARCHAR(200),
  lab_clia VARCHAR(20),
  test_method VARCHAR(50),

  -- Context (on augmentation therapy at time of test?)
  on_augmentation BOOLEAN,
  days_since_infusion INTEGER,

  -- Data source
  source VARCHAR(30),
  source_record_id VARCHAR(100),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id) ON DELETE CASCADE
);

CREATE INDEX idx_registry_aat_levels_participant ON registry_aat_levels(participant_id, test_date DESC);

-- Exacerbation events
CREATE TABLE registry_exacerbations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,

  event_date DATE NOT NULL,

  -- Severity
  severity VARCHAR(20), -- 'mild', 'moderate', 'severe', 'very_severe'
  hospitalized BOOLEAN,
  icu_admission BOOLEAN,
  intubation BOOLEAN,

  -- Treatment
  treatment JSONB,
  /*
  {
    "antibiotics": true,
    "steroids": true,
    "dose": "prednisone 40mg x 5 days",
    "bronchodilator_increase": true
  }
  */

  -- Recovery
  recovery_date DATE,
  recovery_days INTEGER,

  -- Triggers
  triggers TEXT[], -- ['uri', 'pollution', 'allergen', 'unknown']

  -- Data source
  source VARCHAR(30),
  source_record_id VARCHAR(100),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id) ON DELETE CASCADE
);

CREATE INDEX idx_registry_exacerbations_participant ON registry_exacerbations(participant_id, event_date DESC);
CREATE INDEX idx_registry_exacerbations_date ON registry_exacerbations(event_date);

-- Hospitalizations
CREATE TABLE registry_hospitalizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,

  admission_date DATE NOT NULL,
  discharge_date DATE,
  length_of_stay INTEGER, -- Days

  -- Admission details
  admission_type VARCHAR(30), -- 'emergency', 'elective', 'observation'
  admission_source VARCHAR(30), -- 'emergency_room', 'transfer', 'outpatient'

  -- Diagnosis
  primary_diagnosis_code VARCHAR(20), -- ICD-10
  primary_diagnosis_description TEXT,
  secondary_diagnoses JSONB,

  -- AATD-related?
  aatd_related BOOLEAN,
  exacerbation_id UUID, -- Link to exacerbation if applicable

  -- Outcomes
  discharge_disposition VARCHAR(50), -- 'home', 'snf', 'rehab', 'died', 'ama'
  readmission_30day BOOLEAN,

  -- Facility
  facility_name VARCHAR(200),
  facility_npi VARCHAR(10),

  -- Data source
  source VARCHAR(30),
  source_record_id VARCHAR(100),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id) ON DELETE CASCADE,
  FOREIGN KEY (exacerbation_id) REFERENCES registry_exacerbations(id)
);

CREATE INDEX idx_registry_hospitalizations_participant ON registry_hospitalizations(participant_id, admission_date DESC);
CREATE INDEX idx_registry_hospitalizations_aatd ON registry_hospitalizations(aatd_related) WHERE aatd_related = true;

-- Data completeness tracking
CREATE TABLE registry_data_completeness (
  participant_id UUID PRIMARY KEY,

  -- Core data elements (boolean: present or missing)
  has_phenotype BOOLEAN DEFAULT false,
  has_aat_level BOOLEAN DEFAULT false,
  has_spirometry BOOLEAN DEFAULT false,
  has_diagnosis_date BOOLEAN DEFAULT false,
  has_symptom_onset BOOLEAN DEFAULT false,
  has_smoking_history BOOLEAN DEFAULT false,
  has_family_history BOOLEAN DEFAULT false,
  has_treatment_history BOOLEAN DEFAULT false,
  has_exacerbation_history BOOLEAN DEFAULT false,

  -- Data recency (last updated dates)
  spirometry_last_update DATE,
  aat_level_last_update DATE,
  medication_last_update DATE,
  symptoms_last_update DATE,

  -- Calculated completeness score
  completeness_score NUMERIC(3,1), -- 0.0-100.0

  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id) ON DELETE CASCADE
);

CREATE INDEX idx_registry_data_completeness_score ON registry_data_completeness(completeness_score);
```

---

## Registry Enrollment Process

### Self-Enrollment Flow

```typescript
class RegistryEnrollmentService {
  async enrollParticipant(userId: string): Promise<RegistryParticipant> {
    // 1. Check if user already enrolled
    const existing = await this.db.findOne('registry_participants', {
      user_id: userId
    });
    if (existing) {
      throw new Error('User already enrolled in registry');
    }

    // 2. Verify consent obtained
    const consent = await this.consentService.getRegistryConsent(userId);
    if (!consent || !consent.accepted) {
      throw new Error('Registry consent required before enrollment');
    }

    // 3. Pull baseline data from user profile
    const user = await this.userService.getUser(userId);
    const geneticTest = await this.geneticTestService.getLatestTest(userId);

    // 4. Create registry participant record
    const participant: RegistryParticipant = {
      participantId: uuidv4(),
      userId,
      enrollmentDate: new Date(),
      enrollmentSource: 'self_enrollment',

      demographics: {
        dateOfBirth: user.date_of_birth,
        ageAtEnrollment: this.calculateAge(user.date_of_birth),
        sex: user.sex,
        race: user.race || [],
        ethnicity: user.ethnicity || 'unknown',
        countryOfBirth: user.country_of_birth || 'USA',
        primaryLanguage: user.preferred_language || 'en'
      },

      aatdData: {
        phenotype: geneticTest?.phenotype || 'unknown',
        allele1: geneticTest?.allele1 || 'unknown',
        allele2: geneticTest?.allele2 || 'unknown',
        geneticTestDate: geneticTest?.test_date,
        geneticTestLab: geneticTest?.lab_name,
        geneticTestMethod: geneticTest?.test_method,
        aatLevels: [],
        diagnosisDate: user.medical_data?.diagnosis_date,
        diagnosisAge: user.medical_data?.diagnosis_date
          ? this.calculateAge(
              user.date_of_birth,
              user.medical_data.diagnosis_date
            )
          : null,
        diagnosticDelay: null, // Will calculate after symptom onset survey
        howDiagnosed: user.medical_data?.how_diagnosed || 'unknown'
      },

      clinicalStatus: {
        lungDisease: { present: false },
        liverDisease: { present: false },
        otherManifestations: {}
      },

      treatments: {
        augmentationTherapy: { currentlyOn: false },
        copdMedications: [],
        transplant: { received: false }
      },

      lifestyle: {
        smokingStatus: user.smoking_status || 'never',
        alcoholUse: 'none',
        occupationalExposures: [],
        residentialHistory: []
      },

      researchStatus: {
        registryEnrollmentDate: new Date(),
        activeStudies: [],
        completedStudies: [],
        dataCompleteness: 30, // Baseline (will improve with data collection)
        lastDataUpdate: new Date(),
        surveysCompleted: 0,
        surveysDeclined: 0,
        lastSurveyDate: null,
        retentionRisk: 'low'
      },

      consentStatus: {
        registryConsent: true,
        registryConsentDate: consent.consent_date,
        dataSharing: consent.data_sharing_preferences
      },

      dataProvenance: {
        lastEhrSync: null,
        lastClaimsSync: null,
        lastWearableSync: null,
        lastPatientUpdate: new Date()
      },

      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('registry_participants', participant);

    // 5. Trigger baseline data collection
    await this.initiateBaselineDataCollection(participant.participantId);

    // 6. Schedule first engagement survey
    await this.surveyService.scheduleBaselineSurvey(participant.participantId);

    // 7. Send welcome email
    await this.emailService.sendRegistryWelcome(
      userId,
      participant.participantId
    );

    return participant;
  }

  async initiateBaselineDataCollection(participantId: string): Promise<void> {
    // Pull EHR data if authorized
    const participant = await this.getParticipant(participantId);
    if (participant.consentStatus.dataSharing.clinicalData) {
      await this.ehrService.syncPatientData(participant.userId);
    }

    // Pull claims data if authorized
    if (participant.consentStatus.dataSharing.clinicalData) {
      await this.claimsService.syncClaimsData(participant.userId);
    }

    // Request baseline surveys
    await this.surveyService.createSurveyTask({
      participantId,
      surveyType: 'baseline_clinical_history',
      priority: 'high',
      dueDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days
    });

    await this.surveyService.createSurveyTask({
      participantId,
      surveyType: 'baseline_quality_of_life',
      priority: 'high',
      dueDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
    });
  }
}
```

### Provider-Referred Enrollment

```typescript
class ProviderReferralService {
  async referPatientToRegistry(
    providerId: string,
    patientUserId: string,
    referralNotes?: string
  ): Promise<RegistryReferral> {
    // 1. Create referral record
    const referral: RegistryReferral = {
      referralId: uuidv4(),
      providerId,
      patientUserId,
      referralDate: new Date(),
      referralNotes,
      status: 'pending',
      created_at: new Date()
    };

    await this.db.insert('registry_referrals', referral);

    // 2. Send invitation to patient
    await this.emailService.sendRegistryInvitation({
      to: patientUserId,
      from: providerId,
      referralId: referral.referralId,
      message: `Your provider has invited you to join the Fair Underwriting AATD Research Registry. Your participation will help advance AATD research and you'll gain access to exclusive research opportunities.`
    });

    // 3. Create in-app notification
    await this.notificationService.send({
      userId: patientUserId,
      type: 'registry_invitation',
      title: 'Join AATD Research Registry',
      message: 'Your provider recommends joining the research registry',
      actionUrl: `/registry/enroll?referral=${referral.referralId}`
    });

    return referral;
  }

  async acceptReferral(referralId: string, userId: string): Promise<void> {
    // Update referral status
    await this.db.update('registry_referrals', referralId, {
      status: 'accepted',
      accepted_date: new Date()
    });

    // Enroll in registry
    await this.enrollmentService.enrollParticipant(userId, 'provider_referral');

    // Notify provider
    const referral = await this.db.findById('registry_referrals', referralId);
    await this.notificationService.send({
      userId: referral.provider_id,
      type: 'referral_accepted',
      title: 'Patient Enrolled in Registry',
      message: 'Your patient has accepted the registry invitation'
    });
  }
}
```

---

## Cohort Building & Querying

### Interactive Cohort Builder

```typescript
interface CohortQuery {
  name: string;
  description?: string;

  // Inclusion criteria (AND logic)
  inclusion: {
    // Demographics
    ageRange?: { min: number; max: number };
    sex?: ('male' | 'female' | 'other')[];
    race?: string[];
    ethnicity?: string[];

    // AATD Criteria
    phenotypes?: string[]; // ['ZZ', 'SZ']
    aatLevelRange?: { min: number; max: number }; // mg/dL

    // Clinical Criteria
    copdStages?: string[]; // ['gold_2', 'gold_3']
    fev1PercentRange?: { min: number; max: number };
    hasLiverDisease?: boolean;

    // Treatment Criteria
    onAugmentationTherapy?: boolean;
    augmentationDuration?: { min: number; max: number }; // Months

    // Lifestyle
    smokingStatus?: ('never' | 'former' | 'current')[];
    packYearsRange?: { min: number; max: number };

    // Research Engagement
    dataCompletenessMin?: number; // 0-100
    willingToRecontact?: boolean;
  };

  // Exclusion criteria (AND logic)
  exclusion?: {
    hasTransplant?: boolean;
    pregnant?: boolean;
    recentParticipation?: string[]; // Study IDs to exclude recent participants
  };

  // Output
  returnFields?: string[]; // Which data elements to include
  deidentify?: boolean; // Remove PHI
}

class CohortBuilderService {
  async buildCohort(query: CohortQuery): Promise<CohortResult> {
    // 1. Start with all registry participants
    let sqlQuery = this.db.queryBuilder('registry_participants');

    // 2. Apply inclusion criteria
    if (query.inclusion.ageRange) {
      const minDate = new Date();
      minDate.setFullYear(minDate.getFullYear() - query.inclusion.ageRange.max);
      const maxDate = new Date();
      maxDate.setFullYear(maxDate.getFullYear() - query.inclusion.ageRange.min);

      sqlQuery = sqlQuery.whereBetween("demographics->>'dateOfBirth'", [
        minDate.toISOString(),
        maxDate.toISOString()
      ]);
    }

    if (query.inclusion.phenotypes) {
      sqlQuery = sqlQuery.whereIn('phenotype', query.inclusion.phenotypes);
    }

    if (query.inclusion.fev1PercentRange) {
      sqlQuery = sqlQuery.whereRaw(
        `
        (clinical_status->'lungDisease'->'lastSpirometry'->>'fev1_percent')::numeric
        BETWEEN ? AND ?
      `,
        [
          query.inclusion.fev1PercentRange.min,
          query.inclusion.fev1PercentRange.max
        ]
      );
    }

    if (query.inclusion.onAugmentationTherapy !== undefined) {
      sqlQuery = sqlQuery.whereRaw(
        `
        (treatments->'augmentationTherapy'->>'currentlyOn')::boolean = ?
      `,
        [query.inclusion.onAugmentationTherapy]
      );
    }

    if (query.inclusion.dataCompletenessMin) {
      sqlQuery = sqlQuery.where(
        'data_completeness',
        '>=',
        query.inclusion.dataCompletenessMin
      );
    }

    // 3. Apply exclusion criteria
    if (query.exclusion?.hasTransplant) {
      sqlQuery = sqlQuery.whereRaw(`
        (treatments->'transplant'->>'received')::boolean = false
      `);
    }

    // 4. Execute query
    const participants = await sqlQuery.select('*');

    // 5. Deidentify if requested
    let results = participants;
    if (query.deidentify) {
      results = participants.map((p) => this.deidentifyParticipant(p));
    }

    // 6. Select only requested fields
    if (query.returnFields) {
      results = results.map((p) => this.selectFields(p, query.returnFields));
    }

    // 7. Calculate cohort statistics
    const statistics = this.calculateCohortStatistics(participants);

    return {
      queryName: query.name,
      queryDescription: query.description,
      totalMatches: participants.length,
      participants: results,
      statistics,
      queryExecutedAt: new Date()
    };
  }

  calculateCohortStatistics(participants: any[]): CohortStatistics {
    return {
      count: participants.length,

      demographics: {
        meanAge: this.calculateMean(
          participants.map((p) => this.calculateAge(p.demographics.dateOfBirth))
        ),
        malePercent: this.calculatePercent(
          participants,
          (p) => p.demographics.sex === 'male'
        ),
        femalePercent: this.calculatePercent(
          participants,
          (p) => p.demographics.sex === 'female'
        )
      },

      phenotypes: {
        ZZ: this.countMatches(participants, (p) => p.phenotype === 'ZZ'),
        SZ: this.countMatches(participants, (p) => p.phenotype === 'SZ'),
        MZ: this.countMatches(participants, (p) => p.phenotype === 'MZ'),
        other: this.countMatches(
          participants,
          (p) => !['ZZ', 'SZ', 'MZ'].includes(p.phenotype)
        )
      },

      clinicalStatus: {
        meanFev1Percent: this.calculateMean(
          participants
            .filter(
              (p) =>
                p.clinical_status?.lungDisease?.lastSpirometry?.fev1_percent
            )
            .map(
              (p) => p.clinical_status.lungDisease.lastSpirometry.fev1_percent
            )
        ),
        gold1: this.countMatches(
          participants,
          (p) => p.clinical_status?.lungDisease?.copdStage === 'gold_1'
        ),
        gold2: this.countMatches(
          participants,
          (p) => p.clinical_status?.lungDisease?.copdStage === 'gold_2'
        ),
        gold3: this.countMatches(
          participants,
          (p) => p.clinical_status?.lungDisease?.copdStage === 'gold_3'
        ),
        gold4: this.countMatches(
          participants,
          (p) => p.clinical_status?.lungDisease?.copdStage === 'gold_4'
        ),
        onAugmentation: this.countMatches(
          participants,
          (p) => p.treatments?.augmentationTherapy?.currentlyOn === true
        )
      },

      lifestyle: {
        neverSmokers: this.countMatches(
          participants,
          (p) => p.lifestyle?.smokingStatus === 'never'
        ),
        formerSmokers: this.countMatches(
          participants,
          (p) => p.lifestyle?.smokingStatus === 'former'
        ),
        currentSmokers: this.countMatches(
          participants,
          (p) => p.lifestyle?.smokingStatus === 'current'
        )
      },

      dataQuality: {
        meanCompleteness: this.calculateMean(
          participants.map((p) => p.data_completeness)
        ),
        above90Percent: this.countMatches(
          participants,
          (p) => p.data_completeness >= 90
        ),
        below70Percent: this.countMatches(
          participants,
          (p) => p.data_completeness < 70
        )
      }
    };
  }

  deidentifyParticipant(participant: any): any {
    // HIPAA Safe Harbor: Remove 18 identifiers
    return {
      ...participant,
      participantId: this.hashId(participant.participantId), // Pseudonymous ID
      userId: null, // Remove link to user account
      demographics: {
        ...participant.demographics,
        dateOfBirth: null, // Remove exact DOB
        ageAtEnrollment: this.generalizeAge(
          participant.demographics.ageAtEnrollment
        ), // 5-year bins
        zipCode: null // Remove from residential history
      }
      // Remove facility names, provider IDs, etc.
    };
  }

  generalizeAge(age: number): string {
    // Generalize to 5-year age bins
    const bin = Math.floor(age / 5) * 5;
    return `${bin}-${bin + 4}`;
  }
}
```

### Saved Cohort Queries

```typescript
interface SavedCohort {
  cohortId: string;
  userId: string; // Researcher who created it
  name: string;
  description: string;
  query: CohortQuery;

  // Results cache
  lastExecutedAt: Date;
  lastResultCount: number;

  // Notifications
  notifyOnNewMatches: boolean; // Email researcher when new participants match criteria

  created_at: Date;
  updated_at: Date;
}

class SavedCohortService {
  async saveCohort(userId: string, query: CohortQuery): Promise<SavedCohort> {
    // Execute query to get baseline count
    const result = await this.cohortBuilder.buildCohort(query);

    const cohort: SavedCohort = {
      cohortId: uuidv4(),
      userId,
      name: query.name,
      description: query.description,
      query,
      lastExecutedAt: new Date(),
      lastResultCount: result.totalMatches,
      notifyOnNewMatches: false,
      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('saved_cohorts', cohort);

    return cohort;
  }

  async refreshCohort(cohortId: string): Promise<void> {
    const cohort = await this.db.findById('saved_cohorts', cohortId);
    const result = await this.cohortBuilder.buildCohort(cohort.query);

    await this.db.update('saved_cohorts', cohortId, {
      last_executed_at: new Date(),
      last_result_count: result.totalMatches,
      updated_at: new Date()
    });

    // Check for new matches
    if (
      cohort.notifyOnNewMatches &&
      result.totalMatches > cohort.lastResultCount
    ) {
      const newMatches = result.totalMatches - cohort.lastResultCount;
      await this.notificationService.send({
        userId: cohort.userId,
        type: 'cohort_new_matches',
        title: `${newMatches} new participants match "${cohort.name}"`,
        message: `Your saved cohort now has ${result.totalMatches} matching participants (was ${cohort.lastResultCount})`,
        actionUrl: `/research/cohorts/${cohortId}`
      });
    }
  }
}
```

---

## Data Completeness Monitoring

### Completeness Score Calculation

```typescript
class DataCompletenessService {
  async calculateCompleteness(participantId: string): Promise<number> {
    const participant = await this.db.findById(
      'registry_participants',
      participantId
    );

    // Define required data elements with weights
    const dataElements = [
      {
        field: 'phenotype',
        weight: 10,
        check: () => participant.phenotype !== 'unknown'
      },
      {
        field: 'aatLevel',
        weight: 8,
        check: () => participant.aat_levels?.length > 0
      },
      {
        field: 'spirometry',
        weight: 10,
        check: () => this.hasRecentSpirometry(participantId)
      },
      {
        field: 'diagnosisDate',
        weight: 5,
        check: () => participant.diagnosis_date !== null
      },
      {
        field: 'symptomOnset',
        weight: 5,
        check: () => participant.aatd_data?.symptom_onset_date !== null
      },
      {
        field: 'smokingHistory',
        weight: 7,
        check: () => participant.lifestyle?.smoking_status !== null
      },
      {
        field: 'familyHistory',
        weight: 5,
        check: () => participant.family_history?.length > 0
      },
      {
        field: 'currentMedications',
        weight: 8,
        check: () => participant.treatments?.copd_medications?.length > 0
      },
      {
        field: 'augmentationStatus',
        weight: 10,
        check: () =>
          participant.treatments?.augmentation_therapy?.currently_on !== null
      },
      {
        field: 'exacerbationHistory',
        weight: 8,
        check: () => this.hasExacerbationData(participantId)
      },
      {
        field: 'qualityOfLife',
        weight: 8,
        check: () => this.hasQoLData(participantId)
      },
      {
        field: 'comorbidities',
        weight: 6,
        check: () => participant.comorbidities?.length > 0
      },
      {
        field: 'occupation',
        weight: 5,
        check: () => participant.lifestyle?.occupational_exposures !== null
      },
      {
        field: 'residence',
        weight: 5,
        check: () => participant.lifestyle?.residential_history?.length > 0
      }
    ];

    let totalWeight = 0;
    let achievedWeight = 0;

    for (const element of dataElements) {
      totalWeight += element.weight;
      if (element.check()) {
        achievedWeight += element.weight;
      }
    }

    const score = (achievedWeight / totalWeight) * 100;

    // Update registry participant record
    await this.db.update('registry_participants', participantId, {
      data_completeness: score,
      updated_at: new Date()
    });

    // Update data completeness tracking table
    await this.updateDataCompletenessTracking(participantId, dataElements);

    return score;
  }

  async updateDataCompletenessTracking(
    participantId: string,
    dataElements: any[]
  ): Promise<void> {
    const tracking = {
      participant_id: participantId,
      has_phenotype: dataElements.find((e) => e.field === 'phenotype').check(),
      has_aat_level: dataElements.find((e) => e.field === 'aatLevel').check(),
      has_spirometry: dataElements
        .find((e) => e.field === 'spirometry')
        .check(),
      has_diagnosis_date: dataElements
        .find((e) => e.field === 'diagnosisDate')
        .check(),
      has_symptom_onset: dataElements
        .find((e) => e.field === 'symptomOnset')
        .check(),
      has_smoking_history: dataElements
        .find((e) => e.field === 'smokingHistory')
        .check(),
      has_family_history: dataElements
        .find((e) => e.field === 'familyHistory')
        .check(),
      has_treatment_history: dataElements
        .find((e) => e.field === 'currentMedications')
        .check(),
      has_exacerbation_history: dataElements
        .find((e) => e.field === 'exacerbationHistory')
        .check(),
      completeness_score: await this.calculateCompleteness(participantId),
      updated_at: new Date()
    };

    await this.db.upsert('registry_data_completeness', tracking, [
      'participant_id'
    ]);
  }

  async identifyMissingData(participantId: string): Promise<string[]> {
    const completeness = await this.db.findOne('registry_data_completeness', {
      participant_id: participantId
    });

    const missingElements: string[] = [];

    if (!completeness.has_phenotype)
      missingElements.push('Genetic test results (phenotype)');
    if (!completeness.has_aat_level)
      missingElements.push('AAT level blood test');
    if (!completeness.has_spirometry)
      missingElements.push('Recent spirometry (within 12 months)');
    if (!completeness.has_diagnosis_date)
      missingElements.push('Diagnosis date');
    if (!completeness.has_symptom_onset)
      missingElements.push('When symptoms first started');
    if (!completeness.has_smoking_history)
      missingElements.push('Smoking history');
    if (!completeness.has_family_history)
      missingElements.push('Family history of AATD');
    if (!completeness.has_treatment_history)
      missingElements.push('Current medications');
    if (!completeness.has_exacerbation_history)
      missingElements.push('Exacerbation history');

    return missingElements;
  }

  async sendDataCompletenessSurvey(participantId: string): Promise<void> {
    const missingData = await this.identifyMissingData(participantId);

    if (missingData.length === 0) {
      return; // Data already complete
    }

    // Create targeted survey to fill gaps
    await this.surveyService.createSurveyTask({
      participantId,
      surveyType: 'data_completeness',
      priority: 'medium',
      questions: this.generateQuestionsForMissingData(missingData),
      dueDate: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000) // 14 days
    });

    // Send notification
    await this.notificationService.send({
      userId: (await this.getParticipant(participantId)).userId,
      type: 'data_completeness_survey',
      title: 'Help Complete Your Registry Profile',
      message: `We're missing ${missingData.length} data elements. Complete a 5-minute survey to improve your profile.`,
      actionUrl: `/registry/surveys/data-completeness`
    });
  }
}
```

---

## Integration with External Registries

### AlphaNet Registry Integration

```typescript
class AlphaNetIntegrationService {
  async importFromAlphaNet(
    participantId: string,
    alphanetId: string
  ): Promise<void> {
    // 1. Request data export from AlphaNet API
    const alphanetData =
      await this.alphanetClient.exportPatientData(alphanetId);

    // 2. Map AlphaNet data model to Fair Underwriting registry model
    const mappedData = this.mapAlphaNetData(alphanetData);

    // 3. Merge with existing participant data (avoid overwriting newer data)
    await this.mergeParticipantData(participantId, mappedData);

    // 4. Log data provenance
    await this.db.insert('registry_data_imports', {
      participant_id: participantId,
      source: 'alphanet',
      source_id: alphanetId,
      import_date: new Date(),
      records_imported: Object.keys(mappedData).length
    });
  }

  mapAlphaNetData(alphanetData: any): Partial<RegistryParticipant> {
    return {
      demographics: {
        dateOfBirth: alphanetData.dob,
        sex: alphanetData.gender,
        race: [alphanetData.race],
        ethnicity: alphanetData.ethnicity
      },

      aatdData: {
        phenotype: alphanetData.genotype,
        diagnosisDate: alphanetData.diagnosis_date
      },

      treatments: {
        augmentationTherapy: {
          currentlyOn: alphanetData.on_augmentation === 'Yes',
          brand: alphanetData.augmentation_product?.toLowerCase(),
          startDate: alphanetData.augmentation_start_date
        }
      },

      lifestyle: {
        smokingStatus: alphanetData.smoking_status,
        packYears: alphanetData.pack_years
      }
    };
  }

  async syncWithAlphaNet(participantId: string): Promise<void> {
    // Check if participant linked to AlphaNet
    const link = await this.db.findOne('registry_external_links', {
      participant_id: participantId,
      external_registry: 'alphanet'
    });

    if (!link) {
      return; // Not linked
    }

    // Pull latest data
    await this.importFromAlphaNet(participantId, link.external_id);
  }
}
```

---

## Budget & Success Metrics

### Development Costs (3-4 months)

- **Backend Developer** (registry database, APIs, cohort builder): $140K/year × 0.33 = $46,200
- **Data Engineer** (ETL pipelines, data completeness): $150K/year × 0.33 = $49,500
- **Frontend Developer** (cohort builder UI, participant dashboard): $140K/year × 0.25 = $35,000

**Total**: ~$130,700

### Annual Operations

- **Database Storage** (PostgreSQL + TimescaleDB): $12,000/year
- **Data Quality Monitoring**: $6,000/year
- **External Registry Integration**: $8,000/year

**Total**: ~$26,000/year

### Success Metrics

- **Enrollment Rate**: 70% of Fair Underwriting users enroll within 6 months
- **Data Completeness**: Average 90% (vs. 65% industry standard)
- **Retention**: 80% remain active after 3 years
- **Cohort Building**: <5 seconds for complex queries on 10,000+ participants

---

**Document Status:** Complete
**Next Document:** MISSING_FEATURES_21A3_NATURAL_HISTORY_STUDIES.md
