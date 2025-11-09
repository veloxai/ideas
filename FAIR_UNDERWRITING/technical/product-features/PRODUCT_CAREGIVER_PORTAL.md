# Feature #15: Caregiver Portal (Family Management Tools)

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 frontend developer, 0.25 FTE UX designer

---

## Executive Summary

AATD patients often rely on family caregivers—spouses managing multiple medications, adult children coordinating aging parents' care, parents tracking pediatric AATD. Current platform assumes single-user model, forcing caregivers to share passwords (HIPAA violation) or remain locked out (care coordination breakdown). Fair Underwriting needs HIPAA-compliant caregiver accounts with granular permissions, enabling family members to help manage testing, medications, appointments, and insurance without compromising patient privacy.

**Key Value Propositions**:

- **Caregiver Accounts**: HIPAA-compliant delegated access (patient authorizes, caregiver logs in separately)
- **Granular Permissions**: Patient controls what caregivers see (medications yes, mental health records no)
- **Multi-Patient Management**: One caregiver dashboard for multiple family members
- **Task Coordination**: Shared to-do lists (schedule PFT, refill Prolastin, submit PA)
- **Care Team Communication**: Secure messaging between patient, caregivers, providers
- **Emergency Access**: Break-glass override for emergencies (logged, time-limited)

**Business Impact**:

- Serve pediatric AATD market: 3,000+ children with AATD in US
- Improve elderly patient retention: 65+ patients have 40% higher churn without caregiver support
- Reduce support tickets: 25% of calls are "how can my spouse help me?"
- Medication adherence: +18% when caregiver receives refill reminders
- Competitive advantage: Only genetic testing platform with caregiver features

---

## Problem Statement

### Current Gaps

**Scenario 1: Spouse Managing Multiple Medications**

> "My husband has ZZ AATD. He takes 8 medications. I help him track refills, prior authorizations, and infusion schedules. But I can't log into Fair Underwriting to see his medication list or set reminders. He gave me his password, which I know violates HIPAA. We need a legal way for me to help."

**No caregiver accounts** ❌

**Scenario 2: Adult Child Coordinating Aging Parent's Care**

> "My 78-year-old mother has AATD and early dementia. I live 2 hours away. I need to see her test results, schedule appointments, and communicate with her doctors. Currently, I have to call her multiple times, and she forgets details. I can't help her effectively."

**No remote care coordination** ❌

**Scenario 3: Parent Tracking Pediatric AATD**

> "My 12-year-old son has MZ AATD. His pulmonologist wants annual PFTs and liver ultrasounds. I need to track his growth, lung function trends, and make sure we don't miss appointments. There's no way for me to manage his account—he's too young to do it himself."

**No pediatric account management** ❌

**Scenario 4: Privacy Concerns Block Sharing**

> "I want my wife to help with medications and appointments, but I don't want her to see my mental health records or genetic counseling notes. If I give her my password, she sees everything. I need selective sharing."

**No granular permissions** ❌

**Scenario 5: Emergency Situation**

> "I collapsed at home. My husband needed my medication list and insurance info for the ER. He couldn't access my Fair Underwriting account. The doctors didn't know I have AATD or that I'm on augmentation therapy. This could have been life-threatening."

**No emergency access** ❌

---

## Feature Specifications

### 1. Caregiver Account System

**HIPAA-Compliant Delegated Access**:

```typescript
interface CaregiverRelationship {
  relationshipId: string;

  // Patient (the person being cared for)
  patientId: string;
  patientName: string;

  // Caregiver (the helper)
  caregiverId: string;
  caregiverName: string;
  caregiverEmail: string;

  // Relationship
  relationshipType:
    | 'spouse'
    | 'partner'
    | 'parent'
    | 'adult_child'
    | 'sibling'
    | 'friend'
    | 'legal_guardian'
    | 'power_of_attorney'
    | 'other';
  relationshipDescription?: string;

  // Permissions (granular access control)
  permissions: {
    // Health information
    viewMedicalHistory: boolean;
    viewLabResults: boolean;
    viewImagingReports: boolean;
    viewMedications: boolean;
    viewAppointments: boolean;
    viewInsurance: boolean;
    viewBilling: boolean;

    // Actions
    scheduleAppointments: boolean;
    requestPrescriptionRefills: boolean;
    communicateWithProviders: boolean;
    uploadDocuments: boolean;
    exportRecords: boolean;

    // Sensitive (usually restricted)
    viewMentalHealthRecords: boolean;
    viewGeneticCounseling: boolean;
    viewSensitiveNotes: boolean;
  };

  // Status
  status: 'pending' | 'active' | 'suspended' | 'revoked';

  // Invitation
  invitedDate: Date;
  acceptedDate?: Date;
  invitationToken?: string;
  invitationExpiresAt?: Date;

  // Emergency access
  emergencyAccess: boolean; // Break-glass override
  emergencyAccessPin?: string; // Patient sets PIN

  // Audit
  lastAccessDate?: Date;
  accessCount: number;

  // Expiration (optional time-limited access)
  expiresAt?: Date;

  created_at: Date;
  updated_at: Date;
}

class CaregiverService {
  async inviteCaregiver(
    patientId: string,
    caregiverEmail: string,
    relationshipType: string,
    permissions: CaregiverPermissions
  ): Promise<CaregiverInvitation> {
    // Generate invitation token
    const invitationToken = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days

    // Create pending relationship
    const relationship: CaregiverRelationship = {
      relationshipId: uuidv4(),
      patientId,
      patientName: await this.getPatientName(patientId),
      caregiverId: null, // Will be set when caregiver accepts
      caregiverName: null,
      caregiverEmail,
      relationshipType,
      relationshipDescription: null,
      permissions,
      status: 'pending',
      invitedDate: new Date(),
      invitationToken,
      invitationExpiresAt: expiresAt,
      emergencyAccess: false,
      accessCount: 0,
      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('caregiver_relationships', relationship);

    // Send invitation email
    await this.emailService.sendCaregiverInvitation({
      to: caregiverEmail,
      patientName: relationship.patientName,
      invitationUrl: `${process.env.APP_URL}/caregiver/accept/${invitationToken}`,
      expiresAt,
      relationshipType
    });

    // Log audit event
    await this.auditLog.log({
      action: 'caregiver_invited',
      userId: patientId,
      details: {
        caregiverEmail,
        relationshipType,
        permissions
      }
    });

    return {
      relationshipId: relationship.relationshipId,
      invitationUrl: `${process.env.APP_URL}/caregiver/accept/${invitationToken}`,
      expiresAt
    };
  }

  async acceptInvitation(
    token: string,
    caregiverId: string
  ): Promise<CaregiverRelationship> {
    // Find invitation
    const relationship = await this.db.findOne('caregiver_relationships', {
      invitation_token: token,
      status: 'pending'
    });

    if (!relationship) {
      throw new Error('Invalid or expired invitation');
    }

    if (new Date() > relationship.invitation_expires_at) {
      throw new Error('Invitation has expired');
    }

    // Update relationship
    const updated = await this.db.update(
      'caregiver_relationships',
      relationship.relationship_id,
      {
        caregiver_id: caregiverId,
        caregiver_name: await this.getUserName(caregiverId),
        status: 'active',
        accepted_date: new Date(),
        invitation_token: null, // Clear token
        updated_at: new Date()
      }
    );

    // Send confirmation to patient
    await this.emailService.sendCaregiverAcceptedNotification({
      patientId: relationship.patient_id,
      caregiverName: updated.caregiver_name,
      relationshipType: relationship.relationship_type
    });

    // Log audit event
    await this.auditLog.log({
      action: 'caregiver_accepted',
      userId: relationship.patient_id,
      caregiverId,
      details: {
        relationshipType: relationship.relationship_type
      }
    });

    return updated;
  }

  async checkPermission(
    caregiverId: string,
    patientId: string,
    permission: keyof CaregiverPermissions
  ): Promise<boolean> {
    const relationship = await this.getActiveRelationship(
      caregiverId,
      patientId
    );

    if (!relationship) {
      return false;
    }

    // Check if relationship expired
    if (relationship.expires_at && new Date() > relationship.expires_at) {
      return false;
    }

    return relationship.permissions[permission] === true;
  }

  async revokeAccess(
    patientId: string,
    relationshipId: string,
    reason?: string
  ): Promise<void> {
    await this.db.update('caregiver_relationships', relationshipId, {
      status: 'revoked',
      updated_at: new Date()
    });

    // Log audit event
    await this.auditLog.log({
      action: 'caregiver_revoked',
      userId: patientId,
      details: {
        relationshipId,
        reason
      }
    });

    // Notify caregiver
    const relationship = await this.db.findById(
      'caregiver_relationships',
      relationshipId
    );
    await this.emailService.sendAccessRevokedNotification({
      caregiverId: relationship.caregiver_id,
      patientName: relationship.patient_name
    });
  }
}
```

