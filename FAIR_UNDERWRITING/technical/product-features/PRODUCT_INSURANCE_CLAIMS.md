# Feature #11: Insurance Verification & Claims Management

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 5-6 months
**Team Required**: 1 backend developer, 1 integration specialist, 1 frontend developer, 0.5 FTE billing specialist

---

## Executive Summary

Genetic testing is expensive ($250-500/test) and augmentation therapy costs $200K+/year. Patients need to know if their insurance covers AATD testing and treatment BEFORE starting. Fair Underwriting currently processes tests without real-time insurance verification, leading to surprise bills, claim denials, and patient complaints. This feature builds an automated insurance verification and claims management platform that checks eligibility in real-time, submits claims electronically, tracks payment status, and handles denials/appeals.

**Key Value Propositions**:

- **Real-Time Eligibility**: Verify insurance coverage before test is ordered (270/271 EDI)
- **Automated Claims**: Submit claims electronically via 837 EDI (95% of claims)
- **Payment Tracking**: Monitor claim status from submission to payment
- **Denial Management**: AI-powered denial analysis, automated appeal generation
- **Patient Cost Estimates**: Show exact out-of-pocket cost upfront
- **Balance Billing**: Automated patient invoicing for remaining balance

**Business Impact**:

- Reduce claim denials: 18% → 4% (industry-leading)
- Faster payment: 45 days → 18 days average (57% improvement)
- Collections improvement: 85% → 94% of patient balances collected
- Administrative cost savings: $45/claim → $12/claim (73% reduction)
- Patient satisfaction: 4.6/5 stars for billing transparency

---

## Problem Statement

### Current Gaps

**Scenario 1: Patient Receives $450 Surprise Bill**

> "I took the AATD test thinking my insurance covered it. 3 months later I got a bill for $450. If I knew it wasn't covered, I would have used the self-pay discount ($250). Now I'm stuck with the higher bill and collections calls."

**No upfront insurance verification** ❌

**Scenario 2: Claim Denied - Wrong Diagnosis Code**

> "Insurance denied my augmentation therapy claim because the provider used the wrong ICD-10 code (E88.09 instead of E88.01). It took 3 months to resubmit and get paid. During that time, my pharmacy stopped shipping my medication."

**No automated claim validation** ❌

**Scenario 3: Patient Can't Afford $2,000 Deductible**

> "My insurance covers genetic testing but I haven't met my $2,000 deductible. I can't afford that right now. Why didn't anyone tell me before I did the test?"

**No cost estimation upfront** ❌

**Scenario 4: Claim Lost in System**

> "It's been 90 days since my test. I call the billing department - they say they submitted the claim. I call insurance - they have no record of it. Nobody knows where my claim is."

**No claim tracking visibility** ❌

**Scenario 5: Denial Appeal Process Unclear**

> "Insurance denied my augmentation therapy as 'not medically necessary.' I think this is wrong - my FEV1 is 55%. How do I appeal? What evidence do I need?"

**No automated appeal support** ❌

---

## Feature Specifications

### 1. Real-Time Insurance Eligibility Verification

**HIPAA 270/271 EDI Transaction**:

```typescript
interface InsuranceEligibilityRequest {
  // Patient info
  patientFirstName: string;
  patientLastName: string;
  dateOfBirth: string; // YYYY-MM-DD
  gender: 'M' | 'F' | 'U';
  memberId: string; // Insurance member ID

  // Insurance payer
  payerId: string; // '00123' for Blue Cross, '87726' for Aetna
  payerName: string;

  // Service being verified
  serviceTypeCode: string; // '88' for genetic testing, '98' for specialty pharmacy
  serviceDateFrom: string;
  serviceDateTo: string;

  // Provider info
  providerNPI: string;
  providerTaxId: string;
}

interface InsuranceEligibilityResponse {
  // Eligibility status
  eligible: boolean;
  effectiveDate: string;
  terminationDate?: string;

  // Coverage details
  coverage: {
    planName: string;
    groupNumber: string;
    coverageLevel: 'individual' | 'family';

    // Deductible
    deductible: {
      individual: number;
      family: number;
      remaining: number; // How much left to meet
      metPercentage: number; // 0-100
    };

    // Out-of-pocket max
    outOfPocketMax: {
      individual: number;
      family: number;
      remaining: number;
    };

    // Copay/coinsurance
    copayAmount?: number; // Fixed copay (e.g., $30)
    coinsurancePercent?: number; // Percentage (e.g., 20%)

    // Service-specific coverage
    servicesCovered: {
      serviceType: string;
      covered: boolean;
      priorAuthRequired: boolean;
      networkStatus: 'in_network' | 'out_of_network' | 'unknown';
      copay?: number;
      coinsurance?: number;
      limitations?: string; // "1 genetic test per lifetime"
    }[];
  };

  // Additional info
  planType: 'HMO' | 'PPO' | 'EPO' | 'POS' | 'HDHP';
  isPrimaryInsurance: boolean;
  secondaryInsurance?: {
    payerId: string;
    memberId: string;
  };

  // Response metadata
  verificationDate: Date;
  traceNumber: string; // For tracking with payer
}

class InsuranceVerificationService {
  private changeHealthcareClient: ChangeHealthcareClient;

  async verifyEligibility(
    request: InsuranceEligibilityRequest
  ): Promise<InsuranceEligibilityResponse> {
    // Build 270 EDI transaction
    const edi270 = this.build270Transaction(request);

    // Send to clearinghouse (Change Healthcare, Availity, Waystar)
    const response = await this.changeHealthcareClient.post(
      '/eligibility/v3',
      edi270
    );

    // Parse 271 response
    const eligibility = this.parse271Response(response.data);

    // Store verification result
    await this.db.insert('insurance_verifications', {
      patient_user_id: request.patientUserId,
      payer_id: request.payerId,
      verification_date: new Date(),
      eligible: eligibility.eligible,
      coverage_details: eligibility.coverage,
      trace_number: eligibility.traceNumber
    });

    return eligibility;
  }

  build270Transaction(request: InsuranceEligibilityRequest): string {
    // HIPAA 270 format (simplified)
    return `
