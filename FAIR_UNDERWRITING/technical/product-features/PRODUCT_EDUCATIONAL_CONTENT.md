# Feature #7: Educational Content Platform

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 content developer, 1 backend developer, 1 frontend developer, 1 medical writer (contractor)

---

## Executive Summary

AATD is a rare condition that most patients and even many doctors don't fully understand. Fair Underwriting needs a comprehensive educational platform to help users understand their genotype, manage their health, and make informed decisions. This feature builds an interactive learning center with videos, articles, quizzes, and personalized learning paths.

**Key Value Propositions**:

- **Patient Education**: Comprehensive library explaining AATD, genotypes, treatment options
- **Personalized Learning**: Content tailored to user's genotype (MZ vs ZZ have different needs)
- **Gamified Learning**: Progress tracking, quizzes, certificates of completion
- **Provider Education**: Resources for doctors unfamiliar with AATD
- **Family Education**: Help users explain AATD to family members
- **Multi-Format**: Videos, articles, infographics, interactive tools

**Business Impact**:

- Increase activation by 35% (educated users more likely to complete testing)
- Improve engagement by 45% (users return to learn more)
- Reduce support burden by 25% (self-service education)
- Enable B2B sales: License content to insurance partners for employee education
- Drive telemedicine bookings: 40% who complete "Understanding Your Results" book consultation

---

## Problem Statement

### Current Gaps

**Scenario 1: Newly Diagnosed MZ Carrier Overwhelmed**

> "I just got my results: MZ genotype. The report says I'm a 'carrier.' What does that mean? Am I sick? Will I get sick? Should I change my life insurance? I've been Googling for hours and found conflicting information."

**No trusted educational resources tailored to MZ carriers** ❌

**Scenario 2: ZZ Patient Needs Treatment Education**

> "My doctor said I need 'augmentation therapy.' What is Prolastin? How does it work? What are the side effects? Will insurance cover it? I found some videos on YouTube but they're from 2010."

**No up-to-date video content explaining treatments** ❌

**Scenario 3: Family Member Wants to Understand**

> "My wife has AATD. I want to understand what she's going through so I can be supportive. All the medical articles are too technical. I need something in plain English."

**No family-friendly educational materials** ❌

**Scenario 4: Doctor Unfamiliar with AATD**

> "I'm a primary care physician. One of my patients tested positive for ZZ genotype. I've never treated AATD before. I need guidelines on monitoring, referrals, and treatment options."

**No provider-focused educational resources** ❌

**Scenario 5: User Wants to Track Learning Progress**

> "I've watched 3 videos and read 5 articles about AATD. I want to know: Have I covered all the basics? What should I learn next? Can I get a certificate to show I'm educated about my condition?"

**No learning paths or progress tracking** ❌

---

## Feature Specifications

### 1. Content Library Structure

**Content Categories**:

```
┌──────────────────────────────────────────────────────────────┐
│  📚 Education Hub                                             │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  🧬 UNDERSTANDING AATD                                       │
│  ├─ What is Alpha-1 Antitrypsin Deficiency?                 │
│  ├─ How AATD is Inherited (genetics basics)                 │
│  ├─ Genotypes Explained: MM, MZ, ZZ, SS, MS, SZ             │
│  ├─ AATD vs COPD: What's the Difference?                    │
│  ├─ Lung Disease in AATD                                     │
│  ├─ Liver Disease in AATD                                    │
│  └─ Rare Manifestations (panniculitis, vasculitis)          │
│                                                               │
│  🔬 YOUR GENOTYPE (Personalized)                            │
│  ├─ For MZ Carriers:                                         │
│  │   ├─ What Being MZ Means for Your Health                 │
│  │   ├─ Risk Factors to Monitor                             │
│  │   ├─ When to See a Specialist                            │
│  │   └─ Life Insurance & Employment Considerations          │
│  ├─ For ZZ Individuals:                                      │
│  │   ├─ Living with Severe AATD Deficiency                  │
│  │   ├─ Treatment Options & Augmentation Therapy            │
│  │   ├─ Monitoring Your Health                              │
│  │   └─ Long-Term Outlook                                   │
│  └─ For Other Variants (MS, SZ, SS)                         │
│                                                               │
│  💊 TREATMENT & MANAGEMENT                                   │
│  ├─ Augmentation Therapy: The Complete Guide                │
│  │   ├─ What is Augmentation Therapy?                       │
│  │   ├─ Prolastin vs Aralast vs Zemaira                     │
│  │   ├─ Infusion Process: What to Expect                    │
│  │   ├─ Side Effects & Management                           │
│  │   └─ Insurance Coverage & Costs                          │
│  ├─ Pulmonary Rehabilitation                                │
│  ├─ Liver Transplant Evaluation                             │
│  ├─ Oxygen Therapy                                           │
│  ├─ Smoking Cessation (Critical for AATD)                   │
│  └─ Vaccination Guidelines (flu, pneumonia, COVID)          │
│                                                               │
│  👨‍👩‍👧‍👦 FAMILY & GENETICS                                        │
│  ├─ Should My Family Get Tested?                            │
│  ├─ Explaining AATD to Children                             │
│  ├─ AATD and Pregnancy                                       │
│  ├─ Genetic Counseling: What to Expect                      │
│  └─ Family Tree & Inheritance Patterns                      │
│                                                               │
│  🏃 LIFESTYLE & WELLNESS                                     │
│  ├─ Exercise with AATD: Guidelines & Tips                   │
│  ├─ Nutrition for Lung & Liver Health                       │
│  ├─ Air Quality & Environmental Exposures                   │
│  ├─ Travel with AATD                                         │
│  ├─ Mental Health & Coping Strategies                       │
│  └─ Work & Disability Considerations                        │
│                                                               │
│  🏥 NAVIGATING HEALTHCARE                                    │
│  ├─ Finding an AATD Specialist                              │
│  ├─ Understanding Your Lab Results                          │
│  ├─ Insurance Coverage & Prior Authorization                │
│  ├─ Clinical Trials & Research Participation                │
│  └─ Advocating for Yourself                                 │
│                                                               │
│  👨‍⚕️ FOR HEALTHCARE PROVIDERS                                 │
│  ├─ AATD Screening Guidelines                               │
│  ├─ Diagnostic Workup                                        │
│  ├─ Treatment Algorithms                                     │
│  ├─ Referral Guidelines (when to refer to specialist)       │
│  └─ CME Credits Available                                   │
│                                                               │
│  📖 PATIENT STORIES                                          │
│  ├─ Living Well with MZ Genotype                            │
│  ├─ My Augmentation Therapy Journey                         │
│  ├─ From Diagnosis to Treatment                             │
│  └─ Family Cascade Testing Success                          │
│                                                               │
│  🎓 INTERACTIVE TOOLS                                        │
│  ├─ AATD Risk Calculator                                     │
│  ├─ Genotype Inheritance Simulator                          │
│  ├─ Treatment Decision Aid                                   │
│  ├─ Symptom Tracker & Journal                               │
│  └─ Quiz: Test Your AATD Knowledge                          │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

### 2. Database Schema

```sql
-- Content items (articles, videos, quizzes)
CREATE TABLE educational_content (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Content info
  title VARCHAR(300) NOT NULL,
  slug VARCHAR(300) NOT NULL, -- URL-friendly: 'what-is-mz-genotype'
  description TEXT, -- Short summary (150 chars)

  -- Content type
  content_type VARCHAR(50) NOT NULL, -- 'article', 'video', 'infographic', 'quiz', 'interactive_tool'

  -- Content body
  body TEXT, -- Markdown for articles
  body_html TEXT, -- Rendered HTML
  video_url TEXT, -- YouTube/Vimeo URL
  video_duration_seconds INTEGER, -- Video length
  video_transcript TEXT, -- Accessibility

  -- Media
  featured_image_url TEXT,
  thumbnail_url TEXT,

  -- Categorization
  category VARCHAR(100) NOT NULL, -- 'understanding_aatd', 'treatment', 'lifestyle', etc.
  subcategory VARCHAR(100),
  tags TEXT[], -- ['MZ', 'lung_health', 'smoking_cessation']

  -- Personalization
  target_genotypes VARCHAR(10)[], -- ['MZ', 'ZZ'] - show only to these genotypes
  target_audience VARCHAR(50), -- 'patient', 'caregiver', 'provider'
  difficulty_level VARCHAR(20), -- 'beginner', 'intermediate', 'advanced'

  -- Engagement
  view_count INTEGER DEFAULT 0,
  avg_rating DECIMAL(3, 2), -- 0.00 - 5.00
  rating_count INTEGER DEFAULT 0,
  completion_rate DECIMAL(5, 2), -- % who finish (for videos/articles)

  -- Learning path
  learning_path_id UUID, -- Part of structured learning path
  path_order INTEGER, -- Order within learning path
  prerequisite_content_ids UUID[], -- Must complete these first

  -- Metadata
  author_name VARCHAR(200),
  author_credentials VARCHAR(200), -- 'MD, FCCP', 'MS, CGC'
  medical_reviewer_name VARCHAR(200),
  reviewed_date DATE, -- Medical review date

  -- Publishing
  status VARCHAR(20) DEFAULT 'draft', -- 'draft', 'published', 'archived'
  published_at TIMESTAMPTZ,
  last_updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- SEO
  meta_title VARCHAR(70),
  meta_description VARCHAR(160),

  -- Search
  search_vector tsvector,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

CREATE INDEX idx_educational_content_slug ON educational_content(slug);
CREATE INDEX idx_educational_content_category ON educational_content(category, status);
CREATE INDEX idx_educational_content_genotype ON educational_content USING GIN(target_genotypes);
CREATE INDEX idx_educational_content_tags ON educational_content USING GIN(tags);
CREATE INDEX idx_educational_content_search ON educational_content USING GIN(search_vector);

-- Learning paths (structured courses)
CREATE TABLE learning_paths (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL,

  -- Path info
  title VARCHAR(300) NOT NULL,
  slug VARCHAR(300) NOT NULL,
  description TEXT,
  icon VARCHAR(50),

  -- Targeting
  target_genotypes VARCHAR(10)[],
  target_audience VARCHAR(50),

  -- Metrics
  estimated_duration_minutes INTEGER, -- Total time to complete
  content_count INTEGER, -- Number of items in path
  completion_count INTEGER DEFAULT 0, -- Number of users who completed

  -- Gamification
  certificate_enabled BOOLEAN DEFAULT false,
  certificate_template_id UUID,
  points_awarded INTEGER DEFAULT 0, -- Reputation points for completion

  -- Status
  status VARCHAR(20) DEFAULT 'draft',
  published_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- User progress tracking
CREATE TABLE user_content_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,
  content_id UUID NOT NULL,

  -- Progress
  status VARCHAR(20) DEFAULT 'not_started', -- 'not_started', 'in_progress', 'completed'
  progress_percentage INTEGER DEFAULT 0, -- 0-100

  -- Engagement
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  time_spent_seconds INTEGER DEFAULT 0,
  last_viewed_at TIMESTAMPTZ,

  -- For videos: track position
  video_position_seconds INTEGER,

  -- Rating
  user_rating INTEGER, -- 1-5 stars
  user_feedback TEXT,

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (content_id) REFERENCES educational_content(id),

  -- One progress record per user per content item
  UNIQUE(user_id, content_id)
);

CREATE INDEX idx_user_content_progress_user ON user_content_progress(user_id, status);
CREATE INDEX idx_user_content_progress_content ON user_content_progress(content_id, status);

-- Learning path progress
CREATE TABLE user_learning_path_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,
  learning_path_id UUID NOT NULL,

  -- Progress
  status VARCHAR(20) DEFAULT 'not_started',
  progress_percentage INTEGER DEFAULT 0, -- Based on completed content items
  items_completed INTEGER DEFAULT 0,
  items_total INTEGER,

  -- Timing
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  estimated_completion_date DATE, -- Based on current pace

  -- Certificate
  certificate_issued_at TIMESTAMPTZ,
  certificate_url TEXT, -- Pre-signed S3 URL to PDF certificate

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (learning_path_id) REFERENCES learning_paths(id),

  UNIQUE(user_id, learning_path_id)
);

