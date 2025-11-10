# HIPAA Implementation Playbook

**Document Version**: 1.0
**Last Updated**: November 9, 2025
**Owner**: Chief Privacy & Security Officer (CPSO) / COO
**Purpose**: Provide a practical, step-by-step implementation playbook to achieve and maintain compliance with the HIPAA Privacy, Security, and Breach Notification Rules appropriate for a small nonprofit health-related foundation that operates a patient registry, handles PHI, and works with research partners.

---

## Table of Contents

1. Executive Summary
2. Scope & Applicability
3. HIPAA Requirements Overview
4. Roles & Responsibilities
5. Risk Assessment & Gap Analysis
6. Administrative Safeguards
7. Physical Safeguards
8. Technical Safeguards
9. Policies & Procedures (Required and Recommended)
10. Business Associate Agreements (BAAs)
11. Breach Identification & Notification
12. Incident Response Playbook
13. Training & Workforce Management
14. Audit, Monitoring & Logs
15. Data Lifecycle & Retention
16. Tools & Technologies
17. Implementation Roadmap & Timeline
18. Budget Estimate (Year 1-3)
19. Templates & Checklists
20. Continuous Improvement & Governance

---

## 1. Executive Summary

This HIPAA Implementation Playbook is tailored for the Mark Egly Foundation's current operations: a patient registry (REDCap), CRM (Salesforce), Google Workspace, vendor-managed email marketing, and occasional handling of PHI in research collaborations. The goal is to implement a practical, risk-based HIPAA compliance program that provides reasonable assurances of confidentiality, integrity, and availability of protected health information (PHI), supports secure data sharing with research partners, and satisfies Business Associate obligations.

Success criteria:

- Completed HIPAA risk assessment and documented remediation plan
- BAAs in place with all vendors that handle PHI
- Implemented technical safeguards (encryption, MFA, least privilege, logging)
- Incident response and breach notification processes tested and ready
- Workforce trained and attestation of training on file for 100% of staff

---

## 2. Scope & Applicability

This playbook applies to:

- All PHI collected, stored, processed, or transmitted by the Foundation (REDCap records, attachments, scanned consent forms, communications about patients)
- All systems and storage locations that could contain PHI (cloud apps, local laptops, external drives)
- All staff, contractors, volunteers, and board members who access PHI
- All research collaborations and data-sharing arrangements where Foundation data qualifies as PHI or is subject to HIPAA rules

Not in scope: purely de-identified data that meets the HIPAA Safe Harbor or Expert Determination standard (playbook includes guidance for creating and validating de-identified datasets)

---

## 3. HIPAA Requirements Overview

High-level summary of the three core rules:

- Privacy Rule: Governs permitted uses/disclosures of PHI, patients' rights (access, accounting of disclosures, amendment), and minimum necessary principle
- Security Rule: Administrative, physical, and technical safeguards to protect e-PHI
- Breach Notification Rule: Timely notification to affected individuals, HHS OCR, and sometimes media in case of breaches

Key items for nonprofits:

- Covered Entity vs. Business Associate: Foundation may be a covered entity if it conducts treatment, payment, or health care operations; otherwise it may be a Business Associate when handling PHI on behalf of a covered entity. This playbook assumes Foundation handles PHI as a hybrid: a data steward for the registry and a BA for partner health systems—practical controls apply regardless
- Documentation: Maintain policies, risk assessments, BAAs, training records, and breach documentation for at least 6 years

---

## 4. Roles & Responsibilities

- Board: Final approver of HIPAA program, allocates budget, reviews major breaches and program health annually
- Executive Director (ED): Overall accountability, signs BAAs and decisions related to public notification
- Chief Privacy & Security Officer (CPSO) / COO: Program owner—runs risk assessments, drives remediation, points of contact for OCR, leads incident response
- IT Manager / MSP: Implements technical controls (MFA, encryption, backups), performs device management, logging
- Research Lead / Data Custodian: Ensures research agreements, DUAs, and IRB compliance; approves datasets for sharing
- HR: Tracks workforce training, attestation, background checks, access provisioning and deprovisioning
- All Staff: Follow policies, report incidents promptly

Minimal staffing: For small org, CPSO can be COO + contract MSSP (Managed Security Service Provider) + legal counsel for BAAs and breach notifications

---

## 5. Risk Assessment & Gap Analysis

Objective: Identify where PHI resides, how it's used, and associated risks.

Minimum scope for first risk assessment:

- Inventory of systems storing/transmitting PHI (REDCap projects, Salesforce objects, Google Drive folders, local laptops, backups)
- Flow diagrams showing PHI flow (collection → storage → sharing → archival)
- Threat modeling: insider threat, credential compromise, ransomware, accidental disclosure (email to wrong recipient)
- Vulnerability assessment: patching cadence, known vulnerabilities in managed services
- Likelihood & impact scoring: confidentiality, integrity, availability impacts (High/Med/Low)

