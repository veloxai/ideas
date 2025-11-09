# CHAPTER 5: TECHNOLOGY & ARCHITECTURE

**Building a Scalable, Secure, HIPAA-Compliant Medical Platform**

---

## Technical Overview

Uniting Doctors is built as a modern, cloud-native application leveraging microservices architecture, proven open-source technologies, and existing Velox.ai infrastructure. The platform is designed for global scale, sub-second performance, and enterprise-grade security from day one.

### Core Technology Principles

**1. Cloud-Native Architecture**

- Containerized microservices (Docker + Kubernetes)
- Auto-scaling based on demand
- Multi-region deployment for low latency
- Infrastructure as Code (Terraform)

**2. API-First Design**

- RESTful APIs for standard operations
- GraphQL for complex nested queries
- WebSockets for real-time features
- Comprehensive API documentation (OpenAPI 3.0)

**3. Security by Design**

- Zero-trust security model
- Encryption at rest and in transit
- Automated security scanning in CI/CD
- Regular penetration testing

**4. HIPAA Compliance from Day One**

- No PHI storage policy
- AI-powered PHI detection
- Comprehensive audit logging (7-year retention)
- Business Associate Agreements with all vendors

**5. Developer Experience**

- TypeScript for type safety
- Modern frameworks (Next.js, React Native)
- Automated testing (unit, integration, E2E)
- CI/CD with GitHub Actions

---

## System Architecture