ISA*00*          *00*          *ZZ*SUBMITTERID    *ZZ*PAYERID        *${this.formatDate(new Date())}*${this.formatTime(new Date())}*^*00501*000000001*0*P*:~
GS*HS*SUBMITTERID*PAYERID*${this.formatDate(new Date())}*${this.formatTime(new Date())}*1*X*005010X279A1~
ST*270*0001*005010X279A1~
BHT*0022*13*${request.traceNumber}*${this.formatDate(new Date())}*${this.formatTime(new Date())}~
HL*1**20*1~
NM1*PR*2*${request.payerName}*****PI*${request.payerId}~
HL*2*1*21*1~
NM1*1P*2*${request.providerName}*****XX*${request.providerNPI}~
HL*3*2*22*0~
TRN*1*${request.traceNumber}*${request.providerNPI}~
NM1*IL*1*${request.patientLastName}*${request.patientFirstName}****MI*${request.memberId}~
DMG*D8*${request.dateOfBirth.replace(/-/g, '')}*${request.gender}~
DTP*291*D8*${request.serviceDateFrom.replace(/-/g, '')}~
EQ*${request.serviceTypeCode}~
SE*13*0001~
GE*1*1~
IEA*1*000000001~
    `.trim();
  }

  parse271Response(edi271: string): InsuranceEligibilityResponse {
    // Parse EDI 271 response (this is complex - typically use a library)
    // Simplified example
    const segments = edi271.split('~');

    // Extract eligibility status from EB segments
    const ebSegments = segments.filter((s) => s.startsWith('EB*'));

    // EB*1 = Active coverage
    // EB*6 = Deductible
    // EB*C = Coinsurance

    return {
      eligible: ebSegments.some((s) => s.includes('EB*1')),
      effectiveDate: this.extractDate(segments, 'DTP*348'),
      coverage: this.parseCoverageDetails(ebSegments),
      verificationDate: new Date(),
      traceNumber: this.extractTraceNumber(segments)
    };
  }

  async estimatePatientCost(
    serviceCode: string,
    billedAmount: number,
    eligibility: InsuranceEligibilityResponse
  ): Promise<PatientCostEstimate> {
    let patientOwes = 0;
    let insurancePays = 0;

    // Check if deductible met
    if (eligibility.coverage.deductible.remaining > 0) {
      // Patient pays toward deductible first
      const deductiblePortion = Math.min(
        billedAmount,
        eligibility.coverage.deductible.remaining
      );
      patientOwes += deductiblePortion;
      billedAmount -= deductiblePortion;
    }

    // Apply coinsurance to remaining amount
    if (billedAmount > 0 && eligibility.coverage.coinsurancePercent) {
      const coinsuranceAmount =
        billedAmount * (eligibility.coverage.coinsurancePercent / 100);
      patientOwes += coinsuranceAmount;
      insurancePays += billedAmount - coinsuranceAmount;
    } else if (billedAmount > 0 && eligibility.coverage.copayAmount) {
      // Fixed copay
      patientOwes += eligibility.coverage.copayAmount;
      insurancePays += billedAmount - eligibility.coverage.copayAmount;
    } else {
      insurancePays += billedAmount;
    }

    // Check out-of-pocket max
    if (patientOwes > eligibility.coverage.outOfPocketMax.remaining) {
      insurancePays +=
        patientOwes - eligibility.coverage.outOfPocketMax.remaining;
      patientOwes = eligibility.coverage.outOfPocketMax.remaining;
    }

    return {
      billedAmount: billedAmount + patientOwes,
      insurancePays,
      patientOwes,
      breakdown: {
        deductible: Math.min(
          billedAmount,
          eligibility.coverage.deductible.remaining
        ),
        coinsurance: eligibility.coverage.coinsurancePercent ? patientOwes : 0,
        copay: eligibility.coverage.copayAmount || 0
      }
    };
  }
}

interface PatientCostEstimate {
  billedAmount: number;
  insurancePays: number;
  patientOwes: number;
  breakdown: {
    deductible: number;
    coinsurance: number;
    copay: number;
  };
}
```