-- Quizzes
CREATE TABLE educational_quizzes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  content_id UUID NOT NULL, -- Links to educational_content

  -- Quiz settings
  passing_score_percentage INTEGER DEFAULT 70, -- Must score 70% to pass
  max_attempts INTEGER DEFAULT 3, -- Can retake 3 times
  time_limit_seconds INTEGER, -- Optional time limit
  show_correct_answers BOOLEAN DEFAULT true, -- After submission

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (content_id) REFERENCES educational_content(id)
);

-- Quiz questions
CREATE TABLE quiz_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id UUID NOT NULL,

  -- Question
  question_text TEXT NOT NULL,
  question_type VARCHAR(20) NOT NULL, -- 'multiple_choice', 'true_false', 'multi_select'

  -- Options (for multiple choice)
  options JSONB, -- [{"id": "a", "text": "Option A"}, {"id": "b", "text": "Option B"}]
  correct_answer JSONB, -- ["a"] or ["a", "c"] for multi-select

  -- Explanation
  explanation TEXT, -- Shown after answering

  -- Metadata
  difficulty VARCHAR(20), -- 'easy', 'medium', 'hard'
  points INTEGER DEFAULT 1, -- Points awarded for correct answer
  display_order INTEGER,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (quiz_id) REFERENCES educational_quizzes(id)
);

-- Quiz attempts
CREATE TABLE user_quiz_attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  quiz_id UUID NOT NULL,

  -- Attempt info
  attempt_number INTEGER, -- 1st, 2nd, 3rd attempt

  -- Answers
  answers JSONB, -- {"question_id": "user_answer"}

  -- Score
  score_percentage DECIMAL(5, 2),
  points_earned INTEGER,
  passed BOOLEAN,

  -- Timing
  started_at TIMESTAMPTZ,
  submitted_at TIMESTAMPTZ,
  time_taken_seconds INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (quiz_id) REFERENCES educational_quizzes(id)
);

CREATE INDEX idx_quiz_attempts_user ON user_quiz_attempts(user_id, quiz_id, attempt_number);