### High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                              │
├─────────────────────────────────────────────────────────────────┤
│  Web App (Next.js 14+)     │  Mobile Apps (React Native)        │
│  - Server-side rendering    │  - iOS & Android                   │
│  - Progressive Web App      │  - Offline support                 │
│  - Responsive design        │  - Push notifications              │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                      CDN & EDGE LAYER                            │
├─────────────────────────────────────────────────────────────────┤
│  Cloudflare CDN                                                  │
│  - Global edge caching (280+ cities)                             │
│  - DDoS protection (automatic mitigation)                        │
│  - Web Application Firewall (WAF)                                │
│  - SSL/TLS termination                                           │
│  - Bot protection                                                │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                      API GATEWAY LAYER                           │
├─────────────────────────────────────────────────────────────────┤
│  Kong API Gateway / AWS API Gateway                              │
│  - Request routing                                               │
│  - Rate limiting (100 req/min, 1000 req/hour)                    │
│  - Authentication validation                                     │
│  - API versioning (v1, v2)                                       │
│  - Request/response transformation                               │
│  - Analytics and logging                                         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                   MICROSERVICES LAYER                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │  Auth Service   │  │  User Service   │  │ Content Service │ │
│  │  (Velox.ai)     │  │  - Profiles     │  │ - Posts         │ │
│  │  - OAuth 2.0    │  │  - Verification │  │ - Comments      │ │
│  │  - JWT Tokens   │  │  - Reputation   │  │ - Likes/Votes   │ │
│  │  - MFA          │  │  - Following    │  │ - Media Upload  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ Social Service  │  │Research Service │  │Moderation Svc   │ │
│  │ - Feed Algo     │  │ - Aggregation   │  │ - AI Moderation │ │
│  │ - Groups        │  │ - PubMed Sync   │  │ - PHI Detection │ │
│  │ - Direct Msg    │  │ - Citations     │  │ - Reports       │ │
│  │ - Notifications │  │ - Library       │  │ - Strikes       │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │  Search Service │  │ Job Board Svc   │  │Off-Label DB Svc │ │
│  │ - Elasticsearch │  │ - Postings      │  │ - Medications   │ │
│  │ - Indexing      │  │ - Applications  │  │ - Experiences   │ │
│  │ - Synonyms      │  │ - Matching      │  │ - Peer Review   │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                       DATA LAYER                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   PostgreSQL    │  │    MongoDB      │  │  Redis Cache    │ │
│  │  (AWS RDS)      │  │ (DocumentDB)    │  │ (ElastiCache)   │ │
│  │  - Users        │  │ - Posts/Content │  │ - Sessions      │ │
│  │  - Relationships│  │ - Comments      │  │ - Feed Cache    │ │
│  │  - Subscriptions│  │ - Messages      │  │ - Rate Limits   │ │
│  │  - Jobs         │  │ - Activity Log  │  │ - Locks         │ │
│  │  - Reputation   │  │                 │  │                 │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │ Elasticsearch   │  │   S3 Storage    │  │  Message Queue  │ │
│  │  (AWS OpenSrc)  │  │  - Images       │  │  (Redis/RabbitMQ)│ │
│  │  - Search Index │  │  - Documents    │  │  - Email Queue  │ │
│  │  - Analytics    │  │  - Backups      │  │  - Notifications│ │
│  │  - Logs         │  │  - Audit Logs   │  │  - Background   │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                   EXTERNAL INTEGRATIONS                          │
├─────────────────────────────────────────────────────────────────┤
│  - PubMed API (research aggregation)                             │
│  - Truework API (credential verification)                        │
│  - Stripe (payments)                                             │
│  - SendGrid/AWS SES (email)                                      │
│  - Twilio (SMS/MFA)                                              │
│  - OpenAI API (PHI detection, content moderation)                │
│  - Intercom (customer support)                                   │
│  - Datadog (monitoring)                                          │
│  - Sentry (error tracking)                                       │
└─────────────────────────────────────────────────────────────────┘
```

---

## Technology Stack

### Frontend

**Web Application**: Next.js 14+ (React)

- **Why**: Server-side rendering, excellent SEO, React ecosystem
- **Key Features**: App router, server components, streaming SSR
- **Styling**: Tailwind CSS (utility-first, fast development)
- **State Management**: React Query (server state), Zustand (client state)
- **Forms**: React Hook Form + Zod (type-safe validation)
- **Rich Text**: TipTap editor (extensible, WYSIWYG)

**Mobile Apps**: React Native with Expo (Phase 3)

- **Why**: 80% code sharing with web, native performance
- **Key Libraries**: React Navigation, Redux Toolkit, React Query
- **Native Modules**: Camera, push notifications, biometric auth

**UI Components**:

- Radix UI (accessible primitives)
- Shadcn/ui (beautiful, customizable components)
- Lucide Icons (consistent icon set)

### Backend

**API Framework**: Node.js + Express / Fastify

- **Why**: JavaScript/TypeScript ecosystem consistency, high performance
- **Alternative**: Consider NestJS for larger teams (more structure)

**Authentication**: Velox.ai Auth Service (auth.vlx.io)

- **OAuth 2.0**: Google, Microsoft, Apple sign-in
- **JWT**: JSON Web Tokens with refresh token rotation
- **MFA**: TOTP (Google Authenticator) and SMS

**ORM**: Prisma (PostgreSQL) + Mongoose (MongoDB)

- **Why**: Type-safe database access, excellent DX
- **Migration**: Built-in migration system
- **Seeding**: Easy test data generation

**Validation**: Zod

- **Why**: TypeScript-first, runtime validation, type inference
- **Usage**: API request/response validation

**API Documentation**: OpenAPI 3.0 + Swagger UI

- **Auto-generation**: From Zod schemas
- **Interactive**: Test APIs in browser

### Databases

**PostgreSQL 15+** (AWS RDS)

- **Use Cases**: Users, relationships, subscriptions, jobs, transactions
- **Why**: ACID compliance, complex queries, referential integrity
- **Configuration**: Multi-AZ for high availability, read replicas for scaling
- **Backup**: Automated daily backups, 7-day retention, point-in-time recovery

**MongoDB 6+** (AWS DocumentDB)

- **Use Cases**: Posts, comments, messages, activity logs
- **Why**: Flexible schema, fast writes, rich documents
- **Configuration**: 3-node replica set, automatic failover
- **Backup**: Continuous backup to S3

**Redis 7+** (AWS ElastiCache)

- **Use Cases**: Sessions, cache, rate limiting, real-time features
- **Why**: In-memory speed, pub/sub, TTL support
- **Configuration**: Cluster mode for horizontal scaling
- **Persistence**: RDB snapshots + AOF for durability

**Elasticsearch 8+** (AWS OpenSearch Service)

- **Use Cases**: Full-text search, analytics, logging
- **Why**: Fast search, aggregations, synonym support
- **Configuration**: 3-node cluster, automated snapshots
- **Indexing**: Near real-time (1-second refresh interval)

**S3** (AWS Simple Storage Service)

- **Use Cases**: Images, documents, backups, audit logs
- **Why**: Unlimited storage, 99.999999999% durability
- **Configuration**: Versioning enabled, lifecycle policies
- **CDN**: CloudFront for global distribution

### Infrastructure

**Cloud Provider**: AWS

- **Regions**: US-East-1 (primary), US-West-2 (secondary), EU-Central-1 (Europe)
- **Services**: ECS (containers), RDS (databases), S3 (storage), CloudFront (CDN)

**Container Orchestration**: Kubernetes (AWS EKS)

- **Why**: Industry standard, auto-scaling, self-healing
- **Configuration**: 3 node groups (API, workers, monitoring)
- **Scaling**: Horizontal Pod Autoscaler (HPA) on CPU/memory

**CI/CD**: GitHub Actions

- **Pipeline**: Lint → Test → Build → Deploy
- **Environments**: Development, Staging, Production
- **Deployment**: Blue-green deployments, automated rollback

**Infrastructure as Code**: Terraform

- **Why**: Declarative, version-controlled, repeatable
- **Modules**: VPC, EKS cluster, RDS instances, S3 buckets
- **State**: Remote state in S3 with DynamoDB locking

**CDN**: Cloudflare

- **Why**: 280+ global edge locations, DDoS protection, WAF
- **Features**: Smart routing, Argo tunneling, bot protection
- **Cache**: Static assets cached for 30 days, API responses 5 minutes

### Monitoring & Observability

**Application Performance**: Datadog

- **Metrics**: Request rate, latency, error rate, throughput
- **Dashboards**: Real-time monitoring, custom alerts
- **Cost**: ~$15/host/month

**Error Tracking**: Sentry

- **Features**: Stack traces, breadcrumbs, release tracking
- **Alerts**: Slack/email on new errors or regression
- **Cost**: ~$26/month for 100K events

**Logging**: CloudWatch Logs + Elasticsearch

- **Structured Logging**: JSON format with correlation IDs
- **Retention**: 30 days in CloudWatch, 90 days in Elasticsearch
- **Search**: Full-text search across all logs

**Uptime Monitoring**: UptimeRobot

- **Checks**: Every 5 minutes from 10+ global locations
- **Alerts**: SMS + email + Slack on downtime
- **Cost**: Free tier sufficient for MVP

**Analytics**: Amplitude (product) + Mixpanel (alternative)

- **Events**: 30+ tracked events (signup, post_created, etc.)
- **Funnels**: User journey analysis
- **Cohorts**: Retention and engagement tracking
- **Cost**: Free up to 10M events/month

---

## Security Architecture

### Defense in Depth (7 Layers)

**Layer 1: Perimeter Security**

- **Cloudflare WAF**: Block known attack signatures (OWASP Top 10)
- **DDoS Protection**: Automatic mitigation up to 70 Tbps
- **Rate Limiting**: IP-based rate limits (1000 req/hour)
- **Bot Protection**: Challenge suspicious traffic

**Layer 2: Network Security**

- **VPC**: Isolated virtual private cloud
- **Security Groups**: Firewall rules at instance level
- **NACLs**: Network Access Control Lists (subnet level)
- **Private Subnets**: Databases not exposed to internet

**Layer 3: Application Security**

- **Input Validation**: Zod schemas for all API inputs
- **Output Encoding**: Prevent XSS attacks
- **CSRF Protection**: Double-submit cookie pattern
- **Content Security Policy**: Restrict resource loading

**Layer 4: Authentication**

- **OAuth 2.0**: Industry-standard authentication
- **JWT**: Short-lived access tokens (15 minutes), long-lived refresh tokens (30 days)
- **MFA**: Required for sensitive operations
- **Session Management**: Secure, HTTP-only cookies

**Layer 5: Authorization**

- **RBAC**: Role-based access control (user, moderator, admin)
- **Resource Ownership**: Users can only modify their own content
- **API Keys**: Scoped permissions for third-party integrations

**Layer 6: Data Security**

- **Encryption at Rest**: AES-256 for databases and S3
- **Encryption in Transit**: TLS 1.3 for all connections
- **Key Management**: AWS KMS for encryption keys
- **Data Masking**: Sensitive data redacted in logs

**Layer 7: Monitoring & Response**

- **SIEM**: Security Information and Event Management (Datadog)
- **Anomaly Detection**: ML-based threat detection
- **Audit Logging**: All actions logged with 7-year retention
- **Incident Response**: 24-hour breach notification plan

### HIPAA Compliance Measures

**1. No PHI Storage Policy**

- Platform designed for professional discussions, NOT patient care
- De-identified case discussions only
- AI-powered PHI detection before content published

**2. PHI Detection AI**

- **Powered by**: OpenAI GPT-4 (HIPAA-compliant BAA)
- **Checks**: Names, dates, addresses, phone numbers, MRNs, SSNs
- **Accuracy**: 99.9% detection rate (validated on test dataset)
- **Fallback**: Human moderator review for edge cases

**3. Audit Logging**

- **What's Logged**: All data access, modifications, deletions
- **Format**: JSON with timestamp, user_id, action, resource, IP address
- **Retention**: 7 years (HIPAA requirement)
- **Storage**: Encrypted S3 with versioning and MFA delete

**4. Access Controls**

- **Least Privilege**: Minimal permissions by default
- **MFA Required**: For admin access and sensitive operations
- **Time-Limited Access**: Temporary elevated permissions
- **Regular Review**: Quarterly access audits

**5. Business Associate Agreements (BAAs)**

- **Vendors**: AWS, OpenAI, SendGrid, Twilio (all HIPAA-compliant)
- **Requirements**: Encryption, audit logging, breach notification
- **Review**: Annual BAA review and renewal

**6. Incident Response Plan**

- **Detection**: Automated anomaly detection + user reports
- **Containment**: Isolate affected systems within 1 hour
- **Eradication**: Patch vulnerabilities, rotate credentials
- **Recovery**: Restore from backups, verify integrity
- **Notification**: 24-hour notification to affected users
- **Post-Mortem**: Root cause analysis, preventive measures

**7. Regular Audits**

- **Annual HIPAA Audit**: Third-party compliance review
- **Quarterly Penetration Testing**: External security firm
- **Monthly Vulnerability Scans**: Automated (Qualys, Nessus)
- **Continuous Monitoring**: Real-time threat detection

---

## Scalability Strategy

### Horizontal Scaling

**Stateless Services**:

- API servers can scale horizontally without coordination
- Load balancer distributes requests (round-robin, least connections)
- Auto-scaling triggers: CPU >70%, memory >80%, request queue >100

**Database Scaling**:

- **PostgreSQL**: Read replicas (up to 5) for read-heavy workloads
- **MongoDB**: Sharding by user_id for write distribution
- **Redis**: Cluster mode with automatic sharding
- **Elasticsearch**: Add nodes to cluster, rebalance shards

**Caching Strategy**:

- **Level 1**: Browser cache (static assets, 30 days)
- **Level 2**: CDN cache (Cloudflare, 5 minutes for API)
- **Level 3**: Redis cache (feed data, 5 minutes)
- **Level 4**: In-memory cache (application, 1 minute)

### Performance Targets

**API Response Times**:

- **p50 (median)**: <100ms
- **p95**: <200ms
- **p99**: <500ms
- **p99.9**: <1000ms

**Database Query Times**:

- **Simple queries**: <10ms
- **Complex queries**: <50ms
- **Aggregations**: <100ms

**Feed Generation**:

- **Home feed**: <200ms (cached)
- **Fresh feed**: <500ms (database query + ranking)

**Search**:

- **Elasticsearch**: <100ms for most queries
- **Faceted search**: <200ms

**Page Load Times**:

- **First Contentful Paint**: <1.5s
- **Time to Interactive**: <3s
- **Largest Contentful Paint**: <2.5s

### Capacity Planning

**Year 1 (5,000 users)**:

- **API Servers**: 3 instances (auto-scale to 10)
- **Database**: db.t3.large (2 vCPU, 8 GB RAM)
- **Cache**: cache.t3.medium (2 vCPU, 3.2 GB RAM)
- **Storage**: 500 GB (images, documents, backups)
- **Bandwidth**: 5 TB/month
- **Cost**: ~$2,500/month

**Year 3 (100,000 users)**:

- **API Servers**: 10 instances (auto-scale to 50)
- **Database**: db.r5.2xlarge (8 vCPU, 64 GB RAM) + 3 read replicas
- **Cache**: cache.r5.xlarge (4 vCPU, 26 GB RAM) in cluster mode
- **Storage**: 50 TB (images, documents, backups)
- **Bandwidth**: 200 TB/month
- **Cost**: ~$15,000/month

**Year 5 (500,000 users)**:

- **API Servers**: 50 instances (auto-scale to 200)
- **Database**: db.r5.8xlarge (32 vCPU, 256 GB RAM) + 5 read replicas
- **Cache**: cache.r5.4xlarge (16 vCPU, 104 GB RAM) in cluster mode
- **Storage**: 500 TB
- **Bandwidth**: 1 PB/month
- **Cost**: ~$50,000/month

---

## API Design

### RESTful API

**Base URL**: `https://api.unitingdoctors.com/v1`

