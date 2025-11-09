# Feature #9: Clinical Decision Support & Care Coordination

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 5-6 months
**Team Required**: 1 backend developer, 1 frontend developer, 1 clinical informaticist, 1 integration specialist

---

## Executive Summary

AATD patients require coordinated care across multiple specialists (pulmonologists, hepatologists, genetic counselors). Fair Underwriting currently provides test results but lacks clinical decision support tools to help providers manage patients and coordinate care. This feature builds an intelligent care coordination platform that guides treatment decisions, monitors patient progress, and facilitates referrals to specialists.

**Key Value Propositions**:

- **Clinical Guidelines**: Evidence-based treatment protocols for MZ/ZZ patients
- **Risk Stratification**: Automatically identify high-risk patients needing urgent care
- **Care Plans**: Personalized monitoring schedules based on genotype and symptoms
- **Specialist Referrals**: Smart referral matching to AATD experts in patient's area
- **Provider Collaboration**: Secure messaging between PCP, pulmonologist, hepatologist
- **Medication Management**: Track augmentation therapy adherence, side effects

**Business Impact**:

- Improve patient outcomes: 30% better treatment adherence with care plans
- Increase provider satisfaction: 85% of PCPs feel supported managing AATD patients
- Enable value-based contracts: Demonstrate quality metrics to payers
- Drive telemedicine revenue: 60% of care plan patients book consultations
- Differentiate from competitors: Only platform with integrated clinical decision support

---

## Problem Statement

### Current Gaps

**Scenario 1: PCP Overwhelmed Managing ZZ Patient**

> "I'm a primary care physician. My patient just tested ZZ with low AAT levels (35 mg/dL). I've never treated AATD before. Should I start augmentation therapy? Refer to pulmonologist? Order liver function tests? What's the monitoring schedule? I need clinical guidance."

**No clinical decision support for PCPs** ❌

**Scenario 2: ZZ Patient Not Receiving Guideline-Based Care**

> "I'm ZZ and saw my doctor. He said 'just wait and see.' But I read that early augmentation therapy can slow lung damage. How do I know if I should push for treatment? Am I getting the right care?"

**No patient-facing tools to understand if care meets guidelines** ❌

**Scenario 3: Fragmented Care Across Multiple Specialists**

> "I see 3 doctors: my PCP, a pulmonologist, and a hepatologist. They don't talk to each other. My pulmonologist doesn't know my liver enzymes are elevated. I'm the only one coordinating my care."

**No care coordination platform** ❌

**Scenario 4: MZ Carrier with Risk Factors Falls Through Cracks**

> "I'm MZ and smoke 1 pack/day. My doctor said 'you're just a carrier, no big deal.' But MZ + smoking = high COPD risk. Should I see a pulmonologist? Get baseline spirometry? No one told me what to do."

**No risk stratification to identify high-risk carriers** ❌

**Scenario 5: Patient Non-Adherent to Augmentation Therapy**

> "I'm on Prolastin infusions weekly. Some weeks I skip because of side effects. My doctor doesn't know. If I'm not adherent, is the therapy even working?"

**No medication adherence tracking** ❌

---

## Feature Specifications

### 1. Clinical Decision Support Engine

**Risk Stratification Algorithm**:

```typescript
interface PatientRiskProfile {
  userId: string;
  genotype: 'MM' | 'MZ' | 'ZZ' | 'MS' | 'SZ' | 'SS';
  aatLevel: number; // mg/dL

  // Risk factors
  age: number;
  smoker: boolean;
  packYears?: number;
  hasLungSymptoms: boolean; // SOB, cough, wheezing
  hasLiverSymptoms: boolean; // Jaundice, ascites
  familyHistoryCOPD: boolean;
  familyHistoryLiverDisease: boolean;
  occupationalExposure: boolean; // Dust, fumes, chemicals

  // Clinical data
  fev1Percent?: number; // Forced expiratory volume (% predicted)
  liverEnzymes?: {
    ast: number;
    alt: number;
    alkPhos: number;
  };

  // Calculated risk scores
  copdRiskScore: number; // 0-100
  liverRiskScore: number; // 0-100
  overallRiskTier: 'low' | 'moderate' | 'high' | 'critical';
}

class ClinicalDecisionSupportEngine {
  calculateRiskScore(patient: PatientRiskProfile): RiskAssessment {
    // COPD risk scoring
    let copdRisk = 0;

    // Genotype baseline
    if (patient.genotype === 'MM') copdRisk = 5;
    if (patient.genotype === 'MZ') copdRisk = 15; // 2-4x normal
    if (patient.genotype === 'ZZ') copdRisk = 60; // Very high baseline

    // AAT level (lower = worse)
    if (patient.aatLevel < 50)
      copdRisk += 30; // Severe deficiency
    else if (patient.aatLevel < 80) copdRisk += 20; // Moderate deficiency

    // Smoking (MASSIVE impact for AATD)
    if (patient.smoker) {
      if (patient.genotype === 'ZZ')
        copdRisk += 30; // Catastrophic combination
      else if (patient.genotype === 'MZ') copdRisk += 25;
      else copdRisk += 10;

      copdRisk += (patient.packYears || 0) * 2; // +2 per pack-year
    }

    // Age
    if (patient.age > 50) copdRisk += 10;
    if (patient.age > 60) copdRisk += 15;

    // Symptoms
    if (patient.hasLungSymptoms) copdRisk += 15;

    // Lung function
    if (patient.fev1Percent && patient.fev1Percent < 80) {
      copdRisk += (80 - patient.fev1Percent) * 0.5; // Scaled by impairment
    }

    // Occupational exposure
    if (patient.occupationalExposure) copdRisk += 15;

    // Family history
    if (patient.familyHistoryCOPD) copdRisk += 10;

    copdRisk = Math.min(copdRisk, 100);

    // Liver risk scoring
    let liverRisk = 0;

    if (patient.genotype === 'ZZ')
      liverRisk = 40; // High baseline
    else if (patient.genotype === 'MZ') liverRisk = 5; // Rare in MZ

    if (patient.hasLiverSymptoms) liverRisk += 30;

    if (patient.liverEnzymes) {
      if (patient.liverEnzymes.alt > 100) liverRisk += 20; // Elevated
      if (patient.liverEnzymes.ast > 100) liverRisk += 20;
    }

    if (patient.familyHistoryLiverDisease) liverRisk += 10;

    liverRisk = Math.min(liverRisk, 100);

    // Overall risk tier
    const maxRisk = Math.max(copdRisk, liverRisk);
    let overallRiskTier: 'low' | 'moderate' | 'high' | 'critical';

    if (maxRisk >= 75) overallRiskTier = 'critical';
    else if (maxRisk >= 50) overallRiskTier = 'high';
    else if (maxRisk >= 30) overallRiskTier = 'moderate';
    else overallRiskTier = 'low';

    return {
      copdRiskScore: copdRisk,
      liverRiskScore: liverRisk,
      overallRiskTier,
      recommendations: this.generateRecommendations(
        patient,
        copdRisk,
        liverRisk
      )
    };
  }

  generateRecommendations(
    patient: PatientRiskProfile,
    copdRisk: number,
    liverRisk: number
  ): ClinicalRecommendation[] {
    const recommendations: ClinicalRecommendation[] = [];

    // Critical: Smoking cessation for AATD
    if (
      patient.smoker &&
      (patient.genotype === 'MZ' || patient.genotype === 'ZZ')
    ) {
      recommendations.push({
        priority: 'critical',
        category: 'smoking_cessation',
        title: 'URGENT: Quit Smoking',
        description:
          'Smoking accelerates lung damage in AATD by 10-20 years. Immediate cessation is the single most important intervention.',
        actions: [
          'Refer to smoking cessation program',
          'Consider pharmacotherapy (varenicline, bupropion, NRT)',
          'Behavioral counseling'
        ],
        evidenceLevel: 'A', // Strong evidence
        references: ['ATS Guidelines 2003']
      });
    }

    // ZZ patients: Consider augmentation therapy
    if (patient.genotype === 'ZZ' && patient.aatLevel < 50) {
      recommendations.push({
        priority: 'high',
        category: 'augmentation_therapy',
        title: 'Consider Augmentation Therapy',
        description:
          'AAT level <50 mg/dL with ZZ genotype. Augmentation therapy may slow lung function decline.',
        actions: [
          'Refer to pulmonologist experienced in AATD',
          'Baseline spirometry (FEV1)',
          'Discuss risks/benefits of Prolastin/Aralast/Zemaira',
          'Check insurance coverage'
        ],
        evidenceLevel: 'B',
        references: ['RAPID Trial 2015', 'ATS/ERS Guidelines 2003']
      });
    }

    // High COPD risk: Pulmonology referral
    if (copdRisk >= 50) {
      recommendations.push({
        priority: 'high',
        category: 'specialist_referral',
        title: 'Refer to Pulmonologist',
        description: 'High risk for COPD. Specialist evaluation recommended.',
        actions: [
          'Baseline spirometry',
          'Chest CT (if symptomatic)',
          'Pulmonary function tests',
          'Exercise tolerance testing'
        ],
        evidenceLevel: 'A'
      });
    }

    // Moderate risk: Baseline testing
    if (copdRisk >= 30 && copdRisk < 50) {
      recommendations.push({
        priority: 'moderate',
        category: 'monitoring',
        title: 'Baseline Lung Function Testing',
        description: 'Establish baseline to monitor for future decline.',
        actions: ['Office spirometry', 'Repeat annually', 'Monitor symptoms'],
        evidenceLevel: 'B'
      });
    }

    // Liver risk: Hepatology referral
    if (liverRisk >= 50) {
      recommendations.push({
        priority: 'high',
        category: 'specialist_referral',
        title: 'Refer to Hepatologist',
        description: 'Elevated liver risk. Specialist evaluation recommended.',
        actions: [
          'Comprehensive hepatic panel',
          'Abdominal ultrasound',
          'Consider liver biopsy',
          'Fibroscan (liver stiffness)'
        ],
        evidenceLevel: 'A'
      });
    }

    // Vaccinations (all AATD patients)
    recommendations.push({
      priority: 'routine',
      category: 'prevention',
      title: 'Ensure Up-to-Date Vaccinations',
      description: 'AATD patients need protection from respiratory infections.',
      actions: [
        'Annual influenza vaccine',
        'Pneumococcal vaccine (PPSV23 + PCV13)',
        'COVID-19 vaccine + boosters',
        'RSV vaccine (if age 60+)'
      ],
      evidenceLevel: 'A'
    });

    return recommendations.sort((a, b) => {
      const priorityOrder = { critical: 0, high: 1, moderate: 2, routine: 3 };
      return priorityOrder[a.priority] - priorityOrder[b.priority];
    });
  }
}

interface ClinicalRecommendation {
  priority: 'critical' | 'high' | 'moderate' | 'routine';
  category:
    | 'smoking_cessation'
    | 'augmentation_therapy'
    | 'specialist_referral'
    | 'monitoring'
    | 'prevention';
  title: string;
  description: string;
  actions: string[];
  evidenceLevel: 'A' | 'B' | 'C'; // A=strong, B=moderate, C=weak evidence
  references?: string[];
}

interface RiskAssessment {
  copdRiskScore: number;
  liverRiskScore: number;
  overallRiskTier: 'low' | 'moderate' | 'high' | 'critical';
  recommendations: ClinicalRecommendation[];
}
```

