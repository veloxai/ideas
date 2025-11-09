# Feature #55C: Onboarding & Knowledge Management

**Feature Category**: Change Management & Organizational Transformation
**Status**: Learning & Development
**Last Updated**: November 8, 2025
**Estimated Budget**: Included in HR & Organizational Development ($120K/year Feature #55 total)

---

## Executive Summary

Fair Underwriting will hire **70+ people in 36 months**. Without structured onboarding and knowledge management:

**Problems Without Onboarding**:

- ❌ New hires take 3-6 months to become productive (slow ramp)
- ❌ Constantly re-explaining how things work (knowledge in people's heads)
- ❌ High turnover (30%+ first-year attrition due to poor onboarding)
- ❌ Inconsistent training (everyone learns differently)
- ❌ Tribal knowledge lost when people leave (no documentation)

**With Structured Onboarding & Knowledge Management**:

- ✅ New hires productive in 30-60 days (fast ramp)
- ✅ Self-service knowledge base (documentation answers 80% of questions)
- ✅ Low turnover (<15% attrition with great onboarding)
- ✅ Consistent training (everyone learns the same way)
- ✅ Knowledge preserved (documentation survives departures)

This document provides:

1. **30/60/90-day onboarding programs** by role (engineering, sales, customer success, etc.)
2. **Knowledge base structure** (what to document, where to store it)
3. **Documentation standards** (how to write good docs)
4. **Training programs** (HIPAA, product, sales enablement)
5. **Performance management** (quarterly reviews, feedback loops)

---

## Onboarding Philosophy

### The First 90 Days Framework

**Day 1-30: Learn** (Information absorption)

- **Goal**: Understand company, product, team, role
- **Activities**: Read documentation, shadow teammates, attend trainings
- **Success**: Can explain company mission, product value prop, team structure

**Day 31-60: Contribute** (Guided productivity)

- **Goal**: Ship first meaningful work with support
- **Activities**: Complete onboarding projects, pair with senior teammate
- **Success**: First PR merged, first customer call, first deal closed (role-dependent)

**Day 61-90: Own** (Independent productivity)

- **Goal**: Work autonomously, mentor next new hire
- **Activities**: Own features/accounts/projects end-to-end
- **Success**: Fully ramped, no longer "the new person"

---

## Engineering Onboarding (30/60/90 Days)

### Day 1: Welcome & Setup (8 hours)

**Morning (9am-12pm): People & Culture**

- 9:00-9:30: Welcome breakfast with team (in-person or Zoom)
- 9:30-10:30: HR onboarding (benefits, payroll, policies)
  - Sign docs: Offer letter, NDA, IP assignment, handbook acknowledgment
  - Enroll in benefits: Health insurance, 401k, equity grant
  - Set up accounts: Email, Slack, GitHub, AWS, Datadog
- 10:30-11:30: CEO all-hands (company vision, why Fair Underwriting matters)
  - Watch: "Fair Underwriting Origin Story" (15-min video)
  - Discuss: Mission (save lives through early AATD detection), values, 36-month roadmap
- 11:30-12:00: Team intros (meet your immediate team, manager 1-on-1)

**Afternoon (1pm-5pm): Technical Setup**

- 1:00-2:00: Laptop setup (install dependencies, clone repos)
  - Checklist: Node.js, Docker, PostgreSQL, VS Code, Git, AWS CLI
  - Access: GitHub org, AWS dev account, staging environment
- 2:00-3:00: Architecture overview (CTO presentation)
  - Watch: "Fair Underwriting Technical Architecture" (30-min video)
  - Diagram walkthrough: Customer portal, partner portal, genetic vault, lab integration
- 3:00-4:00: Run local environment (get app running on localhost)
  - Follow: README.md setup guide
  - Troubleshoot: Ask buddy for help (assigned senior engineer)
- 4:00-5:00: First commit (fix typo in README, submit PR)
  - Purpose: Practice Git workflow, get first PR merged
  - Celebration: Team reacts with 🎉 when PR merges

**Day 1 Success Criteria**:

- ✅ Laptop fully set up, local app running
- ✅ First PR merged (even if trivial)
- ✅ Met entire team (names + roles memorized)
- ✅ Read company handbook (culture, values, policies)

---

### Week 1 (Days 2-5): Learn the Codebase

**Daily Schedule**:

- **9:00-9:15**: Daily standup (observe, don't present yet)
- **9:15-12:00**: Self-paced learning
  - Read: Technical architecture doc, API documentation, database schema
  - Watch: Product demo videos (customer portal, partner portal)
  - Explore: Run test suite, browse codebase, read old PRs
- **1:00-3:00**: Pair programming with buddy
  - Shadow: Watch buddy code, ask questions
  - Pair: Work together on small feature or bug fix
- **3:00-5:00**: Onboarding project (see below)

**Onboarding Project Options** (Choose 1, complete by end of Week 2):

1. **"Good First Issue"**: Fix 3 bugs labeled `good-first-issue` in GitHub
2. **"Test Coverage"**: Write tests for 1 untested module (boost coverage by 5%)
3. **"Documentation Fix"**: Update stale API docs for 1 endpoint
4. **"Small Feature"**: Add minor feature (e.g., "Add export button to partner dashboard")

**Week 1 Trainings** (Schedule with HR):

- Tuesday 2pm: HIPAA training (2 hours, mandatory for all employees)
- Thursday 3pm: Security training (1 hour, password hygiene, phishing awareness)
- Friday 11am: Product training (1 hour, demo all features)

**Week 1 Success Criteria**:

- ✅ Onboarding project 50% complete
- ✅ HIPAA training certified
- ✅ Can navigate codebase (find files without help)
- ✅ Submitted 2-3 PRs (onboarding project progress)

---

### Week 2-4 (Days 6-30): Ship First Real Feature

**Week 2 Goals**:

- Finish onboarding project (demo to team at Friday sprint demo)
- Participate in sprint planning (understand how sprints work)
- Start shadowing on-call rotation (observe, don't take calls yet)

**Week 3 Goals**:

- Pick first real feature from sprint backlog (manager assigns small feature)
- Write design doc (practice technical writing)
- Get design doc reviewed (learn team's code review standards)

**Week 4 Goals**:

- Ship first real feature (PR merged, deployed to staging)
- Demo feature at sprint demo (present to team)
- Celebrate! (Team kudos in Slack #wins channel)

**Month 1 Success Criteria**:

- ✅ Shipped 1 real feature (not onboarding project)
- ✅ Attended 2 sprint cycles (planning + demo + retro)
- ✅ Understand team processes (sprint, code review, deployment)
- ✅ Manager 1-on-1 check-in: "How's it going? Any blockers?"

---

### Day 31-60: Ramp Up Velocity

**Goals**:

- Ship 2-3 features per sprint (approaching team velocity)
- Take on-call rotation (1 week, with backup)
- Mentor next new hire (pair with them on Week 1)

**Activities**:

- **Week 5-6**: Pick medium-complexity features (2-3 day tasks)
- **Week 7-8**: Lead small project (3-5 day feature with design doc)
- **Week 8**: Shadow on-call (Week 8), solo on-call with backup (Week 9)

**Day 60 Success Criteria**:

- ✅ Shipped 4-6 features (total since start)
- ✅ Completed first on-call week (survived!)
- ✅ Mentored 1 new hire (helped with onboarding project)
- ✅ No longer need buddy's help (working independently)

---

### Day 61-90: Full Productivity

**Goals**:

- Work at same velocity as senior engineers
- Contribute to technical decisions (architecture reviews, design docs)
- Identify and fix tech debt (proactive improvements)

**Activities**:

- **Week 10-11**: Own entire feature area (e.g., "partner dashboard analytics")
- **Week 12-13**: Lead sprint (volunteer to be sprint lead for 1 sprint)

**Day 90 Success Criteria**:

- ✅ Indistinguishable from experienced team member
- ✅ Manager review: "Fully ramped, exceeding expectations"
- ✅ Proactively suggesting improvements (not just executing)
- ✅ Ready for promotion discussion (if performing above level)

---

## Sales Onboarding (30/60/90 Days)

### Day 1-7: Product & Market Immersion

**Day 1**: Same as engineering (company onboarding, HR, CEO vision)

**Day 2-5: Product Deep Dive**

- **Day 2**: Become a customer (sign up, order test, receive results)
  - Experience customer journey firsthand
  - Document pain points and delighters
- **Day 3**: Shadow genetic counseling session (understand clinical workflow)
- **Day 4**: Partner portal training (learn what partners see)
- **Day 5**: Competitive analysis (Color Health, 23andMe, Quest—how are we different?)

**Week 1 Deliverable**: Write "Product Cheat Sheet" (1-pager on value prop, objections, competitive differentiation)

---

### Day 8-30: Sales Skills & Pipeline Building

**Week 2: Sales Training**

- **MEDDPICC Methodology** (2-hour workshop with VP Sales)
  - Metrics, Economic Buyer, Decision Criteria, Decision Process, Paper Process, Identify Pain, Champion, Competition
- **Objection Handling** (role-playing exercises)
  - "We already partner with 23andMe" → How to position Fair Underwriting's privacy advantage
  - "This sounds expensive" → How to articulate ROI (lives saved, cost savings)
  - "We need to think about it" → How to create urgency
- **Demo Training** (practice product demo 10 times)
  - Perfect the 15-min partner pitch
  - Perfect the 30-min deep dive demo

**Week 3-4: Shadow Senior AE**

- Attend 10 discovery calls (observe, take notes)
- Attend 5 demos (observe, ask questions after)
- Attend 1 negotiation (see how VP Sales closes deals)

**Week 4 Deliverable**: First solo discovery call (VP Sales shadows YOU, provides feedback)

**Day 30 Success Criteria**:

- ✅ Can demo product confidently (no notes)
- ✅ Memorized objection responses
- ✅ Completed 1 solo discovery call
- ✅ Built list of 20 target prospects (researched companies)

---

### Day 31-60: First Deals

**Goals**:

- Close first deal (or at least advance 3 deals to proposal stage)
- Build pipeline (20 active opportunities)

**Activities**:

- **Week 5-6**: Outreach to 50 prospects (emails, LinkedIn, calls)
  - Book 10 discovery calls
  - Convert 5 to demo stage
- **Week 7-8**: Run 5 demos (1 per day)
  - Advance 2-3 to proposal stage
- **Week 8**: Draft first proposal (VP Sales reviews, co-presents with you)

**Day 60 Success Criteria**:

- ✅ Pipeline: $1.5M (10 opportunities × $150K average deal size)
- ✅ Stage distribution: 5 discovery, 3 demo, 2 proposal
- ✅ First proposal sent (even if not closed yet)
- ✅ Manager review: "On track to hit quota Month 4-6"

---

### Day 61-90: Quota Attainment

**Goals**:

- Close 1-2 deals (reach $150K-300K in signed contracts)
- Build pipeline for next quarter

**Activities**:

- **Week 10-11**: Close first deal (celebrate!)
- **Week 12-13**: Close second deal OR advance 5 deals to late stage

**Day 90 Success Criteria**:

- ✅ Closed 1-2 deals (minimum 1, ideally 2)
- ✅ Pipeline: $3M+ (working toward $1.5M quarterly quota)
- ✅ Manager review: "Fully ramped, quota-carrying rep"
- ✅ Mentoring next new AE (shadowing you)

---

## Customer Success Onboarding (30/60/90 Days)

### Day 1-30: Learn Customers & Product

**Week 1**: Same as engineering/sales (company onboarding, product training)

**Week 2-3: Shadow Senior CSM**

- Observe 5 customer onboarding calls (new pilot partners)
- Observe 2 QBRs (quarterly business reviews)
- Observe 5 support tickets (how to troubleshoot)

**Week 4: Take Over 5 Small Accounts**

- Manager assigns 5 low-risk accounts (small partners, <500 customers)
- Conduct first customer calls (introduce yourself, listen to feedback)
- Document learnings (what do customers care about?)

**Day 30 Success Criteria**:

- ✅ Managing 5 accounts (under supervision)
- ✅ Completed first QBR (shadowed or co-led)
- ✅ Resolved 10 support tickets
- ✅ Product expert (can answer customer questions confidently)

---

### Day 31-60: Full Book of Business

**Goals**:

- Take over 25 accounts (full CSM load)
- Proactive outreach (not just reactive support)

**Activities**:

- **Week 5-6**: Transition 20 more accounts from senior CSM
- **Week 7-8**: Conduct 10 QBRs (1-2 per day)
- **Week 8**: Identify 3 upsell opportunities (present to sales team)

**Day 60 Success Criteria**:

- ✅ Managing 25 accounts independently
- ✅ NPS >60 (customer satisfaction high)
- ✅ Churn rate <5% (customers not leaving)
- ✅ Identified 3 upsells (expansion revenue)

---

### Day 61-90: Strategic CSM

**Goals**:

- Drive expansion revenue ($100K+ upsells)
- Reduce churn (proactive intervention for at-risk accounts)

**Activities**:

- **Week 10-11**: Close 1 upsell (partner expands to more employees)
- **Week 12-13**: Save 1 at-risk account (intervene before churn)

**Day 90 Success Criteria**:

- ✅ Closed $100K+ in expansion revenue
- ✅ Saved 1 at-risk account (churn avoided)
- ✅ Manager review: "Top-performing CSM, ready for larger accounts"
- ✅ Presenting at all-hands (share customer success story)

---

## Knowledge Base Structure

### Where to Store What

**1. Internal Wiki (Notion or Confluence) - Source of Truth**

- **Company**: Mission, values, history, org chart, policies
- **Product**: Architecture, API docs, feature specs, roadmap
- **Processes**: Sprint planning, code review, deployment, incident response
- **Sales**: Pitch decks, ROI calculators, objection handling, competitive intel
- **Customer Success**: Onboarding playbooks, QBR templates, support troubleshooting

**2. GitHub (Code & Technical Docs)**

- **README.md** (each repo): How to run locally, architecture overview
- **docs/** folder: Technical specs, API contracts, database schema
- **ADRs** (Architecture Decision Records): Why we chose X over Y
- **CONTRIBUTING.md**: How to contribute (code style, PR process)

**3. Google Drive (Business Docs)**

- **Contracts**: Partner agreements, vendor contracts, employment offers
- **Finance**: Budgets, board decks, investor updates
- **Legal**: Compliance reports, audit results, policies

**4. Zendesk (Customer-Facing Knowledge Base)**

- **Help Center**: How to sign up, order test, read results, contact support
- **FAQs**: Pricing, privacy, HIPAA, data security, test accuracy
- **Video Tutorials**: Product demos, feature walkthroughs

**5. Slack (Real-Time Communication - NOT Knowledge Storage)**

- **Use Slack for**: Questions, discussions, quick decisions, social
- **DON'T use Slack for**: Long-term knowledge storage (use Wiki instead)
- **Exception**: #announcements channel archived for important company-wide updates

---

## Documentation Standards

### Good Documentation Principles

**1. Write for Your Future Self** (You'll forget in 3 months)

- Assume reader has zero context
- Explain "why" not just "what"
- Include examples

**2. Make It Scannable** (People skim, not read)

- Use headings, bullet points, tables
- TL;DR at top (executive summary)
- Put most important info first

**3. Keep It Updated** (Stale docs are worse than no docs)

- Review quarterly (delete or update)
- Add "Last Updated" timestamp
- Assign owner (who maintains this doc?)

**4. Link Liberally** (Connect related docs)

- Don't repeat information (link instead)
- Create index pages (e.g., "Engineering Docs Hub")
- Use breadcrumbs (help people navigate)

---

### Documentation Templates

**Template 1: Feature Spec**

```markdown
# Feature: [Feature Name]

**Owner**: [Product Manager name]
**Status**: Draft | In Review | Approved | Shipped
**Last Updated**: YYYY-MM-DD

## TL;DR (2-3 sentences)

What is this feature? Why are we building it?

## Problem Statement

What customer pain point does this solve?

## User Stories

- As a [user type], I want [goal], so that [benefit]
- As a [user type], I want [goal], so that [benefit]

## Design (Mockups or Wireframes)

[Link to Figma or embed screenshots]

## Technical Approach

How will we build this? (high-level, not code-level)

## Success Metrics

How do we measure success?

- Metric 1: Increase X by 20%
- Metric 2: Reduce Y by 30%

## Launch Plan

- Beta: [Date]
- GA: [Date]
- Rollback plan: [If feature breaks, how to revert?]

## Open Questions

- [ ] Question 1?
- [ ] Question 2?
```

---

**Template 2: Incident Postmortem**

```markdown
# Incident Postmortem: [Brief Title]

**Date**: YYYY-MM-DD
**Duration**: X hours
**Severity**: P0 | P1 | P2 | P3
**Incident Lead**: [Name]

## TL;DR

What happened? What was the impact? What did we fix?

## Timeline (all times in PT)

- 10:00am: Incident detected (how?)
- 10:05am: Incident lead assigned
- 10:15am: Root cause identified
- 11:30am: Fix deployed
- 12:00pm: Incident resolved

## Impact

- Customers affected: X
- Revenue lost: $Y
- Downtime: Z minutes

## Root Cause

What caused the incident? (technical details)

## Resolution

How did we fix it? (technical details)

## Action Items (Prevent Recurrence)

- [ ] Action 1: [Owner, Due Date]
- [ ] Action 2: [Owner, Due Date]
- [ ] Action 3: [Owner, Due Date]

## Lessons Learned

What went well? What could we improve?
```

---

## Training Programs

### Mandatory Training (All Employees)

**1. HIPAA Compliance Training**

- **When**: Day 1 (before accessing any systems)
- **Duration**: 2 hours
- **Content**:
  - What is HIPAA? (Health Insurance Portability and Accountability Act)
  - What is PHI? (Protected Health Information) - examples: name + genetic data
  - Allowed uses of PHI (treatment, payment, operations)
  - Prohibited uses (no sharing on Slack, no discussing in public, no accessing out of curiosity)
  - Penalties (up to $50K fine per violation, criminal charges, termination)
- **Assessment**: 20-question quiz (must score 90% to pass)
- **Annual Refresh**: Required every 12 months

**2. Security Training**

- **When**: Day 1
- **Duration**: 1 hour
- **Content**:
  - Password hygiene (use 1Password, enable MFA everywhere)
  - Phishing awareness (how to spot fake emails)
  - Device security (encrypt laptop, lock screen, no public WiFi for work)
  - Incident reporting (see suspicious email? Forward to security@fairunderwriting.com)
- **Assessment**: Phishing test (company sends fake phishing email, see who clicks)
- **Quarterly Refresh**: New phishing tests quarterly

**3. Product Training**

- **When**: Week 1
- **Duration**: 1 hour
- **Content**:
  - Watch product demo (15 min)
  - Try product yourself (30 min hands-on)
  - Q&A with Product Manager (15 min)
- **No Assessment** (informal)
- **Quarterly Updates**: New feature demos at all-hands

---

### Role-Specific Training

**Engineering**:

- **Week 1**: Technical architecture deep dive (2 hours)
- **Week 2**: Code review best practices (1 hour)
- **Week 4**: On-call training (2 hours)
- **Month 3**: Security engineering (secure coding, OWASP Top 10)

**Sales**:

- **Week 1**: MEDDPICC methodology (2 hours)
- **Week 2**: Product demo training (4 hours practice)
- **Week 3**: Objection handling (2 hours role-playing)
- **Month 2**: Negotiation skills (external workshop, $500 budget)

**Customer Success**:

- **Week 1**: Product expert training (4 hours)
- **Week 2**: Conflict resolution (2 hours)
- **Week 3**: QBR facilitation (2 hours)
- **Month 2**: Upselling techniques (2 hours)

---

## Performance Management

### Quarterly Performance Reviews (OKR-Based)

**Process**:

1. **Week 1 of Quarter**: Set OKRs (Objectives and Key Results)
   - Employee drafts OKRs (what will I accomplish this quarter?)
   - Manager reviews and aligns to company goals
   - Final OKRs approved and documented

2. **Mid-Quarter Check-In** (Week 6): Progress review
   - Are you on track?
   - Do you need support or resources?
   - Should we adjust OKRs? (if priorities changed)

3. **End of Quarter**: Performance review
   - Self-assessment: How did I do? (score OKRs 0-100%)
   - Manager assessment: How did they do? (score OKRs 0-100%)
   - 1-on-1 discussion: Feedback, growth areas, next quarter planning

**OKR Scoring**:

- 0-40%: Did not achieve (concerning)
- 40-70%: Partial achievement (acceptable, most people land here)
- 70-100%: Full achievement (great!)
- 100%+: Exceeded (OKRs may have been too easy)

**Performance Rating** (Annual, based on 4 quarters):

- **Exceeds Expectations**: Consistently 80%+ OKR achievement, high impact
- **Meets Expectations**: Consistently 60-80% achievement, solid contributor
- **Needs Improvement**: <60% achievement, performance concerns (PIP possible)

---

### Annual Reviews & Compensation

**Timeline**:

- **January**: Annual performance review (roll up 4 quarterly reviews)
- **February**: Compensation review (raises, bonuses, promotions)
- **March**: Equity refresh grants (for high performers)

**Compensation Philosophy**:

- **Market Rate**: Pay 50th-75th percentile (competitive but not top-of-market)
- **Merit Raises**: 3-5% for "Meets", 8-12% for "Exceeds", 0% for "Needs Improvement"
- **Promotions**: 10-20% raise when promoted (significant jump)
- **Bonuses**: 10-20% of base for executives, tied to company performance

---

## Knowledge Management Budget

**Software** (Tooling costs):

- Notion (Wiki): $10/user/month × 50 users = $6,000/year
- GitHub Enterprise: $21/user/month × 20 engineers = $5,040/year
- Zendesk (Support KB): $10,000/year
- Training platform (Lessonly or EdApp): $5,000/year
- **Total**: $26K/year

**Content Creation** (People costs):

- Technical writer (0.5 FTE, Month 12+): $50K/year
- Video production (contractor): $10K/year (10 training videos)
- **Total**: $60K/year (Month 12+)

**Training & Development** (External):

- Sales training (external workshops): $10K/year
- Leadership development (executive coaching): $20K/year
- Conference attendance (10 people × $2K/person): $20K/year
- **Total**: $50K/year

**Grand Total**: $136K/year (Months 12-36), ~$40K Year 1 (lighter initially)

---

## Onboarding Success Metrics

### Track These KPIs

**Time to Productivity** (Days until fully ramped):

- **Engineering**: Target 60 days (first feature shipped)
- **Sales**: Target 90 days (first deal closed)
- **Customer Success**: Target 60 days (managing 25 accounts)

**New Hire Retention** (% still employed after 1 year):

- **Target**: >85% (industry average ~70%)
- **Measure**: Cohort analysis (e.g., "Of 10 people hired Q1 2026, how many are still here Q1 2027?")

**Onboarding Satisfaction** (Survey after Day 30):

- **Question**: "How satisfied were you with your onboarding experience?" (1-5 scale)
- **Target**: Average 4.0+ ("satisfied" or "very satisfied")
- **Open Feedback**: "What could we improve?"

**Manager Satisfaction** (Survey after Day 90):

- **Question**: "Is this new hire fully ramped and productive?" (Yes/No/Partial)
- **Target**: 90% "Yes"
- **If "No"**: What's blocking them?

---

## Conclusion: Onboarding is Retention

**Why Onboarding Matters**:

- 20% of employee turnover happens in first 45 days (poor onboarding)
- Great onboarding → 82% improvement in retention (Glassdoor study)
- Time to productivity matters: 60 days vs. 180 days = 4 extra productive months/year

**Fair Underwriting's Onboarding Commitment**:

- ✅ Structured 30/60/90-day plans (not "figure it out yourself")
- ✅ Assigned buddy system (never alone)
- ✅ Manager check-ins (weekly Month 1, bi-weekly Month 2-3, then monthly)
- ✅ Self-service knowledge base (documentation answers questions)
- ✅ Continuous improvement (survey feedback drives iteration)

**ROI Calculation**:

- **Investment**: $136K/year onboarding & knowledge management
- **Value Created**:
  - 30-day faster ramp = 1 extra month productivity/year/employee = 50 employees × $10K/month = $500K/year
  - 10% lower turnover = 5 fewer backfills/year × $30K recruiting cost = $150K/year saved
  - Total value: $650K/year
- **Net ROI**: $650K - $136K = **$514K/year benefit** (378% ROI)

**Next Steps**: Combine all 6 documents (Features #54A-C and #55A-C) into master implementation playbook for Fair Underwriting execution.

---

**Document Status**: Complete
**Owner**: VP People (HR Manager until VP hired)
**Review Frequency**: Quarterly (iterate based on new hire feedback)
**Last Updated**: November 8, 2025
**Next Review**: February 2026 (after first 5 hires complete onboarding)
