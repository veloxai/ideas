# Fair Underwriting Technical Architecture

**Version**: 1.0
**Status**: Technical Specification
**Last Updated**: November 7, 2025

---

## System Overview

Fair Underwriting is a multi-tenant B2B2C platform with three primary user interfaces:

1. **Partner Portal** - For insurance companies and wellness organizations
2. **Customer Portal** - For end-users/insureds
3. **Admin Dashboard** - For Fair Underwriting operations

### Architecture Principles

- **Privacy by Design**: Genetic data segregated from all partner-accessible systems
- **Multi-tenancy**: Support thousands of partners with isolated data
- **Scalability**: Handle millions of customers with sub-second response times
- **Compliance**: HIPAA, GINA, SOC 2, ISO 27001 ready from day one
- **API-First**: All features accessible via RESTful + GraphQL APIs

---

## Technology Stack

### Frontend Applications

#### Partner Portal (`partners.fairunderwriting.com`)

```
Framework: Next.js 14+ (App Router)
Language: TypeScript
Styling: Tailwind CSS + shadcn/ui
State: React Query + Zustand
Charts: Recharts / Chart.js
Auth: NextAuth.js (OAuth 2.0, SAML)
```

#### Customer Portal (`my.fairunderwriting.com`)

```
Framework: Next.js 14+ (App Router)
Language: TypeScript
Styling: Tailwind CSS + shadcn/ui
State: React Query + Zustand
Charts: Recharts (AAT trends)
Auth: NextAuth.js (OAuth 2.0, MFA)
Mobile: React Native (future)
```

#### Admin Dashboard (`admin.fairunderwriting.com`)

```
Framework: Next.js 14+ (App Router)
Language: TypeScript
Styling: Tailwind CSS + shadcn/ui
State: React Query + Zustand
Tables: TanStack Table
Auth: Role-based access control
```

#### Marketing Site (`fairunderwriting.com`)

```
Framework: Next.js 14+ (Pages Router)
CMS: Contentful or Sanity.io
Styling: Tailwind CSS
Analytics: Plausible
```

### Backend Services

#### API Gateway

```
Framework: Node.js + Express OR NestJS
Language: TypeScript
API Styles: REST + GraphQL (Apollo Server)
Auth: JWT tokens + OAuth 2.0
Rate Limiting: Redis-based
Load Balancer: Nginx or AWS ALB
```

#### Authentication Service (Leverage existing auth.vlx.io)

```
Current: auth.vlx.io infrastructure
OAuth Providers: Google, Microsoft, custom
Multi-factor: TOTP, SMS, email
Session Management: Redis
Password Policy: Configurable per tenant
```

#### Core Business Logic Service

```
Framework: Node.js + NestJS OR Python + FastAPI
Language: TypeScript or Python
Validation: Zod (TS) or Pydantic (Python)
Queue: BullMQ (Redis-backed)
Caching: Redis
Search: Elasticsearch (optional)
```

#### Genetic Data Vault (ISOLATED)

```
Framework: Python + FastAPI
Encryption: AES-256 at rest, per-customer keys
Storage: Encrypted S3 buckets (separate AWS account)
Access: One-way API only (no direct DB access)
Audit: Every access logged immutably
Network: Private VPC, no internet access
```

#### Lab Integration Service

```
Framework: Node.js + Express
Protocols: HL7/FHIR, custom APIs
Partners: Quest, LabCorp, regional labs
Order Management: Queue-based workflow
Result Processing: Automated parsing + validation
Notifications: Webhooks to customer portal
```

#### Notification Service

```
Framework: Node.js + BullMQ
Channels: Email, SMS, Push, In-app
Providers:
  - Email: SendGrid or AWS SES
  - SMS: Twilio
  - Push: Firebase Cloud Messaging
Templates: Handlebars or React Email
Scheduling: Cron-based + event-driven
```

#### Analytics & Reporting Service