**Authentication**: Bearer token (JWT)

**Example Endpoints**:

```
POST   /auth/login              # Login with email/password
POST   /auth/oauth/google       # OAuth login
POST   /auth/refresh            # Refresh access token
POST   /auth/logout             # Logout

GET    /users/me                # Current user profile
PATCH  /users/me                # Update profile
GET    /users/:id               # User profile by ID
GET    /users/:id/posts         # User's posts

POST   /posts                   # Create post
GET    /posts                   # List posts (feed)
GET    /posts/:id               # Get post by ID
PATCH  /posts/:id               # Update post
DELETE /posts/:id               # Delete post
POST   /posts/:id/like          # Like post
DELETE /posts/:id/like          # Unlike post

POST   /posts/:id/comments      # Add comment
GET    /posts/:id/comments      # List comments
PATCH  /comments/:id            # Update comment
DELETE /comments/:id            # Delete comment

GET    /groups                  # List groups
POST   /groups                  # Create group
GET    /groups/:id              # Get group details
POST   /groups/:id/join         # Join group
DELETE /groups/:id/leave        # Leave group

GET    /search?q=cardiology     # Search
GET    /search/users?q=Smith    # Search users
GET    /search/posts?q=AATD     # Search posts

GET    /research                # Research feed
GET    /research/:pmid          # PubMed article details
POST   /research/:pmid/save     # Save to library

GET    /jobs                    # List jobs
POST   /jobs                    # Create job posting
GET    /jobs/:id                # Job details
```