### 2. Electronic Claims Submission (837 EDI)

**HIPAA 837 Professional Claim**:

```typescript
interface MedicalClaim {
  claimId: string;

  // Patient
  patientUserId: string;
  patientName: string;
  patientDOB: string;
  patientGender: 'M' | 'F';
  memberId: string;

  // Insurance
  insurancePayerId: string;
  insurancePayerName: string;
  insuranceGroupNumber?: string;

  // Provider (billing)
  billingProviderNPI: string;
  billingProviderName: string;
  billingProviderTaxId: string;
  billingProviderAddress: Address;

  // Provider (rendering - who performed service)
  renderingProviderNPI?: string;
  renderingProviderName?: string;

  // Service details
  serviceDate: string;
  placeOfService: string; // '11' = Office, '81' = Independent Lab

  // Charges
  charges: {
    procedureCode: string; // CPT code, e.g., '81332' for AATD genotyping
    modifiers?: string[]; // CPT modifiers
    diagnosisCodes: string[]; // ICD-10 codes
    chargeAmount: number;
    units: number;
    description: string;
  }[];

  totalCharges: number;

  // Status
  status: 'draft' | 'submitted' | 'accepted' | 'rejected' | 'paid' | 'denied' | 'appealed';

  // Tracking
  submittedDate?: Date;
  payerClaimNumber?: string; // Payer's internal tracking number
  checkNumber?: string;
  paidAmount?: number;
  paidDate?: Date;

  // Denial info
  denialCode?: string;
  denialReason?: string;
  appealDeadline?: Date;
}

class ClaimsSubmissionService {
  async submitClaim(claim: MedicalClaim): Promise<ClaimSubmissionResult> {
    // Validate claim before submission
    const validation = await this.validateClaim(claim);
    if (!validation.valid) {
      return { success: false, errors: validation.errors };
    }

    // Build 837 EDI transaction
    const edi837 = this.build837Transaction(claim);

    // Submit to clearinghouse
    const response = await this.changeHealthcareClient.post('/claims/v3', edi837);

    // Store submission record
    await this.db.insert('claim_submissions', {
      claim_id: claim.claimId,
      submitted_date: new Date(),
      status: 'submitted',
      clearinghouse_id: response.clearinghouseId,
      trace_number: response.traceNumber
    });

    // Schedule status check in 24 hours
    await this.scheduleClaim StatusCheck(claim.claimId, 24);

    return {
      success: true,
      clearinghouseId: response.clearinghouseId,
      traceNumber: response.traceNumber,
      estimatedProcessingDays: 14
    };
  }

  validateClaim(claim: MedicalClaim): ClaimValidation {
    const errors: string[] = [];

    // Required fields
    if (!claim.billingProviderNPI || claim.billingProviderNPI.length !== 10) {
      errors.push('Invalid billing provider NPI');
    }

    if (!claim.insurancePayerId) {
      errors.push('Insurance payer ID required');
    }

    if (!claim.memberId) {
      errors.push('Patient member ID required');
    }

    // Validate CPT codes
    for (const charge of claim.charges) {
      if (!this.isValidCPT(charge.procedureCode)) {
        errors.push(`Invalid CPT code: ${charge.procedureCode}`);
      }

      // Check if diagnosis code matches procedure
      if (!this.isDiagnosisAppropriate(charge.procedureCode, charge.diagnosisCodes)) {
        errors.push(`Diagnosis code mismatch for CPT ${charge.procedureCode}`);
      }
    }

    // AATD-specific validations
    if (claim.charges.some(c => c.procedureCode === '81332')) {
      // AATD genotyping requires specific diagnosis codes
      const validDiagnosisCodes = ['E88.01', 'Z13.228', 'J43.9', 'K74.60'];
      const hasDiagnosis = claim.charges.some(c =>
        c.diagnosisCodes.some(d => validDiagnosisCodes.includes(d))
      );

      if (!hasDiagnosis) {
        errors.push('AATD genotyping requires diagnosis code E88.01, Z13.228, J43.9, or K74.60');
      }
    }

    return {
      valid: errors.length === 0,
      errors
    };
  }

  build837Transaction(claim: MedicalClaim): string {
    // HIPAA 837P (Professional) format
    // This is highly complex - typically use a library like node-edi-x12
    return `
