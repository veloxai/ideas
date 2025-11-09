# Feature #55B: Culture, Values & Communication Framework

**Feature Category**: Change Management & Organizational Transformation
**Status**: Culture Design
**Last Updated**: November 8, 2025
**Estimated Budget**: Included in HR & Organizational Development ($120K/year Feature #55 total)

---

## Executive Summary

Organizational structure (#55A) defines **who reports to whom**—but culture defines **how we work together**. Without intentional culture design, Fair Underwriting risks:

**Problems Without Defined Culture**:

- ❌ Toxic behaviors proliferate (politics, blame, territorialism)
- ❌ Decision-making is unclear ("who decides this?")
- ❌ Communication breaks down (silos, information hoarding)
- ❌ Conflict escalates (no resolution process)
- ❌ Remote work fails (no trust, micromanagement)
- ❌ New hires confused ("how do things work here?")

**With Intentional Culture Design**:

- ✅ **Shared values** guide behavior (everyone knows "how we do things")
- ✅ **Clear decision-making** frameworks (speed + quality)
- ✅ **Communication rituals** prevent silos (all-hands, standups, async updates)
- ✅ **Conflict resolution** process (productive disagreement)
- ✅ **Remote-first** policies enable distributed teams
- ✅ **Onboarding** teaches culture explicitly (not osmosis)

This document defines:

1. **Fair Underwriting's 6 Core Values** (with behavioral examples)
2. **Communication rituals** (daily, weekly, monthly, quarterly)
3. **Decision-making frameworks** (who decides what, how fast)
4. **Conflict resolution process** (disagree and commit)
5. **Remote work policies** (async-first, trust-based)
6. **Culture measurement** (how to track and maintain)

---

## Fair Underwriting's Core Values

### Value #1: **Privacy First, Always** 🔒

**What it means**: Customer genetic data privacy is non-negotiable. When speed and privacy conflict, privacy wins.

**Behavioral Examples**:

✅ **DO THIS**:

- Question any feature that could risk customer privacy
- Report security vulnerabilities immediately (no shame, only gratitude)
- Encrypt genetic data at rest + in transit (no shortcuts)
- Say "no" to partners who want access to individual customer data
- Design systems with privacy by default (opt-in, not opt-out)

❌ **NOT THIS**:

- "Let's launch this feature now, we'll fix security later"
- Storing genetic data unencrypted "temporarily" (it becomes permanent)
- Giving engineers production database access without audit logs
- Sharing customer stories publicly without explicit written consent

**Stories That Reinforce This Value**:

- **The Rejected Partnership** (Month 8): Large insurer offers $5M contract if they get access to MZ carrier names. Fair Underwriting says no, walks away. Partners respect this, trust increases.
- **The Security Hero** (Month 10): Junior engineer finds SQL injection vulnerability, reports immediately. CEO praises publicly, gives $5K bonus + "Security Hero" award. No one is embarrassed about the bug—focus is on fixing it.

**How We Measure This**:

- Zero data breaches (tracked monthly)
- 100% of vendors have signed BAAs (tracked quarterly)
- Security audit pass rate (annual)
- Employee surveys: "Do you feel empowered to raise privacy concerns?" (target: 100% yes)

---

### Value #2: **Customers Before Company** 👥

**What it means**: When customer needs and company profits conflict, optimize for customer outcomes (ethical, long-term thinking).

**Behavioral Examples**:

✅ **DO THIS**:

- Recommend genetic counseling even if it's free (customer needs it)
- Refund customers who are dissatisfied (no questions asked <$500)
- Proactively notify MZ carriers of new research (even if they didn't pay for monitoring)
- Build features customers need (not features that maximize short-term revenue)
- Support customers through difficult health journeys (empathy, not transactional)

❌ **NOT THIS**:

- Upselling customers on tests they don't need (revenue extraction)
- Hiding bad news in results (sugar-coating, false hope)
- Making cancellation difficult (dark patterns, friction)
- Ignoring customer feedback because "we know better"
- Prioritizing flashy features over core experience improvements

**Stories That Reinforce This Value**:

- **The Refund That Built Trust** (Month 7): Customer unhappy with test experience, requests refund. CSM refunds immediately + sends apology gift. Customer becomes advocate, refers 3 friends.
- **The Life-Saving Alert** (Month 15): Fair Underwriting notices customer's AAT levels dropped to dangerous levels (acute illness), proactively calls customer and recommends ER visit. Customer's life saved. Story goes viral, NPS jumps 15 points.

**How We Measure This**:

- Net Promoter Score (NPS) target: 65+ (world-class)
- Customer retention rate: 90%+ annual retention
- Support ticket resolution time: <24 hours
- Customer stories: "Fair Underwriting saved my life" testimonials (collect and share)

---

### Value #3: **Speed Beats Perfection** ⚡

**What it means**: Ship fast, iterate faster. Done is better than perfect (within compliance/security boundaries).

**Behavioral Examples**:

✅ **DO THIS**:

- Ship MVP with 8 features (not 30)
- Deploy to production daily (continuous deployment)
- Run beta tests with real customers (not 6-month internal testing)
- Make decisions with 70% information (not 100%)
- Fail fast, learn, pivot (celebrate smart failures)

❌ **NOT THIS**:

- Delaying launch for non-critical "nice-to-have" features
- Waiting for perfect designs before coding (analysis paralysis)
- Endless meetings to reach consensus (diminishing returns)
- "We need more data" when data won't change the decision
- Perfectionism that delays customer value delivery

**Stories That Reinforce This Value**:

- **The MVP Launch** (Month 6): Fair Underwriting launches with 8 features (not 30). Some features are basic, but pilots start on time. Iterate based on feedback, add features Month 7-12.
- **The Quick Pivot** (Month 9): Partner requests employer wellness dashboard. Product team builds prototype in 1 week (not 3 months), tests with partner, gets feedback, iterates. Feature live Month 10.

**How We Measure This**:

- Sprint velocity (story points per sprint, increasing over time)
- Time from idea to production (target: <4 weeks for new features)
- Deployment frequency (target: daily deploys by Month 12)
- Decision latency (time from question to decision, target: <48 hours)

**Important Caveat**: Speed does NOT compromise privacy/security (Value #1) or customer trust (Value #2). Fast + reckless = bad. Fast + thoughtful = good.

---

### Value #4: **Transparent by Default** 📖

**What it means**: Share information openly (unless legal/privacy reasons prevent it). No information hoarding, no politics.

**Behavioral Examples**:

✅ **DO THIS**:

- Share financials with team monthly (runway, revenue, burn rate)
- Document decisions publicly (Notion, Slack, not DMs)
- Default to public Slack channels (not private DMs)
- Share board meeting notes (redact confidential items only)
- Explain "why" behind decisions (context helps alignment)
- Admit mistakes publicly (transparency builds trust)

❌ **NOT THIS**:

- Keeping financials secret from team (creates anxiety, rumors)
- Making decisions in private, announcing without context
- Information silos (engineering doesn't know what sales is doing)
- Sugarcoating bad news (team deserves honest updates)
- "You don't need to know that" unless truly confidential

**Stories That Reinforce This Value**:

- **The Honest Runway Update** (Month 11): CEO shares with team: "We have 4 months of runway, raising Series A, 50% chance we raise by Month 14, 50% chance we need bridge round or layoffs." Team appreciates honesty, rallies together, helps with investor intros. Series A closes Month 13.
- **The Public Postmortem** (Month 8): Production outage affects 500 customers. Engineering team writes detailed postmortem, shares with entire company + affected partners. Transparency builds trust, no one is blamed personally.

**How We Measure This**:

- Employee surveys: "I have the information I need to do my job well" (target: 90%+ agree)
- Documentation coverage: Are key decisions documented? (audit quarterly)
- Slack public channel usage: >80% of conversations in public channels (not DMs)

**Transparency Boundaries** (when NOT to share):

- ❌ Individual compensation (privacy)
- ❌ Personnel issues (HR confidentiality)
- ❌ Customer genetic data (HIPAA)
- ❌ Fundraising negotiations before closed (NDA, market dynamics)
- ❌ M&A discussions (NDA, legal)

---

### Value #5: **Disagree and Commit** 🤝

**What it means**: Debate decisions vigorously, but once decided, everyone commits 100% (no passive-aggressive undermining).

**Behavioral Examples**:

✅ **DO THIS**:

- Voice disagreements clearly in meetings (respectful but direct)
- Provide data/reasoning for your position (not just opinions)
- Listen to other perspectives with open mind
- Once decision is made (by decision-maker), commit fully
- Support the decision publicly (even if you disagreed privately)
- If decision fails, say "we learned" (not "I told you so")

❌ **NOT THIS**:

- Silent in meetings, complain after decision is made
- Undermining decisions you disagreed with ("I knew this wouldn't work")
- Relitigating closed decisions (drains energy)
- Saying "yes" in meetings, doing nothing (passive-aggressive)
- Weaponizing "I told you so" when decision fails

**Stories That Reinforce This Value**:

- **The Mobile App Debate** (Month 7): Product Manager wants to delay mobile apps to Month 12 (focus on web). VP Sales wants mobile apps Month 7 (customers demanding). 2-hour debate, CEO decides: launch mobile apps Month 9 (compromise). VP Sales disagrees but commits, helps with beta testing. Mobile apps successful, VP Sales says "CEO was right, this timeline worked."
- **The Pricing Disagreement** (Month 10): CFO recommends $200/test pricing (maximize revenue). VP Sales recommends $75/test pricing (maximize volume). Board decides $100/test (split difference). CFO commits fully, builds financial model around $100 pricing. Decision works well, both were partially right.

**How We Measure This**:

- Decision velocity (do debates drag on or conclude quickly?)
- Post-decision commitment (do people execute or slow-walk?)
- Retrospectives: Did we debate well? Did we commit well?

**Escalation Process** (when to reopen decisions):

- If new information emerges that invalidates assumptions (e.g., partner cancels, making decision obsolete)
- If decision leads to crisis (e.g., security vulnerability, customer churn spike)
- NOT if you simply disagree (decisions are not relitigated without new evidence)

---

### Value #6: **Lifelong Learners** 📚

**What it means**: Healthcare + genetic testing + insurance is complex. We hire people who admit what they don't know and learn fast.

**Behavioral Examples**:

✅ **DO THIS**:

- Say "I don't know, let me research and get back to you"
- Ask "dumb" questions (no question is dumb)
- Share what you learned (Slack, lunch & learns, documentation)
- Read papers, attend conferences, take courses
- Teach others (mentoring, presentations, blog posts)
- Embrace feedback (growth mindset, not defensive)

❌ **NOT THIS**:

- Pretending to know things you don't (ego > truth)
- "That's not my job" when asked to learn new skill
- Blaming others for your mistakes (fixed mindset)
- Ignoring feedback (defensiveness)
- Doing things the same way forever (complacency)

**Stories That Reinforce This Value**:

- **The Engineer Who Became a Genetics Expert** (Month 10): Backend engineer knew nothing about AATD. Spent 40 hours reading papers, talking to genetic counselors. Built intelligent alerting system that detects acute exacerbations. Promoted to Senior Engineer Month 14.
- **The Lunch & Learn Culture** (Month 8+): Every Friday, someone presents what they learned that week. Topics: HIPAA compliance, React performance optimization, sales objection handling, genetic counseling techniques. Team gets smarter together.

**How We Measure This**:

- Learning budget utilized: $2K/person/year for courses, conferences, books (target: 80% utilized)
- Lunch & learn attendance (target: 50%+ of team)
- Internal promotions: >50% of leadership roles filled internally (learning → growth)
- Employee surveys: "I am learning and growing in my role" (target: 85%+ agree)

---

## Communication Rituals

### Daily Communication

**Engineering Daily Standup** (15 min, 9:00 AM PT)

- **Format**: What did I do yesterday? What am I doing today? Any blockers?
- **Facilitator**: Rotates weekly
- **Attendees**: All engineers (15-20 people by Month 12)
- **Remote-Friendly**: Zoom + written updates in Slack for async teammates
- **Outcome**: Identify blockers, coordinate work, build team cohesion

**Support Triage** (30 min, 8:30 AM PT)

- **Format**: Review overnight support tickets, assign to engineering if bugs
- **Attendees**: CSMs + 1 engineer on support rotation
- **Outcome**: Critical issues escalated immediately

---

### Weekly Communication

**All-Hands Meeting** (30 min, Fridays 4:00 PM PT)

- **Format**:
  - CEO updates (5 min): Company metrics (partners, customers, revenue, runway)
  - Department updates (15 min): Engineering, Sales, Marketing, CS (2-3 min each)
  - Wins of the week (5 min): Celebrate successes (deal closed, feature shipped, customer testimonial)
  - Q&A (5 min): Open questions
- **Attendees**: Entire company (mandatory unless customer emergency)
- **Remote-Friendly**: Zoom, recorded for those who can't attend live
- **Outcome**: Transparency, alignment, celebration

**Leadership Team Sync** (60 min, Mondays 10:00 AM PT)

- **Format**: CEO + direct reports (CTO, VP Sales, VP Marketing, VP CS, Med Director, VP Ops)
- **Agenda**:
  - Department metrics review (15 min)
  - Key decisions needed (20 min)
  - Cross-functional coordination (15 min)
  - Risks and roadblocks (10 min)
- **Outcome**: Leadership alignment, fast decision-making

**Department Team Meetings** (30-60 min, varies by team)

- **Engineering**: Tuesdays 2:00 PM (sprint planning, tech talks)
- **Sales**: Wednesdays 11:00 AM (pipeline review, deal coaching)
- **Marketing**: Thursdays 3:00 PM (campaign reviews, content planning)
- **Customer Success**: Fridays 10:00 AM (customer health scores, escalations)

**1-on-1s** (30 min, weekly or bi-weekly)

- **Format**: Manager + direct report
- **Agenda**: Career growth, feedback, blockers, personal check-in
- **Best Practice**: Direct report drives agenda (not manager)
- **Outcome**: Trust, development, retention

---

### Monthly Communication

**Board Meeting** (2 hours, last Thursday of month)

- **Attendees**: CEO, CFO, CTO, Board members
- **Format**:
  - Financial review (20 min): Revenue, expenses, runway, burn multiple
  - Metrics dashboard (20 min): Customers, NPS, churn, sales pipeline
  - Key decisions (30 min): Strategic issues requiring board input
  - Executive session (30 min): Board only, CEO feedback
- **Outcome**: Board governance, strategic guidance

**Company Metrics Review** (30 min, first Monday of month)

- **Attendees**: All employees
- **Format**: CFO presents financials transparently
  - Revenue, expenses, cash, runway
  - Customer metrics (enrollments, NPS, churn)
  - Sales pipeline, marketing funnel
- **Outcome**: Financial literacy, shared ownership

**Lunch & Learn** (60 min, Fridays 12:00 PM PT)

- **Format**: Employee presents topic they learned
- **Topics**: Technical (new framework), domain (genetics), process (sales technique)
- **Outcome**: Knowledge sharing, learning culture

---

### Quarterly Communication

**Quarterly Planning** (4 hours, first week of quarter)

- **Attendees**: Leadership team
- **Format**: Set OKRs (Objectives & Key Results) for next quarter
- **Outcome**: Aligned priorities, clear goals

**Quarterly Retrospective** (2 hours, last week of quarter)

- **Format**: What went well? What didn't? What will we change?
- **Attendees**: Entire company (or by department if >50 people)
- **Outcome**: Continuous improvement

**Company Offsite** (2 days, quarterly)

- **Format**: Strategic planning, team building, fun
- **Activities**: Vision workshops, brainstorming, hiking/games
- **Outcome**: Bonding, strategic clarity, burnout prevention

---

### Async Communication Norms

**Default to Written Communication** (Not Meetings)

✅ **Use Slack for**:

- Quick questions (async, don't interrupt focus time)
- Status updates (FYI, no response needed)
- Celebrating wins (public kudos)
- Coordination (scheduling, logistics)

✅ **Use Notion/Google Docs for**:

- Decisions (document context, options, decision, rationale)
- Proposals (RFC: Request for Comment)
- Specs (product requirements, technical designs)
- Onboarding (new hire guides, runbooks)

✅ **Use Email for**:

- External communication (customers, partners, investors)
- Official notifications (HR, legal, compliance)
- NOT for internal discussions (use Slack instead)

❌ **Don't Use Meetings for**:

- Information sharing (use Slack, Notion instead—async-first)
- Status updates (use written updates)
- FYI announcements (write it down, no meeting needed)

✅ **DO Use Meetings for**:

- Brainstorming (real-time collaboration is faster)
- Debates (need to discuss multiple perspectives)
- Building relationships (1-on-1s, team bonding)
- Complex decisions (nuance requires dialogue)

---

## Decision-Making Frameworks

### Framework #1: **DRI (Directly Responsible Individual)**

**Concept**: Every decision has ONE person who is accountable (not committees, not consensus).

**How It Works**:

- For every project/decision, assign a DRI
- DRI gathers input (consults relevant people)
- DRI makes final call (owns outcome)
- Team commits to DRI's decision (disagree and commit)

**Examples**:

| Decision Type        | DRI                   |
| -------------------- | --------------------- |
| Product roadmap      | VP Product            |
| Sprint priorities    | Engineering Team Lead |
| Sales comp plan      | VP Sales              |
| Marketing budget     | VP Marketing          |
| Partner pricing      | CEO                   |
| Architecture choices | CTO                   |
| Hiring decisions     | Hiring Manager        |

**What If DRI Gets It Wrong?**

- DRI owns the outcome (accountability)
- Team helps fix it (no blame, focus on solution)
- Retrospective: What did we learn? (growth mindset)
- Adjust process for next time (improve decision-making)

---

### Framework #2: **Escalation Ladder**

**Concept**: Decisions escalate only when lower level can't decide (empowerment, not micromanagement).

**Levels**:

**Level 1: Individual Contributor** (Decide on your own)

- Day-to-day execution decisions
- Technical implementation details
- Customer support responses (within guidelines)
- Example: "Should I use React Query or SWR?" → IC decides

**Level 2: Team Lead** (Decide after consulting team)

- Sprint priorities
- Small scope changes
- Hiring decisions (IC level)
- Example: "Should we refactor this codebase?" → Team Lead consults engineers, decides

**Level 3: Department Head** (VP Engineering, VP Sales, etc.)

- Department strategy
- Budget allocation within department
- Hiring decisions (manager level)
- Example: "Should we build mobile apps Month 7 or Month 12?" → VP Engineering decides (after consulting CTO, Product Manager)

**Level 4: CEO** (Decide on company-wide issues)

- Company strategy
- Partner pricing
- Fundraising
- Major hires (VP level+)
- Example: "Should we pivot to employers instead of insurers?" → CEO decides (after consulting board, leadership team)

**Level 5: Board** (Decide on existential issues)

- Fundraising terms
- M&A
- CEO compensation/firing
- Example: "Should we accept acquisition offer?" → Board decides

**Anti-Pattern**: Escalating decisions that should be made lower (disempowers team, slows velocity)

---

### Framework #3: **RAPID Decision-Making** (Fast Decisions)

**Concept**: For high-stakes, fast-moving decisions, use RAPID framework (Bain & Company model)

**R**ecommend: Person who proposes decision (gathers data, creates options)
**A**gree: People who must agree (e.g., Legal on contracts, Compliance on data handling)
**P**erform: People who execute the decision
**I**nput: People who provide input (consulted but don't have veto)
**D**ecide: ONE person who makes final call

**Example: Should Fair Underwriting offer free genetic counseling to MZ carriers?**

- **Recommend**: Product Manager (researches costs, customer value, competitive landscape)
- **Agree**: CFO (budget impact), CMO (medical ethics, compliance)
- **Perform**: Customer Success team (delivers counseling)
- **Input**: Genetic Counselors (feasibility, workload), Sales (customer demand)
- **Decide**: CEO (final call, owns trade-off between customer value and profitability)

**Outcome**: Decision made in 1 week (not 3 months)

---

## Conflict Resolution Process

### Step 1: Direct Conversation (Attempt to Resolve 1-on-1)

**When**: You disagree with colleague's decision, approach, or behavior

**How**:

- Schedule 30-min 1-on-1 (don't ambush in public)
- Use "I feel..." statements (not "You always...")
- Seek to understand (maybe you're missing context)
- Find compromise (both sides give a little)

**Example**: Engineer disagrees with Product Manager's feature prioritization

- Engineer: "I feel frustrated that we're prioritizing Feature X over Feature Y. Can you help me understand the reasoning?"
- PM: "Feature X unblocks a $500K deal. Feature Y is important but not revenue-blocking this quarter."
- Engineer: "Got it, that makes sense. Can we commit to Feature Y next sprint?"
- PM: "Absolutely, I'll put it at the top of next sprint."

**Outcome**: 70% of conflicts resolved here (most issues are misunderstandings)

---

### Step 2: Mediation (Bring in Manager)

**When**: Direct conversation fails to resolve conflict after 2 attempts

**How**:

- Both parties meet with shared manager (or skip-level if manager is party to conflict)
- Each person explains their perspective (5 min each)
- Manager asks clarifying questions
- Manager either:
  - **Facilitates compromise** (if both sides have valid points)
  - **Makes decision** (if no compromise possible, manager decides)

**Example**: VP Sales and VP Marketing disagree on marketing budget allocation

- VP Sales: "Marketing should spend more on sales enablement, less on brand awareness"
- VP Marketing: "Brand awareness drives inbound leads, which Sales wants"
- CRO (their manager): "Both are valid. Let's split: 60% sales enablement, 40% brand awareness this quarter. We'll revisit next quarter based on data."

**Outcome**: 25% of conflicts escalate here, most are resolved

---

### Step 3: Escalation (CEO or Board)

**When**: Manager mediation fails, or conflict is existential (e.g., founder conflict)

**How**:

- CEO makes final decision (for operational conflicts)
- Board makes final decision (for founder/CEO conflicts)
- Decision is final (no relitigating)

**Example**: CTO and CEO disagree on technical direction (build vs. buy)

- CTO wants to build proprietary genetic vault (12 months, full control)
- CEO wants to buy vendor solution (2 months, less control but faster)
- Board discusses trade-offs, decides: Buy vendor solution for MVP, build proprietary vault Year 2
- Both CTO and CEO commit (disagree and commit)

**Outcome**: 5% of conflicts escalate here (rare but necessary)

---

## Remote Work Policies

### Remote-First Philosophy

**Fair Underwriting is remote-first** (not remote-friendly or hybrid):

- No headquarters (avoid "remote employees are second-class citizens")
- Distributed team (hire anywhere in US, international in future)
- Async-first communication (respect timezones)
- In-person offsites quarterly (build relationships)

**Why Remote-First?**

- **Talent**: Hire best people anywhere (not just SF/NYC)
- **Cost**: No expensive office lease ($50K+/month saved)
- **Flexibility**: Parents, caregivers, people with disabilities benefit
- **Productivity**: Fewer interruptions, deep focus time

---

### Remote Work Guidelines

**Core Hours** (Synchronous Time)

- 10:00 AM - 2:00 PM Pacific Time (overlap for meetings)
- Attend core meetings (all-hands, team meetings, 1-on-1s)
- Available on Slack during core hours (respond within 2 hours)

**Flexible Hours** (Async Time)

- Work when you're most productive (early bird? Night owl? Both OK)
- As long as work gets done, hours don't matter
- Take breaks (walk, gym, errands—trust-based culture)

**Communication Norms**:

- ✅ Assume good intent (text lacks tone, don't assume rudeness)
- ✅ Use video for 1-on-1s (builds relationship)
- ✅ Use Slack threads (keep conversations organized)
- ✅ Set Slack status (in meeting, focus time, out of office)
- ❌ Don't expect instant responses (async-first means delays are OK)
- ❌ Don't message at 11pm and expect reply (respect boundaries)

**Equipment**:

- Company provides: Laptop, monitor, keyboard, mouse, headphones ($3K budget)
- $500/year stipend for home office (desk, chair, lighting)
- Co-working space allowance if needed ($200/month)

---

### In-Person Gatherings

**Quarterly Offsites** (2 days)

- **Purpose**: Strategic planning + team bonding + fun
- **Format**:
  - Day 1: Workshops (OKR planning, retrospectives, brainstorming)
  - Day 2: Team building (hiking, escape room, dinners)
- **Location**: Rotates (SF, Austin, Miami—team votes)
- **Cost**: Company pays flights, hotels, meals ($2K/person)

**Annual Kickoff** (3 days, January)

- **Purpose**: Set annual vision, celebrate prior year, deep team bonding
- **Format**:
  - Day 1: All-hands presentations, vision, strategy
  - Day 2: Department planning, team activities
  - Day 3: Fun (wine tasting, sports, games)

**Team On-Sites** (Optional, quarterly)

- Engineering team wants to work together in person? Book co-working space for a week
- Sales team wants to do joint customer visits? Fly to city, work together
- Customer Success wants training week? Rent Airbnb, intensive training

---

## Culture Measurement & Maintenance

### How We Measure Culture Health

**Quarterly Employee Engagement Survey** (10 questions, 5-min)

Questions:

1. **Alignment**: I understand Fair Underwriting's mission and strategy (1-10)
2. **Growth**: I am learning and growing in my role (1-10)
3. **Manager**: My manager supports my success (1-10)
4. **Peers**: I trust my teammates (1-10)
5. **Communication**: I have the information I need to do my job (1-10)
6. **Values**: Fair Underwriting lives its values (1-10)
7. **Recognition**: I feel appreciated for my contributions (1-10)
8. **Work-Life**: I can balance work and personal life (1-10)
9. **Recommend**: I would recommend Fair Underwriting as a great place to work (1-10)
10. **Anything Else**: Open feedback (text)

**Healthy Culture Targets**:

- Average score: 8.0+ (out of 10)
- eNPS (employee Net Promoter Score): 50+
- Participation rate: 90%+ (anonymity guaranteed)

---

### How We Maintain Culture (As We Scale)

**Challenge**: Culture erodes as company grows (5 → 20 → 50 → 100 people)

**Solutions**:

**1. Culture Onboarding** (Every New Hire)

- Day 1: CEO presents company values (30 min)
- Week 1: New hire reads culture doc, discusses with manager
- Month 1: New hire identifies one way they'll contribute to culture

**2. Values Recognition** (Weekly)

- All-hands: Call out examples of people living values
- Slack #kudos channel: Public recognition
- Quarterly awards: "Privacy Hero", "Customer Champion", "Learning Leader"

**3. Culture Retrospectives** (Quarterly)

- What cultural behaviors are we seeing more of? (celebrate)
- What behaviors are we seeing less of? (course correct)
- What needs to change? (adapt values as we scale)

**4. Hiring for Culture Add** (Not Culture Fit)

- **Culture Fit**: Hire people who already match culture (leads to homogeneity)
- **Culture Add**: Hire people who bring new perspectives (diversity, evolution)
- Interview question: "Tell me about a time you challenged the status quo"

**5. Fire for Culture Violations** (Zero Tolerance)

- Privacy violations: Immediate termination (non-negotiable)
- Toxicity (bullying, harassment, discrimination): Immediate termination
- Undermining decisions after "disagree and commit": Warning, then termination if repeated

---

## Conclusion: Culture is Competitive Advantage

**Most startups fail due to culture breakdown, not product failure**:

- 65% of startups fail due to team conflict (co-founder breakups, toxic culture)
- 23% fail due to lack of focus (poor decision-making, no priorities)
- 17% fail due to poor communication (silos, information hoarding)

**Fair Underwriting's Culture is a Moat**:

- **Privacy-First Culture** → Customer trust → Competitive differentiation
- **Customer-Before-Company Culture** → NPS 65+ → Organic growth via referrals
- **Speed Culture** → Fast execution → Beat competitors to market
- **Transparent Culture** → High trust → Low politics, high velocity
- **Disagree-and-Commit Culture** → Fast decisions → No analysis paralysis
- **Learning Culture** → Continuous improvement → Adapt to market changes

**Next Document**: Feature #55C will design **onboarding and knowledge management** systems to scale this culture.

---

**Document Status**: Complete
**Owner**: CEO + VP People (HR)
**Review Frequency**: Quarterly (culture evolves as company scales)
**Last Updated**: November 8, 2025
**Next Review**: February 2026 (after Month 3, refine based on early learnings)
