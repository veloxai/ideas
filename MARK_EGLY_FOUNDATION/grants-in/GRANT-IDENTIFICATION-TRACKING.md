# Grant Identification & Tracking System

**Document Version**: 1.0
**Last Updated**: November 7, 2025
**Owner**: Chief Development Officer
**Purpose**: System for identifying, tracking, and managing grant opportunities

---

## 📋 Table of Contents

1. [System Overview](#system-overview)
2. [Grant Identification Strategy](#grant-identification-strategy)
3. [Grant Tracking Database](#grant-tracking-database)
4. [Workflow & Process](#workflow--process)
5. [Technology Tools](#technology-tools)
6. [Team Roles & Responsibilities](#team-roles--responsibilities)
7. [Metrics & Reporting](#metrics--reporting)

---

## System Overview

### Purpose

**Centralized system to**:

- Identify relevant grant opportunities (foundations, government, corporate)
- Track application status and deadlines
- Manage grant portfolio and pipeline
- Ensure nothing falls through cracks
- Maximize funding success

---

### Goals

**Year 1** (2026):

- Identify 50-100 potential grants
- Apply to 15-20 grants
- Win 5-7 grants ($200K-$300K total)

**Year 3** (2028):

- Identify 150-200 potential grants
- Apply to 30-40 grants
- Win 15-20 grants ($1M-$1.5M total)

**Year 5** (2030):

- Identify 200-300 potential grants
- Apply to 40-50 grants
- Win 20-30 grants ($2M-$3M total)

---

## Grant Identification Strategy

### Grant Categories

**1. Foundation Grants** (Primary Focus)

**Health Foundations**:

- **Robert Wood Johnson Foundation**: Health equity, chronic disease ($100K-$500K grants)
- **The Pfizer Foundation**: Rare disease, patient education ($50K-$200K)
- **Bristol Myers Squibb Foundation**: Disease awareness, health disparities ($100K-$300K)
- **GlaxoSmithKline Foundation**: Respiratory health, patient support ($50K-$250K)

**Disease-Specific Foundations**:

- **Lung foundations**: American Lung Association, CHEST Foundation ($25K-$100K)
- **Rare disease foundations**: National Organization for Rare Disorders (NORD), Global Genes ($10K-$50K)
- **Medical research foundations**: American Thoracic Society ($50K-$100K)

**Community Foundations** (Local/Regional):

- Community foundations in cities where we operate ($5K-$50K)
- Family foundations with health focus ($10K-$100K)

**Corporate Foundations**:

- **Grifols Foundation**: AAT-related programs (strategic partner)
- **CVS Health Foundation**: Patient access, health equity ($50K-$200K)
- **Walgreens**: Community health ($25K-$100K)

---

**2. Government Grants**

**Federal**:

- **NIH (National Institutes of Health)**: Research grants (R01, R21, R03) ($100K-$2M)
  - NHLBI (lung disease focus)
- **CDC**: Public health, disease surveillance ($50K-$500K)
- **HRSA**: Patient navigation, safety net programs ($100K-$1M)
- **DOD/VA**: Military/veteran health ($100K-$1M)

**State**:

- State health departments: Disease education, screening programs ($25K-$200K)
- State rare disease advisory councils ($10K-$50K)

**Local**:

- County health departments: Community screening ($5K-$25K)

---

**3. Corporate Giving**

**Pharmaceutical Companies**:

- Grifols, CSL Behring, Takeda: Patient assistance, education ($50K-$500K)
- Other respiratory companies: Boehringer Ingelheim, AstraZeneca ($25K-$100K)

**Diagnostic Companies**:

- Quest Diagnostics, LabCorp: Testing initiatives ($10K-$50K)

**Other**:

- Medical device companies: Oxygen concentrators, inhalers ($10K-$50K)

---

### Grant Research Methods

**1. Online Databases** (Subscription Services):

- **Foundation Directory Online** (Candid): Search 140,000+ foundations
- **GrantStation**: Curated grant opportunities for nonprofits
- **Grants.gov**: Federal grant opportunities
- **GrantWatch**: Real-time grant alerts

**Cost**: $1,500-$3,000/year total

---

**2. Professional Networks**:

- **AFP (Association of Fundraising Professionals)**: Networking, grant tips
- **GPA (Grant Professionals Association)**: Training, peer learning
- **Peers at other rare disease foundations**: Share grant leads

---

**3. Direct Outreach**:

- Contact program officers at foundations
- Build relationships with corporate giving managers
- Attend philanthropy conferences (e.g., Council on Foundations)

---

**4. Media Monitoring**:

- Google Alerts: "AATD grants," "rare disease funding," "respiratory health grants"
- Foundation news: RFPs (Requests for Proposals) announcements
- Federal Register: New government grant programs

---

### Grant Fit Criteria

**We apply ONLY if grant meets criteria**:

✅ **Mission Alignment**:

- Supports AATD awareness, research, patient support, or related goals
- Aligns with foundation's strategic priorities

✅ **Eligible Activities**:

- Grant funds the type of work we do (e.g., education, research, patient assistance)

✅ **Geographic Match**:

- We operate in funder's geographic area (or funder has national scope)

✅ **Funding Level**:

- Grant size worth the effort (typically $10K minimum)
- Matches our capacity (can we execute a $1M project?)

✅ **Requirements Feasible**:

- Reporting requirements manageable
- Matching funds available (if required)
- Timeline realistic

✅ **Competitive But Winnable**:

- We have a strong case (unique value proposition)
- Not too competitive (100+ applicants for $10K = low ROI)

**Filter**: Only pursue grants with >20% estimated win probability

---

## Grant Tracking Database

### Database Structure

**Platform**: Salesforce Nonprofit Success Pack (NPSP) OR Airtable (budget-friendly)

**Database Fields**:

**1. Grant Opportunity Info**:

- Grant name
- Funder name and type (foundation, government, corporate)
- Funding amount (range)
- Application deadline
- Award notification date
- Project start date
- Grant duration (1 year, 2 years, etc.)
- Geographic restrictions
- Eligibility criteria

**2. Grant Details**:

- Program focus area (research, education, patient support, advocacy)
- Allowed expenses (personnel, equipment, indirect costs)
- Matching requirements (e.g., 1:1 match)
- Reporting requirements (quarterly, annual)
- Website and contact info (program officer)

**3. Tracking Fields**:

- Status: Identified → Researching → In Development → Submitted → Under Review → Awarded/Declined
- Owner (staff member responsible)
- Priority (High, Medium, Low)
- Probability of winning (%)
- Internal deadline (2 weeks before submission deadline)
- Submission date
- Award decision date
- Award amount (if won)

**4. Application Materials**:

- LOI (Letter of Intent) required? Due date?
- Full proposal required? Due date?
- Budget required? Template?
- Attachments (501c3, financials, board list, etc.)
- Links to stored drafts (Google Drive, Dropbox)

**5. Post-Award**:

- Grant agreement signed
- Award amount received
- Project start/end dates
- Reporting schedule (dates of required reports)
- Grant closeout date

---

### Database Views

**1. Pipeline View** (All Opportunities):

- Sort by deadline (next deadlines first)
- Filter by status (e.g., "In Development" = actively working on)
- Color-coded by priority (red = high, yellow = medium, green = low)

**2. Calendar View**:

- Deadlines displayed on calendar
- Internal deadlines (2 weeks before) shown
- Reporting deadlines (for active grants) shown

**3. Active Grants View** (Awarded):

- Grants we've won and are managing
- Sort by reporting deadline
- Filter by program area

**4. Analytics Dashboard**:

- Total grants identified this year
- Total applications submitted
- Win rate (% of applications that won)
- Total funding secured
- Funding by source (foundation, government, corporate)
- Funding by program area (research, education, etc.)

---

## Workflow & Process

### Step 1: Identify Opportunities (Ongoing)

**Who**: Development Associate (20 hours/week on grant research)

**How**:

- Search grant databases weekly (Foundation Directory, GrantStation, Grants.gov)
- Scan email alerts daily (GrantWatch, Google Alerts)
- Review foundation websites quarterly (top 50 target funders)
- Attend philanthropy webinars monthly

**Output**: Add 5-10 new grant opportunities to database per week

---

### Step 2: Evaluate & Prioritize (Weekly)

**Who**: Chief Development Officer + Development Associate

**Meeting**: Weekly 30-minute grant pipeline review

**Process**:

1. Review new opportunities added to database
2. Apply fit criteria (mission, eligibility, feasibility)
3. Assign priority (High, Medium, Low)
4. Assign owner (who will write proposal?)
5. Determine which to pursue (High priority + resources available)

**Decision Rule**:

- High Priority + Resources Available → Pursue (move to "In Development")
- High Priority + No Resources → Waitlist (revisit later)
- Medium/Low Priority → Archive (unless perfect fit)

**Output**: 2-5 grants moved to "In Development" per week

---

### Step 3: Develop Application (2-6 weeks before deadline)

**Who**: Grant writer (staff or consultant) + Program staff (SMEs)

**Process**:

1. **Research funder** (review past grants, priorities, program officer)
2. **Develop concept** (how our project fits funder's goals)
3. **Draft proposal sections**:
   - Executive summary / Cover letter
   - Organizational background
   - Problem statement / Need
   - Project description (goals, activities, timeline)
   - Evaluation plan (outcomes and metrics)
   - Budget and budget narrative
   - Sustainability plan
4. **Gather attachments** (501c3, financials, board list, letters of support)
5. **Review & revise** (CDO, Executive Director, Board member review)
6. **Finalize** (proofread, format, compliance check)

**Timeline**:

- Small grants (<$25K): 1-2 weeks
- Medium grants ($25-100K): 2-4 weeks
- Large grants (>$100K): 4-8 weeks

**Internal Deadline**: Submit 2 days before funder's deadline (buffer for tech issues)

---

### Step 4: Submit Application (By Deadline)

**Who**: Development Associate

**Process**:

1. Upload all documents to funder's portal (or email, mail)
2. Confirm submission received (confirmation email, receipt)
3. Update database (status = "Submitted," submission date)
4. Calendar follow-up (1 week post-deadline: confirm receipt, 1 month: check status)

---

### Step 5: Follow-Up (Post-Submission)

**Who**: Chief Development Officer

**Timeline**:

- 1 week after submission: Email program officer (confirm receipt, answer questions)
- 1 month after submission: Check decision timeline
- Award notification date: Receive decision

**If awarded**: Move to Step 6
**If declined**: Request feedback, update database (lessons learned), archive

---

### Step 6: Grant Management (If Awarded)

**Who**: Program staff (execute project) + Development Associate (reporting)

**Process**:

1. **Sign grant agreement** (review terms, sign, return)
2. **Set up project** (hire staff, launch activities, track expenses)
3. **Track progress** (maintain project files, document outcomes)
4. **Submit reports** (interim and final reports per grant agreement)
5. **Stewardship** (thank funder, share impact stories, invite to events)
6. **Closeout** (final report, final invoice, archive files)

**Update database**: Mark milestones (reports submitted, payments received, closeout complete)

---

## Technology Tools

### Recommended Tech Stack

**Option 1: Budget-Friendly** (Year 1-2, <$1,000/year):

- **Airtable** ($20/month): Grant tracking database
- **Google Workspace** ($6/user/month): Document storage, collaboration
- **Foundation Directory Online** ($130/month): Grant research
- **GrantWatch** ($40/month): Grant alerts
- **Calendly** (Free): Schedule meetings with program officers

**Total**: ~$250/month = $3,000/year

---

**Option 2: Professional** (Year 3+, <$10,000/year):

- **Salesforce NPSP** ($3,600/year for 10 users): CRM + grant tracking
- **Google Workspace** ($72/year per user): Document storage
- **Foundation Directory Online** ($1,500/year): Grant research
- **GrantStation** ($1,000/year): Grant opportunities
- **Submittable** ($3,000/year): Grant application portal (for Grants OUT program)

**Total**: ~$9,000/year

---

### Software Features Needed

**Must-Have**:

- Database with custom fields (grant details, tracking)
- Calendar integration (deadlines, reminders)
- Document storage (proposals, attachments)
- Reporting (dashboard, analytics)
- Email integration (correspondence with funders)

**Nice-to-Have**:

- Automated reminders (deadline approaching, report due)
- Workflow automation (status updates trigger emails)
- Mobile access (check database from anywhere)
- Integrations (QuickBooks for budget tracking, Mailchimp for funder updates)

---

## Team Roles & Responsibilities

### Staff Roles

**Chief Development Officer (CDO)** (Part-time Year 1, Full-time Year 2+):

- Oversee grant strategy and pipeline
- Build relationships with program officers
- Review and approve all proposals
- Manage large/complex grant applications
- Time allocation: 50% of role

**Development Associate / Grant Writer** (Full-time Year 1+):

- Research and identify grant opportunities
- Write and submit grant proposals
- Maintain grant tracking database
- Submit progress reports for active grants
- Time allocation: 80% of role (other 20% = donor relations)

**Executive Director**:

- Sign grant applications and agreements
- Review large grant proposals (>$100K)
- Represent foundation in funder meetings
- Time allocation: 10% of role

**Program Staff** (as needed):

- Provide content expertise (research, education, patient programs)
- Review proposal drafts for accuracy
- Execute grant-funded projects
- Provide data for reports

---

### External Support

**Grant Writing Consultant** (as needed, Year 1-2):

- Write proposals for large/complex grants (when internal capacity limited)
- Train staff on grant writing best practices
- Cost: $75-$150/hour or $3,000-$10,000 per proposal

**Grant Research Service** (optional):

- Conduct customized grant research (identify best-fit funders)
- Cost: $500-$2,000/month

---

### Board Role

**Board Development Committee**:

- Review grant strategy quarterly
- Approve applications >$250K (board vote)
- Leverage board connections (introductions to funders)
- Sign letters of support (board chair)

---

## Metrics & Reporting

### Key Metrics

**Input Metrics** (Activity):

- Number of grant opportunities identified (per month)
- Number of grant applications submitted (per quarter)
- Number of LOIs submitted (per quarter)

**Output Metrics** (Results):

- Number of grants awarded (per year)
- Total funding secured (per year)
- Win rate (% of applications funded)
- Average grant size

**Efficiency Metrics**:

- Cost per application (staff time + expenses)
- ROI (funding secured / cost to apply)

**Portfolio Metrics**:

- Funding by source (foundation, government, corporate)
- Funding by program area (research, education, patient support, operations)
- Concentration risk (% from top 3 funders)

---

### Monthly Grant Report

**To**: Executive Director, Board Development Committee

**Contents**:

- Pipeline summary (# grants in each stage)
- Applications submitted this month
- Decisions received (awarded, declined)
- Funding secured this month
- Upcoming deadlines (next 30 days)
- Reporting due (active grants)

---

### Quarterly Grant Dashboard

**Metrics**:

- YTD funding secured vs. goal
- Win rate (current quarter and YTD)
- Applications submitted by program area
- Active grants (list, status, next milestones)
- Pipeline forecast (expected funding next quarter)

---

### Annual Grant Report

**Comprehensive analysis**:

- Total funding secured (vs. goal)
- Funding by source (pie chart)
- Funding by program area (bar chart)
- Win rate by funder type (foundation, government, corporate)
- Lessons learned (what worked, what didn't)
- Strategy for next year (adjustments, priorities)

**Presented to**: Board of Directors (Q4 board meeting)

---

## Year 1 Targets

### Funding Goal: $200,000-$300,000

**Grant Portfolio**:

- 5-7 foundation grants ($10K-$50K each)
- 1-2 government grants ($50K-$100K each)
- 1-2 corporate grants ($10K-$25K each)

---

### Target Funders (Year 1)

**Foundation Grants** (Priority):

1. Robert Wood Johnson Foundation - Health Equity ($100K)
2. The Pfizer Foundation - Rare Disease ($50K)
3. American Lung Association - Research ($25K)
4. CHEST Foundation - Education ($25K)
5. Local community foundation ($10K)

**Government Grants**:

1. NIH R03 (Small Research Grant) ($100K, 2-year)
2. State health department (Rare disease education) ($50K)

**Corporate Grants**:

1. Grifols Foundation ($25K)
2. CVS Health Foundation ($15K)

**Total Potential**: $400K (not all will be won, targeting $200-300K actual)

---

## Summary

**A robust grant identification and tracking system is essential**:

- ✅ Identifies opportunities we'd otherwise miss
- ✅ Keeps team organized and on deadline
- ✅ Maximizes funding secured (higher win rate)
- ✅ Demonstrates accountability (board, funders)

**Year 1 Setup** (Investment):

- Technology: $3,000
- Staff time: 0.5 FTE (Development Associate) + 0.25 FTE (CDO)
- Training: $2,000 (grant writing course, database training)
- **Total: ~$50K (staff) + $5K (tech/training) = $55K**

**Year 1 Return**: $200-300K funding secured = **4-5x ROI**

**Year 5 Projection**: $2-3M/year secured with mature system

**This system is the foundation of sustainable funding.**

---

**Questions?**

**Mark Egly Foundation**
📧 Email: development@markeglyfoundation.org
🌐 Website: MarkEglyFoundation.org

---

**Approved by**: Chief Development Officer & Board Development Committee
**Effective Date**: January 1, 2026
**Review Date**: Quarterly
**Version**: 1.0

---

_"Organized. Strategic. Funded."_

**— Mark Egly Foundation**
