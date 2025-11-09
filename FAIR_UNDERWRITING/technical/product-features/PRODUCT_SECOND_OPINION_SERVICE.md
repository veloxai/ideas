# Feature #13: Second Opinion Service & Expert Consultations

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 frontend developer, 0.5 FTE operations coordinator, 0.25 FTE medical director

---

## Executive Summary

AATD is a rare disease - most pulmonologists and hepatologists see only 1-2 cases in their career. Patients often receive conflicting advice, miss treatment opportunities, or make critical decisions (augmentation therapy, liver transplant) without specialized expertise. Fair Underwriting can connect patients to the top 50 AATD experts in North America for second opinions on diagnosis, treatment plans, and surgical decisions. This feature builds a curated network of AATD specialists and enables asynchronous second opinions via secure document review.

**Key Value Propositions**:

- **Expert Network**: Curated list of 50+ AATD specialists (pulmonologists, hepatologists, genetic counselors)
- **Asynchronous Reviews**: Upload records, get expert opinion in 5-7 days (no appointment needed)
- **Specialty Matching**: Match patients to right expert (lung vs. liver, pediatric vs. adult)
- **Comprehensive Review**: Expert reviews all records, provides written opinion (3-5 pages)
- **Affordable Pricing**: $250-500/opinion (vs. $2,000+ traditional second opinion visits)
- **Insurance Integration**: Many insurers cover second opinions, automated verification

**Business Impact**:

- Revenue generation: $150K/year (600 opinions × $250 average)
- Patient outcomes: 35% change treatment plan after second opinion
- Competitive differentiation: Only AATD platform with expert network
- Partner retention: 90% of patients using service stay engaged long-term
- Expert partnerships: Build relationships with top AATD researchers

---

## Problem Statement

### Current Gaps

**Scenario 1: ZZ Patient Unsure About Augmentation Therapy**

> "My local pulmonologist says I should start Prolastin infusions. It's $200K/year and weekly IV infusions for life. I want a second opinion from an AATD expert. The nearest specialist is 300 miles away and has a 4-month wait. I don't know if I should wait or start treatment now."

**No access to AATD specialist second opinions** ❌

**Scenario 2: Conflicting Advice from Two Doctors**

> "My pulmonologist says 'wait and see' on augmentation therapy (FEV1 is 68%). My genetic counselor says I should start immediately because I'm declining. Who do I believe? I need an expert tie-breaker."

**No neutral expert to resolve conflicts** ❌

**Scenario 3: MZ Carrier with Abnormal Liver Enzymes**

> "I'm MZ. My liver enzymes (ALT) are 3x normal. My PCP says 'MZ carriers don't get liver disease.' But I read they can in rare cases. Should I see a hepatologist? Get a biopsy? I'm confused."

**No specialist expertise for complex carrier cases** ❌

**Scenario 4: Pre-Liver Transplant Decision**

> "I'm ZZ with cirrhosis. My hepatologist recommends liver transplant. This is a life-or-death decision. I want an AATD liver expert to review my case before I proceed."

**No second opinion for surgical decisions** ❌

**Scenario 5: Pediatric AATD Case**

> "My 3-year-old daughter tested ZZ. Our pediatrician has never seen AATD. Should we start treatment? Monitor her? What's the standard of care for pediatric AATD? We need a specialist."

**No pediatric AATD experts accessible** ❌

---

## Feature Specifications

### 1. Expert Network Management

**AATD Specialist Directory**:

```typescript
interface AAATDExpert {
  expertId: string;

  // Personal info
  firstName: string;
  lastName: string;
  credentials: string; // 'MD, PhD, FCCP'
  title: string; // 'Professor of Medicine'

  // Specialties
  primarySpecialty:
    | 'Pulmonology'
    | 'Hepatology'
    | 'Genetic Counseling'
    | 'Pediatrics';
  subspecialties: string[]; // ['AATD', 'Interstitial Lung Disease', 'COPD']

  // AATD expertise
  aatdExperienceYears: number;
  aatdPatientsManaged: number; // Lifetime total
  activeAATDPatients: number; // Current panel
  publicationCount: number; // Peer-reviewed papers on AATD

  // Institutional affiliation
  institution: string; // 'University of Florida'
  department: string; // 'Division of Pulmonary Medicine'
  city: string;
  state: string;

  // Focus areas
  expertiseAreas: string[];
  /*
  [
    'Augmentation therapy decision-making',
    'Gene therapy trials',
    'Lung transplant evaluation',
    'Pediatric AATD',
    'MZ carrier management',
    'Liver disease in AATD'
  ]
  */

  // Second opinion services
  offersSecondOpinions: boolean;
  secondOpinionTurnaroundDays: number; // 5-7 days typical
  secondOpinionFee: number; // $250-500
  acceptsInsurance: boolean;

  // Availability
  availableForUrgentReviews: boolean; // 24-48 hour turnaround for $750
  monthlyCapacity: number; // Max opinions per month (e.g., 10)
  currentMonthCount: number; // How many done this month

  // Languages
  languages: string[];

  // Bio & credentials
  biography: string; // 500 words
  education: {
    degree: string;
    institution: string;
    year: number;
  }[];

  boardCertifications: string[];
  professionalMemberships: string[];
  awardsAndHonors: string[];

  // Publications (sample)
  recentPublications: {
    title: string;
    journal: string;
    year: number;
    pmid?: string; // PubMed ID
  }[];

  // Reviews
  averageRating: number; // 0.0 - 5.0
  totalReviews: number;

  // Status
  active: boolean;
  joinedDate: Date;
  lastOpinionDate?: Date;
}

class ExpertNetworkService {
  async findMatchingExpert(
    caseType: CaseType,
    patientProfile: PatientProfile
  ): Promise<AAATDExpert[]> {
    // Match patient to best expert(s)
    let query = `
      SELECT * FROM aatd_experts
      WHERE active = true
      AND offers_second_opinions = true
      AND (current_month_count < monthly_capacity)
    `;

    // Filter by specialty
    if (caseType.primaryConcern === 'lung') {
      query += ` AND primary_specialty = 'Pulmonology'`;
    } else if (caseType.primaryConcern === 'liver') {
      query += ` AND primary_specialty = 'Hepatology'`;
    } else if (caseType.isPediatric) {
      query += ` AND 'Pediatrics' = ANY(subspecialties)`;
    }

    // Filter by expertise area
    if (caseType.specificQuestion) {
      query += ` AND $1 = ANY(expertise_areas)`;
    }

    const experts = await this.db.query(query, [caseType.specificQuestion]);

    // Sort by best match
    return experts.sort((a, b) => {
      // Prioritize: experience > availability > rating
      const scoreA =
        a.aatd_experience_years * 10 +
        (a.monthly_capacity - a.current_month_count) +
        a.average_rating * 2;
      const scoreB =
        b.aatd_experience_years * 10 +
        (b.monthly_capacity - b.current_month_count) +
        b.average_rating * 2;
      return scoreB - scoreA;
    });
  }

  async inviteExpert(expertEmail: string, invitedBy: string): Promise<void> {
    // Invite AATD specialists to join network
    await this.emailService.send({
      to: expertEmail,
      subject: 'Invitation to Join Fair Underwriting AATD Expert Network',
      body: this.renderExpertInvitation(expertEmail, invitedBy)
    });

    await this.db.insert('expert_invitations', {
      email: expertEmail,
      invited_by: invitedBy,
      status: 'pending',
      sent_at: new Date()
    });
  }
}

interface CaseType {
  primaryConcern: 'lung' | 'liver' | 'genetics' | 'pediatric' | 'general';
  specificQuestion: string;
  urgency: 'routine' | 'urgent';
  isPediatric: boolean;
}
```

### 2. Second Opinion Request Flow

**Patient-Initiated Second Opinion**:

```typescript
interface SecondOpinionRequest {
  requestId: string;
  patientUserId: string;
  expertId: string;

  // Case details
  caseTitle: string; // "Should I start augmentation therapy?"
  clinicalQuestion: string; // Detailed question (500 words)

  // Patient info
  age: number;
  gender: string;
  genotype: string;
  aatLevel: number;
  diagnosisDate: Date;

  // Current condition
  symptoms: string[];
  currentTreatments: string[];
  relevantHistory: string;

  // Documents uploaded
  documents: {
    type:
      | 'lab_results'
      | 'imaging'
      | 'pulmonary_function_test'
      | 'pathology'
      | 'clinic_notes'
      | 'other';
    filename: string;
    uploadDate: Date;
    s3Url: string;
    fileSize: number;
  }[];

  // Specific questions for expert
  questions: string[]; // Array of specific questions

  // Urgency
  urgency: 'routine' | 'urgent'; // Urgent = 24-48 hours, +$250 fee

  // Payment
  estimatedFee: number;
  insuranceVerified: boolean;
  insuranceCoverage?: number;
  patientResponsibility: number;

  // Status
  status:
    | 'draft'
    | 'submitted'
    | 'assigned'
    | 'in_review'
    | 'completed'
    | 'cancelled';

  // Dates
  submittedDate?: Date;
  assignedDate?: Date;
  reviewCompletedDate?: Date;
  estimatedCompletionDate?: Date;

  // Expert response
  expertOpinionId?: string;
}

class SecondOpinionService {
  async submitRequest(
    request: SecondOpinionRequest
  ): Promise<RequestSubmission> {
    // Validate request
    if (request.documents.length === 0) {
      throw new Error('At least one medical document required');
    }

    // Verify insurance coverage (if applicable)
    if (request.insuranceVerified) {
      const coverage = await this.verifySecondOpinionCoverage(
        request.patientUserId
      );
      request.insuranceCoverage = coverage.coveredAmount;
      request.patientResponsibility =
        request.estimatedFee - coverage.coveredAmount;
    }

    // Create request
    await this.db.insert('second_opinion_requests', {
      ...request,
      status: 'submitted',
      submitted_date: new Date()
    });

    // Notify expert
    await this.notifyExpert(request.expertId, request.requestId);

    // Notify patient
    await this.emailService.send({
      to: await this.getPatientEmail(request.patientUserId),
      subject: 'Second Opinion Request Submitted',
      body: `
