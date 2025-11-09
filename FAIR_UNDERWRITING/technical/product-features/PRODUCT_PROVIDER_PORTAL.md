# Feature #8: Provider Portal & White-Label Solution

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 backend developer, 1 frontend developer, 1 DevOps engineer, 1 designer

---

## Executive Summary

Fair Underwriting partners with insurance companies and health systems that want to offer AATD testing to their members. Currently, these partners have no visibility into their program's performance or ability to customize the user experience. This feature builds a comprehensive provider portal and white-label solution that allows partners to manage their programs, customize branding, and access detailed analytics.

**Key Value Propositions**:

- **Partner Self-Service**: Partners manage their own programs without Fair Underwriting intervention
- **White-Label Branding**: Custom logos, colors, domains (e.g., aatd.acmeinsurance.com)
- **Program Analytics**: Real-time dashboards showing enrollment, completion rates, ROI
- **Member Management**: Invite employees, track testing status, send reminders
- **Customizable Workflows**: Partners configure their own testing protocols, consent forms
- **API Access**: Programmatic access for enterprise integrations

**Business Impact**:

- Reduce partner onboarding time from 6 weeks to 3 days
- Increase partner retention by 35% (self-service reduces friction)
- Enable enterprise sales: 50+ employee programs require white-label
- Reduce support burden by 60% for partner-related questions
- New revenue stream: $2,500-10,000/month white-label fees

---

## Problem Statement

### Current Gaps

**Scenario 1: Insurance Partner Wants Program Visibility**

> "We launched an AATD testing program for our 5,000 employees 3 months ago. How many signed up? How many completed testing? What genotypes were found? I have to email Fair Underwriting's support team and wait 3 days for a manual Excel report."

**No self-service partner dashboard** ❌

**Scenario 2: Health System Needs Branded Experience**

> "We're a major health system. We can't send our patients to 'fairunderwriting.com' — we need the testing portal to look like it's part of our health system. Custom domain, our logo, our brand colors."

**No white-label capability** ❌

**Scenario 3: Enterprise Client Requires SSO**

> "We have 10,000 employees. We can't have them create yet another username/password. We need SAML SSO integration with our corporate identity provider (Okta)."

**No enterprise SSO support** ❌

**Scenario 4: Partner Wants Custom Consent Forms**

> "Our legal team requires specific consent language for our state. We need to customize the consent forms our employees see during testing registration."

**No customizable workflows or forms** ❌

**Scenario 5: Bulk Employee Enrollment**

> "We want to invite 5,000 employees at once via CSV upload. Currently, we have to manually send individual invite links."

**No bulk enrollment tools** ❌

---

## Feature Specifications

### 1. Partner Portal Architecture

**Multi-Tenant Hierarchy**:

```
┌─────────────────────────────────────────────────────────────┐
│  Fair Underwriting Platform (Platform Tenant)               │
│  - Super admin access                                        │
│  - Manages all partners                                      │
│  - Billing & subscriptions                                   │
└───────────────────┬─────────────────────────────────────────┘
                    │
        ┌───────────┼───────────┐
        │           │           │
┌───────▼──────┐ ┌──▼───────┐ ┌▼──────────────┐
│ Acme Ins.    │ │ HealthCo │ │ MegaCorp      │
│ (Partner)    │ │ (Partner)│ │ (Partner)     │
│              │ │          │ │               │
│ 5,000 empl.  │ │ 800 pts  │ │ 15,000 empl.  │
└──────┬───────┘ └──┬───────┘ └───┬───────────┘
       │            │              │
   ┌───┼────────┐   │          ┌───┼────────┐
   │   │        │   │          │   │        │
┌──▼───▼──┐ ┌──▼───▼──┐    ┌──▼───▼──┐ ┌───▼────┐
│Employee │ │Employee │    │Employee │ │Employee│
│(End User│ │(End User│    │(End User│ │        │
└─────────┘ └─────────┘    └─────────┘ └────────┘
```

**Access Levels**:

1. **Platform Admin** (Fair Underwriting): Manage all partners, billing, platform configuration
2. **Partner Admin**: Manage their organization, view all employees, configure branding
3. **Partner User** (HR, Benefits Manager): View reports, invite employees, no configuration access
4. **End User** (Employee/Patient): Testing, results, health management

### 2. Database Schema

```sql
-- Partner organizations (extends existing tenants table)
CREATE TABLE partner_organizations (
  tenant_id UUID PRIMARY KEY,

  -- Organization info
  organization_name VARCHAR(200) NOT NULL,
  organization_type VARCHAR(50), -- 'insurance_company', 'health_system', 'employer', 'government'
  industry VARCHAR(50),
  employee_count INTEGER,

  -- Program details
  program_name VARCHAR(200), -- "Acme AATD Wellness Program"
  program_start_date DATE,
  program_end_date DATE,

  -- Subscription
  subscription_tier VARCHAR(50), -- 'basic', 'professional', 'enterprise'
  white_label_enabled BOOLEAN DEFAULT false,
  api_access_enabled BOOLEAN DEFAULT false,
  sso_enabled BOOLEAN DEFAULT false,

  -- Limits
  max_test_invitations INTEGER, -- Contracted number of tests
  invitations_used INTEGER DEFAULT 0,
  overage_allowed BOOLEAN DEFAULT false,

  -- Branding (white-label)
  custom_domain VARCHAR(200), -- 'aatd.acmeinsurance.com'
  logo_url TEXT,
  favicon_url TEXT,
  primary_color VARCHAR(7), -- Hex color #FF5733
  secondary_color VARCHAR(7),
  custom_css TEXT, -- Advanced customization

  -- Contact
  primary_contact_name VARCHAR(200),
  primary_contact_email VARCHAR(200),
  primary_contact_phone VARCHAR(20),
  billing_email VARCHAR(200),

  -- Settings
  auto_reminder_enabled BOOLEAN DEFAULT true,
  reminder_frequency_days INTEGER DEFAULT 7,
  require_custom_consent BOOLEAN DEFAULT false,
  custom_consent_text TEXT,

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'trial', 'active', 'suspended', 'cancelled'

  -- Metadata
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Partner users (HR, benefits managers)
CREATE TABLE partner_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  user_id UUID NOT NULL, -- References main users table

  -- Role
  role VARCHAR(50) NOT NULL, -- 'partner_admin', 'partner_user', 'partner_readonly'

  -- Permissions
  can_invite_members BOOLEAN DEFAULT true,
  can_view_reports BOOLEAN DEFAULT true,
  can_configure_branding BOOLEAN DEFAULT false,
  can_manage_users BOOLEAN DEFAULT false,
  can_export_data BOOLEAN DEFAULT false,

  -- Status
  status VARCHAR(20) DEFAULT 'active',
  invited_at TIMESTAMPTZ DEFAULT NOW(),
  activated_at TIMESTAMPTZ,
  last_login_at TIMESTAMPTZ,

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Employee invitations
CREATE TABLE employee_invitations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Invitee info
  email VARCHAR(200) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  employee_id VARCHAR(100), -- Partner's internal employee ID
  department VARCHAR(100),

  -- Invitation
  invitation_code VARCHAR(50) UNIQUE, -- Short code: 'ACME-2025-ABC123'
  invitation_url TEXT, -- Full URL with code
  invited_by_user_id UUID, -- Partner user who sent invite

  -- Status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'accepted', 'test_completed', 'expired'
  sent_at TIMESTAMPTZ DEFAULT NOW(),
  accepted_at TIMESTAMPTZ,
  test_ordered_at TIMESTAMPTZ,
  test_completed_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ, -- 90 days default

  -- Reminders
  reminder_count INTEGER DEFAULT 0,
  last_reminder_sent_at TIMESTAMPTZ,

  -- Linked user (after accepting)
  user_id UUID,

  -- Metadata
  custom_fields JSONB, -- Partner-specific data

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id),
  FOREIGN KEY (invited_by_user_id) REFERENCES users(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_employee_invitations_tenant ON employee_invitations(tenant_id, status);
CREATE INDEX idx_employee_invitations_email ON employee_invitations(email);
CREATE INDEX idx_employee_invitations_code ON employee_invitations(invitation_code);

-- Bulk upload jobs
CREATE TABLE bulk_invitation_jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  created_by_user_id UUID NOT NULL,

  -- Upload details
  filename VARCHAR(200),
  file_url TEXT, -- S3 URL to CSV
  total_rows INTEGER,

  -- Processing status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'processing', 'completed', 'failed'
  processed_rows INTEGER DEFAULT 0,
  successful_invitations INTEGER DEFAULT 0,
  failed_rows INTEGER DEFAULT 0,
  error_log JSONB, -- {row_number: "error message"}

  -- Results
  results_file_url TEXT, -- CSV with success/failure for each row

  -- Timing
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id),
  FOREIGN KEY (created_by_user_id) REFERENCES users(id)
);

-- SSO configuration
CREATE TABLE partner_sso_config (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL UNIQUE,

  -- SSO type
  sso_type VARCHAR(20) NOT NULL, -- 'saml', 'oidc', 'oauth2'

  -- SAML configuration
  saml_entity_id TEXT,
  saml_sso_url TEXT, -- Identity provider SSO URL
  saml_certificate TEXT, -- X.509 certificate
  saml_sign_requests BOOLEAN DEFAULT true,

  -- OIDC configuration
  oidc_issuer_url TEXT,
  oidc_client_id TEXT,
  oidc_client_secret TEXT, -- Encrypted
  oidc_scopes TEXT[], -- ['openid', 'email', 'profile']

  -- Attribute mapping
  email_attribute VARCHAR(100) DEFAULT 'email',
  first_name_attribute VARCHAR(100) DEFAULT 'firstName',
  last_name_attribute VARCHAR(100) DEFAULT 'lastName',
  employee_id_attribute VARCHAR(100),

  -- Settings
  auto_provision_users BOOLEAN DEFAULT true, -- Create user on first SSO login
  require_sso BOOLEAN DEFAULT false, -- Disable password login

  -- Status
  enabled BOOLEAN DEFAULT false,
  last_tested_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id)
);

-- API keys for partners
CREATE TABLE partner_api_keys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Key
  key_name VARCHAR(200), -- "Production API Key", "Staging Key"
  api_key_hash VARCHAR(200) NOT NULL, -- Hashed API key
  api_key_prefix VARCHAR(20), -- First 8 chars for identification: 'pk_live_...'

  -- Permissions
  scopes TEXT[], -- ['read:members', 'write:invitations', 'read:results']
  rate_limit_per_minute INTEGER DEFAULT 100,

  -- IP whitelist (optional)
  allowed_ips TEXT[],

  -- Status
  status VARCHAR(20) DEFAULT 'active', -- 'active', 'revoked', 'expired'
  created_by_user_id UUID NOT NULL,
  last_used_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id),
  FOREIGN KEY (created_by_user_id) REFERENCES users(id)
);

CREATE INDEX idx_partner_api_keys_tenant ON partner_api_keys(tenant_id, status);
CREATE INDEX idx_partner_api_keys_prefix ON partner_api_keys(api_key_prefix);

-- Partner analytics cache (pre-computed for performance)
CREATE TABLE partner_analytics_cache (
  tenant_id UUID PRIMARY KEY,

  -- Enrollment metrics
  total_invitations_sent INTEGER DEFAULT 0,
  invitations_accepted INTEGER DEFAULT 0,
  acceptance_rate DECIMAL(5, 2), -- %

  -- Testing metrics
  tests_ordered INTEGER DEFAULT 0,
  tests_completed INTEGER DEFAULT 0,
  completion_rate DECIMAL(5, 2), -- %
  avg_turnaround_time_days DECIMAL(5, 2),

  -- Results breakdown
  normal_results INTEGER DEFAULT 0, -- MM
  carrier_results INTEGER DEFAULT 0, -- MZ, MS, SZ
  deficient_results INTEGER DEFAULT 0, -- ZZ, SS

  -- Engagement
  active_users_30_days INTEGER DEFAULT 0,
  avg_logins_per_user DECIMAL(5, 2),

  -- Financial
  total_program_cost DECIMAL(12, 2),
  estimated_cost_savings DECIMAL(12, 2),
  roi_percentage DECIMAL(5, 2),

  -- Updated timestamp
  last_updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES partner_organizations(tenant_id)
);
```

