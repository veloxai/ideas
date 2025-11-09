# Uniting Doctors - Infrastructure Architecture

**Version**: 1.0
**Last Updated**: November 8, 2025
**Status**: Planning Phase

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [System Architecture](#system-architecture)
3. [Technology Stack](#technology-stack)
4. [Cloud Infrastructure](#cloud-infrastructure)
5. [Database Architecture](#database-architecture)
6. [Caching Strategy](#caching-strategy)
7. [CDN & Asset Delivery](#cdn--asset-delivery)
8. [Search Infrastructure](#search-infrastructure)
9. [Monitoring & Observability](#monitoring--observability)
10. [CI/CD Pipeline](#cicd-pipeline)
11. [Security Infrastructure](#security-infrastructure)
12. [Disaster Recovery](#disaster-recovery)
13. [Scaling Strategy](#scaling-strategy)
14. [Cost Optimization](#cost-optimization)

---

## 🎯 Overview

Uniting Doctors infrastructure is designed for:

- **High Availability**: 99.95% uptime SLA
- **Scalability**: Handle 100K+ concurrent users
- **Security**: HIPAA-compliant, encrypted data
- **Performance**: <200ms API response time (p95)
- **Global Reach**: Low latency worldwide

### Design Principles

1. **Cloud-Native**: Leverage managed services
2. **Infrastructure as Code**: Terraform for all resources
3. **Immutable Infrastructure**: No manual server changes
4. **Defense in Depth**: Multiple security layers
5. **Observability First**: Comprehensive monitoring
6. **Cost-Conscious**: Optimize for value

---

## 🏗️ System Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                          INTERNET                               │
└────────────────────┬────────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────────┐
│                  CLOUDFLARE CDN                                 │
│  • DDoS Protection                                              │
│  • WAF (Web Application Firewall)                               │
│  • SSL Termination                                              │
│  • Global Edge Network                                          │
└────────────────────┬────────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────────┐
│              AWS APPLICATION LOAD BALANCER                      │
│  • Health Checks                                                │
│  • SSL/TLS (ACM Certificates)                                   │
│  • Path-based Routing                                           │
└─────┬───────────────────────────┬────────────────────────────────┘
      │                           │
      │ /api/*                    │ /*
      │                           │
┌─────▼───────────────┐    ┌──────▼──────────────────────────────┐
│   API SERVERS       │    │      WEB SERVERS (Next.js)          │
│   (Node.js/Express) │    │   • Server-Side Rendering           │
│   • ECS Fargate     │    │   • Edge Rendering (Vercel?)        │
│   • Auto-scaling    │    │   • ECS Fargate                     │
└──┬──────────────────┘    └─────────────────────────────────────┘
   │
   ├─────────────┬──────────────┬──────────────┬─────────────┐
   │             │              │              │             │
┌──▼────┐  ┌────▼────┐  ┌──────▼──────┐  ┌───▼──────┐  ┌──▼─────┐
│ POSTGRES│  │ MONGODB │  │   REDIS     │  │ ELASTIC  │  │   S3   │
│ (RDS)   │  │ (Atlas) │  │  (ElastiC)  │  │  SEARCH  │  │ (CDN)  │
│ • Users │  │ • Posts │  │  • Cache    │  │  • Index │  │ • Files│
│ • Auth  │  │ • Feed  │  │  • Sessions │  │  • Search│  │ • Images│
└─────────┘  └─────────┘  └─────────────┘  └──────────┘  └────────┘
```

### Service Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        API GATEWAY                              │
│  • Authentication                                               │
│  • Rate Limiting                                                │
│  • Request Routing                                              │
└────────────────────┬────────────────────────────────────────────┘
                     │
        ┌────────────┼────────────┬────────────┬────────────┐
        │            │            │            │            │
┌───────▼────┐  ┌────▼────┐  ┌───▼───────┐  ┌─▼─────────┐  │
│   USER     │  │  POST   │  │  SEARCH   │  │ RESEARCH  │  │
│  SERVICE   │  │ SERVICE │  │  SERVICE  │  │  SERVICE  │  │
└────────────┘  └──────┬──┘  └───────────┘  └───────────┘  │
                       │                                    │
                  ┌────▼─────────┐                         │
                  │  REPUTATION  │                         │
                  │   SERVICE    │                         │
                  └──────────────┘                         │
                                                           │
┌──────────────────────────────────────────────────────────▼──────┐
│                    MESSAGE QUEUE (SQS)                          │
│  • Background Jobs                                              │
│  • Email Notifications                                          │
│  • Content Moderation                                           │
│  • Research Aggregation                                         │
└─────────────────────────────────────────────────────────────────┘
```

---

## 💻 Technology Stack

### Frontend

| Layer                 | Technology               | Purpose                     |
| --------------------- | ------------------------ | --------------------------- |
| **Framework**         | Next.js 14+ (App Router) | React framework with SSR    |
| **UI Library**        | React 18+                | Component library           |
| **Styling**           | Tailwind CSS             | Utility-first CSS           |
| **Component Library** | shadcn/ui                | Pre-built components        |
| **State Management**  | Zustand + React Query    | Client state + server cache |
| **Forms**             | React Hook Form          | Form validation             |
| **Rich Text Editor**  | Tiptap                   | WYSIWYG editor              |
| **Build Tool**        | Turbopack                | Fast bundler                |

### Backend

| Layer                 | Technology              | Purpose                   |
| --------------------- | ----------------------- | ------------------------- |
| **Runtime**           | Node.js 20 LTS          | JavaScript runtime        |
| **Framework**         | Express.js (or Fastify) | HTTP server               |
| **Language**          | TypeScript 5+           | Type-safe JavaScript      |
| **API Documentation** | OpenAPI 3.0             | API specs                 |
| **Authentication**    | @veloxai/auth-client    | Velox.ai auth integration |
| **Validation**        | Zod                     | Schema validation         |
| **ORM**               | Prisma                  | Database ORM              |

### Databases

| Type           | Technology             | Purpose                       |
| -------------- | ---------------------- | ----------------------------- |
| **Relational** | PostgreSQL 15+         | Users, auth, relationships    |
| **Document**   | MongoDB 7+             | Posts, comments, feeds        |
| **Cache**      | Redis 7+               | Session, cache, rate limiting |
| **Search**     | Elasticsearch 8+       | Full-text search              |
| **Vector**     | Pinecone (or Weaviate) | Semantic search               |

### Infrastructure

| Layer                       | Technology             | Purpose                 |
| --------------------------- | ---------------------- | ----------------------- |
| **Cloud Provider**          | AWS (primary)          | Infrastructure          |
| **Container Orchestration** | ECS Fargate            | Serverless containers   |
| **CDN**                     | Cloudflare             | Global content delivery |
| **DNS**                     | Cloudflare             | DNS management          |
| **CI/CD**                   | GitHub Actions         | Automated deployment    |
| **IaC**                     | Terraform              | Infrastructure as code  |
| **Monitoring**              | DataDog (or New Relic) | APM, logging, metrics   |

---

## ☁️ Cloud Infrastructure

### AWS Architecture

#### Region Strategy

**Primary Region**: `us-east-1` (N. Virginia)

- Lowest latency for US users
- Most AWS services available
- Cost-effective

**Secondary Region**: `eu-west-1` (Ireland)

- European users
- GDPR compliance (EU data residency)
- Disaster recovery failover

#### VPC Architecture

```
VPC: 10.0.0.0/16

┌─────────────────────────────────────────────────────────────┐
│  PUBLIC SUBNETS (10.0.1.0/24, 10.0.2.0/24)                 │
│  • Application Load Balancer                                │
│  • NAT Gateway                                              │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  PRIVATE SUBNETS (10.0.10.0/24, 10.0.11.0/24)              │
│  • ECS Tasks (API servers)                                  │
│  • Lambda Functions                                         │
│  • ElastiCache (Redis)                                      │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  DATABASE SUBNETS (10.0.20.0/24, 10.0.21.0/24)             │
│  • RDS PostgreSQL (Multi-AZ)                                │
│  • DocumentDB (MongoDB-compatible)                          │
└─────────────────────────────────────────────────────────────┘
```

#### Compute Resources

**ECS Fargate Clusters**:

```hcl
# api-cluster
resource "aws_ecs_cluster" "api" {
  name = "uniting-doctors-api"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# API Service
resource "aws_ecs_service" "api" {
  name            = "api-service"
  cluster         = aws_ecs_cluster.api.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 3  # Minimum for HA
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.api.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "api"
    container_port   = 3000
  }

  # Auto-scaling
  autoscaling_target {
    max_capacity       = 20
    min_capacity       = 3
    target_cpu_percent = 70
  }
}
```

**Task Definitions**:

```json
{
  "family": "api-task",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "512",
  "memory": "1024",
  "containerDefinitions": [
    {
      "name": "api",
      "image": "123456789.dkr.ecr.us-east-1.amazonaws.com/uniting-doctors-api:latest",
      "portMappings": [
        {
          "containerPort": 3000,
          "protocol": "tcp"
        }
      ],
      "environment": [
        { "name": "NODE_ENV", "value": "production" },
        { "name": "PORT", "value": "3000" }
      ],
      "secrets": [
        {
          "name": "DATABASE_URL",
          "valueFrom": "arn:aws:secretsmanager:us-east-1:123456789:secret:db-url"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/api",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "api"
        }
      }
    }
  ]
}
```

---

## 🗄️ Database Architecture

### PostgreSQL (Amazon RDS)

**Configuration**:

```hcl
resource "aws_db_instance" "postgres" {
  identifier     = "uniting-doctors-db"
  engine         = "postgres"
  engine_version = "15.3"
  instance_class = "db.r6g.xlarge"  # 4 vCPU, 32 GB RAM

  allocated_storage     = 100  # GB
  max_allocated_storage = 1000 # Auto-scaling
  storage_type          = "gp3"
  storage_encrypted     = true

  # High Availability
  multi_az               = true
  backup_retention_period = 30
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"

  # Performance
  performance_insights_enabled = true
  monitoring_interval          = 60

  # Security
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  # Snapshots
  skip_final_snapshot       = false
  final_snapshot_identifier = "uniting-doctors-final-snapshot"

  tags = {
    Name        = "UnitingDoctors-PostgreSQL"
    Environment = "production"
  }
}
```

**Schema Design**:

```sql
-- Core tables (simplified)

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  email_verified BOOLEAN DEFAULT FALSE,
  password_hash VARCHAR(255),
  display_name VARCHAR(100),
  verification_status VARCHAR(20) DEFAULT 'pending',
  reputation INT DEFAULT 0,
  is_banned BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_reputation ON users(reputation DESC);
CREATE INDEX idx_users_created_at ON users(created_at DESC);

CREATE TABLE specialties (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  description TEXT
);

CREATE TABLE user_specialties (
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  specialty_id INT REFERENCES specialties(id),
  PRIMARY KEY (user_id, specialty_id)
);

CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  access_token VARCHAR(500) NOT NULL,
  refresh_token VARCHAR(500),
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_access_token ON sessions(access_token);

-- Relationships stored in PostgreSQL
CREATE TABLE follows (
  follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
  following_id UUID REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (follower_id, following_id)
);

CREATE TABLE group_members (
  group_id UUID,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  role VARCHAR(20) DEFAULT 'member',
  joined_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (group_id, user_id)
);
```

**Read Replicas**:

- 2 read replicas for query load distribution
- Route read queries to replicas
- Master handles writes only

### MongoDB (Atlas or DocumentDB)

**Configuration**:

```javascript
// MongoDB connection
const mongoConfig = {
  uri: process.env.MONGODB_URI,
  options: {
    retryWrites: true,
    w: 'majority',
    readPreference: 'secondaryPreferred',
    maxPoolSize: 50,
    minPoolSize: 10,
    serverSelectionTimeoutMS: 5000,
    socketTimeoutMS: 45000
  }
};
```

**Collections**:

```javascript
// posts collection
{
  _id: ObjectId("..."),
  post_id: "post_abc123",  // UUID for cross-DB reference
  author_id: "user_xyz789",
  content: "Discussing novel AFib management...",
  content_html: "<p>Discussing novel AFib management...</p>",
  is_anonymous: false,
  is_question: false,
  evidence_level: "4",
  tags: [
    { id: 1, name: "Cardiology" },
    { id: 45, name: "Arrhythmia" }
  ],
  images: [
    {
      url: "https://cdn.unitingdoctors.com/images/abc123.jpg",
      alt_text: "EKG showing AFib",
      width: 1200,
      height: 800
    }
  ],
  references: [
    {
      type: "pubmed",
      pmid: "12345678",
      citation: "Smith J, et al. JAMA. 2023;329(5):456-463."
    }
  ],
  statistics: {
    upvotes: 234,
    downvotes: 5,
    comment_count: 67,
    view_count: 2340,
    bookmark_count: 89
  },
  created_at: ISODate("2025-11-08T08:30:00Z"),
  updated_at: ISODate("2025-11-08T08:30:00Z"),
  deleted_at: null
}

// Indexes
db.posts.createIndex({ "author_id": 1, "created_at": -1 });
db.posts.createIndex({ "tags.id": 1, "created_at": -1 });
db.posts.createIndex({ "evidence_level": 1, "statistics.upvotes": -1 });
db.posts.createIndex({ "created_at": -1 });
db.posts.createIndex({ "is_question": 1, "is_answered": 1 });

// comments collection
{
  _id: ObjectId("..."),
  comment_id: "comment_xyz789",
  post_id: "post_abc123",
  parent_id: null,  // null for top-level, or comment_id for reply
  author_id: "user_123",
  content: "Great point! One caution...",
  content_html: "<p>Great point! One caution...</p>",
  is_accepted: false,
  statistics: {
    upvotes: 89,
    downvotes: 2
  },
  created_at: ISODate("2025-11-08T09:00:00Z"),
  updated_at: ISODate("2025-11-08T09:00:00Z")
}

// Indexes
db.comments.createIndex({ "post_id": 1, "created_at": -1 });
db.comments.createIndex({ "parent_id": 1, "created_at": -1 });
db.comments.createIndex({ "author_id": 1, "created_at": -1 });
```

**Sharding Strategy** (Future):

- Shard key: `author_id` (distributes load by user)
- 3 shards initially, expand as needed

---

## 🚀 Caching Strategy

### Redis (ElastiCache)

**Configuration**:

```hcl
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "uniting-doctors-redis"
  replication_group_description = "Redis cache for Uniting Doctors"

  engine               = "redis"
  engine_version       = "7.0"
  node_type            = "cache.r6g.large"  # 13.07 GB RAM
  number_cache_clusters = 3  # 1 primary + 2 replicas

  port                       = 6379
  parameter_group_name       = "default.redis7"
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  security_group_ids         = [aws_security_group.redis.id]

  automatic_failover_enabled = true
  multi_az_enabled          = true
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  maintenance_window         = "sun:05:00-sun:06:00"
  snapshot_retention_limit   = 5
  snapshot_window            = "03:00-04:00"

  tags = {
    Name = "UnitingDoctors-Redis"
  }
}
```

**Caching Layers**:

```typescript
// Cache keys
enum CacheKey {
  USER_PROFILE = 'user:profile:{userId}',
  USER_REPUTATION = 'user:reputation:{userId}',
  POST = 'post:{postId}',
  POST_COMMENTS = 'post:{postId}:comments',
  FEED = 'feed:{userId}:{page}',
  TRENDING_POSTS = 'trending:posts:{specialty}',
  SEARCH_RESULTS = 'search:{queryHash}',
  RATE_LIMIT = 'rate_limit:{userId}:{endpoint}',
  SESSION = 'session:{sessionId}'
}

// TTL (Time To Live)
const CacheTTL = {
  USER_PROFILE: 3600, // 1 hour
  USER_REPUTATION: 300, // 5 minutes
  POST: 1800, // 30 minutes
  POST_COMMENTS: 600, // 10 minutes
  FEED: 300, // 5 minutes
  TRENDING_POSTS: 600, // 10 minutes
  SEARCH_RESULTS: 1800, // 30 minutes
  RATE_LIMIT: 60, // 1 minute
  SESSION: 86400 // 24 hours
};

// Cache implementation
class CacheService {
  private redis: Redis;

  async get<T>(key: string): Promise<T | null> {
    const value = await this.redis.get(key);
    return value ? JSON.parse(value) : null;
  }

  async set(key: string, value: any, ttl: number): Promise<void> {
    await this.redis.setex(key, ttl, JSON.stringify(value));
  }

  async invalidate(pattern: string): Promise<void> {
    const keys = await this.redis.keys(pattern);
    if (keys.length > 0) {
      await this.redis.del(...keys);
    }
  }
}
```

**Cache Warming**:

- Pre-populate trending posts on startup
- Warm user profiles for active users
- Background job refreshes hot keys

---

## 🌐 CDN & Asset Delivery

### Cloudflare Configuration

**DNS Settings**:

```
unitingdoctors.com        A       PROXIED    1.2.3.4
www.unitingdoctors.com    CNAME   PROXIED    unitingdoctors.com
api.unitingdoctors.com    CNAME   PROXIED    alb.amazonaws.com
cdn.unitingdoctors.com    CNAME   PROXIED    s3.amazonaws.com
```

**Page Rules**:

```
1. *.unitingdoctors.com/api/*
   - Cache Level: Bypass
   - Security Level: High

2. *.unitingdoctors.com/assets/*
   - Cache Level: Cache Everything
   - Edge Cache TTL: 1 month
   - Browser Cache TTL: 1 month

3. *.unitingdoctors.com/images/*
   - Cache Level: Cache Everything
   - Edge Cache TTL: 1 week
   - Polish: Lossless
   - Mirage: On
```

### Amazon S3 + CloudFront

**S3 Buckets**:

```hcl
# Static assets bucket
resource "aws_s3_bucket" "assets" {
  bucket = "uniting-doctors-assets"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 90
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }
  }
}

# User uploads bucket
resource "aws_s3_bucket" "uploads" {
  bucket = "uniting-doctors-uploads"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://unitingdoctors.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
```

**Image Optimization**:

```javascript
// Automatic image optimization on upload
const sharp = require('sharp');

async function optimizeImage(buffer, options) {
  return sharp(buffer)
    .resize(options.width, options.height, {
      fit: 'inside',
      withoutEnlargement: true
    })
    .webp({ quality: 85 })
    .toBuffer();
}

// Generate multiple sizes
const sizes = [
  { name: 'thumbnail', width: 150, height: 150 },
  { name: 'small', width: 400, height: 400 },
  { name: 'medium', width: 800, height: 800 },
  { name: 'large', width: 1600, height: 1600 }
];
```

---

## 🔍 Search Infrastructure

### Elasticsearch

**Cluster Configuration**:

```hcl
resource "aws_elasticsearch_domain" "main" {
  domain_name           = "uniting-doctors-search"
  elasticsearch_version = "8.7"

  cluster_config {
    instance_type            = "r6g.large.elasticsearch"
    instance_count           = 3  # Minimum for HA
    dedicated_master_enabled = true
    dedicated_master_type    = "r6g.large.elasticsearch"
    dedicated_master_count   = 3
    zone_awareness_enabled   = true

    zone_awareness_config {
      availability_zone_count = 3
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 100  # GB per node
    volume_type = "gp3"
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.elasticsearch.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  tags = {
    Name = "UnitingDoctors-Elasticsearch"
  }
}
```

**Index Mapping**:

```json
{
  "settings": {
    "number_of_shards": 3,
    "number_of_replicas": 2,
    "analysis": {
      "analyzer": {
        "medical_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": ["lowercase", "medical_synonym", "snowball"]
        }
      },
      "filter": {
        "medical_synonym": {
          "type": "synonym",
          "synonyms_path": "analysis/medical_synonyms.txt"
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "content": {
        "type": "text",
        "analyzer": "medical_analyzer",
        "fields": {
          "keyword": {
            "type": "keyword"
          }
        }
      },
      "title": {
        "type": "text",
        "analyzer": "medical_analyzer",
        "boost": 2.0
      },
      "author_reputation": {
        "type": "integer"
      },
      "evidence_level": {
        "type": "keyword"
      },
      "specialty": {
        "type": "keyword"
      },
      "created_at": {
        "type": "date"
      },
      "upvotes": {
        "type": "integer"
      },
      "view_count": {
        "type": "integer"
      }
    }
  }
}
```

### Vector Search (Pinecone)

**For Semantic Search**:

```python
import pinecone

pinecone.init(
    api_key=os.environ['PINECONE_API_KEY'],
    environment='us-west1-gcp'
)

# Create index
index = pinecone.Index("medical-posts")

# Index configuration
{
    "dimension": 768,  # BioBERT embedding size
    "metric": "cosine",
    "pods": 1,
    "replicas": 2,
    "pod_type": "p1.x1"
}

# Insert vectors
index.upsert([
    ("post_abc123", embedding_vector, {"content": "...", "specialty": "cardiology"}),
    # ... more vectors
])

# Query
results = index.query(
    query_vector,
    top_k=10,
    include_metadata=True
)
```

---

## 📊 Monitoring & Observability

### DataDog Configuration

**APM (Application Performance Monitoring)**:

```javascript
// tracer.js
const tracer = require('dd-trace').init({
  service: 'uniting-doctors-api',
  env: process.env.NODE_ENV,
  version: process.env.APP_VERSION,
  logInjection: true,
  analytics: true,
  runtimeMetrics: true
});

// Custom metrics
const { StatsD } = require('hot-shots');
const statsd = new StatsD({
  host: 'datadog-agent',
  port: 8125,
  prefix: 'unitingdoctors.'
});

// Track custom metrics
statsd.increment('posts.created');
statsd.histogram('api.response_time', responseTime);
statsd.gauge('active_users', activeUserCount);
```

**Key Metrics**:

```yaml
# Application Metrics
- api.response_time (p50, p95, p99)
- api.requests_per_second
- api.error_rate
- database.query_time
- cache.hit_rate
- active_users.count

# Business Metrics
- posts.created.count
- comments.created.count
- user.registrations.count
- user.verifications.approved
- moderation.flags.count

# Infrastructure Metrics
- ecs.cpu_utilization
- ecs.memory_utilization
- rds.connections
- rds.cpu_utilization
- elasticsearch.cluster_health
- redis.memory_usage
```

**Alerts**:

```yaml
alerts:
  - name: High API Error Rate
    condition: error_rate > 5%
    window: 5 minutes
    notify: pagerduty, slack

  - name: Slow API Response
    condition: p95_response_time > 500ms
    window: 10 minutes
    notify: slack

  - name: Database Connection Pool Exhausted
    condition: rds.connections > 90% max
    window: 5 minutes
    notify: pagerduty, slack

  - name: Redis Memory High
    condition: redis.memory_usage > 80%
    window: 10 minutes
    notify: slack
```

### Logging Strategy

**Structured Logging**:

```typescript
// logger.ts
import winston from 'winston';

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: {
    service: 'uniting-doctors-api',
    environment: process.env.NODE_ENV
  },
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

// Usage
logger.info('User created', {
  userId: user.id,
  email: user.email,
  specialty: user.specialty
});

logger.error('Database connection failed', {
  error: error.message,
  stack: error.stack,
  connectionString: dbConfig.host
});
```

---

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main, staging]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'pnpm'

      - name: Install dependencies
        run: pnpm install

      - name: Run linter
        run: pnpm lint

      - name: Run unit tests
        run: pnpm test:unit

      - name: Run integration tests
        run: pnpm test:integration
        env:
          DATABASE_URL: ${{ secrets.TEST_DATABASE_URL }}
          REDIS_URL: ${{ secrets.TEST_REDIS_URL }}

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Login to Amazon ECR
        id: login-ecr
        uses: aws-actions/amazon-ecr-login@v1

      - name: Build and push Docker image
        env:
          ECR_REGISTRY: ${{ steps.login-ecr.outputs.registry }}
          ECR_REPOSITORY: uniting-doctors-api
          IMAGE_TAG: ${{ github.sha }}
        run: |
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
          docker tag $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG \
                     $ECR_REGISTRY/$ECR_REPOSITORY:latest
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:latest

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to ECS
        run: |
          aws ecs update-service \
            --cluster uniting-doctors-api \
            --service api-service \
            --force-new-deployment \
            --region us-east-1

      - name: Wait for deployment
        run: |
          aws ecs wait services-stable \
            --cluster uniting-doctors-api \
            --services api-service \
            --region us-east-1

      - name: Notify Slack
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Deployment to production completed'
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

---

## 🔒 Security Infrastructure

### WAF (Web Application Firewall)

**Cloudflare WAF Rules**:

```
1. Block known malicious IPs
2. Rate limiting (1000 requests/hour per IP)
3. SQL injection protection
4. XSS protection
5. CSRF protection
6. Block traffic from high-risk countries (optional)
```

### Secrets Management

**AWS Secrets Manager**:

```hcl
resource "aws_secretsmanager_secret" "database" {
  name = "uniting-doctors/database"

  rotation_rules {
    automatically_after_days = 30
  }
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id     = aws_secretsmanager_secret.database.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.db_password.result
    host     = aws_db_instance.postgres.endpoint
    database = "uniting_doctors"
  })
}
```

### Network Security

**Security Groups**:

```hcl
# ALB Security Group
resource "aws_security_group" "alb" {
  name   = "uniting-doctors-alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# API Security Group
resource "aws_security_group" "api" {
  name   = "uniting-doctors-api-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name   = "uniting-doctors-rds-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.api.id]
  }
}
```

---

## 🔄 Disaster Recovery

### Backup Strategy

**Database Backups**:

- **Automated Daily Snapshots**: 30-day retention
- **Manual Snapshots**: Before major deployments
- **Point-in-Time Recovery**: Up to 35 days
- **Cross-Region Replication**: DR region (eu-west-1)

**Application Data**:

- **S3 Versioning**: Enabled on all buckets
- **S3 Cross-Region Replication**: To DR region
- **MongoDB Atlas**: Continuous backup

**Recovery Time Objectives**:

- **RTO (Recovery Time Objective)**: 4 hours
- **RPO (Recovery Point Objective)**: 1 hour

### Disaster Recovery Plan

**Scenario 1: Region Failure**

1. Route traffic to DR region (eu-west-1) via DNS failover
2. Promote read replica to master in DR region
3. Scale up ECS services in DR region
4. Verify application functionality
5. Notify users of potential data loss (last hour)

**Scenario 2: Database Corruption**

1. Identify last good backup
2. Restore from snapshot
3. Apply transaction logs (point-in-time recovery)
4. Verify data integrity
5. Resume normal operations

---

## 📈 Scaling Strategy

### Horizontal Scaling

**Auto-Scaling Configuration**:

```hcl
resource "aws_appautoscaling_target" "api" {
  max_capacity       = 20
  min_capacity       = 3
  resource_id        = "service/uniting-doctors-api/api-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# CPU-based scaling
resource "aws_appautoscaling_policy" "cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.api.resource_id
  scalable_dimension = aws_appautoscaling_target.api.scalable_dimension
  service_namespace  = aws_appautoscaling_target.api.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70.0
  }
}
```

### Database Scaling

**Vertical Scaling**:

- Monitor RDS metrics
- Schedule scaling during low-traffic windows
- Use Blue/Green deployments for minimal downtime

**Read Scaling**:

- Add read replicas as needed
- Route read queries to replicas
- Use ProxySQL for connection pooling

**Future: Sharding**:

- Shard MongoDB by user_id
- Shard PostgreSQL by tenant (for institutional accounts)

---

## 💰 Cost Optimization

### Monthly Cost Estimate (Production)

| Service               | Configuration                     | Monthly Cost      |
| --------------------- | --------------------------------- | ----------------- |
| **ECS Fargate**       | 3 tasks (0.5 vCPU, 1GB RAM)       | $75               |
| **RDS PostgreSQL**    | db.r6g.xlarge (Multi-AZ)          | $600              |
| **MongoDB Atlas**     | M30 (8GB RAM, 3 replicas)         | $500              |
| **ElastiCache Redis** | cache.r6g.large (3 nodes)         | $450              |
| **Elasticsearch**     | 3 x r6g.large.elasticsearch       | $750              |
| **S3**                | 500GB storage + transfer          | $50               |
| **CloudFront**        | 1TB data transfer                 | $85               |
| **ALB**               | Load balancer + LCU charges       | $30               |
| **DataDog**           | Pro plan (10 hosts)               | $150              |
| **Cloudflare**        | Pro plan                          | $20               |
| **Pinecone**          | Standard plan                     | $70               |
| **Other**             | Secrets Manager, CloudWatch, etc. | $50               |
| **Total**             |                                   | **~$2,830/month** |

### Cost Optimization Strategies

1. **Reserved Instances**: 30-50% savings on RDS, ElastiCache
2. **Spot Instances**: For non-critical background jobs
3. **S3 Lifecycle Policies**: Move old data to Glacier
4. **Right-Sizing**: Monitor and adjust instance sizes
5. **CDN Caching**: Reduce origin requests
6. **Query Optimization**: Reduce database load

---

## 📞 Support & Documentation

**Infrastructure Documentation**: [https://docs.unitingdoctors.com/infrastructure](https://docs.unitingdoctors.com/infrastructure)
**Runbook**: [https://runbook.unitingdoctors.com](https://runbook.unitingdoctors.com)
**Status Page**: [https://status.unitingdoctors.com](https://status.unitingdoctors.com)

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Related Documents**:

- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [SECURITY_ARCHITECTURE.md](./SECURITY_ARCHITECTURE.md)
- [IMPLEMENTATION_ROADMAP.md](./IMPLEMENTATION_ROADMAP.md)
- [API_SPECIFICATION.md](./API_SPECIFICATION.md)