ISA*00*          *00*          *ZZ*${claim.billingProviderTaxId.padEnd(15)}*ZZ*${claim.insurancePayerId.padEnd(15)}*${this.formatDate(new Date())}*${this.formatTime(new Date())}*^*00501*000000001*0*P*:~
GS*HC*${claim.billingProviderTaxId}*${claim.insurancePayerId}*${this.formatDate(new Date())}*${this.formatTime(new Date())}*1*X*005010X222A1~
ST*837*0001*005010X222A1~
BHT*0019*00*${claim.claimId}*${this.formatDate(new Date())}*${this.formatTime(new Date())}*CH~
NM1*41*2*${claim.billingProviderName}*****46*${claim.billingProviderTaxId}~
PER*IC*${claim.billingContact}*TE*${claim.billingPhone}~
NM1*40*2*${claim.insurancePayerName}*****PI*${claim.insurancePayerId}~
HL*1**20*1~
PRV*BI*PXC*207Q00000X~
NM1*85*2*${claim.billingProviderName}*****XX*${claim.billingProviderNPI}~
N3*${claim.billingProviderAddress.street}~
N4*${claim.billingProviderAddress.city}*${claim.billingProviderAddress.state}*${claim.billingProviderAddress.zip}~
HL*2*1*22*0~
SBR*P*18*${claim.insuranceGroupNumber}******CI~
NM1*IL*1*${claim.patientName.split(' ')[1]}*${claim.patientName.split(' ')[0]}****MI*${claim.memberId}~
N3*${claim.patientAddress.street}~
N4*${claim.patientAddress.city}*${claim.patientAddress.state}*${claim.patientAddress.zip}~
DMG*D8*${claim.patientDOB.replace(/-/g, '')}*${claim.patientGender}~
NM1*PR*2*${claim.insurancePayerName}*****PI*${claim.insurancePayerId}~
CLM*${claim.claimId}*${claim.totalCharges}***${claim.placeOfService}:B:1*Y*A*Y*Y~
${claim.charges.map((charge, idx) => `
DTP*472*D8*${claim.serviceDate.replace(/-/g, '')}~
HI*BK:${charge.diagnosisCodes[0].replace('.', '')}~
LX*${idx + 1}~
SV1*HC:${charge.procedureCode}*${charge.chargeAmount}*UN*${charge.units}***1~
DTP*472*D8*${claim.serviceDate.replace(/-/g, '')}~
`).join('')}
SE*${this.countSegments(claim)}*0001~
GE*1*1~
IEA*1*000000001~
    `.trim();
  }

  async checkClaimStatus(claimId: string): Promise<ClaimStatus> {
    // Query 277 claim status request
    const status277 = await this.changeHealthcareClient.get(`/claims/${claimId}/status`);

    // Parse response
    return this.parse277Response(status277);
  }
}

interface ClaimStatus {
  claimId: string;
  status: 'submitted' | 'accepted' | 'rejected' | 'payer_received' | 'adjudicated' | 'paid' | 'denied';
  statusDate: Date;
  payerClaimNumber?: string;

  // Payment info
  allowedAmount?: number; // What insurance approved
  paidAmount?: number; // What insurance paid
  patientResponsibility?: number; // Patient owes
  adjustmentReason?: string; // Why different from billed

  // Check/payment info
  checkNumber?: string;
  checkDate?: Date;

  // Denial info
  denialCode?: string;
  denialReason?: string;
}
```

### 3. Denial Management & Appeals

**AI-Powered Denial Analysis**:

```typescript
interface ClaimDenial {
  claimId: string;
  denialDate: Date;

  // Denial details
  denialCode: string; // CARC (Claim Adjustment Reason Code)
  denialReason: string;
  denialCategory:
    | 'coverage'
    | 'authorization'
    | 'coding'
    | 'duplicate'
    | 'timely_filing'
    | 'medical_necessity';

  // Financial impact
  deniedAmount: number;

  // Appeal info
  appealable: boolean;
  appealDeadline: Date;
  appealStatus?:
    | 'not_started'
    | 'in_progress'
    | 'submitted'
    | 'approved'
    | 'denied_again';
}

class DenialManagementService {
  async analyzeDenial(denial: ClaimDenial): Promise<DenialAnalysis> {
    // Use GPT-4 to analyze denial and suggest fixes
    const claim = await this.getClaim(denial.claimId);

    const prompt = `
Analyze this insurance claim denial and provide actionable recommendations.

Claim Details:
- Service: ${claim.charges[0].description}
- CPT Code: ${claim.charges[0].procedureCode}
- Diagnosis: ${claim.charges[0].diagnosisCodes.join(', ')}
- Billed Amount: $${claim.totalCharges}

