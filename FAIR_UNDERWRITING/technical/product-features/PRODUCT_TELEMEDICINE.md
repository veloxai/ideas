# Feature #2: Telemedicine Integration

**Category**: Critical Missing Feature
**Priority**: Phase 1 (MVP - Must Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 frontend developer, medical compliance specialist

---

## Executive Summary

Telemedicine capabilities are essential for Fair Underwriting to provide comprehensive care beyond genetic testing. With MZ carriers and AATD patients needing regular medical oversight, integrated virtual care reduces barriers to specialist access and improves health outcomes.

**Key Value Propositions**:

- Immediate access to pulmonologists and hepatologists (AATD specialists)
- Genetic counselor video consultations (already planned, expand scope)
- Remote monitoring for at-risk patients
- Lower cost than in-person visits ($50-150 vs. $200-500)
- Improved patient compliance (convenience factor)

---

## Scope Definition

### In Scope

1. **Genetic Counselor Video Consultations** (already partially documented)
2. **Pulmonologist Consultations** (for lung health - COPD/emphysema)
3. **Hepatologist Consultations** (for liver health - cirrhosis risk)
4. **Primary Care Provider (PCP) Coordination**
5. **Integration with Third-Party Telehealth Platforms** (Teladoc, Amwell)
6. **Prescription Management** (e-prescribing integration)

### Out of Scope (Future Phases)

- Mental health counseling
- Physical therapy
- Nutrition counseling (consider Phase 2)
- Chronic disease management programs (diabetes, hypertension)

---

## User Stories

### As an MZ Carrier

"I was diagnosed with MZ heterozygote status. I want to consult with a pulmonologist who understands AATD to discuss my 2-4x COPD risk and create a monitoring plan."

**Acceptance Criteria**:

- Can schedule video appointment with AATD-specialist pulmonologist within 7 days
- Consultation includes spirometry results review (if available)
- Receive personalized lung health plan after consultation
- Follow-up appointment auto-scheduled in 6 months

### As a ZZ Patient on AAT Augmentation Therapy

"I receive monthly AAT infusions. I want to check in with my pulmonologist every 3 months without driving 2 hours to the specialty clinic."

**Acceptance Criteria**:

- Quarterly video check-ins with same pulmonologist (continuity of care)
- Doctor can review my latest AAT levels and lung function tests
- Can discuss side effects or concerns
- Prescription refills handled during visit

### As an Insurance Partner

"We want to reduce costly ER visits and hospitalizations for our AATD patients by providing proactive telemedicine access."

**Acceptance Criteria**:

- Track telemedicine utilization rates (target: 60% of at-risk patients use quarterly)
- Measure reduction in ER visits (track claims data)
- ROI dashboard showing cost savings
- Compliance with telehealth billing requirements

---

## Technical Architecture

### System Components

```
┌─────────────────────────────────────────────────────────┐
│           Fair Underwriting Platform                     │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────────┐       ┌──────────────────┐       │
│  │  Customer Portal │       │  Provider Portal │       │
│  │  (Web + Mobile)  │       │  (Web Only)      │       │
│  └────────┬─────────┘       └────────┬─────────┘       │
│           │                           │                  │
│           └───────────┬───────────────┘                  │
│                       │                                  │
│          ┌────────────▼────────────┐                    │
│          │   Telehealth Service    │                    │
│          │    (New Microservice)   │                    │
│          └────────────┬────────────┘                    │
│                       │                                  │
│    ┌──────────────────┼──────────────────┐             │
│    │                  │                  │             │
│  ┌─▼────────┐  ┌─────▼──────┐  ┌───────▼────┐        │
│  │ Video    │  │ Scheduling │  │  Provider  │        │
│  │ Platform │  │  Engine    │  │  Network   │        │
│  │(Twilio)  │  │(Calendly)  │  │ (Custom)   │        │
│  └──────────┘  └────────────┘  └────────────┘        │
│                                                         │
│  ┌──────────────────────────────────────────┐         │
│  │      Third-Party Integrations            │         │
│  │  • Teladoc API (referrals)               │         │
│  │  • Amwell API (referrals)                │         │
│  │  • Doximity (provider verification)      │         │
│  │  • Surescripts (e-prescribing)           │         │
│  └──────────────────────────────────────────┘         │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Video Platform Selection

**Option 1: Twilio Video (Recommended)**

**Pros**:

- HIPAA-compliant (BAA available)
- Excellent quality (adaptive bitrate)
- Recording capabilities
- Screen sharing (for reviewing results)
- Web SDK + mobile SDKs
- Mature API, good documentation

**Cons**:

- Cost: $0.004/minute/participant (≈ $0.48 for 30-min appt with 2 people)
- Requires custom UI development

**Option 2: Doxy.me (Alternative)**

**Pros**:

- Built for healthcare (HIPAA-native)
- No app required (works in browser)
- Simple "virtual waiting room" UX
- Lower cost: $35/month per provider

**Cons**:

- Less customization
- Limited mobile app integration
- Provider must have separate Doxy.me account

**Decision**: Use **Twilio Video** for full control and white-label experience

---

## Feature Specifications

### 1. Provider Network Management

**Provider Types**:

1. **Genetic Counselors** (In-house, Fair Underwriting employees)
2. **Pulmonologists** (Contract, AATD specialists)
3. **Hepatologists** (Contract, liver disease specialists)
4. **Primary Care Providers** (Customer's existing PCP, integrated)

**Provider Database Schema**:

```typescript
interface Provider {
  id: string;
  type: 'genetic_counselor' | 'pulmonologist' | 'hepatologist' | 'pcp';
  firstName: string;
  lastName: string;
  credentials: string; // "MD", "PhD", "CGC"
  specialty: string; // "Pulmonary Medicine", "Medical Genetics"
  npi: string; // National Provider Identifier
  licenses: {
    state: string;
    licenseNumber: string;
    expiresAt: Date;
  }[];
  aatdSpecialist: boolean; // Has AATD experience
  availability: {
    dayOfWeek: number; // 0-6 (Sunday-Saturday)
    startTime: string; // "09:00"
    endTime: string; // "17:00"
    timezone: string; // "America/New_York"
  }[];
  languages: string[]; // ["English", "Spanish"]
  bio: string;
  photoUrl: string;
  consultationFee: number; // Dollars
  acceptsInsurance: boolean;
  rating: number; // 0-5
  totalConsultations: number;
}
```

**Provider Vetting Process**:

1. Verify medical license (state medical board API)
2. Check NPI validity (NPPES API)
3. Verify board certification
4. Background check (Checkr)
5. HIPAA training completion
6. Orientation to Fair Underwriting platform

### 2. Appointment Scheduling

**Appointment Types**:

| Type                         | Duration | Provider          | Cost            | Booking Window |
| ---------------------------- | -------- | ----------------- | --------------- | -------------- |
| Initial Genetic Counseling   | 60 min   | Genetic Counselor | Free (included) | 1-7 days       |
| Follow-up Genetic Counseling | 30 min   | Genetic Counselor | $49             | 1-14 days      |
| Pulmonologist Consultation   | 45 min   | Pulmonologist     | $150            | 3-14 days      |
| Hepatologist Consultation    | 45 min   | Hepatologist      | $150            | 3-14 days      |
| Urgent Consult               | 20 min   | Any available     | $75             | Same-day       |

**Scheduling Flow**:

```
Customer Journey:
1. Navigate to "Talk to a Specialist"
2. Select consultation type
3. View available time slots (calendar view)
4. Choose date/time
5. Enter reason for visit (optional)
6. Upload medical records (optional)
7. Confirm appointment
8. Receive confirmation email + calendar invite
9. Reminder notifications (24 hours before, 1 hour before)
10. Join video call at appointment time
```

**Scheduling Engine**:

```typescript
interface AppointmentRequest {
  customerId: string;
  providerType: 'genetic_counselor' | 'pulmonologist' | 'hepatologist';
  preferredDates: Date[]; // Top 3 preferences
  reasonForVisit: string;
  urgency: 'routine' | 'urgent';
}

async function findAvailableSlots(
  request: AppointmentRequest
): Promise<TimeSlot[]> {
  // 1. Query providers matching type + AATD specialty
  const providers = await getAvailableProviders(request.providerType);

  // 2. Get each provider's availability
  const slots: TimeSlot[] = [];
  for (const provider of providers) {
    const availability = await provider.getAvailability(request.preferredDates);
    slots.push(...availability);
  }

  // 3. Filter out already-booked slots
  const availableSlots = slots.filter((slot) => !slot.isBooked);

  // 4. Sort by customer preference + provider rating
  return availableSlots.sort((a, b) => {
    const scoreA = calculateSlotScore(a, request);
    const scoreB = calculateSlotScore(b, request);
    return scoreB - scoreA;
  });
}
```

### 3. Video Consultation Platform

**Pre-Consultation**:

```typescript
interface PreConsultationChecklist {
  patientId: string;
  appointmentId: string;
  checks: {
    internetSpeed: 'good' | 'fair' | 'poor'; // Test: speedtest API
    cameraWorking: boolean;
    microphoneWorking: boolean;
    browserSupported: boolean; // Chrome, Safari, Firefox latest
    consentSigned: boolean; // Telehealth consent form
  };
}

// Example: Test internet speed before consultation
async function testInternetSpeed(): Promise<'good' | 'fair' | 'poor'> {
  const speedMbps = await measureDownloadSpeed();
  if (speedMbps > 5) return 'good';
  if (speedMbps > 2) return 'fair';
  return 'poor';
}
```

**During Consultation**:

**Customer View**:

```
┌────────────────────────────────────────────────────┐
│  Dr. Sarah Johnson, MD                   🎥 📱 🔊 │
│  Pulmonology • AATD Specialist                     │
├────────────────────────────────────────────────────┤
│                                                     │
│              [PROVIDER VIDEO FEED]                 │
│                                                     │
│                                                     │
│  ┌──────────┐                                     │
│  │ Customer │  [Mute] [Camera] [Share Screen]    │
│  │  Video   │                                     │
│  └──────────┘  Timer: 12:45 / 45:00              │
├────────────────────────────────────────────────────┤
│  Quick Actions:                                    │
│  [ Show Test Results ]  [ Upload File ]           │
│  [ Chat ]  [ End Call ]                           │
└────────────────────────────────────────────────────┘
```

**Provider View**:

```
┌────────────────────────────────────────────────────┐
│  John Smith • MZ Carrier • Age 45        [Record] │
├────────────────────────────────────────────────────┤
│                                                     │
│              [PATIENT VIDEO FEED]                  │
│                                                     │
│  ┌─────────────────────────────────────────────┐  │
│  │  Patient Chart (Read-Only)                  │  │
│  │  • Latest AAT: 155 mg/dL (normal)           │  │
│  │  • Genotype: MZ heterozygote                │  │
│  │  • Smoking History: Never smoked            │  │
│  │  • Occupation: Office worker                │  │
│  └─────────────────────────────────────────────┘  │
│                                                     │
│  [Mute] [Camera] [Share Screen] [E-Prescribe]    │
│  Timer: 12:45 / 45:00                             │
├────────────────────────────────────────────────────┤
│  Actions:                                          │
│  [ Add Note ]  [ Order Test ]  [ Schedule F/U ]   │
│  [ End Call ]                                      │
└────────────────────────────────────────────────────┘
```

**Key Features**:

- HD video (720p minimum, adaptive bitrate)
- Screen sharing (provider can share test results, educational diagrams)
- In-call chat (for sharing links, notes)
- Call recording (with consent, for medical record)
- File upload during call (spirometry results, chest X-rays)
- Picture-in-picture (mobile: minimizable video)

**Twilio Implementation**:

```typescript
import { connect, Room } from 'twilio-video';

async function joinConsultation(appointmentId: string, token: string) {
  try {
    // Connect to Twilio room
    const room: Room = await connect(token, {
      name: `appointment-${appointmentId}`,
      audio: true,
      video: { width: 1280, height: 720 },
      bandwidthProfile: {
        video: {
          mode: 'collaboration',
          dominantSpeakerPriority: 'high'
        }
      },
      networkQuality: { local: 1, remote: 1 }
    });

    // Handle remote participant
    room.on('participantConnected', (participant) => {
      console.log(`${participant.identity} joined`);
      participant.tracks.forEach((publication) => {
        if (publication.isSubscribed) {
          const track = publication.track;
          document.getElementById('remote-video').appendChild(track.attach());
        }
      });
    });

    // Monitor network quality
    room.localParticipant.on('networkQualityLevelChanged', (level) => {
      if (level < 3) {
        showWarning('Poor connection quality');
      }
    });

    return room;
  } catch (error) {
    console.error('Failed to join consultation', error);
    throw error;
  }
}
```

### 4. Clinical Documentation

**SOAP Notes** (Subjective, Objective, Assessment, Plan):

```typescript
interface ConsultationNote {
  appointmentId: string;
  providerId: string;
  patientId: string;
  date: Date;
  duration: number; // minutes
  soap: {
    subjective: string; // Chief complaint, symptoms
    objective: string; // Physical findings, test results reviewed
    assessment: string; // Diagnosis, clinical impression
    plan: string; // Treatment plan, follow-up
  };
  icd10Codes: string[]; // Diagnosis codes for billing
  prescriptions: {
    medication: string;
    dosage: string;
    frequency: string;
    refills: number;
  }[];
  followUpRecommendation: {
    timeframe: string; // "3 months", "6 months"
    providerType: string;
    reason: string;
  };
  recordingUrl?: string; // If call was recorded
  attachments: {
    filename: string;
    url: string;
    type: 'lab_result' | 'imaging' | 'referral';
  }[];
}
```

**Example SOAP Note**:

```
SUBJECTIVE:
45-year-old male with MZ heterozygote genotype presents for initial consultation.
Reports occasional shortness of breath with exertion. Denies cough, wheezing, or
chest pain. Never smoker. Works in office setting. Family history positive for COPD
in father (age 72).

OBJECTIVE:
Latest AAT level: 155 mg/dL (normal range). Genotype: PiMZ confirmed by genetic
testing. No spirometry on file. Physical exam not performed (telehealth visit).

ASSESSMENT:
MZ heterozygote with mild respiratory symptoms. Increased risk for COPD given
genotype and family history. Recommend baseline spirometry and annual monitoring.

PLAN:
1. Order baseline spirometry at local lab
2. Start daily symptom journal (provided app instructions)
3. Lifestyle counseling: avoid smoking/secondhand smoke, air quality awareness
4. Follow-up in 6 months or sooner if symptoms worsen
5. Consider pulmonary function testing annually
```

### 5. E-Prescribing Integration

**Surescripts Integration** (industry standard):

```typescript
interface Prescription {
  patientId: string;
  providerId: string;
  medication: {
    name: string; // "Prolastin-C" (AAT augmentation)
    ndc: string; // National Drug Code
    strength: string;
    dosage: string;
    quantity: number;
    refills: number;
    daysSupply: number;
  };
  pharmacy: {
    ncpdpId: string; // National Council for Prescription Drug Programs ID
    name: string;
    address: string;
  };
  sig: string; // Directions: "Infuse 60 mg/kg IV weekly"
  daw: boolean; // Dispense As Written (no substitutions)
}

async function sendPrescription(prescription: Prescription) {
  // 1. Verify provider has prescribing authority (DEA number, state license)
  const provider = await getProvider(prescription.providerId);
  if (!provider.canPrescribe) {
    throw new Error('Provider not authorized to prescribe');
  }

  // 2. Check drug interactions (DUR - Drug Utilization Review)
  const patient = await getPatient(prescription.patientId);
  const interactions = await checkDrugInteractions(
    prescription.medication,
    patient.currentMedications
  );
  if (interactions.severity === 'high') {
    throw new Error(`High-risk interaction: ${interactions.details}`);
  }

  // 3. Send to Surescripts
  const response = await surescriptsAPI.sendPrescription({
    prescriber: provider.npi,
    patient: patient.demographics,
    medication: prescription.medication,
    pharmacy: prescription.pharmacy
  });

  return response;
}
```

### 6. Third-Party Platform Integration

**Teladoc Integration** (for after-hours/urgent care):

```typescript
interface TeladocReferral {
  patientId: string;
  reason: 'urgent_symptom' | 'mental_health' | 'general_care';
  severity: 'low' | 'medium' | 'high';
  notes: string;
}

async function referToTeladoc(referral: TeladocReferral) {
  // 1. Check if patient's insurance covers Teladoc
  const patient = await getPatient(referral.patientId);
  const coverage = await checkTeladocCoverage(patient.insuranceInfo);

  if (!coverage.isEligible) {
    return {
      success: false,
      message:
        'Teladoc not covered by insurance. Please contact customer support.'
    };
  }

  // 2. Create referral via Teladoc API
  const teladocReferral = await teladocAPI.createReferral({
    memberId: patient.insuranceMemberId,
    reason: referral.reason,
    notes: referral.notes,
    clinicalSummary: await generateClinicalSummary(patient)
  });

  // 3. Notify patient
  await sendNotification(patient.id, {
    title: 'Teladoc Referral Created',
    body: 'You can now schedule an appointment with Teladoc for urgent care.',
    link: teladocReferral.appointmentUrl
  });

  return { success: true, referralId: teladocReferral.id };
}
```

---

## Compliance & Regulations

### HIPAA Compliance

**Technical Safeguards**:

- All video sessions encrypted end-to-end (TLS 1.3)
- Business Associate Agreement (BAA) with Twilio
- Access logs for all PHI (who accessed what, when)
- Session recordings encrypted at rest (AES-256)
- Automatic session timeout after 60 minutes of inactivity

**Administrative Safeguards**:

- Provider HIPAA training (annual)
- Incident response plan
- Breach notification procedures

### State Medical Licensing

**Challenge**: Providers must be licensed in patient's state
**Solution**:

```typescript
async function validateProviderLicense(providerId: string, patientId: string) {
  const provider = await getProvider(providerId);
  const patient = await getPatient(patientId);

  const hasLicense = provider.licenses.some(
    (license) =>
      license.state === patient.state && license.expiresAt > new Date()
  );

  if (!hasLicense) {
    throw new Error(`Provider not licensed in ${patient.state}`);
  }
}
```

**Interstate Licensing** (future enhancement):

- Support IMLC (Interstate Medical Licensure Compact) for multi-state license
- Partner with locum tenens providers with broad state coverage

### Telehealth Consent

**Required Elements**:

```typescript
interface TelehealthConsent {
  patientId: string;
  consentedAt: Date;
  ipAddress: string;
  userAgent: string;
  consentText: string; // Full legal text
  acknowledged: {
    understandsLimitations: boolean; // No physical exam
    understandsEmergencyProcedure: boolean; // 911 for emergencies
    understandsTechnicalIssues: boolean; // Call may disconnect
    understandsPrivacy: boolean; // HIPAA protections
    understandsBilling: boolean; // Cost disclosure
  };
}
```

**Consent Form Text**:

```
TELEHEALTH SERVICES CONSENT

I understand that:
1. Telehealth involves electronic communication for medical evaluation
2. The provider will not be able to perform a physical examination
3. In case of emergency, I should call 911 or go to the nearest ER
4. Technical issues may interrupt the consultation
5. My health information is protected under HIPAA
6. The consultation fee is $X, due at time of service

I consent to receive telehealth services.

[Signature] [Date]
```

---

## Billing & Reimbursement

### CPT Codes for Telehealth

| Service                          | CPT Code | Medicare Rate | Private Insurance Avg |
| -------------------------------- | -------- | ------------- | --------------------- |
| Telehealth consultation (45 min) | 99213    | $92           | $150                  |
| Genetic counseling (30 min)      | 96040    | $141          | $200                  |
| Psychiatric diagnostic eval      | 90791    | $183          | $250                  |

**Modifiers**:

- **95** - Synchronous telemedicine service
- **GT** - Interactive audio/video (deprecated, use 95)

### Insurance Claim Submission

```typescript
interface InsuranceClaim {
  patientId: string;
  providerId: string;
  appointmentId: string;
  serviceDate: Date;
  cptCodes: {
    code: string;
    modifier?: string;
    units: number;
  }[];
  icd10Codes: string[]; // Diagnosis codes
  chargeAmount: number;
  placeOfService: string; // "02" = Telehealth
}

async function submitClaim(claim: InsuranceClaim) {
  // 1. Verify insurance eligibility
  const eligibility = await verifyInsurance(claim.patientId);
  if (!eligibility.telehealthCovered) {
    return { success: false, reason: 'Telehealth not covered' };
  }

  // 2. Submit via clearinghouse (Change Healthcare, Availity)
  const claimSubmission = await clearinghouse.submitClaim({
    ...claim,
    submitterNPI: process.env.FAIR_UNDERWRITING_NPI,
    payerCode: eligibility.payerCode
  });

  // 3. Track claim status
  await trackClaim(claimSubmission.id, claim.patientId);

  return { success: true, claimId: claimSubmission.id };
}
```

---

## Success Metrics

### Utilization

- **Target Utilization Rate**: 40% of customers use telemedicine in first year
- **Average Consultations per User**: 1.5 per year
- **Same-Day Appointments**: 70% availability

### Quality

- **Patient Satisfaction**: > 4.5/5 stars average rating
- **Provider Satisfaction**: > 4.3/5 stars
- **No-Show Rate**: < 10%
- **Technical Issues**: < 2% of consultations have video/audio problems

### Clinical Outcomes

- **Follow-Up Compliance**: 60% of patients complete recommended follow-ups
- **Prescription Fill Rate**: 80% of e-prescriptions filled within 7 days
- **ER Visit Reduction**: 20% reduction in AATD-related ER visits (vs. control group)

### Financial

- **Cost per Consultation**: < $50 (including provider time, platform costs)
- **Revenue per Consultation**: $150 average (insurance reimbursement + copay)
- **Claims Approval Rate**: > 90%

---

## Budget Estimate

### Development (3-4 months)

- **Backend Developer**: $140K/year × 0.33 years = $46,200
- **Frontend Developer**: $130K/year × 0.33 years = $42,900
- **Medical Compliance Specialist** (consult): $200/hour × 40 hours = $8,000

**Total Development**: ~$97,000

### Annual Infrastructure

- **Twilio Video**: $0.004/min/participant × 30 min/appt × 2 participants × 5,000 appts/year = $1,200
- **Recording Storage** (S3): $0.023/GB × 500 GB/year = $11.50
- **Surescripts Integration**: $5,000/year

**Total Infrastructure**: ~$6,200/year

### Provider Network

- **Genetic Counselors** (2 FTEs): $100K/year × 2 = $200,000
- **Contract Pulmonologists** (5, part-time): $75/hour × 10 hours/week × 5 × 52 weeks = $195,000
- **Contract Hepatologists** (3, part-time): $75/hour × 5 hours/week × 3 × 52 weeks = $58,500

**Total Provider Costs**: ~$453,500/year

### **GRAND TOTAL (First Year)**: ~$557,000

---

## Risks & Mitigations

### Risk 1: Provider Recruitment

**Mitigation**: Partner with telemedicine staffing agencies (Wheel, SteadyMD)

### Risk 2: State Licensing Complexity

**Mitigation**: Start with top 5 states by customer volume, expand gradually

### Risk 3: Video Quality Issues

**Mitigation**: Require minimum 2 Mbps internet, provide phone-only fallback

### Risk 4: Insurance Reimbursement Denials

**Mitigation**: Pre-verify coverage, provide cash-pay option ($150 flat fee)

---

**Document Owner**: Chief Medical Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
