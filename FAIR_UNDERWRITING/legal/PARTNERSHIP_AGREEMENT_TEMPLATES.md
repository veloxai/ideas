# Fair Underwriting - Partnership Agreement Templates

**Last Updated**: November 7, 2025
**Purpose**: Legal framework for insurance partner relationships
**Status**: Template Library for Contract Negotiations

---

## Executive Summary

This document provides **template agreements** and **negotiation guidance** for Fair Underwriting's partnerships with insurance companies. These templates are **starting points** — each partnership will require customization based on partner size, scope, regulatory requirements, and commercial terms.

**Document Structure**:

1. **Master Services Agreement (MSA)** — Overarching partnership framework
2. **Business Associate Agreement (BAA)** — HIPAA compliance (if applicable)
3. **Data Processing Agreement (DPA)** — Privacy and data protection
4. **Laboratory Services Agreement (LSA)** — With Quest/LabCorp
5. **Statement of Work (SOW)** — Pilot-specific deliverables
6. **Negotiation Playbook** — Term sheets, redlines, common objections

---

## Section 1: Master Services Agreement (MSA)

### 1.1 MSA Overview

**Purpose**: Primary contract governing Fair Underwriting ↔ Insurance Partner relationship

**Key Terms**:

- **Services**: Genetic testing, counseling, portal access, support
- **Pricing**: Per-test fees, subscription fees, platform fees
- **Term**: Initial term (1-3 years), renewal options
- **IP**: Fair Underwriting retains IP, partner receives license
- **Liability**: Caps, indemnification, insurance requirements
- **Termination**: Conditions, notice periods, wind-down

---

### 1.2 MSA Template (Annotated)