### 3. Partner Portal UI

**Dashboard**:

```
┌─────────────────────────────────────────────────────────────────┐
│  [Acme Insurance Logo]    AATD Wellness Program        👤 Admin │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  📊 PROGRAM OVERVIEW                                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Program Start: January 1, 2025                           │  │
│  │  Program Duration: 240 days active                        │  │
│  │  Contracted Tests: 5,000    Used: 2,847 (57%)            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  📈 KEY METRICS                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐           │
│  │ Invitations │  │ Accepted    │  │ Tests Done  │           │
│  │   4,200     │  │   2,950     │  │   2,800     │           │
│  │   (84%)     │  │   (70%)     │  │   (95%)     │           │
│  └─────────────┘  └─────────────┘  └─────────────┘           │
│                                                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐           │
│  │ MZ Carriers │  │ ZZ Defic.   │  │ ROI         │           │
│  │   224       │  │   18        │  │   +220%     │           │
│  │   (8.0%)    │  │   (0.6%)    │  │   $1.8M     │           │
│  └─────────────┘  └─────────────┘  └─────────────┘           │
│                                                                  │
│  📊 ENROLLMENT FUNNEL                                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Invited                    ████████████████████ 4,200    │  │
│  │ Accepted                   ██████████████       2,950    │  │
│  │ Ordered Test               █████████████        2,847    │  │
│  │ Sample Collected           █████████████        2,805    │  │
│  │ Results Received           █████████████        2,800    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🧬 GENOTYPE BREAKDOWN                                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  MM (Normal):    2,548  ████████████████████████  91.0%  │  │
│  │  MZ (Carrier):     224  ██                         8.0%  │  │
│  │  ZZ (Deficient):    18  ▌                          0.6%  │  │
│  │  Other (MS/SZ/SS):  10  ▌                          0.4%  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  🚀 QUICK ACTIONS                                               │
│  [Invite Employees] [View Reports] [Export Data] [Settings]    │
│                                                                  │
│  📅 RECENT ACTIVITY                                             │
│  • 15 new test results today                                    │
│  • 42 invitations sent this week                                │
│  • 8 employees completed testing yesterday                      │
│  • Next reminder batch: Tomorrow 9:00 AM                        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Employee Management**:

```
┌─────────────────────────────────────────────────────────────────┐
│  👥 Employee Management                                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Search employees...] [Filter ▼] [Bulk Upload] [Export CSV]   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Name           │ Email          │ Status      │ Genotype │  │
│  ├────────────────┼────────────────┼─────────────┼──────────┤  │
│  │ John Doe       │ jdoe@acme.com  │ ✅ Complete │ MM       │  │
│  │ Jane Smith     │ jsmith@...     │ ✅ Complete │ MZ ⚠️    │  │
│  │ Bob Johnson    │ bjohnson@...   │ 🕒 Pending  │ -        │  │
│  │ Alice Brown    │ abrown@...     │ ✅ Complete │ ZZ 🚨    │  │
│  │ Charlie Davis  │ cdavis@...     │ ❌ Expired  │ -        │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  💡 ACTIONS                                                     │
│  • Select employees → [Send Reminder] [Resend Invitation]       │
│  • High-risk employees (MZ/ZZ) → [Schedule Consultation]        │
│  • Expired invitations → [Extend Deadline]                      │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Bulk Upload Flow**:

```
Step 1: Upload CSV
┌─────────────────────────────────────────────────────────────────┐
│  📄 Upload Employee List                                         │
│                                                                  │
│  Download CSV template: [employee_invite_template.csv]          │
│                                                                  │
│  Required columns:                                               │
│  • email (required)                                              │
│  • first_name (optional)                                         │
│  • last_name (optional)                                          │
│  • employee_id (optional)                                        │
│  • department (optional)                                         │
│                                                                  │
│  [Drag & Drop CSV or Click to Upload]                           │
│                                                                  │
│  [Next: Review →]                                                │
└─────────────────────────────────────────────────────────────────┘

Step 2: Review & Validate
┌─────────────────────────────────────────────────────────────────┐
│  ✅ Validation Results                                           │
│                                                                  │
│  Total rows: 5,000                                               │
│  ✅ Valid: 4,950                                                 │
│  ⚠️  Warnings: 30 (already invited)                              │
│  ❌ Errors: 20 (invalid email format)                            │
│                                                                  │
│  [View Errors] [Download Error Report]                           │
│                                                                  │
│  Proceed with 4,950 valid invitations?                           │
│  [Cancel] [Send Invitations →]                                   │
└─────────────────────────────────────────────────────────────────┘

Step 3: Sending
┌─────────────────────────────────────────────────────────────────┐
│  📧 Sending Invitations...                                       │
│                                                                  │
│  Progress: 2,475 / 4,950 (50%)                                   │
│  ████████████████████░░░░░░░░░░░░░░░░░░░░                      │
│                                                                  │
│  Est. time remaining: 3 minutes                                  │
│                                                                  │
│  You can close this window. We'll email you when complete.      │
└─────────────────────────────────────────────────────────────────┘

Step 4: Complete
┌─────────────────────────────────────────────────────────────────┐
│  ✅ Invitations Sent Successfully!                               │
│                                                                  │
│  Successfully sent: 4,950 invitations                            │
│  Failed: 0                                                       │
│                                                                  │
│  [Download Results CSV] [Return to Dashboard]                    │
└─────────────────────────────────────────────────────────────────┘
```