### 2. Multi-Patient Dashboard

**Caregiver View (Managing Multiple Family Members)**:

```typescript
interface CaregiverDashboard {
  caregiverId: string;

  // All patients this caregiver helps
  patients: {
    patientId: string;
    patientName: string;
    relationship: string;
    permissions: CaregiverPermissions;

    // Quick stats
    upcomingAppointments: number;
    pendingTasks: number;
    medicationsDueToday: number;
    unreadMessages: number;

    // Recent activity
    lastLogin?: Date;
    lastLabResult?: {
      date: Date;
      name: string;
      status: 'normal' | 'abnormal';
    };
    nextAppointment?: {
      date: Date;
      provider: string;
    };
  }[];

  // Aggregated tasks across all patients
  allTasks: CareTask[];

  // Calendar (all patients' appointments)
  upcomingEvents: CalendarEvent[];
}

class CaregiverDashboardService {
  async getDashboard(caregiverId: string): Promise<CaregiverDashboard> {
    // Get all active relationships
    const relationships = await this.db.query(
      `
      SELECT * FROM caregiver_relationships
      WHERE caregiver_id = $1 AND status = 'active'
      ORDER BY patient_name
    `,
      [caregiverId]
    );

    const patients = await Promise.all(
      relationships.map(async (rel) => {
        const [appointments, tasks, medications, messages] = await Promise.all([
          this.getUpcomingAppointments(rel.patient_id, rel.permissions),
          this.getPendingTasks(rel.patient_id, rel.permissions),
          this.getMedicationsDueToday(rel.patient_id, rel.permissions),
          this.getUnreadMessages(rel.patient_id, caregiverId, rel.permissions)
        ]);

        return {
          patientId: rel.patient_id,
          patientName: rel.patient_name,
          relationship: rel.relationship_type,
          permissions: rel.permissions,
          upcomingAppointments: appointments.length,
          pendingTasks: tasks.length,
          medicationsDueToday: medications.length,
          unreadMessages: messages.length,
          lastLogin: await this.getLastLogin(rel.patient_id),
          lastLabResult: await this.getLastLabResult(
            rel.patient_id,
            rel.permissions
          ),
          nextAppointment: appointments[0] || null
        };
      })
    );

    // Aggregate tasks
    const allTasks = await this.getAggregatedTasks(caregiverId, relationships);

    // Aggregate calendar
    const upcomingEvents = await this.getAggregatedCalendar(
      caregiverId,
      relationships
    );

    return {
      caregiverId,
      patients,
      allTasks,
      upcomingEvents
    };
  }

  async getAggregatedTasks(
    caregiverId: string,
    relationships: CaregiverRelationship[]
  ): Promise<CareTask[]> {
    const allTasks: CareTask[] = [];

    for (const rel of relationships) {
      if (
        !rel.permissions.viewAppointments &&
        !rel.permissions.viewMedications
      ) {
        continue; // Skip if no task-related permissions
      }

      // Get tasks for this patient
      const tasks = await this.db.query(
        `
        SELECT * FROM care_tasks
        WHERE patient_id = $1
          AND status != 'completed'
          AND due_date > NOW()
        ORDER BY due_date ASC
        LIMIT 10
      `,
        [rel.patient_id]
      );

      // Add patient context
      tasks.forEach((task) => {
        allTasks.push({
          ...task,
          patientName: rel.patient_name,
          patientId: rel.patient_id
        });
      });
    }

    // Sort by due date
    return allTasks.sort(
      (a, b) => new Date(a.due_date).getTime() - new Date(b.due_date).getTime()
    );
  }
}
```

### 3. Shared Care Tasks

**Task Coordination System**:

```typescript
interface CareTask {
  taskId: string;
  patientId: string;

  // Task details
  title: string;
  description?: string;
  category: 'medication' | 'appointment' | 'test' | 'insurance' | 'other';

  // Assignment
  createdBy: string; // Patient or caregiver
  assignedTo: string[]; // Patient and/or caregiver IDs

  // Status
  status: 'pending' | 'in_progress' | 'completed' | 'cancelled';
  priority: 'low' | 'medium' | 'high' | 'urgent';

  // Timing
  dueDate?: Date;
  completedDate?: Date;
  completedBy?: string;

  // Reminders
  reminderDates?: Date[];

  // Related records
  relatedRecordId?: string; // Link to appointment, medication, etc.
  relatedRecordType?: string;

  // Comments
  comments: {
    commentId: string;
    userId: string;
    userName: string;
    text: string;
    createdAt: Date;
  }[];

  created_at: Date;
  updated_at: Date;
}

class CareTaskService {
  async createTask(task: Partial<CareTask>): Promise<CareTask> {
    const newTask: CareTask = {
      taskId: uuidv4(),
      patientId: task.patientId,
      title: task.title,
      description: task.description,
      category: task.category,
      createdBy: task.createdBy,
      assignedTo: task.assignedTo || [task.patientId],
      status: 'pending',
      priority: task.priority || 'medium',
      dueDate: task.dueDate,
      reminderDates: this.calculateReminders(task.dueDate),
      comments: [],
      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('care_tasks', newTask);

    // Notify assignees
    for (const userId of newTask.assignedTo) {
      await this.notificationService.send({
        userId,
        type: 'task_assigned',
        title: `New task: ${newTask.title}`,
        message: `Due ${newTask.dueDate ? this.formatDate(newTask.dueDate) : 'ASAP'}`,
        linkUrl: `/tasks/${newTask.taskId}`
      });
    }

    return newTask;
  }

  async completeTask(
    taskId: string,
    userId: string,
    notes?: string
  ): Promise<void> {
    await this.db.update('care_tasks', taskId, {
      status: 'completed',
      completed_date: new Date(),
      completed_by: userId,
      updated_at: new Date()
    });

    if (notes) {
      await this.addComment(taskId, userId, notes);
    }

    // Notify other assignees
    const task = await this.getTask(taskId);
    for (const assigneeId of task.assignedTo) {
      if (assigneeId !== userId) {
        await this.notificationService.send({
          userId: assigneeId,
          type: 'task_completed',
          title: `Task completed: ${task.title}`,
          message: `Completed by ${await this.getUserName(userId)}`,
          linkUrl: `/tasks/${taskId}`
        });
      }
    }
  }

  async addComment(
    taskId: string,
    userId: string,
    text: string
  ): Promise<void> {
    const task = await this.getTask(taskId);

    const comment = {
      commentId: uuidv4(),
      userId,
      userName: await this.getUserName(userId),
      text,
      createdAt: new Date()
    };

    task.comments.push(comment);

    await this.db.update('care_tasks', taskId, {
      comments: task.comments,
      updated_at: new Date()
    });

    // Notify other assignees
    for (const assigneeId of task.assignedTo) {
      if (assigneeId !== userId) {
        await this.notificationService.send({
          userId: assigneeId,
          type: 'task_comment',
          title: `Comment on task: ${task.title}`,
          message: text,
          linkUrl: `/tasks/${taskId}`
        });
      }
    }
  }

  // Auto-generate tasks from system events
  async autoGenerateTasks(patientId: string): Promise<void> {
    // Check for upcoming medication refills
    const medications = await this.db.query(
      `
      SELECT * FROM patient_medications
      WHERE patient_id = $1
        AND active = true
        AND refills_remaining <= 1
        AND next_refill_date BETWEEN NOW() AND NOW() + INTERVAL '7 days'
    `,
      [patientId]
    );

    for (const med of medications) {
      await this.createTask({
        patientId,
        title: `Refill ${med.medication_name}`,
        description: `${med.refills_remaining} refills remaining. Due ${this.formatDate(med.next_refill_date)}`,
        category: 'medication',
        createdBy: 'system',
        assignedTo: await this.getPatientAndCaregivers(patientId),
        dueDate: new Date(med.next_refill_date),
        priority: med.refills_remaining === 0 ? 'urgent' : 'high',
        relatedRecordId: med.medication_id,
        relatedRecordType: 'medication'
      });
    }

    // Check for overdue annual tests (PFTs, AAT level, liver ultrasound)
    const testsDue = await this.checkOverdueTests(patientId);
    for (const test of testsDue) {
      await this.createTask({
        patientId,
        title: `Schedule ${test.name}`,
        description: `Last ${test.name} was ${test.daysSinceLast} days ago. Recommended every ${test.recommendedFrequency} days.`,
        category: 'test',
        createdBy: 'system',
        assignedTo: await this.getPatientAndCaregivers(patientId),
        priority:
          test.daysSinceLast > test.recommendedFrequency * 1.5
            ? 'high'
            : 'medium',
        relatedRecordType: 'test'
      });
    }
  }
}
```

### 4. Emergency Access (Break-Glass)

