# Fair Underwriting - KPI Dashboard Specifications

**Last Updated**: November 7, 2025
**Purpose**: Define key performance indicators (KPIs) and dashboard requirements for executive, partner, and operational monitoring
**Status**: Design Document (Implementation Q1 2026)

---

## Executive Summary

This document specifies **KPI Dashboard requirements** for Fair Underwriting across three primary audiences:

1. **Executive Dashboard** (CEO, board, investors—strategic metrics)
2. **Partner Dashboard** (insurance partners—their program performance)
3. **Operational Dashboards** (internal teams—tactical metrics)

**Technology Stack**:

- **Data Warehouse**: ClickHouse (OLAP, fast aggregations for time-series data)
- **Dashboard Framework**: Metabase or Tableau (open-source vs. enterprise, TBD based on budget)
- **Data Pipelines**: Node.js ETL jobs (PostgreSQL → ClickHouse, hourly sync)
- **Access Control**: Role-based (partners see only their data, executives see all)

**Refresh Frequency**:

- **Real-time metrics**: Enrollment funnel, system uptime (refresh every 5 min)
- **Daily metrics**: Revenue, tests processed, NPS (refresh nightly at 2am UTC)
- **Weekly metrics**: Partner pipeline, hiring progress (refresh Sundays)
- **Monthly metrics**: Financial P&L, cash runway (refresh on 1st of month)

---

## Section 1: Executive Dashboard (CEO, Board, Investors)

**Purpose**: High-level strategic metrics to assess business health, growth trajectory, and risk

**Audience**: CEO, CFO, board of directors, Series A/B investors

**Refresh**: Daily (nightly refresh at 2am UTC)

**Access**: Password-protected, read-only, SSO for executives/board

---

### 1.1 Revenue Metrics

**Primary KPI**: **Monthly Recurring Revenue (MRR)**

**Definition**:

- MRR = (Tests revenue / contract months) + Subscription revenue
- Example: $10K in test fees (3-month contracts) + $5K in monthly subscriptions = $8.3K MRR

**Chart Type**: Line chart (MRR over time, last 12 months)

**Targets**:

- Year 1: $30K MRR by Month 12
- Year 2: $150K MRR by Month 24
- Year 3: $450K MRR by Month 36

**Drill-Down**:

- MRR by revenue stream (tests vs. subscriptions)
- MRR by partner (top 10 partners)
- MRR growth rate (% MoM, % YoY)

---

**Secondary KPI**: **Annual Recurring Revenue (ARR)**

**Definition**: ARR = MRR × 12

**Chart Type**: Single metric card (current ARR, % change vs. prior quarter)

**Targets**:

- Year 1: $390K ARR
- Year 2: $1.9M ARR
- Year 3: $5.5M ARR

---

**Secondary KPI**: **Revenue per Customer (ARPU)**

**Definition**: ARPU = Total revenue / Total customers (lifetime)

**Chart Type**: Line chart (ARPU over time, last 12 months)

**Targets**:

- Year 1: $250 ARPU (mostly one-time tests)
- Year 3: $320 ARPU (subscription attach growing)
- Year 5: $400 ARPU (60% subscription attach rate)

---

### 1.2 Customer Metrics

**Primary KPI**: **Total Customers Tested (Cumulative)**

**Definition**: Total customers who completed genetic testing (sample received by lab, results delivered)

**Chart Type**: Line chart (cumulative customers over time, last 12 months)

**Targets**:

- Year 1: 1,500 customers
- Year 2: 7,000 customers (cumulative 8,500)
- Year 3: 20,000 customers (cumulative 28,500)

**Drill-Down**:

- Customers by partner (top 10 partners)
- Customers by month (new customers per month)
- Customers by result type (MM, MZ, MS, SZ, ZZ—breakdown)

---

**Secondary KPI**: **MZ Carriers Detected**

**Definition**: Number of customers with MZ genotype (primary clinical outcome)

**Chart Type**: Single metric card (cumulative MZ carriers, % of total tested)

**Targets**:

- Year 1: 45-60 MZ carriers (3-4% detection rate, in line with population prevalence)
- Year 2: 200-340 MZ carriers (cumulative)
- Year 3: 700-1,140 MZ carriers (cumulative)

**Clinical Significance**: Each MZ carrier detected is a potential life saved (if quit smoking, get PFTs, start monitoring)

---

**Secondary KPI**: **Subscription Members (Active)**

**Definition**: Customers with active annual monitoring subscription ($30-75/year)

**Chart Type**: Line chart (active subscriptions over time, last 12 months)

**Targets**:

- Year 1: 300 subscriptions (20% attach rate)
- Year 2: 2,000 subscriptions (cumulative, ~24% attach)
- Year 3: 8,000 subscriptions (cumulative, ~28% attach)