```
Framework: Python + Pandas + NumPy
Database: ClickHouse (time-series analytics)
Jobs: Airflow or Temporal
Reports: PDF generation (Puppeteer)
Dashboards: Grafana (internal metrics)
```

### Databases

#### Primary Database (PostgreSQL)

```
Version: PostgreSQL 15+
Hosting: AWS RDS (Multi-AZ) or self-hosted
Size: Start with 100GB, scale to TB+
Backups: Automated daily + point-in-time recovery
Replication: Read replicas for analytics

Schemas:
- partners (insurance companies, wellness orgs)
- customers (PII, contact info, preferences)
- tests (orders, status, metadata - NOT results)
- billing (subscriptions, invoices, payments)
- audit_logs (compliance tracking)
```

#### Genetic Data Vault (PostgreSQL + Encryption Layer)

```
Version: PostgreSQL 15+ with pgcrypto
Hosting: Separate AWS account, isolated VPC
Access: API-only, no direct connections
Encryption: Column-level AES-256 + customer-specific keys
Key Management: AWS KMS or HashiCorp Vault
Backups: Encrypted, geographically redundant

Schema:
- genetic_results (SERPINA1 data)
- aat_levels (circulating AAT measurements)
- dna_sequences (full genome data if applicable)
- consent_records (blockchain-backed hashes)
```

#### Cache Layer (Redis)

```
Version: Redis 7+
Hosting: AWS ElastiCache or self-hosted
Use Cases:
- Session storage
- API rate limiting
- Queue management (BullMQ)
- Temporary data caching
- Real-time features (WebSockets)
```

#### Analytics Database (ClickHouse - Optional)

```
Version: ClickHouse 23+
Hosting: ClickHouse Cloud or self-hosted
Use Cases:
- Time-series analytics
- Aggregate reporting
- Partner dashboards
- Business intelligence
Data: Anonymized, aggregate only
```

### Infrastructure

#### Cloud Provider

```
Primary: AWS (recommended)
Alternatives: Google Cloud, Azure

Key Services:
- Compute: EC2, ECS/Fargate, or Lambda
- Storage: S3 (encrypted)
- Database: RDS (PostgreSQL), ElastiCache (Redis)
- Networking: VPC, ALB, Route 53
- Security: WAF, Shield, KMS, Secrets Manager
- Monitoring: CloudWatch, X-Ray
```

#### Container Orchestration

```
Platform: Kubernetes (EKS) OR Docker Swarm OR ECS
Registry: AWS ECR or Docker Hub
CI/CD: GitHub Actions or GitLab CI
Infrastructure as Code: Terraform or CloudFormation
```

#### CDN & Static Assets

```
CDN: Cloudflare (recommended) or CloudFront
Static Sites: Vercel (Next.js) or S3 + CloudFront
SSL: Cloudflare SSL or AWS ACM (free)
DDoS Protection: Cloudflare or AWS Shield
```

#### Monitoring & Logging

```
Application Monitoring: Datadog or New Relic
Error Tracking: Sentry
Logging: CloudWatch Logs or Elasticsearch + Kibana
Uptime Monitoring: health.velox.ai + UptimeRobot
Alerts: PagerDuty or Opsgenie
```

---

## Data Architecture

### Data Flow: Test Ordering

```
Customer → Customer Portal → API Gateway → Core Service
                                              ↓
                               Order stored in PostgreSQL
                                              ↓
                               Queue job created (BullMQ)
                                              ↓
                         Lab Integration Service picks up job
                                              ↓
                       Send order to Lab (Quest/LabCorp API)
                                              ↓
                            Lab processes sample
                                              ↓
                      Lab sends results via HL7/FHIR
                                              ↓
                  Lab Integration Service receives results
                                              ↓
              ┌─────────────────────────────────────────┐
              │  CRITICAL SPLIT FOR PRIVACY             │
              └─────────────────────────────────────────┘
              │                                          │
              ├─ Test metadata (order ID, date, status) │
              │  → PostgreSQL (accessible to admins)    │
              │                                          │
              └─ Genetic results (AAT levels, SERPINA1) │
                 → Genetic Data Vault (customer only)   │
                                                         │
              ┌──────────────────────────────────────────┘
              ↓
    Notification Service sends alert to customer
              ↓
    Customer logs into Customer Portal
              ↓
    Portal calls Genetic Data Vault API with customer auth token
              ↓
    Results displayed to customer only
```

