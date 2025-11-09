# Uniting Doctors - Analytics Strategy

**Version**: 1.0
**Last Updated**: November 8, 2025
**Status**: Planning Phase

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Analytics Goals](#analytics-goals)
3. [Key Performance Indicators](#key-performance-indicators)
4. [Data Collection](#data-collection)
5. [Event Taxonomy](#event-taxonomy)
6. [User Behavior Tracking](#user-behavior-tracking)
7. [A/B Testing Framework](#ab-testing-framework)
8. [Dashboards & Reporting](#dashboards--reporting)
9. [Data Privacy](#data-privacy)
10. [Analytics Infrastructure](#analytics-infrastructure)
11. [Business Intelligence](#business-intelligence)
12. [Predictive Analytics](#predictive-analytics)

---

## 🎯 Overview

Uniting Doctors analytics strategy focuses on data-driven decision making while respecting user privacy. Our analytics inform product development, measure business success, and improve user experience.

### Analytics Principles

1. **Privacy-First**: Collect only necessary data, anonymize where possible
2. **Actionable**: Every metric should drive decisions
3. **Transparent**: Users understand what data we collect
4. **Compliant**: GDPR, HIPAA, CCPA adherence
5. **Real-Time**: Dashboards update in near real-time

---

## 🎯 Analytics Goals

### Product Goals

- Understand user behavior and engagement patterns
- Identify friction points in user journey
- Measure feature adoption and usage
- Optimize content discovery and recommendation
- Improve retention and reduce churn

### Business Goals

- Track revenue and monetization metrics
- Measure marketing campaign effectiveness
- Forecast growth and resource needs
- Identify high-value user segments
- Optimize pricing and packaging

### Technical Goals

- Monitor application performance
- Track errors and exceptions
- Measure API usage and latency
- Optimize infrastructure costs
- Identify scaling bottlenecks

---

## 📊 Key Performance Indicators

### North Star Metric

**Weekly Active Medical Professionals (WAMP)**

- Primary success metric
- Represents engaged, verified healthcare providers
- Target: 10,000 WAMP by end of Year 1

### User Acquisition Metrics

| Metric                     | Definition                       | Target (Month 12) |
| -------------------------- | -------------------------------- | ----------------- |
| **New Registrations**      | Users who complete signup        | 5,000/month       |
| **Verification Rate**      | % of users who get verified      | 70%               |
| **Time to Verification**   | Days from signup to verification | <3 days (median)  |
| **Acquisition Cost (CAC)** | Marketing spend / new users      | <$50              |
| **Organic Growth Rate**    | % growth from referrals          | 20%               |

### Engagement Metrics

| Metric                 | Definition                          | Target     |
| ---------------------- | ----------------------------------- | ---------- |
| **DAU/MAU Ratio**      | Daily Active / Monthly Active Users | 30%        |
| **Session Duration**   | Average time per session            | 12 minutes |
| **Sessions per User**  | Sessions per user per week          | 4          |
| **Post Creation Rate** | Posts per active user per week      | 0.5        |
| **Comment Rate**       | Comments per post                   | 8          |
| **Read Ratio**         | Users who read vs just browse       | 60%        |

### Content Quality Metrics

| Metric                   | Definition                       | Target |
| ------------------------ | -------------------------------- | ------ |
| **Citation Rate**        | % posts with references          | 40%    |
| **Evidence-Based Posts** | % posts with evidence level      | 60%    |
| **Upvote Ratio**         | Upvotes / (Upvotes + Downvotes)  | 85%    |
| **Answer Rate**          | % questions that get answered    | 80%    |
| **Accepted Answer Rate** | % questions with accepted answer | 50%    |
| **Moderation Flag Rate** | % content flagged                | <2%    |

### Retention Metrics

| Metric                | Definition                          | Target |
| --------------------- | ----------------------------------- | ------ |
| **D1 Retention**      | % users active 1 day after signup   | 50%    |
| **D7 Retention**      | % users active 7 days after signup  | 35%    |
| **D30 Retention**     | % users active 30 days after signup | 20%    |
| **Churn Rate**        | % users who stop using (monthly)    | <5%    |
| **Resurrection Rate** | % churned users who return          | 15%    |

### Monetization Metrics

| Metric                 | Definition                         | Target (Month 12) |
| ---------------------- | ---------------------------------- | ----------------- |
| **Premium Conversion** | % users who upgrade to premium     | 5%                |
| **ARPU**               | Average revenue per user (monthly) | $1.25             |
| **LTV**                | Lifetime value per user            | $150              |
| **LTV/CAC Ratio**      | Lifetime value / acquisition cost  | 3:1               |
| **MRR**                | Monthly recurring revenue          | $30,000           |
| **Churn MRR**          | Revenue lost to churn              | <$1,500/month     |

### Research Metrics

| Metric                    | Definition                      | Target |
| ------------------------- | ------------------------------- | ------ |
| **Papers Shared**         | Research papers shared per week | 200    |
| **Paper Discussion Rate** | % papers with discussion        | 30%    |
| **Search Success Rate**   | % searches with clicks          | 75%    |
| **Semantic Search Usage** | % searches using semantic       | 40%    |

---

## 📥 Data Collection

### Data Collection Stack

```typescript
// Analytics configuration
const analyticsConfig = {
  // Client-side analytics
  mixpanel: {
    token: process.env.MIXPANEL_TOKEN,
    config: {
      api_host: 'https://api.mixpanel.com',
      persistence: 'localStorage',
      ignore_dnt: false, // Respect Do Not Track
      secure_cookie: true
    }
  },

  // Server-side analytics
  segment: {
    writeKey: process.env.SEGMENT_WRITE_KEY,
    flushAt: 20,
    flushInterval: 10000
  },

  // Product analytics
  amplitude: {
    apiKey: process.env.AMPLITUDE_API_KEY,
    options: {
      saveEvents: true,
      includeUtm: true,
      includeReferrer: true
    }
  }
};
```

### Data Collection Methods

#### 1. Client-Side Tracking

```typescript
// analytics.ts - Client-side tracking
import mixpanel from 'mixpanel-browser';
import { Analytics } from '@segment/analytics-next';

class AnalyticsService {
  private mixpanel: typeof mixpanel;
  private segment: Analytics;
  private userId?: string;

  initialize(userId?: string) {
    this.userId = userId;

    // Initialize Mixpanel
    mixpanel.init(process.env.NEXT_PUBLIC_MIXPANEL_TOKEN!);

    // Initialize Segment
    this.segment = Analytics.load({
      writeKey: process.env.NEXT_PUBLIC_SEGMENT_KEY!
    });

    // Identify user
    if (userId) {
      this.identify(userId);
    }
  }

  identify(userId: string, traits?: Record<string, any>) {
    this.userId = userId;

    mixpanel.identify(userId);
    this.segment.identify(userId, traits);

    if (traits) {
      mixpanel.people.set(traits);
    }
  }

  track(event: string, properties?: Record<string, any>) {
    const enrichedProperties = {
      ...properties,
      timestamp: new Date().toISOString(),
      page: window.location.pathname,
      referrer: document.referrer
    };

    mixpanel.track(event, enrichedProperties);
    this.segment.track(event, enrichedProperties);
  }

  page(name: string, properties?: Record<string, any>) {
    this.segment.page(name, properties);
  }
}

export const analytics = new AnalyticsService();
```

#### 2. Server-Side Tracking

```typescript
// server-analytics.ts
import Analytics from 'analytics-node';

const segment = new Analytics(process.env.SEGMENT_WRITE_KEY!);

export function trackServerEvent(
  userId: string,
  event: string,
  properties?: Record<string, any>
) {
  segment.track({
    userId,
    event,
    properties: {
      ...properties,
      timestamp: new Date()
    }
  });
}

export function identifyUser(userId: string, traits: Record<string, any>) {
  segment.identify({
    userId,
    traits
  });
}
```

---

## 📝 Event Taxonomy

### Event Naming Convention

Format: `{Object}_{Action}`

Examples:

- `user_signed_up`
- `post_created`
- `comment_upvoted`
- `paper_shared`

### Core Events

#### Authentication Events

```typescript
// User signed up
analytics.track('user_signed_up', {
  method: 'email' | 'google' | 'apple',
  specialty: string,
  practice_setting: string,
  referral_source?: string
});

// User logged in
analytics.track('user_logged_in', {
  method: 'email' | 'google' | 'apple',
  session_count: number,
  days_since_last_login: number
});

// User verified
analytics.track('user_verified', {
  verification_method: 'npi' | 'manual',
  days_since_signup: number
});
```

#### Content Events

```typescript
// Post created
analytics.track('post_created', {
  post_id: string,
  is_question: boolean,
  is_anonymous: boolean,
  has_evidence_level: boolean,
  evidence_level?: string,
  tag_count: number,
  image_count: number,
  reference_count: number,
  word_count: number
});

// Post viewed
analytics.track('post_viewed', {
  post_id: string,
  post_age_days: number,
  view_duration_seconds: number,
  scroll_depth_percent: number,
  author_reputation: number
});

// Comment created
analytics.track('comment_created', {
  comment_id: string,
  post_id: string,
  is_reply: boolean,
  parent_comment_id?: string,
  word_count: number,
  has_references: boolean
});

// Vote cast
analytics.track('vote_cast', {
  vote_type: 'upvote' | 'downvote',
  content_type: 'post' | 'comment',
  content_id: string,
  author_reputation: number
});
```

#### Engagement Events

```typescript
// Search performed
analytics.track('search_performed', {
  query: string, // Hashed for privacy
  search_type: 'keyword' | 'semantic',
  result_count: number,
  filter_specialty?: string,
  filter_evidence_level?: string
});

// Paper shared
analytics.track('paper_shared', {
  pmid: string,
  source: 'search' | 'feed' | 'external',
  has_commentary: boolean,
  tag_count: number
});

// User followed
analytics.track('user_followed', {
  followed_user_id: string,
  followed_user_reputation: number,
  followed_user_specialty: string
});

// Group joined
analytics.track('group_joined', {
  group_id: string,
  group_category: string,
  member_count: number
});
```

#### Monetization Events

```typescript
// Premium viewed
analytics.track('premium_viewed', {
  source: 'banner' | 'paywall' | 'settings',
  feature_locked?: string
});

// Premium purchased
analytics.track('premium_purchased', {
  plan: 'monthly' | 'annual',
  price: number,
  currency: 'USD',
  payment_method: string,
  days_since_signup: number
});

// Premium cancelled
analytics.track('premium_cancelled', {
  reason?: string,
  days_subscribed: number,
  cancellation_method: 'self_service' | 'support'
});
```

---

## 👤 User Behavior Tracking

### User Journey Mapping

```typescript
// Track complete user journey
interface UserJourney {
  userId: string;
  stages: {
    stage:
      | 'awareness'
      | 'signup'
      | 'activation'
      | 'engagement'
      | 'retention'
      | 'monetization';
    timestamp: Date;
    events: string[];
  }[];
}

// Activation funnel
const activationSteps = [
  'user_signed_up',
  'user_verified',
  'profile_completed',
  'first_post_viewed',
  'first_interaction' // comment, vote, or post
];

// Track funnel completion
function trackFunnelStep(userId: string, step: string) {
  analytics.track('funnel_step_completed', {
    funnel: 'activation',
    step,
    step_index: activationSteps.indexOf(step),
    days_since_signup: calculateDaysSinceSignup(userId)
  });
}
```

### Cohort Analysis

```typescript
// Define cohorts
enum CohortType {
  SIGNUP_WEEK = 'signup_week', // Users who signed up same week
  SPECIALTY = 'specialty', // Users in same specialty
  ACQUISITION_CHANNEL = 'channel', // Users from same source
  ENGAGEMENT_LEVEL = 'engagement' // High/medium/low engagement
}

// Track cohort metrics
async function analyzeCohort(
  cohortType: CohortType,
  cohortId: string,
  metric: string
) {
  const users = await getCohortUsers(cohortType, cohortId);

  const metrics = await Promise.all(
    users.map((user) => calculateMetric(user.id, metric))
  );

  return {
    cohort: { type: cohortType, id: cohortId },
    metric,
    avg: average(metrics),
    median: median(metrics),
    p90: percentile(metrics, 90),
    distribution: histogram(metrics)
  };
}
```

### Session Analysis

```typescript
// Track session details
interface SessionData {
  session_id: string;
  user_id: string;
  start_time: Date;
  end_time?: Date;
  duration_seconds?: number;
  page_views: number;
  events: {
    event_name: string;
    timestamp: Date;
  }[];
  device: {
    type: 'desktop' | 'mobile' | 'tablet';
    os: string;
    browser: string;
  };
  referrer?: string;
  utm_source?: string;
  utm_medium?: string;
  utm_campaign?: string;
}

// Session tracking
class SessionTracker {
  private sessionId: string;
  private startTime: Date;
  private events: Array<{ event: string; timestamp: Date }> = [];

  constructor() {
    this.sessionId = generateSessionId();
    this.startTime = new Date();

    // Track session start
    analytics.track('session_started', {
      session_id: this.sessionId
    });

    // Track session end on page unload
    window.addEventListener('beforeunload', () => this.endSession());
  }

  trackEvent(event: string) {
    this.events.push({
      event,
      timestamp: new Date()
    });
  }

  endSession() {
    const duration = (Date.now() - this.startTime.getTime()) / 1000;

    analytics.track('session_ended', {
      session_id: this.sessionId,
      duration_seconds: duration,
      event_count: this.events.length,
      pages_visited: this.getUniquePages()
    });
  }

  private getUniquePages(): number {
    const pages = this.events
      .filter((e) => e.event === 'page_viewed')
      .map((e) => window.location.pathname);
    return new Set(pages).size;
  }
}
```

---

## 🧪 A/B Testing Framework

### Experiment Infrastructure

```typescript
// experiment.ts - A/B testing framework
import { PostHog } from 'posthog-js';

interface Experiment {
  id: string;
  name: string;
  hypothesis: string;
  variants: {
    id: string;
    name: string;
    allocation: number; // Percentage (0-100)
  }[];
  metrics: {
    primary: string;
    secondary: string[];
  };
  startDate: Date;
  endDate?: Date;
  status: 'draft' | 'running' | 'completed' | 'cancelled';
}

class ExperimentService {
  private posthog: PostHog;

  constructor() {
    this.posthog = PostHog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY!, {
      api_host: 'https://app.posthog.com'
    });
  }

  // Get variant for user
  getVariant(experimentId: string, userId: string): string {
    return (this.posthog.getFeatureFlag(experimentId) as string) || 'control';
  }

  // Track experiment exposure
  trackExposure(experimentId: string, variant: string) {
    analytics.track('experiment_exposure', {
      experiment_id: experimentId,
      variant
    });
  }

  // Track experiment conversion
  trackConversion(experimentId: string, metric: string, value?: number) {
    analytics.track('experiment_conversion', {
      experiment_id: experimentId,
      metric,
      value
    });
  }
}

export const experiments = new ExperimentService();
```

### Example Experiments

#### Experiment 1: Onboarding Flow

```typescript
const onboardingExperiment: Experiment = {
  id: 'onboarding_v2',
  name: 'Simplified Onboarding',
  hypothesis: 'Reducing onboarding steps will increase completion rate',
  variants: [
    { id: 'control', name: 'Original (5 steps)', allocation: 50 },
    { id: 'variant', name: 'Simplified (3 steps)', allocation: 50 }
  ],
  metrics: {
    primary: 'onboarding_completion_rate',
    secondary: ['time_to_first_post', 'd7_retention']
  },
  startDate: new Date('2025-11-15'),
  status: 'running'
};

// Implementation
function OnboardingFlow() {
  const variant = experiments.getVariant('onboarding_v2', user.id);

  useEffect(() => {
    experiments.trackExposure('onboarding_v2', variant);
  }, [variant]);

  if (variant === 'variant') {
    return <SimplifiedOnboarding />;
  }

  return <OriginalOnboarding />;
}
```

#### Experiment 2: Feed Algorithm

```typescript
const feedAlgorithmExperiment: Experiment = {
  id: 'feed_algo_v3',
  name: 'Reputation-Weighted Feed',
  hypothesis:
    'Showing posts from higher-reputation users will increase engagement',
  variants: [
    { id: 'control', name: 'Chronological + Trending', allocation: 50 },
    { id: 'variant', name: 'Reputation-Weighted', allocation: 50 }
  ],
  metrics: {
    primary: 'session_duration',
    secondary: ['posts_viewed', 'engagement_rate', 'd7_retention']
  },
  startDate: new Date('2025-11-20'),
  status: 'running'
};

// Server-side implementation
async function getFeed(userId: string, page: number) {
  const variant = await experiments.getVariant('feed_algo_v3', userId);

  let posts;
  if (variant === 'variant') {
    posts = await getReputationWeightedFeed(userId, page);
  } else {
    posts = await getChronologicalFeed(userId, page);
  }

  return posts;
}
```

### Statistical Significance

```typescript
// Calculate statistical significance
function calculateSignificance(
  controlConversions: number,
  controlTotal: number,
  variantConversions: number,
  variantTotal: number
): {
  pValue: number;
  significant: boolean;
  lift: number;
} {
  const controlRate = controlConversions / controlTotal;
  const variantRate = variantConversions / variantTotal;

  // Z-test for proportions
  const pooledRate =
    (controlConversions + variantConversions) / (controlTotal + variantTotal);

  const se = Math.sqrt(
    pooledRate * (1 - pooledRate) * (1 / controlTotal + 1 / variantTotal)
  );

  const zScore = (variantRate - controlRate) / se;
  const pValue = 2 * (1 - normalCDF(Math.abs(zScore)));

  return {
    pValue,
    significant: pValue < 0.05,
    lift: ((variantRate - controlRate) / controlRate) * 100
  };
}
```

---

## 📈 Dashboards & Reporting

### Executive Dashboard

**Metrics**:

- Total users (verified)
- Weekly active users (WAMP)
- Monthly recurring revenue (MRR)
- User growth rate
- Engagement metrics (DAU/MAU, session duration)
- Content metrics (posts/day, citation rate)

```typescript
// Executive dashboard data
async function getExecutiveDashboard(dateRange: DateRange) {
  const [userStats, engagementStats, revenueStats, contentStats] =
    await Promise.all([
      getUserStats(dateRange),
      getEngagementStats(dateRange),
      getRevenueStats(dateRange),
      getContentStats(dateRange)
    ]);

  return {
    users: {
      total: userStats.total,
      verified: userStats.verified,
      active_monthly: userStats.mau,
      active_weekly: userStats.wau,
      growth_rate: userStats.growthRate
    },
    engagement: {
      dau_mau_ratio: engagementStats.dauMauRatio,
      avg_session_duration: engagementStats.avgSessionDuration,
      sessions_per_user: engagementStats.sessionsPerUser
    },
    revenue: {
      mrr: revenueStats.mrr,
      arr: revenueStats.arr,
      arpu: revenueStats.arpu,
      ltv: revenueStats.ltv,
      premium_users: revenueStats.premiumUsers,
      conversion_rate: revenueStats.conversionRate
    },
    content: {
      posts_per_day: contentStats.postsPerDay,
      comments_per_post: contentStats.commentsPerPost,
      citation_rate: contentStats.citationRate,
      papers_shared: contentStats.papersShared
    }
  };
}
```

### Product Dashboard

**Metrics**:

- Feature adoption rates
- User journey funnels
- A/B test results
- Retention cohorts
- Engagement by specialty

### Engineering Dashboard

**Metrics**:

- API response times (p50, p95, p99)
- Error rates
- Database query performance
- Cache hit rates
- Infrastructure costs

### Real-Time Dashboard

```typescript
// Real-time analytics using WebSocket
import { Server } from 'socket.io';

const io = new Server(server);

// Stream real-time metrics
io.on('connection', (socket) => {
  const interval = setInterval(async () => {
    const metrics = await getRealTimeMetrics();
    socket.emit('metrics_update', metrics);
  }, 5000); // Update every 5 seconds

  socket.on('disconnect', () => {
    clearInterval(interval);
  });
});

async function getRealTimeMetrics() {
  return {
    active_users: await getActiveUsersCount(),
    posts_last_hour: await getPostsCount('1h'),
    comments_last_hour: await getCommentsCount('1h'),
    api_requests_per_minute: await getAPIRequestRate(),
    avg_response_time: await getAvgResponseTime()
  };
}
```

---

## 🔒 Data Privacy

### Privacy-Compliant Analytics

```typescript
// Anonymize sensitive data
function anonymizeEvent(event: string, properties: Record<string, any>) {
  const sensitiveFields = ['email', 'ip_address', 'phone', 'full_name'];

  const anonymized = { ...properties };

  // Remove sensitive fields
  sensitiveFields.forEach((field) => {
    delete anonymized[field];
  });

  // Hash user identifiers
  if (anonymized.user_id) {
    anonymized.user_id = hashUserId(anonymized.user_id);
  }

  // Remove PII from text fields
  if (anonymized.content) {
    anonymized.content = redactPII(anonymized.content);
  }

  return anonymized;
}

// Consent management
interface ConsentPreferences {
  analytics: boolean;
  marketing: boolean;
  personalization: boolean;
}

function trackWithConsent(
  event: string,
  properties: Record<string, any>,
  consent: ConsentPreferences
) {
  if (consent.analytics) {
    const anonymized = anonymizeEvent(event, properties);
    analytics.track(event, anonymized);
  }
}
```

### GDPR Compliance

```typescript
// Data export for GDPR requests
async function exportUserData(userId: string) {
  const [profile, posts, comments, votes, searches, analytics] =
    await Promise.all([
      getUserProfile(userId),
      getUserPosts(userId),
      getUserComments(userId),
      getUserVotes(userId),
      getUserSearches(userId),
      getUserAnalytics(userId)
    ]);

  return {
    profile,
    content: { posts, comments, votes },
    activity: { searches },
    analytics: {
      events: analytics.events,
      sessions: analytics.sessions
    }
  };
}

// Data deletion for GDPR requests
async function deleteUserAnalytics(userId: string) {
  // Anonymize in analytics platforms
  await mixpanel.people.delete_user(userId);
  await segment.identify(userId, { deleted: true });

  // Delete from data warehouse
  await dataWarehouse.deleteUserData(userId);

  // Keep aggregated/anonymized data
  await dataWarehouse.aggregateUserData(userId);
}
```

---

## 🏗️ Analytics Infrastructure

### Data Pipeline

```
┌──────────────────────────────────────────────────────────┐
│                    DATA SOURCES                          │
│  • Web App Events                                        │
│  • Mobile App Events                                     │
│  • API Server Logs                                       │
│  • Database Queries                                      │
└─────────────────┬────────────────────────────────────────┘
                  │
┌─────────────────▼────────────────────────────────────────┐
│              DATA COLLECTION                             │
│  • Segment (client + server SDK)                         │
│  • Custom event tracking                                 │
│  • Server logs (CloudWatch, DataDog)                     │
└─────────────────┬────────────────────────────────────────┘
                  │
┌─────────────────▼────────────────────────────────────────┐
│              DATA PROCESSING                             │
│  • AWS Kinesis (stream processing)                       │
│  • Lambda functions (enrichment)                         │
│  • dbt (transformation)                                  │
└─────────────────┬────────────────────────────────────────┘
                  │
┌─────────────────▼────────────────────────────────────────┐
│              DATA STORAGE                                │
│  • Redshift (data warehouse)                             │
│  • S3 (raw event storage)                                │
│  • PostgreSQL (metrics cache)                            │
└─────────────────┬────────────────────────────────────────┘
                  │
┌─────────────────▼────────────────────────────────────────┐
│           ANALYTICS & VISUALIZATION                      │
│  • Metabase (dashboards)                                 │
│  • Looker (business intelligence)                        │
│  • Jupyter Notebooks (ad-hoc analysis)                   │
└──────────────────────────────────────────────────────────┘
```

### Data Warehouse Schema

```sql
-- events table (fact table)
CREATE TABLE events (
  event_id VARCHAR(255) PRIMARY KEY,
  user_id VARCHAR(255),
  event_name VARCHAR(100),
  event_properties JSONB,
  timestamp TIMESTAMPTZ,
  session_id VARCHAR(255),
  device_type VARCHAR(20),
  platform VARCHAR(20),
  page_url TEXT
);

CREATE INDEX idx_events_user_id ON events(user_id);
CREATE INDEX idx_events_timestamp ON events(timestamp);
CREATE INDEX idx_events_event_name ON events(event_name);

-- users dimension table
CREATE TABLE dim_users (
  user_id VARCHAR(255) PRIMARY KEY,
  signup_date TIMESTAMPTZ,
  verification_status VARCHAR(20),
  specialty VARCHAR(100),
  practice_setting VARCHAR(50),
  reputation INT,
  is_premium BOOLEAN
);

-- sessions table
CREATE TABLE sessions (
  session_id VARCHAR(255) PRIMARY KEY,
  user_id VARCHAR(255),
  start_time TIMESTAMPTZ,
  end_time TIMESTAMPTZ,
  duration_seconds INT,
  page_views INT,
  events_count INT,
  device_type VARCHAR(20),
  referrer TEXT,
  utm_source VARCHAR(100),
  utm_medium VARCHAR(100),
  utm_campaign VARCHAR(100)
);

-- aggregated metrics (for faster queries)
CREATE TABLE metrics_daily (
  date DATE,
  metric_name VARCHAR(100),
  metric_value NUMERIC,
  segment VARCHAR(100), -- e.g., 'specialty:cardiology'
  PRIMARY KEY (date, metric_name, segment)
);
```

---

## 💼 Business Intelligence

### SQL Queries for Common Metrics

```sql
-- Daily Active Users (DAU)
SELECT
  DATE(timestamp) as date,
  COUNT(DISTINCT user_id) as dau
FROM events
WHERE event_name = 'session_started'
  AND timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY DATE(timestamp)
ORDER BY date;

-- User Retention Cohorts
WITH signup_cohort AS (
  SELECT
    user_id,
    DATE_TRUNC('week', created_at) as cohort_week
  FROM users
),
user_activity AS (
  SELECT
    user_id,
    DATE_TRUNC('week', timestamp) as activity_week
  FROM events
  WHERE event_name IN ('session_started', 'post_created', 'comment_created')
)
SELECT
  sc.cohort_week,
  ua.activity_week,
  EXTRACT(WEEK FROM ua.activity_week - sc.cohort_week) as weeks_since_signup,
  COUNT(DISTINCT sc.user_id) as cohort_size,
  COUNT(DISTINCT ua.user_id) as active_users,
  ROUND(100.0 * COUNT(DISTINCT ua.user_id) / COUNT(DISTINCT sc.user_id), 2) as retention_rate
FROM signup_cohort sc
LEFT JOIN user_activity ua ON sc.user_id = ua.user_id
GROUP BY sc.cohort_week, ua.activity_week
ORDER BY sc.cohort_week, weeks_since_signup;

-- Conversion Funnel
WITH funnel_steps AS (
  SELECT
    user_id,
    MAX(CASE WHEN event_name = 'user_signed_up' THEN 1 ELSE 0 END) as step1_signup,
    MAX(CASE WHEN event_name = 'user_verified' THEN 1 ELSE 0 END) as step2_verified,
    MAX(CASE WHEN event_name = 'post_viewed' THEN 1 ELSE 0 END) as step3_viewed_post,
    MAX(CASE WHEN event_name IN ('post_created', 'comment_created', 'vote_cast') THEN 1 ELSE 0 END) as step4_engaged
  FROM events
  GROUP BY user_id
)
SELECT
  SUM(step1_signup) as signups,
  SUM(step2_verified) as verified,
  SUM(step3_viewed_post) as viewed_post,
  SUM(step4_engaged) as engaged,
  ROUND(100.0 * SUM(step2_verified) / NULLIF(SUM(step1_signup), 0), 2) as verified_rate,
  ROUND(100.0 * SUM(step3_viewed_post) / NULLIF(SUM(step2_verified), 0), 2) as viewed_rate,
  ROUND(100.0 * SUM(step4_engaged) / NULLIF(SUM(step3_viewed_post), 0), 2) as engaged_rate
FROM funnel_steps;
```

---

## 🔮 Predictive Analytics

### Churn Prediction

```python
# churn_model.py - Predict user churn
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

# Features for churn prediction
features = [
    'days_since_signup',
    'days_since_last_login',
    'total_sessions',
    'avg_session_duration',
    'posts_created',
    'comments_created',
    'votes_cast',
    'reputation',
    'is_verified',
    'has_completed_profile',
    'follows_count',
    'followers_count'
]

# Train model
def train_churn_model(training_data: pd.DataFrame):
    X = training_data[features]
    y = training_data['churned']  # 1 if churned, 0 if retained

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    accuracy = model.score(X_test, y_test)
    print(f"Model accuracy: {accuracy:.2%}")

    return model

# Predict churn risk
def predict_churn_risk(model, user_data: pd.DataFrame):
    churn_probability = model.predict_proba(user_data[features])[:, 1]

    return pd.DataFrame({
        'user_id': user_data['user_id'],
        'churn_risk': churn_probability,
        'risk_level': pd.cut(
            churn_probability,
            bins=[0, 0.3, 0.7, 1.0],
            labels=['low', 'medium', 'high']
        )
    })

# Intervention for high-risk users
async def intervene_high_risk_users():
    high_risk_users = await get_high_risk_users()

    for user in high_risk_users:
        # Send re-engagement email
        await sendEmail(user.email, 'reengagement_template')

        # Show personalized content
        await updateUserPreferences(user.id, {
            'show_onboarding_tips': True,
            'highlight_followed_content': True
        })
```

### Content Recommendation

```python
# recommendation_engine.py
import numpy as np
from scipy.sparse import csr_matrix
from implicit.als import AlternatingLeastSquares

# Collaborative filtering for post recommendations
def train_recommendation_model(interaction_matrix: csr_matrix):
    """
    interaction_matrix: sparse matrix where rows = users, cols = posts,
                        values = engagement score (views + votes + comments)
    """
    model = AlternatingLeastSquares(
        factors=100,
        regularization=0.01,
        iterations=20
    )

    model.fit(interaction_matrix)
    return model

# Get recommendations for user
def get_recommendations(
    model,
    user_id: int,
    interaction_matrix: csr_matrix,
    n_recommendations: int = 10
):
    user_items = interaction_matrix[user_id]

    recommendations = model.recommend(
        user_id,
        user_items,
        N=n_recommendations,
        filter_already_liked_items=True
    )

    return recommendations
```

---

## 📞 Analytics Team

**Data Team Structure**:

- **Data Engineer** (1): Build data pipelines, maintain infrastructure
- **Data Analyst** (1): Create dashboards, ad-hoc analysis
- **Data Scientist** (1, Month 12+): Predictive models, ML

**Tools**:

- Segment (data collection)
- Redshift (data warehouse)
- dbt (transformations)
- Metabase (dashboards)
- Python + Jupyter (analysis)

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Next Review**: February 8, 2026

**Related Documents**:

- [IMPLEMENTATION_ROADMAP.md](./IMPLEMENTATION_ROADMAP.md)
- [BUSINESS_MODEL.md](../business/BUSINESS_MODEL.md)
- [PRIVACY_POLICY.md](../legal/PRIVACY_POLICY.md)
