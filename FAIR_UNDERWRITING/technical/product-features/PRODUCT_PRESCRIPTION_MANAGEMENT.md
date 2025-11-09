# Feature #10: Prescription Management & Pharmacy Integration

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 backend developer, 1 integration specialist, 1 frontend developer, 0.25 FTE pharmacy liaison

---

## Executive Summary

ZZ patients on augmentation therapy (Prolastin, Aralast, Zemaira) face significant barriers: specialty pharmacy coordination, prior authorization delays (3-6 weeks), $200K+ annual drug costs, and complex infusion scheduling. Fair Underwriting currently provides test results but leaves patients to navigate the prescription maze alone. This feature builds an end-to-end prescription management platform that automates prior authorizations, coordinates specialty pharmacies, tracks medication delivery, and ensures treatment continuity.

**Key Value Propositions**:

- **Prior Authorization Automation**: AI-powered PA submissions, reduce approval time from 6 weeks to 10 days
- **Specialty Pharmacy Network**: Direct integration with Accredo, CVS Specialty, BioPlus for augmentation therapy
- **Delivery Tracking**: Real-time visibility into Prolastin shipments, infusion supply orders
- **Cost Transparency**: Show patient out-of-pocket costs before prescription is filled
- **Refill Reminders**: Automated reminders 14 days before next infusion due
- **Financial Assistance**: Connect patients to manufacturer copay cards, patient assistance programs

**Business Impact**:

- Reduce augmentation therapy abandonment: 35% → 8% (industry-leading)
- Prior authorization success rate: 95% (vs. 70% manual baseline)
- Patient satisfaction: 4.7/5 stars for prescription experience
- Enable value-based contracts: Prove medication adherence to payers
- Revenue opportunity: $50-100/prescription coordination fee from pharma partners

---

## Problem Statement

### Current Gaps

**Scenario 1: ZZ Patient Can't Start Augmentation Therapy**

> "My doctor prescribed Prolastin. It's been 6 weeks and I still don't have it. Insurance denied the prior authorization twice. I don't know what documents they need. My pulmonologist's office says 'we submitted everything.' Meanwhile my lung function is declining."

**No prior authorization support** ❌

**Scenario 2: Patient Doesn't Know $5,000 Copay Until Pharmacy Calls**

> "The specialty pharmacy called to say my Prolastin is ready. My copay is $5,000/month. I can't afford that! Why didn't anyone tell me before? Now I wasted 4 weeks getting approved for a drug I can't pay for."

**No cost transparency upfront** ❌

**Scenario 3: Missed Infusion Because Pharmacy Delayed Shipment**

> "I get Prolastin infusions weekly. The pharmacy didn't ship on time. Now I'm 10 days late for my dose. Is my treatment still effective if I miss doses?"

**No delivery tracking or proactive alerts** ❌

**Scenario 4: Patient Unaware of $0 Copay Program**

> "I'm paying $400/month for Prolastin. My friend with AATD pays $0 because she has a copay card from Grifols. No one told me this existed!"

**No financial assistance guidance** ❌

**Scenario 5: Refill Falls Through Cracks**

> "I forgot to refill my albuterol inhaler. Now I'm wheezing and the pharmacy says 3-day wait. Why didn't anyone remind me?"

**No automated refill reminders** ❌

---

## Feature Specifications

### 1. Electronic Prescribing (e-Prescribe)

**Surescripts Integration** (95% of US pharmacies):