### 4. White-Label Branding

**Branding Configuration UI**:

```
┌─────────────────────────────────────────────────────────────────┐
│  🎨 White-Label Branding                                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  CUSTOM DOMAIN                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ https:// [aatd.acmeinsurance.com] /.....                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ℹ️  Add CNAME record: aatd.acmeinsurance.com → fw.velox.ai    │
│  Status: ✅ SSL certificate active                              │
│                                                                  │
│  LOGO & FAVICON                                                  │
│  ┌──────────────────────┐  ┌──────────────────────┐            │
│  │ Company Logo         │  │ Favicon              │            │
│  │                      │  │                      │            │
│  │  [Upload Logo]       │  │  [Upload Favicon]    │            │
│  │  (Recommended:       │  │  (32×32 px PNG)      │            │
│  │   200×50 px PNG)     │  │                      │            │
│  └──────────────────────┘  └──────────────────────┘            │
│                                                                  │
│  BRAND COLORS                                                    │
│  Primary Color:   [#FF5733] ████                                │
│  Secondary Color: [#3357FF] ████                                │
│                                                                  │
│  PREVIEW                                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ [Your Logo]                              Sign In | Help   │  │
│  │                                                            │  │
│  │         Welcome to Acme AATD Wellness Program             │  │
│  │                                                            │  │
│  │         [Get Started →]  (in your primary color)          │  │
│  │                                                            │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  [Save Changes] [Reset to Defaults]                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**White-Label Features**:

1. **Custom Domain**:
   - Partner provides domain (e.g., `aatd.acmeinsurance.com`)
   - Fair Underwriting provides CNAME target
   - Auto-provision SSL certificate (Let's Encrypt)
   - Custom email sender domain (`noreply@acmeinsurance.com`)

2. **Branding Elements**:
   - Custom logo (header, footer, emails)
   - Favicon
   - Primary/secondary brand colors
   - Custom CSS for advanced styling
   - Custom email templates

3. **Content Customization**:
   - Custom welcome message
   - Custom consent forms (legal requirements)
   - Custom privacy policy link
   - Custom support contact info

4. **Subdomain Structure**:
   ```
   https://aatd.acmeinsurance.com/
   ├─ /login          (custom branded)
   ├─ /register       (custom branded)
   ├─ /dashboard      (custom branded)
   ├─ /testing        (custom branded)
   └─ /results        (custom branded)
   ```

### 5. SSO Integration

**SAML 2.0 Flow**:

```
User → Partner Portal → Acme IdP (Okta) → Fair Underwriting
  │                         │                      │
  │                         │                      │
  │  1. Click "Sign In"     │                      │
  ├────────────────────────►│                      │
  │                         │                      │
  │  2. Redirect to Okta    │                      │
  │◄────────────────────────┤                      │
  │                         │                      │
  │  3. Authenticate        │                      │
  ├────────────────────────►│                      │
  │                         │                      │
  │  4. SAML Assertion      │                      │
  │◄────────────────────────┤                      │
  │                         │                      │
  │  5. POST Assertion      │                      │
  ├─────────────────────────────────────────────────►
  │                         │                      │
  │  6. Validate & Create Session                  │
  │                         │                      ├─ Verify signature
  │                         │                      ├─ Extract attributes
  │                         │                      ├─ Auto-provision user
  │                         │                      └─ Create session
  │                         │                      │
  │  7. Redirect to Dashboard                      │
  │◄─────────────────────────────────────────────────
  │                         │                      │