**Revenue Impact**: Subscriptions are high-margin ($30-75/year revenue, <$5 COGS) → critical for profitability

---

### 1.3 Partner Metrics

**Primary KPI**: **Active Partners**

**Definition**: Insurance partners with signed contracts (MSA/BAA/DPA) and active enrollment

**Chart Type**: Single metric card (current active partners, +/- vs. prior quarter)

**Targets**:

- Year 1: 2 partners
- Year 2: 7 partners
- Year 3: 12 partners

**Drill-Down**:

- Partners by type (life insurance, health insurance, disability insurance)
- Partners by stage (pilot, scale, mature)
- Partners by region (state/metro)

---

**Secondary KPI**: **Partner Pipeline**

**Definition**: Prospective partners in sales pipeline by stage

**Chart Type**: Funnel chart (stages: Lead → Demo → Proposal → LOI → Contract)

**Stages**:

- **Lead** (50+ prospects): Initial contact, exploratory discussion
- **Demo** (20-30 prospects): Product demo completed, interest confirmed
- **Proposal** (10-15 prospects): Proposal submitted (pricing, pilot plan)
- **LOI** (5-7 prospects): Letter of intent signed (non-binding commitment)
- **Contract** (2-3 prospects): MSA/BAA/DPA signed (binding commitment)

**Conversion Rates**:

- Lead → Demo: 40-50%
- Demo → Proposal: 50-60%
- Proposal → LOI: 50-60%
- LOI → Contract: 70-80%
- **Overall Lead → Contract**: 10-15% (need 20 leads to close 2-3 contracts)

---

**Secondary KPI**: **Partner Churn Rate**

**Definition**: % of partners who terminate contracts (annually)

**Chart Type**: Single metric card (annual churn rate, +/- vs. prior year)

**Targets**:

- Year 1-2: 0-10% churn (pilots may not renew if dissatisfied)
- Year 3+: <5% churn (mature partnerships, proven ROI)

**Risk Indicator**: Churn >10% signals partner dissatisfaction, product/pricing issues

---

### 1.4 Engagement Metrics

**Primary KPI**: **Enrollment Rate**

**Definition**: % of eligible customers who enroll in genetic testing (per pilot)

**Calculation**: Enrollment rate = Enrolled customers / Eligible customers

**Chart Type**: Bar chart (enrollment rate by partner, last 6 months)

**Targets**:

- Pilot target: 5-10% enrollment rate
- Mature partner: 10-15% enrollment rate (proven messaging, multi-channel campaigns)

**Drill-Down**:

- Enrollment rate by campaign (email, SMS, webinar, wellness event)
- Enrollment funnel (email open → click → enrollment start → enrollment complete → kit order)

---

**Secondary KPI**: **Net Promoter Score (NPS)**

**Definition**: Customer likelihood to recommend Fair Underwriting (0-10 scale, NPS = % Promoters - % Detractors)

**Chart Type**: Line chart (NPS over time, last 12 months) + gauge chart (current NPS)

**Targets**:

- Overall NPS: 40+ (good), 60+ (excellent)
- Genetic counseling NPS: 60+ (critical touchpoint)
- Partner NPS: 50+ (partners recommend Fair Underwriting to peers)

**Segments**:

- NPS by customer type (MM, MZ, ZZ—do MZ carriers rate higher due to actionable results?)
- NPS by touchpoint (enrollment, result delivery, genetic counseling, portal)

---

**Secondary KPI**: **Action Rate (MZ Carriers)**

**Definition**: % of MZ carriers who take recommended actions (smoking cessation, doctor visit, family screening)

**Chart Type**: Bar chart (action type: quit smoking, doctor visit, PFT, family screening)

**Targets**:

- Smoking cessation: 30-40% of MZ smokers quit or reduce
- Doctor visit: 60-80% of MZ carriers see doctor within 3 months
- PFT baseline: 50-70% of MZ carriers get PFT within 6 months
- Family screening: 30-50% of MZ carriers refer ≥1 family member

**Clinical Impact**: High action rate → better outcomes → partner ROI → renewals

---

### 1.5 Financial Metrics

**Primary KPI**: **Cash Runway**

**Definition**: Months of operating expenses remaining (based on current cash balance and burn rate)

**Calculation**: Runway = Cash balance / Monthly burn rate

**Chart Type**: Single metric card (current runway in months, trend arrow up/down)

**Targets**:

- Year 1: Maintain 12+ months runway (raise Series A before runway drops below 12 months)
- Year 2-3: Maintain 18+ months runway (healthy cushion for fundraising, hiring)

**Risk Indicator**: Runway <6 months is critical (must raise capital or cut burn immediately)

