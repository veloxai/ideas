# Feature #25: Patient Payment & Financial Assistance

**Category**: Revenue Operations - Payment Processing
**Priority**: Phase 1 (Critical - Revenue Blocker)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 backend developer, 1 frontend developer, 0.5 FTE financial operations specialist

---

## Executive Summary

Fair Underwriting currently has **no documented patient payment workflow** for genetic testing. While Feature #11 covers insurance verification and claims, **30-40% of patients are uninsured or have high-deductible plans** and need direct payment options.

**Critical Business Gap**:

- ✅ Insurance billing infrastructure (Feature #11)
- ✅ Backend billing system implemented in `api.velox.ai` (Stripe/PayPal/Square)
- ❌ No patient-facing payment portal
- ❌ No payment plan options for $450 test
- ❌ No FSA/HSA integration
- ❌ No financial assistance program

**Revenue Impact**:

- **$450 list price** for AATD genetic test
- 10,000 customers/year × 35% uninsured × $450 = **$1.575M annual revenue at risk**
- Without payment plans: 40% abandon due to cost → **$630K lost revenue**

---

## Problem Scenarios

### Scenario 1: High-Deductible Plan Patient Can't Afford Test

> **Situation**: Sarah has employer-sponsored insurance with $5,000 deductible. She's only paid $200 toward her deductible this year. Her AATD genetic test costs $450, which she must pay out-of-pocket until deductible is met.
>
> **Current State**: Fair Underwriting website shows "$450 test" but clicking "Order Test" goes to insurance verification form. Sarah fills out form, submits. 3 days later she receives email: "Your insurance won't cover this test until you meet your deductible. You owe $450. Please call billing department."
>
> **Pain Points**:
>
> - Unclear pricing upfront
> - 3-day delay to learn she owes $450
> - No payment plan option offered
> - Has to call billing (friction)
> - Can't afford $450 lump sum → abandons test
>
> **Impact**: Lost customer, potentially undiagnosed AATD

**Solution**: Transparent pricing calculator, instant eligibility check, payment plan offer at checkout ($150 down + $150/month × 2 months).

### Scenario 2: Uninsured Patient Qualifies for Financial Assistance

> **Situation**: Michael is 28, self-employed contractor, no health insurance. Family history of COPD (father died at 55). Wants AATD test but sees $450 price and assumes he can't afford it.
>
> **Current State**: Michael lands on Fair Underwriting website, sees "$450 test", leaves immediately. Never discovers financial assistance program exists (if it did).
>
> **Hidden Context**: Michael's household income is $35K/year (175% of Federal Poverty Level). He would qualify for **90% discount** → $45 test.
>
> **Impact**: Missed opportunity. Michael develops severe COPD at age 45, costs healthcare system $250K+ over lifetime. Could have been prevented with early diagnosis.

**Solution**: Prominent "Financial Assistance" link, income-based sliding scale ($45 for <200% FPL, $150 for 200-400% FPL), auto-qualification at checkout.

### Scenario 3: FSA/HSA Reimbursement Nightmare

> **Situation**: Jennifer has HSA (Health Savings Account) with $2,000 balance. Pays $450 for AATD test with personal credit card, plans to reimburse herself from HSA.
>
> **Problem**: Her HSA administrator (Optum Bank) requires:
>
> 1. Itemized receipt showing CPT code (81332)
> 2. Letter of Medical Necessity (LMN) signed by her doctor
> 3. Explanation of Benefits (EOB) from insurance
>
> **Current State**: Fair Underwriting's payment confirmation email is generic: "Thank you for your payment. Amount: $450. Service: Genetic Testing."
>
> **What Jennifer Needs**:
>
> - Itemized receipt with CPT code
> - Automatic EOB generation
> - LMN template she can take to her doctor
>
> **Impact**: Jennifer spends 4 hours fighting with billing department for proper documentation. Negative reviews: "They don't understand how HSAs work."

**Solution**: HSA/FSA-compliant receipts, automatic EOB generation, downloadable LMN template.

### Scenario 4: Payment Plan Default & Collections

> **Situation**: David enrolls in 6-month payment plan ($75 down + $75/month × 5 months). Misses payment in month 3 (forgot to update credit card after it expired).
>
> **Current State**: No system for handling payment plan defaults. Manual process:
>
> - Billing department emails David
> - David doesn't respond for 2 weeks
> - Account sent to collections
> - David angry, leaves 1-star review
>
> **Impact**: Bad debt write-off ($225), damaged reputation, lost customer.

**Solution**: Automated dunning (payment retry logic), grace periods, SMS/email reminders, self-service card update portal.

### Scenario 5: International Patient Payment Failure

> **Situation**: Maria lives in Canada, wants AATD test (family member in US has ZZ genotype). Tries to pay with Canadian credit card.
>
> **Problem**:
>
> - Stripe rejects card (international card on US merchant account)
> - PayPal works but charges 4% foreign transaction fee
> - Maria pays $450 USD = $615 CAD + $25 fee = $640 CAD total
> - She's upset about hidden fees
>
> **Impact**: Poor customer experience, negative reviews from international customers.

**Solution**: Multi-currency support (Feature #23), transparent fee disclosure, international payment methods (Wise/TransferWise).

---

## Technical Specifications

### 1. Payment Methods Supported

```typescript
interface PaymentMethod {
  type:
    | 'credit_card'
    | 'debit_card'
    | 'bank_account'
    | 'paypal'
    | 'apple_pay'
    | 'google_pay'
    | 'hsa_fsa_card'
    | 'financing';
  provider: 'stripe' | 'paypal' | 'square' | 'affirm';

  // Credit/Debit card
  cardDetails?: {
    brand: 'visa' | 'mastercard' | 'amex' | 'discover';
    last4: string;
    expMonth: number;
    expYear: number;
    zipCode: string;
  };

  // Bank account (ACH)
  bankDetails?: {
    accountType: 'checking' | 'savings';
    routingNumber: string;
    accountNumberLast4: string;
    bankName: string;
  };

  // HSA/FSA card
  hsaFsaDetails?: {
    cardLast4: string;
    administrator: 'optum' | 'wex' | 'healthequity' | 'other';
    requiresDocumentation: boolean;
  };

  // Financing (Affirm, Klarna)
  financingDetails?: {
    provider: 'affirm' | 'klarna';
    monthlyPayment: number;
    termMonths: 3 | 6 | 12;
    apr: number;
  };
}
```

### 2. Pricing Calculator

```typescript
interface PricingCalculation {
  testType: 'aatd_genotyping' | 'aatd_phenotyping' | 'comprehensive_panel';
  listPrice: number; // $450 for AATD genotyping

  // Insurance information
  insurance?: {
    hasInsurance: boolean;
    planType: 'commercial' | 'medicare' | 'medicaid' | 'uninsured';
    deductibleMet: boolean;
    estimatedCoverage: number; // % covered
    estimatedPatientResponsibility: number;
  };

  // Discounts
  discounts: {
    type:
      | 'insurance_network'
      | 'financial_assistance'
      | 'employer_wellness'
      | 'promotional';
    amount: number;
    reason: string;
  }[];

  // Final calculation
  subtotal: number;
  discountTotal: number;
  finalPrice: number;

  // Payment plan eligibility
  paymentPlanEligible: boolean;
  paymentPlanOptions?: PaymentPlan[];
}

interface PaymentPlan {
  id: string;
  name: string;
  downPayment: number;
  monthlyPayment: number;
  numberOfPayments: number;
  totalAmount: number;
  apr: number; // 0% for internal plans, >0% for Affirm
  provider: 'internal' | 'affirm' | 'klarna';
}

class PricingCalculator {
  calculatePrice(input: {
    testType: string;
    hasInsurance: boolean;
    insuranceInfo?: any;
    householdIncome?: number;
    householdSize?: number;
  }): PricingCalculation {
    let price = 450; // Base price for AATD genotyping
    const discounts: any[] = [];

    // Insurance discount
    if (input.hasInsurance && input.insuranceInfo?.inNetwork) {
      const insurancePays = this.estimateInsuranceCoverage(input.insuranceInfo);
      price -= insurancePays;
      discounts.push({
        type: 'insurance_network',
        amount: insurancePays,
        reason: 'In-network insurance coverage'
      });
    }

    // Financial assistance (income-based)
    if (input.householdIncome && input.householdSize) {
      const fplPercent = this.calculateFPLPercent(
        input.householdIncome,
        input.householdSize
      );
      const assistance = this.calculateFinancialAssistance(price, fplPercent);

      if (assistance > 0) {
        price -= assistance;
        discounts.push({
          type: 'financial_assistance',
          amount: assistance,
          reason: `Income-based assistance (${fplPercent}% FPL)`
        });
      }
    }

    // Payment plan eligibility
    const paymentPlanEligible = price >= 150; // Minimum $150 for payment plan
    const paymentPlanOptions = paymentPlanEligible
      ? this.generatePaymentPlans(price)
      : [];

    return {
      testType: input.testType,
      listPrice: 450,
      insurance: input.insuranceInfo,
      discounts,
      subtotal: 450,
      discountTotal: 450 - price,
      finalPrice: price,
      paymentPlanEligible,
      paymentPlanOptions
    };
  }

  calculateFPLPercent(income: number, householdSize: number): number {
    // 2025 Federal Poverty Level
    const fpl2025 = {
      1: 15060,
      2: 20440,
      3: 25820,
      4: 31200,
      5: 36580,
      6: 41960,
      7: 47340,
      8: 52720
    };

    const fplThreshold =
      fpl2025[householdSize] || fpl2025[8] + (householdSize - 8) * 5380;
    return (income / fplThreshold) * 100;
  }

  calculateFinancialAssistance(price: number, fplPercent: number): number {
    if (fplPercent <= 138) return price * 0.95; // 95% discount (Medicaid expansion threshold)
    if (fplPercent <= 200) return price * 0.9; // 90% discount ($45 cost)
    if (fplPercent <= 300) return price * 0.75; // 75% discount ($112.50 cost)
    if (fplPercent <= 400) return price * 0.5; // 50% discount ($225 cost)
    return 0;
  }

  generatePaymentPlans(totalAmount: number): PaymentPlan[] {
    const plans: PaymentPlan[] = [];

    // 3-month plan (0% APR)
    if (totalAmount >= 150) {
      plans.push({
        id: 'plan_3mo',
        name: '3-Month Payment Plan',
        downPayment: Math.ceil(totalAmount / 3),
        monthlyPayment: Math.ceil(totalAmount / 3),
        numberOfPayments: 2, // 1 down + 2 monthly
        totalAmount,
        apr: 0,
        provider: 'internal'
      });
    }

    // 6-month plan (0% APR)
    if (totalAmount >= 300) {
      plans.push({
        id: 'plan_6mo',
        name: '6-Month Payment Plan',
        downPayment: Math.ceil(totalAmount / 6),
        monthlyPayment: Math.ceil(totalAmount / 6),
        numberOfPayments: 5,
        totalAmount,
        apr: 0,
        provider: 'internal'
      });
    }

    // 12-month plan via Affirm (10-30% APR based on credit)
    if (totalAmount >= 300) {
      plans.push({
        id: 'plan_12mo_affirm',
        name: '12-Month Financing (Affirm)',
        downPayment: 0,
        monthlyPayment: Math.ceil((totalAmount * 1.15) / 12), // Assume 15% APR average
        numberOfPayments: 12,
        totalAmount: totalAmount * 1.15,
        apr: 15,
        provider: 'affirm'
      });
    }

    return plans;
  }
}
```

### 3. Checkout Flow

```typescript
interface CheckoutSession {
  id: string;
  customerId: string;
  testOrderId: string;

  // Pricing
  pricing: PricingCalculation;
  selectedPaymentPlan?: PaymentPlan;

  // Payment method
  paymentMethod: PaymentMethod;

  // Billing address
  billingAddress: {
    line1: string;
    line2?: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
  };

  // HSA/FSA documentation
  hsaFsaDocumentation?: {
    needsReceipt: boolean;
    needsLMN: boolean; // Letter of Medical Necessity
    needsEOB: boolean; // Explanation of Benefits
  };

  // Status
  status: 'pending' | 'authorized' | 'captured' | 'failed' | 'refunded';

  // Stripe payment intent
  stripePaymentIntentId?: string;

  createdAt: Date;
  completedAt?: Date;
}

class CheckoutService {
  async createCheckoutSession(
    customerId: string,
    testOrderId: string
  ): Promise<CheckoutSession> {
    // 1. Calculate pricing
    const customer = await this.customerRepository.getCustomer(customerId);
    const pricing = this.pricingCalculator.calculatePrice({
      testType: 'aatd_genotyping',
      hasInsurance: customer.hasInsurance,
      insuranceInfo: customer.insuranceInfo,
      householdIncome: customer.householdIncome,
      householdSize: customer.householdSize
    });

    // 2. Create checkout session
    const session: CheckoutSession = {
      id: generateId('checkout'),
      customerId,
      testOrderId,
      pricing,
      paymentMethod: null as any,
      billingAddress: customer.billingAddress,
      status: 'pending',
      createdAt: new Date()
    };

    await this.checkoutRepository.saveSession(session);
    return session;
  }

  async processPayment(
    sessionId: string,
    paymentMethod: PaymentMethod
  ): Promise<PaymentResult> {
    const session = await this.checkoutRepository.getSession(sessionId);

    // 1. Create Stripe payment intent
    const paymentIntent = await this.stripe.paymentIntents.create({
      amount: Math.round(session.pricing.finalPrice * 100), // Convert to cents
      currency: 'usd',
      customer: session.customerId,
      payment_method: paymentMethod.stripePaymentMethodId,
      confirm: true,
      metadata: {
        testOrderId: session.testOrderId,
        customerId: session.customerId
      },
      description: 'AATD Genetic Test (CPT 81332)',
      statement_descriptor: 'FAIR UNDERWRITING',
      receipt_email: session.customerEmail
    });

    // 2. Handle payment result
    if (paymentIntent.status === 'succeeded') {
      session.status = 'captured';
      session.completedAt = new Date();
      session.stripePaymentIntentId = paymentIntent.id;

      await this.checkoutRepository.updateSession(session);

      // 3. Mark test order as paid
      await this.testOrderRepository.markAsPaid(session.testOrderId);

      // 4. Send confirmation email with HSA/FSA receipt
      await this.sendPaymentConfirmation(session);

      return {
        success: true,
        transactionId: paymentIntent.id,
        receiptUrl: paymentIntent.charges.data[0].receipt_url
      };
    } else {
      return {
        success: false,
        error: 'Payment failed',
        details: paymentIntent.last_payment_error?.message
      };
    }
  }

  async setupPaymentPlan(
    sessionId: string,
    planId: string
  ): Promise<PaymentPlanSetup> {
    const session = await this.checkoutRepository.getSession(sessionId);
    const plan = session.pricing.paymentPlanOptions?.find(
      (p) => p.id === planId
    );

    if (!plan) throw new Error('Invalid payment plan');

    // 1. Charge down payment
    const downPaymentResult = await this.processPayment(sessionId, {
      ...session.paymentMethod,
      amount: plan.downPayment
    });

    if (!downPaymentResult.success) {
      return { success: false, error: 'Down payment failed' };
    }

    // 2. Set up recurring payments
    const subscription = await this.stripe.subscriptions.create({
      customer: session.customerId,
      items: [
        {
          price_data: {
            currency: 'usd',
            product: 'prod_aatd_payment_plan',
            recurring: { interval: 'month' },
            unit_amount: Math.round(plan.monthlyPayment * 100)
          }
        }
      ],
      metadata: {
        testOrderId: session.testOrderId,
        paymentPlanId: plan.id,
        remainingPayments: plan.numberOfPayments
      }
    });

    return {
      success: true,
      subscriptionId: subscription.id,
      nextPaymentDate: new Date(subscription.current_period_end * 1000)
    };
  }
}
```

### 4. HSA/FSA Compliance

```typescript
interface HSAReceipt {
  // Required for HSA/FSA reimbursement
  transactionId: string;
  date: Date;
  providerName: string; // "Fair Underwriting, Inc."
  providerTaxId: string; // EIN
  providerAddress: string;

  // Patient information
  patientName: string;
  patientDOB: Date;

  // Service details
  serviceDescription: string; // "Alpha-1 Antitrypsin Deficiency Genetic Testing"
  cptCode: string; // "81332"
  diagnosisCode: string; // "E88.01" (AATD)

  // Pricing
  chargedAmount: number;
  paidAmount: number;
  insuranceAdjustment: number;
  patientResponsibility: number;

  // HSA/FSA eligibility statement
  hsaEligibility: {
    eligible: boolean;
    reason: string; // "Diagnostic genetic testing is an eligible medical expense per IRS Publication 502"
    irsPublication: 'IRS Pub 502';
  };

  // Letter of Medical Necessity (if required)
  lmnRequired: boolean;
  lmnTemplate?: string;
}

class HSAReceiptGenerator {
  generateReceipt(transaction: PaymentTransaction): HSAReceipt {
    return {
      transactionId: transaction.id,
      date: transaction.completedAt,
      providerName: 'Fair Underwriting, Inc.',
      providerTaxId: '12-3456789', // Placeholder EIN
      providerAddress: '123 Medical Plaza, Boston, MA 02115',

      patientName: transaction.customerName,
      patientDOB: transaction.customerDOB,

      serviceDescription:
        'Alpha-1 Antitrypsin Deficiency (AATD) Genetic Testing',
      cptCode: '81332',
      diagnosisCode: 'E88.01',

      chargedAmount: 450.0,
      paidAmount: transaction.amount,
      insuranceAdjustment: 450.0 - transaction.amount,
      patientResponsibility: transaction.amount,

      hsaEligibility: {
        eligible: true,
        reason:
          'Diagnostic genetic testing is an eligible medical expense per IRS Publication 502, Section "Laboratory Fees"',
        irsPublication: 'IRS Pub 502'
      },

      lmnRequired: transaction.amount > 500, // Some HSA administrators require LMN for charges >$500
      lmnTemplate: this.generateLMNTemplate(transaction)
    };
  }

  generateLMNTemplate(transaction: PaymentTransaction): string {
    return `
LETTER OF MEDICAL NECESSITY

Date: ${new Date().toLocaleDateString()}

To: ${transaction.hsaAdministrator || '[HSA/FSA Administrator]'}

Patient Name: ${transaction.customerName}
Patient DOB: ${transaction.customerDOB.toLocaleDateString()}

I am writing to certify that the following medical service was medically necessary for the above-named patient:

Service: Alpha-1 Antitrypsin Deficiency (AATD) Genetic Testing
CPT Code: 81332
Date of Service: ${transaction.completedAt.toLocaleDateString()}
Amount: $${transaction.amount.toFixed(2)}

MEDICAL JUSTIFICATION:
The patient has [symptoms/family history/clinical indication] consistent with Alpha-1 Antitrypsin Deficiency. AATD is a genetic disorder that causes lung disease (COPD, emphysema) and liver disease (cirrhosis). Early diagnosis is critical for:

1. Initiating augmentation therapy (if ZZ or SZ genotype)
2. Smoking cessation counseling (to prevent rapid lung decline)
3. Family cascade screening (to identify at-risk relatives)
4. Occupational counseling (to avoid lung irritants)

Per American Thoracic Society guidelines, AATD testing is recommended for all individuals with:
- COPD or emphysema (especially age <45 or non-smokers)
- Asthma with airflow obstruction
- Unexplained liver disease
- Family history of AATD

This test was medically necessary and appropriate for the patient's condition.

If you require additional information, please contact me at [phone] or [email].

Sincerely,

_________________________________
[Physician Name], [Credentials]
[NPI Number]
[Practice Address]
[Phone]

NOTE TO PATIENT: Please have your ordering physician sign this letter and submit it with your HSA/FSA reimbursement claim.
    `.trim();
  }
}
```

### 5. Financial Assistance Application

```typescript
interface FinancialAssistanceApplication {
  id: string;
  customerId: string;

  // Household information
  householdSize: number;
  householdIncome: number; // Annual gross income
  householdMembers: {
    name: string;
    relationship: string;
    age: number;
    employed: boolean;
  }[];

  // Income verification
  incomeVerification: {
    method:
      | 'tax_return'
      | 'pay_stubs'
      | 'unemployment'
      | 'social_security'
      | 'self_attestation';
    documents: {
      filename: string;
      fileUrl: string;
      fileType: string;
    }[];
    verifiedAt?: Date;
  };

  // Eligibility
  fplPercent: number;
  qualifies: boolean;
  discountPercent: number; // 50%, 75%, 90%, 95%
  discountedPrice: number;

  // Application status
  status: 'pending' | 'approved' | 'denied' | 'needs_more_info';
  reviewedBy?: string;
  reviewedAt?: Date;
  denialReason?: string;

  // Approval expiration
  expiresAt?: Date; // Financial assistance approval valid for 6 months

  createdAt: Date;
}

class FinancialAssistanceService {
  async submitApplication(
    customerId: string,
    applicationData: any
  ): Promise<FinancialAssistanceApplication> {
    const fplPercent = this.calculateFPLPercent(
      applicationData.householdIncome,
      applicationData.householdSize
    );

    const discountPercent = this.getDiscountPercent(fplPercent);
    const discountedPrice = 450 * (1 - discountPercent / 100);

    const application: FinancialAssistanceApplication = {
      id: generateId('fin_assist'),
      customerId,
      householdSize: applicationData.householdSize,
      householdIncome: applicationData.householdIncome,
      householdMembers: applicationData.householdMembers,
      incomeVerification: applicationData.incomeVerification,
      fplPercent,
      qualifies: fplPercent <= 400, // Qualify if ≤400% FPL
      discountPercent,
      discountedPrice,
      status: 'pending',
      expiresAt: new Date(Date.now() + 180 * 24 * 60 * 60 * 1000), // 6 months
      createdAt: new Date()
    };

    // Auto-approve if income verification is clear
    if (this.canAutoApprove(application)) {
      application.status = 'approved';
      application.reviewedAt = new Date();
      application.reviewedBy = 'system';
    }

    await this.financialAssistanceRepository.saveApplication(application);

    // Send confirmation email
    await this.sendApplicationConfirmation(application);

    return application;
  }

  getDiscountPercent(fplPercent: number): number {
    if (fplPercent <= 138) return 95; // Medicaid expansion
    if (fplPercent <= 200) return 90;
    if (fplPercent <= 300) return 75;
    if (fplPercent <= 400) return 50;
    return 0;
  }

  canAutoApprove(application: FinancialAssistanceApplication): boolean {
    // Auto-approve if:
    // 1. Income verification documents provided
    // 2. FPL percent clearly ≤400%
    // 3. No red flags (fraud indicators)

    const hasDocuments = application.incomeVerification.documents.length > 0;
    const clearlyQualifies = application.fplPercent <= 350; // 50 point buffer
    const noRedFlags = !this.detectFraudIndicators(application);

    return hasDocuments && clearlyQualifies && noRedFlags;
  }

  detectFraudIndicators(application: FinancialAssistanceApplication): boolean {
    // Basic fraud detection
    // - Multiple applications from same household
    // - Income suspiciously low for household size
    // - Recent similar applications denied

    // TODO: Implement actual fraud detection logic
    return false;
  }
}
```

---

## Database Schema

```sql
-- Payment transactions (extends existing billing tables in api.velox.ai)
CREATE TABLE patient_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    test_order_id UUID NOT NULL,

    -- Pricing
    list_price DECIMAL(10, 2) NOT NULL DEFAULT 450.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    final_price DECIMAL(10, 2) NOT NULL,

    -- Payment method
    payment_method VARCHAR(50) NOT NULL, -- credit_card, bank_account, paypal, etc.
    payment_provider VARCHAR(50) NOT NULL, -- stripe, paypal, square
    provider_transaction_id VARCHAR(255),

    -- Payment status
    status VARCHAR(30) DEFAULT 'pending',
    -- 'pending', 'authorized', 'captured', 'failed', 'refunded', 'partially_refunded'

    -- Card/bank details (encrypted)
    card_last4 VARCHAR(4),
    card_brand VARCHAR(20),
    bank_name VARCHAR(100),

    -- Payment plan
    payment_plan_id UUID REFERENCES payment_plans(id),
    is_payment_plan BOOLEAN DEFAULT false,

    -- HSA/FSA
    is_hsa_fsa BOOLEAN DEFAULT false,
    hsa_receipt_generated BOOLEAN DEFAULT false,
    hsa_receipt_url TEXT,

    -- Timestamps
    authorized_at TIMESTAMPTZ,
    captured_at TIMESTAMPTZ,
    failed_at TIMESTAMPTZ,
    refunded_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Payment plans
CREATE TABLE payment_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    test_order_id UUID NOT NULL,

    -- Plan details
    plan_type VARCHAR(50) NOT NULL, -- 3mo, 6mo, 12mo_affirm
    total_amount DECIMAL(10, 2) NOT NULL,
    down_payment DECIMAL(10, 2) NOT NULL,
    monthly_payment DECIMAL(10, 2) NOT NULL,
    num_payments INTEGER NOT NULL,
    apr DECIMAL(5, 2) DEFAULT 0.00,

    -- Payment schedule
    next_payment_date DATE NOT NULL,
    payments_completed INTEGER DEFAULT 0,
    payments_remaining INTEGER NOT NULL,

    -- Status
    status VARCHAR(30) DEFAULT 'active',
    -- 'active', 'completed', 'defaulted', 'cancelled'

    -- Failed payments
    failed_payment_count INTEGER DEFAULT 0,
    last_failed_payment_date DATE,

    -- Stripe subscription ID (for recurring payments)
    stripe_subscription_id VARCHAR(255),

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ
);

-- Financial assistance applications
CREATE TABLE financial_assistance_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,

    -- Household info
    household_size INTEGER NOT NULL,
    household_income DECIMAL(10, 2) NOT NULL,
    fpl_percent DECIMAL(5, 2) NOT NULL, -- % of Federal Poverty Level

    -- Income verification
    verification_method VARCHAR(50) NOT NULL,
    verification_documents JSONB, -- Array of document URLs
    verified_at TIMESTAMPTZ,

    -- Eligibility
    qualifies BOOLEAN NOT NULL,
    discount_percent INTEGER, -- 50, 75, 90, 95
    discounted_price DECIMAL(10, 2),

    -- Application status
    status VARCHAR(30) DEFAULT 'pending',
    -- 'pending', 'approved', 'denied', 'needs_more_info'
    reviewed_by VARCHAR(255),
    reviewed_at TIMESTAMPTZ,
    denial_reason TEXT,

    -- Approval expiration (6 months)
    expires_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- HSA/FSA receipts
CREATE TABLE hsa_fsa_receipts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_id UUID REFERENCES patient_payments(id),
    customer_id UUID NOT NULL,

    -- Receipt details
    transaction_id VARCHAR(255) NOT NULL,
    service_date DATE NOT NULL,
    service_description TEXT NOT NULL,
    cpt_code VARCHAR(10) NOT NULL,
    diagnosis_code VARCHAR(10),

    -- Pricing
    charged_amount DECIMAL(10, 2) NOT NULL,
    paid_amount DECIMAL(10, 2) NOT NULL,

    -- Receipt URL (PDF)
    receipt_pdf_url TEXT,

    -- Letter of Medical Necessity
    lmn_required BOOLEAN DEFAULT false,
    lmn_template_url TEXT,

    generated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_patient_payments_customer ON patient_payments(customer_id);
CREATE INDEX idx_patient_payments_test_order ON patient_payments(test_order_id);
CREATE INDEX idx_patient_payments_status ON patient_payments(status);
CREATE INDEX idx_payment_plans_customer ON payment_plans(customer_id);
CREATE INDEX idx_payment_plans_status ON payment_plans(status);
CREATE INDEX idx_payment_plans_next_payment ON payment_plans(next_payment_date) WHERE status = 'active';
CREATE INDEX idx_financial_assistance_customer ON financial_assistance_applications(customer_id);
CREATE INDEX idx_financial_assistance_status ON financial_assistance_applications(status);
```

---

## UI/UX Specifications

### Checkout Page

```
┌────────────────────────────────────────────────────────────────┐
│  Fair Underwriting - Secure Checkout                  🔒       │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ORDER SUMMARY                                                  │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ AATD Genetic Test (CPT 81332)               $450.00    │  │
│  │ Insurance discount                          -$200.00    │  │
│  │ Financial assistance (75% off)              -$187.50    │  │
│  │ ─────────────────────────────────────────────────────   │  │
│  │ YOU PAY TODAY                               $62.50     │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  💰 PAYMENT PLAN AVAILABLE                                     │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ Can't pay $62.50 today? Choose a payment plan:          │  │
│  │                                                           │  │
│  │ ⭘ Pay $62.50 today (no payment plan)                    │  │
│  │ ⭘ 3 payments of $21 (0% APR)                            │  │
│  │ ⭘ 6 payments of $11 (0% APR)                            │  │
│  │                                                           │  │
│  │ [Change Payment Plan]                                    │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  💳 PAYMENT METHOD                                             │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ ⭘ Credit or Debit Card                                  │  │
│  │ ⭘ HSA/FSA Card (includes itemized receipt)              │  │
│  │ ⭘ Bank Account (ACH)                                    │  │
│  │ ⭘ PayPal                                                 │  │
│  │                                                           │  │
│  │ Card Number: [____-____-____-____]                      │  │
│  │ Exp: [MM/YY]  CVV: [___]  ZIP: [_____]                 │  │
│  │                                                           │  │
│  │ ☑ Save this card for future payments                    │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  📬 BILLING ADDRESS                                            │
│  [Same as shipping address]                                    │
│                                                                 │
│  [ Continue to Payment ]                                       │
│                                                                 │
│  🔒 Secure payment powered by Stripe                           │
│  Your payment information is encrypted and secure              │
└────────────────────────────────────────────────────────────────┘
```

### Financial Assistance Application

```
┌────────────────────────────────────────────────────────────────┐
│  Financial Assistance Application                               │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  💰 CAN'T AFFORD THE $450 TEST?                                │
│  We offer income-based financial assistance. Most people        │
│  qualify for significant discounts.                             │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ DISCOUNT TIERS                                           │  │
│  │                                                           │  │
│  │ • Income <$30K (200% FPL): Pay $45 (90% off)           │  │
│  │ • Income $30-45K (300% FPL): Pay $112 (75% off)        │  │
│  │ • Income $45-60K (400% FPL): Pay $225 (50% off)        │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  📝 APPLICATION                                                │
│                                                                 │
│  1. Household Size                                             │
│     How many people live in your household?                    │
│     [1] [2] [3] [4] [5] [6] [7] [8+]                         │
│                                                                 │
│  2. Household Income                                           │
│     What is your total household income (before taxes)?        │
│     [$_______] per [year ▼]                                   │
│                                                                 │
│  3. Income Verification (choose one)                           │
│     ⭘ Upload last year's tax return (Form 1040)               │
│     ⭘ Upload 2 recent pay stubs                               │
│     ⭘ Upload unemployment benefits letter                      │
│     ⭘ Self-attestation (I don't have documents)               │
│                                                                 │
│     [📎 Upload Documents]                                      │
│                                                                 │
│  ───────────────────────────────────────────────────────────   │
│                                                                 │
│  YOUR ESTIMATED DISCOUNT: 90% off                              │
│  You would pay: $45 (instead of $450)                          │
│                                                                 │
│  [ Submit Application ]                                        │
│                                                                 │
│  ⏱️ Most applications approved within 24 hours                 │
│  📧 You'll receive email confirmation                           │
└────────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

**Revenue**:

- **Payment completion rate**: 95%+ (industry avg: 80%)
- **Payment plan adoption**: 40% of customers >$200 balance
- **Financial assistance applications**: 15% of uninsured customers
- **HSA/FSA receipt requests**: <5% support tickets (should be automatic)

**Customer Satisfaction**:

- **Checkout NPS**: 50+ (transparent pricing, easy payment)
- **Support tickets re: billing**: <2% of orders
- **Payment disputes/chargebacks**: <0.5%

**Financial**:

- **Bad debt write-offs**: <2% of payment plan revenue
- **Average days to payment**: <1 day (vs. 30 days for insurance claims)
- **Financial assistance cost**: $75K/year (300 applications @ $250 discount avg)

---

## Budget & Costs

### Development (4-5 months)

- **Backend Developer** (payment processing, webhooks): $140K/year × 0.42 = $58,800
- **Frontend Developer** (checkout UI, payment forms): $130K/year × 0.42 = $54,600
- **Financial Operations Specialist** (financial assistance, payment plans): $80K/year × 0.25 = $20,000

**Total Development**: ~$133,400

### Annual Operations

**Infrastructure**:

- **Stripe fees**: 2.9% + $0.30 per transaction × 10,000 tests = $145,000/year
- **Affirm fees**: 3-6% of financed amount × $500K financed = $15,000-$30,000/year
- **PCI compliance audit**: $3,000/year

**Financial Assistance**:

- **Discounts provided**: 300 applications × $250 avg discount = $75,000/year
- **Staff time (review applications)**: 0.25 FTE × $80K = $20,000/year

**Total Operations**: ~$258,000/year

### **GRAND TOTAL (First Year)**: ~$391,400

**ROI**:

- **Incremental revenue** (from customers who couldn't afford $450 upfront): $630K/year
- **Net benefit**: $630K - $258K operations = **$372K/year profit increase**

---

## Implementation Roadmap

### Phase 1: Basic Payment Processing (Weeks 1-6)

- ✅ Stripe integration for credit/debit cards
- ✅ Checkout page with pricing calculator
- ✅ Payment confirmation emails
- ✅ Basic receipt generation

### Phase 2: Payment Plans (Weeks 7-10)

- ✅ 3-month and 6-month payment plans (0% APR)
- ✅ Subscription-based recurring billing
- ✅ Payment plan dashboard for customers
- ✅ Dunning (failed payment retry logic)

### Phase 3: HSA/FSA Compliance (Weeks 11-12)

- ✅ HSA/FSA-compliant receipts with CPT codes
- ✅ Automatic EOB generation
- ✅ Letter of Medical Necessity template

### Phase 4: Financial Assistance (Weeks 13-16)

- ✅ Financial assistance application form
- ✅ Income verification workflow
- ✅ Auto-approval logic for clear cases
- ✅ Manual review queue for edge cases

### Phase 5: Advanced Features (Weeks 17-20)

- ✅ Affirm financing integration (12-month plans)
- ✅ PayPal, Apple Pay, Google Pay
- ✅ International payment support (multi-currency)
- ✅ Fraud detection (Stripe Radar)

---

**Document Status**: Complete
**Next Feature**: #26 - Advanced Analytics & Business Intelligence
