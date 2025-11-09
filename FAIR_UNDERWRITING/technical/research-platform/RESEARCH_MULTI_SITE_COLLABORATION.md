# Feature #21C-1: Multi-Site Collaboration & Federated Research

**Part of Feature #21: Research Participation Platform (Research Federation)**

---

## Overview

Traditional clinical research suffers from **site fragmentation**: each institution maintains isolated databases, forcing researchers to choose between:

1. **Single-site studies** - Faster IRB/contracting, but limited sample size, narrow demographics
2. **Multi-site studies** - Larger N, diverse populations, but 12-18 month startup, $500K-2M coordination costs

**Fair Underwriting's federated research network** enables **distributed queries** across institutions while preserving data sovereignty. Sites retain full control of patient data—queries execute locally, only aggregate results shared.

### Key Capabilities

1. **Federated Patient Registry** - Query across 20+ participating sites without data movement
2. **Distributed Cohort Building** - Identify eligible patients at each site simultaneously
3. **Multi-Site Study Coordination** - Centralized protocol, decentralized execution
4. **Privacy-Preserving Analytics** - Differential privacy, secure multi-party computation
5. **Site Performance Dashboards** - Enrollment tracking, protocol adherence by site

### Value Proposition

**Traditional Multi-Site Research:**

- IRB approval: 6-12 months per site
- Contract negotiation: 3-6 months per site
- Patient identification: Manual chart review at each site
- Data aggregation: Custom ETL for each site's EHR system
- Timeline: 18-24 months to first participant enrolled
- Cost: $1.5M-3M for 500-patient study across 10 sites

**Fair Underwriting Federated Network:**

- IRB: 3 months (single cIRB + site acknowledgment)
- Contracts: Pre-negotiated network participation agreement
- Patient ID: Automated federated query in <1 hour
- Data aggregation: Standardized FHIR/OMOP, zero ETL
- Timeline: 4-6 months to enrollment
- Cost: $400K-800K for same study

**75% time savings, 60% cost reduction**

---

## Architecture

### Federated Network Topology

```typescript
interface FederatedResearchNetwork {
  networkId: string;
  name: string; // e.g., "AATD Research Consortium"

  // Participating sites
  sites: FederatedSite[];

  // Governance
  governance: {
    leadSite: string; // siteId
    steeringCommittee: string[]; // User IDs
    cirbInstitution: string; // Central IRB
    dua: string; // Data Use Agreement URL
    participationAgreement: string; // Legal document
  };

  // Network capabilities
  capabilities: {
    federatedQuery: boolean;
    distributedCohortBuilding: boolean;
    secureSummaryStatistics: boolean;
    differentialPrivacy: boolean;
  };

  created_at: Date;
}

interface FederatedSite {
  siteId: string;

  // Site details
  institution: string;
  department?: string;
  city: string;
  state: string;
  country: string;

  // Registry size
  registrySize: number; // Total AATD patients
  activeParticipants: number;

  // Technical setup
  nodeType: 'full' | 'query_only'; // Full = can initiate queries; Query-only = responds only
  apiEndpoint: string; // https://site1.aatd-network.org/api/federated
  publicKey: string; // For encrypted communication

  // Governance
  piName: string;
  piEmail: string;
  irbNumber: string;
  irbApprovalDate: Date;
  participationStatus: 'active' | 'pending' | 'suspended';

  joined_at: Date;
  last_activity: Date;
}
```

### Distributed Query Protocol

