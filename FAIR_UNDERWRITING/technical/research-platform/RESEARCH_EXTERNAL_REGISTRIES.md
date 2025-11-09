# Feature #21C-2: External Registry Integration

**Part of Feature #21: Research Participation Platform (Research Federation)**

---

## Overview

Multiple AATD patient registries exist worldwide, each capturing unique patient populations and data types:

1. **AlphaNet Disease Management Program** (US) - 5,000+ patients, quarterly health surveys, augmentation therapy tracking
2. **Alpha-1 Foundation Research Registry** (US) - 3,500+ patients, research-focused, genetic data emphasis
3. **UK Alpha-1 Antitrypsin Deficiency Registry** - 1,200+ patients, NHS-integrated
4. **European AATD Registry (EARCO)** - 2,000+ patients, 15 countries, standardized protocols

**Current challenges:**

- **Fragmentation** - Researchers must negotiate separate access to each registry
- **Duplication** - Patients enrolled in multiple registries, inconsistent data
- **Incompatibility** - Different data models, vocabularies, collection schedules
- **Inefficiency** - Manual data requests, 3-6 month turnaround, custom ETL per registry

**Fair Underwriting's integration strategy:**

- **Bidirectional sync** - Patients can share data to/from external registries
- **Automated data exchange** - HL7 FHIR, OMOP CDM, CSV/API formats
- **Consent management** - Granular control over which registries receive data
- **De-duplication** - Identify overlapping enrollments across registries
- **Unified researcher view** - Query across all connected registries simultaneously

---

## AlphaNet Integration

### AlphaNet Disease Management Program

AlphaNet is the largest US AATD registry with 5,000+ active participants. Integration enables:

- **Data exchange** - Share Fair Underwriting spirometry/PRO data → AlphaNet; receive AlphaNet survey data ← Fair Underwriting
- **Research recruitment** - AlphaNet participants can opt into Fair Underwriting studies
- **Augmentation therapy tracking** - Sync infusion dates, dosing, adherence