---

**Secondary KPI**: **Gross Margin**

**Definition**: (Revenue - COGS) / Revenue

**Calculation**:

- COGS = Lab fees + Genetic counseling + Platform costs
- Gross Margin = (Revenue - COGS) / Revenue

**Chart Type**: Line chart (gross margin % over time, last 12 months)

**Targets**:

- Year 1: 35-40% gross margin (test-heavy, low subscription mix)
- Year 3: 55-60% gross margin (subscription mix growing, lab discounts)
- Year 5: 65-70% gross margin (60% subscription attach, negotiated lab fees)

**Profitability Driver**: Gross margin expansion is critical for profitability (need 60%+ to cover OpEx)

---

**Secondary KPI**: **LTV:CAC Ratio**

**Definition**: Customer Lifetime Value / Customer Acquisition Cost

**Calculation**:

- LTV = (Revenue per customer × Gross margin) - (Retention costs)
- CAC = (Sales + Marketing expenses) / New customers acquired
- LTV:CAC = LTV / CAC

**Chart Type**: Single metric card (current LTV:CAC ratio, trend vs. prior quarter)

**Targets**:

- Year 1: 0.5-1.0x LTV:CAC (underwater—expected in early stage)
- Year 3: 2.0-3.0x LTV:CAC (break-even unit economics)
- Year 5: 4.0-6.0x LTV:CAC (profitable, scalable)

**Benchmark**: VCs want 3-5x LTV:CAC for Series B+ (Fair Underwriting on track by Year 3-4)

---

### 1.6 Operational Metrics

**Primary KPI**: **Headcount**

**Definition**: Total full-time employees (FTEs)

**Chart Type**: Line chart (headcount over time by department, last 12 months)

**Targets**:

- Year 1: 7 → 12 FTEs
- Year 2: 12 → 25 FTEs
- Year 3: 25 → 50 FTEs

**Drill-Down**:

- Headcount by department (Engineering, Clinical, Sales, Marketing, Ops, Finance, etc.)
- Headcount growth rate (% MoM, % YoY)

---

**Secondary KPI**: **Platform Uptime**

**Definition**: % of time Fair Underwriting platform is available (no downtime)

**Chart Type**: Single metric card (uptime % last 30 days, SLA target 99.5%)

**Targets**:

- Year 1-2: 99.0% uptime (allowable: ~7 hours downtime/month)
- Year 3+: 99.5% uptime (allowable: ~3.5 hours downtime/month)

**Risk Indicator**: Uptime <99% signals infrastructure issues (impacts enrollment, customer satisfaction)

---

**Executive Dashboard Summary View** (single-page overview):

```
+------------------------------------------------------------+
|              Fair Underwriting - Executive Dashboard       |
|                    Last Updated: Nov 7, 2025              |
+------------------------------------------------------------+

REVENUE                        CUSTOMERS
ARR: $1.9M (+120% YoY)         Total Tested: 8,500 (+467% YoY)
MRR: $158K (+10% MoM)          MZ Detected: 323 (3.8%)
Gross Margin: 48%              Subscriptions: 2,000 (24% attach)

PARTNERS                       ENGAGEMENT
Active: 7 (+5 YoY)            Enrollment Rate: 8.2%
Pipeline: 23 (8 in proposal)   NPS: 62 (Overall)
Churn: 0% (LTM)               Action Rate: 34% (Smoking Cessation)

FINANCIAL HEALTH               OPERATIONS
Cash Runway: 18 months         Headcount: 25 FTEs
LTV:CAC: 2.1x                 Platform Uptime: 99.3%
Burn Rate: $215K/month        Tests Processed: 685 (last 30 days)

+------------------------------------------------------------+
```

---

## Section 2: Partner Dashboard (Insurance Partners)

**Purpose**: Show insurance partners their program performance (enrollment, outcomes, ROI)

**Audience**: Insurance partner executives, wellness managers, data analysts

**Refresh**: Daily (nightly refresh at 2am UTC)

**Access**: Partner-specific login (SSO via partner identity provider, e.g., Okta), partners see ONLY their data

---

### 2.1 Enrollment Metrics

**Primary KPI**: **Enrollment Count (Cumulative)**

**Definition**: Total policyholders enrolled in Fair Underwriting testing

**Chart Type**: Line chart (cumulative enrollments over time, since pilot launch)

**Target**: Partner-specific (e.g., 5-10% of eligible population)

**Drill-Down**:

- Enrollments by month
- Enrollments by campaign (email, portal, wellness event)
- Enrollment funnel (email sent → opened → clicked → enrolled → kit ordered → sample returned → result delivered)

---

**Secondary KPI**: **Enrollment Rate**

