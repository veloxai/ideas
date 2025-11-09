# User Flows

## Executive Summary

The **User Flows** document maps user journeys through Uniting Doctors, from first visit to engaged community member. These flows optimize for professional credibility, medical accuracy, and efficient information discovery while preserving anonymity.

---

## Core User Personas

### 1. Dr. Academic (Research-Focused Physician)

- **Goals**: Share research, discover cutting-edge studies, engage in evidence-based discussions
- **Pain Points**: Traditional journals slow, wants real-time feedback, needs visibility
- **Behavior**: Posts research summaries, cites extensively, engages in deep technical discussions

### 2. Dr. Community (Community Hospital Physician)

- **Goals**: Practical advice for common cases, learn from peers, quick clinical pearls
- **Pain Points**: Limited specialist access, time constraints, needs actionable information
- **Behavior**: Asks questions, upvotes practical answers, follows relevant specialties

### 3. Dr. Specialist (Academic Tertiary Center)

- **Goals**: Answer complex questions, establish reputation, stay current in niche area
- **Pain Points**: Wants to help but time-limited, needs recognition for expertise
- **Behavior**: Answers questions in specialty, shares complex cases, selective engagement

### 4. Dr. Resident (Training Physician)

- **Goals**: Learn rapidly, prepare for exams, understand real-world practice
- **Pain Points**: Information overload, uncertain about quality, imposter syndrome
- **Behavior**: Searches extensively, reads more than posts, saves content, asks clarifying questions

---

## Onboarding Flow

### A. New User Journey (Account Creation → First Post)

```
┌─────────────────────────────────────────────────────┐
│                   LANDING PAGE                      │
│  "Where doctors share real medicine, anonymously"  │
│                                                     │
│  [Sign Up] [See Example Discussions]               │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              REGISTRATION SCREEN                    │
│                                                     │
│  Email: ___________________________________         │
│  Password: _________________________________        │
│                                                     │
│  ☑ I am a licensed healthcare professional         │
│                                                     │
│  [Create Account]                                   │
│                                                     │
│  Why verify? Ensures quality discussions.           │
│  Your identity is never public.                     │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            VERIFICATION SCREEN                      │
│                                                     │
│  Upload Verification Document:                      │
│  • Medical license                                  │
│  • DEA certificate                                  │
│  • Hospital ID badge                                │
│                                                     │
│  OR                                                 │
│                                                     │
│  Enter NPI Number: __________                       │
│  [Auto-Verify]                                      │
│                                                     │
│  🔒 Encrypted • Deleted after 30 days               │
│                                                     │
│  [Skip for Now] [Submit]                            │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            PROFILE SETUP SCREEN                     │
│                                                     │
│  What should we call you?                           │
│  Display Name: ______________ (anonymous)           │
│                                                     │
│  Specialty:                                         │
│  ☐ Internal Medicine  ☐ Surgery                    │
│  ☐ Pediatrics         ☐ Anesthesiology             │
│  [+ More]                                           │
│                                                     │
│  Practice Setting:                                  │
│  ☐ Academic Medical Center                         │
│  ☐ Community Hospital                               │
│  ☐ Private Practice                                 │
│  ☐ Resident/Fellow                                  │
│                                                     │
│  [Continue]                                         │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            INTEREST SELECTION                       │
│                                                     │
│  What topics interest you?                          │
│                                                     │
│  [#Cardiology] [#Sepsis] [#Diabetes]                │
│  [#Anticoagulation] [#Difficult Airway]             │
│  [#Palliative Care] [+ Browse All]                  │
│                                                     │
│  Follow specialties for personalized feed:          │
│  ☐ Emergency Medicine                               │
│  ☐ Critical Care                                    │
│  ☐ Infectious Disease                               │
│                                                     │
│  [Finish Setup]                                     │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            WELCOME TO YOUR FEED                     │
│                                                     │
│  ✨ Get Started Challenges:                         │
│  ☐ Read 3 discussions (0/3) +10 rep                │
│  ☐ Make your first comment +25 rep                  │
│  ☐ Ask a question +15 rep                           │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  📰 Top Discussion Today                            │
│  "Novel approach to refractory AFib..."             │
│  👤 CardioDoc1234 • 2h ago • 234 ⬆                  │
│                                                     │
│  📚 Research: NEJM just published                   │
│  "SGLT2 inhibitors in heart failure..."            │
│  🔗 Read Paper • 🗨 45 comments                      │
│                                                     │
│  [Write a post] [Ask a question]                    │
└─────────────────────────────────────────────────────┘
```

