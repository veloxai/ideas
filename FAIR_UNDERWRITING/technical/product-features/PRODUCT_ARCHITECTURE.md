# Product Architecture - Fair Underwriting

## 🏗️ System Overview

Fair Underwriting consists of three primary user-facing portals and a comprehensive backend infrastructure that maintains strict data segregation for privacy and compliance.

```
┌─────────────────────────────────────────────────────────────┐
│                    Fair Underwriting Platform                │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Partner    │  │   Customer   │  │    Admin     │      │
│  │  Dashboard   │  │    Portal    │  │  Dashboard   │      │
│  │              │  │              │  │              │      │
│  │  partners.   │  │     my.      │  │   admin.     │      │
│  │fairunder...  │  │fairunder...  │  │fairunder...  │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                  │                  │              │
│         └──────────┬───────┴──────────────────┘              │
│                    │                                          │
│         ┌──────────▼────────────────────┐                    │
│         │      API Gateway (GraphQL     │                    │
│         │       + REST + WebSockets)    │                    │
│         └──────────┬────────────────────┘                    │
│                    │                                          │
│    ┌───────────────┼───────────────┐                        │
│    │               │               │                        │
│  ┌─▼──────┐  ┌────▼─────┐  ┌─────▼────┐                   │
│  │Partner │  │ Customer │  │  Admin   │                   │
│  │Service │  │ Service  │  │ Service  │                   │
│  └───┬────┘  └────┬─────┘  └─────┬────┘                   │
│      │            │              │                         │
│      └────────────┼──────────────┘                         │
│                   │                                         │
│        ┌──────────▼──────────────┐                         │
│        │   Data Segregation      │                         │
│        │        Layer            │                         │
│        └──────────┬──────────────┘                         │
│                   │                                         │
│    ┌──────────────┼──────────────┐                        │
│    │              │              │                        │
│ ┌──▼────┐  ┌─────▼──────┐  ┌───▼───────┐                │
│ │Partner│  │  Customer  │  │ Research  │                │
│ │  DB   │  │ Genetic DB │  │ Anon. DB  │                │
│ │       │  │(Encrypted) │  │           │                │
│ └───────┘  └────────────┘  └───────────┘                │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

## 🖥️ Portal 1: Partner Dashboard

**URL**: `partners.fairunderwriting.com`
**Users**: Insurance companies, wellness organizations
**Purpose**: Manage partnerships, view aggregate statistics, ROI tracking

### Core Features

#### 1. Customer Enrollment Management

- **Bulk enrollment** via CSV upload
- **API integration** for real-time enrollment
- **Enrollment tracking** and status monitoring
- **Customer ID matching** (with privacy protection)
- **Opt-in/opt-out management**

#### 2. Analytics & Reporting Dashboard

**Aggregated Statistics Only - No Individual PII**

- **Enrollment Metrics**
  - Total enrolled customers
  - Active vs. inactive customers
  - Month-over-month growth
  - Enrollment by demographic (age ranges, geographic regions)

- **Health Outcomes**
  - AATD detection rate (population level)
  - Early disease detection count
  - Acute illness alerts (4x AAT spikes) - count only
  - Test completion rate
  - Customer engagement scores

- **Financial & ROI Metrics**
  - Estimated life expectancy extension (actuarial projections)
  - Cost savings estimates
  - Premium collection extension estimates
  - Customer lifetime value improvements
  - Program ROI calculator

- **Trend Analysis**
  - Historical data visualization
  - Predictive modeling
  - Benchmark comparisons
  - Year-over-year comparisons

#### 3. Certification Badge Management

- **Badge level display** (Bronze, Silver, Gold, Platinum)
- **Badge code generator** (HTML/JavaScript snippets)
- **Statistics display controls** (choose what to show publicly)
- **Badge preview** and testing
- **Verification URL** management
- **Badge analytics** (impressions, clicks)

#### 4. Marketing & Co-Branding Tools

- **Co-branded materials library**
  - Brochures (downloadable PDFs)
  - Email templates
  - Social media graphics
  - Website banners
  - Educational videos

- **Campaign tracking**
  - UTM parameter generation
  - Campaign performance metrics
  - Enrollment attribution

- **Partner logo management**
  - Upload partner logo for co-branding
  - Brand guidelines repository

#### 5. Billing & Invoicing

- **Billing dashboard**
  - Current invoice
  - Payment history
  - Upcoming charges preview
  - Volume-based pricing calculator

- **Payment methods**
  - Credit card
  - ACH/wire transfer
  - Purchase order support

- **Automatic invoicing**
  - Monthly/quarterly billing
  - Detailed line items
  - Export to accounting software

#### 6. API Access & Integration

- **API credentials management**
  - Generate API keys
  - Rotate keys
  - Usage tracking

- **Webhook configuration**
  - Test result notification endpoints
  - Enrollment status updates
  - System alerts

- **Integration documentation**
  - Interactive API docs (Swagger/OpenAPI)
  - Code samples (multiple languages)
  - Testing sandbox

#### 7. Support & Resources

- **Knowledge base** search
- **Submit support tickets**
- **Account manager contact**
- **System status page**
- **Scheduled maintenance calendar**

### User Roles & Permissions

- **Account Owner**: Full access, billing
- **Administrator**: Full access except billing
- **Analyst**: View-only access to analytics
- **API User**: Programmatic access only
- **Marketing User**: Marketing materials, badge management only

---

## 👤 Portal 2: Customer Portal

**URL**: `my.fairunderwriting.com`
**Users**: Individual customers (end-users)
**Purpose**: View test results, manage health data, control privacy

### Core Features

#### 1. Dashboard & Overview

- **Current AAT status** (most recent test)
- **Visual trend graph** (AAT levels over time)
- **Alert notifications** (critical values, 4x spikes)
- **Next test due** reminder
- **Quick actions** (schedule test, contact counselor)

#### 2. Test Results & History

- **Complete test history**
  - Date of each test
  - AAT level with normal range indicator
  - Trend arrows (increasing, decreasing, stable)
  - Lab name and certification info

- **Result visualization**
  - Line chart (AAT over time)
  - Color-coded status (normal, elevated, critical)
  - Annotations for significant events

- **Download results**
  - PDF report generation
  - CSV export for personal tracking
  - Share with healthcare provider (secure link)

#### 3. Genetic Information (SERPINA1)

**Only visible if testing has been completed**

- **Mutation status**
  - Genotype (e.g., MM, MZ, ZZ, etc.)
  - Variant details and clinical significance
  - Carrier status explanation

- **Inheritance information**
  - Family planning implications
  - Inheritance pattern visualization
  - Risk for future children

- **Clinical recommendations**
  - Screening recommendations
  - Lifestyle modifications
  - When to seek medical attention

#### 4. Full DNA Sequencing Results

**Premium feature - separate section**

- **Health risk assessments**
  - Disease risk scores
  - Pharmacogenomic insights
  - Carrier status for other conditions

- **Annual updates**
  - New discoveries notifications
  - Research updates on your variants
  - Revised risk assessments

- **Raw data download**
  - VCF file export
  - 23andMe/Ancestry compatible format
  - Data portability tools

#### 5. Health Alerts & Notifications

- **Critical alerts** (4x AAT spike detection)
  - Immediate notification (push, email, SMS)
  - Action recommendations
  - Emergency contact suggestions

- **Routine reminders**
  - Test scheduling reminders
  - Result ready notifications
  - Annual review reminders

- **Educational notifications**
  - New research relevant to your profile
  - Seasonal health tips
  - Wellness recommendations

#### 6. Genetic Counselor Access

- **Chat messaging**
  - Secure in-app messaging
  - Response within 24 hours
  - Message history

- **Video consultations**
  - Schedule appointment
  - Virtual waiting room
  - Screen sharing for result review

- **Consultation packages**
  - Free initial consultation (with testing)
  - Additional consultations (purchase)
  - Family consultation options

#### 7. Privacy & Consent Management

- **Data access control**
  - View who has accessed your data (audit log)
  - Revoke access (partner, research)
  - Download all data (GDPR/CCPA right)

- **Consent management**
  - Research participation opt-in/out
  - Partner data sharing (aggregate only)
  - Third-party integration authorizations

- **Account security**
  - Two-factor authentication
  - Biometric login (mobile)
  - Session management
  - Login history

#### 8. Family Health History

- **Family tree builder**
  - Add family members
  - Record health conditions
  - Genetic risk visualization

- **Family invitations**
  - Invite family members to test
  - Share family health patterns
  - Coordinate testing

#### 9. Integration with Health Apps

- **Wearable device sync**
  - Apple Health
  - Google Fit
  - Fitbit
  - Other fitness trackers

- **Data correlation**
  - Activity levels vs. AAT trends
  - Sleep patterns correlation
  - Heart rate variability

#### 10. Educational Resources

- **AATD library**
  - What is AATD?
  - Understanding AAT levels
  - Managing AATD
  - Latest research

- **Interactive tools**
  - Risk calculator
  - Symptom checker
  - Lifestyle impact simulator

- **Video content**
  - Expert interviews
  - Patient stories
  - How-to guides

### Mobile App Features

**iOS & Android**

- All portal features optimized for mobile
- **Push notifications** for critical alerts
- **Touch ID / Face ID** for quick secure access
- **Offline mode** for viewing past results
- **Camera integration** for document upload
- **Location services** for nearby testing centers

---

## 🔧 Portal 3: Admin Dashboard

**URL**: `admin.fairunderwriting.com`
**Users**: Fair Underwriting staff
**Purpose**: Operations management, system monitoring, compliance

### Core Features

#### 1. Partner Management

- **Partner directory**
  - All partner organizations
  - Contact information
  - Contract details
  - Account status

- **Partner onboarding**
  - Onboarding workflow
  - Document collection
  - API setup assistance
  - Training completion tracking

- **Partner health**
  - Enrollment velocity
  - Engagement metrics
  - Support ticket volume
  - Satisfaction scores

#### 2. Customer Management

- **Customer directory** (with privacy controls)
  - Search and filter
  - Account status
  - Test history
  - Support interactions

- **Customer support tools**
  - View customer issues
  - Impersonate (with audit log)
  - Manual data corrections
  - Account recovery

#### 3. Test Fulfillment & Lab Integration

- **Test order management**
  - Pending orders
  - In-process tracking
  - Completed orders
  - Failed/rejected orders

- **Lab partner dashboard**
  - Lab performance metrics
  - Turnaround time tracking
  - Quality metrics
  - Issue escalation

- **Sample tracking**
  - Chain of custody
  - Shipping status
  - Sample quality issues
  - Retest requests

#### 4. Quality Assurance

- **Test result review**
  - Flagged results (extreme values)
  - Validation workflow
  - Sign-off process
  - Audit trail

- **Data quality monitoring**
  - Missing data reports
  - Outlier detection
  - Data integrity checks
  - Reconciliation reports

#### 5. Financial Management

- **Revenue dashboard**
  - Daily/monthly/yearly revenue
  - Revenue by partner
  - Revenue by product
  - Forecasting

- **Billing operations**
  - Generate invoices
  - Payment tracking
  - Failed payment handling
  - Refund processing

- **Cost tracking**
  - Lab costs per test
  - Infrastructure costs
  - Partner acquisition costs
  - Customer support costs

#### 6. Compliance & Audit

- **Regulatory compliance dashboard**
  - HIPAA compliance checks
  - GINA compliance monitoring
  - State-specific requirements
  - Certification status

- **Audit logs**
  - All data access (searchable)
  - Administrative actions
  - System changes
  - Security events

- **Consent tracking**
  - Customer consent status
  - Consent version history
  - Withdrawal requests
  - Research participation

#### 7. Research Data Platform

- **Anonymization pipeline**
  - De-identification workflow
  - Quality checks
  - IRB approval tracking
  - Data release management

- **Research requests**
  - Incoming research requests
  - Approval workflow
  - Data preparation
  - Licensing agreements

#### 8. System Health Monitoring

- **Infrastructure dashboard**
  - Server health
  - Database performance
  - API response times
  - Error rates

- **Security monitoring**
  - Failed login attempts
  - Suspicious activity alerts
  - Vulnerability scan results
  - Penetration test reports

- **Alert management**
  - System alerts
  - On-call rotation
  - Incident management
  - Post-mortem repository

#### 9. Content Management

- **Educational content**
  - Article management
  - Video library
  - FAQ editor
  - Version control

- **Marketing materials**
  - Template library
  - Brand asset management
  - Co-branding approvals

#### 10. Reports & Analytics

- **Executive reports**
  - KPI dashboard
  - Board reports
  - Investor reports
  - Custom reports

- **Operational reports**
  - Daily operations summary
  - Weekly performance
  - Monthly financials
  - Quarterly business review

### User Roles & Permissions

- **Super Admin**: Full system access
- **Operations Manager**: Day-to-day operations
- **Support Agent**: Customer support only
- **Lab Coordinator**: Lab operations
- **Financial Admin**: Billing and finance
- **Compliance Officer**: Audit and compliance
- **Data Scientist**: Research database (anonymized)

---

## 🔌 API Architecture

### REST API Endpoints

#### Partner API

```
POST   /api/v1/partners/enroll-customer
GET    /api/v1/partners/customers
GET    /api/v1/partners/analytics
GET    /api/v1/partners/badge
POST   /api/v1/partners/webhook
```

#### Customer API

```
GET    /api/v1/customer/tests
GET    /api/v1/customer/results/{id}
POST   /api/v1/customer/schedule-test
GET    /api/v1/customer/genetic-info
POST   /api/v1/customer/consent
```

#### Lab API (Internal)

```
POST   /api/v1/labs/orders
PUT    /api/v1/labs/results
GET    /api/v1/labs/quality-metrics
POST   /api/v1/labs/issues
```

### GraphQL API

**Flexible queries for dashboard data**

```graphql
query PartnerDashboard {
  partner(id: "ABC123") {
    enrolledCustomers {
      total
      active
      demographics {
        ageRange
        count
      }
    }
    healthOutcomes {
      aatdDetectionRate
      earlyDetectionCount
    }
    roi {
      estimatedLifeExtension
      costSavings
    }
  }
}
```

### WebSocket Connections

**Real-time updates for critical events**

- Critical test results
- System alerts
- Live chat messages
- Notification delivery

---

## 🔒 Data Segregation Architecture

### Three-Tier Data Model

#### Tier 1: Partner Database

**What partners can see**

- Aggregate statistics only
- No PII
- No individual genetic data

**Storage**: PostgreSQL (primary database)
**Encryption**: At rest (AES-256)

#### Tier 2: Customer Database

**Customer-controlled genetic data**

- Individual test results
- SERPINA1 mutations
- Full DNA sequencing
- Personal health records

**Storage**: Separate encrypted vault (AWS KMS, HashiCorp Vault, or similar)
**Encryption**: At rest + in transit
**Access**: Customer only (+ authorized medical staff with explicit consent)

#### Tier 3: Research Database

**Anonymized data for research**

- De-identified genetic data
- No linkage to individuals
- IRB approved uses only

**Storage**: Separate data warehouse
**Anonymization**: Irreversible de-identification
**Access**: Researchers (approved projects only)

### Data Flow

```
Customer Test → Lab Results → Encrypted Storage → Customer Portal
                                        ↓
                              Aggregation Engine
                                        ↓
                              Partner Dashboard
                                   (Stats Only)

