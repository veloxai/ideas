# Feature #21A-4: Dynamic Consent Management

**Part of Feature #21: Research Participation Platform (Core Infrastructure)**

---

## Overview

Traditional research consent is **static**: participants sign a paper form at enrollment and cannot change preferences without contacting the study team. This creates problems:

1. **Inflexibility** - Participants can't granularly control what data is shared or revoke consent to specific studies
2. **Poor transparency** - Participants don't know how their data is being used
3. **Compliance burden** - Manual consent tracking, difficult audits
4. **Re-consent challenges** - Protocol amendments require re-contacting all participants

Fair Underwriting implements **dynamic consent**: a digital, granular, auditable consent system where participants can:

- **Opt in/out of specific studies** without affecting registry participation
- **Control data sharing** at the data type level (genetic, clinical, surveys, wearables)
- **View consent usage** - see which studies are using their data
- **Revoke consent** instantly with automated data withdrawal
- **Receive updates** when studies change protocols (e-consent amendments)

---

## Tiered Consent Model

### Consent Hierarchy

```typescript
interface ConsentHierarchy {
  // Level 1: Registry Consent (required for any research)
  registryConsent: {
    consentId: string;
    userId: string;
    version: string; // e.g., "v2.1"
    accepted: boolean;
    acceptedDate: Date;
    expirationDate?: Date; // Optional consent renewal

    // Core permissions
    permissions: {
      enrollInRegistry: boolean; // Always true if accepted
      dataStorage: boolean;
      futureContact: boolean; // Can we contact about new studies?
    };
  };

  // Level 2: Data Sharing Preferences (granular control)
  dataSharing: {
    // Broad categories
    clinicalData: boolean; // EHR, claims, spirometry, labs
    geneticData: boolean; // Phenotype, sequencing
    patientReportedData: boolean; // Surveys, symptoms
    wearableData: boolean; // Home spirometer, activity tracker
    biosamples: boolean; // If applicable

    // Specific data types (override broad categories)
    dataTypeOverrides: {
      [dataType: string]: boolean; // e.g., {"imaging": false} even if clinicalData: true
    };
  };

  // Level 3: Study-Specific Consent
  studyConsents: {
    studyId: string;
    studyTitle: string;
    consentVersion: string;
    accepted: boolean;
    acceptedDate: Date;
    revokedDate?: Date;

    // Study-specific permissions
    permissions: {
      participateInStudy: boolean;
      receiveStudyUpdates: boolean;
      shareDataWithCollaborators: boolean; // External researchers
      publishDeidentifiedData: boolean; // In papers, databases
      recontactForFollowUp: boolean;
    };
  }[];

  // Level 4: Secondary Use Consent
  secondaryUse: {
    commercialResearch: boolean; // Pharma can use data?
    internationalSharing: boolean; // Share with non-US researchers?
    publicDataSharing: boolean; // Contribute to public databases (e.g., dbGaP)
    aiMachineLearning: boolean; // Use data for AI model training?
  };
}
```

### Consent Database Schema