**Time-Limited Override for Emergencies**:

```typescript
interface EmergencyAccess {
  accessId: string;
  relationshipId: string;

  patientId: string;
  caregiverId: string;

  // Emergency details
  reason: string;
  accessedAt: Date;
  expiresAt: Date; // 24 hours

  // Verification (patient sets PIN in advance)
  pinVerified: boolean;
  pinAttempts: number;

  // What was accessed
  accessedRecords: {
    recordId: string;
    recordType: string;
    accessedAt: Date;
  }[];

  // Notification
  patientNotified: boolean;
  patientNotifiedAt?: Date;

  // Status
  status: 'active' | 'expired' | 'revoked';

  created_at: Date;
}

class EmergencyAccessService {
  async requestEmergencyAccess(
    caregiverId: string,
    patientId: string,
    pin: string,
    reason: string
  ): Promise<EmergencyAccess> {
    // Get relationship
    const relationship = await this.db.findOne('caregiver_relationships', {
      caregiver_id: caregiverId,
      patient_id: patientId
    });

    if (!relationship) {
      throw new Error('No caregiver relationship found');
    }

    if (!relationship.emergency_access) {
      throw new Error('Emergency access not enabled for this relationship');
    }

    // Verify PIN
    const pinValid = await this.verifyEmergencyPin(
      relationship.relationship_id,
      pin
    );

    if (!pinValid) {
      // Log failed attempt
      await this.logFailedPinAttempt(relationship.relationship_id);
      throw new Error('Invalid emergency PIN');
    }

    // Create emergency access
    const access: EmergencyAccess = {
      accessId: uuidv4(),
      relationshipId: relationship.relationship_id,
      patientId,
      caregiverId,
      reason,
      accessedAt: new Date(),
      expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000), // 24 hours
      pinVerified: true,
      pinAttempts: 1,
      accessedRecords: [],
      patientNotified: false,
      status: 'active',
      created_at: new Date()
    };

    await this.db.insert('emergency_access_logs', access);

    // Notify patient immediately (email, SMS, push)
    await this.notificationService.sendUrgent({
      userId: patientId,
      channels: ['email', 'sms', 'push'],
      type: 'emergency_access_granted',
      title: '⚠️ Emergency Access Granted',
      message: `${await this.getUserName(caregiverId)} has been granted 24-hour emergency access to your health records. Reason: ${reason}`,
      actionUrl: `/settings/caregivers/emergency/${access.accessId}`
    });

    // Update notification status
    await this.db.update('emergency_access_logs', access.accessId, {
      patient_notified: true,
      patient_notified_at: new Date()
    });

    // Log audit event (high severity)
    await this.auditLog.log({
      action: 'emergency_access_granted',
      userId: patientId,
      caregiverId,
      severity: 'high',
      details: {
        reason,
        expiresAt: access.expiresAt
      }
    });

    return access;
  }

  async logRecordAccess(
    emergencyAccessId: string,
    recordId: string,
    recordType: string
  ): Promise<void> {
    const access = await this.db.findById(
      'emergency_access_logs',
      emergencyAccessId
    );

    if (access.status !== 'active') {
      throw new Error('Emergency access is not active');
    }

    if (new Date() > access.expires_at) {
      await this.expireAccess(emergencyAccessId);
      throw new Error('Emergency access has expired');
    }

    // Log what was accessed
    access.accessed_records.push({
      recordId,
      recordType,
      accessedAt: new Date()
    });

    await this.db.update('emergency_access_logs', emergencyAccessId, {
      accessed_records: access.accessed_records
    });
  }

  async revokeEmergencyAccess(
    patientId: string,
    emergencyAccessId: string
  ): Promise<void> {
    await this.db.update('emergency_access_logs', emergencyAccessId, {
      status: 'revoked',
      expires_at: new Date() // Immediate expiration
    });

    // Notify caregiver
    const access = await this.db.findById(
      'emergency_access_logs',
      emergencyAccessId
    );
    await this.notificationService.send({
      userId: access.caregiver_id,
      type: 'emergency_access_revoked',
      title: 'Emergency Access Revoked',
      message: `Your emergency access to ${await this.getUserName(patientId)}'s records has been revoked.`
    });
  }
}
```

### 5. Database Schema

```sql
-- Caregiver relationships
CREATE TABLE caregiver_relationships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Patient
  patient_id UUID NOT NULL,
  patient_name VARCHAR(300),

  -- Caregiver
  caregiver_id UUID, -- NULL until invitation accepted
  caregiver_name VARCHAR(300),
  caregiver_email VARCHAR(300) NOT NULL,

  -- Relationship
  relationship_type VARCHAR(50) NOT NULL,
  relationship_description TEXT,

  -- Permissions (JSONB for flexibility)
  permissions JSONB NOT NULL,
  /*
  {
    "viewMedicalHistory": true,
    "viewLabResults": true,
    "viewMedications": true,
    "viewAppointments": true,
    "scheduleAppointments": true,
    "requestPrescriptionRefills": true,
    "communicateWithProviders": true,
    "viewMentalHealthRecords": false,
    "viewGeneticCounseling": false
  }
  */

  -- Status
  status VARCHAR(20) DEFAULT 'pending',

  -- Invitation
  invited_date TIMESTAMPTZ NOT NULL,
  accepted_date TIMESTAMPTZ,
  invitation_token VARCHAR(64),
  invitation_expires_at TIMESTAMPTZ,

  -- Emergency access
  emergency_access BOOLEAN DEFAULT false,
  emergency_access_pin VARCHAR(255), -- Hashed

  -- Audit
  last_access_date TIMESTAMPTZ,
  access_count INTEGER DEFAULT 0,

  -- Expiration
  expires_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_id) REFERENCES users(id),
  FOREIGN KEY (caregiver_id) REFERENCES users(id)
);