-- Certificates
CREATE TABLE user_certificates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Certificate info
  certificate_type VARCHAR(50), -- 'learning_path_completion', 'quiz_passing', 'course_completion'
  learning_path_id UUID,
  content_id UUID,

  -- Details
  title VARCHAR(300), -- "Certificate of Completion: Understanding AATD"
  description TEXT,

  -- Verification
  certificate_number VARCHAR(50) UNIQUE, -- e.g., 'AATD-2025-001234'
  verification_url TEXT, -- Public URL to verify certificate authenticity

  -- File
  certificate_pdf_url TEXT, -- S3 URL to PDF

  -- Issuing
  issued_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ, -- Optional expiration (e.g., CME credits)

  -- Shareable
  is_shareable BOOLEAN DEFAULT true, -- User can share on LinkedIn, etc.
  share_count INTEGER DEFAULT 0,

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),
  FOREIGN KEY (learning_path_id) REFERENCES learning_paths(id),
  FOREIGN KEY (content_id) REFERENCES educational_content(id)
);

CREATE INDEX idx_user_certificates_user ON user_certificates(user_id, issued_at DESC);
```

### 3. Content Delivery System

**Personalized Homepage**:

```typescript
interface PersonalizedEducationHomepage {
  user: {
    userId: string;
    genotype: string;
    learningStreak: number; // Days in a row with activity
    totalPointsEarned: number;
    certificatesEarned: number;
  };

  recommendedForYou: {
    contentId: string;
    title: string;
    contentType: string;
    thumbnail: string;
    duration: number; // minutes
    reason: string; // "Based on your MZ genotype" or "Popular with other MZ carriers"
  }[];

  continueWatching: {
    contentId: string;
    title: string;
    progressPercentage: number;
    lastViewedAt: string;
  }[];

  learningPaths: {
    pathId: string;
    title: string;
    progressPercentage: number;
    itemsCompleted: number;
    itemsTotal: number;
    nextContentItem: {
      contentId: string;
      title: string;
    };
  }[];

  trending: {
    contentId: string;
    title: string;
    viewCount: number;
    avgRating: number;
  }[];

  achievements: {
    badgeId: string;
    badgeName: string;
    description: string;
    unlockedAt: string;
  }[];
}

// Example recommendation engine
class EducationRecommendationEngine {
  async getRecommendations(userId: string): Promise<ContentItem[]> {
    const user = await this.getUserProfile(userId);
    const recommendations: ContentItem[] = [];

    // 1. Genotype-specific content
    const genotypeContent = await this.query(
      `
      SELECT * FROM educational_content
      WHERE $1 = ANY(target_genotypes)
      AND status = 'published'
      AND id NOT IN (
        SELECT content_id FROM user_content_progress
        WHERE user_id = $2 AND status = 'completed'
      )
      ORDER BY view_count DESC
      LIMIT 5
    `,
      [user.genotype, userId]
    );

    recommendations.push(...genotypeContent);

    // 2. Collaborative filtering (users like you also watched)
    const similarUsers = await this.findSimilarUsers(userId); // Same genotype, similar engagement
    const popularAmongSimilar = await this.query(
      `
      SELECT c.*, COUNT(*) as popularity
      FROM user_content_progress ucp
      JOIN educational_content c ON ucp.content_id = c.id
      WHERE ucp.user_id = ANY($1)
      AND ucp.status = 'completed'
      AND c.id NOT IN (
        SELECT content_id FROM user_content_progress WHERE user_id = $2
      )
      GROUP BY c.id
      ORDER BY popularity DESC
      LIMIT 5
    `,
      [similarUsers.map((u) => u.id), userId]
    );

    recommendations.push(...popularAmongSimilar);

    // 3. Next logical content (based on learning paths)
    if (user.currentLearningPath) {
      const nextInPath = await this.getNextContentInPath(
        user.currentLearningPath,
        userId
      );
      if (nextInPath) {
        recommendations.unshift(nextInPath); // Prioritize
      }
    }

    // 4. Content related to recent searches
    if (user.recentSearches.length > 0) {
      const relatedContent = await this.searchByKeywords(
        user.recentSearches[0]
      );
      recommendations.push(...relatedContent.slice(0, 3));
    }

    // Deduplicate and limit
    return this.deduplicate(recommendations).slice(0, 10);
  }
}
```

### 4. Interactive Tools

**Genotype Inheritance Simulator**:

```typescript
interface InheritanceSimulator {
  parent1Genotype: 'MM' | 'MZ' | 'ZZ' | 'MS' | 'SZ' | 'SS';
  parent2Genotype: 'MM' | 'MZ' | 'ZZ' | 'MS' | 'SZ' | 'SS';

  results: {
    childGenotype: string;
    probability: number; // 0.0 - 1.0
    riskLevel: 'normal' | 'carrier' | 'deficient';
    description: string;
  }[];
}

// Example: MZ × MZ
const simulation: InheritanceSimulator = {
  parent1Genotype: 'MZ',
  parent2Genotype: 'MZ',
  results: [
    {
      childGenotype: 'MM',
      probability: 0.25,
      riskLevel: 'normal',
      description: 'Normal AAT levels, no increased risk'
    },
    {
      childGenotype: 'MZ',
      probability: 0.5,
      riskLevel: 'carrier',
      description: 'Carrier, 2-4x increased COPD risk'
    },
    {
      childGenotype: 'ZZ',
      probability: 0.25,
      riskLevel: 'deficient',
      description: 'Severe deficiency, high risk for lung/liver disease'
    }
  ]
};