```
MASTER SERVICES AGREEMENT

This Master Services Agreement ("Agreement") is entered into as of [DATE] ("Effective Date")
by and between:

Fair Underwriting, Inc., a Delaware corporation with principal place of business at [ADDRESS]
("Fair Underwriting" or "Provider"),

and

[PARTNER NAME], a [STATE] [corporation/mutual company] with principal place of business at [ADDRESS]
("Partner" or "Customer").

WHEREAS, Provider offers genetic testing and wellness services;
WHEREAS, Partner desires to offer such services to its policyholders;

NOW, THEREFORE, in consideration of the mutual covenants and agreements hereinafter set forth
and for other good and valuable consideration, the receipt and sufficiency of which are hereby
acknowledged, the parties agree as follows:

───────────────────────────────────────────────────────────────────────
1. SERVICES
───────────────────────────────────────────────────────────────────────

1.1 Services Provided. Provider shall provide the following services ("Services") to Partner's
policyholders ("Eligible Members"):

    (a) Genetic Testing: SERPINA1 genotyping and alpha-1 antitrypsin serum level testing
        via CLIA/CAP-certified laboratory partners (Quest Diagnostics or LabCorp).

    (b) Genetic Counseling: Access to licensed genetic counselors for Eligible Members with
        clinically significant results (MZ, SZ, ZZ genotypes).

    (c) Web Portal: Secure online portal for enrollment, education, results viewing, and
        counseling scheduling.

    (d) Customer Support: Email, live chat, and phone support during business hours
        (9am-5pm ET, Monday-Friday).

    (e) Reporting: Monthly reports to Partner on enrollment, testing, and outcomes metrics.

1.2 Service Levels. Provider shall use commercially reasonable efforts to:
    (a) Maintain portal uptime of 99.5% (excluding scheduled maintenance).
    (b) Deliver test results within 14 business days of lab receipt of sample.
    (c) Schedule genetic counseling within 48 hours of result delivery for urgent cases
        (ZZ, SZ genotypes), 7 days for standard cases (MZ genotype).
    (d) Respond to customer support inquiries within 24 business hours.

1.3 Partner Responsibilities. Partner shall:
    (a) Provide access to Eligible Members (email lists, portal integration, marketing support).
    (b) Approve co-branded marketing materials (within 10 business days of submission).
    (c) Provide technical support for SSO integration (SAML or OAuth).
    (d) Pay fees as set forth in Section 3.

───────────────────────────────────────────────────────────────────────
2. TERM AND TERMINATION
───────────────────────────────────────────────────────────────────────

2.1 Initial Term. This Agreement shall commence on the Effective Date and continue for an
initial term of [1/2/3] year(s) ("Initial Term"), unless earlier terminated as provided herein.

2.2 Renewal. This Agreement shall automatically renew for successive [1-year] periods
("Renewal Terms") unless either party provides written notice of non-renewal at least
[90/180] days prior to the end of the then-current term.

2.3 Termination for Convenience. Either party may terminate this Agreement for any reason
upon [180] days' prior written notice.

2.4 Termination for Cause. Either party may terminate this Agreement immediately upon
written notice if:
    (a) The other party materially breaches this Agreement and fails to cure within [30] days
        of written notice; or
    (b) The other party becomes insolvent, files for bankruptcy, or ceases business operations.

2.5 Effect of Termination.
    (a) Partner shall pay all fees for Services rendered prior to termination date.
    (b) Eligible Members who have enrolled but not yet received results shall be permitted
        to complete testing and receive results for [90] days post-termination.
    (c) Provider shall provide Partner with final report within [30] days of termination.
    (d) Sections 4 (Intellectual Property), 5 (Confidentiality), 7 (Limitation of Liability),
        and 8 (General Provisions) shall survive termination.

───────────────────────────────────────────────────────────────────────
3. FEES AND PAYMENT
───────────────────────────────────────────────────────────────────────

3.1 Fees. Partner shall pay Provider the following fees:

    (a) Per-Test Fee: $[75-150] per Eligible Member tested (includes genetic test, AAT level,
        genetic counseling if applicable, portal access, and customer support).
        [NOTE: Pricing varies based on volume commitments and partner size.]

    (b) Subscription Fee (optional, Year 2+): $[10-30] per Eligible Member per year for
        annual AAT monitoring, ongoing portal access, and counseling as needed.

    (c) Platform Fee (optional, for large partners): $[50K-200K] per year for API access,
        custom integrations, and white-label portal.

    (d) Setup Fee (if applicable): $[10K-50K] one-time fee for SSO integration, custom
        branding, and partner training.

3.2 Invoicing and Payment. Provider shall invoice Partner monthly in arrears for Services
rendered. Payment is due within [30] days of invoice date. Late payments shall accrue interest
at [1.5%] per month or the maximum rate permitted by law, whichever is less.

3.3 Taxes. Fees are exclusive of all taxes. Partner shall be responsible for all sales, use,
excise, VAT, and other taxes (excluding Provider's income taxes).

───────────────────────────────────────────────────────────────────────
4. INTELLECTUAL PROPERTY
───────────────────────────────────────────────────────────────────────

4.1 Provider IP. Provider retains all right, title, and interest in and to:
    (a) The Fair Underwriting platform, portal, software, and technology;
    (b) All patents, including US Patent No. 20220165374 ("Privacy Framework Patent");
    (c) Trade secrets, algorithms, and know-how;
    (d) Trademarks, trade names, and branding ("Fair Underwriting," logos, etc.).

4.2 License to Partner. Provider grants Partner a limited, non-exclusive, non-transferable,
non-sublicensable license to access and use the Fair Underwriting platform solely for the
purpose of providing Services to Eligible Members during the term of this Agreement.

4.3 Partner Marks. Partner grants Provider a limited license to use Partner's name, logo,
and trademarks solely for co-branded marketing materials and public references to the
partnership (e.g., "Fair Underwriting partners with [Partner Name]"), subject to Partner's
prior written approval (not to be unreasonably withheld).

4.4 No Ownership Transfer. Nothing in this Agreement transfers ownership of any intellectual
property from one party to the other.

───────────────────────────────────────────────────────────────────────
5. CONFIDENTIALITY
───────────────────────────────────────────────────────────────────────

5.1 Definition. "Confidential Information" means all non-public information disclosed by one
party ("Disclosing Party") to the other ("Receiving Party"), including but not limited to
business plans, customer data, pricing, technical specifications, and trade secrets.

5.2 Obligations. Receiving Party shall:
    (a) Maintain Confidential Information in strict confidence;
    (b) Use Confidential Information solely to perform obligations under this Agreement;
    (c) Limit disclosure to employees/contractors with need-to-know and bound by confidentiality;
    (d) Protect Confidential Information using at least same degree of care as for own info
        (but no less than reasonable care).

5.3 Exceptions. Confidential Information does not include information that:
    (a) Is or becomes publicly available through no breach by Receiving Party;
    (b) Was rightfully known to Receiving Party prior to disclosure;
    (c) Is independently developed by Receiving Party without use of Confidential Information;
    (d) Is rightfully received from a third party without breach.

5.4 Required Disclosure. If Receiving Party is legally compelled to disclose Confidential
Information (e.g., court order, subpoena), it shall: (a) promptly notify Disclosing Party;
(b) cooperate with Disclosing Party's efforts to obtain protective order; and (c) disclose
only minimum information required.

5.5 Return of Confidential Information. Upon termination or request, Receiving Party shall
return or destroy all Confidential Information (except as required by law or for archival
backup purposes).

───────────────────────────────────────────────────────────────────────
6. DATA PRIVACY AND SECURITY
───────────────────────────────────────────────────────────────────────

6.1 Personal Information. "Personal Information" means individually identifiable information
about Eligible Members, including name, contact information, genetic data, and health
information.

6.2 Data Ownership. Personal Information is owned by the Eligible Member, not by Provider or
Partner. Eligible Members grant Provider a limited license to process Personal Information
solely to provide Services.

6.3 Privacy Framework (Patent-Protected). Provider's privacy framework (US Patent 20220165374)
ensures that:
    (a) Eligible Members' genetic results are NOT shared with Partner (insurer);
    (b) Partner receives only aggregate, de-identified data (enrollment metrics, MZ detection
        counts, NPS scores);
    (c) Eligible Members may voluntarily share results with healthcare providers but are NOT
        required to share with Partner.

6.4 HIPAA Compliance (if applicable). If Partner is a Covered Entity under HIPAA, parties
shall execute a Business Associate Agreement (BAA) as set forth in Exhibit A, which is
incorporated herein by reference.

6.5 Data Processing Agreement (if applicable). If EU General Data Protection Regulation (GDPR)
or California Consumer Privacy Act (CCPA) applies, parties shall execute a Data Processing
Agreement (DPA) as set forth in Exhibit B.

6.6 Data Security. Provider shall implement administrative, physical, and technical safeguards
to protect Personal Information, including:
    (a) Encryption at rest (AES-256) and in transit (TLS 1.3);
    (b) Access controls (role-based, multi-factor authentication);
    (c) Audit logging (all access to Personal Information logged and retained 7 years);
    (d) Annual security risk assessments;
    (e) Incident response plan.

6.7 Data Breach Notification. In the event of a data breach involving Personal Information,
Provider shall notify Partner within [48] hours and provide:
    (a) Description of breach (what, when, how);
    (b) Personal Information affected;
    (c) Steps taken to mitigate;
    (d) Assistance with regulatory notifications (HIPAA Breach Notification, state laws).

───────────────────────────────────────────────────────────────────────
7. REPRESENTATIONS, WARRANTIES, AND DISCLAIMERS
───────────────────────────────────────────────────────────────────────

7.1 Mutual Representations. Each party represents and warrants that:
    (a) It is duly organized, validly existing, and in good standing;
    (b) It has full power and authority to enter into and perform this Agreement;
    (c) This Agreement does not conflict with any other agreement or obligation.

7.2 Provider Warranties. Provider warrants that:
    (a) Services shall be performed in a professional, workmanlike manner consistent with
        industry standards;
    (b) Laboratory partners (Quest, LabCorp) are CLIA/CAP-certified;
    (c) Genetic counselors are licensed and credentialed;
    (d) Platform shall substantially conform to documentation provided to Partner.

7.3 DISCLAIMER. EXCEPT AS EXPRESSLY PROVIDED HEREIN, PROVIDER MAKES NO WARRANTIES, EXPRESS
OR IMPLIED, INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
OR NON-INFRINGEMENT. PROVIDER DOES NOT WARRANT THAT SERVICES WILL BE ERROR-FREE, UNINTERRUPTED,
OR MEET PARTNER'S REQUIREMENTS.

7.4 No Medical Advice. Provider is a testing and wellness service, not a healthcare provider.
Services do not constitute medical advice, diagnosis, or treatment. Eligible Members are
advised to consult healthcare providers for medical decisions.

───────────────────────────────────────────────────────────────────────
8. LIMITATION OF LIABILITY
───────────────────────────────────────────────────────────────────────

8.1 Cap on Liability. EXCEPT FOR SECTION 8.2 (EXCLUDED CLAIMS), EACH PARTY'S TOTAL LIABILITY
ARISING OUT OF OR RELATED TO THIS AGREEMENT SHALL NOT EXCEED THE TOTAL FEES PAID OR PAYABLE
BY PARTNER TO PROVIDER IN THE [12] MONTHS PRECEDING THE CLAIM.

8.2 Excluded Claims. The liability cap in Section 8.1 does NOT apply to:
    (a) Breaches of confidentiality (Section 5);
    (b) Breaches of data security (Section 6);
    (c) Infringement of intellectual property (Section 4);
    (d) Gross negligence or willful misconduct;
    (e) Indemnification obligations (Section 9).

8.3 Consequential Damages. EXCEPT FOR EXCLUDED CLAIMS, NEITHER PARTY SHALL BE LIABLE FOR
INDIRECT, INCIDENTAL, CONSEQUENTIAL, SPECIAL, OR PUNITIVE DAMAGES (INCLUDING LOST PROFITS,
LOST REVENUE, OR LOST DATA), EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

───────────────────────────────────────────────────────────────────────
9. INDEMNIFICATION
───────────────────────────────────────────────────────────────────────

9.1 Provider Indemnification. Provider shall defend, indemnify, and hold harmless Partner
from and against any third-party claims, damages, and costs (including reasonable attorneys'
fees) arising from:
    (a) Provider's breach of this Agreement;
    (b) Provider's gross negligence or willful misconduct;
    (c) Infringement of third-party IP by Provider's technology (excluding Partner's misuse);
    (d) Violation of applicable laws by Provider.

9.2 Partner Indemnification. Partner shall defend, indemnify, and hold harmless Provider
from and against any third-party claims, damages, and costs arising from:
    (a) Partner's breach of this Agreement;
    (b) Partner's gross negligence or willful misconduct;
    (c) Partner's misuse of Services;
    (d) Claims by Eligible Members related to Partner's actions (e.g., marketing, enrollment).

9.3 Indemnification Procedures. Indemnified party shall: (a) promptly notify indemnifying
party of claim; (b) cooperate with defense; (c) allow indemnifying party to control defense
and settlement (provided settlement does not admit liability on behalf of indemnified party
or impose obligations without consent).

───────────────────────────────────────────────────────────────────────
10. INSURANCE
───────────────────────────────────────────────────────────────────────

10.1 Provider Insurance. Provider shall maintain, at its own expense, the following insurance:
    (a) General Liability: $2M per occurrence, $5M aggregate;
    (b) Professional Liability (E&O): $2M per claim, $5M aggregate;
    (c) Cyber Liability: $5M per incident, $10M aggregate;
    (d) Workers' Compensation: Statutory limits.

10.2 Certificates of Insurance. Provider shall provide Partner with certificates of insurance
evidencing the coverages above, naming Partner as additional insured (except for Professional
Liability and Workers' Compensation).

───────────────────────────────────────────────────────────────────────
11. GENERAL PROVISIONS
───────────────────────────────────────────────────────────────────────

11.1 Governing Law. This Agreement shall be governed by the laws of the State of [DELAWARE/
PARTNER'S STATE], without regard to conflicts of law principles.

11.2 Dispute Resolution.
    (a) Negotiation: Parties shall attempt to resolve disputes through good-faith negotiation
        for [30] days.
    (b) Mediation: If negotiation fails, parties shall mediate dispute with mutually agreed
        mediator (costs split 50/50).
    (c) Arbitration (optional): If mediation fails, disputes shall be resolved by binding
        arbitration under AAA Commercial Arbitration Rules in [CITY, STATE]. Judgment on
        arbitration award may be entered in any court of competent jurisdiction.
    [NOTE: Arbitration is optional; some partners prefer litigation in court.]

11.3 Publicity. Neither party shall issue press releases or public statements regarding this
Agreement without prior written consent of the other party, except as required by law.

11.4 Entire Agreement. This Agreement, including all Exhibits, constitutes the entire agreement
between parties and supersedes all prior agreements, understandings, and representations.

11.5 Amendments. This Agreement may be amended only by written instrument signed by both parties.

11.6 Assignment. Neither party may assign this Agreement without prior written consent of the
other, except: (a) to an affiliate; or (b) in connection with merger, acquisition, or sale of
substantially all assets. This Agreement shall bind and inure to the benefit of successors and
permitted assigns.

11.7 Severability. If any provision is held invalid or unenforceable, the remaining provisions
shall remain in full force and effect.

11.8 Waiver. Failure to enforce any provision shall not constitute a waiver of future enforcement.

11.9 Force Majeure. Neither party shall be liable for failure to perform due to events beyond
reasonable control (acts of God, war, terrorism, pandemics, government actions, strikes, etc.),
provided the affected party: (a) promptly notifies the other party; and (b) resumes performance
as soon as reasonably practicable.

11.10 Independent Contractors. Parties are independent contractors, not partners, agents, or
joint venturers.

11.11 Notices. All notices shall be in writing and delivered to addresses below, deemed effective
upon receipt:

Fair Underwriting, Inc.
[ADDRESS]
Attn: [CEO NAME]
Email: [EMAIL]

[PARTNER NAME]
[ADDRESS]
Attn: [CMO/WELLNESS VP NAME]
Email: [EMAIL]

11.12 Counterparts. This Agreement may be executed in counterparts (including electronic/PDF
signatures), each deemed an original, all together constituting one agreement.

IN WITNESS WHEREOF, the parties have executed this Agreement as of the Effective Date.

FAIR UNDERWRITING, INC.                    [PARTNER NAME]

By: _________________________              By: _________________________
Name: [CEO NAME]                           Name: [AUTHORIZED SIGNATORY]
Title: Chief Executive Officer             Title: [TITLE]
Date: _______________________              Date: _______________________
```

