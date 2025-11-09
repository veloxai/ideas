# Feature #21B-1: Real-World Evidence (RWE) Generation

**Part of Feature #21: Research Participation Platform (Advanced Data Collection)**

---

## Overview

Real-World Evidence (RWE) refers to clinical evidence derived from routine healthcare data outside traditional clinical trials. For rare diseases like AATD, RWE is **critical** because:

1. **Small populations** - Only ~3,000-5,000 diagnosed Pi\*ZZ patients in US, insufficient for large RCTs
2. **Long disease timelines** - COPD progression takes 10-20 years, impractical for controlled trials
3. **Treatment effectiveness** - Augmentation therapy approved via safety trials, efficacy shown via RWE
4. **Regulatory acceptance** - FDA increasingly accepts RWE for rare disease approvals (21st Century Cures Act)

Fair Underwriting's RWE infrastructure automatically transforms patient data into research-grade evidence by:

- **Continuous data capture** from EHR, claims, wearables, patient reports
- **Comparative effectiveness research** - Treatment A vs. B in real-world settings
- **Natural history characterization** - Disease progression without intervention
- **Safety surveillance** - Detect adverse events post-market
- **Health economics** - Cost-effectiveness, healthcare utilization

---

## RWE Data Sources & Integration

### Multi-Source Data Aggregation

```typescript
interface RealWorldDataStream {
  participantId: string;

  // EHR Data (structured + unstructured)
  ehr: {
    source: 'epic' | 'cerner' | 'allscripts' | 'athenahealth';
    connectionType: 'fhir_api' | 'hl7_v2' | 'ccda_import';
    lastSync: Date;

    structuredData: {
      // Coded data
      diagnoses: { icd10: string; date: Date; source: string }[];
      procedures: { cpt: string; date: Date; provider: string }[];
      medications: { rxnorm: string; startDate: Date; endDate?: Date }[];
      labs: { loinc: string; value: number; unit: string; date: Date }[];
      vitals: { type: string; value: number; date: Date }[];
    };

    unstructuredData: {
      // Clinical notes (NLP extraction)
      progressNotes: { date: Date; text: string; extractedEntities: any[] }[];
      radiology: { date: Date; modality: string; impression: string }[];
      pathology: { date: Date; specimen: string; diagnosis: string }[];
    };
  };

  // Insurance Claims (medical + pharmacy)
  claims: {
    source: 'medicare' | 'commercial_payer' | 'medicaid';
    lastSync: Date;

    medicalClaims: {
      claimId: string;
      serviceDate: Date;
      diagnosisCodes: string[];
      procedureCodes: string[];
      providerType: string;
      claimAmount: number;
      paidAmount: number;
      settingOfCare: 'inpatient' | 'outpatient' | 'emergency' | 'office';
    }[];

    pharmacyClaims: {
      claimId: string;
      fillDate: Date;
      ndc: string; // National Drug Code
      rxnorm: string;
      daysSupply: number;
      quantity: number;
      cost: number;
    }[];
  };

  // Patient-Reported Outcomes
  pro: {
    surveys: {
      surveyType: 'cat' | 'sgrq' | 'sf36' | 'eq5d' | 'exacerbation_diary';
      completedDate: Date;
      responses: any;
      scoreSummary: {
        totalScore: number;
        domainScores?: { [domain: string]: number };
      };
    }[];

    symptoms: {
      date: Date;
      symptomType: string;
      severity: 1 | 2 | 3 | 4 | 5;
      duration: string; // e.g., "3 days"
    }[];
  };

  // Wearables & Home Monitoring
  wearables: {
    homeSpiromter: {
      readings: { date: Date; fev1: number; fvc: number; pef: number }[];
      deviceModel: string;
      compliance: number; // % of expected readings completed
    };

    pulseOximeter: {
      readings: { timestamp: Date; spo2: number; heartRate: number }[];
    };

    activityTracker: {
      dailySteps: { date: Date; steps: number }[];
      sleepData: { date: Date; hours: number; quality: string }[];
    };
  };

  // Social Determinants of Health (SDOH)
  sdoh: {
    residentialHistory: {
      zipCode: string;
      startDate: Date;
      endDate?: Date;
      airQualityIndex: number;
      povertyRate: number;
      healthcareAccessScore: number;
    }[];

    employment: {
      employed: boolean;
      occupation?: string;
      occupationalExposures?: string[];
    };

    insurance: {
      type: 'medicare' | 'medicaid' | 'commercial' | 'uninsured';
      startDate: Date;
      endDate?: Date;
    }[];
  };
}
```

### Data Quality & Validation

