# Feature #5: Advanced Customer Analytics & Business Intelligence

**Category**: Critical Missing Feature
**Priority**: Phase 1 (MVP - Must Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 data engineer, 1 data scientist, 1 backend developer, 1 frontend developer

---

## Executive Summary

Fair Underwriting currently lacks sophisticated analytics to understand customer behavior, predict churn, optimize marketing spend, and demonstrate ROI to insurance partners. This feature builds a comprehensive business intelligence platform that transforms raw data into actionable insights for both Fair Underwriting's internal teams and partner insurance companies.

**Key Value Propositions**:

- **Churn Prediction**: Identify at-risk customers 30-60 days before they cancel
- **Customer Segmentation**: Group users by genotype, risk level, engagement patterns
- **Partner ROI Dashboard**: Show insurance companies real-time cost savings
- **Marketing Attribution**: Track which channels drive highest-value customers
- **Cohort Analysis**: Understand lifetime value by acquisition source
- **Predictive Health Scoring**: Forecast which customers need proactive outreach

**Business Impact**:

- Reduce churn by 25% through proactive retention campaigns
- Increase partner renewals by 40% via transparent ROI reporting
- Optimize CAC by 30% through channel attribution analysis
- Improve LTV by 35% through targeted upselling

---

## Problem Statement

### Current Gaps

**Scenario 1: Insurance Partner Wants ROI Proof**

> "We've partnered with Fair Underwriting for 6 months and referred 500 employees. We need to see: How many completed testing? What genotypes were found? How much did we save in future healthcare costs? What's our projected ROI over 5 years?"

**Currently impossible to generate partner-specific ROI reports** ❌

**Scenario 2: High Churn, Unknown Causes**

> "Our subscription churn rate is 25% annually. We don't know: Are MZ carriers churning more than non-carriers? Do users cancel after seeing normal results? Does engagement drop after the first year?"

**No churn prediction model or cohort retention analysis** ❌

**Scenario 3: Inefficient Marketing Spend**

> "We're spending $200K/year on Facebook, Google, LinkedIn ads. We don't know: Which channel drives the highest lifetime value customers? What's our true CAC by source? Which campaigns lead to completed tests (vs. just sign-ups)?"

**No marketing attribution or funnel conversion tracking** ❌

**Scenario 4: Missed Upsell Opportunities**

> "We have 2,000 users who tested positive for MZ genotype. We don't know: Who would benefit from telemedicine consultations? Who needs family cascade testing? Who should upgrade to premium monitoring?"

**No predictive scoring for upsell opportunities** ❌

---

## System Architecture

### Data Pipeline

```
┌──────────────────────────────────────────────────────────────┐
│                    DATA SOURCES                               │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Users DB │  │  Tests   │  │Wearables │  │Subscript.│   │
│  │(Postgres)│  │   DB     │  │   DB     │  │   DB     │   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘   │
│       │             │              │              │          │
│       └─────────────┼──────────────┼──────────────┘          │
│                     │              │                          │
│              ┌──────▼──────────────▼─────┐                   │
│              │   ETL Pipeline (Airbyte)  │                   │
│              │   - Extracts every 15 min │                   │
│              │   - Transforms (dbt)      │                   │
│              │   - Validates data quality│                   │
│              └──────────┬────────────────┘                   │
│                         │                                     │
│              ┌──────────▼────────────────┐                   │
│              │  Data Warehouse           │                   │
│              │  (Snowflake or BigQuery)  │                   │
│              │  - Fact tables            │                   │
│              │  - Dimension tables       │                   │
│              │  - Aggregates             │                   │
│              └──────────┬────────────────┘                   │
│                         │                                     │
│         ┌───────────────┼───────────────┐                    │
│         │               │               │                    │
│  ┌──────▼─────┐  ┌──────▼─────┐  ┌────▼─────────┐          │
│  │  ML Models │  │  BI Tools  │  │  Real-time   │          │
│  │  (Python)  │  │  (Looker)  │  │  Dashboards  │          │
│  │  - Churn   │  │  - Reports │  │  (React)     │          │
│  │  - LTV     │  │  - Ad-hoc  │  │  - KPIs      │          │
│  │  - Segment │  │    queries │  │  - Alerts    │          │
│  └────────────┘  └────────────┘  └──────────────┘          │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

### Data Warehouse Schema (Snowflake)

**Fact Tables**:

```sql
-- Central fact table: User activity events
CREATE TABLE fact_user_events (
  event_id VARCHAR(36) PRIMARY KEY,
  event_timestamp TIMESTAMP_NTZ NOT NULL,

  -- Dimensions (foreign keys)
  user_id VARCHAR(36) NOT NULL,
  tenant_id VARCHAR(36) NOT NULL,
  session_id VARCHAR(36),

  -- Event details
  event_type VARCHAR(50) NOT NULL, -- 'signup', 'login', 'test_ordered', 'test_completed', 'result_viewed', 'subscription_started', 'subscription_cancelled'
  event_category VARCHAR(20), -- 'acquisition', 'activation', 'engagement', 'revenue', 'churn'

  -- Attribution
  utm_source VARCHAR(100), -- 'facebook', 'google', 'linkedin', 'organic'
  utm_medium VARCHAR(100), -- 'cpc', 'email', 'referral'
  utm_campaign VARCHAR(100), -- 'aatd_awareness_2025', 'carrier_education'
  referrer_url TEXT,

  -- Revenue
  revenue_amount DECIMAL(10, 2), -- Associated revenue (e.g., $250 for test order)

  -- Context
  device_type VARCHAR(20), -- 'mobile', 'desktop', 'tablet'
  browser VARCHAR(50),
  os VARCHAR(50),
  country VARCHAR(2),

  -- Metadata
  event_properties VARIANT -- JSON for flexible additional data
);

-- Partition by month for performance
ALTER TABLE fact_user_events ADD CLUSTER BY (event_timestamp);

-- Test results fact table
CREATE TABLE fact_test_results (
  test_id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  tenant_id VARCHAR(36) NOT NULL,

  -- Test details
  test_date DATE NOT NULL,
  test_type VARCHAR(50), -- 'aat_level', 'genotype', 'lung_function'

  -- Results
  aat_level DECIMAL(5, 2), -- mg/dL
  genotype VARCHAR(10), -- 'MM', 'MZ', 'ZZ', 'SS', 'null'
  risk_category VARCHAR(20), -- 'normal', 'carrier', 'deficient'

  -- Clinical
  provider_id VARCHAR(36),
  ordering_physician_id VARCHAR(36),
  lab_id VARCHAR(36),

  -- Cost
  test_cost DECIMAL(10, 2),
  insurance_covered BOOLEAN,
  patient_paid DECIMAL(10, 2),

  -- Timing
  ordered_at TIMESTAMP_NTZ,
  sample_collected_at TIMESTAMP_NTZ,
  result_received_at TIMESTAMP_NTZ,
  result_viewed_at TIMESTAMP_NTZ,

  turnaround_time_hours INTEGER
);

-- Subscription fact table
CREATE TABLE fact_subscriptions (
  subscription_id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  tenant_id VARCHAR(36) NOT NULL,

  -- Subscription details
  plan_name VARCHAR(50), -- 'basic', 'premium', 'family'
  tier VARCHAR(20), -- 'standard', 'premium', 'enterprise'

  -- Dates
  started_at TIMESTAMP_NTZ NOT NULL,
  scheduled_end_at TIMESTAMP_NTZ,
  actual_end_at TIMESTAMP_NTZ,
  cancelled_at TIMESTAMP_NTZ,

  -- Revenue
  mrr DECIMAL(10, 2), -- Monthly recurring revenue
  arr DECIMAL(10, 2), -- Annual recurring revenue
  lifetime_value DECIMAL(10, 2), -- Total revenue to date

  -- Status
  status VARCHAR(20), -- 'active', 'cancelled', 'paused', 'expired'
  cancellation_reason VARCHAR(100),

  -- Billing
  billing_frequency VARCHAR(20), -- 'monthly', 'annual'
  payment_method VARCHAR(20), -- 'card', 'ach', 'insurance'

  -- Metrics
  months_active INTEGER,
  is_churned BOOLEAN
);

-- Partner ROI fact table
CREATE TABLE fact_partner_roi (
  roi_id VARCHAR(36) PRIMARY KEY,
  partner_tenant_id VARCHAR(36) NOT NULL,
  calculation_date DATE NOT NULL,

  -- Population
  total_employees INTEGER,
  employees_tested INTEGER,
  test_completion_rate DECIMAL(5, 2), -- %

  -- Findings
  carriers_identified INTEGER, -- MZ, MS, SZ genotypes
  deficient_identified INTEGER, -- ZZ, SS genotypes
  high_risk_identified INTEGER, -- ZZ + elevated AAT

  -- Cost savings (projected)
  baseline_healthcare_cost DECIMAL(12, 2), -- Without early detection
  projected_healthcare_cost DECIMAL(12, 2), -- With early detection & intervention
  cost_savings DECIMAL(12, 2), -- Difference
  roi_percentage DECIMAL(5, 2), -- (savings - program_cost) / program_cost * 100

  -- Program costs
  program_cost DECIMAL(12, 2), -- Total cost to partner (tests + subscriptions)
  cost_per_employee DECIMAL(10, 2),
  cost_per_positive DECIMAL(10, 2),

  -- Engagement
  avg_engagement_score DECIMAL(5, 2), -- 0-100
  active_subscribers INTEGER,

  -- Timeframe
  months_since_launch INTEGER
);
```

**Dimension Tables**:

```sql
-- User dimension
CREATE TABLE dim_users (
  user_id VARCHAR(36) PRIMARY KEY,
  tenant_id VARCHAR(36) NOT NULL,

  -- Demographics
  age_range VARCHAR(20), -- '18-24', '25-34', '35-44', '45-54', '55-64', '65+'
  gender VARCHAR(20),
  state VARCHAR(2),
  country VARCHAR(2),

  -- Risk profile
  genotype VARCHAR(10),
  risk_category VARCHAR(20),
  family_history BOOLEAN,
  smoker BOOLEAN,

  -- Engagement
  engagement_score INTEGER, -- 0-100
  engagement_tier VARCHAR(20), -- 'low', 'medium', 'high', 'power_user'

  -- Lifecycle
  lifecycle_stage VARCHAR(30), -- 'prospect', 'activated', 'engaged', 'at_risk', 'churned', 'resurrected'
  days_since_signup INTEGER,
  days_since_last_activity INTEGER,

  -- Value
  ltv DECIMAL(10, 2),
  predicted_ltv DECIMAL(10, 2), -- ML model prediction
  customer_segment VARCHAR(30), -- 'high_value', 'medium_value', 'low_value'

  -- Acquisition
  acquisition_channel VARCHAR(50),
  acquisition_date DATE,

  -- Predictions
  churn_probability DECIMAL(5, 4), -- 0.0000 to 1.0000
  churn_risk_tier VARCHAR(20), -- 'low', 'medium', 'high', 'critical'
  predicted_next_action VARCHAR(50), -- 'reorder_test', 'upgrade_plan', 'refer_family'

  -- SCD Type 2 (slowly changing dimension)
  valid_from TIMESTAMP_NTZ,
  valid_to TIMESTAMP_NTZ,
  is_current BOOLEAN
);

-- Partner/Tenant dimension
CREATE TABLE dim_partners (
  tenant_id VARCHAR(36) PRIMARY KEY,

  -- Organization
  partner_name VARCHAR(200),
  partner_type VARCHAR(50), -- 'insurance_company', 'employer', 'health_system'
  industry VARCHAR(50),
  company_size VARCHAR(20), -- '1-50', '51-200', '201-1000', '1001-5000', '5000+'

  -- Contract
  contract_start_date DATE,
  contract_end_date DATE,
  contract_value DECIMAL(12, 2),

  -- Status
  status VARCHAR(20), -- 'active', 'trial', 'cancelled'
  health_score INTEGER, -- 0-100 (partner satisfaction)

  -- Contact
  primary_contact_name VARCHAR(200),
  primary_contact_email VARCHAR(200),
  account_manager VARCHAR(200)
);

-- Date dimension (standard for analytics)
CREATE TABLE dim_date (
  date_key INTEGER PRIMARY KEY, -- YYYYMMDD format
  date DATE NOT NULL,

  -- Date parts
  year INTEGER,
  quarter INTEGER, -- 1-4
  month INTEGER, -- 1-12
  month_name VARCHAR(10), -- 'January', 'February'
  week INTEGER, -- 1-52
  day_of_month INTEGER, -- 1-31
  day_of_week INTEGER, -- 1-7 (Monday=1)
  day_name VARCHAR(10), -- 'Monday', 'Tuesday'

  -- Business logic
  is_weekend BOOLEAN,
  is_holiday BOOLEAN,
  holiday_name VARCHAR(100),

  -- Fiscal periods (if different from calendar)
  fiscal_year INTEGER,
  fiscal_quarter INTEGER,
  fiscal_month INTEGER
);
```

### ML Models

**1. Churn Prediction Model**:

```python
import pandas as pd
import numpy as np
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score, precision_recall_curve
import joblib

class ChurnPredictionModel:
    def __init__(self):
        self.model = GradientBoostingClassifier(
            n_estimators=200,
            learning_rate=0.05,
            max_depth=5,
            random_state=42
        )
        self.feature_importance = None

    def prepare_features(self, user_id: str) -> pd.DataFrame:
        """Extract features for churn prediction"""

        # Query user data
        user_data = self.query_user_data(user_id)

        features = {
            # Engagement features
            'days_since_signup': user_data['days_since_signup'],
            'days_since_last_login': user_data['days_since_last_login'],
            'total_logins': user_data['total_logins'],
            'logins_last_30_days': user_data['logins_last_30_days'],
            'logins_last_7_days': user_data['logins_last_7_days'],
            'avg_session_duration_minutes': user_data['avg_session_duration_minutes'],

            # Test history
            'total_tests_completed': user_data['total_tests_completed'],
            'days_since_last_test': user_data['days_since_last_test'],
            'genotype_is_carrier': 1 if user_data['genotype'] in ['MZ', 'MS', 'SZ'] else 0,
            'genotype_is_deficient': 1 if user_data['genotype'] in ['ZZ', 'SS'] else 0,
            'has_viewed_results': user_data['has_viewed_results'],

            # Subscription
            'subscription_months_active': user_data['subscription_months_active'],
            'is_premium_tier': 1 if user_data['tier'] == 'premium' else 0,
            'billing_frequency_annual': 1 if user_data['billing_frequency'] == 'annual' else 0,
            'payment_failures_last_90_days': user_data['payment_failures_last_90_days'],

            # Feature usage
            'wearable_connected': user_data['wearable_connected'],
            'telemedicine_sessions': user_data['telemedicine_sessions'],
            'family_members_invited': user_data['family_members_invited'],

            # Demographics
            'age_bracket': user_data['age_bracket'], # Encoded as integer
            'has_insurance_coverage': user_data['has_insurance_coverage'],

            # Value
            'total_revenue': user_data['total_revenue'],
            'avg_monthly_revenue': user_data['avg_monthly_revenue']
        }

        return pd.DataFrame([features])

    def train(self, training_data: pd.DataFrame):
        """Train churn prediction model"""

        # Separate features and target
        X = training_data.drop(['user_id', 'churned'], axis=1)
        y = training_data['churned']

        # Split
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=42, stratify=y
        )

        # Train
        self.model.fit(X_train, y_train)

        # Evaluate
        y_pred_proba = self.model.predict_proba(X_test)[:, 1]
        auc = roc_auc_score(y_test, y_pred_proba)

        print(f"Model AUC: {auc:.4f}")

        # Feature importance
        self.feature_importance = pd.DataFrame({
            'feature': X.columns,
            'importance': self.model.feature_importances_
        }).sort_values('importance', ascending=False)

        print("\nTop 10 Most Important Features:")
        print(self.feature_importance.head(10))

        # Find optimal threshold (balance precision/recall)
        precision, recall, thresholds = precision_recall_curve(y_test, y_pred_proba)
        f1_scores = 2 * (precision * recall) / (precision + recall + 1e-10)
        optimal_idx = np.argmax(f1_scores)
        self.optimal_threshold = thresholds[optimal_idx]

        print(f"\nOptimal Churn Threshold: {self.optimal_threshold:.4f}")

        # Save model
        joblib.dump(self.model, 'churn_model.pkl')
        joblib.dump(self.optimal_threshold, 'churn_threshold.pkl')

    def predict_churn(self, user_id: str) -> dict:
        """Predict churn probability for a user"""

        features = self.prepare_features(user_id)
        churn_probability = self.model.predict_proba(features)[0][1]

        # Classify risk tier
        if churn_probability >= 0.7:
            risk_tier = 'critical'
            recommended_action = 'immediate_outreach'
        elif churn_probability >= 0.5:
            risk_tier = 'high'
            recommended_action = 'personalized_email'
        elif churn_probability >= 0.3:
            risk_tier = 'medium'
            recommended_action = 'engagement_campaign'
        else:
            risk_tier = 'low'
            recommended_action = 'none'

        # Get top 3 contributing factors
        feature_values = features.iloc[0]
        contributions = []
        for feature, importance in self.feature_importance.head(10).itertuples(index=False):
            if feature_values[feature] > 0:  # Only include active factors
                contributions.append({
                    'factor': feature,
                    'importance': float(importance),
                    'value': float(feature_values[feature])
                })

        contributions = sorted(contributions, key=lambda x: x['importance'], reverse=True)[:3]

        return {
            'user_id': user_id,
            'churn_probability': float(churn_probability),
            'risk_tier': risk_tier,
            'recommended_action': recommended_action,
            'top_contributing_factors': contributions,
            'predicted_at': datetime.now().isoformat()
        }

    def batch_score_users(self, at_risk_threshold: float = 0.3) -> pd.DataFrame:
        """Score all active users for churn risk"""

        # Query all active users
        active_users = self.query_active_users()

        results = []
        for user_id in active_users:
            try:
                prediction = self.predict_churn(user_id)
                if prediction['churn_probability'] >= at_risk_threshold:
                    results.append(prediction)
            except Exception as e:
                print(f"Error scoring user {user_id}: {e}")

        return pd.DataFrame(results).sort_values('churn_probability', ascending=False)
