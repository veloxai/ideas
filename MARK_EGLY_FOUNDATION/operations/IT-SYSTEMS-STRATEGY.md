# IT Systems Strategy & Technology Roadmap

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Operating Officer & IT Committee
**Purpose**: Comprehensive technology infrastructure plan for Mark Egly Foundation—selecting, implementing, and managing IT systems from startup through Year 5 scale

---

## 📋 Table of Contents

1. [Technology Philosophy](#technology-philosophy)
2. [Core Systems Architecture](#core-systems-architecture)
3. [Year 1 Technology Stack](#year-1-technology-stack)
4. [System-by-System Implementation](#system-by-system-implementation)
5. [Integration Strategy](#integration-strategy)
6. [Data Architecture](#data-architecture)
7. [Security & Access Controls](#security--access-controls)
8. [Vendor Selection Criteria](#vendor-selection-criteria)
9. [5-Year Technology Roadmap](#5-year-technology-roadmap)
10. [Budget & Cost Management](#budget--cost-management)

---

## Technology Philosophy

### Guiding Principles

**1. Mission-First Technology**

- Every system must directly support patient services, research, or fundraising
- No technology for technology's sake—pragmatic over perfect
- Measure ROI: time saved, patients served, revenue generated

**2. Nonprofit-Appropriate Solutions**

- Leverage free/discounted nonprofit software (Google for Nonprofits, Salesforce Nonprofit Cloud, Microsoft 365 Nonprofit)
- Avoid over-engineering—start simple, scale complexity as needed
- Open-source preferred when expertise available (WordPress, REDCap)

**3. Security & Compliance First**

- HIPAA-compliant infrastructure (patient data = PHI)
- SOC 2-certified vendors preferred (Salesforce, Google Workspace, AWS)
- Encryption at rest and in transit—non-negotiable

**4. Cloud-First, Mobile-Friendly**

- SaaS over on-premise (no servers to maintain, automatic updates, lower TCO)
- Mobile-responsive for staff and patients (50% of traffic is mobile)
- Remote work enabled (staff may work from home, virtual support groups)

**5. Staff Empowerment**

- Low-code/no-code where possible (staff can build workflows, not wait for IT)
- Comprehensive training (onboarding + ongoing)
- User-friendly interfaces (if staff hate it, they won't use it)

---

## Core Systems Architecture

### Technology Ecosystem Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      EXTERNAL USERS                              │
│  Patients · Donors · Researchers · Volunteers · Partners         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      PUBLIC-FACING LAYER                         │
│  • Website (WordPress)                                           │
│  • Patient Portal (Custom or WordPress + Plugins)                │
│  • Donation Pages (Donorbox or Salesforce Nonprofit Cloud)      │
│  • Registry Enrollment (REDCap Public Survey)                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    OPERATIONAL SYSTEMS                           │
│  • CRM: Salesforce Nonprofit Cloud (donors, patients, events)   │
│  • Email Marketing: Mailchimp (newsletters, campaigns)           │
│  • Financial: QuickBooks Nonprofit (accounting, invoicing)       │
│  • Registry: REDCap (patient data, research database)            │
│  • Biobank: Freezerworks (sample tracking)                       │
│  • HR: BambooHR or Gusto (payroll, benefits, onboarding)        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                  COLLABORATION & PRODUCTIVITY                    │
│  • Email & Calendar: Google Workspace (Gmail, Calendar, Meet)   │
│  • File Storage: Google Drive (shared folders, HIPAA BAA)       │
│  • Project Management: Asana or Monday.com                       │
│  • Internal Comms: Slack (team chat, integrations)              │
│  • Documentation: Google Docs + Notion (SOPs, knowledge base)   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INFRASTRUCTURE & SECURITY                     │
│  • Hosting: AWS or Google Cloud (HIPAA-compliant)               │
│  • Security: 1Password (password manager), Duo (2FA)            │
│  • Backup: Backblaze or AWS S3 (automated daily)                │
│  • Monitoring: Datadog or Sentry (uptime, errors, performance)  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Year 1 Technology Stack

### Priority Systems (Launch Requirements)

**1. Email & Productivity Suite** ($0-$100/month)

- **Solution**: Google Workspace for Nonprofits
- **Cost**: FREE for first 30 users (normally $6/user/month)
- **Includes**: Gmail (markeglyfoundation.org emails), Google Drive (unlimited storage), Calendar, Meet (video calls), Docs/Sheets
- **Setup**: 2 weeks (domain verification, user accounts, HIPAA BAA signing)
- **Decision**: Google > Microsoft because easier for non-technical users, better mobile apps

**2. Website & CMS** ($100-$300/month)

- **Solution**: WordPress (self-hosted on WP Engine or Kinsta)
- **Cost**: $30/month hosting + $100/year domain + $200 one-time theme
- **Features**: Blog, patient education library, donation integration, event calendar, volunteer signup
- **Setup**: 6-8 weeks (design, content migration, SEO, accessibility)
- **Decision**: WordPress > Squarespace because flexibility, plugins, developer community

**3. CRM & Donor Management** ($0-$500/month)

- **Solution**: Salesforce Nonprofit Cloud (Nonprofit Success Pack - NPSP)
- **Cost**: FREE for 10 users (Power of Us Program), then $36/user/month
- **Manages**: Donors (contact info, giving history, communications), Patients (non-PHI only—demographics, participation), Events (registration, attendance), Volunteers (hours, roles)
- **Setup**: 3 months (data model, workflows, reports, training—complex but worth it)
- **Decision**: Salesforce > HubSpot because nonprofit-specific features, app ecosystem, long-term scalability

**4. Email Marketing** ($50-$200/month)

- **Solution**: Mailchimp (nonprofit discount available)
- **Cost**: $50/month for 2,500 contacts (scales to $200/month for 10,000)
- **Features**: Newsletter builder, automation (welcome series, event reminders), segmentation, A/B testing, analytics
- **Setup**: 2 weeks (import contacts, design templates, GDPR compliance)
- **Decision**: Mailchimp > Constant Contact because better UX, integrations, reporting

**5. Accounting & Financial Management** ($50-$100/month)

- **Solution**: QuickBooks Online Nonprofit Edition
- **Cost**: $50/month (nonprofit discount ~30% off standard)
- **Features**: Fund accounting, grant tracking, donor receipts, budget vs. actual, Form 990 prep support
- **Setup**: 1 month (chart of accounts, bank feeds, CPA integration)
- **Decision**: QuickBooks > Xero because accountant familiarity, nonprofit features, payroll integration

**6. Patient Registry & Research Database** ($500-$2,000/year)

- **Solution**: REDCap (Research Electronic Data Capture)
- **Cost**: FREE (hosted by partner university—common arrangement), or $500-$2K/year for commercial hosting (Critical Path Institute, Vanderbilt)
- **Features**: HIPAA-compliant surveys, longitudinal data collection, data quality rules, audit trails, API for integrations
- **Setup**: 3-4 months (IRB approval, database design, testing, patient enrollment)
- **Decision**: REDCap > Qualtrics because research-specific, free, academic credibility

**7. Password Management & Security** ($100-$300/year)

- **Solution**: 1Password for Teams
- **Cost**: $8/user/month = $96/year for 10 users Year 1
- **Features**: Shared vaults (for team passwords—Salesforce, QuickBooks), secure notes (bank info, API keys), audit logs, 2FA enforcement
- **Setup**: 1 day (everyone installs, migrates passwords)
- **Decision**: 1Password > LastPass because better security track record, family sharing

**8. Project Management** ($0-$200/month)

- **Solution**: Asana (nonprofit discount or free tier)
- **Cost**: FREE for up to 15 users, then $10/user/month
- **Features**: Task tracking, project timelines, team workload, integrations (Slack, Google Drive, Salesforce)
- **Setup**: 1 week (projects created, team training)
- **Decision**: Asana > Trello because better for complex workflows, reporting

**Year 1 Total Technology Budget**: $3,000-$8,000 (setup) + $2,400-$4,800/year (ongoing)

---

## System-by-System Implementation

### 1. Website (WordPress)

**Implementation Timeline**: Weeks 1-8

**Phase 1: Planning (Weeks 1-2)**

- Define sitemap (homepage, about, programs, research, donate, blog, contact)
- Content audit (what exists, what needs creating)
- Competitor research (AlphaNet, Alpha-1 Foundation, CF Foundation—steal best ideas)
- Accessibility requirements (WCAG 2.1 AA compliance—screen readers, keyboard navigation)

**Phase 2: Development (Weeks 3-6)**

- Choose hosting (WP Engine $30/month or Kinsta $35/month—managed WordPress, automatic backups, security)
- Install WordPress + premium theme (Divi $89/year or GeneratePress $59/year—flexible, fast, accessible)
- Essential plugins:
  - Yoast SEO (search engine optimization)
  - WPForms (contact forms, volunteer signup)
  - MonsterInsights (Google Analytics integration)
  - UpdraftPlus (backups to Google Drive)
  - Wordfence (security firewall, malware scan)
- Page creation (10-15 core pages, mobile-responsive)

**Phase 3: Content & Launch (Weeks 7-8)**

- Write and publish content (SEO-optimized, patient-friendly language)
- Donation integration (Donorbox embedded forms or Salesforce Nonprofit Cloud donation pages)
- SSL certificate (HTTPS encryption—included with hosting)
- Launch (soft launch to Board, then public announcement)

**Ongoing Maintenance**: $50/month (hosting + plugins + security updates—staff does, or hire freelancer $500/month for 5 hours)

---

### 2. CRM (Salesforce Nonprofit Cloud)

**Implementation Timeline**: Weeks 2-14

**Phase 1: Foundation Setup (Weeks 2-4)**

- Apply for Salesforce Power of Us Program (free 10 licenses—2-3 week approval)
- Install Nonprofit Success Pack (NPSP—Salesforce's nonprofit data model)
- Data model design:
  - **Accounts**: Organizations (hospitals, pharmaceutical companies, foundations)
  - **Contacts**: Individuals (patients, donors, volunteers, physicians)
  - **Opportunities**: Donations (one-time, recurring, pledges)
  - **Campaigns**: Fundraising campaigns, events, programs
  - **Custom Objects**: Patient Programs (support group attendance, navigator sessions), Research Participation (registry enrollment, biobank consent)

**Phase 2: Customization (Weeks 5-10)**

- Build custom fields (genotype, FEV1, augmentation therapy status—non-PHI demographics only, detailed clinical = REDCap)
- Workflows & automation:
  - New donor → send thank you email (automated)
  - Patient enrolls in support group → assign to facilitator, add to Mailchimp list
  - Event registration → confirmation email, reminders 7 days and 1 day before
- Reports & dashboards:
  - Fundraising Dashboard (MTD/YTD revenue, donor retention, average gift size)
  - Patient Services Dashboard (active patients, program participation, navigation requests)
  - Executive Dashboard (Board-facing—revenue, patients served, research participants)

**Phase 3: Data Migration & Training (Weeks 11-14)**

- Import existing data (Excel → CSV → Salesforce Data Loader—contacts, giving history)
- User training (3 sessions: Admin, Fundraising Staff, Program Staff—2 hours each)
- Documentation (SOPs for common tasks—"How to Add a Donor," "How to Track Support Group Attendance")
- Go-live (cutover from old system—spreadsheets or legacy donor database)

**Ongoing Admin**: 5-10 hours/week (COO or Operations Manager—maintain data quality, build new reports, troubleshoot)

---

### 3. Email Marketing (Mailchimp)

**Implementation Timeline**: Weeks 3-5

**Setup Checklist**:

- [ ] Create account (nonprofit discount application—25% off)
- [ ] Domain authentication (SPF/DKIM records—prevents spam filtering)
- [ ] Import contacts from Salesforce (sync integration—Mailchimp ↔ Salesforce)
- [ ] Create audience segments:
  - **Patients** (receive patient-focused content—research updates, support group invitations)
  - **Donors** (fundraising appeals, impact stories, annual reports)
  - **Volunteers** (volunteer opportunities, thank you messages)
  - **Researchers** (registry updates, collaboration opportunities)
- [ ] Design email templates (branded—logo, colors, footer with social links + unsubscribe)
- [ ] Build automation workflows:
  - **New Patient Welcome Series** (Day 0: Welcome + resources, Day 3: Support group info, Day 7: Navigator introduction)
  - **New Donor Thank You** (Immediate: Receipt + gratitude, Day 30: Impact report, Day 365: Renewal ask)
  - **Event Reminders** (7 days before, 1 day before, day-of with Zoom link)

**Content Calendar** (Year 1):

- Monthly patient newsletter (research updates, patient stories, upcoming events—4th Tuesday each month)
- Quarterly donor newsletter (fundraising progress, financials, Board updates—15th of Jan/Apr/Jul/Oct)
- Ad-hoc campaigns (Rare Disease Day Feb 28, Giving Tuesday Nov, Year-End Dec)

**Compliance**:

- ✅ GDPR-compliant (double opt-in for European contacts, easy unsubscribe)
- ✅ CAN-SPAM Act compliant (physical address in footer, honor unsubscribes within 10 days)
- ✅ HIPAA considerations (no PHI in emails—clinical data stays in REDCap)

---

### 4. Accounting (QuickBooks Online Nonprofit)

**Implementation Timeline**: Weeks 2-6

**Phase 1: Setup (Weeks 2-3)**

- Create account (nonprofit discount—contact Intuit or use TechSoup)
- Chart of accounts (fund accounting structure):
  - **Assets**: Cash (checking, savings, money market), Accounts Receivable (pledges), Investments (if applicable)
  - **Liabilities**: Accounts Payable (unpaid invoices), Credit Cards, Deferred Revenue (multi-year pledges)
  - **Net Assets**: Unrestricted (general operating), Temporarily Restricted (grants with timelines), Permanently Restricted (endowment)
  - **Revenue**: Individual Donations, Corporate Donations, Foundation Grants, Event Revenue (gala, golf, 5K), Program Service Revenue (registry licensing)
  - **Expenses**: Program Services (patient support, research, education), Fundraising (events, development staff), Administration (ED, accounting, IT, office)
- Bank account connections (automatic transaction import—checking, savings, credit cards)

**Phase 2: Processes (Weeks 4-5)**

- Invoicing templates (for registry licensing, consulting—professional branded invoice)
- Expense tracking (staff submit receipts → manager approves → bookkeeper enters → reimburse)
- Grant tracking (classes or projects for each grant—track spending against budget, generate reports for funders)
- Recurring transactions (monthly donations, software subscriptions—automate entry)

**Phase 3: Reporting (Week 6)**

- Financial statements templates:
  - **Statement of Financial Position** (Balance Sheet—assets, liabilities, net assets)
  - **Statement of Activities** (Income Statement—revenue, expenses, change in net assets by category)
  - **Statement of Cash Flows** (cash in/out by operating, investing, financing activities)
  - **Statement of Functional Expenses** (expenses by program/fundraising/admin AND by type—salaries, travel, IT, etc.)
- Budget vs. actual reports (monthly—COO reviews, quarterly—Board reviews)
- Donor receipt automation (thank you letter + tax receipt after each gift)

**CPA Partnership**: Hire CPA ($3K-$5K/year) for:

- Quarterly reviews (catch errors, reconcile accounts)
- Form 990 preparation (annual tax filing—due 4.5 months after year-end)
- Audit support (if required by grantors—year 3+ when revenue >$750K)

---

### 5. Patient Registry (REDCap)

**Implementation Timeline**: Months 3-6 (parallel with IRB approval)

**Phase 1: Database Design (Month 3)**

- Data dictionary creation (every field defined—variable name, type [text, number, date, multiple choice], validation rules)
- **Core Data Elements**:
  - **Demographics**: Date of birth (year only—de-identified), sex, race/ethnicity, state, ZIP code (3 digits only)
  - **Genotype**: AAT genotype (Pi*ZZ, Pi*SZ, Pi\*MZ, etc.), genetic testing date, testing lab
  - **Lung Function**: FEV1 (liters), FEV1 % predicted, FVC, FEV1/FVC ratio, testing date
  - **Augmentation Therapy**: Currently receiving? (Y/N), start date, frequency (weekly), brand (Prolastin, Glassia, Zemaira, Aralast)
  - **Exacerbations**: Count in past 12 months, hospitalization (Y/N), antibiotics (Y/N), steroids (Y/N)
  - **Liver**: Liver disease (Y/N), cirrhosis (Y/N), transaminases (AST, ALT), imaging findings
  - **Quality of Life**: SGRQ score (St. George's Respiratory Questionnaire), symptom severity (1-10 scale), limitations (work, exercise, ADLs)
  - **Longitudinal**: Annual follow-up surveys (automated—REDCap sends email reminder on anniversary)
- Form logic (skip patterns—"If liver disease = No, skip liver questions")
- Calculated fields (FEV1 % predicted = FEV1 / expected FEV1 based on age/sex/height)

**Phase 2: IRB Approval (Month 4)**

- Submit to Ethics Committee (Foundation's IRB or partner university IRB)
- Informed consent form (patients understand data use, risks, benefits, withdrawal rights)
- HIPAA authorization (patients consent to data sharing with researchers—de-identified)
- Approval timeline: 4-6 weeks (expedited review—minimal risk study)

**Phase 3: Build & Test (Month 5)**

- REDCap database build (enter data dictionary, design forms, test logic)
- User acceptance testing (Research Coordinator enrolls 5 test patients—catch bugs, refine UX)
- Public survey creation (patient-facing enrollment form—hosted at redcap.markeglyfoundation.org/enroll)
- API setup (Salesforce ↔ REDCap integration—new patient in Salesforce → create record in REDCap)

**Phase 4: Launch & Recruitment (Month 6)**

- Soft launch (recruit 20 patients from support groups—friendly users, provide feedback)
- Refine process (fix confusing questions, streamline flow)
- Full launch (promote via website, patient newsletter, support group announcements)
- Target: 100 patients enrolled by end of Month 6, 500 by end of Year 1

**Data Quality Controls**:

- Required fields (can't submit form if key fields blank)
- Range checks (FEV1 can't be negative or >10 liters—flag outliers for review)
- Duplicate detection (same patient enrolling twice—check email, date of birth)
- Audit trail (every data change logged—who, what, when—HIPAA requirement)

---

### 6. Collaboration Tools

**Slack** ($0-$150/month)

- Free tier (10K message history, 10 integrations) adequate for Year 1
- Channels: #general, #fundraising, #programs, #research, #finance, #random
- Integrations: Salesforce (alerts for large donations), Asana (task updates), Google Calendar (meeting reminders)
- Upgrade to Pro ($8/user/month) when message history becomes limiting (Year 2+)

**Asana** ($0-$200/month)

- Free tier for up to 15 users (adequate Year 1-2)
- Projects:
  - **Gala Planning** (timeline from 6 months out → event day—tasks, owners, deadlines)
  - **Patient Conference** (speaker outreach, venue, marketing, registration)
  - **Research Grants** (application deadlines, review cycles, award notifications)
  - **Website Redesign** (if Year 2—page-by-page checklist)
- Templates for recurring work (new hire onboarding, grant application, event planning)

**Google Drive Organization**:

```
/Mark Egly Foundation
  /Board
    /Minutes (2025, 2026, 2027...)
    /Financials (monthly reports, annual audits)
    /Policies (bylaws, conflict of interest, whistleblower)
  /Finance
    /Budgets
    /Invoices
    /Grants (folder per grant—application, award letter, reports)
  /Programs
    /Support Groups (facilitator guides, attendance, feedback)
    /Patient Navigation (case notes—HIPAA-compliant folder with access controls)
    /Education (articles, videos, webinar recordings)
  /Research
    /Registry (data dictionary, IRB applications, consents—NOT patient data, that's in REDCap)
    /Grants Awarded (applications, progress reports)
  /Fundraising
    /Events (gala, golf, 5K—budgets, sponsorships, attendee lists)
    /Donor Stewardship (thank you templates, impact reports)
  /HR
    /Personnel Files (by employee—offer letters, reviews, I-9 forms—access restricted to ED + HR)
    /Policies (employee handbook, PTO, expenses)
  /Marketing
    /Brand Assets (logo files, style guide, photos)
    /Content Calendar (blog posts, social media, newsletter topics)
```

---

## Integration Strategy

### Key Integrations (Reduce Manual Data Entry)

**Salesforce ↔ Mailchimp**

- **What syncs**: Contacts (with segment tags—"Patient," "Donor," "Volunteer")
- **Frequency**: Real-time (new contact in Salesforce → instantly added to Mailchimp)
- **Setup**: Native integration via Mailchimp's Salesforce app (AppExchange)
- **Benefit**: No manual CSV exports, segmentation done in Salesforce

**Salesforce ↔ QuickBooks**

- **What syncs**: Donations (Opportunity closed won → Invoice in QuickBooks)
- **Frequency**: Daily batch (overnight)
- **Setup**: Third-party connector (DBSync $25/month or Zapier $30/month)
- **Benefit**: Finance team doesn't re-enter every donation

**Salesforce ↔ Donorbox (or donation processor)**

- **What syncs**: Online donations → automatically create Opportunity in Salesforce
- **Frequency**: Real-time (instant donor acknowledgment)
- **Setup**: Donorbox native integration or Zapier
- **Benefit**: Donor receipts sent immediately, no lag

**REDCap ↔ Salesforce** (Custom, Year 2+)

- **What syncs**: Patient demographics (non-PHI only—name, email, genotype, state)
- **Frequency**: Daily
- **Setup**: REDCap API + Salesforce API (developer builds—4-6 weeks, $5K-$10K)
- **Benefit**: Single source of truth for patient contact info, program participation tracked in Salesforce

**Google Calendar ↔ Salesforce**

- **What syncs**: Events created in Salesforce appear on Google Calendar
- **Frequency**: Real-time
- **Setup**: Native Salesforce integration
- **Benefit**: Staff sees all meetings/events in one calendar

---

## Data Architecture

### Data Flow & Ownership

| **Data Type**          | **Source of Truth** | **Synced To**                 | **Why**                                                    |
| ---------------------- | ------------------- | ----------------------------- | ---------------------------------------------------------- |
| **Donor contact info** | Salesforce          | Mailchimp, QuickBooks         | CRM = single source for relationships                      |
| **Donation amounts**   | QuickBooks          | Salesforce (via sync)         | Finance system = authoritative for money                   |
| **Patient PHI**        | REDCap              | NOWHERE (isolated)            | HIPAA—clinical data stays in HIPAA-compliant system        |
| **Patient non-PHI**    | Salesforce          | REDCap (one-way initial sync) | CRM tracks program participation, registry tracks clinical |
| **Email engagement**   | Mailchimp           | Salesforce (open/click data)  | Understand donor engagement for cultivation                |
| **Financial reports**  | QuickBooks          | Google Drive (PDFs)           | Board reviews financials, stored centrally                 |

### Data Backup Strategy

**Daily Automated Backups**:

- **Salesforce**: Native backup (Salesforce retains 90 days), plus weekly export via OwnBackup ($50/month—insurance against accidental deletion)
- **REDCap**: Daily database dump to encrypted AWS S3 bucket ($20/month storage)
- **QuickBooks**: Automatic cloud backup (Intuit hosted), plus monthly export to Google Drive
- **Google Workspace**: Native retention (Google keeps deleted files 30 days), plus Backupify ($5/user/month for comprehensive backup)
- **Website**: UpdraftPlus plugin (daily backup to Google Drive—database + files)

**Disaster Recovery**:

- RPO (Recovery Point Objective): <24 hours (lose max 1 day of data)
- RTO (Recovery Time Objective): <4 hours (operational within half day)
- Tested annually (restore backup to test environment, verify integrity)

---

## Security & Access Controls

### Access Management

**Principle of Least Privilege**: Staff access only systems/data needed for their role

| **Role**                 | **Salesforce**                   | **REDCap**                    | **QuickBooks**              | **Google Drive**                        |
| ------------------------ | -------------------------------- | ----------------------------- | --------------------------- | --------------------------------------- |
| **Executive Director**   | Full Admin                       | Full Admin                    | Full Admin                  | Owner (all folders)                     |
| **COO**                  | Full Admin                       | Admin                         | Admin                       | Owner                                   |
| **Development Director** | Standard (donors, events)        | Read-only (aggregate reports) | Read-only (revenue reports) | Access (Fundraising, Marketing folders) |
| **Research Coordinator** | Read-only (patient contact info) | Full Admin (registry)         | No access                   | Access (Research folder)                |
| **Patient Navigator**    | Standard (patient records)       | Data Entry (patient surveys)  | No access                   | Access (Programs folder)                |
| **Accountant/CPA**       | No access                        | No access                     | Full Admin                  | Access (Finance folder)                 |

**Two-Factor Authentication (2FA)**: REQUIRED for all systems

- Salesforce: Mandatory (enforced in settings)
- Google Workspace: Mandatory (admin enforces)
- QuickBooks: Strongly recommended (enable in settings)
- 1Password: Yes (protects password vault itself)

**Password Policy**:

- Minimum 12 characters (16+ for admins)
- Complexity: uppercase, lowercase, number, symbol
- No password reuse (1Password generates unique)
- Rotation: Every 180 days (prompted automatically)
- Shared passwords: NEVER via email/text—only via 1Password shared vault

**Device Security**:

- All Foundation-issued laptops: Full-disk encryption (FileVault on Mac, BitLocker on Windows)
- Mobile device management (Google MDM—free with Google Workspace): Remote wipe if phone lost/stolen
- Screen lock: Auto-lock after 5 minutes idle (password/biometric required)
- Antivirus: Mandatory (Windows Defender on PC, Malwarebytes on Mac—$40/year/device)

---

## Vendor Selection Criteria

### Evaluation Rubric (Score 1-5, Max 50 Points)

**1. Functionality (Weight: 10/50)**

- Does it solve our problem completely? (not 80%, not 120%—just right)
- Mission-critical features present? (e.g., fund accounting for QB, HIPAA compliance for REDCap)
- Nice-to-haves? (e.g., mobile app, API, reporting)

**2. Ease of Use (Weight: 8/50)**

- Can non-technical staff use without training? (low-code/no-code)
- Intuitive interface? (test with actual user, not just admin)
- Good documentation? (help articles, videos, community forum)

**3. Cost (Weight: 8/50)**

- Nonprofit discount available? (10-100% off)
- Total Cost of Ownership: subscription + implementation + training + support
- Scalability: Will cost 10x when we 10x users/data? (avoid cost surprises)

**4. Integrations (Weight: 7/50)**

- Native integrations with our core stack? (Salesforce, Google, QuickBooks)
- API available? (for custom integrations if needed)
- Zapier support? (fallback if no native integration)

**5. Security & Compliance (Weight: 7/50)**

- SOC 2 Type II certified? (standard for SaaS—audited security controls)
- HIPAA BAA available? (Business Associate Agreement—required for PHI)
- Data residency? (US-based preferred for legal simplicity)
- Encryption at rest + in transit? (TLS 1.2+, AES-256)

**6. Support (Weight: 5/50)**

- Response time? (email within 24 hours, chat within 4 hours ideal)
- Knowledge base quality? (can staff self-serve common questions?)
- Onboarding support? (free training, implementation help)

**7. Vendor Stability (Weight: 3/50)**

- Company age and funding? (prefer established—not startup that might fold)
- Customer count? (>10,000 customers = proven)
- Nonprofit references? (3-5 similar organizations using successfully)

**8. Scalability (Weight: 2/50)**

- Handles 10x growth? (500 patients → 5,000, 1K donors → 10K)
- Performance at scale? (no slowdowns when database grows)
- Upgrade path? (from free tier to paid, from basic to advanced)

**Decision Threshold**: >40/50 = Strong Yes, 35-39 = Qualified Yes (with caveats), <35 = Keep Looking

---

## 5-Year Technology Roadmap

### Year 1 (Startup): Core Infrastructure ($3K-$8K setup, $2K-$5K/year)

**Q1-Q2**:

- ✅ Google Workspace (email, docs, drive)
- ✅ WordPress website (public-facing)
- ✅ Salesforce NPSP (donors, basic patient tracking)
- ✅ Mailchimp (newsletters)
- ✅ QuickBooks (accounting)
- ✅ 1Password (security)
- ✅ Asana (project management)

**Q3-Q4**:

- ✅ REDCap (patient registry—once IRB approved)
- ✅ Donorbox or Salesforce donation pages (online giving)
- ✅ Zoom Pro ($150/year—support groups, Board meetings)

---

### Year 2 (Optimize): Integration & Automation ($10K-$20K)

**New Systems**:

- **HR System**: BambooHR ($150/month) or Gusto ($40/month base + $6/employee—payroll, benefits, onboarding)
- **Survey Tool**: Typeform or SurveyMonkey ($50-$100/month—patient satisfaction, program evaluation, not clinical surveys—that's REDCap)
- **Scheduling**: Calendly ($12/user/month—patient navigator appointments, donor meetings—syncs to Google Calendar)
- **E-signature**: DocuSign ($25/month—contracts, consent forms, donation pledges)

**Enhancements**:

- Salesforce ↔ QuickBooks integration (reduce manual entry)
- Salesforce ↔ REDCap integration (patient data sync)
- Mailchimp advanced automation (predictive send times, product recommendations [ok, donors, not patients 😊])
- Website redesign (Year 2 Q3—improve UX, accessibility audit)

**Training**:

- Salesforce admin certification for COO ($1,500 course + exam)
- REDCap advanced training (data quality, APIs—2-day workshop $800)

---

### Year 3 (Scale): Advanced Features ($20K-$40K)

**New Systems**:

- **Biobank Management**: Freezerworks ($5K one-time + $2K/year—track plasma/serum samples, chain of custody, -80°C freezer inventory)
- **Grant Management**: Foundant ($3K/year—track grants awarded by Foundation to researchers—application portal, review workflow, reporting)
- **Volunteer Management**: Better Impact ($3K/year—volunteer applications, background checks, hour tracking, communications)
- **Event Management**: Eventbrite ($100-$500/event fees) or Salesforce Events app (free AppExchange app—manage gala, conference, summits)

**Infrastructure Upgrades**:

- AWS hosting for custom applications (if any developed—e.g., patient portal)
- Datadog monitoring ($100/month—uptime alerts, performance dashboards)
- Advanced backups (OwnBackup for Salesforce $50/month, Backupify for Google $5/user/month)

**Data & Analytics**:

- Salesforce Einstein Analytics ($75/user/month—advanced dashboards, predictive insights like "Which donors likely to lapse?")
- Google Analytics 4 (free—website traffic, conversion tracking)
- Power BI or Tableau (if Board wants fancy visualizations—$20/user/month)

---

### Year 4 (Mature): Custom Development ($40K-$80K)

**Custom Applications**:

- **Patient Portal** (custom build—$30K-$50K): Patients log in, view registry data (de-identified), update surveys, access resources, message navigator
  - Technology: React (frontend) + Node.js (backend) + AWS hosting
  - Timeline: 6 months (design, build, test, launch)
  - Ongoing: $500-$1K/month (hosting, maintenance, support)

- **Researcher Data Access Portal** (custom build—$20K-$30K): Researchers apply for data access, Foundation approves, researchers query registry (aggregate data only, no PHI downloads)
  - Technology: REDCap API + custom query builder
  - Timeline: 4 months

**Advanced Integrations**:

- REDCap ↔ EHR systems (HL7/FHIR integration—pull clinical data from hospitals, reduce manual entry—$50K+ project, consider grant-funded)

---

### Year 5 (Innovation): AI & Automation ($50K-$100K)

**AI/ML Applications**:

- **Donor Propensity Scoring** (Einstein Analytics or custom model): Predict which prospects most likely to give $10K+, prioritize major gifts team outreach
- **Patient Matching** (custom ML model): Match newly diagnosed patients to most relevant support group based on demographics, disease severity, location
- **Research Data QA** (anomaly detection): Flag registry data outliers for review (e.g., FEV1 = 10 liters—typo? Or real outlier?)

**Automation**:

- Robotic Process Automation (RPA) for repetitive tasks (e.g., pull monthly metrics from 5 systems, generate Board report PDF—UiPath or Zapier)

**International Expansion** (if applicable):

- Multi-language website (WordPress multilingual plugins)
- GDPR-compliant systems (Salesforce already compliant, but processes need documentation)
- European payment processors (Stripe supports EUR, GBP—donations from European patients)

---

## Budget & Cost Management

### Year 1 Budget Breakdown

| **System**              | **Setup Cost**    | **Annual Cost** | **Notes**                                                                                  |
| ----------------------- | ----------------- | --------------- | ------------------------------------------------------------------------------------------ |
| **Google Workspace**    | $0                | $0              | Free for nonprofits (first 30 users)                                                       |
| **WordPress Hosting**   | $500              | $400            | WP Engine or Kinsta (includes security, backups)                                           |
| **Salesforce**          | $0                | $0              | Free 10 licenses via Power of Us (normally $4,320/year)                                    |
| **Mailchimp**           | $0                | $800            | $50-$100/month average (scales with contacts)                                              |
| **QuickBooks**          | $0                | $600            | $50/month nonprofit rate                                                                   |
| **REDCap**              | $0                | $500            | Free if university-hosted, or $500 commercial hosting                                      |
| **1Password**           | $0                | $200            | $8/user/month × 10 users = $960, but likely 5 users Year 1                                 |
| **Asana**               | $0                | $0              | Free tier adequate Year 1                                                                  |
| **Zoom Pro**            | $0                | $150            | $15/month single license (host creates all meetings)                                       |
| **Donorbox**            | $0                | $0              | 1.5% transaction fee (built into donation, not separate cost)                              |
| **Domain & SSL**        | $100              | $15             | $15/year domain renewal, SSL included with hosting                                         |
| **Subtotal**            | **$600**          | **$2,665**      | Core systems only                                                                          |
| **Implementation Help** | $2,000-$5,000     | —               | Freelance Salesforce admin (50-100 hours @ $50/hour), web developer (design + build = $2K) |
| **Training**            | $500-$1,000       | —               | Staff time (internal) + external courses (Salesforce Trailhead free, REDCap webinar $200)  |
| **Contingency (10%)**   | $300-$600         | $300            | Unexpected—plugin purchase, emergency support, etc.                                        |
| **TOTAL YEAR 1**        | **$3,400-$7,200** | **$3,000**      | One-time + recurring                                                                       |

---

### Year 2-5 Budget (Recurring Annual)

| **Year**   | **Systems Cost** | **Integration & Dev**                    | **Training & Support**         | **Total Annual** |
| ---------- | ---------------- | ---------------------------------------- | ------------------------------ | ---------------- |
| **Year 2** | $8,000           | $10,000 (integrations, website redesign) | $2,000 (Salesforce admin cert) | **$20,000**      |
| **Year 3** | $15,000          | $20,000 (biobank system, custom reports) | $3,000 (advanced training)     | **$38,000**      |
| **Year 4** | $25,000          | $50,000 (patient portal build)           | $5,000 (ongoing training)      | **$80,000**      |
| **Year 5** | $35,000          | $50,000 (AI/ML projects, international)  | $5,000                         | **$90,000**      |

**% of Operating Budget**:

- Year 1: $3K / $500K budget = 0.6% (very lean—mostly free nonprofit software)
- Year 3: $38K / $3M budget = 1.3% (healthy—below 2% typical for nonprofits)
- Year 5: $90K / $10M budget = 0.9% (efficient—scale economies, mature systems)

---

### Cost Optimization Strategies

**1. Nonprofit Discounts** (10-100% off)

- TechSoup (Microsoft, Adobe, Cisco—up to 90% off)
- Salesforce Power of Us (10 free licenses + $36/user vs. $150 standard = 76% off)
- Google for Nonprofits (free Workspace, $10K/month Google Ads grants)
- GitHub (free for nonprofits—if building custom software)

**2. Open Source** (Free Software)

- WordPress (vs. Drupal or proprietary CMS—save $10K-$50K)
- REDCap (vs. Medidata or Veeva—save $50K-$200K/year)
- LibreOffice (if Google Docs insufficient—free vs. Microsoft Office $100/user/year)

**3. Freemium Tiers** (Use Free as Long as Possible)

- Mailchimp (free up to 500 contacts—Year 1 likely fine)
- Asana (free up to 15 users—Year 1-2)
- Zoom (free 40-min meetings—buy Pro only when need longer support groups)
- Calendly (free 1 event type—upgrade to $12/month when need multiple types)

**4. Annual Billing** (10-20% discount vs. monthly)

- Most SaaS offers 2 free months if pay annually (16% discount)
- Foundation has cash flow → pay upfront, save $500-$1,000/year

**5. Consolidation** (Avoid Tool Sprawl)

- Use Salesforce for surveys (free Forms feature) instead of separate SurveyMonkey
- Use Google Drive for internal docs instead of separate Notion/Confluence
- Use Slack for video calls (free tier) instead of separate Zoom (until need >40 min)

---

## Key Performance Indicators (KPIs)

### System Health Metrics

**Uptime**:

- Target: >99.5% (max 3.6 hours downtime/month)
- Monitored via: Pingdom ($15/month) or UptimeRobot (free)
- Escalation: If >1 hour outage, notify COO + vendor support immediately

**Data Quality**:

- Salesforce: <5% duplicate records (dedupe tool runs weekly)
- REDCap: <10% missing data on required fields (query outstanding surveys)
- QuickBooks: Bank reconciliation within 5 days of month-end (catch errors fast)

**User Adoption**:

- Salesforce login rate: >80% of licensed users log in weekly (if not, they don't need license → reassign)
- Mailchimp open rate: >25% (nonprofit average 25.17%—if below, improve subject lines)
- REDCap survey completion: >70% (start → finish without abandonment—if low, survey too long or confusing)

**Security**:

- 2FA adoption: 100% (mandatory—enforce via admin settings)
- Password manager: 100% (spot-check—passwords stored in 1Password, not sticky notes)
- Phishing test: <10% click rate (quarterly simulated phishing—train staff who fall for it)

---

## Implementation Timeline Summary

### Month-by-Month Rollout (Year 1)

| **Month**     | **System**       | **Key Milestone**                     | **Owner**            |
| ------------- | ---------------- | ------------------------------------- | -------------------- |
| **Month 1**   | Google Workspace | Email, Drive, Calendar live           | COO                  |
| **Month 1**   | 1Password        | All staff migrated                    | COO                  |
| **Month 1**   | Asana            | Project tracking begins               | COO                  |
| **Month 2**   | QuickBooks       | Chart of accounts, bank feeds         | Accountant           |
| **Month 2**   | Salesforce       | Data model designed, NPSP installed   | COO + Consultant     |
| **Month 2-3** | WordPress        | Website launched                      | Web Developer + COO  |
| **Month 3**   | Mailchimp        | First newsletter sent                 | Development Director |
| **Month 3-4** | Salesforce       | Customization complete, training done | COO                  |
| **Month 4**   | Salesforce       | Data migration, go-live               | COO                  |
| **Month 3-5** | REDCap           | Database design, IRB approval         | Research Coordinator |
| **Month 6**   | REDCap           | Registry enrollment opens             | Research Coordinator |

---

## Change Management & Training

### Staff Training Plan

**Onboarding (New Hires)**:

- Day 1: Google Workspace (email, Drive, Calendar—1 hour)
- Day 2: 1Password + 2FA setup (30 min)
- Week 1: Salesforce basics (navigation, search, common tasks—2 hours)
- Week 2: Role-specific systems (e.g., Mailchimp for Development, REDCap for Research—2 hours)

**Ongoing Training**:

- Quarterly "Lunch & Learn" (1 hour—spotlight a feature, e.g., "Salesforce Reports 101," "Mailchimp Automation Tips")
- Annual refresher (half-day workshop—security best practices, system updates, new features)
- Self-paced learning (Salesforce Trailhead, Mailchimp Academy, Google Skillshop—staff complete modules, earn badges)

**Documentation**:

- Internal wiki (Google Sites or Notion—free): "How To" guides, FAQs, video tutorials
- System admins maintain (update when processes change)
- New hire checklist references wiki (learn by doing)

---

## Conclusion: Build Smart, Scale Sustainably

**Mark Egly Foundation's Technology Approach**:

- ✅ **Start simple**: Free/cheap nonprofit tools (Google, Salesforce, REDCap—<$3K Year 1)
- ✅ **Build on proven platforms**: Not custom-built from scratch (leverage Salesforce ecosystem, WordPress plugins)
- ✅ **Integrate, don't duplicate**: Systems talk to each other (Salesforce ↔ Mailchimp ↔ QuickBooks—one source of truth)
- ✅ **Secure by design**: HIPAA-compliant (REDCap), encrypted (Google Drive), 2FA enforced, regular backups
- ✅ **Scale gradually**: Add systems as needed (Year 1 = core, Year 3 = biobank, Year 5 = AI—don't overbuild)

**Investment Payoff**:

- **Time saved**: 10-20 hours/week (automation, integrations—staff focus on mission, not manual data entry)
- **Cost savings**: $50K-$100K vs. enterprise systems (nonprofit discounts, open-source, freemium tiers)
- **Impact multiplier**: Serve 10x more patients with same staff size (systems scale, humans don't—technology = force multiplier)

**"The best technology is invisible—it just works, so staff can focus on patients, research, and cures."**

---

**Document Owner**: Chief Operating Officer
**Review Frequency**: Annually (update for new systems, vendor changes, cost adjustments)
**Last Updated**: November 8, 2025
**Next Review**: November 2026

---

**Approved by**: Board of Directors, Technology Committee
**Effective Date**: January 1, 2026

---

_Technology serves the mission. Choose wisely, implement carefully, and scale sustainably._

**— Mark Egly Foundation Operations Team**
