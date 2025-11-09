# Feature #6: Community & Support Forums

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 2-3 months
**Team Required**: 1 backend developer, 1 frontend developer, 1 community manager

---

## Executive Summary

Living with AATD or being an MZ carrier creates unique challenges and questions that are best addressed through peer support. Fair Underwriting currently lacks a community platform where users can share experiences, ask questions, and receive emotional support. This feature builds a moderated forum system that connects users while maintaining HIPAA compliance and privacy.

**Key Value Propositions**:

- **Peer Support**: Connect with others who have the same genotype (MZ, ZZ, etc.)
- **Expert Q&A**: Direct access to genetic counselors, pulmonologists, hepatologists
- **Knowledge Base**: Searchable archive of common questions and answers
- **Reduce Support Burden**: Community answers 70% of questions (deflect from support tickets)
- **Increase Engagement**: Users with forum access log in 2.5x more often
- **Improve Outcomes**: Peer support linked to better treatment adherence

**Business Impact**:

- Reduce support costs by 40% ($80K/year savings)
- Increase engagement by 150% (from 5 to 12.5 logins/month)
- Improve retention by 18% (community members less likely to churn)
- Enable premium "Expert Access" tier ($10/month add-on)

---

## Problem Statement

### Current Gaps

**Scenario 1: Newly Diagnosed MZ Carrier Seeking Guidance**

> "I just found out I'm MZ. My doctor said 'it's nothing to worry about,' but I have questions: Should I tell my employer? Do I need life insurance changes? Should my kids get tested? Can I donate blood? I feel alone and scared."

**No peer support network or community resources** ❌

**Scenario 2: ZZ Patient Managing Augmentation Therapy**

> "I'm on Prolastin infusions weekly. Side effects are rough. Are others experiencing headaches and fatigue? Any tips to make infusions easier? My local support group only has 3 people."

**No way to connect with other ZZ patients globally** ❌

**Scenario 3: Family Members Seeking Information**

> "My husband is ZZ with early COPD. I'm his primary caregiver. I need advice on lung health, diet, exercise limitations, travel with oxygen. Where can I find other caregivers who understand?"

**No caregiver support community** ❌

**Scenario 4: Repetitive Support Questions**

> "Our support team answers the same questions 50 times per week: 'What does MZ mean?', 'Should I exercise?', 'Can I drink alcohol?', 'Will my insurance cover testing?' We need a self-service knowledge base."

**No FAQ or community-driven knowledge base** ❌

---

## Feature Specifications

### 1. Forum Categories & Structure

**Top-Level Categories**:

```
┌─────────────────────────────────────────────────────────────┐
│  📁 Forum Categories                                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  🧬 BY GENOTYPE                                             │
│  ├─ MZ Carriers (2,450 members, 850 posts)                 │
│  ├─ ZZ Deficiency (180 members, 420 posts)                 │
│  ├─ MS/SZ Variants (45 members, 80 posts)                  │
│  └─ Normal/MM (informational only)                          │
│                                                              │
│  🫁 BY CONDITION                                            │
│  ├─ COPD Management (650 posts)                            │
│  ├─ Liver Disease (220 posts)                              │
│  ├─ Asymptomatic Carriers (1,200 posts)                    │
│  └─ Pre-Diagnosis Questions (380 posts)                     │
│                                                              │
│  💊 TREATMENT & THERAPY                                     │
│  ├─ Augmentation Therapy (Prolastin, Aralast, Zemaira)    │
│  ├─ Smoking Cessation (critical for AATD)                  │
│  ├─ Pulmonary Rehabilitation                               │
│  └─ Liver Transplant Journey                               │
│                                                              │
│  👨‍👩‍👧‍👦 FAMILY & GENETICS                                      │
│  ├─ Family Testing & Cascade Screening                     │
│  ├─ Pregnancy & AATD                                        │
│  ├─ Pediatric AATD                                          │
│  └─ Caregiver Support                                       │
│                                                              │
│  🏥 HEALTHCARE & INSURANCE                                  │
│  ├─ Insurance Coverage Questions                           │
│  ├─ Finding AATD Specialists                               │
│  ├─ Clinical Trials & Research                             │
│  └─ Disability & Work Accommodations                        │
│                                                              │
│  💪 LIFESTYLE & WELLNESS                                    │
│  ├─ Exercise & Fitness                                      │
│  ├─ Diet & Nutrition                                        │
│  ├─ Travel with AATD                                        │
│  └─ Mental Health & Coping                                  │
│                                                              │
│  🎓 ASK THE EXPERTS                                         │
│  ├─ Genetic Counselor Q&A (weekly office hours)            │
│  ├─ Pulmonologist Q&A (monthly)                            │
│  ├─ Hepatologist Q&A (monthly)                             │
│  └─ Respiratory Therapist Tips                             │
│                                                              │
│  💬 GENERAL DISCUSSION                                      │
│  ├─ Introduce Yourself                                      │
│  ├─ Off-Topic / Lounge                                      │
│  ├─ Success Stories                                         │
│  └─ Research & News                                         │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2. Database Schema

```sql
-- Forum categories
CREATE TABLE forum_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Category info
  name VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL, -- URL-friendly: 'mz-carriers', 'copd-management'
  description TEXT,
  icon VARCHAR(50), -- Emoji or icon name

  -- Hierarchy
  parent_category_id UUID, -- For subcategories
  display_order INTEGER DEFAULT 0,

  -- Access control
  visibility VARCHAR(20) DEFAULT 'public', -- 'public', 'members_only', 'genotype_specific'
  required_genotype VARCHAR(10), -- e.g., 'MZ', 'ZZ' - restrict access to specific genotypes

  -- Metadata
  post_count INTEGER DEFAULT 0,
  member_count INTEGER DEFAULT 0,

  -- Status
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