### Data Flow: Partner Dashboard

```
Partner logs into Partner Portal
              ↓
    API Gateway authenticates partner
              ↓
    API fetches partner-specific data from PostgreSQL
              ↓
    ┌─────────────────────────────────────────┐
    │  AGGREGATE DATA ONLY                    │
    └─────────────────────────────────────────┘
              │
              ├─ Number of enrolled customers
              ├─ Test completion rates
              ├─ Aggregate health outcomes
              ├─ ROI metrics
              └─ NO INDIVIDUAL GENETIC DATA
              │
              ↓
    Analytics Service generates charts
              ↓
    Dashboard displays to partner
```

### Data Segregation Model

```
┌──────────────────────────────────────────────────────────┐
│ LEVEL 1: PUBLIC DATA                                     │
│ - Partner company names (certified)                      │
│ - Aggregate statistics (anonymized)                      │
│ - Educational content                                    │
│ Access: Anyone on internet                               │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ LEVEL 2: PARTNER DATA (Non-PII Aggregate)               │
│ - Number of customers enrolled                           │
│ - Test completion rates                                  │
│ - Population health trends                               │
│ - ROI calculations                                       │
│ Access: Authenticated partners (their data only)         │
│ Storage: PostgreSQL main DB                              │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ LEVEL 3: CUSTOMER PII (No Genetic Data)                 │
│ - Name, email, phone, address                            │
│ - Test order history (metadata only)                     │
│ - Billing information                                    │
│ - Consent records                                        │
│ Access: Customer + Fair Underwriting admins             │
│ Storage: PostgreSQL main DB (encrypted at rest)          │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ LEVEL 4: GENETIC DATA (Maximum Security)                │
│ - SERPINA1 gene mutation data                            │
│ - AAT circulating levels                                 │
│ - Full DNA sequencing results                            │
│ - Genetic health risk reports                            │
│ Access: Customer ONLY (+ genetic counselors with consent)│
│ Storage: Genetic Data Vault (isolated, encrypted)        │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ LEVEL 5: ANONYMIZED RESEARCH DATA                       │
│ - De-identified genetic patterns                         │
│ - Statistical correlations                               │
│ - Aggregate cohort analysis                              │
│ Access: Research partners (with IRB approval)            │
│ Storage: Separate research database                      │
└──────────────────────────────────────────────────────────┘
```

---

## Security Architecture

### Authentication & Authorization

#### Customer Authentication

```
Methods:
- Email/Password (with MFA)
- OAuth (Google, Apple, Microsoft)
- SSO via partner insurance company
- Biometric (mobile app future)

Session Management:
- JWT access tokens (15 min expiry)
- Refresh tokens (30 day expiry, rotating)
- Redis session store
- Device fingerprinting
- Suspicious activity detection

MFA Requirements:
- Required for viewing genetic results
- TOTP (Google Authenticator, Authy)
- SMS backup (with warnings)
- Recovery codes (one-time use)
```

#### Partner Authentication

```
Methods:
- SSO (SAML 2.0, OAuth 2.0)
- API keys for programmatic access
- Role-based access control

Roles:
- Admin: Full partner account access
- Analyst: Read-only dashboard access
- Developer: API access only
- Billing: Invoice and payment access

API Authentication:
- OAuth 2.0 client credentials
- API keys with IP whitelisting
- Rate limiting per key
- Webhook signature verification
```

#### Admin Authentication

```
Methods:
- Email/Password with mandatory MFA
- Hardware security keys (YubiKey)
- IP whitelisting (office networks only)

Roles:
- Super Admin: Full system access
- Operations: Customer support, no genetic data
- Finance: Billing and payments
- Engineering: System maintenance, read-only data
- Compliance: Audit logs, no data modification

Genetic Data Access:
- NEVER direct database access
- Only via encrypted API with full audit logging
- Requires customer explicit consent
- Time-limited access tokens
```