Your second opinion request has been submitted to ${await this.getExpertName(request.expertId)}.

Expected turnaround: ${request.urgency === 'urgent' ? '24-48 hours' : '5-7 days'}

You will receive an email when your opinion is ready.

Track status: ${process.env.APP_URL}/second-opinions/${request.requestId}
      `
    });

    return {
      success: true,
      requestId: request.requestId,
      estimatedCompletionDate: this.calculateCompletionDate(request.urgency)
    };
  }

  async verifySecondOpinionCoverage(
    userId: string
  ): Promise<InsuranceCoverage> {
    // Check if patient's insurance covers second opinions
    const insurance = await this.getPatientInsurance(userId);

    // Many insurers cover second opinions at 100%
    const eligibility =
      await this.insuranceVerificationService.verifyEligibility({
        patientUserId: userId,
        serviceTypeCode: '99242', // CPT code for office consultation
        payerId: insurance.payerId
      });

    return {
      covered: eligibility.coverage.servicesCovered.some(
        (s) => s.serviceType === 'second_opinion' && s.covered
      ),
      coveredAmount: eligibility.coverage.copayAmount === 0 ? 500 : 0,
      patientResponsibility: eligibility.coverage.copayAmount || 500
    };
  }
}
```

### 3. Expert Opinion Document

**Structured Expert Response**:

```typescript
interface ExpertOpinion {
  opinionId: string;
  requestId: string;
  expertId: string;

  // Opinion content
  sections: {
    // 1. Case Summary (written by expert)
    caseSummary: string;
    /*
    "52-year-old male with ZZ genotype, AAT level 32 mg/dL, diagnosed 2018.
     FEV1 has declined from 78% to 62% over 18 months. Currently not on
     augmentation therapy. Non-smoker. Family history of COPD."
    */

    // 2. Review of Records
    recordsReviewed: string[];
    /*
    [
      "Pulmonary function tests (PFTs) from 10/2023 showing FEV1 62%",
      "Chest CT from 08/2023 showing basilar emphysema",
      "AAT genotyping and quantification from 01/2018"
    ]
    */

    // 3. Expert Analysis
    clinicalAnalysis: string;
    /*
    "This patient demonstrates progressive lung function decline consistent
     with AATD-related COPD. The rate of FEV1 decline (8% per year) is
     concerning and exceeds typical COPD progression..."
    */

    // 4. Recommendations
    recommendations: {
      priority: 'high' | 'moderate' | 'low';
      recommendation: string;
      rationale: string;
    }[];
    /*
    [
      {
        priority: 'high',
        recommendation: 'Initiate augmentation therapy with alpha-1 proteinase inhibitor',
        rationale: 'Patient meets FDA criteria (ZZ genotype, AAT <50 mg/dL, FEV1 35-60%).
                    Rapid decline suggests aggressive disease. RAPID trial showed 34%
                    reduction in emphysema progression with augmentation therapy.'
      }
    ]
    */

    // 5. Alternative Options
    alternativeOptions: string;
    /*
    "If patient declines augmentation therapy due to IV infusion burden,
     consider enrollment in clinical trial for oral AAT augmentation (NCT...)
     or monitor closely with PFTs every 3 months."
    */

    // 6. Follow-up Plan
    followUpPlan: string;
    /*
    "1. Discuss augmentation therapy options with local pulmonologist
     2. If starting therapy, baseline pre-treatment PFTs
     3. Follow-up PFTs at 6 months post-initiation
     4. Annual chest CT to monitor emphysema progression"
    */

    // 7. Questions Answered
    questionsAnswered: {
      question: string;
      answer: string;
    }[];

    // 8. Additional Comments
    additionalComments?: string;

    // 9. References
    references: string[];
    /*
    [
      "RAPID Trial: Chapman et al. Lancet 2015",
      "ATS/ERS Guidelines for AATD. Am J Respir Crit Care Med 2003",
      "FDA Guidance for Augmentation Therapy 1987"
    ]
    */
  };

  // Metadata
  reviewDurationMinutes: number; // How long expert spent
  wordCount: number;

  // Dates
  startedReviewDate: Date;
  completedDate: Date;

  // Delivery
  deliveredToPatient: boolean;
  deliveredDate?: Date;
  patientViewedDate?: Date;

  // Follow-up
  allowFollowUpQuestions: boolean;
  followUpQuestionsAsked: number;

  // Quality
  patientRating?: number; // 1-5 stars
  patientFeedback?: string;
}

class ExpertOpinionGenerator {
  async createOpinion(requestId: string, expertId: string): Promise<string> {
    // Expert creates opinion (text editor interface)
    const opinion: ExpertOpinion = {
      opinionId: uuidv4(),
      requestId,
      expertId,
      sections: {
        caseSummary: '',
        recordsReviewed: [],
        clinicalAnalysis: '',
        recommendations: [],
        alternativeOptions: '',
        followUpPlan: '',
        questionsAnswered: [],
        references: []
      },
      startedReviewDate: new Date(),
      allowFollowUpQuestions: true,
      followUpQuestionsAsked: 0
    };

    await this.db.insert('expert_opinions', opinion);
    return opinion.opinionId;
  }

  async submitOpinion(opinionId: string): Promise<void> {
    // Expert submits completed opinion
    const opinion = await this.getOpinion(opinionId);

    // Calculate word count
    const wordCount = this.calculateWordCount(opinion.sections);

    // Quality check (minimum 800 words)
    if (wordCount < 800) {
      throw new Error('Opinion must be at least 800 words');
    }

    // Update completion date
    await this.db.update('expert_opinions', opinionId, {
      completed_date: new Date(),
      word_count: wordCount
    });

    // Generate PDF
    const pdfUrl = await this.generateOpinionPDF(opinion);

    // Mark request as completed
    await this.db.update('second_opinion_requests', opinion.requestId, {
      status: 'completed',
      review_completed_date: new Date(),
      expert_opinion_id: opinionId
    });

    // Notify patient
    await this.notifyPatientOpinionReady(opinion.requestId, pdfUrl);

    // Pay expert
    await this.processExpertPayment(opinion.expertId, opinion.requestId);
  }

  async generateOpinionPDF(opinion: ExpertOpinion): Promise<string> {
    // Generate professional PDF report
    const expert = await this.getExpert(opinion.expertId);
    const request = await this.getRequest(opinion.requestId);

    const html = `
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; margin: 40px; }
          h1 { color: #2c3e50; border-bottom: 2px solid #3498db; }
          h2 { color: #34495e; margin-top: 30px; }
          .header { text-align: center; margin-bottom: 30px; }
          .recommendation { background: #ecf0f1; padding: 15px; margin: 10px 0; }
          .high-priority { border-left: 4px solid #e74c3c; }
          .reference { font-size: 0.9em; color: #7f8c8d; }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>AATD Expert Second Opinion</h1>
          <p><strong>${expert.firstName} ${expert.lastName}, ${expert.credentials}</strong></p>
          <p>${expert.title}, ${expert.institution}</p>
          <p>Date: ${new Date().toLocaleDateString()}</p>
        </div>

        <h2>Case Summary</h2>
        <p>${opinion.sections.caseSummary}</p>

        <h2>Records Reviewed</h2>
        <ul>
          ${opinion.sections.recordsReviewed.map((r) => `<li>${r}</li>`).join('')}
        </ul>

        <h2>Clinical Analysis</h2>
        <p>${opinion.sections.clinicalAnalysis}</p>

        <h2>Recommendations</h2>
        ${opinion.sections.recommendations
          .map(
            (rec) => `
          <div class="recommendation ${rec.priority === 'high' ? 'high-priority' : ''}">
            <strong>${rec.recommendation}</strong>
            <p>${rec.rationale}</p>
          </div>
        `
          )
          .join('')}

        <h2>Alternative Options</h2>
        <p>${opinion.sections.alternativeOptions}</p>

        <h2>Follow-Up Plan</h2>
        <p>${opinion.sections.followUpPlan}</p>

        <h2>Your Questions Answered</h2>
        ${opinion.sections.questionsAnswered
          .map(
            (qa) => `
          <p><strong>Q: ${qa.question}</strong></p>
          <p>A: ${qa.answer}</p>
        `
          )
          .join('')}

        ${
          opinion.sections.additionalComments
            ? `
          <h2>Additional Comments</h2>
          <p>${opinion.sections.additionalComments}</p>
        `
            : ''
        }

        <h2>References</h2>
        <ol class="reference">
          ${opinion.sections.references.map((ref) => `<li>${ref}</li>`).join('')}
        </ol>

        <hr>
        <p style="font-size: 0.8em; color: #7f8c8d;">
          This opinion is based on the medical records provided and represents the expert's
          professional assessment. It does not establish a physician-patient relationship.
          Please discuss these recommendations with your treating physician.
        </p>
      </body>
      </html>
    `;

    // Convert HTML to PDF
    const pdf = await this.htmlToPdfService.convert(html);

    // Upload to S3
    const s3Key = `second-opinions/${opinion.opinionId}.pdf`;
    await this.s3.upload(s3Key, pdf);

    return `https://cdn.fairunderwriting.com/${s3Key}`;
  }

  async processExpertPayment(
    expertId: string,
    requestId: string
  ): Promise<void> {
    // Pay expert for opinion
    const request = await this.getRequest(requestId);
    const expert = await this.getExpert(expertId);

    // Expert gets 70% of fee, platform keeps 30%
    const expertPayout = request.estimatedFee * 0.7;

    await this.db.insert('expert_payments', {
      expert_id: expertId,
      request_id: requestId,
      gross_amount: request.estimatedFee,
      platform_fee: request.estimatedFee * 0.3,
      expert_payout: expertPayout,
      status: 'pending',
      scheduled_payment_date: this.getNextPaymentDate() // Monthly payouts
    });
  }
}
```

### 4. Database Schema

```sql
-- AATD experts
CREATE TABLE aatd_experts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Personal
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  credentials VARCHAR(100),
  title VARCHAR(200),

  -- Specialties
  primary_specialty VARCHAR(50),
  subspecialties TEXT[],

  -- AATD expertise
  aatd_experience_years INTEGER,
  aatd_patients_managed INTEGER,
  active_aatd_patients INTEGER,
  publication_count INTEGER,

  -- Institution
  institution VARCHAR(300),
  department VARCHAR(200),
  city VARCHAR(100),
  state VARCHAR(2),

  -- Expertise areas
  expertise_areas TEXT[],

  -- Second opinion services
  offers_second_opinions BOOLEAN DEFAULT true,
  second_opinion_turnaround_days INTEGER DEFAULT 7,
  second_opinion_fee DECIMAL(10, 2) DEFAULT 400.00,
  accepts_insurance BOOLEAN DEFAULT true,

  -- Availability
  available_for_urgent_reviews BOOLEAN DEFAULT false,
  monthly_capacity INTEGER DEFAULT 10,
  current_month_count INTEGER DEFAULT 0,

  -- Languages
  languages TEXT[] DEFAULT ARRAY['English'],

  -- Bio
  biography TEXT,
  education JSONB,
  board_certifications TEXT[],
  professional_memberships TEXT[],
  awards_and_honors TEXT[],
  recent_publications JSONB,

  -- Reviews
  average_rating DECIMAL(3, 2) DEFAULT 0.00,
  total_reviews INTEGER DEFAULT 0,

  -- Banking (for payments)
  stripe_account_id VARCHAR(100),

  -- Status
  active BOOLEAN DEFAULT true,
  joined_date DATE DEFAULT CURRENT_DATE,
  last_opinion_date DATE,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_experts_specialty ON aatd_experts(primary_specialty, active);
CREATE INDEX idx_experts_availability ON aatd_experts(current_month_count, monthly_capacity) WHERE active = true;

-- Second opinion requests
CREATE TABLE second_opinion_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  expert_id UUID NOT NULL,

  -- Case details
  case_title VARCHAR(300) NOT NULL,
  clinical_question TEXT NOT NULL,

  -- Patient info
  age INTEGER,
  gender VARCHAR(10),
  genotype VARCHAR(10),
  aat_level DECIMAL(5, 1),
  diagnosis_date DATE,

  -- Condition
  symptoms TEXT[],
  current_treatments TEXT[],
  relevant_history TEXT,

  -- Documents (JSONB array)
  documents JSONB,
  /*
  [
    {
      "type": "pulmonary_function_test",
      "filename": "pft_2025_10_15.pdf",
      "uploadDate": "2025-11-07T10:30:00Z",
      "s3Url": "s3://...",
      "fileSize": 245678
    }
  ]
  */

  -- Questions
  questions TEXT[],

  -- Urgency
  urgency VARCHAR(20) DEFAULT 'routine', -- 'routine', 'urgent'

  -- Payment
  estimated_fee DECIMAL(10, 2) NOT NULL,
  insurance_verified BOOLEAN DEFAULT false,
  insurance_coverage DECIMAL(10, 2),
  patient_responsibility DECIMAL(10, 2),
  payment_status VARCHAR(20) DEFAULT 'pending',
  paid_amount DECIMAL(10, 2) DEFAULT 0.00,

  -- Status
  status VARCHAR(30) DEFAULT 'draft',
  -- 'draft', 'submitted', 'assigned', 'in_review', 'completed', 'cancelled'

  -- Dates
  submitted_date TIMESTAMPTZ,
  assigned_date TIMESTAMPTZ,
  review_completed_date TIMESTAMPTZ,
  estimated_completion_date DATE,

  -- Expert response
  expert_opinion_id UUID,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_user_id) REFERENCES users(id),
  FOREIGN KEY (expert_id) REFERENCES aatd_experts(id),
  FOREIGN KEY (expert_opinion_id) REFERENCES expert_opinions(id)
);

CREATE INDEX idx_second_opinion_requests_patient ON second_opinion_requests(patient_user_id, status);
CREATE INDEX idx_second_opinion_requests_expert ON second_opinion_requests(expert_id, status);
CREATE INDEX idx_second_opinion_requests_pending ON second_opinion_requests(status, submitted_date)
  WHERE status IN ('submitted', 'assigned', 'in_review');

-- Expert opinions
CREATE TABLE expert_opinions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id UUID NOT NULL,
  expert_id UUID NOT NULL,

  -- Opinion content (JSONB for structured data)
  sections JSONB NOT NULL,
  /*
  {
    "caseSummary": "...",
    "recordsReviewed": ["...", "..."],
    "clinicalAnalysis": "...",
    "recommendations": [
      {
        "priority": "high",
        "recommendation": "...",
        "rationale": "..."
      }
    ],
    "alternativeOptions": "...",
    "followUpPlan": "...",
    "questionsAnswered": [
      {"question": "...", "answer": "..."}
    ],
    "additionalComments": "...",
    "references": ["...", "..."]
  }
  */

  -- Metadata
  review_duration_minutes INTEGER,
  word_count INTEGER,

  -- PDF
  pdf_url TEXT,

  -- Dates
  started_review_date TIMESTAMPTZ,
  completed_date TIMESTAMPTZ,

  -- Delivery
  delivered_to_patient BOOLEAN DEFAULT false,
  delivered_date TIMESTAMPTZ,
  patient_viewed_date TIMESTAMPTZ,

  -- Follow-up
  allow_follow_up_questions BOOLEAN DEFAULT true,
  follow_up_questions_asked INTEGER DEFAULT 0,

  -- Quality
  patient_rating INTEGER, -- 1-5
  patient_feedback TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (request_id) REFERENCES second_opinion_requests(id),
  FOREIGN KEY (expert_id) REFERENCES aatd_experts(id)
);