**Key Decisions**:

- **Early vs Late Verification**: Collect email early, allow exploration before verification
- **Anonymous from Start**: No real names ever displayed
- **Interest-Driven**: Personalized feed immediately
- **Gamification**: Challenges encourage first actions

---

## Core Content Flows

### B. Asking a Question Flow

```
User Action: Click [Ask a Question]
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              QUESTION COMPOSER                      │
│                                                     │
│  Title (concise, specific)                          │
│  ________________________________________________   │
│                                                     │
│  Question Details (full context)                    │
│  ┌──────────────────────────────────────────────┐  │
│  │ Patient: 45M with chest pain, no cardiac... │  │
│  │                                              │  │
│  │ Labs: Troponin negative, EKG shows...       │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ⚠️ PHI Check: No patient names/MRNs detected ✓     │
│                                                     │
│  Tags:                                              │
│  [#Emergency-Medicine] [#Cardiology] [+ Add Tag]    │
│                                                     │
│  Evidence Level: ☐ Case-based  ☐ Research Q        │
│                                                     │
│  [Preview] [Post Question]                          │
│                                                     │
│  Tips:                                              │
│  • Include relevant labs/imaging                    │
│  • Specify what you've tried                        │
│  • Tag appropriate specialties                      │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            QUESTION POSTED                          │
│                                                     │
│  ✓ Question posted successfully!                    │
│                                                     │
│  👥 Notified:                                       │
│  • 234 Emergency Medicine followers                 │
│  • 89 Cardiology followers                          │
│                                                     │
│  💡 Tip: Upvote helpful answers to thank experts    │
│                                                     │
│  [View Question] [Ask Another]                      │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            QUESTION PAGE                            │
│                                                     │
│  "45M with atypical chest pain - stress test?"      │
│  Asked by You • Just now                            │
│                                                     │
│  [Full question details...]                         │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  💬 Answers (0)                                     │
│                                                     │
│  "Be the first to answer..."                        │
│                                                     │
│  [Follow Question] [Share] [Edit]                   │
└─────────────────────────────────────────────────────┘
```

**15 minutes later...**

```
Notification: 🔔 EmergencyDoc89 answered your question
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│            QUESTION WITH ANSWER                     │
│                                                     │
│  💬 Answers (1)                                     │
│                                                     │
│  ▲234 ✓ EmergencyDoc89 • 980 reputation            │
│  │      ⚕️ Verified: Emergency Medicine             │
│  │                                                  │
│  │  "Given negative troponin and atypical          │
│  │  features, consider PERC rule for PE            │
│  │  risk stratification..."                        │
│  │                                                  │
│  │  [1] JAMA 2008;299(22):2463 (PERC rule)        │
│  │  [2] Circulation 2011;123:e369 (UA/NSTEMI)     │
│  │                                                  │
│  └─ [Reply] [Upvote] [Accept Answer]                │
│                                                     │
│  💡 Accept this answer if it solved your question   │
└─────────────────────────────────────────────────────┘
```

**Key Features**:

- **PHI Detection**: Automated check before posting
- **Tag Suggestions**: ML suggests relevant specialties
- **Notification Routing**: Alerts targeted experts
- **Accept Answer**: Signals resolution, rewards answerer

---

### C. Sharing Research Flow