### Data Encryption

#### At Rest

```
Level 1: Disk Encryption
- AWS EBS volumes encrypted (AWS KMS)
- S3 buckets encrypted (SSE-S3 or SSE-KMS)

Level 2: Database Encryption
- PostgreSQL with pgcrypto
- Column-level encryption for sensitive fields
- Separate encryption keys per customer

Level 3: Application-Level Encryption
- Genetic Data Vault: AES-256-GCM
- Customer-specific keys stored in KMS
- Key rotation every 90 days
```

#### In Transit

```
TLS 1.3 Only
- All API endpoints
- Database connections
- Internal service communication
- CDN to browser

Certificate Management:
- Automated renewal (Let's Encrypt or ACM)
- Certificate pinning (mobile apps)
- HSTS enabled (max-age=31536000)
```

### Network Security

```
┌─────────────────────────────────────────────────┐
│ Public Internet                                 │
└────────────────┬────────────────────────────────┘
                 │
          ┌──────▼──────┐
          │  Cloudflare │ ← DDoS protection, WAF
          │  CDN + WAF  │
          └──────┬──────┘
                 │
          ┌──────▼──────────┐
          │  AWS ALB        │ ← SSL termination
          │  (Load Balancer)│
          └──────┬──────────┘
                 │
     ┌───────────┴───────────┐
     │                       │
┌────▼────┐           ┌──────▼──────┐
│ Public  │           │  Private    │
│ Subnet  │           │  Subnet     │
│         │           │             │
│ - API   │           │ - Core      │
│   Gateway│          │   Services  │
│ - Web   │           │ - Databases │
│   Servers│          │ - Redis     │
└────┬────┘           └──────┬──────┘
     │                       │
     │                ┌──────▼─────────┐
     │                │  Isolated VPC  │
     │                │  (Separate AWS │
     │                │   Account)     │
     │                │                │
     │                │ - Genetic Data │
     │                │   Vault        │
     │                │ - No internet  │
     │                │   access       │
     │                │ - API-only     │
     └────────────────▶  access        │
                      └────────────────┘
```

### Compliance & Auditing

#### HIPAA Compliance

- [ ] Business Associate Agreements (BAAs) with all partners
- [ ] Access controls and audit logs
- [ ] Data encryption at rest and in transit
- [ ] Breach notification procedures
- [ ] Regular risk assessments
- [ ] Employee training programs
- [ ] Incident response plan

#### GINA Compliance

- [ ] No genetic data used in underwriting (Method 400/700)
- [ ] Customer consent for any genetic data collection
- [ ] Clear privacy policies
- [ ] Genetic data segregation from partner access

#### SOC 2 Type II

- [ ] Security controls documentation
- [ ] Availability monitoring (99.9% uptime SLA)
- [ ] Processing integrity (data validation)
- [ ] Confidentiality (encryption, access controls)
- [ ] Privacy (consent management, data rights)
- [ ] Annual audit by accredited firm

#### GDPR / CCPA

- [ ] Right to access (data export)
- [ ] Right to deletion (complete data removal)
- [ ] Right to rectification (data correction)
- [ ] Right to portability (machine-readable format)
- [ ] Consent management system
- [ ] Privacy by design architecture

#### Audit Logging

```
All logged events:
- User authentication (success/failure)
- Genetic data access (who, when, what)
- Admin actions (all CRUD operations)
- API calls (request/response metadata)
- Data exports
- Consent changes
- System errors and exceptions

Log Storage:
- Immutable append-only logs
- Encrypted storage
- 7-year retention (compliance requirement)
- Real-time alerting for suspicious activity
- Searchable via Elasticsearch (optional)
```

---

## API Architecture

### RESTful API Endpoints

#### Authentication

