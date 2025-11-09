# Feature #21C-3: Data Standardization & Interoperability

**Part of Feature #21: Research Participation Platform (Research Federation)**

---

## Overview

Healthcare data interoperability remains **the #1 barrier** to multi-site research:

- **250+ EHR vendors** - Each with proprietary data models
- **Incompatible terminologies** - ICD-10 vs SNOMED CT vs local codes
- **Inconsistent units** - FEV₁ in ml vs L, dates in MM/DD/YYYY vs ISO 8601
- **Semantic ambiguity** - "Diagnosis" could mean suspected, confirmed, ruled out, history of

**Result:** 60-80% of research project time spent on data wrangling, not analysis.

**Fair Underwriting's standardization strategy:**

1. **FHIR R4 as native format** - HL7 FHIR for all data exchange
2. **OMOP CDM for analytics** - Convert to OMOP for observational research
3. **CDISC SDTM for trials** - Export to SDTM for FDA submissions
4. **HL7 v2/CDA for legacy systems** - Backwards compatibility
5. **Automated vocabulary mapping** - LOINC, SNOMED CT, RxNorm, ICD-10

---

## FHIR R4 Implementation

### Core FHIR Resources

```typescript
interface FHIRImplementation {
  // Patient demographics
  patient: fhir.Patient;

  // Clinical data
  condition: fhir.Condition; // Diagnoses
  observation: fhir.Observation; // Labs, vitals, spirometry
  medicationStatement: fhir.MedicationStatement; // Current medications
  procedure: fhir.Procedure; // Procedures, surgeries

  // Study participation
  researchSubject: fhir.ResearchSubject;
  researchStudy: fhir.ResearchStudy;

  // Consent
  consent: fhir.Consent;

  // Documents
  documentReference: fhir.DocumentReference; // PDFs, images

  // Genetic data
  molecularSequence: fhir.MolecularSequence;
  diagnosticReport: fhir.DiagnosticReport;
}

class FHIRConversionService {
  async convertToFHIR(
    participantId: string,
    resourceTypes: string[]
  ): Promise<fhir.Bundle> {
    const participant =
      await this.registryService.getParticipant(participantId);
    const entries: fhir.BundleEntry[] = [];

    // Convert Patient resource
    if (resourceTypes.includes('Patient')) {
      entries.push({
        fullUrl: `urn:uuid:${participantId}`,
        resource: this.convertPatient(participant)
      });
    }

    // Convert Conditions (diagnoses)
    if (resourceTypes.includes('Condition')) {
      const conditions = await this.convertConditions(participantId);
      entries.push(...conditions);
    }

    // Convert Observations (spirometry, labs, vitals)
    if (resourceTypes.includes('Observation')) {
      const observations = await this.convertObservations(participantId);
      entries.push(...observations);
    }

    // Convert Medications
    if (resourceTypes.includes('MedicationStatement')) {
      const medications = await this.convertMedications(participantId);
      entries.push(...medications);
    }

    // Create bundle
    const bundle: fhir.Bundle = {
      resourceType: 'Bundle',
      type: 'collection',
      timestamp: new Date().toISOString(),
      entry: entries
    };

    return bundle;
  }

  convertPatient(participant: any): fhir.Patient {
    return {
      resourceType: 'Patient',
      id: participant.participantId,
      identifier: [
        {
          system: 'https://fairunderwriting.com/participant-id',
          value: participant.participantId
        }
      ],
      name: [
        {
          use: 'official',
          family: participant.demographics.lastName,
          given: [participant.demographics.firstName]
        }
      ],
      gender: participant.demographics.gender.toLowerCase() as
        | 'male'
        | 'female'
        | 'other'
        | 'unknown',
      birthDate: participant.demographics.birthDate.toISOString().split('T')[0],
      address: [
        {
          use: 'home',
          line: [participant.demographics.address?.street],
          city: participant.demographics.address?.city,
          state: participant.demographics.address?.state,
          postalCode: participant.demographics.address?.zipCode,
          country: 'US'
        }
      ],
      telecom: [
        {
          system: 'email',
          value: participant.contactInfo?.email,
          use: 'home'
        },
        {
          system: 'phone',
          value: participant.contactInfo?.phone,
          use: 'mobile'
        }
      ]
    };
  }

  async convertObservations(
    participantId: string
  ): Promise<fhir.BundleEntry[]> {
    const entries: fhir.BundleEntry[] = [];

    // Spirometry observations
    const spirometry = await this.db.query(
      `
      SELECT reading_id, timestamp, fev1, fvc, pef, fev1_fvc_ratio
      FROM spirometer_readings
      WHERE participant_id = $1
      ORDER BY timestamp DESC
      LIMIT 100
    `,
      [participantId]
    );

    for (const s of spirometry) {
      // FEV1 observation
      entries.push({
        fullUrl: `urn:uuid:${s.reading_id}-fev1`,
        resource: {
          resourceType: 'Observation',
          id: `${s.reading_id}-fev1`,
          status: 'final',
          category: [
            {
              coding: [
                {
                  system:
                    'http://terminology.hl7.org/CodeSystem/observation-category',
                  code: 'vital-signs',
                  display: 'Vital Signs'
                }
              ]
            }
          ],
          code: {
            coding: [
              {
                system: 'http://loinc.org',
                code: '20150-9',
                display: 'FEV1'
              }
            ]
          },
          subject: {
            reference: `Patient/${participantId}`
          },
          effectiveDateTime: s.timestamp.toISOString(),
          valueQuantity: {
            value: s.fev1.value,
            unit: 'mL',
            system: 'http://unitsofmeasure.org',
            code: 'mL'
          }
        } as fhir.Observation
      });

      // FVC observation
      entries.push({
        fullUrl: `urn:uuid:${s.reading_id}-fvc`,
        resource: {
          resourceType: 'Observation',
          id: `${s.reading_id}-fvc`,
          status: 'final',
          category: [
            {
              coding: [
                {
                  system:
                    'http://terminology.hl7.org/CodeSystem/observation-category',
                  code: 'vital-signs'
                }
              ]
            }
          ],
          code: {
            coding: [
              {
                system: 'http://loinc.org',
                code: '19870-5',
                display: 'FVC'
              }
            ]
          },
          subject: {
            reference: `Patient/${participantId}`
          },
          effectiveDateTime: s.timestamp.toISOString(),
          valueQuantity: {
            value: s.fvc.value,
            unit: 'mL',
            system: 'http://unitsofmeasure.org',
            code: 'mL'
          }
        } as fhir.Observation
      });
    }

    // Lab observations
    const labs = await this.db.query(
      `
      SELECT result_id, test_date, loinc_code, test_name, value, unit, reference_range
      FROM lab_results
      WHERE participant_id = $1
      ORDER BY test_date DESC
    `,
      [participantId]
    );

    for (const lab of labs) {
      entries.push({
        fullUrl: `urn:uuid:${lab.result_id}`,
        resource: {
          resourceType: 'Observation',
          id: lab.result_id,
          status: 'final',
          category: [
            {
              coding: [
                {
                  system:
                    'http://terminology.hl7.org/CodeSystem/observation-category',
                  code: 'laboratory'
                }
              ]
            }
          ],
          code: {
            coding: [
              {
                system: 'http://loinc.org',
                code: lab.loinc_code,
                display: lab.test_name
              }
            ]
          },
          subject: {
            reference: `Patient/${participantId}`
          },
          effectiveDateTime: lab.test_date.toISOString(),
          valueQuantity: this.isNumeric(lab.value)
            ? {
                value: parseFloat(lab.value),
                unit: lab.unit,
                system: 'http://unitsofmeasure.org',
                code: lab.unit
              }
            : undefined,
          valueString: !this.isNumeric(lab.value) ? lab.value : undefined,
          referenceRange: lab.reference_range
            ? [
                {
                  text: lab.reference_range
                }
              ]
            : undefined
        } as fhir.Observation
      });
    }

    return entries;
  }

  async convertConditions(participantId: string): Promise<fhir.BundleEntry[]> {
    const entries: fhir.BundleEntry[] = [];

    const diagnoses = await this.db.query(
      `
      SELECT
        diagnosis_id,
        icd10_code,
        description,
        diagnosis_date,
        status
      FROM diagnoses
      WHERE participant_id = $1
    `,
      [participantId]
    );

    for (const dx of diagnoses) {
      entries.push({
        fullUrl: `urn:uuid:${dx.diagnosis_id}`,
        resource: {
          resourceType: 'Condition',
          id: dx.diagnosis_id,
          clinicalStatus: {
            coding: [
              {
                system:
                  'http://terminology.hl7.org/CodeSystem/condition-clinical',
                code: dx.status === 'active' ? 'active' : 'resolved'
              }
            ]
          },
          verificationStatus: {
            coding: [
              {
                system:
                  'http://terminology.hl7.org/CodeSystem/condition-ver-status',
                code: 'confirmed'
              }
            ]
          },
          code: {
            coding: [
              {
                system: 'http://hl7.org/fhir/sid/icd-10',
                code: dx.icd10_code,
                display: dx.description
              }
            ]
          },
          subject: {
            reference: `Patient/${participantId}`
          },
          onsetDateTime: dx.diagnosis_date.toISOString()
        } as fhir.Condition
      });
    }

    return entries;
  }

  async convertMedications(participantId: string): Promise<fhir.BundleEntry[]> {
    const entries: fhir.BundleEntry[] = [];

    const medications = await this.db.query(
      `
      SELECT
        medication_id,
        medication_name,
        rxnorm_code,
        start_date,
        end_date,
        dosage,
        frequency,
        route
      FROM medications
      WHERE participant_id = $1
        AND (end_date IS NULL OR end_date > NOW())
    `,
      [participantId]
    );

    for (const med of medications) {
      entries.push({
        fullUrl: `urn:uuid:${med.medication_id}`,
        resource: {
          resourceType: 'MedicationStatement',
          id: med.medication_id,
          status: 'active',
          medicationCodeableConcept: {
            coding: [
              {
                system: 'http://www.nlm.nih.gov/research/umls/rxnorm',
                code: med.rxnorm_code,
                display: med.medication_name
              }
            ]
          },
          subject: {
            reference: `Patient/${participantId}`
          },
          effectivePeriod: {
            start: med.start_date.toISOString().split('T')[0],
            end: med.end_date?.toISOString().split('T')[0]
          },
          dosage: [
            {
              text: `${med.dosage} ${med.frequency}`,
              route: {
                coding: [
                  {
                    system: 'http://snomed.info/sct',
                    code: this.mapRouteToSNOMED(med.route),
                    display: med.route
                  }
                ]
              }
            }
          ]
        } as fhir.MedicationStatement
      });
    }

    return entries;
  }

  mapRouteToSNOMED(route: string): string {
    const mapping: { [key: string]: string } = {
      oral: '26643006',
      intravenous: '47625008',
      subcutaneous: '34206005',
      inhalation: '18679011',
      topical: '6064005'
    };

    return mapping[route.toLowerCase()] || '26643006'; // Default to oral
  }
}
```

