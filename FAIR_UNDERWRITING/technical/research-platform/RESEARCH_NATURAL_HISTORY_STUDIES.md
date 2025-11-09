# Feature #21A-3: Natural History Studies Platform

**Part of Feature #21: Research Participation Platform (Core Infrastructure)**

---

## Overview

Natural history studies track disease progression over time in large patient cohorts. For AATD, understanding natural history is critical for:

1. **Predicting disease trajectories** - Which ZZ patients develop COPD vs. remain asymptomatic?
2. **Identifying risk factors** - Does smoking cessation halt FEV₁ decline? Do exacerbations accelerate decline?
3. **Clinical trial design** - Establishing progression rates to calculate sample sizes
4. **Treatment effectiveness** - Real-world evidence for augmentation therapy

Traditional natural history studies are expensive ($5-10M), take 5-10 years, and suffer from 40-60% dropout. Fair Underwriting's **embedded natural history platform** leverages the existing patient relationship to achieve:

- **90% data completeness** (automated EHR/claims sync)
- **85% retention at 5 years** (vs. 50% industry standard)
- **1/10th the cost** (~$500K for 5-year study of 1,000 patients)

---

## Longitudinal Data Collection Architecture

### Automated Multi-Source Data Streams

```typescript
interface LongitudinalDataStream {
  participantId: string;

  // Clinical Data (automated sync)
  clinicalData: {
    source: 'ehr' | 'claims' | 'home_monitoring' | 'manual_entry';
    frequency:
      | 'realtime'
      | 'daily'
      | 'weekly'
      | 'monthly'
      | 'quarterly'
      | 'annual';
    dataTypes: string[]; // ['spirometry', 'aat_levels', 'exacerbations', 'medications']
    lastSync: Date;
    nextSync: Date;
  }[];

  // Patient-Reported Outcomes (survey-based)
  proData: {
    surveyType: 'cat' | 'sgrq' | 'sf36' | 'eq5d' | 'custom';
    frequency: 'monthly' | 'quarterly' | 'biannual' | 'annual';
    lastCompleted: Date;
    nextDue: Date;
    completionRate: number; // 0-100%
  }[];

  // Wearable/Home Monitoring
  digitalData: {
    deviceType:
      | 'home_spirometer'
      | 'pulse_oximeter'
      | 'activity_tracker'
      | 'smart_scale';
    manufacturer: string;
    frequency: 'continuous' | 'daily' | 'weekly';
    lastReading: Date;
    complianceRate: number; // 0-100%
  }[];
}
```

### Milestone-Based Data Collection

Instead of fixed-interval visits, collect data at **clinical milestones**:

```typescript
interface ClinicalMilestone {
  milestoneId: string;
  participantId: string;
  milestoneType:
    | 'diagnosis'
    | 'symptom_onset'
    | 'first_exacerbation'
    | 'treatment_initiation'
    | 'treatment_change'
    | 'hospitalization'
    | 'disease_progression'
    | 'annual_checkup';

  triggerDate: Date;

  // Data collection triggered by milestone
  dataCollectionTasks: {
    taskType:
      | 'survey'
      | 'spirometry'
      | 'lab_test'
      | 'imaging'
      | 'provider_assessment';
    priority: 'required' | 'recommended' | 'optional';
    dueDate: Date;
    completedDate?: Date;
    status: 'pending' | 'in_progress' | 'completed' | 'missed';
  }[];

  created_at: Date;
}

class MilestoneDetectionService {
  async detectMilestones(participantId: string): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);

    // Monitor for treatment initiation
    await this.checkTreatmentInitiation(participantId);

    // Monitor for disease progression
    await this.checkDiseaseProgression(participantId);

    // Monitor for exacerbation events
    await this.checkExacerbations(participantId);

    // Annual milestones
    await this.checkAnnualMilestones(participantId);
  }

  async checkTreatmentInitiation(participantId: string): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);

    // Check if participant just started augmentation therapy
    const augmentation = participant.treatments?.augmentationTherapy;
    if (augmentation?.currentlyOn && augmentation.startDate) {
      const daysSinceStart = this.daysBetween(
        augmentation.startDate,
        new Date()
      );

      // Trigger baseline assessment within 30 days of starting
      if (daysSinceStart <= 30) {
        await this.createMilestone({
          participantId,
          milestoneType: 'treatment_initiation',
          triggerDate: augmentation.startDate,
          dataCollectionTasks: [
            {
              taskType: 'spirometry',
              priority: 'required',
              dueDate: this.addDays(augmentation.startDate, 30)
            },
            {
              taskType: 'lab_test',
              priority: 'required',
              dueDate: this.addDays(augmentation.startDate, 30)
            },
            {
              taskType: 'survey',
              priority: 'required',
              dueDate: this.addDays(augmentation.startDate, 14)
            }
          ]
        });
      }
    }
  }

  async checkDiseaseProgression(participantId: string): Promise<void> {
    // Get recent spirometry values
    const spirometryHistory = await this.db.query(
      `
      SELECT test_date, pre_fev1_percent
      FROM registry_spirometry
      WHERE participant_id = $1
      ORDER BY test_date DESC
      LIMIT 3
    `,
      [participantId]
    );

    if (spirometryHistory.length < 2) return;

    // Check for significant FEV₁ decline (>50ml/year or move to worse GOLD stage)
    const latest = spirometryHistory[0];
    const previous = spirometryHistory[1];

    const yearsElapsed = this.yearsBetween(
      previous.test_date,
      latest.test_date
    );
    const fev1Decline = previous.pre_fev1_percent - latest.pre_fev1_percent;
    const annualDeclineRate = fev1Decline / yearsElapsed;

    // Rapid decline: >2% FEV₁ predicted per year
    if (annualDeclineRate > 2) {
      await this.createMilestone({
        participantId,
        milestoneType: 'disease_progression',
        triggerDate: latest.test_date,
        dataCollectionTasks: [
          {
            taskType: 'provider_assessment',
            priority: 'required',
            dueDate: this.addDays(new Date(), 30)
          },
          {
            taskType: 'survey',
            priority: 'required',
            dueDate: this.addDays(new Date(), 14)
          }
        ]
      });

      // Alert provider
      await this.notificationService.send({
        userId: participant.userId,
        type: 'rapid_decline_detected',
        title: 'Rapid FEV₁ Decline Detected',
        message: `Your FEV₁ is declining at ${annualDeclineRate.toFixed(1)}%/year. Please schedule a provider visit.`,
        priority: 'high'
      });
    }
  }

  async checkAnnualMilestones(participantId: string): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);
    const enrollmentAnniversary = new Date(participant.enrollmentDate);
    enrollmentAnniversary.setFullYear(new Date().getFullYear());

    // Check if within 30 days of anniversary
    const daysToAnniversary = this.daysBetween(
      new Date(),
      enrollmentAnniversary
    );

    if (Math.abs(daysToAnniversary) <= 30) {
      await this.createMilestone({
        participantId,
        milestoneType: 'annual_checkup',
        triggerDate: enrollmentAnniversary,
        dataCollectionTasks: [
          {
            taskType: 'spirometry',
            priority: 'required',
            dueDate: enrollmentAnniversary
          },
          {
            taskType: 'survey',
            priority: 'required',
            dueDate: this.addDays(enrollmentAnniversary, -7) // Before anniversary
          },
          {
            taskType: 'lab_test',
            priority: 'recommended',
            dueDate: enrollmentAnniversary
          }
        ]
      });
    }
  }
}
```

---

## Study Protocol Management

### Natural History Study Definition

