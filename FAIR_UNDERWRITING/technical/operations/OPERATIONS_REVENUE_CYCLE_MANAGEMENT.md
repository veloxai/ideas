# Feature #39: Revenue Cycle Management & Medical Billing Operations

**Category**: Operational Infrastructure - Financial Operations
**Priority**: Tier 1 - Critical (Launch Blocker)
**Depends On**: Feature #11 (Insurance Verification & Claims Management)
**Budget**: $180,000/year operations
**Status**: Required for Commercial Launch

---

## Executive Summary

Fair Underwriting will process **$5-10M in annual claims** from genetic testing, genetic counseling, and augmentation therapy services. Feature #11 automates electronic claims submission (837 EDI) and denial analysis, but **who operates the billing system?** Revenue Cycle Management (RCM) is the **people, processes, and software** that turn claims into cash. Without RCM operations, Fair Underwriting will have:

- **$1M+ in uncollected revenue** (industry average: 15% never collected)
- **90+ day delays** in payment (vs. 30 days with active RCM)
- **Billing disputes** with patients and insurers (no one to resolve)
- **Claim denial black holes** (4% of claims denied, no one appeals)
- **Cash flow crises** (can't pay lab partners or genetic counselors)

**This feature establishes**:

- **Billing Operations Team** (2 billing specialists, 1 RCM manager)
- **Revenue Cycle Management Software** (Athenahealth, Kareo, or Availity)
- **Standard Operating Procedures** (claims submission, payment posting, denial management, collections)
- **KPIs & Reporting** (days in A/R, collection rate, denial rate, patient satisfaction)

**Investment**: $180,000/year operations ($120K salaries + $60K software/overhead)
**ROI**: Collect 98% of billable revenue vs. 85% without RCM = **$650K/year saved** ($5M revenue × 13% improvement)

---

## Problem Scenarios

### Scenario 1: $450K in Unpaid Claims - No One Following Up

> **Situation**: Fair Underwriting submits 1,000 insurance claims in Q1 (avg $450/claim = $450K billed). Feature #11 automation submits claims electronically via Availity clearinghouse.
>
> **What Happens Next** (Without RCM Team):
>
> - Month 1: Claims submitted ✅
> - Month 2: 70% of claims paid ($315K collected) ✅
> - Month 3: 30% still pending ($135K outstanding) ⚠️
>   - 10% denied (coding errors, missing info) - $45K
>   - 15% payer processing delays - $67.5K
>   - 5% lost in system - $22.5K
>
> **Problem**: **No one is monitoring the $135K in unpaid claims**. CEO too busy fundraising, CTO building features, COO managing partnerships. Billing slips through cracks.
>
> **Outcome**:
>
> - Month 6: $90K written off (past timely filing deadline)
> - Month 12: $30K collected after patient complaints
> - **Total loss**: $105K (23% of billed amount never collected)
>
> **With RCM Team**: Billing specialist tracks every claim daily, follows up on denials within 48 hours, resubmits corrected claims, collects 98% of billed amount = **$441K collected vs. $345K** = **$96K saved per quarter** = **$384K/year**

---

### Scenario 2: Patient Calls Angry - "I Got a Bill for $450!"

> **Situation**: Patient Sarah took AATD test, thinking insurance covered it. 3 months later, bill arrives for $450.
>
> **Sarah calls Fair Underwriting**: "Why am I getting this bill? I have insurance!"
>
> **Current State** (No Support Team):
>
> - Call goes to generic support@ email
> - No one responds for 3 days
> - Sarah calls insurance - they say "claim was denied for missing diagnosis code"
> - Sarah posts angry review on Trustpilot: "Fair Underwriting billed me $450 after promising it was covered. Scam!"
>
> **With RCM Team**:
>
> - Call routed to billing specialist within 1 hour
> - Specialist pulls claim: "I see the denial - missing ICD-10 code E88.01. I'll resubmit today."
> - Specialist resubmits corrected claim
> - Insurance pays $350, Sarah owes $100 (deductible)
> - Specialist calls Sarah: "Good news - insurance approved $350. Your balance is $100, not $450. Would you like to set up a payment plan?"
> - Sarah happy ✅, no negative review ✅, $350 collected ✅

---

### Scenario 3: Payer Denies All Claims - "Not Medically Necessary"

> **Situation**: Blue Cross Blue Shield (BCBS) denies 50 claims in one week, all with reason code "CO-50: Not medically necessary".
>
> **Impact**: $22,500 in revenue at risk ($450 × 50 claims)
>
> **Current State** (No RCM Team):
>
> - Denials sit in Availity portal unnoticed
> - 30-day appeal window passes
> - $22,500 written off as bad debt
>
> **With RCM Team**:
>
> - Daily denial monitoring alerts RCM manager
> - RCM manager analyzes pattern: "BCBS changed policy 2 weeks ago - now requiring pre-authorization for genetic tests"
> - Action plan:
>   1. **Retroactive appeals**: Submit appeals with clinical justification (ATS/ERS guidelines recommend AATD testing for early-onset COPD patients)
>   2. **Process fix**: Update intake workflow to check BCBS pre-auth requirement before ordering tests
>   3. **Payer outreach**: Call BCBS provider relations to understand new policy
> - **Outcome**: 40/50 appeals approved = $18K collected, 10 denied = $4.5K write-off
> - **Savings**: $18K recovered vs. $0 without RCM team

---

### Scenario 4: Patient Payment Plans Defaulting

> **Situation**: 100 patients on 6-month payment plans ($75/month × 6 months = $450 total per patient = $45K total revenue).
>
> **Month 3**: 30% of patients miss payments (30 patients × $225 remaining = $6,750 at risk)
>
> **Current State** (No Collections Process):
>
> - Stripe auto-charges fail, no follow-up
> - Patients ghost Fair Underwriting
> - $6,750 sent to collections agency (keep 30% = $2,025 loss)
>
> **With RCM Team**:
>
> - Automated payment failure alerts
> - Billing specialist calls patients within 24 hours:
>   - "Hi John, your payment of $75 didn't go through. Can we update your card?"
>   - "I see you're having financial difficulty - would you like to extend your plan to 12 months at $37.50/month?"
> - **Recovery rate**: 80% (24/30 patients resume payments)
> - **Savings**: $5,400 recovered vs. $4,725 lost without RCM

---

### Scenario 5: End-of-Year Chaos - No Financial Visibility

> **Situation**: December 31st, CEO preparing for investor update. CFO asks: "What was our collection rate in Q4?"
>
> **Current State** (No RCM Reporting):
>
> - No idea. Data scattered across Stripe, Availity, Excel spreadsheets.
> - Takes 2 weeks to manually reconcile → miss investor deadline
> - Can't answer: "What's our average days to payment?" "What's our denial rate?" "Which payers pay fastest?"
>
> **With RCM Team**:
>
> - RCM software (Kareo) auto-generates reports:
>   - **Collection rate**: 96.2% (industry benchmark: 95-98%)
>   - **Days in A/R**: 28 days (target: <45 days)
>   - **Denial rate**: 3.8% (target: <5%)
>   - **Top payers by volume**: Anthem 30%, UnitedHealthcare 25%, Aetna 20%
>   - **Revenue by service**: Genetic testing $3.2M, counseling $800K, augmentation therapy support $500K
> - CEO has data in 5 minutes, investor call goes smoothly ✅

---

## Technical Specifications

### 1. Billing Operations Team Structure

```typescript
interface BillingTeam {
  roles: {
    rcmManager: {
      fte: 1.0;
      salary: 70000; // $70K/year
      responsibilities: [
        'Oversee billing operations',
        'Manage billing specialists',
        'Payer contract compliance',
        'Monthly financial reporting',
        'Process improvement',
        'Denial trend analysis',
        'Software vendor management'
      ];
      kpis: {
        collectionRate: 0.96; // Target: 96%+
        daysInAR: 30; // Target: <45 days
        denialRate: 0.04; // Target: <5%
      };
    };

    billingSpecialist1: {
      fte: 1.0;
      salary: 45000; // $45K/year
      responsibilities: [
        'Claims submission (backup to automation)',
        'Payment posting (EOB reconciliation)',
        'Denial management (research, appeal)',
        'Patient billing inquiries',
        'Insurance follow-up (aged A/R)',
        'Payer portal monitoring'
      ];
      dailyTasks: {
        morning: [
          'Review overnight claim rejections',
          'Post payments from previous day',
          'Follow up on claims >30 days old'
        ];
        afternoon: [
          'Research denials',
          'Submit appeals',
          'Return patient calls',
          'Update claim statuses'
        ];
      };
    };

    billingSpecialist2: {
      fte: 1.0;
      salary: 45000; // $45K/year
      responsibilities: [
        'Patient statements (generate, mail)',
        'Payment plan setup & monitoring',
        'Collections (pre-collections, hardship programs)',
        'Credit card processing (Stripe reconciliation)',
        'FSA/HSA receipt generation',
        'Patient portal billing support'
      ];
      dailyTasks: {
        morning: [
          'Process overnight online payments',
          'Review failed payment plan charges',
          'Generate weekly patient statements'
        ];
        afternoon: [
          'Call patients with overdue balances',
          'Set up new payment plans',
          'Update patient accounts',
          'Mail hardcopy statements'
        ];
      };
    };
  };

  coverage: {
    coreHours: '8am-5pm ET, Monday-Friday';
    afterHours: 'Voicemail + email (24-48 hour response)';
    escalation: 'RCM Manager handles complex disputes';
  };

  training: {
    initial: '2 weeks (RCM software, billing workflows, payer policies)';
    ongoing: 'Monthly (new payer policies, coding updates, process changes)';
    certifications: 'CPMA (Certified Professional Medical Auditor) optional';
  };
}
```

---

### 2. Revenue Cycle Management Software Stack

**Option 1: Athenahealth** (Enterprise-Grade RCM Platform)

```typescript
interface AthenahealthRCM {
  features: {
    claimsManagement: {
      submission: 'Integrated EDI (837) - bypasses Availity';
      scrubbing: 'Pre-submission validation (90% clean claim rate)';
      tracking: 'Real-time claim status from 5,000+ payers';
      denialManagement: 'Auto-categorize denials, track appeals';
    };

    paymentPosting: {
      eraProcessing: '835 EDI auto-posts payments';
      manual Posting: 'GUI for paper checks/credit cards';
      reconciliation: 'Match payments to claims';
      patientStatements: 'Auto-generate statements';
    };

    reporting: {
      revenueReports: 'Daily/weekly/monthly collection reports';
      arAging: 'Claims aging by 30/60/90/120+ days';
      denialAnalytics: 'Top denial reasons, payer-specific trends';
      productivity: 'Billing team performance metrics';
    };

    patientBilling: {
      statementGeneration: 'Auto-send via mail/email/portal';
      paymentPlans: 'Setup & track installment plans';
      onlinePayments: 'Patient portal integration (Stripe)';
      collections: 'Pre-collections workflows';
    };
  };

  pricing: {
    setupFee: 15000; // $15K one-time
    monthlyFee: 2500; // $2.5K/month = $30K/year
    perClaimFee: 0; // Included in monthly fee
    total: 45000; // Year 1: $45K, Year 2+: $30K/year
  };

  pros: [
    'All-in-one platform (billing + EHR + patient portal)',
    'Excellent payer connectivity (5,000+ payers)',
    'Strong analytics',
    'HIPAA-compliant cloud infrastructure'
  ];

  cons: [
    'Expensive ($30K/year ongoing)',
    'Overkill for small operation (<5,000 claims/year)',
    'Complex setup (3 months implementation)'
  ];

  bestFor: 'Enterprise scale (50K+ claims/year), multi-location practices';
}
```

**Option 2: Kareo** (Mid-Market RCM Platform) ⭐ **RECOMMENDED**

```typescript
interface KareoRCM {
  features: {
    claimsManagement: {
      submission: 'Integrated EDI via Kareo clearinghouse';
      scrubbing: 'Pre-submission edits (85% clean claim rate)';
      tracking: 'Claim status checks (3,000+ payers)';
      denialManagement: 'Denial dashboard with appeal templates';
    };

    paymentPosting: {
      eraProcessing: '835 EDI auto-posts';
      manualPosting: 'Simple GUI';
      reconciliation: 'Bank deposit matching';
      patientStatements: 'Branded statements (PDF/mail)';
    };

    reporting: {
      revenueReports: 'Revenue by payer, service, date range';
      arAging: '30/60/90/120+ day aging reports';
      denialAnalytics: 'Top 10 denial codes';
      productivity: 'Claims per specialist per day';
    };

    patientBilling: {
      statementGeneration: 'Email/mail/SMS statements';
      paymentPlans: 'Track installments, auto-reminders';
      onlinePayments: 'Kareo Pay (Stripe backend)';
      collections: 'Soft collections tools (no agency needed)';
    };
  };

  pricing: {
    setupFee: 5000; // $5K one-time
    monthlyFee: 799; // $799/month = $9,588/year
    perClaimFee: 2.5; // $2.50/claim (5,000 claims = $12.5K/year)
    total: 27088; // Year 1: $27K, Year 2+: $22K/year
  };

  pros: [
    'Affordable ($22K/year ongoing)',
    'Fast setup (4-6 weeks)',
    'Intuitive interface (easy to train billing team)',
    'Good analytics for mid-market',
    'Integrated patient portal'
  ];

  cons: [
    'Per-claim fees add up at scale (>10K claims)',
    'Less robust than Athenahealth (3,000 vs. 5,000 payers)',
    'Limited customization'
  ];

  bestFor: 'Small to mid-size operations (5K-50K claims/year)';
}
```

**Option 3: Availity Essentials** (Lightweight RCM Add-On)

```typescript
interface AvailityEssentials {
  features: {
    claimsManagement: {
      submission: 'Already using Availity for EDI (Feature #11)';
      scrubbing: 'Basic edits (70% clean claim rate)';
      tracking: 'Claim status checks (all major payers)';
      denialManagement: 'Manual denial research (no automation)';
    };

    paymentPosting: {
      eraProcessing: '835 EDI download (manual posting)';
      manualPosting: 'Spreadsheet-based';
      reconciliation: 'Manual';
      patientStatements: 'No built-in tool';
    };

    reporting: {
      revenueReports: 'Basic Excel reports';
      arAging: 'Manual calculation';
      denialAnalytics: 'No analytics';
      productivity: 'No tracking';
    };

    patientBilling: {
      statementGeneration: 'Use external tool (QuickBooks)';
      paymentPlans: 'Track in spreadsheet';
      onlinePayments: 'Direct Stripe integration';
      collections: 'Manual process';
    };
  };

  pricing: {
    setupFee: 0; // Already using Availity
    monthlyFee: 99; // $99/month = $1,188/year
    perClaimFee: 1; // $1/claim (5,000 claims = $5K/year)
    total: 6188; // Year 1 & 2+: $6.2K/year
  };

  pros: [
    'Cheapest option ($6K/year)',
    'Already integrated (Feature #11)',
    'No additional software learning curve'
  ];

  cons: [
    'Heavy manual work (requires 2x billing team time)',
    'No automation (payment posting, denial analysis)',
    'Poor reporting (CFO will be frustrated)',
    'No patient portal integration'
  ];

  bestFor: 'Early stage (<2,000 claims/year), tight budget';
}
```

**Recommendation**: **Kareo** for Fair Underwriting's needs

- **5,000-10,000 claims/year projected** (5K customers × 1-2 claims/customer)
- **Mid-market sweet spot** ($22K/year affordable, not overkill)
- **Fast setup** (launch in 6 weeks vs. 3 months for Athenahealth)
- **Strong automation** (reduce billing team workload 40%)

---

### 3. Standard Operating Procedures

**SOP #1: Daily Claims Submission Monitoring**

```typescript
interface DailyClaimsMonitoring {
  schedule: 'Every morning, 8:00am-9:00am';

  steps: [
    {
      step: 1;
      task: 'Review overnight claim rejections';
      system: 'Kareo > Claims > Rejected tab';
      action: 'Research rejection reason, correct, resubmit same day';
      sla: 'All rejections resolved within 24 hours';
    },
    {
      step: 2;
      task: 'Review claims pending >3 days';
      system: 'Kareo > Claims > Pending tab, filter by date';
      action: 'Call clearinghouse (Availity) if stuck, escalate to payer if needed';
      sla: 'No claim pending >7 days without follow-up';
    },
    {
      step: 3;
      task: 'Review new denials';
      system: 'Kareo > Denials > New tab';
      action: 'Categorize denial, assign to specialist for appeal';
      sla: 'All denials categorized same day';
    },
    {
      step: 4;
      task: 'Review ERA files (835 EDI)';
      system: 'Kareo > Payments > ERA tab';
      action: 'Auto-post payments, verify accuracy, flag discrepancies';
      sla: 'All payments posted within 1 business day';
    }
  ];

  kpis: {
    claimsSubmitted: 20-30 per day (assuming 5K claims/year);
    rejectionRate: '<10% (Kareo scrubbing catches errors)';
    resubmissionTime: '<24 hours';
  };
}
```

**SOP #2: Weekly Patient Statement Generation**

```typescript
interface WeeklyStatementGeneration {
  schedule: 'Every Friday, 2:00pm-4:00pm';

  steps: [
    {
      step: 1;
      task: 'Generate statements for all accounts with balance >$0';
      system: 'Kareo > Billing > Statements > Generate';
      filters: 'Balance >$0, last statement >30 days ago';
      output: 'PDF statements (email preferred, mail if no email)';
    },
    {
      step: 2;
      task: 'Review accounts >90 days past due';
      system: 'Kareo > A/R Aging > 90+ days tab';
      action: 'Call patient, offer payment plan, escalate to collections if unresponsive';
      threshold: '>$100 balance warrants phone call';
    },
    {
      step: 3;
      task: 'Mail hardcopy statements';
      system: 'Export PDFs, send to print vendor (Lob.com)';
      cost: '$1.50 per statement (postage + printing)';
      volume: '~100 statements/week = $150/week = $7.8K/year';
    },
    {
      step: 4;
      task: 'Update patient portal balances';
      system: 'Kareo syncs to Fair Underwriting portal (API)';
      action: 'Verify sync successful, troubleshoot if balances mismatch';
    }
  ];

  kpis: {
    statementsGenerated: 400-500 per month;
    emailDeliveryRate: '95%+ (verify email addresses)';
    paymentRate: '30% of patients pay within 7 days of statement';
  };
}
```

**SOP #3: Monthly Denial Appeals**

```typescript
interface MonthlyDenialAppeals {
  schedule: 'First week of each month';

  steps: [
    {
      step: 1;
      task: 'Prioritize denials by value';
      system: 'Kareo > Denials > sort by Amount';
      action: 'Focus on high-value denials (>$200) first';
      rationale: '80/20 rule - 20% of denials = 80% of revenue at risk';
    },
    {
      step: 2;
      task: 'Research denial reason';
      system: 'Kareo > Denial details, payer website, calling payer';
      commonReasons: {
        missingInfo: 'Request info from patient/provider, resubmit';
        codingError: 'Correct CPT/ICD-10 code, resubmit';
        priorAuthRequired: 'Retroactive auth or write off';
        timely Filing: 'Write off (can\'t appeal past deadline)';
        notMedicallyNecessary: 'Appeal with clinical justification';
      };
    },
    {
      step: 3;
      task: 'Draft appeal letter';
      system: 'Feature #11 AI appeal generation or manual draft';
      template: 'Use payer-specific appeal forms';
      attachments: 'Clinical notes, lab results, ATS/ERS guidelines';
    },
    {
      step: 4;
      task: 'Submit appeal';
      system: 'Payer portal (preferred) or fax';
      tracking: 'Log in Kareo > Denials > Appeal Status';
      followUp: 'Check status 30 days after submission';
    }
  ];

  kpis: {
    appealsSubmitted: 15-20 per month (4% denial rate × 500 claims = 20 denials);
    appealSuccessRate: '60-70% (industry average)';
    averageAppealTime: '45-60 days for payer decision';
  };
}
```

**SOP #4: Quarterly Payer Contract Compliance Review**

```typescript
interface QuarterlyPayerReview {
  schedule: 'First month of Q2, Q3, Q4, Q1';

  steps: [
    {
      step: 1;
      task: 'Review contracted rates vs. actual reimbursement';
      system: 'Kareo > Reports > Reimbursement Analysis';
      action: 'Identify underpayments, submit corrected claims or contact payer';
      example: 'Contract says $400/test, payer paid $350 → underpayment by $50';
    },
    {
      step: 2;
      task: 'Review payer-specific denial trends';
      system: 'Kareo > Denials > Group by Payer';
      action: 'Identify problematic payers (>10% denial rate)';
      escalation: 'Contact payer relations, discuss process improvements';
    },
    {
      step: 3;
      task: 'Update fee schedules';
      system: 'Kareo > Setup > Fee Schedules';
      action: 'Reflect new payer contracts, CPI adjustments';
      frequency: 'Annual adjustments (per contract terms)';
    },
    {
      step: 4;
      task: 'Generate quarterly report for CFO';
      system: 'Kareo > Reports > Custom dashboard';
      metrics: {
        collectionRate: 'Target 96%+';
        daysInAR: 'Target <45 days';
        denialRate: 'Target <5%';
        revenueByPayer: 'Top 5 payers';
        profitMargin: '(Revenue - COGS) / Revenue';
      };
    }
  ];

  kpis: {
    underpaymentRecovery: '$5K-10K per quarter';
    payerRelationships: 'Maintain 95%+ clean claim rate with top 5 payers';
  };
}
```

---

### 4. Key Performance Indicators (KPIs)

```typescript
interface RCM_KPIs {
  primaryMetrics: {
    collectionRate: {
      definition: '(Cash collected ÷ Total charges) × 100';
      target: 96; // 96%+
      calculation: 'Last 90 days: $480K collected ÷ $500K charged = 96%';
      benchmark: 'Industry average: 95-98%';
      redFlag: '<90% = serious collection problem';
    };

    daysInAR: {
      definition: 'Average days from service date to payment';
      target: 30; // <45 days
      calculation: '(Total A/R ÷ Average daily charges)';
      example: '$60K A/R ÷ $2K/day charges = 30 days';
      benchmark: 'Industry average: 30-45 days';
      redFlag: '>60 days = slow collections, cash flow risk';
    };

    denialRate: {
      definition: '(Denied claims ÷ Total claims submitted) × 100';
      target: 4; // <5%
      calculation: 'Last month: 20 denials ÷ 500 claims = 4%';
      benchmark: 'Industry average: 5-10%';
      redFlag: '>10% = systemic billing issues';
    };

    netCollectionRate: {
      definition: '(Cash collected ÷ (Total charges - Contractual adjustments)) × 100';
      target: 99; // 99%+
      explanation: 'Measures collection of allowed amount (after payer discounts)';
      example: 'Charged $500, allowed $400, collected $396 = 99%';
      benchmark: 'Best-in-class: 98-100%';
    };
  };

  secondaryMetrics: {
    cleanClaimRate: {
      definition: 'Claims accepted on first submission (no rejections)';
      target: 90; // 90%+
      impact: 'Higher clean claim rate = faster payment';
    };

    appealSuccessRate: {
      definition: 'Appeals approved ÷ Total appeals submitted';
      target: 65; // 65%+
      rationale: '65% success = worth appealing, <50% = not worth effort';
    };

    patientSatisfactionScore: {
      definition: 'NPS or CSAT for billing inquiries';
      target: 80; // 80%+ satisfaction
      measurement: 'Post-call survey: "How satisfied were you with our billing support?"';
    };

    costToCollect: {
      definition: 'Billing team cost ÷ Revenue collected';
      target: 3; // <3%
      calculation: '$180K team cost ÷ $6M collected = 3%';
      benchmark: 'Industry average: 3-5%';
    };
  };

  dashboard: {
    frequency: 'Updated daily (auto-generated from Kareo)';
    recipients: ['CFO', 'CEO', 'RCM Manager'];
    format: 'Kareo dashboard + weekly email summary';
    alerts: {
      collectionRateDrop: 'Alert if <94% (2% below target)';
      daysInARIncrease: 'Alert if >50 days (20 days above target)';
      denialSpike: 'Alert if >10% in any single day';
    };
  };
}
```

---

### 5. Collections Workflow

```typescript
interface CollectionsWorkflow {
  stage1_Soft: {
    trigger: 'Balance 30 days past due';
    actions: [
      'Send friendly reminder email',
      'Offer payment plan (3/6/12 months)',
      'Update patient portal with balance notice'
    ];
    tone: 'Friendly: "We noticed your balance - can we help?"';
    successRate: '40% pay after first reminder';
  };

  stage2_Firm: {
    trigger: 'Balance 60 days past due';
    actions: [
      'Phone call from billing specialist',
      'Verify financial hardship (offer assistance program)',
      'Set up payment plan or settle for reduced amount'
    ];
    tone: 'Firm but compassionate: "We need to resolve this balance"';
    successRate: '30% pay after phone call';
  };

  stage3_PreCollections: {
    trigger: 'Balance 90 days past due, >$100';
    actions: [
      'Final notice letter (certified mail)',
      'Offer: "Pay 75% by [date] to avoid collections"',
      'Set 10-day deadline'
    ];
    tone: 'Serious: "This is your final opportunity to avoid collections"';
    successRate: '15% pay after final notice';
  };

  stage4_Collections: {
    trigger: 'Balance 120 days past due, >$200';
    actions: [
      'Send to collections agency',
      'Agency keeps 30-40% of collected amount',
      'Fair Underwriting writes off balance from A/R'
    ];
    costBenefit: 'Only worthwhile for balances >$200 (agency fee > collection)';
    successRate: '20-30% collected by agency';
  };

  stage5_WriteOff: {
    trigger: 'Balance >180 days past due, <$200, or exhausted all options';
    actions: [
      'Write off as bad debt',
      'Report to CFO monthly',
      'Track write-off % (target: <2% of revenue)'
    ];
    taxImplication: 'Bad debt can be deducted from taxable income';
  };

  financialAssistanceProgram: {
    integration: 'Feature #25 financial assistance (FPL-based discounts)';
    trigger: 'Patient claims financial hardship at any stage';
    process: [
      'Patient submits income verification',
      'Auto-approve if <350% FPL',
      'Discount balance 50-95% per FPL tier',
      'Write off discounted amount'
    ];
    impact: 'Prevents bad debt, improves patient satisfaction';
  };
}
```

---

### 6. Integration with Fair Underwriting Platform

```typescript
interface RCM_Integration {
  // Kareo API integration
  kareoAPI: {
    authentication: 'OAuth 2.0 (client_credentials flow)';
    baseURL: 'https://api.kareo.com/v1';

    endpoints: {
      createClaim: 'POST /claims';
      getClaimStatus: 'GET /claims/{id}';
      postPayment: 'POST /payments';
      generateStatement: 'POST /statements';
      getARReport: 'GET /reports/aging';
    };

    webhooks: {
      claimPaid: 'Kareo → Fair Underwriting: Claim paid, post to database';
      claimDenied: 'Kareo → Fair Underwriting: Claim denied, trigger alert';
      statementGenerated: 'Kareo → Fair Underwriting: Update patient portal balance';
    };
  };

  // Fair Underwriting database schema
  billing: {
    tables: {
      medical_claims: {
        // Defined in Feature #11
        additionalFields: {
          kareo_claim_id: 'VARCHAR(50) - link to Kareo';
          rcm_status: 'VARCHAR(30) - tracking RCM workflow stage';
          assigned_specialist: 'UUID - which billing specialist owns this';
          last_action_date: 'TIMESTAMPTZ - last RCM action taken';
        };
      };

      rcm_actions: {
        // Track all RCM team actions
        schema: `
          id UUID PRIMARY KEY,
          claim_id UUID REFERENCES medical_claims(id),
          action_type VARCHAR(50), -- 'follow_up', 'appeal', 'call_patient', 'call_payer'
          action_taken TEXT,
          performed_by UUID REFERENCES users(id), -- Billing specialist
          created_at TIMESTAMPTZ DEFAULT NOW()
        `;
      };

      payment_allocations: {
        // Track how payments are allocated across claims/balances
        schema: `
          id UUID PRIMARY KEY,
          payment_id UUID,
          claim_id UUID REFERENCES medical_claims(id),
          allocated_amount DECIMAL(10, 2),
          allocation_type VARCHAR(30), -- 'insurance', 'patient', 'adjustment'
          created_at TIMESTAMPTZ DEFAULT NOW()
        `;
      };
    };

    reports: {
      rcmDashboard: `
        SELECT
          COUNT(*) FILTER (WHERE status = 'submitted') AS claims_pending,
          COUNT(*) FILTER (WHERE status = 'denied') AS claims_denied,
          COUNT(*) FILTER (WHERE status = 'paid') AS claims_paid,
          SUM(total_charges) FILTER (WHERE status IN ('submitted', 'accepted')) AS ar_total,
          AVG(EXTRACT(EPOCH FROM (paid_date - service_date))/86400) AS avg_days_to_payment,
          SUM(total_charges) FILTER (WHERE status = 'denied') AS denial_amount,
          (COUNT(*) FILTER (WHERE status = 'denied') * 100.0 / COUNT(*)) AS denial_rate
        FROM medical_claims
        WHERE service_date >= NOW() - INTERVAL '90 days'
      `;
    };
  };

  // Patient portal integration
  patientPortal: {
    billingTab: {
      features: [
        'View current balance',
        'View claim status (submitted, paid, denied)',
        'Download invoices/receipts',
        'Set up payment plan',
        'Make payment (Stripe)',
        'Request financial assistance',
        'Message billing team'
      ];

      dataSync: 'Real-time sync from Kareo API every 15 minutes';
    };
  };

  // Alerts & notifications
  notifications: {
    slack: {
      channel: '#billing-alerts';
      alerts: [
        'Claim denied (>$200)',
        'Payment posted (>$1,000)',
        'Payer underpayment detected',
        'Patient dispute escalation'
      ];
    };

    email: {
      recipients: [
        'rcm-manager@fairunderwriting.com',
        'cfo@fairunderwriting.com'
      ];
      alerts: [
        'Daily: Claims pending >7 days',
        'Weekly: A/R aging report',
        'Monthly: RCM KPI dashboard'
      ];
    };
  };
}
```

---

## Budget & Costs

### Development (One-Time Setup)

| Item                                    | Cost        | Notes                                  |
| --------------------------------------- | ----------- | -------------------------------------- |
| **Kareo Setup & Configuration**         | $5,000      | Kareo onboarding fee                   |
| **API Integration** (Kareo ↔ Platform) | $12,000     | 2 weeks backend dev (0.33 FTE × $72K)  |
| **Billing Portal UI** (Patient-facing)  | $8,000      | 1 week frontend dev (0.2 FTE × $84K)   |
| **Training Materials** (SOPs, videos)   | $3,000      | Document workflows, train billing team |
| **Kareo Data Migration** (if switching) | $2,000      | Import historical claims               |
| **TOTAL DEVELOPMENT**                   | **$30,000** | One-time setup (Months 1-2)            |

---

### Annual Operations (Ongoing)

| Item                                        | Cost/Year    | Notes                                  |
| ------------------------------------------- | ------------ | -------------------------------------- |
| **Salaries**                                |              |                                        |
| - RCM Manager (1.0 FTE)                     | $70,000      | $70K salary + 0% benefits (contractor) |
| - Billing Specialist #1 (1.0 FTE)           | $45,000      | $45K salary                            |
| - Billing Specialist #2 (1.0 FTE)           | $45,000      | $45K salary                            |
| **Subtotal Salaries**                       | **$160,000** |                                        |
| **Software & Services**                     |              |                                        |
| - Kareo RCM Platform                        | $22,000      | $799/mo + $2.50/claim × 5K claims      |
| - Lob.com (Statement mailing)               | $7,800       | $1.50 × 100 statements/week × 52 weeks |
| - Collections Agency Fees                   | $3,000       | 30% of collected bad debt (~$10K/year) |
| - Credit Card Processing (patient payments) | $6,000       | 2.9% on $200K patient payments         |
| **Subtotal Software**                       | **$38,800**  |                                        |
| **Overhead**                                |              |                                        |
| - Payroll Taxes (7.65% employer portion)    | $12,240      | FICA on $160K salaries                 |
| - Office Supplies, Phone System             | $2,000       | Headsets, printer, postage             |
| - Training & Certifications                 | $1,500       | CPMA certification, conferences        |
| **Subtotal Overhead**                       | **$15,740**  |                                        |
| **TOTAL ANNUAL OPS**                        | **$214,540** | Round to **$215K/year**                |

**Adjustment**: Initial budget estimate was $180K/year. After detailed breakdown, actual cost is **$215K/year**. Revised budget: **$215,000/year**.

---

## Success Metrics

### Financial Impact

| Metric                       | Without RCM Team | With RCM Team | Improvement |
| ---------------------------- | ---------------- | ------------- | ----------- |
| **Collection Rate**          | 85%              | 96%           | +11%        |
| **Days in A/R**              | 60 days          | 30 days       | -50%        |
| **Denial Rate**              | 18%              | 4%            | -78%        |
| **Bad Debt Write-Off %**     | 8%               | 2%            | -75%        |
| **Annual Revenue Collected** | $4.25M           | $4.8M         | **+$550K**  |

**ROI Calculation**:

- **Investment**: $215K/year
- **Return**: $550K additional revenue collected
- **Net Benefit**: $550K - $215K = **$335K/year profit**
- **ROI**: ($335K / $215K) × 100 = **156% ROI**

---

### Operational Metrics

| Metric                               | Target    | Measurement                             |
| ------------------------------------ | --------- | --------------------------------------- |
| **Claims Submitted Daily**           | 20-30     | Kareo dashboard                         |
| **Clean Claim Rate**                 | 90%+      | Claims accepted first submission        |
| **Payment Posting Turnaround**       | <24 hours | ERA posted same day received            |
| **Denial Appeal Turnaround**         | <7 days   | From denial to appeal submission        |
| **Patient Billing Inquiry Response** | <4 hours  | Phone/email response time               |
| **Statement Generation**             | Weekly    | Every Friday 2pm                        |
| **Aged A/R Follow-Up**               | 100%      | All claims >30 days followed up monthly |

---

### Patient Satisfaction

| Metric                               | Target | Measurement                        |
| ------------------------------------ | ------ | ---------------------------------- |
| **Billing Inquiry Resolution**       | 80%+   | Resolved in single interaction     |
| **Payment Plan Acceptance**          | 70%+   | Patients accept offered plans      |
| **Billing-Related Complaints**       | <2%    | Complaints / total patients tested |
| **Billing NPS (Net Promoter Score)** | 50+    | Post-billing survey                |

---

## Implementation Roadmap

### Month 1: Hiring & Setup

**Week 1-2: Hire RCM Team**

- Post job listings (Indeed, LinkedIn)
- Interview candidates (RCM manager first, then specialists)
- Background checks, references
- **Target**: Hire all 3 roles by Week 2

**Week 3-4: Kareo Setup**

- Sign Kareo contract
- Kareo onboarding call (setup checklist)
- Configure fee schedules, payer contracts
- Test claim submission (sandbox environment)
- **Deliverable**: Kareo configured, ready for production

---

### Month 2: Training & Integration

**Week 5-6: Billing Team Training**

- Kareo training (provided by Kareo)
- Fair Underwriting workflow training (SOPs)
- Shadow current billing process (if any)
- Practice: Submit test claims, post test payments
- **Deliverable**: Team trained, confident using Kareo

**Week 7-8: API Integration**

- Backend dev: Kareo API ↔ Fair Underwriting database
- Frontend dev: Patient billing portal
- Test: End-to-end claim submission, payment posting
- **Deliverable**: Technical integration complete

---

### Month 3: Go-Live & Optimization

**Week 9: Soft Launch**

- Process all new claims through Kareo (50-100 claims)
- Monitor daily: rejections, denials, payment posting
- Daily standup: RCM manager + billing specialists
- **Deliverable**: First month of claims processed smoothly

**Week 10-12: Scale-Up**

- Increase volume to 500 claims/month
- Identify bottlenecks, optimize workflows
- Train on denial appeals (first appeals submitted)
- **Deliverable**: RCM team operating at full capacity

---

### Month 4+: Ongoing Optimization

**Quarterly Reviews**

- Review KPIs (collection rate, days in A/R, denial rate)
- Identify top denial reasons, implement fixes
- Payer contract compliance review
- Update SOPs based on lessons learned

**Annual Goals**

- Year 1: Achieve 94% collection rate, <40 days in A/R
- Year 2: Achieve 96% collection rate, <30 days in A/R, <4% denial rate
- Year 3: Expand team (add 1 specialist if volume >10K claims/year)

---

## Risk Mitigation

### Risk 1: Billing Team Turnover

**Risk**: High turnover in billing industry (30-40% annual turnover)

**Mitigation**:

- Competitive salaries ($45K for specialists = 90th percentile for remote)
- Career path: Billing Specialist → Senior Specialist → RCM Manager
- Ongoing training budget ($1.5K/year for certifications)
- Cross-training (2 specialists can cover for each other)

**Contingency**: If specialist quits, temp agency can provide coverage ($40/hour = $6,400/month) while hiring replacement

---

### Risk 2: Kareo Outage

**Risk**: Kareo system down = can't submit claims, post payments

**Mitigation**:

- Kareo SLA: 99.9% uptime (8 hours downtime/year)
- Backup: Use Availity portal directly (Feature #11 fallback)
- Manual process: Download ERA files, post payments manually
- Communication: Alert team immediately, work from backlog

**Contingency**: If Kareo down >24 hours, escalate to Kareo account manager, consider switching to Availity Essentials temporarily

---

### Risk 3: Payer Reimbursement Cuts

**Risk**: Payer reduces reimbursement rate (e.g., $450 → $350/test)

**Mitigation**:

- Monitor industry trends (CMS reimbursement changes)
- Diversify payer mix (not dependent on single payer)
- Negotiate multi-year contracts (lock in rates)
- Patient payment plans (shift burden from payer to patient if needed)

**Contingency**: If reimbursement cut >20%, re-evaluate profitability, potentially discontinue service for that payer

---

### Risk 4: High Denial Rate

**Risk**: Denial rate >10% = significant revenue loss

**Mitigation**:

- Kareo claim scrubbing (catch errors before submission)
- Weekly denial trend analysis (identify root causes)
- Payer-specific training (each payer has unique rules)
- Pre-authorization checks (before ordering test, not after)

**Contingency**: If denial rate >10% for 2 consecutive months, conduct root cause analysis, retrain billing team, escalate to payer relations

---

## Conclusion

Revenue Cycle Management is **not optional** for Fair Underwriting. Without a dedicated RCM team and software platform, Fair Underwriting will lose **$550K/year in uncollected revenue**, face **patient billing disputes**, and suffer **cash flow crises**.

**Key Takeaways**:

1. **Invest $215K/year in RCM operations** (3-person team + Kareo software)
2. **ROI: 156%** ($335K net benefit vs. $215K cost)
3. **Launch blocker**: Cannot scale beyond 2,000 claims/year without RCM team
4. **Implementation**: 3 months from hiring to full operation

**Next Steps**:

1. Approve $215K/year budget (include in Series A raise)
2. Post job listings for RCM Manager, 2 Billing Specialists (Month 0)
3. Sign Kareo contract (Month 1)
4. Begin training and integration (Months 1-2)
5. Go-live with RCM operations (Month 3)

---

**Document Status**: Complete
**Last Updated**: November 8, 2025
**Owner**: CFO + COO
**Review Frequency**: Quarterly (adjust KPIs, staffing as volume scales)