```sql
-- Main consent table
CREATE TABLE research_consents (
  consent_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  consent_type VARCHAR(50) NOT NULL, -- 'registry', 'study', 'data_sharing', 'secondary_use'

  -- Consent document reference
  consent_version VARCHAR(20) NOT NULL, -- e.g., "v2.1"
  consent_document_url TEXT, -- PDF/HTML consent form

  -- Status
  status VARCHAR(20) NOT NULL, -- 'active', 'revoked', 'expired', 'superseded'
  accepted_date TIMESTAMPTZ NOT NULL,
  revoked_date TIMESTAMPTZ,
  expiration_date TIMESTAMPTZ,

  -- Permissions (JSONB for flexibility)
  permissions JSONB NOT NULL,
  /*
  {
    "enrollInRegistry": true,
    "dataStorage": true,
    "futureContact": true
  }
  */

  -- Study-specific (if consent_type = 'study')
  study_id UUID,

  -- Provenance
  consent_method VARCHAR(50), -- 'web_form', 'mobile_app', 'paper_scan', 'phone_verbal'
  ip_address VARCHAR(45), -- For audit trail
  user_agent TEXT,

  -- Witness (if required by IRB)
  witnessed_by UUID, -- User ID of witness (e.g., study coordinator)
  witness_signature TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (study_id) REFERENCES natural_history_studies(id),
  FOREIGN KEY (witnessed_by) REFERENCES users(id)
);

CREATE INDEX idx_research_consents_user ON research_consents(user_id);
CREATE INDEX idx_research_consents_study ON research_consents(study_id);
CREATE INDEX idx_research_consents_status ON research_consents(status);
CREATE INDEX idx_research_consents_type ON research_consents(consent_type);

-- Consent audit log (immutable)
CREATE TABLE consent_audit_log (
  log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consent_id UUID NOT NULL,
  user_id UUID NOT NULL,

  -- Action
  action VARCHAR(50) NOT NULL, -- 'accepted', 'revoked', 'updated', 'viewed', 'downloaded'

  -- Context
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  ip_address VARCHAR(45),
  user_agent TEXT,

  -- Changes (if action = 'updated')
  old_permissions JSONB,
  new_permissions JSONB,

  -- Reason (if action = 'revoked')
  revocation_reason TEXT,

  FOREIGN KEY (consent_id) REFERENCES research_consents(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_consent_audit_log_consent ON consent_audit_log(consent_id);
CREATE INDEX idx_consent_audit_log_user ON consent_audit_log(user_id);
CREATE INDEX idx_consent_audit_log_timestamp ON consent_audit_log(timestamp);

-- Consent versions (templates)
CREATE TABLE consent_templates (
  template_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consent_type VARCHAR(50) NOT NULL,
  version VARCHAR(20) NOT NULL,

  -- Content
  title TEXT NOT NULL,
  content TEXT NOT NULL, -- HTML or Markdown
  summary TEXT, -- Plain text summary

  -- IRB approval
  irb_approval_number VARCHAR(50),
  irb_approval_date DATE,

  -- Validity
  effective_date DATE NOT NULL,
  expiration_date DATE,
  superseded_by UUID, -- Next version

  -- Metadata
  requires_witness BOOLEAN DEFAULT false,
  renewal_period_months INTEGER, -- NULL = no renewal required

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (superseded_by) REFERENCES consent_templates(template_id)
);

CREATE INDEX idx_consent_templates_type_version ON consent_templates(consent_type, version);
CREATE INDEX idx_consent_templates_effective ON consent_templates(effective_date);

-- Data usage tracking (which studies are using participant data)
CREATE TABLE data_usage_tracking (
  usage_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,
  study_id UUID NOT NULL,

  -- What data was accessed
  data_type VARCHAR(50) NOT NULL, -- 'clinical', 'genetic', 'survey', 'wearable'
  data_elements TEXT[], -- Specific fields accessed

  -- When
  access_date TIMESTAMPTZ NOT NULL,

  -- Who
  accessed_by UUID NOT NULL, -- Researcher user ID
  access_purpose TEXT, -- e.g., "Analyzing FEV1 decline rates"

  -- Consent verification (snapshot at time of access)
  consent_id UUID NOT NULL,
  consent_status VARCHAR(20) NOT NULL, -- 'active' at time of access

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id),
  FOREIGN KEY (study_id) REFERENCES natural_history_studies(id),
  FOREIGN KEY (accessed_by) REFERENCES users(id),
  FOREIGN KEY (consent_id) REFERENCES research_consents(id)
);

CREATE INDEX idx_data_usage_tracking_participant ON data_usage_tracking(participant_id);
CREATE INDEX idx_data_usage_tracking_study ON data_usage_tracking(study_id);
CREATE INDEX idx_data_usage_tracking_date ON data_usage_tracking(access_date);
```

---

## Consent Collection Workflows

### Registry Consent (Initial Enrollment)