```typescript
interface AlphaNetConnection {
  connectionId: string;
  participantId: string; // Fair Underwriting ID
  alphaNetId: string; // AlphaNet member ID

  // Consent
  consentDate: Date;
  consentExpiration: Date;
  dataFlowDirection: 'to_alphanet' | 'from_alphanet' | 'bidirectional';

  // Data sharing preferences
  sharedDataTypes: {
    spirometry: boolean;
    proSurveys: boolean;
    exacerbations: boolean;
    augmentationTherapy: boolean;
    geneticData: boolean;
  };

  // Sync status
  lastSyncToAlphaNet?: Date;
  lastSyncFromAlphaNet?: Date;
  syncFrequency: 'realtime' | 'daily' | 'weekly' | 'monthly';

  status: 'active' | 'paused' | 'revoked';
  created_at: Date;
}

class AlphaNetIntegrationService {
  private alphaNetApiUrl = 'https://api.alphanet.org/v2';
  private apiKey = process.env.ALPHANET_API_KEY;

  async connectParticipant(
    participantId: string,
    alphaNetId: string,
    consent: any
  ): Promise<AlphaNetConnection> {
    // 1. Verify AlphaNet ID
    const alphaNetPatient = await this.verifyAlphaNetId(alphaNetId);

    // 2. Check for existing connection (prevent duplicates)
    const existing = await this.db.queryOne(
      `
      SELECT * FROM alphanet_connections
      WHERE participant_id = $1 OR alphanet_id = $2
    `,
      [participantId, alphaNetId]
    );

    if (existing) {
      throw new Error('Connection already exists');
    }

    // 3. Create connection record
    const connection: AlphaNetConnection = {
      connectionId: uuidv4(),
      participantId,
      alphaNetId,
      consentDate: consent.signedDate,
      consentExpiration: new Date(
        consent.signedDate.getTime() + 365 * 24 * 60 * 60 * 1000
      ), // 1 year
      dataFlowDirection: consent.dataFlowDirection,
      sharedDataTypes: consent.sharedDataTypes,
      syncFrequency: 'daily',
      status: 'active',
      created_at: new Date()
    };

    await this.db.insert('alphanet_connections', connection);

    // 4. Initial data sync
    if (
      connection.dataFlowDirection === 'bidirectional' ||
      connection.dataFlowDirection === 'from_alphanet'
    ) {
      await this.syncFromAlphaNet(connection.connectionId);
    }

    if (
      connection.dataFlowDirection === 'bidirectional' ||
      connection.dataFlowDirection === 'to_alphanet'
    ) {
      await this.syncToAlphaNet(connection.connectionId);
    }

    return connection;
  }

  async syncToAlphaNet(connectionId: string): Promise<void> {
    const connection = await this.db.findById(
      'alphanet_connections',
      connectionId
    );
    const participant = await this.registryService.getParticipant(
      connection.participantId
    );

    // Collect data to share based on preferences
    const dataPackage: any = {
      member_id: connection.alphaNetId,
      data_source: 'Fair Underwriting',
      sync_date: new Date().toISOString()
    };

    // Spirometry data
    if (connection.sharedDataTypes.spirometry) {
      const spirometry = await this.db.query(
        `
        SELECT timestamp, fev1, fvc, pef
        FROM spirometer_readings
        WHERE participant_id = $1
          AND timestamp > $2
        ORDER BY timestamp DESC
        LIMIT 100
      `,
        [
          connection.participantId,
          connection.lastSyncToAlphaNet || new Date('2000-01-01')
        ]
      );

      dataPackage.spirometry = spirometry.map((s) => ({
        date: s.timestamp.toISOString().split('T')[0],
        fev1_ml: s.fev1.value,
        fvc_ml: s.fvc.value,
        pef_lmin: s.pef.value
      }));
    }

    // PRO surveys
    if (connection.sharedDataTypes.proSurveys) {
      const proResponses = await this.db.query(
        `
        SELECT instrument_id, completed_at, score_summary
        FROM pro_survey_responses
        WHERE participant_id = $1
          AND completed_at > $2
      `,
        [
          connection.participantId,
          connection.lastSyncToAlphaNet || new Date('2000-01-01')
        ]
      );

      dataPackage.surveys = proResponses.map((p) => ({
        survey_type: p.instrument_id,
        date: p.completed_at.toISOString().split('T')[0],
        score: p.score_summary.totalScore
      }));
    }

    // Exacerbations
    if (connection.sharedDataTypes.exacerbations) {
      const exacerbations = await this.db.query(
        `
        SELECT onset_date, severity, treatment
        FROM exacerbations
        WHERE participant_id = $1
          AND onset_date > $2
      `,
        [
          connection.participantId,
          connection.lastSyncToAlphaNet || new Date('2000-01-01')
        ]
      );

      dataPackage.exacerbations = exacerbations.map((e) => ({
        date: e.onset_date.toISOString().split('T')[0],
        severity: e.severity,
        treatment: e.treatment
      }));
    }

    // Send to AlphaNet API
    try {
      await axios.post(
        `${this.alphaNetApiUrl}/data-exchange/import`,
        dataPackage,
        {
          headers: {
            Authorization: `Bearer ${this.apiKey}`,
            'Content-Type': 'application/json'
          }
        }
      );

      // Update last sync timestamp
      await this.db.update('alphanet_connections', connectionId, {
        last_sync_to_alphanet: new Date()
      });

      console.log(`Synced data to AlphaNet for connection ${connectionId}`);
    } catch (error) {
      console.error(`AlphaNet sync failed: ${error.message}`);
      throw error;
    }
  }

  async syncFromAlphaNet(connectionId: string): Promise<void> {
    const connection = await this.db.findById(
      'alphanet_connections',
      connectionId
    );

    // Fetch data from AlphaNet API
    const response = await axios.get(
      `${this.alphaNetApiUrl}/data-exchange/export/${connection.alphaNetId}`,
      {
        params: {
          since: connection.lastSyncFromAlphaNet?.toISOString() || '2000-01-01'
        },
        headers: {
          Authorization: `Bearer ${this.apiKey}`
        }
      }
    );

    const alphaNetData = response.data;

    // Import quarterly health surveys
    if (alphaNetData.health_surveys) {
      for (const survey of alphaNetData.health_surveys) {
        await this.db.insert('alphanet_health_surveys', {
          surveyId: uuidv4(),
          participantId: connection.participantId,
          alphaNetSurveyId: survey.id,
          surveyDate: new Date(survey.date),

          // Map AlphaNet survey fields to our schema
          respiratory_status: survey.respiratory_status,
          exacerbations_last_3_months: survey.exacerbations_count,
          hospitalizations_last_3_months: survey.hospitalizations_count,
          current_medications: survey.medications,
          quality_of_life_score: survey.qol_score,

          imported_at: new Date()
        });
      }
    }

    // Import augmentation therapy data
    if (
      alphaNetData.augmentation_therapy &&
      connection.sharedDataTypes.augmentationTherapy
    ) {
      for (const infusion of alphaNetData.augmentation_therapy.infusions) {
        await this.db.insert('augmentation_infusions', {
          infusionId: uuidv4(),
          participantId: connection.participantId,
          infusionDate: new Date(infusion.date),
          product: infusion.product, // e.g., "Prolastin", "Zemaira"
          dose_mg: infusion.dose_mg,
          source: 'alphanet',
          imported_at: new Date()
        });
      }
    }

    // Update last sync timestamp
    await this.db.update('alphanet_connections', connectionId, {
      last_sync_from_alphanet: new Date()
    });

    console.log(`Synced data from AlphaNet for connection ${connectionId}`);
  }

  async verifyAlphaNetId(alphaNetId: string): Promise<any> {
    // Verify that AlphaNet ID exists and patient has consented to data sharing
    const response = await axios.get(
      `${this.alphaNetApiUrl}/members/${alphaNetId}/verify`,
      {
        headers: { Authorization: `Bearer ${this.apiKey}` }
      }
    );

    if (!response.data.exists) {
      throw new Error('AlphaNet ID not found');
    }

    if (!response.data.data_sharing_consent) {
      throw new Error('Patient has not consented to data sharing in AlphaNet');
    }

    return response.data;
  }
}
```