---

## Section 2: Business Associate Agreement (BAA)

### 2.1 BAA Overview

**Purpose**: HIPAA compliance when Partner is a Covered Entity (e.g., health insurer)

**When Required**: If Partner is subject to HIPAA and Fair Underwriting will access Protected Health Information (PHI)

**Key Terms**:

- **PHI Definition**: Name, contact info, health info, genetic data
- **Permitted Uses**: Only to provide Services
- **Safeguards**: Administrative, physical, technical (encryption, access controls)
- **Breach Notification**: Report breaches within 48 hours
- **Termination**: Partner may terminate if Fair Underwriting breaches BAA

---

### 2.2 BAA Template (Short Form)

```
BUSINESS ASSOCIATE AGREEMENT (BAA)

This Business Associate Agreement ("BAA") is entered into as of [DATE] and is incorporated
into the Master Services Agreement dated [MSA DATE] ("Agreement") between [PARTNER NAME]
("Covered Entity") and Fair Underwriting, Inc. ("Business Associate").

───────────────────────────────────────────────────────────────────────
1. DEFINITIONS
───────────────────────────────────────────────────────────────────────

Capitalized terms not defined herein have the meanings set forth in the Agreement or in HIPAA
(45 CFR Parts 160 and 164).

"Protected Health Information" or "PHI" means individually identifiable health information
transmitted or maintained by Business Associate on behalf of Covered Entity, including genetic
test results, AAT levels, and related health data.

───────────────────────────────────────────────────────────────────────
2. PERMITTED USES AND DISCLOSURES OF PHI
───────────────────────────────────────────────────────────────────────

2.1 Permitted Uses. Business Associate may use PHI solely to perform Services as set forth
in the Agreement.

2.2 Permitted Disclosures. Business Associate may disclose PHI only to:
    (a) Eligible Members (the individuals to whom the PHI relates);
    (b) Laboratory partners (Quest, LabCorp) as necessary to perform genetic testing;
    (c) Genetic counselors as necessary to provide counseling services;
    (d) Subcontractors who agree in writing to same restrictions as Business Associate (BAA).

2.3 Prohibited Uses. Business Associate shall NOT:
    (a) Use or disclose PHI for underwriting, rate-setting, or policy determinations;
    (b) Share PHI with Covered Entity (insurer) except as required by law or with individual's
        written authorization;
    (c) Sell PHI to third parties.

───────────────────────────────────────────────────────────────────────
3. SAFEGUARDS
───────────────────────────────────────────────────────────────────────

Business Associate shall implement administrative, physical, and technical safeguards to
prevent use or disclosure of PHI other than as permitted herein, including:

(a) Encryption: AES-256 at rest, TLS 1.3 in transit;
(b) Access Controls: Role-based, multi-factor authentication, least privilege;
(c) Audit Logging: All PHI access logged and retained 7 years;
(d) Security Risk Assessment: Annual assessment per HIPAA Security Rule;
(e) Workforce Training: HIPAA training for all employees with PHI access;
(f) Business Associate Agreements: Executed with all subcontractors handling PHI.

───────────────────────────────────────────────────────────────────────
4. BREACH NOTIFICATION
───────────────────────────────────────────────────────────────────────

4.1 Breach Discovery. Business Associate shall report any breach of unsecured PHI to Covered
Entity within 48 hours of discovery.

4.2 Breach Report. Report shall include: (a) description of breach; (b) PHI involved;
(c) individuals affected; (d) mitigation steps taken; (e) contact information.

4.3 Investigation and Mitigation. Business Associate shall: (a) investigate breach;
(b) mitigate harmful effects; (c) document investigation; (d) cooperate with Covered Entity's
breach response.

───────────────────────────────────────────────────────────────────────
5. INDIVIDUAL RIGHTS
───────────────────────────────────────────────────────────────────────

Business Associate shall, to the extent required by HIPAA:

(a) Access: Provide individuals with access to their PHI within 30 days of request;
(b) Amendment: Amend PHI as directed by Covered Entity (within 60 days);
(c) Accounting of Disclosures: Provide accounting of PHI disclosures (within 60 days);
(d) Restrictions: Honor requests for restrictions as directed by Covered Entity.

───────────────────────────────────────────────────────────────────────
6. TERM AND TERMINATION
───────────────────────────────────────────────────────────────────────

6.1 Term. This BAA is effective as of the date first written above and shall terminate upon
termination of the Agreement.

6.2 Termination for Breach. If Covered Entity determines that Business Associate has breached
a material term of this BAA, Covered Entity may:
    (a) Provide opportunity for Business Associate to cure breach (within 30 days); or
    (b) Immediately terminate Agreement if cure is not feasible.

6.3 Effect of Termination. Upon termination, Business Associate shall:
    (a) Return or destroy all PHI received from or created for Covered Entity;
    (b) Retain no copies of PHI (except as required by law or for archival backup);
    (c) Ensure subcontractors return or destroy PHI.

───────────────────────────────────────────────────────────────────────
7. MISCELLANEOUS
───────────────────────────────────────────────────────────────────────

7.1 Regulatory Changes. Parties agree to amend this BAA to comply with changes in HIPAA or
other applicable privacy laws.

7.2 Interpretation. In the event of conflict between BAA and Agreement, BAA controls with
respect to PHI.

7.3 Survival. Sections 3 (Safeguards), 4 (Breach Notification), and 6.3 (Effect of Termination)
survive termination.

IN WITNESS WHEREOF, parties have executed this BAA as of the date first written above.

FAIR UNDERWRITING, INC.                    [PARTNER NAME]

By: _________________________              By: _________________________
Name: [CEO NAME]                           Name: [AUTHORIZED SIGNATORY]
Title: CEO                                 Title: [TITLE]
```