```typescript
interface ElectronicPrescription {
  prescriptionId: string;
  patientUserId: string;

  // Prescriber
  prescriberNPI: string; // National Provider Identifier
  prescriberDEA?: string; // DEA # for controlled substances
  prescriberName: string;
  prescriberPhone: string;

  // Medication
  medicationName: string;
  genericName?: string;
  ndc: string; // National Drug Code (11 digits)
  strength: string; // '60 mg/kg'
  dosageForm: string; // 'Injection', 'Inhaler', 'Tablet'
  quantity: number;
  daysSupply: number;

  // Directions
  sig: string; // Patient instructions, e.g., "Infuse 60 mg/kg IV weekly"
  refills: number;

  // Pharmacy
  pharmacyNCPDP: string; // National Council for Prescription Drug Programs ID
  pharmacyName: string;
  pharmacyType: 'retail' | 'specialty' | 'mail_order';

  // Prior Authorization
  requiresPriorAuth: boolean;
  priorAuthStatus?: 'pending' | 'approved' | 'denied' | 'not_required';

  // Status
  status:
    | 'draft'
    | 'sent'
    | 'received_by_pharmacy'
    | 'filled'
    | 'picked_up'
    | 'cancelled';

  // Dates
  writtenDate: Date;
  sentToPharmacyDate?: Date;
  filledDate?: Date;
  expirationDate: Date; // Prescriptions expire after 1 year (6 months for controlled)

  // Clinical justification (for specialty meds)
  diagnosisCodes: string[]; // ICD-10 codes, e.g., ['E88.01'] for AATD
  clinicalNotes?: string;
}

class SurescriptsIntegration {
  async sendPrescription(
    prescription: ElectronicPrescription
  ): Promise<PrescriptionResponse> {
    // Build NCPDP SCRIPT 2017071 XML message
    const scriptMessage = this.buildSCRIPTMessage(prescription);

    // Send via Surescripts network
    const response = await this.surescriptsClient.post(
      '/prescription',
      scriptMessage,
      {
        headers: {
          'Content-Type': 'application/xml',
          'X-Surescripts-DigitalSignature':
            this.generateSignature(scriptMessage)
        }
      }
    );

    // Parse pharmacy response
    if (response.status === 'ACCEPTED') {
      // Pharmacy received prescription
      await this.updatePrescriptionStatus(
        prescription.prescriptionId,
        'received_by_pharmacy'
      );

      // Check if PA required
      if (response.priorAuthRequired) {
        await this.initiatePriorAuth(prescription);
      }

      return { success: true, message: 'Prescription sent to pharmacy' };
    } else if (response.status === 'DENIED') {
      // Pharmacy rejected (e.g., drug not covered, patient not found)
      return { success: false, error: response.denialReason };
    }
  }

  buildSCRIPTMessage(rx: ElectronicPrescription): string {
    return `
      <?xml version="1.0" encoding="UTF-8"?>
      <Message xmlns="http://www.ncpdp.org/schema/SCRIPT">
        <Header>
          <To>PHARM_${rx.pharmacyNCPDP}</To>
          <From>PRES_${rx.prescriberNPI}</From>
          <MessageID>${uuidv4()}</MessageID>
          <SentTime>${new Date().toISOString()}</SentTime>
        </Header>
        <Body>
          <NewRx>
            <Prescriber>
              <Identification>
                <NPI>${rx.prescriberNPI}</NPI>
                <DEA>${rx.prescriberDEA || ''}</DEA>
              </Identification>
              <Name>${rx.prescriberName}</Name>
              <Phone>${rx.prescriberPhone}</Phone>
            </Prescriber>
            <Patient>
              <Identification>
                <PatientID>${rx.patientUserId}</PatientID>
              </Identification>
            </Patient>
            <Medication>
              <DrugDescription>${rx.medicationName}</DrugDescription>
              <DrugCoded>
                <ProductCode>
                  <Code>${rx.ndc}</Code>
                  <Qualifier>NDC</Qualifier>
                </ProductCode>
              </DrugCoded>
              <Quantity>
                <Value>${rx.quantity}</Value>
              </Quantity>
              <DaysSupply>${rx.daysSupply}</DaysSupply>
              <Refills>${rx.refills}</Refills>
              <Directions>${rx.sig}</Directions>
            </Medication>
            <Diagnosis>
              <ClinicalInformationQualifier>ICD10</ClinicalInformationQualifier>
              <Primary>
                <Value>${rx.diagnosisCodes[0]}</Value>
              </Primary>
            </Diagnosis>
          </NewRx>
        </Body>
      </Message>
    `;
  }
}
```

### 2. Prior Authorization Automation

**AI-Powered PA Submission**:

```typescript
interface PriorAuthorizationRequest {
  prescriptionId: string;
  patientUserId: string;
  insurancePayerId: string;

  // Medication requiring PA
  medicationName: string;
  ndc: string;
  quantity: number;
  daysSupply: number;

  // Clinical justification
  diagnosisCodes: string[]; // ['E88.01'] AATD
  clinicalRationale: string;

  // Supporting documentation
  labResults: {
    aatLevel: number; // mg/dL
    genotype: string; // 'ZZ'
    testDate: Date;
  };
  pulmonaryFunctionTests?: {
    fev1Percent: number;
    fev1FVCRatio: number;
    testDate: Date;
  };
  chestImaging?: {
    findings: string;
    imageDate: Date;
    reportUrl: string;
  };

  // Treatment history
  priorMedications: {
    name: string;
    trialLength: string; // 'Failed 3-month trial'
    outcome: string; // 'Inadequate response'
  }[];

  // Status
  status: 'draft' | 'submitted' | 'pending' | 'approved' | 'denied' | 'appeal';
  submittedDate?: Date;
  decisionDate?: Date;
  denialReason?: string;

  // Tracking
  insuranceReferenceNumber?: string;
  expectedDecisionDate?: Date;
}

class PriorAuthAutomation {
  async submitPriorAuth(
    request: PriorAuthorizationRequest
  ): Promise<PASubmissionResult> {
    // Get payer-specific PA form
    const paForm = await this.getPayerPAForm(
      request.insurancePayerId,
      request.ndc
    );

    // Auto-fill PA form using AI
    const filledForm = await this.autoFillPAForm(paForm, request);

    // Attach supporting documents
    const documents = await this.gatherSupportingDocuments(request);

    // Submit via CoverMyMeds API (handles most payers)
    const submission = await this.coverMyMedsClient.post(
      '/prior_authorizations',
      {
        payer_id: request.insurancePayerId,
        medication_ndc: request.ndc,
        patient_id: request.patientUserId,
        prescriber_npi: request.prescriberNPI,
        clinical_rationale: filledForm.clinicalRationale,
        diagnosis_codes: request.diagnosisCodes,
        supporting_documents: documents,
        urgency: this.calculateUrgency(request) // 'standard' or 'urgent'
      }
    );

    // Track PA status
    await this.db.insert('prior_authorizations', {
      id: submission.paId,
      prescription_id: request.prescriptionId,
      insurance_reference_number: submission.referenceNumber,
      status: 'submitted',
      submitted_date: new Date(),
      expected_decision_date: submission.expectedDecisionDate
    });

    // Set up polling for status updates
    this.scheduleStatusCheck(submission.paId);

    return {
      success: true,
      paId: submission.paId,
      referenceNumber: submission.referenceNumber,
      estimatedApprovalDate: submission.expectedDecisionDate
    };
  }

  async autoFillPAForm(
    form: PAForm,
    request: PriorAuthorizationRequest
  ): Promise<FilledPAForm> {
    // Use GPT-4 to intelligently fill PA forms
    const prompt = `
      Fill out this prior authorization form for Alpha-1 Antitrypsin Deficiency augmentation therapy.

      Patient: ZZ genotype, AAT level ${request.labResults.aatLevel} mg/dL
      Medication: ${request.medicationName}
      Diagnosis: AATD (ICD-10: E88.01)

      ${request.pulmonaryFunctionTests ? `Lung function: FEV1 ${request.pulmonaryFunctionTests.fev1Percent}%` : ''}

      Form questions:
      ${form.questions.map((q) => `${q.number}. ${q.text}`).join('\n')}

      Provide evidence-based answers citing ATS/ERS guidelines.
    `;

    const gpt4Response = await openai.chat.completions.create({
      model: 'gpt-4-turbo',
      messages: [{ role: 'user', content: prompt }]
    });

    // Parse GPT-4 response into structured form
    return this.parseGPT4Response(gpt4Response, form);
  }

  calculateUrgency(request: PriorAuthorizationRequest): 'standard' | 'urgent' {
    // Urgent if patient is symptomatic and awaiting first dose
    if (
      request.pulmonaryFunctionTests &&
      request.pulmonaryFunctionTests.fev1Percent < 50
    ) {
      return 'urgent'; // Severe lung impairment
    }

    // Urgent if patient is currently on therapy and running out
    const prescription = await this.getPrescription(request.prescriptionId);
    if (prescription.isRefill && prescription.daysUntilOut <= 14) {
      return 'urgent'; // Continuity of care
    }

    return 'standard';
  }

  async checkPAStatus(paId: string): Promise<PAStatusUpdate> {
    // Poll CoverMyMeds for status
    const status = await this.coverMyMedsClient.get(
      `/prior_authorizations/${paId}`
    );

    if (status.decision === 'APPROVED') {
      // Notify patient & prescriber
      await this.notifyPAApproval(paId);

      // Trigger prescription fulfillment
      await this.sendPrescriptionToPharmacy(status.prescriptionId);
    } else if (status.decision === 'DENIED') {
      // Notify with denial reason
      await this.notifyPADenial(paId, status.denialReason);

      // Offer appeal assistance
      await this.offerAppealSupport(paId);
    }

    return status;
  }
}

// CoverMyMeds API integration (used by 95% of US pharmacies)
class CoverMyMedsClient {
  private apiKey: string;
  private baseUrl = 'https://api.covermymeds.com/v1';

  async createPriorAuth(data: any) {
    return axios.post(`${this.baseUrl}/prior_authorizations`, data, {
      headers: {
        Authorization: `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      }
    });
  }

  async getStatus(paId: string) {
    return axios.get(`${this.baseUrl}/prior_authorizations/${paId}`, {
      headers: { Authorization: `Bearer ${this.apiKey}` }
    });
  }
}
```

### 3. Specialty Pharmacy Network

**Integration with Major Specialty Pharmacies**:

```typescript
interface SpecialtyPharmacy {
  pharmacyId: string;
  name: string; // 'Accredo', 'CVS Specialty', 'BioPlus', 'Walgreens Specialty'
  ncpdpId: string;