```typescript
class ConsentCollectionService {
  async presentRegistryConsent(userId: string): Promise<ConsentPresentation> {
    // 1. Get latest registry consent template
    const template = await this.db.findOne(
      'consent_templates',
      {
        consent_type: 'registry',
        effective_date: { '<=': new Date() },
        expiration_date: { '>': new Date() }
      },
      { orderBy: 'version DESC' }
    );

    // 2. Check if user already consented to this version
    const existing = await this.db.findOne('research_consents', {
      user_id: userId,
      consent_type: 'registry',
      consent_version: template.version,
      status: 'active'
    });

    if (existing) {
      return {
        alreadyConsented: true,
        consentId: existing.consent_id,
        consentDate: existing.accepted_date
      };
    }

    // 3. Present consent form
    return {
      alreadyConsented: false,
      template: {
        templateId: template.template_id,
        version: template.version,
        title: template.title,
        content: template.content,
        summary: template.summary,
        requiresWitness: template.requires_witness
      }
    };
  }

  async acceptRegistryConsent(
    userId: string,
    templateId: string,
    ipAddress: string,
    userAgent: string
  ): Promise<Consent> {
    // 1. Get template
    const template = await this.db.findById('consent_templates', templateId);

    // 2. Create consent record
    const consent: Consent = {
      consentId: uuidv4(),
      userId,
      consentType: 'registry',
      consentVersion: template.version,
      consentDocumentUrl: await this.generateConsentPDF(template, userId),
      status: 'active',
      acceptedDate: new Date(),
      revokedDate: null,
      expirationDate: template.renewal_period_months
        ? this.addMonths(new Date(), template.renewal_period_months)
        : null,
      permissions: {
        enrollInRegistry: true,
        dataStorage: true,
        futureContact: true // Default: yes, can be changed later
      },
      studyId: null,
      consentMethod: 'web_form',
      ipAddress,
      userAgent,
      witnessedBy: null,
      witnessSignature: null,
      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('research_consents', consent);

    // 3. Log audit trail
    await this.logConsentAction(
      consent.consentId,
      userId,
      'accepted',
      ipAddress,
      userAgent
    );

    // 4. Trigger registry enrollment
    await this.registryService.enrollParticipant(userId);

    return consent;
  }

  async generateConsentPDF(
    template: ConsentTemplate,
    userId: string
  ): Promise<string> {
    const user = await this.userService.getUser(userId);

    // Populate template with user data
    const populatedContent = template.content
      .replace('{{userName}}', `${user.first_name} ${user.last_name}`)
      .replace('{{userEmail}}', user.email)
      .replace('{{consentDate}}', new Date().toLocaleDateString())
      .replace('{{consentVersion}}', template.version);

    // Generate PDF
    const pdf = await this.pdfService.generateFromHTML(populatedContent, {
      title: template.title,
      footer: `Version ${template.version} | ${new Date().toLocaleDateString()}`
    });

    // Upload to S3
    const s3Key = `consents/${userId}/${template.consent_type}_${template.version}_${Date.now()}.pdf`;
    await this.s3.upload({
      bucket: process.env.CONSENT_BUCKET,
      key: s3Key,
      body: pdf,
      contentType: 'application/pdf'
    });

    return `https://${process.env.CONSENT_BUCKET}.s3.amazonaws.com/${s3Key}`;
  }
}
```

### Study-Specific Consent

```typescript
class StudyConsentService {
  async inviteToStudy(userId: string, studyId: string): Promise<void> {
    const study = await this.db.findById('natural_history_studies', studyId);
    const participant = await this.registryService.getParticipant(userId);

    // 1. Check if participant meets eligibility criteria
    const eligibility = await this.cohortBuilder.checkEligibility(
      participant,
      study.design.inclusionCriteria,
      study.design.exclusionCriteria
    );

    if (!eligibility.matches) {
      throw new Error('Participant not eligible for study');
    }

    // 2. Check if already consented
    const existing = await this.db.findOne('research_consents', {
      user_id: userId,
      study_id: studyId,
      status: 'active'
    });

    if (existing) {
      throw new Error('Already consented to this study');
    }

    // 3. Send invitation
    await this.emailService.send({
      to: userId,
      subject: `Research Opportunity: ${study.title}`,
      template: 'study_invitation',
      data: {
        studyTitle: study.title,
        studyDescription: study.description,
        duration: study.design.duration,
        compensation: study.retentionStrategy.incentives,
        consentUrl: `/research/studies/${studyId}/consent`
      }
    });

    // 4. Create in-app notification
    await this.notificationService.send({
      userId,
      type: 'study_invitation',
      title: `You're Invited to Join ${study.title}`,
      message: study.description,
      actionUrl: `/research/studies/${studyId}/consent`
    });
  }