```typescript
interface DataQualityMetrics {
  participantId: string;

  // Completeness
  completeness: {
    overall: number; // 0-100%

    bySource: {
      ehr: number;
      claims: number;
      pro: number;
      wearables: number;
    };

    criticalElements: {
      elementName: string;
      required: boolean;
      present: boolean;
      lastUpdated?: Date;
    }[];
  };

  // Timeliness
  timeliness: {
    ehrSyncDelay: number; // Days since last sync
    claimsSyncDelay: number;
    proRecency: number; // Days since last survey
    wearableRecency: number;
  };

  // Consistency
  consistency: {
    crossSourceDiscrepancies: {
      dataElement: string;
      ehrValue: any;
      claimsValue: any;
      discrepancyType: 'date_mismatch' | 'value_mismatch' | 'missing_source';
    }[];
  };

  // Validity
  validity: {
    outliers: {
      dataElement: string;
      value: any;
      expectedRange: { min: any; max: any };
      flaggedDate: Date;
    }[];

    invalidCodes: {
      codeType: 'icd10' | 'cpt' | 'loinc' | 'rxnorm';
      code: string;
      reason: string;
    }[];
  };
}

class DataQualityService {
  async assessDataQuality(participantId: string): Promise<DataQualityMetrics> {
    const participant =
      await this.registryService.getParticipant(participantId);

    // 1. Completeness checks
    const completeness = await this.checkCompleteness(participant);

    // 2. Timeliness checks
    const timeliness = {
      ehrSyncDelay: this.daysSince(participant.dataProvenance.lastEhrSync),
      claimsSyncDelay: this.daysSince(
        participant.dataProvenance.lastClaimsSync
      ),
      proRecency: this.daysSince(participant.researchStatus.lastSurveyDate),
      wearableRecency: this.daysSince(
        participant.dataProvenance.lastWearableSync
      )
    };

    // 3. Consistency checks
    const consistency = await this.checkConsistency(participant);

    // 4. Validity checks
    const validity = await this.checkValidity(participant);

    return {
      participantId,
      completeness,
      timeliness,
      consistency,
      validity
    };
  }

  async checkConsistency(participant: any): Promise<any> {
    const discrepancies = [];

    // Example: Medication discrepancy between EHR and claims
    const ehrMeds = await this.db.query(
      `
      SELECT DISTINCT medication_name, start_date
      FROM ehr_medications
      WHERE participant_id = $1
        AND start_date >= NOW() - INTERVAL '1 year'
    `,
      [participant.participantId]
    );

    const claimsMeds = await this.db.query(
      `
      SELECT DISTINCT drug_name, fill_date
      FROM pharmacy_claims
      WHERE participant_id = $1
        AND fill_date >= NOW() - INTERVAL '1 year'
    `,
      [participant.participantId]
    );

    // Check for medications in EHR but not claims (non-adherence?)
    for (const ehrMed of ehrMeds) {
      const foundInClaims = claimsMeds.some(
        (c) =>
          this.normalizeMedicationName(c.drug_name) ===
          this.normalizeMedicationName(ehrMed.medication_name)
      );

      if (!foundInClaims) {
        discrepancies.push({
          dataElement: 'medication',
          ehrValue: ehrMed.medication_name,
          claimsValue: null,
          discrepancyType: 'missing_source'
        });
      }
    }

    // Example: Diagnosis date discrepancy
    const ehrDiagnosisDate = participant.aatdData?.diagnosisDate;
    const claimsDiagnosisDate = await this.getFirstAATDClaimDate(
      participant.participantId
    );

    if (ehrDiagnosisDate && claimsDiagnosisDate) {
      const daysDiff = Math.abs(
        this.daysBetween(ehrDiagnosisDate, claimsDiagnosisDate)
      );
      if (daysDiff > 90) {
        // >3 months difference
        discrepancies.push({
          dataElement: 'aatd_diagnosis_date',
          ehrValue: ehrDiagnosisDate,
          claimsValue: claimsDiagnosisDate,
          discrepancyType: 'date_mismatch'
        });
      }
    }

    return { crossSourceDiscrepancies: discrepancies };
  }

  async checkValidity(participant: any): Promise<any> {
    const outliers = [];
    const invalidCodes = [];

    // Outlier detection: FEV1 values
    const spirometry = await this.db.query(
      `
      SELECT test_date, pre_fev1_percent
      FROM registry_spirometry
      WHERE participant_id = $1
      ORDER BY test_date DESC
      LIMIT 10
    `,
      [participant.participantId]
    );

    for (const reading of spirometry) {
      // FEV1% should be 0-150% (>150% likely data entry error)
      if (reading.pre_fev1_percent < 0 || reading.pre_fev1_percent > 150) {
        outliers.push({
          dataElement: 'fev1_percent',
          value: reading.pre_fev1_percent,
          expectedRange: { min: 0, max: 150 },
          flaggedDate: reading.test_date
        });
      }

      // Check for implausible rapid changes (>20% in <6 months without transplant)
      if (spirometry.length > 1) {
        const previous = spirometry[1];
        const change = Math.abs(
          reading.pre_fev1_percent - previous.pre_fev1_percent
        );
        const daysDiff = this.daysBetween(
          previous.test_date,
          reading.test_date
        );

        if (
          change > 20 &&
          daysDiff < 180 &&
          !participant.treatments?.transplant?.received
        ) {
          outliers.push({
            dataElement: 'fev1_percent_change',
            value: change,
            expectedRange: { min: -20, max: 20 },
            flaggedDate: reading.test_date
          });
        }
      }
    }

    // Invalid code detection: ICD-10 codes
    const diagnoses = await this.db.query(
      `
      SELECT DISTINCT icd10_code
      FROM ehr_diagnoses
      WHERE participant_id = $1
    `,
      [participant.participantId]
    );

    for (const dx of diagnoses) {
      const isValid = await this.validateICD10Code(dx.icd10_code);
      if (!isValid) {
        invalidCodes.push({
          codeType: 'icd10',
          code: dx.icd10_code,
          reason: 'Invalid or deprecated code'
        });
      }
    }

    return { outliers, invalidCodes };
  }
}
```

