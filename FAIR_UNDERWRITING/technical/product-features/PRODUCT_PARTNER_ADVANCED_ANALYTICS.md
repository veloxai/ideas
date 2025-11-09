# Feature #26: Advanced Analytics & Business Intelligence

**Category**: Business Operations - Data & Insights
**Priority**: Phase 2 (Year 1 - Strategic Decision-Making)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 data engineer, 1 analytics engineer, 0.5 FTE business analyst

---

## Executive Summary

Fair Underwriting currently has **limited business analytics** beyond basic operational metrics. While patient-facing reports exist (Feature #18: Longitudinal Reporting) and research dashboards exist (Feature #21: Research Platform), **there is no executive-level business intelligence** for strategic decision-making.

**Current Analytics Gaps**:

- ✅ Patient longitudinal reports (Feature #18)
- ✅ Research dashboards (Feature #21A5)
- ✅ API analytics endpoints (`/api/analytics/*`)
- ❌ No executive KPI dashboards
- ❌ No predictive analytics (churn, demand forecasting)
- ❌ No cohort analysis
- ❌ No marketing attribution
- ❌ No financial forecasting

**Business Impact**:

- **Blind spots**: Leadership making decisions without data (e.g., "Should we hire more genetic counselors?" → no capacity data)
- **Reactive vs. proactive**: Discover problems after they happen (e.g., high churn in MZ cohort)
- **Missed opportunities**: Don't know which marketing channels drive best ROI
- **Inefficiency**: Manual Excel reports instead of real-time dashboards

---

## Problem Scenarios

### Scenario 1: Genetic Counselor Capacity Crisis

> **Situation**: Fair Underwriting experiences 3x growth in test volume over 6 months. Genetic counseling wait times increase from 2 days → 14 days. Customer satisfaction scores drop. CEO asks: "How many genetic counselors do we need to hire?"
>
> **Current State**: No data on:
>
> - Genetic counselor utilization rates (are they at 80% capacity or 120%?)
> - Average session duration (has it changed over time?)
> - Demand trends (is growth linear, seasonal, or exponential?)
> - Counselor productivity (sessions per week, cancellation rates)
>
> **Impact**: Leadership guesses, hires 3 counselors. 2 months later, counselors are idle (over-hired). Wasted $200K in salaries.

**Solution**: **Workforce Analytics Dashboard** showing real-time counselor utilization, demand forecasting (predict 90 days ahead), optimal staffing recommendations.

### Scenario 2: High MZ Carrier Churn Mystery

> **Situation**: CFO notices 40% of MZ carriers cancel subscriptions within 6 months. No one knows why. Product team debates:
>
> - "Maybe they don't understand MZ risk?"
> - "Maybe genetic counseling wasn't helpful?"
> - "Maybe our educational content sucks?"
>
> **Current State**: No churn analysis tools. Can't answer:
>
> - Which cohorts churn most (MZ vs. ZZ vs. MM)?
> - When do they churn (after 1 month, 3 months, 6 months)?
> - What's the last action before churn (stopped logging in, skipped counseling, never downloaded app)?
> - What predicts churn (engagement score, counseling satisfaction, genotype)?
>
> **Impact**: Team wastes 3 months building wrong solutions. Churn stays high.

**Solution**: **Churn Prediction Model** + **Cohort Retention Dashboard** identifying at-risk customers, actionable interventions (e.g., "Send re-engagement email to MZ carriers who haven't logged in 30 days").

### Scenario 3: Marketing Budget Black Hole

> **Situation**: Fair Underwriting spends $500K/year on marketing across 10 channels (Google Ads, Facebook, content marketing, partnerships). CMO asks: "Which channels drive the best ROI?"
>
> **Current State**: No attribution model. Tracking basic metrics:
>
> - Google Ads: 50,000 clicks, $200K spend
> - Facebook: 100,000 impressions, $150K spend
> - But no idea which channel drives **paying customers** and **high lifetime value**.
>
> **Impact**: Continue spending $150K on Facebook ads that drive low-quality leads (high bounce rate, low conversion). Meanwhile, underfund content marketing that drives high-intent customers.

**Solution**: **Marketing Attribution Dashboard** with multi-touch attribution, customer acquisition cost (CAC) by channel, lifetime value (LTV) by channel, ROI analysis.

### Scenario 4: Insurance Payer Negotiations Without Data

> **Situation**: Fair Underwriting negotiates contract renewal with Anthem (largest payer, 30% of revenue). Anthem says: "Your genetic testing isn't cost-effective. We're cutting reimbursement from $450 → $300."
>
> **Fair Underwriting's Response**: "Actually, early AATD diagnosis saves you money!"
>
> **Anthem**: "Prove it."
>
> **Current State**: No data on:
>
> - Cost savings from early diagnosis (how much does Anthem save when ZZ patient starts augmentation therapy early?)
> - Downstream healthcare utilization (do diagnosed patients use less ER, fewer hospitalizations?)
> - Clinical outcomes (lung function improvement, quality of life)
>
> **Impact**: Can't negotiate effectively. Anthem cuts reimbursement. Revenue drops 20%.

**Solution**: **Payer Dashboard** showing cost savings per patient, ROI calculation, clinical outcomes data, ready for value-based care contracts.

### Scenario 5: Lab Partner SLA Violations Undetected

> **Situation**: Lab partner (LabCorp) is contractually obligated to deliver results within 10 business days. Over 3 months, average turnaround increases to 14 days (40% SLA violation). No one notices until customer complaints spike.
>
> **Current State**: Lab turnaround time tracked manually in spreadsheet, reviewed quarterly. No alerts.
>
> **Impact**: 500 customers wait extra 4 days for results. Customer satisfaction drops. LabCorp owes $50K in SLA penalties, but Fair Underwriting doesn't invoice them (didn't catch violation in time).

**Solution**: **Operational Dashboard** with real-time SLA monitoring, automated alerts when metrics degrade, trend analysis to catch problems early.

---

## Technical Specifications

### 1. Executive KPI Dashboard

```typescript
interface ExecutiveKPIDashboard {
  // Revenue metrics
  revenue: {
    mrr: number; // Monthly Recurring Revenue
    mrrGrowth: number; // % month-over-month
    arr: number; // Annual Recurring Revenue

    revenueBySource: {
      b2c_tests: number; // Direct consumer genetic tests
      b2b_employer: number; // Corporate wellness programs
      research_partnerships: number; // Pharma collaborations
      clinical_trials: number; // Trial recruitment fees
    };

    revenueByPayer: {
      commercial_insurance: number;
      medicare: number;
      medicaid: number;
      self_pay: number;
    };

    // Forecasting
    projectedMRRIn90Days: number;
    confidenceInterval: [number, number]; // 95% CI
  };

  // Customer metrics
  customers: {
    total: number;
    active: number; // Logged in past 30 days
    newThisMonth: number;
    churnedThisMonth: number;
    churnRate: number; // %

    byGenotype: {
      zz: number;
      sz: number;
      mz: number;
      mm: number;
      ms: number;
      ss: number;
    };

    // Customer Acquisition
    cac: number; // Customer Acquisition Cost
    cacByChannel: { [channel: string]: number };
    ltv: number; // Lifetime Value
    ltvCacRatio: number; // Should be >3
  };

  // Operational metrics
  operations: {
    tests: {
      ordered: number;
      completed: number;
      avgTurnaroundDays: number;
      targetTurnaroundDays: number;
      slaBreach: boolean;
    };

    geneticCounseling: {
      sessionsCompleted: number;
      avgWaitTimeDays: number;
      targetWaitTimeDays: number;
      utilizationRate: number; // % of counselor capacity used
      satisfactionScore: number; // 1-5
    };

    support: {
      ticketsOpen: number;
      avgResponseTimeHours: number;
      targetResponseTimeHours: number;
      firstContactResolutionRate: number; // %
      csat: number; // Customer Satisfaction Score
    };
  };

  // Financial health
  financial: {
    cashBalance: number;
    burnRate: number; // $ per month
    monthsOfRunway: number;

    grossMargin: number; // %
    contributionMargin: number; // % (revenue - variable costs)

    costPerTest: number; // Lab costs + operational overhead
    reimbursementPerTest: number; // Average from payers
    profitPerTest: number;
  };

  // Strategic metrics
  strategic: {
    marketPenetration: number; // % of estimated AATD population diagnosed
    nps: number; // Net Promoter Score
    brandAwareness: number; // % (from surveys)
    partnerCount: number; // Insurance brokers, employers, pharma
  };
}

class ExecutiveDashboardService {
  async generateDashboard(
    dateRange: DateRange
  ): Promise<ExecutiveKPIDashboard> {
    // Aggregate data from multiple sources
    const [revenue, customers, operations, financial, strategic] =
      await Promise.all([
        this.getRevenueMetrics(dateRange),
        this.getCustomerMetrics(dateRange),
        this.getOperationalMetrics(dateRange),
        this.getFinancialMetrics(dateRange),
        this.getStrategicMetrics(dateRange)
      ]);

    return {
      revenue,
      customers,
      operations,
      financial,
      strategic
    };
  }

  private async getRevenueMetrics(dateRange: DateRange) {
    // Query billing database
    const subscriptions = await db
      .selectFrom('subscriptions')
      .select([
        db.fn.sum('amount').as('mrr'),
        db.fn.count('id').as('active_subscriptions')
      ])
      .where('status', '=', 'active')
      .executeTakeFirst();

    // Revenue by source
    const revenueBySource = await db
      .selectFrom('invoices')
      .select([
        'metadata->revenue_source as source',
        db.fn.sum('total').as('revenue')
      ])
      .where('paid_at', '>=', dateRange.start)
      .where('paid_at', '<=', dateRange.end)
      .groupBy('source')
      .execute();

    // Forecasting (simple linear regression for now)
    const historicalMRR = await this.getHistoricalMRR(90); // Last 90 days
    const projectedMRR = this.forecastMRR(historicalMRR, 90);

    return {
      mrr: Number(subscriptions?.mrr || 0),
      mrrGrowth: this.calculateGrowthRate(historicalMRR),
      arr: Number(subscriptions?.mrr || 0) * 12,
      revenueBySource: this.parseRevenueBySource(revenueBySource),
      projectedMRRIn90Days: projectedMRR.point_estimate,
      confidenceInterval: projectedMRR.confidence_interval
    };
  }

  private forecastMRR(
    historicalData: number[],
    daysAhead: number
  ): ForecastResult {
    // Linear regression: y = mx + b
    const n = historicalData.length;
    const x = Array.from({ length: n }, (_, i) => i);
    const y = historicalData;

    const sumX = x.reduce((a, b) => a + b, 0);
    const sumY = y.reduce((a, b) => a + b, 0);
    const sumXY = x.reduce((sum, xi, i) => sum + xi * y[i], 0);
    const sumX2 = x.reduce((sum, xi) => sum + xi * xi, 0);

    const slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    const intercept = (sumY - slope * sumX) / n;

    const predicted = slope * (n + daysAhead) + intercept;

    // Calculate standard error for confidence interval
    const predictions = x.map((xi) => slope * xi + intercept);
    const residuals = y.map((yi, i) => yi - predictions[i]);
    const sse = residuals.reduce((sum, r) => sum + r * r, 0);
    const mse = sse / (n - 2);
    const se = Math.sqrt(mse);

    // 95% confidence interval (z = 1.96)
    const margin =
      1.96 * se * Math.sqrt(1 + 1 / n + Math.pow(daysAhead, 2) / sumX2);

    return {
      point_estimate: predicted,
      confidence_interval: [predicted - margin, predicted + margin]
    };
  }
}
```

### 2. Churn Prediction Model

```typescript
interface ChurnPrediction {
  customerId: string;
  churnProbability: number; // 0-1
  riskLevel: 'low' | 'medium' | 'high' | 'critical';

  // Features influencing prediction
  factors: {
    daysSinceLastLogin: number;
    geneticCounselingAttended: boolean;
    appDownloaded: boolean;
    emailEngagement: number; // Open rate
    supportTickets: number;
    genotype: string;
    monthsSinceSignup: number;
  };

  // Recommended interventions
  interventions: {
    type:
      | 'email'
      | 'sms'
      | 'phone_call'
      | 'discount_offer'
      | 'genetic_counseling';
    message: string;
    priority: number;
    expectedImpact: number; // % reduction in churn probability
  }[];

  predictedChurnDate?: Date; // When we expect them to churn
}

class ChurnPredictionService {
  // Train model on historical data
  async trainModel(): Promise<ChurnModel> {
    // Get historical customer data
    const customers = await db
      .selectFrom('customers')
      .leftJoin('subscriptions', 'customers.id', 'subscriptions.customer_id')
      .leftJoin(
        'genetic_counseling_sessions',
        'customers.id',
        'genetic_counseling_sessions.customer_id'
      )
      .leftJoin(
        'user_activity_logs',
        'customers.id',
        'user_activity_logs.customer_id'
      )
      .select([
        'customers.id',
        'customers.genotype',
        'customers.created_at',
        'subscriptions.status',
        'subscriptions.cancelled_at',
        db.fn.count('genetic_counseling_sessions.id').as('counseling_sessions'),
        db.fn.max('user_activity_logs.timestamp').as('last_activity')
      ])
      .groupBy('customers.id')
      .execute();

    // Feature engineering
    const features = customers.map((c) => ({
      daysSinceSignup: daysBetween(c.created_at, new Date()),
      daysSinceLastActivity: c.last_activity
        ? daysBetween(c.last_activity, new Date())
        : 999,
      counselingSessions: Number(c.counseling_sessions),
      genotype: c.genotype,
      churned: c.status === 'cancelled'
    }));

    // Train random forest classifier (using ml.js or similar)
    const X = features.map((f) => [
      f.daysSinceSignup,
      f.daysSinceLastActivity,
      f.counselingSessions,
      this.encodeGenotype(f.genotype)
    ]);
    const y = features.map((f) => (f.churned ? 1 : 0));

    const model = new RandomForestClassifier({
      nEstimators: 100,
      maxDepth: 10,
      minSamplesSplit: 10
    });

    await model.train(X, y);

    return model;
  }

  async predictChurn(customerId: string): Promise<ChurnPrediction> {
    // Get customer features
    const customer = await this.getCustomerFeatures(customerId);

    // Load trained model
    const model = await this.loadModel();

    // Predict churn probability
    const X = [
      customer.daysSinceSignup,
      customer.daysSinceLastLogin,
      customer.counselingSessions,
      this.encodeGenotype(customer.genotype)
    ];

    const churnProb = model.predict(X)[0];

    // Risk level
    let riskLevel: 'low' | 'medium' | 'high' | 'critical';
    if (churnProb < 0.2) riskLevel = 'low';
    else if (churnProb < 0.5) riskLevel = 'medium';
    else if (churnProb < 0.8) riskLevel = 'high';
    else riskLevel = 'critical';

    // Recommend interventions
    const interventions = this.recommendInterventions(customer, churnProb);

    return {
      customerId,
      churnProbability: churnProb,
      riskLevel,
      factors: {
        daysSinceLastLogin: customer.daysSinceLastLogin,
        geneticCounselingAttended: customer.counselingSessions > 0,
        appDownloaded: customer.appDownloaded,
        emailEngagement: customer.emailOpenRate,
        supportTickets: customer.supportTickets,
        genotype: customer.genotype,
        monthsSinceSignup: Math.floor(customer.daysSinceSignup / 30)
      },
      interventions,
      predictedChurnDate:
        churnProb > 0.5
          ? this.estimateChurnDate(customer, churnProb)
          : undefined
    };
  }

  private recommendInterventions(customer: any, churnProb: number): any[] {
    const interventions = [];

    // High-risk customer, no genetic counseling → offer free session
    if (churnProb > 0.6 && customer.counselingSessions === 0) {
      interventions.push({
        type: 'genetic_counseling',
        message:
          'Offer complimentary genetic counseling session to increase engagement',
        priority: 1,
        expectedImpact: 0.25 // 25% reduction in churn probability
      });
    }

    // Inactive user → re-engagement email
    if (customer.daysSinceLastLogin > 30) {
      interventions.push({
        type: 'email',
        message:
          'Send "We miss you" re-engagement email with personalized health tips',
        priority: 2,
        expectedImpact: 0.15
      });
    }

    // MZ carrier, no app → push app download
    if (customer.genotype === 'MZ' && !customer.appDownloaded) {
      interventions.push({
        type: 'email',
        message:
          'Send mobile app download email highlighting push notifications for health alerts',
        priority: 3,
        expectedImpact: 0.1
      });
    }

    // Critical risk → personal phone call
    if (churnProb > 0.8) {
      interventions.push({
        type: 'phone_call',
        message:
          'High-risk customer: Assign to customer success manager for personal outreach',
        priority: 1,
        expectedImpact: 0.3
      });
    }

    return interventions.sort((a, b) => b.expectedImpact - a.expectedImpact);
  }
}
```

### 3. Cohort Analysis Dashboard

```typescript
interface CohortAnalysis {
  cohortId: string;
  cohortName: string; // "January 2025 Signups", "MZ Carriers", "Self-Pay Customers"
  cohortSize: number;

  // Retention by month
  retention: {
    month: number; // 0 = signup month, 1 = 1st month, 2 = 2nd month, etc.
    customersActive: number;
    retentionRate: number; // %
    churnedThisMonth: number;
  }[];

  // Engagement metrics
  engagement: {
    avgSessionsPerMonth: number;
    avgTimeOnPlatformMinutes: number;
    featureUsage: {
      viewedResults: number; // % who viewed test results
      attendedCounseling: number; // % who attended genetic counseling
      downloadedApp: number;
      sharedResults: number;
    };
  };

  // Financial metrics
  financial: {
    avgRevenuePerCustomer: number;
    totalRevenue: number;
    cac: number; // Customer Acquisition Cost for this cohort
    ltv: number; // Lifetime Value
    ltvCacRatio: number;
    monthsToPayback: number; // How many months to recover CAC
  };

  // Comparison to other cohorts
  benchmark: {
    cohortPerformance: 'above_average' | 'average' | 'below_average';
    retentionVsAverage: number; // Percentage points above/below average
    ltvVsAverage: number;
  };
}

class CohortAnalysisService {
  async analyzeCohort(
    cohortDefinition: CohortDefinition
  ): Promise<CohortAnalysis> {
    // Get customers in cohort
    const customers = await this.getCustomersInCohort(cohortDefinition);

    // Calculate retention by month
    const retention = await this.calculateRetention(customers);

    // Calculate engagement
    const engagement = await this.calculateEngagement(customers);

    // Calculate financial metrics
    const financial = await this.calculateFinancialMetrics(customers);

    // Benchmark against other cohorts
    const benchmark = await this.benchmarkCohort(
      cohortDefinition,
      retention,
      financial
    );

    return {
      cohortId: cohortDefinition.id,
      cohortName: cohortDefinition.name,
      cohortSize: customers.length,
      retention,
      engagement,
      financial,
      benchmark
    };
  }

  async calculateRetention(customers: Customer[]): Promise<any[]> {
    const retention = [];

    for (let month = 0; month <= 12; month++) {
      const activeCustomers = customers.filter((c) => {
        const monthsSinceSignup = daysBetween(c.createdAt, new Date()) / 30;
        const stillActive =
          !c.cancelledAt ||
          daysBetween(c.createdAt, c.cancelledAt) / 30 > month;
        return monthsSinceSignup >= month && stillActive;
      });

      const churnedThisMonth = customers.filter((c) => {
        if (!c.cancelledAt) return false;
        const churnMonth = Math.floor(
          daysBetween(c.createdAt, c.cancelledAt) / 30
        );
        return churnMonth === month;
      });

      retention.push({
        month,
        customersActive: activeCustomers.length,
        retentionRate: (activeCustomers.length / customers.length) * 100,
        churnedThisMonth: churnedThisMonth.length
      });
    }

    return retention;
  }

  async generateCohortReport(
    startDate: Date,
    endDate: Date
  ): Promise<CohortReport> {
    // Pre-defined cohorts
    const cohorts = [
      { id: 'all', name: 'All Customers', filter: () => true },
      {
        id: 'zz',
        name: 'ZZ Genotype',
        filter: (c: Customer) => c.genotype === 'ZZ'
      },
      {
        id: 'mz',
        name: 'MZ Genotype',
        filter: (c: Customer) => c.genotype === 'MZ'
      },
      {
        id: 'self_pay',
        name: 'Self-Pay',
        filter: (c: Customer) => c.paymentMethod === 'self_pay'
      },
      {
        id: 'insured',
        name: 'Insured',
        filter: (c: Customer) => c.hasInsurance
      }
    ];

    const analyses = await Promise.all(
      cohorts.map((c) => this.analyzeCohort(c))
    );

    return {
      reportDate: new Date(),
      dateRange: { start: startDate, end: endDate },
      cohorts: analyses,
      insights: this.generateInsights(analyses)
    };
  }

  private generateInsights(cohorts: CohortAnalysis[]): string[] {
    const insights = [];

    // Find best and worst performing cohorts
    const sortedByLTV = [...cohorts].sort(
      (a, b) => b.financial.ltv - a.financial.ltv
    );
    const best = sortedByLTV[0];
    const worst = sortedByLTV[sortedByLTV.length - 1];

    insights.push(
      `Best performing cohort: ${best.cohortName} (LTV: $${best.financial.ltv}, Retention: ${best.retention[6].retentionRate.toFixed(1)}% at 6 months)`
    );

    insights.push(
      `Worst performing cohort: ${worst.cohortName} (LTV: $${worst.financial.ltv}, Retention: ${worst.retention[6].retentionRate.toFixed(1)}% at 6 months)`
    );

    // Find cohorts with high churn
    const highChurn = cohorts.filter((c) => c.retention[3].retentionRate < 50);
    if (highChurn.length > 0) {
      insights.push(
        `⚠️ High churn alert: ${highChurn.map((c) => c.cohortName).join(', ')} have <50% retention at 3 months`
      );
    }

    return insights;
  }
}
```

### 4. Marketing Attribution Dashboard

```typescript
interface MarketingAttribution {
  // Channel performance
  channels: {
    name: string; // 'google_ads', 'facebook', 'content_marketing', 'partnerships'
    spend: number;
    impressions: number;
    clicks: number;
    conversions: number; // Customers acquired
    cac: number; // Customer Acquisition Cost
    ltv: number; // Lifetime Value of customers from this channel
    roi: number; // (LTV - CAC) / CAC
    conversionRate: number; // %
  }[];

  // Attribution model
  attributionModel:
    | 'first_touch'
    | 'last_touch'
    | 'linear'
    | 'time_decay'
    | 'position_based';

  // Customer journey insights
  touchpointAnalysis: {
    avgTouchpointsToConversion: number;
    mostCommonFirstTouch: string; // e.g., "Google search"
    mostCommonLastTouch: string; // e.g., "Email campaign"
    avgDaysToConversion: number;

    // Multi-touch paths
    topPaths: {
      path: string[]; // e.g., ['google_ads', 'website', 'email', 'conversion']
      count: number;
      conversionRate: number;
      avgLTV: number;
    }[];
  };

  // Campaign performance
  campaigns: {
    id: string;
    name: string;
    channel: string;
    spend: number;
    conversions: number;
    cac: number;
    roi: number;
    status: 'active' | 'paused' | 'completed';
  }[];

  // Recommendations
  recommendations: {
    type:
      | 'increase_spend'
      | 'decrease_spend'
      | 'pause_campaign'
      | 'test_new_creative';
    channel: string;
    reason: string;
    expectedImpact: string;
  }[];
}

class MarketingAttributionService {
  async generateAttributionReport(
    dateRange: DateRange
  ): Promise<MarketingAttribution> {
    // Get all customers acquired in date range
    const customers = await db
      .selectFrom('customers')
      .leftJoin('subscriptions', 'customers.id', 'subscriptions.customer_id')
      .select([
        'customers.id',
        'customers.created_at',
        'customers.acquisition_channel',
        'customers.utm_source',
        'customers.utm_medium',
        'customers.utm_campaign',
        db.fn.sum('subscriptions.amount').as('ltv')
      ])
      .where('customers.created_at', '>=', dateRange.start)
      .where('customers.created_at', '<=', dateRange.end)
      .groupBy('customers.id')
      .execute();

    // Get marketing spend by channel
    const spend = await db
      .selectFrom('marketing_spend')
      .select(['channel', db.fn.sum('amount').as('total_spend')])
      .where('date', '>=', dateRange.start)
      .where('date', '<=', dateRange.end)
      .groupBy('channel')
      .execute();

    // Calculate channel performance
    const channels = this.calculateChannelPerformance(customers, spend);

    // Analyze customer journeys (multi-touch attribution)
    const touchpointAnalysis = await this.analyzeCustomerJourneys(customers);

    // Get campaign performance
    const campaigns = await this.getCampaignPerformance(dateRange);

    // Generate recommendations
    const recommendations = this.generateRecommendations(channels, campaigns);

    return {
      channels,
      attributionModel: 'time_decay', // Weight recent touchpoints more
      touchpointAnalysis,
      campaigns,
      recommendations
    };
  }

  private calculateChannelPerformance(customers: any[], spend: any[]): any[] {
    const channelGroups = this.groupBy(customers, 'acquisition_channel');

    return Object.entries(channelGroups).map(([channel, customers]) => {
      const channelSpend =
        spend.find((s) => s.channel === channel)?.total_spend || 0;
      const conversions = customers.length;
      const totalLTV = customers.reduce(
        (sum, c) => sum + Number(c.ltv || 0),
        0
      );
      const avgLTV = totalLTV / conversions;
      const cac = channelSpend / conversions;
      const roi = ((avgLTV - cac) / cac) * 100;

      return {
        name: channel,
        spend: channelSpend,
        impressions: 0, // TODO: Get from ad platforms
        clicks: 0,
        conversions,
        cac,
        ltv: avgLTV,
        roi,
        conversionRate: 0 // TODO: clicks to conversions
      };
    });
  }

  private async analyzeCustomerJourneys(customers: Customer[]): Promise<any> {
    // Get touchpoints for each customer
    const journeys = await Promise.all(
      customers.map((c) => this.getCustomerTouchpoints(c.id))
    );

    // Calculate average touchpoints
    const avgTouchpoints =
      journeys.reduce((sum, j) => sum + j.length, 0) / journeys.length;

    // Find most common first and last touch
    const firstTouches = journeys.map((j) => j[0]?.source);
    const lastTouches = journeys.map((j) => j[j.length - 1]?.source);

    const mostCommonFirst = this.mode(firstTouches);
    const mostCommonLast = this.mode(lastTouches);

    // Calculate average time to conversion
    const conversionTimes = journeys.map((j) => {
      const first = j[0]?.timestamp;
      const last = j[j.length - 1]?.timestamp;
      return first && last ? daysBetween(first, last) : 0;
    });
    const avgDaysToConversion =
      conversionTimes.reduce((a, b) => a + b, 0) / conversionTimes.length;

    // Find top conversion paths
    const paths = journeys.map((j) => j.map((t) => t.source).join(' → '));
    const pathCounts = this.countOccurrences(paths);
    const topPaths = Object.entries(pathCounts)
      .sort(([, a], [, b]) => b - a)
      .slice(0, 10)
      .map(([path, count]) => ({
        path: path.split(' → '),
        count,
        conversionRate: (count / journeys.length) * 100,
        avgLTV: this.getAvgLTVForPath(path, customers)
      }));

    return {
      avgTouchpointsToConversion: avgTouchpoints,
      mostCommonFirstTouch: mostCommonFirst,
      mostCommonLastTouch: mostCommonLast,
      avgDaysToConversion,
      topPaths
    };
  }

  private generateRecommendations(channels: any[], campaigns: any[]): any[] {
    const recommendations = [];

    // High ROI channels → increase spend
    channels
      .filter((c) => c.roi > 300)
      .forEach((c) => {
        recommendations.push({
          type: 'increase_spend',
          channel: c.name,
          reason: `High ROI (${c.roi.toFixed(0)}%). Each $1 spent returns $${(c.roi / 100 + 1).toFixed(2)}.`,
          expectedImpact: `+20% spend → +${(c.conversions * 0.2).toFixed(0)} customers`
        });
      });

    // Negative ROI channels → pause
    channels
      .filter((c) => c.roi < 0)
      .forEach((c) => {
        recommendations.push({
          type: 'pause_campaign',
          channel: c.name,
          reason: `Negative ROI (${c.roi.toFixed(0)}%). Losing money on this channel.`,
          expectedImpact: `Save $${c.spend.toFixed(0)} per month`
        });
      });

    // Low conversion rate → test new creative
    channels
      .filter((c) => c.conversionRate < 1)
      .forEach((c) => {
        recommendations.push({
          type: 'test_new_creative',
          channel: c.name,
          reason: `Low conversion rate (${c.conversionRate.toFixed(2)}%). May need better targeting or messaging.`,
          expectedImpact: `Improve conversion 1% → 2% = double customers at same cost`
        });
      });

    return recommendations;
  }
}
```

### 5. Operational Monitoring Dashboard

```typescript
interface OperationalDashboard {
  // Lab partner performance
  labs: {
    partnerId: string;
    partnerName: string;

    // Turnaround time
    avgTurnaroundDays: number;
    targetTurnaroundDays: number;
    slaCompliance: number; // %
    slaBreach: boolean;

    // Quality metrics
    testAccuracy: number; // % (from proficiency testing)
    sampleRejectionRate: number; // % of samples rejected due to quality issues

    // Volume
    testsCompletedThisMonth: number;
    testsInProgress: number;

    // Trend (last 30 days)
    trend: 'improving' | 'stable' | 'degrading';
    trend_data: { date: Date; turnaround_days: number }[];
  }[];

  // Genetic counselor utilization
  counselors: {
    counselorId: string;
    counselorName: string;

    // Capacity
    sessionsThisWeek: number;
    maxSessionsPerWeek: number;
    utilizationRate: number; // %

    // Quality
    avgSessionDuration: number; // minutes
    targetSessionDuration: number;
    satisfactionScore: number; // 1-5

    // Availability
    nextAvailableSlot: Date;
    waitlistSize: number;
  }[];

  // Customer support
  support: {
    ticketsOpen: number;
    ticketsByPriority: {
      critical: number;
      high: number;
      medium: number;
      low: number;
    };

    avgResponseTimeHours: number;
    targetResponseTimeHours: number;

    avgResolutionTimeDays: number;
    firstContactResolutionRate: number; // %

    csat: number; // Customer Satisfaction Score (1-5)
    topIssues: { category: string; count: number }[];
  };

  // System health
  system: {
    uptime: number; // %
    apiLatency: { p50: number; p95: number; p99: number }; // milliseconds
    errorRate: number; // % of requests

    activeUsers: number; // Currently logged in
    peakConcurrentUsers: number; // Max today

    databaseConnections: number;
    maxDatabaseConnections: number;

    alerts: {
      severity: 'info' | 'warning' | 'error' | 'critical';
      message: string;
      timestamp: Date;
    }[];
  };

  // Alerts & notifications
  alerts: {
    id: string;
    type: 'sla_breach' | 'capacity_warning' | 'quality_issue' | 'system_error';
    severity: 'low' | 'medium' | 'high' | 'critical';
    message: string;
    affectedEntity: string; // Lab partner, counselor, system component
    timestamp: Date;
    acknowledged: boolean;
    resolvedAt?: Date;
  }[];
}

class OperationalDashboardService {
  async generateDashboard(): Promise<OperationalDashboard> {
    const [labs, counselors, support, system, alerts] = await Promise.all([
      this.getLabPerformance(),
      this.getCounselorUtilization(),
      this.getSupportMetrics(),
      this.getSystemHealth(),
      this.getActiveAlerts()
    ]);

    return { labs, counselors, support, system, alerts };
  }

  private async getLabPerformance(): Promise<any[]> {
    const labs = await db.selectFrom('lab_partners').selectAll().execute();

    return Promise.all(
      labs.map(async (lab) => {
        // Calculate turnaround time
        const tests = await db
          .selectFrom('test_orders')
          .select(['sent_to_lab_at', 'results_received_at'])
          .where('lab_partner_id', '=', lab.id)
          .where('results_received_at', 'is not', null)
          .where('sent_to_lab_at', '>=', sql`CURRENT_DATE - INTERVAL '30 days'`)
          .execute();

        const turnaroundTimes = tests.map((t) =>
          daysBetween(t.sent_to_lab_at!, t.results_received_at!)
        );

        const avgTurnaround =
          turnaroundTimes.reduce((a, b) => a + b, 0) / turnaroundTimes.length;
        const targetTurnaround = lab.sla_turnaround_days || 10;
        const slaCompliance =
          (turnaroundTimes.filter((t) => t <= targetTurnaround).length /
            turnaroundTimes.length) *
          100;

        // Detect trend
        const recentTests = tests.slice(-10);
        const recentAvg =
          recentTests.reduce(
            (sum, t) =>
              sum + daysBetween(t.sent_to_lab_at!, t.results_received_at!),
            0
          ) / recentTests.length;
        const olderTests = tests.slice(-30, -10);
        const olderAvg =
          olderTests.reduce(
            (sum, t) =>
              sum + daysBetween(t.sent_to_lab_at!, t.results_received_at!),
            0
          ) / olderTests.length;

        let trend: 'improving' | 'stable' | 'degrading';
        if (recentAvg < olderAvg - 1) trend = 'improving';
        else if (recentAvg > olderAvg + 1) trend = 'degrading';
        else trend = 'stable';

        return {
          partnerId: lab.id,
          partnerName: lab.name,
          avgTurnaroundDays: avgTurnaround,
          targetTurnaroundDays: targetTurnaround,
          slaCompliance,
          slaBreach: slaCompliance < 95,
          testAccuracy: 99.9, // From proficiency testing
          sampleRejectionRate: 0.5,
          testsCompletedThisMonth: tests.length,
          testsInProgress: await this.getTestsInProgress(lab.id),
          trend,
          trend_data: this.generateTrendData(tests)
        };
      })
    );
  }

  // Auto-alerting when metrics degrade
  async checkAlertsAndNotify(): Promise<void> {
    const dashboard = await this.generateDashboard();

    // Check for SLA breaches
    for (const lab of dashboard.labs) {
      if (
        lab.slaBreach &&
        !this.hasExistingAlert('sla_breach', lab.partnerId)
      ) {
        await this.createAlert({
          type: 'sla_breach',
          severity: 'high',
          message: `${lab.partnerName} SLA compliance dropped to ${lab.slaCompliance.toFixed(1)}% (target: ≥95%)`,
          affectedEntity: lab.partnerId
        });

        // Send notification to operations team
        await this.notifyOperationsTeam({
          subject: `SLA Breach: ${lab.partnerName}`,
          body: `Lab partner ${lab.partnerName} is not meeting SLA. Average turnaround: ${lab.avgTurnaroundDays.toFixed(1)} days (target: ${lab.targetTurnaroundDays} days).`
        });
      }
    }

    // Check counselor capacity
    for (const counselor of dashboard.counselors) {
      if (
        counselor.utilizationRate > 90 &&
        !this.hasExistingAlert('capacity_warning', counselor.counselorId)
      ) {
        await this.createAlert({
          type: 'capacity_warning',
          severity: 'medium',
          message: `${counselor.counselorName} at ${counselor.utilizationRate.toFixed(0)}% capacity. Consider hiring additional counselors.`,
          affectedEntity: counselor.counselorId
        });
      }
    }

    // Check system health
    if (dashboard.system.errorRate > 1) {
      // >1% error rate
      await this.createAlert({
        type: 'system_error',
        severity: 'critical',
        message: `High error rate: ${dashboard.system.errorRate.toFixed(2)}%. Investigate immediately.`,
        affectedEntity: 'api_server'
      });

      // Page on-call engineer
      await this.sendPagerDutyAlert({
        severity: 'critical',
        message: `API error rate: ${dashboard.system.errorRate.toFixed(2)}%`
      });
    }
  }
}
```

---

## Database Schema

```sql
-- Marketing touchpoints (for attribution)
CREATE TABLE marketing_touchpoints (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,

    -- Touchpoint details
    source VARCHAR(100), -- 'google_ads', 'facebook', 'email', 'direct'
    medium VARCHAR(100), -- 'cpc', 'social', 'email', 'organic'
    campaign VARCHAR(255),
    content VARCHAR(255),

    -- UTM parameters
    utm_source VARCHAR(255),
    utm_medium VARCHAR(255),
    utm_campaign VARCHAR(255),
    utm_term VARCHAR(255),
    utm_content VARCHAR(255),

    -- Referrer
    referrer_url TEXT,
    landing_page_url TEXT,

    -- Session
    session_id VARCHAR(255),
    timestamp TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Attribution
    is_first_touch BOOLEAN DEFAULT false,
    is_last_touch BOOLEAN DEFAULT false,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Marketing spend (for ROI calculation)
CREATE TABLE marketing_spend (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Channel
    channel VARCHAR(100) NOT NULL, -- 'google_ads', 'facebook', 'content_marketing'
    campaign_name VARCHAR(255),

    -- Spend
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',

    -- Date
    date DATE NOT NULL,

    -- Metrics
    impressions INTEGER,
    clicks INTEGER,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Churn predictions
CREATE TABLE churn_predictions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,

    -- Prediction
    churn_probability DECIMAL(5, 4) NOT NULL, -- 0.0000 to 1.0000
    risk_level VARCHAR(20) NOT NULL, -- 'low', 'medium', 'high', 'critical'

    -- Features (for model explainability)
    features JSONB NOT NULL,
    /*
    {
      "days_since_last_login": 45,
      "genetic_counseling_attended": false,
      "app_downloaded": false,
      "email_engagement": 0.10,
      "genotype": "MZ"
    }
    */

    -- Interventions recommended
    interventions JSONB,

    -- Outcome tracking
    intervention_sent BOOLEAN DEFAULT false,
    intervention_type VARCHAR(50),
    intervention_sent_at TIMESTAMPTZ,

    customer_churned BOOLEAN,
    churned_at TIMESTAMPTZ,

    -- Model version
    model_version VARCHAR(50) NOT NULL,

    predicted_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Cohorts (for cohort analysis)
CREATE TABLE cohorts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,

    -- Cohort definition (SQL-like filter)
    filter_criteria JSONB NOT NULL,
    /*
    {
      "genotype": "MZ",
      "signup_date_start": "2025-01-01",
      "signup_date_end": "2025-01-31"
    }
    */

    -- Membership (could also be dynamically calculated)
    customer_ids UUID[],

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Operational alerts
CREATE TABLE operational_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Alert details
    type VARCHAR(50) NOT NULL, -- 'sla_breach', 'capacity_warning', 'quality_issue'
    severity VARCHAR(20) NOT NULL, -- 'low', 'medium', 'high', 'critical'
    message TEXT NOT NULL,

    -- Affected entity
    affected_entity_type VARCHAR(50), -- 'lab_partner', 'counselor', 'system'
    affected_entity_id VARCHAR(255),

    -- Status
    status VARCHAR(20) DEFAULT 'open', -- 'open', 'acknowledged', 'resolved'
    acknowledged_at TIMESTAMPTZ,
    acknowledged_by VARCHAR(255),
    resolved_at TIMESTAMPTZ,
    resolved_by VARCHAR(255),
    resolution_notes TEXT,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX idx_marketing_touchpoints_customer ON marketing_touchpoints(customer_id);
CREATE INDEX idx_marketing_touchpoints_timestamp ON marketing_touchpoints(timestamp DESC);
CREATE INDEX idx_marketing_spend_date ON marketing_spend(date DESC);
CREATE INDEX idx_marketing_spend_channel ON marketing_spend(channel);
CREATE INDEX idx_churn_predictions_customer ON churn_predictions(customer_id);
CREATE INDEX idx_churn_predictions_risk ON churn_predictions(risk_level) WHERE customer_churned IS NULL;
CREATE INDEX idx_operational_alerts_status ON operational_alerts(status) WHERE status = 'open';
CREATE INDEX idx_operational_alerts_severity ON operational_alerts(severity, created_at DESC);
```

---

## Success Metrics

**Adoption**:

- **Dashboard usage**: 80%+ of leadership team logs in weekly
- **Data-driven decisions**: 50%+ of strategic decisions cite analytics
- **Alert response time**: <2 hours for critical alerts

**Operational Efficiency**:

- **Time saved**: 20 hours/week (no more manual Excel reports)
- **Faster decisions**: Reduce decision-making time 50% (real-time data vs. waiting for reports)

**Business Impact**:

- **Churn reduction**: 15% reduction in churn via proactive interventions
- **Marketing ROI improvement**: 25% improvement (reallocate spend to high-ROI channels)
- **Revenue increase**: $500K/year from reduced churn + optimized marketing

---

## Budget & Costs

### Development (3-4 months)

- **Data Engineer** (data pipelines, ETL): $160K/year × 0.33 = $52,800
- **Analytics Engineer** (dashboards, SQL): $140K/year × 0.33 = $46,200
- **Business Analyst** (requirements, KPIs): $120K/year × 0.17 = $20,400

**Total Development**: ~$119,400

### Annual Operations

**Infrastructure**:

- **Looker/Tableau license**: $5,000/year (10 users)
- **Data warehouse** (BigQuery/Snowflake): $12,000/year
- **ML model training** (GPU compute): $6,000/year

**Tooling**:

- **Attribution tool** (Segment, Google Analytics 360): $10,000/year
- **Alerting** (PagerDuty): $1,200/year

**Total Operations**: ~$34,200/year

### **GRAND TOTAL (First Year)**: ~$153,600

**ROI**:

- **Churn reduction**: 15% × $1.5M ARR × 40% churn = **$90K saved**
- **Marketing optimization**: 25% improvement on $500K spend = **$125K saved**
- **Net benefit**: $215K - $34K operations = **$181K/year profit**

---

**Document Status**: Complete
**Next Feature**: #27 - Partner Portal Enhancements