**Definition**: % of eligible policyholders who enrolled

**Calculation**: Enrollment rate = Enrolled / Eligible

**Chart Type**: Single metric card (current enrollment rate, +/- vs. target)

**Benchmark**:

- 5-10% enrollment is typical for wellness programs
- 10-15% is excellent (indicates strong messaging, incentives, partner engagement)

---

### 2.2 Clinical Outcomes

**Primary KPI**: **MZ Carriers Detected**

**Definition**: Number of policyholders with MZ genotype

**Chart Type**: Single metric card (cumulative MZ carriers, % of tested population)

**Clinical Significance**:

- Each MZ carrier is at 2-4x COPD risk (if smoker)
- Early detection + intervention → prevent $5K-15K/year COPD costs

**Drill-Down**:

- MZ carriers by age, gender, smoking status
- MZ carriers who took action (smoking cessation, doctor visit, PFT)

---

**Secondary KPI**: **ZZ Carriers Detected**

**Definition**: Number of policyholders with ZZ genotype (severe AATD)

**Chart Type**: Single metric card (cumulative ZZ carriers)

**Clinical Significance**:

- ZZ carriers have severe AATD (need augmentation therapy, specialist care)
- Early diagnosis → prevent irreversible lung/liver damage

**Expected Prevalence**: 1 in 2,500-5,000 (for 10K pilot, expect 2-4 ZZ carriers)

---

### 2.3 Engagement Outcomes

**Primary KPI**: **Action Rate (MZ Carriers)**

**Definition**: % of MZ carriers who completed recommended actions

**Chart Type**: Bar chart (action type: smoking cessation, doctor visit, PFT, family screening)

**Targets** (partner-specific, but typical):

- Smoking cessation: 30-40%
- Doctor visit: 60-80%
- PFT baseline: 50-70%
- Family screening: 30-50%

**Partner Value**: High action rate → better health outcomes → medical cost savings → ROI

---

**Secondary KPI**: **Customer Satisfaction (NPS)**

**Definition**: Net Promoter Score for policyholders who used Fair Underwriting

**Chart Type**: Gauge chart (current NPS, 0-100 scale)

**Targets**:

- 40+ NPS: Good (policyholders satisfied)
- 60+ NPS: Excellent (policyholders love it, recommend to friends/family)

**Partner Value**: High NPS → policyholder retention, brand goodwill, competitive advantage

---

### 2.4 ROI Metrics

**Primary KPI**: **Projected Medical Cost Savings**

**Definition**: Estimated medical cost savings from early intervention (MZ carriers who quit smoking, get PFTs)

**Calculation**:

- Baseline COPD cost: $5K-15K/year per patient
- MZ carrier risk: 2-4x higher COPD risk if smoker
- Smoking cessation reduces COPD risk by 58%
- Projected savings per MZ carrier: $1,200-2,500 over 5 years (discounted present value)
- Total savings = MZ carriers detected × Action rate × Savings per carrier

**Example** (10K pilot, 40 MZ carriers detected, 34% smoking cessation):

- 40 MZ carriers × 34% action rate = 13.6 quit smoking
- 13.6 × $1,800 savings (midpoint) = $24,480 projected savings over 5 years

**Chart Type**: Single metric card (total projected savings, $/policyholder)

**Partner Value**: Demonstrates ROI—Fair Underwriting pays for itself via medical cost savings

---

**Secondary KPI**: **Cost per MZ Carrier Detected**

**Definition**: Total program cost / MZ carriers detected

**Calculation**:

- Total cost = (Enrolled × $350/test) + Partner admin costs
- Cost per MZ = Total cost / MZ detected

**Example** (10K pilot, 800 enrolled, 30 MZ detected):

- Total cost = 800 × $350 = $280K
- Cost per MZ = $280K / 30 = $9,333

**Benchmark**:

- <$10K per MZ: Excellent (cost-effective screening)
- $10K-20K per MZ: Good (typical for genetic screening programs)
- > $20K per MZ: Poor (low enrollment or low MZ prevalence—may need program optimization)

**Partner Value**: Lower cost per MZ → better ROI → renewal likelihood

---

**Partner Dashboard Summary View** (single-page overview for each partner):