```typescript
interface FederatedQuery {
  queryId: string;
  initiatorSiteId: string;
  initiatorUserId: string;

  // Query definition
  cohortCriteria: {
    inclusionCriteria: CohortCriterion[];
    exclusionCriteria: CohortCriterion[];
  };

  // Requested data elements
  dataElements: string[]; // e.g., ['demographics.age', 'clinical.fev1', 'treatment.augmentation']

  // Privacy settings
  privacySettings: {
    minimumCellSize: number; // Don't return counts <10
    differentialPrivacyEpsilon?: number; // ε for DP noise
    suppressDirectIdentifiers: boolean;
  };

  // Target sites
  targetSites: string[]; // Empty = all network sites

  // Status
  status: 'pending' | 'executing' | 'completed' | 'failed';

  // Results (aggregate only)
  results: FederatedQueryResult[];

  created_at: Date;
  executed_at?: Date;
  completed_at?: Date;
}

interface FederatedQueryResult {
  queryId: string;
  siteId: string;

  // Cohort summary
  cohortSize: number; // Matching patients

  // Aggregate statistics (never individual-level data)
  aggregateData: {
    [dataElement: string]: {
      count: number;
      mean?: number;
      median?: number;
      stddev?: number;
      min?: number;
      max?: number;

      // For categorical variables
      distribution?: { [value: string]: number };
    };
  };

  // Execution metadata
  executionTime: number; // Milliseconds
  dataAsOfDate: Date;

  computed_at: Date;
}

class FederatedQueryService {
  async executeQuery(query: FederatedQuery): Promise<FederatedQueryResult[]> {
    // 1. Validate query against network policy
    await this.validateQuery(query);

    // 2. Encrypt query for transmission
    const encryptedQuery = await this.encryptQuery(query);

    // 3. Send to all target sites
    const promises = query.targetSites.map((siteId) =>
      this.sendQueryToSite(siteId, encryptedQuery)
    );

    // 4. Wait for responses (with timeout)
    const results = await Promise.allSettled(promises);

    // 5. Aggregate results
    const aggregated = results
      .filter((r) => r.status === 'fulfilled')
      .map((r) => (r as PromiseFulfilledResult<FederatedQueryResult>).value);

    // 6. Store results
    await this.db.insert('federated_query_results', aggregated);

    // 7. Update query status
    await this.db.update('federated_queries', query.queryId, {
      status: 'completed',
      completed_at: new Date()
    });

    return aggregated;
  }

  async sendQueryToSite(
    siteId: string,
    encryptedQuery: string
  ): Promise<FederatedQueryResult> {
    const site = await this.db.findById('federated_sites', siteId);

    // Send encrypted query via HTTPS
    const response = await axios.post(
      `${site.apiEndpoint}/query`,
      { encryptedQuery },
      {
        timeout: 30000, // 30 second timeout
        headers: {
          'X-Network-Id': process.env.NETWORK_ID,
          'X-Signature': await this.signRequest(encryptedQuery)
        }
      }
    );

    // Decrypt response
    const result = await this.decryptResult(response.data.encryptedResult);

    return result;
  }

  // This runs at EACH SITE to respond to queries
  async respondToQuery(encryptedQuery: string): Promise<FederatedQueryResult> {
    // 1. Decrypt query
    const query = await this.decryptQuery(encryptedQuery);

    // 2. Verify query signature
    await this.verifyQuerySignature(query);

    // 3. Check local IRB approval for this study/query type
    await this.checkLocalIRBApproval(query);

    // 4. Execute query locally
    const cohort = await this.identifyLocalCohort(query.cohortCriteria);

    // 5. Apply privacy filters
    if (cohort.length < query.privacySettings.minimumCellSize) {
      throw new Error(
        `Cohort size below minimum threshold (${query.privacySettings.minimumCellSize})`
      );
    }

    // 6. Compute aggregate statistics
    const aggregateData = await this.computeAggregates(
      cohort,
      query.dataElements,
      query.privacySettings
    );

    // 7. Return encrypted result
    const result: FederatedQueryResult = {
      queryId: query.queryId,
      siteId: process.env.SITE_ID,
      cohortSize: cohort.length,
      aggregateData,
      executionTime: Date.now() - startTime,
      dataAsOfDate: new Date(),
      computed_at: new Date()
    };

    return result;
  }

  async computeAggregates(
    cohort: string[],
    dataElements: string[],
    privacySettings: any
  ): Promise<any> {
    const aggregates: any = {};

    for (const element of dataElements) {
      const [domain, field] = element.split('.');

      // Fetch data for cohort
      const data = await this.db.query(
        `
        SELECT ${field}
        FROM ${domain}
        WHERE participant_id = ANY($1)
      `,
        [cohort]
      );

      const values = data.map((d) => d[field]).filter((v) => v !== null);

      // Compute statistics
      if (typeof values[0] === 'number') {
        aggregates[element] = {
          count: values.length,
          mean: this.mean(values),
          median: this.median(values),
          stddev: this.stddev(values),
          min: Math.min(...values),
          max: Math.max(...values)
        };

        // Apply differential privacy noise if requested
        if (privacySettings.differentialPrivacyEpsilon) {
          aggregates[element] = this.addDPNoise(
            aggregates[element],
            privacySettings.differentialPrivacyEpsilon
          );
        }
      } else {
        // Categorical variable - count distribution
        const distribution: any = {};
        for (const value of values) {
          distribution[value] = (distribution[value] || 0) + 1;
        }

        aggregates[element] = {
          count: values.length,
          distribution
        };
      }
    }

    return aggregates;
  }

  addDPNoise(statistics: any, epsilon: number): any {
    // Laplace mechanism for differential privacy
    const sensitivity = 1; // Depends on query
    const scale = sensitivity / epsilon;

    // Add noise to each statistic
    const noisy = { ...statistics };

    if (noisy.mean !== undefined) {
      noisy.mean += this.laplaceNoise(scale);
    }
    if (noisy.median !== undefined) {
      noisy.median += this.laplaceNoise(scale);
    }
    // Don't noise min/max as they're less informative

    return noisy;
  }

  laplaceNoise(scale: number): number {
    // Generate Laplace noise: Lap(0, scale)
    const u = Math.random() - 0.5;
    return -scale * Math.sign(u) * Math.log(1 - 2 * Math.abs(u));
  }
}
```