---

## Section 3: Data Processing Agreement (DPA)

### 3.1 DPA Overview

**Purpose**: Privacy compliance for GDPR (EU), CCPA (California), and other data protection laws

**When Required**: If Fair Underwriting processes Personal Data of EU residents (GDPR) or California residents (CCPA)

**Key Terms**:

- **Roles**: Partner = Data Controller, Fair Underwriting = Data Processor
- **Permitted Processing**: Only per Partner's instructions
- **Data Subject Rights**: Access, deletion, portability, etc.
- **Sub-Processors**: Must be approved by Partner
- **Data Transfer**: Standard Contractual Clauses (if EU data)

---

### 3.2 DPA Template (Short Form)

```
DATA PROCESSING AGREEMENT (DPA)

This Data Processing Agreement ("DPA") is entered into as of [DATE] and is incorporated into
the Master Services Agreement dated [MSA DATE] ("Agreement") between [PARTNER NAME]
("Controller") and Fair Underwriting, Inc. ("Processor").

───────────────────────────────────────────────────────────────────────
1. DEFINITIONS
───────────────────────────────────────────────────────────────────────

"Personal Data" means information relating to an identified or identifiable natural person
("Data Subject"), including name, email, genetic data, and health information.

"Processing" means any operation performed on Personal Data, including collection, storage,
use, disclosure, and deletion.

"Data Protection Laws" means GDPR (EU Regulation 2016/679), CCPA (California Civil Code
§1798.100 et seq.), and other applicable privacy laws.

───────────────────────────────────────────────────────────────────────
2. SCOPE AND INSTRUCTIONS
───────────────────────────────────────────────────────────────────────

2.1 Scope. Processor shall process Personal Data solely to provide Services as set forth in
the Agreement.

2.2 Processing Instructions. Processor shall process Personal Data only on documented
instructions from Controller (via Agreement, Statement of Work, or written instructions).

2.3 No Prohibited Processing. Processor shall NOT process Personal Data for its own purposes
or disclose to third parties (except as authorized by Controller or required by law).

───────────────────────────────────────────────────────────────────────
3. SUB-PROCESSORS
───────────────────────────────────────────────────────────────────────

3.1 Authorized Sub-Processors. Processor may engage the following sub-processors to process
Personal Data:
    (a) AWS (cloud hosting);
    (b) Cloudflare (CDN);
    (c) Quest Diagnostics / LabCorp (laboratory testing);
    (d) [Genetic Counseling Firm] (genetic counseling).

3.2 Sub-Processor Obligations. Processor shall: (a) execute written agreement with each
sub-processor imposing same data protection obligations as this DPA; (b) remain liable for
sub-processor's acts/omissions.

3.3 New Sub-Processors. Processor shall notify Controller of any new sub-processors at least
30 days prior to engagement. Controller may object on reasonable data protection grounds.

───────────────────────────────────────────────────────────────────────
4. DATA SECURITY
───────────────────────────────────────────────────────────────────────

Processor shall implement technical and organizational measures to ensure a level of security
appropriate to the risk, including:

(a) Encryption: AES-256 at rest, TLS 1.3 in transit;
(b) Access Controls: Role-based, MFA, least privilege;
(c) Audit Logging: All Personal Data access logged;
(d) Security Assessments: Annual risk assessments, penetration testing;
(e) Incident Response: Plan to detect, investigate, and respond to breaches;
(f) Confidentiality: All personnel processing Personal Data bound by confidentiality.

───────────────────────────────────────────────────────────────────────
5. DATA SUBJECT RIGHTS
───────────────────────────────────────────────────────────────────────

5.1 Assistance. Processor shall assist Controller in responding to Data Subject requests:
    (a) Access: Provide Data Subject's Personal Data within 30 days;
    (b) Rectification: Correct inaccurate Personal Data;
    (c) Erasure ("Right to be Forgotten"): Delete Personal Data unless legal basis to retain;
    (d) Portability: Provide Personal Data in machine-readable format;
    (e) Objection/Restriction: Cease or limit processing as directed.

5.2 Timeframe. Processor shall respond to Controller's requests within 15 days (or sooner if
required by law).

───────────────────────────────────────────────────────────────────────
6. DATA BREACH NOTIFICATION
───────────────────────────────────────────────────────────────────────

6.1 Notification. Processor shall notify Controller of any Personal Data breach within 48
hours of discovery.

6.2 Breach Details. Notification shall include: (a) nature of breach; (b) Personal Data
affected; (c) likely consequences; (d) mitigation measures taken/proposed.

6.3 Cooperation. Processor shall cooperate with Controller's investigation and provide
information necessary for Controller to notify regulators/Data Subjects as required by Data
Protection Laws.

───────────────────────────────────────────────────────────────────────
7. DATA RETENTION AND DELETION
───────────────────────────────────────────────────────────────────────

7.1 Retention Period. Processor shall retain Personal Data only as long as necessary to
perform Services or as required by law.

7.2 Deletion. Upon termination of Agreement or upon Controller's request, Processor shall
delete or return all Personal Data within 90 days, except:
    (a) Personal Data required by law to retain (e.g., audit logs—7 years); or
    (b) Backup copies retained for disaster recovery (deleted per normal backup retention
        cycle—90 days).

───────────────────────────────────────────────────────────────────────
8. AUDITS AND INSPECTIONS
───────────────────────────────────────────────────────────────────────

8.1 Audit Rights. Controller may audit Processor's compliance with this DPA once per year
upon 30 days' notice.

8.2 Audit Process. Audit may be conducted by Controller or third-party auditor (bound by
confidentiality). Processor shall provide reasonable assistance (access to personnel,
documentation, systems).

8.3 Audit Costs. Controller bears audit costs unless audit reveals material non-compliance,
in which case Processor bears costs.

8.4 SOC 2 Reports. In lieu of audit, Processor may provide annual SOC 2 Type II report.

───────────────────────────────────────────────────────────────────────
9. INTERNATIONAL DATA TRANSFERS
───────────────────────────────────────────────────────────────────────

9.1 Standard Contractual Clauses (SCC). If Personal Data is transferred from EU to US,
parties shall execute Standard Contractual Clauses approved by European Commission (Module 2:
Controller-to-Processor). [NOTE: SCCs are separate document, incorporated by reference.]

9.2 Data Localization. If required by Controller, Processor shall store Personal Data in
specific geographic locations (e.g., EU-only data centers).

───────────────────────────────────────────────────────────────────────
10. TERM AND TERMINATION
───────────────────────────────────────────────────────────────────────

10.1 Term. This DPA is effective as of the date first written above and shall terminate upon
termination of the Agreement.

10.2 Survival. Sections 4 (Data Security), 6 (Breach Notification), 7 (Data Retention),
and 8 (Audits) survive termination for statutory limitation periods.

IN WITNESS WHEREOF, parties have executed this DPA as of the date first written above.

FAIR UNDERWRITING, INC.                    [PARTNER NAME]

By: _________________________              By: _________________________
Name: [CEO NAME]                           Name: [AUTHORIZED SIGNATORY]
Title: CEO                                 Title: [TITLE]
```