```
POST   /api/v1/auth/register
POST   /api/v1/auth/login
POST   /api/v1/auth/logout
POST   /api/v1/auth/refresh
POST   /api/v1/auth/mfa/enable
POST   /api/v1/auth/mfa/verify
POST   /api/v1/auth/password/reset
```

#### Customer Portal API

```
GET    /api/v1/customer/profile
PUT    /api/v1/customer/profile
DELETE /api/v1/customer/account

GET    /api/v1/customer/tests
POST   /api/v1/customer/tests/order
GET    /api/v1/customer/tests/:id

GET    /api/v1/customer/results        ← Genetic Data Vault
GET    /api/v1/customer/results/:id    ← Genetic Data Vault
POST   /api/v1/customer/results/:id/share

GET    /api/v1/customer/consent
POST   /api/v1/customer/consent
PUT    /api/v1/customer/consent/:id

GET    /api/v1/customer/family-history
POST   /api/v1/customer/family-history
```

#### Partner Portal API

```
GET    /api/v1/partner/profile
PUT    /api/v1/partner/profile

GET    /api/v1/partner/customers
POST   /api/v1/partner/customers/enroll
GET    /api/v1/partner/customers/:id    ← No genetic data

GET    /api/v1/partner/analytics
GET    /api/v1/partner/analytics/roi
GET    /api/v1/partner/analytics/health-outcomes

GET    /api/v1/partner/badge
PUT    /api/v1/partner/badge/settings

GET    /api/v1/partner/billing
GET    /api/v1/partner/billing/invoices/:id
```

#### Admin API

```
GET    /api/v1/admin/partners
POST   /api/v1/admin/partners
GET    /api/v1/admin/partners/:id
PUT    /api/v1/admin/partners/:id
DELETE /api/v1/admin/partners/:id

GET    /api/v1/admin/customers
GET    /api/v1/admin/customers/:id
PUT    /api/v1/admin/customers/:id     ← No genetic data access

GET    /api/v1/admin/tests
PUT    /api/v1/admin/tests/:id/status

GET    /api/v1/admin/audit-logs
GET    /api/v1/admin/audit-logs/search

GET    /api/v1/admin/system/health
GET    /api/v1/admin/system/metrics
```

### GraphQL API

```graphql
# Query Examples

query GetCustomerTests {
  customer(id: "customer-id") {
    id
    name
    email
    tests {
      id
      type
      orderedAt
      status
      # Note: NO genetic results in this query
    }
  }
}

query GetPartnerAnalytics {
  partner(id: "partner-id") {
    id
    name
    statistics {
      enrolledCustomers
      completedTests
      averageAAT
      earlyDetections
      roi {
        extendedLifeYears
        estimatedSavings
      }
    }
  }
}

# Genetic results require separate authenticated call to Genetic Data Vault
query GetGeneticResults {
  geneticResults(customerId: "customer-id", token: "encrypted-token") {
    aatLevels {
      value
      date
      unit
    }
    serpina1 {
      genotype
      variants
      interpretation
    }
  }
}
```

### Webhooks

Partners can subscribe to events:

```
Partner Webhooks:
- customer.enrolled
- test.ordered
- test.completed (metadata only, no results)
- badge.verified
- analytics.updated

Customer Webhooks:
- test.result_ready
- aat.alert (4x elevation detected)
- consent.requested
- account.updated

Webhook Payload Example:
{
  "event": "test.result_ready",
  "timestamp": "2025-11-07T12:00:00Z",
  "data": {
    "testId": "test-123",
    "customerId": "customer-456",
    "type": "AAT_LEVEL",
    "status": "completed"
    # NO genetic results in webhook
  },
  "signature": "sha256=..."
}
```

### Rate Limiting

```
Public API (unauthenticated):
- 100 requests / 15 minutes per IP

Customer API (authenticated):
- 1,000 requests / hour
- 100 requests / minute burst

Partner API (authenticated):
- 10,000 requests / hour
- 500 requests / minute burst

Admin API (authenticated):
- Unlimited (internal use)

Genetic Data Vault API:
- 100 requests / hour (sensitive data)
- Additional throttling for suspicious patterns
```

