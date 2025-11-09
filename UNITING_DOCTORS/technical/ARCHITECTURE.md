# UNITING DOCTORS - PLATFORM ARCHITECTURE

**Last Updated**: November 8, 2025

---

## 🏗️ System Architecture Overview

Uniting Doctors is built as a modern, scalable, cloud-native application leveraging microservices architecture and existing Velox.ai infrastructure.

### Architecture Principles

1. **Microservices-Based**: Separate services for core functions
2. **API-First**: RESTful APIs with GraphQL for complex queries
3. **Cloud-Native**: Designed for AWS/Cloudflare deployment
4. **Security-First**: HIPAA-compliant, encrypted, audited
5. **Scalable**: Horizontal scaling for millions of users
6. **Real-Time**: WebSocket connections for live updates
7. **Mobile-Ready**: API-driven for web and mobile clients

---

## 📊 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                              │
├─────────────────────────────────────────────────────────────────┤
│  Web App (Next.js)  │  Mobile Apps (React Native - Future)      │
│  - Responsive        │  - iOS                                     │
│  - PWA Capable       │  - Android                                 │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         CDN LAYER                                │
├─────────────────────────────────────────────────────────────────┤
│  Cloudflare CDN      │  Static Assets  │  Edge Caching          │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      API GATEWAY LAYER                           │
├─────────────────────────────────────────────────────────────────┤
│  - Rate Limiting     │  - Authentication  │  - Request Routing   │
│  - DDoS Protection   │  - Load Balancing  │  - API Versioning    │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    APPLICATION SERVICES                          │
├─────────────────────────────────────────────────────────────────┤
│  Auth Service        │  User Service      │  Content Service     │
│  (Velox.ai)          │  - Profiles        │  - Posts            │
│  - OAuth 2.0         │  - Verification    │  - Comments         │
│  - JWT Tokens        │  - Reputation      │  - Likes            │
│  - MFA               │                    │  - Shares           │
├─────────────────────────────────────────────────────────────────┤
│  Social Service      │  Research Service  │  Moderation Service │
│  - Feed Algorithm    │  - Aggregation     │  - AI Moderation    │
│  - Groups            │  - Citations       │  - Reports          │
│  - DMs               │  - Literature      │  - Flags            │
├─────────────────────────────────────────────────────────────────┤
│  Search Service      │  Job Board Service │  Notification Svc   │
│  - Elasticsearch     │  - Postings        │  - Email            │
│  - Filters           │  - Applications    │  - Push             │
│  - Tagging           │  - Analytics       │  - In-App           │
├─────────────────────────────────────────────────────────────────┤
│  Off-Label DB Svc    │  Analytics Service │  CME Service        │
│  - Medications       │  - User Analytics  │  - Courses          │
│  - Outcomes          │  - Platform Metrics│  - Credits          │
│  - Discussions       │  - Insights        │  - Tracking         │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       DATA LAYER                                 │
├─────────────────────────────────────────────────────────────────┤
│  PostgreSQL          │  MongoDB           │  Redis Cache        │
│  - Users             │  - Posts/Content   │  - Sessions         │
│  - Relationships     │  - Comments        │  - Feed Cache       │
│  - Transactions      │  - Messages        │  - Rate Limits      │
├─────────────────────────────────────────────────────────────────┤
│  Elasticsearch       │  S3 Storage        │  Message Queue      │
│  - Search Index      │  - Images          │  - RabbitMQ/Redis   │
│  - Aggregations      │  - Documents       │  - Background Jobs  │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    EXTERNAL INTEGRATIONS                         │
├─────────────────────────────────────────────────────────────────┤
│  PubMed API          │  License Verification │  Email Service   │
│  Crossref API        │  SendGrid/AWS SES     │  Analytics       │
│  Journal APIs        │  NPI Registry         │  Monitoring      │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔐 Authentication & Authorization

### Leveraging Velox.ai Auth System

**Authentication Service**: Use existing `auth.vlx.io` infrastructure

**Features**:
- OAuth 2.0 with multiple providers
- JWT-based authentication
- Multi-factor authentication (MFA)
- Passwordless login options
- Session management
- API key management

**User Verification**:
- Medical license verification (NPI for US, GMC for UK, etc.)
- Educational credentials (medical school, residency)
- Institution verification (hospital, clinic, research center)
- Identity verification (government ID)

