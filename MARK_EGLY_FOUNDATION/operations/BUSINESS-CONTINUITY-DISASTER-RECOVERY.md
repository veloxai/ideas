# Business Continuity & Disaster Recovery Plan

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Operating Officer
**Purpose**: Comprehensive framework to ensure Mark Egly Foundation can continue critical operations during and after disasters, protect patient/donor data, and restore full functionality within defined recovery time objectives

---

## 📋 Table of Contents

1. [Business Impact Analysis](#business-impact-analysis)
2. [Recovery Objectives](#recovery-objectives)
3. [Disaster Scenarios](#disaster-scenarios)
4. [Critical Systems & Dependencies](#critical-systems--dependencies)
5. [Backup & Data Protection](#backup--data-protection)
6. [Recovery Procedures](#recovery-procedures)
7. [Communication Protocols](#communication-protocols)
8. [Testing & Exercises](#testing--exercises)
9. [Incident Response Team](#incident-response-team)
10. [Continuous Improvement](#continuous-improvement)

---

## Business Impact Analysis

### Mission-Critical Functions (Cannot Stop)

**Definition**: Functions that MUST continue during disaster—patient harm, legal violations, or catastrophic reputation damage if interrupted

| **Function**                      | **Max Tolerable Downtime (MTD)** | **Impact if Lost**                                                                         | **Priority**      |
| --------------------------------- | -------------------------------- | ------------------------------------------------------------------------------------------ | ----------------- |
| **Patient Navigation & Support**  | 4 hours                          | Patients in crisis can't reach Foundation (suicide risk, medical emergency referral needs) | **P1 - Critical** |
| **Research Registry Data Access** | 24 hours                         | Researchers can't access data (delays clinical trials, grant deliverables missed)          | **P1 - Critical** |
| **Donor Payment Processing**      | 72 hours                         | Year-end campaign donations lost (30% annual revenue in Dec—$300K+ at risk)                | **P1 - Critical** |
| **Email Communications**          | 8 hours                          | Can't respond to patients, donors, media (reputation harm, missed opportunities)           | **P2 - High**     |
| **Website (Public)**              | 24 hours                         | Diagnosis quiz unavailable (miss 50-100 potential patients/week)                           | **P2 - High**     |

---

### Important Functions (Should Continue)

**Definition**: Functions that should continue but can tolerate brief interruption with workarounds

| **Function**                    | **Max Tolerable Downtime (MTD)** | **Workaround**                                             | **Priority**    |
| ------------------------------- | -------------------------------- | ---------------------------------------------------------- | --------------- |
| **Grant Management**            | 7 days                           | Manual tracking in spreadsheets (inefficient but feasible) | **P3 - Medium** |
| **Accounting/Bookkeeping**      | 14 days                          | Paper records, process after recovery                      | **P3 - Medium** |
| **Social Media**                | 3 days                           | Post from personal accounts temporarily                    | **P4 - Low**    |
| **Internal Project Management** | 7 days                           | Email coordination, resume when systems back               | **P4 - Low**    |

---

### Financial Impact of Downtime

| **Duration** | **Direct Costs**                                | **Indirect Costs**                                                           | **Total Impact** |
| ------------ | ----------------------------------------------- | ---------------------------------------------------------------------------- | ---------------- |
| **4 hours**  | $500 (staff idle time)                          | $0 (minimal reputational impact)                                             | **$500**         |
| **1 day**    | $2,000 (staff + emergency IT)                   | $5,000 (missed donations, patient inquiries)                                 | **$7,000**       |
| **3 days**   | $8,000 (staff + consultants)                    | $25,000 (donor confidence, media coverage)                                   | **$33,000**      |
| **1 week**   | $20,000 (full disaster recovery, consultants)   | $100,000 (major donor loss, grant delays, reputation damage)                 | **$120,000**     |
| **1 month**  | $80,000 (rebuild systems, recovery consultants) | $500,000 (existential threat—donors defect, staff quit, patients lose trust) | **$580,000**     |

**Justification for BC/DR Investment**: Spending $10K-$20K/year on backup systems, disaster recovery planning, and testing prevents potential $120K-$580K losses

---

## Recovery Objectives

### RPO and RTO Definitions

**Recovery Point Objective (RPO)**: Maximum acceptable data loss (measured in time)

- _Example_: RPO = 24 hours means Foundation can afford to lose up to 24 hours of data (yesterday's work recreated from memory, emails, paper notes)

**Recovery Time Objective (RTO)**: Maximum acceptable downtime (measured in time)

- _Example_: RTO = 4 hours means Foundation must restore function within 4 hours of disaster

---

### Foundation's Recovery Targets

| **System**                    | **RPO**       | **RTO**  | **Rationale**                                                                                                                                   |
| ----------------------------- | ------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Google Workspace (Email)**  | 0 (real-time) | 4 hours  | Google's infrastructure (multi-region replication—data loss near impossible). RTO = staff access recovery (password resets, device replacement) |
| **Salesforce (CRM)**          | 24 hours      | 8 hours  | Daily backups (OwnBackup). Lose 1 day of donor/patient updates (acceptable—can recreate from emails, notes)                                     |
| **REDCap (Patient Registry)** | 24 hours      | 24 hours | Daily backups. Critical research data but not real-time life-or-death (patients not actively monitored in registry)                             |
| **QuickBooks (Accounting)**   | 7 days        | 72 hours | Weekly backups adequate (not processing transactions every day). Delayed bill payment acceptable short-term                                     |
| **WordPress (Website)**       | 24 hours      | 48 hours | Daily backups. Static content (not frequently changing). Can post "Site under maintenance" for 2 days without major impact                      |
| **1Password (Passwords)**     | 0 (real-time) | 1 hour   | 1Password multi-region sync. If lost, Foundation can't access ANY system (existential crisis—highest priority recovery)                         |

---

## Disaster Scenarios

### Scenario 1: Ransomware Attack

**Probability**: High (nonprofits targeted 3x more in 2024-2025)
**Impact**: Catastrophic (all systems encrypted, data held hostage)

**Attack Vector**:

- Phishing email → staff clicks malicious link → ransomware downloads → encrypts files (Google Drive, Salesforce, local laptops) → displays ransom note ("Pay $100K Bitcoin or data deleted")

**Immediate Response** (First 4 Hours):

1. **Isolate** (0-15 min):
   - Disconnect infected devices from WiFi/Ethernet (stop lateral spread)
   - Change all passwords (1Password, Google admin, Salesforce admin—assume attacker has credentials)
   - Notify staff: "Do NOT open email attachments until further notice"

2. **Assess** (15-60 min):
   - Identify scope: Which systems encrypted? (Check Google Drive, Salesforce, REDCap, QuickBooks, laptops)
   - Check backups: Are backups intact or also encrypted? (If attacker had access >24 hours, may have deleted backups)
   - Document timeline: When did encryption start? (SIEM logs, user reports—helps identify patient zero)

3. **Contain** (1-4 hours):
   - Disable compromised accounts (Google admin console, Salesforce)
   - Force password resets for ALL users (assume all credentials stolen)
   - Scan all devices with antivirus/EDR (remove malware before restoring data—otherwise reinfection)

**Recovery** (4-72 Hours):

1. **Restore from backups** (4-24 hours):
   - Google Drive: Google native backups (restore from previous day—24-hour RPO acceptable)
   - Salesforce: OwnBackup restore (8-hour RTO—full database restoration)
   - REDCap: AWS S3 backup restore (24-hour RTO—rebuild database, test data integrity)
   - Laptops: Reimage from clean OS install (don't restore from backup—may contain malware)

2. **Verify integrity** (24-48 hours):
   - Sample data checks: Do 100 random patient records look correct? (not corrupted)
   - System functionality: Can staff log in? Create records? Run reports?
   - Security scan: No malware remnants? (full antivirus + EDR scan)

3. **Resume operations** (48-72 hours):
   - Gradual staff re-access (admins first, then remaining staff—monitor for anomalies)
   - Communication to stakeholders: "Systems restored, no data loss, enhanced security implemented"

**Decision: Pay Ransom?**

- **Default position**: NO (FBI guidance—paying encourages more attacks, no guarantee of decryption)
- **Consider paying if**: (1) Backups failed, (2) Data loss >RPO (e.g., lose 1 month of registry data—irreplaceable), (3) Downtime >1 week (existential threat)
- **If paying**: Negotiate (average ransom paid = 10-30% of initial demand—$100K demand → $20K paid), use cyber insurance, involve law enforcement (FBI Cyber Division)

**Cost**:

- **Recovery without paying**: $20K-$50K (consultant fees, staff overtime, forensics, system rebuild)
- **Recovery if pay ransom**: $50K-$150K (ransom $20K-$100K + recovery costs—decryption often slow/incomplete)

---

### Scenario 2: Cloud Service Outage (AWS, Google, Salesforce)

**Probability**: Medium (AWS outage 2-3x/year, typically regional, 2-8 hours)
**Impact**: High (Foundation's systems unavailable but data not lost—temporary disruption)

**Example**: AWS US-East-1 outage (December 2021—8 hours, affected REDCap hosting)

**Immediate Response** (First 1 Hour):

1. **Verify outage** (0-10 min):
   - Check vendor status page (status.aws.amazon.com, status.cloud.google.com, status.salesforce.com)
   - Distinguish: Is this widespread outage (vendor's fault) or Foundation-specific issue (our misconfiguration, cyber attack)?

2. **Communicate** (10-30 min):
   - Internal: "AWS outage affecting REDCap—not a Foundation issue, monitoring vendor updates"
   - External (if necessary): Website banner "Patient registry temporarily unavailable due to hosting provider outage. Expected restoration: [vendor ETA]. Urgent patient inquiries: Call 555-1234"

3. **Activate workarounds** (30-60 min):
   - **Email**: If Google down, use personal emails temporarily (ED's Gmail, COO's Outlook—insecure but better than silence)
   - **Donor processing**: If Salesforce down, manual donor log (Google Sheet or paper—enter into Salesforce after restoration)
   - **Registry**: If REDCap down, no workaround (researchers must wait—not life-threatening, acceptable delay)

**Recovery** (Vendor-Dependent):

- **Vendor restores service**: Foundation verifies systems functional (login, test records, reports)
- **If extended outage >24 hours**: Escalate to vendor (enterprise support line), engage vendor's account team, demand compensation (SLA credits—refund 10-30% monthly fees)

**Prevention**:

- **Multi-region redundancy**: (Year 3+, ~$500/month extra) Host REDCap in US-East-1 AND US-West-2 (if one region down, failover to other—RTO <1 hour)
- **Vendor diversification**: Don't host everything on AWS (e.g., REDCap on AWS, website on Google Cloud—limits single-vendor risk)

---

### Scenario 3: Office Disaster (Fire, Flood, Tornado)

**Probability**: Low (but potentially catastrophic if not prepared)
**Impact**: Medium (Foundation is cloud-first—no critical on-premise servers, but staff displaced, equipment lost)

**Example**: Fire destroys Foundation office (rare but possible)

**Immediate Response** (First 4 Hours):

1. **Safety first** (0-15 min):
   - Evacuate staff (human life > data/equipment)
   - Account for all staff (call/text roll call)
   - Contact emergency services (911)

2. **Assess damage** (1-4 hours):
   - Office accessible? (If fire damage, likely condemned for weeks/months)
   - Equipment salvageable? (Water damage to laptops, smoke damage—likely total loss)
   - Data loss? (If cloud-first, minimal—all data on Google, Salesforce, AWS)

**Recovery** (4 Hours - 2 Weeks):

1. **Immediate workspace** (Day 1):
   - **Staff work from home** (already have laptops, VPN, cloud access—seamless transition)
   - **Phone forwarding**: Forward office phone to ED's cell (Google Voice or telecom provider—takes 1-2 hours)
   - **Virtual meetings**: Zoom, Google Meet (no in-person office needed short-term)

2. **Equipment replacement** (Days 1-7):
   - **Laptops**: Order replacements ($1,200-$1,500 each × 5 staff = $7,500, delivered 2-5 days)
   - **Phones**: Order replacements ($500-$800 each, overnight shipping)
   - **Insurance claim**: File with property insurance (recover equipment costs, business interruption—may take 30-90 days but reimburses Foundation)

3. **Temporary office** (Weeks 1-4):
   - **Coworking space**: WeWork, Regus ($500-$1,000/month per desk—flexible, short-term)
   - **Home office stipends**: $200/month per staff (internet upgrade, ergonomic chair, monitor—tax-deductible)
   - **Permanent office**: Search for new lease (2-6 months to find, negotiate, move-in)

**Cost**:

- **Immediate** (Week 1): $15K (equipment replacement)
- **Short-term** (Months 1-3): $20K (coworking, home office stipends, temporary IT)
- **Long-term** (Months 3-12): $50K (new office deposit, moving costs, furniture)
- **Total**: $85K (likely recovered via insurance minus $5K-$10K deductible)

---

### Scenario 4: Key Person Loss (ED, COO, CFO Sudden Departure)

**Probability**: Medium (illness, accident, resignation, termination—always possible)
**Impact**: High (leadership vacuum, institutional knowledge lost, operational disruption)

**Immediate Response** (First 24 Hours):

1. **Stabilize** (0-4 hours):
   - Board Chair assumes interim leadership (or appoints Acting ED if COO available)
   - Notify staff (emergency meeting—"ED has departed, Board managing transition, operations continue normally")

2. **Access control** (4-24 hours):
   - Revoke departed person's system access (Google admin, Salesforce, QuickBooks, 1Password—within 1 hour of departure to prevent sabotage or data theft)
   - Transfer critical accounts: Email forwarding (ED's email → Board Chair + COO), bank signature authority (COO or CFO added as signer)

**Recovery** (24 Hours - 6 Months):

1. **Interim leadership** (Days 1-30):
   - Acting ED (COO steps up or Board member temporarily—maintain operations while searching for permanent)
   - External consultant (if no internal successor—$200/hour × 20 hours/week = $4K/week, expensive but prevents collapse)

2. **Knowledge transfer** (Weeks 1-4):
   - Document review (departed ED's files, emails, contacts—COO/Acting ED extracts critical info)
   - Stakeholder outreach (major donors, grantors, partners—Acting ED calls: "Transition underway, Foundation stable, committed to mission")

3. **Permanent replacement** (Months 1-6):
   - Executive search (nonprofit recruiter $20K-$50K fee or Board-led search—free but time-intensive)
   - Hire and onboard (new ED—90 days to full productivity, overlapping COO support)

**Prevention** (Succession Planning):

- **Cross-training**: COO can perform 80% of ED functions (fundraising, Board liaison), ED can perform 80% of COO functions (operations, HR)
- **Documentation**: Key relationships documented (donor contact logs in Salesforce, grant files in Google Drive—not trapped in ED's head)
- **Backup authority**: Board resolution pre-authorizes COO to sign contracts <$50K (prevents operational freeze if ED suddenly unavailable)

---

### Scenario 5: Pandemic / Public Health Emergency (COVID-19 Repeat)

**Probability**: Medium (CDC predicts another pandemic within 20 years)
**Impact**: Medium (Foundation already remote-capable, but fundraising events, patient in-person support disrupted)

**Immediate Response** (First 1 Week):

1. **Remote operations** (Day 1):
   - All staff work from home (Foundation already cloud-first—seamless)
   - Cancel in-person events (conferences, fundraising galas—pivot to virtual)

2. **Patient support adjustment** (Days 1-7):
   - Telemedicine navigation (help patients access virtual pulmonology appointments—train staff on telehealth platforms)
   - Virtual support groups (Zoom support groups replace in-person—maintain patient connection)

**Recovery** (Ongoing, Months-Years):

- **Fundraising pivot**: Virtual galas ($50K-$100K raised—lower than in-person $200K but better than canceling), digital campaigns (email, social media—increase donor acquisition 2-3x to compensate)
- **Research continuity**: Remote data analysis continues (registry unaffected—researchers work from university/home), delayed: in-person biobank sample collection (halt new collections, resume when safe)

**Cost**: Minimal (Foundation already remote-capable—no new infrastructure needed, primary impact = reduced fundraising revenue, mitigated by digital campaigns)

---

## Critical Systems & Dependencies

### System Dependency Map

```
┌─────────────────────────────────────────────────────────────────┐
│  PATIENT-FACING LAYER                                           │
│  - Website (WordPress on Google Cloud)                         │
│  - Email (Google Workspace)                                     │
│  - Phone (Google Voice → Staff Cells)                          │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  OPERATIONAL LAYER                                              │
│  - CRM (Salesforce - donors + patients)                        │
│  - Patient Registry (REDCap on AWS)                            │
│  - Email Marketing (Mailchimp)                                 │
│  - Accounting (QuickBooks)                                      │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  COLLABORATION LAYER                                            │
│  - Document Storage (Google Drive)                              │
│  - Project Management (Asana)                                   │
│  - Video Conferencing (Zoom)                                    │
│  - Team Chat (Slack)                                            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  INFRASTRUCTURE LAYER                                           │
│  - Authentication (Google SSO, Salesforce 2FA)                  │
│  - Password Management (1Password)                              │
│  - Backups (OwnBackup, AWS S3, Google Vault)                   │
│  - Security Monitoring (Datadog, CrowdStrike)                   │
└─────────────────────────────────────────────────────────────────┘
```

**Single Points of Failure** (Highest Risk):

1. **1Password**: If lost, can't access any system (all passwords stored here—no 1Password = operational paralysis)
   - **Mitigation**: Emergency Kit (paper backup of master password + recovery codes, stored in COO's home safe + Board Chair's safe)
2. **Google Workspace**: If account compromised/suspended, lose email + Drive (all operations halt)
   - **Mitigation**: Super admin recovery phone numbers (3 Board members authorized for account recovery), Google Workspace support (24/7 enterprise line)
3. **Internet connectivity**: If office internet down, staff can't work
   - **Mitigation**: Remote work (staff work from home with home internet—redundant), mobile hotspots (provide 2-3 staff with hotspot devices—$50/month)

---

## Backup & Data Protection

### Backup Architecture

**Tier 1: Primary Data** (Production Systems)

- **Google Workspace**: Google data centers (multi-region automatic replication—California, Iowa, South Carolina)
- **Salesforce**: Salesforce cloud (US instance, automatic multi-datacenter replication)
- **REDCap**: AWS RDS database (US-East-1, automatic daily snapshots retained 7 days)
- **QuickBooks**: Intuit cloud (automatic backups, not directly accessible by Foundation)

**Tier 2: Secondary Backups** (Third-Party Backup Services)

- **Google Workspace**: Google Vault (litigation hold, 10-year retention—$5/user/month)
- **Salesforce**: OwnBackup (independent backup—not on Salesforce infrastructure, daily automated, 3-month retention, $600/year)
- **REDCap**: Daily automated backup script (AWS S3 bucket in separate AWS account—if primary account compromised, backup account safe)
- **Website**: UpdraftPlus plugin (daily backup to Google Drive—restore entire site in 1 hour)

**Tier 3: Offline/Immutable Backups** (Ransomware Protection)

- **Monthly offline backup**: External hard drive (4TB, encrypted, updated monthly, stored in bank safe deposit box—$100/year)
- **AWS S3 Object Lock**: 30-day immutable retention (ransomware attacker can't delete even with full AWS credentials—restore last clean backup)

---

### Backup Testing Schedule

| **System**       | **Test Frequency** | **Test Type**           | **Success Criteria**                                            | **Last Tested** |
| ---------------- | ------------------ | ----------------------- | --------------------------------------------------------------- | --------------- |
| **Google Drive** | Monthly            | Restore random file     | File accessible, content intact                                 | Oct 15, 2025    |
| **Salesforce**   | Quarterly          | Restore sandbox         | 100 test records restored, fields accurate                      | Sep 1, 2025     |
| **REDCap**       | Quarterly          | Full database restore   | Test environment rebuilt, query results match production        | Aug 20, 2025    |
| **QuickBooks**   | Annually           | Restore to test account | Chart of accounts, 1 month transactions restored                | Jan 15, 2025    |
| **Website**      | Quarterly          | Full site restore       | WordPress site rebuilt on test domain, pages/plugins functional | Oct 1, 2025     |
| **1Password**    | Annually           | Emergency Kit recovery  | Recover account from paper backup                               | Feb 1, 2025     |

**Failed Test Protocol**:

- **If test fails**: (1) Document failure (what went wrong), (2) Fix backup configuration, (3) Re-test within 7 days, (4) Report to COO + Board (if critical system)
- **Example**: Q2 2025 Salesforce restore test failed (OwnBackup API credentials expired—fixed by renewing, re-tested successfully 3 days later)

---

### Data Retention Policy

| **Data Type**             | **Retention**                                           | **Rationale**                                             | **Destruction Method**                                                                        |
| ------------------------- | ------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| **Patient Registry Data** | Permanent (or until patient requests deletion)          | Research data—long-term value, GDPR/CCPA right to erasure | Secure deletion (7-pass wipe) + certificate of destruction                                    |
| **Donor Records**         | 7 years after last donation                             | IRS audit requirements (substantiate tax deductions)      | After 7 years: anonymize (remove PII, keep donation amounts for historical analysis)          |
| **Financial Records**     | 7 years                                                 | IRS audit period                                          | Shred paper, secure delete digital                                                            |
| **Email**                 | 3 years (auto-delete)                                   | Reduce storage costs, legal discovery risk                | Google Workspace retention policy (auto-delete after 3 years, exceptions for litigation hold) |
| **HR Records**            | Employee: 7 years post-termination<br>Applicant: 1 year | EEOC requirements (employment discrimination claims)      | Secure deletion                                                                               |
| **Contracts**             | 7 years post-expiration                                 | Statute of limitations (contract disputes)                | Secure deletion                                                                               |

---

## Recovery Procedures

### Recovery Playbook Template

**SYSTEM: [Name]**
**RPO**: [Hours/Days]
**RTO**: [Hours/Days]
**Owner**: [Title]

**Trigger**: [When to initiate recovery—e.g., "System unavailable >1 hour and backup needed"]

**Prerequisites**:

- [ ] Verify disaster cause (ransomware, vendor outage, misconfiguration)
- [ ] Confirm backups exist and intact (check backup dashboard, not corrupted)
- [ ] Assemble recovery team (Owner + IT support + vendor if needed)

**Recovery Steps**:

1. **Step 1**: [Specific action—e.g., "Log into OwnBackup dashboard"]
2. **Step 2**: [Specific action—e.g., "Select most recent clean backup (pre-incident timestamp)"]
3. **Step 3**: [Specific action—e.g., "Initiate restore to production environment—estimated 4-8 hours"]
4. **Verification**: [How to confirm success—e.g., "Login to Salesforce, check 10 donor records match pre-incident state"]

**Estimated Time**: [Hours/Days]
**Cost**: [If requires vendor assistance—e.g., "$500 for expedited support"]

---

### Example: Salesforce Recovery Playbook

**SYSTEM**: Salesforce CRM
**RPO**: 24 hours
**RTO**: 8 hours
**Owner**: Development Director (+ IT Manager)

**Trigger**: Salesforce data lost, corrupted, or mass deletion detected (e.g., ransomware, accidental bulk delete, malicious insider)

**Prerequisites**:

- [x] OwnBackup subscription active (confirm $600/year paid, credentials valid)
- [x] Salesforce admin credentials available (stored in 1Password vault: "Salesforce Admin")
- [x] Backup exists within RTO window (check OwnBackup dashboard—last backup <24 hours old)

**Recovery Steps**:

**Phase 1: Assess Damage** (15-30 minutes)

1. Log into Salesforce (https://markeglyfoundation.my.salesforce.com)
2. Run "Data Health Report" (Setup → Data → Reports):
   - Count total Contacts: [Expected: 10,000 donors + 5,000 patients = 15,000]
   - Check sample records: Open 10 random donor records—do fields look correct?
3. Document scope:
   - **Partial loss**: [e.g., "500 donor records deleted"] → Restore those specific records only
   - **Total loss**: [e.g., "All data encrypted/deleted"] → Full database restore

**Phase 2: Restore from OwnBackup** (2-6 hours)

1. Log into OwnBackup (https://app.ownbackup.com)
   - Credentials: 1Password → "OwnBackup Admin"
2. Navigate: Salesforce Org → Backups → Select most recent CLEAN backup (pre-incident timestamp)
   - **Example**: Incident discovered Nov 8, 2025 10am → Select backup from Nov 7, 2025 11pm (last known good state)
3. Initiate restore:
   - **Partial restore**: Select specific objects (Contacts, Accounts, Opportunities—if only certain objects affected)
   - **Full restore**: All objects (if total data loss)
   - Restore mode: "Compare and restore" (overwrites changed records, leaves unchanged records alone—safer than full wipe)
4. Monitor progress (OwnBackup dashboard shows % complete—typical full restore = 4-8 hours for 100K records)

**Phase 3: Verify Restoration** (1-2 hours)

1. Salesforce data checks (30 min):
   - Count total records (should match backup count)
   - Spot-check 50 random records (open donor profiles—name, address, donation history look correct?)
   - Run critical reports (Year-to-Date Donations, Active Patients—do totals match expectations?)
2. Functionality tests (30 min):
   - Create test record (new Contact) → Save → Confirm visible
   - Delete test record → Confirm deletion works (not in read-only mode)
   - Mailchimp sync test (check if Salesforce → Mailchimp integration still working—may need to re-enable)
3. User acceptance (30 min):
   - Have 2-3 staff log in (Development Director, Patient Navigator) → Verify can access, edit, report (multi-user test)

**Phase 4: Post-Recovery** (30 min)

1. Change all Salesforce passwords (assume compromise—force all users to reset via email)
2. Review Salesforce audit logs (Setup → Security → View Setup Audit Trail—identify how data was lost to prevent recurrence)
3. Document incident (Incident Report template—what happened, how recovered, lessons learned)
4. Notify stakeholders (Board email: "Salesforce data recovered, no material loss, <24-hour downtime, enhanced monitoring implemented")

**Total Estimated Time**: 4-10 hours (depends on database size, complexity)

**Cost**:

- OwnBackup restore: $0 (included in $600/year subscription)
- If need expedited vendor support: $500 (Salesforce Premier Support—priority queue, 1-hour response)

**Common Pitfalls**:

- ❌ Restoring to wrong point in time (e.g., restore from 1 week ago → lose 1 week of new donor entries—verify backup timestamp carefully)
- ❌ Overwriting good data (e.g., if only 500 records lost but restore ALL 15,000 → lose 1 day of updates on unaffected 14,500 records—use "Compare and restore" mode)
- ❌ Not testing integrations (Mailchimp sync breaks after restore—must re-authenticate API connection)

---

### Example: REDCap Recovery Playbook

**SYSTEM**: REDCap Patient Registry
**RPO**: 24 hours
**RTO**: 24 hours
**Owner**: Research Coordinator (+ IT Manager or AWS consultant)

**Trigger**: REDCap database unavailable, corrupted, or data lost (AWS outage, database corruption, ransomware)

**Prerequisites**:

- [x] AWS account access (credentials in 1Password: "AWS Root Account" + "AWS S3 Backup Access")
- [x] REDCap backup script running (verify AWS S3 bucket "markeglyfoundation-redcap-backups" contains recent files—last 24 hours)
- [x] REDCap admin credentials (1Password: "REDCap Admin")

**Recovery Steps**:

**Phase 1: Assess & Backup Current State** (30 min)

1. Attempt to access REDCap (https://redcap.markeglyfoundation.org)
   - **If accessible but corrupted**: Export current state (even if corrupted—may be partially salvageable, don't overwrite without backup)
   - **If completely inaccessible**: Proceed to restore (no export possible)

**Phase 2: Restore Database** (4-12 hours, mostly automated)

1. Log into AWS Console (https://console.aws.amazon.com)
   - Navigate to: RDS → Databases → markeglyfoundation-redcap-db
2. Restore from automated snapshot:
   - **Option A: Automated RDS snapshot** (AWS creates daily snapshots automatically):
     - RDS → Snapshots → Select most recent clean snapshot (pre-incident date)
     - Click "Restore Snapshot" → New database instance name: "redcap-db-restored-nov8"
     - Instance type: Same as production (db.t3.medium—$50/month)
     - Launch (takes 30-60 minutes to restore 10GB database)
   - **Option B: Manual S3 backup** (if RDS snapshots also corrupted—rare but possible):
     - Download backup file from S3 (bucket: markeglyfoundation-redcap-backups, file: redcap_backup_2025-11-07.sql)
     - Restore to new RDS instance using MySQL command:
       ```bash
       mysql -h redcap-db-restored-nov8.aws-endpoint.com -u admin -p redcap_database < redcap_backup_2025-11-07.sql
       ```
     - Estimated time: 2-4 hours for 10GB database
3. Update REDCap configuration:
   - Edit REDCap config file (/var/www/html/redcap/database.php) → Change database hostname to restored instance
   - Restart web server: `sudo systemctl restart apache2`

**Phase 3: Verify Restoration** (2-3 hours)

1. REDCap functionality tests (30 min):
   - Login to REDCap admin panel
   - Confirm project count (should match production—e.g., 5 projects: Alpha-1 Registry, Biobank, etc.)
   - Open 1 project → Check record count (should match expected—e.g., 10,000 patient records)
2. Data integrity checks (1 hour):
   - Random sampling: Export 100 random patient IDs → Compare to known good data (paper records, previous export—if available)
   - Query tests: Run standard REDCap reports (Patient Demographics, Genotype Distribution) → Compare to last known results
   - Missing data analysis: Check if any records from incident window lost (e.g., if backup from Nov 7 but incident Nov 8 → Nov 8 data lost—acceptable per 24-hour RPO)
3. Researcher access test (30 min):
   - Have 2-3 researchers log in → Verify can access projects, view data, export (no data corruption visible to users)

**Phase 4: Cutover to Restored System** (1-2 hours)

1. DNS update (if using new RDS instance):
   - Point redcap.markeglyfoundation.org to restored database instance (update Route 53 DNS—takes 5-15 minutes to propagate)
2. Communication:
   - Email researchers: "REDCap restored, last 24 hours of data entry may be lost (please re-enter if you entered data on Nov 8), systems fully operational"
3. Incident review:
   - Document in incident log (what caused failure, how prevented in future—e.g., if RDS ran out of disk space → increase storage allocation, monitor with CloudWatch alarms)

**Total Estimated Time**: 6-18 hours (depends on database size, restore method)

**Cost**:

- RDS restore: $0 (automated snapshots included in RDS pricing)
- Temporary second instance: $50 (1 month—if keep both running during testing, can delete after verification)
- AWS consultant (if IT Manager can't execute): $200/hour × 4 hours = $800

---

## Communication Protocols

### Internal Communication (Staff)

**Incident Notification Hierarchy**:

1. **Discover incident** → Notify COO immediately (call + text + email—redundant to ensure received)
2. **COO assesses** → Decide if disaster response needed (minor issue = IT Manager handles, major = activate full team)
3. **COO activates team** → Emergency call/text to Incident Response Team (ED, IT Manager, Development Director if donor data affected, Research Coordinator if registry affected)

**Communication Tools** (In Priority Order):

1. **Phone calls/texts** (primary—reliable even if internet/email down)
2. **Personal email** (if Google Workspace down—use personal Gmail, Outlook)
3. **Slack** (if available—fast group chat)
4. **In-person** (if local and possible—office evacuation scenario)

**Status Updates**:

- **Every 2 hours** during active incident (even if "no update"—confirms team still working, not new problem)
- **All-staff update** once incident contained (don't alarm staff prematurely—wait until understand scope)

---

### External Communication (Donors, Patients, Public)

**Decision Matrix: Do We Publicly Disclose?**

| **Incident Type**                        | **Disclose?**         | **Timing**                     | **Rationale**                                                                       |
| ---------------------------------------- | --------------------- | ------------------------------ | ----------------------------------------------------------------------------------- |
| **Patient data breach**                  | YES (required by law) | Within 60 days (HIPAA)         | Legal requirement—notify affected patients + HHS + media (if >500 patients)         |
| **Donor data breach**                    | YES (ethical + legal) | Within 30 days (best practice) | Donors deserve to know—risk of identity theft, phishing                             |
| **Ransomware with data theft**           | YES                   | Immediately after confirmed    | Public transparency builds trust—worse if discovered via media leak                 |
| **Systems down <24 hours, no data loss** | NO (internal only)    | N/A                            | Minor disruption—don't alarm stakeholders unnecessarily                             |
| **Systems down >48 hours**               | YES                   | 48-hour mark                   | Donors/patients notice (website down, emails bounce—proactive better than reactive) |
| **Office disaster (fire)**               | YES                   | Immediately                    | Visible event (can't hide)—reassure stakeholders operations continue remotely       |

**Communication Templates**:

**Template 1: Data Breach Notification (HIPAA-Required)**

Subject: Important Notice Regarding Mark Egly Foundation Patient Data

Dear [Patient Name],

We are writing to inform you of a data security incident that may have affected your personal health information stored in our patient registry.

**What Happened**: On [Date], we discovered that an unauthorized party accessed our patient database through [brief description—e.g., ransomware attack, vendor breach]. The incident was contained on [Date], and we have no evidence of misuse of your data.

**What Information Was Involved**: The affected information includes [list: names, dates of birth, email addresses, medical conditions, genetic test results—be specific]. Financial information (credit card, bank account) was NOT involved.

**What We Are Doing**: We have [actions taken: restored from backups, enhanced security, engaged cybersecurity firm, notified law enforcement]. We are offering [remedies: free credit monitoring for 1 year via Experian—$20/person × 500 patients = $10K].

**What You Should Do**:

- Monitor your medical records (request copies from your providers, check for fraudulent insurance claims)
- Enroll in credit monitoring (link provided below—activation by [deadline])
- Report suspicious activity (call us at 555-1234 or email privacy@markeglyfoundation.org)

We sincerely apologize for this incident. Protecting your information is our highest priority, and we are committed to preventing recurrence.

Sincerely,
[Executive Director Name]
Mark Egly Foundation

---

**Template 2: Systems Outage (No Data Loss)**

Subject: Mark Egly Foundation Systems Restoration Update

Dear [Donors/Patients/Partners],

You may have noticed that our website and patient registry were temporarily unavailable from [Date/Time] to [Date/Time] due to [brief reason—e.g., hosting provider outage, scheduled maintenance, security incident].

**Impact**: [Services affected—e.g., website inaccessible, registry data entry paused, email delayed]. Donor data, patient data, and financial information were NOT compromised—this was an availability issue, not a security breach.

**Resolution**: Systems are now fully operational. All data is intact, and no information was lost.

**Lessons Learned**: We have [actions taken—e.g., implemented redundant backup systems, enhanced monitoring, changed hosting providers] to prevent recurrence.

We apologize for any inconvenience. If you have questions, contact us at 555-1234 or info@markeglyfoundation.org.

Sincerely,
[Executive Director Name]
Mark Egly Foundation

---

### Media Relations (If Breach >500 Records)

**HIPAA Requirement**: Breaches affecting >500 individuals = notify local media (HHS publishes on public "Wall of Shame" website)

**Proactive Strategy** (Better than reactive):

1. **Pre-draft press release** (have template ready—fill in incident specifics)
2. **Designate spokesperson** (ED or Board Chair—media-trained, calm under pressure)
3. **Key messages** (3 bullets):
   - "Patient safety is our priority—we immediately contained the incident and notified affected individuals"
   - "We are working with cybersecurity experts and law enforcement to investigate and prevent recurrence"
   - "We regret this incident and are offering affected patients free credit monitoring and identity theft protection"
4. **Avoid**:
   - ❌ "No comment" (sounds guilty, evasive)
   - ❌ Blame victims ("Staff shouldn't have clicked phishing link"—internal issue, not public statement)
   - ❌ Downplay severity ("It wasn't that bad"—patients decide severity, not Foundation)

---

## Testing & Exercises

### Annual Disaster Recovery Test (Full-Scale Exercise)

**Frequency**: Annually (September—after summer, before year-end campaign)

**Scenario**: Tabletop exercise (simulate disaster, test decision-making + communication—no actual systems disrupted)

**Example Scenario: Ransomware Attack**

- **9:00 AM**: Facilitator (external consultant or COO): "It's 9am Monday. Staff reports Salesforce is displaying 'Your files are encrypted. Pay $100K Bitcoin to unlock.' What do you do?"
- **Team discusses**: (ED, COO, IT Manager, Development Director, Board Chair participating)
  - Who do we call first? (IT Manager to assess, COO to lead response)
  - Do we isolate systems? (Yes—immediately disconnect from network)
  - Do we notify Board? (Yes—Board Chair within 1 hour)
  - Do we pay ransom? (No—default position, check if backups intact first)
- **9:30 AM**: Facilitator injects complication: "Backups were also encrypted. Do you change your decision?"
  - Team discusses: Escalate to cyber insurance (will they cover ransom?), engage FBI, consider paying if data truly unrecoverable
- **10:00 AM**: Facilitator: "Assume you restore from backups. How do you notify donors?"
  - Team drafts communication (use Template 2 from Communication Protocols), decides disclosure (if no PHI stolen = not HIPAA-reportable, internal notification only)

**Duration**: 2-3 hours

**Output**: After-action report (what went well, what needs improvement—e.g., "Response times good, but communication templates need pre-approval from legal")

**Cost**: $2K-$5K (if hire external facilitator—disaster recovery consultant provides scenario, facilitates discussion, writes report)

---

### Quarterly Backup Restore Test

**Frequency**: Quarterly (January, April, July, October)

**Scope**: Rotate through critical systems each quarter

- **Q1**: Salesforce
- **Q2**: REDCap
- **Q3**: Website
- **Q4**: QuickBooks + Google Drive

**Process**:

1. Select random restore point (from 30 days ago—ensures backups not only recent)
2. Restore to TEST environment (not production—don't disrupt live operations)
3. Verify data integrity (spot-check 50 records, run sample reports)
4. Document results (pass/fail, time to restore, issues encountered)

**Pass Criteria**:

- [x] Restore completes within 2× RTO (e.g., Salesforce RTO = 8 hours, test must complete in <16 hours)
- [x] Data accuracy >99% (spot-check 50 records—<1 should have errors)
- [x] System functional (users can login, create/edit records, run reports)

**If Fail**: Escalate to COO, fix backup configuration, re-test within 7 days

---

## Incident Response Team

### Team Structure

| **Role**                                              | **Responsibilities**                                                                                 | **Skills Needed**                                                      | **Training**                                                           |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| **Incident Commander** (COO)                          | Overall coordination, decision authority, stakeholder communication (Board, ED)                      | Leadership, decisiveness under pressure, technical literacy            | Annual tabletop exercise, quarterly status reviews                     |
| **Technical Lead** (IT Manager or consultant)         | Assess technical scope, execute recovery, vendor coordination                                        | Systems admin (AWS, Salesforce, Linux), backup/restore expertise       | Quarterly backup tests, vendor training (OwnBackup, AWS)               |
| **Communications Lead** (Development Director)        | Stakeholder notifications (donors, patients, media), message consistency                             | PR/communications, empathy, crisis messaging                           | Annual media training (if breach >500 records, may need spokesperson)  |
| **Security Lead** (IT Security Officer or consultant) | Investigate breach cause, implement post-incident controls, forensics                                | Cybersecurity (SIEM, malware analysis), incident response (SANS, NIST) | Annual security conference (e.g., RSA), monthly threat intel briefings |
| **Legal Advisor** (Attorney)                          | Regulatory notifications (HIPAA, state breach laws), liability assessment, insurance claims          | HIPAA law, nonprofit law, cyber insurance                              | Retainer relationship (on-call for incidents—not full-time staff)      |
| **Executive Sponsor** (ED)                            | Board liaison, final decision authority (e.g., pay ransom?), public spokesperson (if major incident) | Leadership, public speaking, crisis management                         | Annual crisis management training (Board + executives)                 |

---

### Roles & Responsibilities Matrix (RACI)

| **Activity**                       | **Incident Commander (COO)** | **Technical Lead** | **Communications** | **Security Lead** | **Legal** | **ED** |
| ---------------------------------- | ---------------------------- | ------------------ | ------------------ | ----------------- | --------- | ------ |
| **Detect incident**                | I                            | R                  | I                  | R                 | -         | -      |
| **Assess severity**                | R                            | C                  | I                  | C                 | -         | I      |
| **Activate team**                  | R                            | I                  | I                  | I                 | I         | A      |
| **Contain threat**                 | A                            | R                  | -                  | C                 | -         | I      |
| **Restore systems**                | A                            | R                  | I                  | C                 | -         | I      |
| **Notify stakeholders (internal)** | R                            | I                  | C                  | -                 | -         | A      |
| **Notify stakeholders (external)** | C                            | -                  | R                  | -                 | C         | A      |
| **Regulatory notifications**       | I                            | -                  | -                  | I                 | R         | A      |
| **Post-incident review**           | R                            | C                  | C                  | C                 | C         | A      |

**Legend**: R = Responsible (does the work), A = Accountable (final decision), C = Consulted (provides input), I = Informed (kept updated)

---

## Continuous Improvement

### Post-Incident Review Process

**Timing**: Within 7 days of incident resolution (while fresh in team's memory)

**Participants**: Full Incident Response Team (COO, IT Manager, Development Director, Security Lead, ED, Board Chair if major incident)

**Agenda** (2-hour meeting):

1. **Timeline Review** (30 min): Reconstruct incident chronologically (when detected, when contained, when recovered—identify delays)
2. **What Went Well** (20 min): Celebrate successes (e.g., "Backups worked perfectly, restored in 6 hours vs. 8-hour RTO")
3. **What Went Wrong** (40 min): Identify failures (e.g., "Detection delayed 12 hours—SIEM alert not monitored overnight")
4. **Root Cause Analysis** (20 min): Why did incident occur? (e.g., "Phishing email because staff not trained on spotting fake sender addresses")
5. **Action Items** (10 min): Specific improvements (e.g., "Implement 24/7 SIEM monitoring via managed SOC—$500/month")

**Output**: Incident Report (5-10 pages—executive summary, timeline, root cause, action items, budget implications)

**Distribution**: Board Audit Committee (full report), Board (executive summary), Staff (lessons learned—no blame, focus on prevention)

---

### Metrics & Continuous Monitoring

| **Metric**                          | **Target**       | **Measurement**                                                          | **Frequency**                     |
| ----------------------------------- | ---------------- | ------------------------------------------------------------------------ | --------------------------------- |
| **Backup success rate**             | 100%             | Automated backup monitoring (OwnBackup dashboard, AWS CloudWatch alarms) | Daily (alerts if backup fails)    |
| **Mean Time to Detect (MTTD)**      | <4 hours         | Incident timestamp (when occurred) vs. detection timestamp               | Per incident (trending quarterly) |
| **Mean Time to Respond (MTTR)**     | <24 hours        | Detection timestamp vs. containment timestamp                            | Per incident (trending quarterly) |
| **Mean Time to Recover (MTTR)**     | < RTO per system | Incident start vs. full operational restoration                          | Per incident (trending quarterly) |
| **Recovery test success rate**      | 100%             | Quarterly backup restore tests (pass/fail)                               | Quarterly                         |
| **Staff BC/DR training completion** | 100%             | Annual training attendance                                               | Annually                          |
| **Vendor SLA compliance**           | >99%             | Vendor uptime reports (Google, Salesforce, AWS)                          | Monthly review                    |

**Quarterly Review**: COO + IT Manager review metrics (trending improving or degrading?), present to Board (dashboard format—green/yellow/red indicators)

---

## Conclusion: Resilience is Continuous

**Foundation's BC/DR Philosophy**:

- ✅ **Hope for the best, plan for the worst**: Disasters are rare but catastrophic—investment in preparedness pays off exponentially when incident occurs
- ✅ **Test, don't trust**: Backups that haven't been tested = don't exist (schedule quarterly restore tests, not optional)
- ✅ **Communication is half the battle**: Technical recovery is only half—stakeholder trust recovery equally important (proactive, transparent communication)
- ✅ **Learn from every incident**: Post-incident reviews = opportunities to improve (blame-free culture—focus on systems, not individuals)

**ROI of BC/DR Program**:

- **Invest**: $10K-$20K/year (backup services, testing, training, tabletop exercises)
- **Avoid**: $120K-$580K (1-week to 1-month downtime cost—see Business Impact Analysis)
- **Gain**: Donor confidence ("Foundation prepared for anything"), operational resilience ("We survived ransomware with <1 day downtime"), staff morale ("Leadership has our back—clear plans, not chaos")

**"Disasters don't make appointments. Preparedness makes the difference between disruption and disaster."**

---

**Document Owner**: Chief Operating Officer
**Review Frequency**: Annually (September) + After each incident
**Last Updated**: November 8, 2025
**Next Review**: September 2026

---

**Approved by**: Board of Directors, Audit & Risk Committee
**Effective Date**: January 1, 2026

---

_Resilience protects the mission. Preparedness is everyone's responsibility._

**— Mark Egly Foundation Operations Team**