// Visual Punnett square
/*
       M    Z
    ┌────┬────┐
  M │ MM │ MZ │
    ├────┼────┤
  Z │ MZ │ ZZ │
    └────┴────┘
*/
```

**AATD Risk Calculator**:

```typescript
interface RiskCalculator {
  inputs: {
    genotype: 'MM' | 'MZ' | 'ZZ';
    age: number;
    smoker: boolean;
    packYears?: number; // If smoker
    occupationalExposure: boolean; // Dust, fumes, chemicals
    familyHistoryCOPD: boolean;
    currentSymptoms: string[]; // ['shortness_of_breath', 'chronic_cough', 'wheezing']
  };

  outputs: {
    copdRiskScore: number; // 0-100
    liverDiseaseRiskScore: number; // 0-100
    recommendedActions: string[];
    urgencyLevel: 'routine' | 'moderate' | 'urgent';
  };
}

// Example calculation for MZ carrier
function calculateCOPDRisk(inputs: RiskCalculator['inputs']): number {
  let risk = 0;

  // Baseline by genotype
  if (inputs.genotype === 'MM') risk = 5; // Normal population risk
  if (inputs.genotype === 'MZ') risk = 15; // 2-4x normal
  if (inputs.genotype === 'ZZ') risk = 60; // High baseline risk

  // Smoking (MASSIVE impact)
  if (inputs.smoker) {
    risk += inputs.packYears * 2; // +2 points per pack-year
  }

  // Age
  if (inputs.age > 50) risk += 10;
  if (inputs.age > 60) risk += 15;

  // Occupational exposure
  if (inputs.occupationalExposure) risk += 15;

  // Family history
  if (inputs.familyHistoryCOPD) risk += 10;

  // Current symptoms
  risk += inputs.currentSymptoms.length * 5;

  return Math.min(risk, 100);
}

// Example output
const result: RiskCalculator['outputs'] = {
  copdRiskScore: 45, // Moderate-high risk
  liverDiseaseRiskScore: 20,
  recommendedActions: [
    'See a pulmonologist for baseline spirometry',
    'Quit smoking immediately (most important!)',
    'Get vaccinated: flu, pneumonia, COVID-19',
    'Consider genetic counseling for family members',
    'Monitor lung function annually'
  ],
  urgencyLevel: 'moderate'
};
```

**Symptom Tracker & Journal**:

```typescript
interface SymptomEntry {
  id: string;
  userId: string;
  date: Date;

  // Respiratory symptoms
  shortnessOfBreath: number; // 0-10 scale
  cough: 'none' | 'mild' | 'moderate' | 'severe';
  wheezing: boolean;
  chestTightness: boolean;
  sputumProduction: 'none' | 'clear' | 'yellow' | 'green';

  // Activity level
  stepsToday: number;
  exerciseMinutes: number;
  exerciseDifficulty: number; // 0-10

  // Environmental
  airQualityIndex: number;
  exposures: string[]; // ['dust', 'smoke', 'pollen']

  // General
  energyLevel: number; // 0-10
  moodScore: number; // 0-10
  sleepQuality: number; // 0-10

  // Medications
  medicationsTaken: string[];
  missedDoses: string[];

  // Notes
  notes: string;

  // Correlations (auto-generated)
  triggers?: string[]; // AI identifies potential triggers
}

// Visualization: Symptom trends over time
interface SymptomTrends {
  timeline: {
    date: Date;
    shortnessOfBreath: number;
    airQualityIndex: number;
    stepsToday: number;
  }[];

  insights: {
    correlations: {
      factor1: string; // 'Air Quality Index'
      factor2: string; // 'Shortness of Breath'
      correlation: number; // -1 to 1
      description: string; // "Your symptoms worsen when AQI > 100"
    }[];

    bestDays: Date[]; // Days with lowest symptoms
    worstDays: Date[]; // Days with highest symptoms

    recommendations: string[]; // "Avoid outdoor exercise on high AQI days"
  };
}
```

### 5. Video Content Production

**Video Library (50+ videos planned)**:

| Video Title                         | Duration | Target Audience | Production Status |
| ----------------------------------- | -------- | --------------- | ----------------- |
| What is AATD? (Overview)            | 5 min    | All             | ✅ Completed      |
| Understanding Your MZ Genotype      | 8 min    | MZ carriers     | ✅ Completed      |
| Living with ZZ Deficiency           | 12 min   | ZZ patients     | 🟡 In Production  |
| Augmentation Therapy Explained      | 10 min   | ZZ patients     | 🟡 In Production  |
| Your First Prolastin Infusion       | 15 min   | ZZ patients     | 📅 Planned        |
| Smoking Cessation for AATD          | 7 min    | Smokers         | ✅ Completed      |
| Exercise Guidelines for MZ Carriers | 9 min    | MZ carriers     | 📅 Planned        |
| Family Cascade Testing              | 6 min    | All             | ✅ Completed      |
| Talking to Your Doctor About AATD   | 8 min    | All             | 📅 Planned        |
| AATD and Pregnancy                  | 11 min   | Women           | 📅 Planned        |

**Video Production Workflow**:

```
Script Writing (Medical Writer)
    │
    ▼