```typescript
interface NaturalHistoryStudy {
  studyId: string;
  title: string;
  description: string;

  // Study Design
  design: {
    type: 'prospective_cohort' | 'retrospective_cohort' | 'case_control';
    duration: number; // Months
    targetEnrollment: number;

    // Eligibility
    inclusionCriteria: CohortQuery;
    exclusionCriteria: CohortQuery;
  };

  // Data Collection Schedule
  dataCollectionSchedule: {
    baseline: DataCollectionVisit;
    followUp: DataCollectionVisit[];
  };

  // Primary Endpoints
  primaryEndpoints: {
    name: string;
    description: string;
    measurementMethod: string;
    unit: string;
    dataSource: 'ehr' | 'survey' | 'lab' | 'spirometry' | 'claims';
  }[];

  // Secondary Endpoints
  secondaryEndpoints: {
    name: string;
    description: string;
    measurementMethod: string;
  }[];

  // Retention Strategy
  retentionStrategy: {
    reminderFrequency: 'weekly' | 'monthly';
    incentives: {
      type: 'gift_card' | 'donation' | 'early_access';
      amount?: number;
      frequency: 'per_visit' | 'completion';
    }[];
  };

  // IRB/Ethics
  irbApproval: {
    approved: boolean;
    approvalDate: Date;
    irbNumber: string;
    institution: string;
  };

  status: 'draft' | 'recruiting' | 'active' | 'completed' | 'terminated';

  created_at: Date;
  updated_at: Date;
}

interface DataCollectionVisit {
  visitName: string;
  timepoint: number; // Months from baseline (0 = baseline)
  window: number; // Days (e.g., ±30 days)

  // Required data elements
  required: {
    dataType:
      | 'spirometry'
      | 'lab_test'
      | 'survey'
      | 'imaging'
      | 'physical_exam';
    specificTests?: string[]; // e.g., ['FEV1', 'FVC', 'DLCO']
  }[];

  // Optional data elements
  optional: {
    dataType: string;
    specificTests?: string[];
  }[];
}
```

### Study Protocol Example: AATD Progression Study

```typescript
const aatdProgressionStudy: NaturalHistoryStudy = {
  studyId: 'nhs-001',
  title: 'AATD Longitudinal Progression Study',
  description:
    'A 5-year prospective cohort study to characterize FEV₁ decline rates in Pi*ZZ patients with and without augmentation therapy',

  design: {
    type: 'prospective_cohort',
    duration: 60, // 5 years
    targetEnrollment: 1000,

    inclusionCriteria: {
      name: 'AATD Progression Study - Inclusion',
      inclusion: {
        phenotypes: ['ZZ'],
        ageRange: { min: 30, max: 70 },
        fev1PercentRange: { min: 30, max: 80 }, // GOLD 2-3
        dataCompletenessMin: 80
      }
    },

    exclusionCriteria: {
      name: 'AATD Progression Study - Exclusion',
      exclusion: {
        hasTransplant: true,
        recentParticipation: ['nhs-002', 'rct-005'] // Avoid overlap
      }
    }
  },

  dataCollectionSchedule: {
    baseline: {
      visitName: 'Baseline',
      timepoint: 0,
      window: 30,
      required: [
        { dataType: 'spirometry', specificTests: ['FEV1', 'FVC', 'DLCO'] },
        { dataType: 'lab_test', specificTests: ['AAT_level', 'CBC', 'CMP'] },
        { dataType: 'survey', specificTests: ['CAT', 'SGRQ', 'SF-36'] }
      ],
      optional: [{ dataType: 'imaging', specificTests: ['chest_ct'] }]
    },

    followUp: [
      {
        visitName: 'Month 6',
        timepoint: 6,
        window: 30,
        required: [
          { dataType: 'spirometry', specificTests: ['FEV1', 'FVC'] },
          { dataType: 'survey', specificTests: ['CAT', 'exacerbation_diary'] }
        ],
        optional: []
      },
      {
        visitName: 'Year 1',
        timepoint: 12,
        window: 30,
        required: [
          { dataType: 'spirometry', specificTests: ['FEV1', 'FVC', 'DLCO'] },
          { dataType: 'lab_test', specificTests: ['AAT_level'] },
          { dataType: 'survey', specificTests: ['CAT', 'SGRQ', 'SF-36'] }
        ],
        optional: [{ dataType: 'imaging', specificTests: ['chest_ct'] }]
      }
      // Year 2-5: Similar structure
      // ...
    ]
  },

  primaryEndpoints: [
    {
      name: 'Annual FEV₁ Decline Rate',
      description:
        'Rate of FEV₁ decline (ml/year) measured from baseline to Year 5',
      measurementMethod: 'Linear mixed-effects model',
      unit: 'ml/year',
      dataSource: 'spirometry'
    },
    {
      name: 'Time to Disease Progression',
      description: 'Time from baseline to ≥1 GOLD stage worsening',
      measurementMethod: 'Kaplan-Meier survival analysis',
      unit: 'months',
      dataSource: 'spirometry'
    }
  ],

  secondaryEndpoints: [
    {
      name: 'Exacerbation Rate',
      description: 'Annualized exacerbation rate',
      measurementMethod: 'Poisson regression'
    },
    {
      name: 'Quality of Life Change',
      description: 'Change in SGRQ total score from baseline',
      measurementMethod: 'Repeated measures ANOVA'
    },
    {
      name: 'Hospitalization Rate',
      description: 'AATD-related hospitalizations per year',
      measurementMethod: 'Claims data analysis'
    }
  ],

  retentionStrategy: {
    reminderFrequency: 'monthly',
    incentives: [
      {
        type: 'gift_card',
        amount: 50,
        frequency: 'per_visit'
      },
      {
        type: 'early_access',
        frequency: 'completion' // Early access to study results
      }
    ]
  },

  irbApproval: {
    approved: true,
    approvalDate: new Date('2025-01-15'),
    irbNumber: 'IRB-2025-001',
    institution: 'Fair Underwriting Research Institute'
  },

  status: 'recruiting',

  created_at: new Date('2025-01-01'),
  updated_at: new Date('2025-01-15')
};
```