---

## Multi-Site Study Management

### Study Coordination

```typescript
interface MultiSiteStudy {
  studyId: string;
  networkId: string;

  // Study details
  title: string;
  protocol: string; // URL to protocol document
  clinicalTrialsGovId?: string;

  // Leadership
  piName: string;
  piInstitution: string;
  coordinatingCenter: string; // siteId

  // Participating sites
  sites: SiteParticipation[];

  // Enrollment
  targetEnrollment: number;
  currentEnrollment: number;
  enrollmentBySite: { [siteId: string]: number };

  // Timeline
  irbApprovalDate: Date;
  enrollmentStartDate: Date;
  enrollmentEndDate: Date;
  studyCompletionDate: Date;

  // Data collection
  dataElements: string[];
  collectionSchedule: {
    visit: string; // 'baseline', 'month_3', 'month_6', etc.
    dataElements: string[];
    window: { early: number; late: number }; // Days
  }[];

  // Status
  status: 'planning' | 'enrolling' | 'active' | 'completed' | 'terminated';
}

interface SiteParticipation {
  siteId: string;
  role: 'coordinating' | 'recruiting' | 'data_only';

  // Site-specific details
  sitePiName: string;
  localIrbNumber: string;
  localIrbApprovalDate: Date;

  // Enrollment
  targetEnrollment: number;
  currentEnrollment: number;
  enrollmentRate: number; // Patients per month

  // Performance
  screenFailRate: number; // % screened but not enrolled
  dropoutRate: number; // % enrolled but withdrew
  protocolDeviations: number;

  // Data quality
  dataCompletenessRate: number; // % of expected data collected
  queryRate: number; // Data queries per patient

  activated_at: Date;
  last_enrollment?: Date;
}

class MultiSiteStudyService {
  async createStudy(study: MultiSiteStudy): Promise<string> {
    // 1. Create study record
    const studyId = uuidv4();
    await this.db.insert('multi_site_studies', { ...study, studyId });

    // 2. Send invitations to sites
    for (const site of study.sites) {
      await this.inviteSite(studyId, site.siteId);
    }

    // 3. Create study-specific consent form
    await this.consentService.createConsentTemplate({
      studyId,
      title: `${study.title} - Informed Consent`,
      content: await this.generateConsentDocument(study),
      networkWide: true
    });

    return studyId;
  }

  async enrollParticipant(
    studyId: string,
    siteId: string,
    participantId: string
  ): Promise<void> {
    // 1. Verify eligibility
    const study = await this.db.findById('multi_site_studies', studyId);
    const eligible = await this.checkEligibility(
      participantId,
      study.eligibilityCriteria
    );

    if (!eligible.isEligible) {
      throw new Error(`Participant not eligible: ${eligible.reason}`);
    }

    // 2. Obtain consent
    const consentId = await this.consentService.collectConsent({
      participantId,
      studyId,
      templateId: study.consentTemplateId
    });

    // 3. Randomize (if applicable)
    const arm = study.randomized
      ? await this.randomizationService.assignArm(
          studyId,
          participantId,
          siteId
        )
      : null;

    // 4. Create enrollment record
    await this.db.insert('study_enrollments', {
      enrollmentId: uuidv4(),
      studyId,
      siteId,
      participantId,
      consentId,
      arm,
      enrolledDate: new Date(),
      status: 'active'
    });

    // 5. Update counts
    await this.db.query(
      `
      UPDATE multi_site_studies
      SET current_enrollment = current_enrollment + 1,
          enrollment_by_site = jsonb_set(
            enrollment_by_site,
            '{${siteId}}',
            (COALESCE((enrollment_by_site->>'${siteId}')::int, 0) + 1)::text::jsonb
          )
      WHERE study_id = $1
    `,
      [studyId]
    );

    // 6. Schedule study visits
    await this.scheduleStudyVisits(studyId, participantId);

    // 7. Notify coordinating center
    await this.notificationService.send({
      userId: study.piUserId,
      type: 'study_enrollment',
      message: `New participant enrolled at ${siteId} for ${study.title}. Total: ${study.currentEnrollment + 1}/${study.targetEnrollment}`,
      actionUrl: `/studies/${studyId}/enrollment`
    });
  }

  async scheduleStudyVisits(
    studyId: string,
    participantId: string
  ): Promise<void> {
    const study = await this.db.findById('multi_site_studies', studyId);
    const enrollment = await this.db.queryOne(
      `
      SELECT enrolled_date
      FROM study_enrollments
      WHERE study_id = $1 AND participant_id = $2
    `,
      [studyId, participantId]
    );

    for (const schedule of study.collectionSchedule) {
      let visitDate: Date;

      if (schedule.visit === 'baseline') {
        visitDate = enrollment.enrolled_date;
      } else {
        // Extract month number from visit name (e.g., "month_6" -> 6)
        const monthMatch = schedule.visit.match(/month_(\d+)/);
        if (monthMatch) {
          const months = parseInt(monthMatch[1]);
          visitDate = new Date(enrollment.enrolled_date);
          visitDate.setMonth(visitDate.getMonth() + months);
        }
      }

      await this.db.insert('study_visits', {
        visitId: uuidv4(),
        studyId,
        participantId,
        visitName: schedule.visit,
        scheduledDate: visitDate,
        windowStart: new Date(
          visitDate.getTime() - schedule.window.early * 24 * 60 * 60 * 1000
        ),
        windowEnd: new Date(
          visitDate.getTime() + schedule.window.late * 24 * 60 * 60 * 1000
        ),
        status: 'scheduled',
        dataElements: schedule.dataElements
      });
    }
  }

  async generateSitePerformanceReport(
    studyId: string,
    siteId: string
  ): Promise<SitePerformanceReport> {
    const study = await this.db.findById('multi_site_studies', studyId);
    const siteParticipation = study.sites.find((s) => s.siteId === siteId);

    // Enrollment metrics
    const enrollmentData = await this.db.query(
      `
      SELECT
        COUNT(*) AS total_enrolled,
        COUNT(*) FILTER (WHERE status = 'active') AS active,
        COUNT(*) FILTER (WHERE status = 'withdrawn') AS withdrawn,
        AVG(EXTRACT(EPOCH FROM (withdrawn_date - enrolled_date)) / 86400) AS avg_days_to_withdrawal
      FROM study_enrollments
      WHERE study_id = $1 AND site_id = $2
    `,
      [studyId, siteId]
    );

    // Data completeness
    const completeness = await this.db.query(
      `
      SELECT
        data_element,
        COUNT(*) AS expected,
        COUNT(value) AS collected,
        (COUNT(value)::float / COUNT(*) * 100) AS completeness_rate
      FROM (
        SELECT
          e.participant_id,
          v.visit_name,
          unnest(v.data_elements) AS data_element,
          -- Check if data exists
          CASE
            WHEN EXISTS (
              SELECT 1 FROM study_data_points dp
              WHERE dp.study_id = e.study_id
                AND dp.participant_id = e.participant_id
                AND dp.data_element = unnest(v.data_elements)
                AND dp.visit_name = v.visit_name
            ) THEN 1
          END AS value
        FROM study_enrollments e
        JOIN study_visits v ON e.study_id = v.study_id AND e.participant_id = v.participant_id
        WHERE e.study_id = $1 AND e.site_id = $2
      ) sub
      GROUP BY data_element
    `,
      [studyId, siteId]
    );

    // Protocol deviations
    const deviations = await this.db.query(
      `
      SELECT
        deviation_type,
        COUNT(*) AS count
      FROM protocol_deviations
      WHERE study_id = $1 AND site_id = $2
      GROUP BY deviation_type
    `,
      [studyId, siteId]
    );

    return {
      studyId,
      siteId,
      enrollment: {
        target: siteParticipation.targetEnrollment,
        current: enrollmentData[0].total_enrolled,
        active: enrollmentData[0].active,
        withdrawn: enrollmentData[0].withdrawn,
        dropoutRate:
          (enrollmentData[0].withdrawn / enrollmentData[0].total_enrolled) * 100
      },
      dataCompleteness: completeness,
      protocolDeviations: deviations,
      generatedAt: new Date()
    };
  }
}
```