### 2. Personalized Care Plans

**Care Plan Template by Genotype**:

```typescript
interface CarePlan {
  userId: string;
  genotype: string;
  riskTier: string;

  // Monitoring schedule
  monitoring: {
    spirometry: { frequency: string; nextDue: Date }; // 'annually', 'every_6_months'
    aatLevel: { frequency: string; nextDue: Date };
    liverPanel: { frequency: string; nextDue: Date };
    chestXray: { frequency: string; nextDue: Date };
    ctChest: { frequency: string; nextDue: Date };
  };

  // Specialist appointments
  specialists: {
    pulmonologist: { frequency: string; nextDue: Date };
    hepatologist?: { frequency: string; nextDue: Date };
    geneticCounselor?: { frequency: string; nextDue: Date };
  };

  // Medications
  medications: {
    name: string;
    dosage: string;
    frequency: string;
    purpose: string;
    startDate: Date;
  }[];

  // Lifestyle recommendations
  lifestyle: {
    smokingCessation: boolean;
    exerciseMinutesPerWeek: number;
    vaccinationSchedule: string[];
    environmentalPrecautions: string[];
  };

  // Care team
  careTeam: {
    primaryCareProvider: ProviderId;
    pulmonologist?: ProviderId;
    hepatologist?: ProviderId;
    geneticCounselor?: ProviderId;
  };
}

// Example care plan for ZZ patient
const zzCarePlan: CarePlan = {
  userId: 'user-123',
  genotype: 'ZZ',
  riskTier: 'high',

  monitoring: {
    spirometry: {
      frequency: 'every_6_months',
      nextDue: new Date('2025-05-01')
    },
    aatLevel: { frequency: 'annually', nextDue: new Date('2026-01-15') },
    liverPanel: { frequency: 'annually', nextDue: new Date('2026-01-15') },
    chestXray: { frequency: 'annually', nextDue: new Date('2026-01-15') },
    ctChest: { frequency: 'every_2_years', nextDue: new Date('2027-01-15') }
  },

  specialists: {
    pulmonologist: { frequency: 'quarterly', nextDue: new Date('2025-02-01') },
    hepatologist: { frequency: 'annually', nextDue: new Date('2026-01-15') },
    geneticCounselor: { frequency: 'as_needed', nextDue: null }
  },

  medications: [
    {
      name: 'Prolastin-C (Alpha-1 Proteinase Inhibitor)',
      dosage: '60 mg/kg',
      frequency: 'Weekly IV infusion',
      purpose: 'Augmentation therapy to slow lung damage',
      startDate: new Date('2024-06-15')
    },
    {
      name: 'Albuterol HFA',
      dosage: '2 puffs',
      frequency: 'As needed (PRN)',
      purpose: 'Bronchodilator for shortness of breath',
      startDate: new Date('2024-08-01')
    }
  ],

  lifestyle: {
    smokingCessation: true, // CRITICAL
    exerciseMinutesPerWeek: 150, // Moderate exercise
    vaccinationSchedule: [
      'Flu (annual)',
      'Pneumonia (PPSV23 + PCV13)',
      'COVID-19 (boosters)',
      'RSV (if 60+)'
    ],
    environmentalPrecautions: [
      'Avoid air pollution (check AQI daily)',
      'Wear N95 mask on high pollution days',
      'Avoid occupational dust/fumes',
      'Use HEPA air purifier at home'
    ]
  },

  careTeam: {
    primaryCareProvider: 'provider-001',
    pulmonologist: 'provider-045',
    hepatologist: 'provider-089'
  }
};

// Example care plan for MZ carrier (low risk)
const mzCarePlan: CarePlan = {
  userId: 'user-456',
  genotype: 'MZ',
  riskTier: 'moderate',

  monitoring: {
    spirometry: { frequency: 'annually', nextDue: new Date('2026-01-15') },
    aatLevel: { frequency: 'every_5_years', nextDue: new Date('2030-01-15') },
    liverPanel: { frequency: 'as_needed', nextDue: null },
    chestXray: { frequency: 'as_needed', nextDue: null },
    ctChest: { frequency: 'as_needed', nextDue: null }
  },

  specialists: {
    pulmonologist: { frequency: 'baseline_then_as_needed', nextDue: null }
  },

  medications: [], // Usually no augmentation therapy for MZ

  lifestyle: {
    smokingCessation: true, // Still critical for MZ
    exerciseMinutesPerWeek: 150,
    vaccinationSchedule: ['Flu (annual)', 'Pneumonia', 'COVID-19'],
    environmentalPrecautions: [
      'Avoid smoking (if smoker, quit immediately)',
      'Minimize occupational exposures',
      'Monitor for respiratory symptoms'
    ]
  },

  careTeam: {
    primaryCareProvider: 'provider-001'
  }
};
```