---

## Participant Enrollment & Management

### Study Enrollment Workflow

```typescript
class StudyEnrollmentService {
  async enrollParticipant(
    studyId: string,
    participantId: string
  ): Promise<void> {
    // 1. Check eligibility
    const study = await this.db.findById('natural_history_studies', studyId);
    const participant =
      await this.registryService.getParticipant(participantId);

    const eligible = await this.cohortBuilder.checkEligibility(
      participant,
      study.design.inclusionCriteria,
      study.design.exclusionCriteria
    );

    if (!eligible.matches) {
      throw new Error(
        `Participant not eligible: ${eligible.reasons.join(', ')}`
      );
    }

    // 2. Obtain informed consent
    const consent = await this.consentService.getStudyConsent(
      participantId,
      studyId
    );
    if (!consent || !consent.accepted) {
      throw new Error('Study consent required before enrollment');
    }

    // 3. Create study enrollment record
    const enrollment: StudyEnrollment = {
      enrollmentId: uuidv4(),
      studyId,
      participantId,
      enrollmentDate: new Date(),
      status: 'active',

      // Baseline data collection
      baselineVisit: {
        scheduledDate: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
        completedDate: null,
        dataCollected: []
      },

      // Future visits
      followUpVisits: study.dataCollectionSchedule.followUp.map((visit) => ({
        visitName: visit.visitName,
        scheduledDate: this.calculateVisitDate(
          new Date(),
          visit.timepoint,
          visit.window
        ),
        completedDate: null,
        dataCollected: []
      })),

      // Retention tracking
      retentionMetrics: {
        visitsCompleted: 0,
        visitsScheduled: 1 + study.dataCollectionSchedule.followUp.length,
        lastContactDate: new Date(),
        retentionRisk: 'low'
      },

      created_at: new Date(),
      updated_at: new Date()
    };

    await this.db.insert('study_enrollments', enrollment);

    // 4. Schedule baseline visit
    await this.scheduleBaselineVisit(enrollment);

    // 5. Send welcome email
    await this.emailService.sendStudyWelcome({
      participantId,
      studyId,
      studyTitle: study.title,
      baselineVisitDate: enrollment.baselineVisit.scheduledDate
    });
  }

  async scheduleBaselineVisit(enrollment: StudyEnrollment): Promise<void> {
    const study = await this.db.findById(
      'natural_history_studies',
      enrollment.studyId
    );
    const baseline = study.dataCollectionSchedule.baseline;

    // Create tasks for each required data element
    for (const dataElement of baseline.required) {
      await this.createDataCollectionTask({
        enrollmentId: enrollment.enrollmentId,
        participantId: enrollment.participantId,
        visitName: 'Baseline',
        dataType: dataElement.dataType,
        specificTests: dataElement.specificTests,
        dueDate: enrollment.baselineVisit.scheduledDate,
        priority: 'required'
      });
    }

    // Optional data elements
    for (const dataElement of baseline.optional) {
      await this.createDataCollectionTask({
        enrollmentId: enrollment.enrollmentId,
        participantId: enrollment.participantId,
        visitName: 'Baseline',
        dataType: dataElement.dataType,
        specificTests: dataElement.specificTests,
        dueDate: enrollment.baselineVisit.scheduledDate,
        priority: 'optional'
      });
    }
  }

  calculateVisitDate(
    enrollmentDate: Date,
    timepoint: number,
    window: number
  ): Date {
    // timepoint in months, window in days
    const visitDate = new Date(enrollmentDate);
    visitDate.setMonth(visitDate.getMonth() + timepoint);
    return visitDate;
  }
}
```