```
User discovers paper → Shares to platform
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              SHARE RESEARCH                         │
│                                                     │
│  Import from PubMed:                                │
│  PMID: _________ [Fetch]                            │
│                                                     │
│  OR paste DOI:                                      │
│  DOI: _________ [Fetch]                             │
│                                                     │
│  OR enter manually:                                 │
│  Title: _______________________________________     │
│  Authors: _____________________________________     │
│  Journal: _________________ Year: _______           │
└─────────────────────────────────────────────────────┘
                      │ (Fetches metadata)
                      ▼
┌─────────────────────────────────────────────────────┐
│              ADD COMMENTARY                         │
│                                                     │
│  📄 NEJM 2024: "SGLT2 Inhibitors in HFpEF"          │
│  Johnson et al. | PMID: 12345678                    │
│                                                     │
│  Your Take (optional):                              │
│  ┌──────────────────────────────────────────────┐  │
│  │ This changes my practice for HFpEF patients  │  │
│  │ with DM. Key takeaway: 25% mortality         │  │
│  │ reduction with empagliflozin...              │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  Clinical Relevance:                                │
│  ☑ Changes practice                                 │
│  ☐ Controversial finding                            │
│  ☐ Confirms existing evidence                       │
│                                                     │
│  Tags: [#Cardiology] [#Heart-Failure] [#SGLT2]      │
│                                                     │
│  [Post to Feed]                                     │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              RESEARCH POST (FEED)                   │
│                                                     │
│  👤 CardiologyDoc2024 • 1h ago                      │
│  ⚕️ Verified: Cardiology                            │
│                                                     │
│  📄 NEJM 2024: "SGLT2 Inhibitors in HFpEF"          │
│                                                     │
│  "This changes my practice for HFpEF patients..."   │
│                                                     │
│  🔗 [Read Full Text] (Open Access via Unpaywall)    │
│  📊 [View Figures]                                  │
│                                                     │
│  Evidence: Level 1a (Systematic Review)             │
│                                                     │
│  ▲ 189 ⬆  💬 34 comments  🔖 Save  📤 Share         │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  Top Comment by NephroExpert:                       │
│  "Important to note CKD subgroup analysis..."       │
└─────────────────────────────────────────────────────┘
```

**Key Features**:

- **Automated Metadata**: Fetches paper details from PubMed
- **Open Access Detection**: Unpaywall API finds free versions
- **Evidence Tagging**: Classifies study type
- **Clinical Relevance**: Signals practice-changing findings

---

### D. Discovering Content Flow

```
User searches: "refractory septic shock"
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              SEARCH RESULTS                         │
│                                                     │
│  "refractory septic shock"                          │
│  ───────────────────────────────────────────────    │
│                                                     │
│  Filter: [All] [Questions] [Research] [Cases]       │
│  Sort: [Relevance] [Recent] [Most Voted]            │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  🔥 Top Result                                      │
│  "Methylene blue in distributive shock"             │
│  👤 ICU_Intensivist • 456 ⬆ • 89 comments           │
│  Evidence: Level 1b (RCT)                           │
│  ⚕️ Verified: Critical Care                         │
│                                                     │
│  Excerpt: "...vasopressin-refractory shock,         │
│  consider methylene blue 1-2mg/kg..."               │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  📄 Recent Research                                 │
│  "Angiotensin II in Septic Shock (ATHOS-3)"        │
│  NEJM 2023 • 234 citations • Shared 45 times        │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  💬 Question                                        │
│  "Patient on 4 pressors, pH 6.9 - ECMO?"           │
│  Asked 2d ago • 23 answers                          │
│                                                     │
│  [Load More Results]                                │
└─────────────────────────────────────────────────────┘
```

**Hybrid Search** (Elasticsearch + Semantic):

1. Keyword match: "septic shock", "refractory"
2. Semantic expansion: Related terms (distributive shock, vasoplegic)
3. Ranking: Reputation + recency + votes + relevance

---

### E. Building Reputation Flow

```
New User (0 reputation) → Engaged Expert (1000+ reputation)

Action Taken                    Reputation Change
──────────────────────────────────────────────────
Account verified                     +50
First quality post                   +25
Post receives upvote                 +10
Post heavily upvoted (50+)          +100
Answer accepted                      +50
Question receives upvote             +5
Comment receives upvote              +2
Research shared (cited)             +15
──────────────────────────────────────────────────
Cumulative: 1000+ → Trusted Expert
```

**Reputation Milestones**:

```
┌─────────────────────────────────────────────────────┐
│              REPUTATION MILESTONES                  │
│                                                     │
│  Your Reputation: 1,240                             │
│  Rank: Trusted Expert (Top 5%)                      │
│                                                     │
│  ████████████░░░░░░░░                               │
│  Next: Senior Expert (1,500)                        │
│                                                     │
│  Unlocked Privileges:                               │
│  ✓ Vote on posts (50 rep)                           │
│  ✓ Comment anywhere (100 rep)                       │
│  ✓ Edit community wiki (500 rep)                    │
│  ✓ Vote to close low-quality (1,000 rep)            │
│  ⏳ Access moderation tools (1,500 rep)              │
│                                                     │
│  Recent Activity:                                   │
│  • Answer accepted: +50                             │
│  • Post upvoted 8x: +80                             │
│  • Research cited by 5 users: +75                   │
└─────────────────────────────────────────────────────┘
```