### 3. Database Schema

```sql
-- Care plans
CREATE TABLE care_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Plan details
  genotype VARCHAR(10) NOT NULL,
  risk_tier VARCHAR(20) NOT NULL, -- 'low', 'moderate', 'high', 'critical'
  plan_type VARCHAR(50), -- 'standard_mz', 'standard_zz', 'custom'

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'completed', 'suspended'

  -- Monitoring schedule (JSONB for flexibility)
  monitoring_schedule JSONB, -- {spirometry: {frequency: 'annual', nextDue: '2026-01-15'}}
  specialist_schedule JSONB,

  -- Care team
  primary_care_provider_id UUID,
  pulmonologist_id UUID,
  hepatologist_id UUID,
  genetic_counselor_id UUID,

  -- Created/updated
  created_by_provider_id UUID, -- Provider who created plan
  created_at TIMESTAMPTZ DEFAULT NOW(),
  last_updated_at TIMESTAMPTZ DEFAULT NOW(),
  last_reviewed_at TIMESTAMPTZ, -- Last time provider reviewed plan

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (primary_care_provider_id) REFERENCES providers(id)
);

CREATE INDEX idx_care_plans_user ON care_plans(user_id, status);

-- Care plan tasks (monitoring items, appointments, etc.)
CREATE TABLE care_plan_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  care_plan_id UUID NOT NULL,
  user_id UUID NOT NULL,

  -- Task details
  task_type VARCHAR(50) NOT NULL, -- 'spirometry', 'aat_test', 'specialist_appointment', 'vaccination'
  task_title VARCHAR(200),
  task_description TEXT,

  -- Scheduling
  due_date DATE,
  reminder_date DATE, -- Send reminder X days before due
  frequency VARCHAR(50), -- 'annually', 'quarterly', 'monthly', 'one_time'

  -- Status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'completed', 'overdue', 'cancelled'
  completed_at TIMESTAMPTZ,
  completed_by_user_id UUID,

  -- Results (if applicable)
  result_value TEXT, -- e.g., 'FEV1: 75%', 'AAT: 45 mg/dL'
  result_interpretation TEXT, -- 'Within normal limits', 'Declining function'
  result_file_url TEXT, -- PDF lab report

  -- Next recurrence (for recurring tasks)
  next_occurrence_date DATE,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (care_plan_id) REFERENCES care_plans(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_care_plan_tasks_user ON care_plan_tasks(user_id, status, due_date);
CREATE INDEX idx_care_plan_tasks_overdue ON care_plan_tasks(status, due_date) WHERE status = 'pending' AND due_date < CURRENT_DATE;

-- Medication tracking
CREATE TABLE patient_medications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,
  care_plan_id UUID,

  -- Medication info
  medication_name VARCHAR(200) NOT NULL,
  generic_name VARCHAR(200),
  dosage VARCHAR(100), -- '60 mg/kg', '2 puffs'
  frequency VARCHAR(100), -- 'Weekly IV', 'PRN', 'Daily'
  route VARCHAR(50), -- 'IV', 'Oral', 'Inhaled'

  -- Purpose
  indication VARCHAR(200), -- 'Augmentation therapy', 'Bronchodilator'

  -- Prescriber
  prescribed_by_provider_id UUID,
  prescribed_date DATE,

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'discontinued', 'on_hold'
  start_date DATE,
  end_date DATE,
  discontinuation_reason TEXT,

  -- Adherence tracking
  adherence_percentage DECIMAL(5, 2), -- 0.00 - 100.00
  missed_doses_last_30_days INTEGER DEFAULT 0,

  -- Side effects
  side_effects TEXT[], -- ['headache', 'fatigue', 'nausea']

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (care_plan_id) REFERENCES care_plans(id),
  FOREIGN KEY (prescribed_by_provider_id) REFERENCES providers(id)
);

CREATE INDEX idx_patient_medications_user ON patient_medications(user_id, status);

-- Medication doses (adherence tracking)
CREATE TABLE medication_doses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  medication_id UUID NOT NULL,
  user_id UUID NOT NULL,

  -- Dose details
  scheduled_date DATE NOT NULL,
  scheduled_time TIME,

  -- Status
  status VARCHAR(20) DEFAULT 'scheduled', -- 'scheduled', 'taken', 'missed', 'skipped'
  actual_date DATE,
  actual_time TIME,

  -- Self-reported
  side_effects_reported TEXT[],
  notes TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (medication_id) REFERENCES patient_medications(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_medication_doses_medication ON medication_doses(medication_id, scheduled_date);
CREATE INDEX idx_medication_doses_user ON medication_doses(user_id, status);

-- Clinical recommendations (from decision support engine)
CREATE TABLE clinical_recommendations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,
  care_plan_id UUID,

  -- Recommendation
  priority VARCHAR(20) NOT NULL, -- 'critical', 'high', 'moderate', 'routine'
  category VARCHAR(50), -- 'smoking_cessation', 'augmentation_therapy', etc.
  title VARCHAR(300),
  description TEXT,
  actions JSONB, -- ["action 1", "action 2"]

  -- Evidence
  evidence_level VARCHAR(5), -- 'A', 'B', 'C'
  references TEXT[], -- Citations

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'completed', 'dismissed', 'not_applicable'
  dismissed_reason TEXT,

  -- Provider response
  reviewed_by_provider_id UUID,
  reviewed_at TIMESTAMPTZ,
  provider_action_taken TEXT, -- What provider did in response

  -- Timing
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ, -- Some recommendations have expiration

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (care_plan_id) REFERENCES care_plans(id),
  FOREIGN KEY (reviewed_by_provider_id) REFERENCES providers(id)
);

CREATE INDEX idx_clinical_recommendations_user ON clinical_recommendations(user_id, status, priority);

-- Specialist referrals
CREATE TABLE specialist_referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,
  care_plan_id UUID,

  -- Referral details
  specialty VARCHAR(100) NOT NULL, -- 'Pulmonology', 'Hepatology', 'Genetic Counseling'
  reason TEXT NOT NULL,
  urgency VARCHAR(20) DEFAULT 'routine', -- 'urgent', 'routine', 'non_urgent'

  -- Referring provider
  referring_provider_id UUID NOT NULL,
  referred_date DATE DEFAULT CURRENT_DATE,

  -- Referred to
  referred_to_provider_id UUID, -- Specific provider (if known)
  referred_to_practice_name VARCHAR(200),

  -- Status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'scheduled', 'completed', 'cancelled'
  appointment_date DATE,
  appointment_time TIME,
  completed_at TIMESTAMPTZ,

  -- Clinical info shared
  clinical_summary TEXT,
  relevant_test_results JSONB,
  attached_files TEXT[], -- S3 URLs to PDFs

  -- Follow-up
  consultation_notes TEXT, -- Specialist's notes (if shared back)
  recommendations_from_specialist TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (care_plan_id) REFERENCES care_plans(id),
  FOREIGN KEY (referring_provider_id) REFERENCES providers(id),
  FOREIGN KEY (referred_to_provider_id) REFERENCES providers(id)
);

CREATE INDEX idx_specialist_referrals_user ON specialist_referrals(user_id, status);
CREATE INDEX idx_specialist_referrals_provider ON specialist_referrals(referred_to_provider_id, status);

-- Provider messages (secure care team communication)
CREATE TABLE provider_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Message
  from_provider_id UUID NOT NULL,
  to_provider_id UUID NOT NULL,
  subject VARCHAR(300),
  body TEXT NOT NULL,

  -- Related items
  related_care_plan_id UUID,
  related_referral_id UUID,
  related_test_result_id UUID,

  -- Status
  status VARCHAR(20) DEFAULT 'unread', -- 'unread', 'read', 'archived'
  read_at TIMESTAMPTZ,

  -- Attachments
  attachments TEXT[], -- S3 URLs

  -- Thread
  parent_message_id UUID, -- For replies
  thread_id UUID, -- All messages in conversation

  sent_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_user_id) REFERENCES users(id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  FOREIGN KEY (from_provider_id) REFERENCES providers(id),
  FOREIGN KEY (to_provider_id) REFERENCES providers(id),
  FOREIGN KEY (related_care_plan_id) REFERENCES care_plans(id),
  FOREIGN KEY (parent_message_id) REFERENCES provider_messages(id)
);

CREATE INDEX idx_provider_messages_to ON provider_messages(to_provider_id, status);
CREATE INDEX idx_provider_messages_patient ON provider_messages(patient_user_id);
CREATE INDEX idx_provider_messages_thread ON provider_messages(thread_id, sent_at);
```