CREATE INDEX idx_forum_categories_slug ON forum_categories(slug);

-- Forum posts
CREATE TABLE forum_posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,
  category_id UUID NOT NULL,

  -- Author
  author_user_id UUID NOT NULL,
  author_display_name VARCHAR(200), -- Can use pseudonym for privacy
  author_genotype VARCHAR(10), -- Display badge (MZ, ZZ) if user consents
  author_role VARCHAR(20), -- 'member', 'expert', 'moderator', 'admin'

  -- Content
  title VARCHAR(300) NOT NULL,
  body TEXT NOT NULL, -- Supports Markdown
  body_html TEXT, -- Rendered HTML (cached)

  -- Thread info
  parent_post_id UUID, -- NULL for top-level posts, set for replies
  root_post_id UUID, -- Points to the original post in thread

  -- Engagement
  view_count INTEGER DEFAULT 0,
  reply_count INTEGER DEFAULT 0,
  upvote_count INTEGER DEFAULT 0,

  -- Flags
  is_pinned BOOLEAN DEFAULT false, -- Sticky posts
  is_locked BOOLEAN DEFAULT false, -- Prevent further replies
  is_expert_answer BOOLEAN DEFAULT false, -- Verified answer from expert
  is_solution BOOLEAN DEFAULT false, -- Marked as solution by OP

  -- Moderation
  is_flagged BOOLEAN DEFAULT false,
  flag_count INTEGER DEFAULT 0,
  moderation_status VARCHAR(20) DEFAULT 'approved', -- 'pending', 'approved', 'rejected', 'hidden'
  moderated_by UUID,
  moderated_at TIMESTAMPTZ,
  moderation_reason TEXT,

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  last_activity_at TIMESTAMPTZ DEFAULT NOW(), -- Updated when replies added

  -- Search
  search_vector tsvector, -- Full-text search

  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  FOREIGN KEY (category_id) REFERENCES forum_categories(id),
  FOREIGN KEY (author_user_id) REFERENCES users(id),
  FOREIGN KEY (parent_post_id) REFERENCES forum_posts(id),
  FOREIGN KEY (root_post_id) REFERENCES forum_posts(id)
);

CREATE INDEX idx_forum_posts_category ON forum_posts(category_id, last_activity_at DESC);
CREATE INDEX idx_forum_posts_author ON forum_posts(author_user_id);
CREATE INDEX idx_forum_posts_thread ON forum_posts(root_post_id, created_at);
CREATE INDEX idx_forum_posts_search ON forum_posts USING GIN(search_vector);

-- Trigger to update search vector
CREATE TRIGGER forum_posts_search_update
BEFORE INSERT OR UPDATE ON forum_posts
FOR EACH ROW EXECUTE FUNCTION
  tsvector_update_trigger(search_vector, 'pg_catalog.english', title, body);