---

## Comparative Effectiveness Research (CER)

### Propensity Score Matching

```typescript
interface ComparativeEffectivenessStudy {
  studyId: string;
  title: string;

  // Research question
  question: string; // e.g., "Does augmentation therapy reduce exacerbation rates?"

  // Treatment groups
  treatmentGroup: {
    name: string; // e.g., "Augmentation Therapy"
    definition: CohortQuery; // Eligibility criteria
    participants: string[]; // Participant IDs
  };

  controlGroup: {
    name: string; // e.g., "Standard Care Only"
    definition: CohortQuery;
    participants: string[];
  };

  // Confounding variables to adjust for
  confounders: string[]; // e.g., ["age", "fev1_baseline", "smoking_status", "exacerbation_history"]

  // Outcome measures
  primaryOutcome: {
    name: string; // e.g., "Exacerbation Rate"
    definition: string;
    measurementUnit: string;
  };

  secondaryOutcomes: {
    name: string;
    definition: string;
  }[];

  // Follow-up period
  followUpMonths: number;

  // Statistical method
  method:
    | 'propensity_score_matching'
    | 'inverse_probability_weighting'
    | 'regression_adjustment';
}

class ComparativeEffectivenessService {
  async conductCER(study: ComparativeEffectivenessStudy): Promise<CERResults> {
    // 1. Identify eligible participants
    const treatmentParticipants = await this.cohortBuilder.buildCohort(
      study.treatmentGroup.definition
    );

    const controlParticipants = await this.cohortBuilder.buildCohort(
      study.controlGroup.definition
    );

    // 2. Calculate propensity scores
    const propensityScores = await this.calculatePropensityScores(
      treatmentParticipants.participants,
      controlParticipants.participants,
      study.confounders
    );

    // 3. Perform matching
    const matchedPairs =
      await this.performPropensityScoreMatching(propensityScores);

    // 4. Check balance (are matched groups similar on confounders?)
    const balanceCheck = await this.checkBalance(
      matchedPairs,
      study.confounders
    );

    // 5. Measure outcomes
    const treatmentOutcomes = await this.measureOutcomes(
      matchedPairs.map((p) => p.treatmentId),
      study.primaryOutcome,
      study.followUpMonths
    );

    const controlOutcomes = await this.measureOutcomes(
      matchedPairs.map((p) => p.controlId),
      study.primaryOutcome,
      study.followUpMonths
    );

    // 6. Statistical comparison
    const comparison = await this.compareOutcomes(
      treatmentOutcomes,
      controlOutcomes
    );

    return {
      studyId: study.studyId,
      treatmentGroupSize: matchedPairs.length,
      controlGroupSize: matchedPairs.length,
      balanceCheck,
      primaryOutcome: {
        treatmentMean: comparison.treatmentMean,
        controlMean: comparison.controlMean,
        difference: comparison.difference,
        pValue: comparison.pValue,
        confidenceInterval: comparison.confidenceInterval,
        effectSize: comparison.effectSize
      },
      secondaryOutcomes: []
    };
  }

  async calculatePropensityScores(
    treatmentParticipants: any[],
    controlParticipants: any[],
    confounders: string[]
  ): Promise<PropensityScore[]> {
    // Combine both groups
    const allParticipants = [
      ...treatmentParticipants.map((p) => ({ ...p, treated: 1 })),
      ...controlParticipants.map((p) => ({ ...p, treated: 0 }))
    ];

    // Extract confounder values
    const features = allParticipants.map((p) => ({
      participantId: p.participantId,
      treated: p.treated,
      age: this.calculateAge(p.demographics.dateOfBirth),
      fev1_baseline:
        p.clinicalStatus?.lungDisease?.lastSpirometry?.fev1_percent,
      smoking_status: p.lifestyle?.smokingStatus === 'current' ? 1 : 0,
      pack_years: p.lifestyle?.packYears || 0,
      exacerbation_history:
        p.clinicalStatus?.lungDisease?.exacerbationsPerYear || 0,
      bmi: p.vitals?.bmi || 25,
      comorbidities: p.comorbidities?.length || 0
    }));

    // Logistic regression: P(treated=1 | confounders)
    const propensityModel = await this.mlModel.train('logistic_regression', {
      features: features.map((f) => [
        f.age,
        f.fev1_baseline,
        f.smoking_status,
        f.pack_years,
        f.exacerbation_history,
        f.bmi,
        f.comorbidities
      ]),
      labels: features.map((f) => f.treated)
    });

    // Calculate propensity scores
    const propensityScores = features.map((f) => ({
      participantId: f.participantId,
      treated: f.treated === 1,
      propensityScore: propensityModel.predict([
        f.age,
        f.fev1_baseline,
        f.smoking_status,
        f.pack_years,
        f.exacerbation_history,
        f.bmi,
        f.comorbidities
      ])[0]
    }));

    return propensityScores;
  }

  async performPropensityScoreMatching(
    propensityScores: PropensityScore[]
  ): Promise<MatchedPair[]> {
    const treated = propensityScores.filter((p) => p.treated);
    const control = propensityScores.filter((p) => !p.treated);

    const matchedPairs: MatchedPair[] = [];
    const usedControls = new Set<string>();

    // Greedy nearest-neighbor matching with caliper
    const caliper = 0.1; // Maximum propensity score difference

    for (const treatedParticipant of treated) {
      // Find closest control within caliper
      let bestMatch: PropensityScore | null = null;
      let minDifference = Infinity;

      for (const controlParticipant of control) {
        if (usedControls.has(controlParticipant.participantId)) continue;

        const difference = Math.abs(
          treatedParticipant.propensityScore -
            controlParticipant.propensityScore
        );

        if (difference < minDifference && difference <= caliper) {
          minDifference = difference;
          bestMatch = controlParticipant;
        }
      }

      if (bestMatch) {
        matchedPairs.push({
          treatmentId: treatedParticipant.participantId,
          controlId: bestMatch.participantId,
          propensityScoreDifference: minDifference
        });
        usedControls.add(bestMatch.participantId);
      }
    }

    return matchedPairs;
  }

  async checkBalance(
    matchedPairs: MatchedPair[],
    confounders: string[]
  ): Promise<BalanceCheck> {
    // After matching, check if treatment and control groups are balanced on confounders
    const treatmentData = await this.getParticipantData(
      matchedPairs.map((p) => p.treatmentId)
    );
    const controlData = await this.getParticipantData(
      matchedPairs.map((p) => p.controlId)
    );

    const balanceMetrics = [];

    for (const confounder of confounders) {
      const treatmentValues = treatmentData.map((p) =>
        this.extractConfounderValue(p, confounder)
      );
      const controlValues = controlData.map((p) =>
        this.extractConfounderValue(p, confounder)
      );

      // Calculate standardized mean difference (SMD)
      const treatmentMean = this.mean(treatmentValues);
      const controlMean = this.mean(controlValues);
      const pooledStdDev = Math.sqrt(
        (this.variance(treatmentValues) + this.variance(controlValues)) / 2
      );

      const smd = (treatmentMean - controlMean) / pooledStdDev;

      balanceMetrics.push({
        confounder,
        treatmentMean,
        controlMean,
        standardizedMeanDifference: smd,
        balanced: Math.abs(smd) < 0.1 // Threshold: |SMD| < 0.1 indicates good balance
      });
    }

    const allBalanced = balanceMetrics.every((m) => m.balanced);

    return {
      balanced: allBalanced,
      metrics: balanceMetrics
    };
  }

  async measureOutcomes(
    participantIds: string[],
    outcome: { name: string; definition: string; measurementUnit: string },
    followUpMonths: number
  ): Promise<OutcomeMeasurement[]> {
    const measurements: OutcomeMeasurement[] = [];

    for (const participantId of participantIds) {
      let outcomeValue: number;

      // Example: Exacerbation rate
      if (outcome.name === 'Exacerbation Rate') {
        const exacerbations = await this.db.query(
          `
          SELECT COUNT(*) AS count
          FROM registry_exacerbations
          WHERE participant_id = $1
            AND event_date >= NOW() - INTERVAL '${followUpMonths} months'
        `,
          [participantId]
        );

        outcomeValue = exacerbations[0].count / (followUpMonths / 12); // Annualized rate
      }

      // Example: FEV1 decline rate
      else if (outcome.name === 'FEV1 Decline Rate') {
        outcomeValue = await this.calculateFEV1DeclineRate(
          participantId,
          followUpMonths
        );
      }

      measurements.push({
        participantId,
        outcomeValue
      });
    }

    return measurements;
  }

  async compareOutcomes(
    treatmentOutcomes: OutcomeMeasurement[],
    controlOutcomes: OutcomeMeasurement[]
  ): Promise<OutcomeComparison> {
    const treatmentValues = treatmentOutcomes.map((o) => o.outcomeValue);
    const controlValues = controlOutcomes.map((o) => o.outcomeValue);

    const treatmentMean = this.mean(treatmentValues);
    const controlMean = this.mean(controlValues);
    const difference = treatmentMean - controlMean;

    // t-test
    const tTestResult = this.tTest(treatmentValues, controlValues);

    // Effect size (Cohen's d)
    const pooledStdDev = Math.sqrt(
      (this.variance(treatmentValues) + this.variance(controlValues)) / 2
    );
    const effectSize = difference / pooledStdDev;

    return {
      treatmentMean,
      controlMean,
      difference,
      pValue: tTestResult.pValue,
      confidenceInterval: tTestResult.confidenceInterval,
      effectSize
    };
  }
}
```