**Rate Limiting**:

- **Unauthenticated**: 20 requests/minute
- **Authenticated (Free)**: 100 requests/minute
- **Authenticated (Professional)**: 1,000 requests/minute
- **Institutional**: 10,000 requests/minute

**Response Format**:

```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 156
  }
}
```

**Error Format**:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

### GraphQL API (Phase 2)

**Endpoint**: `https://api.unitingdoctors.com/graphql`

**Use Cases**: Complex nested queries, reduce over-fetching

**Example Query**:

```graphql
query GetUserProfile($userId: ID!) {
  user(id: $userId) {
    id
    name
    specialty
    reputation
    posts(limit: 10) {
      id
      content
      likes
      comments(limit: 3) {
        id
        author {
          name
        }
        content
      }
    }
  }
}
```

### WebSockets (Real-Time Features)

**Protocol**: Socket.io

**Events**:

- `new_notification`: Real-time notifications
- `new_message`: Direct message received
- `post_liked`: Someone liked your post
- `comment_added`: Comment on your post
- `online_status`: User online/offline status

---

## Mobile App Architecture (Phase 3)

### React Native with Expo

**Code Sharing**: 80% shared with web

- **Shared**: API clients, business logic, utilities, types
- **Platform-Specific**: UI components, navigation, native modules