Deliverables:

- Written risk assessment report (document gaps, risk scoring, recommended remediation)
- Prioritized remediation plan with owners and timelines

Recommended cadence: full risk assessment annually; light scan (targeted) quarterly

---

## 6. Administrative Safeguards

Core administrative controls to implement immediately:

- HIPAA Privacy & Security Policies: comprehensive policy manual covering minimum necessary, patient rights, workforce roles, sanctions for violations, data classification
- Risk Management Program: documented risk assessment, remediation plan, acceptance criteria
- Incident Response Plan: defined processes, escalation paths, breach notification timelines
- Workforce Training: Annual HIPAA training with role-based modules (REDCap users, admins, managers), training attestations recorded
- Access Management: Role-based access control (RBAC), least privilege, process for provisioning and deprovisioning tied to HR events
- Sanctions Policy: Progressive discipline for policy violations (verbal → written → PIP → termination for repeated or severe violations)
- Data Use & Data Sharing Agreements: DUAs for research partners that restrict permitted uses, retention, and re-identification
- Documentation & Record-Keeping: Retain policies, training, risk assessments, BAAs, breach logs for 6 years

Templates (see Section 19): policy checklist, training signoff form, risk assessment worksheet

---

## 7. Physical Safeguards

Controls to protect physical access to ePHI and workspaces:

- Office Controls: Locked server/IT closets, visitor sign-in, clean desk policy
- Device Controls: Full-disk encryption on all laptops (FileVault/BitLocker), screen lock timeout (5 min), automatic updates
- Work-from-Home: Require Foundation-issued encrypted laptops, do not store PHI on personal devices, remote wipe capability
- Media Disposal: Secure disposal policies for paper and electronic media (shredder, secure recycling vendor)

For hybrid remote work: define secure home office expectations in Remote Work Policy (already created) including Wi-Fi security standards and storage restrictions

---

## 8. Technical Safeguards

Minimum technical controls to implement (high-priority):

1. Authentication & Access Controls
   - Multi-factor authentication (MFA) on all accounts with PHI access (Google Workspace, Salesforce, REDCap, VPN)
   - Least privilege access and RBAC (admin accounts restricted, break-glass process documented)
   - SSO with account lifecycle management (Google SSO, Okta optional)

2. Encryption
   - Encryption at rest for databases and file storage (AWS S3 server-side encryption, database encryption)
   - Encryption in transit (TLS 1.2+ for all web services, enforced HTTPS)
   - Full-disk encryption for laptops

3. Audit Logging & Monitoring
   - Enable detailed logging for Salesforce, REDCap, Google Workspace (Drive, email audit logs), VPN, and servers
   - Central log collection (CloudWatch/Loggly/Splunk/ELK) or MSSP monitoring with alerting for suspicious activity

4. Integrity Controls
   - File integrity monitoring for critical configuration files, critical datasets, and backups
   - Version control for code and data processing scripts (Git with access controls)

5. Backup & Availability
   - Regular automated backups, immutable backups where possible, offsite retention (3-2-1 rule)
   - Test restoration quarterly for critical systems (REDCap projects, Salesforce backups)

6. Endpoint Protection
   - EDR (Endpoint Detection & Response) on Foundation PCs/laptops (CrowdStrike, Defender for Business)
   - Anti-malware, disk encryption, and tamper protections

7. Remote Access
   - VPN or Zero Trust (Tailscale/Cloudflare Access) for admin access to internal systems
   - Conditional access policies (MFA + device compliance for privileged actions)

8. Data Loss Prevention (DLP)
   - Email and Drive DLP rules (Google Workspace DLP) to detect PHI exfiltration patterns
   - Prevent external sharing of PHI documents and enforce pre-approved sharing workflows

---

## 9. Policies & Procedures (Required and Recommended)

Required policies (examples, templates in Section 19):

- HIPAA Privacy Policy
- HIPAA Security Policy
- Breach Notification Policy
- Access Control Policy
- Data Classification & Handling Policy
- Business Associate Management Policy
- Acceptable Use Policy
- Incident Response & Forensics Policy
- Mobile Device & Remote Work Policy (see Remote Work Policy file)
- Data Retention & Destruction Policy

Recommended policies:

- Vendor Risk Management Policy
- Encryption Policy
- Logging & Monitoring Policy
- Change Management for systems that touch PHI

Each policy must include: purpose, scope, roles & responsibilities, procedural steps, enforcement, review frequency, and document owner

---

## 10. Business Associate Agreements (BAAs)

Approach:

- Identify all vendors with potential PHI access (REDCap hosting, Salesforce, cloud backups, email marketing vendors if they access PHI, billing processors, scanning services, transcription vendors, consultants with dataset access)
- Obtain executed BAA before any PHI disclosure (vendor risk: do not rely on verbal assurances)
- Include key BAA clauses: permitted uses, security controls, breach notification obligations (timebound, e.g., notify within 48 hours), subcontractor flow-down, return/destruction of PHI, audit rights, indemnification, insurance requirements

BAA Checklist:

- Legal name and contact
- Types of PHI processed
- Security controls summary
- Subprocessor list
- Breach notification timeline
- Data return/destruction process
- Insurance minimums (cyber liability)

Template: Simple BAA for SaaS + Exhibit A security obligations

---

## 11. Breach Identification & Notification

Breach definition: unauthorized acquisition, access, use, or disclosure of PHI that compromises security or privacy, except where low probability of compromise exists (risk assessment required)

High-level process:

1. Identify & Contain (within 24 hours of detection)
2. Assess scope & risk (which PHI, number of individuals, types of identifiers)
3. Notify internally (Incident Commander, legal counsel, ED, board if large)
4. Notify OCR & Affected Individuals per timeline
   - OCR: within 60 days for breaches affecting 500+ individuals (report immediately and publish media notice)
   - For <500 individuals: log and submit annual report to OCR
5. Notify Business Associates and partners
6. Document remediation & lessons learned

Notification templates included in Section 19 (individual notification letter, media statement, HHS OCR report form guidance)

---

## 12. Incident Response Playbook

Roles:

- Incident Commander (IC): CPSO / COO
- Technical Lead: IT Manager / MSSP
- Legal Counsel: external counsel retained for PHI breaches
- Communications: ED / Communications lead
- HR: workforce issues, internal discipline
- Board notification threshold: breach affecting >1,000 individuals or ransomware with data exfiltration

Phases & timeline:

- T+0 (Detect): Security systems alert, employee reports suspicious email, or external party reports suspected breach
- T+1 (Triage, 0-4 hrs): IC convenes incident call, initial containment plan (isolate machines, revoke credentials)
- T+24 (Assessment): Complete scoping (which data, how many records), preserve evidence (disk images, logs)
- T+48-72 (Decision): Determine if notification required; begin drafting letters and media statements; contact external counsel
- T+72–14 days (Notification): Notify affected individuals, OCR (per rules), and BA partners; set up call center if necessary
- Post-Incident (30–90 days): Remediation actions, root cause analysis, policy changes, staff retraining

For ransomware: follow guidance—do not pay without legal/forensics counsel; isolate infected systems; preserve logs; assume exfiltration until proven otherwise

---

## 13. Training & Workforce Management

Minimum training program:

- All staff: Annual HIPAA Privacy & Security training (1-hour baseline) + annual attestation
- Role-based training: REDCap admins, Salesforce admins, Data Custodians have advanced security & privacy training (2–4 hours/year)
- New hire onboarding: HIPAA training within first 14 days, sign attestation
- Phishing simulations: Monthly or quarterly simulated phishing via KnowBe4 (target 3–5% click-through goal)
- Incident reporting training: "How to report" one-page quick guide pinned in Slack and onboarding materials

Documentation: maintain signed attestations in personnel file, training completion dashboard (COO tracks)

---

## 14. Audit, Monitoring & Logs

Logging requirements:

- Maintain audit logs for access to PHI (who accessed, when, what records)
- Retain logs for minimum 6 years where feasible (policy aligned)
- Monitor logs for anomalous patterns: bulk exports, privileged account activity at odd hours

Audit activities:

- Quarterly configuration and access reviews (review privileged accounts, admin access)
- Annual third-party penetration test & vulnerability scan (external pen test by certified vendor)
- Annual security control validation (verify encryption, MFA, backup integrity)
- Random data access audits (spot-check who accessed top 100 patients' records)

Reporting:

- Weekly security dashboard (open incidents, patch compliance %, MFA adoption %, backup success)
- Quarterly Board-level summary (no PHI details—high-level metrics)

---

## 15. Data Lifecycle & Retention

Lifecycle stages:

- Collection (consent capture—ensure proper authorization, consent forms stored securely)
- Use (limit to minimum necessary, track purpose)
- Sharing (DUAs, BAAs, secure transfer methods—SFTP, signed URLs, encrypted attachments)
- Archival (encrypted archives, retain per policy—e.g., research records 7 years, general patient records 6 years per state regs)
- Disposal (secure deletion, media shredding, crypto-shredding for cloud objects)

Retention schedule (example):

- Consent forms: 7 years after last contact
- Research datasets: 7–10 years per funder/IRB
- Administrative records: 6 years

---

## 16. Tools & Technologies

Recommended stack (low-cost, HIPAA-friendly for small nonprofit):

- REDCap (hosted with BAA from hosting provider)
- Salesforce (Health Cloud if budget allows) with BAA
- Google Workspace for Nonprofits (with BAA, enforce MFA and DLP rules)
- 1Password Business (secrets management, shared vaults for service accounts)
- Tailscale or Cloudflare Access (zero-trust remote access)
- EDR: Microsoft Defender for Business or CrowdStrike (small footprint)
- Backup: Veeam or vendor-managed backups with immutable snapshots
- MSSP/IR on-demand retainer (for 24/7 monitoring, incident handling)
- Pen Test vendor: third-party annual pen test and quarterly vulnerability scanning

Open-source / lower-cost options noted where appropriate; ensure vendor will sign BAA and provide SOC2/HIPAA compliance documentation

---

## 17. Implementation Roadmap & Timeline

Phase 0 — Planning (Weeks 0–4)

- Appoint CPSO/Program owner
- Inventory systems, appoint Data Custodians
- Engage external counsel and MSSP for assessment support

Phase 1 — Foundational Controls (Weeks 4–12)

- Complete initial risk assessment & gap analysis
- Execute BAAs with critical vendors (REDCap host, Salesforce, Google Workspace)
- Enforce MFA, full-disk encryption, baseline patching
- Implement least privilege and start access reviews
- Deliver workforce baseline training and attestations

Phase 2 — Technical Hardening (Months 3–6)

- Centralized logging and alerting (MSSP or SIEM lite)
- Enable DLP rules and email protections
- Configure backups and recovery testing
- Implement EDR on endpoints

Phase 3 — Operationalization (Months 6–12)

- Run tabletop incident response exercises (quarterly)
- Execute third-party penetration test and remediate
- Formalize retention and secure disposal workflows
- Implement continuous monitoring and quarterly audits

Phase 4 — Maturity (Year 2+)

- Ongoing improvement, annual risk assessments, expand to more advanced zero-trust
- Expand BAAs to additional partners, formalize IR retainer, board-level reporting cadence

---

## 18. Budget Estimate (Year 1–3)

Baseline (Year 1): $15K–$50K

- Risk assessment, MSSP initial setup: $5K–$15K
- BAAs legal review: $2K–$6K
- Technical controls (MFA, 1Password, EDR, Zero Trust): $5K–$15K
- Training & phishing simulations: $1K–$3K
- Penetration test: $2K–$5K

Year 2–3: scale to $25K–$100K depending on headcount, data volume, and maturity (SIEM, dedicated security staff, annual pen tests, increased MSSP fees)

Cost-saving tips: Use Google Workspace for Nonprofits, negotiate nonprofit discounts, stagger pen tests and large vendor spends

---

## 19. Templates & Checklists (Included)

- HIPAA Risk Assessment Worksheet (inventory + risk scoring) — fillable table
- BAA checklist + sample BAA template (SaaS and professional services variants)
- Breach Notification templates: Individual letter, OCR report outline, media statement
- Incident Response Runbook (playbook for ransomware, unauthorized access, lost/stolen device)
- Access Review Checklist (quarterly)
- Training Attestation Form
- Data Classification Matrix (PHI, limited data set, de-identified)
- Vendor Evaluation Scorecard (security controls, certifications, BAA readiness)

(Each template stored in /operations/templates/ for reuse)

---

## 20. Continuous Improvement & Governance

Governance Rhythm:

- Monthly Security Operations sync (CPSO, IT Manager, MSSP)
- Quarterly Executive review (ED, COO, CPSO) with metrics: incidents, patch compliance, MFA adoption, backup success
- Annual Board briefing (risk posture, major incidents, budget ask)

KPIs / Metrics to track:

- MFA coverage (%)
- Patch compliance (% of devices up-to-date)
- Time to detect & time to contain (MTTD, MTTC)
- Number of incidents (by severity)
- Training completion rate (%)
- BAAs executed / total vendors that need BAAs

Continuous improvement tactics:

- Post-incident reviews (root cause, remediate, update playbooks)
- Red team / blue team exercises (if budget allows)
- Regular vendor security re-evaluation and penetration testing every 12 months

---

## Conclusion

This HIPAA Implementation Playbook turns regulatory requirements into actionable steps for the Mark Egly Foundation. Start with a focused risk assessment, implement high-value technical and administrative controls (MFA, encryption, BAAs), train your workforce, and ensure robust incident response capabilities. Document all decisions and maintain a cadence of review to keep the program aligned with growth and evolving threats.

**Next Steps**: Kick off risk assessment, secure BAAs with REDCap + Google, enable MFA across accounts, and schedule the first tabletop incident response exercise within 90 days.

---

**Document Owner**: CPSO / COO
**Review Frequency**: Annual (or after any material incident)
**Last Updated**: November 9, 2025
**Next Review**: January 2026

---

**Questions?** Contact CPSO at security@markeglyfoundation.org