### Automated Visit Reminders

```typescript
class StudyReminderService {
  async sendUpcomingVisitReminders(): Promise<void> {
    // Find visits due within 14 days
    const upcomingVisits = await this.db.query(`
      SELECT
        se.enrollment_id,
        se.participant_id,
        se.study_id,
        jsonb_array_elements(se.follow_up_visits) AS visit
      FROM study_enrollments se
      WHERE
        se.status = 'active'
        AND (visit->>'completedDate')::DATE IS NULL
        AND (visit->>'scheduledDate')::DATE BETWEEN NOW() AND NOW() + INTERVAL '14 days'
    `);

    for (const visit of upcomingVisits) {
      await this.sendVisitReminder(visit);
    }
  }

  async sendVisitReminder(visit: any): Promise<void> {
    const participant = await this.registryService.getParticipant(
      visit.participant_id
    );
    const study = await this.db.findById(
      'natural_history_studies',
      visit.study_id
    );

    // Email reminder
    await this.emailService.send({
      to: participant.userId,
      subject: `${study.title} - Visit Reminder`,
      template: 'study_visit_reminder',
      data: {
        studyTitle: study.title,
        visitName: visit.visit.visitName,
        scheduledDate: visit.visit.scheduledDate,
        tasksRemaining: await this.getIncompleteTasksForVisit(
          visit.enrollment_id,
          visit.visit.visitName
        )
      }
    });

    // SMS reminder (if opted in)
    if (participant.preferences?.smsNotifications) {
      await this.smsService.send({
        to: participant.phoneNumber,
        message: `Reminder: Your ${study.title} ${visit.visit.visitName} visit is on ${this.formatDate(visit.visit.scheduledDate)}. Please complete your spirometry and surveys.`
      });
    }

    // In-app notification
    await this.notificationService.send({
      userId: participant.userId,
      type: 'study_visit_reminder',
      title: `${visit.visit.visitName} Visit Due Soon`,
      message: `Your ${study.title} visit is scheduled for ${this.formatDate(visit.visit.scheduledDate)}`,
      actionUrl: `/research/studies/${visit.study_id}/visits/${visit.visit.visitName}`
    });
  }

  async sendMissedVisitFollowUp(): Promise<void> {
    // Find visits missed (>30 days past scheduled date)
    const missedVisits = await this.db.query(`
      SELECT
        se.enrollment_id,
        se.participant_id,
        se.study_id,
        jsonb_array_elements(se.follow_up_visits) AS visit
      FROM study_enrollments se
      WHERE
        se.status = 'active'
        AND (visit->>'completedDate')::DATE IS NULL
        AND (visit->>'scheduledDate')::DATE < NOW() - INTERVAL '30 days'
    `);

    for (const visit of missedVisits) {
      // Flag participant as high retention risk
      await this.updateRetentionRisk(visit.enrollment_id, 'high');

      // Send follow-up
      await this.sendMissedVisitEmail(visit);

      // If still no response after 14 days, call participant
      if (this.daysSince(visit.visit.scheduledDate) > 44) {
        await this.createOutreachTask({
          enrollmentId: visit.enrollment_id,
          taskType: 'phone_call',
          reason: 'missed_visit_followup',
          priority: 'high'
        });
      }
    }
  }
}
```

---

## Retention Strategies

### Predictive Retention Model