### 4. Provider Dashboard

**Clinical Dashboard for PCPs**:

```
┌─────────────────────────────────────────────────────────────────┐
│  👨‍⚕️ Provider Portal - Dr. Sarah Chen, MD                        │
│     Primary Care Physician                                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🚨 ALERTS & NOTIFICATIONS                                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ ⚠️  URGENT: John Doe (MZ) - Smoker with declining FEV1   │  │
│  │     FEV1 dropped from 85% → 72% in 6 months              │  │
│  │     Recommendation: Refer to pulmonologist urgently       │  │
│  │     [View Details] [Send Referral]                        │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🔔  3 patients have overdue monitoring tasks              │  │
│  │     - Alice Brown: Spirometry overdue by 30 days         │  │
│  │     - Bob Smith: Liver panel overdue by 15 days          │  │
│  │     - Carol Davis: Flu vaccine recommended               │  │
│  │     [Review Tasks]                                        │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📊 MY AATD PATIENTS (24 total)                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Risk Tier   │ Count │ Action Needed                       │  │
│  ├─────────────┼───────┼─────────────────────────────────────┤  │
│  │ 🚨 Critical │   2   │ [Review Care Plans]                 │  │
│  │ ⚠️  High    │   5   │ [Monitor Closely]                   │  │
│  │ 🟡 Moderate │  12   │ [Routine Monitoring]                │  │
│  │ 🟢 Low      │   5   │ [Annual Check-ins]                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🎯 RECOMMENDED ACTIONS                                         │
│  • 2 patients need smoking cessation referrals                  │
│  • 1 patient eligible for augmentation therapy                  │
│  • 3 patients due for spirometry                                │
│  • 5 patients need flu vaccines                                 │
│                                                                  │
│  📁 QUICK LINKS                                                 │
│  [Patient List] [Care Plans] [Referrals] [Messages] [Reports]  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Patient Care Plan View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  📋 Care Plan: John Doe (MZ Carrier)                            │
│     Risk Tier: High (COPD Risk: 68/100)                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ⚠️  CLINICAL ALERTS                                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • Active smoker (20 pack-years) - QUIT IMMEDIATELY        │  │
│  │ • FEV1 declining: 85% → 72% over 6 months                 │  │
│  │ • Overdue for spirometry (30 days)                        │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🎯 CLINICAL RECOMMENDATIONS (3)                                │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 1. 🚨 CRITICAL: Smoking Cessation                         │  │
│  │    Evidence Level: A                                       │  │
│  │    Actions:                                                │  │
│  │    ☐ Refer to smoking cessation program                   │  │
│  │    ☐ Prescribe varenicline (Chantix)                      │  │
│  │    ☐ Follow-up in 2 weeks                                 │  │
│  │    [Mark Complete] [Dismiss]                              │  │
│  │                                                            │  │
│  │ 2. ⚠️  HIGH: Urgent Pulmonology Referral                  │  │
│  │    Declining lung function warrants specialist eval       │  │
│  │    [Send Referral] [View Guidelines]                      │  │
│  │                                                            │  │
│  │ 3. 🟡 ROUTINE: Update Vaccinations                        │  │
│  │    Due for flu vaccine                                     │  │
│  │    [Schedule] [Mark Complete]                             │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📅 MONITORING SCHEDULE                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Test/Appointment  │ Frequency  │ Last Done   │ Next Due  │  │
│  ├───────────────────┼────────────┼─────────────┼───────────┤  │
│  │ Spirometry        │ 6 months   │ 2024-07-15  │ OVERDUE   │  │
│  │ AAT Level         │ Annual     │ 2025-01-15  │ 2026-01   │  │
│  │ Pulmonologist     │ Pending referral                      │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💊 MEDICATIONS                                                 │
│  • Albuterol HFA 90 mcg - 2 puffs PRN (Adherence: 95%)         │
│  • Smoking cessation: [Prescribe Now]                           │
│                                                                  │
│  👥 CARE TEAM                                                   │
│  • Primary Care: Dr. Sarah Chen (You)                           │
│  • Pulmonologist: Pending referral                              │
│  • Genetic Counselor: Dr. Michael Torres                        │
│                                                                  │
│  [Update Care Plan] [Send Message] [Order Tests] [View History]│
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 5. Specialist Finder & Referral Matching

**AATD Specialist Directory**:

```typescript
interface AAATDSpecialistProfile {
  providerId: string;
  name: string;
  credentials: string; // 'MD, FCCP'
  specialty: 'Pulmonology' | 'Hepatology' | 'Genetic Counseling';

