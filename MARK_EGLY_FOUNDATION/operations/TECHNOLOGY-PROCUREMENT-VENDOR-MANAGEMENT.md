# Technology Procurement & Vendor Management

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Chief Operating Officer
**Purpose**: Standardized process for selecting, onboarding, monitoring, renewing, and offboarding technology vendors and SaaS providers used by the Mark Egly Foundation. Ensures value-for-money, security and privacy compliance (HIPAA where applicable), continuity, and clear accountability.

---

## Table of Contents

1. Policy Summary
2. Procurement Principles
3. Vendor Selection Lifecycle
4. Evaluation Criteria & Scorecard
5. Contracting Standards & Required Clauses
6. SaaS Subscription Management
7. License Inventory & Renewal Management
8. Onboarding & Security Assessment
9. Vendor Monitoring & Performance Management
10. Offboarding & Contract Closeout
11. Procurement Approval Matrix (RACI)
12. Templates, Checklists & Example Clauses
13. KPIs, Metrics & Reporting
14. Budget & Implementation Timeline
15. Change Log

---

## 1. Policy Summary

All technology purchases—hardware, software subscriptions, cloud services, consultants, and integrations—must follow this procurement process. Exceptions (emergency purchases) require retrospective approval by the COO and one Board designee within 72 hours.

Objectives:

- Ensure secure, cost-effective solutions aligned with mission
- Reduce vendor risk (security, privacy, financial stability)
- Track vendor contracts, licenses, renewal dates to avoid service interruptions
- Maximize nonprofit discounts and favorable commercial terms

Scope:

- Applies to all staff, contractors, volunteers who initiate or approve technology purchases
- Applies to one-time purchases and recurring subscriptions
- Thresholds: purchases <$1,000: departmental lead can approve; $1,000–$25,000: COO approval; >$25,000: Board approval required

---

## 2. Procurement Principles

- Mission-first: Technology should directly support patient services, registry growth, research, fundraising, or essential operations
- Security-first: No product handling PHI or sensitive donor financials is approved without security review and a signed BAA (if PHI involved)
- Total cost of ownership (TCO): Consider onboarding, training, integration, maintenance, and exit costs
- Vendor consolidation: Prefer vendors that reduce integration overhead and provide required functionality
- Nonprofit discounts: Always request nonprofit pricing; document responses
- Transparency: Maintain vendor register and contract repository (Google Drive restricted folder + 1Password for credentials)

---

## 3. Vendor Selection Lifecycle

1. Need Identification
   - Requester completes Technology Purchase Request form (link to form stored in operations folder). Include business justification, desired timeline, budget, integration needs.

2. Market Research
   - IT evaluates 3 vendors (where feasible): commercial leader, nonprofit-focused provider, and open-source/self-hosted alternative. Document pros/cons.

3. Security & Compliance Pre-Screen
   - Quick security check: SOC 2? HIPAA BAA available? Encryption in transit & at rest? Data residency? Subprocessors?

4. Demo & Trial
   - Vendor provides demo and 14–30 day trial where possible. Use test data or dummy records—never import PHI into trial accounts.

5. Scorecard Evaluation
   - Use vendor scorecard (section 4). Require minimum pass threshold (e.g., 70/100) for procurement

6. Contract Negotiation
   - Legal and Finance review proposed contract, negotiate key clauses (see section 5)

7. Purchase & Onboarding
   - Purchase executed per approval matrix. IT performs onboarding steps: provisioning, SSO configuration, MFA enforcement, logging enabled.

8. Ongoing Monitoring
   - Quarterly review of vendor performance, security posture, and billing

9. Renewal/Offboarding
   - At renewal window (60–90 days before expiration), review value and decide renew vs. replace

---

## 4. Evaluation Criteria & Scorecard

Score each vendor 0–5 across categories, multiply by weight, total 100 points.

- Functionality (20%): 0–20 points
- Security & Compliance (25%): 0–25 points
- Integration & APIs (15%): 0–15 points
- Usability & Training (10%): 0–10 points
- Support & SLA (10%): 0–10 points
- Cost & TCO (10%): 0–10 points
- Vendor Stability & References (10%): 0–10 points