```typescript
class RetentionPredictionService {
  async predictDropoutRisk(enrollmentId: string): Promise<number> {
    const enrollment = await this.db.findById(
      'study_enrollments',
      enrollmentId
    );
    const participant = await this.registryService.getParticipant(
      enrollment.participantId
    );

    // Features for dropout prediction
    const features = {
      // Engagement metrics
      surveyCompletionRate: this.calculateSurveyCompletionRate(enrollment),
      lastContactDays: this.daysSince(
        enrollment.retentionMetrics.lastContactDate
      ),
      visitsCompletedPercent:
        (enrollment.retentionMetrics.visitsCompleted /
          enrollment.retentionMetrics.visitsScheduled) *
        100,

      // Demographic factors
      age: this.calculateAge(participant.demographics.dateOfBirth),
      distanceToClinic:
        await this.calculateDistanceToNearestClinic(participant),

      // Disease severity (sicker patients more engaged?)
      fev1Percent:
        participant.clinicalStatus?.lungDisease?.lastSpirometry?.fev1_percent,
      exacerbationsPerYear:
        participant.clinicalStatus?.lungDisease?.exacerbationsPerYear,

      // Social factors
      hasCaregiver: participant.caregivers?.length > 0,
      employmentStatus: participant.employment_status
    };

    // Logistic regression model (trained on historical data)
    const dropoutProbability = await this.mlModel.predict(
      'retention_model',
      features
    );

    // Update retention risk
    let risk: 'low' | 'medium' | 'high';
    if (dropoutProbability < 0.2) risk = 'low';
    else if (dropoutProbability < 0.5) risk = 'medium';
    else risk = 'high';

    await this.db.update('study_enrollments', enrollmentId, {
      'retention_metrics.retention_risk': risk
    });

    return dropoutProbability;
  }

  async identifyAtRiskParticipants(): Promise<StudyEnrollment[]> {
    const enrollments = await this.db.query(`
      SELECT *
      FROM study_enrollments
      WHERE
        status = 'active'
        AND retention_metrics->>'retentionRisk' IN ('medium', 'high')
    `);

    return enrollments;
  }

  async implementRetentionInterventions(): Promise<void> {
    const atRisk = await this.identifyAtRiskParticipants();

    for (const enrollment of atRisk) {
      const risk = enrollment.retentionMetrics.retentionRisk;

      if (risk === 'medium') {
        // Moderate interventions
        await this.sendPersonalizedMessage(enrollment);
        await this.offerVirtualVisit(enrollment);
      } else if (risk === 'high') {
        // Intensive interventions
        await this.assignStudyCoordinator(enrollment);
        await this.schedulePhoneCall(enrollment);
        await this.offerIncentiveBonus(enrollment);
      }
    }
  }

  async sendPersonalizedMessage(enrollment: StudyEnrollment): Promise<void> {
    const participant = await this.registryService.getParticipant(
      enrollment.participantId
    );
    const study = await this.db.findById(
      'natural_history_studies',
      enrollment.studyId
    );

    await this.emailService.send({
      to: participant.userId,
      subject: `We miss you! Your participation in ${study.title} matters`,
      template: 'retention_personalized',
      data: {
        participantName: participant.demographics.firstName,
        studyTitle: study.title,
        contribution: `Your data has contributed to ${this.calculateContributionImpact(enrollment)} research insights`,
        missedVisits: this.getMissedVisits(enrollment),
        incentive: 'Complete your next visit and receive a $75 gift card'
      }
    });
  }
}
```

### Gamification & Engagement

