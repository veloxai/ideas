# Feature #14: Health Records Integration (EHR/PHR)

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 5-6 months
**Team Required**: 1 backend developer, 1 integration specialist, 1 frontend developer, 0.25 FTE HIPAA compliance officer

---

## Executive Summary

AATD patients see multiple specialists (pulmonologist, hepatologist, PCP, genetic counselor) whose records are scattered across different EMR systems. Patients manually carry paper records to appointments, repeat tests, and risk care gaps when providers can't see the full picture. Fair Underwriting can become the central hub for AATD health records by integrating with major EHR systems (Epic, Cerner) and enabling patients to import/share their medical data seamlessly.

**Key Value Propositions**:

- **EHR Integration**: Pull records from Epic, Cerner, Allscripts via FHIR APIs
- **Personal Health Record**: Patient-controlled longitudinal health record
- **Automated Import**: Pull lab results, imaging reports, clinic notes, medications automatically
- **Smart Sharing**: Share relevant records with new providers (one-click consent)
- **Timeline View**: Visual timeline of all medical events (diagnosis, tests, treatments)
- **Blue Button**: Export complete health record in standard format (CCD)

**Business Impact**:

- Reduce duplicate testing: Save $1,200/patient/year (avoid repeat AAT tests, PFTs, imaging)
- Improve care coordination: 70% reduction in missing records at appointments
- Patient satisfaction: 4.7/5 stars for records access
- Competitive advantage: Only AATD platform with full EHR integration
- Enable data analytics: Aggregated de-identified data for research ($150K+/year licensing)

---

## Problem Statement

### Current Gaps

**Scenario 1: Records Lost Between Providers**

> "I switched pulmonologists. They wanted my old PFTs and chest CTs. I had to call my old doctor's office 3 times to get records faxed. It took 6 weeks. Meanwhile, they repeated tests that insurance wouldn't cover. I got billed $800."

**No automated records transfer** ❌

**Scenario 2: Patient Can't Access Own Records**

> "I wanted to see my AAT genotype report from 2018. My doctor retired. The office closed. I have no way to get my records. I might need to repeat genetic testing ($450)."

**No patient-owned health record** ❌

**Scenario 3: Emergency Room Lacks Critical Info**

> "I went to ER with severe shortness of breath. They didn't know I have AATD, what medications I'm on, or my baseline FEV1. I was too sick to explain. They treated me like regular COPD."

**No emergency access to medical history** ❌

**Scenario 4: Specialist Needs Full History**

> "I'm seeing a hepatologist for elevated liver enzymes. He needs my complete AATD history (genotype, lung function, augmentation therapy). I don't remember all the details from 5 years ago."

**No longitudinal view of AATD journey** ❌

**Scenario 5: Research Requires Manual Data Entry**

> "I want to participate in a registry study. They need 10 years of PFT data. I have to manually type in results from 40 different tests. This will take hours."

**No structured data export for research** ❌

---

## Feature Specifications

### 1. FHIR (Fast Healthcare Interoperability Resources) Integration

**Epic/Cerner/Allscripts Connection**:

```typescript
interface FHIRConnection {
  connectionId: string;
  userId: string;

  // EHR system
  ehrSystem:
    | 'Epic'
    | 'Cerner'
    | 'Allscripts'
    | 'eClinicalWorks'
    | 'Athenahealth';
  facilityName: string;
  facilityId: string; // FHIR server identifier

  // OAuth 2.0 tokens (for patient-authorized access)
  accessToken: string;
  refreshToken: string;
  tokenExpiresAt: Date;

  // FHIR server endpoint
  fhirServerUrl: string; // e.g., 'https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4'

  // Patient FHIR ID
  fhirPatientId: string; // Patient's ID in the EHR system

  // Scope (what data we can access)
  scopes: string[]; // ['patient/*.read', 'patient/Observation.read', 'patient/Condition.read']

  // Sync status
  lastSyncDate: Date;
  syncStatus: 'active' | 'expired' | 'revoked' | 'error';

  // Status
  active: boolean;
  connectedAt: Date;
}

class FHIRIntegrationService {
  async initiateConnection(
    userId: string,
    ehrSystem: string,
    facilityId: string
  ): Promise<OAuthUrl> {
    // Start OAuth 2.0 flow (SMART on FHIR)
    const state = this.generateState();
    const codeVerifier = this.generateCodeVerifier();
    const codeChallenge = this.generateCodeChallenge(codeVerifier);

    // Store state for callback verification
    await this.redis.set(
      `oauth_state:${state}`,
      JSON.stringify({
        userId,
        ehrSystem,
        facilityId,
        codeVerifier
      }),
      'EX',
      600
    ); // 10 minutes

    // Get FHIR authorization endpoint
    const authEndpoint = await this.getFHIRAuthEndpoint(ehrSystem, facilityId);

    // Build authorization URL
    const authUrl =
      `${authEndpoint}?` +
      new URLSearchParams({
        response_type: 'code',
        client_id: process.env.FHIR_CLIENT_ID,
        redirect_uri: `${process.env.APP_URL}/api/fhir/callback`,
        scope: 'launch/patient patient/*.read offline_access',
        state,
        aud: this.getFHIRServerUrl(ehrSystem, facilityId),
        code_challenge: codeChallenge,
        code_challenge_method: 'S256'
      }).toString();

    return { authUrl };
  }

  async handleOAuthCallback(
    code: string,
    state: string
  ): Promise<FHIRConnection> {
    // Verify state
    const stateData = await this.redis.get(`oauth_state:${state}`);
    if (!stateData) {
      throw new Error('Invalid or expired OAuth state');
    }

    const { userId, ehrSystem, facilityId, codeVerifier } =
      JSON.parse(stateData);

    // Exchange code for tokens
    const tokenEndpoint = await this.getFHIRTokenEndpoint(
      ehrSystem,
      facilityId
    );

    const tokenResponse = await axios.post(
      tokenEndpoint,
      new URLSearchParams({
        grant_type: 'authorization_code',
        code,
        redirect_uri: `${process.env.APP_URL}/api/fhir/callback`,
        client_id: process.env.FHIR_CLIENT_ID,
        code_verifier: codeVerifier
      }),
      {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
      }
    );

    const {
      access_token,
      refresh_token,
      expires_in,
      patient, // FHIR patient ID
      scope
    } = tokenResponse.data;

    // Store connection
    const connection: FHIRConnection = {
      connectionId: uuidv4(),
      userId,
      ehrSystem,
      facilityName: await this.getFacilityName(facilityId),
      facilityId,
      accessToken: await this.encrypt(access_token),
      refreshToken: await this.encrypt(refresh_token),
      tokenExpiresAt: new Date(Date.now() + expires_in * 1000),
      fhirServerUrl: this.getFHIRServerUrl(ehrSystem, facilityId),
      fhirPatientId: patient,
      scopes: scope.split(' '),
      lastSyncDate: new Date(),
      syncStatus: 'active',
      active: true,
      connectedAt: new Date()
    };

    await this.db.insert('fhir_connections', connection);

    // Trigger initial data sync
    await this.syncAllResources(connection.connectionId);

    return connection;
  }

  async syncAllResources(connectionId: string): Promise<void> {
    const connection = await this.getConnection(connectionId);

    // Fetch all relevant FHIR resources
    const resourceTypes = [
      'Patient',
      'Condition',
      'Observation',
      'MedicationRequest',
      'Procedure',
      'DiagnosticReport',
      'DocumentReference',
      'AllergyIntolerance',
      'Immunization',
      'Encounter'
    ];

    for (const resourceType of resourceTypes) {
      await this.syncResource(connection, resourceType);
    }

    // Update last sync date
    await this.db.update('fhir_connections', connectionId, {
      last_sync_date: new Date()
    });
  }

  async syncResource(
    connection: FHIRConnection,
    resourceType: string
  ): Promise<void> {
    const accessToken = await this.decrypt(connection.accessToken);

    // Fetch resources from FHIR server
    const url = `${connection.fhirServerUrl}/${resourceType}?patient=${connection.fhirPatientId}`;

    const response = await axios.get(url, {
      headers: {
        Authorization: `Bearer ${accessToken}`,
        Accept: 'application/fhir+json'
      }
    });

    const bundle = response.data;

    if (bundle.resourceType === 'Bundle' && bundle.entry) {
      for (const entry of bundle.entry) {
        await this.storeResource(
          connection.userId,
          resourceType,
          entry.resource
        );
      }
    }

    // Handle pagination (if bundle has more results)
    if (bundle.link) {
      const nextLink = bundle.link.find((l) => l.relation === 'next');
      if (nextLink) {
        await this.fetchNextPage(connection, nextLink.url);
      }
    }
  }

  async storeResource(
    userId: string,
    resourceType: string,
    resource: any
  ): Promise<void> {
    // Parse and store FHIR resource
    const parsed = this.parseFHIRResource(resourceType, resource);

    await this.db.insert('health_records', {
      user_id: userId,
      resource_type: resourceType,
      fhir_id: resource.id,
      data: resource,
      parsed_data: parsed,
      effective_date: parsed.effectiveDate || resource.meta?.lastUpdated,
      source: 'fhir',
      created_at: new Date()
    });
  }

  parseFHIRResource(resourceType: string, resource: any): ParsedResource {
    // Extract key information from FHIR resource
    switch (resourceType) {
      case 'Observation':
        return this.parseObservation(resource);
      case 'Condition':
        return this.parseCondition(resource);
      case 'MedicationRequest':
        return this.parseMedication(resource);
      case 'DiagnosticReport':
        return this.parseDiagnosticReport(resource);
      default:
        return { raw: resource };
    }
  }

  parseObservation(obs: any): ParsedObservation {
    // Parse lab results, vitals, PFTs, etc.
    return {
      type: 'observation',
      code: obs.code?.coding?.[0]?.code,
      display: obs.code?.coding?.[0]?.display,
      category: obs.category?.[0]?.coding?.[0]?.code,
      value: obs.valueQuantity?.value,
      unit: obs.valueQuantity?.unit,
      effectiveDate: obs.effectiveDateTime || obs.effectiveDate,
      status: obs.status,

      // AATD-specific parsing
      isAATLevel: obs.code?.coding?.some(
        (c) =>
          c.code === '48805-0' || // AAT level LOINC code
          c.display?.toLowerCase().includes('alpha-1-antitrypsin')
      ),
      isFEV1: obs.code?.coding?.some(
        (c) =>
          c.code === '20150-9' || // FEV1 LOINC code
          c.display?.toLowerCase().includes('fev1')
      )
    };
  }

  parseCondition(condition: any): ParsedCondition {
    return {
      type: 'condition',
      code: condition.code?.coding?.[0]?.code,
      display: condition.code?.coding?.[0]?.display,
      clinicalStatus: condition.clinicalStatus?.coding?.[0]?.code,
      verificationStatus: condition.verificationStatus?.coding?.[0]?.code,
      onsetDate: condition.onsetDateTime || condition.onsetDate,
      recordedDate: condition.recordedDate,

      // Check if AATD-related
      isAATD: condition.code?.coding?.some(
        (c) =>
          c.code === 'E88.01' || // ICD-10 for AATD
          c.display?.toLowerCase().includes('alpha-1')
      )
    };
  }
}
```