---

## Scalability & Performance

### Horizontal Scaling

```
Component              | Initial | Scale Target  | Strategy
-----------------------|---------|---------------|------------------
API Gateway            | 2 nodes | 20+ nodes     | Auto-scaling (CPU)
Core Services          | 3 nodes | 50+ nodes     | Auto-scaling (CPU)
PostgreSQL             | 1 master| 1 master +    | Read replicas
                       |         | 5 read replicas|
Redis Cache            | 1 node  | 3 node cluster| Redis Cluster
Genetic Data Vault     | 2 nodes | 10+ nodes     | Manual scaling
Lab Integration Service| 2 nodes | 10 nodes      | Queue-based
Notification Service   | 2 nodes | 10 nodes      | Queue-based
```

### Caching Strategy

```
Level 1: CDN (Cloudflare)
- Static assets (images, CSS, JS)
- Marketing site pages
- 30-day cache for immutable assets
- 5-minute cache for dynamic pages

Level 2: Application Cache (Redis)
- User sessions (15 min TTL)
- API responses (5 min TTL)
- Partner analytics (1 hour TTL)
- Aggregate statistics (24 hour TTL)

Level 3: Database Query Cache
- PostgreSQL query cache
- Materialized views for analytics
- Refresh hourly for reporting

Level 4: Browser Cache
- Service workers for PWA
- IndexedDB for offline capability (mobile app)
```

### Database Optimization

```
Indexes:
- customers(email) UNIQUE
- customers(partner_id, created_at)
- tests(customer_id, created_at)
- tests(status, partner_id)
- audit_logs(timestamp, user_id)
- genetic_results(customer_id) UNIQUE - in Genetic Data Vault

Partitioning:
- audit_logs by month (time-series)
- tests by year (historical data)

Connection Pooling:
- Max 100 connections per service
- PgBouncer for connection management
```

### Performance Targets

```
API Response Times:
- p50: < 100ms
- p95: < 500ms
- p99: < 1000ms

Page Load Times:
- Marketing site: < 2 seconds (LCP)
- Partner portal: < 3 seconds (LCP)
- Customer portal: < 3 seconds (LCP)

Uptime:
- 99.9% uptime SLA (43 min downtime/month)
- 99.99% uptime target (4 min downtime/month)

Database Queries:
- < 50ms for simple queries
- < 200ms for complex analytics
```

---

## Disaster Recovery & Business Continuity

### Backup Strategy

```
PostgreSQL:
- Automated daily full backups (retain 30 days)
- Point-in-time recovery (7 days)
- Cross-region backup replication
- Quarterly restore testing

Genetic Data Vault:
- Automated daily encrypted backups
- Geographically redundant storage (3 regions)
- 7-year retention (compliance requirement)
- Monthly restore testing

Redis:
- RDB snapshots every 6 hours
- AOF persistence enabled
- Cross-region replication

File Storage (S3):
- Versioning enabled
- Cross-region replication
- Lifecycle policies (archive to Glacier after 1 year)
```

### Disaster Recovery Plan

```
RTO (Recovery Time Objective): 4 hours
RPO (Recovery Point Objective): 1 hour

Scenario: Complete AWS Region Failure

Hour 0:
- Automated health checks detect outage
- PagerDuty alerts on-call engineer
- Status page updated

Hour 1:
- Failover to secondary region initiated
- DNS updated to point to backup region
- Database restored from latest backup

Hour 2:
- All services up in secondary region
- Testing and validation
- Customer notifications sent

Hour 3-4:
- Full functionality restored
- Monitoring for issues
- Post-mortem analysis begins
```

---

## Development & Deployment

### Development Workflow