---

## FHIR API Server

### RESTful FHIR Endpoints

```typescript
import express from 'express';
import { Router } from 'express';

class FHIRAPIServer {
  private router: Router;

  constructor() {
    this.router = express.Router();
    this.setupRoutes();
  }

  setupRoutes(): void {
    // FHIR Capability Statement
    this.router.get('/metadata', this.getCapabilityStatement);

    // Patient resource
    this.router.get('/Patient', this.searchPatients);
    this.router.get('/Patient/:id', this.getPatient);

    // Observation resource
    this.router.get('/Observation', this.searchObservations);
    this.router.get('/Observation/:id', this.getObservation);

    // Condition resource
    this.router.get('/Condition', this.searchConditions);

    // MedicationStatement resource
    this.router.get('/MedicationStatement', this.searchMedications);

    // Bundle operations
    this.router.post('/Patient/:id/$everything', this.getPatientEverything);
  }

  async getCapabilityStatement(
    req: express.Request,
    res: express.Response
  ): Promise<void> {
    const capabilityStatement: fhir.CapabilityStatement = {
      resourceType: 'CapabilityStatement',
      status: 'active',
      date: '2024-01-01',
      kind: 'instance',
      software: {
        name: 'Fair Underwriting FHIR Server',
        version: '1.0.0'
      },
      fhirVersion: '4.0.1',
      format: ['json', 'xml'],
      rest: [
        {
          mode: 'server',
          resource: [
            {
              type: 'Patient',
              profile: 'http://hl7.org/fhir/StructureDefinition/Patient',
              interaction: [{ code: 'read' }, { code: 'search-type' }],
              searchParam: [
                { name: 'identifier', type: 'token' },
                { name: 'birthdate', type: 'date' },
                { name: 'name', type: 'string' }
              ]
            },
            {
              type: 'Observation',
              profile: 'http://hl7.org/fhir/StructureDefinition/Observation',
              interaction: [{ code: 'read' }, { code: 'search-type' }],
              searchParam: [
                { name: 'patient', type: 'reference' },
                { name: 'code', type: 'token' },
                { name: 'date', type: 'date' },
                { name: 'category', type: 'token' }
              ]
            }
            // ... other resources
          ]
        }
      ]
    };

    res.json(capabilityStatement);
  }

  async searchObservations(
    req: express.Request,
    res: express.Response
  ): Promise<void> {
    const { patient, code, date, category } = req.query;

    // Convert FHIR search parameters to database query
    let query = 'SELECT * FROM observations WHERE 1=1';
    const params: any[] = [];

    if (patient) {
      params.push(patient.toString().replace('Patient/', ''));
      query += ` AND participant_id = $${params.length}`;
    }

    if (code) {
      // Parse LOINC code (e.g., "http://loinc.org|20150-9")
      const loincCode = code.toString().split('|')[1];
      params.push(loincCode);
      query += ` AND loinc_code = $${params.length}`;
    }

    if (date) {
      // Parse date parameter (e.g., "ge2024-01-01")
      const dateMatch = date
        .toString()
        .match(/(eq|ge|le|gt|lt)(\d{4}-\d{2}-\d{2})/);
      if (dateMatch) {
        const [, operator, dateValue] = dateMatch;
        const sqlOperator = {
          eq: '=',
          ge: '>=',
          le: '<=',
          gt: '>',
          lt: '<'
        }[operator];

        params.push(dateValue);
        query += ` AND DATE(timestamp) ${sqlOperator} $${params.length}`;
      }
    }

    const results = await this.db.query(query, params);

    // Convert to FHIR Bundle
    const bundle: fhir.Bundle = {
      resourceType: 'Bundle',
      type: 'searchset',
      total: results.length,
      entry: results.map((r) => ({
        fullUrl: `${req.protocol}://${req.get('host')}/fhir/Observation/${r.id}`,
        resource: this.fhirService.convertObservationToFHIR(r)
      }))
    };

    res.json(bundle);
  }

  async getPatientEverything(
    req: express.Request,
    res: express.Response
  ): Promise<void> {
    const participantId = req.params.id;

    // Fetch all data for patient
    const bundle = await this.fhirService.convertToFHIR(participantId, [
      'Patient',
      'Condition',
      'Observation',
      'MedicationStatement',
      'Procedure',
      'DocumentReference'
    ]);

    res.json(bundle);
  }
}
```

---

## CDISC SDTM for Clinical Trials

### Study Data Tabulation Model

CDISC SDTM is required for **FDA submissions** and most pharma-sponsored trials. Fair Underwriting can auto-generate SDTM datasets from registry data.

```typescript
interface SDTMExport {
  exportId: string;
  studyId: string;