-- Post reactions (upvotes, helpful, etc.)
CREATE TABLE forum_post_reactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID NOT NULL,
  user_id UUID NOT NULL,

  -- Reaction type
  reaction_type VARCHAR(20) NOT NULL, -- 'upvote', 'helpful', 'heart', 'thanks'

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (post_id) REFERENCES forum_posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id),

  -- One reaction per user per post
  UNIQUE(post_id, user_id, reaction_type)
);

-- Post flags/reports
CREATE TABLE forum_post_flags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID NOT NULL,
  reporter_user_id UUID NOT NULL,

  -- Flag reason
  reason VARCHAR(50) NOT NULL, -- 'spam', 'inappropriate', 'medical_misinformation', 'harassment', 'other'
  details TEXT,

  -- Status
  status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'reviewed', 'actioned', 'dismissed'
  reviewed_by UUID,
  reviewed_at TIMESTAMPTZ,
  action_taken VARCHAR(100), -- 'post_hidden', 'user_warned', 'no_action'

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (post_id) REFERENCES forum_posts(id),
  FOREIGN KEY (reporter_user_id) REFERENCES users(id),
  FOREIGN KEY (reviewed_by) REFERENCES users(id)
);

-- User forum profiles
CREATE TABLE forum_user_profiles (
  user_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,

  -- Display preferences
  display_name VARCHAR(200), -- Public name (can be pseudonym)
  bio TEXT,
  avatar_url TEXT,
  show_genotype BOOLEAN DEFAULT false, -- Consent to display genotype badge

  -- Reputation
  reputation_score INTEGER DEFAULT 0,
  helpful_answer_count INTEGER DEFAULT 0,

  -- Stats
  post_count INTEGER DEFAULT 0,
  reply_count INTEGER DEFAULT 0,
  upvotes_received INTEGER DEFAULT 0,

  -- Badges
  badges TEXT[], -- ['helpful_contributor', 'expert_verified', '100_posts', 'early_adopter']

  -- Notifications
  email_on_reply BOOLEAN DEFAULT true,
  email_on_mention BOOLEAN DEFAULT true,
  email_digest_frequency VARCHAR(20) DEFAULT 'daily', -- 'realtime', 'daily', 'weekly', 'never'

  -- Moderation role
  is_moderator BOOLEAN DEFAULT false,
  moderator_categories UUID[], -- Categories they can moderate

  -- Status
  last_active_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

-- Subscriptions (follow threads)
CREATE TABLE forum_subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,

  -- Subscribe to category or specific post
  category_id UUID,
  post_id UUID,

  -- Notification preferences
  notify_on_new_post BOOLEAN DEFAULT true,
  notify_on_reply BOOLEAN DEFAULT true,

  subscribed_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES forum_categories(id),
  FOREIGN KEY (post_id) REFERENCES forum_posts(id),

  -- Subscribe to category OR post, not both
  CHECK ((category_id IS NOT NULL AND post_id IS NULL) OR (category_id IS NULL AND post_id IS NOT NULL))
);