```

**2. Customer Lifetime Value (LTV) Model**:

```python
class LTVPredictionModel:
    def __init__(self):
        self.model = GradientBoostingRegressor(
            n_estimators=200,
            learning_rate=0.05,
            max_depth=5,
            random_state=42
        )

    def prepare_features(self, user_id: str) -> pd.DataFrame:
        """Extract features for LTV prediction"""

        user_data = self.query_user_data(user_id)

        features = {
            # Acquisition
            'acquisition_channel': user_data['acquisition_channel'],  # One-hot encoded
            'days_since_signup': user_data['days_since_signup'],

            # Early behavior (first 30 days)
            'first_month_logins': user_data['first_month_logins'],
            'days_to_first_test': user_data['days_to_first_test'],
            'completed_onboarding': user_data['completed_onboarding'],

            # Engagement
            'avg_monthly_logins': user_data['avg_monthly_logins'],
            'feature_adoption_count': user_data['feature_adoption_count'],  # How many features used

            # Clinical
            'genotype_risk_level': user_data['genotype_risk_level'],  # 0=normal, 1=carrier, 2=deficient
            'total_tests_ordered': user_data['total_tests_ordered'],

            # Social
            'family_members_invited': user_data['family_members_invited'],
            'family_members_joined': user_data['family_members_joined'],

            # Revenue to date
            'total_revenue_to_date': user_data['total_revenue_to_date'],
            'months_subscribed': user_data['months_subscribed'],

            # Subscription tier
            'is_premium': 1 if user_data['tier'] == 'premium' else 0,
            'is_annual_billing': 1 if user_data['billing_frequency'] == 'annual' else 0
        }

        return pd.DataFrame([features])

    def predict_ltv(self, user_id: str, time_horizon_months: int = 36) -> dict:
        """Predict customer lifetime value over next N months"""

        features = self.prepare_features(user_id)
        predicted_ltv = self.model.predict(features)[0]

        # Adjust for time horizon (model trained on 36-month LTV)
        adjusted_ltv = predicted_ltv * (time_horizon_months / 36)

        # Calculate confidence interval (based on model's historical error)
        std_error = 120  # $120 standard error (from model validation)
        confidence_95_lower = adjusted_ltv - (1.96 * std_error)
        confidence_95_upper = adjusted_ltv + (1.96 * std_error)

        # Segment user
        if adjusted_ltv >= 1000:
            value_segment = 'high_value'
        elif adjusted_ltv >= 500:
            value_segment = 'medium_value'
        else:
            value_segment = 'low_value'

        return {
            'user_id': user_id,
            'predicted_ltv': float(adjusted_ltv),
            'confidence_95_lower': float(max(0, confidence_95_lower)),
            'confidence_95_upper': float(confidence_95_upper),
            'value_segment': value_segment,
            'time_horizon_months': time_horizon_months,
            'predicted_at': datetime.now().isoformat()
        }
