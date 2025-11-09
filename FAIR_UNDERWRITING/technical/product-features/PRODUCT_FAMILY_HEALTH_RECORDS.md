# Feature #3: Family Health Management

**Category**: Critical Missing Feature
**Priority**: Phase 1 (MVP - Must Have)
**Status**: Not Started
**Estimated Effort**: 2-3 months
**Team Required**: 1 backend developer, 1 frontend developer, 1 genetic counselor (advisor)

---

## Executive Summary

Family health management is critical for genetic conditions like AATD because inheritance patterns directly affect family members. When one person tests positive for PiMZ or PiZZ genotype, their siblings have a 25-50% chance of also carrying the mutation. Fair Underwriting needs cascade testing workflows, family tree visualization, and multi-member account management to maximize early detection.

**Key Value Propositions**:

- **Cascade Testing**: When one family member tests positive, easily invite and test relatives
- **Family Tree Visualization**: See inheritance patterns at a glance
- **Multi-Member Accounts**: Parents manage children's results, caregivers manage elderly parents
- **Family Discounts**: Incentivize family-wide testing (3+ members get 20% off)
- **Shared Insights**: Understand family risk patterns without violating individual privacy

**Business Impact**:

- Increase customer LTV by 3-5x (one positive case → 3-5 family members test)
- Improve detection rates (family screening finds 10x more cases than random screening)
- Strengthen partner ROI (insurance companies benefit from early detection across families)

---

## Problem Statement

### Current Gaps

**Scenario 1: Adult discovers MZ genotype**

> "I just found out I'm an MZ carrier with elevated COPD risk. My two siblings and three kids should also get tested. How do I:
>
> - Explain to them why they should test?
> - Help them register without revealing my specific results?
> - Track who has been tested?
> - Share relevant educational materials?"

**Currently impossible** ❌

**Scenario 2: Parent managing children's health**

> "My 8-year-old daughter was diagnosed with PiSZ genotype (mild AATD). I need to:
>
> - View her test results and track trends
> - Schedule her annual follow-up tests
> - Receive notifications about her results
> - Share results with her pediatrician
> - Ensure her results stay private from insurance until she's 18"

**Currently impossible** ❌

**Scenario 3: Adult child caring for aging parent**

> "My 75-year-old father has PiZZ AATD and receives monthly AAT infusions. I'm his primary caregiver. I need to:
>
> - Access his test results and medication schedule
> - Get alerts when his AAT levels are abnormal
> - Communicate with his pulmonologist
> - Coordinate care with my siblings"

**Currently impossible** ❌

---

## User Stories

### As a Primary Account Holder (Index Case)

**US-1**: As an MZ carrier, I want to invite my siblings to get tested so they can assess their own risk

- **Acceptance Criteria**:
  - Can generate unique invitation links for up to 10 family members
  - Invitation explains why testing is recommended (without revealing my results)
  - Can track invitation status (sent, opened, test ordered, results received)
  - Invitation includes family discount code (20% off if 3+ test)

**US-2**: As a parent, I want to view and manage my minor children's test results

- **Acceptance Criteria**:
  - Can add children under 18 to my account
  - View their test results in separate profiles
  - Receive notifications about their results
  - Schedule tests on their behalf
  - Children automatically get their own login at age 18

**US-3**: As an adult, I want to grant my spouse access to view (but not modify) my results

- **Acceptance Criteria**:
  - Can grant "view-only" access to specific family members
  - Can revoke access at any time
  - Access is logged in audit trail
  - Spouse receives email notification when I share access

### As a Family Member (Invited)

**US-4**: As a sibling of someone with AATD, I want to understand why I should get tested

