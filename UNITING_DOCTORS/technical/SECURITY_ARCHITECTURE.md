# Uniting Doctors - Security Architecture

**Version**: 1.0
**Last Updated**: November 8, 2025
**Status**: Planning Phase

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Security Principles](#security-principles)
3. [Threat Model](#threat-model)
4. [Authentication & Authorization](#authentication--authorization)
5. [Data Protection](#data-protection)
6. [Application Security](#application-security)
7. [Infrastructure Security](#infrastructure-security)
8. [PHI & HIPAA Compliance](#phi--hipaa-compliance)
9. [Incident Response](#incident-response)
10. [Security Testing](#security-testing)
11. [Compliance & Auditing](#compliance--auditing)
12. [Security Roadmap](#security-roadmap)

---

## 🎯 Overview

Uniting Doctors handles sensitive medical discussions and must maintain the highest security standards to protect user data, maintain trust, and comply with healthcare regulations.

### Security Goals

1. **Confidentiality**: Protect user data and medical information
2. **Integrity**: Prevent unauthorized data modification
3. **Availability**: Maintain 99.95% uptime with DDoS protection
4. **Compliance**: Meet HIPAA, GDPR, and SOC 2 requirements
5. **Trust**: Transparent security practices and incident response

### Regulatory Requirements

| Regulation | Applicability        | Key Requirements                                 |
| ---------- | -------------------- | ------------------------------------------------ |
| **HIPAA**  | US healthcare data   | Encryption, access controls, audit logs, BAAs    |
| **GDPR**   | EU user data         | Consent, right to erasure, data portability      |
| **CCPA**   | California users     | Data disclosure, opt-out, deletion rights        |
| **SOC 2**  | Enterprise customers | Security, availability, confidentiality controls |

---

## 🛡️ Security Principles

### Defense in Depth

Multiple security layers to protect against various attack vectors:

```
┌──────────────────────────────────────────────────────┐
│  Layer 1: Perimeter (Cloudflare WAF, DDoS)          │
│  Layer 2: Network (VPC, Security Groups, NACLs)     │
│  Layer 3: Application (Input validation, CSRF)      │
│  Layer 4: Authentication (OAuth 2.0, MFA)           │
│  Layer 5: Authorization (RBAC, resource ownership)  │
│  Layer 6: Data (Encryption at rest and in transit)  │
│  Layer 7: Monitoring (SIEM, anomaly detection)      │
└──────────────────────────────────────────────────────┘
```

### Security by Design

- **Least Privilege**: Minimal permissions by default
- **Fail Securely**: Errors don't expose sensitive data
- **Zero Trust**: Verify every request, never assume trust
- **Privacy by Default**: Opt-in for data collection
- **Secure Defaults**: Strong security out-of-the-box

---

## ⚠️ Threat Model

### STRIDE Threat Analysis

#### 1. Spoofing Identity

**Threats**:

- Credential theft (phishing, keyloggers)
- Session hijacking
- Account takeover via weak passwords

**Mitigations**:

- OAuth 2.0 + JWT with short expiration
- Multi-factor authentication (MFA)
- Rate limiting on login attempts
- Email verification for new devices
- CAPTCHA on suspicious activity

#### 2. Tampering with Data

**Threats**:

- SQL injection
- NoSQL injection
- API parameter manipulation
- Man-in-the-middle attacks

**Mitigations**:

- Parameterized queries (Prisma ORM)
- Input validation with Zod schemas
- TLS 1.3 encryption for all traffic
- Content Security Policy (CSP) headers
- Database-level integrity constraints

#### 3. Repudiation

**Threats**:

- Users deny actions (post, comment, vote)
- Admins deny moderation decisions

**Mitigations**:

- Comprehensive audit logging
- Immutable log storage (S3 with versioning)
- Digital signatures for critical actions
- Timestamp all database records

#### 4. Information Disclosure

**Threats**:

- PHI exposure in posts/comments
- Database dumps leaked
- Verbose error messages reveal system info
- Side-channel attacks (timing, cache)

**Mitigations**:

- Automated PHI detection before posting
- Encryption at rest (database, S3)
- Generic error messages to users
- Detailed errors only in logs
- Security headers (X-Content-Type-Options, etc.)

#### 5. Denial of Service

**Threats**:

- DDoS attacks
- Resource exhaustion (API abuse)
- Database connection pool exhaustion

**Mitigations**:

- Cloudflare DDoS protection
- Rate limiting (per user, per IP)
- Query timeout limits
- Connection pooling with max limits
- Auto-scaling infrastructure

#### 6. Elevation of Privilege

**Threats**:

- Horizontal privilege escalation (access other user's data)
- Vertical privilege escalation (user → admin)
- Insecure direct object references (IDOR)

**Mitigations**:

- Role-based access control (RBAC)
- Resource ownership checks on every request
- Admin actions require additional verification
- Audit all permission changes

### Attack Surface Analysis

| Attack Vector        | Risk Level | Mitigations                                        |
| -------------------- | ---------- | -------------------------------------------------- |
| **Public API**       | High       | Rate limiting, input validation, authentication    |
| **Web Application**  | High       | CSP, XSS protection, CSRF tokens                   |
| **User Uploads**     | Medium     | File type validation, malware scanning, sandboxing |
| **Third-party APIs** | Medium     | API key rotation, request signing, timeout limits  |
| **Database**         | High       | Encryption, access controls, audit logging         |
| **Admin Panel**      | Critical   | IP whitelisting, MFA required, session timeout     |

---

## 🔐 Authentication & Authorization

### Authentication Flow

```typescript
// OAuth 2.0 + JWT Authentication
import { AuthClient } from '@veloxai/auth-client';

const authClient = new AuthClient({
  authServerUrl: 'https://auth.vlx.io',
  clientId: process.env.AUTH_CLIENT_ID,
  clientSecret: process.env.AUTH_CLIENT_SECRET,
  redirectUri: 'https://unitingdoctors.com/auth/callback'
});

// Login
app.post('/auth/login', async (req, res) => {
  const { email, password } = req.body;

  // Validate input
  const schema = z.object({
    email: z.string().email(),
    password: z.string().min(8)
  });

  const validated = schema.parse({ email, password });

  // Rate limiting check
  const attempts = await redis.incr(`login_attempts:${req.ip}`);
  await redis.expire(`login_attempts:${req.ip}`, 300); // 5 minutes

  if (attempts > 5) {
    return res.status(429).json({
      error: 'TOO_MANY_ATTEMPTS',
      message: 'Too many login attempts. Try again in 5 minutes.'
    });
  }

  // Authenticate
  try {
    const tokens = await authClient.authenticate({
      email: validated.email,
      password: validated.password
    });

    // Create session
    const session = await createSession({
      userId: tokens.userId,
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiresAt: new Date(Date.now() + 3600000) // 1 hour
    });

    // Set secure cookie
    res.cookie('session_id', session.id, {
      httpOnly: true,
      secure: true,
      sameSite: 'strict',
      maxAge: 3600000
    });

    // Log successful login
    await auditLog.log({
      action: 'USER_LOGIN',
      userId: tokens.userId,
      ip: req.ip,
      userAgent: req.get('user-agent'),
      timestamp: new Date()
    });

    res.json({
      success: true,
      user: tokens.user
    });
  } catch (error) {
    // Log failed attempt
    await auditLog.log({
      action: 'FAILED_LOGIN',
      email: validated.email,
      ip: req.ip,
      reason: error.message,
      timestamp: new Date()
    });

    res.status(401).json({
      error: 'AUTHENTICATION_FAILED',
      message: 'Invalid email or password'
    });
  }
});

// Authentication middleware
async function requireAuth(req, res, next) {
  const sessionId = req.cookies.session_id;

  if (!sessionId) {
    return res.status(401).json({
      error: 'AUTHENTICATION_REQUIRED',
      message: 'You must be logged in'
    });
  }

  // Check session
  const session = await getSession(sessionId);

  if (!session || session.expiresAt < new Date()) {
    return res.status(401).json({
      error: 'SESSION_EXPIRED',
      message: 'Your session has expired'
    });
  }

  // Verify access token
  try {
    const user = await authClient.verifyToken(session.accessToken);
    req.user = user;
    next();
  } catch (error) {
    // Try to refresh token
    try {
      const tokens = await authClient.refreshToken(session.refreshToken);
      await updateSession(sessionId, {
        accessToken: tokens.accessToken,
        expiresAt: new Date(Date.now() + 3600000)
      });
      req.user = tokens.user;
      next();
    } catch (refreshError) {
      return res.status(401).json({
        error: 'AUTHENTICATION_FAILED',
        message: 'Unable to verify your identity'
      });
    }
  }
}
```

### Multi-Factor Authentication (MFA)

```typescript
// MFA with TOTP (Time-based One-Time Password)
import speakeasy from 'speakeasy';
import QRCode from 'qrcode';

// Enable MFA
app.post('/users/me/mfa/enable', requireAuth, async (req, res) => {
  const user = req.user;

  // Generate secret
  const secret = speakeasy.generateSecret({
    name: `Uniting Doctors (${user.email})`,
    issuer: 'Uniting Doctors'
  });

  // Generate QR code
  const qrCodeUrl = await QRCode.toDataURL(secret.otpauth_url);

  // Save secret (encrypted)
  await updateUser(user.id, {
    mfa_secret: encrypt(secret.base32),
    mfa_enabled: false // Not enabled until verified
  });

  res.json({
    success: true,
    secret: secret.base32,
    qr_code: qrCodeUrl,
    backup_codes: generateBackupCodes() // For recovery
  });
});

// Verify MFA setup
app.post('/users/me/mfa/verify', requireAuth, async (req, res) => {
  const { code } = req.body;
  const user = await getUser(req.user.id);

  const verified = speakeasy.totp.verify({
    secret: decrypt(user.mfa_secret),
    encoding: 'base32',
    token: code,
    window: 2 // Allow 2 time steps (60 seconds)
  });

  if (verified) {
    await updateUser(user.id, {
      mfa_enabled: true,
      mfa_verified_at: new Date()
    });

    res.json({ success: true });
  } else {
    res.status(400).json({
      error: 'INVALID_CODE',
      message: 'Invalid verification code'
    });
  }
});

// Login with MFA
app.post('/auth/mfa/verify', async (req, res) => {
  const { session_id, code } = req.body;

  // Get pending session
  const session = await getPendingMFASession(session_id);
  if (!session) {
    return res.status(400).json({ error: 'INVALID_SESSION' });
  }

  const user = await getUser(session.userId);

  // Verify code
  const verified = speakeasy.totp.verify({
    secret: decrypt(user.mfa_secret),
    encoding: 'base32',
    token: code,
    window: 2
  });

  if (verified) {
    // Complete login
    await activateSession(session_id);
    res.json({ success: true });
  } else {
    res.status(400).json({
      error: 'INVALID_CODE',
      message: 'Invalid authentication code'
    });
  }
});
```

### Role-Based Access Control (RBAC)

```typescript
enum Role {
  USER = 'user',
  MODERATOR = 'moderator',
  ADMIN = 'admin',
  SUPER_ADMIN = 'super_admin'
}

enum Permission {
  // Posts
  CREATE_POST = 'post:create',
  EDIT_OWN_POST = 'post:edit:own',
  EDIT_ANY_POST = 'post:edit:any',
  DELETE_OWN_POST = 'post:delete:own',
  DELETE_ANY_POST = 'post:delete:any',

  // Comments
  CREATE_COMMENT = 'comment:create',
  EDIT_OWN_COMMENT = 'comment:edit:own',
  DELETE_ANY_COMMENT = 'comment:delete:any',

  // Moderation
  VIEW_MODERATION_QUEUE = 'moderation:view',
  MODERATE_CONTENT = 'moderation:moderate',
  BAN_USER = 'moderation:ban',

  // Admin
  MANAGE_USERS = 'admin:users',
  VIEW_AUDIT_LOGS = 'admin:audit',
  MANAGE_SETTINGS = 'admin:settings'
}

const rolePermissions: Record<Role, Permission[]> = {
  [Role.USER]: [
    Permission.CREATE_POST,
    Permission.EDIT_OWN_POST,
    Permission.DELETE_OWN_POST,
    Permission.CREATE_COMMENT,
    Permission.EDIT_OWN_COMMENT
  ],
  [Role.MODERATOR]: [
    // All user permissions
    ...rolePermissions[Role.USER],
    // Plus moderation permissions
    Permission.VIEW_MODERATION_QUEUE,
    Permission.MODERATE_CONTENT,
    Permission.DELETE_ANY_COMMENT,
    Permission.DELETE_ANY_POST
  ],
  [Role.ADMIN]: [
    // All moderator permissions
    ...rolePermissions[Role.MODERATOR],
    // Plus admin permissions
    Permission.BAN_USER,
    Permission.MANAGE_USERS,
    Permission.VIEW_AUDIT_LOGS
  ],
  [Role.SUPER_ADMIN]: [
    // All admin permissions
    ...rolePermissions[Role.ADMIN],
    // Plus super admin permissions
    Permission.MANAGE_SETTINGS
  ]
};

// Authorization middleware
function requirePermission(permission: Permission) {
  return async (req, res, next) => {
    const user = req.user;

    if (!user) {
      return res.status(401).json({
        error: 'AUTHENTICATION_REQUIRED'
      });
    }

    const userPermissions = rolePermissions[user.role] || [];

    if (!userPermissions.includes(permission)) {
      await auditLog.log({
        action: 'UNAUTHORIZED_ACCESS_ATTEMPT',
        userId: user.id,
        permission,
        endpoint: req.path,
        timestamp: new Date()
      });

      return res.status(403).json({
        error: 'INSUFFICIENT_PERMISSIONS',
        message: 'You do not have permission to perform this action'
      });
    }

    next();
  };
}

// Usage
app.delete(
  '/posts/:postId',
  requireAuth,
  requirePermission(Permission.DELETE_ANY_POST),
  async (req, res) => {
    // Delete post logic
  }
);
```

---

## 🔒 Data Protection

### Encryption at Rest

**Database Encryption**:

```hcl
# RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds.arn
}

# ElastiCache Redis
resource "aws_elasticache_replication_group" "redis" {
  at_rest_encryption_enabled = true
  kms_key_id                 = aws_kms_key.redis.arn
}

# S3 Buckets
resource "aws_s3_bucket" "uploads" {
  bucket = "uniting-doctors-uploads"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.s3.arn
      }
    }
  }
}
```

**Application-Level Encryption**:

```typescript
// Encrypt sensitive fields (e.g., MFA secrets)
import crypto from 'crypto';

const ENCRYPTION_KEY = process.env.ENCRYPTION_KEY; // 32 bytes
const ALGORITHM = 'aes-256-gcm';

function encrypt(text: string): string {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(ALGORITHM, ENCRYPTION_KEY, iv);

  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');

  const authTag = cipher.getAuthTag();

  // Format: iv:authTag:encrypted
  return `${iv.toString('hex')}:${authTag.toString('hex')}:${encrypted}`;
}

function decrypt(encryptedText: string): string {
  const [ivHex, authTagHex, encrypted] = encryptedText.split(':');

  const iv = Buffer.from(ivHex, 'hex');
  const authTag = Buffer.from(authTagHex, 'hex');

  const decipher = crypto.createDecipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
  decipher.setAuthTag(authTag);

  let decrypted = decipher.update(encrypted, 'hex', 'utf8');
  decrypted += decipher.final('utf8');

  return decrypted;
}
```

### Encryption in Transit

**TLS Configuration**:

```nginx
# Minimum TLS 1.2, prefer TLS 1.3
ssl_protocols TLSv1.2 TLSv1.3;

# Strong cipher suites
ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305';
ssl_prefer_server_ciphers on;

# HSTS (HTTP Strict Transport Security)
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
```

### Data Sanitization

**PII/PHI Detection**:

```typescript
// Detect and redact PHI before storing
import { RegexEntity } from 'redact-pii';

const phiPatterns = [
  // Medical Record Numbers
  /\b(MRN|Medical Record Number):?\s*[\d-]+\b/gi,

  // Social Security Numbers
  /\b\d{3}-\d{2}-\d{4}\b/g,

  // Phone Numbers
  /\b\d{3}[-.]?\d{3}[-.]?\d{4}\b/g,

  // Email addresses (when containing PHI)
  /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g,

  // Dates of Birth (in specific contexts)
  /\b(DOB|Date of Birth):?\s*\d{1,2}\/\d{1,2}\/\d{4}\b/gi,

  // Specific patient identifiers
  /\b(patient|pt)\s+[A-Z]{2}\s+[\d-]+\b/gi
];

async function detectPHI(content: string): Promise<{
  hasPHI: boolean;
  matches: string[];
  redactedContent: string;
}> {
  const matches: string[] = [];
  let redactedContent = content;

  for (const pattern of phiPatterns) {
    const found = content.match(pattern);
    if (found) {
      matches.push(...found);
      redactedContent = redactedContent.replace(pattern, '[REDACTED]');
    }
  }

  // Use ML model for additional detection
  const mlDetection = await aiService.detectPHI(content);

  if (mlDetection.hasPHI) {
    matches.push(...mlDetection.entities);
  }

  return {
    hasPHI: matches.length > 0 || mlDetection.hasPHI,
    matches,
    redactedContent: mlDetection.hasPHI ? mlDetection.redacted : redactedContent
  };
}

// Use in post creation
app.post('/posts', requireAuth, async (req, res) => {
  const { content } = req.body;

  // Check for PHI
  const phiCheck = await detectPHI(content);

  if (phiCheck.hasPHI) {
    await auditLog.log({
      action: 'PHI_DETECTED',
      userId: req.user.id,
      matches: phiCheck.matches,
      content: phiCheck.redactedContent,
      timestamp: new Date()
    });

    return res.status(400).json({
      error: 'PHI_DETECTED',
      message:
        'Your post appears to contain Protected Health Information (PHI). Please remove any patient identifiers before posting.',
      matches: phiCheck.matches.map((m) => m.replace(/./g, '*')) // Show redacted matches
    });
  }

  // Continue with post creation
  // ...
});
```

### Data Retention & Deletion

```typescript
// GDPR Right to Erasure
app.delete('/users/me', requireAuth, async (req, res) => {
  const userId = req.user.id;

  // Start deletion process
  await startUserDeletionJob({
    userId,
    requestedAt: new Date(),
    requestedBy: userId
  });

  res.json({
    success: true,
    message:
      'Your account deletion request has been received. All data will be permanently deleted within 30 days.'
  });
});

// Background job for user deletion
async function deleteUserData(userId: string) {
  // 1. Anonymize posts and comments (preserve content)
  await db.posts.updateMany({
    where: { author_id: userId },
    data: {
      author_id: 'deleted_user',
      is_anonymous: true
    }
  });

  await db.comments.updateMany({
    where: { author_id: userId },
    data: {
      author_id: 'deleted_user'
    }
  });

  // 2. Delete user profile
  await db.users.update({
    where: { id: userId },
    data: {
      email: `deleted_${userId}@deleted.local`,
      display_name: '[Deleted User]',
      bio: null,
      avatar_url: null,
      deleted_at: new Date()
    }
  });

  // 3. Delete sessions
  await db.sessions.deleteMany({
    where: { user_id: userId }
  });

  // 4. Delete uploaded files
  await deleteUserUploads(userId);

  // 5. Log deletion
  await auditLog.log({
    action: 'USER_DATA_DELETED',
    userId,
    timestamp: new Date()
  });
}
```

---

## 🛡️ Application Security

### Input Validation

```typescript
// Comprehensive input validation with Zod
import { z } from 'zod';

// User registration
const registerSchema = z.object({
  email: z.string().email('Invalid email address').max(255, 'Email too long'),

  password: z
    .string()
    .min(8, 'Password must be at least 8 characters')
    .max(128, 'Password too long')
    .regex(/[a-z]/, 'Password must contain a lowercase letter')
    .regex(/[A-Z]/, 'Password must contain an uppercase letter')
    .regex(/[0-9]/, 'Password must contain a number')
    .regex(/[^a-zA-Z0-9]/, 'Password must contain a special character'),

  display_name: z
    .string()
    .min(2, 'Display name too short')
    .max(50, 'Display name too long')
    .regex(/^[a-zA-Z0-9\s._-]+$/, 'Display name contains invalid characters'),

  specialty_ids: z
    .array(z.number().int().positive())
    .min(1, 'Select at least one specialty')
    .max(5, 'Select at most 5 specialties')
});

// Post creation
const createPostSchema = z.object({
  content: z
    .string()
    .min(10, 'Post content too short')
    .max(10000, 'Post content too long'),

  is_anonymous: z.boolean().default(false),

  is_question: z.boolean().default(false),

  evidence_level: z.enum(['1', '2', '3', '4', '5']).optional(),

  tag_ids: z.array(z.number().int().positive()).max(10, 'Too many tags'),

  images: z
    .array(
      z.object({
        url: z.string().url(),
        alt_text: z.string().max(200)
      })
    )
    .max(5, 'Too many images')
    .optional(),

  references: z
    .array(
      z.object({
        type: z.enum(['pubmed', 'doi', 'url', 'book']),
        pmid: z.string().optional(),
        doi: z.string().optional(),
        url: z.string().url().optional(),
        citation: z.string().max(500)
      })
    )
    .max(20, 'Too many references')
    .optional()
});

// Validation middleware
function validateRequest(schema: z.ZodSchema) {
  return async (req, res, next) => {
    try {
      req.body = await schema.parseAsync(req.body);
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          error: 'VALIDATION_ERROR',
          message: 'Invalid request data',
          details: error.errors
        });
      }
      next(error);
    }
  };
}

// Usage
app.post(
  '/auth/register',
  validateRequest(registerSchema),
  async (req, res) => {
    // Registration logic
  }
);
```

### CSRF Protection

```typescript
import csrf from 'csurf';

// CSRF middleware
const csrfProtection = csrf({
  cookie: {
    httpOnly: true,
    secure: true,
    sameSite: 'strict'
  }
});

// Get CSRF token
app.get('/csrf-token', csrfProtection, (req, res) => {
  res.json({
    csrfToken: req.csrfToken()
  });
});

// Protected routes
app.post('/posts', csrfProtection, requireAuth, async (req, res) => {
  // Post creation logic
});
```

### XSS Protection

```typescript
// Content Security Policy
import helmet from 'helmet';

app.use(
  helmet.contentSecurityPolicy({
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: [
        "'self'",
        "'unsafe-inline'",
        'https://cdn.unitingdoctors.com'
      ],
      styleSrc: ["'self'", "'unsafe-inline'", 'https://fonts.googleapis.com'],
      imgSrc: [
        "'self'",
        'data:',
        'https://cdn.unitingdoctors.com',
        'https://i.imgur.com'
      ],
      fontSrc: ["'self'", 'https://fonts.gstatic.com'],
      connectSrc: ["'self'", 'https://api.unitingdoctors.com'],
      frameSrc: ["'none'"],
      objectSrc: ["'none'"],
      upgradeInsecureRequests: []
    }
  })
);

// Sanitize user input (HTML)
import DOMPurify from 'isomorphic-dompurify';

function sanitizeHTML(html: string): string {
  return DOMPurify.sanitize(html, {
    ALLOWED_TAGS: [
      'p',
      'br',
      'strong',
      'em',
      'u',
      'a',
      'ul',
      'ol',
      'li',
      'blockquote',
      'code',
      'pre'
    ],
    ALLOWED_ATTR: ['href', 'target', 'rel'],
    ALLOWED_URI_REGEXP: /^(?:(?:https?):\/\/|mailto:)/i
  });
}
```

### SQL Injection Prevention

```typescript
// Using Prisma ORM (parameterized queries)
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

// Safe query
async function getUser(email: string) {
  return await prisma.user.findUnique({
    where: { email } // Automatically parameterized
  });
}

// Complex query with filtering
async function searchPosts(filters: {
  specialty?: number;
  evidence_level?: string;
  query?: string;
}) {
  return await prisma.post.findMany({
    where: {
      AND: [
        filters.specialty ? { tags: { some: { id: filters.specialty } } } : {},
        filters.evidence_level
          ? { evidence_level: filters.evidence_level }
          : {},
        filters.query
          ? {
              OR: [
                { content: { contains: filters.query, mode: 'insensitive' } },
                { title: { contains: filters.query, mode: 'insensitive' } }
              ]
            }
          : {}
      ]
    },
    take: 20
  });
}
```

### Rate Limiting

```typescript
import rateLimit from 'express-rate-limit';
import RedisStore from 'rate-limit-redis';

// Global rate limiter
const globalLimiter = rateLimit({
  store: new RedisStore({
    client: redisClient,
    prefix: 'rate_limit:global:'
  }),
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 1000, // 1000 requests per 15 minutes
  message: {
    error: 'RATE_LIMIT_EXCEEDED',
    message: 'Too many requests, please try again later'
  }
});

// Strict limiter for authentication
const authLimiter = rateLimit({
  store: new RedisStore({
    client: redisClient,
    prefix: 'rate_limit:auth:'
  }),
  windowMs: 15 * 60 * 1000,
  max: 5, // 5 login attempts per 15 minutes
  skipSuccessfulRequests: true
});

// Apply rate limiting
app.use('/api/', globalLimiter);
app.use('/auth/login', authLimiter);
app.use('/auth/register', authLimiter);
```

---

## 🏢 Infrastructure Security

### Network Security

**VPC Configuration**:

- Private subnets for application servers (no direct internet access)
- Public subnets only for load balancers
- NAT Gateway for outbound internet from private subnets
- Network ACLs for subnet-level filtering

**Security Groups** (see INFRASTRUCTURE.md for details):

- Principle of least privilege
- Only necessary ports open
- Source IP restrictions where possible

### Secrets Management

```typescript
// AWS Secrets Manager
import {
  SecretsManagerClient,
  GetSecretValueCommand
} from '@aws-sdk/client-secrets-manager';

const secretsManager = new SecretsManagerClient({ region: 'us-east-1' });

async function getSecret(secretName: string): Promise<any> {
  const command = new GetSecretValueCommand({ SecretId: secretName });
  const response = await secretsManager.send(command);

  return JSON.parse(response.SecretString!);
}

// Usage
const dbConfig = await getSecret('uniting-doctors/database');
const apiKeys = await getSecret('uniting-doctors/api-keys');

// Rotate secrets every 30 days
// Automated via AWS Secrets Manager rotation
```

### Container Security

```dockerfile
# Dockerfile best practices
FROM node:20-alpine AS base

# Run as non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY --chown=nodejs:nodejs . .

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js

# Start application
CMD ["node", "dist/index.js"]
```

**Image Scanning**:

```yaml
# GitHub Actions - Scan Docker images
- name: Scan Docker image
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: ${{ env.ECR_REGISTRY }}/${{ env.ECR_REPOSITORY }}:${{ github.sha }}
    format: 'sarif'
    output: 'trivy-results.sarif'

- name: Upload Trivy results to GitHub Security
  uses: github/codeql-action/upload-sarif@v2
  with:
    sarif_file: 'trivy-results.sarif'
```

---

## 🏥 PHI & HIPAA Compliance

### HIPAA Technical Safeguards

| Requirement               | Implementation                              |
| ------------------------- | ------------------------------------------- |
| **Access Control**        | OAuth 2.0, MFA, RBAC, session management    |
| **Audit Controls**        | Comprehensive audit logging, immutable logs |
| **Integrity**             | Checksums, digital signatures, encryption   |
| **Transmission Security** | TLS 1.3, encrypted data in transit          |

### Business Associate Agreements (BAAs)

Required with all third-party services that may access PHI:

- ✅ AWS (signed BAA)
- ✅ MongoDB Atlas (signed BAA)
- ✅ DataDog (signed BAA)
- ✅ Sentry (signed BAA)
- ⚠️ OpenAI (requires BAA before GPT-4 features)

### PHI Handling Guidelines

```typescript
// PHI Policy Enforcement
enum DataClassification {
  PUBLIC = 'public', // Publicly viewable
  INTERNAL = 'internal', // Internal use only
  CONFIDENTIAL = 'confidential', // User-specific data
  PHI = 'phi' // Protected Health Information
}

// Metadata for data classification
interface DataField {
  name: string;
  classification: DataClassification;
  encrypted: boolean;
  auditLogged: boolean;
}

const dataClassification: Record<string, DataField> = {
  'user.email': {
    name: 'email',
    classification: DataClassification.CONFIDENTIAL,
    encrypted: false,
    auditLogged: true
  },
  'user.npi_number': {
    name: 'npi_number',
    classification: DataClassification.PHI,
    encrypted: true,
    auditLogged: true
  },
  'post.content': {
    name: 'content',
    classification: DataClassification.PUBLIC,
    encrypted: false,
    auditLogged: false
  }
};

// Audit log for PHI access
async function logPHIAccess(
  userId: string,
  resourceType: string,
  resourceId: string,
  action: string
) {
  await auditLog.log({
    action: 'PHI_ACCESS',
    userId,
    resourceType,
    resourceId,
    action,
    timestamp: new Date(),
    ip: req.ip
  });
}
```

---

## 🚨 Incident Response

### Incident Response Plan

**Phases**:

1. **Detection**: Automated alerts, user reports
2. **Containment**: Isolate affected systems
3. **Eradication**: Remove threat
4. **Recovery**: Restore normal operations
5. **Lessons Learned**: Post-incident review

### Security Incident Runbook

#### Data Breach Response

```markdown
## Data Breach Response Procedure

### Immediate Actions (0-1 hour)

1. **Confirm the breach**
   - Verify the incident is real
   - Identify affected systems
   - Estimate scope (number of users, data types)

2. **Contain the breach**
   - Isolate affected systems
   - Revoke compromised credentials
   - Block suspicious IP addresses
   - Take snapshots for forensics

3. **Notify incident response team**
   - Security Lead
   - CTO
   - Legal Counsel
   - PR/Communications

### Short-term Actions (1-24 hours)

4. **Investigate**
   - Review audit logs
   - Identify attack vector
   - Determine data accessed/exfiltrated
   - Preserve evidence

5. **Eradicate threat**
   - Patch vulnerabilities
   - Remove malware
   - Reset all credentials
   - Deploy security updates

6. **Begin notification process**
   - Draft user notification
   - Prepare regulatory notifications (HHS for HIPAA breach)
   - Coordinate with legal team

### Medium-term Actions (1-3 days)

7. **Notify affected parties**
   - Email to affected users (within 60 days per HIPAA)
   - Public disclosure if >500 users affected
   - Regulatory notification (HHS Office for Civil Rights)
   - Media notification if required

8. **Offer remediation**
   - Credit monitoring (if PII exposed)
   - Password reset assistance
   - Enhanced security features (MFA)

### Long-term Actions (1-2 weeks)

9. **Post-incident review**
   - Root cause analysis
   - Timeline reconstruction
   - Document lessons learned
   - Update security measures

10. **Improve defenses**
    - Implement additional safeguards
    - Update incident response plan
    - Conduct security training
```

### Breach Notification Template

```
Subject: Important Security Notice - Uniting Doctors Data Incident

Dear [User Name],

We are writing to inform you of a security incident that may have affected your account.

What Happened:
On [DATE], we discovered [DESCRIPTION OF INCIDENT]. We immediately launched an investigation and took steps to secure our systems.

What Information Was Involved:
The incident may have exposed the following information:
- [LIST DATA TYPES, e.g., email address, display name]
- [DO NOT include sensitive details about the vulnerability]

What We Are Doing:
- We have [ACTIONS TAKEN]
- We have notified law enforcement and regulatory authorities
- We are conducting a thorough security review

What You Can Do:
- Change your password immediately
- Enable multi-factor authentication (MFA)
- Monitor your account for suspicious activity
- Be cautious of phishing attempts

We sincerely apologize for this incident and any concern it may cause. The security of your data is our top priority.

For more information, please visit: https://unitingdoctors.com/security-notice

Sincerely,
The Uniting Doctors Security Team
```

---

## 🧪 Security Testing

### Penetration Testing

**Schedule**:

- Quarterly penetration tests by third-party firm
- Annual comprehensive security audit
- Post-major-release testing

**Scope**:

- Web application (frontend and API)
- Mobile applications
- Infrastructure (network, AWS)
- Social engineering (phishing simulations)

**Test Types**:

1. **Black Box**: No prior knowledge
2. **Gray Box**: Limited knowledge (typical user account)
3. **White Box**: Full knowledge (code + infrastructure)

### Vulnerability Scanning

```yaml
# Automated vulnerability scanning

# Dependency scanning (npm audit)
- name: Run npm audit
  run: npm audit --audit-level=moderate

# SAST (Static Application Security Testing)
- name: Run CodeQL analysis
  uses: github/codeql-action/analyze@v2
  with:
    languages: typescript, javascript

# Container scanning
- name: Scan Docker image
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: 'image'
    severity: 'CRITICAL,HIGH'

# Infrastructure scanning
- name: Scan Terraform
  uses: aquasecurity/tfsec-action@v1.0.0
```

### Bug Bounty Program

**Platform**: HackerOne or Bugcrowd

**Scope**:

- In scope: Web app, API, mobile apps
- Out of scope: Social engineering, DDoS, third-party services

**Rewards**:
| Severity | Reward |
|----------|--------|
| **Critical** | $5,000 - $10,000 |
| **High** | $1,000 - $5,000 |
| **Medium** | $250 - $1,000 |
| **Low** | $100 - $250 |

**Rules**:

- No public disclosure until fixed
- Provide detailed reproduction steps
- One issue per report
- Must be reproducible on production

---

## 📜 Compliance & Auditing

### Audit Logging

```typescript
// Comprehensive audit log
interface AuditLogEntry {
  id: string;
  timestamp: Date;
  action: string;
  actor_id: string;
  actor_role: string;
  actor_ip: string;
  resource_type: string;
  resource_id: string;
  changes?: {
    field: string;
    old_value: any;
    new_value: any;
  }[];
  result: 'success' | 'failure';
  error_message?: string;
}

// Actions to log
const AUDITED_ACTIONS = [
  'USER_LOGIN',
  'USER_LOGOUT',
  'USER_CREATED',
  'USER_UPDATED',
  'USER_DELETED',
  'PASSWORD_CHANGED',
  'MFA_ENABLED',
  'MFA_DISABLED',
  'POST_CREATED',
  'POST_UPDATED',
  'POST_DELETED',
  'MODERATION_ACTION',
  'USER_BANNED',
  'USER_UNBANNED',
  'PERMISSION_CHANGED',
  'PHI_ACCESSED',
  'DATA_EXPORTED',
  'SETTINGS_CHANGED'
];

// Audit log service
class AuditLogService {
  async log(entry: Omit<AuditLogEntry, 'id' | 'timestamp'>) {
    const logEntry = {
      id: generateId(),
      timestamp: new Date(),
      ...entry
    };

    // Write to database
    await db.auditLog.create({ data: logEntry });

    // Also send to centralized logging (DataDog, Splunk)
    await this.sendToCentralizedLogging(logEntry);

    // Archive to S3 for long-term retention
    await this.archiveToS3(logEntry);
  }

  async query(filters: {
    actor_id?: string;
    action?: string;
    resource_type?: string;
    start_date?: Date;
    end_date?: Date;
  }) {
    return await db.auditLog.findMany({
      where: filters,
      orderBy: { timestamp: 'desc' }
    });
  }
}
```

### Compliance Monitoring

```typescript
// Automated compliance checks
async function runComplianceChecks() {
  const checks = [
    {
      name: 'Password policy enforcement',
      check: async () => {
        const weakPasswords = await db.user.count({
          where: {
            password_strength: { lt: 3 }
          }
        });
        return weakPasswords === 0;
      }
    },
    {
      name: 'MFA adoption rate',
      check: async () => {
        const total = await db.user.count();
        const mfaEnabled = await db.user.count({
          where: { mfa_enabled: true }
        });
        return mfaEnabled / total > 0.8; // 80% adoption
      }
    },
    {
      name: 'Encryption at rest',
      check: async () => {
        // Verify RDS, S3, Redis encryption
        return await verifyEncryptionSettings();
      }
    },
    {
      name: 'Audit log retention',
      check: async () => {
        const oldestLog = await db.auditLog.findFirst({
          orderBy: { timestamp: 'asc' }
        });
        const ageInDays =
          (Date.now() - oldestLog.timestamp.getTime()) / (1000 * 60 * 60 * 24);
        return ageInDays <= 2555; // 7 years (HIPAA requirement)
      }
    }
  ];

  for (const check of checks) {
    const result = await check.check();
    if (!result) {
      await alertSecurityTeam(`Compliance check failed: ${check.name}`);
    }
  }
}

// Run daily
cron.schedule('0 2 * * *', runComplianceChecks);
```

---

## 🗓️ Security Roadmap

### Phase 1: MVP Security (Months 1-4)

- ✅ OAuth 2.0 + JWT authentication
- ✅ TLS encryption
- ✅ Input validation
- ✅ CSRF protection
- ✅ Rate limiting
- ✅ Audit logging
- ✅ PHI detection

### Phase 2: Enhanced Security (Months 5-8)

- ✅ Multi-factor authentication (MFA)
- ✅ WAF configuration (Cloudflare)
- ✅ Automated vulnerability scanning
- ✅ Secrets management (AWS Secrets Manager)
- ✅ Container security (image scanning)
- ✅ Incident response plan

### Phase 3: Compliance (Months 9-12)

- ⬜ HIPAA compliance audit
- ⬜ SOC 2 Type I certification
- ⬜ Penetration testing (third-party)
- ⬜ Bug bounty program launch
- ⬜ GDPR compliance verification
- ⬜ Security training for all staff

### Phase 4: Advanced Security (Months 13-18)

- ⬜ SOC 2 Type II certification
- ⬜ SIEM implementation (Splunk/ELK)
- ⬜ Threat intelligence integration
- ⬜ Advanced anomaly detection (ML-based)
- ⬜ Zero-trust architecture
- ⬜ Regular red team exercises

---

## 📞 Security Contacts

**Security Team Email**: security@unitingdoctors.com
**Responsible Disclosure**: https://unitingdoctors.com/security/disclosure
**Bug Bounty Program**: https://hackerone.com/unitingdoctors
**Security Advisories**: https://unitingdoctors.com/security/advisories

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Next Review**: February 8, 2026

**Related Documents**:

- [INFRASTRUCTURE.md](./INFRASTRUCTURE.md)
- [COMPLIANCE.md](../legal/COMPLIANCE.md)
- [PRIVACY_POLICY.md](../legal/PRIVACY_POLICY.md)
- [INCIDENT_RESPONSE_PLAN.md](../operations/INCIDENT_RESPONSE_PLAN.md)