---

## Section 4: Laboratory Services Agreement (LSA) Template

[NOTE: This is Fair Underwriting ↔ Lab (Quest/LabCorp), not Partner-facing, but included for completeness.]

**Key Terms**:

- **Testing Services**: SERPINA1 genotyping, AAT serum level
- **Pricing**: $25-40 per test (volume discounts)
- **Turnaround Time**: 7-14 days from sample receipt
- **Quality**: CLIA/CAP-certified, 99.9% accuracy
- **Sample Handling**: Chain of custody, proper storage/transport
- **Liability**: Lab liable for testing errors, Fair Underwriting liable for sample collection errors

**Negotiation Tips**:

- Start with Quest (larger, more infrastructure), use LabCorp as backup/leverage
- Negotiate volume discounts (tiered: <1K tests/year, 1K-10K, 10K-100K, >100K)
- Ensure exclusivity is NOT required (maintain flexibility to switch labs)
- Include performance penalties for missed turnaround times (e.g., 10% fee reduction if >10% of results late)

---

## Section 5: Statement of Work (SOW) for Pilots

### 5.1 SOW Overview

**Purpose**: Pilot-specific deliverables, timeline, and pricing (supplements MSA)

**When Used**: For each pilot partner (1-year pilot before full-scale deployment)

**Key Sections**:

- Project Overview
- Scope and Deliverables
- Timeline
- Pricing
- Success Metrics

---

### 5.2 SOW Template

```
STATEMENT OF WORK (SOW)
Pilot Program: [PARTNER NAME]

This Statement of Work ("SOW") is entered into as of [DATE] under the Master Services Agreement
dated [MSA DATE] ("Agreement") between [PARTNER NAME] ("Partner") and Fair Underwriting, Inc.
("Provider").

───────────────────────────────────────────────────────────────────────
1. PROJECT OVERVIEW
───────────────────────────────────────────────────────────────────────

Partner engages Provider to conduct a pilot program to offer genetic testing and wellness
services to [500-1,500] Eligible Members.

Pilot Duration: [6-12] months from Launch Date
Launch Date (target): [DATE]

───────────────────────────────────────────────────────────────────────
2. SCOPE AND DELIVERABLES
───────────────────────────────────────────────────────────────────────

Provider shall deliver:

2.1 Technology Platform
    - Web portal (enrollment, education, results, counseling scheduling)
    - Partner dashboard (real-time analytics)
    - SSO integration (SAML or OAuth)
    - Data feeds (optional: enrollment/results data → Partner system)

2.2 Clinical Services
    - SERPINA1 genetic testing + AAT serum level
    - Genetic counseling (30-45 min for MZ/SZ/ZZ carriers)
    - Specialist referrals (if needed for severe AATD)

2.3 Customer Support
    - Email, live chat, phone support (9am-5pm ET, M-F)
    - FAQ documentation, instructional videos

2.4 Marketing Materials
    - Co-branded email templates (3-5 emails for enrollment campaign)
    - Landing page (education + enrollment)
    - FAQ document
    - Instructional video (how to collect sample)

2.5 Reporting
    - Weekly enrollment reports (# enrolled, demographics, drop-off analysis)
    - Monthly results reports (# tested, MZ/SZ/ZZ detections, counseling completion, NPS)
    - Final pilot report (comprehensive analysis + case study draft)

───────────────────────────────────────────────────────────────────────
3. TIMELINE
───────────────────────────────────────────────────────────────────────

Month 1-2: Onboarding
    - Contract execution
    - Kickoff meeting
    - Technical integration (SSO, dashboard, data feeds)
    - Partner team training
    - Marketing materials development

Month 3: Launch Preparation
    - Co-branded materials finalized
    - Email list provided by Partner
    - Pre-launch testing (UAT)
    - Launch date confirmed

Month 4-6: Enrollment Phase
    - Marketing campaign launch
    - Customer enrollment (target: [500-1,500] enrollments)
    - Weekly reporting to Partner

Month 5-8: Testing Phase
    - Sample collection (at-home kits or lab visits)
    - Lab processing (7-14 days)
    - Results delivery
    - Genetic counseling
    - Monthly reporting to Partner

Month 9 (or Month 12): Wrap-Up
    - Final pilot report
    - Case study development (Partner collaboration)
    - Lessons learned debrief
    - Renewal discussion

───────────────────────────────────────────────────────────────────────
4. PRICING
───────────────────────────────────────────────────────────────────────

4.1 Per-Test Fee: $[75-100] per Eligible Member tested
    (includes genetic test, AAT level, genetic counseling if applicable, portal access,
    customer support)

4.2 Setup Fee (if applicable): $[10K-25K] one-time fee for SSO integration, custom branding,
    and partner training.

4.3 Total Estimated Cost:
    - Assuming [500-1,500] tests: $[37.5K-150K] (test fees)
    - Setup fee (if applicable): $[10K-25K]
    - **Total: $[47.5K-175K]**

4.4 Invoicing: Provider shall invoice Partner monthly in arrears. Payment due within 30 days.

───────────────────────────────────────────────────────────────────────
5. SUCCESS METRICS
───────────────────────────────────────────────────────────────────────

Pilot success shall be measured by:

- Enrollment Rate: Target [5-15%] of eligible members enroll
- Test Completion Rate: Target [>80%] of enrolled complete testing
- MZ Detection: Target [10-40] MZ carriers detected
- Customer NPS: Target [>40]
- Partner Satisfaction: Qualitative assessment (partner testimonial, renewal intent)

───────────────────────────────────────────────────────────────────────
6. ASSUMPTIONS AND DEPENDENCIES
───────────────────────────────────────────────────────────────────────

6.1 Partner Responsibilities:
    - Provide email list of [2K-10K] Eligible Members by [DATE]
    - Approve co-branded marketing materials within 10 business days
    - Provide IT support for SSO integration (3-5 days of IT time)
    - Pay invoices within 30 days

6.2 Provider Assumptions:
    - Enrollment rate: [5-15%] of eligible members
    - MZ prevalence: [2-3%] (national average)
    - Test turnaround time: [7-14] business days

───────────────────────────────────────────────────────────────────────
7. ACCEPTANCE
───────────────────────────────────────────────────────────────────────

This SOW is effective upon signature by both parties.

FAIR UNDERWRITING, INC.                    [PARTNER NAME]

By: _________________________              By: _________________________
Name: [CEO NAME]                           Name: [AUTHORIZED SIGNATORY]
Title: CEO                                 Title: [TITLE]
Date: _______________________              Date: _______________________
```