**Authorization Levels**:
1. **Unverified User**: Limited access (can browse, cannot post)
2. **Verified Medical Professional**: Full access to platform
3. **Verified Specialist**: Badge, special privileges in specialty groups
4. **Institutional Admin**: Manage team accounts
5. **Platform Admin**: Full moderation and management access

---

## 💾 Data Architecture

### Database Strategy: Polyglot Persistence

#### PostgreSQL (Primary Database)
**Use Cases**: Structured, relational data

**Schema**:
```sql
-- Users
users (
  id UUID PRIMARY KEY,
  auth_id UUID REFERENCES velox_auth.users,
  email VARCHAR(255) UNIQUE,
  username VARCHAR(50) UNIQUE,
  display_name VARCHAR(100),
  bio TEXT,
  specialty VARCHAR(100),
  sub_specialty VARCHAR(100),
  credentials TEXT[], -- MD, DO, RN, PhD, etc.
  verification_status ENUM('unverified', 'pending', 'verified'),
  verification_details JSONB,
  reputation_score INTEGER DEFAULT 0,
  is_specialist BOOLEAN DEFAULT FALSE,
  anonymity_settings JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Verification Documents
verification_documents (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  document_type ENUM('license', 'degree', 'id', 'institution'),
  file_url VARCHAR(500),
  status ENUM('pending', 'approved', 'rejected'),
  reviewed_by UUID REFERENCES users(id),
  reviewed_at TIMESTAMP,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Relationships
user_relationships (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  target_user_id UUID REFERENCES users(id),
  relationship_type ENUM('follow', 'block', 'mute'),
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, target_user_id, relationship_type)
);

-- Groups
groups (
  id UUID PRIMARY KEY,
  name VARCHAR(100),
  slug VARCHAR(100) UNIQUE,
  description TEXT,
  group_type ENUM('specialty', 'disease', 'topic', 'institution'),
  privacy ENUM('public', 'private', 'secret'),
  member_count INTEGER DEFAULT 0,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Group Memberships
group_memberships (
  id UUID PRIMARY KEY,
  group_id UUID REFERENCES groups(id),
  user_id UUID REFERENCES users(id),
  role ENUM('member', 'moderator', 'admin'),
  joined_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(group_id, user_id)
);

-- Jobs
jobs (
  id UUID PRIMARY KEY,
  title VARCHAR(200),
  description TEXT,
  institution VARCHAR(200),
  location VARCHAR(200),
  salary_range VARCHAR(100),
  job_type ENUM('full-time', 'part-time', 'contract', 'locum'),
  specialty VARCHAR(100),
  posted_by UUID REFERENCES users(id),
  status ENUM('active', 'filled', 'expired', 'closed'),
  expires_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Subscriptions
subscriptions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  plan ENUM('free', 'professional', 'institutional'),
  status ENUM('active', 'cancelled', 'expired', 'trial'),
  stripe_subscription_id VARCHAR(100),
  current_period_start TIMESTAMP,
  current_period_end TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Reputation Events
reputation_events (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  event_type ENUM('post_liked', 'post_cited', 'comment_upvoted', 'expert_badge', 'penalty'),
  points INTEGER,
  source_id UUID, -- post_id, comment_id, etc.
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

#### MongoDB (Content Database)
**Use Cases**: Flexible, document-based content

**Collections**:

**posts**:
```javascript
{
  _id: ObjectId,
  user_id: UUID,
  is_anonymous: Boolean,
  content: String,
  content_html: String, // Sanitized HTML
  media: [{
    type: 'image' | 'video' | 'document',
    url: String,
    thumbnail_url: String,
    metadata: Object
  }],
  tags: [String],
  citations: [{
    source: String,
    url: String,
    title: String,
    authors: [String],
    year: Number
  }],
  post_type: 'discussion' | 'question' | 'news' | 'research' | 'case',
  groups: [UUID], // Group IDs
  engagement: {
    likes: Number,
    comments: Number,
    shares: Number,
    views: Number,
    saves: Number
  },
  moderation_status: 'pending' | 'approved' | 'flagged' | 'removed',
  created_at: Date,
  updated_at: Date,
  edited_at: Date
}
```

**comments**:
```javascript
{
  _id: ObjectId,
  post_id: ObjectId,
  user_id: UUID,
  is_anonymous: Boolean,
  parent_comment_id: ObjectId, // For nested comments
  content: String,
  content_html: String,
  citations: [Object],
  likes: Number,
  moderation_status: String,
  created_at: Date,
  updated_at: Date
}
```

**messages** (Direct Messages):
```javascript
{
  _id: ObjectId,
  conversation_id: UUID,
  sender_id: UUID,
  recipient_id: UUID,
  content: String,
  encrypted: Boolean,
  read_at: Date,
  created_at: Date
}
```

**off_label_medications**:
```javascript
{
  _id: ObjectId,
  medication_name: String,
  approved_uses: [String],
  off_label_use: String,
  condition: String,
  evidence_level: 'anecdotal' | 'case_series' | 'clinical_trial' | 'meta_analysis',
  experiences: [{
    user_id: UUID,
    is_anonymous: Boolean,
    outcome: 'positive' | 'neutral' | 'negative',
    details: String,
    duration: String,
    dosage: String,
    citations: [Object],
    created_at: Date
  }],
  citations: [Object],
  discussion_thread_id: ObjectId,
  created_at: Date,
  updated_at: Date
}
```

**research_items**:
```javascript
{
  _id: ObjectId,
  source: 'pubmed' | 'crossref' | 'manual',
  external_id: String, // PubMed ID, DOI, etc.
  title: String,
  authors: [String],
  abstract: String,
  journal: String,
  publication_date: Date,
  url: String,
  tags: [String],
  specialty: String,
  engagement: {
    shares: Number,
    saves: Number,
    discussions: Number
  },
  aggregated_at: Date,
  created_at: Date
}
```

---

#### Redis (Caching & Real-Time)
**Use Cases**: Fast caching, session storage, real-time features

**Data Structures**:
- **Session cache**: `session:{session_id}` → User data
- **Feed cache**: `feed:{user_id}` → Cached feed posts
- **Rate limits**: `rate_limit:{user_id}:{action}` → Request count
- **Online users**: `online_users` → Set of user IDs
- **Trending topics**: `trending:{timeframe}` → Sorted set of topics
- **Notification queue**: `notifications:{user_id}` → List of notifications
- **Real-time counters**: `post:{post_id}:likes` → Counter

---

#### Elasticsearch (Search Engine)
**Use Cases**: Full-text search, complex queries, aggregations

**Indices**:

**users_index**:
```json
{
  "user_id": "uuid",
  "username": "string",
  "display_name": "string",
  "bio": "text",
  "specialty": "keyword",
  "sub_specialty": "keyword",
  "credentials": ["keyword"],
  "reputation_score": "integer",
  "is_verified": "boolean"
}
```

**posts_index**:
```json
{
  "post_id": "uuid",
  "user_id": "uuid",
  "content": "text",
  "tags": ["keyword"],
  "post_type": "keyword",
  "specialty": "keyword",
  "citations_count": "integer",
  "engagement_score": "float",
  "created_at": "date"
}
```

**research_index**:
```json
{
  "research_id": "uuid",
  "title": "text",
  "abstract": "text",
  "authors": ["text"],
  "journal": "keyword",
  "specialty": "keyword",
  "publication_date": "date",
  "tags": ["keyword"]
}
```

---

## 🚀 API Design

### RESTful API Structure

**Base URL**: `https://api.unitingdoctors.com/v1`