---

## Cross-Site Data Harmonization

### Data Standardization

```typescript
interface DataHarmonizationRules {
  networkId: string;

  // Standard vocabularies
  vocabularies: {
    diagnosis: 'ICD-10' | 'SNOMED CT';
    procedures: 'CPT' | 'SNOMED CT';
    medications: 'RxNorm' | 'NDC';
    labs: 'LOINC';
    observations: 'SNOMED CT';
  };

  // Unit conversions
  unitConversions: {
    sourceUnit: string;
    targetUnit: string;
    conversionFactor: number;
  }[];

  // Value mappings (for categorical data)
  valueMappings: {
    dataElement: string;
    mappings: { [sourceValue: string]: string }; // e.g., {'M': 'male', 'F': 'female'}
  }[];

  // Date formats
  dateFormat: string; // ISO 8601
}

class DataHarmonizationService {
  async harmonizeValue(
    dataElement: string,
    value: any,
    sourceSiteId: string
  ): Promise<any> {
    const rules = await this.getHarmonizationRules();

    // 1. Unit conversion (for numeric values with units)
    if (this.hasUnit(value)) {
      value = await this.convertUnit(value, rules);
    }

    // 2. Value mapping (for categorical data)
    const mapping = rules.valueMappings.find(
      (m) => m.dataElement === dataElement
    );
    if (mapping && mapping.mappings[value]) {
      value = mapping.mappings[value];
    }

    // 3. Code translation (for coded data)
    if (this.isCodedValue(value)) {
      value = await this.translateCode(value, dataElement, rules);
    }

    return value;
  }

  async convertUnit(
    value: { value: number; unit: string },
    rules: any
  ): Promise<any> {
    const conversion = rules.unitConversions.find(
      (c) => c.sourceUnit === value.unit
    );

    if (conversion) {
      return {
        value: value.value * conversion.conversionFactor,
        unit: conversion.targetUnit
      };
    }

    return value;
  }

  async translateCode(
    value: { code: string; system: string },
    dataElement: string,
    rules: any
  ): Promise<any> {
    // Example: Translate local diagnosis code to ICD-10
    if (dataElement.startsWith('diagnosis') && value.system !== 'ICD-10') {
      const icd10Code = await this.terminologyService.translate(
        value.code,
        value.system,
        'ICD-10'
      );

      return { code: icd10Code, system: 'ICD-10' };
    }

    return value;
  }
}
```

