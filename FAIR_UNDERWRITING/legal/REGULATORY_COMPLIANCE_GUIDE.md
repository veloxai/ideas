# Fair Underwriting - Regulatory Compliance Guide

**Last Updated**: November 7, 2025
**Compliance Status**: Pre-Launch Planning
**Next Audit**: Upon MVP Completion

---

## Executive Summary

Fair Underwriting operates at the intersection of **genetic testing**, **healthcare data**, and **insurance**, making regulatory compliance complex but manageable. This guide provides a comprehensive roadmap for compliance with federal and state regulations.

**Key Regulatory Frameworks**:

1. **HIPAA** (Health Insurance Portability and Accountability Act) - Healthcare data privacy
2. **GINA** (Genetic Information Nondiscrimination Act) - Genetic discrimination protection
3. **CLIA** (Clinical Laboratory Improvement Amendments) - Lab testing standards
4. **FDA** (Food and Drug Administration) - Genetic test regulation
5. **State Laws** - Genetic privacy, insurance, and testing regulations
6. **Data Privacy** - CCPA, GDPR (if applicable)

**Compliance Strategy**: Build compliance into the foundation, not bolt it on later.

---

## Regulatory Landscape Overview

### Federal Regulations

| Regulation | Applies To               | Key Requirements                                            | Penalties for Non-Compliance     |
| ---------- | ------------------------ | ----------------------------------------------------------- | -------------------------------- |
| **HIPAA**  | Healthcare data handling | Privacy Rule, Security Rule, Breach Notification            | Up to $1.5M/year per violation   |
| **GINA**   | Genetic information use  | Prohibits discrimination in health insurance and employment | Up to $300K per violation        |
| **CLIA**   | Laboratory testing       | Lab certification, quality standards                        | Fines, lab closure               |
| **FDA**    | Genetic tests (LDTs)     | Varies by risk classification                               | Warning letters, consent decrees |
| **FTC**    | Consumer protection      | Accurate advertising, data security                         | Fines, consent orders            |

### State Regulations

| State Type                      | Examples                 | Key Requirements                                                     |
| ------------------------------- | ------------------------ | -------------------------------------------------------------------- |
| **Genetic Privacy Laws**        | CA, NY, MA, FL           | Explicit consent for genetic testing, additional privacy protections |
| **Genetic Testing Regulations** | NY (most strict), CA, PA | Lab licensing, genetic counselor requirements                        |
| **Insurance Regulations**       | All states               | Varies; some prohibit genetic testing in underwriting                |
| **Genetic Counselor Licensing** | 30+ states               | Must use licensed genetic counselors                                 |

---

## 1. HIPAA Compliance

### Overview

**Applicability**: Fair Underwriting handles Protected Health Information (PHI), making us a **Covered Entity** or **Business Associate**.

**Determination**:

- If we bill insurance directly → **Covered Entity**
- If we provide services to insurers → **Business Associate**
- **Our Model**: Likely Business Associate (partner insurers are Covered Entities)

### HIPAA Privacy Rule

**Requirements**:

1. **Notice of Privacy Practices (NPP)**
   - ✅ Create clear, accessible privacy notice
   - ✅ Explain how PHI is used (testing, counseling, research)
   - ✅ Inform customers of their rights (access, amendment, deletion)
   - ✅ Provide at enrollment, make available on website

2. **Individual Rights**
   - ✅ **Right to Access**: Customers can request copy of their PHI (portal download)
   - ✅ **Right to Amendment**: Customers can request corrections
   - ✅ **Right to Accounting**: Log all PHI disclosures (audit trail)
   - ✅ **Right to Restriction**: Customers can request limits on PHI use
   - ✅ **Right to Confidential Communications**: Secure portal, encrypted email

3. **Minimum Necessary Standard**
   - ✅ Only collect PHI necessary for testing and counseling
   - ✅ Limit access internally (role-based access control)
   - ✅ Share only minimum necessary with partners (aggregated data)

4. **Business Associate Agreements (BAAs)**
   - ✅ Execute BAAs with:
     - Lab partners (Quest, LabCorp)
     - Cloud hosting providers (AWS)
     - Email/SMS providers (Twilio, SendGrid)
     - Analytics tools (if they access PHI)
   - ✅ Template: Use HHS model BAA, customize

**Implementation Checklist**:

- [ ] Draft and publish Notice of Privacy Practices
- [ ] Implement customer rights workflows (access requests, amendments)
- [ ] Create audit logging system (who accessed what PHI, when)
- [ ] Execute BAAs with all vendors handling PHI
- [ ] Train all employees on HIPAA Privacy Rule (annually)

---