### 2. Personal Health Record (PHR)

**Patient-Controlled Longitudinal Record**:

```typescript
interface HealthRecord {
  recordId: string;
  userId: string;

  // Record metadata
  recordType:
    | 'lab_result'
    | 'imaging'
    | 'clinical_note'
    | 'medication'
    | 'procedure'
    | 'vital_sign'
    | 'immunization'
    | 'allergy'
    | 'problem'
    | 'document';

  // Source
  source:
    | 'fhir'
    | 'manual_entry'
    | 'patient_upload'
    | 'provider_upload'
    | 'import';
  sourceSystem?: string; // 'Epic', 'Cerner', etc.
  facilityName?: string;

  // Content
  title: string;
  description?: string;
  category: string;

  // Date
  effectiveDate: Date; // Date of service/test/procedure
  recordedDate: Date; // When entered into system

  // Data
  structuredData?: any; // Parsed FHIR resource or structured fields
  unstructuredData?: string; // Free text
  attachments?: {
    filename: string;
    mimeType: string;
    s3Url: string;
    fileSize: number;
  }[];

  // AATD-specific tags
  tags: string[]; // ['aatd', 'lung_function', 'lab_result', 'critical']

  // Sharing
  sharedWith: {
    recipientId: string;
    recipientType: 'provider' | 'family_member' | 'researcher';
    sharedDate: Date;
    expiresDate?: Date;
  }[];

  // Privacy
  sensitivity: 'normal' | 'sensitive' | 'restricted';

  created_at: Date;
  updated_at: Date;
}

class PersonalHealthRecordService {
  async getTimeline(
    userId: string,
    filters?: TimelineFilters
  ): Promise<HealthTimeline> {
    // Get all health records in chronological order
    let query = `
      SELECT * FROM health_records
      WHERE user_id = $1
      ORDER BY effective_date DESC
    `;

    if (filters?.recordTypes) {
      query += ` AND record_type = ANY($2)`;
    }

    if (filters?.startDate && filters?.endDate) {
      query += ` AND effective_date BETWEEN $3 AND $4`;
    }

    const records = await this.db.query(query, [
      userId,
      filters?.recordTypes,
      filters?.startDate,
      filters?.endDate
    ]);

    // Group by year/month
    const timeline = this.groupByTimePeriod(records);

    // Identify key milestones
    const milestones = this.identifyMilestones(records);

    return {
      timeline,
      milestones,
      totalRecords: records.length,
      dateRange: {
        earliest: records[records.length - 1]?.effective_date,
        latest: records[0]?.effective_date
      }
    };
  }

  identifyMilestones(records: HealthRecord[]): Milestone[] {
    const milestones: Milestone[] = [];

    // Diagnosis
    const diagnosisRecord = records.find(
      (r) =>
        r.recordType === 'problem' &&
        r.tags.includes('aatd') &&
        r.structuredData?.clinicalStatus === 'active'
    );
    if (diagnosisRecord) {
      milestones.push({
        date: diagnosisRecord.effective_date,
        type: 'diagnosis',
        title: 'AATD Diagnosis',
        description: 'Alpha-1 Antitrypsin Deficiency diagnosed',
        icon: '🔬'
      });
    }

    // First augmentation therapy
    const firstAugmentation = records.find(
      (r) =>
        r.recordType === 'medication' &&
        r.title.toLowerCase().includes('prolastin' || 'aralast' || 'zemaira')
    );
    if (firstAugmentation) {
      milestones.push({
        date: firstAugmentation.effective_date,
        type: 'treatment_start',
        title: 'Started Augmentation Therapy',
        description: firstAugmentation.title,
        icon: '💉'
      });
    }

    // Significant FEV1 decline
    const fev1Records = records
      .filter(
        (r) => r.tags.includes('lung_function') && r.structuredData?.isFEV1
      )
      .sort(
        (a, b) =>
          new Date(a.effective_date).getTime() -
          new Date(b.effective_date).getTime()
      );

    for (let i = 1; i < fev1Records.length; i++) {
      const prev = fev1Records[i - 1].structuredData.value;
      const curr = fev1Records[i].structuredData.value;
      const decline = ((prev - curr) / prev) * 100;

      if (decline > 10) {
        // >10% decline
        milestones.push({
          date: fev1Records[i].effective_date,
          type: 'clinical_change',
          title: 'Significant FEV1 Decline',
          description: `FEV1 dropped from ${prev}% to ${curr}% (${decline.toFixed(1)}% decline)`,
          icon: '📉'
        });
      }
    }

    return milestones.sort(
      (a, b) => new Date(b.date).getTime() - new Date(a.date).getTime()
    );
  }

  async exportBlueButton(
    userId: string,
    format: 'ccd' | 'pdf' | 'json'
  ): Promise<string> {
    // Export complete health record in standard format
    const records = await this.getAllRecords(userId);

    if (format === 'ccd') {
      // Continuity of Care Document (C-CDA XML)
      return this.generateCCD(records);
    } else if (format === 'pdf') {
      // Human-readable PDF
      return this.generatePDF(records);
    } else {
      // JSON export
      return JSON.stringify(records, null, 2);
    }
  }

  generateCCD(records: HealthRecord[]): string {
    // Generate C-CDA XML (standard format for health records)
    // This is complex - typically use a library like blue-button.js
    return `