---

## Budget & Success Metrics

### Development Costs (5-6 months)

- **Distributed Systems Engineer** (federated query protocol): $180K/year × 0.50 = $90,000
- **Backend Developer** (multi-site APIs, data harmonization): $140K/year × 0.50 = $70,000
- **Security Engineer** (encryption, privacy-preserving analytics): $160K/year × 0.33 = $52,800
- **Data Scientist** (differential privacy implementation): $160K/year × 0.25 = $40,000
- **Clinical Research Coordinator** (multi-site study workflows): $100K/year × 0.42 = $42,000

**Total**: ~$294,800

### Annual Operations

- **Network Coordination** (governance, site onboarding): $80,000/year
- **Infrastructure** (federated query servers, encryption): $40,000/year
- **Legal & Compliance** (DUA updates, IRB coordination): $60,000/year

**Total**: ~$180,000/year

### Success Metrics

**Network Growth**

- Participating sites: 20+ within 2 years
- Registry coverage: 5,000+ AATD patients across network
- Geographic diversity: 15+ states

**Query Performance**

- Query execution time: <2 minutes for 20-site query
- Response rate: 90% of sites respond within timeout
- Uptime: 99.5%

**Research Productivity**

- Multi-site studies launched: 10+ within 3 years
- Time to study activation: 6 months (vs. 18 months traditional)
- Cost per multi-site study: $600K (vs. $2M traditional)

**Data Quality**

- Data harmonization success: 95% of data elements standardized
- Query accuracy: 98% match vs. manual aggregation
- Privacy compliance: Zero breaches, 100% audit trail

---

**Document Status:** Complete
**Next:** Feature 21C-2 - External Registry Integration