  // AATD expertise
  aatdExperienceYears: number;
  aatdPatientCount: number;
  boardCertified: boolean;

  // Practice
  practiceName: string;
  address: {
    street: string;
    city: string;
    state: string;
    zip: string;
    latitude: number;
    longitude: number;
  };
  phone: string;

  // Availability
  acceptingNewPatients: boolean;
  avgWaitTimeDays: number;
  insuranceAccepted: string[]; // ['Aetna', 'Blue Cross', 'UnitedHealthcare']
  telemedicineAvailable: boolean;

  // Services
  augmentationTherapyOnsite: boolean; // Can do Prolastin infusions
  languages: string[];

  // Ratings
  avgPatientRating: number; // 0.0 - 5.0
  totalReviews: number;
}

class SpecialistMatchingEngine {
  async findBestMatch(
    patientLocation: { latitude: number; longitude: number },
    specialty: string,
    patientInsurance: string,
    urgency: 'urgent' | 'routine'
  ): Promise<AAATDSpecialistProfile[]> {
    // Query specialists
    let specialists = await this.query(
      `
      SELECT * FROM aatd_specialists
      WHERE specialty = $1
      AND accepting_new_patients = true
      AND $2 = ANY(insurance_accepted)
      ORDER BY
        ST_Distance(location, ST_Point($3, $4)) ASC, -- Closest first
        aatd_patient_count DESC, -- Most experienced
        avg_patient_rating DESC
      LIMIT 10
    `,
      [
        specialty,
        patientInsurance,
        patientLocation.longitude,
        patientLocation.latitude
      ]
    );

    // Filter by wait time if urgent
    if (urgency === 'urgent') {
      specialists = specialists.filter((s) => s.avgWaitTimeDays <= 7);
    }

    // Calculate match score
    return specialists
      .map((specialist) => ({
        ...specialist,
        matchScore: this.calculateMatchScore(
          specialist,
          patientLocation,
          urgency
        ),
        distanceMiles: this.calculateDistance(
          patientLocation,
          specialist.address
        )
      }))
      .sort((a, b) => b.matchScore - a.matchScore);
  }