```
+------------------------------------------------------------+
|      Fair Underwriting - [Partner Name] Dashboard         |
|              Pilot Launched: Jan 1, 2025                   |
|              Last Updated: Nov 7, 2025                     |
+------------------------------------------------------------+

ENROLLMENT                     CLINICAL OUTCOMES
Enrolled: 842 / 10,000         MZ Carriers: 32 (3.8%)
Enrollment Rate: 8.4%          ZZ Carriers: 2 (0.24%)
Target: 5-10% ✅              Other Variants: 15 (MS, SS, SZ)

ENGAGEMENT                     ROI
NPS: 64 (Excellent)           Projected Savings: $57,600 (5-yr)
Action Rate (MZ): 34%         Cost per MZ: $9,208
  - Quit Smoking: 11/32       Cost per Enrolled: $350
  - Doctor Visit: 26/32       Break-Even: Year 3 (projected)

NEXT STEPS
📊 Monthly review call: Dec 1, 2025
📈 Enrollment campaign: Holiday wellness push (Dec 15-31)
🎯 Goal: 1,000 enrolled by Jan 1, 2026 (pilot end)

+------------------------------------------------------------+
```

---

## Section 3: Operational Dashboards (Internal Teams)

**Purpose**: Tactical metrics for day-to-day operations (engineering, clinical, sales, marketing, finance)

**Audience**: Internal teams (department-specific dashboards)

**Refresh**: Real-time or daily (depending on metric)

**Access**: Internal employees only (SSO via Okta/Auth0)

---

### 3.1 Engineering Dashboard

**Metrics**:

1. **Platform Uptime** (Real-time)
   - Current uptime % (last 24 hours, last 7 days, last 30 days)
   - Downtime incidents (count, duration, root cause)
   - SLA target: 99.5% (3.5 hours downtime/month allowable)

2. **API Response Time** (Real-time)
   - P50, P95, P99 latency (ms) for critical endpoints (enrollment, result delivery, dashboard)
   - Target: P95 <500ms, P99 <1000ms

3. **Error Rate** (Real-time)
   - 5xx errors (server errors) per hour
   - 4xx errors (client errors—e.g., bad requests) per hour
   - Target: <0.1% error rate

4. **Database Performance** (Real-time)
   - Query latency (P95, P99)
   - Connection pool utilization (%)
   - Slow queries (>1 second)

5. **Deployment Frequency** (Weekly)
   - Number of deployments per week
   - Deployment success rate (%)
   - Target: 5-10 deployments/week (continuous deployment)

6. **Bug Backlog** (Weekly)
   - Critical bugs (blocking customers, data loss risk): Target 0
   - High-priority bugs: Target <5
   - Medium/low bugs: Backlog acceptable

**Chart Types**: Line charts (uptime, latency over time), bar charts (errors by endpoint), table (bug list)

---

### 3.2 Clinical Operations Dashboard

**Metrics**:

1. **Tests in Progress** (Real-time)
   - Kits ordered (waiting for customer to mail sample): X kits
   - Samples in transit (customer mailed, not yet received by lab): Y samples
   - Samples at lab (received, processing): Z samples
   - Results pending delivery (lab completed, Fair Underwriting delivering to customer): W results

2. **Lab Turnaround Time** (Daily)
   - Median time from sample receipt → result delivery
   - P90 time (90th percentile)
   - Target: Median 7-10 days, P90 <14 days

3. **Genetic Counseling Queue** (Real-time)
   - MZ/ZZ carriers awaiting counseling: X customers
   - Average wait time for counseling session
   - Target: MZ carriers scheduled within 7 days, ZZ carriers within 48 hours (urgent)

4. **Counselor Utilization** (Weekly)
   - Hours counseled / Available hours (per counselor)
   - Target: 70-85% utilization (too high → burnout, too low → underutilized)

5. **Customer Support Tickets** (Daily)
   - Open tickets by priority (critical, high, medium, low)
   - Median time to first response
   - Median time to resolution
   - Target: First response <24 hours, resolution <72 hours

**Chart Types**: Funnel (tests in progress), histogram (turnaround time distribution), table (counselor schedule)

---

### 3.3 Sales Dashboard

**Metrics**:

1. **Pipeline Value** (Weekly)
   - Total contract value (TCV) in pipeline by stage (Lead, Demo, Proposal, LOI, Contract)
   - Weighted pipeline value (TCV × stage probability—e.g., LOI stage = 70% probability)

2. **Sales Velocity** (Weekly)
   - Average days in each pipeline stage (Lead → Demo: X days, Demo → Proposal: Y days, etc.)
   - Conversion rates by stage (Lead → Demo: %, Demo → Proposal: %, etc.)

3. **Quota Attainment** (Monthly)
   - Sales quota (e.g., close 3 pilots in Q4)
   - Actual closed deals
   - % to quota
   - Target: 80-100% quota attainment (consistently hitting quota)

4. **Rep Performance** (Monthly)
   - Sales per rep (SDR: demos booked, AE: contracts closed)
   - Leaderboard (top performers)

5. **Deal Forecast** (Monthly)
   - Deals expected to close this month/quarter (based on stage, probability)
   - Upside/downside scenarios