```

**3. Customer Segmentation (RFM + K-Means)**:

```python
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler

class CustomerSegmentation:
    def __init__(self, n_segments: int = 5):
        self.n_segments = n_segments
        self.model = KMeans(n_clusters=n_segments, random_state=42)
        self.scaler = StandardScaler()

    def calculate_rfm(self, users_df: pd.DataFrame) -> pd.DataFrame:
        """Calculate Recency, Frequency, Monetary scores"""

        reference_date = pd.Timestamp.now()

        rfm = users_df.groupby('user_id').agg({
            'last_activity_date': lambda x: (reference_date - x.max()).days,  # Recency
            'event_id': 'count',  # Frequency
            'revenue_amount': 'sum'  # Monetary
        }).rename(columns={
            'last_activity_date': 'recency',
            'event_id': 'frequency',
            'revenue_amount': 'monetary'
        })

        # Additional features
        rfm['genotype_risk'] = users_df.groupby('user_id')['genotype_risk_level'].first()
        rfm['engagement_score'] = users_df.groupby('user_id')['engagement_score'].first()
        rfm['months_active'] = users_df.groupby('user_id')['months_active'].first()

        return rfm

    def segment_users(self, rfm_df: pd.DataFrame) -> pd.DataFrame:
        """Cluster users into segments"""

        # Standardize features
        features = ['recency', 'frequency', 'monetary', 'engagement_score', 'months_active']
        X = self.scaler.fit_transform(rfm_df[features])

        # Cluster
        rfm_df['segment_id'] = self.model.fit_predict(X)

        # Name segments based on characteristics
        segment_names = {}
        for segment_id in range(self.n_segments):
            segment_data = rfm_df[rfm_df['segment_id'] == segment_id]

            avg_recency = segment_data['recency'].mean()
            avg_frequency = segment_data['frequency'].mean()
            avg_monetary = segment_data['monetary'].mean()

            # Rules-based naming
            if avg_recency < 30 and avg_frequency > 10 and avg_monetary > 500:
                name = 'Champions'
            elif avg_recency < 30 and avg_monetary > 300:
                name = 'Loyal Customers'
            elif avg_monetary > 500:
                name = 'Big Spenders'
            elif avg_recency < 60 and avg_frequency > 5:
                name = 'Potential Loyalists'
            elif avg_recency < 90:
                name = 'Recent Customers'
            elif avg_recency < 180:
                name = 'At Risk'
            elif avg_frequency > 5:
                name = 'Cant Lose Them'
            else:
                name = 'Hibernating'

            segment_names[segment_id] = name

        rfm_df['segment_name'] = rfm_df['segment_id'].map(segment_names)

        return rfm_df

    def get_segment_profiles(self, rfm_df: pd.DataFrame) -> pd.DataFrame:
        """Summarize each segment's characteristics"""

        profiles = rfm_df.groupby('segment_name').agg({
            'recency': 'mean',
            'frequency': 'mean',
            'monetary': 'mean',
            'engagement_score': 'mean',
            'months_active': 'mean',
            'user_id': 'count'
        }).rename(columns={'user_id': 'user_count'})

        profiles['percentage'] = (profiles['user_count'] / profiles['user_count'].sum() * 100).round(1)

        return profiles.sort_values('monetary', ascending=False)