  async presentStudyConsent(
    userId: string,
    studyId: string
  ): Promise<StudyConsentPresentation> {
    const study = await this.db.findById('natural_history_studies', studyId);

    // Get study-specific consent template (or use default)
    const template =
      (await this.db.findOne('consent_templates', {
        consent_type: 'study',
        study_id: studyId
      })) || (await this.getDefaultStudyConsentTemplate());

    // Populate with study details
    const populatedContent = template.content
      .replace('{{studyTitle}}', study.title)
      .replace('{{studyDescription}}', study.description)
      .replace('{{studyDuration}}', `${study.design.duration} months`)
      .replace(
        '{{primaryEndpoints}}',
        study.primaryEndpoints.map((e) => e.name).join(', ')
      )
      .replace(
        '{{dataCollectionSchedule}}',
        this.formatDataCollectionSchedule(study)
      )
      .replace(
        '{{compensation}}',
        this.formatCompensation(study.retentionStrategy.incentives)
      );

    return {
      studyTitle: study.title,
      template: {
        templateId: template.template_id,
        version: template.version,
        content: populatedContent,
        summary: template.summary
      },

      // Key study details
      studyDetails: {
        duration: study.design.duration,
        visits: 1 + study.dataCollectionSchedule.followUp.length,
        compensation: study.retentionStrategy.incentives,
        timeCommitment: this.estimateTimeCommitment(study)
      },

      // What data will be collected
      dataCollectionSummary: {
        clinicalData: this.listClinicalDataTypes(study),
        surveys: this.listSurveyTypes(study),
        procedures: this.listProcedures(study)
      },

      // Risks and benefits
      risksAndBenefits: {
        risks: [
          'Minimal risk - survey completion, routine clinical tests',
          'Privacy risk - data breach (mitigated by encryption)',
          'Time burden - ~2 hours per visit'
        ],
        benefits: [
          'Contribute to AATD research',
          'Access to study results',
          `Compensation: ${this.formatCompensation(study.retentionStrategy.incentives)}`,
          'Close disease monitoring'
        ]
      }
    };
  }

  async acceptStudyConsent(
    userId: string,
    studyId: string,
    templateId: string,
    permissions: StudyConsentPermissions,
    ipAddress: string,
    userAgent: string
  ): Promise<Consent> {
    const template = await this.db.findById('consent_templates', templateId);

    const consent: Consent = {
      consentId: uuidv4(),
      userId,
      consentType: 'study',
      consentVersion: template.version,
      consentDocumentUrl: await this.generateConsentPDF(
        template,
        userId,
        studyId
      ),
      status: 'active',
      acceptedDate: new Date(),
      revokedDate: null,
      expirationDate: null,
      permissions,
      studyId,
      consentMethod: 'web_form',
      ipAddress,
      userAgent,
      witnessedBy: null,
      witnessSignature: null,
      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('research_consents', consent);
    await this.logConsentAction(
      consent.consentId,
      userId,
      'accepted',
      ipAddress,
      userAgent
    );

    // Enroll participant in study
    await this.studyEnrollmentService.enrollParticipant(studyId, userId);

    return consent;
  }
}
```

---

## Dynamic Consent Management

### Granular Permission Control

```typescript
class ConsentPermissionService {
  async updateDataSharingPreferences(
    userId: string,
    newPreferences: DataSharingPreferences
  ): Promise<void> {
    // 1. Get current registry consent
    const registryConsent = await this.db.findOne('research_consents', {
      user_id: userId,
      consent_type: 'registry',
      status: 'active'
    });

    if (!registryConsent) {
      throw new Error('No active registry consent found');
    }

    // 2. Store old preferences for audit
    const oldPreferences = registryConsent.permissions.dataSharing;

    // 3. Update permissions
    await this.db.update('research_consents', registryConsent.consent_id, {
      'permissions.dataSharing': newPreferences,
      updated_at: new Date()
    });

    // 4. Log change
    await this.db.insert('consent_audit_log', {
      log_id: uuidv4(),
      consent_id: registryConsent.consent_id,
      user_id: userId,
      action: 'updated',
      timestamp: new Date(),
      old_permissions: { dataSharing: oldPreferences },
      new_permissions: { dataSharing: newPreferences }
    });

    // 5. If permissions were restricted, check if any studies need to be notified
    const restrictedDataTypes = this.getRestrictedDataTypes(
      oldPreferences,
      newPreferences
    );
    if (restrictedDataTypes.length > 0) {
      await this.notifyStudiesOfRestriction(userId, restrictedDataTypes);
    }
  }