  // Capabilities
  handlesAugmentationTherapy: boolean;
  homeInfusionServices: boolean;
  nurseSupport: boolean;
  financialCounseling: boolean;

  // Contact
  phone: string;
  hoursOfOperation: string;

  // Insurance
  insurancePlans: string[]; // Which plans use this pharmacy

  // Service areas
  statesServed: string[];

  // Ratings
  avgRating: number;
  totalReviews: number;
}

class SpecialtyPharmacyCoordinator {
  async routePrescription(
    prescription: ElectronicPrescription,
    patientInsurance: InsuranceInfo
  ): Promise<SpecialtyPharmacy> {
    // Determine if specialty pharmacy required
    if (!this.requiresSpecialtyPharmacy(prescription.medicationName)) {
      // Route to patient's preferred retail pharmacy
      return this.getPreferredRetailPharmacy(prescription.patientUserId);
    }

    // Find specialty pharmacy for patient's insurance
    const specialtyPharmacies = await this.db.query(
      `
      SELECT * FROM specialty_pharmacies
      WHERE handles_augmentation_therapy = true
      AND $1 = ANY(insurance_plans)
      AND $2 = ANY(states_served)
      ORDER BY avg_rating DESC
    `,
      [patientInsurance.payerName, patientInsurance.patientState]
    );

    if (specialtyPharmacies.length === 0) {
      throw new Error('No specialty pharmacy found for your insurance');
    }

    // Preferred pharmacy for AATD augmentation therapy
    return specialtyPharmacies[0];
  }

  requiresSpecialtyPharmacy(medicationName: string): boolean {
    const specialtyMeds = [
      'Prolastin-C',
      'Prolastin',
      'Aralast NP',
      'Zemaira',
      'Glassia'
    ];

    return specialtyMeds.some((med) => medicationName.includes(med));
  }

  async trackShipment(prescriptionId: string): Promise<ShipmentStatus> {
    // Query specialty pharmacy's shipment tracking API
    const prescription = await this.getPrescription(prescriptionId);
    const pharmacy = await this.getPharmacy(prescription.pharmacyNCPDP);

    // Call pharmacy-specific tracking API
    if (pharmacy.name === 'Accredo') {
      return this.accredoClient.getShipmentStatus(prescriptionId);
    } else if (pharmacy.name === 'CVS Specialty') {
      return this.cvsSpecialtyClient.getShipmentStatus(prescriptionId);
    }

    // Generic fallback
    return { status: 'unknown', estimatedDelivery: null };
  }
}

interface ShipmentStatus {
  status:
    | 'pending'
    | 'shipped'
    | 'in_transit'
    | 'out_for_delivery'
    | 'delivered'
    | 'failed';
  trackingNumber?: string;
  carrier?: string; // 'FedEx', 'UPS'
  estimatedDeliveryDate?: Date;
  actualDeliveryDate?: Date;

  // For augmentation therapy (requires refrigeration)
  requiresSignature: boolean;
  temperatureMonitored: boolean;

  // Shipment events
  events: {
    timestamp: Date;
    location: string;
    description: string;
  }[];
}
```

### 4. Cost Transparency & Financial Assistance

**Real-Time Pricing Check**:

```typescript
interface MedicationCost {
  medicationName: string;
  ndc: string;
  quantity: number;
  daysSupply: number;

  // Pricing
  wholesaleCost: number; // AWP (Average Wholesale Price)
  insuranceCovers: number;
  patientResponsibility: number; // Copay/coinsurance

  // Patient assistance available
  copayCard?: {
    programName: string; // 'Grifols Prolastin Copay Card'
    maxAnnualBenefit: number; // $12,000
    estimatedCopayAfterCard: number; // $0
    applicationUrl: string;
  };

  patientAssistanceProgram?: {
    programName: string; // 'Grifols Patient Assistance Program'
    incomeEligibility: string; // '<300% federal poverty level'
    providesFreeMedication: boolean;
    applicationUrl: string;
  };