```

---

## API Endpoints

### Analytics Dashboard APIs

```typescript
// GET /api/v1/analytics/kpis - Get key performance indicators
interface DashboardKPIsRequest {
  startDate: string; // ISO date
  endDate: string;
  tenantId?: string; // For partner-specific view
  comparisonPeriod?: 'previous_period' | 'previous_year';
}

interface DashboardKPIsResponse {
  period: {
    startDate: string;
    endDate: string;
  };
  kpis: {
    // User metrics
    totalUsers: number;
    newUsers: number;
    activeUsers: number; // Active in period
    mau: number; // Monthly active users
    dau: number; // Daily active users

    // Engagement
    avgSessionDuration: number; // minutes
    avgLoginsPerUser: number;
    engagementScore: number; // 0-100

    // Testing
    testsOrdered: number;
    testsCompleted: number;
    completionRate: number; // %
    avgTurnaroundTime: number; // hours

    // Findings
    carriersIdentified: number; // MZ, MS, SZ
    deficientsIdentified: number; // ZZ, SS

    // Revenue
    mrr: number; // Monthly recurring revenue
    arr: number; // Annual recurring revenue
    newRevenue: number;
    churnedRevenue: number;
    netRevenue: number;

    // Subscriptions
    activeSubscriptions: number;
    newSubscriptions: number;
    cancelledSubscriptions: number;
    churnRate: number; // %

    // Customer value
    avgLtv: number;
    avgRevenuePerUser: number;

    // Marketing
    cac: number; // Customer acquisition cost
    ltv_cac_ratio: number;
  };
  comparison?: {
    // Each KPI includes % change from comparison period
    totalUsers: { value: number; change: number; changePercent: number };
    // ... (same structure for all KPIs)
  };
}