  getRestrictedDataTypes(
    oldPrefs: DataSharingPreferences,
    newPrefs: DataSharingPreferences
  ): string[] {
    const restricted: string[] = [];

    // Check broad categories
    if (oldPrefs.clinicalData && !newPrefs.clinicalData)
      restricted.push('clinicalData');
    if (oldPrefs.geneticData && !newPrefs.geneticData)
      restricted.push('geneticData');
    if (oldPrefs.patientReportedData && !newPrefs.patientReportedData)
      restricted.push('patientReportedData');
    if (oldPrefs.wearableData && !newPrefs.wearableData)
      restricted.push('wearableData');

    // Check specific overrides
    for (const [dataType, allowed] of Object.entries(
      newPrefs.dataTypeOverrides || {}
    )) {
      if (oldPrefs.dataTypeOverrides?.[dataType] !== false && !allowed) {
        restricted.push(dataType);
      }
    }

    return restricted;
  }

  async notifyStudiesOfRestriction(
    userId: string,
    restrictedDataTypes: string[]
  ): Promise<void> {
    // Find active studies using participant's data
    const activeStudies = await this.db.query(
      `
      SELECT DISTINCT s.study_id, s.title
      FROM study_enrollments se
      JOIN natural_history_studies s ON se.study_id = s.id
      WHERE
        se.participant_id = (SELECT id FROM registry_participants WHERE user_id = $1)
        AND se.status = 'active'
    `,
      [userId]
    );

    for (const study of activeStudies) {
      // Notify study coordinators
      await this.notificationService.send({
        userId: study.principal_investigator_id,
        type: 'participant_consent_changed',
        title: `Participant Restricted Data Sharing`,
        message: `A participant in ${study.title} has restricted access to: ${restrictedDataTypes.join(', ')}`,
        priority: 'medium'
      });
    }
  }
}
```

### Consent Revocation

```typescript
class ConsentRevocationService {
  async revokeStudyConsent(
    userId: string,
    studyId: string,
    reason: string
  ): Promise<void> {
    // 1. Find active consent
    const consent = await this.db.findOne('research_consents', {
      user_id: userId,
      study_id: studyId,
      status: 'active'
    });

    if (!consent) {
      throw new Error('No active consent found for this study');
    }

    // 2. Update consent status
    await this.db.update('research_consents', consent.consent_id, {
      status: 'revoked',
      revoked_date: new Date(),
      updated_at: new Date()
    });

    // 3. Log revocation
    await this.db.insert('consent_audit_log', {
      log_id: uuidv4(),
      consent_id: consent.consent_id,
      user_id: userId,
      action: 'revoked',
      timestamp: new Date(),
      revocation_reason: reason
    });

    // 4. Withdraw participant from study
    await this.withdrawFromStudy(userId, studyId);

    // 5. Notify study team
    const study = await this.db.findById('natural_history_studies', studyId);
    await this.notificationService.send({
      userId: study.principal_investigator_id,
      type: 'participant_withdrew',
      title: `Participant Withdrew from ${study.title}`,
      message: `Reason: ${reason}`,
      priority: 'high'
    });
  }

  async withdrawFromStudy(userId: string, studyId: string): Promise<void> {
    // 1. Update enrollment status
    await this.db.query(
      `
      UPDATE study_enrollments
      SET
        status = 'withdrawn',
        withdrawal_date = NOW(),
        updated_at = NOW()
      WHERE
        participant_id = (SELECT id FROM registry_participants WHERE user_id = $1)
        AND study_id = $2
        AND status = 'active'
    `,
      [userId, studyId]
    );

    // 2. Cancel future data collection tasks
    await this.db.query(
      `
      UPDATE data_collection_tasks
      SET
        status = 'cancelled',
        updated_at = NOW()
      WHERE
        enrollment_id IN (
          SELECT enrollment_id
          FROM study_enrollments se
          JOIN registry_participants rp ON se.participant_id = rp.id
          WHERE rp.user_id = $1 AND se.study_id = $2
        )
        AND status = 'pending'
    `,
      [userId, studyId]
    );

    // 3. Handle data retention based on consent
    await this.handleDataRetention(userId, studyId);
  }

  async handleDataRetention(userId: string, studyId: string): Promise<void> {
    // Check if consent specifies data deletion upon withdrawal
    const consent = await this.db.findOne('research_consents', {
      user_id: userId,
      study_id: studyId,
      status: 'revoked'
    });

    // Most research consents allow retention of de-identified data collected before withdrawal
    // But participant can request deletion

    const retainData = consent.permissions.retainDataAfterWithdrawal !== false; // Default: true

    if (!retainData) {
      // Delete participant's data from study database
      await this.deleteStudyData(userId, studyId);
    } else {
      // De-identify but retain data
      await this.deidentifyStudyData(userId, studyId);
    }
  }