  // Alternatives
  genericAvailable: boolean;
  therapeuticAlternatives?: {
    medicationName: string;
    estimatedCopay: number;
  }[];
}

class MedicationPricingEngine {
  async estimatePatientCost(
    ndc: string,
    quantity: number,
    insurance: InsuranceInfo
  ): Promise<MedicationCost> {
    // Call RxSaver or GoodRx API for pricing
    const pricingData = await this.rxSaverClient.getPricing({
      ndc,
      quantity,
      zip: insurance.patientZip,
      insurance_group: insurance.groupNumber
    });

    // Check for manufacturer copay cards
    const copayCard = await this.findCopayCard(ndc);

    // Check patient assistance programs
    const patientAssistance = await this.findPatientAssistance(
      ndc,
      insurance.householdIncome
    );

    return {
      medicationName: pricingData.name,
      ndc,
      quantity,
      daysSupply: pricingData.daysSupply,
      wholesaleCost: pricingData.awp,
      insuranceCovers: pricingData.awp - pricingData.patientPays,
      patientResponsibility: pricingData.patientPays,
      copayCard,
      patientAssistanceProgram: patientAssistance
    };
  }

  async findCopayCard(ndc: string): Promise<CopayCard | undefined> {
    // Common AATD augmentation therapy copay cards
    const copayPrograms = {
      Prolastin: {
        programName: 'Grifols Prolastin Copay Card',
        maxAnnualBenefit: 12000,
        estimatedCopayAfterCard: 0,
        applicationUrl: 'https://www.prolastin.com/copay-card',
        eligibility: 'Commercial insurance only (not Medicare/Medicaid)'
      },
      Aralast: {
        programName: 'Takeda Aralast Copay Assistance',
        maxAnnualBenefit: 15000,
        estimatedCopayAfterCard: 0,
        applicationUrl: 'https://www.aralast.com/copay'
      },
      Zemaira: {
        programName: 'CSL Behring Zemaira CASH Program',
        maxAnnualBenefit: 12000,
        estimatedCopayAfterCard: 0,
        applicationUrl: 'https://www.zemaira.com/copay'
      }
    };

    // Look up medication by NDC
    const medication = await this.getMedicationByNDC(ndc);

    return copayPrograms[medication.brandName];
  }
}
```

### 5. Database Schema

```sql
-- Prescriptions
CREATE TABLE prescriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Prescriber
  prescriber_npi VARCHAR(10) NOT NULL,
  prescriber_name VARCHAR(200),
  prescriber_phone VARCHAR(20),

  -- Medication
  medication_name VARCHAR(300) NOT NULL,
  generic_name VARCHAR(300),
  ndc VARCHAR(11), -- National Drug Code
  strength VARCHAR(100),
  dosage_form VARCHAR(50),
  quantity DECIMAL(10, 3),
  days_supply INTEGER,
  refills INTEGER DEFAULT 0,

  -- Directions
  sig TEXT, -- Patient instructions

  -- Pharmacy
  pharmacy_ncpdp VARCHAR(7),
  pharmacy_name VARCHAR(200),
  pharmacy_type VARCHAR(20), -- 'retail', 'specialty', 'mail_order'

  -- Prior Authorization
  requires_prior_auth BOOLEAN DEFAULT false,
  prior_auth_id UUID,

  -- Status
  status VARCHAR(30) DEFAULT 'draft',
  -- 'draft', 'sent', 'received_by_pharmacy', 'filled', 'picked_up', 'delivered', 'cancelled'

  -- Dates
  written_date DATE NOT NULL,
  sent_to_pharmacy_date TIMESTAMPTZ,
  filled_date TIMESTAMPTZ,
  picked_up_date TIMESTAMPTZ,
  expiration_date DATE, -- Expires 1 year from written date

  -- Clinical
  diagnosis_codes TEXT[], -- ICD-10 codes
  clinical_notes TEXT,

  -- Cost
  estimated_patient_cost DECIMAL(10, 2),
  actual_patient_cost DECIMAL(10, 2),
  copay_card_applied BOOLEAN DEFAULT false,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, patient_user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (prior_auth_id) REFERENCES prior_authorizations(id)
);

CREATE INDEX idx_prescriptions_patient ON prescriptions(patient_user_id, status);
CREATE INDEX idx_prescriptions_status ON prescriptions(status, sent_to_pharmacy_date);