---

## Alpha-1 Foundation Research Registry

### Integration Approach

The Alpha-1 Foundation Research Registry focuses on genetic data and family histories. Integration provides:

- **Genetic data enrichment** - Import genotype, family pedigree data
- **Research study recruitment** - Offer Foundation registry participants Fair Underwriting studies
- **Event notifications** - Alert Foundation when participants experience major events

```typescript
interface Alpha1FoundationConnection {
  connectionId: string;
  participantId: string;
  foundationRegistryId: string;

  // Data sharing
  importGeneticData: boolean;
  importFamilyHistory: boolean;
  exportClinicalEvents: boolean;

  // Sync
  lastSync: Date;
  status: 'active' | 'inactive';
}

class Alpha1FoundationService {
  async importGeneticData(connectionId: string): Promise<void> {
    const connection = await this.db.findById(
      'alpha1_foundation_connections',
      connectionId
    );

    // Alpha-1 Foundation uses FHIR for genetic data exchange
    const fhirClient = new FHIRClient({
      baseUrl: 'https://fhir.alpha1.org',
      auth: {
        type: 'client_credentials',
        clientId: process.env.ALPHA1_CLIENT_ID,
        clientSecret: process.env.ALPHA1_CLIENT_SECRET
      }
    });

    // Fetch genetic observations
    const observations = await fhirClient.search('Observation', {
      subject: `Patient/${connection.foundationRegistryId}`,
      category: 'laboratory',
      code: 'LA24470-1' // LOINC code for AATD genetic test
    });

    for (const obs of observations) {
      // Extract genotype (e.g., "Pi*ZZ", "Pi*MZ")
      const genotype = obs.valueCodeableConcept?.coding?.[0]?.display;

      // Import to our system
      await this.geneticService.importGenotype({
        participantId: connection.participantId,
        source: 'alpha1_foundation',
        testDate: new Date(obs.effectiveDateTime),
        genotype,
        allele1: this.parseAllele(genotype, 1),
        allele2: this.parseAllele(genotype, 2),
        imported_at: new Date()
      });
    }

    // Fetch family history
    const familyHistory = await fhirClient.search('FamilyMemberHistory', {
      patient: connection.foundationRegistryId
    });

    for (const fh of familyHistory) {
      await this.db.insert('family_history', {
        historyId: uuidv4(),
        participantId: connection.participantId,
        relationship: fh.relationship.coding[0].display,
        condition: fh.condition?.[0]?.code?.coding?.[0]?.display,
        ageAtOnset: fh.condition?.[0]?.onsetAge?.value,
        source: 'alpha1_foundation',
        imported_at: new Date()
      });
    }
  }

  async exportClinicalEvent(
    participantId: string,
    eventType: string,
    eventData: any
  ): Promise<void> {
    const connection = await this.db.queryOne(
      `
      SELECT * FROM alpha1_foundation_connections
      WHERE participant_id = $1 AND status = 'active' AND export_clinical_events = true
    `,
      [participantId]
    );

    if (!connection) return; // Not connected or not consented

    // Convert to FHIR Observation
    const observation = {
      resourceType: 'Observation',
      status: 'final',
      category: [
        {
          coding: [
            {
              system:
                'http://terminology.hl7.org/CodeSystem/observation-category',
              code: 'clinical'
            }
          ]
        }
      ],
      code: {
        coding: [
          {
            system: 'http://snomed.info/sct',
            code: this.mapEventTypeToSNOMED(eventType)
          }
        ],
        text: eventType
      },
      subject: {
        reference: `Patient/${connection.foundationRegistryId}`
      },
      effectiveDateTime: eventData.date.toISOString(),
      valueString: JSON.stringify(eventData)
    };

    // Send to Alpha-1 Foundation FHIR endpoint
    await axios.post('https://fhir.alpha1.org/Observation', observation, {
      headers: {
        Authorization: `Bearer ${await this.getAccessToken()}`,
        'Content-Type': 'application/fhir+json'
      }
    });
  }
}
```

