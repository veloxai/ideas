# Feature #47: Sales & Business Development Operations

**Category**: Business Operations - Revenue Generation
**Priority**: Tier 1 - Critical (Launch Blocker)
**Budget**: $400,000/year operations + $120,000 one-time setup
**Revenue Impact**: Enables all revenue ($0 without sales team → $4.5M Year 1 with sales)

---

## Executive Summary

Fair Underwriting has documented 46 product features, operational infrastructure, and strategic partnerships. **Critical gap**: **No sales team to sell them.**

**Current State**:

- ✅ Amazing product (mobile apps, telemedicine, analytics, ML models)
- ✅ Comprehensive operations (billing, support, compliance, quality assurance)
- ✅ Strategic partnerships (pharma, providers, payers, academic)
- ❌ **Zero sales team** → Nobody to:
  - Close deals with insurance companies (B2B)
  - Pitch to insurance brokers (channel partners)
  - Attend industry conferences (LIMRA, NAIFA, NAIC)
  - Build relationships with benefits consultants
  - Negotiate partnership agreements
  - Generate pipeline

**Consequence**: Beautiful product nobody buys.

**Solution**: Build enterprise B2B sales organization targeting life insurance carriers, health insurance companies, and large employers.

---

## Problem Scenarios

### Scenario 1: The $2M Deal That Never Happened

> **Situation**: UnitedHealthcare reaches out (inbound lead from website). Interested in piloting Fair Underwriting genetic testing for 100,000 members.
>
> **Current State** (No Sales Team):
>
> - Email goes to info@fairunderwriting.com (forwarded to CEO)
> - CEO schedules call (3 weeks later - busy with product)
> - Discovery call goes OK but CEO doesn't know:
>   - UnitedHealthcare's buying process (3-month RFP cycle, requires legal/compliance/IT reviews)
>   - Decision makers (Chief Medical Officer, VP of Member Services, Procurement)
>   - Budget timeline (Q4 budget planning, need to close by October)
>   - Competitive landscape (23andMe, Color Health also pitching)
> - No follow-up (CEO forgets amid 100 other priorities)
> - UnitedHealthcare selects 23andMe
>
> **Impact**:
>
> - Lost revenue: $2M/year (100K members × $20 PMPM)
> - Lost credibility: "Fair Underwriting didn't even send a proposal"
> - Missed learning: No feedback on why we lost

**With Sales Team**:

- VP of Sales responds within 2 hours
- Schedules discovery call within 48 hours
- Identifies decision makers, budget, timeline, competition
- Coordinates technical demo, security review, compliance documentation
- Negotiates pricing, contract terms, SLAs
- Closes deal in 90 days → $2M ARR

---

### Scenario 2: Conference Booth Ghost Town