<?xml version="1.0" encoding="UTF-8"?>
<ClinicalDocument xmlns="urn:hl7-org:v3">
  <realmCode code="US"/>
  <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
  <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
  <id root="${uuidv4()}"/>
  <code code="34133-9" displayName="Summarization of Episode Note"
        codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
  <title>Continuity of Care Document</title>
  <effectiveTime value="${new Date().toISOString()}"/>

  <!-- Patient demographics -->
  <recordTarget>
    <patientRole>
      <!-- Patient info here -->
    </patientRole>
  </recordTarget>

  <!-- Problems/Diagnoses -->
  <component>
    <section>
      <templateId root="2.16.840.1.113883.10.20.22.2.5.1"/>
      <code code="11450-4" displayName="Problem List"
            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
      <title>Problems</title>
      <text>
        <list>
          ${records
            .filter((r) => r.recordType === 'problem')
            .map(
              (r) => `
            <item>${r.title} - ${r.effectiveDate}</item>
          `
            )
            .join('')}
        </list>
      </text>
      <!-- Structured entries here -->
    </section>
  </component>

  <!-- Medications -->
  <component>
    <section>
      <templateId root="2.16.840.1.113883.10.20.22.2.1.1"/>
      <code code="10160-0" displayName="Medication List"
            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
      <title>Medications</title>
      <!-- Medication entries -->
    </section>
  </component>

  <!-- Results (Labs, PFTs) -->
  <component>
    <section>
      <templateId root="2.16.840.1.113883.10.20.22.2.3.1"/>
      <code code="30954-2" displayName="Results"
            codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
      <title>Results</title>
      <!-- Lab/test results -->
    </section>
  </component>