// GET /api/v1/analytics/cohorts - Cohort retention analysis
interface CohortAnalysisRequest {
  cohortBy: 'signup_month' | 'acquisition_channel' | 'genotype';
  startDate: string;
  endDate: string;
  metricType: 'retention' | 'revenue';
}

interface CohortAnalysisResponse {
  cohorts: {
    cohortId: string; // e.g., '2025-01' or 'facebook'
    cohortName: string; // e.g., 'January 2025' or 'Facebook Ads'
    cohortSize: number;

    // Retention by month
    retention: {
      month0: number; // 100% (baseline)
      month1: number; // % still active in month 1
      month2: number;
      month3: number;
      month6: number;
      month12: number;
    };

    // Revenue by month (if metricType=revenue)
    revenue?: {
      month0: number;
      month1: number;
      month2: number;
      // ...
    };
  }[];

  // Overall trends
  averageRetention: {
    month1: number;
    month3: number;
    month6: number;
    month12: number;
  };
}

// GET /api/v1/analytics/funnel - Conversion funnel analysis
interface FunnelAnalysisRequest {
  funnelType:
    | 'signup_to_test'
    | 'test_to_subscription'
    | 'acquisition_to_revenue';
  startDate: string;
  endDate: string;
  segmentBy?: 'acquisition_channel' | 'genotype' | 'age_bracket';
}