CREATE INDEX idx_caregiver_relationships_patient ON caregiver_relationships(patient_id, status);
CREATE INDEX idx_caregiver_relationships_caregiver ON caregiver_relationships(caregiver_id, status);
CREATE INDEX idx_caregiver_relationships_token ON caregiver_relationships(invitation_token) WHERE status = 'pending';

-- Care tasks (shared to-do lists)
CREATE TABLE care_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL,

  -- Task details
  title VARCHAR(500) NOT NULL,
  description TEXT,
  category VARCHAR(30),

  -- Assignment
  created_by UUID NOT NULL, -- User ID (patient or caregiver)
  assigned_to UUID[], -- Array of user IDs

  -- Status
  status VARCHAR(20) DEFAULT 'pending',
  priority VARCHAR(20) DEFAULT 'medium',

  -- Timing
  due_date TIMESTAMPTZ,
  completed_date TIMESTAMPTZ,
  completed_by UUID,

  -- Reminders
  reminder_dates TIMESTAMPTZ[],

  -- Related records
  related_record_id UUID,
  related_record_type VARCHAR(50),

  -- Comments (JSONB array)
  comments JSONB DEFAULT '[]'::jsonb,
  /*
  [
    {
      "commentId": "uuid",
      "userId": "uuid",
      "userName": "John Doe",
      "text": "Called pharmacy, they need new PA",
      "createdAt": "2025-11-07T10:00:00Z"
    }
  ]
  */

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_id) REFERENCES users(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE INDEX idx_care_tasks_patient ON care_tasks(patient_id, status, due_date);
CREATE INDEX idx_care_tasks_assigned ON care_tasks USING GIN(assigned_to);

-- Emergency access logs
CREATE TABLE emergency_access_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  relationship_id UUID NOT NULL,

  -- Parties
  patient_id UUID NOT NULL,
  caregiver_id UUID NOT NULL,

  -- Emergency details
  reason TEXT NOT NULL,
  accessed_at TIMESTAMPTZ NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,

  -- Verification
  pin_verified BOOLEAN DEFAULT false,
  pin_attempts INTEGER DEFAULT 0,

  -- What was accessed (JSONB array)
  accessed_records JSONB DEFAULT '[]'::jsonb,
  /*
  [
    {
      "recordId": "uuid",
      "recordType": "medication",
      "accessedAt": "2025-11-07T10:00:00Z"
    }
  ]
  */

  -- Notification
  patient_notified BOOLEAN DEFAULT false,
  patient_notified_at TIMESTAMPTZ,

  -- Status
  status VARCHAR(20) DEFAULT 'active',

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (relationship_id) REFERENCES caregiver_relationships(id),
  FOREIGN KEY (patient_id) REFERENCES users(id),
  FOREIGN KEY (caregiver_id) REFERENCES users(id)
);

CREATE INDEX idx_emergency_access_patient ON emergency_access_logs(patient_id, status);
CREATE INDEX idx_emergency_access_caregiver ON emergency_access_logs(caregiver_id, status);
CREATE INDEX idx_emergency_access_expires ON emergency_access_logs(expires_at) WHERE status = 'active';

