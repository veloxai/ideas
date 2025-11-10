# Cybersecurity Program

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Operating Officer & IT Security Officer
**Purpose**: Comprehensive cybersecurity framework to protect Mark Egly Foundation's systems, data, and reputation from cyber threats—beyond HIPAA baseline to enterprise-grade security

---

## 📋 Table of Contents

1. [Threat Landscape](#threat-landscape)
2. [Security Framework](#security-framework)
3. [Access Controls & Identity Management](#access-controls--identity-management)
4. [Network & Infrastructure Security](#network--infrastructure-security)
5. [Data Protection & Encryption](#data-protection--encryption)
6. [Endpoint Security](#endpoint-security)
7. [Security Monitoring & Incident Response](#security-monitoring--incident-response)
8. [Security Awareness & Training](#security-awareness--training)
9. [Vendor & Third-Party Risk](#vendor--third-party-risk)
10. [Compliance & Audit](#compliance--audit)

---

## Threat Landscape

### Why Nonprofits Are Targets

**Misconception**: "We're too small to be targeted"
**Reality**: Nonprofits are HIGH-VALUE targets because:

- **Sensitive data**: Patient PHI (genetic data, clinical records—black market value $250-$1,000/record)
- **Weak defenses**: Small IT budgets → fewer security controls → easier to breach
- **Payment likelihood**: Nonprofits pay ransomware (can't afford downtime—patient services, fundraising events depend on systems)
- **Lateral access**: Foundation → Research partners, hospitals, pharmaceutical companies (supply chain attacks)

---

### Threat Actors & Tactics

**1. Ransomware Gangs** (Highest Risk)

- **Who**: Organized cybercrime (REvil, LockBit, Conti—operate from Russia, Eastern Europe)
- **How**: Phishing emails → malware download → encrypt files → demand $50K-$500K Bitcoin ransom
- **Impact**: Systems down 7-30 days (even if pay ransom—decryption slow), data stolen + leaked if don't pay
- **Example**: 2021: University of California SF paid $1.14M ransomware (research data held hostage)

**2. Phishing & Social Engineering** (Most Common)

- **Who**: Opportunistic hackers, nation-states (China, Russia, North Korea—steal research)
- **How**: Fake emails ("Your password expiring, click to reset" → steals credentials), phone calls ("IT support, need your password"), texts (smishing)
- **Impact**: Account compromise → access to Salesforce (donor data), REDCap (patient data), QuickBooks (banking)
- **Example**: 2019: AARP phishing attack—staff clicked link, hackers accessed member database (38M records)

**3. Insider Threats** (10-20% of breaches)

- **Who**: Disgruntled employees, accidental leaks, compromised accounts
- **How**: Download donor list before quitting (sell to competitor), email PHI to personal account (HIPAA violation), leave laptop in coffee shop (stolen)
- **Impact**: Data loss, regulatory fines, reputation damage
- **Example**: 2020: Hospital employee accessed 2,500 patient records out of curiosity (not for care—HIPAA violation, $100K fine)

**4. Supply Chain Attacks**

- **Who**: Nation-states (sophisticated—APT groups like APT29 Cozy Bear)
- **How**: Compromise vendor software (e.g., SolarWinds hack 2020—malware in software update → 18,000 organizations infected including US government)
- **Impact**: Foundation doesn't know it's compromised (backdoor access for months), exfiltrate research data
- **Example**: 2023: MOVEit file transfer software hack → 2,000+ organizations breached (including Johns Hopkins)

---

### Foundation-Specific Risks

**Critical Assets** (Ranked by Value to Attackers):

1. **Patient Registry (REDCap)**: 10,000 patients × $500/record = $5M black market value (genetic data, rare disease—highly valuable)
2. **Donor Database (Salesforce)**: 10,000 donors × $10/record = $100K value (wealthy donors—phishing targets)
3. **Banking/Financial (QuickBooks)**: $10M/year budget → wire transfer fraud ($50K-$500K losses common)
4. **Research IP**: Gene therapy data, diagnostic patents ($1M-$10M competitor value)
5. **Email (Google Workspace)**: Staff accounts → lateral access to partners (hospitals, universities, pharmaceutical companies)

---

## Security Framework

### Defense-in-Depth Model (Layered Security)

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 7: PEOPLE (Security Awareness Training)                  │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 6: POLICIES (Acceptable Use, Incident Response)          │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 5: DATA (Encryption at Rest, DLP, Backups)               │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 4: APPLICATION (2FA, Role-Based Access, Patching)        │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 3: NETWORK (Firewall, VPN, Network Segmentation)         │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 2: HOST (Antivirus, EDR, Patch Management)               │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: PHYSICAL (Office access control, device locks)        │
└─────────────────────────────────────────────────────────────────┘
```

**Principle**: If attacker breaches one layer, others protect—no single point of failure

---

### NIST Cybersecurity Framework (Foundation's Approach)

**1. IDENTIFY** (Know what you have)

- Asset inventory (all devices, software, data—what needs protecting?)
- Risk assessment (which assets most critical? Which most vulnerable?)
- Security policies (define rules—who accesses what, when, how)

**2. PROTECT** (Secure the assets)

- Access controls (2FA, least privilege, password policies)
- Data protection (encryption, backups, DLP)
- Security training (quarterly phishing tests, annual courses)

**3. DETECT** (Catch attacks early)

- Security monitoring (SIEM logs, alerts for suspicious activity)
- Vulnerability scanning (quarterly—find weaknesses before attackers do)
- Threat intelligence (monitor for Foundation-specific threats—dark web mentions)

**4. RESPOND** (Contain and recover)

- Incident response plan (who does what when breach occurs)
- Forensics (investigate how breach happened, what data stolen)
- Communication (notify patients, donors, regulators as required)

**5. RECOVER** (Restore operations)

- Disaster recovery (restore from backups, rebuild systems)
- Lessons learned (post-mortem—how prevent recurrence?)
- Continuous improvement (update controls based on incident)

---

## Access Controls & Identity Management

### Multi-Factor Authentication (MFA/2FA)

**Requirement**: MANDATORY for all systems, all users, no exceptions

**Implementation**:

- **Google Workspace**: Enforced via admin console (SMS, authenticator app, or YubiKey)
- **Salesforce**: Enforced via Session Settings (authenticator app required—SMS not allowed, less secure)
- **QuickBooks**: Strongly recommended (enable in settings, push all users)
- **REDCap**: Required for admins, recommended for all users
- **1Password**: Protected by master password + 2FA (device authorization)

**Approved MFA Methods** (Ranked Best → Worst):

1. **Hardware tokens** (YubiKey $50/key—phishing-resistant, gold standard)
2. **Authenticator apps** (Google Authenticator, Authy—time-based codes, good)
3. **SMS codes** (text message—acceptable but vulnerable to SIM swapping, use only if no alternative)
4. **❌ Email codes** (NOT approved—if email hacked, MFA bypassed)

**Rollout Timeline**:

- Month 1: ED, COO, Finance staff (high-privilege accounts first)
- Month 2: All staff (universal enforcement)
- Month 3: Board members (accessing sensitive documents)

---

### Role-Based Access Control (RBAC)

**Principle of Least Privilege**: Give minimum access needed for job function—no more

| **Role**                 | **Systems**                                            | **Access Level** | **Rationale**                                             |
| ------------------------ | ------------------------------------------------------ | ---------------- | --------------------------------------------------------- |
| **Executive Director**   | All systems                                            | Admin            | Oversight, emergency access                               |
| **COO**                  | All systems                                            | Admin            | Day-to-day operations management                          |
| **Development Director** | Salesforce (donors), Mailchimp, QuickBooks (read-only) | Standard         | Need donor data, not patient data                         |
| **Patient Navigator**    | Salesforce (patients only), REDCap (data entry)        | Standard         | Need patient contact, limited clinical                    |
| **Research Coordinator** | REDCap (full), Salesforce (read-only patients)         | Admin (REDCap)   | Manage registry, reference Salesforce for contact info    |
| **Accountant**           | QuickBooks                                             | Admin            | Bookkeeping, financial reports                            |
| **Board Members**        | Google Drive (Board folder only)                       | View-only        | Review documents, not edit (except Board Chair = Editor)  |
| **Volunteers**           | None (or limited public survey access)                 | No system access | Minimize risk—volunteers = higher turnover, less training |

**Access Reviews**: Quarterly audit (COO reviews who has access to what—revoke unnecessary permissions)

---

### Password Policy

**Requirements**:

- **Minimum length**: 16 characters (12+ for legacy systems that can't handle longer)
- **Complexity**: Mix of uppercase, lowercase, numbers, symbols (enforced by 1Password generator)
- **No reuse**: Every account = unique password (1Password ensures this)
- **Rotation**: Every 180 days (automatic prompts), or immediately after breach/departure

**Banned Practices**:

- ❌ Sharing passwords (even "temporarily"—use shared vault in 1Password instead)
- ❌ Writing on sticky notes (physical or digital—if on screen, screenshot = breach)
- ❌ Emailing/texting passwords (email = insecure, texts = phone theft risk)
- ❌ Using personal info (birthdays, pet names—easily guessed)

**Enforcement**:

- 1Password = mandatory (all staff must use, IT installs and onboards)
- Quarterly password audits (1Password Watchtower flags weak, reused, compromised passwords)
- Violations = remedial training (first offense), written warning (second), termination (third—severe breach of security policy)

---

## Network & Infrastructure Security

### Cloud-First Security

**Why Cloud > On-Premise for Foundation**:

- ✅ **Professional security teams**: Google, AWS employ 1,000+ security engineers (Foundation can't compete)
- ✅ **Automatic patching**: Cloud providers patch vulnerabilities within hours (on-premise = IT staff must manually patch—often delayed)
- ✅ **DDoS protection**: Built-in (on-premise = expensive separate service)
- ✅ **Compliance certifications**: SOC 2, HIPAA, ISO 27001 (Foundation inherits compliance)

**Cloud Security Checklist**:

- [x] **Google Workspace**: HIPAA BAA signed (Business Associate Agreement—legally binds Google to HIPAA compliance)
- [x] **Salesforce**: Shield encryption enabled (additional encryption layer—$25/user/month, worth it for sensitive donor data)
- [x] **AWS** (if used): VPC configured (Virtual Private Cloud—isolated network), security groups restrict access (firewall rules), CloudTrail enabled (audit logs)
- [x] **All SaaS**: TLS 1.3 enforced (encrypted connections), IP whitelisting where possible (access only from Foundation IP addresses—prevents credential theft from public WiFi)

---

### Network Segmentation

**Staff Devices** (Laptops, phones):

- Connect via **Guest WiFi** or **VPN** (encrypted tunnel—traffic hidden from ISP, coffee shop, etc.)
- VPN = Tailscale ($10/user/month—modern, easy to use) or Cloudflare Zero Trust (free tier adequate for 50 users)
- **No direct access** to Foundation network (all apps are cloud—no internal servers to access, reduces attack surface)

**Office Network** (If physical office):

- **Staff WiFi**: WPA3 encryption (password protected, guest network separate)
- **Guest WiFi**: Isolated VLAN (visitors can't access staff devices)
- **IoT devices**: Separate network (smart thermostat, security cameras—often insecure, don't want on same network as laptops)

---

## Data Protection & Encryption

### Encryption Standards

**At Rest** (Data Stored):

- **Google Drive**: AES-256 encryption (Google manages keys)
- **Salesforce**: AES-256 (with Shield Platform Encryption—Foundation manages keys, higher security)
- **REDCap**: AES-256 database encryption + encrypted backups
- **Laptops**: Full-disk encryption mandatory (FileVault on Mac, BitLocker on Windows—if laptop stolen, data unreadable)

**In Transit** (Data Moving):

- **TLS 1.3** required for all web traffic (HTTPS—green padlock in browser, prevents eavesdropping)
- **Verify certificates**: Train staff to check URLs (markeglyfoundation.org, NOT markeglyfoundati0n.org [zero instead of O]—phishing site)

---

### Data Loss Prevention (DLP)

**Google Workspace DLP Rules** ($10/user/month—Google Workspace Enterprise):

- **Rule 1**: Detect PHI in emails (name + medical condition, SSN-like patterns) → warn user + send alert to COO ("Are you sure you want to email patient data?")
- **Rule 2**: Block large file downloads to personal accounts (>100 MB from Drive → personal Gmail = suspicious)
- **Rule 3**: External sharing alerts (Share Google Doc with @outsider-domain → COO notification, monthly review)

**Salesforce DLP**:

- **Field-level security**: Hide sensitive fields (SSN, genotype, bank account) from standard users—only admins see
- **Export restrictions**: Disable bulk data exports for non-admins (prevent mass donor list download)

**Removable Media**:

- **USB drives**: Prohibited (malware vector + data theft risk)
- **Exception process**: COO approves encrypted USB (IronKey $100—hardware-encrypted) for specific use (e.g., transfer large dataset to research partner—but prefer secure file share like Box)

---

### Backup Strategy

**3-2-1 Backup Rule**:

- **3 copies** of data (original + 2 backups)
- **2 different media types** (cloud + local, or two different clouds)
- **1 offsite** (geographically separate—protect against fire, flood, earthquake)

**Foundation's Implementation**:

| **System**       | **Backup Frequency**       | **Backup Location**                           | **Retention**         | **Testing**            |
| ---------------- | -------------------------- | --------------------------------------------- | --------------------- | ---------------------- |
| **Google Drive** | Continuous (Google native) | Google data centers (multi-region)            | 30 days deleted files | Monthly restore test   |
| **Salesforce**   | Weekly                     | OwnBackup ($50/month—third-party)             | 3 months              | Quarterly restore test |
| **REDCap**       | Daily (automated)          | AWS S3 (separate account—not same as primary) | 1 year                | Quarterly restore test |
| **QuickBooks**   | Daily (Intuit automatic)   | Intuit cloud                                  | 90 days               | Annual restore test    |
| **Website**      | Daily                      | Google Drive (UpdraftPlus plugin)             | 30 days               | Quarterly restore test |

**Ransomware Protection**:

- **Immutable backups**: OwnBackup, AWS S3 (object lock—can't delete or modify for 30 days, even if attacker has credentials)
- **Air-gapped backup**: Monthly offline backup (external hard drive, stored in bank safe deposit box—ultimate protection, can rebuild even if all cloud compromised)

---

## Endpoint Security

### Device Management

**Foundation-Issued Devices**:

- **Laptops**: MacBook Air or Dell XPS ($1,200-$1,500 each—refresh every 3-4 years)
- **Phones**: iPhone or Google Pixel ($500-$800—Foundation pays plan for staff, BYOD not allowed for privileged accounts)
- **Tablets**: iPad (optional for navigators, Board members—PDF reader, note-taking)

**Security Configuration** (Pre-Deployment):

- [x] Full-disk encryption enabled (FileVault/BitLocker—required before first use)
- [x] Automatic updates ON (macOS, Windows, Chrome OS—monthly patches)
- [x] Firewall enabled (default deny—only approved apps communicate externally)
- [x] Screen lock: 5 minutes idle (password or biometric required)
- [x] Find My Device enabled (remote wipe if lost—erase all data remotely)
- [x] Antivirus installed (see below)

**Mobile Device Management (MDM)**:

- **Google Workspace MDM** (free with Enterprise—$10/user/month if needed): Enforce policies (require passcode, disable screenshots in sensitive apps, remote wipe)
- **Apple Business Manager** (free): Deploy iPhones with Foundation settings (VPN auto-installed, corporate email)

---

### Antivirus & Endpoint Detection and Response (EDR)

**Antivirus** (Basic—catches 90% of malware):

- **Windows**: Microsoft Defender (built-in, free, good enough)
- **Mac**: Malwarebytes ($40/year/device—supplements macOS security)
- **Updates**: Automatic (daily signature updates)

**EDR** (Advanced—Year 3+ when budget allows):

- **CrowdStrike Falcon** ($8/device/month) or **SentinelOne** ($6/device/month): Behavioral detection (catches zero-day exploits antivirus misses), rollback ransomware changes, forensic analysis
- **When to upgrade**: Year 3 (15+ staff, $10M annual budget, registry = 5,000+ patients—higher stakes justify $2K/year cost)

---

### Patching & Vulnerability Management

**Update Policy**:

- **Critical security patches**: Within 7 days (zero-day exploits—install immediately, even if inconvenient)
- **Standard patches**: Monthly (Patch Tuesday—second Tuesday of month, Windows pushes updates)
- **Application updates**: Automatic for SaaS (Salesforce, Google, QuickBooks—vendor manages), quarterly for desktop apps (Adobe, Microsoft Office)

**Vulnerability Scanning** (Year 2+):

- **Tool**: Qualys ($2K/year) or Rapid7 InsightVM ($3K/year)—scans Foundation devices, identifies missing patches, misconfigurations
- **Frequency**: Monthly automated scan + quarterly penetration test (ethical hacker attempts breach—$5K-$10K/test, find weaknesses before real attackers)

---

## Security Monitoring & Incident Response

### Security Information and Event Management (SIEM)

**What is SIEM?**: Centralized logging + alerts (aggregate logs from all systems, detect suspicious patterns)

**Foundation's SIEM** (Year 2—when budget ~$2M+):

- **Tool**: Datadog Security Monitoring ($100-$300/month—affordable for nonprofits) or Splunk Cloud (free tier up to 500 MB/day—adequate Year 1-2)
- **Log Sources**:
  - Google Workspace (login failures, admin changes, file sharing)
  - Salesforce (login locations, mass data exports, privilege escalation)
  - REDCap (data access, record modifications)
  - QuickBooks (invoice creation, wire transfer initiation)
  - AWS CloudTrail (if using AWS—API calls, resource changes)

**Alerts** (Prioritized by Severity):

| **Alert**                                | **Trigger**                                                     | **Action**                                                                                               | **SLA**  |
| ---------------------------------------- | --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | -------- |
| **CRITICAL: Ransomware indicators**      | Mass file encryption, suspicious .exe execution                 | 1. Isolate device (disable WiFi/Ethernet)<br>2. Call COO immediately<br>3. Engage incident response team | <15 min  |
| **HIGH: Multiple login failures**        | >5 failed logins in 10 minutes (brute force attempt)            | 1. Lock account<br>2. Notify user (is this you?)<br>3. Reset password if compromised                     | <1 hour  |
| **MEDIUM: Access from unusual location** | Login from new country (user normally in Ohio, suddenly Russia) | 1. Challenge with MFA<br>2. Email user verification<br>3. Investigate if user denies                     | <4 hours |
| **LOW: Offhours access**                 | Login at 2am on weekend (unusual but not necessarily malicious) | 1. Log for review<br>2. Weekly report to COO<br>3. Ask user if expected                                  | 1 week   |

---

### Incident Response Plan

**Incident Response Team**:

- **Incident Commander**: COO (central decision-maker)
- **Technical Lead**: IT Manager or external consultant (contain and remediate)
- **Communications**: Development Director (internal comms), PR consultant (external media)
- **Legal**: Attorney (regulatory notifications—HIPAA breach reporting)
- **Executive**: ED (Board notifications, strategic decisions)

**Phases**:

**1. DETECTION** (Minutes–Hours)

- Alert fires (SIEM, user report, vendor notification)
- Initial triage: Is this real threat or false positive? (95% of alerts = false positives, don't panic)

**2. CONTAINMENT** (Hours)

- **Short-term**: Isolate affected systems (disconnect from network—stop lateral spread)
- **Long-term**: Patch vulnerability, reset credentials (prevent reinfection)

**3. ERADICATION** (Days)

- Remove malware (antivirus, manual deletion, rebuild system from clean backup)
- Identify root cause (phishing email? Unpatched vulnerability? Insider?)

**4. RECOVERY** (Days–Weeks)

- Restore data from backups (verify integrity—not restoring infected backup)
- Bring systems back online (phased—critical first, then remaining)
- Enhanced monitoring (watch for attacker returning)

**5. LESSONS LEARNED** (1-2 Weeks After)

- Post-incident review (what worked? What didn't?)
- Update controls (e.g., if phishing successful → enhance email filters, more training)
- Communicate to Board (transparency—what happened, how prevented recurrence, cost)

**Breach Notification Requirements** (HIPAA):

- **If PHI exposed**: Notify patients within 60 days (letter, email, or substitute notice if >10 people affected)
- **If >500 records**: Notify HHS Office of Civil Rights + local media (public disclosure—very damaging to reputation)
- **Penalty for non-compliance**: $50K per violation (max $1.5M/year—plus reputational harm, donor loss)

---

### Cyber Insurance

**Coverage** (Year 2—when budget ~$1M+):

- **Policy**: Cyber liability insurance ($1M-$2M coverage, $5K-$15K annual premium)
- **What's covered**:
  - Forensic investigation ($50K-$100K—expert incident responders)
  - Legal fees (HIPAA breach notifications, lawsuits—$50K-$200K)
  - Ransom payment ($50K-$500K—insurer negotiates, often pays 10-30% of initial demand)
  - Business interruption (lost fundraising revenue if systems down during year-end campaign)
  - PR crisis management ($20K-$50K—reputation repair)
- **What's NOT covered**:
  - Social engineering (CEO fraud—attacker impersonates ED, tricks Finance into wire transfer—separate crime insurance needed)
  - Unencrypted devices (if laptop not encrypted, breach not covered—strong incentive to comply)
  - Known vulnerabilities (if vulnerability scanner flagged risk 6 months ago, not patched, exploited—negligence, not covered)

**Carrier Selection**:

- Chubb, AIG, Beazley (specialize in cyber—understand nonprofit needs)
- Application requires security controls documentation (MFA, encryption, backups—lower premium if strong controls)

---

## Security Awareness & Training

### Staff Training Program

**Onboarding (New Hires)**:

- **Day 1**: Security basics (30 min video—passwords, phishing, clean desk policy)
- **Week 1**: Hands-on setup (1Password, 2FA, encrypted laptop—IT assistance)
- **Month 1**: Phishing test (simulated email—see if new hire clicks, immediate remedial training if fails)

**Annual Training** (All Staff):

- **KnowBe4** ($200/year for 10 users) or **Proofpoint** ($300/year): Interactive courses, certificates
- **Topics**:
  - Phishing identification (hover over links, check sender address, "If suspicious, report—don't click")
  - Physical security (lock screen when leaving desk, don't tailgate into office)
  - Data handling (PHI = email encrypted or don't email at all, donor data = Salesforce only)
  - Incident reporting (See something suspicious? Email security@markeglyfoundation.org immediately—no judgment, early detection saves millions)

**Quarterly Phishing Simulations**:

- **Vendor**: KnowBe4, Proofpoint, or LUCY ($10/user/year)
- **Example phishing emails**:
  - "Your Salesforce account expires today, click to renew" (fake link)
  - "CEO needs you to buy $500 gift cards urgently" (CEO fraud)
  - "Document shared: Q4 Budget.xlsx" (malicious attachment)
- **Click rate benchmark**: <10% good, <5% excellent, >20% remedial training needed
- **Remediation**: Staff who click get automatic 5-minute training ("Here's what you missed, here's how to spot next time"—not punitive, educational)

---

### Security Culture

**"See Something, Say Something"**:

- **Encourage reporting**: No punishment for reporting false alarms (better 10 false positives than 1 missed breach)
- **Reward vigilance**: Quarterly "Security Champion" award ($50 gift card—staff who reported most suspicious emails, caught phishing)

**Executive Leadership**:

- **ED and COO model behavior**: Use 1Password (not sticky notes), lock screens, attend training (if leaders exempt, staff won't take seriously)
- **Board oversight**: Cybersecurity = Board agenda item (quarterly update—recent threats, controls implemented, audit findings)

---

## Vendor & Third-Party Risk

### Vendor Security Assessment

**Before Signing Contract**:

- [ ] **SOC 2 Type II report** (request from vendor—audit of security controls, renewed annually)
- [ ] **HIPAA BAA** (if vendor handles PHI—legally binds them to HIPAA, not optional)
- [ ] **Insurance certificate** (vendor's cyber insurance—proves financial accountability if they're breached)
- [ ] **Security questionnaire** (SIG—Standardized Information Gathering, 125 questions—vendor completes, Foundation reviews):
  - Data encryption? (at rest + in transit)
  - Patch management? (how quickly they patch vulnerabilities)
  - Incident response? (have they been breached before? How handled?)
  - Subprocessors? (do they use other vendors—need to assess those too)

**Ongoing Monitoring**:

- **Annual re-assessment** (request updated SOC 2 report, re-send questionnaire if vendor had breach)
- **Breach notification clause in contract** (vendor must notify Foundation within 24 hours if our data compromised—not optional, legal requirement)

**Vendor Tiers** (Risk-Based Due Diligence):

| **Tier**      | **Risk**                                     | **Examples**                                  | **Assessment**                                                  |
| ------------- | -------------------------------------------- | --------------------------------------------- | --------------------------------------------------------------- |
| **Critical**  | High (handles PHI or payment data)           | REDCap hosting, QuickBooks, payment processor | Full SOC 2 audit, BAA, annual reviews, penetration test results |
| **Important** | Medium (handles business data)               | Salesforce, Google, Mailchimp                 | SOC 2, BAA (if any PHI), questionnaire                          |
| **Low**       | Low (commodity services, no Foundation data) | Zoom, Asana, Slack                            | SOC 2 (nice to have), basic questionnaire                       |

---

## Compliance & Audit

### Annual Security Audit

**Internal Audit** (Year 1-2):

- **Scope**: COO + external consultant ($5K-$10K) review controls
- **Checklist**:
  - Access reviews (who has access to what—revoke unnecessary)
  - Password audits (1Password Watchtower—weak, reused, compromised)
  - Patch compliance (all systems up to date?)
  - Backup tests (restore test—verify backups work)
  - Incident log review (what security events occurred, how handled)
- **Output**: Audit report (findings + recommendations), remediation plan (30-60-90 day action items)

**External Audit** (Year 3+, if required by grantors):

- **Scope**: Third-party auditor ($15K-$30K—CPA firm with cybersecurity practice) assesses controls
- **Standards**: SSAE 18 SOC 2 Type II (industry-standard audit—demonstrates to donors, partners Foundation takes security seriously)
- **Frequency**: Annual (maintain certification)

---

### Regulatory Compliance

**HIPAA Security Rule** (45 CFR Part 164.308-316):

- **Administrative** (policies, training, incident response—covered in this document)
- **Physical** (facility access, device security—lock office, encrypt laptops)
- **Technical** (access controls, encryption, audit logs—Salesforce, REDCap, Google)

**GDPR** (if European patients in registry):

- **Data minimization** (collect only necessary data—don't ask for data you don't need)
- **Right to erasure** (patient can request deletion—Foundation must comply within 30 days)
- **Data breach notification** (72 hours to notify EU authorities if EU resident data compromised)

**State Laws** (CCPA in California, similar in Virginia, Colorado, Connecticut):

- **Disclosure** (privacy policy states what data collected, how used, with whom shared)
- **Opt-out** (California residents can opt-out of data sharing—Foundation doesn't sell data anyway, but must offer option)

---

## Budget & Implementation Timeline

### Year 1 Security Budget ($3K-$8K)

| **Category**          | **Item**                         | **Cost**   |
| --------------------- | -------------------------------- | ---------- |
| **Identity & Access** | 1Password Teams (10 users)       | $100       |
|                       | Google Workspace 2FA (free)      | $0         |
| **Endpoint Security** | Malwarebytes (5 Macs)            | $200       |
|                       | Laptop encryption (built-in)     | $0         |
| **Network**           | Tailscale VPN (10 users)         | $100       |
| **Training**          | KnowBe4 phishing training        | $200       |
| **Backup**            | OwnBackup (Salesforce)           | $600       |
|                       | UpdraftPlus Premium (WordPress)  | $70        |
| **Monitoring**        | Datadog free tier                | $0         |
| **Consulting**        | Security assessment (consultant) | $5,000     |
| **Subtotal**          |                                  | $6,270     |
| **Contingency (20%)** |                                  | $1,250     |
| **Total Year 1**      |                                  | **$7,520** |

---

### Year 2-5 Budget Growth

| **Year**   | **Annual Spend** | **New Additions**                                                            |
| ---------- | ---------------- | ---------------------------------------------------------------------------- |
| **Year 2** | $12K             | SIEM (Datadog paid), cyber insurance ($8K), external audit ($5K)             |
| **Year 3** | $18K             | EDR (CrowdStrike), vulnerability scanning (Qualys), penetration test ($10K)  |
| **Year 4** | $25K             | Advanced DLP, enhanced monitoring, additional staff training                 |
| **Year 5** | $35K             | SOC 2 certification ($25K first-year, $15K ongoing), security team expansion |

**% of IT Budget**: 20-30% (security = critical investment, not optional)

---

## Key Performance Indicators (KPIs)

### Security Metrics (Track Monthly)

| **Metric**                      | **Target**          | **Measurement**                                                  |
| ------------------------------- | ------------------- | ---------------------------------------------------------------- |
| **MFA adoption**                | 100%                | Google Workspace admin console (user authentication report)      |
| **Phishing click rate**         | <10%                | KnowBe4 simulation results                                       |
| **Patch compliance**            | >95% within 30 days | Vulnerability scanner (% devices current on patches)             |
| **Password strength**           | 0 weak/reused       | 1Password Watchtower (flag violations)                           |
| **Backup success rate**         | 100%                | Automated backup alerts (failures trigger immediate remediation) |
| **Mean time to detect (MTTD)**  | <4 hours            | SIEM alert timestamp → acknowledged                              |
| **Mean time to respond (MTTR)** | <24 hours           | Incident start → contained                                       |
| **Security incidents**          | <5/year             | Incident log (true positives only—exclude false alarms)          |

---

## Conclusion: Security = Mission Enabler

**Foundation's Security Philosophy**:

- ✅ **Proactive, not reactive**: Invest in prevention ($10K training + controls) vs. recovery ($500K breach cost)
- ✅ **Layered defenses**: No single control is perfect—multiple layers compensate
- ✅ **Culture of security**: Every staff member = part of security team (not just IT's job)
- ✅ **Continuous improvement**: Threats evolve → controls evolve (annual reviews, post-incident learning)

**ROI of Security**:

- **Avoid**: $500K ransomware, $200K HIPAA fine, $1M reputation damage
- **Invest**: $8K Year 1, $35K Year 5 (0.35% of $10M budget—negligible compared to breach cost)
- **Gain**: Donor trust ("Foundation protects my data"), research credibility ("IRB trusts our security"), patient safety ("My health data is secure")

**"Security isn't about technology—it's about protecting patients, honoring donors, and enabling the mission. Every control we implement is an act of stewardship."**

---

**Document Owner**: Chief Operating Officer + IT Security Officer (external consultant Year 1-2, dedicated role Year 3+)
**Review Frequency**: Quarterly (threat landscape changes rapidly)
**Last Updated**: November 8, 2025
**Next Review**: February 2026

---

**Approved by**: Board of Directors, Audit Committee
**Effective Date**: January 1, 2026

---

_Security protects the mission. Vigilance is everyone's responsibility._

**— Mark Egly Foundation Security Team**