Minimum Passing Score: 70/100

Example quick checklist:

- SOC 2 Type II report available? (Y/N)
- BAA available if handling PHI? (Y/N)
- Data export capability (CSV/API)? (Y/N)
- 24/7 support or business hours? (Which?)
- Nonprofit discount? %
- Data location: US-only or global? (Preference: US data residency for PHI)

---

## 5. Contracting Standards & Required Clauses

All vendor contracts must be reviewed by Legal (internal attorney or retained counsel). Required clauses for technology vendors:

Mandatory clauses (minimum):

- Parties & scope of services
- Term & renewal provisions (auto-renew opt-out periods)
- Fees, payment schedule, refund/cancellation terms
- Data ownership and rights (Foundation retains ownership of its data)
- Data security & privacy obligations (encryption, access controls)
- HIPAA Business Associate Agreement (if PHI is stored or processed)
- Subprocessor disclosure & approval process
- Incident notification clause (notify vendor within 24 hours of vendor-side breach affecting Foundation data)
- Right to audit / SOC 2 reports
- Termination & data return/destruction (how data returned at end of contract)
- Indemnification & liability limits (ensure vendor liability not unilaterally limited to $1 or trivial amount)
- Insurance requirements (cyber liability minimums—$1M recommended)
- Confidentiality
- Service Level Agreement (uptime % and credits)
- Export/import compliance

Negotiation tips:

- Avoid automatic multi-year auto-renew without notice—insist on 60–90 day renewal notice
- Cap price increases (no more than X% per year without mutual agreement)
- Insist on data portability (export in machine-readable formats within X days)

---

## 6. SaaS Subscription Management

Centralize all SaaS subscriptions in a single register (Google Sheet + link to contract in Drive). Fields to track:

- Vendor name
- Product name
- Primary contact (vendor rep)
- Business owner (staff owner)
- Technical owner (IT Manager)
- Annual/monthly cost
- Billing cadence
- Contract start & end date
- Auto-renew? (Y/N)
- Last security review date
- License counts & seat assignment
- Credentials stored in 1Password (shared vault)

Quarterly SaaS audit: IT Manager reviews active subscriptions (do we still use it? any duplicate functionality?). Cancel unused seats and services.

Cost optimization:

- Request nonprofit/academic discounts
- Negotiate multi-year discounts if plan to use 3+ years
- Consider annual billing (saves 10–15%) but weigh cashflow impact
- Use seat pooling and role-based access to minimize seat counts

---

## 7. License Inventory & Renewal Management

Maintain license inventory and calendar (60/30/7 day renewal reminders):

- Use Google Calendar with shared alert for IT Manager and Finance
- Add reminders: 90, 60, 30, 14, 7 days prior to renewal
- Prepare renewal review packet 60 days before renewal: usage report, support tickets, uptime, integration issues, cost vs value

Automation: Evaluate using a subscription management tool (Year 2-3, e.g., Blissfully or Zylo) when >50 subscriptions (> $20K/year total spend)

---

## 8. Onboarding & Security Assessment

Security onboarding checklist (must be completed before vendor granted production access):

- [ ] Signed contract + BAA if PHI
- [ ] SOC 2 Type II or equivalent security documentation reviewed
- [ ] Data flow diagram (what data will be transmitted/stored?)
- [ ] Access provisioning plan (RBAC roles, SSO integration, MFA required)
- [ ] Logging & audit access (can we access logs? will vendor provide access?)
- [ ] Backup & restore procedures (who owns backups?)
- [ ] Subprocessor list obtained & approved
- [ ] Penetration test results (for critical vendors) or evidence of third-party testing
- [ ] Disaster recovery & continuity plan reviewed (RTO/RPO commitments)
- [ ] Insurance certificate provided (cyber liability)

Technical configuration steps:

- Integrate with Google SSO or SAML where possible
- Enforce SSO + mandatory MFA
- Restrict IP ranges where applicable
- Configure logging to central monitoring (where supported)
- Configure data retention preferences per Foundation policies