**Authentication**: 
- Bearer token (JWT from Velox.ai auth)
- `Authorization: Bearer {token}`

**Core Endpoints**:

#### Users
```
GET    /users/me                  # Get current user
PUT    /users/me                  # Update current user
GET    /users/:userId             # Get user profile
GET    /users/:userId/posts       # Get user's posts
POST   /users/:userId/follow      # Follow user
DELETE /users/:userId/follow      # Unfollow user
GET    /users/search              # Search users
POST   /users/verify              # Submit verification
```

#### Posts
```
GET    /posts                     # Get feed
POST   /posts                     # Create post
GET    /posts/:postId             # Get single post
PUT    /posts/:postId             # Update post
DELETE /posts/:postId             # Delete post
POST   /posts/:postId/like        # Like post
DELETE /posts/:postId/like        # Unlike post
POST   /posts/:postId/share       # Share post
POST   /posts/:postId/save        # Save post
POST   /posts/:postId/report      # Report post
GET    /posts/:postId/comments    # Get comments
POST   /posts/:postId/comments    # Create comment
```

#### Groups
```
GET    /groups                    # List groups
POST   /groups                    # Create group
GET    /groups/:groupId           # Get group details
PUT    /groups/:groupId           # Update group
DELETE /groups/:groupId           # Delete group
POST   /groups/:groupId/join      # Join group
DELETE /groups/:groupId/leave     # Leave group
GET    /groups/:groupId/posts     # Get group posts
GET    /groups/:groupId/members   # Get group members
```