-- Expert office hours
CREATE TABLE forum_expert_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Expert info
  expert_user_id UUID NOT NULL,
  expert_name VARCHAR(200),
  expert_title VARCHAR(200), -- 'Genetic Counselor', 'Pulmonologist'
  expert_credentials VARCHAR(200), -- 'MD, FCCP', 'MS, CGC'

  -- Session details
  category_id UUID NOT NULL,
  session_title VARCHAR(300),
  session_description TEXT,

  -- Timing
  scheduled_start TIMESTAMPTZ NOT NULL,
  scheduled_end TIMESTAMPTZ NOT NULL,

  -- Status
  status VARCHAR(20) DEFAULT 'scheduled', -- 'scheduled', 'live', 'completed', 'cancelled'

  -- Stats
  questions_answered INTEGER DEFAULT 0,
  participants_count INTEGER DEFAULT 0,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES tenants(id),
  FOREIGN KEY (expert_user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES forum_categories(id)
);
```

### 3. Privacy & HIPAA Compliance

**Key Privacy Features**:

1. **Pseudonymous Profiles**:
   - Users choose display name (not required to use real name)
   - Profile shows only: genotype (if consented), member since date, post count
   - No email addresses or PII visible to other users

2. **Genotype-Restricted Categories**:
   - MZ-only forums: Only users with MZ genotype can access
   - ZZ-only forums: Only users with ZZ genotype can access
   - Prevents "curiosity seekers" from accessing sensitive discussions

3. **Content Warnings**:
   - Posts about difficult topics (end-of-life, severe symptoms) flagged with warnings
   - Users can filter out triggering content

4. **No Direct Messaging**:
   - To prevent HIPAA violations, no DMs between users
   - All communication public (within category restrictions)
   - Exception: Users can message verified experts (logged for compliance)

5. **Automatic PII Detection**:
   - AI scans posts for SSN, credit card numbers, full names, addresses
   - Auto-flags for moderator review before publication

6. **Data Retention**:
   - Users can delete their own posts anytime (replaced with "[deleted]")
   - User can request full account deletion (removes all posts)
   - Backups encrypted, retained 7 years for compliance

### 4. Moderation System

**Automated Moderation**:

```typescript
class ForumModerationService {
  async moderatePost(postId: string): Promise<ModerationResult> {
    const post = await this.getPost(postId);

    const checks = await Promise.all([
      this.checkProfanity(post.body),
      this.checkPII(post.body),
      this.checkMedicalClaims(post.body),
      this.checkSpam(post.body),
      this.checkLinks(post.body)
    ]);

    let status = 'approved';
    let flags: string[] = [];

    // Profanity filter
    if (checks[0].hasProfanity) {
      status = 'pending';
      flags.push('profanity_detected');
    }

    // PII detection (SSN, credit card, etc.)
    if (checks[1].hasPII) {
      status = 'rejected';
      flags.push('pii_detected');
      await this.notifyUser(
        post.author_user_id,
        'Your post contains personal information. Please remove it and try again.'
      );
    }

    // Medical claims (requires expert verification)
    if (checks[2].hasMedicalClaim) {
      status = 'pending';
      flags.push('medical_claim_needs_review');
    }

    // Spam detection
    if (checks[3].isSpam) {
      status = 'rejected';
      flags.push('spam');
    }

    // External links (require approval for first-time posters)
    if (checks[4].hasExternalLinks && post.author.post_count < 10) {
      status = 'pending';
      flags.push('external_link_needs_review');
    }

    // Auto-approve trusted users
    if (post.author.reputation_score > 500) {
      status = 'approved';
      flags = [];
    }

    await this.updatePostStatus(postId, status, flags);

    return { status, flags };
  }

  async checkMedicalClaims(
    text: string
  ): Promise<{ hasMedicalClaim: boolean; claims: string[] }> {
    // Use NLP to detect unverified medical claims
    const claimPatterns = [
      /(?:this|try|use) \w+ (?:cures?|treats?|heals?|fixes?) (?:AATD|COPD|liver disease)/i,
      /(?:I|you) (?:don't need|shouldn't take|should stop) (?:medication|therapy|treatment)/i,
      /(?:doctors? are wrong|ignore your doctor)/i
    ];

    const claims: string[] = [];

    for (const pattern of claimPatterns) {
      const match = text.match(pattern);
      if (match) {
        claims.push(match[0]);
      }
    }

    return {
      hasMedicalClaim: claims.length > 0,
      claims
    };
  }
}
```

**Human Moderation Workflow**:

```
Post Created
    │
    ▼
┌───────────────────────┐
│ Automated Checks      │
│ - Profanity           │
│ - PII                 │
│ - Spam                │
│ - Medical claims      │
└──────┬────────────────┘
       │
       ├─ Approved ──────────────────────► Published
       │
       ├─ Rejected ──────────────────────► Notify Author, Don't Publish
       │
       └─ Pending ──────┐
                        │
                        ▼
              ┌──────────────────┐
              │ Moderator Queue  │
              │ (prioritized)    │
              └────┬─────────────┘
                   │
                   ├─ Approve ──────────► Published
                   │
                   ├─ Reject ───────────► Notify Author
                   │
                   └─ Request Edit ─────► Send Back to Author
```

**Moderator Dashboard**:

```
┌─────────────────────────────────────────────────────────┐
│  🛡️ Moderation Queue - 15 Items Pending                 │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  🚨 HIGH PRIORITY (5)                                   │
│  ┌────────────────────────────────────────────────────┐ │
│  │ ⚠️ Medical Claim Detected                          │ │
│  │ "Vitamin C cures COPD" by JohnDoe123               │ │
│  │ Category: COPD Management                           │ │
│  │ [Approve] [Edit Required] [Reject] [View Context]  │ │
│  └────────────────────────────────────────────────────┘ │
│                                                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │ 🔗 External Link in Post                           │ │
│  │ New user posted link to supplement website         │ │
│  │ [Approve] [Remove Link] [Reject]                   │ │
│  └────────────────────────────────────────────────────┘ │
│                                                          │
│  📋 NORMAL PRIORITY (10)                                │
│  - 8 posts with minor profanity                         │
│  - 2 posts flagged by users                             │
│                                                          │
│  📊 STATS (Last 7 Days)                                 │
│  - 1,240 posts created                                  │
│  - 1,185 auto-approved (96%)                            │
│  - 45 required review (4%)                              │
│  - 8 rejected (0.6%)                                    │
│  - Avg review time: 12 minutes                          │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 5. Expert Q&A System