**Key Gamification**:

- **Clear Progress**: Visual reputation bar
- **Privilege Unlocks**: New abilities motivate engagement
- **Transparency**: Show how reputation was earned

---

## Moderation Flows

### F. Reporting Content Flow

```
User sees problematic post → Reports
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              REPORT CONTENT                         │
│                                                     │
│  Why are you reporting this?                        │
│                                                     │
│  ☐ Medical misinformation                           │
│  ☐ Spam or advertising                              │
│  ☐ Harassment or abuse                              │
│  ☐ Patient privacy violation (PHI)                  │
│  ☐ Off-topic / Low quality                          │
│  ☐ Other: __________________                        │
│                                                     │
│  Additional context (optional):                     │
│  ┌──────────────────────────────────────────────┐  │
│  │ This recommends stopping insulin for T1DM   │  │
│  │ patients, which is dangerous advice.        │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  [Cancel] [Submit Report]                           │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              REPORT SUBMITTED                       │
│                                                     │
│  ✓ Thank you for helping keep the community safe    │
│                                                     │
│  Your report has been submitted to moderators.      │
│  We'll review within 24 hours.                      │
│                                                     │
│  Report ID: #REP-45782                              │
│                                                     │
│  [Track Report Status]                              │
└─────────────────────────────────────────────────────┘
                      │
                      ▼ (Moderator Review)
┌─────────────────────────────────────────────────────┐
│            MODERATION QUEUE                         │
│                                                     │
│  Report #REP-45782                                  │
│  Type: Medical Misinformation                       │
│  Reported by: User #12345 (450 rep)                 │
│  Post by: AnonymousDoc789 (120 rep)                 │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  Reported Content:                                  │
│  "For Type 1 diabetics, try stopping insulin..."   │
│                                                     │
│  Reporter Note:                                     │
│  "Dangerous advice - T1DM requires insulin"         │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  Moderator Actions:                                 │
│  [Remove Post] [Issue Warning] [Dismiss Report]     │
│  [Ban User] [Request Peer Review]                   │
│                                                     │
│  Similar Past Reports: 2 (same user)                │
│  AI Risk Score: HIGH (0.89)                         │
└─────────────────────────────────────────────────────┘
                      │ (Moderator removes post)
                      ▼
┌─────────────────────────────────────────────────────┐
│              REMOVAL NOTIFICATION                   │
│                                                     │
│  Your post was removed                              │
│                                                     │
│  Reason: Dangerous medical misinformation           │
│                                                     │
│  Specific Issue:                                    │
│  Recommending discontinuation of life-saving        │
│  medication (insulin for Type 1 diabetes)           │
│  violates Community Guidelines § 3.2                │
│                                                     │
│  This is your 1st violation.                        │
│  Reputation: -50 points                             │
│                                                     │
│  Further violations may result in suspension.       │
│                                                     │
│  [Appeal Decision] [Acknowledge]                    │
└─────────────────────────────────────────────────────┘
```

**Key Features**:

- **Fast Reporting**: 2-click process
- **Moderator Context**: AI risk score + past reports
- **User Education**: Explain why content removed
- **Appeal Process**: Fair dispute resolution

---

## Mobile Experience Flows

### G. Mobile App Navigation

```
┌──────────────────────┐
│  📱 MOBILE APP       │
│                      │
│  ╔═══════════════╗   │
│  ║ Uniting Doctors║   │
│  ╚═══════════════╝   │
│                      │
│  🏠 For You          │
│  ──────────────────  │
│  📰 Post 1           │
│  ⬆189 💬34 🔖        │
│  ──────────────────  │
│  📰 Post 2           │
│  ⬆234 💬67 🔖        │
│  ──────────────────  │
│                      │
│  [➕ Quick Post]     │
│                      │
│  ──────────────────  │
│  🏠 Feed             │
│  🔍 Search           │
│  🔔 Notifications    │
│  👤 Profile          │
└──────────────────────┘
```

**Mobile-Optimized Features**:

- **Swipe Actions**: Swipe right to upvote, left to save
- **Tap to Expand**: Collapsed long posts
- **Voice Input**: Dictate questions (hands-free for busy clinicians)
- **Offline Mode**: Cache recent content, sync when online
- **Push Notifications**: Critical updates, answered questions