### Example Study: Augmentation Therapy Effectiveness

```typescript
const augmentationEffectivenessStudy: ComparativeEffectivenessStudy = {
  studyId: 'cer-001',
  title: 'Real-World Effectiveness of Alpha-1 Antitrypsin Augmentation Therapy',

  question:
    'Does augmentation therapy reduce exacerbation rates and slow FEV₁ decline in Pi*ZZ patients with COPD?',

  treatmentGroup: {
    name: 'Augmentation Therapy',
    definition: {
      name: 'Augmentation Cohort',
      inclusion: {
        phenotypes: ['ZZ'],
        fev1PercentRange: { min: 30, max: 80 },
        onAugmentationTherapy: true,
        augmentationDuration: { min: 12, max: 120 } // 1-10 years
      }
    },
    participants: []
  },

  controlGroup: {
    name: 'Standard Care Only',
    definition: {
      name: 'Standard Care Cohort',
      inclusion: {
        phenotypes: ['ZZ'],
        fev1PercentRange: { min: 30, max: 80 },
        onAugmentationTherapy: false
      }
    },
    participants: []
  },

  confounders: [
    'age',
    'fev1_baseline',
    'smoking_status',
    'pack_years',
    'exacerbation_history',
    'bmi',
    'comorbidities'
  ],

  primaryOutcome: {
    name: 'Exacerbation Rate',
    definition:
      'Annualized rate of moderate-to-severe exacerbations requiring antibiotics, steroids, or hospitalization',
    measurementUnit: 'events per year'
  },

  secondaryOutcomes: [
    {
      name: 'FEV₁ Decline Rate',
      definition:
        'Change in FEV₁ (ml/year) measured via linear mixed-effects model'
    },
    {
      name: 'Hospitalization Rate',
      definition: 'Annualized rate of COPD-related hospitalizations'
    },
    {
      name: 'Quality of Life',
      definition: 'Change in SGRQ total score from baseline'
    }
  ],

  followUpMonths: 36, // 3 years

  method: 'propensity_score_matching'
};
```