Denial:
- Code: ${denial.denialCode}
- Reason: ${denial.denialReason}

Tasks:
1. Classify denial category (coding error, medical necessity, authorization, etc.)
2. Determine if denial is valid or should be appealed
3. Provide step-by-step appeal strategy
4. Draft appeal letter text
5. List required supporting documents
    `;

    const gpt4Response = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [{ role: 'user', content: prompt }]
    });

    return this.parseDenialAnalysis(gpt4Response.choices[0].message.content);
  }

  async generateAppealLetter(denial: ClaimDenial): Promise<string> {
    const analysis = await this.analyzeDenial(denial);
    const claim = await this.getClaim(denial.claimId);
    const patient = await this.getPatient(claim.patientUserId);

    // Generate appeal letter
    return `
[Date]

${claim.insurancePayerName}
Appeals Department
[Address]

RE: Appeal of Claim Denial
Claim Number: ${denial.claimId}
Patient: ${patient.name}
Member ID: ${patient.memberId}
Date of Service: ${claim.serviceDate}
Denied Amount: $${denial.deniedAmount}

Dear Appeals Coordinator,

I am writing to formally appeal the denial of the above-referenced claim for Alpha-1 Antitrypsin Deficiency (AATD) genetic testing.

REASON FOR DENIAL:
Your explanation of benefits states: "${denial.denialReason}" (Code: ${denial.denialCode})

GROUNDS FOR APPEAL:
${analysis.appealRationale}

CLINICAL JUSTIFICATION:
${this.buildClinicalJustification(claim, patient)}

SUPPORTING DOCUMENTATION:
${analysis.requiredDocuments.map((doc, idx) => `${idx + 1}. ${doc}`).join('\n')}

Based on the above information, I respectfully request that you overturn this denial and approve payment of $${denial.deniedAmount}.

If you require additional information, please contact me at [phone] or [email].

Sincerely,

[Provider Name]
[NPI: ${claim.billingProviderNPI}]
    `.trim();
  }

  buildClinicalJustification(claim: MedicalClaim, patient: any): string {
    // Build evidence-based justification
    if (claim.charges.some((c) => c.procedureCode === '81332')) {
      // AATD genotyping
      return `
The patient presents with symptoms consistent with Alpha-1 Antitrypsin Deficiency:
- ${patient.symptoms.join('\n- ')}

AATD genetic testing (CPT 81332) is medically necessary because:
1. Early-onset COPD (age ${patient.age}) without significant smoking history
2. Family history of COPD/liver disease
3. Low AAT level (${patient.aatLevel} mg/dL, normal >150 mg/dL)

Per ATS/ERS guidelines (2003), genetic testing is recommended for:
- Individuals with COPD (especially early-onset or non-smokers)
- Individuals with unexplained liver disease
- Siblings of known AATD patients

This testing directly impacts treatment decisions. If patient tests ZZ, augmentation therapy (weekly Prolastin infusions) is indicated and can slow disease progression.

Supporting Citations:
- American Thoracic Society/European Respiratory Society Statement (2003)
- AATD-specific CPT code 81332 approved by AMA for this exact indication
      `.trim();
    }

    return '';
  }

  async submitAppeal(
    denialId: string,
    appealLetter: string,
    supportingDocs: string[]
  ): Promise<AppealResult> {
    // Submit appeal via fax or portal
    const denial = await this.getDenial(denialId);
    const claim = await this.getClaim(denial.claimId);

    // Send via payer portal or fax
    if (this.payerHasPortal(claim.insurancePayerId)) {
      return this.submitViaPortal(
        claim.insurancePayerId,
        appealLetter,
        supportingDocs
      );
    } else {
      return this.submitViaFax(
        claim.insurancePayerFax,
        appealLetter,
        supportingDocs
      );
    }
  }
}

interface DenialAnalysis {
  denialCategory: string;
  appealable: boolean;
  appealRationale: string;
  successProbability: number; // 0-100
  requiredDocuments: string[];
  appealStrategy: string[];
  estimatedTimeToResolution: number; // days
}
```

### 4. Database Schema