---

## Section 6: Negotiation Playbook

### 6.1 Common Partner Objections & Responses

| **Objection**                        | **Response**                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **"Pricing too high"**               | "Our pilot pricing ($75-100/test) is 30-50% discounted vs. commercial rate. Cost includes not just genetic test ($25-40 lab fee) but also genetic counseling ($50-100/session), portal development, customer support, and reporting. We're confident ROI will be positive (MZ detection → smoking cessation → medical cost savings)." |
| **"Liability concerns"**             | "Fair Underwriting carries $5M professional liability and $10M cyber liability insurance. We're also indemnified by our lab partners (Quest/LabCorp). Our liability cap is [12 months fees], and we exclude liability for Partner's actions (e.g., marketing, enrollment)."                                                           |
| **"Genetic discrimination fears"**   | "Our patent-protected privacy framework (US 20220165374) ensures members' genetic results are NOT shared with you (the insurer). You receive only aggregate, de-identified data (enrollment metrics, MZ detection counts). This eliminates genetic discrimination concerns and complies with GINA."                                   |
| **"HIPAA compliance uncertainty"**   | "We've executed BAAs with multiple partners and have never had a HIPAA breach. Our platform is SOC 2 Type II certified, with encryption (AES-256, TLS 1.3), access controls (MFA, RBAC), and audit logging (7-year retention). We're happy to undergo your security review."                                                          |
| **"Need more proof (case studies)"** | "We're offering pilot pricing specifically to build case studies. Our first 2-3 partners will receive significant discounts in exchange for testimonials and PR collaboration. Once we have proof points, pricing will increase."                                                                                                     |
| **"Enrollment rate too uncertain"**  | "We offer per-test fee pricing (not upfront flat fee) to reduce your risk. You pay only for members who complete testing. Based on wellness program benchmarks (5-15% engagement), we're confident we'll hit targets. If enrollment is lower, we'll work with you to improve marketing."                                              |

