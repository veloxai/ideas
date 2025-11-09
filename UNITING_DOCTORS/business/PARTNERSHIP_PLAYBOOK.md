# Uniting Doctors - Partnership Playbook

**Version**: 1.0
**Last Updated**: November 9, 2025
**Status**: Planning Phase

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Partnership Strategy](#partnership-strategy)
3. [Partner Types](#partner-types)
4. [Partnership Process](#partnership-process)
5. [Onboarding & Integration](#onboarding--integration)
6. [Co-Marketing](#co-marketing)
7. [Legal & Contracts](#legal--contracts)
8. [Partner Success](#partner-success)
9. [Metrics & ROI](#metrics--roi)
10. [Partner Directory](#partner-directory)
11. [Templates & Resources](#templates--resources)

---

## 🎯 Overview

Strategic partnerships accelerate growth, enhance platform value, and expand reach within the medical community. This playbook provides a systematic approach to identifying, securing, and managing partnerships.

### Partnership Vision

**"Building an ecosystem that serves every aspect of medical professional life"**

We partner with organizations that share our mission to unite doctors and improve healthcare outcomes.

### Core Principles

1. **Mutual Value**: Win-win for both parties
2. **User-First**: Partnerships must benefit our community
3. **Strategic Fit**: Align with our mission and roadmap
4. **Long-Term**: Build lasting relationships, not one-off deals
5. **Measurable**: Track and optimize partnership performance

---

## 🎯 Partnership Strategy

### Strategic Objectives

1. **User Acquisition**: Access to medical professional audiences
2. **Platform Enhancement**: Integrate complementary tools/content
3. **Revenue Generation**: Referral fees, affiliate programs
4. **Credibility**: Association with respected brands
5. **Content**: High-quality educational content
6. **Distribution**: Extend platform reach

### Partnership Priorities

**Phase 1 (Year 1)**: Foundation

- Medical societies (3-5 specialty societies)
- CME providers (2-3 partners)
- Medical publications (5-10 partners)
- Healthcare tech (2-3 integrations)

**Phase 2 (Year 2)**: Expansion

- Health systems (5-10 institutions)
- Pharmaceutical companies (education-focused)
- Telemedicine platforms (2-3 partners)
- Medical device companies (education content)

**Phase 3 (Year 3+)**: Ecosystem

- International societies
- Medical schools
- Residency programs
- Global health organizations

---

## 🤝 Partner Types

### 1. Medical Specialty Societies

**Examples**: American College of Cardiology (ACC), American Thoracic Society (ATS), American College of Emergency Physicians (ACEP)

**Value to Them**:

- Engage members in modern platform
- Extend reach to younger physicians
- Distribute guidelines and content
- Gather member feedback

**Value to Us**:

- Credibility and trust
- Access to member base
- High-quality content
- Specialty expertise

**Partnership Model**:

```
┌─────────────────────────────────────────────────┐
│  MEDICAL SOCIETY PARTNERSHIP                    │
├─────────────────────────────────────────────────┤
│                                                 │
│  Society Provides:                              │
│  • Official guidelines (exclusive or early)     │
│  • Expert-authored content                      │
│  • Member newsletter promotion                  │
│  • Logo/endorsement                             │
│  • Conference booth/speaking slot               │
│                                                 │
│  We Provide:                                    │
│  • Branded specialty group                      │
│  • Free premium for society members             │
│  • Member engagement analytics                  │
│  • Co-branded content                           │
│  • Revenue share (premium subs)                 │
│                                                 │
│  KPIs:                                          │
│  • X% of members join platform                  │
│  • Y engagement rate in specialty group         │
│  • Z guideline downloads                        │
└─────────────────────────────────────────────────┘
```

**Outreach Template**:

```
Subject: Partnership Opportunity: [Society Name] x Uniting Doctors

Dear [Contact Name],

I'm reaching out to explore a potential partnership between [Society Name]
and Uniting Doctors, a new platform connecting 10,000+ verified medical
professionals worldwide.

Our Mission: Unite doctors across specialties to share knowledge, discuss
cases, and stay current with evidence-based medicine.

Why Partner?
• Engage your members on a modern, mobile-first platform
• Exclusive distribution channel for your guidelines and content
• Deeper insights into member needs and interests
• Extend your impact to the next generation of physicians

What We're Proposing:
1. Co-branded [Specialty] community on Uniting Doctors
2. Free premium access for [Society] members
3. Featured content from [Society] (guidelines, statements, etc.)
4. Cross-promotion to both audiences

I'd love to schedule a brief call to explore this further.

Are you available for a 20-minute call next week?

Best regards,
[Your Name]
[Title], Uniting Doctors
[Email] | [Phone]
```

---

### 2. CME Providers

**Examples**: Medscape, Mayo Clinic, Harvard CME, Stanford CME

**Value to Them**:

- Additional distribution channel
- Engaged medical audience
- Modern delivery platform
- Analytics on learner engagement

**Value to Us**:

- High-quality educational content
- CME credits (retention driver)
- Revenue share
- Attract users seeking CME

**Partnership Model**:

```
CME INTEGRATION

Provider Provides:
• CME-accredited courses/modules
• Certificates upon completion
• ACCME compliance

We Provide:
• Platform integration (iframe or API)
• User base (targeted audience)
• Analytics (completion rates, engagement)
• Promotion (email, in-app)

Revenue Model:
• Revenue share: 70/30 (Provider/Us)
• Or: Flat monthly fee
• Or: Cost-per-completion

Integration:
[Course Page] → [Provider LMS] → [Certificate] → [Uniting Doctors]
```

**Technical Integration**:

```typescript
// CME course integration
interface CMECourse {
  id: string;
  provider: 'medscape' | 'mayo' | 'harvard';
  title: string;
  credits: number;
  specialty: string[];
  duration_minutes: number;
  launch_url: string; // External LMS
  completion_webhook: string; // Notify us when complete
}

// Embed CME course
function CMECourseCard({ course }: { course: CMECourse }) {
  const launchCourse = () => {
    // Open in webview or external browser
    const url = `${course.launch_url}?user_id=${user.id}&return_url=${RETURN_URL}`;
    Linking.openURL(url);

    // Track launch
    trackEvent('CME Course Launched', {
      course_id: course.id,
      provider: course.provider,
      specialty: course.specialty
    });
  };

  return (
    <Card>
      <Card.Content>
        <Title>{course.title}</Title>
        <Caption>{course.provider} • {course.credits} CME Credits</Caption>
        <Paragraph>{course.specialty.join(', ')}</Paragraph>
      </Card.Content>
      <Card.Actions>
        <Button onPress={launchCourse}>Start Course</Button>
      </Card.Actions>
    </Card>
  );
}

// Completion webhook handler
app.post('/api/webhooks/cme-completion', async (req, res) => {
  const { user_id, course_id, completion_date, certificate_url } = req.body;

  // Award credits to user
  await awardCMECredits(user_id, course_id);

  // Store certificate
  await storeCertificate(user_id, certificate_url);

  // Notify user
  await sendNotification(user_id, {
    title: 'CME Certificate Available',
    body: 'You earned credits! Download your certificate.',
    data: { certificate_url }
  });

  res.json({ success: true });
});
```

---

### 3. Medical Publications & News

**Examples**: NEJM, The Lancet, BMJ, JAMA, MedPage Today, STAT News

**Value to Them**:

- Drive traffic to full articles
- Engage readers in discussion
- Feedback on content
- Reach younger audience

**Value to Us**:

- Authoritative content
- Breaking medical news
- Credibility
- SEO benefits

**Partnership Models**:

**Option A: Content Syndication**

```
Publication grants us:
• Rights to post summaries + link to full article
• Or: Full text for premium users only
• Attribution and backlinks

We provide:
• Traffic referrals
• Engagement metrics
• Promotion to relevant specialties
```

**Option B: Discussion Integration**

```
Publication embeds:
• Uniting Doctors discussion widget on their articles
• Allows their readers to discuss on our platform

We provide:
• Widget embed code
• Moderation
• User authentication
```

**Example Integration**:

```typescript
// Auto-post new publications
async function autoPostPublication(article: {
  title: string;
  journal: string;
  authors: string[];
  doi: string;
  abstract: string;
  url: string;
}) {
  // Create post on Uniting Doctors
  const post = await createPost({
    title: `New in ${article.journal}: ${article.title}`,
    content: `
      ${article.abstract}

      Authors: ${article.authors.join(', ')}

      Read full article: ${article.url}
    `,
    category: 'research_update',
    source: article.journal,
    external_url: article.url,
    tags: extractTagsFromAbstract(article.abstract)
  });

  // Notify relevant users
  await notifyBySpecialty(post.tags, post.id);
}
```

---

### 4. Healthcare Technology Companies

**Examples**: Epic, Athenahealth, UpToDate, DynaMed, Epocrates

**Value to Them**:

- Access to community for feedback
- User acquisition channel
- Engagement with target audience

**Value to Us**:

- Product integrations (reference tools, EHR)
- Affiliate revenue
- Enhanced platform capabilities
- B2B sales channel

**Partnership Examples**:

**UpToDate Integration**:

```
Feature: "Look up in UpToDate" button on clinical questions

Implementation:
• Deep link to UpToDate search with keywords from post
• Affiliate link (earn commission on subscriptions)
• Track clicks and conversions
```

**Epic App Orchard**:

```
Feature: Uniting Doctors widget in Epic EHR

Use Case:
• Clinician viewing patient chart
• Has question about diagnosis
• Opens Uniting Doctors widget
• Posts question (anonymized patient data)
• Gets peer input

Requirements:
• SMART on FHIR integration
• Epic App Orchard certification
• HIPAA BAA with Epic
```

---

### 5. Health Systems & Hospitals

**Examples**: Mayo Clinic, Cleveland Clinic, Johns Hopkins, Kaiser Permanente

**Value to Them**:

- Professional development for physicians
- Reduce physician burnout (community/connection)
- Recruiting tool (highlight affiliation)
- Institutional branding

**Value to Us**:

- Bulk subscriptions (B2B revenue)
- Credibility
- Access to large physician networks
- Case studies

**Enterprise Partnership**:

```
┌─────────────────────────────────────────────────┐
│  HEALTH SYSTEM PARTNERSHIP (B2B)                │
├─────────────────────────────────────────────────┤
│  Package: Uniting Doctors Enterprise            │
│                                                 │
│  Includes:                                      │
│  • Premium accounts for all employed physicians │
│  • Custom-branded institutional group           │
│  • SSO integration (SAML)                       │
│  • Usage analytics dashboard                    │
│  • Dedicated account manager                    │
│  • CME tracking integration                     │
│  • Custom onboarding/training                   │
│                                                 │
│  Pricing:                                       │
│  • $50/physician/year (100+ physicians)         │
│  • $40/physician/year (500+ physicians)         │
│  • $30/physician/year (1,000+ physicians)       │
│                                                 │
│  Contract: 1-year minimum, auto-renew           │
└─────────────────────────────────────────────────┘
```

---

### 6. Pharmaceutical & Medical Device Companies

**Examples**: Pfizer, AstraZeneca, Medtronic, Abbott

**Value to Them**:

- Educate physicians about products
- Gather real-world feedback
- Build thought leader relationships
- Sponsor CME content

**Value to Us**:

- Sponsorship revenue
- Educational content funding
- Conference presence

**Partnership Guidelines** (to maintain trust):

```
✅ ALLOWED:
• Sponsor CME courses (clearly labeled)
• Sponsor "clinical update" content (balanced, evidence-based)
• Support conference attendance
• Fund platform features (e.g., "Search powered by Pfizer")

❌ NOT ALLOWED:
• Direct product promotion in feed
• Influencing clinical discussions
• Biased content
• Targeting specific doctors for sales

Transparency: All pharma relationships disclosed clearly
```

---

## 🔄 Partnership Process

### Stage 1: Identification (Week 1-2)

**Research**:

- Identify potential partners aligned with strategy
- Assess fit (mission, audience, reputation)
- Prioritize by potential impact

**Criteria**:

- [ ] Serves medical professionals
- [ ] Reputable brand
- [ ] Complementary to our offering
- [ ] Realistic to close deal
- [ ] Clear mutual value

### Stage 2: Outreach (Week 2-3)

**Find Right Contact**:

- LinkedIn search (partnerships, business development)
- Mutual connections (warm intro preferred)
- Conference meetings
- Direct email

**Initial Email** (see templates below)

**Follow-Up**:

- Day 3: Follow-up if no response
- Day 7: Final follow-up
- Move on if no response

### Stage 3: Discovery Call (Week 3-4)

**Agenda** (30 minutes):

```
1. Introductions (5 min)
   • Our backgrounds
   • Their role

2. Their Needs (10 min)
   • What are their goals?
   • What challenges do they face?
   • What have they tried?

3. Our Platform (5 min)
   • Brief demo
   • Key features
   • User testimonials

4. Partnership Ideas (8 min)
   • Brainstorm collaboration models
   • Gauge interest
   • Address concerns

5. Next Steps (2 min)
   • Follow-up meeting?
   • Proposal timeline
   • Key stakeholders to involve
```

**Follow-Up**:

- Send thank you email within 24 hours
- Summarize discussion and next steps
- Share any requested materials

### Stage 4: Proposal (Week 4-6)

**Partnership Proposal Template**:

```markdown
# Partnership Proposal

[Partner Name] x Uniting Doctors

## Executive Summary

[2-3 sentences on partnership vision]

## About Uniting Doctors

• Platform overview
• Key metrics (users, engagement, specialties)
• Mission and vision

## Partnership Opportunity

### Objectives

• [Specific goal 1]
• [Specific goal 2]
• [Specific goal 3]

### Proposed Collaboration

[Detailed description of partnership model]

### What [Partner] Provides

• [Item 1]
• [Item 2]
• [Item 3]

### What Uniting Doctors Provides

• [Item 1]
• [Item 2]
• [Item 3]

### Success Metrics

| Metric     | Target   | Timeline |
| ---------- | -------- | -------- |
| [Metric 1] | [Target] | [When]   |
| [Metric 2] | [Target] | [When]   |

### Timeline

• Month 1: [Milestone]
• Month 2: [Milestone]
• Month 3: [Milestone]

### Investment Required

[Financial terms, resources needed, etc.]

### Next Steps

1. Review proposal
2. Feedback call
3. Contract negotiation
4. Execution

## Contact

[Your Name, Email, Phone]
```

### Stage 5: Negotiation (Week 6-10)

**Key Terms to Negotiate**:

- Exclusivity (if any)
- Duration (1 year? 3 years?)
- Revenue split (if applicable)
- IP ownership (content, branding)
- Termination clauses
- Performance requirements
- Confidentiality

**Negotiation Tips**:

- Start with relationship building
- Understand their constraints
- Be flexible on structure, firm on value
- Document everything
- Involve legal early

### Stage 6: Contract (Week 10-12)

**Legal Review**:

- Engage healthcare attorney
- Review terms carefully
- Ensure HIPAA compliance
- Clarify data sharing rules
- Define success metrics

**Signature**:

- Both parties sign
- Countersigned copies exchanged
- Store in partnership database

### Stage 7: Launch (Week 12+)

See [Onboarding & Integration](#onboarding--integration) section

---

## 🚀 Onboarding & Integration

### Partner Onboarding Checklist

**Week 1: Kickoff**

- [ ] Kickoff call with both teams
- [ ] Introductions (key stakeholders)
- [ ] Align on goals and timelines
- [ ] Assign owners (PM from each side)
- [ ] Set up communication channels (Slack, email)

**Week 2-3: Planning**

- [ ] Technical integration requirements documented
- [ ] Marketing assets shared (logos, brand guidelines)
- [ ] Content plan created
- [ ] Legal agreements signed
- [ ] Analytics/tracking set up

**Week 4-6: Development**

- [ ] Technical integration built
- [ ] QA testing completed
- [ ] Marketing materials created
- [ ] Launch plan finalized
- [ ] Training materials prepared

**Week 7: Soft Launch**

- [ ] Launch to small group (beta test)
- [ ] Monitor closely
- [ ] Gather feedback
- [ ] Fix issues

**Week 8: Public Launch**

- [ ] Announce to full audience
- [ ] Co-marketing campaign
- [ ] Monitor metrics
- [ ] Ongoing optimization

### Technical Integration

**Integration Types**:

1. **API Integration**: Partner's data accessible via API
2. **SSO (Single Sign-On)**: Users log in once, access both platforms
3. **Iframe Embed**: Partner's content embedded in our platform
4. **Webhook**: Real-time notifications between platforms
5. **Deep Linking**: Direct links between platforms

**Example: SSO Integration (SAML)**

```typescript
// SAML SSO for enterprise partners
import { Strategy as SAMLStrategy } from 'passport-saml';

passport.use(
  'partner-sso',
  new SAMLStrategy(
    {
      entryPoint: 'https://partner.com/sso',
      issuer: 'uniting-doctors',
      callbackUrl: 'https://unitingdoctors.com/auth/sso/callback',
      cert: process.env.PARTNER_SSO_CERT
    },
    async (profile, done) => {
      // Find or create user based on partner's data
      const user = await findOrCreateUser({
        email: profile.email,
        name: profile.displayName,
        partner_id: profile.nameID,
        partner: 'mayo-clinic',
        is_verified: true // Trust partner's verification
      });

      done(null, user);
    }
  )
);

// SSO login route
app.get('/auth/sso/:partner', passport.authenticate('partner-sso'));

app.post(
  '/auth/sso/callback',
  passport.authenticate('partner-sso', {
    successRedirect: '/feed',
    failureRedirect: '/login'
  })
);
```

---

## 📢 Co-Marketing

### Co-Marketing Opportunities

1. **Press Release**: Joint announcement
2. **Blog Posts**: Cross-posted on both sites
3. **Webinar**: Co-hosted educational session
4. **Email Campaign**: To both audiences
5. **Social Media**: Coordinated posts
6. **Conference**: Co-branded booth
7. **Case Study**: Success story
8. **Content Series**: Co-created content

### Co-Marketing Plan Template

```markdown
# Co-Marketing Plan

[Partner Name] x Uniting Doctors Partnership Launch

## Goals

• Generate 5,000+ signups from [Partner] audience
• 1M+ impressions across channels
• Position partnership as industry-leading

## Target Audience

• [Partner]'s members/users: [X] physicians
• Our users: [Y] physicians
• Media: Healthcare tech publications

## Messaging

### Key Messages

1. [Message 1]
2. [Message 2]
3. [Message 3]

### Tagline

"[Compelling tagline for partnership]"

## Tactics

### Pre-Launch (Week 1-2)

• Teaser posts on social media
• Email to both lists ("Something exciting coming...")
• Internal team announcements

### Launch Week (Week 3)

• Monday: Press release (distribute to 50+ media outlets)
• Tuesday: Blog posts on both sites
• Wednesday: Webinar announcement
• Thursday: Email campaign to both lists
• Friday: Social media blitz

### Post-Launch (Week 4+)

• Case studies
• User testimonials
• Ongoing content collaboration

## Assets Needed

• [ ] Logos (both partners)
• [ ] Screenshots/product images
• [ ] Partner quotes
• [ ] Press release draft
• [ ] Blog post drafts
• [ ] Social media images (5-10)
• [ ] Email templates

## Timeline

[Gantt chart or detailed timeline]

## Budget

• PR distribution: $X
• Paid social: $X
• Event/webinar: $X
• Design/creative: $X
**Total: $X**

## Success Metrics

| Channel            | Target |
| ------------------ | ------ |
| Press mentions     | 10+    |
| Social impressions | 500K+  |
| Email opens        | 25%+   |
| Webinar attendees  | 500+   |
| New signups        | 5,000+ |

## Owners

• Uniting Doctors: [Name] (email)
• [Partner]: [Name] (email)
```

---

## ⚖️ Legal & Contracts

### Standard Partnership Agreement Outline

```
1. Parties
2. Recitals (context)
3. Definitions
4. Term (duration of partnership)
5. Scope of Partnership
   a. Partner obligations
   b. Our obligations
6. Intellectual Property
   a. Ownership of existing IP
   b. Ownership of co-created IP
   c. License grants
7. Data & Privacy
   a. Data sharing terms
   b. HIPAA compliance
   c. User privacy
8. Financial Terms
   a. Revenue share (if applicable)
   b. Payment terms
   c. Invoicing
9. Marketing & Branding
   a. Logo usage rights
   b. Approval process
   c. Brand guidelines
10. Confidentiality
11. Representations & Warranties
12. Indemnification
13. Limitation of Liability
14. Termination
    a. Termination for convenience
    b. Termination for cause
    c. Effects of termination
15. Miscellaneous
    a. Governing law
    b. Dispute resolution
    c. Force majeure
    d. Entire agreement
```

### Key Clauses

#### Revenue Share Example

```
Revenue Share: For each Premium subscription sold through
Partner's referral, Partner shall receive thirty percent (30%)
of the subscription fee for the duration of that user's
subscription.

Payment Terms: Payments calculated monthly and paid within
30 days of month end via ACH transfer.
```

#### Data Sharing Example

```
Data Sharing: Partner may share user data (name, email,
specialty) with Uniting Doctors for the purpose of creating
user accounts. Uniting Doctors will handle all data in
compliance with HIPAA and shall not share user data with
third parties without explicit consent.
```

#### Termination Example

```
Termination for Convenience: Either party may terminate this
Agreement with ninety (90) days written notice.

Termination for Cause: Either party may terminate immediately
if the other party breaches a material term and fails to cure
within thirty (30) days of written notice.

Effect of Termination: Upon termination, Partner shall remove
all Uniting Doctors branding and cease promotion. Revenue
share continues for existing subscriptions.
```

---

## 📈 Partner Success

### Partner Success Manager Role

**Responsibilities**:

- Primary contact for all partners
- Monitor partnership health
- Quarterly business reviews
- Identify expansion opportunities
- Resolve issues quickly

### Quarterly Business Review (QBR)

**Agenda** (60 minutes):

```
1. Welcome & Relationship Check-in (5 min)
   • How's the partnership going?
   • Any concerns?

2. Metrics Review (20 min)
   • Review dashboard
   • Discuss trends
   • Compare to targets

3. Wins & Challenges (15 min)
   • Celebrate successes
   • Address roadblocks
   • Gather feedback

4. Roadmap Preview (10 min)
   • Share upcoming features
   • Get partner input
   • Identify new opportunities

5. Action Items & Next Steps (10 min)
   • Document action items
   • Assign owners
   • Schedule next QBR
```

### Partner Health Score

**Calculate monthly**:

| Factor             | Weight   | Score (1-5)   |
| ------------------ | -------- | ------------- |
| Usage/Engagement   | 30%      | [Score]       |
| Revenue/Value      | 25%      | [Score]       |
| Communication      | 15%      | [Score]       |
| Satisfaction (NPS) | 15%      | [Score]       |
| Strategic Fit      | 15%      | [Score]       |
| **Total**          | **100%** | **[Overall]** |

**Health Tiers**:

- 🟢 Green (4.0-5.0): Thriving
- 🟡 Yellow (3.0-3.9): At risk
- 🔴 Red (1.0-2.9): Critical

**Actions**:

- Green: Expand partnership, ask for referrals
- Yellow: Schedule check-in, address concerns
- Red: Escalate to executive team, intervention plan

---

## 📊 Metrics & ROI

### Partnership Metrics Dashboard

**Track for Each Partner**:

| Metric                  | Definition                              | Goal            |
| ----------------------- | --------------------------------------- | --------------- |
| **Users Acquired**      | New signups from partner                | Varies          |
| **Referral Conversion** | % of referred visitors who sign up      | >10%            |
| **Activation Rate**     | % who complete onboarding               | >50%            |
| **Engagement**          | DAU, posts, comments from partner users | Match avg       |
| **Retention**           | D7, D30 retention vs. overall           | Match or better |
| **Revenue**             | From partner referrals or deal          | $X/month        |
| **Cost**                | Resources invested (time, money)        | <$Y             |
| **ROI**                 | (Revenue - Cost) / Cost                 | >200%           |

### ROI Calculation Example

```
Partnership: American College of Cardiology

Investment (Year 1):
• Contract negotiation time: $5,000
• Integration development: $15,000
• Marketing campaign: $10,000
• Partner success management: $8,000
• Total Cost: $38,000

Returns (Year 1):
• 2,000 new users from ACC promotion
• 400 convert to premium ($10/month) = $48,000/year
• Engagement boost (brand credibility): $10,000 value
• Content value (guidelines, expert posts): $5,000
• Total Value: $63,000

ROI = ($63,000 - $38,000) / $38,000 = 66%

Plus intangibles:
• Brand credibility
• Long-term relationship
• Referral potential
```

---

## 📂 Partner Directory

### Current Partners (Template)

| Partner        | Type            | Launch Date | Status      | Owner  |
| -------------- | --------------- | ----------- | ----------- | ------ |
| [Society Name] | Medical Society | Q1 2026     | Active      | [Name] |
| [CME Provider] | CME             | Q2 2026     | Negotiation | [Name] |
| [Publication]  | Content         | Q2 2026     | Planning    | [Name] |

---

## 📝 Templates & Resources

### Email Templates

#### Initial Outreach - Society

```
Subject: Partnership Opportunity - [Society Name] x Uniting Doctors

Dear [Name],

I hope this email finds you well. I'm [Your Name], [Title] at Uniting
Doctors, a platform connecting 10,000+ verified medical professionals.

I'm reaching out because I believe a partnership between [Society Name]
and Uniting Doctors could significantly benefit your members.

Quick stats:
• 10,000+ verified doctors across 50+ specialties
• 80% monthly active users
• 100,000+ clinical discussions

What we're envisioning:
• Co-branded [Specialty] community
• Free premium for your members
• Exclusive distribution for your guidelines
• Joint content initiatives

Would you be open to a 20-minute exploratory call next week?

Best regards,
[Your Name]
[Title], Uniting Doctors
[Email] | [Phone] | [LinkedIn]
```

#### Follow-Up Email

```
Subject: Re: Partnership Opportunity - [Society Name] x Uniting Doctors

Hi [Name],

I wanted to follow up on my email from [date] about a potential
partnership.

I know you're busy, so I'll be brief: We have 10,000+ doctors on our
platform who would benefit from [Society]'s expertise and content.

Would you be open to a brief call to explore this? I'm happy to work
around your schedule.

Thanks,
[Your Name]
```

### Proposal Template

[See Stage 4: Proposal above]

### QBR Deck Template

```
Slide 1: Welcome
Slide 2: Partnership Goals (remind them)
Slide 3: Metrics Dashboard
Slide 4: Key Wins
Slide 5: Challenges & Mitigations
Slide 6: User Testimonials
Slide 7: Roadmap Preview
Slide 8: Action Items
Slide 9: Thank You
```

---

## 📞 Partnership Contacts

**Partnerships Team**:

- Head of Partnerships: [TBD]
- Partner Success Manager: [TBD]
- Legal Counsel: [TBD]

**Inquiries**: partnerships@unitingdoctors.com

---

**Document Version**: 1.0
**Last Updated**: November 9, 2025
**Next Review**: Quarterly

**Related Documents**:

- [PARTNER_STRATEGY.md](../business/PARTNER_STRATEGY.md)
- [GO_TO_MARKET_STRATEGY.md](../business/GO_TO_MARKET_STRATEGY.md)
- [BUSINESS_MODEL.md](../business/BUSINESS_MODEL.md)
- [IMPLEMENTATION_ROADMAP.md](../technical/IMPLEMENTATION_ROADMAP.md)