  // SDTM domains to export
  domains: ('dm' | 'ae' | 'cm' | 'lb' | 'vs' | 'ex' | 'mh')[];

  // Export format
  format: 'sas7bdat' | 'csv' | 'xpt';
  outputLocation: string;

  // Mapping configuration
  mappingConfig: {
    domain: string;
    sourceTable: string;
    columnMappings: { sdtmColumn: string; sourceColumn: string }[];
  }[];

  status: 'pending' | 'running' | 'completed';
  created_at: Date;
}

class SDTMExportService {
  async exportToSDTM(config: SDTMExport): Promise<void> {
    // 1. Export Demographics domain (DM)
    await this.exportDM(config);

    // 2. Export Adverse Events (AE)
    if (config.domains.includes('ae')) {
      await this.exportAE(config);
    }

    // 3. Export Concomitant Medications (CM)
    if (config.domains.includes('cm')) {
      await this.exportCM(config);
    }

    // 4. Export Laboratory Results (LB)
    if (config.domains.includes('lb')) {
      await this.exportLB(config);
    }

    // 5. Export Vital Signs (VS) - includes spirometry
    if (config.domains.includes('vs')) {
      await this.exportVS(config);
    }

    // 6. Export Exposure (EX) - study drug administration
    if (config.domains.includes('ex')) {
      await this.exportEX(config);
    }

    // 7. Export Medical History (MH)
    if (config.domains.includes('mh')) {
      await this.exportMH(config);
    }
  }