Medical Review (Pulmonologist)
    │
    ▼
Storyboard & Graphics Design
    │
    ▼
Voice Recording (Professional narrator)
    │
    ▼
Video Editing (Motion graphics, captions)
    │
    ▼
Final Medical Review
    │
    ▼
Publish to Platform + YouTube
    │
    ▼
SEO Optimization (tags, transcript)
```

**Video Hosting**:

- **Primary**: Self-hosted (AWS S3 + CloudFront CDN)
- **Backup**: YouTube (unlisted, embedded in platform)
- **Accessibility**: Auto-generated captions + manual review, transcript provided

### 6. Gamification & Engagement

**Learning Streaks**:

```
🔥 7-Day Streak!

You've learned something new about AATD every day this week.
Keep it up!

Current Streak: 7 days
Longest Streak: 14 days

[Continue Learning] [Share Achievement]
```

**Points & Levels**:

```typescript
interface UserLearningProfile {
  userId: string;
  totalPoints: number;
  currentLevel: number; // 1-10
  pointsToNextLevel: number;

  pointsBreakdown: {
    articlesRead: number; // +10 per article
    videosWatched: number; // +15 per video
    quizzesPassed: number; // +25 per quiz
    learningPathsCompleted: number; // +100 per path
    certificatesEarned: number; // +50 per certificate
    dailyStreaks: number; // +5 per day
  };

  badges: {
    id: string;
    name: string;
    description: string;
    iconUrl: string;
    unlockedAt: Date;
  }[];
}

// Levels
const LEVELS = [
  { level: 1, pointsRequired: 0, title: 'AATD Beginner' },
  { level: 2, pointsRequired: 100, title: 'Learning Enthusiast' },
  { level: 3, pointsRequired: 250, title: 'AATD Student' },
  { level: 4, pointsRequired: 500, title: 'Knowledge Seeker' },
  { level: 5, pointsRequired: 1000, title: 'AATD Expert' },
  { level: 6, pointsRequired: 2000, title: 'Master Learner' },
  { level: 7, pointsRequired: 3500, title: 'AATD Scholar' },
  { level: 8, pointsRequired: 5000, title: 'Health Champion' },
  { level: 9, pointsRequired: 7500, title: 'AATD Ambassador' },
  { level: 10, pointsRequired: 10000, title: 'Lifelong Learner' }
];
```

**Achievements/Badges**:

```
🏅 AVAILABLE BADGES:

✅ First Steps: Complete your first article
✅ Video Viewer: Watch your first video
✅ Quiz Master: Pass 5 quizzes with 90%+ score
✅ Learning Path Pioneer: Complete your first learning path
✅ Week Warrior: Maintain a 7-day learning streak
✅ Month Master: Maintain a 30-day learning streak
✅ Knowledge Sharer: Share 3 articles with family/friends
✅ AATD Advocate: Complete "Understanding AATD" learning path
✅ Treatment Expert: Complete "Treatment Options" learning path
✅ Family Champion: Complete "Family Genetics" learning path
✅ Perfect Score: Get 100% on any quiz
✅ Speed Learner: Complete 10 pieces of content in one day
✅ Night Owl: Learn something after 10 PM
✅ Early Bird: Learn something before 6 AM
✅ Completionist: Finish 50 pieces of content
```

### 7. Certificates

**Certificate Design**:

```
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│                    [Fair Underwriting Logo]                  │
│                                                              │
│                   CERTIFICATE OF COMPLETION                  │
│                                                              │
│                 This certificate is awarded to               │
│                                                              │
│                        John Doe                              │
│                                                              │
│            For successfully completing the course            │
│                                                              │
│              "Understanding AATD: MZ Carriers"               │
│                                                              │
│                     November 7, 2025                         │
│                                                              │
│  ─────────────────────────────────────────────────────────  │
│  Reviewed by: Dr. Sarah Johnson, Genetic Counselor, MS, CGC │
│  Certificate Number: AATD-2025-001234                        │
│  Verify at: verify.fairunderwriting.com/AATD-2025-001234    │
│                                                              │
│  [QR Code]                                                   │
│                                                              │
│  [Share on LinkedIn] [Download PDF] [Print]                 │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**Shareable on LinkedIn**:

- Auto-populate LinkedIn "Add to Profile" form
- Pre-filled fields: Title, Issuing Organization, Issue Date, Credential ID, Credential URL