---

## 9. Vendor Monitoring & Performance Management

Quarterly vendor review items:

- Uptime & SLA compliance
- Support ticket response times & resolution quality
- Security posture changes (SOC 2 renewals, breach disclosures)
- Billing changes and license usage
- Integration reliability (API errors, sync failures)
- Quarterly scorecard update (re-run vendor scorecard based on performance)

Escalation:

- If vendor misses SLA 2x in 90 days → formal remediation plan (30 days) or begin sourcing replacement
- If vendor experiences security breach impacting Foundation → invoke incident clause, require forensic report within 72 hours, consider suspension of service until fixed

---

## 10. Offboarding & Contract Closeout

Offboarding steps (ensure no data leakage and clean separation):

- [ ] Termination notice per contract sent by Legal/COO
- [ ] Final data export in machine-readable format (CSV, JSON) requested and verified
- [ ] Revoke vendor access (SSO accounts, API keys, support portal accounts)
- [ ] Rotate any shared credentials in 1Password
- [ ] Confirm deletion/destruction of Foundation data on vendor side (obtain certificate of destruction if high-sensitivity data)
- [ ] Final invoice paid and contract archived
- [ ] Update license inventory and cancel next billing cycle

---

## 11. Procurement Approval Matrix (RACI)

| Purchase Size  | Requester       | IT Manager | COO | CFO | Legal | Board              |
| -------------- | --------------- | ---------- | --- | --- | ----- | ------------------ |
| <$1,000        | Department Lead | I          | A   | I   | I     | I                  |
| $1,000–$25,000 | Department Lead | C          | A   | C   | C     | I                  |
| >$25,000       | Department Lead | C          | C   | C   | C     | A (Board Approval) |

Legend: R = Responsible, A = Accountable, C = Consulted, I = Informed

---

## 12. Templates, Checklists & Example Clauses

Included in operations folder (linked templates):

- Technology Purchase Request (Google Form)
- Vendor Scorecard (Google Sheet)
- Security Assessment Checklist (PDF)
- Master Service Agreement (MSA) redlineable template
- Business Associate Agreement (BAA) template for HIPAA vendors
- Data Export & Deletion Request template
- Termination notice template

Example Incident Notification Clause:
"Vendor shall notify Foundation within 24 hours of becoming aware of any security incident affecting Foundation data. Vendor shall provide weekly status updates until remediation is complete and a final incident report within 30 days."

Example Data Return Clause:
"Upon termination or expiration, Vendor will provide an export of all Foundation Data in machine-readable format within 10 business days and securely delete Foundation Data within 30 days, providing a certificate of deletion upon request."

---

## 13. KPIs, Metrics & Reporting

Operational KPIs (monthly/quarterly reporting to COO):

- Number of active vendors (aim to consolidate where possible)
- Total annual spend on SaaS & vendors
- % of vendors with SOC 2 or equivalent
- % of critical vendors with BAA / HIPAA compliance where required
- Number of SLA breaches in last 90 days
- % of subscriptions renewed with better terms (discounts obtained)

Reports:

- Quarterly vendor health report (COO to Board Audit Committee)
- Annual procurement spend analysis (Finance + COO)

---

## 14. Budget & Implementation Timeline

Year 1 (Setup): $4,000–$10,000

- Set up vendor register (Google Sheet, templates) – $0
- Legal template creation / retainer – $3,000
- Security assessment templates & staff training – $500
- Initial vendor consolidation & renegotiation savings target: 10–15% of recurring costs

Year 2 (Scale): $6,000–$20,000

- Subscription management tooling (optional) – $0–$6,000
- Dedicated procurement consultancy for large contracts – $5,000–$10,000

---

## 15. Change Log

- 1.0 — 2025-11-08 — Initial release

---

**Document Owner**: COO
**Review Frequency**: Annual (or after major procurement event)
**Last Updated**: November 8, 2025

---

_Procurement is an engine for mission delivery—managed well, it reduces risk and frees resources for patient impact._