---

### 6.2 Term Sheet Template (Pre-Contract Negotiation)

```
FAIR UNDERWRITING - PARTNERSHIP TERM SHEET (NON-BINDING)

Partner: [NAME]
Date: [DATE]

───────────────────────────────────────────────────────────────────────
1. SERVICES
───────────────────────────────────────────────────────────────────────

Provider: Fair Underwriting, Inc.
Services: Genetic testing (SERPINA1, AAT level), genetic counseling, web portal, customer support
Eligible Members: [Partner's policyholders, age 18+, [specific criteria if any]]

───────────────────────────────────────────────────────────────────────
2. COMMERCIAL TERMS
───────────────────────────────────────────────────────────────────────

Pricing Model: Per-Test Fee
Per-Test Fee: $[75-100] per member tested
Setup Fee: $[10K-25K] (one-time)
Estimated Pilot Cost: $[50K-150K] (assuming [500-1,500] tests)

Payment Terms: Net 30 days, invoiced monthly in arrears

───────────────────────────────────────────────────────────────────────
3. TERM
───────────────────────────────────────────────────────────────────────

Pilot Duration: [6-12] months
Launch Target: [MONTH/YEAR]
Renewal: Automatic renewal for [1-year] terms unless either party provides [90-180] days' notice

───────────────────────────────────────────────────────────────────────
4. DELIVERABLES
───────────────────────────────────────────────────────────────────────

Provider Delivers:
- Web portal (enrollment, results, counseling scheduling)
- Partner dashboard (analytics)
- SSO integration
- Co-branded marketing materials (emails, landing page, FAQ, video)
- Customer support (email, chat, phone)
- Weekly/monthly reporting
- Final pilot report + case study

Partner Provides:
- Email list of [X] Eligible Members
- Marketing approval (10 business days)
- IT support for SSO integration
- Payment per terms above

───────────────────────────────────────────────────────────────────────
5. SUCCESS METRICS
───────────────────────────────────────────────────────────────────────

Enrollment Rate: Target [5-15%]
Test Completion: Target [>80%]
MZ Detection: Target [10-40] carriers
Customer NPS: Target [>40]
Partner Satisfaction: Qualitative (testimonial, renewal intent)

───────────────────────────────────────────────────────────────────────
6. KEY TERMS
───────────────────────────────────────────────────────────────────────

Privacy: Fair Underwriting's patent-protected privacy framework—Partner does NOT receive individual genetic results
HIPAA: Business Associate Agreement (BAA) required (if Partner is Covered Entity)
Data Protection: Data Processing Agreement (DPA) if CCPA/GDPR applies
Liability Cap: [12] months of fees paid
Insurance: Provider maintains $2M general liability, $2M E&O, $5M cyber liability
IP: Provider retains IP; Partner receives limited license
Confidentiality: 5-year confidentiality obligation

───────────────────────────────────────────────────────────────────────
7. NEXT STEPS
───────────────────────────────────────────────────────────────────────

1. Partner reviews term sheet → feedback by [DATE]
2. Parties negotiate terms → finalize by [DATE]
3. Legal drafts MSA, BAA, DPA → circulate by [DATE]
4. Contract execution → target [DATE]
5. Kickoff meeting → [DATE]

───────────────────────────────────────────────────────────────────────
8. NON-BINDING
───────────────────────────────────────────────────────────────────────

This term sheet is non-binding and is intended solely to facilitate negotiations. Binding
obligations arise only upon execution of definitive agreements (MSA, BAA, DPA, SOW).

ACKNOWLEDGED:

Fair Underwriting, Inc.                    [Partner Name]

By: _________________________              By: _________________________
Name: [CEO]                                Name: [NAME]
Date: _______________________              Date: _______________________
```

---

## Conclusion

This **Partnership Agreement Templates** document provides Fair Underwriting with **battle-tested legal framework** for insurance partnerships:

1. **Master Services Agreement (MSA)**: Comprehensive contract covering services, pricing, IP, liability, termination
2. **Business Associate Agreement (BAA)**: HIPAA compliance for health insurers
3. **Data Processing Agreement (DPA)**: GDPR/CCPA compliance for privacy
4. **Laboratory Services Agreement (LSA)**: Framework for Quest/LabCorp partnerships
5. **Statement of Work (SOW)**: Pilot-specific deliverables, timeline, pricing
6. **Negotiation Playbook**: Objection handling, term sheet template

**Next Steps**:

1. **Legal review**: Have Fair Underwriting's attorney review templates, customize for specific state laws
2. **Partner feedback**: Share templates with first 1-2 pilot partners, iterate based on feedback
3. **Finalize**: Create "final" versions for use in all partner negotiations (with minor customization per partner)

---

**Document Owner**: General Counsel + CEO + BD
**Review Frequency**: Annually (update for legal/regulatory changes)
**Last Updated**: November 7, 2025
**Next Review**: November 7, 2026