---

## Safety Surveillance

### Adverse Event Detection

```typescript
interface AdverseEventSignal {
  eventType: string; // e.g., "Infusion reaction", "Liver enzyme elevation"

  // Detection method
  detectionMethod:
    | 'claims_based'
    | 'ehr_based'
    | 'patient_reported'
    | 'lab_based';

  // Event details
  affectedParticipants: string[];
  incidenceRate: number; // Events per 100 person-years

  // Risk factors
  riskFactors: {
    factor: string;
    oddsRatio: number;
    confidenceInterval: [number, number];
    pValue: number;
  }[];

  // Temporal pattern
  temporalPattern: {
    timeToOnset: { mean: number; median: number; range: [number, number] }; // Days from treatment start
    seasonal: boolean;
  };

  // Severity
  severity: 'mild' | 'moderate' | 'severe' | 'life_threatening';

  // Comparison to known baseline
  expectedRate?: number; // Background rate in general population
  observedVsExpectedRatio?: number; // Signal strength

  flaggedDate: Date;
}

class SafetySurveillanceService {
  async detectAdverseEvents(
    treatmentType: string
  ): Promise<AdverseEventSignal[]> {
    const signals: AdverseEventSignal[] = [];

    // Get participants on treatment
    const treatedParticipants = await this.db.query(`
      SELECT rp.id, rp.user_id, rp.treatments
      FROM registry_participants rp
      WHERE
        (rp.treatments->'augmentationTherapy'->>'currentlyOn')::boolean = true
        AND rp.treatments->'augmentationTherapy'->>'startDate' >= NOW() - INTERVAL '5 years'
    `);

    // 1. Claims-based detection: Look for ER visits, hospitalizations
    const claimsSignals =
      await this.detectClaimsBasedEvents(treatedParticipants);
    signals.push(...claimsSignals);

    // 2. EHR-based detection: Look for new diagnoses, abnormal labs
    const ehrSignals = await this.detectEHRBasedEvents(treatedParticipants);
    signals.push(...ehrSignals);

    // 3. Patient-reported detection: Surveys, symptom reports
    const patientSignals =
      await this.detectPatientReportedEvents(treatedParticipants);
    signals.push(...patientSignals);

    // 4. Lab-based detection: Abnormal results
    const labSignals = await this.detectLabBasedEvents(treatedParticipants);
    signals.push(...labSignals);

    return signals;
  }

  async detectLabBasedEvents(
    participants: any[]
  ): Promise<AdverseEventSignal[]> {
    const signals: AdverseEventSignal[] = [];

    // Example: Liver enzyme elevation (ALT >3x ULN)
    const elevatedALT = await this.db.query(`
      SELECT
        rp.id AS participant_id,
        el.test_date,
        el.alt_value,
        rp.treatments->'augmentationTherapy'->>'startDate' AS treatment_start_date
      FROM registry_participants rp
      JOIN ehr_labs el ON rp.id = el.participant_id
      WHERE
        (rp.treatments->'augmentationTherapy'->>'currentlyOn')::boolean = true
        AND el.test_name = 'ALT'
        AND el.alt_value > 120  -- >3x ULN (assuming ULN = 40)
        AND el.test_date >= (rp.treatments->'augmentationTherapy'->>'startDate')::DATE
    `);

    if (elevatedALT.length > 0) {
      // Calculate incidence rate
      const personYears = this.calculatePersonYears(participants);
      const incidenceRate = (elevatedALT.length / personYears) * 100;

      // Time to onset
      const timesToOnset = elevatedALT.map((e) =>
        this.daysBetween(e.treatment_start_date, e.test_date)
      );

      signals.push({
        eventType: 'Liver Enzyme Elevation (ALT >3x ULN)',
        detectionMethod: 'lab_based',
        affectedParticipants: elevatedALT.map((e) => e.participant_id),
        incidenceRate,
        riskFactors: await this.identifyRiskFactors(
          elevatedALT,
          participants,
          'elevated_alt'
        ),
        temporalPattern: {
          timeToOnset: {
            mean: this.mean(timesToOnset),
            median: this.median(timesToOnset),
            range: [Math.min(...timesToOnset), Math.max(...timesToOnset)]
          },
          seasonal: false
        },
        severity: 'moderate',
        expectedRate: 2.0, // Background rate: 2 per 100 person-years
        observedVsExpectedRatio: incidenceRate / 2.0,
        flaggedDate: new Date()
      });
    }

    return signals;
  }

  async identifyRiskFactors(
    events: any[],
    allParticipants: any[],
    eventType: string
  ): Promise<any[]> {
    // Case-control analysis to identify risk factors
    const cases = events.map((e) => e.participant_id);
    const controls = allParticipants
      .filter((p) => !cases.includes(p.id))
      .slice(0, cases.length * 3); // 1:3 matching

    // Extract potential risk factors
    const riskFactors = [];

    // Age
    const caseAges = cases.map((id) =>
      this.calculateAge(
        allParticipants.find((p) => p.id === id).demographics.dateOfBirth
      )
    );
    const controlAges = controls.map((p) =>
      this.calculateAge(p.demographics.dateOfBirth)
    );
    const ageOddsRatio = this.calculateOddsRatio(caseAges, controlAges, 60); // Age >60
    if (ageOddsRatio.significant) {
      riskFactors.push({
        factor: 'Age >60',
        oddsRatio: ageOddsRatio.or,
        confidenceInterval: ageOddsRatio.ci,
        pValue: ageOddsRatio.pValue
      });
    }

    // Alcohol use
    const caseAlcohol = cases.filter(
      (id) =>
        allParticipants.find((p) => p.id === id).lifestyle?.alcoholUse ===
        'heavy'
    ).length;
    const controlAlcohol = controls.filter(
      (p) => p.lifestyle?.alcoholUse === 'heavy'
    ).length;
    const alcoholOR = this.calculateOddsRatio(
      [caseAlcohol],
      [controlAlcohol],
      1
    );
    if (alcoholOR.significant) {
      riskFactors.push({
        factor: 'Heavy Alcohol Use',
        oddsRatio: alcoholOR.or,
        confidenceInterval: alcoholOR.ci,
        pValue: alcoholOR.pValue
      });
    }

    return riskFactors;
  }
}
```