```

**SSO Configuration Example**:

```typescript
interface SAMLConfig {
  tenantId: string;
  entityId: string; // 'https://aatd.acmeinsurance.com/saml/metadata'
  ssoUrl: string; // Okta SSO URL
  certificate: string; // X.509 cert for signature validation
  signRequests: boolean;

  // Attribute mapping
  emailAttribute: string; // 'email' or 'urn:oid:0.9.2342.19200300.100.1.3'
  firstNameAttribute: string; // 'firstName'
  lastNameAttribute: string; // 'lastName'
  employeeIdAttribute: string; // 'employeeId'

  // User provisioning
  autoProvisionUsers: boolean; // Create user on first SSO login
  requireSso: boolean; // Disable password auth
}

class SAMLAuthService {
  async handleSAMLResponse(
    samlResponse: string,
    tenantId: string
  ): Promise<User> {
    const config = await this.getSAMLConfig(tenantId);

    // 1. Parse SAML assertion
    const assertion = this.parseSAMLAssertion(samlResponse);

    // 2. Verify signature
    const isValid = this.verifySignature(assertion, config.certificate);
    if (!isValid) {
      throw new Error('Invalid SAML signature');
    }

    // 3. Check assertion expiration
    if (assertion.notAfter < new Date()) {
      throw new Error('SAML assertion expired');
    }

    // 4. Extract user attributes
    const email = assertion.attributes[config.emailAttribute];
    const firstName = assertion.attributes[config.firstNameAttribute];
    const lastName = assertion.attributes[config.lastNameAttribute];
    const employeeId = assertion.attributes[config.employeeIdAttribute];

    // 5. Find or create user
    let user = await this.findUserByEmail(email, tenantId);

    if (!user && config.autoProvisionUsers) {
      user = await this.createUser({
        email,
        firstName,
        lastName,
        employeeId,
        tenantId,
        authMethod: 'saml'
      });
    }

    if (!user) {
      throw new Error('User not found and auto-provisioning disabled');
    }

    // 6. Log SSO event
    await this.logSSOEvent({
      userId: user.id,
      tenantId,
      method: 'saml',
      success: true
    });

    return user;
  }
}
```

### 6. Partner API

**RESTful API for Programmatic Access**:

```typescript
// Authentication: API Key in header
// X-API-Key: pk_live_abc123...

// POST /api/v1/partner/invitations - Send invitation
interface SendInvitationRequest {
  Body: {
    email: string;
    firstName?: string;
    lastName?: string;
    employeeId?: string;
    department?: string;
    customFields?: Record<string, any>;
  };
}

interface SendInvitationResponse {
  success: boolean;
  invitation: {
    id: string;
    email: string;
    invitationCode: string;
    invitationUrl: string;
    status: 'pending';
    expiresAt: string;
  };
}