```
1. Local Development
   - Docker Compose for local services
   - PostgreSQL, Redis running locally
   - Mock Genetic Data Vault for testing
   - Hot reload enabled

2. Feature Branch
   - Create branch from `main`
   - Write code + tests
   - Local testing
   - Push to GitHub

3. Continuous Integration (GitHub Actions)
   - Lint and format check
   - Unit tests
   - Integration tests
   - Build Docker images
   - Security scanning (Snyk, Trivy)

4. Pull Request
   - Code review (2 approvals required)
   - Automated checks pass
   - Merge to `main`

5. Staging Deployment
   - Auto-deploy to staging environment
   - E2E tests run
   - Manual QA testing
   - Load testing (optional)

6. Production Deployment
   - Manual approval required
   - Blue-green deployment
   - Gradual rollout (10%, 50%, 100%)
   - Monitoring for errors
   - Rollback capability (< 5 min)
```

### Environments

```
Local:
- Docker Compose
- localhost:3000 (Next.js dev server)
- localhost:4000 (API server)
- Mock data, no real lab integrations

Development:
- Shared dev environment
- dev.fairunderwriting.com
- Real databases, but test data
- Lab integrations in sandbox mode

Staging:
- Production-like environment
- staging.fairunderwriting.com
- Real data from pilot partners
- Full lab integrations
- Used for final QA before production

Production:
- Live customer-facing environment
- fairunderwriting.com
- Real data, real customers
- High availability, monitoring
- Regular backups
```

### Monitoring & Alerting

```
Application Metrics:
- Request rate, error rate, latency (RED method)
- Database connection pool usage
- Queue depth (BullMQ)
- Cache hit rate (Redis)
- API rate limit usage

Business Metrics:
- Customer signups per day
- Test orders per day
- Partner enrollments per week
- Revenue per day
- Churn rate

Security Metrics:
- Failed login attempts
- MFA enrollment rate
- Suspicious activity detected
- Genetic data access attempts
- API abuse patterns

Alerts:
- P0 (Page immediately): Production down, data breach
- P1 (Page within 15 min): Elevated error rate, database issues
- P2 (Slack alert): High latency, cache issues
- P3 (Email): Non-critical warnings, scheduled maintenance
```

---

## Integration Points

### Existing Velox.AI Infrastructure

```
Leverage:
- auth.vlx.io: OAuth, SSO, user management
- api.velox.ai: Shared API patterns and libraries
- admin: UI components and patterns
- health.velox.ai: Monitoring and health checks
- docs.velox.ai: API documentation hosting

New Infrastructure:
- Fair Underwriting-specific services
- Genetic Data Vault (isolated)
- Lab integration services
- Partner/customer portals
```

### Third-Party Integrations

```
Laboratory Partners:
- Quest Diagnostics API
- LabCorp API
- Regional lab HL7/FHIR endpoints

Payment Processing:
- Stripe for credit card processing
- ACH for partner invoicing
- PayPal (optional)

Communication:
- Twilio (SMS)
- SendGrid (Email)
- Firebase (Push notifications)

Analytics:
- Plausible (web analytics)
- Mixpanel or Amplitude (product analytics)
- Google Analytics (optional, privacy concerns)

Support:
- Intercom or Zendesk (customer support)
- Slack (partner support channel)

Genetic Counseling:
- Telemedicine platform integration (future)
- Video conferencing (Zoom, Twilio Video)
```

---

## Security Testing

### Automated Security Testing

```
- SAST (Static Analysis): SonarQube, Semgrep
- DAST (Dynamic Analysis): OWASP ZAP
- Dependency Scanning: Snyk, Dependabot
- Container Scanning: Trivy, Clair
- Secrets Detection: GitGuardian, TruffleHog
```

### Manual Security Testing

```
Quarterly:
- Penetration testing by third-party firm
- HIPAA compliance audit
- SOC 2 audit preparation

Annual:
- Full security audit
- Disaster recovery testing
- Compliance certification renewal
```

---

**Document Status**: Technical Architecture Specification
**Version**: 1.0
**Last Updated**: November 7, 2025
**Next Review**: After pilot program (Q2 2026)
**Technical Lead**: [To be assigned]