  calculateMatchScore(
    specialist: AAATDSpecialistProfile,
    patientLocation: any,
    urgency: string
  ): number {
    let score = 0;

    // Distance (closer = better)
    const distance = this.calculateDistance(
      patientLocation,
      specialist.address
    );
    if (distance < 10) score += 50;
    else if (distance < 25) score += 30;
    else if (distance < 50) score += 10;

    // Experience
    score += Math.min(specialist.aatdPatientCount / 10, 30); // Up to +30 for 300+ patients

    // Availability
    if (urgency === 'urgent') {
      if (specialist.avgWaitTimeDays <= 3) score += 20;
      else if (specialist.avgWaitTimeDays <= 7) score += 10;
    }

    // Rating
    score += specialist.avgPatientRating * 4; // Up to +20 for 5-star rating

    // Augmentation therapy onsite (important for ZZ patients)
    if (specialist.augmentationTherapyOnsite) score += 15;

    return score;
  }
}
```

**Referral Flow**:

```
Provider Dashboard → Select Patient → "Refer to Specialist"
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│  🏥 Create Referral for John Doe                            │
│                                                              │
│  Specialty: [Pulmonology ▼]                                 │
│  Reason: [Declining FEV1, MZ carrier, active smoker]        │
│  Urgency: [●] Urgent  [ ] Routine                           │
│                                                              │
│  📍 Find Specialists Near Patient (Denver, CO):             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ 1. Dr. Jennifer Martinez, MD, FCCP                    │  │
│  │    National Jewish Health - Pulmonary Dept            │  │
│  │    🌟 4.9/5 (180 reviews) | 5.2 miles away            │  │
│  │    ✅ AATD Expert (500+ patients)                     │  │
│  │    ✅ Augmentation therapy onsite                     │  │
│  │    ⏱ Avg wait: 5 days | Accepts Aetna                │  │
│  │    [Select This Provider]                             │  │
│  │                                                        │  │
│  │ 2. Dr. Robert Kim, MD                                 │  │
│  │    Denver Lung Institute                              │  │
│  │    🌟 4.7/5 (95 reviews) | 8.1 miles away             │  │
│  │    ✅ AATD Experience (200+ patients)                 │  │
│  │    ⏱ Avg wait: 10 days | Accepts Aetna               │  │
│  │    [Select This Provider]                             │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  Clinical Summary (auto-populated):                         │
│  • MZ genotype, AAT level 65 mg/dL                          │
│  • Active smoker, 20 pack-years                             │
│  • FEV1 declined 85% → 72% over 6 months                    │
│  • No current pulmonary medications                         │
│  [Edit Summary]                                              │
│                                                              │
│  Attach Records:                                             │
│  ☑ Recent spirometry (2024-07-15)                           │
│  ☑ AAT genotype report (2025-01-15)                         │
│  ☑ Chest X-ray (2024-06-01)                                 │
│                                                              │
│  [Send Referral] [Save Draft]                               │
└─────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Clinical Outcomes