```sql
-- Insurance verifications
CREATE TABLE insurance_verifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Payer info
  payer_id VARCHAR(50) NOT NULL,
  payer_name VARCHAR(200),
  member_id VARCHAR(100),
  group_number VARCHAR(100),

  -- Verification details
  verification_date TIMESTAMPTZ DEFAULT NOW(),
  service_date DATE, -- Date of service being verified
  service_type_code VARCHAR(10), -- '88' for genetic testing

  -- Eligibility result
  eligible BOOLEAN,
  effective_date DATE,
  termination_date DATE,

  -- Coverage details (JSONB for flexibility)
  coverage_details JSONB,
  /*
  {
    "planName": "Blue Cross PPO Gold",
    "deductible": { "individual": 2000, "remaining": 500 },
    "outOfPocketMax": { "individual": 5000, "remaining": 3000 },
    "coinsurance": 20,
    "geneticTestingCovered": true,
    "priorAuthRequired": false
  }
  */

  -- Tracking
  trace_number VARCHAR(100), -- From 271 response

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, patient_user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_insurance_verifications_patient ON insurance_verifications(patient_user_id, verification_date DESC);

-- Medical claims
CREATE TABLE medical_claims (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  claim_number VARCHAR(50) UNIQUE NOT NULL,
  tenant_id UUID NOT NULL,

  -- Patient
  patient_user_id UUID NOT NULL,
  patient_name VARCHAR(200),
  patient_dob DATE,
  patient_gender VARCHAR(1),
  member_id VARCHAR(100),

  -- Insurance
  insurance_payer_id VARCHAR(50),
  insurance_payer_name VARCHAR(200),
  insurance_group_number VARCHAR(100),

  -- Provider
  billing_provider_npi VARCHAR(10),
  billing_provider_name VARCHAR(200),
  billing_provider_tax_id VARCHAR(20),
  rendering_provider_npi VARCHAR(10),

  -- Service
  service_date DATE NOT NULL,
  place_of_service VARCHAR(5), -- '11' = Office, '81' = Lab

  -- Charges (JSONB array)
  charges JSONB,
  /*
  [
    {
      "procedureCode": "81332",
      "description": "AATD genotyping",
      "diagnosisCodes": ["E88.01"],
      "chargeAmount": 450.00,
      "units": 1
    }
  ]
  */

  -- Financial
  total_charges DECIMAL(10, 2) NOT NULL,
  allowed_amount DECIMAL(10, 2),
  insurance_paid DECIMAL(10, 2),
  patient_responsibility DECIMAL(10, 2),
  paid_amount DECIMAL(10, 2) DEFAULT 0.00,
  balance DECIMAL(10, 2),

  -- Status
  status VARCHAR(30) DEFAULT 'draft',
  -- 'draft', 'submitted', 'accepted', 'rejected', 'payer_received',
  -- 'adjudicated', 'paid', 'denied', 'appealed', 'written_off'

  -- Tracking
  submitted_date TIMESTAMPTZ,
  payer_claim_number VARCHAR(100), -- Payer's internal ID
  clearinghouse_id VARCHAR(100),
  trace_number VARCHAR(100),

  -- Payment
  check_number VARCHAR(50),
  check_date DATE,
  paid_date TIMESTAMPTZ,

  -- Denial
  denial_code VARCHAR(10), -- CARC code
  denial_reason TEXT,
  appeal_deadline DATE,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, patient_user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_medical_claims_patient ON medical_claims(patient_user_id, service_date DESC);
CREATE INDEX idx_medical_claims_status ON medical_claims(status, submitted_date);
CREATE INDEX idx_medical_claims_balance ON medical_claims(balance) WHERE balance > 0;

-- Claim submissions (tracking history)
CREATE TABLE claim_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  claim_id UUID NOT NULL,

  -- Submission details
  submitted_date TIMESTAMPTZ DEFAULT NOW(),
  submission_method VARCHAR(30), -- 'edi_837', 'portal', 'paper'
  clearinghouse_id VARCHAR(100),
  trace_number VARCHAR(100),

  -- Response
  response_received_date TIMESTAMPTZ,
  response_status VARCHAR(30), -- 'accepted', 'rejected'
  response_details TEXT,

  -- Rejection info
  rejection_code VARCHAR(50),
  rejection_reason TEXT,

  -- Resubmission
  is_resubmission BOOLEAN DEFAULT false,
  original_submission_id UUID,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (claim_id) REFERENCES medical_claims(id),
  FOREIGN KEY (original_submission_id) REFERENCES claim_submissions(id)
);

CREATE INDEX idx_claim_submissions_claim ON claim_submissions(claim_id, submitted_date DESC);

-- Claim denials
CREATE TABLE claim_denials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  claim_id UUID NOT NULL,

  -- Denial details
  denial_date DATE NOT NULL,
  denial_code VARCHAR(10), -- CARC (Claim Adjustment Reason Code)
  denial_reason TEXT NOT NULL,
  denial_category VARCHAR(30),
  -- 'coverage', 'authorization', 'coding', 'duplicate', 'timely_filing', 'medical_necessity'

  -- Financial impact
  denied_amount DECIMAL(10, 2) NOT NULL,

  -- Appeal info
  appealable BOOLEAN DEFAULT true,
  appeal_deadline DATE,
  appeal_status VARCHAR(30) DEFAULT 'not_started',
  -- 'not_started', 'in_progress', 'submitted', 'approved', 'denied_again', 'abandoned'

  -- Appeal tracking
  appeal_submitted_date TIMESTAMPTZ,
  appeal_decision_date TIMESTAMPTZ,
  appeal_decision TEXT,
  appeal_recovered_amount DECIMAL(10, 2),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (claim_id) REFERENCES medical_claims(id)
);

CREATE INDEX idx_claim_denials_claim ON claim_denials(claim_id);
CREATE INDEX idx_claim_denials_appeal ON claim_denials(appeal_status, appeal_deadline);

-- Patient statements (invoices)
CREATE TABLE patient_statements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Statement details
  statement_number VARCHAR(50) UNIQUE NOT NULL,
  statement_date DATE NOT NULL,
  due_date DATE NOT NULL,

  -- Charges included
  claim_ids UUID[], -- Multiple claims can be on one statement

  -- Financial
  total_charges DECIMAL(10, 2) NOT NULL,
  insurance_paid DECIMAL(10, 2),
  adjustments DECIMAL(10, 2) DEFAULT 0.00,
  patient_balance DECIMAL(10, 2) NOT NULL,
  amount_due DECIMAL(10, 2) NOT NULL,

  -- Payment status
  status VARCHAR(30) DEFAULT 'sent',
  -- 'draft', 'sent', 'viewed', 'payment_plan', 'paid', 'written_off', 'collections'

  -- Delivery
  sent_via_email BOOLEAN DEFAULT false,
  sent_via_mail BOOLEAN DEFAULT false,
  email_viewed_date TIMESTAMPTZ,

  -- Payment
  paid_amount DECIMAL(10, 2) DEFAULT 0.00,
  paid_date TIMESTAMPTZ,
  payment_method VARCHAR(30), -- 'credit_card', 'ach', 'check', 'cash'

  -- Collections
  sent_to_collections_date DATE,
  collections_agency VARCHAR(200),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, patient_user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_patient_statements_patient ON patient_statements(patient_user_id, statement_date DESC);
CREATE INDEX idx_patient_statements_due ON patient_statements(status, due_date) WHERE status IN ('sent', 'viewed');

-- Payment plans
CREATE TABLE payment_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  statement_id UUID NOT NULL,

  -- Plan details
  plan_start_date DATE NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  monthly_payment DECIMAL(10, 2) NOT NULL,
  number_of_payments INTEGER NOT NULL,

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'completed', 'defaulted'

  -- Tracking
  payments_made INTEGER DEFAULT 0,
  total_paid DECIMAL(10, 2) DEFAULT 0.00,
  balance DECIMAL(10, 2),
  next_payment_due_date DATE,

  -- Default
  missed_payments INTEGER DEFAULT 0,
  defaulted_date DATE,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_user_id) REFERENCES users(id),
  FOREIGN KEY (statement_id) REFERENCES patient_statements(id)
);

CREATE INDEX idx_payment_plans_patient ON payment_plans(patient_user_id, status);
CREATE INDEX idx_payment_plans_due ON payment_plans(next_payment_due_date) WHERE status = 'active';
```