---

## OMOP CDM Export

### Common Data Model for Multi-Registry Analysis

OMOP (Observational Medical Outcomes Partnership) Common Data Model is widely used for observational research. Exporting Fair Underwriting data to OMOP enables:

- **Cross-registry queries** - Analyze AATD data alongside other disease registries
- **Standardized analytics** - Use OHDSI tools (ATLAS, Achilles, etc.)
- **Federated research networks** - Connect to networks like OHDSI, PCORnet

```typescript
interface OMOPExportConfig {
  exportId: string;

  // Export scope
  cohortDefinition: CohortCriterion[];
  includeAllHistory: boolean; // Export all historical data or just recent?

  // OMOP CDM version
  cdmVersion: '5.3' | '5.4';

  // Vocabulary mappings
  vocabularyMappings: {
    sourceVocabulary: string;
    targetVocabulary: string; // e.g., "SNOMED", "RxNorm", "LOINC"
  }[];

  // Output
  outputFormat: 'postgresql' | 'csv' | 'parquet';
  outputLocation: string;

  status: 'pending' | 'running' | 'completed' | 'failed';
  created_at: Date;
  completed_at?: Date;
}

class OMOPExportService {
  async exportToOMOP(config: OMOPExportConfig): Promise<void> {
    // 1. Identify cohort
    const cohort = await this.registryService.buildCohort(
      config.cohortDefinition
    );

    // 2. Export to OMOP tables
    await this.exportPersonTable(cohort);
    await this.exportObservationPeriodTable(cohort);
    await this.exportConditionOccurrenceTable(cohort);
    await this.exportDrugExposureTable(cohort);
    await this.exportMeasurementTable(cohort);
    await this.exportObservationTable(cohort);
    await this.exportProcedureOccurrenceTable(cohort);
    await this.exportVisitOccurrenceTable(cohort);

    // 3. Mark as completed
    await this.db.update('omop_exports', config.exportId, {
      status: 'completed',
      completed_at: new Date()
    });
  }

  async exportPersonTable(cohort: string[]): Promise<void> {
    const participants = await this.db.query(
      `
      SELECT
        participant_id,
        demographics.birth_date,
        demographics.gender,
        demographics.race,
        demographics.ethnicity,
        enrollment_date
      FROM registry_participants
      WHERE participant_id = ANY($1)
    `,
      [cohort]
    );

    for (const p of participants) {
      await this.omopDb.insert('person', {
        person_id: this.hashId(p.participant_id), // De-identified numeric ID
        gender_concept_id: this.mapGenderToOMOP(p.demographics.gender),
        year_of_birth: p.demographics.birth_date.getFullYear(),
        month_of_birth: p.demographics.birth_date.getMonth() + 1,
        day_of_birth: p.demographics.birth_date.getDate(),
        race_concept_id: this.mapRaceToOMOP(p.demographics.race),
        ethnicity_concept_id: this.mapEthnicityToOMOP(p.demographics.ethnicity),
        person_source_value: null // Don't export identifiable ID
      });
    }
  }

  async exportMeasurementTable(cohort: string[]): Promise<void> {
    // Spirometry measurements
    const spirometry = await this.db.query(
      `
      SELECT
        participant_id,
        timestamp,
        fev1,
        fvc,
        pef
      FROM spirometer_readings
      WHERE participant_id = ANY($1)
    `,
      [cohort]
    );

    for (const s of spirometry) {
      const personId = this.hashId(s.participant_id);

      // FEV1 measurement
      await this.omopDb.insert('measurement', {
        measurement_id: this.generateId(),
        person_id: personId,
        measurement_concept_id: 3024171, // LOINC: FEV1
        measurement_date: s.timestamp.toISOString().split('T')[0],
        measurement_datetime: s.timestamp.toISOString(),
        measurement_type_concept_id: 44818701, // Patient reported
        value_as_number: s.fev1.value,
        unit_concept_id: 8587, // milliliter
        unit_source_value: 'ml'
      });

      // FVC measurement
      await this.omopDb.insert('measurement', {
        measurement_id: this.generateId(),
        person_id: personId,
        measurement_concept_id: 3013466, // LOINC: FVC
        measurement_date: s.timestamp.toISOString().split('T')[0],
        measurement_datetime: s.timestamp.toISOString(),
        measurement_type_concept_id: 44818701,
        value_as_number: s.fvc.value,
        unit_concept_id: 8587,
        unit_source_value: 'ml'
      });
    }

    // Lab results
    const labs = await this.db.query(
      `
      SELECT
        participant_id,
        test_date,
        loinc_code,
        value,
        unit
      FROM lab_results
      WHERE participant_id = ANY($1)
    `,
      [cohort]
    );

    for (const lab of labs) {
      await this.omopDb.insert('measurement', {
        measurement_id: this.generateId(),
        person_id: this.hashId(lab.participant_id),
        measurement_concept_id: await this.vocabularyService.loincToOMOP(
          lab.loinc_code
        ),
        measurement_date: lab.test_date.toISOString().split('T')[0],
        measurement_datetime: lab.test_date.toISOString(),
        measurement_type_concept_id: 44818702, // Lab result
        value_as_number: parseFloat(lab.value),
        unit_concept_id: await this.vocabularyService.unitToOMOP(lab.unit),
        unit_source_value: lab.unit,
        measurement_source_value: lab.loinc_code
      });
    }
  }

  async exportDrugExposureTable(cohort: string[]): Promise<void> {
    const medications = await this.db.query(
      `
      SELECT
        participant_id,
        medication_name,
        rxnorm_code,
        start_date,
        end_date,
        dosage,
        route
      FROM medications
      WHERE participant_id = ANY($1)
    `,
      [cohort]
    );

    for (const med of medications) {
      await this.omopDb.insert('drug_exposure', {
        drug_exposure_id: this.generateId(),
        person_id: this.hashId(med.participant_id),
        drug_concept_id: await this.vocabularyService.rxnormToOMOP(
          med.rxnorm_code
        ),
        drug_exposure_start_date: med.start_date.toISOString().split('T')[0],
        drug_exposure_start_datetime: med.start_date.toISOString(),
        drug_exposure_end_date: med.end_date?.toISOString().split('T')[0],
        drug_type_concept_id: 38000177, // Prescription written
        quantity: null,
        days_supply: med.end_date
          ? Math.floor(
              (med.end_date.getTime() - med.start_date.getTime()) /
                (24 * 60 * 60 * 1000)
            )
          : null,
        drug_source_value: med.medication_name
      });
    }
  }

  mapGenderToOMOP(gender: string): number {
    const mapping = {
      male: 8507,
      female: 8532,
      other: 0,
      unknown: 0
    };
    return mapping[gender.toLowerCase()] || 0;
  }

  hashId(participantId: string): number {
    // Convert UUID to deterministic numeric ID for OMOP
    const hash = crypto.createHash('sha256').update(participantId).digest();
    return parseInt(hash.toString('hex').substring(0, 8), 16);
  }
}
```

