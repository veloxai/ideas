# Document #15: Research Data Management

## Mark Egly Foundation - Phase 2 Expansion

**Document Type:** Data Management & Research Infrastructure
**Priority:** LOW (Foundational for future)
**Estimated Budget:** $10,000 - $40,000 setup, $5,000 - $15,000 annual
**Timeline:** 6-12 months to establish framework
**Dependencies:** Patient Registry (Doc #14), Partnerships (Docs #7-9)
**Last Updated:** November 2025

---

## Executive Summary

This document establishes a comprehensive research data management framework to support the Mark Egly Foundation's research initiatives, ensure data integrity, facilitate collaboration, and meet funding agency requirements. As the Foundation grows its research portfolio, systematic data management becomes essential for credibility, compliance, and scientific impact.

**Framework Objectives:**

- Establish data governance policies and procedures
- Ensure compliance with funder requirements (NIH, PCORI, foundations)
- Facilitate data sharing and collaboration while protecting privacy
- Implement secure data storage and long-term preservation
- Create standardized data documentation and metadata
- Support reproducible research and transparency

**Key Components:**

- Data Management Plans (DMPs) for all research projects
- Secure data repositories and backup systems
- Data sharing policies aligned with FAIR principles
- Metadata standards and data dictionaries
- Collaborative research agreements and data use terms
- Training and support for researchers and staff

**Resource Requirements:**

- Data Manager or Research Coordinator (0.25-0.5 FTE): $12,000-$25,000
- Data storage and repository: $1,000-$5,000/year
- Compliance and security tools: $2,000-$5,000/year
- Training and consulting: $2,000-$5,000

---

## Part 1: Data Governance Framework

### 1.1 Data Governance Structure

**Data Governance Committee:**

- **Chair:** Research Director or Medical Director
- **Members:**
  - Executive Director (organizational perspective)
  - Data Manager (technical expertise)
  - 2-3 Research investigators (user perspective)
  - Privacy/Security officer (compliance)
  - Legal counsel or consultant (contracts, IP)
  - Patient advocate (community voice)

**Responsibilities:**

- Review and approve data management plans
- Oversee data sharing requests and agreements
- Ensure compliance with regulations (HIPAA, IRB, funder requirements)
- Resolve data access disputes
- Monitor data security and breaches
- Review data management policies annually

**Meeting Schedule:** Quarterly (4 times/year) or as needed

### 1.2 Data Classification System

**Level 1: Public Data**

- **Definition:** No restrictions, publicly shareable
- **Examples:** Published research results, aggregate statistics, press releases
- **Storage:** Foundation website, public repositories
- **Access:** Open to anyone
- **Backup:** Standard backup protocols

**Level 2: Internal Data**

- **Definition:** Sensitive business information, not PHI
- **Examples:** Donor lists, financial records, strategic plans, unpublished results
- **Storage:** Secure Foundation servers, encrypted drives
- **Access:** Foundation staff only, role-based permissions
- **Backup:** Daily encrypted backups

**Level 3: Confidential Research Data (De-identified)**

- **Definition:** Research datasets without direct identifiers
- **Examples:** Patient registry limited dataset, survey responses, clinical outcomes
- **Storage:** REDCap, secure research servers, encrypted cloud
- **Access:** Approved researchers only, Data Use Agreement required
- **Backup:** Daily encrypted backups, 7-year retention minimum

**Level 4: Protected Health Information (PHI)**

- **Definition:** Identifiable patient data under HIPAA
- **Examples:** Medical records, patient contact information, genetic data with identifiers
- **Storage:** HIPAA-compliant systems only (REDCap, Epic, secure servers)
- **Access:** Minimum necessary principle, IRB approval, signed BAA
- **Backup:** Daily encrypted backups, audit trails, 7-year retention minimum post-study

### 1.3 Data Lifecycle Management

**Stage 1: Planning (Before Data Collection)**

- Develop Data Management Plan (DMP)
- Obtain IRB approval
- Establish data security measures
- Create data collection instruments
- Define metadata and documentation standards

**Stage 2: Collection (Active Research)**

- Collect data per approved protocols
- Ensure data quality (validation, cleaning)
- Document data sources and methods
- Maintain audit trails
- Store in secure, backed-up systems

**Stage 3: Analysis (During Study)**

- Create analysis datasets (derived variables, merged files)
- Document all data transformations and analyses
- Maintain version control
- Prepare data for sharing (de-identification if needed)
- Ensure reproducibility (code, syntax files)

**Stage 4: Sharing & Publication (Post-Study)**

- Deposit data in appropriate repositories
- Create comprehensive data dictionaries and codebooks
- Obtain DOI for dataset (persistent identifier)
- Link data to publications
- Respond to data requests per sharing policy

**Stage 5: Archiving (Long-term Preservation)**

- Migrate data to long-term storage formats (non-proprietary)
- Maintain documentation and metadata
- Ensure discoverability (catalog, registry)
- Retain per funder/IRB requirements (minimum 7 years)
- Plan for eventual destruction or permanent archiving

---

## Part 2: Data Management Plans (DMPs)

### 2.1 DMP Requirements by Funder

**NIH (National Institutes of Health):**

- **Required:** Yes, for all applications since 2023
- **Timing:** Submitted with grant application
- **Page Limit:** 2 pages (Genomic Data Sharing Plan may be additional)
- **Key Elements:**
  - Data types and formats
  - Metadata, standards, and data dictionaries
  - Data sharing timeline and repositories
  - Access, distribution, and reuse policies
  - Plans for archiving and preservation
- **Review:** Scored as part of scientific merit
- **Repository Suggestions:** dbGaP (genomic), ClinicalTrials.gov, NHLBI BioLINCC

**PCORI (Patient-Centered Outcomes Research Institute):**

- **Required:** Yes
- **Key Elements:** Similar to NIH plus patient engagement in data decisions
- **Unique Requirement:** Make data available within 1 year of study completion

**Alpha-1 Foundation:**

- **Required:** Not formally, but recommended
- **Preference:** Share with AlphaNet registry, collaborate with other Alpha-1 researchers

**Private Foundations (Gates, Robert Wood Johnson, etc.):**

- **Varies by funder:** Check specific requirements
- **Trend:** Increasing expectation of data sharing and open science

**Internal Foundation Projects (No External Funding):**

- **Required:** Recommended for all research, even if not externally mandated
- **Purpose:** Ensures quality, reproducibility, and future use

### 2.2 DMP Template

**Mark Egly Foundation - Data Management Plan Template**

**1. Data Description**

- Types of data generated (surveys, clinical measures, biospecimens, genomic, images)
- Formats and standards (CSV, SPSS, DICOM, FASTQ)
- Volume and scale (number of participants, variables, size in GB/TB)
- Relationship to existing data (linkage with registries, public datasets)

**2. Metadata & Documentation**

- Metadata standards used (Dublin Core, DataCite, domain-specific)
- Data dictionaries and codebooks (variable names, definitions, codes)
- Protocols and procedures documentation
- Informed consent language regarding data use

**3. Data Storage & Security**

- Storage location during active study (REDCap, secure servers, cloud)
- Security measures (encryption, access controls, authentication)
- Backup frequency and location (daily, off-site)
- Compliance frameworks (HIPAA, FISMA, ISO 27001)

**4. Data Sharing & Access**

- Timeline for sharing (immediately upon publication, 1 year post-study, embargo period)
- Repository selection (domain-specific, institutional, general like Zenodo)
- De-identification methods (remove direct identifiers, date shifting, aggregation)
- Access controls (open, embargoed, controlled-access via DUA)
- Intellectual property and licensing (CC0, CC-BY, proprietary)

**5. Long-term Preservation**

- Archive repository (institutional, domain-specific, national archives)
- Data retention period (minimum 7 years, 10 years, indefinite)
- File format migration plans (to non-proprietary formats like CSV, XML)
- Sustainability and funding for long-term preservation

**6. Roles & Responsibilities**

- Data Manager: Oversees data quality, security, documentation
- PI/Investigator: Responsible for DMP compliance, final approval
- IT Support: Maintains infrastructure, backups, security
- Data Governance Committee: Reviews and approves sharing requests

**7. Budget & Resources**

- Personnel effort (Data Manager, analyst)
- Storage and repository costs
- Data sharing platform fees
- De-identification and data preparation labor

### 2.3 DMP Tools & Resources

**DMPTool (dmptool.org) - RECOMMENDED:**

- **FREE** online tool for creating DMPs
- Templates for all major funders (NIH, NSF, PCORI, etc.)
- Institution-specific guidance (if affiliated with university)
- Collaboration features (multiple authors)
- Export to PDF, Word, JSON

**DMPonline (dmponline.dcc.ac.uk):**

- UK-based alternative to DMPTool
- Similar features, international funder templates

**Funder Templates:**

- NIH: Download from grants.nih.gov
- PCORI: Available on pcori.org
- Alpha-1 Foundation: Request from grants@alpha1.org

---

## Part 3: Data Repositories & Storage

### 3.1 Data Repository Options

**Domain-Specific Repositories (RECOMMENDED for Alpha-1 research):**

| Repository                                       | Best For                         | Cost | Features                                                     | Limitations                                            |
| ------------------------------------------------ | -------------------------------- | ---- | ------------------------------------------------------------ | ------------------------------------------------------ |
| **dbGaP** (Database of Genotypes and Phenotypes) | Genomic data with phenotypes     | FREE | NIH-approved, long-term preservation, DOI, controlled access | Requires NIH funding or approval, complex submission   |
| **ClinicalTrials.gov**                           | Clinical trial results           | FREE | Required for trials, public, searchable                      | Limited to interventional studies, basic results only  |
| **NHLBI BioLINCC**                               | Cardiovascular and lung research | FREE | NIH repository, curated, supports secondary analysis         | Must be NHLBI-funded, extensive documentation required |
| **Orphadata**                                    | Rare disease data                | FREE | International rare disease database, FAIR-compliant          | Limited to rare diseases, European focus               |

**General Research Repositories:**

| Repository                       | Best For                             | Cost                                | Features                                                      | Limitations                                          |
| -------------------------------- | ------------------------------------ | ----------------------------------- | ------------------------------------------------------------- | ---------------------------------------------------- |
| **Zenodo**                       | Small datasets, publications         | FREE (up to 50 GB/dataset)          | DOI, version control, GitHub integration, EU-based            | 50 GB per dataset limit, not health data specialized |
| **Figshare**                     | Figures, small datasets, supplements | FREE (20 GB/month) or $7-$249/month | DOI, metrics, embeddable, altmetrics                          | Storage limits on free tier, not HIPAA-compliant     |
| **Dryad**                        | Associated with journal publications | $120/submission                     | DOI, peer-reviewed datasets, long-term preservation           | Cost per dataset, limited to published data          |
| **Open Science Framework (OSF)** | Full project lifecycle               | FREE (5 GB) or $5-$60/month         | Preregistration, collaboration, version control, integrations | Not specialized for health data, storage limits      |

**Institutional Repositories:**

- University of Pittsburgh D-Scholarship
- Penn State ScholarSphere
- CMU's Research Showcase
- **Advantages:** FREE, long-term commitment, university support
- **Limitations:** Requires university affiliation, variable features

**Commercial Cloud Storage (NOT RECOMMENDED for primary repository):**

- Dropbox, Google Drive, OneDrive
- **Use Case:** Temporary file sharing, collaboration during active study
- **Not Suitable:** Long-term archiving, not designed for research data, no DOI

### 3.2 Repository Selection Criteria

**Choose Repository Based On:**

1. **Funder Requirements:**
   - NIH-funded? → dbGaP (genomic) or NHLBI BioLINCC (lung data)
   - PCORI-funded? → They recommend domain-specific or institutional
   - No funder mandate? → Choose based on data type and community norms

2. **Data Type:**
   - Genomic/genetic data → dbGaP
   - Clinical trial results → ClinicalTrials.gov (required) + supplement in Zenodo
   - Survey data, patient-reported outcomes → Zenodo, OSF, institutional
   - Medical images → TCIA (The Cancer Imaging Archive) or domain-specific

3. **Access Control Needs:**
   - Open data (de-identified, no concerns) → Zenodo, Dryad, Figshare
   - Controlled access (sensitive, requires DUA) → dbGaP, institutional with access controls
   - Embargo period (need delayed release) → Dryad, Zenodo (set embargo date)

4. **Cost:**
   - FREE options: Zenodo (up to 50 GB), OSF (5 GB), dbGaP, institutional
   - Paid if needed: Dryad ($120/dataset), Figshare ($7-$249/month), AWS S3 (variable)

5. **Discoverability:**
   - DOI assignment (persistent identifier): All major repositories
   - Indexed by Google Dataset Search: Zenodo, Dryad, Figshare
   - Community-specific: dbGaP for genomics researchers

**Recommendation for Mark Egly Foundation:**

- **Primary:** Zenodo for most datasets (FREE, easy, DOI)
- **Secondary:** dbGaP for any genomic data (if/when generated)
- **Tertiary:** University institutional repository if partnership established
- **Supplemental:** OSF for project management and pre-publication materials

### 3.3 Data Storage During Active Research

**For Patient Registry (See Doc #14):**

- **Platform:** REDCap (HIPAA-compliant, secure)
- **Backup:** Daily automated backups by REDCap host
- **Access:** Role-based, minimum necessary
- **Cost:** $0 (university partner) or $5,000-$10,000/year (cloud)

**For Other Research Projects:**

**Option 1: University Research Storage (RECOMMENDED if partnership exists):**

- **Provider:** Pitt, Penn State, CMU research computing
- **Cost:** Often FREE or low-cost for partners
- **Capacity:** TBs available
- **Features:** Automated backups, HIPAA-compliant options, technical support
- **Example:** Pitt CRC Storage ($0-$100/TB/year for collaborators)

**Option 2: Commercial Cloud (HIPAA-compliant tier):**

- **AWS S3 with HIPAA BAA:** $23/TB/month (~$276/TB/year)
- **Microsoft Azure HIPAA:** $20/TB/month (~$240/TB/year)
- **Google Cloud Healthcare API:** $26/TB/month (~$312/TB/year)
- **Pros:** Scalable, reliable, integrated services
- **Cons:** Cost adds up, requires IT expertise to configure securely

**Option 3: On-Premises Server:**

- **Cost:** $5,000-$15,000 hardware + $2,000-$5,000/year maintenance
- **Pros:** One-time purchase, local control
- **Cons:** Requires IT staff, physical security, backup complexity, not recommended for small org

**Recommendation:** University research storage if partnership established, otherwise AWS S3 or Azure with BAA for HIPAA compliance. Budget $500-$2,000/year for 1-5 TB research data.

---

## Part 4: Data Sharing Policies

### 4.1 FAIR Data Principles

**Guiding Framework:** Make data **Findable, Accessible, Interoperable, Reusable**

**Findable:**

- Assign persistent identifiers (DOI)
- Rich metadata describing dataset
- Indexed in searchable resources (Google Dataset Search, DataCite)

**Accessible:**

- Retrievable via standard protocols (HTTP, FTP)
- Metadata always accessible, even if data restricted
- Clear access procedures (DUA, application process)

**Interoperable:**

- Use standard data formats (CSV, XML, JSON not proprietary)
- Employ shared vocabularies and ontologies
- Include qualified references to other datasets

**Reusable:**

- Clear data usage license (CC0, CC-BY, custom)
- Detailed provenance (how data was generated)
- Meet community standards (CONSORT, STROBE for study reporting)

### 4.2 Default Data Sharing Policy

**Mark Egly Foundation Research Data Sharing Policy (Template):**

**Principle:** The Mark Egly Foundation is committed to transparent and responsible data sharing to advance Alpha-1 research and improve patient outcomes.

**Scope:** Applies to all research conducted or funded by the Foundation.

**Default Position:** Data will be shared consistent with:

- Funder requirements
- Participant consent
- IRB approval
- Applicable regulations (HIPAA, state law)

**Sharing Timeline:**

- **Published research:** Data available upon publication or within 1 year of study completion, whichever is sooner
- **Unpublished research:** Data available within 2 years of study completion (to allow time for primary publications)
- **Embargo:** Up to 1 year embargo acceptable if justified (competitive advantage, ongoing analysis)

**Data to be Shared:**

- De-identified individual participant data underlying published findings
- Data dictionary and codebook
- Study protocol and analysis plan
- Informed consent form (template)

**Data NOT Shared:**

- Identifiable data (unless required by funder with explicit consent and security plan)
- Data for which consent was not obtained for sharing
- Commercially sensitive or proprietary data

**Access Mechanisms:**

- **Open Access:** For fully de-identified, non-sensitive data (via Zenodo, Dryad)
- **Controlled Access:** For sensitive data requiring Data Use Agreement (via dbGaP, institutional repository)

**Acceptable Use:**

- Secondary research purposes
- Validation of published findings
- Meta-analyses
- Educational purposes (with attribution)

**Prohibited Use:**

- Attempts to re-identify participants
- Commercial use without permission
- Malicious or unethical purposes

**Attribution:**

- Cite original publication
- Acknowledge Mark Egly Foundation and data contributors
- Follow repository citation standards

**Review Process:**

- Data sharing plan reviewed by Data Governance Committee before study start
- Data requests reviewed within 30 days
- Annual review of policy and practices

### 4.3 Data Use Agreements (DUAs)

**When DUA Required:**

- Controlled-access data (sensitive, not fully de-identified)
- Data containing genetic information
- Data with re-identification risk
- Funder or IRB requires DUA

**Key DUA Terms:**

**1. Purpose Limitation:**

- Data used only for approved research purposes
- No attempts to re-identify participants
- No redistribution without permission

**2. Security Requirements:**

- Store data on secure, encrypted systems
- Limit access to authorized personnel
- Report breaches immediately

**3. Publication and Attribution:**

- Acknowledge data source in publications
- Provide manuscript preprints to Foundation
- Co-authorship not required but considered case-by-case

**4. Term and Termination:**

- Typically 2-3 years, renewable
- Termination upon project completion or breach
- Data destruction or return at term end

**5. Intellectual Property:**

- Foundation retains ownership of data
- Recipient owns analyses and derived works
- Sharing of derived data requires Foundation approval

**DUA Template Sources:**

- NIH model DUA (for genomic data sharing)
- ICPSR (Inter-university Consortium for Political and Social Research) DUA
- Institutional templates (Pitt, Penn State)

---

## Part 5: Metadata & Documentation Standards

### 5.1 Metadata Standards

**Dublin Core (Simple, Widely Used):**

- **Title:** Dataset name
- **Creator:** PI, investigators, Foundation
- **Subject:** Keywords (Alpha-1, AATD, COPD, rare disease)
- **Description:** Study summary, data contents
- **Publisher:** Mark Egly Foundation
- **Contributor:** Funders, collaborators
- **Date:** Publication/release date
- **Type:** Dataset
- **Format:** CSV, SPSS, etc.
- **Identifier:** DOI
- **Source:** If derived from other data
- **Language:** English
- **Rights:** License (CC-BY-4.0, custom)

**DataCite (Research Data Specific):**

- Builds on Dublin Core
- Additional fields: Funder, Related Identifiers (linked publications), Geo-location
- Automatically generated when DOI assigned via Zenodo, Dryad, etc.

**Domain-Specific Standards:**

- **Clinical Trials:** CONSORT checklist, ClinicalTrials.gov schema
- **Genomics:** dbGaP metadata, MIAME (Minimum Information About a Microarray Experiment)
- **Patient Registries:** STROBE (Strengthening the Reporting of Observational Studies in Epidemiology)

**Minimum Metadata Requirements (Mark Egly Foundation):**

- Study title and brief description (2-3 sentences)
- Principal Investigator and contact
- Date range of data collection
- Number of participants/observations
- List of variables or data elements
- Data format(s)
- Related publications (if any)
- DOI or persistent URL
- License/usage terms
- Funding source

### 5.2 Data Dictionaries & Codebooks

**Purpose:** Document every variable in dataset for future users

**Required Elements:**

**Variable-Level Documentation:**
| Field | Description | Example |
|-------|-------------|---------|
| Variable Name | Short name in dataset | `age_dx` |
| Label | Full descriptive label | Age at Alpha-1 Diagnosis |
| Type | Data type | Numeric, String, Date, Boolean |
| Format | Specific format | Integer, YYYY-MM-DD, 0/1 |
| Units | Measurement units | Years, mg/dL, % predicted |
| Valid Range | Acceptable values | 18-90, 0-200, 1/2/3/4 |
| Missing Codes | How missing represented | -99 (refused), -88 (don't know), blank (not asked) |
| Derivation | How calculated | `age_dx = dx_date - birth_date (in years)` |
| Notes | Special considerations | "Self-reported, not verified" |

**Categorical Variable Codes:**
| Variable | Code | Label |
|----------|------|-------|
| `gender` | 1 | Male |
| `gender` | 2 | Female |
| `gender` | 3 | Non-binary |
| `gender` | 4 | Prefer not to answer |
| `genotype` | 1 | PI*ZZ |
| `genotype` | 2 | PI*SZ |
| `genotype` | 3 | PI\*MZ |
| `genotype` | 4 | Other |

**Study-Level Documentation (README file):**

- Study purpose and design
- Inclusion/exclusion criteria
- Recruitment methods
- Data collection procedures
- Quality control measures
- Known data issues or limitations
- Versioning and change log
- Citation and acknowledgment
- Contact for questions

**Tools for Creating Data Dictionaries:**

- **Excel/CSV:** Simple, universally readable
- **REDCap:** Auto-generates data dictionary from database
- **R (dataMeta package):** Programmatic data dictionary creation
- **Stata (.do file):** Label variables and values in code
- **SPSS syntax:** Save variable and value labels

### 5.3 Version Control & Provenance

**Version Control for Data:**

- **Version Numbering:** Use semantic versioning (v1.0, v1.1, v2.0)
  - Major version (v2.0): Significant changes (new variables, changed definitions)
  - Minor version (v1.1): Small changes (corrected errors, added documentation)
- **Change Log:** Document all changes, date, reason
- **Example:**
  ```
  Version 1.0 (2025-01-15): Initial release, 150 participants
  Version 1.1 (2025-03-20): Corrected 5 age miscodes, no new data
  Version 2.0 (2025-06-30): Added 50 participants, added liver enzyme variables
  ```

**Version Control for Code:**

- **Git/GitHub:** For analysis scripts (R, Python, Stata syntax)
- Commit messages: Describe what changed
- Tag releases: Match data version (v1.0 code for v1.0 data)

**Provenance Documentation:**

- **Raw Data → Cleaned Data:** Document all transformations
  - "Removed 3 participants with invalid dates"
  - "Recoded missing (-99) to NA"
  - "Calculated BMI from height and weight"
- **Cleaned Data → Analysis Data:** Document subsetting, merging
  - "Selected only participants with lung disease (N=120 from 150 total)"
  - "Merged with pharmacy claims data on patient ID"
- **Analysis Data → Results:** Link to specific analysis scripts and versions
  - "Table 1 generated by `descriptive_stats_v1.R` on 2025-07-15"

---

## Part 6: Collaborative Research Agreements

### 6.1 Types of Research Collaborations

**Type 1: Data Sharing Only (External Researcher Requests Foundation Data):**

- **Agreement:** Data Use Agreement (DUA)
- **Foundation Provides:** De-identified dataset, data dictionary
- **Researcher Provides:** Research proposal, IRB approval, DUA signed
- **Authorship:** Not required, but acknowledgment expected
- **Timeline:** Typically 2-3 year DUA term

**Type 2: Joint Research Project (Co-Investigators):**

- **Agreement:** Memorandum of Understanding (MOU) or Research Collaboration Agreement
- **Both Parties:** Co-develop research question, share resources, co-author publications
- **Funding:** Determined in MOU (joint application, cost-sharing, or one party funds)
- **IP:** Shared or negotiated
- **Timeline:** Project duration, typically 2-5 years

**Type 3: Foundation Funds External Researcher:**

- **Agreement:** Grant Agreement or Contract
- **Foundation:** Provides funding and potentially data access
- **Researcher:** Conducts study, submits reports, shares data with Foundation
- **Authorship:** Researcher primary, Foundation may be co-author
- **IP:** Defined in agreement (usually researcher owns with Foundation use rights)

**Type 4: Industry-Sponsored Research (Pharmaceutical Company):**

- **Agreement:** Research Sponsored Agreement (complex, legal review required)
- **Company:** Provides funding, potentially study drug/product
- **Foundation:** Provides patient registry access, recruitment support
- **Authorship:** Negotiated, avoid ghost authorship
- **IP:** Company often retains, Foundation negotiates data access for participants
- **COI:** Disclose in all publications, ensure research independence (see Doc #8)

### 6.2 Key Agreement Terms

**Scope of Work:**

- Specific research aims and questions
- Deliverables (datasets, reports, publications)
- Timeline and milestones

**Data Ownership:**

- Who owns collected data? (Foundation retains ownership typical)
- Who owns analyses and results? (Usually collaborator)
- Rights to use data in future projects?

**Intellectual Property:**

- Patents, inventions, discoveries
- Usually: Each party owns their own IP, joint IP shared
- Commercial rights negotiated

**Publication Rights:**

- Who can publish? (Typically all parties)
- Review period before publication (30-60 days)
- Authorship determination (follow ICMJE guidelines)
- Acknowledgment requirements

**Confidentiality:**

- What information is confidential?
- Term of confidentiality (typically 3-5 years)
- Exceptions (public information, independently developed)

**Indemnification & Liability:**

- Each party responsible for their own actions
- Malpractice insurance for clinical research
- Compliance with regulations

**Termination:**

- Conditions for termination (breach, mutual agreement, funding ends)
- Data disposition upon termination (return, destroy, or retain per DUA)

**Governing Law:**

- State law (typically Pennsylvania for Mark Egly Foundation)

### 6.3 Template Agreements

**Simple DUA (For Non-Sensitive, De-identified Data):**

- 2-3 pages
- Standard terms (purpose limitation, security, attribution, no re-identification)
- Can be click-through for fully open data

**Standard DUA (For Controlled-Access Data):**

- 5-10 pages
- Detailed terms, countersignature required
- Review by Data Governance Committee

**Research Collaboration Agreement (Joint Projects):**

- 10-20 pages
- Comprehensive terms (scope, funding, IP, publication, termination)
- Legal review required
- Example sources: Pitt CTSI templates, NIH model agreements

**Pharmaceutical Sponsored Research Agreement:**

- 20-50 pages, complex
- **MUST have legal counsel review**
- Negotiate carefully: publication rights, data access, COI management
- See Document #8 for pharmaceutical partnership COI safeguards

---

## Part 7: Compliance & Regulations

### 7.1 HIPAA Compliance for Research

**HIPAA Privacy Rule:**

- Applies when handling Protected Health Information (PHI)
- 18 HIPAA identifiers must be removed for de-identification
- Business Associate Agreement (BAA) required with data processors

**De-identification Methods:**

**Safe Harbor Method (Remove 18 Identifiers):**

1. Names
2. Geographic subdivisions smaller than state (except first 3 digits of ZIP if population >20,000)
3. All dates (except year)
4. Telephone numbers
5. Fax numbers
6. Email addresses
7. Social Security Numbers
8. Medical record numbers
9. Health plan numbers
10. Account numbers
11. Certificate/license numbers
12. Vehicle identifiers
13. Device identifiers/serial numbers
14. Web URLs
15. IP addresses
16. Biometric identifiers
17. Full-face photos
18. Any other unique identifying numbers/codes

**Expert Determination Method:**

- Statistician certifies low risk of re-identification
- More flexible than Safe Harbor
- Allows retention of more granular data (dates, ZIP codes)
- Requires documentation

**Limited Data Set (LDS):**

- Removes direct identifiers but keeps dates, ZIP codes, ages >89
- Requires Data Use Agreement
- Commonly used in research

**HIPAA Authorization:**

- For sharing identifiable data
- Participant signs specific authorization for research use
- Must describe data to be shared and recipients

### 7.2 Genomic Data Sharing (NIH Policy)

**NIH Genomic Data Sharing (GDS) Policy (Effective 2015):**

- **Applies to:** All NIH-funded research generating large-scale genomic data
- **Requirement:** Share data via dbGaP or approved repository
- **Timeline:** Submit within 6 months of study completion or manuscript acceptance
- **Access:** Controlled access via dbGaP application
- **Informed Consent:** Must allow broad data sharing

**Genomic Data Types Covered:**

- Genome-wide association studies (GWAS)
- Whole genome sequencing (WGS)
- Whole exome sequencing (WES)
- RNA sequencing (RNA-seq)

**Exemptions:**

- Small-scale genomic data (e.g., single gene sequencing)
- Data for which consent does not allow sharing
- Data with identifiability concerns that cannot be mitigated

**If Mark Egly Foundation Conducts Genomic Research:**

- Obtain broad consent at enrollment for future data sharing
- Budget for dbGaP submission costs ($10,000-$30,000 for curation)
- Plan 6-12 months for dbGaP submission process
- Work with experienced genomic data manager or consultant

### 7.3 International Data Transfers

**GDPR (EU General Data Protection Regulation):**

- **Applies if:** Foundation has EU participants or collaborators
- **Key Requirements:**
  - Explicit consent for data processing and transfer
  - Data Protection Impact Assessment (DPIA)
  - Lawful basis for international transfer (adequacy decision, Standard Contractual Clauses)
  - Right to be forgotten (data erasure)
  - Data portability

**Schrems II Decision (2020):**

- Invalidated EU-US Privacy Shield
- Use Standard Contractual Clauses (SCCs) for EU-US data transfers
- Conduct Transfer Impact Assessment (TIA)

**Recommendation:**

- Avoid collecting data from EU unless necessary
- If EU participants, work with GDPR consultant
- Use SCC templates from EU Commission
- Budget $5,000-$15,000 for GDPR compliance if applicable

---

## Part 8: Training & Support

### 8.1 Training Requirements

**All Research Staff:**

- HIPAA Privacy and Security training (annual)
- Good Clinical Practice (GCP) if conducting clinical research (every 3 years)
- Human Subjects Research (CITI or NIH training, every 3 years)
- Data security awareness (annual)

**Data Managers & Research Coordinators:**

- Data management best practices (DMPTool, NIH courses)
- REDCap training (if using REDCap)
- Data de-identification techniques
- Secure file transfer protocols
- Metadata standards

**Principal Investigators:**

- Responsible Conduct of Research (RCR) (every 4 years)
- Data sharing policies and requirements
- Conflict of interest management

**Training Resources:**

**FREE Online Training:**

- **NIH:** Data Sharing training modules (grants.nih.gov/learning)
- **CITI Program:** Data management courses (citiprogram.org)
- **MANTRA:** Research Data Management Training (mantra.edina.ac.uk)
- **DataOne:** Data Management Education Modules (dataone.org/education-modules)

**University Courses (If Partnership Exists):**

- Pitt: HSLS Data Management Workshops
- Penn State: Data Management LibGuides
- CMU: Research Data Management Services

**Paid Training:**

- Society for Clinical Research Associates (SoCRA): $200-$500/course
- Association of Clinical Research Professionals (ACRP): $300-$1,000/course

**Budget:** $500-$2,000/year for staff training

### 8.2 Ongoing Support

**Data Management Support:**

- **Internal:** Data Manager (0.25-0.5 FTE) provides ongoing guidance
- **External:** University librarians (data management consultations often FREE)
- **Consultant:** Hire data management consultant for complex projects ($100-$200/hour)

**IRB & Compliance Support:**

- **University IRB:** If partnership established, IRB staff available for questions
- **Independent IRB:** Advarra, WCG offer support with application
- **Legal Counsel:** For contracts, DUAs, compliance questions ($200-$400/hour)

**IT & Security Support:**

- **University Research Computing:** Technical support for storage, servers, backup (if partnership)
- **Cloud Provider Support:** AWS, Azure have research support programs
- **Cybersecurity Consultant:** Annual security audit recommended ($2,000-$5,000)

**Budget:** $2,000-$8,000/year for consulting and support

---

## Part 9: Budget & Implementation

### 9.1 Detailed Budget (Year 1)

**Personnel:**
| Role | Time | Annual Cost |
|------|------|-------------|
| Data Manager / Research Coordinator | 0.25-0.5 FTE | $12,000-$25,000 |
| IT Support (contract or shared) | 0.1 FTE | $3,000-$8,000 |
| Legal Consultation (DUAs, agreements) | 10-20 hours | $2,000-$8,000 |
| **Personnel Subtotal** | | **$17,000-$41,000** |

**Technology & Infrastructure:**
| Item | Annual Cost |
|------|-------------|
| Data storage (cloud or university) | $500-$5,000 |
| Repository deposits (if Dryad used) | $0-$500 |
| Backup systems and disaster recovery | $500-$2,000 |
| Security tools (encryption, VPN, 2FA) | $500-$1,500 |
| **Technology Subtotal** | **$1,500-$9,000** |

**Compliance & Governance:**
| Item | Cost |
|------|------|
| HIPAA compliance assessment | $1,000-$3,000 |
| Cybersecurity audit | $2,000-$5,000 |
| Data Governance Committee (stipends) | $0-$2,000 |
| **Compliance Subtotal** | **$3,000-$10,000** |

**Training & Professional Development:**
| Item | Cost |
|------|------|
| Staff training (CITI, GCP, data management) | $500-$2,000 |
| Conference attendance (data management, research integrity) | $1,000-$3,000 |
| Subscriptions (DMPTool premium, DataCite) | $0-$500 |
| **Training Subtotal** | **$1,500-$5,500** |

**Consulting & Expertise:**
| Item | Cost |
|------|------|
| Data management consultant | $2,000-$5,000 |
| Genomic data specialist (if applicable) | $0-$10,000 |
| GDPR consultant (if EU data) | $0-$5,000 |
| **Consulting Subtotal** | **$2,000-$20,000** |

### 9.2 Budget Scenarios

**Minimal Budget ($10,000-$15,000) - Basic Framework:**

- Data Manager (0.25 FTE): $12,000
- University storage partnership: $0
- DIY data dictionaries and DMPs: $0
- FREE training (NIH, CITI): $0
- Minimal compliance (self-assessment): $500
- **Total: ~$12,500**
- **Sufficient for:** Small-scale research, internal quality improvement, basic data organization

**Moderate Budget ($25,000-$40,000) - RECOMMENDED:**

- Data Manager (0.5 FTE): $25,000
- Cloud storage + repository: $2,000
- HIPAA compliance assessment: $2,000
- Staff training: $1,500
- Legal consultation for DUAs: $3,000
- Data management consultant: $3,000
- IT support (shared): $5,000
- **Total: ~$41,500**
- **Sufficient for:** Multiple research projects, patient registry, external collaborations, grant-funded research

**Optimal Budget ($50,000-$75,000) - Comprehensive Program:**

- Full-time Data Manager: $50,000
- Dedicated IT support: $8,000
- Robust compliance program: $10,000
- Comprehensive training: $5,000
- Legal counsel retainer: $8,000
- Genomic data specialist: $10,000
- GDPR compliance (if needed): $5,000
- **Total: ~$96,000**
- **Sufficient for:** Large research portfolio, NIH-funded research, genomic studies, international collaborations, mature research infrastructure

**Recommendation:** Start with minimal budget ($12.5K), scale to moderate ($41.5K) as research grows, plan for optimal ($96K) if pursuing major external funding (NIH R01 scale).

### 9.3 Ongoing Costs (Years 2-5)

**Annual Operating Budget:**

- Data Manager: $12,000-$50,000 (0.25-1.0 FTE depending on portfolio)
- Storage and repository: $500-$5,000
- Compliance audits: $1,000-$3,000
- Training: $500-$2,000
- IT support: $3,000-$8,000
- Legal consultation: $1,000-$5,000
- **Total Years 2-5: $18,000-$73,000/year**

**Five-Year Total: $100,000-$350,000** (depending on research intensity)

---

## Part 10: Implementation Roadmap

### 10.1 Phase 1: Foundation (Months 1-3)

**Month 1: Assessment & Planning**

- Inventory current data and research projects
- Assess current data management practices (strengths and gaps)
- Hire or assign Data Manager (0.25-0.5 FTE)
- Form Data Governance Committee (5-7 members)
- Review funder requirements (NIH, PCORI, Alpha-1 Foundation)

**Month 2: Policy Development**

- Draft data governance policies
- Develop data classification system (Public, Internal, Confidential, PHI)
- Create data sharing policy template
- Draft DUA templates (simple and standard)
- Establish metadata standards

**Month 3: Infrastructure Setup**

- Select and set up data storage solution (university or cloud)
- Establish backup and disaster recovery procedures
- Set up DMPTool account for DMP creation
- Create Zenodo account for data deposition
- Conduct initial HIPAA and security assessment

### 10.2 Phase 2: Implementation (Months 4-6)

**Month 4: Training & Rollout**

- Train staff on data management policies
- Train staff on DMP creation using DMPTool
- Train staff on REDCap or data storage systems
- Create Data Management SOP (Standard Operating Procedures) manual
- Pilot data management framework on one project

**Month 5: Documentation & Templates**

- Create data dictionary templates
- Develop README file templates
- Create versioning and change log procedures
- Establish codebook standards
- Build library of example DMPs

**Month 6: Review & Refinement**

- Data Governance Committee reviews framework
- Collect staff feedback on usability
- Refine policies and procedures based on lessons learned
- Conduct first compliance audit
- Present to Board of Directors

### 10.3 Phase 3: Maturity (Months 7-12)

**Ongoing Activities:**

- Implement DMPs for all new research projects
- Deposit completed datasets in repositories
- Respond to external data requests per policy
- Maintain documentation and metadata
- Quarterly Data Governance Committee meetings

**Year-End Milestones:**

- 100% of active research projects have current DMPs
- 100% of completed studies have data archived
- At least 1 dataset deposited in public repository (Zenodo)
- Data sharing policy operational with 2-3 external requests processed
- Annual compliance and security audit completed
- Staff proficient in data management practices

### 10.4 Years 2-5: Continuous Improvement

**Year 2:**

- Expand to include genomic data management (if applicable)
- Establish partnerships with additional universities or repositories
- Publish first dataset in peer-reviewed data journal
- Add Spanish language documentation (if working with Hispanic/Latino patients)

**Year 3:**

- Evaluate and upgrade data storage as needed
- Implement advanced metadata standards (DataCite, domain-specific)
- Collaborate with Alpha-1 Foundation on harmonized data standards
- Pursue external funding for research data infrastructure (NIH R24, CTSA)

**Year 4-5:**

- Mature data governance program with 20+ datasets archived
- Recognized as leader in Alpha-1 research data sharing
- Multiple external collaborations using Foundation data
- Self-sustaining through grant indirect costs and partnerships

---

## Part 11: Success Metrics

### 11.1 Key Performance Indicators (KPIs)

**Data Management Plan Compliance:**

- **Year 1 Target:** 80% of research projects have written DMP
- **Year 3 Target:** 100% of projects have DMP before data collection starts
- **Measure:** % of projects with approved DMP in project files

**Data Archiving & Preservation:**

- **Year 1 Target:** 50% of completed studies archived in repository
- **Year 3 Target:** 100% of completed studies archived within 1 year of completion
- **Measure:** % of eligible studies with DOI-assigned dataset

**Data Sharing Requests:**

- **Year 1 Target:** Respond to 100% of requests within 60 days
- **Year 3 Target:** Respond within 30 days, approve 70%+ of requests
- **Measure:** Average response time, % approved vs. denied

**Compliance:**

- **Year 1 Target:** 0 HIPAA breaches, 100% staff trained
- **Year 3 Target:** Maintain 0 breaches, annual compliance audits with no major findings
- **Measure:** Breach incidents, audit findings, training completion rates

**Collaboration & Impact:**

- **Year 1 Target:** 1-2 external collaborations using Foundation data
- **Year 3 Target:** 5-10 active collaborations, 3-5 publications citing Foundation data
- **Measure:** Number of active DUAs, publications citing datasets

**Researcher Satisfaction:**

- **Year 1 Target:** 70% of researchers rate data management support as "good" or "excellent"
- **Year 3 Target:** 85%+ satisfaction
- **Measure:** Annual survey of PIs and research staff

### 11.2 Impact Assessment

**Scientific Impact:**

- Publications using Foundation data
- Citations of datasets (via DOI)
- Collaborations with external researchers
- Contributions to Alpha-1 knowledge base

**Patient Impact:**

- Research findings improving patient care
- Patient engagement in research decisions
- Patients' data contributing to scientific discoveries
- Community awareness of Foundation's research role

**Organizational Impact:**

- Grant funding success (good DMPs support applications)
- Reputation as research-capable organization
- Partnerships with universities and institutions
- Efficiency gains from organized data management

---

## Appendix A: Data Management Plan Example (Abbreviated)

**Mark Egly Foundation Patient Registry - Data Management Plan**

**1. Data Description:**
The Mark Egly Foundation Patient Registry collects longitudinal data on adults with Alpha-1 Antitrypsin Deficiency. Data types include:

- Patient-reported outcomes (surveys via REDCap): SGRQ, CAT, PHQ-4, COST-FACIT
- Clinical data (from medical records): FEV1, liver enzymes, hospitalizations
- Sociodemographic data: Age, gender, education, insurance, ZIP code
- Foundation service utilization: Financial assistance, events, support groups

**Expected Scale:** 100-200 participants Year 1, 300-500 by Year 5. Approximately 50 variables per participant, 3-5 timepoints (baseline, 6-month, annual). Total dataset size: ~5-10 MB (primarily survey data, no images).

**Data Formats:** CSV (primary), SPSS (.sav for backup), REDCap XML (data dictionary).

**2. Metadata & Documentation:**

- REDCap auto-generates data dictionary with variable names, labels, codes, and logic
- Study protocol document describes recruitment, inclusion/exclusion, procedures
- Codebook includes all variable definitions and response options
- README file describes dataset structure, known issues, and change log
- Metadata follows DataCite schema for repository deposit

**3. Data Storage & Security:**

- **Active Study:** REDCap hosted by University of Pittsburgh (HIPAA-compliant, encrypted, daily backups)
- **Access:** Role-based permissions (PI, Registry Coordinator, Data Manager). Participants access via unique login.
- **Security:** Two-factor authentication, audit trails, annual security assessment
- **Backup:** Daily automated backups by REDCap host, retained for 30 days rolling

**4. Data Sharing & Access:**

- **Timeline:** De-identified limited dataset shared within 1 year of primary publication or 2 years post-study completion
- **Repository:** Zenodo (public) for de-identified data; REDCap (controlled access) for limited dataset requiring DUA
- **De-identification:** Remove direct identifiers per HIPAA Safe Harbor, retain dates and 3-digit ZIP codes (limited dataset)
- **Access:** Open access for fully de-identified data with data dictionary; controlled access (DUA required) for limited dataset with dates/ZIP
- **License:** CC-BY-4.0 (attribution required)

**5. Long-term Preservation:**

- **Repository:** Zenodo (EU-based, committed to 20+ year preservation)
- **Format Migration:** Export to non-proprietary CSV format for long-term readability
- **Retention Period:** Indefinite (rare disease research has long-term value)
- **DOI:** Assigned by Zenodo for permanent citation
- **Version Control:** New versions deposited with updated DOI if substantial changes (v1.0, v2.0)

**6. Roles & Responsibilities:**

- **PI:** Oversees all research activities, approves data sharing requests
- **Registry Coordinator (0.5 FTE):** Day-to-day data management, data quality, documentation
- **Data Governance Committee:** Reviews and approves external data requests, ensures compliance
- **IT (University Partner):** Maintains REDCap, backups, security updates

**7. Budget:**

- REDCap hosting: $0 (university partnership)
- Registry Coordinator (data management): $12,500 (50% of 0.5 FTE allocated to data tasks)
- Zenodo deposit: $0 (free up to 50 GB)
- Data dictionary and documentation: Included in Coordinator time
- **Total: $12,500/year**

---

## Appendix B: Data Use Agreement Template (Abbreviated)

**MARK EGLY FOUNDATION - DATA USE AGREEMENT**

**Effective Date:** [Date]

**BETWEEN:**

- **Data Provider:** Mark Egly Foundation ("Foundation")
- **Data Recipient:** [Recipient Name, Institution] ("Recipient")

**PURPOSE:**
Recipient requests access to Foundation's [Dataset Name] for the following research purpose: [Brief description of research project].

**TERMS:**

**1. Data Provided:**
De-identified limited dataset including [list key variables]. Data dictionary and README included.

**2. Permitted Uses:**

- Research consistent with stated purpose
- Validation of published findings
- Educational purposes with attribution

**3. Prohibited Uses:**

- Re-identification attempts
- Commercial use without written permission
- Redistribution to third parties

**4. Security Requirements:**

- Store data on secure, encrypted systems
- Limit access to authorized personnel listed below
- Report breaches within 24 hours to [Foundation Contact]

**5. Publication:**

- Acknowledge Foundation in all publications: "Data provided by the Mark Egly Foundation"
- Cite dataset: [Dataset Citation with DOI]
- Provide manuscript preprint to Foundation 30 days before submission

**6. Term:** [Start Date] to [End Date] (typically 2-3 years), renewable with mutual agreement.

**7. Data Destruction:** Upon term end, Recipient will destroy or return data and certify destruction in writing.

**SIGNATURES:**

**Foundation:**
************\_************ Date: ****\_\_****
[Executive Director Name]
Mark Egly Foundation

**Recipient:**
************\_************ Date: ****\_\_****
[Recipient Name, Title]
[Institution]

**Authorized Personnel (Access List):**

1. [Name, Role]
2. [Name, Role]

---

## Document Approval

**Prepared by:** VLX AI Assistant
**Date:** November 2025
**Version:** 1.0
**Next Review:** Annually, or upon major policy changes (NIH updates, GDPR revisions)

**Approvers:**

- [ ] Executive Director
- [ ] Data Governance Committee Chair
- [ ] Legal Counsel (for DUA and collaboration agreement templates)
- [ ] Board Chair (for budget approval)

---

## 🎉 PHASE 2 EXPANSION COMPLETE! 🎉

_This is the FINAL document (15 of 15) in the Mark Egly Foundation Phase 2 Expansion series._

**Series Complete:**

1. ✅ Patient Assistance Program
2. ✅ Employee Giving Programs (Corporate Partners)
3. ✅ Support Group Operations Manual
4. ✅ Annual Fundraising Gala Planning
5. ✅ Community Walk/Run Event Management
6. ✅ Emergency Financial Assistance Fund
7. ✅ Similar Organizations Partnership Database
8. ✅ Pharmaceutical Company Partnership Framework
9. ✅ Genetic Testing Company Partnerships
10. ✅ Website Redesign & Information Architecture
11. ✅ Content Strategy & SEO Plan
12. ✅ Social Media Strategy
13. ✅ Email Marketing & Donor Communications
14. ✅ Patient Registry & Outcomes Tracking
15. ✅ **Research Data Management**

**Total Documentation: ~300,000 words across 15 comprehensive strategic planning documents**

_For questions or implementation support, contact the Mark Egly Foundation at info@markegly.org_