- **Guideline Adherence**: 85% of ZZ patients receive guideline-concordant care
- **Smoking Cessation**: 40% quit rate for patients in cessation program (industry: 20-25%)
- **Treatment Adherence**: 30% improvement in augmentation therapy adherence
- **Early Detection**: 50% increase in early-stage COPD diagnosis (FEV1 > 50%)

### Provider Satisfaction

- **PCP Confidence**: 85% of PCPs feel confident managing AATD patients (baseline: 35%)
- **Time Savings**: 45 minutes saved per patient visit (pre-populated care plans)
- **Referral Success**: 90% of referrals result in completed specialist appointment
- **Provider NPS**: 70+ (excellent)

### Patient Outcomes

- **Care Plan Activation**: 65% of patients have active, up-to-date care plans
- **Monitoring Completion**: 80% complete scheduled monitoring on time (baseline: 45%)
- **Specialist Connection**: 75% see appropriate specialist within 30 days of referral
- **Patient Satisfaction**: 4.8/5 stars for care coordination

### Business Impact

- **Telemedicine Revenue**: 60% of care plan patients book consultations ($180K/year)
- **Value-Based Contracts**: Enable 3 new contracts with payers ($500K/year)
- **Competitive Advantage**: Only AATD platform with clinical decision support
- **Partner Retention**: 15% improvement in partner satisfaction

---

## Budget Estimate

### Development (5-6 months)

- **Backend Developer** (care plans, decision engine): $140K/year × 0.5 years = $70,000
- **Frontend Developer** (provider dashboard): $140K/year × 0.42 years = $58,800
- **Clinical Informaticist** (guidelines, algorithms): $130K/year × 0.33 years = $42,900
- **Integration Specialist** (EHR integration): $150K/year × 0.25 years = $37,500

**Total Development**: ~$209,200

### Annual Operations

- **Medical Director** (oversight, guideline updates): $200K/year × 0.25 FTE = $50,000
- **Clinical Coordinator** (care plan management): $75K/year
- **Provider Support** (training, onboarding): $65K/year

**Total Operations**: ~$190,000/year

### Annual Infrastructure

- **Clinical Rules Engine** (commercial license): $12,000/year
- **Specialist Directory API**: $3,600/year
- **Data Storage** (care plans, clinical data): $2,400/year

**Total Infrastructure**: ~$18,000/year

### **GRAND TOTAL (First Year)**: ~$417,200

### **Ongoing (Year 2+)**: ~$208,000/year (operations + infrastructure)

---

## Risks & Mitigations

### Risk 1: Clinical Liability

**Impact**: Incorrect recommendations lead to patient harm, lawsuits
**Mitigation**: Evidence-based guidelines only, medical director oversight, clear disclaimers ("not a substitute for clinical judgment"), malpractice insurance

### Risk 2: Provider Resistance

**Impact**: Physicians don't trust algorithm recommendations
**Mitigation**: Show evidence sources, allow provider override, pilot with champion providers, training on how to use tool

### Risk 3: EHR Integration Complexity

**Impact**: Can't pull clinical data from EMRs, limited utility
**Mitigation**: Start with manual data entry, partner with Epic/Cerner for API access (HL7 FHIR)

### Risk 4: Specialist Network Gaps

**Impact**: No AATD experts in rural areas
**Mitigation**: Telemedicine specialists, regional referral centers, partnership with AlphaNet coordinators

### Risk 5: Medication Adherence Tracking Privacy

**Impact**: Patients uncomfortable reporting missed doses
**Mitigation**: Opt-in only, emphasize benefits ("we can adjust your plan to help you succeed"), no penalties

---

**Document Owner**: Chief Medical Officer, VP Product
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