---

## API Endpoints

### Content Discovery APIs

```typescript
// GET /api/v1/education/home - Personalized education homepage
interface EducationHomeRequest {
  Querystring: {
    includeRecommendations?: boolean;
    includeTrending?: boolean;
  };
}

interface EducationHomeResponse {
  recommendedForYou: ContentItem[];
  continueWatching: ContentItem[];
  learningPaths: LearningPathProgress[];
  trending: ContentItem[];
  achievements: Achievement[];
  userStats: {
    totalPointsEarned: number;
    currentLevel: number;
    learningStreak: number;
    certificatesEarned: number;
  };
}

// GET /api/v1/education/content - Browse content library
interface BrowseContentRequest {
  Querystring: {
    category?: string; // 'understanding_aatd', 'treatment', etc.
    contentType?: 'article' | 'video' | 'quiz' | 'interactive_tool';
    targetGenotype?: string; // Filter by genotype
    difficulty?: 'beginner' | 'intermediate' | 'advanced';
    sort?: 'popular' | 'recent' | 'top_rated';
    page?: number;
    limit?: number;
  };
}

interface BrowseContentResponse {
  content: {
    id: string;
    title: string;
    slug: string;
    description: string;
    contentType: string;
    thumbnailUrl: string;
    duration: number; // minutes
    category: string;
    tags: string[];
    avgRating: number;
    viewCount: number;
    userProgress?: {
      status: 'not_started' | 'in_progress' | 'completed';
      progressPercentage: number;
    };
  }[];
  pagination: {
    page: number;
    limit: number;
    totalPages: number;
    totalItems: number;
  };
}

// GET /api/v1/education/content/:slug - Get content item
interface GetContentResponse {
  content: {
    id: string;
    title: string;
    slug: string;
    description: string;
    contentType: string;
    bodyHtml?: string; // For articles
    videoUrl?: string;
    videoDuration?: number;
    videoTranscript?: string;
    featuredImageUrl: string;
    category: string;
    subcategory: string;
    tags: string[];
    targetGenotypes: string[];
    targetAudience: string;
    difficultyLevel: string;
    authorName: string;
    authorCredentials: string;
    medicalReviewerName: string;
    reviewedDate: string;
    publishedAt: string;
    lastUpdatedAt: string;
    avgRating: number;
    ratingCount: number;
    viewCount: number;
  };
  userProgress: {
    status: string;
    progressPercentage: number;
    timeSpentSeconds: number;
    videoPositionSeconds?: number;
    userRating?: number;
  };
  relatedContent: ContentItem[]; // Similar content
  nextContent?: ContentItem; // If part of learning path
}

// POST /api/v1/education/content/:id/progress - Update progress
interface UpdateProgressRequest {
  Params: { id: string };
  Body: {
    status?: 'in_progress' | 'completed';
    progressPercentage?: number; // 0-100
    timeSpentSeconds?: number;
    videoPositionSeconds?: number; // For resuming videos
  };
}

// POST /api/v1/education/content/:id/rate - Rate content
interface RateContentRequest {
  Params: { id: string };
  Body: {
    rating: number; // 1-5 stars
    feedback?: string;
  };
}

// GET /api/v1/education/search - Search content
interface SearchContentRequest {
  Querystring: {
    q: string; // Search query
    filters?: {
      contentType?: string[];
      category?: string[];
      targetGenotype?: string[];
    };
  };
}

// GET /api/v1/education/learning-paths - List learning paths
interface ListLearningPathsResponse {
  paths: {
    id: string;
    title: string;
    slug: string;
    description: string;
    targetGenotypes: string[];
    estimatedDuration: number; // minutes
    contentCount: number;
    certificateEnabled: boolean;
    userProgress?: {
      status: string;
      progressPercentage: number;
      itemsCompleted: number;
      itemsTotal: number;
    };
  }[];
}

// GET /api/v1/education/learning-paths/:slug - Get learning path details
interface GetLearningPathResponse {
  path: {
    id: string;
    title: string;
    slug: string;
    description: string;
    targetGenotypes: string[];
    estimatedDuration: number;
    contentCount: number;
    certificateEnabled: boolean;
  };
  contentItems: {
    id: string;
    title: string;
    contentType: string;
    duration: number;
    order: number;
    isCompleted: boolean;
    isLocked: boolean; // If prerequisites not met
  }[];
  userProgress: {
    status: string;
    progressPercentage: number;
    itemsCompleted: number;
    itemsTotal: number;
    startedAt?: string;
    estimatedCompletionDate?: string;
  };
}

// POST /api/v1/education/quizzes/:id/attempt - Take quiz
interface TakeQuizRequest {
  Params: { id: string };
  Body: {
    answers: { [questionId: string]: string | string[] }; // Single or multiple answers
  };
}

interface TakeQuizResponse {
  attemptId: string;
  attemptNumber: number;
  scorePercentage: number;
  pointsEarned: number;
  passed: boolean;
  feedback: {
    questionId: string;
    correct: boolean;
    userAnswer: string | string[];
    correctAnswer: string | string[];
    explanation: string;
  }[];
  remainingAttempts: number;
}

// GET /api/v1/education/certificates - List user certificates
interface ListCertificatesResponse {
  certificates: {
    id: string;
    certificateNumber: string;
    title: string;
    description: string;
    issuedAt: string;
    certificatePdfUrl: string;
    verificationUrl: string;
    isShareable: boolean;
    shareCount: number;
  }[];
}

// GET /api/v1/education/profile - User learning profile
interface LearningProfileResponse {
  profile: {
    totalPoints: number;
    currentLevel: number;
    levelTitle: string;
    pointsToNextLevel: number;
    learningStreak: number;
    longestStreak: number;

    stats: {
      articlesRead: number;
      videosWatched: number;
      quizzesPassed: number;
      learningPathsCompleted: number;
      certificatesEarned: number;
      totalTimeSpent: number; // minutes
    };

    badges: {
      id: string;
      name: string;
      description: string;
      iconUrl: string;
      unlockedAt: string;
    }[];
  };

  recentActivity: {
    contentId: string;
    title: string;
    action: 'started' | 'completed' | 'rated';
    timestamp: string;
  }[];
}
```