// GET /api/v1/partner/invitations/:id - Get invitation status
interface GetInvitationStatusResponse {
  invitation: {
    id: string;
    email: string;
    status: 'pending' | 'accepted' | 'test_completed' | 'expired';
    sentAt: string;
    acceptedAt?: string;
    testCompletedAt?: string;

    // If completed
    testResult?: {
      genotype: string;
      riskCategory: string;
      resultDate: string;
    };
  };
}

// POST /api/v1/partner/invitations/bulk - Bulk invite
interface BulkInviteRequest {
  Body: {
    invitations: {
      email: string;
      firstName?: string;
      lastName?: string;
      employeeId?: string;
    }[];
  };
}

interface BulkInviteResponse {
  jobId: string;
  status: 'processing';
  totalInvitations: number;
  estimatedCompletionSeconds: number;
}

// GET /api/v1/partner/analytics - Get program analytics
interface PartnerAnalyticsResponse {
  program: {
    startDate: string;
    daysActive: number;
    contractedTests: number;
    usedTests: number;
  };

  enrollment: {
    invitationsSent: number;
    invitationsAccepted: number;
    acceptanceRate: number;
  };

  testing: {
    testsOrdered: number;
    testsCompleted: number;
    completionRate: number;
    avgTurnaroundTimeDays: number;
  };

  results: {
    normal: number; // MM
    carriers: number; // MZ, MS, SZ
    deficient: number; // ZZ, SS
  };

  roi: {
    programCost: number;
    estimatedSavings: number;
    roiPercentage: number;
  };
}

// GET /api/v1/partner/members - List members
interface ListMembersRequest {
  Querystring: {
    status?: 'pending' | 'accepted' | 'test_completed';
    page?: number;
    limit?: number;
  };
}

interface ListMembersResponse {
  members: {
    id: string;
    email: string;
    firstName: string;
    lastName: string;
    employeeId: string;
    status: string;
    invitedAt: string;
    testCompletedAt?: string;
    genotype?: string; // Only if consented to share
  }[];
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
}

// Webhook: Test completion notification
interface WebhookTestCompletedEvent {
  event: 'test.completed';
  timestamp: string;
  data: {
    invitationId: string;
    userId: string;
    email: string;
    employeeId: string;
    testCompletedAt: string;
    genotype: string;
    riskCategory: 'normal' | 'carrier' | 'deficient';
  };
}
```

**API Rate Limits**:

- Basic tier: 100 requests/minute
- Professional tier: 500 requests/minute
- Enterprise tier: 2,000 requests/minute

### 7. Automated Reminders

**Reminder System**:

```typescript
interface ReminderConfig {
  enabled: boolean;
  frequencyDays: number; // Send reminder every N days
  maxReminders: number; // Max 3 reminders
  reminderTemplates: {
    firstReminder: string; // Email template ID
    secondReminder: string;
    finalReminder: string;
  };
}

class InvitationReminderService {
  async sendReminders() {
    // Find pending invitations needing reminders
    const pendingInvitations = await this.query(`
      SELECT * FROM employee_invitations
      WHERE status = 'pending'
      AND expires_at > NOW()
      AND reminder_count < 3
      AND (
        last_reminder_sent_at IS NULL
        OR last_reminder_sent_at < NOW() - INTERVAL '7 days'
      )
    `);

    for (const invitation of pendingInvitations) {
      const reminderNumber = invitation.reminder_count + 1;

      // Determine template
      let template = 'reminder_generic';
      if (reminderNumber === 1) template = 'reminder_first';
      if (reminderNumber === 2) template = 'reminder_second';
      if (reminderNumber === 3) template = 'reminder_final';

      // Send email
      await this.sendEmail({
        to: invitation.email,
        template,
        variables: {
          firstName: invitation.first_name,
          invitationUrl: invitation.invitation_url,
          expiresAt: invitation.expires_at,
          partnerName: invitation.partner_name
        }
      });

      // Update reminder count
      await this.query(
        `
        UPDATE employee_invitations
        SET reminder_count = reminder_count + 1,
            last_reminder_sent_at = NOW()
        WHERE id = $1
      `,
        [invitation.id]
      );
    }
  }
}