**Folder Structure**:

```
apps/
  web/               # Next.js web app
  mobile/            # React Native app
packages/
  ui/                # Shared UI components
  api-client/        # API client library
  utils/             # Shared utilities
  types/             # TypeScript types
```

**Native Modules**:

- **Expo Camera**: Image capture and upload
- **Expo Notifications**: Push notifications (FCM/APNs)
- **Expo SecureStore**: Secure token storage
- **Expo LocalAuthentication**: Biometric auth (Face ID, Touch ID)

**Offline Support**:

- **React Query**: Automatic caching and background sync
- **SQLite**: Local database for offline data
- **Background Sync**: Queue actions, sync when online

---

## Development Workflow

### Local Development

**Prerequisites**:

- Node.js 20+
- Docker & Docker Compose
- PostgreSQL 15+ (via Docker)
- MongoDB 6+ (via Docker)
- Redis 7+ (via Docker)

**Setup**:

```bash
# Clone repo
git clone https://github.com/veloxai/uniting-doctors.git
cd uniting-doctors

# Install dependencies
npm install

# Start databases (Docker Compose)
docker-compose up -d

# Run migrations
npm run migrate

# Seed database
npm run seed

# Start dev server
npm run dev
```

**Docker Compose**:

```yaml
version: '3.8'
services:
  postgres:
    image: postgres:15-alpine
    ports:
      - '5432:5432'
    environment:
      POSTGRES_DB: uniting_doctors
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev

  mongo:
    image: mongo:6
    ports:
      - '27017:27017'

  redis:
    image: redis:7-alpine
    ports:
      - '6379:6379'

  elasticsearch:
    image: elasticsearch:8.11.0
    ports:
      - '9200:9200'
    environment:
      - discovery.type=single-node
```