-- Prior Authorizations
CREATE TABLE prior_authorizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prescription_id UUID NOT NULL,
  patient_user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Payer
  insurance_payer_id VARCHAR(50), -- '00123' Blue Cross
  insurance_payer_name VARCHAR(200),

  -- Request details
  medication_name VARCHAR(300),
  ndc VARCHAR(11),
  quantity DECIMAL(10, 3),
  days_supply INTEGER,

  -- Clinical justification
  diagnosis_codes TEXT[],
  clinical_rationale TEXT,

  -- Supporting documents (S3 URLs)
  lab_results_url TEXT,
  pulmonary_function_test_url TEXT,
  chest_imaging_url TEXT,
  prior_treatment_history TEXT,

  -- Status
  status VARCHAR(20) DEFAULT 'draft',
  -- 'draft', 'submitted', 'pending', 'approved', 'denied', 'appealed', 'cancelled'

  -- Tracking
  insurance_reference_number VARCHAR(100),
  covermymeds_request_id VARCHAR(100),

  -- Dates
  submitted_date TIMESTAMPTZ,
  expected_decision_date DATE,
  decision_date TIMESTAMPTZ,
  approval_expiration_date DATE, -- PAs typically valid 1 year

  -- Denial info
  denial_reason TEXT,
  appeal_submitted_date TIMESTAMPTZ,
  appeal_decision TEXT,

  -- Urgency
  urgency VARCHAR(20) DEFAULT 'standard', -- 'standard', 'urgent'

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
  FOREIGN KEY (tenant_id, patient_user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_prior_auths_patient ON prior_authorizations(patient_user_id, status);
CREATE INDEX idx_prior_auths_status ON prior_authorizations(status, expected_decision_date);
CREATE INDEX idx_prior_auths_pending ON prior_authorizations(status) WHERE status = 'pending';

-- Specialty Pharmacies
CREATE TABLE specialty_pharmacies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Pharmacy info
  name VARCHAR(200) NOT NULL,
  ncpdp_id VARCHAR(7) UNIQUE NOT NULL,

  -- Capabilities
  handles_augmentation_therapy BOOLEAN DEFAULT false,
  home_infusion_services BOOLEAN DEFAULT false,
  nurse_support BOOLEAN DEFAULT false,
  financial_counseling BOOLEAN DEFAULT false,

  -- Contact
  phone VARCHAR(20),
  hours_of_operation TEXT,

  -- Service
  insurance_plans TEXT[], -- ['Aetna', 'Blue Cross']
  states_served TEXT[], -- ['CO', 'CA', 'TX']

  -- Ratings
  avg_rating DECIMAL(3, 2),
  total_reviews INTEGER DEFAULT 0,

  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_specialty_pharmacies_insurance ON specialty_pharmacies USING GIN(insurance_plans);

-- Medication Shipments
CREATE TABLE medication_shipments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prescription_id UUID NOT NULL,
  patient_user_id UUID NOT NULL,

  -- Shipment details
  tracking_number VARCHAR(100),
  carrier VARCHAR(50), -- 'FedEx', 'UPS'

  -- Status
  status VARCHAR(30) DEFAULT 'pending',
  -- 'pending', 'shipped', 'in_transit', 'out_for_delivery', 'delivered', 'failed'

  -- Dates
  shipped_date TIMESTAMPTZ,
  estimated_delivery_date DATE,
  actual_delivery_date TIMESTAMPTZ,

  -- Special handling (for augmentation therapy)
  requires_signature BOOLEAN DEFAULT false,
  temperature_monitored BOOLEAN DEFAULT false,

  -- Delivery address
  delivery_address_street VARCHAR(200),
  delivery_address_city VARCHAR(100),
  delivery_address_state VARCHAR(2),
  delivery_address_zip VARCHAR(10),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
  FOREIGN KEY (patient_user_id) REFERENCES users(id)
);

CREATE INDEX idx_shipments_patient ON medication_shipments(patient_user_id, status);
CREATE INDEX idx_shipments_tracking ON medication_shipments(tracking_number);

-- Shipment Events (tracking history)
CREATE TABLE shipment_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  shipment_id UUID NOT NULL,

  -- Event details
  event_timestamp TIMESTAMPTZ NOT NULL,
  location VARCHAR(200),
  description TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (shipment_id) REFERENCES medication_shipments(id)
);

CREATE INDEX idx_shipment_events_shipment ON shipment_events(shipment_id, event_timestamp DESC);