```typescript
interface StudyEngagementMetrics {
  participantId: string;
  studyId: string;

  // Points system
  points: {
    total: number;
    breakdown: {
      visitsCompleted: number;
      surveysCompleted: number;
      dataShared: number;
      referrals: number;
    };
  };

  // Badges
  badges: {
    badgeId: string;
    name: string;
    description: string;
    earnedDate: Date;
  }[];

  // Leaderboard (anonymous)
  rank: number; // Among all study participants
  percentile: number; // Top 10%
}

class EngagementGamificationService {
  async awardPoints(
    enrollmentId: string,
    action: string,
    points: number
  ): Promise<void> {
    await this.db.query(
      `
      UPDATE study_engagement_metrics
      SET
        total_points = total_points + $1,
        points_breakdown = jsonb_set(
          points_breakdown,
          '{${action}}',
          (COALESCE((points_breakdown->'${action}')::int, 0) + $1)::text::jsonb
        )
      WHERE enrollment_id = $2
    `,
      [points, enrollmentId]
    );

    // Check for badge eligibility
    await this.checkBadgeEligibility(enrollmentId);
  }

  async checkBadgeEligibility(enrollmentId: string): Promise<void> {
    const enrollment = await this.db.findById(
      'study_enrollments',
      enrollmentId
    );
    const metrics = await this.db.findOne('study_engagement_metrics', {
      enrollment_id: enrollmentId
    });

    // "Consistency Champion" badge: 100% visit completion
    if (
      enrollment.retentionMetrics.visitsCompleted ===
        enrollment.retentionMetrics.visitsScheduled &&
      enrollment.retentionMetrics.visitsScheduled >= 3
    ) {
      await this.awardBadge(enrollmentId, 'consistency_champion');
    }

    // "Data Superstar" badge: >95% data completeness
    if (metrics.dataCompleteness > 95) {
      await this.awardBadge(enrollmentId, 'data_superstar');
    }

    // "Community Builder" badge: Referred 3+ participants
    const referrals = await this.db.count('study_enrollments', {
      referrer_enrollment_id: enrollmentId
    });
    if (referrals >= 3) {
      await this.awardBadge(enrollmentId, 'community_builder');
    }
  }

  async awardBadge(enrollmentId: string, badgeId: string): Promise<void> {
    const badge = this.badges[badgeId];

    await this.db.query(
      `
      UPDATE study_engagement_metrics
      SET badges = badges || $1::jsonb
      WHERE enrollment_id = $2
    `,
      [
        JSON.stringify({
          badgeId,
          name: badge.name,
          description: badge.description,
          earnedDate: new Date()
        }),
        enrollmentId
      ]
    );

    // Send congratulatory notification
    const enrollment = await this.db.findById(
      'study_enrollments',
      enrollmentId
    );
    const participant = await this.registryService.getParticipant(
      enrollment.participantId
    );

    await this.notificationService.send({
      userId: participant.userId,
      type: 'badge_earned',
      title: `🏆 Badge Earned: ${badge.name}!`,
      message: badge.description,
      actionUrl: `/research/studies/${enrollment.studyId}/achievements`
    });
  }

  badges = {
    consistency_champion: {
      name: 'Consistency Champion',
      description: 'Completed all study visits on time'
    },
    data_superstar: {
      name: 'Data Superstar',
      description: 'Maintained >95% data completeness'
    },
    community_builder: {
      name: 'Community Builder',
      description: 'Referred 3+ participants to the study'
    },
    early_adopter: {
      name: 'Early Adopter',
      description: 'Enrolled in the first 100 participants'
    },
    long_hauler: {
      name: 'Long Hauler',
      description: 'Active participant for 3+ years'
    }
  };
}
```

---

## Data Analysis & Visualization

### Longitudinal Trend Analysis