  async exportDM(config: SDTMExport): Promise<void> {
    const enrollments = await this.db.query(
      `
      SELECT
        e.participant_id,
        p.demographics,
        e.enrolled_date,
        e.arm,
        s.title AS study_title
      FROM study_enrollments e
      JOIN registry_participants p ON e.participant_id = p.participant_id
      JOIN multi_site_studies s ON e.study_id = s.study_id
      WHERE e.study_id = $1
    `,
      [config.studyId]
    );

    const dm = enrollments.map((e, index) => ({
      STUDYID: config.studyId,
      DOMAIN: 'DM',
      USUBJID: this.generateSubjectId(e.participant_id), // De-identified
      SUBJID: String(index + 1).padStart(4, '0'),
      RFSTDTC: e.enrolled_date.toISOString().split('T')[0], // Reference Start Date
      RFENDTC: null, // Reference End Date (completion)
      SITEID: '001', // Site identifier
      AGE: this.calculateAge(e.demographics.birthDate, e.enrolled_date),
      AGEU: 'YEARS',
      SEX: e.demographics.gender === 'male' ? 'M' : 'F',
      RACE: this.mapRaceToSDTM(e.demographics.race),
      ETHNIC: this.mapEthnicityToSDTM(e.demographics.ethnicity),
      ARM: e.arm,
      ARMCD: e.arm?.substring(0, 8).toUpperCase(),
      COUNTRY: 'USA'
    }));

    await this.writeSDTMFile('dm', dm, config);
  }