### HIPAA Security Rule

**Requirements**:

1. **Administrative Safeguards**
   - ✅ **Security Management Process**: Risk assessment, risk management, sanctions policy
   - ✅ **Assigned Security Responsibility**: Designate Security Officer (likely CTO)
   - ✅ **Workforce Training**: Annual HIPAA security training for all employees
   - ✅ **Access Management**: Role-based access, least privilege principle
   - ✅ **Security Incident Procedures**: Incident response plan, breach notification process

2. **Physical Safeguards**
   - ✅ **Facility Access Controls**: Data centers (AWS responsibility), office security
   - ✅ **Workstation Security**: Encrypted laptops, screensavers, clean desk policy
   - ✅ **Device Controls**: Inventory, disposal, encryption

3. **Technical Safeguards**
   - ✅ **Access Controls**: Unique user IDs, emergency access, automatic logoff, encryption
   - ✅ **Audit Controls**: Log all PHI access (who, what, when)
   - ✅ **Integrity Controls**: Ensure PHI not improperly altered (checksums, version control)
   - ✅ **Transmission Security**: TLS 1.3 for data in transit, VPN for remote access

**Encryption Requirements**:

- **At Rest**: AES-256 encryption for databases, file storage
- **In Transit**: TLS 1.3 for all web traffic, APIs
- **Backups**: Encrypted backups, secure key management (AWS KMS)

**Implementation Checklist**:

- [ ] Complete HIPAA Security Risk Assessment (SRA)
- [ ] Document security policies and procedures
- [ ] Implement technical safeguards (encryption, access controls, audit logs)
- [ ] Designate Security Officer (typically CTO)
- [ ] Conduct annual security training for all employees
- [ ] Implement incident response plan
- [ ] Conduct annual risk assessment and remediation

---

### HIPAA Breach Notification Rule

**Definition of Breach**: Unauthorized acquisition, access, use, or disclosure of PHI that compromises security or privacy.

**Notification Requirements**:

1. **Individual Notification** (within 60 days of discovery)
   - Method: First-class mail, or email if customer opted in
   - Content: What happened, what PHI involved, what we're doing, how to protect themselves

2. **HHS Notification**
   - **Breaches affecting 500+ individuals**: Within 60 days, posted on HHS website
   - **Breaches affecting <500 individuals**: Annual notification

3. **Media Notification** (if 500+ individuals in same state/jurisdiction)
   - Prominent media outlets in affected area

4. **Business Associate Notification to Covered Entity**
   - If we're a BA and breach occurs, notify partners immediately (within 60 days max)

**Breach Prevention**:

- ✅ Encryption (if data encrypted and key not compromised, may not be breach)
- ✅ Access controls and monitoring
- ✅ Employee training (phishing, social engineering)
- ✅ Incident response plan and drills

**Implementation Checklist**:

- [ ] Create breach notification templates (individual, HHS, media)
- [ ] Establish breach response team and procedures
- [ ] Implement breach detection tools (SIEM, alerts)
- [ ] Conduct annual breach response tabletop exercise
- [ ] Purchase cyber liability insurance ($2-5M coverage)

---

### HIPAA Compliance Costs & Timeline

**Initial Setup** (Month 1-3):

- Legal counsel (health law firm): $15K-30K
- Security risk assessment: $10K-20K (consultant or DIY with tools)
- Policy/procedure documentation: $5K-10K
- Technical implementation (encryption, access controls): $20K-40K
- Training: $2K-5K
- **Total**: $52K-105K

**Ongoing** (Annual):

- Annual risk assessment: $5K-10K
- Training (annual, all employees): $2K-5K
- Compliance monitoring: $10K-20K
- **Total**: $17K-35K/year

**Timeline**:

- Weeks 1-4: Security risk assessment, gap analysis
- Weeks 5-8: Remediation (technical, policy, training)
- Weeks 9-10: Documentation, BAA execution
- Weeks 11-12: Final audit, readiness review
- **Total**: 3 months to launch compliance

---

## 2. GINA (Genetic Information Nondiscrimination Act)

### Overview

**Purpose**: Prohibits discrimination based on genetic information in health insurance and employment.

**Enacted**: 2008

**Applicability**:

- **Title I**: Health insurance (prevents genetic discrimination)
- **Title II**: Employment (prevents genetic discrimination)

**Fair Underwriting Alignment**: Our patent (Claim 34) legally enforces GINA principles—insureds not required to share genetic results.

---

### GINA Title I: Health Insurance

**Prohibitions**:

1. Health insurers **CANNOT**:
   - Request or require genetic testing
   - Use genetic information for eligibility or premium decisions
   - Request, require, or purchase genetic information for underwriting