**Chart Types**: Funnel (pipeline stages), bar chart (quota attainment by rep), table (deal list)

---

### 3.4 Marketing Dashboard

**Metrics**:

1. **Website Traffic** (Weekly)
   - Unique visitors per week
   - Traffic sources (organic search, paid ads, referrals, direct)
   - Conversion rate (visitors → enrollments)

2. **Campaign Performance** (Weekly)
   - Email campaigns: Open rate, click rate, enrollment rate
   - Paid ads: Impressions, clicks, cost per click (CPC), cost per enrollment
   - Webinars: Registrations, attendees, enrollments

3. **Content Engagement** (Monthly)
   - Blog posts: Page views, time on page, shares
   - Case studies: Downloads, shares
   - Videos: Views, completion rate

4. **Lead Generation** (Weekly)
   - New leads per week (for sales team)
   - Lead sources (conference, content download, demo request, referral)

5. **Brand Awareness** (Quarterly)
   - Media mentions (press coverage, podcasts, conferences)
   - Social media followers, engagement

**Chart Types**: Line charts (traffic over time), bar charts (campaign ROI), table (content performance)

---

### 3.5 Finance Dashboard

**Metrics**:

1. **Cash Balance** (Daily)
   - Current cash in bank
   - Burn rate (monthly cash out)
   - Runway (months remaining)

2. **Revenue** (Daily)
   - Revenue today, this week, this month, this year
   - Revenue by stream (tests, subscriptions, licensing, data)

3. **Expenses** (Monthly)
   - Expenses by category (payroll, lab fees, marketing, software, office, etc.)
   - Budget vs. actual (variance)

4. **Accounts Receivable** (Weekly)
   - Outstanding invoices (partners owe Fair Underwriting)
   - Days Sales Outstanding (DSO—average days to collect payment)
   - Target: DSO <30 days

5. **Key Financial Ratios** (Monthly)
   - Gross margin %
   - Operating margin %
   - LTV:CAC ratio
   - Revenue per employee

**Chart Types**: Single metric cards (cash, revenue), waterfall chart (cash flow), table (expenses by category)

---

## Section 4: Technical Implementation

### 4.1 Data Architecture

**Data Sources** (PostgreSQL operational database):

- `customers` table: customer info, enrollment date, result type, subscription status
- `partners` table: partner info, contract details, eligible population
- `tests` table: test orders, sample status, lab processing status, result delivery date
- `counseling_sessions` table: genetic counseling appointments, counselor, duration, NPS
- `subscriptions` table: subscription start date, renewal date, cancellation date, MRR
- `financial_transactions` table: invoices, payments, revenue recognition

**ETL Pipeline** (Extract, Transform, Load):

- **Extract**: Hourly cron job queries PostgreSQL (incremental updates—only new/changed rows since last sync)
- **Transform**: Aggregate data (e.g., count MZ carriers, calculate enrollment rate, compute LTV)
- **Load**: Insert into ClickHouse (OLAP database optimized for analytics)

**ClickHouse Schema** (fact tables + dimension tables):

**Fact Tables**:

- `fact_enrollments`: enrollment_date, partner_id, customer_id, campaign_id
- `fact_tests`: test_date, customer_id, result_type (MM, MZ, ZZ, etc.), turnaround_time_days
- `fact_counseling`: session_date, customer_id, counselor_id, duration_minutes, nps_score
- `fact_revenue`: transaction_date, partner_id, revenue_type (test, subscription), amount

**Dimension Tables**:

- `dim_partners`: partner_id, partner_name, partner_type (life, health, disability), state, contract_start_date
- `dim_customers`: customer_id, partner_id, age, gender, smoking_status, result_type
- `dim_campaigns`: campaign_id, campaign_name, campaign_type (email, SMS, webinar), start_date

---

### 4.2 Dashboard Framework

**Option 1: Metabase** (Open-Source)

**Pros**:

- Free (open-source, self-hosted)
- Easy to set up (Docker container, 1-hour setup)
- SQL-based (write SQL queries, visualize results)
- Embeddable (can embed dashboards in Fair Underwriting portal for partners)

**Cons**:

- Limited features (compared to Tableau/Looker)
- Self-hosted (Fair Underwriting manages infrastructure, updates, security)

**Recommendation**: Use Metabase for Year 1-2 (low cost, fast setup), migrate to Tableau if budget allows in Year 3+

---

**Option 2: Tableau** (Enterprise)

**Pros**:

- Powerful (advanced visualizations, drill-downs, interactive dashboards)
- Partner-friendly (polished UI, easy to use for non-technical users)
- Cloud-hosted (Tableau manages infrastructure, security, updates)

**Cons**:

- Expensive ($70/user/month for Tableau Cloud, 10 users = $8,400/year)
- Overkill for early stage (Metabase sufficient for Year 1-2)

**Recommendation**: Migrate to Tableau in Year 3+ when partner count grows (20+ partners, need polished dashboards for executive reviews)

---

### 4.3 Access Control

**Role-Based Access Control (RBAC)**:

**Role 1: Executive** (CEO, CFO, board)

- Access: All dashboards (Executive, Partner, Operational)
- Data: All partners, all metrics

**Role 2: Partner User** (insurance partner employee)

- Access: Partner Dashboard only
- Data: Their partner's data only (no visibility into other partners)
- Authentication: SSO via partner identity provider (Okta, Azure AD)

**Role 3: Team Member** (Fair Underwriting employee)

- Access: Operational Dashboards (department-specific—e.g., engineers see Engineering Dashboard, sales team sees Sales Dashboard)
- Data: All partners (for internal use)

**Implementation**:

- Metabase/Tableau supports RBAC (assign users to roles, restrict dashboard access by role)
- ClickHouse row-level security (filter queries by partner_id for Partner Users)

---

### 4.4 Alerting & Notifications

**Alert Types**:

1. **Critical Alerts** (Immediate notification—Slack, email, SMS):
   - Platform downtime (uptime <99%)
   - Security incident (breach, unauthorized access)
   - Cash runway <6 months (financial emergency)

2. **Warning Alerts** (Daily email summary):
   - Enrollment rate drops below target (e.g., <5% for a partner)
   - NPS drops below 40 (customer dissatisfaction)
   - Lab turnaround time >14 days (customer experience issue)
   - Partner churn (contract termination)

3. **Info Alerts** (Weekly email summary):
   - New partner signed (celebrate!)
   - Revenue milestone hit (e.g., $1M ARR)
   - MZ carrier milestone (e.g., 100th MZ carrier detected)

**Alert Delivery**:

- **Slack**: #alerts channel (real-time critical alerts)
- **Email**: Daily/weekly digest (warning/info alerts)
- **SMS**: CEO, CTO phone (critical alerts only—platform down, security breach)

**Alert Configuration** (Metabase/Tableau):

- Set thresholds (e.g., "Alert if enrollment rate <5%")
- Schedule (e.g., "Check daily at 8am UTC, email if threshold breached")

---

## Section 5: Dashboard Mockups

### Executive Dashboard Mockup (Text-Based Layout)

```
+------------------------------------------------------------------+
|                  FAIR UNDERWRITING - EXECUTIVE DASHBOARD         |
|                       Last Updated: Nov 7, 2025, 2:05am UTC      |
+------------------------------------------------------------------+
|                                                                  |
|  REVENUE METRICS                                                |
|  +----------------------+  +----------------------+              |
|  | ARR                  |  | MRR                  |              |
|  | $1.9M                |  | $158K                |              |
|  | ↑ 120% YoY           |  | ↑ 10% MoM            |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  Revenue Trend (Last 12 Months)                                 |
|  [Line Chart: MRR over time, Jan-Nov 2025]                      |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  CUSTOMER METRICS                                               |
|  +----------------------+  +----------------------+              |
|  | Total Tested         |  | MZ Carriers          |              |
|  | 8,500                |  | 323 (3.8%)           |              |
|  | ↑ 467% YoY           |  | ↑ 510% YoY           |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  Customer Growth (Last 12 Months)                               |
|  [Line Chart: Cumulative customers tested, Jan-Nov 2025]        |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  PARTNER METRICS                                                |
|  +----------------------+  +----------------------+              |
|  | Active Partners      |  | Partner Churn        |              |
|  | 7                    |  | 0% (LTM)             |              |
|  | ↑ 5 YoY              |  | ✅ On Target         |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  Partner Pipeline (Current)                                     |
|  [Funnel Chart: 50 Leads → 25 Demos → 12 Proposals → 5 LOIs]   |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  FINANCIAL HEALTH                                               |
|  +----------------------+  +----------------------+              |
|  | Cash Runway          |  | LTV:CAC              |              |
|  | 18 months            |  | 2.1x                 |              |
|  | ✅ Healthy           |  | ↑ from 1.5x (Q2)     |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
+------------------------------------------------------------------+
```

---

### Partner Dashboard Mockup (Text-Based Layout)