-- Caregiver activity log (audit trail)
CREATE TABLE caregiver_activity_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  relationship_id UUID NOT NULL,

  -- Action
  action VARCHAR(100) NOT NULL,
  -- 'viewed_medications', 'scheduled_appointment', 'requested_refill',
  -- 'exported_records', 'sent_message', etc.

  -- Context
  target_record_id UUID,
  target_record_type VARCHAR(50),

  -- Details (JSONB)
  details JSONB,

  -- IP/device tracking
  ip_address INET,
  user_agent TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (relationship_id) REFERENCES caregiver_relationships(id)
);

CREATE INDEX idx_caregiver_activity_relationship ON caregiver_activity_log(relationship_id, created_at DESC);
```

### 6. Patient Portal

**Caregiver Management Interface**:

```
┌─────────────────────────────────────────────────────────────────┐
│  👥 My Caregivers - John Doe                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🤝 ACTIVE CAREGIVERS                                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Sarah Doe (Spouse)                                        │  │
│  │ Connected: June 15, 2024 | Last access: 2 hours ago      │  │
│  │                                                            │  │
│  │ ✅ Can view:                                              │  │
│  │ • Medical history • Lab results • Medications             │  │
│  │ • Appointments • Insurance • Billing                      │  │
│  │                                                            │  │
│  │ ✅ Can do:                                                │  │
│  │ • Schedule appointments • Request refills                 │  │
│  │ • Message providers • Upload documents                    │  │
│  │                                                            │  │
│  │ ⚠️ Emergency Access: ENABLED (PIN required)               │  │
│  │                                                            │  │
│  │ [Edit Permissions] [View Activity Log] [Revoke Access]    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Emily Doe (Adult Daughter)                                │  │
│  │ Connected: March 22, 2025 | Last access: 1 week ago      │  │
│  │                                                            │  │
│  │ ✅ Limited access:                                        │  │
│  │ • Appointments • Medications only                         │  │
│  │                                                            │  │
│  │ ❌ Emergency Access: DISABLED                             │  │
│  │                                                            │  │
│  │ [Edit Permissions] [View Activity Log] [Revoke Access]    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📩 PENDING INVITATIONS                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ michael.doe@email.com (Brother)                           │  │
│  │ Invited: Nov 5, 2025 | Expires: Nov 12, 2025             │  │
│  │ [Resend Invitation] [Cancel]                              │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  [+ Invite New Caregiver]                                       │
│                                                                  │
│  📋 ACTIVITY LOG (Last 30 Days)                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Nov 7, 10:30 AM - Sarah viewed your medication list       │  │
│  │ Nov 7, 9:15 AM - Sarah scheduled appointment with Dr. M   │  │
│  │ Nov 6, 2:45 PM - Sarah downloaded lab results (AAT level) │  │
│  │ Nov 5, 4:20 PM - Emily viewed upcoming appointments       │  │
│  │ [View Full Log]                                            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Caregiver Dashboard**:

```
┌─────────────────────────────────────────────────────────────────┐
│  👨‍👩‍👧 Caregiver Dashboard - Sarah Doe                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  👤 PEOPLE I HELP                                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ [John Doe (Spouse)] [Mom (Parent)] [+ Add]               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  Currently viewing: John Doe (Spouse)                           │
│                                                                  │
│  ⚠️ URGENT TASKS (2)                                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🚨 Refill Prolastin - 0 refills left | Due: Tomorrow      │  │
│  │    [Request Refill] [Mark Complete]                        │  │
│  │                                                            │  │
│  │ 📅 Schedule annual PFT - 13 months since last | Overdue   │  │
│  │    [Schedule Now] [Mark Complete]                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📅 UPCOMING APPOINTMENTS (3)                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Nov 12, 10:00 AM - Dr. Martinez (Pulmonologist)           │  │
│  │ 📍 Denver Lung Clinic | 📞 Video visit                    │  │
│  │ [View Details] [Reschedule] [Cancel]                       │  │
│  │                                                            │  │
│  │ Nov 29, 2:00 PM - Prolastin infusion                      │  │
│  │ 📍 Home infusion                                          │  │
│  │ [View Details]                                             │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💊 MEDICATIONS (8)                                             │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Prolastin 1000 mg - Weekly infusion | Next: Nov 14        │  │
│  │ Albuterol inhaler - 2 puffs every 4-6 hrs PRN             │  │
│  │ Spiriva 18 mcg - Daily | 45 days supply remaining         │  │
│  │ [View All Medications]                                     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🧪 RECENT LAB RESULTS                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Nov 5 - AAT Level: 32 mg/dL ⚠️ Low (normal 90-200)       │  │
│  │ Nov 3 - FEV1: 62% predicted ⚠️ Moderate obstruction       │  │
│  │ [View All Results]                                         │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💬 MESSAGES (1 unread)                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Dr. Martinez: "Lab results look stable. See you at next   │  │
│  │ appointment." - Nov 6                                      │  │
│  │ [View Messages]                                            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Caregiver Adoption

- **Invitations Sent**: 900+ (60% of patients invite at least 1 caregiver)
- **Acceptance Rate**: 85% (caregivers accept within 3 days)
- **Active Caregivers**: 750+ active caregiver accounts
- **Multi-Patient Caregivers**: 20% manage 2+ family members

### Usage Patterns

- **Weekly Logins**: 65% of caregivers check dashboard weekly
- **Task Completion**: 82% of caregiver-assigned tasks completed on time
- **Appointment Scheduling**: 45% of appointments scheduled by caregivers
- **Medication Management**: 70% of refill requests initiated by caregivers

### Patient Outcomes

- **Medication Adherence**: +18% (caregiver reminders/coordination)
- **Missed Appointments**: -40% (caregivers manage scheduling)
- **Test Compliance**: +25% (annual PFTs, AAT levels on schedule)
- **Patient Satisfaction**: 4.6/5 stars (caregivers reduce burden)

### Market Expansion

- **Pediatric Patients**: 150+ children with AATD enrolled (parents manage accounts)
- **Elderly Patients** (65+): +30% retention (adult children provide support)
- **Support Ticket Reduction**: -25% ("how can my spouse help?" questions eliminated)

---

## Budget Estimate

### Development (3-4 months)

- **Backend Developer** (caregiver system, permissions, tasks): $140K/year × 0.33 years = $46,200
- **Frontend Developer** (caregiver dashboard, multi-patient UI): $140K/year × 0.33 years = $46,200
- **UX Designer** (0.25 FTE, caregiver workflows): $130K/year × 0.25 = $32,500

**Total Development**: ~$124,900

### Annual Operations

- **Customer Support** (0.5 FTE, helping caregivers): $55K/year × 0.5 = $27,500
- **Security/Compliance Reviews** (audit caregiver access): $15,000/year

**Total Operations**: ~$42,500/year

### Annual Infrastructure

- **Database Storage** (audit logs, task data): $2,400/year
- **Notification Services** (email/SMS to caregivers): $3,600/year

**Total Infrastructure**: ~$6,000/year

### **GRAND TOTAL (First Year)**: ~$173,400

### **Ongoing (Year 2+)**: ~$48,500/year

**Value Created**:

- Pediatric market: 150 patients × $600/year = $90K/year revenue
- Elderly retention: 200 patients retained × $600/year = $120K/year revenue
- Support cost savings: 25% reduction × $200K support budget = $50K/year savings
  **Total Value**: $260K/year

**Net Benefit (Year 2+)**: +$211,500/year

---

## Risks & Mitigations

### Risk 1: HIPAA Violations (Caregiver Oversharing)

**Impact**: Patients share passwords instead of proper caregiver accounts
**Mitigation**: Education campaigns, easy invitation process, granular permissions make proper sharing easier than password sharing, audit logs detect shared accounts

### Risk 2: Family Conflicts (Disputed Access)

**Impact**: Family members fight over caregiver permissions
**Mitigation**: Patient always has final control, can revoke anytime, activity logs show what caregivers do, clear consent process

### Risk 3: Emergency Access Abuse

**Impact**: Caregivers misuse emergency override
**Mitigation**: Requires PIN (patient sets in advance), 24-hour time limit, immediate patient notification (email/SMS/push), complete audit trail, ability to revoke mid-emergency

### Risk 4: Pediatric Consent Complexity

**Impact**: Legal issues around minors' health records
**Mitigation**: Consult healthcare attorney for each state's laws, parents/legal guardians only, transition plan when child turns 18, comply with COPPA

### Risk 5: Caregiver Burnout

**Impact**: Caregivers overwhelmed by too many notifications/tasks
**Mitigation**: Smart notification grouping, daily digest option (not real-time alerts), task prioritization (urgent vs. routine), ability to snooze/delegate

---

**Document Owner**: CPO, HIPAA Compliance Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