### 5. Patient Billing Portal

**Patient View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  💳 My Bills - John Doe                                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  📊 ACCOUNT SUMMARY                                             │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Current Balance: $125.00                                  │  │
│  │ Payment Due: December 15, 2025                            │  │
│  │ [Pay Now] [Set Up Payment Plan]                           │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🧾 RECENT STATEMENTS                                           │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Statement #2025-001 - November 15, 2025                   │  │
│  │                                                            │  │
│  │ Service: AATD Genetic Testing                             │  │
│  │ Date of Service: October 10, 2025                         │  │
│  │ Provider: Fair Underwriting Lab                           │  │
│  │                                                            │  │
│  │ 💰 CHARGES                                                │  │
│  │ Total Charges:        $450.00                             │  │
│  │ Insurance Paid:       $325.00 ✅                          │  │
│  │ Your Responsibility:  $125.00                             │  │
│  │   - Deductible:       $100.00                             │  │
│  │   - Coinsurance:      $ 25.00 (20%)                       │  │
│  │                                                            │  │
│  │ 📋 INSURANCE CLAIM STATUS                                 │  │
│  │ Submitted: October 12, 2025                               │  │
│  │ Status: ✅ Paid (November 5, 2025)                        │  │
│  │ Claim #: 2025-ABC-123456                                  │  │
│  │ EOB: [View Explanation of Benefits]                       │  │
│  │                                                            │  │
│  │ Amount Due: $125.00                                       │  │
│  │ Due Date: December 15, 2025                               │  │
│  │                                                            │  │
│  │ [Pay $125.00] [Request Payment Plan] [Download PDF]       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ❓ QUESTIONS ABOUT YOUR BILL?                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ • Why do I owe money if I have insurance?                 │  │
│  │   → Your plan has a $2,000 deductible. You paid $100     │  │
│  │     toward your deductible + 20% coinsurance.            │  │
│  │                                                            │  │
│  │ • Can I set up a payment plan?                            │  │
│  │   → Yes! We offer 3, 6, or 12-month plans at 0% interest│  │
│  │     [Set Up Payment Plan]                                 │  │
│  │                                                            │  │
│  │ • I think my insurance should have covered more           │  │
│  │   → Contact your insurance at: 1-800-XXX-XXXX            │  │
│  │     Reference claim #: 2025-ABC-123456                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💳 PAYMENT METHODS                                             │
│  • Credit/Debit Card (Visa, MC, Amex, Discover)                │
│  • Bank Account (ACH)                                           │
│  • Payment Plan (0% interest, 3-12 months)                      │
│  • HSA/FSA Card                                                 │
│                                                                  │
│  [Payment History] [Update Payment Method] [Contact Support]    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Claims Performance