```
+------------------------------------------------------------------+
|          FAIR UNDERWRITING - NORTHWESTERN MUTUAL DASHBOARD       |
|               Pilot Launched: Jan 1, 2025                        |
|               Last Updated: Nov 7, 2025, 2:05am UTC              |
+------------------------------------------------------------------+
|                                                                  |
|  ENROLLMENT METRICS                                             |
|  +----------------------+  +----------------------+              |
|  | Enrolled             |  | Enrollment Rate      |              |
|  | 842 / 10,000         |  | 8.4%                 |              |
|  | Target: 5-10% ✅     |  | ↑ from 7.1% (Oct)    |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  Enrollment Trend (Last 9 Months)                               |
|  [Line Chart: Cumulative enrollments, Jan-Nov 2025]             |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  CLINICAL OUTCOMES                                              |
|  +----------------------+  +----------------------+              |
|  | MZ Carriers          |  | ZZ Carriers          |              |
|  | 32 (3.8%)            |  | 2 (0.24%)            |              |
|  | Expected: 25-40 ✅   |  | Expected: 2-4 ✅     |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  Variant Distribution (All 842 Tested)                          |
|  [Pie Chart: MM 795, MZ 32, MS 10, SZ 3, ZZ 2]                  |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  ENGAGEMENT OUTCOMES                                            |
|  +----------------------+  +----------------------+              |
|  | NPS                  |  | Action Rate (MZ)     |              |
|  | 64                   |  | 34% (Quit Smoking)   |              |
|  | Excellent ✅         |  | Target: 30-40% ✅    |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
|  MZ Carrier Actions (32 MZ Carriers)                            |
|  [Bar Chart: Quit Smoking 11, Doctor Visit 26, PFT 18, Family 14] |
|                                                                  |
+------------------------------------------------------------------+
|                                                                  |
|  ROI METRICS                                                    |
|  +----------------------+  +----------------------+              |
|  | Projected Savings    |  | Cost per MZ          |              |
|  | $57,600 (5-year)     |  | $9,208               |              |
|  | Break-Even: Year 3   |  | Benchmark: <$10K ✅  |              |
|  +----------------------+  +----------------------+              |
|                                                                  |
+------------------------------------------------------------------+
```

---

## Section 6: Success Metrics for Dashboard

**How do we know the dashboard is successful?**

1. **Usage Metrics**:
   - **Executives**: Log in weekly (check Executive Dashboard before board meetings)
   - **Partners**: Log in monthly (check Partner Dashboard before quarterly business reviews)
   - **Internal teams**: Log in daily (operational dashboards drive decision-making)

2. **Decision Impact**:
   - **Executives**: Use dashboard data for fundraising (investor pitch includes dashboard screenshots)
   - **Partners**: Use ROI data to justify contract renewals ("Fair Underwriting saved us $57K over 5 years")
   - **Internal teams**: Use dashboards to identify issues (e.g., low enrollment rate → trigger marketing campaign)

3. **Data Quality**:
   - **Accuracy**: Data matches source systems (PostgreSQL) within 1% (acceptable variance for aggregations)
   - **Freshness**: Real-time metrics refresh every 5 min, daily metrics refresh by 2am UTC (SLA: 99% on-time)
   - **Completeness**: No missing data (e.g., all tests have result_type recorded, all enrollments have partner_id)

4. **Satisfaction**:
   - **Internal NPS**: Survey employees quarterly ("How useful is the dashboard?" 0-10 scale), target NPS 60+
   - **Partner NPS**: Survey partners annually ("Does the dashboard help you understand program performance?"), target 70+

---

## Conclusion

This **KPI Dashboard Specification** defines:

- **Executive Dashboard**: Strategic metrics (ARR, customers, partners, cash runway, LTV:CAC)
- **Partner Dashboard**: Program performance (enrollment, MZ detection, action rate, ROI)
- **Operational Dashboards**: Tactical metrics (engineering uptime, clinical queue, sales pipeline, marketing campaigns, finance)

**Implementation Plan**:

- **Q1 2026**: Build Executive Dashboard (Metabase, ClickHouse ETL, 1 engineer, 4-6 weeks)
- **Q2 2026**: Build Partner Dashboard (embed in portal, SSO, partner-specific data filtering, 1 engineer, 6-8 weeks)
- **Q3 2026**: Build Operational Dashboards (department-specific, 1 engineer, 8-10 weeks)

**Budget**:

- **Technology**: ClickHouse (self-hosted, AWS EC2 ~$500/month), Metabase (free, self-hosted)
- **Engineering**: 1 engineer, 6 months (20-30 hours/week) = $30K-50K (contractor or internal engineer)

**Success Criteria**:

- Executives use dashboard for board meetings (100% adoption by Q2 2026)
- Partners log in monthly (50%+ adoption by Q3 2026)
- Internal teams use dashboards daily (80%+ adoption by Q4 2026)

---

**Document Owner**: CTO + CFO + Data Analyst (Year 3+)
**Review Frequency**: Quarterly (update KPIs, add new metrics as business evolves)
**Last Updated**: November 7, 2025
**Next Review**: February 7, 2026