CREATE INDEX idx_expert_opinions_request ON expert_opinions(request_id);
CREATE INDEX idx_expert_opinions_expert ON expert_opinions(expert_id, completed_date DESC);

-- Expert payments
CREATE TABLE expert_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  expert_id UUID NOT NULL,
  request_id UUID NOT NULL,

  -- Amounts
  gross_amount DECIMAL(10, 2) NOT NULL, -- What patient paid
  platform_fee DECIMAL(10, 2) NOT NULL, -- 30% fee
  expert_payout DECIMAL(10, 2) NOT NULL, -- 70% to expert

  -- Status
  status VARCHAR(20) DEFAULT 'pending',
  -- 'pending', 'scheduled', 'paid', 'failed'

  -- Payment details
  scheduled_payment_date DATE,
  paid_date DATE,
  payment_method VARCHAR(50), -- 'stripe', 'ach'
  transaction_id VARCHAR(100),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (expert_id) REFERENCES aatd_experts(id),
  FOREIGN KEY (request_id) REFERENCES second_opinion_requests(id)
);

CREATE INDEX idx_expert_payments_expert ON expert_payments(expert_id, status);
CREATE INDEX idx_expert_payments_scheduled ON expert_payments(scheduled_payment_date) WHERE status = 'scheduled';