**Weekly Office Hours**:

```typescript
interface ExpertSession {
  id: string;
  expertName: string;
  expertTitle: string; // "Genetic Counselor, MS, CGC"
  credentials: string;
  scheduledStart: Date;
  scheduledEnd: Date;
  status: 'scheduled' | 'live' | 'completed';
}

// Example schedule
const expertSessions: ExpertSession[] = [
  {
    id: '...',
    expertName: 'Dr. Sarah Johnson',
    expertTitle: 'Genetic Counselor',
    credentials: 'MS, CGC',
    scheduledStart: new Date('2025-11-10T14:00:00Z'), // Every Monday 2 PM ET
    scheduledEnd: new Date('2025-11-10T15:00:00Z'),
    status: 'scheduled'
  },
  {
    id: '...',
    expertName: 'Dr. Michael Chen',
    expertTitle: 'Pulmonologist',
    credentials: 'MD, FCCP',
    scheduledStart: new Date('2025-11-15T19:00:00Z'), // Monthly, 3rd Friday 7 PM ET
    scheduledEnd: new Date('2025-11-15T20:30:00Z'),
    status: 'scheduled'
  }
];
```

**Expert Answer Badge**:

```
┌─────────────────────────────────────────────────────────┐
│ ❓ Question: "Should MZ carriers avoid high altitudes?" │
│                                                          │
│ Posted by: MountainHiker22 (MZ Carrier)                 │
│ 3 days ago • 12 views • 4 replies                       │
├─────────────────────────────────────────────────────────┤
│                                                          │
│ 💬 Reply from: Dr. Sarah Johnson                        │
│     ✅ EXPERT ANSWER • Genetic Counselor, MS, CGC       │
│                                                          │
│     "MZ carriers generally tolerate altitude well,      │
│      but individual responses vary. If you have lung    │
│      symptoms, consult your pulmonologist before        │
│      traveling above 8,000 feet. Monitor SpO2 levels    │
│      with a pulse oximeter. Most MZ carriers can enjoy  │
│      mountain activities without issues."               │
│                                                          │
│     [Mark as Solution] 👍 15 upvotes                    │
│                                                          │
├─────────────────────────────────────────────────────────┤
│ 💬 Reply from: ColoradoSkier (MZ Carrier)               │
│                                                          │
│     "I live in Denver (5,280 ft) and ski regularly.     │
│      No issues as an MZ carrier. Just stay hydrated!"   │
│                                                          │
│     👍 8 upvotes                                         │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 6. Gamification & Reputation System

**Reputation Points**:

| Action                          | Points | Notes                 |
| ------------------------------- | ------ | --------------------- |
| Create helpful post             | +10    | If upvoted 5+ times   |
| Reply to post                   | +2     | Encourages engagement |
| Upvote received                 | +1     | Per upvote            |
| Expert marks answer as solution | +50    | High value            |
| Post flagged as spam            | -20    | Penalty               |
| Complete profile                | +5     | One-time bonus        |
| First post                      | +5     | Welcome bonus         |
| 100 posts milestone             | +100   | Achievement           |

**Badges**:

```
🏆 Helpful Contributor: 10+ posts marked as helpful
🌟 Expert Verified: Answered by expert, marked as solution
💯 Century Club: 100+ posts
🚀 Early Adopter: Joined in first 30 days
❤️ Caring Community: Gave 50+ upvotes to others
📚 Knowledge Seeker: Asked 10+ questions
🎓 Professor: Answered 50+ questions
👑 Top Contributor: Top 1% reputation in category
```

### 7. Search & Discovery

**Full-Text Search**:

```sql
-- Search posts by keyword
SELECT
  p.id,
  p.title,
  p.body,
  p.author_display_name,
  c.name AS category_name,
  ts_rank(p.search_vector, plainto_tsquery('english', 'augmentation therapy side effects')) AS relevance