  async exportVS(config: SDTMExport): Promise<void> {
    // Spirometry as vital signs
    const spirometry = await this.db.query(
      `
      SELECT
        sr.participant_id,
        sr.timestamp,
        sr.fev1,
        sr.fvc,
        sr.pef,
        v.visit_name
      FROM spirometer_readings sr
      JOIN study_enrollments e ON sr.participant_id = e.participant_id
      LEFT JOIN study_visits v ON sr.timestamp::date = v.scheduled_date::date
      WHERE e.study_id = $1
    `,
      [config.studyId]
    );

    const vs: any[] = [];

    for (const s of spirometry) {
      const subjId = this.generateSubjectId(s.participant_id);

      // FEV1
      vs.push({
        STUDYID: config.studyId,
        DOMAIN: 'VS',
        USUBJID: subjId,
        VSSEQ: vs.length + 1,
        VSTESTCD: 'FEV1',
        VSTEST: 'Forced Expiratory Volume in 1 Second',
        VSORRES: s.fev1.value.toString(),
        VSORRESU: 'mL',
        VSSTRESN: s.fev1.value,
        VSSTRESU: 'mL',
        VSSTAT: null,
        VSREASND: null,
        VSDTC: s.timestamp.toISOString(),
        VISIT: s.visit_name || 'Unscheduled'
      });

      // FVC
      vs.push({
        STUDYID: config.studyId,
        DOMAIN: 'VS',
        USUBJID: subjId,
        VSSEQ: vs.length + 1,
        VSTESTCD: 'FVC',
        VSTEST: 'Forced Vital Capacity',
        VSORRES: s.fvc.value.toString(),
        VSORRESU: 'mL',
        VSSTRESN: s.fvc.value,
        VSSTRESU: 'mL',
        VSSTAT: null,
        VSREASND: null,
        VSDTC: s.timestamp.toISOString(),
        VISIT: s.visit_name || 'Unscheduled'
      });
    }

    await this.writeSDTMFile('vs', vs, config);
  }