-- Refill Reminders
CREATE TABLE refill_reminders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  prescription_id UUID NOT NULL,
  patient_user_id UUID NOT NULL,

  -- Reminder details
  reminder_type VARCHAR(30), -- 'upcoming_refill', 'overdue_refill'

  -- Scheduling
  scheduled_date DATE NOT NULL,
  sent_at TIMESTAMPTZ,

  -- Patient response
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'sent', 'acknowledged', 'refill_ordered'
  patient_action_date TIMESTAMPTZ,

  -- Notification channels
  sent_via_email BOOLEAN DEFAULT false,
  sent_via_sms BOOLEAN DEFAULT false,
  sent_via_push BOOLEAN DEFAULT false,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
  FOREIGN KEY (patient_user_id) REFERENCES users(id)
);

CREATE INDEX idx_refill_reminders_patient ON refill_reminders(patient_user_id, status);
CREATE INDEX idx_refill_reminders_scheduled ON refill_reminders(scheduled_date) WHERE status = 'pending';

-- Copay Cards & Financial Assistance
CREATE TABLE financial_assistance_programs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Program details
  program_name VARCHAR(200) NOT NULL,
  program_type VARCHAR(30), -- 'copay_card', 'patient_assistance', 'foundation'
  manufacturer VARCHAR(200), -- 'Grifols', 'Takeda', 'CSL Behring'

  -- Medications covered
  covered_medications TEXT[], -- NDCs or brand names

  -- Benefits
  max_annual_benefit DECIMAL(10, 2),
  covers_full_copay BOOLEAN DEFAULT false,

  -- Eligibility
  income_eligibility TEXT, -- '<300% FPL', 'Commercial insurance only'
  insurance_requirements TEXT,

  -- Application
  application_url TEXT,
  phone_number VARCHAR(20),

  -- Status
  active BOOLEAN DEFAULT true,

  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Patient enrollment in assistance programs
CREATE TABLE patient_financial_assistance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_user_id UUID NOT NULL,
  program_id UUID NOT NULL,

  -- Enrollment
  enrollment_date DATE NOT NULL,
  expiration_date DATE,

  -- Program ID
  member_id VARCHAR(100), -- Patient's ID in copay program

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'expired', 'cancelled'

  -- Usage tracking
  total_benefit_used DECIMAL(10, 2) DEFAULT 0.00,
  remaining_benefit DECIMAL(10, 2),

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (patient_user_id) REFERENCES users(id),
  FOREIGN KEY (program_id) REFERENCES financial_assistance_programs(id)
);

CREATE INDEX idx_patient_financial_assistance_user ON patient_financial_assistance(patient_user_id, status);
```

### 6. Patient Prescription Portal

**Patient View**:

```
┌─────────────────────────────────────────────────────────────────┐
│  💊 My Prescriptions - John Doe                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🚨 ACTIVE PRESCRIPTIONS (2)                                    │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 💉 Prolastin-C (Alpha-1 Proteinase Inhibitor)            │  │
│  │    60 mg/kg - Weekly IV Infusion                          │  │
│  │    Prescribed by: Dr. Jennifer Martinez (Pulmonologist)   │  │
│  │    Pharmacy: Accredo Specialty Pharmacy                   │  │
│  │                                                            │  │
│  │    📦 SHIPMENT STATUS                                     │  │
│  │    ┌────────────────────────────────────────────────────┐│  │
│  │    │ ✅ Delivered - Dec 3, 2025                         ││  │
│  │    │ FedEx Tracking: 7849-2301-4456                     ││  │
│  │    │ Next shipment scheduled: Dec 31, 2025              ││  │
│  │    └────────────────────────────────────────────────────┘│  │
│  │                                                            │  │
│  │    💰 COST                                                │  │
│  │    Retail price: $6,800/infusion                          │  │
│  │    Insurance covers: $6,500                               │  │
│  │    Your copay: $300                                       │  │
│  │    With Grifols Copay Card: $0 ✨                         │  │
│  │    [Enroll in Copay Card Program]                         │  │
│  │                                                            │  │
│  │    📅 REFILL SCHEDULE                                     │  │
│  │    Next refill: December 24, 2025 (21 days)               │  │
│  │    Automatic refill: Enabled ✓                            │  │
│  │    [Manage Refills]                                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ 🫁 Albuterol HFA 90 mcg Inhaler                           │  │
│  │    2 puffs every 4-6 hours as needed                      │  │
│  │    Prescribed by: Dr. Sarah Chen (PCP)                    │  │
│  │    Pharmacy: Walgreens #4523                              │  │
│  │                                                            │  │
│  │    ⚠️  LOW SUPPLY WARNING                                 │  │
│  │    Estimated 5 days remaining                             │  │
│  │    [Refill Now] [Set Reminder]                            │  │
│  │                                                            │  │
│  │    💰 COST                                                │  │
│  │    Your copay: $15                                        │  │
│  │    Refills remaining: 3                                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📋 PRIOR AUTHORIZATION STATUS                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Prolastin-C Annual Renewal                                │  │
│  │ Status: ✅ APPROVED (expires Dec 31, 2026)                │  │
│  │ Submitted: Nov 15, 2025                                   │  │
│  │ Approved: Nov 28, 2025 (13 days)                          │  │
│  │ [View Approval Letter]                                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💵 FINANCIAL ASSISTANCE                                        │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Grifols Prolastin Copay Card                              │  │
│  │ Status: Active                                             │  │
│  │ Annual benefit: $12,000                                    │  │
│  │ Used this year: $3,600 (30%)                              │  │
│  │ Remaining: $8,400                                          │  │
│  │ Renews: January 1, 2026                                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  [Prescription History] [Add Pharmacy] [Contact Support]        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Prior Authorization Performance