FROM forum_posts p
JOIN forum_categories c ON p.category_id = c.id
WHERE p.search_vector @@ plainto_tsquery('english', 'augmentation therapy side effects')
  AND p.moderation_status = 'approved'
ORDER BY relevance DESC, p.last_activity_at DESC
LIMIT 20;
```

**Trending Topics**:

```typescript
interface TrendingTopic {
  categoryId: string;
  categoryName: string;
  hotPosts: {
    id: string;
    title: string;
    replyCount: number;
    viewCount: number;
    lastActivityAt: Date;
    trendingScore: number; // Weighted by recency + engagement
  }[];
}

// Calculate trending score (last 7 days)
function calculateTrendingScore(post: ForumPost): number {
  const daysSinceActivity =
    (Date.now() - post.lastActivityAt.getTime()) / (1000 * 60 * 60 * 24);
  const recencyWeight = Math.max(0, 1 - daysSinceActivity / 7); // Decay over 7 days

  const engagementScore =
    post.viewCount * 1 + post.replyCount * 10 + post.upvoteCount * 5;

  return engagementScore * recencyWeight;
}
```

---

## API Endpoints

### Core Forum APIs

```typescript
// GET /api/v1/forum/categories - List all categories
interface ListCategoriesResponse {
  categories: {
    id: string;
    name: string;
    slug: string;
    description: string;
    icon: string;
    postCount: number;
    memberCount: number;
    subcategories?: typeof this.categories;

    // Access control
    requiresGenotype?: string; // If genotype-restricted
    canAccess: boolean; // Based on current user
  }[];
}

// GET /api/v1/forum/categories/:categorySlug/posts - List posts in category
interface ListPostsRequest {
  Params: { categorySlug: string };
  Querystring: {
    sort?: 'recent' | 'popular' | 'unanswered';
    page?: number;
    limit?: number;
  };
}

interface ListPostsResponse {
  category: {
    id: string;
    name: string;
    slug: string;
  };
  posts: {
    id: string;
    title: string;
    body: string; // Truncated to 200 chars
    authorDisplayName: string;
    authorGenotype?: string; // If user consented
    authorRole: string;
    replyCount: number;
    viewCount: number;
    upvoteCount: number;
    isPinned: boolean;
    isLocked: boolean;
    hasSolution: boolean;
    createdAt: string;
    lastActivityAt: string;
  }[];
  pagination: {
    page: number;
    limit: number;
    totalPages: number;
    totalPosts: number;
  };
}

// POST /api/v1/forum/posts - Create new post
interface CreatePostRequest {
  Body: {
    categoryId: string;
    title: string;
    body: string; // Markdown
    parentPostId?: string; // If replying to existing post
  };
}

interface CreatePostResponse {
  success: boolean;
  post: {
    id: string;
    status: 'approved' | 'pending' | 'rejected';
    moderationFlags?: string[];
    createdAt: string;
  };
  message?: string; // e.g., "Your post is pending moderator approval"
}

// GET /api/v1/forum/posts/:postId - Get post with replies
interface GetPostResponse {
  post: {
    id: string;
    title: string;
    body: string;
    bodyHtml: string; // Rendered Markdown
    authorDisplayName: string;
    authorGenotype?: string;
    authorRole: string;
    categoryId: string;
    categoryName: string;
    viewCount: number;
    upvoteCount: number;
    isPinned: boolean;
    isLocked: boolean;
    isSolution: boolean;
    createdAt: string;
    updatedAt: string;
  };
  replies: (typeof this.post)[]; // Nested replies
  currentUserReaction?: string; // 'upvote', 'helpful', etc.
  canEdit: boolean;
  canDelete: boolean;
  canModerate: boolean;
}

// POST /api/v1/forum/posts/:postId/react - React to post
interface ReactToPostRequest {
  Params: { postId: string };
  Body: {
    reactionType: 'upvote' | 'helpful' | 'heart' | 'thanks';
  };
}

// POST /api/v1/forum/posts/:postId/flag - Report post
interface FlagPostRequest {
  Params: { postId: string };
  Body: {
    reason:
      | 'spam'
      | 'inappropriate'
      | 'medical_misinformation'
      | 'harassment'
      | 'other';
    details?: string;
  };
}