  async writeSDTMFile(
    domain: string,
    data: any[],
    config: SDTMExport
  ): Promise<void> {
    const filename = `${domain}.${config.format}`;
    const filepath = `${config.outputLocation}/${filename}`;

    if (config.format === 'csv') {
      // Write CSV
      const csv = this.convertToCSV(data);
      await fs.writeFile(filepath, csv, 'utf8');
    } else if (config.format === 'xpt') {
      // Write SAS Transport File (XPT)
      await this.convertToXPT(data, filepath);
    } else if (config.format === 'sas7bdat') {
      // Write SAS Dataset
      await this.convertToSAS(data, filepath);
    }
  }

  generateSubjectId(participantId: string): string {
    // Generate de-identified subject ID deterministically
    const hash = crypto
      .createHash('sha256')
      .update(participantId)
      .digest('hex');
    return `SUBJ-${hash.substring(0, 8).toUpperCase()}`;
  }

  mapRaceToSDTM(race: string): string {
    const mapping: { [key: string]: string } = {
      white: 'WHITE',
      black: 'BLACK OR AFRICAN AMERICAN',
      asian: 'ASIAN',
      native_american: 'AMERICAN INDIAN OR ALASKA NATIVE',
      pacific_islander: 'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER',
      other: 'OTHER',
      unknown: 'UNKNOWN'
    };

    return mapping[race.toLowerCase()] || 'UNKNOWN';
  }
}
```

---

## Terminology Service

### Automated Vocabulary Mapping

```typescript
class TerminologyService {
  private umls: UMLSClient;

  async mapToStandardVocabulary(
    code: string,
    sourceSystem: string,
    targetSystem: string
  ): Promise<string> {
    // Use UMLS API to map between vocabularies
    const mapping = await this.umls.mapCode(code, sourceSystem, targetSystem);

    if (!mapping) {
      throw new Error(
        `No mapping found from ${sourceSystem} to ${targetSystem} for code ${code}`
      );
    }

    return mapping.targetCode;
  }

  async enrichWithSNOMED(diagnosis: string): Promise<any> {
    // Search SNOMED CT for concept
    const concepts = await this.umls.searchSNOMED(diagnosis);

    if (concepts.length === 0) {
      return null;
    }

    const bestMatch = concepts[0];

    return {
      code: bestMatch.code,
      display: bestMatch.display,
      system: 'http://snomed.info/sct',

      // Hierarchical relationships
      parents: await this.getSNOMEDParents(bestMatch.code),
      children: await this.getSNOMEDChildren(bestMatch.code),

      // Synonyms
      synonyms: bestMatch.synonyms
    };
  }

  async standardizeMedication(medicationName: string): Promise<any> {
    // Search RxNorm
    const rxnorm = await this.rxnormService.search(medicationName);

    if (!rxnorm) {
      return null;
    }

    return {
      rxcui: rxnorm.rxcui,
      name: rxnorm.name,
      ingredient: rxnorm.ingredient,
      strength: rxnorm.strength,
      doseForm: rxnorm.doseForm,
      route: rxnorm.route
    };
  }