</ClinicalDocument>
    `.trim();
  }
}

interface HealthTimeline {
  timeline: {
    year: number;
    months: {
      month: number;
      records: HealthRecord[];
    }[];
  }[];
  milestones: Milestone[];
  totalRecords: number;
  dateRange: {
    earliest: Date;
    latest: Date;
  };
}

interface Milestone {
  date: Date;
  type:
    | 'diagnosis'
    | 'treatment_start'
    | 'treatment_change'
    | 'clinical_change'
    | 'surgery'
    | 'hospitalization';
  title: string;
  description: string;
  icon: string;
}
```

### 3. Database Schema

```sql
-- FHIR connections
CREATE TABLE fhir_connections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- EHR system
  ehr_system VARCHAR(50) NOT NULL,
  facility_name VARCHAR(300),
  facility_id VARCHAR(100),

  -- OAuth tokens (encrypted)
  access_token TEXT NOT NULL,
  refresh_token TEXT,
  token_expires_at TIMESTAMPTZ,

  -- FHIR details
  fhir_server_url TEXT NOT NULL,
  fhir_patient_id VARCHAR(100),
  scopes TEXT[],

  -- Sync
  last_sync_date TIMESTAMPTZ,
  sync_status VARCHAR(20) DEFAULT 'active',

  -- Status
  active BOOLEAN DEFAULT true,
  connected_at TIMESTAMPTZ DEFAULT NOW(),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_fhir_connections_user ON fhir_connections(user_id, active);

-- Health records (unified storage for all health data)
CREATE TABLE health_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Record type
  record_type VARCHAR(50) NOT NULL,

  -- Source
  source VARCHAR(30) NOT NULL,
  source_system VARCHAR(50),
  facility_name VARCHAR(300),
  fhir_connection_id UUID,
  fhir_resource_id VARCHAR(100),

  -- Content
  title VARCHAR(500) NOT NULL,
  description TEXT,
  category VARCHAR(100),

  -- Dates
  effective_date TIMESTAMPTZ NOT NULL, -- Date of service
  recorded_date TIMESTAMPTZ DEFAULT NOW(),

  -- Data (JSONB for flexibility)
  structured_data JSONB,
  unstructured_data TEXT,

  -- Attachments
  attachments JSONB,
  /*
  [
    {
      "filename": "chest_ct_2025_10_15.pdf",
      "mimeType": "application/pdf",
      "s3Url": "s3://...",
      "fileSize": 2456789
    }
  ]
  */

  -- Tags (for filtering/searching)
  tags TEXT[],

  -- Sharing
  shared_with JSONB,
  /*
  [
    {
      "recipientId": "provider_123",
      "recipientType": "provider",
      "sharedDate": "2025-11-07T10:00:00Z",
      "expiresDate": "2026-11-07T10:00:00Z"
    }
  ]
  */

  -- Privacy
  sensitivity VARCHAR(20) DEFAULT 'normal',

  -- Full-text search
  search_vector tsvector,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (fhir_connection_id) REFERENCES fhir_connections(id)
);

CREATE INDEX idx_health_records_user ON health_records(user_id, effective_date DESC);
CREATE INDEX idx_health_records_type ON health_records(user_id, record_type);
CREATE INDEX idx_health_records_tags ON health_records USING GIN(tags);
CREATE INDEX idx_health_records_search ON health_records USING GIN(search_vector);

-- Trigger to update search_vector
CREATE FUNCTION health_records_search_vector_update() RETURNS TRIGGER AS $$
BEGIN
  NEW.search_vector :=
    setweight(to_tsvector('english', coalesce(NEW.title, '')), 'A') ||
    setweight(to_tsvector('english', coalesce(NEW.description, '')), 'B') ||
    setweight(to_tsvector('english', coalesce(NEW.unstructured_data, '')), 'C');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER health_records_search_vector_trigger
BEFORE INSERT OR UPDATE ON health_records
FOR EACH ROW EXECUTE FUNCTION health_records_search_vector_update();

-- Record sharing (tracking who has access)
CREATE TABLE record_sharing (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  record_id UUID NOT NULL,
  user_id UUID NOT NULL, -- Owner

  -- Recipient
  recipient_id VARCHAR(100) NOT NULL, -- Can be provider_id, user_id, etc.
  recipient_type VARCHAR(30), -- 'provider', 'family_member', 'researcher'
  recipient_name VARCHAR(300),

  -- Access
  shared_date TIMESTAMPTZ DEFAULT NOW(),
  expires_date TIMESTAMPTZ,
  access_level VARCHAR(20) DEFAULT 'view', -- 'view', 'download'

  -- Tracking
  viewed_at TIMESTAMPTZ,
  downloaded_at TIMESTAMPTZ,

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'expired', 'revoked'
  revoked_at TIMESTAMPTZ,
  revoked_by UUID,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (record_id) REFERENCES health_records(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_record_sharing_recipient ON record_sharing(recipient_id, status);
CREATE INDEX idx_record_sharing_expires ON record_sharing(expires_date) WHERE status = 'active';

-- Data import jobs (track bulk imports from EHR)
CREATE TABLE data_import_jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,

  -- Source
  import_source VARCHAR(50), -- 'fhir', 'blue_button', 'csv_upload'
  fhir_connection_id UUID,

  -- Status
  status VARCHAR(30) DEFAULT 'pending',
  -- 'pending', 'in_progress', 'completed', 'failed'

  -- Progress
  total_records INTEGER,
  processed_records INTEGER DEFAULT 0,
  failed_records INTEGER DEFAULT 0,

  -- Results
  imported_record_ids UUID[],
  error_log TEXT,

  -- Timing
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (fhir_connection_id) REFERENCES fhir_connections(id)
);

CREATE INDEX idx_import_jobs_user ON data_import_jobs(user_id, status);
```