  async deleteStudyData(userId: string, studyId: string): Promise<void> {
    const participantId = await this.db.queryOne(
      `
      SELECT id FROM registry_participants WHERE user_id = $1
    `,
      [userId]
    );

    // Delete study-specific data
    await this.db.query(
      `
      DELETE FROM data_usage_tracking
      WHERE participant_id = $1 AND study_id = $2
    `,
      [participantId, studyId]
    );

    // Log deletion for audit
    await this.db.insert('data_deletion_log', {
      log_id: uuidv4(),
      participant_id: participantId,
      study_id: studyId,
      deletion_date: new Date(),
      deletion_reason: 'consent_revoked',
      deleted_records: ['data_usage_tracking', 'study_specific_data']
    });
  }
}
```

---

## Consent Transparency Dashboard

### Participant View

```typescript
interface ConsentDashboard {
  userId: string;

  // Active Consents
  activeConsents: {
    registryConsent: {
      consentId: string;
      version: string;
      acceptedDate: Date;
      expiresDate?: Date;
      permissions: any;
    };

    studyConsents: {
      studyId: string;
      studyTitle: string;
      consentId: string;
      acceptedDate: Date;
      permissions: any;
    }[];

    dataSharing: {
      clinicalData: boolean;
      geneticData: boolean;
      patientReportedData: boolean;
      wearableData: boolean;
      secondaryUse: any;
    };
  };

  // Data Usage Summary
  dataUsage: {
    totalAccesses: number;
    lastAccessDate: Date;

    byStudy: {
      studyId: string;
      studyTitle: string;
      accessCount: number;
      dataTypes: string[];
      lastAccess: Date;
    }[];

    byDataType: {
      dataType: string;
      accessCount: number;
      studies: string[]; // Study titles
    }[];
  };

  // Revocation History
  revocationHistory: {
    consentId: string;
    studyTitle?: string;
    revokedDate: Date;
    reason: string;
  }[];
}

class ConsentDashboardService {
  async getDashboard(userId: string): Promise<ConsentDashboard> {
    // 1. Get active consents
    const activeConsents = await this.getActiveConsents(userId);

    // 2. Get data usage summary
    const dataUsage = await this.getDataUsageSummary(userId);

    // 3. Get revocation history
    const revocationHistory = await this.getRevocationHistory(userId);

    return {
      userId,
      activeConsents,
      dataUsage,
      revocationHistory
    };
  }

  async getDataUsageSummary(userId: string): Promise<any> {
    const participantId = await this.db.queryOne(
      `
      SELECT id FROM registry_participants WHERE user_id = $1
    `,
      [userId]
    );

    // Total accesses
    const totalAccesses = await this.db.count('data_usage_tracking', {
      participant_id: participantId
    });

    // Last access
    const lastAccess = await this.db.queryOne(
      `
      SELECT access_date
      FROM data_usage_tracking
      WHERE participant_id = $1
      ORDER BY access_date DESC
      LIMIT 1
    `,
      [participantId]
    );

    // By study
    const byStudy = await this.db.query(
      `
      SELECT
        s.id AS study_id,
        s.title AS study_title,
        COUNT(*) AS access_count,
        array_agg(DISTINCT dut.data_type) AS data_types,
        MAX(dut.access_date) AS last_access
      FROM data_usage_tracking dut
      JOIN natural_history_studies s ON dut.study_id = s.id
      WHERE dut.participant_id = $1
      GROUP BY s.id, s.title
      ORDER BY access_count DESC
    `,
      [participantId]
    );

    // By data type
    const byDataType = await this.db.query(
      `
      SELECT
        dut.data_type,
        COUNT(*) AS access_count,
        array_agg(DISTINCT s.title) AS studies
      FROM data_usage_tracking dut
      JOIN natural_history_studies s ON dut.study_id = s.id
      WHERE dut.participant_id = $1
      GROUP BY dut.data_type
      ORDER BY access_count DESC
    `,
      [participantId]
    );

    return {
      totalAccesses,
      lastAccessDate: lastAccess?.access_date,
      byStudy,
      byDataType
    };
  }
}
```

### Researcher View (Compliance Dashboard)

```typescript
interface StudyConsentComplianceDashboard {
  studyId: string;
  studyTitle: string;