- **Acceptance Criteria**:
  - Invitation email includes educational content about AATD inheritance
  - Can view family risk calculator (based on index case's genotype)
  - Can schedule free genetic counseling consultation before deciding
  - Can decline invitation without judgment (tracked anonymously)

**US-5**: As a child reaching age 18, I want to take control of my own health data

- **Acceptance Criteria**:
  - Automatically receive notification at age 18 about account transition
  - Can review historical test results from childhood
  - Can choose to keep or remove parent access
  - Can delete childhood data if desired (GDPR right to erasure)

### As a Caregiver

**US-6**: As an adult child caring for aging parent, I want to manage their Fair Underwriting account

- **Acceptance Criteria**:
  - Can be added as "authorized caregiver" with parent's consent
  - View parent's results, schedule tests, communicate with providers
  - Receive notifications about parent's critical health alerts
  - Can add multiple caregivers (e.g., siblings) with defined roles

---

## Technical Architecture

### Database Schema

**New Tables**:

```sql
-- Family relationships
CREATE TABLE family_connections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Who is connected
  primary_user_id UUID NOT NULL, -- Person who initiated connection
  connected_user_id UUID NOT NULL, -- Person connected to

  -- Relationship type
  relationship_type VARCHAR(50) NOT NULL, -- 'parent', 'child', 'sibling', 'spouse', 'caregiver'

  -- Permissions
  permission_level VARCHAR(20) NOT NULL, -- 'view_only', 'manage', 'full_control'
  can_view_results BOOLEAN DEFAULT FALSE,
  can_schedule_tests BOOLEAN DEFAULT FALSE,
  can_contact_providers BOOLEAN DEFAULT FALSE,
  can_modify_account BOOLEAN DEFAULT FALSE,

  -- Metadata
  relationship_verified BOOLEAN DEFAULT FALSE, -- Requires ID verification
  consent_document_url TEXT, -- Signed consent form
  consent_date TIMESTAMP,

  -- Status
  status VARCHAR(20) NOT NULL DEFAULT 'pending', -- 'pending', 'active', 'revoked'
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  revoked_at TIMESTAMP,

  FOREIGN KEY (tenant_id, primary_user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (tenant_id, connected_user_id) REFERENCES users(tenant_id, id),

  -- Prevent duplicate connections
  UNIQUE(tenant_id, primary_user_id, connected_user_id, relationship_type)
);

-- Family invitations (for cascade testing)
CREATE TABLE family_invitations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Who sent invitation
  inviter_user_id UUID NOT NULL,
  inviter_genotype VARCHAR(10), -- 'MZ', 'ZZ', etc. (for risk calculation)

  -- Invitation details
  invitee_email VARCHAR(255),
  invitee_phone VARCHAR(20),
  relationship_to_inviter VARCHAR(50), -- 'sibling', 'child', 'parent'

  -- Invitation content
  invitation_code VARCHAR(20) UNIQUE NOT NULL, -- e.g., 'FU-FAM-ABC123'
  message TEXT, -- Personal message from inviter

  -- Tracking
  status VARCHAR(20) NOT NULL DEFAULT 'sent', -- 'sent', 'opened', 'accepted', 'declined', 'expired'
  sent_at TIMESTAMP DEFAULT NOW(),
  opened_at TIMESTAMP,
  accepted_at TIMESTAMP,
  declined_at TIMESTAMP,
  expires_at TIMESTAMP, -- 90 days from sent_at

  -- Conversion tracking
  test_ordered BOOLEAN DEFAULT FALSE,
  test_order_date TIMESTAMP,
  result_received BOOLEAN DEFAULT FALSE,

  -- Privacy
  share_inviter_results BOOLEAN DEFAULT FALSE, -- Did inviter consent to share their results?

  FOREIGN KEY (tenant_id, inviter_user_id) REFERENCES users(tenant_id, id)
);

-- Family tree nodes (for visualization)
CREATE TABLE family_tree_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  family_id UUID NOT NULL, -- Groups people into families

  -- Person details
  user_id UUID, -- NULL if not yet registered
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  date_of_birth DATE,
  gender VARCHAR(20), -- 'male', 'female', 'other', 'prefer_not_to_say'

  -- Genetic info (if tested)
  genotype VARCHAR(10), -- 'MM', 'MZ', 'ZZ', 'MS', 'SZ', etc.
  has_tested BOOLEAN DEFAULT FALSE,
  test_date DATE,

  -- Relationships
  parent1_id UUID, -- Reference to mother
  parent2_id UUID, -- Reference to father

  -- Privacy
  visibility VARCHAR(20) DEFAULT 'family', -- 'family', 'private', 'public'

  -- Status
  is_deceased BOOLEAN DEFAULT FALSE,
  is_proband BOOLEAN DEFAULT FALSE, -- Index case (first diagnosed)

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

-- Access logs (audit trail for family access)
CREATE TABLE family_access_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Who accessed what
  accessor_user_id UUID NOT NULL, -- Person viewing data
  target_user_id UUID NOT NULL, -- Person whose data was viewed

  -- What was accessed
  action_type VARCHAR(50) NOT NULL, -- 'view_results', 'schedule_test', 'download_pdf', etc.
  resource_type VARCHAR(50), -- 'test_result', 'genetic_report', 'appointment'
  resource_id UUID,

  -- Context
  ip_address VARCHAR(45),
  user_agent TEXT,
  accessed_at TIMESTAMP DEFAULT NOW(),

  FOREIGN KEY (tenant_id, accessor_user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (tenant_id, target_user_id) REFERENCES users(tenant_id, id)
);

-- Indexes for performance
CREATE INDEX idx_family_connections_primary ON family_connections(tenant_id, primary_user_id);
CREATE INDEX idx_family_connections_connected ON family_connections(tenant_id, connected_user_id);
CREATE INDEX idx_family_invitations_code ON family_invitations(invitation_code);
CREATE INDEX idx_family_invitations_email ON family_invitations(invitee_email);
CREATE INDEX idx_family_tree_family ON family_tree_members(family_id);
CREATE INDEX idx_family_access_logs_target ON family_access_logs(tenant_id, target_user_id, accessed_at);
```

### API Endpoints

**Family Connections**:

```typescript
// POST /api/v1/family/connections - Request family connection
interface CreateConnectionRequest {
  connectedUserId: string; // User already on platform
  relationshipType: 'parent' | 'child' | 'sibling' | 'spouse' | 'caregiver';
  permissions: {
    canViewResults: boolean;
    canScheduleTests: boolean;
    canContactProviders: boolean;
    canModifyAccount: boolean;
  };
  consentDocument?: File; // For legal guardian relationships
}

// GET /api/v1/family/connections - List my family connections
interface ListConnectionsResponse {
  connections: {
    id: string;
    connectedUser: {
      id: string;
      firstName: string;
      lastName: string;
      relationship: string;
    };
    permissionLevel: string;
    status: 'pending' | 'active' | 'revoked';
    createdAt: string;
  }[];
}

// PUT /api/v1/family/connections/:id - Update permissions
interface UpdateConnectionRequest {
  permissions: {
    canViewResults?: boolean;
    canScheduleTests?: boolean;
    canContactProviders?: boolean;
    canModifyAccount?: boolean;
  };
}

// DELETE /api/v1/family/connections/:id - Revoke access
// Returns: 204 No Content
```

**Family Invitations**:

```typescript
// POST /api/v1/family/invitations - Invite family member
interface SendInvitationRequest {
  inviteeEmail: string;
  inviteePhone?: string;
  relationshipToInviter: 'sibling' | 'child' | 'parent' | 'cousin' | 'other';
  personalMessage?: string;
  shareMyResults: boolean; // Consent to share inviter's genotype
  includeEducationalMaterials: boolean;
}

interface SendInvitationResponse {
  success: boolean;
  invitationId: string;
  invitationCode: string; // 'FU-FAM-ABC123'
  invitationUrl: string; // 'https://my.fairunderwriting.com/family/join/FU-FAM-ABC123'
  estimatedRisk: {
    relationshipType: string;
    probabilityOfCarrier: number; // 0-1
    recommendedAction: string; // 'Test immediately', 'Consider testing', 'Low priority'
  };
}

// GET /api/v1/family/invitations - List sent invitations
interface ListInvitationsResponse {
  invitations: {
    id: string;
    inviteeEmail: string;
    relationshipToInviter: string;
    status: 'sent' | 'opened' | 'accepted' | 'declined' | 'expired';
    sentAt: string;
    expiresAt: string;
    testOrdered: boolean;
  }[];
}

// POST /api/v1/family/invitations/:code/accept - Accept invitation (public endpoint)
interface AcceptInvitationRequest {
  email: string; // Verify matches invitation
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  createAccount: boolean; // If false, just order test without account
}

// POST /api/v1/family/invitations/:code/decline - Decline invitation
interface DeclineInvitationRequest {
  reason?: 'not_interested' | 'already_tested' | 'privacy_concerns' | 'other';
  comments?: string;
}
```

**Family Tree**:

```typescript
// GET /api/v1/family/tree - Get family tree
interface FamilyTreeResponse {
  familyId: string;
  members: {
    id: string;
    userId?: string; // NULL if not registered
    firstName: string;
    lastName: string;
    dateOfBirth?: string;
    gender?: string;
    genotype?: string; // Only if has_tested = true
    hasTested: boolean;
    isProband: boolean; // Index case
    isDeceased: boolean;
    parent1Id?: string;
    parent2Id?: string;
    children: string[]; // IDs of children
    visibility: 'family' | 'private' | 'public';
  }[];
  probandId: string; // ID of index case (first diagnosed)
}

// POST /api/v1/family/tree/members - Add family member to tree
interface AddTreeMemberRequest {
  firstName: string;
  lastName: string;
  dateOfBirth?: string;
  gender?: string;
  relationshipToPrimary: string; // 'mother', 'father', 'sibling', 'child'
  parent1Id?: string;
  parent2Id?: string;
  isDeceased?: boolean;
}

// PUT /api/v1/family/tree/members/:id - Update family member
interface UpdateTreeMemberRequest {
  firstName?: string;
  lastName?: string;
  genotype?: string; // If they got tested
  hasTested?: boolean;
  testDate?: string;
  visibility?: 'family' | 'private' | 'public';
}
```

**Multi-User Account Management**:

```typescript
// POST /api/v1/family/accounts/add-child - Add minor child to account
interface AddChildRequest {
  firstName: string;
  lastName: string;
  dateOfBirth: string; // Must be under 18
  gender?: string;
  relationshipProof: File; // Birth certificate scan
}

// POST /api/v1/family/accounts/transfer-ownership - Transfer child account at age 18
interface TransferOwnershipRequest {
  childUserId: string;
  newEmail: string; // Child's email for independent login
  notifyParent: boolean;
}

// POST /api/v1/family/accounts/add-caregiver - Add authorized caregiver
interface AddCaregiverRequest {
  caregiverEmail: string;
  relationshipType:
    | 'adult_child'
    | 'spouse'
    | 'sibling'
    | 'professional_caregiver';
  permissions: {
    canViewResults: boolean;
    canScheduleTests: boolean;
    canContactProviders: boolean;
    canManageFinancials: boolean;
  };
  powerOfAttorneyDocument?: File; // Required for full control
}
```

---

## Feature Specifications

### 1. Family Tree Visualization

**Visual Representation**:

```
                    [John Smith]
                    MM (normal)
                         |
        ┌────────────────┴────────────────┐
        |                                  |
   [You - Sarah]                    [Brother - Mike]
   MZ (carrier)                      ZZ (affected)
   ⚠️ 2-4x COPD risk                ⚠️ Severe AATD
        |                                  |
  ┌─────┴─────┐                     ┌─────┴─────┐
  |           |                     |           |
[Emily]    [Jacob]              [Nephew]    [Niece]
Age 8      Age 5                Age 12      Age 9
Not tested Not tested           MZ          Not tested
                                (tested)
```

**Interactive Features**:

- Click on any member → view details (if you have permission)
- Color coding:
  - 🟢 Green = MM (normal)
  - 🟡 Yellow = MS or MZ (carrier)
  - 🔴 Red = ZZ, SZ, or rare severe mutations
  - ⚪ Gray = Not tested
  - ⚫ Black outline = Deceased
- Hover tooltips showing risk levels
- Expand/collapse branches
- Export as PDF (for sharing with genetic counselor)

**Punnett Square Calculator**:

```
When two MZ carriers have children:

        M    Z
    ┌───┬───┬───┐
  M │MM │MZ │
    ├───┼───┼───┤
  Z │MZ │ZZ │
    └───┴───┴───┘

Results:
- 25% chance: MM (normal)
- 50% chance: MZ (carrier, 2-4x COPD risk)
- 25% chance: ZZ (severe AATD)

Recommendation: Both parents and all children should be tested.
```

### 2. Cascade Testing Workflow

**Trigger Events**:

1. User receives positive result (MZ, ZZ, SZ, rare mutation)
2. Genetic counselor recommends family testing
3. User manually initiates cascade testing

**Workflow Steps**:

```
Step 1: Index Case Receives Results
   └─> "Your genotype is MZ. Family members may also be affected."
   └─> [Button: "Invite Family to Get Tested"]

Step 2: Identify At-Risk Family Members
   └─> "Who should get tested?"
       - First-degree relatives (parents, siblings, children): ⭐ HIGHEST PRIORITY
       - Second-degree relatives (grandparents, aunts/uncles, nieces/nephews): ⭐ HIGH PRIORITY
       - Third-degree relatives (cousins): ⭐ MODERATE PRIORITY
   └─> Calculate risk for each based on index case genotype

Step 3: Generate Personalized Invitations
   └─> For each family member:
       - Pre-filled email template
       - Explanation of inheritance (without revealing your exact results)
       - Risk calculator (e.g., "50% chance you're also a carrier")
       - Unique invitation code for discount
       - Educational PDF attachment

Step 4: Send Invitations
   └─> Email + SMS (if phone provided)
   └─> Track delivery and opens
   └─> Auto-reminder after 7 days (if not opened)
   └─> Auto-reminder after 30 days (if opened but not acted on)

Step 5: Family Member Responds
   └─> Option A: Accept invitation → Order test → Create account
   └─> Option B: Decline invitation (tracked anonymously)
   └─> Option C: "I've already been tested" → Upload results

Step 6: Track Completion
   └─> Dashboard showing:
       - Invitations sent: 5
       - Tests ordered: 3
       - Results received: 2
       - Positive cases found: 1 (your brother Mike - ZZ genotype)
   └─> Celebrate wins: "You helped detect 1 case of severe AATD early!"
```

**Email Template Example**:

```
Subject: Your sibling recommends genetic testing for Alpha-1 Antitrypsin Deficiency

Hi [Name],

Someone in your immediate family recently completed genetic testing through
Fair Underwriting and learned they carry a genetic variant that affects
Alpha-1 Antitrypsin (AAT) protein production.

WHAT THIS MEANS FOR YOU:
Because you share genetics with your family member, there's a 50% chance you
may also carry this variant. Carriers have a 2-4x increased risk of developing
COPD and may have elevated liver disease risk.

WHY TEST NOW:
✓ Early detection allows for preventive care
✓ Knowledge empowers lifestyle choices (avoid smoking, monitor air quality)
✓ Understanding your genetics helps with family planning

SPECIAL FAMILY DISCOUNT:
Use code FU-FAM-ABC123 for 20% off genetic testing ($79 → $63)
Expires in 90 days.

[Get Tested Now]  [Learn More]  [Speak with Genetic Counselor (Free)]

Questions? Reply to this email or call 1-800-FAIR-UND.

Privacy Note: Your family member has not shared their specific results with us.
This invitation is based only on your relationship and general risk guidelines.

---
Fair Underwriting | Genetic Privacy Meets Longevity Incentives
```

### 3. Multi-Member Account Management

**Account Types**:

**1. Individual Account** (default):

- Single user
- Full control over their data
- Can invite family members

**2. Family Account** (parent + children):

- Parent is "Account Holder"
- Can add up to 5 minor children (under 18)
- Parent views all results in unified dashboard
- Each child gets separate profile
- At age 18, child auto-transitions to individual account

**3. Caregiver-Managed Account** (elderly parent + adult child):

- Primary user grants "Authorized Caregiver" status
- Caregiver can view results, schedule tests, communicate with providers
- Primary user can revoke access anytime
- All caregiver actions logged in audit trail

**Parent Dashboard Example**:

```
┌────────────────────────────────────────────────────────┐
│  Family Account - Smith Family                         │
├────────────────────────────────────────────────────────┤
│                                                         │
│  👤 You (Sarah Smith)                                  │
│      Latest AAT: 155 mg/dL | Genotype: MZ             │
│      [View Full Profile]                               │
│                                                         │
│  👧 Emily (Age 8)                                      │
│      Latest AAT: Not yet tested                        │
│      [Schedule Test] [View Medical History]            │
│                                                         │
│  👦 Jacob (Age 5)                                      │
│      Latest AAT: 180 mg/dL | Genotype: MM (normal)    │
│      Next test due: October 2026                       │
│      [View Full Profile]                               │
│                                                         │
│  🔔 Notifications (2)                                  │
│      • Emily's annual test is due next month           │
│      • New educational content: "Talking to Kids       │
│        About Genetic Testing"                          │
│                                                         │
│  [Manage Family Members] [Family Settings]             │
└────────────────────────────────────────────────────────┘
```

**Age 18 Transition Flow**:

```
30 days before 18th birthday:
   └─> Email to parent: "Emily turns 18 soon. She'll get her own login."
   └─> Email to Emily: "You're turning 18! Here's what changes..."

On 18th birthday:
   └─> System automatically:
       1. Creates independent login for Emily
       2. Sends welcome email with temp password
       3. Transfers full control of account to Emily
       4. Asks Emily: "Keep parent access?" [Yes] [No]
       5. Notifies parent of transition

If Emily chooses "No":
   └─> Parent loses access immediately
   └─> Parent receives email: "Emily has taken control of her account"
   └─> Emily can still share access later if she changes mind
```

### 4. Permissions & Privacy Controls

**Permission Levels**:

| Level            | View Results | Schedule Tests | Contact Providers | Modify Account | Manage Billing |
| ---------------- | ------------ | -------------- | ----------------- | -------------- | -------------- |
| **View Only**    | ✅           | ❌             | ❌                | ❌             | ❌             |
| **Manage**       | ✅           | ✅             | ✅                | ❌             | ❌             |
| **Full Control** | ✅           | ✅             | ✅                | ✅             | ✅             |

**Granular Permissions** (for advanced users):

```typescript
interface FamilyMemberPermissions {
  // Data access
  canViewTestResults: boolean;
  canViewGeneticData: boolean; // More sensitive than test results
  canViewBillingInfo: boolean;
  canViewMedicalHistory: boolean;

  // Actions
  canScheduleTests: boolean;
  canCancelTests: boolean;
  canDownloadReports: boolean;
  canShareWithProviders: boolean;

  // Communication
  canContactGeneticCounselor: boolean;
  canContactSupport: boolean;
  canReceiveNotifications: boolean;

  // Account management
  canModifyProfile: boolean;
  canInviteOtherFamily: boolean;
  canManageBilling: boolean;
  canDeleteAccount: boolean; // Requires primary user approval
}
```

**Privacy Safeguards**:

- All family access is opt-in (never automatic)
- Consent forms required for legal guardian relationships
- Two-factor authentication required for adding caregivers
- Email notifications when someone accesses your data
- Annual review prompt: "Review who has access to your account"
- Easy revocation: "Revoke All Access" button

### 5. Family Discounts & Incentives

**Tiered Discount Structure**:

| Family Members Tested | Discount Per Person | Example Cost        |
| --------------------- | ------------------- | ------------------- |
| 1 person              | 0% (regular price)  | $79/test            |
| 2 people              | 10% off             | $71/test × 2 = $142 |
| 3-5 people            | 20% off             | $63/test × 3 = $189 |
| 6+ people             | 30% off             | $55/test × 6 = $330 |

**Family Package Deals**:

- **Sibling Trio**: 3 siblings test for $180 (save $57)
- **Nuclear Family**: Parents + 2 kids for $250 (save $66)
- **Extended Family**: 10 people for $500 (save $290)

**Referral Bonuses**:

- Refer a family member → Both get $10 credit
- Refer 5+ family members → Free annual AAT monitoring for life

**Insurance Partner Incentives**:

- Insurance covers index case testing (free)
- Family members get co-pay waived if they test within 90 days
- Partner tracks "family penetration rate" (% of relatives tested)

---

## Compliance & Legal Considerations

### HIPAA Compliance

**Challenge**: Sharing health data between family members
**Solution**:

- Explicit consent required for each data share
- Minimum necessary principle (only share what's needed)
- Audit logs of all family access
- Right to revoke access anytime

**Parental Access to Minor Children**:

- HIPAA allows parents to access children's PHI until age 18
- Some states (e.g., California) restrict access to sensitive services at age 12
- Fair Underwriting defaults to full parental access until 18, with state-specific exceptions

### GINA Protections

**Genetic Information Nondiscrimination Act**:

- Family members' genetic information is protected under GINA
- Insurance companies cannot access family tree data
- Partners see only aggregate "family screening completion rates" (no individuals)

### State-Specific Regulations

**California**:

- Minors age 12+ have privacy rights for certain health services
- May need separate consent for children 12-17

**New York**:

- Genetic testing requires special informed consent
- Family members must sign separate consent forms

**Texas**:

- Age of medical consent is 18, but exceptions for emergencies
- Power of attorney required for caregiver access

### Data Retention

**Minor Children**:

- Parent can request deletion of child's data before age 18
- At age 18, data remains but control transfers to adult child
- Adult child can request deletion of childhood data

**Deceased Family Members**:

- Family tree can include deceased members (for inheritance visualization)
- No PHI stored for deceased members (only name, relationship, genotype if known)

---

## Success Metrics

### Cascade Testing Effectiveness

- **Invitation Response Rate**: 40% of invitations result in test order (target)
- **Family Penetration Rate**: Average 2.5 family members test per index case
- **Detection Yield**: 30% of invited family members test positive for carrier status
  - (vs. 4% in general population → 7.5x improvement)

### Multi-Member Account Adoption

- **Family Account Creation**: 15% of customers create family accounts
- **Caregiver Account Usage**: 8% of customers add authorized caregivers
- **Child Account Transitions**: 95% smooth transition rate at age 18 (no issues)

### Engagement & Retention

- **Family Engagement**: Customers with family accounts are 3x more engaged (sessions/month)
- **Retention**: Family account holders have 85% annual retention (vs. 75% individual)
- **Cross-Sell**: Family members test for additional panels (30% upgrade to full DNA)

### Business Impact

- **Revenue per Index Case**: $79 (initial) → $260 (with 2.5 family members)
- **Partner ROI**: Family screening finds 10x more cases, improving partner outcomes
- **Customer Acquisition Cost**: 50% lower for family invitations (warm leads)

---

## Implementation Plan

### Phase 1: Core Family Features (Month 1-2)

**Week 1-2**: Database schema and API development

- Create tables (family_connections, family_invitations)
- Build REST APIs for family management
- Unit tests for permission logic

**Week 3-4**: Family invitation system

- Email template design
- Invitation tracking dashboard
- Discount code generation

**Week 5-6**: Multi-member accounts

- Parent-child account linking
- Permission management UI
- Audit logging

**Week 7-8**: Testing and pilot launch

- Internal testing with employees
- Pilot with 50 families
- Bug fixes and iteration

### Phase 2: Family Tree & Visualization (Month 3)

**Week 9-10**: Family tree builder

- Interactive tree visualization (D3.js or similar)
- Punnett square calculator
- Inheritance pattern animations

**Week 11-12**: Advanced features

- PDF export (for genetic counselors)
- Risk prediction algorithms
- Mobile app support

### Phase 3: Optimization (Ongoing)

- A/B test invitation email templates
- Optimize discount structure
- Add social features (family leaderboards)

---

## Budget Estimate

### Development (2-3 months)

- **Backend Developer**: $140K/year × 0.25 years = $35,000
- **Frontend Developer**: $130K/year × 0.25 years = $32,500
- **Genetic Counselor** (advisor, part-time): $50/hour × 40 hours = $2,000
- **QA & Testing**: $25K/year × 0.25 years = $6,250

**Total Development**: ~$75,750

### Ongoing Costs (Annual)

- **Email Service** (SendGrid, family invitations): $200/month × 12 = $2,400
- **SMS Service** (Twilio, invitation reminders): $100/month × 12 = $1,200
- **Storage** (family tree visualizations, consent documents): $50/month × 12 = $600
- **Support** (family account issues): 2 hours/week × $50/hour × 52 weeks = $5,200

**Total Annual**: ~$9,400

### **GRAND TOTAL (First Year)**: ~$85,000

---

## Risks & Mitigations

### Risk 1: Privacy Concerns

**Mitigation**: Opt-in only, explicit consent, easy revocation, audit logs

### Risk 2: Complex Permissions

**Mitigation**: Start with 3 simple levels (view, manage, full), add granularity later

### Risk 3: Family Conflict

**Mitigation**: Clear dispute resolution process, genetic counselor mediation

### Risk 4: Age 18 Transition Issues

**Mitigation**: 30-day advance notice, help center articles, live support

### Risk 5: Low Invitation Response Rates

**Mitigation**: A/B test messaging, increase discount, add urgency ("limited time")

---

## Future Enhancements (Phase 4+)

### Family Health Dashboard

- Aggregated family health trends (anonymized)
- Comparative risk levels across generations
- Proactive alerts ("3 family members have elevated AAT")

### Family Challenges & Gamification

- "Get Your Whole Family Tested" challenge (rewards for completion)
- Family leaderboards (most engaged family)
- Badges ("Family Health Champion")

### AI-Powered Risk Prediction

- Machine learning model predicts which family members most likely to have mutation
- Prioritized invitation list (highest-risk first)
- Personalized counseling based on family history

### Integration with Ancestry/23andMe

- Import family tree from Ancestry.com
- Auto-map genetic relationships
- Suggest Fair Underwriting testing for at-risk branches

---

**Document Owner**: CPO, Chief Medical Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