-- Follow-up questions
CREATE TABLE second_opinion_followups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  opinion_id UUID NOT NULL,
  patient_user_id UUID NOT NULL,
  expert_id UUID NOT NULL,

  -- Question
  question TEXT NOT NULL,

  -- Answer
  answer TEXT,
  answered_date TIMESTAMPTZ,

  -- Status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'answered'

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (opinion_id) REFERENCES expert_opinions(id),
  FOREIGN KEY (patient_user_id) REFERENCES users(id),
  FOREIGN KEY (expert_id) REFERENCES aatd_experts(id)
);

CREATE INDEX idx_followups_opinion ON second_opinion_followups(opinion_id, created_at);
CREATE INDEX idx_followups_expert ON second_opinion_followups(expert_id, status);
```

### 5. Patient Portal

**Patient View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  🩺 Second Opinion Service                                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  📋 REQUEST A SECOND OPINION                                    │
│                                                                  │
│  What's your primary concern?                                   │
│  [ ] Should I start augmentation therapy?                       │
│  [ ] Conflicting advice from doctors                            │
│  [ ] Pre-surgical decision (transplant, etc.)                   │
│  [ ] Abnormal test results                                      │
│  [ ] Treatment not working                                      │
│  [ ] Other: [___________________]                               │
│                                                                  │
│  Tell us about your case (500 words):                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ I'm 52, ZZ genotype, diagnosed 2018. My FEV1 has dropped │  │
│  │ from 78% to 62% over 18 months. My local pulmonologist   │  │
│  │ recommends starting Prolastin infusions. I want to know  │  │
│  │ if this is the right decision and if there are other     │  │
│  │ options...                                                │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📎 Upload Medical Records:                                     │
│  ✅ Pulmonary Function Tests (pft_2025_10.pdf)                 │
│  ✅ Chest CT Report (ct_chest_2025_08.pdf)                     │
│  ✅ AAT Genotype Report (genotype_2018.pdf)                    │
│  [+ Add More Files]                                             │
│                                                                  │
│  ❓ Specific Questions for the Expert:                          │
│  1. Should I start augmentation therapy now or wait?            │
│  2. What's my prognosis if I don't start treatment?             │
│  3. Are there alternatives to weekly IV infusions?              │
│  [+ Add Question]                                               │
│                                                                  │
│  🩺 SELECT AN EXPERT                                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ ⭐ RECOMMENDED                                            │  │
│  │                                                            │  │
│  │ Dr. Jennifer Martinez, MD, FCCP                           │  │
│  │ Professor of Medicine, University of Florida              │  │
│  │ 🌟 4.9/5 (47 reviews)                                     │  │
│  │                                                            │  │
│  │ Expertise:                                                 │  │
│  │ • Augmentation therapy decision-making                    │  │
│  │ • Early-onset COPD management                             │  │
│  │ • 25+ years AATD experience (500+ patients)               │  │
│  │                                                            │  │
│  │ Turnaround: 5-7 days | Fee: $400                          │  │
│  │ Your insurance covers: $400 (you pay: $0!)                │  │
│  │                                                            │  │
│  │ [Select Dr. Martinez] [View Full Profile]                 │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  [View More Experts (12 available)]                             │
│                                                                  │
│  ⚡ Need urgent review? (24-48 hours, +$250)                   │
│  [ ] Yes, this is time-sensitive                                │
│                                                                  │
│  💳 COST SUMMARY                                                │
│  Expert opinion fee:     $400                                   │
│  Insurance coverage:    -$400 ✅                                │
│  Your responsibility:     $0                                    │
│                                                                  │
│  [Submit Request]                                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Opinion Delivered**:

```
┌─────────────────────────────────────────────────────────────────┐
│  ✅ Your Second Opinion is Ready                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  From: Dr. Jennifer Martinez, MD, FCCP                          │
│  Completed: November 12, 2025 (5 days)                          │
│                                                                  │
│  📄 EXECUTIVE SUMMARY                                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Based on my review of your records, I recommend           │  │
│  │ initiating augmentation therapy now. Your FEV1 decline    │  │
│  │ of 8% per year is concerning and indicates aggressive     │  │
│  │ disease. You meet all FDA criteria for treatment.         │  │
│  │                                                            │  │
│  │ Key recommendations:                                       │  │
│  │ ✓ Start Prolastin-C or Zemaira (weekly IV)               │  │
│  │ ✓ Pulmonary rehabilitation program                        │  │
│  │ ✓ Repeat PFTs in 6 months to assess response             │  │
│  │ ✓ Consider gene therapy trial (if eligible)              │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📖 FULL REPORT (2,450 words, 8 pages)                          │
│  [Download PDF] [View Online]                                   │
│                                                                  │
│  Sections:                                                       │
│  • Case Summary                                                 │
│  • Records Reviewed (3 documents)                               │
│  • Clinical Analysis                                            │
│  • Recommendations (4 high-priority, 2 moderate)                │
│  • Alternative Options                                          │
│  • Follow-Up Plan                                               │
│  • Your Questions Answered (3)                                  │
│  • References (8 citations)                                     │
│                                                                  │
│  💬 HAVE FOLLOW-UP QUESTIONS?                                   │
│  You can ask Dr. Martinez 1 clarifying question (included)      │
│  [Ask Follow-Up Question]                                       │
│                                                                  │
│  ⭐ RATE THIS OPINION                                           │
│  How helpful was this second opinion?                           │
│  [★] [★] [★] [★] [★]                                           │
│                                                                  │
│  📧 NEXT STEPS                                                  │
│  • Share this opinion with your treating physician              │
│  • Discuss recommendations at your next appointment             │
│  • If you need help finding a local specialist: [Find Provider]│
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Patient Engagement