---

## Health Economics & Outcomes Research (HEOR)

### Cost-Effectiveness Analysis

```typescript
interface CostEffectivenessAnalysis {
  analysisId: string;
  title: string;

  // Comparators
  intervention: {
    name: string;
    cohort: string[];
  };

  comparator: {
    name: string;
    cohort: string[];
  };

  // Time horizon
  timeHorizonYears: number;

  // Costs
  costs: {
    intervention: {
      treatmentCost: number; // Per patient per year
      medicalCost: number; // Hospitalizations, ER, etc.
      indirectCost: number; // Lost productivity
      totalCost: number;
    };

    comparator: {
      treatmentCost: number;
      medicalCost: number;
      indirectCost: number;
      totalCost: number;
    };

    incrementalCost: number; // Intervention - Comparator
  };

  // Outcomes (QALYs)
  outcomes: {
    intervention: {
      lifeYears: number;
      qualityAdjustment: number; // 0-1
      qalys: number;
    };

    comparator: {
      lifeYears: number;
      qualityAdjustment: number;
      qalys: number;
    };

    incrementalQALYs: number;
  };

  // Result
  icer: number; // Incremental Cost-Effectiveness Ratio ($/QALY)
  costEffective: boolean; // ICER < $150,000/QALY threshold
}

class HealthEconomicsService {
  async conductCostEffectivenessAnalysis(
    interventionCohort: string[],
    comparatorCohort: string[],
    timeHorizonYears: number
  ): Promise<CostEffectivenessAnalysis> {
    // 1. Calculate costs for intervention group
    const interventionCosts = await this.calculateCosts(
      interventionCohort,
      timeHorizonYears
    );

    // 2. Calculate costs for comparator group
    const comparatorCosts = await this.calculateCosts(
      comparatorCohort,
      timeHorizonYears
    );

    // 3. Calculate QALYs for intervention group
    const interventionQALYs = await this.calculateQALYs(
      interventionCohort,
      timeHorizonYears
    );

    // 4. Calculate QALYs for comparator group
    const comparatorQALYs = await this.calculateQALYs(
      comparatorCohort,
      timeHorizonYears
    );

    // 5. Calculate ICER
    const incrementalCost =
      interventionCosts.totalCost - comparatorCosts.totalCost;
    const incrementalQALYs = interventionQALYs.qalys - comparatorQALYs.qalys;
    const icer = incrementalCost / incrementalQALYs;

    return {
      analysisId: uuidv4(),
      title: 'Cost-Effectiveness of Augmentation Therapy',
      intervention: {
        name: 'Augmentation Therapy + Standard Care',
        cohort: interventionCohort
      },
      comparator: {
        name: 'Standard Care Only',
        cohort: comparatorCohort
      },
      timeHorizonYears,
      costs: {
        intervention: interventionCosts,
        comparator: comparatorCosts,
        incrementalCost
      },
      outcomes: {
        intervention: interventionQALYs,
        comparator: comparatorQALYs,
        incrementalQALYs
      },
      icer,
      costEffective: icer < 150000 // WTP threshold
    };
  }

  async calculateCosts(
    cohort: string[],
    timeHorizonYears: number
  ): Promise<any> {
    let treatmentCost = 0;
    let medicalCost = 0;
    let indirectCost = 0;

    for (const participantId of cohort) {
      const participant =
        await this.registryService.getParticipant(participantId);

      // Treatment cost (augmentation therapy = ~$100k/year)
      if (participant.treatments?.augmentationTherapy?.currentlyOn) {
        treatmentCost += 100000 * timeHorizonYears;
      }

      // Medical costs from claims
      const claims = await this.db.query(
        `
        SELECT SUM(paid_amount) AS total
        FROM medical_claims
        WHERE
          participant_id = $1
          AND service_date >= NOW() - INTERVAL '${timeHorizonYears} years'
      `,
        [participantId]
      );
      medicalCost += claims[0]?.total || 0;

      // Indirect costs (lost productivity)
      const employed = participant.employment?.employed;
      const exacerbationsPerYear =
        participant.clinicalStatus?.lungDisease?.exacerbationsPerYear || 0;
      if (employed) {
        // Each exacerbation = ~10 days lost work = $2,000
        indirectCost += exacerbationsPerYear * 2000 * timeHorizonYears;
      }
    }

    // Per-patient averages
    const n = cohort.length;
    return {
      treatmentCost: treatmentCost / n,
      medicalCost: medicalCost / n,
      indirectCost: indirectCost / n,
      totalCost: (treatmentCost + medicalCost + indirectCost) / n
    };
  }

  async calculateQALYs(
    cohort: string[],
    timeHorizonYears: number
  ): Promise<any> {
    let totalLifeYears = 0;
    let totalQualityAdjustment = 0;

    for (const participantId of cohort) {
      const participant =
        await this.registryService.getParticipant(participantId);

      // Life years (assume survival for time horizon - simplified)
      const survived = timeHorizonYears; // In reality, use survival models
      totalLifeYears += survived;

      // Quality adjustment from EQ-5D or SF-36
      const qualityOfLife = await this.getAverageQualityOfLife(
        participantId,
        timeHorizonYears
      );
      totalQualityAdjustment += qualityOfLife; // 0-1 scale
    }

    const n = cohort.length;
    const avgLifeYears = totalLifeYears / n;
    const avgQualityAdjustment = totalQualityAdjustment / n;
    const qalys = avgLifeYears * avgQualityAdjustment;

    return {
      lifeYears: avgLifeYears,
      qualityAdjustment: avgQualityAdjustment,
      qalys
    };
  }

  async getAverageQualityOfLife(
    participantId: string,
    timeHorizonYears: number
  ): Promise<number> {
    // Extract EQ-5D scores from surveys
    const surveys = await this.db.query(
      `
      SELECT score_summary->>'eq5d_index' AS eq5d_score
      FROM pro_surveys
      WHERE
        participant_id = $1
        AND survey_type = 'eq5d'
        AND completed_date >= NOW() - INTERVAL '${timeHorizonYears} years'
      ORDER BY completed_date
    `,
      [participantId]
    );

    if (surveys.length > 0) {
      const scores = surveys
        .map((s) => parseFloat(s.eq5d_score))
        .filter((s) => !isNaN(s));
      return this.mean(scores);
    }

    // If no EQ-5D, estimate from SGRQ
    const sgrqSurveys = await this.db.query(
      `
      SELECT score_summary->>'totalScore' AS sgrq_score
      FROM pro_surveys
      WHERE
        participant_id = $1
        AND survey_type = 'sgrq'
        AND completed_date >= NOW() - INTERVAL '${timeHorizonYears} years'
      ORDER BY completed_date
    `,
      [participantId]
    );

    if (sgrqSurveys.length > 0) {
      const avgSGRQ = this.mean(
        sgrqSurveys.map((s) => parseFloat(s.sgrq_score))
      );
      // Convert SGRQ (0-100, higher = worse) to utility (0-1, higher = better)
      return 1 - avgSGRQ / 100;
    }

    // Default: moderate quality of life
    return 0.65;
  }
}
```