---

## Cross-Registry De-Duplication

### Patient Matching

Many AATD patients are enrolled in multiple registries. De-duplication prevents:

- **Double-counting** in research studies
- **Conflicting data** from different sources
- **Consent confusion** about which registries have access to what data

```typescript
interface PatientMatchCandidate {
  fairUnderwritingId: string;
  externalRegistryId: string;
  externalRegistry: 'alphanet' | 'alpha1_foundation' | 'earco' | 'uk_registry';

  // Matching scores
  matchScore: number; // 0-100
  confidenceLevel: 'high' | 'medium' | 'low';

  // Matching criteria
  matchingFields: {
    firstName: boolean;
    lastName: boolean;
    dateOfBirth: boolean;
    zipCode: boolean;
    email: boolean;
    genotype: boolean;
  };

  // Manual review
  requiresReview: boolean;
  reviewedBy?: string;
  reviewedAt?: Date;
  matchStatus: 'confirmed' | 'rejected' | 'pending';
}

class PatientMatchingService {
  async findDuplicates(
    participantId: string
  ): Promise<PatientMatchCandidate[]> {
    const participant =
      await this.registryService.getParticipant(participantId);
    const candidates: PatientMatchCandidate[] = [];

    // Search AlphaNet
    const alphaNetMatches = await this.searchAlphaNet(participant);
    candidates.push(...alphaNetMatches);

    // Search Alpha-1 Foundation
    const foundationMatches = await this.searchAlpha1Foundation(participant);
    candidates.push(...foundationMatches);

    // Calculate match scores
    for (const candidate of candidates) {
      candidate.matchScore = this.calculateMatchScore(participant, candidate);
      candidate.confidenceLevel = this.determineConfidence(
        candidate.matchScore
      );
      candidate.requiresReview = candidate.confidenceLevel !== 'high';
    }

    // Sort by match score
    candidates.sort((a, b) => b.matchScore - a.matchScore);

    return candidates;
  }

  async searchAlphaNet(participant: any): Promise<PatientMatchCandidate[]> {
    // Use AlphaNet API to search by demographics
    const response = await axios.post(
      `${this.alphaNetApiUrl}/members/search`,
      {
        firstName: participant.demographics.firstName,
        lastName: participant.demographics.lastName,
        dateOfBirth: participant.demographics.birthDate
          .toISOString()
          .split('T')[0],
        zipCode: participant.demographics.address?.zipCode
      },
      {
        headers: { Authorization: `Bearer ${this.apiKey}` }
      }
    );

    return response.data.matches.map((match) => ({
      fairUnderwritingId: participant.participantId,
      externalRegistryId: match.member_id,
      externalRegistry: 'alphanet' as const,
      matchScore: 0, // Calculated later
      confidenceLevel: 'low' as const,
      matchingFields: {
        firstName: this.fuzzyMatch(
          participant.demographics.firstName,
          match.first_name
        ),
        lastName: this.fuzzyMatch(
          participant.demographics.lastName,
          match.last_name
        ),
        dateOfBirth:
          participant.demographics.birthDate.toISOString().split('T')[0] ===
          match.dob,
        zipCode: participant.demographics.address?.zipCode === match.zip_code,
        email: participant.contactInfo?.email === match.email,
        genotype: participant.genetics?.genotype === match.genotype
      },
      requiresReview: true,
      matchStatus: 'pending' as const
    }));
  }

  calculateMatchScore(
    participant: any,
    candidate: PatientMatchCandidate
  ): number {
    let score = 0;

    // Weighted scoring
    if (candidate.matchingFields.firstName) score += 15;
    if (candidate.matchingFields.lastName) score += 15;
    if (candidate.matchingFields.dateOfBirth) score += 30; // Strong identifier
    if (candidate.matchingFields.zipCode) score += 10;
    if (candidate.matchingFields.email) score += 20; // Strong identifier
    if (candidate.matchingFields.genotype) score += 10;

    return score;
  }

  determineConfidence(matchScore: number): 'high' | 'medium' | 'low' {
    if (matchScore >= 80) return 'high'; // e.g., DOB + email + name = 80
    if (matchScore >= 60) return 'medium';
    return 'low';
  }

  fuzzyMatch(str1: string, str2: string): boolean {
    // Simple Levenshtein distance for name matching
    const distance = this.levenshteinDistance(
      str1.toLowerCase(),
      str2.toLowerCase()
    );

    // Allow 1-2 character differences for typos
    return distance <= 2;
  }

  levenshteinDistance(str1: string, str2: string): number {
    const matrix = [];

    for (let i = 0; i <= str2.length; i++) {
      matrix[i] = [i];
    }

    for (let j = 0; j <= str1.length; j++) {
      matrix[0][j] = j;
    }

    for (let i = 1; i <= str2.length; i++) {
      for (let j = 1; j <= str1.length; j++) {
        if (str2.charAt(i - 1) === str1.charAt(j - 1)) {
          matrix[i][j] = matrix[i - 1][j - 1];
        } else {
          matrix[i][j] = Math.min(
            matrix[i - 1][j - 1] + 1, // substitution
            matrix[i][j - 1] + 1, // insertion
            matrix[i - 1][j] + 1 // deletion
          );
        }
      }
    }

    return matrix[str2.length][str1.length];
  }
}
```