2. Health insurers **CAN**:
   - Request genetic information for payment of claims (treatment-related)
   - Offer wellness programs that include genetic testing (IF voluntary, no penalties for declining)

**Fair Underwriting Compliance**:

- ✅ Our model is **voluntary wellness testing** (GINA-compliant)
- ✅ Customers **not required** to share results with insurer (Claim 34)
- ✅ Insurer receives **only aggregated, de-identified data** (no individual genetic results)

**Key Requirement**: Ensure partner contracts explicitly state:

- Testing is voluntary
- No penalties for declining
- Results are customer-owned, not shared with insurer for underwriting

---

### GINA Title II: Employment

**Prohibitions**:

1. Employers **CANNOT**:
   - Use genetic information in hiring, firing, promotion
   - Request, require, or purchase genetic information

2. Employers **CAN**:
   - Offer wellness programs with voluntary genetic testing

**Fair Underwriting Application**:

- If partnering with employers (wellness programs), ensure compliance
- Testing must be voluntary, no employment consequences for results

---

### GINA Limitations & Gaps

**What GINA Does NOT Cover**:

1. **Life insurance** (GINA does NOT prohibit life insurers from using genetic info)
2. **Disability insurance**
3. **Long-term care insurance**
4. Military health coverage (TRICARE)
5. Veterans' benefits
6. Indian Health Service
7. Federal Employees Health Benefits

**Implication for Fair Underwriting**:

- Life insurers **CAN legally** use genetic info for underwriting (GINA doesn't prevent)
- **Our patent framework** provides protection where GINA doesn't (life insurance)
- This is our **key value proposition**: Privacy protection beyond GINA

---

### State Genetic Privacy Laws (Stronger than GINA)

Many states have **stronger protections** than GINA:

**California (CA GIPA)**:

- Requires explicit written consent for genetic testing
- Prohibits discrimination based on genetic info (broader than GINA)
- Applies to all insurance types (life, disability, LTC)

**New York**:

- Strong genetic privacy protections
- Insurance regulations vary by type

**Florida, Massachusetts, Others**:

- Additional consent requirements
- Insurance protections

**Implementation**:

- ✅ Review laws in each state where we operate
- ✅ Implement strongest standard across all states (simplifies compliance)
- ✅ Explicit written consent for genetic testing (e-signature in portal)

---

### GINA Compliance Checklist

- [ ] Review partner contracts for GINA compliance language
- [ ] Ensure testing is voluntary (no penalties for declining)
- [ ] Customer consent forms state results are private
- [ ] Data sharing agreements prohibit actuarial use of genetic data
- [ ] Partner dashboard shows only aggregated data (no individual genetic results)
- [ ] Train partners on GINA requirements (wellness program guidelines)
- [ ] Monitor state genetic privacy laws (more restrictive than GINA)

**Cost**: Legal review of contracts and consent forms ($5K-10K)

---

## 3. CLIA (Clinical Laboratory Improvement Amendments)

### Overview

**Purpose**: Ensure quality standards for laboratory testing.

**Applicability**: All clinical labs that test human specimens.

**Fair Underwriting Model**: We **do not operate labs**; we partner with CLIA-certified labs (Quest, LabCorp).

---

### CLIA Certification Levels

1. **Waived Tests**: Simple, low-risk (e.g., glucose meters)
2. **Moderate Complexity**: Most common lab tests
3. **High Complexity**: Advanced testing (genetic tests = high complexity)

**SERPINA1 Testing**: High complexity, requires CLIA certification + CAP accreditation.

---

### Fair Underwriting Compliance

**Strategy**: Partner with CLIA/CAP-certified labs (we don't need certification).

**Lab Partner Requirements**:

- ✅ CLIA High Complexity certification
- ✅ CAP (College of American Pathologists) accreditation (higher standard)
- ✅ AATD testing validation (Quest and LabCorp have this)
- ✅ Quality assurance protocols
- ✅ Proficiency testing

**Our Responsibilities**:

- ✅ Verify lab partner certifications (annually)
- ✅ Include lab certifications in marketing materials (credibility)
- ✅ Quality oversight (turnaround time, error rates)

**Implementation**:

- [ ] Request CLIA/CAP certificates from lab partners
- [ ] Review lab quality metrics (quarterly)
- [ ] Include lab credentials in sales materials

**Cost**: $0 (lab partner responsibility)

---

## 4. FDA (Food and Drug Administration) Regulation

### Overview

**Purpose**: Ensure safety and effectiveness of medical devices (including genetic tests).

**Controversy**: FDA regulation of Laboratory Developed Tests (LDTs) is evolving.

---

### LDT (Laboratory Developed Test) Background

**Definition**: Tests developed, validated, and performed within a single CLIA-certified lab.

**Historical Treatment**:

- FDA exercised "enforcement discretion" (didn't regulate most LDTs)
- Labs relied on CLIA certification

**Recent Changes** (2024-2025):

- FDA proposed phasing out enforcement discretion
- Plans to regulate high-risk LDTs more closely
- Timeline: Multi-year phase-in

---

### SERPINA1 Testing FDA Status

**Current Status** (2025):

- SERPINA1 genetic testing is an **LDT** (offered by Quest, LabCorp, others)
- **Not FDA-approved** as a specific test kit
- Labs validate the test internally (CLIA/CAP standards)

**Risk Classification** (if FDA regulates):

- Likely **Class II** (moderate risk) - most genetic tests
- Would require **510(k) clearance** or **PMA** (Pre-Market Approval)

**Fair Underwriting Risk**:

- **Low-Medium**: SERPINA1 is well-established, low controversy
- FDA likely to prioritize high-risk tests (cancer diagnostics, prenatal)
- Clinical utility well-documented (AlphaNet, ATS guidelines)

---

### FDA Compliance Strategy

**Current Strategy** (2025-2027):

1. **Rely on Lab Partner**: Quest/LabCorp handle FDA compliance (LDT validation)
2. **Monitor FDA Guidance**: Stay informed on LDT regulation changes
3. **Clinical Utility Evidence**: Maintain database of studies supporting AATD testing
4. **Advisory Board**: Include medical experts (pulmonologists, geneticists) for credibility

**If FDA Requires Approval**:

1. **510(k) Pathway** (most likely):
   - Demonstrate substantial equivalence to existing test
   - Clinical performance data
   - Cost: $50K-200K, 6-12 months
2. **De Novo Pathway** (if novel):
   - More extensive review
   - Cost: $100K-500K, 12-18 months

**Contingency Plan**:

- Budget $100K-200K for FDA submission (if needed)
- Partner with regulatory consultants (FDA specialists)
- Build clinical evidence database proactively

**Implementation**:

- [ ] Monitor FDA LDT guidance (quarterly)
- [ ] Maintain clinical utility literature database
- [ ] Engage regulatory consultant (on retainer, $5K-10K/year)
- [ ] Budget for potential FDA submission (Month 18-24)

**Cost**:

- Monitoring & consulting: $10K-20K/year
- Potential submission: $100K-200K (if required)

---

## 5. State Genetic Testing Regulations

### State-by-State Variability

**Challenge**: Each state has different laws for genetic testing, privacy, and insurance.

**Strategy**:

1. Start in states with **favorable regulations**
2. Expand to **moderate** states
3. Defer **strict** states until scale justifies compliance costs

---

### State Categories

#### Tier 1: Favorable (Start Here)

**Examples**: Most Midwestern and Southern states

**Characteristics**:

- Minimal genetic testing regulations
- No special lab licensing beyond CLIA
- Genetic counselor licensing not required (though we'll use licensed counselors)
- Insurance regulations permissive

**Target for Pilots**: Iowa, Nebraska, Wisconsin, North Carolina

---

#### Tier 2: Moderate (Expand After Pilots)

**Examples**: California, Massachusetts, Pennsylvania, Florida

**Characteristics**:

- Genetic privacy laws (explicit consent required)
- Some genetic counselor licensing requirements
- Insurance regulations moderate

**Compliance**:

- Explicit written consent (we already do this)
- Use licensed genetic counselors (we already do this)

**Target for Scale**: California (large market, worth compliance effort)

---

#### Tier 3: Strict (Defer Until Scale)

**Example**: New York (most strict)

**Characteristics**:

- **Lab Licensing**: Out-of-state labs must be licensed in NY (complex, expensive)
- **Genetic Test Approval**: Some tests require NYS DOH approval
- **Genetic Counseling**: May require NY-licensed counselor

**Compliance Effort**:

- Lab partner handles NY licensing (Quest/LabCorp already licensed)
- Hire NY-licensed genetic counselor (or partner for NY customers)
- Cost: $20K-50K for NY compliance

**Strategy**: Defer until we have 5-10 partners (worth the effort)

---

### Key State Laws to Monitor

| State             | Key Regulation      | Requirement                              | Compliance Strategy                   |
| ----------------- | ------------------- | ---------------------------------------- | ------------------------------------- |
| **New York**      | NYS Lab Licensing   | Out-of-state labs must be NY-licensed    | Use Quest/LabCorp (already licensed)  |
| **California**    | CA GIPA             | Explicit written consent, strong privacy | Implement statewide (high bar)        |
| **Massachusetts** | Genetic Testing Law | Consent, counseling access               | Licensed counselors (already planned) |
| **Florida**       | Genetic Privacy Act | Consent, no discrimination               | Standard consent process              |
| **Pennsylvania**  | Genetic Test Law    | Counseling requirements                  | Licensed counselors                   |
| **Texas**         | Genetic Privacy Law | Consent, insurance protections           | Standard process                      |

---

### Genetic Counselor Licensing

**Requirement**: 30+ states require genetic counselors to be licensed.

**Our Approach**: Hire **nationally certified genetic counselors** (ABGC or ABMGG).

**Licensure**:

- Most states recognize **ABGC/ABMGG certification** for licensure
- Some states require additional state-specific exam/application

**Strategy**:

1. Hire genetic counselors with **multi-state licensure** (or ability to obtain)
2. Start with counselors licensed in pilot states
3. As we expand, hire or contract counselors licensed in new states
4. Consider **telehealth genetic counseling** (counselor in one state, customer in another - legal in most states)

**Cost**:

- Genetic counselor salary: $75K-95K + benefits
- Licensing fees: $200-500 per state
- Continuing education: $2K-5K/year

---

### State Insurance Regulations

**Concern**: Some states prohibit insurers from requiring genetic testing.

**Our Model**: Testing is **voluntary** (wellness program), not required.

**Compliance**: Ensure partner contracts state testing is voluntary, no penalties.

**State-Specific Review**:

- Legal counsel reviews insurance regulations in each target state
- Cost: $2K-5K per state legal review

---

### State Compliance Roadmap

**Phase 1: Pilots (2 States)**

- Select states with favorable regulations
- Complete legal review: $5K-10K total
- Implement state-specific consent forms (if needed)

**Phase 2: Expansion (5-10 States)**

- Prioritize large markets (CA, TX, FL, PA)
- Legal review: $10K-50K
- Hire genetic counselors with multi-state licensure

**Phase 3: National (All 50 States)**

- New York last (most complex)
- Legal review: $50K-100K total
- Network of genetic counselors across regions

**Timeline**: Phase 1 (Month 4), Phase 2 (Month 12), Phase 3 (Month 24+)

---

## 6. Data Privacy Regulations (CCPA, GDPR)

### California Consumer Privacy Act (CCPA)

**Applicability**:

- We handle data of California residents
- Revenue >$25M OR process data of 50K+ CA residents

**Likely Timeline**: Applicable by Year 2-3 (once we scale)

**Requirements**:

1. **Right to Know**: What personal info collected, how used
2. **Right to Delete**: Customers can request deletion (with exceptions for healthcare)
3. **Right to Opt-Out**: Opt-out of "sale" of personal info (we don't sell, so N/A)
4. **Notice**: Clear privacy policy

**Fair Underwriting Compliance**:

- ✅ Privacy policy already required (HIPAA)
- ✅ Customer portal includes data access, download, deletion
- ✅ Genetic data is healthcare data (HIPAA > CCPA, exceptions apply)

**Implementation**:

- [ ] CCPA-compliant privacy policy (when applicable)
- [ ] Data deletion workflow (with healthcare exceptions)
- [ ] Annual privacy training for employees

**Cost**: $10K-20K for CCPA compliance (when applicable)

---

### GDPR (General Data Protection Regulation)

**Applicability**: If we process data of EU residents

**Likelihood**: Low initially (US-only), High if we expand internationally

**Requirements** (if applicable):

1. **Lawful Basis**: Consent, contract, legitimate interest
2. **Data Subject Rights**: Access, rectification, erasure, portability
3. **Data Protection Officer** (if large-scale health data processing)
4. **Data Processing Agreement**: With all vendors
5. **GDPR-Compliant Privacy Policy**

**Compliance Strategy** (if/when applicable):

- Appoint Data Protection Officer (DPO)
- GDPR-compliant consent forms
- Data Processing Agreements with vendors
- Privacy by design (already our approach)

**Cost**: $50K-150K for GDPR compliance (EU expansion)

**Timeline**: Plan for GDPR if international expansion (Month 24+)

---

## 7. Insurance Regulation & Licensing

### Question: Does Fair Underwriting Need Insurance Licensing?

**Answer**: Likely **NO**, but depends on business model.

**Analysis**:

**We Are NOT**:

- Insurance company (we don't underwrite policies)
- Insurance agent/broker (we don't sell policies)
- Third-party administrator (we don't administer claims)

**We ARE**:

- **Wellness service provider** (genetic testing for health improvement)
- **Technology platform** (software for insurers)
- **Business Associate** (providing services to insurers)

**Licensing Likely Not Required** IF:

- We provide services **to insurers** (not directly to consumers for insurance purposes)
- We don't use genetic data for **actuarial calculations** (we don't, per patent)
- Testing is **wellness/prevention**, not underwriting

**Recommendation**: Obtain legal opinion from insurance regulatory attorney.

**Cost**: $10K-20K for legal opinion and state-by-state review

---

### State Insurance Department Notifications

**Best Practice**: Proactively notify state insurance departments of our business model.

**Approach**:

- Letter to state insurance commissioner explaining our model
- Emphasize: Wellness program, privacy-protected, GINA-compliant, patent framework
- Request confirmation that no licensing required

**Timeline**: Before launching in each state (pilot states first)

**Cost**: $5K-10K (legal counsel to draft notifications)

---

## 8. Cybersecurity & Data Breach Regulations

### Requirements

**HIPAA Security Rule** (covered above)

**State Data Breach Notification Laws** (all 50 states have them)

**Key Requirements**:

- Notify affected individuals (varies by state, typically 30-90 days)
- Notify state attorney general (if >500-1,000 residents)
- Offer credit monitoring (some states, if SSN compromised - we don't collect SSN)

**Our Compliance**:

- Implement robust cybersecurity (see TECHNICAL_ARCHITECTURE.md)
- Incident response plan
- Cyber liability insurance ($2-5M coverage)

---

### Cybersecurity Frameworks

**NIST Cybersecurity Framework** (voluntary, best practice):

1. **Identify**: Asset management, risk assessment
2. **Protect**: Access control, data security, training
3. **Detect**: Anomalies, continuous monitoring
4. **Respond**: Response planning, communications
5. **Recover**: Recovery planning, improvements

**Implementation**: Follow NIST CSF from Day 1 (builds trust, reduces risk)

**Audit**: Annual external security audit (penetration testing, vulnerability assessment)

**Cost**:

- Initial setup: $20K-40K (part of HIPAA compliance)
- Annual audits: $10K-20K

---

## 9. Marketing & Advertising Regulations (FTC)

### FTC Oversight

**FTC Act**: Prohibits deceptive or unfair practices.

**Applicability**: Our marketing claims about genetic testing, health benefits.

**Key Principles**:

1. **Truthful**: Claims must be accurate (e.g., MZ prevalence, COPD risk)
2. **Substantiated**: Health claims must be backed by science
3. **Not Misleading**: Avoid overstating benefits or understating risks

---

### Genetic Testing Marketing Guidelines

**FTC Guidelines** (for genetic test marketing):

1. **Clearly Explain**: What test measures, limitations
2. **Avoid Overpromising**: Don't claim test predicts disease with certainty (genes + environment)
3. **Privacy Claims**: If we claim "privacy-protected," must deliver (we do, via patent)
4. **Not a Diagnostic**: Make clear test is for wellness/risk assessment (if applicable)

**Our Compliance**:

- ✅ Educational content vetted by medical advisors
- ✅ Claims backed by peer-reviewed research (see CLINICAL_EVIDENCE_DATABASE.md)
- ✅ Clear explanation of MZ risk (2-4x COPD risk, not "you will get COPD")

**Review Process**:

- All marketing materials reviewed by:
  1. Medical advisor (accuracy)
  2. Legal counsel (compliance)
  3. Marketing team (messaging)

**Cost**: $5K-10K for FTC compliance review (initial materials)

---

## 10. Telehealth Regulations (Genetic Counseling)

### Overview

**Model**: Genetic counseling via video call (telehealth).

**Regulation**: Varies by state (where customer is located, where counselor is licensed).

---

### State Telehealth Laws

**Generally Permissive**: Most states allow telehealth genetic counseling.

**Requirements**:

1. **Counselor Licensure**: Must be licensed in state where customer is located (or multi-state compact)
2. **Informed Consent**: Customer consents to telehealth (vs. in-person)
3. **Technology**: HIPAA-compliant video platform (Zoom HIPAA, Doxy.me, etc.)

**Multi-State Licensure**:

- Some states have reciprocity or multi-state compacts
- Genetic counselors often licensed in multiple states

**Our Compliance**:

- Hire genetic counselors with multi-state licensure
- Use HIPAA-compliant video platform
- Document customer consent for telehealth

**Cost**:

- HIPAA-compliant video platform: $20-50/month per user (Zoom Healthcare, Doxy.me)
- Multi-state licensure fees: $200-500 per state per counselor

---

## 11. Research & Data Use Regulations (IRB, 21 CFR Part 11)

### If We Conduct Research (Future)

**Institutional Review Board (IRB)** oversight required for human subjects research.

**Applicability**:

- If we publish research using customer data (anonymized)
- If we run clinical trials or studies

**Compliance**:

- Partner with external IRB (commercial IRBs available)
- Obtain customer consent for research use (opt-in)
- Follow Good Clinical Practice (GCP) guidelines

**Cost**: $5K-20K per study (IRB fees)

**Timeline**: Plan for IRB if/when we conduct research (Month 18+)

---

### 21 CFR Part 11 (FDA Electronic Records)

**Applicability**: If we submit data to FDA (e.g., for test approval).

**Requirements**: Electronic records and signatures must be secure, reliable.

**Our Compliance**: Cloud infrastructure already meets most requirements (AWS, encryption, audit logs).

**Cost**: Minimal (if FDA submission required, part of that process)

---

## Compliance Implementation Roadmap

### Phase 1: Pre-Launch (Month 1-3)

**Priority**: HIPAA, GINA, initial state reviews

| Task                               | Owner            | Cost          | Timeline     |
| ---------------------------------- | ---------------- | ------------- | ------------ |
| HIPAA Security Risk Assessment     | CTO + Consultant | $10K-20K      | Weeks 1-4    |
| HIPAA Policies & Procedures        | Legal + CTO      | $10K-20K      | Weeks 3-6    |
| GINA Compliance Review             | Legal            | $5K-10K       | Weeks 3-5    |
| State Law Review (2 pilot states)  | Legal            | $5K-10K       | Weeks 4-6    |
| BAA Execution (labs, AWS, vendors) | CEO + Legal      | $5K-10K       | Weeks 5-8    |
| Employee HIPAA Training            | HR + Consultant  | $2K-5K        | Week 10      |
| Privacy Policy & Consent Forms     | Legal            | $5K-10K       | Weeks 6-8    |
| Cyber Liability Insurance          | CFO              | $10K-25K/year | Week 8       |
| **Total Phase 1**                  | —                | **$52K-110K** | **3 months** |

---

### Phase 2: Launch (Month 4-9)

**Priority**: Ongoing compliance, monitoring

| Task                                   | Owner                   | Cost               | Timeline           |
| -------------------------------------- | ----------------------- | ------------------ | ------------------ |
| Breach Response Drills                 | CTO + Security Officer  | $2K-5K             | Quarterly          |
| Lab Partner Certification Verification | Operations              | $0                 | Ongoing            |
| State Law Monitoring                   | Legal (retainer)        | $2K-5K/month       | Ongoing            |
| Marketing Compliance Review            | Legal + Medical Advisor | $5K-10K            | One-time + ongoing |
| **Total Phase 2**                      | —                       | **$10K-20K/month** | **6 months**       |

---

### Phase 3: Scale (Month 10+)

**Priority**: Expansion compliance, additional states

| Task                               | Owner                 | Cost             | Timeline    |
| ---------------------------------- | --------------------- | ---------------- | ----------- |
| State Expansion Legal Reviews      | Legal                 | $2K-5K per state | As needed   |
| Annual HIPAA Security Assessment   | CTO + Auditor         | $10K-20K         | Annual      |
| SOC 2 Type II Audit                | CTO + Auditor         | $25K-50K         | Year 2      |
| ISO 27001 Certification (optional) | CTO + Consultant      | $50K-100K        | Year 2-3    |
| FDA Regulatory Monitoring          | Consultant (retainer) | $10K-20K/year    | Ongoing     |
| **Total Phase 3**                  | —                     | **Varies**       | **Ongoing** |

---

## Total Compliance Budget (First 2 Years)

| Category                 | Year 1         | Year 2         | Notes                            |
| ------------------------ | -------------- | -------------- | -------------------------------- |
| **Initial Setup**        | $52K-110K      | —              | HIPAA, GINA, policies            |
| **Legal (Ongoing)**      | $24K-60K       | $30K-75K       | State reviews, contracts         |
| **Audits & Assessments** | $10K-20K       | $35K-70K       | Security audits, SOC 2           |
| **Insurance**            | $10K-25K       | $15K-35K       | Cyber liability, E&O             |
| **Training**             | $5K-10K        | $5K-10K        | HIPAA, security, compliance      |
| **Consulting**           | $10K-25K       | $15K-30K       | Regulatory, FDA, privacy         |
| **Software & Tools**     | $5K-10K        | $5K-10K        | Compliance platforms, monitoring |
| **Total**                | **$116K-260K** | **$105K-230K** | —                                |

**Note**: Costs decrease in Year 2 (no initial setup) but increase with scale (more states, SOC 2).

---

## Compliance Ownership & Roles

| Compliance Area       | Primary Owner                            | Secondary Owner                  | External Support          |
| --------------------- | ---------------------------------------- | -------------------------------- | ------------------------- |
| **HIPAA Privacy**     | Chief Privacy Officer (or CEO initially) | Legal                            | Health law attorney       |
| **HIPAA Security**    | CTO (Security Officer)                   | DevOps                           | Security consultant       |
| **GINA**              | Legal                                    | CEO                              | Health law attorney       |
| **State Regulations** | Legal                                    | Compliance Manager (future hire) | Multi-state legal counsel |
| **CLIA**              | Operations (lab oversight)               | Medical Director                 | Lab partners              |
| **FDA**               | Medical Director                         | Regulatory Affairs (future)      | FDA consultant            |
| **Data Privacy**      | CTO + Legal                              | Privacy Officer (future)         | Privacy attorney          |
| **Marketing/FTC**     | CMO                                      | Legal                            | FTC attorney              |

---

## Compliance Technology Stack

**Tools to Implement**:

1. **HIPAA Compliance Platform**: Vanta, Drata, or Secureframe
   - Automates compliance monitoring, employee training, policy management
   - Cost: $10K-30K/year
   - Benefit: Reduces manual effort, audit-ready

2. **Security Information & Event Management (SIEM)**: AWS Security Hub, Splunk
   - Monitors security events, detects breaches
   - Cost: $5K-20K/year
   - Benefit: Real-time threat detection

3. **Access Management**: Okta, Auth0 (leverage auth.vlx.io)
   - Role-based access control, SSO, MFA
   - Cost: $5K-15K/year
   - Benefit: HIPAA access control compliance

4. **Audit Logging**: Integrated into platform (PostgreSQL audit, AWS CloudTrail)
   - Who accessed what PHI, when
   - Cost: Included in infrastructure
   - Benefit: HIPAA audit controls

5. **Encryption**: AWS KMS, Let's Encrypt (TLS certificates)
   - Data at rest (AES-256), in transit (TLS 1.3)
   - Cost: Minimal (AWS KMS pricing, Let's Encrypt free)
   - Benefit: HIPAA technical safeguards

6. **Incident Response Platform**: PagerDuty, Opsgenie
   - Alerts for security incidents, breach response
   - Cost: $5K-15K/year
   - Benefit: Rapid incident detection and response

**Total Technology Cost**: $30K-100K/year (scales with usage)

---

## Red Flags & Risk Mitigation

### Red Flag: "Genetic Discrimination Incident"

**Scenario**: Partner insurer uses genetic data for underwriting (violates GINA, our patent).

**Mitigation**:

- Contract explicitly prohibits (liquidated damages clause)
- Technical controls (partner dashboard shows no individual genetic data)
- Regular audits of partner compliance
- Customer can report violations (hotline, portal)

---

### Red Flag: "Data Breach"

**Scenario**: Unauthorized access to customer genetic data.

**Mitigation**:

- Encryption (even if breached, data unreadable)
- Access controls (minimize who can access PHI)
- Monitoring (detect breaches quickly)
- Incident response plan (contain, notify, remediate)
- Cyber insurance (financial protection)

---

### Red Flag: "State Orders Cease & Desist"

**Scenario**: State regulator says we're operating without proper licensing.

**Mitigation**:

- Proactive legal review before entering each state
- Notification to state insurance departments (document "no licensing required")
- Rapid response team (legal counsel, CEO) to engage regulator
- Contingency: Pause operations in that state, obtain license if required

---

### Red Flag: "FDA Warning Letter"

**Scenario**: FDA says SERPINA1 test requires approval.

**Mitigation**:

- Partner with labs (they hold FDA responsibility for LDT)
- Monitor FDA guidance proactively
- Budget for 510(k) submission if required
- Clinical utility evidence database (justify test value)

---

## Key Takeaways

1. **Compliance is Foundational**: Build it in from Day 1, don't bolt on later.

2. **HIPAA is Core**: Most complex and important (healthcare data).

3. **GINA Alignment**: Our patent framework enforces GINA principles (key differentiator).

4. **Partner with Experts**: Labs handle CLIA/FDA, we handle data privacy and partnership compliance.

5. **State-by-State Strategy**: Start in friendly states, expand systematically.

6. **Budget Appropriately**: $116K-260K Year 1, $105K-230K Year 2.

7. **Continuous Monitoring**: Regulations evolve; stay informed and adaptive.

---

**Document Owner**: Chief Privacy Officer / CTO / Legal Counsel
**Review Frequency**: Quarterly (regulations change frequently)
**Last Updated**: November 7, 2025
**Next Review**: February 7, 2026