  async mapLabToLOINC(testName: string): Promise<string> {
    // Use fuzzy matching to find LOINC code
    const loincResults = await this.loincService.search(testName);

    if (loincResults.length === 0) {
      throw new Error(`No LOINC code found for test: ${testName}`);
    }

    // Return best match
    return loincResults[0].loincCode;
  }
}
```

---

## Budget & Success Metrics

### Development Costs (5-6 months)

- **FHIR Architect** (FHIR R4 implementation, API design): $180K/year × 0.50 = $90,000
- **Backend Developer** (FHIR server, CDISC export): $140K/year × 0.50 = $70,000
- **Data Engineer** (OMOP CDM, vocabulary mapping): $150K/year × 0.42 = $63,000
- **Clinical Informatics Specialist** (terminology mapping, validation): $130K/year × 0.33 = $42,900

**Total**: ~$265,900

### Annual Operations

- **UMLS License** (terminology service): $5,000/year
- **FHIR Server Infrastructure**: $30,000/year
- **Vocabulary Updates** (quarterly SNOMED/LOINC/RxNorm releases): $15,000/year

**Total**: ~$50,000/year

### Success Metrics

**Interoperability**

- FHIR conformance: 100% compliance with US Core Implementation Guide
- Supported vocabularies: LOINC, SNOMED CT, RxNorm, ICD-10, CPT
- Vocabulary mapping success: 95% of terms auto-mapped

**Data Exchange**

- FHIR API uptime: 99.9%
- FHIR API requests per month: 10,000+
- External systems integrated: 20+ (EHRs, registries, research networks)

**Research Enablement**

- OMOP CDM exports: 50+ per year for observational studies
- CDISC SDTM exports: 10+ per year for clinical trials
- FDA submissions: 3+ trials using Fair Underwriting SDTM data

---

## Feature 21C Complete Summary

### Total Budget (All 3 Documents)

**Development Costs:**

- 21C-1: Multi-Site Collaboration - $294,800
- 21C-2: External Registry Integration - $190,600
- 21C-3: Data Standardization - $265,900
  **Total Development**: ~$751,300 (14-17 months)

**Annual Operations:**

- 21C-1: Multi-site - $180,000/year
- 21C-2: External registries - $70,000/year
- 21C-3: Standards/interop - $50,000/year
  **Total Operations**: ~$300,000/year

---

## Feature #21 Complete Summary (All 11 Documents)

### Total Budget

**Development Costs:**

- **21A (Core Infrastructure)**: $678,900 (5 documents)
- **21B (Advanced Data Collection)**: $670,400 (3 documents)
- **21C (Research Federation)**: $751,300 (3 documents)
  **Grand Total Development**: ~$2,100,600 (24-30 months)

**Annual Operations:**

- **21A**: $60,000/year
- **21B**: $360,000/year
- **21C**: $300,000/year
  **Grand Total Operations**: ~$720,000/year

### Success Metrics Summary

**Registry Scale**

- Active participants: 5,000+ within 3 years
- Data completeness: 90% average across all participants
- Retention rate: 78% at 5 years (vs. 58% traditional)

**Research Productivity**

- Studies launched: 50+ within 3 years
- Time to enrollment: 4-6 months (vs. 18-24 traditional)
- Cost per study: $600K-1.5M (vs. $3M-10M traditional)
- Publications: 30+ papers within 5 years

**Data Quality**

- Multi-source integration: 85% participants with EHR + claims + PRO + wearables
- Real-time data collection: 80% device compliance
- Standardization: 95% FHIR/OMOP compliant

**Network Effect**

- Connected sites: 20+ institutions
- External registries: 3+ (AlphaNet, Alpha-1 Foundation, EARCO)
- Total network reach: 10,000+ AATD patients

---

**Document Status:** Complete
**Feature 21C Status:** Complete (3/3 documents finished)
**Feature #21 Status:** Complete (11/11 documents finished)
**Overall Progress:** Features #14-20 + Feature #21 (11 sub-documents) = 18 major feature components complete
**Next:** Return to main feature sequence - Feature #22
