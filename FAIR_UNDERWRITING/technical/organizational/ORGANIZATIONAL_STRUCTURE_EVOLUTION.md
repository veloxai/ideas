# Feature #55A: Organizational Structure Evolution

**Feature Category**: Change Management & Organizational Transformation
**Status**: Organization Design
**Last Updated**: November 8, 2025
**Estimated Budget**: Included in HR & Organizational Development ($120K/year Feature #55 total)

---

## Executive Summary

Fair Underwriting will grow from **0 → 75 employees in 36 months**. Without organizational design, this creates chaos:

**Problems Without Structure**:

- ❌ No one knows who makes decisions (paralysis)
- ❌ Teams step on each other's toes (conflict)
- ❌ Critical work falls through cracks (no ownership)
- ❌ New hires confused about reporting lines (low productivity)
- ❌ Culture becomes toxic (politics, finger-pointing)

**With Clear Organizational Structure**:

- ✅ RACI matrix defines decision authority (clarity)
- ✅ Reporting lines crystal clear (accountability)
- ✅ Roles evolve with company stage (startup → scale-up → enterprise)
- ✅ New hires onboard fast (know who to ask)
- ✅ Culture scales (values embedded in structure)

This document provides:

1. **4 organizational phases** (Day 1, Month 6, Month 12, Month 24)
2. **Org charts** with reporting lines and team sizes
3. **Role definitions** (responsibilities, decision authority)
4. **RACI matrices** (Responsible, Accountable, Consulted, Informed)
5. **Transition playbooks** (how to reorganize as company grows)

---

## Organization Design Philosophy

### Startup → Scale-up → Enterprise Evolution

**Phase 1: Startup (Day 1 - Month 6, 5 → 20 people)**

- **Structure**: Flat, everyone reports to CEO
- **Decision-Making**: Consensus-driven, founders make final calls
- **Communication**: Daily standups, everyone knows everything
- **Culture**: Scrappy, all-hands-on-deck, no job titles matter

**Phase 2: Scale-Up (Month 7 - Month 24, 20 → 50 people)**

- **Structure**: Functional teams (Engineering, Sales, Marketing, Customer Success)
- **Decision-Making**: Department heads have autonomy, CEO focuses on strategy
- **Communication**: Weekly all-hands, async updates, not everyone in every meeting
- **Culture**: Process-driven, specialization, job titles start mattering

**Phase 3: Enterprise (Month 25 - Month 36+, 50 → 100+ people)**

- **Structure**: Divisional (Product, GTM, Operations), matrix for cross-functional work
- **Decision-Making**: VPs run divisions, CEO/Board set vision
- **Communication**: Monthly all-hands, quarterly offsites, formal communication channels
- **Culture**: Scalable systems, career paths, leadership development

---

## Phase 1: Startup Structure (Day 1 - Month 6)

### Team Size: 5 → 20 people

### Month 1 (5 people) - The Founding Team

**Org Chart**:

```
CEO (Mark Egly or external hire)
├── CTO (1.0 FTE)
│   ├── Backend Engineer #1 (1.0 FTE)
│   └── Backend Engineer #2 (1.0 FTE)
├── Compliance Specialist (1.0 FTE) - reports directly to CEO for independence
```

**Why This Structure**:

- CEO owns everything (sales, fundraising, partnerships, strategy)
- CTO owns everything technical (product, engineering, infrastructure)
- Compliance reports to CEO (independent from engineering, avoids conflicts)
- Everyone is an IC (individual contributor), no middle management yet

**Decision Authority (RACI)**:

| Decision Type                | CEO | CTO | Compliance | Engineers |
| ---------------------------- | --- | --- | ---------- | --------- |
| **Company vision**           | A   | C   | I          | I         |
| **Product roadmap**          | A   | R   | C          | C         |
| **Architecture**             | I   | A   | I          | R         |
| **Hiring**                   | A   | R/C | C          | I         |
| **Fundraising**              | A   | C   | I          | I         |
| **Compliance policy**        | A   | C   | R          | C         |
| **Day-to-day eng decisions** | I   | A   | I          | R         |

**Legend**: A=Accountable (final decision), R=Responsible (does the work), C=Consulted (input), I=Informed (kept in loop)

---

### Month 3 (12 people) - Engineering Ramp

**Org Chart**:

```
CEO
├── CTO
│   ├── Backend Engineers (4) - 2 new hires
│   ├── Frontend Engineers (2) - NEW
│   ├── DevOps Engineer (1) - NEW
│   └── QA Engineer (1) - NEW
├── Compliance Specialist (1.0 FTE)
├── Legal Counsel (0.5 FTE) - NEW
├── HR Manager (0.5 FTE) - NEW (recruiting for Month 4-6)
```

**New Roles**:

- **Frontend Engineers**: Build customer + partner portals
- **DevOps Engineer**: AWS infrastructure, CI/CD, monitoring
- **QA Engineer**: Test framework, automated tests, manual testing
- **Legal Counsel** (part-time): Partner contracts, BAAs, compliance reviews
- **HR Manager** (part-time): Recruiting for upcoming hiring wave

**Team Dynamics** (Month 3):

- Still flat structure (everyone reports to CEO or CTO)
- Engineering team size: 8 people (manageable for CTO to lead directly)
- Weekly all-hands (30 min): CEO shares progress, everyone knows company status
- Daily eng standup (15 min): CTO facilitates, blockers discussed
- No middle managers yet (too early)

---

### Month 6 (20 people) - MVP Launch Team

**Org Chart**:

```
CEO
├── CTO
│   ├── VP Engineering (NEW) - manages engineering team
│   │   ├── Backend Team (4 engineers)
│   │   ├── Frontend Team (2 engineers)
│   │   ├── DevOps Engineer (1)
│   │   ├── QA Engineers (2) - 1 new hire
│   │   └── Integration Engineer (1) - NEW
│   └── Product Manager (1.0 FTE) - NEW, reports to CTO
├── VP Sales (1.0 FTE) - NEW
│   └── Account Executive (1.0 FTE) - NEW
├── CMO (0.5 FTE) - NEW
│   └── Content Writer (1.0 FTE) - NEW
├── Medical Director (0.5 FTE) - NEW
│   └── Genetic Counselor (1.0 FTE) - NEW
├── Customer Success Manager (1.0 FTE) - NEW
├── Compliance Specialist (1.0 FTE)
├── Legal Counsel (0.5 FTE)
├── HR Manager (0.5 FTE)
```

**Key Changes** (Month 6 vs. Month 3):

- **VP Engineering hired**: CTO can't manage 10 engineers + product strategy
  - VP Eng manages day-to-day engineering execution
  - CTO focuses on architecture, product strategy, technical vision
- **Go-to-Market team hired**: Sales + Marketing now exist
- **Clinical team hired**: Medical Director + Genetic Counselor for customer support
- **Product Manager hired**: Prioritizes backlog, writes requirements, unblocks engineers

**Reporting Structure Maturation**:

- **Month 1-5**: CEO directly manages 12 people (chaotic but works at small scale)
- **Month 6**: CEO manages 7 direct reports (VP Eng, VP Sales, CMO, Med Director, CSM, Compliance, HR)
  - Still manageable (7 directs is healthy for CEO)
  - Functional leaders (VP Eng, VP Sales, CMO) now manage their teams

**Decision Authority Updates** (Month 6):

| Decision Type         | CEO | CTO | VP Eng | Product Manager | VP Sales |
| --------------------- | --- | --- | ------ | --------------- | -------- |
| **Product roadmap**   | A   | R   | C      | R               | C        |
| **Sprint priorities** | I   | C   | A      | R               | I        |
| **Architecture**      | I   | A   | C      | C               | I        |
| **Eng team hiring**   | C   | C   | A      | I               | I        |
| **Sales strategy**    | A   | I   | I      | I               | R        |
| **Partner pricing**   | A   | C   | I      | C               | R        |

**Why VP Engineering Reports to CTO (not CEO)**:

- CTO remains technical leader (not pure manager)
- VP Eng handles tactical execution (sprint planning, performance reviews)
- CTO handles strategic decisions (architecture, technical debt, platform choices)
- In future (Month 24+), CTO may become Chief Product Officer, VP Eng reports to CEO

---

## Phase 2: Scale-Up Structure (Month 7 - Month 24)

### Month 12 (30 people) - Functional Teams Mature

**Org Chart**:

```
CEO
├── CTO / Chief Product Officer
│   ├── VP Engineering (1.0 FTE)
│   │   ├── Backend Team Lead (1 eng becomes lead)
│   │   │   └── Backend Engineers (5) - 1 new hire
│   │   ├── Frontend Team Lead (1 eng becomes lead)
│   │   │   └── Frontend Engineers (3) - 1 new hire
│   │   ├── Mobile Team (NEW)
│   │   │   ├── iOS Developer (1.0 FTE) - NEW
│   │   │   └── Android Developer (1.0 FTE) - NEW
│   │   ├── DevOps Engineers (2) - 1 new hire
│   │   ├── QA Engineers (2)
│   │   └── Integration Engineer (1)
│   └── Product Team
│       ├── Product Manager (1.0 FTE)
│       └── UI/UX Designer (1.0 FTE) - NEW
├── VP Sales (1.0 FTE)
│   ├── Account Executives (3) - 2 new hires
│   └── Sales Ops Manager (0.5 FTE) - NEW
├── VP Marketing (1.0 FTE) - CMO promoted to full-time
│   ├── Content Writer (1.0 FTE)
│   ├── SEO Specialist (0.5 FTE) - NEW
│   └── Digital Marketing Manager (1.0 FTE) - NEW
├── VP Customer Success (NEW, promoted from CSM)
│   ├── Customer Success Managers (3) - 2 new hires
│   └── Support Specialist (1.0 FTE) - NEW
├── Medical Director (0.75 FTE) - increased from 0.5
│   └── Genetic Counselors (2) - 1 new hire
├── Compliance Specialist (1.0 FTE)
├── Legal Counsel (0.5 FTE)
├── Financial Controller (0.5 FTE) - NEW
├── HR Manager (0.75 FTE) - increased from 0.5
```

**Total Headcount**: 30 people (from 20 → 30 in 6 months)

**Key Organizational Changes**:

1. **Engineering Team Leads Introduced** (Month 12)
   - Backend Team Lead: Manages 5 backend engineers
   - Frontend Team Lead: Manages 3 frontend engineers
   - **Why now?** VP Eng can't manage 15 ICs directly
   - Team Leads are player-coaches (70% coding, 30% people management)

2. **Functional VPs Established**
   - VP Sales, VP Marketing, VP Customer Success all have teams
   - VPs have autonomy over their functions (CEO not micromanaging)
   - CEO focuses on: fundraising, board, partnerships, vision

3. **Support Functions Added**
   - Financial Controller (Month 12): Company has revenue, needs financial management
   - Sales Ops Manager (Month 9): Salesforce, pipeline reporting, sales tools
   - HR Manager expanded (Month 6 → Month 12): Now doing benefits, performance reviews, culture

**Reporting Span**:

- **CEO direct reports**: 9 (CTO, VP Sales, VP Marketing, VP Customer Success, Med Director, Compliance, Legal, Controller, HR)
- **VP Engineering direct reports**: 6 team leads (Backend, Frontend, Mobile, DevOps, QA, Integration)
- **VP Sales direct reports**: 4 (3 AEs + Sales Ops)
- **VP Marketing direct reports**: 3 (Content, SEO, Digital)
- **VP Customer Success direct reports**: 4 (3 CSMs + Support)

**Healthy Span of Control**: 5-9 direct reports (achieved at Month 12)

---

### Month 18 (40 people) - Regional Sales Expansion

**Org Chart** (Additions to Month 12 structure):

```
CEO
├── CTO / Chief Product Officer (same as Month 12)
├── VP Sales
│   ├── East Region Sales Manager (NEW)
│   │   └── Account Executives (2) - NEW
│   ├── West Region Sales Manager (NEW)
│   │   └── Account Executives (2) - NEW
│   ├── Central Region Account Executive (1)
│   └── Sales Ops Manager (0.75 FTE)
├── VP Marketing (same as Month 12, +2 hires)
│   ├── Content Writer (1.0 FTE)
│   ├── SEO Specialist (0.75 FTE) - increased
│   ├── Digital Marketing Manager (1.0 FTE)
│   ├── Graphic Designer (0.5 FTE) - NEW
│   └── PR Manager (0.5 FTE) - NEW
├── VP Customer Success (same structure, +3 CSMs for 6 total)
├── VP Operations (NEW ROLE) - consolidates support functions
│   ├── Financial Controller (0.75 FTE)
│   ├── HR Manager (1.0 FTE) - now full-time
│   ├── Compliance Specialist (1.0 FTE)
│   ├── Legal Counsel (0.75 FTE)
│   └── Data Analyst (1.0 FTE) - NEW
├── Medical Director (1.0 FTE full-time)
│   └── Genetic Counselors (4) - 2 new hires
```

**Total Headcount**: 40 people

**Major Organizational Change: VP Operations Role**

**Why VP Operations Now?**

- CEO was managing 9 directs (too many)
- Support functions (Finance, HR, Compliance, Legal) are related
- VP Ops consolidates these → CEO now has 6 directs (CTO, Sales, Marketing, CS, Ops, Med Director)

**VP Operations Responsibilities**:

- Finance: Budget management, financial reporting, fundraising support
- HR: Recruiting, onboarding, benefits, performance management, culture
- Compliance: HIPAA, GINA, SOC 2, audits, security
- Legal: Contracts, IP, employment law
- Data/Analytics: Business intelligence, reporting, data governance

**Regional Sales Structure**:

- East Region (NYC, Boston, Philadelphia metro)
- West Region (San Francisco, Los Angeles, Seattle metro)
- Central Region (Chicago, Dallas, Atlanta metro)
- Each region has 2 AEs + 1 Regional Manager
- Sales Ops supports all regions (Salesforce, tools, reporting)

---

### Month 24 (50 people) - Mature Scale-Up

**Org Chart**:

```
CEO
├── Chief Product Officer (CTO promoted/retitled)
│   ├── VP Engineering (1.0 FTE)
│   │   ├── Backend Platform Team (6 engineers, 1 lead)
│   │   ├── Frontend/Mobile Team (5 engineers, 1 lead)
│   │   ├── Infrastructure Team (3 DevOps engineers, 1 lead)
│   │   ├── QA Team (3 QA engineers, 1 lead)
│   │   └── Integration/Data Team (3 engineers, 1 lead)
│   └── Product Team
│       ├── Product Manager - Core Platform (1.0 FTE)
│       ├── Product Manager - Partner Tools (1.0 FTE) - NEW
│       ├── UI/UX Designers (2) - 1 new hire
│       └── Data Scientist (1.0 FTE) - NEW (AI features)
├── Chief Revenue Officer (NEW, VP Sales promoted)
│   ├── VP Sales (1.0 FTE) - now reports to CRO
│   │   ├── East Region Manager + 3 AEs
│   │   ├── West Region Manager + 3 AEs
│   │   ├── Central Region Manager + 2 AEs
│   │   └── Sales Ops Manager (1.0 FTE)
│   └── VP Marketing (1.0 FTE) - now reports to CRO
│       ├── Content Team (2 writers)
│       ├── SEO Specialist (1.0 FTE)
│       ├── Digital Marketing Manager (1.0 FTE)
│       ├── Graphic Designer (1.0 FTE)
│       └── PR Manager (0.75 FTE)
├── VP Customer Success (1.0 FTE)
│   ├── Enterprise CSMs (4) - handle large partners
│   ├── Mid-Market CSMs (3) - handle smaller partners
│   ├── Support Team Lead (1.0 FTE) - NEW
│   │   └── Support Specialists (3) - 2 new hires
│   └── Implementation Manager (1.0 FTE) - NEW (partner onboarding)
├── VP Operations (1.0 FTE)
│   ├── CFO (1.0 FTE) - NEW, Controller promoted
│   ├── HR Manager (1.0 FTE)
│   ├── Compliance Manager (1.0 FTE) - Specialist promoted
│   ├── Legal Counsel (1.0 FTE) - now full-time
│   └── Data/Analytics Team (2 analysts)
├── Chief Medical Officer (1.0 FTE) - Medical Director promoted
│   ├── Clinical Operations Manager (1.0 FTE) - NEW
│   └── Genetic Counselors (6) - 2 new hires
```

**Total Headcount**: 50 people

**C-Level Executive Team** (Month 24):

- **CEO**: Strategy, fundraising, board, partnerships
- **Chief Product Officer**: Product vision, engineering, technical strategy
- **Chief Revenue Officer**: Sales + Marketing unified (common in SaaS)
- **VP Customer Success**: Retention, expansion, advocacy
- **VP Operations**: Finance, HR, Compliance, Legal, Data
- **Chief Medical Officer**: Clinical quality, genetic counseling, medical advisory board

**Why Chief Revenue Officer?**

- Sales and Marketing need tight alignment (common goal: revenue)
- CRO eliminates friction between sales and marketing
- CEO doesn't need to mediate sales/marketing conflicts
- Industry best practice for SaaS companies at $10M+ ARR

**Engineering Team Structure Maturity**:

- 5 specialized teams (Backend Platform, Frontend/Mobile, Infrastructure, QA, Integration/Data)
- Team Leads manage 3-6 engineers each (healthy span)
- VP Engineering focuses on cross-team coordination, hiring, architecture
- CPO focuses on product strategy, not daily engineering management

**Support Functions Maturity**:

- CFO role added (Controller promoted): Company is $14M ARR, needs CFO
- Compliance Manager: SOC 2, ISO 27001, state licenses, audits
- Full-time Legal Counsel: Contract volume justifies FTE

---

## Phase 3: Enterprise Structure (Month 25 - Month 36+)

### Month 36 (75 people) - Divisional Structure

**Org Chart** (High-Level):

```
CEO
├── Chief Product Officer
│   ├── VP Engineering (20 engineers across 6 teams)
│   └── VP Product (4 Product Managers, 3 Designers, 2 Data Scientists)
├── Chief Revenue Officer
│   ├── VP Sales (15 people: 3 Regional VPs, 10 AEs, 2 Ops)
│   └── VP Marketing (8 people: content, SEO, digital, PR, design, events)
├── VP Customer Success (12 people: 9 CSMs, 3 Support)
├── Chief Operating Officer (NEW ROLE - Operations + new functions)
│   ├── CFO (5 people: Controller, 2 analysts, AP/AR specialist, Ops Accountant)
│   ├── VP People (HR) (3 people: recruiter, HR ops, learning & development)
│   ├── VP Compliance (3 people: Compliance Manager, Security Engineer, Auditor)
│   ├── General Counsel (2 people: lawyer, paralegal)
│   └── VP Business Operations (3 people: data, analytics, BizOps)
├── Chief Medical Officer
│   ├── Clinical Operations Manager (2 people: ops + lab liaison)
│   └── Genetic Counseling Team (10 counselors, 1 lead counselor)
├── VP International (NEW ROLE) - 0.5 FTE initially
│   └── International team (TBD, starts Month 34+)
```

**Total Headcount**: 75 people

**Key Organizational Changes (Month 24 → Month 36)**:

1. **Chief Operating Officer Added**
   - **Why?** CEO needs to focus externally (fundraising, board, partnerships, M&A)
   - **COO Role**: Run company day-to-day (internal operations, finance, HR, compliance)
   - **COO Reports to CEO**, manages: CFO, VP People, VP Compliance, General Counsel, VP BizOps

2. **VP Product Separated from Engineering**
   - **Why?** Product management is strategic function (not just supporting engineering)
   - **VP Product Role**: Product strategy, roadmap, market research, pricing, positioning
   - **VP Engineering Role**: Engineering execution, technical excellence, platform scalability
   - Both report to CPO (maintains product-engineering alignment)

3. **Divisional Structure Emerges**
   - **Product Division** (CPO): Engineering + Product teams
   - **Go-to-Market Division** (CRO): Sales + Marketing teams
   - **Customer Division** (VP CS): Customer success + support
   - **Operations Division** (COO): Finance, HR, Compliance, Legal, Data
   - **Clinical Division** (CMO): Medical oversight, genetic counseling

4. **International Expansion Begins**
   - VP International (part-time Month 36, full-time Month 40+)
   - Reports to CEO (strategic priority)
   - Builds Canada team (Month 34-36), UK team (Month 36+)

---

## RACI Matrix (Month 24 - Mature Organization)

### Product Decisions

| Decision                 | CEO | CPO | VP Eng | VP Product | PM  |
| ------------------------ | --- | --- | ------ | ---------- | --- |
| **Product vision**       | A   | R   | C      | C          | I   |
| **Annual roadmap**       | C   | A   | C      | R          | C   |
| **Quarterly OKRs**       | I   | A   | R      | R          | C   |
| **Sprint priorities**    | I   | I   | C      | A          | R   |
| **Architecture choices** | I   | C   | A      | C          | I   |
| **New feature specs**    | I   | I   | C      | C          | R   |

### Sales/Marketing Decisions

| Decision                    | CEO | CRO | VP Sales | VP Marketing | AE  |
| --------------------------- | --- | --- | -------- | ------------ | --- |
| **Revenue targets**         | A   | R   | C        | C            | I   |
| **Pricing strategy**        | A   | R   | C        | C            | I   |
| **Sales comp plans**        | C   | A   | R        | I            | C   |
| **Marketing budget**        | C   | A   | C        | R            | I   |
| **Brand strategy**          | C   | A   | I        | R            | I   |
| **Enterprise deals >$500K** | A   | C   | R        | I            | R   |
| **Deal discounts >20%**     | C   | A   | R        | I            | C   |

### Hiring Decisions

| Decision                | CEO | Hiring Manager | VP People | Recruiter | Team |
| ----------------------- | --- | -------------- | --------- | --------- | ---- |
| **Headcount budget**    | A   | C              | R         | I         | I    |
| **Job descriptions**    | I   | A              | C         | R         | C    |
| **Candidate sourcing**  | I   | C              | C         | R         | I    |
| **Interview decisions** | I   | A              | C         | I         | R    |
| **Offer approval**      | C   | A              | R         | C         | I    |
| **Compensation bands**  | C   | C              | A         | R         | I    |

### Financial Decisions

| Decision                   | CEO | CFO | COO | Department Head | Board              |
| -------------------------- | --- | --- | --- | --------------- | ------------------ |
| **Annual budget**          | A   | R   | C   | C               | C                  |
| **Quarterly re-forecasts** | C   | A   | C   | C               | I                  |
| **Expenses >$50K**         | A   | R   | C   | I               | I                  |
| **Fundraising strategy**   | A   | C   | C   | I               | C                  |
| **Acquisitions**           | A   | C   | R   | I               | A (Board approval) |

---

## Organizational Transition Playbooks

### Transition 1: Flat → Functional (Month 6)

**Trigger**: Team size >15 people, CEO managing >10 directs

**Steps**:

1. **Week 1: Announce Change**
   - All-hands meeting: Explain why (span of control, scaling)
   - Introduce new leaders (VP Engineering, VP Sales, CMO)

2. **Week 2: Define Reporting Lines**
   - New leaders meet 1-on-1 with their teams
   - Clarify expectations, answer questions

3. **Week 3-4: Transition Period**
   - New leaders shadow CEO for 2 weeks (learn decision-making)
   - CEO gradually hands off day-to-day management

4. **Week 5+: New Normal**
   - Weekly leadership team meeting (CEO + 6 VPs)
   - Department leads have autonomy, CEO focuses on strategy

**Common Pitfalls**:

- ❌ CEO micromanages even after delegating (trust leaders)
- ❌ New leaders lack authority (CEO overrides decisions)
- ❌ Team confused about who to ask (clarify RACI)

---

### Transition 2: Functional → Divisional (Month 24-36)

**Trigger**: Team size >50 people, functional silos emerge

**Steps**:

1. **Month 24: COO Hired**
   - COO takes over internal operations from CEO
   - CEO focuses on external (fundraising, partnerships, board)

2. **Month 25-27: Divisional Consolidation**
   - CRO consolidates sales + marketing (unified GTM)
   - CPO consolidates product + engineering
   - COO consolidates finance + HR + compliance + legal

3. **Month 28-30: Process Standardization**
   - Cross-functional processes documented (new hire onboarding, budget approvals, etc.)
   - Weekly divisional leadership meetings (CPO team, CRO team, COO team)
   - Monthly company-wide all-hands

4. **Month 31-36: Enterprise Maturity**
   - Formal career paths defined (IC track, management track)
   - Performance review system (annual + quarterly check-ins)
   - Leadership development program (train future directors/VPs)

---

## Compensation Philosophy by Level

### Individual Contributors (ICs)

**Junior Engineer** (0-2 years exp):

- **Base**: $80K-100K
- **Equity**: 0.05%-0.1% (5-10 basis points)
- **Target Comp**: $80K-110K

**Mid-Level Engineer** (2-5 years exp):

- **Base**: $100K-140K
- **Equity**: 0.1%-0.25%
- **Target Comp**: $110K-160K

**Senior Engineer** (5-10 years exp):

- **Base**: $140K-180K
- **Equity**: 0.25%-0.5%
- **Target Comp**: $160K-210K

### Managers (Team Leads, First-Line Managers)

**Engineering Team Lead**:

- **Base**: $150K-180K
- **Equity**: 0.3%-0.6%
- **Target Comp**: $180K-220K

**Sales Manager**:

- **Base**: $120K
- **Variable**: $60K (50/50 split)
- **Equity**: 0.2%-0.4%
- **Target Comp**: $200K-240K

### Directors (Manage Managers)

**Director of Engineering**:

- **Base**: $180K-220K
- **Bonus**: 20% target
- **Equity**: 0.5%-1.0%
- **Target Comp**: $240K-300K

### Vice Presidents (Functional Leaders)

**VP Engineering, VP Sales, VP Marketing**:

- **Base**: $200K-250K
- **Bonus**: 30% target
- **Equity**: 1.0%-2.0%
- **Target Comp**: $300K-400K

### C-Level (Executive Team)

**CTO, CRO, CFO, CMO**:

- **Base**: $250K-350K
- **Bonus**: 50% target
- **Equity**: 2.0%-5.0%
- **Target Comp**: $450K-700K

**CEO**:

- **Base**: $200K-300K (founders often take lower cash)
- **Bonus**: 50-100% target
- **Equity**: 10%-25% (founder) or 3%-7% (hired CEO)
- **Target Comp**: $400K-900K

---

## Conclusion: Organization Design Enables Execution

**Key Principles**:

1. **Right structure for stage**: Flat (startup) → Functional (scale-up) → Divisional (enterprise)
2. **Healthy span of control**: 5-9 directs per manager (more = chaos, less = micromanagement)
3. **Clear decision rights**: RACI eliminates ambiguity (who decides what?)
4. **Transition intentionally**: Reorganize proactively (not reactively after crisis)
5. **Compensation scales with value**: Pay market rate + equity, retain top talent

**Next Document**: Feature #55B will define Fair Underwriting's **culture, values, and communication framework**.

---

**Document Status**: Complete
**Owner**: CEO + COO + VP People
**Review Frequency**: Quarterly (adjust org structure as company scales)
**Last Updated**: November 8, 2025
**Next Review**: February 2026 (after Month 3, pre-Month 6 hiring wave)