// GET /api/v1/forum/search - Search posts
interface SearchPostsRequest {
  Querystring: {
    q: string; // Search query
    categoryId?: string; // Filter by category
    authorUserId?: string; // Filter by author
    hasExpertAnswer?: boolean; // Only posts with expert replies
    sort?: 'relevance' | 'recent' | 'popular';
  };
}

// GET /api/v1/forum/trending - Get trending topics
interface TrendingTopicsResponse {
  trending: {
    categoryId: string;
    categoryName: string;
    posts: {
      id: string;
      title: string;
      replyCount: number;
      viewCount: number;
      trendingScore: number;
    }[];
  }[];
}

// GET /api/v1/forum/experts/schedule - Get expert Q&A schedule
interface ExpertScheduleResponse {
  sessions: {
    id: string;
    expertName: string;
    expertTitle: string;
    credentials: string;
    categoryId: string;
    categoryName: string;
    scheduledStart: string;
    scheduledEnd: string;
    status: 'scheduled' | 'live' | 'completed';
    questionCount: number;
  }[];
}

// GET /api/v1/forum/profile/:userId - Get user forum profile
interface ForumProfileResponse {
  profile: {
    userId: string;
    displayName: string;
    bio: string;
    avatarUrl: string;
    genotype?: string; // If user consented
    reputationScore: number;
    badges: string[];
    postCount: number;
    replyCount: number;
    upvotesReceived: number;
    memberSince: string;
  };
  recentPosts: {
    id: string;
    title: string;
    categoryName: string;
    createdAt: string;
  }[];
}
```

---

## Success Metrics

### Adoption

- **Active Forum Users**: 45% of total users post or comment
- **Daily Active Forum Users**: 8% of total users (600-800 DAU)
- **Posts per Day**: 150-200 organic posts
- **Expert Participation**: 85% of scheduled office hours attended

### Engagement

- **Avg Response Time**: < 2 hours for questions
- **Answer Rate**: 92% of questions receive at least one reply
- **Expert Answer Rate**: 15% of questions get expert-verified answers
- **Return Visitors**: 65% return within 7 days

### Support Deflection

- **Tickets Reduced**: 40% decrease in support tickets (from 500 to 300/month)
- **Cost Savings**: $80K/year in support costs
- **Self-Service Rate**: 70% of common questions answered in forum

### Quality

- **Spam Rate**: < 1% of posts flagged as spam
- **Moderation Accuracy**: 95% of flags correctly actioned
- **User Satisfaction**: 4.6/5 stars (forum NPS)

### Business Impact

- **Retention Lift**: 18% higher retention for forum participants
- **Engagement Lift**: 2.5x more logins/month for forum users
- **Premium Upgrade**: 22% of active forum users upgrade to premium

---

## Budget Estimate

### Development (2-3 months)

- **Backend Developer**: $140K/year × 0.25 years = $35,000
- **Frontend Developer**: $140K/year × 0.25 years = $35,000

**Total Development**: ~$70,000

### Annual Operations

- **Community Manager** (full-time): $75K/year
- **Moderator** (part-time, 20 hrs/week): $30K/year
- **Expert Stipends** (genetic counselor, doctors): $12K/year ($200/session × 60 sessions)
- **Infrastructure** (database, search): $200/month × 12 = $2,400

**Total Operations**: ~$119,400/year

### **GRAND TOTAL (First Year)**: ~$189,400

### **Cost Savings (Support Deflection)**: -$80,000/year

### **NET COST**: ~$109,400/year

---

## Risks & Mitigations

### Risk 1: Medical Misinformation

**Impact**: Dangerous health advice spreads in forum
**Mitigation**: AI + human moderation, expert verification badges, clear disclaimers ("Not medical advice")

### Risk 2: HIPAA Violations

**Impact**: Users share PII, creating compliance risk
**Mitigation**: Auto-detection of PII, no DMs, clear guidelines, user education

### Risk 3: Low Adoption

**Impact**: Forum is "ghost town" with few posts
**Mitigation**: Seed content, invite power users early, expert office hours to drive traffic

### Risk 4: Toxicity

**Impact**: Arguments, harassment, hostile environment
**Mitigation**: Strong moderation, clear community guidelines, ban repeat offenders

### Risk 5: Expert Burnout

**Impact**: Experts stop participating due to time commitment
**Mitigation**: Paid stipends, limit to 1-2 hours/month, rotate experts

---

**Document Owner**: VP Product, Community Manager
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