#### Research
```
GET    /research                  # Get research feed
GET    /research/:researchId      # Get research details
POST   /research/save             # Save research
GET    /research/saved            # Get saved research
GET    /research/search           # Search research
```

#### Off-Label Database
```
GET    /off-label                 # List medications
GET    /off-label/:medicationId   # Get medication details
POST   /off-label                 # Create entry
POST   /off-label/:id/experience  # Add experience
GET    /off-label/search          # Search medications
```

#### Jobs
```
GET    /jobs                      # List jobs
POST   /jobs                      # Create job posting
GET    /jobs/:jobId               # Get job details
PUT    /jobs/:jobId               # Update job
DELETE /jobs/:jobId               # Close job
POST   /jobs/:jobId/apply         # Apply to job
```

#### Messaging
```
GET    /messages/conversations    # List conversations
POST   /messages/conversations    # Start conversation
GET    /messages/:conversationId  # Get conversation messages
POST   /messages/:conversationId  # Send message
PUT    /messages/:messageId/read  # Mark as read
```

#### Search
```
GET    /search?q=query&type=posts|users|research|groups
```

---

### GraphQL API (Phase 2)

**Endpoint**: `https://api.unitingdoctors.com/graphql`

**Use Cases**: Complex queries, nested data, mobile app optimization

**Example Query**:
```graphql
query GetFeed($limit: Int, $cursor: String) {
  feed(limit: $limit, cursor: $cursor) {
    edges {
      node {
        id
        content
        isAnonymous
        author {
          id
          displayName
          specialty
          reputationScore
        }
        engagement {
          likes
          comments
          shares
        }
        citations {
          title
          url
        }
      }
      cursor
    }
    pageInfo {
      hasNextPage
      endCursor
    }
  }
}
```

---

## 🔄 Real-Time Features (WebSockets)

**Protocol**: Socket.io

**Endpoint**: `wss://realtime.unitingdoctors.com`

**Real-Time Events**:
- New posts in followed groups
- New comments on user's posts
- New direct messages
- Likes and engagement notifications
- Live typing indicators in DMs
- Online/offline status
- Real-time feed updates

---

## 📱 Frontend Architecture

### Next.js 14+ (App Router)

**Structure**:
```
src/
├── app/
│   ├── (auth)/
│   │   ├── login/
│   │   ├── register/
│   │   └── verify/
│   ├── (dashboard)/
│   │   ├── feed/
│   │   ├── groups/
│   │   ├── research/
│   │   ├── off-label/
│   │   ├── jobs/
│   │   ├── messages/
│   │   └── profile/
│   ├── api/ (API routes for server-side operations)
│   └── layout.tsx
├── components/
│   ├── ui/ (shadcn/ui components)
│   ├── feed/
│   ├── posts/
│   ├── groups/
│   └── shared/
├── lib/
│   ├── api/ (API client functions)
│   ├── auth/ (Auth utilities)
│   ├── hooks/ (React hooks)
│   └── utils/
└── stores/ (Zustand stores)
```

**Key Technologies**:
- **Framework**: Next.js 14+ (React 18+)
- **Styling**: Tailwind CSS + shadcn/ui
- **State**: Zustand + React Query
- **Forms**: React Hook Form + Zod validation
- **Real-time**: Socket.io client
- **Rich Text**: TipTap or Lexical editor
- **Charts**: Recharts or Chart.js

---

## 🛡️ Security Architecture

### Security Layers

1. **Network Security**
   - DDoS protection (Cloudflare)
   - Rate limiting (API Gateway)
   - IP whitelisting/blacklisting
   - Geofencing

2. **Application Security**
   - Input validation and sanitization
   - XSS protection
   - CSRF tokens
   - SQL injection prevention (parameterized queries)
   - Content Security Policy (CSP)