> **Situation**: Fair Underwriting sponsors LIMRA Life Insurance Conference ($25K booth).
>
> **Current State** (No Sales Team):
>
> - CTO and 2 engineers staff booth (uncomfortable with sales, just want to code)
> - Booth traffic: 150 people stop by over 3 days
> - Lead capture: 23 business cards collected (no CRM to track)
> - Follow-up: Zero (engineers don't know what to say, go back to coding)
>
> **Impact**:
>
> - Wasted $25K sponsorship + $10K travel
> - Wasted 150 warm leads (conference attendees = decision makers)
> - Competitor Color Health (3 booths away) with professional sales team closes 5 deals = $3M pipeline

**With Sales Team**:

- VP of Sales + 2 Account Executives staff booth
- Professional booth setup (demo videos, product brochures, giveaways)
- Lead capture: 150 contacts scanned into Salesforce
- Qualification: 45 qualified leads (insurance carriers, large brokers)
- Follow-up: 45 personalized emails sent within 24 hours
- Pipeline generated: $8M (45 leads × $180K average deal size)
- Closed deals: 3 in next 6 months = $2.5M ARR

---

### Scenario 3: The Broker Network That Never Was

> **Situation**: Insurance brokers are ideal channel partners (they sell to employers, could bundle Fair Underwriting). Plan: recruit 100 brokers by Year 2.
>
> **Current State** (No Sales Team):
>
> - Product team builds beautiful partner portal (Feature #27)
> - Marketing creates broker brochures, videos, case studies
> - Launch announcement: "Partner portal now live!"
> - Result: 2 broker sign-ups (both are CEO's friends)
> - Pipeline: $0
>
> **Why?**: Nobody recruiting brokers. Brokers don't sign up for random websites. They need **personal relationships, training, incentives, ongoing support**.

**With Sales Team**:

- VP of Sales hires 2 Channel Account Managers (focus: broker recruitment)
- Identify top 500 brokers (by AUM, geographic coverage, AATD market exposure)
- Outbound campaigns: 50 calls/emails per week
- Broker webinars: "How to Add Genetic Testing to Your Wellness Offerings" (monthly)
- Broker incentives: $500 referral fee per customer + 10% revenue share
- Result: 50 broker partners recruited Year 1 → $1.2M ARR (brokers bring customers)

---

### Scenario 4: Expansion Opportunity Missed

> **Situation**: Fair Underwriting launches with AAT monitoring + SERPINA1 genotyping ($150/year). Customer feedback: "Can you add pharmacogenomics testing?" (how medications work based on genetics - $500 product).
>
> **Current State** (No Sales Team):
>
> - Product team: "Great idea, let's build it!" (6 months development)
> - Launch pharmacogenomics product
> - Existing customers: No one tells them it exists (no outbound sales motion)
> - Revenue: $0 (product sits unused)

**With Sales Team**:

- Account Executives identify upsell opportunity (existing customer base = warm leads)
- Create upsell campaign: Email to 5,000 existing customers announcing pharmacogenomics
- Schedule demos: 200 customers attend webinar
- Close rate: 15% (300 customers add pharmacogenomics @ $500/year)
- Upsell revenue: $150K Year 1, growing to $500K as customer base grows

---

### Scenario 5: RFP Graveyard

> **Situation**: Large employers (5,000+ employees) issue RFPs for genetic testing benefits. Fair Underwriting receives 10 RFPs/year (average deal size $500K).
>
> **Current State** (No Sales Team):
>
> - RFPs go unanswered (CEO too busy, product team doesn't know how to respond)
> - Lost opportunities: 10 RFPs × $500K = $5M pipeline
> - Win rate: 0%

**With Sales Team**:

- VP of Sales establishes RFP response process:
  - Qualify RFP (budget confirmed, decision timeline, buying criteria)
  - Assemble response team (sales lead + product + legal + compliance)
  - Create proposal (pricing, SLA commitments, case studies, references)
  - Present to selection committee
  - Negotiate contract
- Win rate: 30% (3 out of 10 RFPs)
- Revenue: $1.5M/year (3 × $500K)

---

## Solution: Enterprise B2B Sales Organization

### Sales Team Structure

```typescript
interface SalesOrganization {
  leadership: {
    vpSales: {
      fte: 1.0;
      salary: 150000; // $150K base
      ote: 225000; // $225K OTE (base + commission)
      commission: 'Tiered: 5% on first $2M ARR, 7.5% above $2M';
      responsibilities: [
        'Build and lead sales team',
        'Develop sales strategy and playbooks',
        'Manage sales pipeline ($10M+ target)',
        'Close strategic deals (>$500K ARR)',
        'Partner with CEO on partnerships',
        'Represent Fair Underwriting at conferences',
        'Quarterly sales forecasting and board reporting'
      ];
      kpis: {
        teamRevenue: '$4.5M ARR Year 1 target';
        pipelineCoverage: '3x quota (pipeline = 3× revenue target)';
        winRate: '25% (1 in 4 qualified opportunities)';
        salesCycleLength: '90 days avg (RFP-based sales)';
      };
      qualifications: [
        '10+ years enterprise software sales',
        'Healthcare/insurance industry experience required',
        'Proven track record closing $1M+ deals',
        'Existing relationships with insurance carriers (UnitedHealthcare, Anthem, Aetna)',
        'Executive presence (C-level selling)',
        'Startup experience (Series A/B stage)'
      ];
    };

    salesOperationsManager: {
      fte: 0.5; // Part-time Year 1, full-time Year 2
      salary: 90000; // $90K full-time = $45K for 0.5 FTE
      responsibilities: [
        'Manage Salesforce CRM (lead tracking, pipeline reports)',
        'Sales enablement (training materials, playbooks, battle cards)',
        'Sales analytics (conversion rates, win/loss analysis)',
        'Territory planning and quota setting',
        'Contract templates and pricing approvals',
        'Sales compensation administration'
      ];
    };
  };

  accountExecutives: {
    count: 2; // Year 1, grow to 5 by Year 3
    fte: 1.0;
    salaryEach: 85000; // $85K base
    oteEach: 170000; // $170K OTE (base + commission at quota)
    totalCost: 340000; // 2 AEs × $170K OTE
    quota: 1500000; // $1.5M ARR per AE
    commission: 'Tiered: 8% on first $1M, 10% on $1-2M, 12% above $2M';
    territories: [
      {
        ae: 'AE #1 - Enterprise Insurance';
        focus: 'Life insurance carriers (>$1B AUM), health insurance carriers';
        targetAccounts: [
          'UnitedHealthcare',
          'Anthem',
          'Aetna',
          'Cigna',
          'Humana',
          'Prudential',
          'MetLife',
          'New York Life',
          'Northwestern Mutual',
          'MassMutual'
        ];
      },
      {
        ae: 'AE #2 - Large Employers';
        focus: 'Fortune 1000 companies (>5,000 employees), self-insured employers';
        targetAccounts: [
          'Apple',
          'Google',
          'Amazon',
          'Microsoft',
          'JPMorgan Chase',
          'Bank of America',
          'Walmart',
          'Target',
          'Boeing',
          'General Electric'
        ];
      }
    ];
    responsibilities: [
      'Prospect and qualify leads (50 outbound touches/week)',
      'Conduct discovery calls and product demos',
      'Navigate complex sales cycles (multiple stakeholders)',
      'Coordinate technical/security/compliance reviews',
      'Negotiate pricing and contract terms',
      'Manage renewals and upsells (existing customers)',
      'Forecast pipeline and revenue (weekly updates)'
    ];
    kpis: {
      newBusinessARR: '$1.5M per AE per year';
      pipelineGeneration: '$4.5M pipeline per AE (3x coverage)';
      activitiesPerWeek: '50 (calls, emails, meetings)';
      meetingsPerWeek: '10 (discovery calls, demos, negotiations)';
      winRate: '25% (qualified opportunities → closed deals)';
      avgDealSize: '$180K ARR';
    };
  };

  channelAccountManagers: {
    count: 1; // Year 1, grow to 3 by Year 3
    fte: 1.0;
    salary: 75000; // $75K base
    ote: 135000; // $135K OTE
    commission: '15% of revenue from partner-sourced deals';
    focus: 'Recruit and enable insurance broker partners';
    responsibilities: [
      'Recruit brokers (target: 50 broker partners Year 1)',
      'Broker onboarding and training',
      'Create broker enablement materials (decks, case studies, ROI calculators)',
      'Monthly broker webinars',
      'Broker incentive programs (referral fees, revenue share)',
      'Track broker-sourced pipeline and revenue',
      'Quarterly broker business reviews'
    ];
    targetBrokers: [
      'Marsh & McLennan (largest global broker)',
      'Aon',
      'Willis Towers Watson',
      'Arthur J. Gallagher',
      'Hub International',
      'Brown & Brown',
      'Regional brokers (500+ across US)',
      'Benefits consultants (Mercer, Fidelity, Alight)'
    ];
    kpis: {
      brokersRecruited: '50 Year 1, 150 Year 2, 500 Year 3';
      brokerSourcedRevenue: '$1.2M Year 1 (50 brokers × $24K avg)';
      brokerActivationRate: '60% (% of recruited brokers who close deals)';
    };
  };

  businessDevelopmentReps: {
    count: 0; // Add 2 BDRs in Year 2 when pipeline demand increases
    fte: 1.0;
    salaryEach: 55000; // $55K base
    oteEach: 80000; // $80K OTE (base + commission on qualified meetings)
    responsibilities: [
      'Outbound prospecting (cold calls, emails, LinkedIn)',
      'Qualify leads (BANT: Budget, Authority, Need, Timeline)',
      'Schedule qualified meetings for AEs',
      'Update CRM with lead status and notes',
      'Support marketing campaigns (webinar promotion, event follow-up)'
    ];
    note: 'Not needed Year 1 (VP Sales + AEs handle prospecting). Add Year 2 when scaling to 5 AEs.';
  };
}
```

---

## Sales Process & Methodology

### Sales Funnel

```
Suspects (10,000 companies)
    ↓ Outreach (email, calls, conferences)
    ↓
Leads (500/year - expressed interest)
    ↓ Qualification (BANT: Budget, Authority, Need, Timeline)
    ↓
Qualified Opportunities (100/year - 20% lead-to-opp conversion)
    ↓ Discovery → Demo → Security/Compliance Review → Pricing → Negotiation
    ↓
Closed Deals (25/year - 25% win rate)
    ↓
Revenue: 25 deals × $180K avg = $4.5M ARR Year 1
```

### Sales Stages (Salesforce)

```typescript
enum SalesStage {
  PROSPECT = 'Prospect', // Initial outreach, not yet responded
  QUALIFIED = 'Qualified', // BANT confirmed, opportunity created
  DISCOVERY = 'Discovery', // Discovery call completed, understanding pain points
  DEMO = 'Demo/Presentation', // Product demo scheduled or completed
  SECURITY_REVIEW = 'Security/Compliance Review', // Customer IT/compliance reviewing Fair Underwriting
  PROPOSAL = 'Proposal Sent', // Pricing proposal and contract sent
  NEGOTIATION = 'Negotiation', // Negotiating pricing, terms, SLAs
  CLOSED_WON = 'Closed Won', // Contract signed, revenue recognized
  CLOSED_LOST = 'Closed Lost' // Lost to competitor or no decision
}

interface Opportunity {
  id: string;
  accountName: string; // UnitedHealthcare, Acme Corp
  contactName: string; // John Smith, VP of Member Services
  stage: SalesStage;
  amount: number; // $500,000 ARR
  probability: number; // 25% (varies by stage: Qualified 10%, Demo 25%, Proposal 50%, Negotiation 75%)
  closeDate: Date; // Expected close date
  nextSteps: string; // "Schedule security review with their CISO"
  competitorThreatened: string[]; // ['23andMe', 'Color Health']
  lossReason?: string; // If Closed Lost: "Price too high" or "No budget" or "Selected 23andMe"
}
```

### Sales Methodology: MEDDPICC

**MEDDPICC** = Gold standard for enterprise B2B sales (used by Salesforce, Oracle, SAP)

```typescript
interface MEDDPICCQualification {
  metrics: {
    question: 'What economic impact will Fair Underwriting deliver?';
    example: 'UnitedHealthcare: Early AATD detection saves $50K per ZZ patient × 5,000 ZZ members = $250M lifetime savings';
    salesTip: 'Quantify ROI early. CFOs buy on numbers, not features.';
  };

  economicBuyer: {
    question: 'Who has budget authority and can sign the contract?';
    example: 'Chief Medical Officer (CMO) or VP of Member Services (not IT director or benefits manager)';
    salesTip: 'Get to economic buyer by meeting 3. If stuck at lower level by meeting 5, deal will stall.';
  };

  decisionCriteria: {
    question: 'What are their buying criteria? How will they evaluate vendors?';
    example: 'Must-haves: HIPAA compliance, CAP-accredited labs, <7 day turnaround. Nice-to-haves: Mobile app, genetic counseling';
    salesTip: 'Align proposal to their criteria. If price is #1 criterion, you lose to low-cost competitor.';
  };

  decisionProcess: {
    question: 'What is their buying process? Who approves?';
    example: 'Legal review (2 weeks) → IT security review (4 weeks) → CMO approval → Procurement negotiation (2 weeks) = 10 weeks total';
    salesTip: 'Map out process early. Long sales cycles = forecast accuracy issues.';
  };

  paperProcess: {
    question: 'What paperwork is required? Contract, MSA, BAA, SLA?';
    example: 'Must use customer paper (their contract template), requires SOC 2 report, HIPAA BAA, SLA commitment 99.9% uptime';
    salesTip: 'Understand contracting requirements early. Some customers require 60-day legal review = add 2 months to close date.';
  };

  identifyPain: {
    question: 'What is their pain? Why buy now vs. wait?';
    example: 'UnitedHealthcare: Facing lawsuits from ZZ patients diagnosed late. Need to demonstrate proactive care.';
    salesTip: 'No pain = no urgency = no close. If they say "interesting but no rush", deal dies.';
  };

  champion: {
    question: "Who internally sells Fair Underwriting when you're not in the room?";
    example: 'VP of Member Services loves product, will advocate to CMO and CFO';
    salesTip: 'No champion = 90% lose rate. Champion coaches you on politics, decision process, objections.';
  };

  competition: {
    question: 'Who are we competing against? What is their strategy?';
    example: '23andMe (low cost, consumer brand), Color Health (enterprise focus, existing customer), Status Quo (do nothing)';
    salesTip: 'Most deals lost to Status Quo (no decision). Create urgency via pain/ROI.';
  };
}
```

---

## Sales Enablement & Tools

### CRM: Salesforce

```typescript
interface SalesforceCRM {
  cost: 25000; // $25K/year (5 users × $150/user/month × 12 months + implementation)
  users: ['VP Sales', 'AE #1', 'AE #2', 'Channel Mgr', 'Sales Ops'];

  modules: {
    salesCloud: {
      features: [
        'Lead and opportunity management',
        'Contact and account management',
        'Pipeline forecasting and reporting',
        'Email integration (Gmail/Outlook)',
        'Mobile app (Salesforce Mobile)',
        'Dashboards and analytics'
      ];
    };

    pardot: {
      cost: 15000; // $15K/year marketing automation
      features: [
        'Email campaigns',
        'Lead scoring and grading',
        'Landing pages and forms',
        'Lead nurturing workflows',
        'ROI reporting'
      ];
      note: 'Optional Year 1, add Year 2 when scaling marketing';
    };

    integrations: [
      'Gmail/Outlook (email tracking, calendar sync)',
      'LinkedIn Sales Navigator (prospect research)',
      'DocuSign (contract signing)',
      'Slack (notifications: deal closed, at-risk opportunities)',
      'Zoom (meeting scheduling and recording)',
      'Fair Underwriting API (customer usage data for upsells)'
    ];
  };

  reports: {
    pipelineReport: 'Weekly: Pipeline by stage, forecast vs. quota, at-risk deals';
    activityReport: 'Daily: Calls, emails, meetings by rep';
    winLossReport: 'Monthly: Win rate, loss reasons, competitor analysis';
    forecastReport: 'Weekly: Weighted pipeline, commit vs. best case vs. worst case';
  };
}
```

### Sales Playbooks

#### Playbook 1: Insurance Carrier Outreach

```markdown
**Target**: VP of Member Services or Chief Medical Officer at UnitedHealthcare, Anthem, Aetna, etc.

**Step 1: Research** (30 minutes before call)

- Google: "[Company] genetic testing program" (do they already offer genetic testing?)
- LinkedIn: Find VP of Member Services, CMO (connect, send personalized note)
- Earnings calls: Listen to latest earnings (any mention of preventive care, population health?)
- News: Any recent AATD-related press? Lawsuits from late diagnosis?

**Step 2: Outreach Sequence** (over 2 weeks)

- Day 1: LinkedIn connection request (personalized: "Saw you spoke at AHIP conference...")
- Day 3: Email #1 (subject: "Preventing $250M in AATD-related claims")
- Day 7: Follow-up email #2 (subject: "Re: Preventing $250M...")
- Day 10: Phone call (if no response)
- Day 14: Final email #3 (subject: "Should I close your file?")

**Step 3: Discovery Call** (if they respond)

- Agenda:
  1. Understanding their current genetic testing offerings (5 min)
  2. Pain points (10 min): "What challenges do you face with genetic testing?"
  3. Fair Underwriting solution overview (10 min)
  4. Next steps (5 min): Schedule product demo or send proposal
- MEDDPICC questions:
  - "What ROI would you need to see to move forward?"
  - "Who else needs to be involved in this decision?"
  - "What is your timeline for implementing a genetic testing program?"
  - "Are you evaluating other vendors?" (Competition)

**Step 4: Demo** (if qualified)

- Pre-demo: Send agenda, demo environment login, case study
- Demo flow (45 min):
  1. Privacy-first architecture (5 min) - addresses their #1 concern
  2. Partner portal walkthrough (10 min) - how they manage members
  3. Customer portal walkthrough (10 min) - member experience
  4. AATD test results and genetic counseling (10 min) - clinical value
  5. Reporting and analytics (5 min) - population health insights
  6. Q&A (10 min)
- Post-demo: Send follow-up email with pricing, case study, security documentation

**Step 5: Proposal** (if demo went well)

- Proposal includes:
  - Executive summary (1 page): Problem, solution, ROI
  - Pricing (tiered: <10K members $30 PMPM, 10-50K members $25 PMPM, 50K+ members $20 PMPM)
  - Implementation timeline (8 weeks: SSO integration, data feeds, training)
  - SLA commitments (99.9% uptime, 7-day test turnaround, <1 hour support response)
  - Case studies (if available)
  - References (if available)
  - Contract terms (3-year agreement, annual renewal, 90-day termination notice)

**Step 6: Negotiation**

- Common objections:
  - "Price too high" → Show ROI: $250M savings vs. $2M cost = 125x ROI
  - "Need to see case studies" → Offer pilot: 1,000 members for 6 months
  - "Legal review taking forever" → Escalate to CEO to meet their General Counsel
  - "Competitor is cheaper" → Highlight privacy moat: "Only Fair Underwriting has patent on insurance-safe genetic testing"

**Step 7: Close**

- Contract signed via DocuSign
- Kickoff call within 1 week (introduce implementation team)
- Invoice sent (Net 30 terms, first month prepaid)
```

#### Playbook 2: Large Employer Outreach

```markdown
**Target**: VP of Benefits or Chief HR Officer at Fortune 1000 companies

**Value Prop**: "Add genetic testing to your employee wellness program. Increase benefits differentiation, improve employee health, reduce healthcare costs."

**Outreach**: Similar to insurance carriers, but emphasize:

- Employee satisfaction: "Modern benefits attract and retain top talent"
- Preventive care: "Early AATD detection prevents expensive hospitalizations"
- Data privacy: "Employees trust you with their genetic data (vs. 23andMe selling to insurers)"

**Demo**: Focus on employee experience (mobile app, easy test kit, genetic counseling)

**Pricing**: Per employee per year (not PMPM)

- <1,000 employees: $50/employee/year
- 1,000-5,000 employees: $40/employee/year
- 5,000+ employees: $30/employee/year

**Pilot**: Offer 6-month pilot to 500 employees (test engagement, gather feedback)
```

#### Playbook 3: Broker Partner Recruitment

```markdown
**Target**: Insurance brokers with >$10M AUM, focus on group health or voluntary benefits

**Value Prop**: "Add Fair Underwriting to your product portfolio. Differentiate your firm, earn referral fees ($500/customer + 10% revenue share)."

**Outreach**: Warm introductions (LinkedIn, referrals) work best. Cold outreach has 5% response rate.

**Onboarding**:

1. Broker signs partner agreement (commission terms, branding guidelines)
2. Broker attends training webinar (1 hour: product overview, how to position, objection handling)
3. Broker receives enablement kit (brochures, case studies, ROI calculator, demo environment access)
4. Broker starts pitching to clients

**Support**: Monthly broker office hours (Q&A), quarterly broker leaderboard (top referrers win prizes)
```

---

## Sales Compensation Plans

### VP of Sales Compensation

```typescript
interface VPSalesCompensation {
  base: 150000; // $150K base salary
  targetCommission: 75000; // $75K at 100% quota attainment
  ote: 225000; // $225K OTE (On-Target Earnings)

  quotaStructure: {
    teamQuota: 4500000; // $4.5M ARR (2 AEs × $1.5M + 1 Channel Mgr × $1.5M)
    commissionRate: {
      tier1: { threshold: '0-80% of quota'; rate: 0.04 }; // 4% of ARR
      tier2: { threshold: '80-100% of quota'; rate: 0.05 }; // 5% of ARR
      tier3: { threshold: '100-120% of quota'; rate: 0.075 }; // 7.5% of ARR
      tier4: { threshold: '120%+ of quota'; rate: 0.1 }; // 10% of ARR (accelerators)
    };
  };

  example: {
    scenario: 'Team closes $5M ARR (111% of quota)';
    calculation: [
      '$3.6M × 4% = $144K (0-80% tier)',
      '$0.9M × 5% = $45K (80-100% tier)',
      '$0.5M × 7.5% = $37.5K (100-120% tier)'
    ];
    totalCommission: 226500; // $226.5K
    totalComp: 376500; // $150K base + $226.5K commission
  };

  spiffs: {
    firstDealBonus: 10000; // $10K bonus for team's first closed deal
    megaDealBonus: 25000; // $25K bonus for any deal >$1M ARR
  };
}
```

### Account Executive Compensation

```typescript
interface AECompensation {
  base: 85000; // $85K base
  targetCommission: 85000; // $85K at 100% quota (50/50 split)
  ote: 170000; // $170K OTE
  quota: 1500000; // $1.5M ARR per year

  commissionRate: {
    tier1: { threshold: '0-75% of quota', rate: 0.06 }, // 6% of ARR
    tier2: { threshold: '75-100% of quota', rate: 0.08 }, // 8% of ARR
    tier3: { threshold: '100-125% of quota', rate: 0.10 }, // 10% of ARR
    tier4: { threshold: '125%+ of quota', rate: 0.12 } // 12% of ARR
  };

  example: {
    scenario: 'AE closes $1.8M ARR (120% of quota)',
    calculation: [
      '$1.125M × 6% = $67.5K (0-75% tier)',
      '$0.375M × 8% = $30K (75-100% tier)',
      '$0.3M × 10% = $30K (100-125% tier)'
    ],
    totalCommission: 127500, // $127.5K
    totalComp: 212500 // $85K base + $127.5K commission
  };

  spiffs: {
    firstDeal: 5000, // $5K bonus for first deal
    quarterlyPresident sClub: 10000 // $10K bonus if top performer in quarter
  };

  claw back: {
    policy: 'Commission clawed back if customer churns within 12 months',
    example: 'If $500K deal churns in month 6, AE owes back 50% of commission'
  };
}
```

---

## Sales Metrics & KPIs

### Individual Metrics (Per AE)

```typescript
interface SalesKPIs {
  activity: {
    callsPerWeek: { target: 30; benchmark: '25-40' };
    emailsPerWeek: { target: 50; benchmark: '40-60' };
    meetingsPerWeek: { target: 10; benchmark: '8-12' };
    connectionsPerWeek: { target: 15; benchmark: '10-20' }; // LinkedIn, cold calls → conversations
  };

  pipeline: {
    pipelineGenerated: { target: 4500000; benchmark: '3x quota' }; // $4.5M pipeline per AE
    opportunitiesCreated: { target: 50; benchmark: '40-60 per year' };
    avgDealSize: { target: 180000; benchmark: '$150K-250K' };
    pipelineVelocity: { target: 90; benchmark: '60-120 days' }; // Days from opp created → closed
  };

  conversion: {
    leadToOpp: { target: 0.2; benchmark: '15-25%' }; // 20% of leads become qualified opps
    oppToDemo: { target: 0.6; benchmark: '50-70%' }; // 60% of opps get a demo
    demoToProposal: { target: 0.5; benchmark: '40-60%' }; // 50% of demos → proposal sent
    proposalToClose: { target: 0.5; benchmark: '40-60%' }; // 50% of proposals → closed won
    overallWinRate: { target: 0.25; benchmark: '20-30%' }; // 25% of qualified opps → closed won
  };

  revenue: {
    newARR: { target: 1500000; benchmark: '$1.2M-1.8M per AE' };
    renewalRate: { target: 0.9; benchmark: '85-95%' }; // 90% of customers renew
    upsellRate: { target: 0.15; benchmark: '10-20%' }; // 15% of customers expand
  };
}
```

### Team Metrics (Entire Sales Org)

```typescript
interface TeamKPIs {
  revenue: {
    totalARR: { year1: 4500000; year2: 12000000; year3: 28000000 };
    netNewARR: { year1: 4500000; year2: 7500000; year3: 16000000 }; // Excludes renewals
    churnRate: { target: 0.1; benchmark: '<15%' }; // 10% annual churn
  };

  efficiency: {
    cac: { target: 15000; benchmark: '$10K-20K' }; // Customer Acquisition Cost
    ltv: { target: 450000; benchmark: '$300K-600K' }; // Lifetime Value (3 years × $150K avg deal)
    ltvCacRatio: { target: 30; benchmark: '20-40' }; // $450K LTV / $15K CAC = 30:1
    magicNumber: { target: 1.5; benchmark: '1.0-2.0' }; // Net new ARR / sales & marketing spend
  };

  pipeline: {
    totalPipeline: { target: 13500000; benchmark: '3x revenue target' }; // $13.5M for $4.5M target
    pipelineCoverage: { target: 3.0; benchmark: '2.5-4.0x' };
    avgSalesCycle: { target: 90; benchmark: '60-120 days' };
  };
}
```

---

## First Year Roadmap

### Q1 2026 (Months 1-3): Build Foundation

**Hiring**:

- Month 1: Hire VP of Sales (45-day search)
- Month 2: VP Sales starts, begins hiring AEs
- Month 3: Hire 2 Account Executives, 1 Channel Account Manager

**Systems**:

- Month 1: Implement Salesforce CRM
- Month 2: Create sales playbooks, call scripts, email templates
- Month 3: Develop pricing and packaging (tiered pricing, pilot offers)

**Demand Generation**:

- Month 1: Build target account list (500 insurance carriers, 1,000 large employers, 500 brokers)
- Month 2: Launch outbound campaigns (cold email, LinkedIn outreach)
- Month 3: First industry conference (LIMRA - booth + speaking slot)

**Metrics**:

- Pipeline created: $2M (early stage, mostly prospects)
- Closed deals: 0 (too early, sales cycles are 90 days)
- Budget: $100K (VP Sales 3 months salary + Salesforce + conference)

---

### Q2 2026 (Months 4-6): Ramp Sales Team

**Onboarding**:

- AEs complete product training (2 weeks: learn Fair Underwriting inside out)
- AEs shadow VP Sales on calls (2 weeks: watch how it's done)
- AEs run first demo (week 5), VP Sales provides feedback

**Activity**:

- Each AE: 30 calls/week, 50 emails/week, 10 meetings/week
- Total team activity: 120 calls/week, 200 emails/week, 40 meetings/week

**Pipeline**:

- Pipeline created: $4M (VP Sales + 2 AEs + Channel Mgr)
- Qualified opportunities: 20 (early stage)
- Demos conducted: 30

**Revenue**:

- Closed deals: 3-5 (first deals close in Month 5-6)
- ARR: $500K-800K
- Budget: $150K (3 AEs fully ramped + conferences)

---

### Q3 2026 (Months 7-9): Scale Pipeline

**Expansion**:

- Hire Sales Operations Manager (0.5 FTE) to support growing team
- Attend 2 major conferences (AHIP, NAIC)
- Launch broker partner program (recruit 25 brokers)

**Activity**:

- Team fully ramped, hitting activity targets
- Pipeline velocity improving (learning from first deals)
- Win/loss analysis: Why did we win/lose? Adjust playbooks accordingly

**Pipeline**:

- Pipeline created: $5M (cumulative $11M total pipeline)
- Qualified opportunities: 40 (cumulative)
- Closed deals: 8-10 (cumulative 11-15 deals closed Year 1)

**Revenue**:

- Q3 ARR added: $1.5M
- Cumulative ARR: $2M-2.3M
- Budget: $200K

---

### Q4 2026 (Months 10-12): Finish Strong

**Goals**:

- Hit $4.5M ARR target (accelerate deal closures)
- Recruit 50 broker partners (generate 2027 pipeline)
- Plan 2027 expansion (hire 2 more AEs, expand to enterprise segment)

**Activity**:

- End-of-year push: Close deals before budgets reset in January
- Customer success: Ensure Q4 deals are successful (avoid churn in 2027)
- Planning: Set 2027 quotas, territories, compensation plans

**Revenue**:

- Q4 ARR added: $2.2M-2.5M (largest quarter, end-of-year budget flush)
- Cumulative ARR: $4.5M (target achieved!)
- Budget: $250K

---

## Budget & Financial Model

### Year 1 Budget

| Item                             | Q1        | Q2        | Q3        | Q4        | Total Year 1 |
| -------------------------------- | --------- | --------- | --------- | --------- | ------------ |
| **Salaries**                     |           |           |           |           |              |
| VP Sales ($150K base)            | $37.5K    | $37.5K    | $37.5K    | $37.5K    | $150K        |
| 2 Account Executives ($85K each) | $21K      | $42.5K    | $42.5K    | $42.5K    | $148.5K      |
| 1 Channel Mgr ($75K)             | $9.4K     | $18.8K    | $18.8K    | $18.8K    | $65.8K       |
| Sales Ops Mgr 0.5 FTE ($45K)     | $0        | $0        | $11.3K    | $11.3K    | $22.6K       |
| **Commissions**                  |           |           |           |           |              |
| VP Sales commission              | $0        | $20K      | $60K      | $100K     | $180K        |
| AE commissions                   | $0        | $30K      | $70K      | $120K     | $220K        |
| Channel Mgr commission           | $0        | $10K      | $25K      | $45K      | $80K         |
| **Software & Tools**             |           |           |           |           |              |
| Salesforce CRM                   | $6.3K     | $6.3K     | $6.3K     | $6.3K     | $25K         |
| LinkedIn Sales Navigator         | $1K       | $1K       | $1K       | $1K       | $4K          |
| ZoomInfo (contact data)          | $1.5K     | $1.5K     | $1.5K     | $1.5K     | $6K          |
| DocuSign                         | $0.5K     | $0.5K     | $0.5K     | $0.5K     | $2K          |
| **Events & Conferences**         |           |           |           |           |              |
| LIMRA Conference                 | $15K      | $0        | $0        | $0        | $15K         |
| AHIP Conference                  | $0        | $0        | $20K      | $0        | $20K         |
| NAIC Conference                  | $0        | $0        | $15K      | $0        | $15K         |
| Regional events                  | $3K       | $5K       | $5K       | $7K       | $20K         |
| **Other**                        |           |           |           |           |              |
| Travel & entertainment           | $5K       | $8K       | $10K      | $12K      | $35K         |
| Sales training                   | $5K       | $5K       | $0        | $0        | $10K         |
| Marketing collateral             | $3K       | $2K       | $2K       | $3K       | $10K         |
| **Total per Quarter**            | **$108K** | **$188K** | **$325K** | **$406K** | **$1,027K**  |

**Total Year 1 Budget**: ~$1,030,000 (round to **$1,000,000**)

### Revenue Impact

```typescript
interface Year1FinancialImpact {
  investment: 1000000; // $1M sales & marketing spend Year 1

  revenue: {
    newARR: 4500000; // $4.5M ARR from 25 deals
    breakdown: {
      directSales: 3300000; // 18 deals × $183K avg (VP Sales + 2 AEs)
      channelSales: 1200000; // 7 deals × $171K avg (50 brokers × 14% active × 1 deal each)
    };
  };

  profitability: {
    grossMargin: 0.75; // 75% gross margin (software business)
    grossProfit: 3375000; // $4.5M × 75% = $3.375M
    netProfit: 2375000; // $3.375M - $1M sales cost = $2.375M
    roi: 2.38; // $2.375M profit / $1M investment = 238% ROI
  };

  customerMetrics: {
    customersAcquired: 25;
    avgDealSize: 180000; // $180K ARR
    cac: 40000; // $1M / 25 customers = $40K CAC
    ltv: 450000; // $180K × 3 years × 83% retention = $450K LTV
    ltvCacRatio: 11.25; // $450K / $40K = 11.25:1 (healthy)
  };
}
```

---

## Success Metrics

### Lagging Indicators (Results)

| Metric            | Q1 Target | Q2 Target | Q3 Target | Q4 Target | Year 1 Total |
| ----------------- | --------- | --------- | --------- | --------- | ------------ |
| **New ARR**       | $0        | $700K     | $1.5M     | $2.3M     | **$4.5M**    |
| **Customers**     | 0         | 4         | 8         | 13        | **25**       |
| **Avg Deal Size** | -         | $175K     | $188K     | $177K     | **$180K**    |
| **Win Rate**      | -         | 20%       | 23%       | 27%       | **25%**      |

### Leading Indicators (Activities)

| Metric               | Q1 Target | Q2 Target | Q3 Target | Q4 Target           |
| -------------------- | --------- | --------- | --------- | ------------------- |
| **Pipeline Created** | $2M       | $4M       | $5M       | $2.5M (maintaining) |
| **Qualified Opps**   | 10        | 20        | 25        | 30                  |
| **Demos Conducted**  | 15        | 30        | 40        | 50                  |
| **Proposals Sent**   | 5         | 15        | 20        | 25                  |
| **Broker Partners**  | 0         | 10        | 25        | 50                  |

---

## Risks & Mitigation

### Risk 1: VP Sales Hire Takes Too Long

**Impact**: 3-month delay = $1M lost ARR (Q4 deals push to Q1 2027)

**Mitigation**:

- Start search in Month -2 (before launch)
- Use executive recruiter ($30K fee, but faster)
- CEO acts as interim VP Sales if needed

---

### Risk 2: Long Sales Cycles (>120 days)

**Impact**: Revenue target missed, cash burn increases

**Mitigation**:

- Offer pilots (3-month, $50K) to shorten decision time
- Target mid-market (faster buyers) in addition to enterprise
- Improve sales enablement (better demos = faster closes)

---

### Risk 3: Competition from 23andMe, Color Health

**Impact**: Lower win rates, price pressure

**Mitigation**:

- Emphasize privacy moat (patent protection, insurance-safe testing)
- Build case studies and customer testimonials
- Offer ROI guarantee ("If you don't save $10M in 3 years, we refund your money")

---

### Risk 4: Broker Channel Doesn't Scale

**Impact**: Miss $1.2M broker-sourced revenue

**Mitigation**:

- Increase referral fees ($500 → $1,000 per customer)
- Co-marketing campaigns (Fair Underwriting sponsors broker conferences)
- Exclusive territories (top brokers get exclusivity in their region)

---

## Conclusion

**Sales team is Critical Launch Blocker**. Fair Underwriting has world-class product but zero revenue without sales.

**Investment**: $1M Year 1 (VP Sales + 2 AEs + Channel Mgr + tools + conferences)

**Return**: $4.5M ARR Year 1 → $2.375M net profit → **238% ROI**

**Next Steps**:

1. Approve $1M sales budget
2. Hire VP of Sales (Month 1)
3. Implement Salesforce CRM (Month 1)
4. Build target account list (Month 1)
5. Launch outbound campaigns (Month 2)

---

**Document Status**: Complete
**Last Updated**: November 8, 2025
**Owner**: CEO + VP Sales (TBD)
**Review Frequency**: Monthly (sales metrics review)