- **Approval Rate**: 95% (vs. 70% manual baseline)
- **Approval Time**: 10 days average (vs. 42 days manual)
- **Urgent PA Approval**: 3 days (vs. 21 days)
- **Appeal Success**: 80% of denials overturned on first appeal

### Treatment Adherence

- **Augmentation Therapy Abandonment**: 8% (vs. 35% industry average)
- **Refill Timeliness**: 92% of refills filled before running out (vs. 65%)
- **Missed Doses**: 15% reduction in missed doses (via tracking)

### Patient Experience

- **Cost Transparency**: 95% of patients know out-of-pocket cost before filling
- **Financial Assistance Enrollment**: 70% of eligible patients enrolled in copay cards
- **Patient Satisfaction**: 4.7/5 stars for prescription experience
- **Shipment Delivery**: 98% on-time delivery rate

### Business Impact

- **Revenue**: $50-100/prescription coordination fee from pharma partners
- **Retention**: 20% improvement in patient retention (better medication continuity)
- **Partner Satisfaction**: Specialty pharmacies rate platform 4.5/5
- **Cost Savings**: $120K/year in reduced manual PA processing

---

## Budget Estimate

### Development (4-5 months)

- **Backend Developer** (APIs, integrations): $140K/year × 0.42 years = $58,800
- **Integration Specialist** (Surescripts, CoverMyMeds, pharmacy APIs): $150K/year × 0.42 years = $63,000
- **Frontend Developer** (patient/provider portals): $140K/year × 0.33 years = $46,200

**Total Development**: ~$168,000

### Annual Operations

- **Pharmacy Liaison** (0.25 FTE): $80K/year × 0.25 = $20,000
- **PA Specialist** (appeal support): $65K/year
- **Customer Support** (prescription questions): $55K/year × 0.5 FTE = $27,500

**Total Operations**: ~$112,500/year

### Annual Infrastructure & Licensing

- **Surescripts Network Access**: $25,000/year (e-prescribing)
- **CoverMyMeds API**: $15,000/year (PA automation)
- **RxSaver/GoodRx API**: $6,000/year (pricing data)
- **FedEx/UPS Tracking APIs**: $2,400/year
- **Database & Storage**: $3,600/year

**Total Infrastructure**: ~$52,000/year

### **GRAND TOTAL (First Year)**: ~$332,500

### **Ongoing (Year 2+)**: ~$164,500/year (operations + infrastructure)

**Revenue Offset**: -$75,000/year (coordination fees from pharma partners)
**Net Cost (Year 2+)**: ~$89,500/year

---

## Risks & Mitigations

### Risk 1: Surescripts Certification Delays

**Impact**: Can't go live with e-prescribing
**Mitigation**: Start certification process early (6+ months), work with experienced Surescripts consultant, parallel path with fax prescriptions

### Risk 2: Prior Authorization Denials Still Occur

**Impact**: Patients frustrated by denials despite automation
**Mitigation**: Human PA specialist reviews all denied cases, appeal support, alternative medication suggestions

### Risk 3: Specialty Pharmacy Integration Complexity

**Impact**: Each pharmacy has different API, hard to maintain
**Mitigation**: Start with top 3 pharmacies (80% market share), standardize internal data model, pharmacy SDK

### Risk 4: Patient Privacy Concerns

**Impact**: Patients uncomfortable sharing prescription data
**Mitigation**: HIPAA compliance, clear privacy policy, patient controls data sharing, encryption

### Risk 5: State-Specific Prescribing Laws

**Impact**: Different rules for controlled substances by state
**Mitigation**: Legal review of all 50 states, automated compliance checks, provider education

---

**Document Owner**: VP Product, Head of Pharmacy Operations
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