interface FunnelAnalysisResponse {
  funnel: {
    step: string;
    stepNumber: number;
    users: number;
    conversionRate: number; // % from previous step
    dropoffRate: number; // % who didn't continue
    avgTimeToNextStep: number; // hours
  }[];

  // Example for 'signup_to_test':
  // Step 1: Signed up (10,000 users, 100%)
  // Step 2: Completed profile (8,500 users, 85%, 15% dropoff)
  // Step 3: Ordered test (6,000 users, 70%, 30% dropoff)
  // Step 4: Sample collected (5,500 users, 92%, 8% dropoff)
  // Step 5: Results received (5,400 users, 98%, 2% dropoff)

  overallConversionRate: number; // % from step 1 to final step
  avgTimeToComplete: number; // hours from step 1 to final step

  // If segmented
  segments?: {
    segmentName: string;
    funnel: typeof this.funnel;
    overallConversionRate: number;
  }[];
}

// GET /api/v1/analytics/churn-risk - Churn risk report
interface ChurnRiskRequest {
  riskTier?: 'critical' | 'high' | 'medium' | 'low';
  minProbability?: number; // 0.0 - 1.0
  limit?: number;
  offset?: number;
}

interface ChurnRiskResponse {
  atRiskUsers: {
    userId: string;
    userName: string;
    email: string;
    churnProbability: number;
    riskTier: string;
    topRiskFactors: {
      factor: string;
      importance: number;
    }[];
    recommendedAction: string;
    lastActivity: string;
    monthsActive: number;
    currentLtv: number;
  }[];

  summary: {
    totalAtRisk: number;
    criticalRisk: number;
    highRisk: number;
    mediumRisk: number;
    potentialRevenueAtRisk: number; // Total LTV of at-risk users
  };
}

// POST /api/v1/analytics/segment-users - Create custom user segment
interface CreateSegmentRequest {
  segmentName: string;
  criteria: {
    genotype?: string[];
    riskCategory?: string[];
    engagementScore?: { min: number; max: number };
    ltv?: { min: number; max: number };
    daysSinceSignup?: { min: number; max: number };
    acquisitionChannel?: string[];
    hasWearable?: boolean;
    subscriptionStatus?: string[];
  };
}

interface CreateSegmentResponse {
  segmentId: string;
  segmentName: string;
  userCount: number;
  avgLtv: number;
  avgEngagementScore: number;
  demographics: {
    genotypes: { [key: string]: number };
    ageRanges: { [key: string]: number };
    states: { [key: string]: number };
  };
}
```

### Partner ROI APIs

```typescript
// GET /api/v1/analytics/partner-roi - Partner ROI dashboard
interface PartnerROIRequest {
  tenantId: string; // Partner/tenant ID
  includeProjections?: boolean; // Include 5-year projections
}

interface PartnerROIResponse {
  partner: {
    tenantId: string;
    partnerName: string;
    contractStartDate: string;
    monthsSinceLaunch: number;
  };

  population: {
    totalEmployees: number;
    employeesInvited: number;
    employeesTested: number;
    testCompletionRate: number; // %
  };

  findings: {
    normalResults: number; // MM genotype
    carriersIdentified: number; // MZ, MS, SZ
    deficientsIdentified: number; // ZZ, SS
    highRiskPatients: number; // ZZ + symptoms

    // Breakdown by genotype
    byGenotype: {
      MM: number;
      MZ: number;
      ZZ: number;
      MS: number;
      SS: number;
      SZ: number;
      null: number; // Rare variants
    };
  };

  costAnalysis: {
    programCosts: {
      testingCosts: number; // $250-500 per test
      subscriptionCosts: number; // Monthly subscriptions
      platformFees: number;
      totalProgramCost: number;
    };

    costPerMetrics: {
      costPerEmployee: number;
      costPerTest: number;
      costPerPositive: number; // Cost per carrier/deficient found
    };
  };

  roi: {
    // Based on published AATD healthcare cost studies
    baselineHealthcareCost: number; // Without early detection
    projectedHealthcareCost: number; // With early detection & intervention
    totalCostSavings: number;
    roiPercentage: number; // (savings - program_cost) / program_cost * 100
    breakEvenMonths: number; // When savings > costs

    // 5-year projection (if requested)
    fiveYearProjection?: {
      year1: { programCost: number; savings: number; netROI: number };
      year2: { programCost: number; savings: number; netROI: number };
      year3: { programCost: number; savings: number; netROI: number };
      year4: { programCost: number; savings: number; netROI: number };
      year5: { programCost: number; savings: number; netROI: number };
      cumulativeROI: number;
    };
  };