3. **Authentication Security**
   - OAuth 2.0 (Velox.ai)
   - JWT with short expiration
   - Refresh token rotation
   - MFA for sensitive operations
   - Device fingerprinting

4. **Data Security**
   - Encryption at rest (AES-256)
   - Encryption in transit (TLS 1.3)
   - End-to-end encryption for DMs
   - Secure file upload (virus scanning)
   - HIPAA-compliant data handling

5. **Anonymity Protection**
   - Anonymous post attribution obfuscation
   - IP address anonymization
   - User agent randomization
   - Reputation attribution without identity exposure

---

## 📊 Monitoring & Observability

### Monitoring Stack

**Application Performance Monitoring (APM)**:
- **Tool**: DataDog or New Relic
- **Metrics**: Response times, error rates, throughput
- **Tracing**: Distributed tracing across services

**Logging**:
- **Tool**: ELK Stack (Elasticsearch, Logstash, Kibana) or DataDog Logs
- **Logs**: Application logs, access logs, error logs, audit logs

**Error Tracking**:
- **Tool**: Sentry
- **Features**: Real-time error notifications, stack traces, user context

**Infrastructure Monitoring**:
- **Tool**: CloudWatch (AWS) or Grafana
- **Metrics**: CPU, memory, disk, network

**Analytics**:
- **User Analytics**: Mixpanel or Amplitude
- **Product Analytics**: Custom dashboards (engagement, retention, feature usage)

---

## 🚀 Deployment & Infrastructure

### Cloud Provider: AWS (Primary)

**Services**:
- **Compute**: ECS (Fargate) for containers
- **Database**: RDS (PostgreSQL), DocumentDB (MongoDB-compatible)
- **Cache**: ElastiCache (Redis)
- **Search**: OpenSearch (Elasticsearch-compatible)
- **Storage**: S3 for files
- **CDN**: CloudFront + Cloudflare
- **Load Balancer**: Application Load Balancer (ALB)
- **DNS**: Route 53
- **Email**: SES
- **Monitoring**: CloudWatch
- **Secrets**: Secrets Manager

**Regions**:
- Primary: US-East-1 (Virginia)
- Secondary: EU-West-1 (Ireland) - for international users
- Backup: US-West-2 (Oregon)

---

### CI/CD Pipeline

**Tools**: GitHub Actions

**Pipeline**:
1. **Code Commit** → GitHub
2. **Run Tests** → Unit tests, integration tests
3. **Build** → Docker images
4. **Push** → ECR (Elastic Container Registry)
5. **Deploy** → ECS Fargate (Blue-Green deployment)
6. **Smoke Tests** → Post-deployment validation
7. **Notify** → Slack/Discord notification

**Environments**:
- **Development**: Auto-deploy on push to `develop`
- **Staging**: Auto-deploy on push to `staging`
- **Production**: Manual approval after staging tests

---

## 🔧 Scalability Strategy

### Horizontal Scaling

**Application Servers**:
- Auto-scaling based on CPU and memory
- Minimum 2 instances, maximum 50+ instances
- Target utilization: 70% CPU

**Database**:
- PostgreSQL: Read replicas for read-heavy operations
- MongoDB: Sharding for large collections
- Redis: Clustered for high availability

**Search**:
- Elasticsearch: Multi-node cluster

### Performance Optimization

**Caching Strategy**:
- **Level 1**: Browser cache (static assets)
- **Level 2**: CDN cache (images, videos)
- **Level 3**: Redis cache (API responses, user sessions)
- **Level 4**: Application cache (in-memory)

**Database Optimization**:
- Indexing on frequently queried fields
- Query optimization and EXPLAIN analysis
- Connection pooling
- Read-write splitting

**Content Delivery**:
- Cloudflare CDN for global distribution
- Image optimization and lazy loading
- Video transcoding and adaptive bitrate streaming

---

## 🧪 Testing Strategy

**Unit Tests**: Jest (80%+ coverage)
**Integration Tests**: Supertest (API endpoints)
**End-to-End Tests**: Playwright (critical user flows)
**Performance Tests**: k6 or Artillery (load testing)
**Security Tests**: OWASP ZAP (vulnerability scanning)

---

**Next Steps**:
1. Set up development environment
2. Initialize repositories and CI/CD
3. Implement MVP features
4. Deploy to staging
5. Beta testing
