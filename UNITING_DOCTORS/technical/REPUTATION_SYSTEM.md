# Reputation System with Anonymous Posting

## Executive Summary

The **Reputation System** enables Uniting Doctors to maintain high-quality discourse while preserving user anonymity. This innovative approach allows healthcare professionals to post sensitive information, discuss controversial topics, and share clinical experiences without fear of professional repercussions—while still maintaining accountability through a sophisticated reputation-tracking mechanism.

**Core Value**: Foster honest, unfiltered medical discourse by decoupling identity from content while ensuring quality and accountability through reputation scores, community moderation, and behavioral analysis.

---

## Table of Contents

1. [System Overview](#system-overview)
2. [The Anonymity-Accountability Balance](#the-anonymity-accountability-balance)
3. [Reputation Score Mechanics](#reputation-score-mechanics)
4. [Anonymous Posting Framework](#anonymous-posting-framework)
5. [Identity Verification Tiers](#identity-verification-tiers)
6. [Reputation Earning & Penalties](#reputation-earning--penalties)
7. [Content Quality Signals](#content-quality-signals)
8. [Community Moderation](#community-moderation)
9. [Abuse Prevention](#abuse-prevention)
10. [Reputation Decay & Recovery](#reputation-decay--recovery)
11. [Displaying Reputation](#displaying-reputation)
12. [Technical Implementation](#technical-implementation)

---

## System Overview

### The Problem

Healthcare professionals need to:

- Discuss controversial treatments and clinical decisions
- Share mistakes and learning experiences
- Question established protocols
- Report concerns about institutions or colleagues
- Discuss off-label medication uses
- Seek advice on difficult cases without HIPAA concerns

**Barrier**: Fear of professional consequences, legal liability, or reputational damage

### The Solution

**Anonymous Posting with Reputation Tracking**:

- Users can post content anonymously
- Reputation score indicates trustworthiness without revealing identity
- Verified credentials displayed without personal information
- Behavioral patterns tracked to prevent abuse
- Community voting influences reputation

### Key Principles

1. **True Anonymity**: Platform cannot reverse-engineer identity from anonymous posts
2. **Reputation Persistence**: Reputation follows the user across anonymous posts
3. **Quality over Quantity**: Rewards thoughtful, evidence-based contributions
4. **Abuse Deterrence**: Sophisticated detection of bad actors
5. **Transparency**: Clear rules for reputation gains and losses

---

## The Anonymity-Accountability Balance

### Degrees of Anonymity

**1. Fully Identified Posts**:

- Full name, credentials, affiliation visible
- Highest trust level
- Used for: Published research, institutional statements, professional profiles

**2. Credential-Verified Anonymous**:

- Shows: "Verified Cardiologist, 15 years experience" (anonymous)
- Hides: Name, institution, location
- Shows: Reputation score (e.g., ★★★★☆ 4.2/5.0)
- Used for: Clinical discussions, case consultations

**3. Peer-Verified Anonymous**:

- Shows: "Verified Medical Professional"
- Hides: Specialty, experience level
- Shows: Reputation score
- Used for: General medical discussions

**4. Unverified Anonymous**:

- Shows: "Unverified User"
- Severely limited posting capabilities
- Used for: Questions from patients/family (separate section)

### Accountability Mechanisms

Even anonymous posts are accountable through:

1. **Reputation Impact**: Poor quality content lowers reputation
2. **Behavioral Analysis**: Pattern detection for trolls/spammers
3. **Community Moderation**: Voting and reporting
4. **Access Restrictions**: Low-reputation users have limited privileges
5. **Permanent Bans**: Severe violations result in account suspension
6. **Legal Compliance**: Reserved right to reveal identity under subpoena

---

## Reputation Score Mechanics

### Reputation Components

**Overall Reputation Score** (0-1000 points):

```
Reputation =
  Base Score (500) +
  Content Quality Score (±300) +
  Community Engagement Score (±100) +
  Peer Recognition Score (±100) +
  Behavioral Score (±100) -
  Penalties (0-500)
```

**Rating Display**:

- 0-199: ☆☆☆☆☆ (1.0/5.0) - New/Problematic
- 200-399: ★☆☆☆☆ (2.0/5.0) - Limited Trust
- 400-599: ★★☆☆☆ (3.0/5.0) - Moderate Trust
- 600-799: ★★★★☆ (4.0/5.0) - High Trust
- 800-1000: ★★★★★ (5.0/5.0) - Excellent Trust

### Multi-Dimensional Reputation

**Specialty-Specific Reputation**:

- Users build separate reputation scores per specialty
- Example: High reputation in Cardiology, moderate in Oncology

**Content-Type Reputation**:

- **Clinical Discussion**: Accuracy of diagnoses, treatment recommendations
- **Research Commentary**: Quality of literature analysis
- **Case Presentations**: Thoroughness and educational value
- **Guideline Discussions**: Evidence-based arguments

---

## Anonymous Posting Framework

### How Anonymous Posting Works

**Technical Implementation**:

1. **User Creates Anonymous Persona**:

   ```
   User Account (John Doe, MD)
   ├── Public Profile (identifiable)
   └── Anonymous Persona(s)
       ├── Anon#7392 (Verified Cardiologist)
       └── Anon#8841 (Verified Physician)
   ```

2. **Posting Flow**:

   ```
   User → Select Identity Mode → Compose Post → Submit
                ↓
          [Identified] or [Anonymous]
                ↓
   Anonymous: Persona ID + Reputation Badge
   Identified: Full name + Credentials
   ```

3. **Data Separation**:

   ```
   posts table:
   - post_id
   - user_id (encrypted, salted hash)
   - persona_id (anonymous identifier)
   - is_anonymous (boolean)
   - content
   - reputation_at_time_of_post
   ```

4. **Reputation Tracking**:
   - Votes on anonymous posts update persona's reputation
   - Reputation changes stored separately from identity
   - Aggregated metrics prevent reverse-engineering

### Anonymity Guarantees

**Technical Safeguards**:

1. **Cryptographic Separation**:

   ```python
   import hashlib
   import secrets

   def generate_anonymous_persona(user_id, persona_index):
       """
       Generate unlinkable anonymous persona ID
       """
       # Random salt per persona (stored securely)
       salt = secrets.token_bytes(32)

       # Hash user_id + persona_index + salt
       persona_hash = hashlib.pbkdf2_hmac(
           'sha256',
           f"{user_id}:{persona_index}".encode(),
           salt,
           100000  # iterations
       )

       # Generate display ID
       persona_id = f"anon_{persona_hash.hex()[:8]}"

       return {
           'persona_id': persona_id,
           'salt': salt,  # Stored in secure vault
           'user_id_hash': hashlib.sha256(str(user_id).encode()).hexdigest()
       }
   ```

2. **No IP/Device Fingerprinting** for anonymous content
3. **Metadata Scrubbing**: Remove timestamps, location data
4. **Rate Limiting**: Prevent correlation by posting patterns
5. **Secure Storage**: Anonymous linking data in encrypted vault

**Policy Safeguards**:

- Platform commits to not de-anonymizing except under legal obligation
- Transparent warrant canary system
- Regular third-party security audits
- Data minimization principles

### Multiple Anonymous Personas

**Why Allow Multiple Personas?**

- Separate work discussions from whistleblowing
- Different specialties/contexts
- Prevent cross-topic correlation

**Limits**:

- Maximum 3 anonymous personas per verified account
- Must wait 30 days between creating new personas
- Each persona has independent reputation

---

## Identity Verification Tiers

### Tier 1: Verified Medical Professional

**Requirements**:

- Medical degree (MD, DO, MBBS) verification
- Active medical license verification
- NPI number validation (US) or equivalent

**Verification Process**:

1. Upload medical license (redacted for privacy)
2. Provide NPI number or medical registration
3. Third-party verification service (e.g., Doximity, medical board lookup)
4. Email verification from institutional address

**Anonymous Display**:

```
┌─────────────────────────────────────────┐
│ 🟢 Verified Cardiologist                │
│ ★★★★☆ 4.3/5.0 (872 reputation points)  │
│ 12+ years experience                    │
│ 234 contributions                       │
└─────────────────────────────────────────┘
```

**Privileges**:

- Post in all medical discussion forums
- Vote on content quality
- Earn full reputation
- Create up to 3 anonymous personas

### Tier 2: Verified Healthcare Professional

**Requirements**:

- Nursing license (RN, NP, CRNA)
- PA license
- PharmD license
- Clinical psychology license
- Other allied health credentials

**Anonymous Display**:

```
┌─────────────────────────────────────────┐
│ 🔵 Verified Critical Care Nurse (NP)   │
│ ★★★★☆ 4.0/5.0                          │
│ 8+ years experience                     │
└─────────────────────────────────────────┘
```

**Privileges**:

- Post in relevant specialty forums
- Vote on content
- Earn reputation (capped at 800)

### Tier 3: Verified Researcher/Academic

**Requirements**:

- PhD in biomedical science
- Published research in peer-reviewed journals
- Institutional affiliation

**Anonymous Display**:

```
┌─────────────────────────────────────────┐
│ 🟡 Verified Biomedical Researcher       │
│ ★★★☆☆ 3.5/5.0                          │
│ PhD, 20+ publications                   │
└─────────────────────────────────────────┘
```

**Privileges**:

- Post in research/science forums
- Comment on clinical topics (labeled as non-clinician)
- Limited clinical forum access

### Tier 4: Verified Patient/Advocate

**Requirements**:

- Email verification
- Optional: Patient advocacy organization membership

**Display**:

```
┌─────────────────────────────────────────┐
│ ⚪ Verified Patient                      │
│ ★★☆☆☆ 2.8/5.0                          │
└─────────────────────────────────────────┘
```

**Privileges**:

- Post questions in patient Q&A section
- Cannot post in professional medical discussions
- Can read public content (not restricted discussions)

---

## Reputation Earning & Penalties

### Earning Reputation Points

**Content Quality Votes**:

- Upvote from peer: +1 point
- Upvote from high-reputation user (800+): +2 points
- Downvote: -1 point
- Accepted answer (case discussions): +15 points
- Featured post (editor's choice): +25 points

**Engagement Quality**:

- Cited by another user: +5 points
- Saved by others (per 10 saves): +2 points
- Shared externally: +3 points
- Spawns high-quality discussion: +5 points

**Content Creation**:

- Original case presentation: +10 points
- Literature review/summary: +8 points
- Clinical guideline analysis: +12 points
- Educational content: +10 points

**Peer Recognition**:

- "Expert" badge from 5 high-rep users: +50 points
- Consistent high-quality contributions: +2 per week
- Help new users (constructive comments): +1 per interaction

**Evidence-Based Contributions**:

- Cites peer-reviewed sources: +2 points
- Provides data/statistics: +2 points
- Links to clinical guidelines: +3 points

**Maximum Points per Day**: 50 (prevents gaming)

### Losing Reputation Points

**Quality Issues**:

- Low-quality post (community flagged): -5 points
- Misinformation (fact-checked, corrected): -10 points
- Anecdotal advice without evidence: -2 points
- Off-topic content: -3 points

**Behavioral Issues**:

- Personal attack/harassment: -15 points
- Spam/promotional content: -20 points
- Trolling/inflammatory comments: -10 points
- Multiple reports upheld: -5 points each

**Ethical Violations**:

- HIPAA violation (patient info shared): -100 points + ban risk
- Plagiarism: -50 points
- Fraudulent credentials: Permanent ban
- Harmful medical advice: -50 points + review

**Moderation Actions**:

- Warning from moderator: -5 points
- Temporary suspension (resolved): -25 points
- Multiple violations: Escalating penalties

### Reputation Caps & Floors

**Floor**: 0 points (cannot go negative)
**New User Start**: 500 points (neutral)
**Cap**: 1000 points
**Probation**: < 200 points (restricted privileges)

---

## Content Quality Signals

### AI-Assisted Quality Scoring

**Automated Analysis**:

```python
def calculate_content_quality_score(post):
    """
    AI-powered content quality assessment
    Returns score 0-100
    """
    score = 50  # Base score

    # 1. Medical Terminology Density
    medical_terms = extract_medical_terms(post.content)
    if len(medical_terms) > 5:
        score += 10

    # 2. Evidence-Based Content
    citations = extract_citations(post.content)
    score += min(len(citations) * 5, 20)  # Cap at +20

    # 3. Readability & Structure
    if has_clear_structure(post.content):
        score += 5
    if word_count(post.content) > 100:
        score += 5

    # 4. Sentiment Analysis
    sentiment = analyze_sentiment(post.content)
    if sentiment == 'constructive':
        score += 10
    elif sentiment == 'inflammatory':
        score -= 15

    # 5. Plagiarism Check
    if is_original_content(post.content):
        score += 10
    else:
        score -= 30

    # 6. Medical Accuracy (GPT-4 fact-check)
    accuracy = check_medical_accuracy(post.content)
    if accuracy == 'accurate':
        score += 15
    elif accuracy == 'inaccurate':
        score -= 25
    elif accuracy == 'misleading':
        score -= 35

    return max(0, min(100, score))
```

### Peer Review Signals

**"Helpful" vs. "Not Helpful"**:

- Simple binary voting
- Weighted by voter's reputation
- Aggregate determines quality

**"Endorse" Feature**:

- High-reputation users (800+) can endorse posts
- Endorsement = +15 reputation points
- Badge: "Endorsed by 3 experts"

**"Flag" System**:

- Report misinformation, spam, harassment
- Requires justification
- Multiple flags trigger manual review

---

## Community Moderation

### Volunteer Moderators

**Selection**:

- Reputation > 850
- Active for 6+ months
- No recent violations
- Specialty expertise

**Responsibilities**:

- Review flagged content
- Remove rule violations
- Issue warnings
- Temporary suspensions (< 7 days)

**Powers**:

- Delete posts/comments
- Lock threads
- Adjust reputation (±10 points)
- Issue official warnings

### Moderation Queue

**Priority Levels**:

1. **Urgent**: HIPAA violations, dangerous advice, harassment
2. **High**: Misinformation, spam, off-topic
3. **Normal**: Quality issues, minor violations
4. **Low**: User reports requiring review

**Moderation Actions**:

```typescript
enum ModAction {
  APPROVE = 'approve',
  REMOVE = 'remove',
  WARN = 'warn',
  SUSPEND = 'suspend',
  BAN = 'ban',
  REQUIRE_EDIT = 'require_edit'
}

interface ModerationAction {
  contentId: string;
  action: ModAction;
  reason: string;
  moderatorId: string;
  reputationAdjustment: number;
  timestamp: Date;
}
```

### Community Guidelines Enforcement

**Strike System**:

- 1st Violation: Warning (-5 reputation)
- 2nd Violation: 24-hour suspension (-15 reputation)
- 3rd Violation: 7-day suspension (-30 reputation)
- 4th Violation: 30-day suspension (-50 reputation)
- 5th Violation: Permanent ban

**Appeals Process**:

- User can appeal within 7 days
- Reviewed by different moderator
- Senior moderator arbitration if needed

---

## Abuse Prevention

### Detecting Bad Actors

**Sockpuppet Detection**:

```python
def detect_sockpuppets(user_id):
    """
    Detect multiple accounts by same person
    """
    signals = {
        'writing_style': compare_writing_style(user_id),
        'posting_times': analyze_posting_patterns(user_id),
        'topic_overlap': check_topic_similarity(user_id),
        'voting_patterns': detect_vote_manipulation(user_id),
        'network_analysis': graph_based_detection(user_id)
    }

    suspicion_score = calculate_suspicion(signals)

    if suspicion_score > 0.8:
        flag_for_manual_review(user_id, signals)

    return suspicion_score
```

**Vote Manipulation Detection**:

- Identify coordinated upvoting/downvoting
- Detect vote rings (mutual upvoting)
- Anomaly detection in voting patterns
- Penalize participants (reputation loss + suspension)

**Spam Detection**:

- Repetitive content across posts
- External link patterns
- Promotional language detection
- Automated content detection

### Rate Limiting

**Anonymous Posting Limits**:

- New accounts: 5 posts/day, 20 comments/day
- Reputation 200-400: 10 posts/day, 50 comments/day
- Reputation 400-600: 20 posts/day, 100 comments/day
- Reputation 600+: 50 posts/day, unlimited comments

**Voting Limits**:

- 100 votes/day per user
- Cannot vote on same user's content more than 10 times/day

**Flagging Limits**:

- 20 flags/day
- Excessive false flags result in flag privilege suspension

---

## Reputation Decay & Recovery

### Time-Based Decay

**Inactive Users**:

- No decay for first 6 months of inactivity
- After 6 months: -1 point/week
- Stops at 400 points (prevents complete loss)

**Outdated Content**:

- Posts >2 years old have reduced impact on reputation
- Encourages ongoing contribution

### Reputation Recovery

**For Low-Reputation Users**:

- Grace period: First 30 days, only positive actions count
- Mentorship program: Paired with high-rep user for guidance
- Education: Required to complete "Community Guidelines" course
- Bonus points: Double points for first 10 high-quality contributions

**After Suspension**:

- Reputation frozen during suspension
- Upon return: 30-day probation (monitored closely)
- Can earn reputation normally, but threshold for violations is lower

---

## Displaying Reputation

### Reputation Badges

**Visual Indicators**:

```
★★★★★ Trusted Expert (900-1000)
★★★★☆ Highly Trusted (750-899)
★★★☆☆ Trusted (600-749)
★★☆☆☆ Established (400-599)
★☆☆☆☆ New Member (200-399)
☆☆☆☆☆ Limited Trust (0-199)
```

**Specialty Badges**:

```
🫀 Cardiology Expert (800+ in Cardiology)
🫁 Pulmonology Expert
🧠 Neurology Expert
...
```

**Achievement Badges**:

- 🏆 Top Contributor (most helpful answers this month)
- 📚 Scholar (100+ cited sources)
- 🎓 Educator (50+ educational posts)
- 🔬 Researcher (50+ research paper discussions)
- 🌟 Rising Star (fastest reputation growth)

### Profile Display

**Anonymous Persona Profile**:

```
┌──────────────────────────────────────────────────────┐
│  Anon#7392                                           │
│  🟢 Verified Cardiologist                            │
│  ★★★★☆ 4.4/5.0 (876 reputation points)              │
│                                                      │
│  Joined: 2 years ago                                │
│  Experience: 12+ years in practice                  │
│  Contributions: 342 posts, 1,289 comments           │
│  Helpful votes: 2,456                               │
│                                                      │
│  Top Topics:                                        │
│  • Heart Failure (234 posts, 4.6 avg rating)       │
│  • Arrhythmias (89 posts, 4.3 avg rating)          │
│  • Interventional Cardiology (42 posts, 4.5 rating)│
│                                                      │
│  Badges:                                            │
│  🫀 Cardiology Expert                               │
│  🏆 Top Contributor (March 2025)                    │
│  📚 Scholar (142 citations)                         │
└──────────────────────────────────────────────────────┘
```

---

## Technical Implementation

### Database Schema

**Users Table**:

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  credentials VARCHAR(100),
  verification_tier INT,
  created_at TIMESTAMP,
  last_active TIMESTAMP
);
```

**Anonymous Personas Table**:

```sql
CREATE TABLE anonymous_personas (
  persona_id VARCHAR(50) PRIMARY KEY,
  user_id_hash VARCHAR(64) NOT NULL, -- SHA-256 hash
  persona_index INT NOT NULL,
  salt BYTEA NOT NULL, -- Cryptographic salt
  verification_tier INT,
  specialty VARCHAR(100),
  years_experience INT,
  created_at TIMESTAMP,
  CONSTRAINT unique_user_persona UNIQUE (user_id_hash, persona_index)
);
```

**Reputation Table**:

```sql
CREATE TABLE reputation_scores (
  persona_id VARCHAR(50) PRIMARY KEY,
  total_score INT DEFAULT 500,
  content_quality_score INT DEFAULT 0,
  engagement_score INT DEFAULT 0,
  peer_recognition_score INT DEFAULT 0,
  behavioral_score INT DEFAULT 0,
  penalties INT DEFAULT 0,
  last_updated TIMESTAMP,
  FOREIGN KEY (persona_id) REFERENCES anonymous_personas(persona_id)
);
```

**Specialty Reputation Table**:

```sql
CREATE TABLE specialty_reputation (
  id UUID PRIMARY KEY,
  persona_id VARCHAR(50),
  specialty VARCHAR(100),
  score INT DEFAULT 500,
  post_count INT DEFAULT 0,
  average_rating DECIMAL(3,2),
  FOREIGN KEY (persona_id) REFERENCES anonymous_personas(persona_id),
  CONSTRAINT unique_persona_specialty UNIQUE (persona_id, specialty)
);
```

**Posts Table**:

```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY,
  persona_id VARCHAR(50),
  is_anonymous BOOLEAN DEFAULT FALSE,
  content TEXT NOT NULL,
  specialty VARCHAR(100),
  quality_score INT,
  upvotes INT DEFAULT 0,
  downvotes INT DEFAULT 0,
  reputation_at_post_time INT,
  created_at TIMESTAMP,
  edited_at TIMESTAMP,
  FOREIGN KEY (persona_id) REFERENCES anonymous_personas(persona_id)
);
```

**Reputation Events Table** (Audit Log):

```sql
CREATE TABLE reputation_events (
  id UUID PRIMARY KEY,
  persona_id VARCHAR(50),
  event_type VARCHAR(50), -- 'upvote', 'downvote', 'flag', 'endorsement', 'penalty'
  points_change INT,
  reason TEXT,
  source_post_id UUID,
  created_at TIMESTAMP,
  FOREIGN KEY (persona_id) REFERENCES anonymous_personas(persona_id)
);
```

### Reputation Calculation Service

```python
class ReputationService:
    def __init__(self, db):
        self.db = db

    async def update_reputation(self, persona_id, event_type, points_change, reason):
        """
        Update persona's reputation score
        """
        # Get current reputation
        current = await self.db.reputation_scores.find_one(
            {'persona_id': persona_id}
        )

        if not current:
            # Initialize reputation for new persona
            current = {
                'persona_id': persona_id,
                'total_score': 500,
                'content_quality_score': 0,
                'engagement_score': 0,
                'peer_recognition_score': 0,
                'behavioral_score': 0,
                'penalties': 0
            }

        # Apply change to appropriate category
        if event_type in ['upvote', 'downvote', 'quality_flag']:
            current['content_quality_score'] += points_change
        elif event_type in ['citation', 'save', 'share']:
            current['engagement_score'] += points_change
        elif event_type in ['endorsement', 'expert_badge']:
            current['peer_recognition_score'] += points_change
        elif event_type in ['warning', 'suspension', 'violation']:
            current['penalties'] += abs(points_change)

        # Calculate total score
        total_score = (
            500 +  # Base score
            current['content_quality_score'] +
            current['engagement_score'] +
            current['peer_recognition_score'] +
            current['behavioral_score'] -
            current['penalties']
        )

        # Clamp to [0, 1000]
        total_score = max(0, min(1000, total_score))
        current['total_score'] = total_score
        current['last_updated'] = datetime.now()

        # Update database
        await self.db.reputation_scores.update_one(
            {'persona_id': persona_id},
            {'$set': current},
            upsert=True
        )

        # Log event
        await self.db.reputation_events.insert_one({
            'persona_id': persona_id,
            'event_type': event_type,
            'points_change': points_change,
            'reason': reason,
            'created_at': datetime.now()
        })

        return total_score

    async def get_reputation_badge(self, persona_id):
        """
        Get visual reputation badge for display
        """
        reputation = await self.db.reputation_scores.find_one(
            {'persona_id': persona_id}
        )

        score = reputation['total_score'] if reputation else 500

        if score >= 900:
            return {'stars': 5, 'label': 'Trusted Expert', 'rating': 5.0}
        elif score >= 750:
            return {'stars': 5, 'label': 'Highly Trusted', 'rating': 4.5}
        elif score >= 600:
            return {'stars': 4, 'label': 'Trusted', 'rating': 4.0}
        elif score >= 400:
            return {'stars': 3, 'label': 'Established', 'rating': 3.0}
        elif score >= 200:
            return {'stars': 2, 'label': 'New Member', 'rating': 2.0}
        else:
            return {'stars': 1, 'label': 'Limited Trust', 'rating': 1.0}
```

---

## Conclusion

The Reputation System enables Uniting Doctors to foster honest, high-quality medical discourse while protecting user anonymity. By decoupling identity from reputation and implementing sophisticated abuse prevention, we create an environment where healthcare professionals can share openly without fear of professional repercussions.

**Success Metrics**:

- **Active Anonymous Contributors**: 60% of verified users post anonymously
- **Content Quality**: Average quality score > 75/100
- **Abuse Rate**: < 2% of anonymous posts flagged
- **User Trust**: 85% of users trust anonymous content from high-reputation sources

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Product & Technical Teams
**Related Documents**:

- [COMMUNITY_GUIDELINES.md](../operations/COMMUNITY_GUIDELINES.md)
- [CONTENT_MODERATION.md](../operations/CONTENT_MODERATION.md)
- [ANONYMITY_FRAMEWORK.md](../legal/ANONYMITY_FRAMEWORK.md)