---

## Budget & Success Metrics

### Development Costs (4-5 months)

- **Data Engineer** (multi-source integration, ETL pipelines): $150K/year × 0.42 = $63,000
- **Backend Developer** (CER, safety surveillance APIs): $140K/year × 0.42 = $58,800
- **Biostatistician** (propensity scoring, HEOR models): $160K/year × 0.42 = $67,200
- **Health Economist** (cost-effectiveness models): $150K/year × 0.25 = $37,500
- **Data Scientist** (adverse event detection, ML models): $160K/year × 0.33 = $52,800

**Total**: ~$279,300

### Annual Operations

- **Data Integration** (EHR, claims connectors): $30,000/year
- **NLP Services** (clinical note extraction): $20,000/year
- **Statistical Computing** (propensity matching, ML): $15,000/year
- **Adverse Event Monitoring**: $25,000/year

**Total**: ~$90,000/year

### Success Metrics

**Data Integration**

- Multi-source data completeness: >85% (EHR + claims + PRO + wearables)
- Sync latency: <48 hours for EHR/claims data
- Data quality score: >90%

**Comparative Effectiveness Research**

- CER studies per year: 3-5 studies
- Publication rate: 80% of studies result in peer-reviewed publications
- Time to publication: 18-24 months (vs. 36-48 months traditional RCTs)

**Safety Surveillance**

- Adverse event detection: Identify signals 6-12 months earlier than traditional pharmacovigilance
- False positive rate: <10%
- Sensitivity: >85% (detect real signals)

**Health Economics**

- Cost-effectiveness analyses: 2-3 per year
- Influence policy: 50% of analyses inform payer coverage decisions
- Cost per analysis: $50,000 (vs. $200,000 traditional HEOR study)

---

**Document Status:** Complete
**Next Document:** MISSING_FEATURES_21B2_PATIENT_REPORTED_OUTCOMES.md