Customer Consent → Anonymization → Research Database
```

---

## 📱 Mobile Architecture

### React Native Application

**Shared codebase for iOS and Android**

- **UI Components**: React Native Paper (Material Design)
- **Navigation**: React Navigation
- **State Management**: Redux Toolkit
- **API Client**: Axios with interceptors
- **Secure Storage**: react-native-keychain
- **Biometrics**: react-native-biometrics
- **Push Notifications**: Firebase Cloud Messaging

### Offline Support

- **Local database**: WatermelonDB or Realm
- **Sync strategy**: Optimistic updates, background sync
- **Conflict resolution**: Server wins for health data

---

## 🛠️ Technology Stack Summary

### Frontend

- **Web**: React + Next.js (TypeScript)
- **Mobile**: React Native (TypeScript)
- **UI Library**: Material-UI, Tailwind CSS
- **Charts**: D3.js, Chart.js, Recharts
- **State Management**: Redux Toolkit, React Query

### Backend

- **API**: Node.js + Express (REST), Apollo Server (GraphQL)
- **Language**: TypeScript
- **Authentication**: OAuth 2.0, JWT, Passport.js
- **Queue**: Redis + Bull (job processing)
- **WebSockets**: Socket.io

### Databases

- **Primary DB**: PostgreSQL 15+ (partner data, operations)
- **Genetic Vault**: Separate PostgreSQL with encryption
- **Cache**: Redis
- **Search**: Elasticsearch (optional)
- **Analytics**: ClickHouse (optional, for big data)

### Infrastructure

- **Hosting**: AWS or Google Cloud Platform
- **Containers**: Docker + Kubernetes
- **CDN**: CloudFlare
- **Storage**: S3-compatible (encrypted)
- **Secrets**: AWS Secrets Manager or HashiCorp Vault

### Security

- **WAF**: CloudFlare WAF
- **DDoS Protection**: CloudFlare
- **Encryption**: TLS 1.3, AES-256
- **Compliance**: HIPAA, SOC 2 Type II, ISO 27001
- **Monitoring**: Datadog, Sentry
- **Audit Logs**: Immutable log storage

---

**Document Version**: 1.0
**Last Updated**: November 7, 2025
**Next Review**: Development kickoff