### 4. Patient Portal

**Health Records Dashboard**:

```
┌─────────────────────────────────────────────────────────────────┐
│  📊 My Health Records - John Doe                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🔗 CONNECTED PROVIDERS                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ ✅ University Hospital (Epic)                             │  │
│  │    Last synced: 2 hours ago | 127 records                │  │
│  │    [View Records] [Disconnect]                            │  │
│  │                                                            │  │
│  │ ✅ Denver Pulmonology Clinic (Cerner)                     │  │
│  │    Last synced: 1 day ago | 43 records                   │  │
│  │    [View Records] [Disconnect]                            │  │
│  │                                                            │  │
│  │ [+ Connect Another Provider]                              │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📅 HEALTH TIMELINE                                             │
│                                                                  │
│  2025                                                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ November                                                   │  │
│  │ • 🔬 AAT Level: 32 mg/dL (Nov 5)                          │  │
│  │ • 🫁 Pulmonary Function Test: FEV1 62% (Nov 3)            │  │
│  │                                                            │  │
│  │ October                                                    │  │
│  │ • 💉 Prolastin infusion (Oct 29)                          │  │
│  │ • 📋 Clinic visit with Dr. Martinez (Oct 15)              │  │
│  │ • 📸 Chest CT scan (Oct 10)                               │  │
│  │                                                            │  │
│  │ [Show More]                                                │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🎯 KEY MILESTONES                                              │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 💉 Started Augmentation Therapy - June 15, 2024           │  │
│  │ 🔬 AATD Diagnosis (ZZ) - January 18, 2018                 │  │
│  │ 📉 Significant FEV1 Decline - March 2023                  │  │
│  │ 🫁 First COPD Diagnosis - September 2017                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📂 RECORDS BY CATEGORY                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🧪 Lab Results (45)                                       │  │
│  │ 🫁 Pulmonary Function Tests (23)                          │  │
│  │ 📸 Imaging Reports (15)                                   │  │
│  │ 💊 Medications (8)                                        │  │
│  │ 📋 Clinic Notes (67)                                      │  │
│  │ 💉 Procedures (12)                                        │  │
│  │ 📄 Documents (32)                                         │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🔍 QUICK SEARCH                                                │
│  [Search all records...] 🔍                                     │
│  Recent: "FEV1", "AAT level", "CT scan"                         │
│                                                                  │
│  📤 EXPORT & SHARE                                              │
│  [Download All Records (PDF)] [Export CCD] [Share with Doctor] │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Record Detail View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  📋 Lab Result: Alpha-1 Antitrypsin Level                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  📅 DATE: November 5, 2025                                      │
│  🏥 FACILITY: University Hospital Lab                           │
│  👨‍⚕️ ORDERING PROVIDER: Dr. Jennifer Martinez                  │
│                                                                  │
│  📊 RESULTS                                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Alpha-1 Antitrypsin, Serum                                │  │
│  │                                                            │  │
│  │ Result: 32 mg/dL                                          │  │
│  │ Reference Range: 90-200 mg/dL                             │  │
│  │ Status: ⚠️ ABNORMAL (Low)                                 │  │
│  │                                                            │  │
│  │ Interpretation:                                            │  │
│  │ Severely deficient. Consistent with ZZ or other null      │  │
│  │ phenotypes. Recommend genotyping if not already done.     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📈 TREND (Last 5 tests)                                        │
│  35 mg/dL ─┐                                                    │
│  34 mg/dL  │                                                    │
│  32 mg/dL ─┤ ← Current                                          │
│  33 mg/dL  │                                                    │
│  31 mg/dL ─┘                                                    │
│  2023  2024  2025                                               │
│                                                                  │
│  💬 MY NOTES                                                    │
│  [Add personal notes about this result...]                      │
│                                                                  │
│  📎 ATTACHMENTS                                                 │
│  📄 lab_report_2025_11_05.pdf (245 KB)                          │
│  [Download] [Share]                                             │
│                                                                  │
│  🔗 RELATED RECORDS                                             │
│  • Genotype Test (ZZ) - Jan 18, 2018                            │
│  • Previous AAT Level (33 mg/dL) - June 2024                   │
│  • Pulmonologist Clinic Visit - Nov 3, 2025                     │
│                                                                  │
│  🤝 SHARED WITH                                                 │
│  • Dr. Martinez (Pulmonologist) - Expires Dec 31, 2025          │
│  [Share with Another Provider]                                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### EHR Integration

- **Connections**: 60% of patients connect at least 1 EHR system
- **Sync Success Rate**: 95% (successful data retrieval)
- **Records Imported**: 8,000+ records across 1,500 patients
- **Sync Frequency**: Daily automated sync

### Patient Adoption

- **Active Users**: 75% view health records monthly
- **Record Uploads**: 40% patients upload additional documents
- **Timeline Views**: 3.5 views/patient/month
- **Export Usage**: 25% export records for new providers

### Care Coordination Impact

- **Reduced Duplicate Tests**: $1,200/patient/year savings
- **Faster Provider Onboarding**: 6 weeks → 1 week (83% reduction)
- **Complete Records at Appointments**: 70% (vs. 25% baseline)
- **Patient Satisfaction**: 4.7/5 stars

### Data Quality

- **Structured Data**: 80% of records have structured fields
- **AATD-Relevant Records**: 2,500+ AAT levels, 1,800+ PFTs, 1,200+ genotypes
- **Timeline Completeness**: 85% of major events captured
- **Search Accuracy**: 92% (users find what they need)

---

## Budget Estimate

### Development (5-6 months)

- **Backend Developer** (FHIR integration, APIs): $140K/year × 0.5 years = $70,000
- **Integration Specialist** (Epic/Cerner setup): $150K/year × 0.42 years = $63,000
- **Frontend Developer** (timeline, record viewer): $140K/year × 0.33 years = $46,200

**Total Development**: ~$179,200

### Annual Operations

- **HIPAA Compliance Officer** (0.25 FTE): $120K/year × 0.25 = $30,000
- **Customer Support** (0.5 FTE, helping with EHR connections): $55K/year × 0.5 = $27,500

**Total Operations**: ~$57,500/year

### Annual Infrastructure

- **FHIR Gateway Services** (Redox, Particle Health): $35,000/year
- **Document Storage** (S3, large files): $6,000/year
- **Encryption Services**: $3,600/year
- **Search/Indexing** (Elasticsearch): $4,800/year

**Total Infrastructure**: ~$49,400/year

### **GRAND TOTAL (First Year)**: ~$286,100

### **Ongoing (Year 2+)**: ~$107,000/year

**Value Created**: $1.8M/year (1,500 patients × $1,200 savings from reduced duplicate testing)
**Net Benefit (Year 2+)**: +$1.69M/year (massive ROI!)

---

## Risks & Mitigations

### Risk 1: EHR Integration Complexity

**Impact**: Can't connect to all health systems
**Mitigation**: Partner with FHIR aggregators (Redox, Particle Health) who handle 500+ systems, fallback to manual upload

### Risk 2: Patient Privacy Concerns

**Impact**: Patients hesitant to connect EHRs
**Mitigation**: Clear privacy policy, patients control sharing, OAuth (patients authorize access), annual security audits

### Risk 3: Data Quality Issues

**Impact**: Imported data is incomplete/incorrect
**Mitigation**: Validation rules, allow patient corrections, display source system clearly, periodic re-sync

### Risk 4: Token Expiration

**Impact**: Connections break after 90 days
**Mitigation**: Automated refresh token flow, email patients when connection expires, easy re-authorization

### Risk 5: HIPAA Compliance

**Impact**: Violation leads to fines, lawsuits
**Mitigation**: BAAs with all partners, encryption at rest/transit, access logging, annual HIPAA training, security audits

---

**Document Owner**: CTO, HIPAA Compliance Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