- **Opinions Requested**: 600/year (40% of ZZ patients, 5% of MZ)
- **Completion Rate**: 95% (experts complete within turnaround time)
- **Patient Satisfaction**: 4.8/5 stars average
- **Treatment Changes**: 35% of patients change treatment plan based on opinion

### Expert Network

- **Active Experts**: 50+ AATD specialists
- **Expert Retention**: 90% (experts stay active year-over-year)
- **Average Turnaround**: 5.2 days (within promised 5-7 days)
- **Opinion Quality**: 2,200 words average (exceeds 800-word minimum)

### Business Impact

- **Revenue**: $150K/year (600 opinions × $250 net after insurance)
- **Expert Payouts**: $105K/year (70% of fees)
- **Platform Revenue**: $45K/year (30% commission)
- **Patient Retention**: 90% of users stay engaged post-opinion

### Clinical Outcomes

- **Appropriate Treatment**: 80% of patients follow expert recommendations
- **Reduced Uncertainty**: 92% of patients feel more confident in decisions
- **Earlier Intervention**: 25% start treatment sooner after second opinion
- **Avoided Unnecessary Procedures**: 15% avoid unnecessary surgeries/treatments

---

## Budget Estimate

### Development (3-4 months)

- **Backend Developer** (expert network, document upload): $140K/year × 0.33 years = $46,200
- **Frontend Developer** (patient/expert portals): $140K/year × 0.33 years = $46,200