  // Enrollment & Consent
  enrollment: {
    targetEnrollment: number;
    currentEnrollment: number;

    consentStatus: {
      fullConsent: number; // All permissions granted
      partialConsent: number; // Some data types restricted
      withdrawn: number;
    };
  };

  // Consent Expiration Tracking
  expiringConsents: {
    participantId: string;
    consentId: string;
    expirationDate: Date;
    daysUntilExpiration: number;
  }[];

  // Data Access Compliance
  dataAccessCompliance: {
    totalDataAccesses: number;
    unauthorizedAccessAttempts: number; // Tried to access restricted data

    recentAccesses: {
      accessDate: Date;
      participantId: string;
      dataType: string;
      accessedBy: string; // Researcher name
      consentStatus: string; // 'valid', 'expired', 'revoked'
    }[];
  };

  // Protocol Amendments (require re-consent)
  protocolAmendments: {
    amendmentId: string;
    amendmentDate: Date;
    description: string;
    requiresReconsent: boolean;

    reconsentProgress: {
      totalParticipants: number;
      reconsented: number;
      pending: number;
      declined: number;
    };
  }[];
}

class ResearcherConsentDashboardService {
  async getStudyComplianceDashboard(
    studyId: string
  ): Promise<StudyConsentComplianceDashboard> {
    const study = await this.db.findById('natural_history_studies', studyId);

    // Enrollment stats
    const enrollment = await this.getEnrollmentStats(studyId);

    // Expiring consents
    const expiringConsents = await this.getExpiringConsents(studyId);

    // Data access compliance
    const dataAccessCompliance = await this.getDataAccessCompliance(studyId);

    // Protocol amendments
    const protocolAmendments = await this.getProtocolAmendments(studyId);

    return {
      studyId,
      studyTitle: study.title,
      enrollment,
      expiringConsents,
      dataAccessCompliance,
      protocolAmendments
    };
  }

  async getExpiringConsents(studyId: string): Promise<any[]> {
    return await this.db.query(
      `
      SELECT
        rc.consent_id,
        se.participant_id,
        rc.expiration_date,
        EXTRACT(DAY FROM rc.expiration_date - NOW()) AS days_until_expiration
      FROM research_consents rc
      JOIN study_enrollments se ON rc.user_id = (
        SELECT user_id FROM registry_participants WHERE id = se.participant_id
      )
      WHERE
        se.study_id = $1
        AND rc.status = 'active'
        AND rc.expiration_date IS NOT NULL
        AND rc.expiration_date BETWEEN NOW() AND NOW() + INTERVAL '60 days'
      ORDER BY rc.expiration_date ASC
    `,
      [studyId]
    );
  }

  async detectUnauthorizedAccess(
    studyId: string,
    participantId: string,
    dataType: string
  ): Promise<boolean> {
    // Check if researcher has consent to access this data type
    const consent = await this.db.findOne('research_consents', {
      user_id: (await this.db.findById('registry_participants', participantId))
        .user_id,
      study_id: studyId,
      status: 'active'
    });

    if (!consent) {
      // No active consent - unauthorized
      await this.logUnauthorizedAccess(
        studyId,
        participantId,
        dataType,
        'no_active_consent'
      );
      return true;
    }

    // Check if data type is permitted
    const dataSharing = consent.permissions.dataSharing;
    let permitted = false;

    if (dataType === 'clinical') permitted = dataSharing.clinicalData;
    else if (dataType === 'genetic') permitted = dataSharing.geneticData;
    else if (dataType === 'survey') permitted = dataSharing.patientReportedData;
    else if (dataType === 'wearable') permitted = dataSharing.wearableData;

    // Check overrides
    if (dataSharing.dataTypeOverrides?.[dataType] !== undefined) {
      permitted = dataSharing.dataTypeOverrides[dataType];
    }

    if (!permitted) {
      await this.logUnauthorizedAccess(
        studyId,
        participantId,
        dataType,
        'data_type_restricted'
      );
      return true;
    }

    return false; // Authorized
  }
}
```

---

## Protocol Amendment Management

### Re-Consent Workflow

```typescript
class ProtocolAmendmentService {
  async createAmendment(
    studyId: string,
    amendment: {
      description: string;
      changes: string[];
      requiresReconsent: boolean;
      newConsentVersion: string;
    }
  ): Promise<void> {
    // 1. Create amendment record
    const amendmentId = uuidv4();
    await this.db.insert('protocol_amendments', {
      amendment_id: amendmentId,
      study_id: studyId,
      description: amendment.description,
      changes: amendment.changes,
      requires_reconsent: amendment.requiresReconsent,
      new_consent_version: amendment.newConsentVersion,
      amendment_date: new Date(),
      created_at: new Date()
    });

    if (!amendment.requiresReconsent) {
      // Just notify participants
      await this.notifyParticipantsOfAmendment(studyId, amendment.description);
      return;
    }

    // 2. Get all active participants
    const participants = await this.db.query(
      `
      SELECT se.participant_id, rp.user_id
      FROM study_enrollments se
      JOIN registry_participants rp ON se.participant_id = rp.id
      WHERE se.study_id = $1 AND se.status = 'active'
    `,
      [studyId]
    );

    // 3. Create re-consent tasks for each participant
    for (const participant of participants) {
      await this.createReconsentTask({
        userId: participant.user_id,
        studyId,
        amendmentId,
        newConsentVersion: amendment.newConsentVersion,
        dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days
      });
    }

    // 4. Send notifications
    await this.notifyParticipantsOfReconsent(
      studyId,
      amendment.description,
      amendment.changes
    );
  }