```typescript
class LongitudinalAnalysisService {
  async analyzeFev1Decline(studyId: string): Promise<Fev1AnalysisResult> {
    // Get all spirometry data for study participants
    const data = await this.db.query(
      `
      SELECT
        se.enrollment_id,
        se.participant_id,
        rs.test_date,
        rs.pre_fev1_ml,
        rs.pre_fev1_percent,
        rp.demographics,
        rp.treatments
      FROM study_enrollments se
      JOIN registry_participants rp ON se.participant_id = rp.id
      JOIN registry_spirometry rs ON rp.id = rs.participant_id
      WHERE
        se.study_id = $1
        AND se.status = 'active'
        AND rs.test_date BETWEEN se.enrollment_date AND NOW()
      ORDER BY se.enrollment_id, rs.test_date
    `,
      [studyId]
    );

    // Group by participant
    const participantData = this.groupBy(data, 'enrollment_id');

    // Calculate decline rate for each participant (linear regression)
    const declineRates = participantData.map((participant) => {
      const timePoints = participant.map(
        (p) => this.daysBetween(participant[0].test_date, p.test_date) / 365.25 // Years
      );
      const fev1Values = participant.map((p) => p.pre_fev1_ml);

      const { slope, intercept, rSquared } = this.linearRegression(
        timePoints,
        fev1Values
      );

      return {
        enrollmentId: participant[0].enrollment_id,
        participantId: participant[0].participant_id,
        declineRate: slope, // ml/year
        baseline: intercept,
        rSquared,
        onAugmentation:
          participant[0].treatments?.augmentationTherapy?.currentlyOn,
        age: this.calculateAge(participant[0].demographics.dateOfBirth),
        smokingStatus: participant[0].lifestyle?.smokingStatus
      };
    });

    // Stratified analysis
    const augmentationGroup = declineRates.filter((p) => p.onAugmentation);
    const noAugmentationGroup = declineRates.filter((p) => !p.onAugmentation);

    return {
      overallDeclineRate: {
        mean: this.mean(declineRates.map((p) => p.declineRate)),
        median: this.median(declineRates.map((p) => p.declineRate)),
        stdDev: this.stdDev(declineRates.map((p) => p.declineRate)),
        n: declineRates.length
      },

      augmentationGroup: {
        mean: this.mean(augmentationGroup.map((p) => p.declineRate)),
        median: this.median(augmentationGroup.map((p) => p.declineRate)),
        n: augmentationGroup.length
      },

      noAugmentationGroup: {
        mean: this.mean(noAugmentationGroup.map((p) => p.declineRate)),
        median: this.median(noAugmentationGroup.map((p) => p.declineRate)),
        n: noAugmentationGroup.length
      },

      // Statistical test
      pValue: this.tTest(
        augmentationGroup.map((p) => p.declineRate),
        noAugmentationGroup.map((p) => p.declineRate)
      ),

      // Visualization data
      spaghettiPlot: this.generateSpaghettiPlotData(participantData),
      meanTrajectories: {
        augmentation: this.calculateMeanTrajectory(augmentationGroup),
        noAugmentation: this.calculateMeanTrajectory(noAugmentationGroup)
      }
    };
  }

  generateSpaghettiPlotData(participantData: any[]): any {
    return participantData.map((participant) => ({
      participantId: participant[0].participant_id,
      data: participant.map((p) => ({
        x: this.daysBetween(participant[0].test_date, p.test_date) / 365.25, // Years
        y: p.pre_fev1_ml
      })),
      group: participant[0].treatments?.augmentationTherapy?.currentlyOn
        ? 'Augmentation'
        : 'No Augmentation'
    }));
  }
}
```

---

## Budget & Success Metrics

### Development Costs (4-5 months)

- **Backend Developer** (study protocols, milestone detection, data collection): $140K/year × 0.42 = $58,800
- **Data Scientist** (longitudinal analysis, retention models): $160K/year × 0.42 = $67,200
- **Frontend Developer** (participant dashboard, data entry forms): $140K/year × 0.33 = $46,200
- **Clinical Research Specialist** (protocol design, IRB): $120K/year × 0.25 = $30,000

**Total**: ~$202,200

### Per-Study Costs (5-year study of 1,000 participants)

- **Study Coordination** (2 FTE coordinators): $120K/year × 2 × 5 = $1,200,000
- **Participant Incentives** ($50/visit × 6 visits × 1,000): $300,000
- **Data Storage & Compute**: $50,000/year × 5 = $250,000
- **Statistical Analysis** (biostatistician): $150K/year × 0.5 × 2 = $150,000

**Total Per Study**: ~$1,900,000

**Traditional Natural History Study Cost**: $5-10M
**Cost Savings**: 62-81%

### Success Metrics

- **Enrollment Rate**: Achieve target enrollment within 12 months (vs. 24-36 months traditional)
- **Retention Rate**: 85% at Year 5 (vs. 50-60% traditional)
- **Data Completeness**: 90% (vs. 65% traditional)
- **Cost per Patient-Year**: $380 (vs. $1,000-2,000 traditional)

---

**Document Status:** Complete
**Next Document:** MISSING_FEATURES_21A4_CONSENT_MANAGEMENT.md