  engagement: {
    activeSubscribers: number;
    avgEngagementScore: number;
    wearableConnections: number;
    telemedicineConsultations: number;
    avgLoginFrequency: number; // per month
  };

  healthOutcomes: {
    earlyInterventions: number; // Patients started treatment before symptoms
    hospitalAdmissionsPrevented: number; // Estimated
    smokingCessations: number;
    patientsOnAugmentationTherapy: number;
  };

  comparisons: {
    industryBenchmark: {
      avgTestCompletionRate: number;
      avgCarrierRate: number; // Industry: 2-4%
      avgROI: number;
    };
    vsIndustry: {
      testCompletionRateDiff: number; // % difference
      carrierDetectionRateDiff: number;
      roiDiff: number;
    };
  };
}

// GET /api/v1/analytics/partner-reports - Generate downloadable report
interface GeneratePartnerReportRequest {
  tenantId: string;
  reportType: 'quarterly' | 'annual' | 'executive_summary';
  format: 'pdf' | 'excel' | 'powerpoint';
  includeCharts?: boolean;
}

interface GeneratePartnerReportResponse {
  reportId: string;
  downloadUrl: string; // Pre-signed S3 URL
  expiresAt: string; // URL expires after 24 hours
  generatedAt: string;
}
```

---

## Dashboards & Visualizations

### Internal Operations Dashboard

**Key Metrics Cards**:

```
┌─────────────────────────────────────────────────────────────────┐
│  📊 Operations Dashboard - November 2025                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │   MAU        │  │   MRR        │  │  Churn Rate  │         │
│  │   12,450     │  │   $186,750   │  │   2.8%       │         │
│  │   ↑ 8.2%     │  │   ↑ 12.5%    │  │   ↓ 0.5%     │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │Tests/Month   │  │ Avg LTV      │  │ LTV:CAC      │         │
│  │   1,850      │  │   $1,248     │  │   3.2:1      │         │
│  │   ↑ 5.1%     │  │   ↑ 4.8%     │  │   ↑ 0.3      │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

**Cohort Retention Heatmap**:

```
Signup Month │ M0  │ M1  │ M2  │ M3  │ M6  │ M12 │
──────────────┼─────┼─────┼─────┼─────┼─────┼─────┤
Jan 2025     │100% │ 85% │ 78% │ 72% │ 65% │ 58% │
Feb 2025     │100% │ 87% │ 80% │ 75% │ 68% │  -  │
Mar 2025     │100% │ 89% │ 82% │ 77% │ 70% │  -  │
Apr 2025     │100% │ 90% │ 84% │ 79% │  -  │  -  │
May 2025     │100% │ 88% │ 83% │  -  │  -  │  -  │

🟢 >80%  🟡 60-80%  🔴 <60%
```

**Funnel Conversion**:

```
Signup to First Test Completed
─────────────────────────────────────────────
│████████████████████████████████████│ 10,000  Signed Up
│████████████████████████████████    │  8,500  Completed Profile (85%)
│████████████████████                │  6,000  Ordered Test (71%)
│███████████████████                 │  5,500  Sample Collected (92%)
│██████████████████                  │  5,400  Results Received (98%)
─────────────────────────────────────────────
Overall Conversion: 54%
Avg Time to Complete: 18 days
```

### Partner ROI Dashboard (White-labeled)

```
┌───────────────────────────────────────────────────────────────┐
│  Acme Insurance - AATD Screening Program Results              │
│  Program Launch: January 2025  |  Reporting Period: 10 months │
├───────────────────────────────────────────────────────────────┤
│                                                                │
│  🏢 PROGRAM OVERVIEW                                          │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │ Total Employees:           5,000                         │ │
│  │ Employees Invited:         4,200  (84%)                  │ │
│  │ Tests Completed:           2,800  (67% completion)       │ │
│  │ Active Subscribers:        2,650  (95% subscribed)       │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                                │
│  🧬 GENETIC FINDINGS                                          │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │ Normal (MM):               2,548  (91%)                  │ │
│  │ MZ Carriers:                 224  (8.0%)  ← Industry: 2-4%│ │
│  │ ZZ Deficient:                 18  (0.6%)  ← Rare         │ │
│  │ Other Variants (MS/SZ/SS):    10  (0.4%)                 │ │
│  │                                                           │ │
│  │ High-Risk Patients:           28  (require monitoring)   │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                                │
│  💰 COST-BENEFIT ANALYSIS                                     │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │ Program Investment:                                       │ │
│  │  - Testing Costs:          $700,000  ($250/test)         │ │
│  │  - Subscriptions:           $79,500  ($30/user/year)     │ │
│  │  - Platform Fees:           $50,000                       │ │
│  │  Total Program Cost:       $829,500                       │ │
│  │                                                           │ │
│  │ Projected Cost Savings (5 years):                        │ │
│  │  - Early COPD prevention:  $1,850,000                    │ │
│  │  - Liver disease avoid:      $480,000                    │ │
│  │  - Hospitalization reduced:  $320,000                    │ │
│  │  Total Savings:            $2,650,000                    │ │
│  │                                                           │ │
│  │ NET ROI:                   +$1,820,500  (220%)           │ │
│  │ Breakeven:                  Month 18                      │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                                │
│  📈 5-YEAR PROJECTION                                         │
│   $3M ┐                              ╱                        │
│       │                          ╱                            │
│   $2M │                      ╱                                │
│       │    Program Cost  ╱   Projected Savings               │
│   $1M │            ╱─────                                     │
│       │        ╱                                              │
│    $0 ├────────────────────────────────                      │
│       Year1  Year2  Year3  Year4  Year5                      │
│                                                                │
│  ✅ KEY ACHIEVEMENTS                                          │
│  • 67% test completion (industry avg: 45%)                   │
│  • 8% carrier detection (2x industry baseline)               │
│  • 28 high-risk patients receiving early intervention        │
│  • 15 employees started augmentation therapy                 │
│  • 42 smoking cessations (critical for AATD)                 │
│                                                                │
│  [Download Full Report]  [Share with Leadership]             │
└───────────────────────────────────────────────────────────────┘
```