---

## Budget & Success Metrics

### Development Costs (4-5 months)

- **Integration Engineer** (API connectors, data mapping): $140K/year × 0.42 = $58,800
- **Backend Developer** (OMOP export, FHIR clients): $140K/year × 0.42 = $58,800
- **Data Scientist** (patient matching algorithm): $160K/year × 0.25 = $40,000
- **Clinical Data Manager** (registry coordination, mapping validation): $100K/year × 0.33 = $33,000

**Total**: ~$190,600

### Annual Operations

- **Registry Partnership Fees** (AlphaNet, Alpha-1 Foundation): $30,000/year
- **API Usage** (data exchange costs): $15,000/year
- **Manual Matching Review** (staff time for ambiguous duplicates): $25,000/year

**Total**: ~$70,000/year

### Success Metrics

**Integration Coverage**

- Connected registries: 3+ (AlphaNet, Alpha-1 Foundation, EARCO)
- Participants with external registry connections: 40%
- Bidirectional data flow: 80% of connections share data both ways

**Data Exchange Volume**

- Records synced per month: 5,000+
- Sync reliability: 99% success rate
- Data latency: <24 hours for daily sync

**De-Duplication Accuracy**

- Duplicate detection rate: 95% of known duplicates identified
- False positive rate: <5%
- High-confidence matches: 70% auto-confirmed without manual review

**Research Impact**

- Multi-registry studies enabled: 5+ within 2 years
- Combined cohort size: 10,000+ patients across all connected registries
- Cross-registry queries per month: 50+

---

**Document Status:** Complete
**Next:** Feature 21C-3 - Data Standardization & Interoperability