  async notifyParticipantsOfReconsent(
    studyId: string,
    description: string,
    changes: string[]
  ): Promise<void> {
    const study = await this.db.findById('natural_history_studies', studyId);
    const participants = await this.db.query(
      `
      SELECT rp.user_id
      FROM study_enrollments se
      JOIN registry_participants rp ON se.participant_id = rp.id
      WHERE se.study_id = $1 AND se.status = 'active'
    `,
      [studyId]
    );

    for (const participant of participants) {
      await this.emailService.send({
        to: participant.user_id,
        subject: `Important Update: ${study.title} Protocol Amendment`,
        template: 'protocol_amendment_reconsent',
        data: {
          studyTitle: study.title,
          amendmentDescription: description,
          changes: changes,
          reconsentUrl: `/research/studies/${studyId}/reconsent`,
          deadline: this.formatDate(
            new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
          )
        }
      });

      await this.notificationService.send({
        userId: participant.user_id,
        type: 'reconsent_required',
        title: `Action Required: ${study.title} Protocol Update`,
        message: `The study protocol has been updated. Please review and re-consent within 30 days.`,
        priority: 'high',
        actionUrl: `/research/studies/${studyId}/reconsent`
      });
    }
  }

  async trackReconsentProgress(
    amendmentId: string
  ): Promise<ReconsentProgress> {
    const amendment = await this.db.findById(
      'protocol_amendments',
      amendmentId
    );

    const totalParticipants = await this.db.count('study_enrollments', {
      study_id: amendment.study_id,
      status: 'active'
    });

    const reconsented = await this.db.count('reconsent_tasks', {
      amendment_id: amendmentId,
      status: 'completed'
    });

    const declined = await this.db.count('reconsent_tasks', {
      amendment_id: amendmentId,
      status: 'declined'
    });

    const pending = totalParticipants - reconsented - declined;

    return {
      amendmentId,
      totalParticipants,
      reconsented,
      declined,
      pending,
      completionRate: (reconsented / totalParticipants) * 100
    };
  }
}
```

---

## Budget & Success Metrics

### Development Costs (3-4 months)

- **Backend Developer** (consent APIs, audit trail): $140K/year × 0.33 = $46,200
- **Frontend Developer** (consent UI, dashboard): $140K/year × 0.33 = $46,200
- **Compliance Specialist** (consent templates, IRB coordination): $130K/year × 0.25 = $32,500
- **Legal Review** (consent language): $15,000 flat fee

**Total**: ~$140,000

### Annual Operations

- **Consent Storage & Audit Trail** (S3, database): $6,000/year
- **Compliance Monitoring**: $8,000/year
- **IRB Renewals**: $5,000/year

**Total**: ~$19,000/year

### Success Metrics

- **Consent Collection**: 95% of invited participants complete consent within 7 days
- **Granular Control**: 80% of participants customize data sharing preferences
- **Transparency**: Average 3 logins to consent dashboard per participant per year
- **Revocation Response Time**: <24 hours to process consent revocation
- **Re-Consent Rate**: 90% of participants re-consent after protocol amendments

---

**Document Status:** Complete
**Next Document:** MISSING_FEATURES_21A5_DASHBOARDS.md