---

## Success Metrics

### Data Quality

- **ETL Pipeline Uptime**: 99.9%
- **Data Freshness**: < 15 minutes lag from production to warehouse
- **Data Accuracy**: 99.5% (validated against production DB)

### Adoption (Internal)

- **Dashboard DAU**: 25 daily active users (product, marketing, exec teams)
- **Report Generation**: 150 reports/month
- **Data-Driven Decisions**: 80% of strategic decisions backed by analytics

### Partner Satisfaction

- **Partner ROI Dashboard Usage**: 85% of partners log in monthly
- **QBR Preparation Time**: Reduced from 8 hours to 30 minutes
- **Partner Renewals**: 95% renewal rate (up from 75%)
- **Net Promoter Score**: 72 (excellent)

### Business Impact

- **Churn Reduction**: 25% decrease in churn (from 3.5% to 2.6% monthly)
- **CAC Optimization**: 30% reduction through channel reallocation
- **LTV Increase**: 35% increase through targeted upselling
- **Revenue Recovery**: $125K/year from churn prevention campaigns

---

## Implementation Plan

### Phase 1: Foundation (Months 1-2)

**Goal**: Data pipeline + warehouse setup

- **Week 1-2**: Requirements gathering, tool selection (Airbyte vs. Fivetran, Snowflake vs. BigQuery)
- **Week 3-4**: Set up data warehouse, create initial schema (fact_user_events, dim_users)
- **Week 5-6**: Build ETL pipelines for core tables (users, tests, subscriptions)
- **Week 7-8**: Data validation, quality checks, backfill historical data

**Deliverables**:

- Data warehouse operational
- Core tables populated
- ETL running every 15 minutes

### Phase 2: ML Models (Month 3)

**Goal**: Churn prediction + LTV models

- **Week 9-10**: Feature engineering, model training (churn prediction)
- **Week 11-12**: LTV model development, customer segmentation

**Deliverables**:

- Churn prediction model (AUC > 0.80)
- LTV prediction model (R² > 0.75)
- Daily batch scoring of all users

### Phase 3: Dashboards (Month 4)

**Goal**: Internal operations dashboard

- **Week 13-14**: Design dashboard UX, build KPI cards
- **Week 15-16**: Cohort analysis, funnel visualization, churn risk list

**Deliverables**:

- Operations dashboard live
- 15+ key metrics tracked
- Real-time updates (< 15 min lag)

### Phase 4: Partner ROI (Month 5)

**Goal**: White-labeled partner dashboards

- **Week 17-18**: Partner ROI calculation logic, cost savings models
- **Week 19-20**: White-labeled dashboard, PDF report generation

**Deliverables**:

- Partner ROI dashboard
- Automated quarterly reports
- 5-year projection models

---

## Budget Estimate

### Development (4-5 months)

- **Data Engineer**: $160K/year × 0.42 years = $67,200
- **Data Scientist** (ML models): $160K/year × 0.25 years = $40,000
- **Backend Developer** (APIs): $140K/year × 0.33 years = $46,200
- **Frontend Developer** (dashboards): $140K/year × 0.25 years = $35,000

**Total Development**: ~$188,400

### Annual Infrastructure

- **Snowflake** (data warehouse): $1,500/month × 12 = $18,000
- **Airbyte Cloud** (ETL): $500/month × 12 = $6,000
- **Looker** (BI tool, optional): $1,000/month × 12 = $12,000
- **Compute** (ML training): $200/month × 12 = $2,400

**Total Infrastructure**: ~$38,400/year

### **GRAND TOTAL (First Year)**: ~$226,800

---

## Risks & Mitigations

### Risk 1: Data Quality Issues

**Impact**: Inaccurate insights → bad decisions
**Mitigation**: Automated data validation, anomaly detection, manual QA spot-checks

### Risk 2: Model Drift

**Impact**: Churn model becomes less accurate over time
**Mitigation**: Monthly model retraining, A/B test new models, monitor AUC trends

### Risk 3: Dashboard Overload

**Impact**: Too many metrics → analysis paralysis
**Mitigation**: Start with 15 core KPIs, add more based on user requests

### Risk 4: Privacy Concerns

**Impact**: Partners concerned about data sharing
**Mitigation**: Aggregate-only data in partner dashboards (no PII), clear data usage policies

### Risk 5: ROI Calculation Disputes

**Impact**: Partners question savings projections
**Mitigation**: Base calculations on peer-reviewed AATD cost studies, clearly document assumptions, conservative estimates

---

**Document Owner**: VP Product, CTO
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