- **Claim Acceptance Rate**: 96% (vs. 82% baseline)
- **Denial Rate**: 4% (vs. 18% industry average)
- **Days to Payment**: 18 days average (vs. 45 days)
- **Appeal Success Rate**: 75% (vs. 50% industry)

### Financial Metrics

- **Collections Rate**: 94% of patient balances (vs. 85%)
- **Administrative Cost per Claim**: $12 (vs. $45 manual)
- **Bad Debt Write-offs**: 2% (vs. 8% industry)
- **Revenue Cycle Improvement**: $180K/year additional revenue

### Patient Experience

- **Cost Transparency**: 95% know out-of-pocket cost before service
- **Billing Complaint Rate**: <2% (vs. 12% baseline)
- **Payment Plan Enrollment**: 40% of patients >$200 balance
- **Patient Satisfaction**: 4.6/5 stars for billing

### Operational Efficiency

- **Staff Time Savings**: 60% reduction in manual claim work
- **Insurance Verification Time**: 2 minutes (vs. 15 minutes phone call)
- **Appeal Turnaround**: 5 days (vs. 21 days manual)

---

## Budget Estimate

### Development (5-6 months)

- **Backend Developer** (EDI integration, APIs): $140K/year × 0.5 years = $70,000
- **Integration Specialist** (Change Healthcare, clearinghouse): $150K/year × 0.5 years = $75,000
- **Frontend Developer** (patient/provider portals): $140K/year × 0.33 years = $46,200

**Total Development**: ~$191,200

### Annual Operations

- **Billing Specialist** (0.5 FTE): $65K/year × 0.5 = $32,500
- **Appeals Specialist** (denials/appeals): $70K/year
- **Customer Support** (billing questions): $55K/year × 0.5 FTE = $27,500

**Total Operations**: ~$130,000/year

### Annual Infrastructure & Licensing

- **Change Healthcare Clearinghouse**: $35,000/year
- **EDI Transaction Fees**: $0.50/claim × 5,000 claims = $2,500/year
- **GPT-4 API** (denial analysis): $3,600/year
- **Payment Processing**: 2.9% + $0.30 per transaction = ~$8,000/year
- **Database & Storage**: $3,600/year

**Total Infrastructure**: ~$52,700/year

### **GRAND TOTAL (First Year)**: ~$373,900

### **Ongoing (Year 2+)**: ~$182,700/year

**Revenue Impact**: +$180,000/year (faster collections, reduced write-offs)
**Net Cost (Year 2+)**: ~$2,700/year (nearly revenue-neutral!)

---

## Risks & Mitigations

### Risk 1: Clearinghouse Integration Complexity

**Impact**: EDI transactions fail, claims not submitted
**Mitigation**: Work with experienced clearinghouse (Change Healthcare has 95% market share), thorough testing, fallback to paper/portal submissions

### Risk 2: Payer-Specific Rules Vary

**Impact**: Claims denied due to payer-specific requirements
**Mitigation**: Build payer-specific validation rules, maintain library of common denial reasons, continuous learning from denials

### Risk 3: Patient Confusion About Bills

**Impact**: Patients don't understand EOB vs. patient statement
**Mitigation**: Clear, plain-language explanations, FAQs, live chat support, educational videos

### Risk 4: HIPAA Compliance

**Impact**: PHI exposed in billing communications
**Mitigation**: Encrypted patient portal, secure messaging, HIPAA training for billing staff, regular audits

### Risk 5: Payment Processing Failures

**Impact**: Patients can't pay online, frustration
**Mitigation**: Stripe/Square integration (99.9% uptime), multiple payment methods, phone payment option, payment plan flexibility

---

**Document Owner**: VP Finance, Revenue Cycle Manager
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