---

## Advanced Flows

### H. Creating a Clinical Series

```
Expert wants to create multi-part educational content
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              CREATE SERIES                          │
│                                                     │
│  Series Title:                                      │
│  "Anticoagulation Mastery: 10-Part Series"          │
│                                                     │
│  Description:                                       │
│  "Comprehensive guide to anticoagulation            │
│  management in complex scenarios..."                │
│                                                     │
│  Planned Posts:                                     │
│  1. Introduction to DOACs vs Warfarin               │
│  2. Managing bleeding complications                 │
│  3. Bridging strategies                             │
│  4. Special populations (CKD, liver disease)        │
│  [+ Add More]                                       │
│                                                     │
│  Publishing Schedule:                               │
│  ☑ Weekly (every Monday)                            │
│                                                     │
│  [Create Series]                                    │
└─────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────┐
│              SERIES LANDING PAGE                    │
│                                                     │
│  📚 Anticoagulation Mastery                         │
│  by AnticoagExpert (2,300 rep)                      │
│                                                     │
│  10 parts • 234 followers • 45 hours content        │
│                                                     │
│  [Follow Series]                                    │
│                                                     │
│  ──────────────────────────────────────────         │
│                                                     │
│  ✅ Part 1: Introduction to DOACs (Published)       │
│  ⏳ Part 2: Bleeding complications (Next Monday)    │
│  📝 Part 3: Bridging strategies (Draft)             │
│  [ ] Part 4-10: Coming soon                         │
│                                                     │
│  💬 Discussion Forum (67 comments)                  │
└─────────────────────────────────────────────────────┘
```

**Series Benefits**:

- **Structured Learning**: Follow educational paths
- **Reputation Boost**: High-quality series = major reputation
- **Notifications**: Followers alerted to new parts
- **Discoverability**: Series featured in platform

---

## Success Metrics per Flow

### Onboarding

- **Activation Rate**: 70% complete profile setup
- **Time to First Action**: <5 minutes
- **Verification Rate**: 85% verify within 7 days

### Content Creation

- **Daily Active Posters**: 5% of users
- **Questions Answered**: 80% within 24 hours
- **Research Shared**: 50+ papers daily

### Discovery

- **Search Success**: 90% find relevant content in 3 clicks
- **Time on Platform**: 15 min avg per session
- **Return Rate**: 60% weekly active users

### Moderation

- **Report Response**: 90% reviewed within 24 hours
- **False Reports**: <5%
- **User Appeals**: 20% of removals appealed, 15% overturned

---

## Accessibility Flows

### I. Screen Reader Experience

```
VoiceOver/JAWS User Navigation:
                      │
                      ▼
"Main navigation landmark"
  ├─ "Link: Home Feed"
  ├─ "Link: Search"
  ├─ "Link: Notifications, 3 unread"
  └─ "Link: Profile"
                      │
                      ▼
"Article: Post by CardioDoc1234"
  ├─ "Heading level 2: Novel approach to refractory AFib"
  ├─ "Posted 2 hours ago"
  ├─ "234 upvotes"
  ├─ "Button: Upvote post"
  ├─ "Button: Comment"
  └─ "Link: Read 45 comments"
```

**Keyboard Navigation**:

- `Tab`: Navigate focusable elements
- `Enter`: Activate buttons/links
- `Space`: Upvote (on vote button)
- `Shift+Tab`: Navigate backwards
- `Esc`: Close modals
- `/`: Focus search bar

---

## Conclusion

These user flows optimize for:

- **Rapid Onboarding**: Get users engaged quickly
- **Effortless Discovery**: Find relevant content easily
- **Quality Content Creation**: Tools for detailed, evidence-based posts
- **Reputation Building**: Clear path to expertise recognition
- **Community Safety**: Effective moderation flows
- **Mobile Excellence**: Native-quality mobile experience
- **Accessibility**: WCAG 2.1 AA compliant flows

**Next Steps**: Wireframe these flows in [WIREFRAMES.md](./WIREFRAMES.md)

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Product & UX Team
**Related Documents**:

- [WIREFRAMES.md](./WIREFRAMES.md)
- [BRAND_IDENTITY.md](./BRAND_IDENTITY.md)
- [ONBOARDING_EXPERIENCE.md](../operations/ONBOARDING_EXPERIENCE.md)