---

## Success Metrics

### Adoption

- **Content Library Users**: 60% of registered users access education content
- **Video Views**: 8,000 video views/month (avg 2.5 videos per active user)
- **Learning Path Enrollment**: 35% of users enroll in at least one path
- **Quiz Participation**: 25% of users take quizzes

### Engagement

- **Avg Time Spent**: 15 minutes per session
- **Return Rate**: 55% return within 7 days to continue learning
- **Completion Rate**: 68% complete videos they start (industry: 40-50%)
- **Certificate Completion**: 40% who start a learning path earn certificate

### Learning Impact

- **Knowledge Improvement**: 75% score improvement on pre/post-test (same quiz before and after learning path)
- **Activation**: 35% increase in test completion for users who complete "Understanding Your Results" content
- **Telemedicine Bookings**: 40% who complete "Treatment Options" path book consultation

### Business Impact

- **Engagement Lift**: 45% more monthly logins for users who access education
- **Retention Lift**: 22% better retention for users who earn certificates
- **Support Deflection**: 25% reduction in basic support questions
- **B2B Revenue**: $50K/year licensing content to partners

---

## Budget Estimate

### Development (3-4 months)

- **Content Developer** (CMS, learning paths): $120K/year × 0.33 years = $39,600
- **Backend Developer** (APIs, progress tracking): $140K/year × 0.33 years = $46,200
- **Frontend Developer** (UI/UX, video player): $140K/year × 0.33 years = $46,200

**Total Development**: ~$132,000

### Content Production (First Year)

- **Medical Writer** (contractor, 50 articles): $150/article × 50 = $7,500
- **Video Production** (50 videos, outsourced):
  - Script writing: $300/video × 50 = $15,000
  - Voice narration: $200/video × 50 = $10,000
  - Video editing/graphics: $500/video × 50 = $25,000
  - Medical review: $200/video × 50 = $10,000
- **Infographics** (20 infographics): $300 each = $6,000
- **Quiz Development**: $100/quiz × 30 = $3,000

**Total Content Production**: ~$76,500

### Annual Operations

- **Video Hosting** (S3 + CloudFront): $400/month × 12 = $4,800
- **Content Management**: $100/month × 12 = $1,200
- **Annual Content Updates** (refresh 25% of library): $15,000
- **Medical Review** (quarterly reviews): $8,000

**Total Operations**: ~$29,000/year

### **GRAND TOTAL (First Year)**: ~$237,500

### **Ongoing (Year 2+)**: ~$44,000/year (operations + updates)

---

## Risks & Mitigations

### Risk 1: Medical Accuracy

**Impact**: Outdated or inaccurate content harms users
**Mitigation**: Quarterly medical review by pulmonologist, version control, content expiration dates

### Risk 2: Low Engagement

**Impact**: Users don't watch videos, don't complete learning paths
**Mitigation**: Gamification, personalization, short-form content (5-10 min videos), mobile-first design

### Risk 3: Content Production Delays

**Impact**: Library takes too long to build
**Mitigation**: Outsource video production, reuse existing AlphaNet Foundation content (with permission), start with most critical 20 pieces

### Risk 4: Accessibility Issues

**Impact**: Users with disabilities can't access content
**Mitigation**: All videos have captions + transcripts, screen reader compatible, WCAG 2.1 AA compliance

### Risk 5: Content Licensing

**Impact**: Copyright issues with images, videos, medical diagrams
**Mitigation**: Use licensed stock images (Shutterstock Medical), create original diagrams, cite all sources

---

**Document Owner**: VP Product, Chief Medical Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