**Total Development**: ~$92,400

### Annual Operations

- **Operations Coordinator** (0.5 FTE, expert recruitment, quality): $75K/year × 0.5 = $37,500
- **Medical Director** (0.25 FTE, oversight): $200K/year × 0.25 = $50,000
- **Customer Support** (0.25 FTE, patient questions): $55K/year × 0.25 = $13,750

**Total Operations**: ~$101,250/year

### Annual Infrastructure

- **PDF Generation** (HTML to PDF service): $1,200/year
- **Document Storage** (S3): $2,400/year
- **Email/SMS Notifications**: $2,400/year
- **Payment Processing** (Stripe fees, 2.9% + $0.30): ~$4,500/year

**Total Infrastructure**: ~$10,500/year

### **GRAND TOTAL (First Year)**: ~$204,150

### **Ongoing (Year 2+)**: ~$111,750/year

**Revenue**: $150K/year (600 opinions × $250 average after insurance/expert payouts)
**Net Cost (Year 2+)**: +$38,250/year (still costs more than revenue, but breaks even at ~750 opinions/year)

---

## Risks & Mitigations

### Risk 1: Insufficient Expert Recruitment

**Impact**: Can't fulfill patient requests
**Mitigation**: Partner with AlphaNet, ATS AATD Assembly, offer attractive fee split (70%), flexible scheduling

### Risk 2: Expert Quality Variability

**Impact**: Some opinions are low-quality, disappoint patients
**Mitigation**: Minimum word count (800), peer review sample opinions, patient ratings, remove low-rated experts

### Risk 3: Liability if Patient Follows Bad Advice

**Impact**: Legal exposure if expert opinion causes harm
**Mitigation**: Clear disclaimers, malpractice insurance for experts, opinion is "second opinion" not "treatment," patient discusses with treating physician

### Risk 4: Insurance Reimbursement Challenges

**Impact**: Insurers won't cover, patients can't afford
**Mitigation**: Most insurers cover second opinions at 100%, help patients appeal denials, offer payment plans

### Risk 5: Expert Burnout

**Impact**: Experts leave network, can't fulfill requests
**Mitigation**: Cap monthly opinions (10/month), offer premium urgent fees (+$250), recognize top experts publicly

---

**Document Owner**: Chief Medical Officer, VP Product
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