// Run daily via cron
// 0 9 * * * - Every day at 9 AM
```

---

## Success Metrics

### Partner Adoption

- **Partner Onboarding Time**: Reduced from 6 weeks to 3 days
- **Partner Portal DAU**: 75% of partners log in weekly
- **API Usage**: 40% of enterprise partners use API integrations
- **White-Label Adoption**: 60% of 50+ employee programs use white-label

### Partner Satisfaction

- **Partner NPS**: 65+ (promoter score)
- **Support Ticket Reduction**: 60% fewer partner support requests
- **Partner Retention**: 95% annual retention (up from 70%)
- **Partner Referrals**: 35% of new partners come from referrals

### Program Performance

- **Invitation Acceptance Rate**: 72% (industry: 45-55%)
- **Test Completion Rate**: 94% of accepted invitations
- **Time to First Invitation**: < 24 hours after partner onboarding

### Business Impact

- **Enterprise Deals**: 15 new enterprise contracts ($100K+ each)
- **White-Label Revenue**: $150K/year in white-label fees
- **API Revenue**: $75K/year in API overage fees
- **Partner LTV**: +40% increase

---

## Budget Estimate

### Development (4-5 months)

- **Backend Developer** (APIs, SSO, multi-tenancy): $140K/year × 0.42 years = $58,800
- **Frontend Developer** (partner portal UI): $140K/year × 0.42 years = $58,800
- **DevOps Engineer** (white-label domains, SSL, SSO): $150K/year × 0.25 years = $37,500
- **Designer** (white-label branding system): $120K/year × 0.17 years = $20,400

**Total Development**: ~$175,500

### Annual Infrastructure

- **SSL Certificates** (Let's Encrypt automated): Free
- **Domain Management** (Route53): $50/month × 12 = $600
- **CDN** (CloudFront for white-label assets): $150/month × 12 = $1,800
- **Email Service** (custom sender domains): $100/month × 12 = $1,200
- **Monitoring** (partner portal uptime): $50/month × 12 = $600

**Total Infrastructure**: ~$4,200/year

### Annual Operations

- **Partner Success Manager** (onboarding, training): $85K/year
- **Partner Support** (dedicated support for partners): $60K/year

**Total Operations**: ~$145,000/year

### **GRAND TOTAL (First Year)**: ~$324,700

### **Ongoing (Year 2+)**: ~$149,200/year (operations + infrastructure)

### **Revenue Potential**:

- White-label fees: $2,500-10,000/month per partner × 15 partners = ~$150K/year
- API overage fees: ~$75K/year
- **Total New Revenue**: ~$225K/year

### **NET COST (First Year)**: ~$99,700 ($324,700 - $225K revenue)

---

## Risks & Mitigations

### Risk 1: SSO Integration Complexity

**Impact**: Each enterprise has unique SSO requirements (Okta, Azure AD, Ping, etc.)
**Mitigation**: Start with SAML 2.0 (most common), outsource to Auth0/WorkOS for multi-IdP support

### Risk 2: White-Label Performance Issues

**Impact**: Custom domains cause DNS/SSL issues, slow page loads
**Mitigation**: Automated SSL provisioning, CloudFront CDN, extensive testing

### Risk 3: Data Isolation

**Impact**: Partner A accidentally sees Partner B's data (security breach)
**Mitigation**: Strict tenant filtering in all queries, automated security audits, row-level security

### Risk 4: API Abuse

**Impact**: Partners exceed rate limits, abuse API for scraping
**Mitigation**: Rate limiting, IP whitelisting, API usage monitoring, billing for overages

### Risk 5: Partner Churn

**Impact**: Partners cancel after expensive onboarding
**Mitigation**: Annual contracts, training/documentation, dedicated partner success manager

---

**Document Owner**: VP Product, Head of Partnerships
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
