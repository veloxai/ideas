# Fair Underwriting - Integration Specifications

**Last Updated**: November 7, 2025
**Purpose**: Technical specifications for integrating Fair Underwriting platform with insurance partner systems
**Status**: Design Document (Implementation Q1 2026+)

---

## Executive Summary

This document defines **technical integration patterns** for connecting Fair Underwriting with insurance partner systems, enabling:

1. **Single Sign-On (SSO)**: Partner employees/policyholders log into Fair Underwriting using partner credentials
2. **Data Feeds**: Eligibility data (who can enroll), enrollment data (who enrolled), outcomes data (test results, aggregate metrics)
3. **API Access**: Programmatic access for partner systems to query Fair Underwriting data, trigger actions
4. **Portal White-Labeling**: Embed Fair Underwriting portal in partner benefits site (iframe or native integration)

**Integration Patterns**:

| **Pattern**               | **Complexity** | **Setup Time** | **Use Case**                                                    |
| ------------------------- | -------------- | -------------- | --------------------------------------------------------------- |
| **SSO (SAML/OAuth)**      | Medium         | 2-4 weeks      | Partner employees/policyholders log in with partner credentials |
| **SFTP Data Feed**        | Low            | 1-2 weeks      | Daily batch file exchange (eligibility, enrollments, results)   |
| **REST API**              | High           | 4-8 weeks      | Real-time data sync, custom integrations                        |
| **Webhook**               | Medium         | 2-3 weeks      | Event-driven notifications (enrollment completed, result ready) |
| **Portal Embed (iframe)** | Low            | 1 week         | Embed Fair Underwriting portal in partner website               |
| **Native Integration**    | Very High      | 12+ weeks      | Deep integration (partner's EHR, benefits platform)             |

**Technology Stack**:

- **SSO**: SAML 2.0 (primary), OAuth 2.0 / OIDC (secondary)
- **API**: REST, JSON, OAuth 2.0 authentication, rate limiting
- **Data Feeds**: SFTP (batch files), CSV/JSON formats, PGP encryption
- **Portal**: Next.js 14, responsive design, iframe-embeddable, white-label CSS

---

## Section 1: Single Sign-On (SSO)

### 1.1 SSO Overview

**Purpose**: Allow partner employees and policyholders to log into Fair Underwriting using partner credentials (no separate username/password)

**Benefits**:

- **User experience**: One-click login from partner portal (no password to remember)
- **Security**: Partner manages authentication (Fair Underwriting never sees passwords)
- **Provisioning**: Partner controls user access (add/remove users via SSO)

**Supported Protocols**:

1. **SAML 2.0** (Security Assertion Markup Language—primary, enterprise-standard)
2. **OAuth 2.0 / OpenID Connect (OIDC)** (secondary, modern standard)

---

### 1.2 SAML 2.0 Integration (Primary)

**SAML Flow** (SP-Initiated—Fair Underwriting as Service Provider):

```
1. User clicks "Login with [Partner]" on Fair Underwriting portal
2. Fair Underwriting redirects to Partner IdP (Identity Provider) with SAML AuthnRequest
3. User authenticates at Partner IdP (username/password, MFA, etc.)
4. Partner IdP redirects back to Fair Underwriting with SAML Response (assertion)
5. Fair Underwriting validates assertion, creates session, logs user in
```

**SAML Configuration** (Partner provides to Fair Underwriting):

```yaml
# Partner IdP Metadata
idp_entity_id: 'https://partner.okta.com'
idp_sso_url: 'https://partner.okta.com/app/fairunderwriting/sso/saml'
idp_slo_url: 'https://partner.okta.com/app/fairunderwriting/slo/saml' # Single Logout (optional)
idp_certificate: |
  -----BEGIN CERTIFICATE-----
  MIIDpDCCAoygAwIBAgIGAXk... (X.509 certificate)
  -----END CERTIFICATE-----

# User Attributes (mapped from Partner IdP to Fair Underwriting)
attributes:
  email: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'
  first_name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname'
  last_name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname'
  partner_id: 'partnerId' # Custom attribute (partner's internal user ID)
  role: 'role' # Optional: "admin", "user", "read-only"
```

**Fair Underwriting SP Metadata** (provided to Partner):

```yaml
sp_entity_id: 'https://fairunderwriting.com/saml'
sp_acs_url: 'https://fairunderwriting.com/saml/acs' # Assertion Consumer Service
sp_slo_url: 'https://fairunderwriting.com/saml/slo' # Single Logout (optional)
sp_certificate: |
  -----BEGIN CERTIFICATE-----
  MIIDpDCCAoygAwIBAgIGAXk... (Fair Underwriting X.509 certificate)
  -----END CERTIFICATE-----

# NameID Format
nameid_format: 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
```

**Implementation** (Fair Underwriting):

- Library: `passport-saml` (Node.js), `python-saml` (Python)
- Session management: JWT tokens (access token + refresh token)
- User provisioning: Create Fair Underwriting account on first login (Just-In-Time provisioning)

**Testing**:

1. **SSO tester**: Use SAML test tool (e.g., samltool.io) to validate SAML Response
2. **UAT**: Partner IT team tests login with 5-10 test users
3. **Production cutover**: Enable SSO for all partner users

**Timeline**: 2-4 weeks (1 week Fair Underwriting config, 1 week Partner IT config, 1-2 weeks testing/troubleshooting)

---

### 1.3 OAuth 2.0 / OIDC Integration (Secondary)

**OAuth Flow** (Authorization Code Flow):

```
1. User clicks "Login with [Partner]" on Fair Underwriting portal
2. Fair Underwriting redirects to Partner OAuth server with authorization request
3. User authenticates at Partner (username/password, MFA)
4. Partner redirects back to Fair Underwriting with authorization code
5. Fair Underwriting exchanges code for access token (backend API call)
6. Fair Underwriting uses access token to fetch user info (email, name, etc.)
7. Fair Underwriting creates session, logs user in
```

**OAuth Configuration** (Partner provides to Fair Underwriting):

```yaml
# OAuth Endpoints
authorization_url: 'https://partner.auth0.com/authorize'
token_url: 'https://partner.auth0.com/oauth/token'
userinfo_url: 'https://partner.auth0.com/userinfo'

# Client Credentials
client_id: 'fairunderwriting-client-id'
client_secret: 'fairunderwriting-client-secret' # Securely shared (1Password, Vault)

# Scopes
scopes: ['openid', 'profile', 'email']

# Redirect URI (Fair Underwriting callback)
redirect_uri: 'https://fairunderwriting.com/oauth/callback'
```

**Implementation** (Fair Underwriting):

- Library: `passport-oauth2` (Node.js), `authlib` (Python)
- Token storage: Store access token + refresh token securely (encrypted in database)
- User provisioning: Create Fair Underwriting account on first login

**Timeline**: 2-3 weeks (faster than SAML—simpler protocol)

---

### 1.4 SSO Security Considerations

**Certificate Expiration**:

- Partner IdP certificates expire (typically 1-3 years)
- Fair Underwriting monitors expiration (alert 30 days before)
- Partner must provide new certificate before expiration

**Replay Attacks**:

- SAML assertions are one-time use (Fair Underwriting validates `InResponseTo` ID)
- Assertions have short TTL (5-10 minutes)

**Man-in-the-Middle**:

- All traffic over HTTPS/TLS 1.3
- Fair Underwriting validates Partner IdP certificate (reject if invalid/self-signed)

**User Deprovisioning**:

- If Partner removes user from IdP, user cannot log in (SSO will fail)
- Fair Underwriting should periodically sync user list with Partner (via API or SFTP) to deactivate accounts

---

## Section 2: Data Feeds (SFTP Batch Integration)

### 2.1 Data Feed Overview

**Purpose**: Exchange data files between Fair Underwriting and Partner systems (eligibility, enrollments, outcomes)

**Feed Types**:

1. **Eligibility Feed** (Partner → Fair Underwriting): List of policyholders eligible for testing
2. **Enrollment Feed** (Fair Underwriting → Partner): List of policyholders who enrolled
3. **Outcome Feed** (Fair Underwriting → Partner): Aggregate outcomes (MZ carriers detected, NPS, action rates)

**Protocol**: SFTP (Secure File Transfer Protocol)

**Frequency**:

- **Eligibility**: Daily (Partner uploads at 2am UTC, Fair Underwriting processes at 3am)
- **Enrollment**: Daily (Fair Underwriting uploads at 2am UTC, Partner downloads at 3am)
- **Outcome**: Monthly (Fair Underwriting uploads on 1st of month)

**File Format**: CSV (primary), JSON (secondary)

**Encryption**: PGP (optional but recommended for PHI)

---

### 2.2 Eligibility Feed (Partner → Fair Underwriting)

**Purpose**: Partner provides list of policyholders eligible for Fair Underwriting testing

**File Naming Convention**: `eligibility_[partner_id]_[YYYYMMDD].csv`

- Example: `eligibility_northwestern_mutual_20260115.csv`

**CSV Schema**:

```csv
partner_member_id,email,first_name,last_name,date_of_birth,gender,state,policy_type,policy_start_date
12345678,john.doe@email.com,John,Doe,1980-05-15,M,IA,Life,2022-01-01
23456789,jane.smith@email.com,Jane,Smith,1985-09-20,F,TX,Health,2023-03-15
```

**Field Specifications**:

| **Field**           | **Type**          | **Required** | **Description**                                                  |
| ------------------- | ----------------- | ------------ | ---------------------------------------------------------------- |
| `partner_member_id` | String            | Yes          | Partner's internal member ID (unique identifier)                 |
| `email`             | String            | Yes          | Policyholder email (for Fair Underwriting login, communications) |
| `first_name`        | String            | Yes          | Policyholder first name                                          |
| `last_name`         | String            | Yes          | Policyholder last name                                           |
| `date_of_birth`     | Date (YYYY-MM-DD) | Yes          | Policyholder date of birth (for age validation—must be 18+)      |
| `gender`            | String (M/F/O)    | No           | Policyholder gender (optional, used for demographics)            |
| `state`             | String (2-letter) | Yes          | U.S. state (for compliance—some states restrict genetic testing) |
| `policy_type`       | String            | Yes          | "Life", "Health", "Disability" (for reporting)                   |
| `policy_start_date` | Date (YYYY-MM-DD) | No           | Policy start date (optional, for eligibility rules)              |

**Processing**:

1. Fair Underwriting downloads file from Partner SFTP at 3am UTC
2. Validate file (check schema, required fields, data types)
3. Deduplicate (if `partner_member_id` already exists, update record)
4. Load into `eligible_members` table in PostgreSQL
5. Send email to eligible policyholders (if opted in): "You're eligible for free genetic testing via [Partner]"

**Error Handling**:

- If file invalid (missing columns, bad format): Email Partner IT ("Eligibility file rejected—please fix and re-upload")
- If record invalid (e.g., state = "XX"): Skip record, log error, continue processing (don't fail entire file)

---

### 2.3 Enrollment Feed (Fair Underwriting → Partner)

**Purpose**: Fair Underwriting notifies Partner of new enrollments (policyholders who signed up for testing)

**File Naming Convention**: `enrollment_[partner_id]_[YYYYMMDD].csv`

- Example: `enrollment_northwestern_mutual_20260115.csv`

**CSV Schema**:

```csv
partner_member_id,enrollment_date,kit_order_date,sample_received_date,result_delivery_date,result_type,subscription_status
12345678,2026-01-10,2026-01-11,2026-01-15,2026-01-22,MZ,Active
23456789,2026-01-12,2026-01-13,2026-01-18,,Pending,None
```

**Field Specifications**:

| **Field**              | **Type**          | **Required** | **Description**                                                         |
| ---------------------- | ----------------- | ------------ | ----------------------------------------------------------------------- |
| `partner_member_id`    | String            | Yes          | Partner's internal member ID (matches eligibility feed)                 |
| `enrollment_date`      | Date (YYYY-MM-DD) | Yes          | Date policyholder enrolled (consented to testing)                       |
| `kit_order_date`       | Date (YYYY-MM-DD) | No           | Date kit shipped to policyholder                                        |
| `sample_received_date` | Date (YYYY-MM-DD) | No           | Date lab received saliva sample                                         |
| `result_delivery_date` | Date (YYYY-MM-DD) | No           | Date result delivered to policyholder                                   |
| `result_type`          | String            | No           | "MM", "MZ", "MS", "SZ", "ZZ" (only if result delivered—otherwise blank) |
| `subscription_status`  | String            | Yes          | "None", "Active", "Cancelled" (annual monitoring subscription)          |

**Privacy**: `result_type` is **aggregate-only** for Partner dashboard (Partner sees "40 MZ carriers detected" but NOT individual names/results—patent-protected privacy)

**Processing**:

1. Fair Underwriting generates file daily at 2am UTC (includes all enrollments from prior day)
2. Upload to Partner SFTP
3. Partner downloads at 3am UTC
4. Partner loads into their CRM/data warehouse for reporting

**Incremental vs. Full File**:

- **Incremental** (default): Only new/updated records since last feed
- **Full** (optional): All enrollments (partner requests full file monthly for reconciliation)

---

### 2.4 Outcome Feed (Fair Underwriting → Partner)

**Purpose**: Fair Underwriting provides aggregate outcomes data for Partner dashboard (enrollment rates, MZ detection, NPS, ROI)

**File Naming Convention**: `outcome_[partner_id]_[YYYYMM].csv`

- Example: `outcome_northwestern_mutual_202601.csv` (January 2026 data)

**CSV Schema**:

```csv
metric,value,period_start,period_end
eligible_members,10000,2026-01-01,2026-01-31
enrolled_members,842,2026-01-01,2026-01-31
enrollment_rate,8.42%,2026-01-01,2026-01-31
tests_completed,785,2026-01-01,2026-01-31
mz_detected,32,2026-01-01,2026-01-31
mz_detection_rate,4.08%,2026-01-01,2026-01-31
zz_detected,2,2026-01-01,2026-01-31
nps_overall,64,2026-01-01,2026-01-31
nps_counseling,68,2026-01-01,2026-01-31
action_rate_smoking_cessation,34%,2026-01-01,2026-01-31
action_rate_doctor_visit,81%,2026-01-01,2026-01-31
projected_savings_5yr,$57600,2026-01-01,2026-01-31
cost_per_mz,$9208,2026-01-01,2026-01-31
```

**Field Specifications**:

| **Field**      | **Type**          | **Required** | **Description**                              |
| -------------- | ----------------- | ------------ | -------------------------------------------- |
| `metric`       | String            | Yes          | Metric name (see above for standard metrics) |
| `value`        | String            | Yes          | Metric value (number, percentage, currency)  |
| `period_start` | Date (YYYY-MM-DD) | Yes          | Start of reporting period (e.g., 2026-01-01) |
| `period_end`   | Date (YYYY-MM-DD) | Yes          | End of reporting period (e.g., 2026-01-31)   |

**Privacy**: All metrics are **aggregate-only** (no individual-level data)

**Processing**:

1. Fair Underwriting generates file monthly (on 1st of month for prior month)
2. Upload to Partner SFTP
3. Partner downloads and loads into BI tool (Tableau, Power BI) for executive dashboards

---

### 2.5 SFTP Setup

**Fair Underwriting SFTP Server**:

- Hostname: `sftp.fairunderwriting.com`
- Port: 22 (standard SFTP)
- Authentication: SSH key (public key provided by Partner, private key kept by Fair Underwriting)
- Directory structure:
  - `/inbound/[partner_id]/` (Partner uploads eligibility files here)
  - `/outbound/[partner_id]/` (Fair Underwriting uploads enrollment/outcome files here)

**Partner SFTP Server** (alternative—Partner hosts, Fair Underwriting connects):

- Partner provides: Hostname, port, SSH key (or username/password)
- Fair Underwriting uploads files to Partner's SFTP

**Security**:

- SSH keys (preferred over passwords—more secure, no password rotation)
- IP whitelisting (Partner firewall allows only Fair Underwriting IPs)
- File encryption (PGP—Fair Underwriting encrypts files with Partner's public PGP key, Partner decrypts with private key)

**Monitoring**:

- Fair Underwriting monitors SFTP success/failure (alert if file not uploaded/downloaded on schedule)
- Partner monitors for missing files (alert if expected file not received by 4am UTC)

---

## Section 3: REST API

### 3.1 API Overview

**Purpose**: Programmatic access for Partner systems to query Fair Underwriting data, trigger actions (real-time integration)

**Use Cases**:

1. **Eligibility check**: "Is this policyholder eligible for Fair Underwriting testing?"
2. **Enrollment status**: "Has this policyholder enrolled? What's their test status?"
3. **Outcome query**: "What are the aggregate outcomes for our population?"
4. **Trigger actions**: "Send enrollment reminder to this policyholder"

**API Design**:

- **Protocol**: REST (HTTP/HTTPS)
- **Format**: JSON (request/response bodies)
- **Authentication**: OAuth 2.0 (client credentials flow—Partner gets API key + secret)
- **Rate Limiting**: 100 requests/minute per partner (prevent abuse)
- **Versioning**: `/api/v1/`, `/api/v2/` (backward-compatible, deprecation policy)

**Base URL**: `https://api.fairunderwriting.com/v1`

---

### 3.2 Authentication

**OAuth 2.0 Client Credentials Flow**:

```
1. Partner requests access token (POST /oauth/token with client_id, client_secret)
2. Fair Underwriting validates credentials, returns access token (JWT, expires in 1 hour)
3. Partner includes access token in API requests (Authorization: Bearer <token>)
4. Fair Underwriting validates token, processes request
```

**Request Access Token**:

```bash
POST /oauth/token
Content-Type: application/json

{
  "grant_type": "client_credentials",
  "client_id": "partner_northwestern_mutual",
  "client_secret": "super_secret_key_12345"
}
```

**Response**:

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

**Using Access Token** (in subsequent requests):

```bash
GET /api/v1/enrollments?partner_member_id=12345678
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

### 3.3 API Endpoints

**Endpoint 1: Check Eligibility**

```
GET /api/v1/eligibility/{partner_member_id}
```

**Purpose**: Check if policyholder is eligible for Fair Underwriting testing

**Request**:

```bash
GET /api/v1/eligibility/12345678
Authorization: Bearer <token>
```

**Response** (200 OK):

```json
{
  "partner_member_id": "12345678",
  "eligible": true,
  "reason": "Policyholder meets eligibility criteria (age 18+, state allows genetic testing)",
  "enrollment_url": "https://fairunderwriting.com/enroll?token=abc123"
}
```

**Response** (404 Not Found):

```json
{
  "partner_member_id": "12345678",
  "eligible": false,
  "reason": "Policyholder not found in eligibility feed"
}
```

---

**Endpoint 2: Get Enrollment Status**

```
GET /api/v1/enrollments/{partner_member_id}
```

**Purpose**: Get policyholder's enrollment and test status

**Request**:

```bash
GET /api/v1/enrollments/12345678
Authorization: Bearer <token>
```

**Response** (200 OK, enrolled):

```json
{
  "partner_member_id": "12345678",
  "enrolled": true,
  "enrollment_date": "2026-01-10",
  "test_status": "result_delivered",
  "kit_order_date": "2026-01-11",
  "sample_received_date": "2026-01-15",
  "result_delivery_date": "2026-01-22",
  "result_type": null, // Privacy: Partner cannot see individual result
  "subscription_status": "active",
  "nps_score": 9
}
```

**Response** (200 OK, not enrolled):

```json
{
  "partner_member_id": "12345678",
  "enrolled": false,
  "reason": "Policyholder has not enrolled yet"
}
```

**Privacy Note**: `result_type` is **always null** in API response (Partner cannot access individual genetic results—patent-protected privacy)

---

**Endpoint 3: Get Aggregate Outcomes**

```
GET /api/v1/outcomes?partner_id={partner_id}&start_date={YYYY-MM-DD}&end_date={YYYY-MM-DD}
```

**Purpose**: Get aggregate outcomes for Partner's population (for dashboards, reporting)

**Request**:

```bash
GET /api/v1/outcomes?partner_id=northwestern_mutual&start_date=2026-01-01&end_date=2026-01-31
Authorization: Bearer <token>
```

**Response** (200 OK):

```json
{
  "partner_id": "northwestern_mutual",
  "period_start": "2026-01-01",
  "period_end": "2026-01-31",
  "metrics": {
    "eligible_members": 10000,
    "enrolled_members": 842,
    "enrollment_rate": 0.0842,
    "tests_completed": 785,
    "mz_detected": 32,
    "mz_detection_rate": 0.0408,
    "zz_detected": 2,
    "nps_overall": 64,
    "nps_counseling": 68,
    "action_rate_smoking_cessation": 0.34,
    "action_rate_doctor_visit": 0.81,
    "projected_savings_5yr": 57600,
    "cost_per_mz": 9208
  }
}
```

---

**Endpoint 4: Trigger Enrollment Reminder**

```
POST /api/v1/reminders
```

**Purpose**: Trigger Fair Underwriting to send enrollment reminder email to policyholder

**Request**:

```bash
POST /api/v1/reminders
Authorization: Bearer <token>
Content-Type: application/json

{
  "partner_member_id": "12345678",
  "reminder_type": "enrollment",
  "message": "Don't forget to enroll in your free genetic testing benefit!"
}
```

**Response** (202 Accepted):

```json
{
  "status": "queued",
  "partner_member_id": "12345678",
  "reminder_id": "rem_abc123",
  "estimated_send_time": "2026-01-15T14:30:00Z"
}
```

**Response** (400 Bad Request, already enrolled):

```json
{
  "error": "Policyholder already enrolled",
  "partner_member_id": "12345678"
}
```

---

### 3.4 API Error Handling

**Standard HTTP Status Codes**:

- **200 OK**: Request successful
- **201 Created**: Resource created (e.g., POST /enrollments)
- **202 Accepted**: Request accepted, processing asynchronously (e.g., POST /reminders)
- **400 Bad Request**: Invalid request (missing required fields, bad format)
- **401 Unauthorized**: Missing or invalid access token
- **403 Forbidden**: Access token valid, but Partner not authorized for this resource
- **404 Not Found**: Resource not found (e.g., partner_member_id doesn't exist)
- **429 Too Many Requests**: Rate limit exceeded (100 requests/minute)
- **500 Internal Server Error**: Fair Underwriting server error (alert engineering team)

**Error Response Format**:

```json
{
  "error": "Invalid partner_member_id",
  "error_code": "INVALID_MEMBER_ID",
  "message": "The partner_member_id '99999999' does not exist in our system",
  "timestamp": "2026-01-15T14:30:00Z"
}
```

---

### 3.5 API Rate Limiting

**Limits**:

- **100 requests/minute** per partner (average ~1.7 requests/second)
- **10,000 requests/day** per partner

**Rate Limit Headers** (included in every API response):

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 87
X-RateLimit-Reset: 1642262400  # Unix timestamp (seconds) when limit resets
```

**429 Response** (rate limit exceeded):

```json
{
  "error": "Rate limit exceeded",
  "error_code": "RATE_LIMIT_EXCEEDED",
  "message": "You have exceeded 100 requests/minute. Please wait 32 seconds before retrying.",
  "retry_after": 32
}
```

**Implementation**: Redis (token bucket algorithm—allows burst traffic, smooth rate limiting)

---

### 3.6 API Versioning & Deprecation

**Versioning Strategy**:

- URL-based versioning: `/api/v1/`, `/api/v2/`
- Backward-compatible within major version (v1.0 → v1.1 → v1.2—no breaking changes)
- Breaking changes require new major version (v1 → v2)

**Deprecation Policy**:

- **6-month notice**: Announce deprecation 6 months before sunset (email partners, API changelog)
- **Maintain old version**: Continue supporting old version for 6 months after new version launch
- **Sunset**: Disable old version after 6 months (return 410 Gone)

**Example Deprecation**:

```
Date: 2026-01-01
Announcement: "API v1 will be deprecated on 2026-07-01. Please migrate to API v2 by then."

Date: 2026-07-01
Action: API v1 disabled. All requests return:
{
  "error": "API v1 has been deprecated. Please use API v2.",
  "migration_guide": "https://docs.fairunderwriting.com/api/v2-migration"
}
```

---

## Section 4: Webhooks (Event-Driven Integration)

### 4.1 Webhook Overview

**Purpose**: Fair Underwriting sends real-time notifications to Partner when events occur (enrollment completed, result delivered, subscription renewed)

**Benefits**:

- **Real-time**: Partner receives notifications immediately (vs. daily batch files)
- **Event-driven**: Partner systems react to events (e.g., send congratulations email when result delivered)

**Webhook Flow**:

```
1. Event occurs at Fair Underwriting (e.g., policyholder enrolls)
2. Fair Underwriting sends HTTP POST to Partner's webhook URL
3. Partner receives POST, processes event, returns 200 OK
4. If Partner returns error (500, timeout), Fair Underwriting retries (exponential backoff)
```

---

### 4.2 Webhook Configuration

**Partner Provides** (during onboarding):

- **Webhook URL**: `https://partner.com/webhooks/fairunderwriting`
- **Secret Key**: Shared secret for HMAC signature verification (prevents spoofing)

**Fair Underwriting Sends**:

- **POST** to Partner's webhook URL
- **Headers**:
  - `Content-Type: application/json`
  - `X-FairUnderwriting-Event: enrollment.completed` (event type)
  - `X-FairUnderwriting-Signature: sha256=abc123...` (HMAC-SHA256 signature of payload with secret key)

---

### 4.3 Webhook Events

**Event 1: enrollment.completed**

**Trigger**: Policyholder completes enrollment (consented, kit ordered)

**Payload**:

```json
{
  "event": "enrollment.completed",
  "timestamp": "2026-01-15T14:30:00Z",
  "data": {
    "partner_member_id": "12345678",
    "enrollment_date": "2026-01-15",
    "kit_order_date": "2026-01-15",
    "enrollment_url": "https://fairunderwriting.com/enrollments/enr_abc123"
  }
}
```

---

**Event 2: sample.received**

**Trigger**: Lab receives saliva sample from policyholder

**Payload**:

```json
{
  "event": "sample.received",
  "timestamp": "2026-01-20T10:15:00Z",
  "data": {
    "partner_member_id": "12345678",
    "sample_received_date": "2026-01-20",
    "estimated_result_date": "2026-01-27"
  }
}
```

---

**Event 3: result.delivered**

**Trigger**: Genetic test result delivered to policyholder

**Payload**:

```json
{
  "event": "result.delivered",
  "timestamp": "2026-01-27T09:00:00Z",
  "data": {
    "partner_member_id": "12345678",
    "result_delivery_date": "2026-01-27",
    "result_type": null, // Privacy: Partner cannot see individual result
    "counseling_scheduled": true,
    "counseling_date": "2026-01-29T15:00:00Z"
  }
}
```

**Privacy**: `result_type` is always null (Partner cannot access individual results)

---

**Event 4: subscription.started**

**Trigger**: Policyholder subscribes to annual monitoring ($30-75/year)

**Payload**:

```json
{
  "event": "subscription.started",
  "timestamp": "2026-02-01T12:00:00Z",
  "data": {
    "partner_member_id": "12345678",
    "subscription_start_date": "2026-02-01",
    "subscription_amount": 50.0,
    "subscription_frequency": "annual"
  }
}
```

---

**Event 5: subscription.cancelled**

**Trigger**: Policyholder cancels annual monitoring subscription

**Payload**:

```json
{
  "event": "subscription.cancelled",
  "timestamp": "2026-05-15T16:30:00Z",
  "data": {
    "partner_member_id": "12345678",
    "cancellation_date": "2026-05-15",
    "cancellation_reason": "No longer interested"
  }
}
```

---

### 4.4 Webhook Security (HMAC Signature Verification)

**Why?**: Prevent spoofing (malicious actor could send fake webhooks to Partner)

**How**:

1. Fair Underwriting computes HMAC-SHA256 signature of payload using shared secret key
2. Fair Underwriting includes signature in `X-FairUnderwriting-Signature` header
3. Partner recomputes HMAC-SHA256 signature of received payload
4. Partner compares computed signature with received signature—if match, webhook is authentic

**Example** (Node.js):

```javascript
const crypto = require('crypto');

function verifyWebhookSignature(payload, receivedSignature, secretKey) {
  const computedSignature =
    'sha256=' +
    crypto
      .createHmac('sha256', secretKey)
      .update(JSON.stringify(payload))
      .digest('hex');

  return crypto.timingSafeEqual(
    Buffer.from(computedSignature),
    Buffer.from(receivedSignature)
  );
}

// In webhook handler
app.post('/webhooks/fairunderwriting', (req, res) => {
  const payload = req.body;
  const receivedSignature = req.headers['x-fairunderwriting-signature'];
  const secretKey = process.env.FAIRUNDERWRITING_WEBHOOK_SECRET;

  if (!verifyWebhookSignature(payload, receivedSignature, secretKey)) {
    return res.status(401).json({ error: 'Invalid signature' });
  }

  // Process webhook
  console.log('Webhook received:', payload.event, payload.data);
  res.status(200).json({ received: true });
});
```

---

### 4.5 Webhook Retry Logic

**If Partner Returns Error** (500, 502, 503, timeout):

- Fair Underwriting retries webhook delivery (exponential backoff)
- **Retry Schedule**:
  - Attempt 1: Immediate
  - Attempt 2: 1 minute later
  - Attempt 3: 5 minutes later
  - Attempt 4: 15 minutes later
  - Attempt 5: 1 hour later
  - Give up after 5 attempts (alert Fair Underwriting engineering, email Partner IT)

**Partner Should Return 200 OK Quickly**:

- Acknowledge receipt (return 200 OK within 5 seconds)
- Process event asynchronously (queue job, don't block webhook response)

**Example** (Node.js):

```javascript
app.post('/webhooks/fairunderwriting', async (req, res) => {
  const payload = req.body;

  // Acknowledge receipt immediately
  res.status(200).json({ received: true });

  // Process asynchronously (don't block response)
  processWebhookAsync(payload);
});

async function processWebhookAsync(payload) {
  // Queue job, send email, update database, etc.
  await queue.add('process-fairunderwriting-webhook', payload);
}
```

---

## Section 5: Portal Embedding (White-Label Integration)

### 5.1 Portal Embedding Overview

**Purpose**: Embed Fair Underwriting portal in Partner's benefits website (seamless user experience—policyholder doesn't leave partner.com)

**Integration Methods**:

1. **iframe Embed** (simplest—embed Fair Underwriting portal in iframe on partner.com)
2. **JavaScript Widget** (medium complexity—Fair Underwriting provides JS widget, Partner includes on page)
3. **Native Integration** (most complex—Partner builds UI, calls Fair Underwriting API for data)

---

### 5.2 iframe Embed (Recommended)

**How It Works**:

1. Partner adds `<iframe>` tag to their benefits page
2. iframe loads Fair Underwriting portal (e.g., `https://fairunderwriting.com/embed/northwestern-mutual`)
3. Fair Underwriting portal detects Partner (via URL parameter or SSO), applies white-label branding

**HTML Example** (on partner.com):

```html
<h1>Your Genetic Testing Benefit</h1>
<p>
  Northwestern Mutual is proud to offer free genetic testing powered by Fair
  Underwriting.
</p>

<iframe
  src="https://fairunderwriting.com/embed/northwestern-mutual?sso_token=abc123"
  width="100%"
  height="800px"
  frameborder="0"
  allow="camera; microphone"
  sandbox="allow-scripts allow-same-origin allow-forms"
></iframe>
```

**White-Label Branding**:

- Fair Underwriting portal styled to match Partner's brand (colors, logo, fonts)
- Configuration in Fair Underwriting admin panel:
  - Primary color: `#003DA5` (Northwestern Mutual blue)
  - Logo: Upload Partner logo (displayed in portal header)
  - Font: `"Lato", sans-serif` (Partner's brand font)

**SSO Integration**:

- `sso_token` parameter (generated by Partner's backend after SSO authentication)
- Fair Underwriting validates token, logs user in (no separate login required)

**Responsive Design**:

- Fair Underwriting portal is mobile-responsive (works on desktop, tablet, mobile)
- iframe height auto-adjusts based on content (via postMessage API)

---

### 5.3 JavaScript Widget (Alternative)

**How It Works**:

1. Partner includes Fair Underwriting JavaScript snippet on their page
2. JavaScript widget renders Fair Underwriting UI (enrollment form, results, etc.) in specified `<div>`

**HTML Example** (on partner.com):

```html
<div id="fairunderwriting-widget"></div>

<script src="https://cdn.fairunderwriting.com/widget.js"></script>
<script>
  FairUnderwriting.init({
    partnerId: 'northwestern-mutual',
    container: '#fairunderwriting-widget',
    ssoToken: 'abc123', // Generated by Partner backend after SSO
    theme: {
      primaryColor: '#003DA5',
      logo: 'https://partner.com/logo.png'
    }
  });
</script>
```

**Benefits**:

- More flexible than iframe (Partner controls layout, can add custom elements)
- JavaScript can communicate with Partner's page (e.g., update enrollment count in Partner's UI)

**Drawbacks**:

- More complex (requires JavaScript integration, CSP configuration)
- Potential conflicts (Fair Underwriting's CSS/JS may conflict with Partner's)

---

### 5.4 Native Integration (Advanced)

**How It Works**:

1. Partner builds their own UI (enrollment form, results page, dashboard)
2. Partner calls Fair Underwriting API for data (eligibility, enrollment status, outcomes)
3. Partner displays data in their custom UI

**Benefits**:

- Full control over UX (Partner designs everything)
- Deeply integrated into Partner's benefits platform

**Drawbacks**:

- High complexity (Partner must build UI, handle state management, error handling)
- Long implementation time (12+ weeks vs. 1 week for iframe)
- Maintenance burden (Partner must update UI when Fair Underwriting changes APIs)

**Recommended For**: Enterprise partners with dedicated engineering teams, custom requirements

---

## Section 6: Implementation Timeline

### Pilot Partner Integration (Typical Timeline)

**Week 1-2: Kickoff & Discovery**

- Kickoff call (Fair Underwriting + Partner IT teams)
- Technical discovery (Partner's systems, authentication, data feeds)
- Define integration scope (SSO? SFTP? API? Portal embed?)
- Exchange credentials (API keys, SFTP keys, certificates)

**Week 3-4: SSO Integration**

- Partner provides IdP metadata (SAML or OAuth config)
- Fair Underwriting configures SSO (test with 5-10 Partner test users)
- UAT (User Acceptance Testing—Partner IT validates SSO login flow)

**Week 5-6: Data Feed Integration**

- Partner provides eligibility feed (CSV format, SFTP upload)
- Fair Underwriting validates feed, processes records
- Test round-trip (Partner uploads eligibility, Fair Underwriting returns enrollment/outcome feeds)

**Week 7-8: Portal Embedding (Optional)**

- Fair Underwriting provides iframe code, white-label branding
- Partner embeds iframe on benefits page
- UAT (Partner tests enrollment flow from their website)

**Week 9: Production Cutover**

- Enable SSO for all Partner users
- Start daily SFTP feeds (eligibility, enrollment, outcome)
- Launch portal embed on partner.com
- Monitor for issues (first 2 weeks—daily check-ins)

**Total: 9 weeks** (SSO + SFTP + Portal Embed)

**Faster Track** (if simpler integration):

- SSO only: 2-4 weeks
- SFTP only: 1-2 weeks
- Portal iframe only: 1 week

---

## Section 7: Testing & Validation

### 7.1 Integration Testing Checklist

**SSO Testing**:

- [ ] Test SSO login (user can log in with Partner credentials)
- [ ] Test SSO logout (user logs out of Fair Underwriting + Partner)
- [ ] Test SSO with multiple users (5-10 test accounts)
- [ ] Test SSO failure scenarios (invalid credentials, expired certificate, network timeout)
- [ ] Test user provisioning (new user auto-created on first login)

**SFTP Testing**:

- [ ] Test eligibility feed upload (Partner uploads file, Fair Underwriting processes)
- [ ] Test enrollment feed download (Fair Underwriting uploads file, Partner downloads)
- [ ] Test outcome feed download (Fair Underwriting uploads file, Partner downloads)
- [ ] Test file format validation (Fair Underwriting rejects invalid files)
- [ ] Test encryption (PGP-encrypted files can be decrypted)

**API Testing**:

- [ ] Test OAuth token generation (Partner can obtain access token)
- [ ] Test API endpoints (eligibility, enrollments, outcomes)
- [ ] Test authentication (invalid token returns 401)
- [ ] Test rate limiting (Partner gets 429 after 100 requests/minute)
- [ ] Test error handling (API returns proper error codes for invalid requests)

**Webhook Testing**:

- [ ] Test webhook delivery (Fair Underwriting sends event, Partner receives)
- [ ] Test HMAC signature verification (Partner validates signature)
- [ ] Test retry logic (Fair Underwriting retries if Partner returns 500)
- [ ] Test multiple event types (enrollment, result, subscription)

**Portal Embed Testing**:

- [ ] Test iframe embed (portal loads correctly on partner.com)
- [ ] Test white-label branding (Partner's colors, logo, fonts applied)
- [ ] Test SSO integration (user logged in automatically via iframe)
- [ ] Test responsive design (portal works on desktop, tablet, mobile)

---

### 7.2 UAT (User Acceptance Testing)

**UAT Participants**:

- Partner IT team (3-5 people)
- Fair Underwriting engineering (2-3 people)
- Fair Underwriting customer success (1 person—document issues, coordinate resolution)

**UAT Process**:

1. **Test Scripts**: Fair Underwriting provides test scripts (step-by-step instructions for testing each integration)
2. **Execution**: Partner IT team executes test scripts, logs issues in shared tracker (Jira, Asana)
3. **Issue Resolution**: Fair Underwriting fixes issues, Partner re-tests
4. **Sign-Off**: Partner IT approves integration (all tests pass, issues resolved)

**UAT Duration**: 1-2 weeks (depending on integration complexity)

---

### 7.3 Production Monitoring

**Post-Launch Monitoring** (first 2 weeks):

- Daily check-ins (Fair Underwriting + Partner IT—review metrics, issues)
- Monitor SSO success rate (target: >99%)
- Monitor SFTP file processing (target: 100% success)
- Monitor API error rates (target: <1%)
- Monitor webhook delivery (target: >99%)

**Ongoing Monitoring**:

- Weekly check-ins (first month)
- Monthly check-ins (after first month)
- Quarterly business reviews (QBRs—review integration health, discuss enhancements)

---

## Conclusion

This **Integration Specifications** document provides Fair Underwriting with:

- **SSO Integration** (SAML 2.0, OAuth 2.0—2-4 weeks setup)
- **Data Feeds** (SFTP batch files for eligibility, enrollment, outcomes—1-2 weeks setup)
- **REST API** (Real-time access to Fair Underwriting data—4-8 weeks setup)
- **Webhooks** (Event-driven notifications—2-3 weeks setup)
- **Portal Embedding** (iframe, JavaScript widget, native—1-12 weeks depending on complexity)
- **Implementation Timeline** (typical pilot: 9 weeks SSO + SFTP + Portal)
- **Testing & Validation** (UAT checklist, production monitoring)

**Top 3 Integration Priorities (Pilot Partners)**:

1. **SSO (SAML 2.0)**: Enable one-click login from Partner portal (critical for UX)
2. **SFTP Data Feeds**: Daily batch exchange for eligibility, enrollment, outcomes (critical for reporting)
3. **Portal iframe Embed**: Embed Fair Underwriting portal on partner.com (nice-to-have, improves UX)

**Success Metrics**:

- SSO success rate: >99% (user can log in without errors)
- SFTP file processing: 100% success (no missed files, no data errors)
- Portal embed load time: <2 seconds (fast, seamless UX)
- Partner satisfaction: 8/10 or higher (integration is smooth, well-documented)

---

**Document Owner**: CTO + VP Engineering + Partner Success Team
**Review Frequency**: Quarterly (update based on new integration patterns, partner feedback)
**Last Updated**: November 7, 2025
**Next Review**: February 7, 2026