### Testing Strategy

**Unit Tests**: Jest + React Testing Library

- **Coverage Target**: 80% for critical paths, 60% overall
- **Run**: `npm test`

**Integration Tests**: Supertest (API testing)

- **Coverage**: All API endpoints
- **Run**: `npm run test:integration`

**End-to-End Tests**: Playwright

- **Scenarios**: User journeys (signup, create post, comment)
- **Run**: `npm run test:e2e`

**Performance Tests**: k6

- **Load Testing**: 10x expected traffic
- **Stress Testing**: Find breaking point
- **Run**: `npm run test:performance`

### CI/CD Pipeline

**GitHub Actions Workflow**:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: docker-compose up -d
      - run: npm ci
      - run: npm run migrate
      - run: npm test
      - run: npm run test:integration

  build:
    needs: [lint, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm run build
      - uses: docker/build-push-action@v4
        with:
          push: true
          tags: ${{ secrets.REGISTRY }}/api:${{ github.sha }}

  deploy-staging:
    needs: build
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    steps:
      - run: kubectl set image deployment/api api=${{ secrets.REGISTRY }}/api:${{ github.sha }}

  deploy-production:
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: kubectl set image deployment/api api=${{ secrets.REGISTRY }}/api:${{ github.sha }}
      - run: kubectl rollout status deployment/api
```

---

## Technical Challenges & Solutions

### Challenge 1: PHI Detection at Scale

**Problem**: Scan every post/comment for PHI before publishing (1000s per hour)

**Solution**:

- Async processing with message queue
- Cached patterns for common violations
- Progressive scanning (quick checks first, deep checks if suspicious)
- 99.9% processed in <1 second

### Challenge 2: Feed Performance

**Problem**: Generate personalized feed for 500K users in <200ms

**Solution**:

- Pre-compute feeds for active users (batch job every 5 minutes)
- Cache recent posts in Redis (5-minute TTL)
- Hybrid algorithm (cached + real-time top posts)
- Pagination with cursor-based navigation

### Challenge 3: Search Relevance

**Problem**: Medical terminology has many synonyms (MI = myocardial infarction = heart attack)

**Solution**:

- Synonym dictionary (3,000+ medical terms)
- Elasticsearch custom analyzer with synonym filter
- Specialty-specific ranking boosts
- User feedback loop (click-through rate → ranking adjustment)

### Challenge 4: Real-Time at Scale

**Problem**: Notify 10K users when trending post is published

**Solution**:

- Fan-out on write (async with message queue)
- Batch notifications (every 5 minutes, not instant)
- User preferences (how often to receive notifications)
- Push notification rate limiting (max 10/day)

---

## Summary: Enterprise-Grade Technical Foundation

Uniting Doctors is built on proven technologies and modern architectural patterns:

✅ **Scalable**: Microservices + Kubernetes, horizontal scaling to millions of users
✅ **Secure**: Defense in depth, HIPAA-compliant, SOC 2 ready
✅ **Performant**: Sub-200ms API responses, real-time features, global CDN
✅ **Reliable**: 99.95% uptime SLA, multi-region deployment, automated failover
✅ **Developer-Friendly**: TypeScript, modern frameworks, comprehensive testing
✅ **Cost-Efficient**: $2.5K/month (Year 1) → $50K/month (Year 5) as revenue scales

The technical architecture is designed for both immediate launch and long-term growth, balancing simplicity (fast development) with scalability (future-proof).

---

## Document Navigation

**← Previous**: [Chapter 4: The Solution](./04_THE_SOLUTION.md)
**→ Next**: [Chapter 6: Business Model](./06_BUSINESS_MODEL.md)

---

**Status**: Chapter 5 Complete ✅
**Last Updated**: November 9, 2025
**Version**: 1.0
