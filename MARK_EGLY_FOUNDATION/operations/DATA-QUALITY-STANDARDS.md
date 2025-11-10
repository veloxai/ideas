# Data Quality Standards

**Document 15 of 37: Mark Egly Foundation Operations Manual**
**Topic 4: Quality Assurance (Document 2 of 4)**
**Version:** 1.0
**Last Updated:** November 2025
**Document Owner:** Chief Operating Officer & Registry Manager
**Review Cycle:** Semi-Annual (with continuous monitoring)

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Data Quality Framework](#data-quality-framework)
3. [Data Quality Dimensions](#data-quality-dimensions)
4. [Data Validation Rules](#data-validation-rules)
5. [Data Entry Standards and Procedures](#data-entry-standards-and-procedures)
6. [Duplicate Detection and Management](#duplicate-detection-and-management)
7. [Data Cleaning Procedures](#data-cleaning-procedures)
8. [Completeness Metrics and Standards](#completeness-metrics-and-standards)
9. [Accuracy Audits](#accuracy-audits)
10. [Interrater Reliability](#interrater-reliability)
11. [Data Quality Dashboard](#data-quality-dashboard)
12. [Data Entry Training Program](#data-entry-training-program)
13. [Data Quality Roles and Responsibilities](#data-quality-roles-and-responsibilities)
14. [Continuous Monitoring and Improvement](#continuous-monitoring-and-improvement)
15. [Data Quality Incident Management](#data-quality-incident-management)
16. [Tools and Technology](#tools-and-technology)
17. [Budget and Resources](#budget-and-resources)
18. [Conclusion](#conclusion)

---

## Executive Summary

The Mark Egly Foundation's Data Quality Standards establish rigorous protocols for ensuring the accuracy, completeness, consistency, and reliability of all data collected, stored, and analyzed by the Foundation. High-quality data is essential for credible research, effective program evaluation, and informed decision-making that serves the Alpha-1 community.

**Data Quality Philosophy:**

> **"Data quality is not a destination but a continuous process. Every data point represents a patient, a discovery opportunity, or a program outcome. We commit to treating data with the respect and rigor it deserves."**

**Key Principles:**

1. **Accuracy First**: Data must correctly represent the real-world entities and events it describes
2. **Completeness Matters**: Missing data undermines analysis; we strive for >95% completeness on critical fields
3. **Consistency Across Systems**: Data elements mean the same thing across all Foundation databases and reports
4. **Timeliness**: Data is entered and updated promptly to maintain relevance
5. **Validity**: Data conforms to defined formats, ranges, and business rules
6. **Auditability**: All data changes are tracked with user, timestamp, and reason
7. **Accessibility**: Quality data is available to authorized users when needed

**Scope of Data Quality Standards:**

This document covers quality standards for:

- **Patient Registry Data**: Demographics, diagnosis, clinical measures, outcomes, surveys
- **Research Data**: Grant applications, progress reports, publications, outcomes
- **Program Data**: Event attendance, education materials usage, awareness campaign metrics
- **Operational Data**: Donor records, volunteer information, financial transactions, website analytics
- **Compliance Data**: HIPAA audits, state registrations, contract tracking

**Data Quality Targets:**

| **Metric**                                 | **Year 1 Target** | **Year 2-3 Target** | **Year 4-5 Target** |
| ------------------------------------------ | ----------------- | ------------------- | ------------------- |
| **Critical Field Completeness**            | 90%               | 95%                 | 98%                 |
| **Data Accuracy Rate** (validation sample) | 95%               | 97%                 | 99%                 |
| **Duplicate Record Rate**                  | <2%               | <1%                 | <0.5%               |
| **Data Entry Error Rate**                  | <5%               | <3%                 | <1%                 |
| **Data Quality Score** (composite)         | 85/100            | 90/100              | 95/100              |

---

## Data Quality Framework

### Six Dimensions of Data Quality

**1. Accuracy**

- **Definition**: Data correctly represents reality; values are true and correct
- **Example**: Patient's birth date in registry matches birth certificate
- **Measurement**: Validation audits comparing database values to source documents

**2. Completeness**

- **Definition**: All required data fields are populated; no critical missing values
- **Example**: 98% of registry participants have diagnosis date recorded
- **Measurement**: % of required fields with non-null values

**3. Consistency**

- **Definition**: Data values are uniform across systems and time; no contradictions
- **Example**: Patient's Alpha-1 genotype is same in registry and research database
- **Measurement**: Cross-system data matching audits

**4. Validity**

- **Definition**: Data conforms to defined formats, ranges, and business rules
- **Example**: Diagnosis year is between 1970 and current year; ZIP code is valid US format
- **Measurement**: % of values passing validation rules

**5. Timeliness**

- **Definition**: Data is current and entered promptly after collection
- **Example**: Event attendance data entered within 2 business days
- **Measurement**: Avg. lag time from data collection to entry

**6. Uniqueness**

- **Definition**: No duplicate records exist for same real-world entity
- **Example**: Each patient has single registry record (not multiple IDs)
- **Measurement**: Duplicate detection rate

### Data Quality Lifecycle

**Phase 1: Design** → Define data elements, formats, validation rules

**Phase 2: Collection** → Capture data from patients, researchers, operations

**Phase 3: Entry** → Input data into databases following standards

**Phase 4: Validation** → Automated and manual checks verify quality

**Phase 5: Cleaning** → Identify and correct errors, fill missing values

**Phase 6: Monitoring** → Continuous tracking of quality metrics

**Phase 7: Improvement** → Analyze quality issues; implement preventive measures

---

## Data Quality Dimensions

### Accuracy Standards

**Accuracy Definition for Each Data Type:**

| **Data Type**                                 | **Accuracy Standard**                                      | **Verification Method**                              |
| --------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| **Patient Demographics**                      | 100% match to source document (ID, consent form)           | Dual data entry; annual audit of 10% sample          |
| **Clinical Data** (diagnosis, genotype, FEV1) | 99% match to medical records                               | Source verification for 25% sample; clinician review |
| **Survey Responses**                          | 100% match to submitted survey (no transcription errors)   | Direct electronic capture (no manual entry)          |
| **Financial Data**                            | 100% accuracy (no tolerance for financial errors)          | Monthly reconciliation; annual CPA audit             |
| **Contact Information**                       | 95% deliverable (emails don't bounce, mail doesn't return) | Quarterly validation using verification services     |
| **Publication Data**                          | 100% accurate citations                                    | PubMed verification; DOI lookup                      |

**Accuracy Audit Process:**

1. **Monthly**: Automated validation checks flag potential errors
2. **Quarterly**: Manual review of 5% random sample for each database
3. **Annually**: Comprehensive audit of 10% sample by independent data validator
4. **Ongoing**: User-reported errors logged and corrected within 2 business days

### Completeness Standards

**Critical Fields (95-100% Completeness Required):**

**Patient Registry:**

- Patient ID, enrollment date, consent date, consent type
- Birth year (not full date if patient prefers privacy), gender, state/country
- Alpha-1 genotype (if tested), diagnosis date
- Current email or phone (at least one contact method)

**Research Grants:**

- Grant ID, recipient name/institution, award amount, start/end dates
- Research aim, disease focus, methodology
- Progress reports (required annually), publication citations

**Donor Records:**

- Donor ID, full name, donation date, amount, payment method
- Mailing address (for tax receipts), email (if available)
- Campaign/appeal code, acknowledgment sent date

**Allowable Missing Data:**

Some fields inherently have missing data:

- **Clinical measures**: Not all patients have FEV1 (lung function) data if not recently tested
- **Outcome measures**: Patients who don't complete annual survey have missing outcome data
- **Historical data**: Legacy data may lack fields added after initial collection

**Handling Missing Data:**

1. **Distinguish Missing Types**:
   - **NA (Not Applicable)**: Field doesn't apply (e.g., "lung transplant date" for patient without transplant)
   - **Unknown**: Information exists but Foundation doesn't have it
   - **Refused**: Patient declined to provide (e.g., income)
   - **NULL**: Data should exist but wasn't collected (DATA QUALITY ISSUE)

2. **Minimize NULLs**: Target <5% NULL rate on required fields

3. **Document Missing Data Reasons**: Use codes/notes to explain why data missing

### Consistency Standards

**Consistency Rules:**

1. **Cross-Field Consistency Within Record**:
   - If patient is "pediatric" (age <18), must have parent/guardian consent
   - If genotype is "PI\*MZ", should have Alpha-1 diagnosis (not "unaffected")
   - If FEV1 < 50%, disease severity should be "moderate" or "severe"

2. **Temporal Consistency**:
   - Diagnosis date ≤ registry enrollment date
   - Birth year + age = current year (±1 year tolerance)
   - Death date (if present) > birth date

3. **Cross-System Consistency**:
   - Patient name/DOB in registry matches consent form in document system
   - Grant amounts in grants database match accounting system
   - Donor totals in CRM match financial records

**Consistency Checks:**

- **Real-Time**: Automated validation during data entry (e.g., alerts if enrollment date < diagnosis date)
- **Batch**: Nightly consistency checks flag violations for review
- **Quarterly**: Manual cross-system audits

### Validity Standards

**Format Validation:**

| **Field Type** | **Validation Rule**                             | **Example Valid**   | **Example Invalid** |
| -------------- | ----------------------------------------------- | ------------------- | ------------------- |
| **Email**      | Valid email format; no spaces                   | john.doe@email.com  | john doe@email      |
| **Phone**      | 10 digits (US); international format if non-US  | (555) 123-4567      | 555-123             |
| **ZIP Code**   | 5 or 9 digits (US); country-appropriate format  | 02134, 02134-5678   | 213                 |
| **Date**       | YYYY-MM-DD format; valid date                   | 2024-11-09          | 2024-13-45          |
| **Genotype**   | Must be from approved list (PI*MM, PI*MZ, etc.) | PI\*ZZ              | PIZ                 |
| **URL**        | Valid URL format; resolves (if critical)        | https://example.com | htp://example       |

**Range Validation:**

| **Field**              | **Valid Range**     | **Rationale**                                                |
| ---------------------- | ------------------- | ------------------------------------------------------------ |
| **Birth Year**         | 1900 - current year | Oldest living person ~120 years                              |
| **FEV1 (% predicted)** | 5-150%              | Below 5% incompatible with survival; >150% likely data error |
| **Diagnosis Age**      | 0-90 years          | Alpha-1 typically diagnosed 0-80; 90 allows outliers         |
| **Donation Amount**    | $1 - $10,000,000    | Below $1 likely error; above $10M requires special handling  |

**Controlled Vocabularies:**

Use standardized code sets to ensure validity:

- **Country**: ISO 3166-1 alpha-2 codes (US, CA, GB)
- **State**: USPS abbreviations (MA, CA, TX)
- **Ethnicity**: NIH categories (for research)
- **Disease Severity**: Foundation-defined scale (asymptomatic, mild, moderate, severe, very severe)
- **Genotype**: Alpha-1 Foundation-approved genotypes

### Timeliness Standards

**Data Entry Deadlines:**

| **Data Type**                          | **Entry Deadline**                            | **Consequence of Delay**                            |
| -------------------------------------- | --------------------------------------------- | --------------------------------------------------- |
| **Patient Registry Enrollment**        | Within 5 business days of consent             | Delays patient communications, survey invitations   |
| **Event Attendance**                   | Within 2 business days of event               | Delayed thank-you emails, inaccurate event reports  |
| **Donation**                           | Same business day (for timely acknowledgment) | IRS requirement for receipts; donor dissatisfaction |
| **Grant Application**                  | Within 2 business days of receipt             | Delays review process                               |
| **Clinical Data from Medical Records** | Within 10 business days of receipt            | Delays research studies needing current data        |

**Timeliness Monitoring**: Dashboard tracks avg. lag time for each data type; alerts if >20% of records exceed deadline.

---

## Data Validation Rules

### Automated Validation Rules

**Real-Time Validation (During Data Entry):**

Implemented in data entry forms to prevent errors at point of capture.

**Example Rules:**

1. **Required Field Check**: Cannot save record without completing all required fields
   - _Alert_: "Birth year is required. Please enter a valid year."

2. **Format Check**: Field must match expected format
   - _Alert_: "Email format invalid. Please enter a valid email address (e.g., name@example.com)."

3. **Range Check**: Value must be within acceptable range
   - _Alert_: "FEV1 value of 250% is outside valid range (5-150%). Please verify."

4. **Consistency Check**: Related fields must be logically consistent
   - _Alert_: "Diagnosis date (2025-05-01) is after enrollment date (2024-12-01). Please verify dates."

5. **Duplicate Check**: Check for potential duplicate based on name, DOB, email
   - _Alert_: "A record with similar name and birth year already exists. Is this the same person? [View existing record] [Proceed with new record]"

**Batch Validation (Nightly Automated Checks):**

Run after daily data entry closes; generate report of data quality issues.

**Example Nightly Checks:**

- Identify orphan records (e.g., survey response without matching patient record)
- Detect statistical outliers (values >3 standard deviations from mean)
- Flag records missing non-required but expected fields (e.g., phone number when email is missing)
- Check for stale data (e.g., contact info not updated in >2 years)

**Validation Report Format:**

| **Record ID** | **Issue Type** | **Field**    | **Current Value** | **Expected**              | **Severity** | **Assigned To**         |
| ------------- | -------------- | ------------ | ----------------- | ------------------------- | ------------ | ----------------------- |
| PT-00234      | Out of Range   | FEV1_percent | 220               | 5-150                     | High         | Registry Coordinator    |
| PT-00456      | Missing        | Phone        | NULL              | Not NULL if email missing | Medium       | Data Entry Staff        |
| DN-00789      | Format Error   | ZIP          | 213               | 5 or 9 digits             | Low          | Development Coordinator |

**Issue Resolution Timeline:**

- **High Severity**: Resolve within 2 business days
- **Medium Severity**: Resolve within 1 week
- **Low Severity**: Resolve within 1 month or next data cleaning cycle

### Business Logic Validation

**Complex Rules Requiring Domain Knowledge:**

1. **Clinical Logic**:
   - If genotype is PI\*ZZ (high risk), patient should have Alpha-1 diagnosis (not "carrier only" or "unaffected")
   - If patient has lung disease symptoms, should have pulmonary function test (FEV1) within last 2 years

2. **Research Logic**:
   - If grant is marked "completed," must have final report and publication data (or "no publications" with explanation)
   - If publication cites Foundation funding, grant ID must be linked

3. **Operational Logic**:
   - If donor gave >$1,000, should have stewardship plan assigned
   - If event has >50 attendees, must have liability waiver on file

**Implementation**: Business logic rules coded into validation scripts; flagged issues reviewed by subject matter experts (Registry Coordinator for clinical, Grant Manager for research, etc.).

---

## Data Entry Standards and Procedures

### Standardized Data Entry Protocols

**General Data Entry Standards:**

1. **Use Consistent Capitalization**:
   - Names: Title Case (John Smith, not JOHN SMITH or john smith)
   - Addresses: Title Case (123 Main Street, not 123 main street)
   - Genotypes: Uppercase (PI*ZZ, not pi*zz)

2. **Use Standard Abbreviations**:
   - States: USPS codes (MA, not Mass. or Massachusetts in abbreviated fields)
   - Titles: Dr., Mr., Ms. (not Doctor, Mister)

3. **Dates**: Always YYYY-MM-DD format (2024-11-09, not 11/9/24 or Nov 9, 2024)

4. **Phone Numbers**: (XXX) XXX-XXXX format for US; +XX-XXX-XXX-XXXX for international

5. **Names with Special Characters**: Preserve hyphens, apostrophes (O'Brien, not OBrien; Mary-Anne, not Mary Anne)

6. **Avoid Abbreviations in Narrative Fields**: Write "cardiovascular disease," not "CVD" in free-text clinical notes

### Data Entry Workflow

**Step-by-Step Process:**

**1. Verify Source Document**

- Ensure source document (consent form, survey, medical record) is legible and complete
- If missing critical data, attempt to obtain from patient/provider before entry
- If data unclear, flag for review (don't guess)

**2. Enter Data Into System**

- Use designated data entry forms (not direct database editing)
- Complete all required fields
- Follow field-specific standards (see Data Dictionary)

**3. Real-Time Validation**

- Address any validation errors before proceeding
- If validation rule seems incorrect, consult supervisor (don't override without reason)

**4. Review and Save**

- Review entered data on summary screen
- Check for transcription errors
- Save record

**5. Source Document Management**

- Mark source document as "entered" with date and initials
- File source document per retention policy
- For electronic source (e.g., email survey), move to "processed" folder

**6. Quality Check (For High-Stakes Data)**

- Second reviewer independently verifies data entry (dual data entry)
- Discrepancies resolved by comparing to source document

### Dual Data Entry for Critical Data

**When Required:**

- Patient registry enrollment (demographics, consent, initial clinical data)
- Financial data (donations, grant awards, expenses >$1,000)
- Genetic test results (genotype)
- IRB-approved research data (per research protocol)

**Process:**

1. **First Entry**: Data entry person A enters data from source document
2. **Second Entry**: Data entry person B independently enters same data (without seeing Person A's entry)
3. **Comparison**: System compares entries; flags discrepancies
4. **Resolution**: Both reviewers examine source document; consensus entry becomes final

**Discrepancy Rate Tolerance**: If discrepancy rate >5%, investigate cause (poor training, illegible source documents, system usability issues).

---

## Duplicate Detection and Management

### Duplicate Prevention Strategies

**1. Real-Time Duplicate Checks During Entry**

When entering new patient record, system searches for existing records matching:

- Last name + first name + birth year (fuzzy matching to catch typos)
- Email address (exact match)
- Phone number (exact match, after stripping formatting)

**Alert**: "Possible duplicate found: [Existing Record ID] John Smith, born 1978, john.smith@email.com. [View Record] [Not a Duplicate - Proceed]"

**2. Unique Identifiers**

- Assign unique IDs upon record creation (auto-incrementing, not reusable)
- Use external IDs when available (e.g., if patient provides Alpha-1 Foundation member ID, record it to prevent duplicate enrollment)

**3. Master Data Management**

- Registry is "system of record" for patient data; other systems reference registry ID
- Donor CRM is "system of record" for donor data
- Avoid storing same entity in multiple systems independently

### Duplicate Detection Methods

**Automated Duplicate Detection (Monthly Batch Process):**

Run probabilistic matching algorithm using multiple fields:

**Matching Rules:**

| **Rule**               | **Fields**                                | **Threshold** | **Interpretation**                     |
| ---------------------- | ----------------------------------------- | ------------- | -------------------------------------- |
| **Exact Match**        | First Name + Last Name + DOB              | 100%          | Highly likely duplicate (unless twins) |
| **High Probability**   | First Name + Last Name + Birth Year + ZIP | 95%           | Investigate; likely duplicate          |
| **Medium Probability** | Last Name + DOB + Phone                   | 85%           | Review; possible duplicate             |
| **Low Probability**    | Similar Last Name + Birth Year + City     | 70%           | May be relatives; flag for review      |

**Fuzzy Matching**: Use algorithms to catch typos, nicknames:

- "Jon Smith" and "John Smith" (typo)
- "Robert Johnson" and "Bob Johnson" (nickname)
- "Mary O'Brien" and "Mary OBrien" (punctuation difference)

### Duplicate Resolution Process

**When Potential Duplicate Identified:**

1. **Review Both Records**: Compare all fields; check source documents

2. **Determine True Status**:
   - **True Duplicate**: Same person, two records
   - **False Positive**: Different people with similar data
   - **Related Records**: Same family (parent/child, siblings)

3. **If True Duplicate**:
   - **Merge Records**:
     - Combine data from both records into single master record
     - Retain most complete/accurate values for each field
     - Link old record ID to master record (preserve audit trail)
     - Mark duplicate record as "merged" (don't delete; maintain history)
   - **Document Merge**: Log reason for merge, which record became master, date, person who performed merge

4. **If False Positive**:
   - **Flag as "Not Duplicate"**: Prevent future alerts for this pair
   - **Add Distinguishing Data**: If possible, add data to differentiate (middle initial, more precise address)

**Merge Checklist:**

- [ ] Reviewed both records thoroughly
- [ ] Confirmed duplicate with supervisor
- [ ] Backed up both records before merge
- [ ] Merged data, retaining most accurate values
- [ ] Linked old ID to master record
- [ ] Updated related records (surveys, consents) to reference master ID
- [ ] Notified data users if research/reports may be affected
- [ ] Documented merge in audit log

**Duplicate Rate Target**: <1% duplicate records in registry

---

## Data Cleaning Procedures

### Scheduled Data Cleaning Cycles

**Monthly Data Cleaning:**

- **Focus**: Recent data (past 30 days)
- **Activities**:
  - Resolve validation errors flagged by nightly checks
  - Verify high-stakes data (new enrollments, large donations)
  - Correct formatting inconsistencies

**Quarterly Deep Cleaning:**

- **Focus**: All active records
- **Activities**:
  - Run duplicate detection; resolve duplicates
  - Fill missing data where possible (e.g., lookup ZIP codes for incomplete addresses)
  - Standardize free-text fields (e.g., convert "Massachusetts" to "MA")
  - Update stale data (contact patients/donors to refresh contact info)
  - Archive inactive records (e.g., donors who haven't given in 5+ years moved to separate table)

**Annual Comprehensive Cleaning:**

- **Focus**: Entire database
- **Activities**:
  - All quarterly cleaning activities
  - External data validation (address verification service, email validation)
  - Data quality audit by external validator
  - Update data dictionary and validation rules based on lessons learned

### Data Cleaning Techniques

**1. Standardization**

Convert data to consistent formats:

- **Names**: Title case, trim whitespace
- **Addresses**: USPS standardization (e.g., "Street" → "St", "Apartment 5" → "Apt 5")
- **Genotypes**: Standardize nomenclature (e.g., "ZZ" → "PI\*ZZ")

**Tools**: Use data cleaning scripts (Python, R) or platforms (OpenRefine, Trifacta).

**2. Deduplication**

See Duplicate Detection and Management section.

**3. Missing Data Imputation**

**When Appropriate**:

- Non-critical fields where estimate is acceptable (e.g., impute missing ZIP code from city/state)
- Statistical analysis requiring complete datasets (use imputation methods like mean substitution, regression imputation)

**When NOT Appropriate**:

- Critical clinical data (never guess genotype or diagnosis date)
- Financial data (never estimate donation amounts)
- Research data used for publications (must be actual values or explicitly noted as imputed)

**Best Practice**: Clearly mark imputed values (e.g., add "imputed" flag field) so analysts know data source.

**4. Outlier Review**

Statistical outliers may be errors or genuine extreme values:

- **FEV1 of 5%**: Extreme but possible (very severe disease); verify with clinician
- **Donation of $100,000**: Unusual but possible; verify with donor records
- **Age at diagnosis = 1 year**: Rare but possible (pediatric diagnosis); verify

**Process**: Flag outliers (values >3 SD from mean); manual review by subject matter expert.

**5. Consistency Corrections**

If patient has genotype PI\*ZZ but disease status is "unaffected":

- **Investigate**: Review source documents
- **Correct**: Update incorrect field (likely status should be "affected" or genotype was misrecorded)
- **Document**: Note in audit log

---

## Completeness Metrics and Standards

### Completeness Measurement

**Field-Level Completeness**:

For each field, calculate:

**Completeness % = (# records with non-null value / # records where field is required) × 100**

**Example**: Registry has 500 participants. "Diagnosis date" is required field. 475 records have diagnosis date → **95% completeness**.

**Record-Level Completeness**:

For each record, calculate:

**Record Completeness % = (# completed required fields / # total required fields) × 100**

**Example**: Record has 20 required fields; 18 are completed → **90% completeness**.

**Dataset-Level Completeness**:

Average record-level completeness across all records.

### Completeness Targets by Field Priority

**Tier 1 (Critical) - 98%+ Completeness Required:**

- Patient ID, enrollment date, consent status
- Birth year, gender, country
- Donor ID, name, donation amount, date
- Grant ID, recipient, award amount, dates

**Tier 2 (Important) - 90%+ Completeness Required:**

- Alpha-1 genotype (if tested), diagnosis date
- Contact info (email or phone)
- Donor address (for tax receipts)
- Grant research aims, expected outcomes

**Tier 3 (Valuable) - 75%+ Completeness Target:**

- Clinical measures (FEV1, liver function)
- Patient-reported outcomes (survey responses)
- Event attendance details
- Research publication citations

**Tier 4 (Optional) - No Completeness Target:**

- Demographics beyond basics (income, education)
- Patient narrative stories
- Donor survey feedback

### Strategies to Improve Completeness

**1. Simplify Data Collection**

- Ask only essential questions (avoid "nice to know" fields that add burden)
- Use skip logic (if patient answers "no" to "Do you have lung symptoms?", skip detailed lung questions)

**2. Make Required Fields Clear**

- Mark required fields with asterisk (\*) in forms
- Use inline validation (can't submit form with missing required fields)

**3. Incentivize Completion**

- Offer incentive for completing full registry survey ($10-$25 gift card)
- Provide completion progress bar ("You're 80% complete!")

**4. Follow Up on Missing Data**

- Automated email reminders for incomplete survey responses
- Phone follow-up for high-priority missing data

**5. Use External Data Sources**

- Lookup ZIP code from address databases if only city/state provided
- Pre-fill known data (if patient enrolls via provider, auto-populate diagnosis date from provider referral)

---

## Accuracy Audits

### Audit Methodology

**Source Verification Audits:**

Compare database values to original source documents (consent forms, medical records, surveys).

**Sample Selection:**

- **Random Sample**: 10% of records selected randomly each year for comprehensive audit
- **Targeted Sample**: 25% of high-risk data (new genotype entries, clinical trial data) audited
- **Continuous Monitoring**: 100% of high-stakes data (financial transactions) reviewed in real-time or monthly

**Audit Process:**

1. **Select Sample**: Use random number generator or stratified sampling (ensure representation across demographics, time periods)

2. **Retrieve Source Documents**: Pull original consent forms, surveys, medical records for sampled records

3. **Compare Database vs. Source**: Field-by-field comparison

4. **Classify Discrepancies**:
   - **Transcription Error**: Data entry person incorrectly typed value
   - **Source Document Error**: Source document itself was incorrect or ambiguous
   - **System Error**: Software bug caused incorrect storage
   - **Acceptable Variation**: Minor difference that doesn't affect meaning (e.g., "Dr. John Smith" vs. "John Smith, MD")

5. **Correct Errors**: Update database with correct values

6. **Calculate Accuracy Rate**:

**Accuracy % = (# fields matching source / # fields audited) × 100**

**Target**: ≥97% accuracy

### Audit Reporting

**Monthly Accuracy Report:**

- # records audited
- # errors found
- Error rate by field type (demographics, clinical, financial)
- Root cause analysis (transcription errors most common? Data entry staff need more training?)
- Corrective actions taken

**Annual Comprehensive Audit Report:**

- Full-year accuracy trends
- Comparison to prior years
- Recommendations for data quality improvements
- Certification statement (signed by COO): "I certify that the Foundation's data quality audit for [Year] has been completed, achieving [X]% accuracy rate, meeting/exceeding our 97% target."

---

## Interrater Reliability

### Definition and Importance

**Interrater Reliability (IRR)**: Degree to which different data entry persons or reviewers produce consistent results when coding or entering the same data.

**Why It Matters**:

- Ensures subjective judgments (e.g., categorizing disease severity as "moderate" vs. "severe") are consistent across staff
- Critical for research data that will be analyzed or published
- Low IRR indicates need for clearer coding guidelines or additional training

### Measuring IRR

**Kappa Statistic (Cohen's Kappa)**:

Measures agreement between two raters, adjusting for chance agreement.

**Interpretation**:

| **Kappa Value** | **Agreement Level** | **Interpretation**                    |
| --------------- | ------------------- | ------------------------------------- |
| 0.81 - 1.00     | Almost Perfect      | Excellent reliability                 |
| 0.61 - 0.80     | Substantial         | Good reliability                      |
| 0.41 - 0.60     | Moderate            | Acceptable with improvement           |
| 0.21 - 0.40     | Fair                | Poor reliability; revise coding rules |
| 0.00 - 0.20     | Slight              | Unacceptable; major revision needed   |

**Target**: Kappa ≥ 0.70 for subjective coding tasks

### IRR Testing Process

**When to Conduct IRR Testing**:

- New subjective coding scheme introduced (e.g., categorizing patient narratives by theme)
- New data entry staff hired
- Annually for ongoing subjective coding tasks

**Process**:

1. **Select Sample**: 50-100 records to be coded/reviewed by multiple raters

2. **Independent Coding**: 2-3 staff members independently code the same records (without seeing each other's codes)

3. **Calculate Agreement**: Use statistical software (SPSS, R, online calculators) to compute Kappa

4. **Review Discrepancies**: For records where raters disagreed, discuss why and reach consensus

5. **Refine Coding Rules**: If Kappa <0.70, clarify guidelines and retest

**Example - Disease Severity Coding**:

Two Registry Coordinators independently code disease severity ("asymptomatic," "mild," "moderate," "severe") for 100 patients based on FEV1 and symptoms.

- Agreement: 85 records coded identically
- Kappa: 0.78 (substantial agreement)
- Action: Acceptable IRR; document coding guidelines as standard operating procedure

---

## Data Quality Dashboard

### Dashboard Components

**Real-Time Data Quality Dashboard** (accessible to COO, Data Manager, program staff):

**Section 1: Completeness Metrics**

- **Gauge Chart**: Overall database completeness (target: 95%)
- **By Field**: Bar chart showing completeness % for each Tier 1 and Tier 2 field
- **Trend**: Line chart showing completeness over past 12 months

**Section 2: Accuracy Metrics**

- **Gauge Chart**: Current accuracy rate from latest audit (target: 97%)
- **Error Rate by Category**: Pie chart (transcription errors, source errors, system errors)
- **Trend**: Accuracy rate over time

**Section 3: Timeliness Metrics**

- **Average Lag Time**: Avg. days from data collection to entry (target: <3 days for most data types)
- **Aging Report**: # records awaiting entry, grouped by age (0-3 days, 4-7 days, 8-14 days, 15+ days)

**Section 4: Duplicate Metrics**

- **Duplicate Rate**: % duplicate records (target: <1%)
- **Potential Duplicates**: # records flagged for review

**Section 5: Validation Errors**

- **Open Issues**: # validation errors awaiting resolution, grouped by severity (High, Medium, Low)
- **Top Issues**: Most common validation errors (e.g., missing phone numbers)

**Section 6: Data Quality Score**

- **Composite Score**: Weighted average of completeness, accuracy, timeliness, uniqueness (out of 100)
- **Target**: 90/100

**Red/Yellow/Green Indicators**: Each metric color-coded (green = meets target, yellow = within 10% of target, red = below target).

### Dashboard Technology

**Options**:

1. **Tableau**: Professional dashboards, integrates with databases ($70/month)
2. **Power BI**: Microsoft tool, good for Excel/SQL integration ($10/month)
3. **Google Data Studio**: Free, integrates with Google Sheets, adequate for basic needs
4. **Custom-Built**: Use Python (Dash, Plotly) or R (Shiny) to build custom dashboard

**Recommendation**: Year 1 start with Google Data Studio (free); Year 2+ upgrade to Tableau for advanced features.

---

## Data Entry Training Program

### Training Curriculum for Data Entry Staff

**New Hire Training (8 hours):**

**Module 1: Introduction to Foundation Data (1 hour)**

- Foundation mission and programs overview
- Why data quality matters (patient impact, research credibility)
- Overview of Foundation databases and systems

**Module 2: Data Quality Principles (1 hour)**

- Six dimensions of data quality (accuracy, completeness, consistency, validity, timeliness, uniqueness)
- Foundation's data quality standards and targets
- Real-world examples of data quality issues and impacts

**Module 3: Data Entry Standards and Procedures (2 hours)**

- Data entry workflow (step-by-step)
- Field-specific standards (capitalization, formatting, dates, phone numbers)
- Using the Data Dictionary
- Hands-on practice: Enter 10 practice records with trainer review

**Module 4: Validation and Error Handling (1 hour)**

- Understanding validation rules
- How to respond to validation errors
- When to consult supervisor vs. proceeding
- Flagging unclear data for review

**Module 5: Confidentiality and Security (1 hour)**

- HIPAA compliance basics (see HIPAA Implementation Playbook for full training)
- Handling sensitive data (patient info, financial data)
- System access and password security
- Reporting security incidents

**Module 6: System-Specific Training (2 hours)**

- Hands-on training in specific data entry system (registry database, donor CRM)
- Practice entering real data under supervision
- Q&A

**Assessment**: Complete 20 test entries; must achieve ≥95% accuracy to proceed independently.

### Ongoing Training

**Monthly Data Quality Meetings (30 minutes):**

- Review dashboard metrics
- Discuss common errors from past month
- Introduce any new validation rules or procedures
- Share data quality success stories

**Annual Refresher Training (2 hours):**

- Review data quality standards
- Update on new systems, fields, or procedures
- Advanced topics (e.g., duplicate detection, complex validation)

**Just-in-Time Training:**

When new data type or system introduced, provide targeted training before go-live.

---

## Data Quality Roles and Responsibilities

### Key Roles

**Chief Operating Officer (COO)**

- **Overall Accountability**: Ensures Foundation meets data quality standards
- **Responsibilities**:
  - Approve data quality policies and standards
  - Review quarterly data quality reports
  - Allocate resources for data quality improvement
  - Report data quality metrics to Board

**Data Quality Manager / Registry Manager** (0.5-1.0 FTE, Years 2+)

- **Day-to-Day Leadership**: Drives data quality initiatives
- **Responsibilities**:
  - Maintain Data Dictionary and validation rules
  - Oversee data cleaning cycles
  - Conduct accuracy audits
  - Train data entry staff
  - Manage data quality dashboard
  - Resolve data quality incidents

**Data Entry Staff** (multiple roles: Registry Coordinators, Development Coordinators, Program Assistants)

- **Front-Line Responsibility**: Enter accurate, complete data
- **Responsibilities**:
  - Follow data entry standards
  - Address validation errors promptly
  - Flag unclear or missing data for resolution
  - Participate in training
  - Report data quality issues

**Program Managers** (Registry, Research, Development, Education)

- **Program-Specific Data Quality**: Ensure quality of data for their programs
- **Responsibilities**:
  - Define data requirements for their programs
  - Review data quality metrics for their areas
  - Support data cleaning efforts (e.g., contacting patients to update info)

**IT/Database Administrator** (contractor or fractional staff, Years 2+)

- **Technical Implementation**: Build and maintain data quality systems
- **Responsibilities**:
  - Implement validation rules in databases
  - Build and maintain data quality dashboard
  - Develop data cleaning scripts
  - Optimize database performance
  - Ensure data backups and security

---

## Continuous Monitoring and Improvement

### Monthly Data Quality Review

**Meeting**: Last Friday of each month, 1 hour

**Attendees**: COO, Data Quality Manager, program staff

**Agenda**:

1. **Dashboard Review**: Examine current metrics vs. targets
2. **Error Analysis**: Review top data quality issues from past month
3. **Root Cause Discussion**: Why are errors occurring? (training gap, system usability, unclear source documents)
4. **Improvement Actions**: Assign action items to address root causes
5. **Celebrate Successes**: Recognize staff achieving high accuracy, improvements in completeness

**Documentation**: Meeting notes logged; action items tracked to completion.

### Quarterly Data Quality Report

**Report Contents**:

- **Executive Summary**: Overall data quality status (green/yellow/red)
- **Metrics Dashboard**: Snapshot of all key metrics
- **Trends**: Comparison to prior quarters and targets
- **Issues and Resolutions**: Major data quality incidents and how resolved
- **Improvement Initiatives**: Data quality projects underway or planned
- **Recommendations**: Proposed policy/system changes

**Distribution**: ED, COO, Board Evaluation Committee

**Presentation**: COO presents at quarterly Board meeting

### Plan-Do-Study-Act (PDSA) for Data Quality

Use rapid-cycle testing to improve data quality:

**Example PDSA Cycle**:

- **Problem**: Registry survey completion rate only 60%; incomplete surveys reduce data quality
- **Plan**: Test shorter survey (reduce from 50 questions to 30 by removing low-priority questions). Predict completion rate will increase to 70%.
- **Do**: Deploy shorter survey to next 100 participants.
- **Study**: Completion rate increased to 72%. Feedback: "Much better length."
- **Act**: Implement shorter survey for all participants. Monitor completion rate; if sustained at 70%+, keep. If drops, refine further.

---

## Data Quality Incident Management

### Defining Data Quality Incidents

**Severity Levels**:

**Critical Incident**:

- **Definition**: Data quality issue that compromises patient safety, regulatory compliance, or financial integrity
- **Examples**:
  - Incorrect genotype reported to patient or researcher
  - Patient contact info exposed due to data breach
  - Financial data inaccuracy resulting in incorrect tax reporting
- **Response Time**: Immediate (within 4 hours)

**Major Incident**:

- **Definition**: Significant data quality issue affecting research validity or program operations
- **Examples**:
  - 10%+ of registry records have missing critical fields
  - Duplicate donation records causing inaccurate donor reporting
  - System error corrupting recent data entries
- **Response Time**: Within 1 business day

**Minor Incident**:

- **Definition**: Isolated data quality issue with limited impact
- **Examples**:
  - Single record with incorrect address
  - Temporary validation rule malfunction
  - Formatting inconsistency in non-critical field
- **Response Time**: Within 1 week

### Incident Response Process

**Step 1: Detection and Reporting**

- Anyone can report data quality incident via email to dataqualit@markegly.org or incident log form
- Automated alerts flag potential incidents (e.g., sudden spike in validation errors)

**Step 2: Triage**

- Data Quality Manager assesses severity within 2 hours of report
- Assigns incident to appropriate staff

**Step 3: Investigation**

- Determine root cause:
  - Human error (data entry mistake)?
  - System bug?
  - Process failure (training inadequate)?
  - External factor (bad source data)?

**Step 4: Containment**

- Prevent further errors:
  - If system bug, disable problematic feature until fixed
  - If training gap, provide immediate re-training
  - If source data issue, halt data entry from that source until resolved

**Step 5: Correction**

- Fix incorrect data:
  - For single record: Manual correction
  - For multiple records: Scripted correction with manual verification
- Document all corrections in audit log

**Step 6: Notification**

- **Critical Incidents**: Notify affected individuals (patients, donors, researchers) and COO/ED immediately
- **Major Incidents**: Notify relevant staff and program managers
- **Minor Incidents**: Log only; no external notification needed

**Step 7: Prevention**

- Implement changes to prevent recurrence:
  - Add validation rule
  - Improve training
  - Fix system bug
  - Clarify procedures

**Step 8: Documentation**

- Complete Incident Report documenting:
  - Description of incident
  - Root cause
  - Impact (# records affected, potential harm)
  - Correction actions taken
  - Prevention measures implemented
  - Lessons learned

---

## Tools and Technology

### Data Quality Software

**Data Validation Tools**:

- **Great Expectations** (Python library): Open-source data validation framework; define expectations (rules) for data; automated testing
- **Talend Data Quality**: Enterprise tool for profiling, cleansing, matching ($)
- **Trifacta Wrangler**: Interactive data cleaning tool; visual interface for transformations ($)

**Duplicate Detection Tools**:

- **Dedupe.io**: Machine learning-based deduplication (Python library, free)
- **DataMatch Enterprise**: Powerful duplicate detection and merging ($$$)
- **OpenRefine**: Open-source tool for data cleaning and deduplication (free)

**Data Quality Dashboards**:

- **Tableau** ($), **Power BI** ($), **Google Data Studio** (free) - see Dashboard section

**Address Verification**:

- **USPS API**: Free address standardization and verification (US only)
- **Melissa Data**, **SmartyStreets**: Paid services for comprehensive address validation, email verification

### Database Features for Data Quality

**Built-In Validation**:

- **Data Types**: Enforce data types (INT, DATE, VARCHAR) at database level
- **Constraints**: NOT NULL (required fields), CHECK (range validation), UNIQUE (prevent duplicates)
- **Foreign Keys**: Ensure referential integrity (survey responses must link to existing patient)

**Audit Trails**:

- **Audit Tables**: Log all INSERT, UPDATE, DELETE operations with user, timestamp, old value, new value
- **Triggers**: Database triggers automatically populate audit tables

**Version Control**:

- For critical data changes, maintain versioned history (e.g., if patient updates address, keep both old and new with effective dates)

---

## Budget and Resources

### Data Quality Budget (Annual)

**Year 1 (Basic Data Quality System):**

| **Category**             | **Items**                                               | **Cost**          |
| ------------------------ | ------------------------------------------------------- | ----------------- |
| **Staff Time**           | COO/program staff data quality activities (0.2 FTE)     | $15,000 (in-kind) |
| **Software**             | Google Data Studio (free), OpenRefine (free)            | $0                |
| **Training**             | Data entry training materials, external trainer (1 day) | $2,000            |
| **Address Verification** | USPS API (free), SmartyStreets (100K verifications)     | $500              |
| **External Audit**       | Data quality consultant to conduct accuracy audit       | $5,000            |
| **TOTAL**                |                                                         | **$22,500**       |

**Years 2-3 (Developing Capacity):**

| **Category**                   | **Items**                                                   | **Cost**    |
| ------------------------------ | ----------------------------------------------------------- | ----------- |
| **Staff**                      | Part-time Data Quality Manager / Registry Manager (0.5 FTE) | $40,000     |
| **Software**                   | Tableau ($840), OpenRefine/Dedupe.io (free)                 | $1,000      |
| **Data Cleaning Tools**        | Trifacta or similar                                         | $3,000      |
| **Address/Email Verification** | SmartyStreets, BriteVerify                                  | $2,000      |
| **Training**                   | Annual training program, conference attendance              | $3,000      |
| **External Audit**             | Annual data quality audit                                   | $6,000      |
| **TOTAL**                      |                                                             | **$55,000** |

**Years 4-5 (Mature System):**

| **Category**              | **Items**                                        | **Cost**     |
| ------------------------- | ------------------------------------------------ | ------------ |
| **Staff**                 | Full-time Data Quality Manager (1.0 FTE)         | $75,000      |
| **Software**              | Tableau, data quality suite (Talend or similar)  | $8,000       |
| **Database Optimization** | DBA consultant for performance, validation rules | $10,000      |
| **Verification Services** | Address, email, phone validation (higher volume) | $5,000       |
| **Training**              | Comprehensive program, certifications            | $5,000       |
| **External Audit**        | Annual comprehensive audit                       | $8,000       |
| **TOTAL**                 |                                                  | **$111,000** |

**Data Quality as % of Budget**: Target 3-5% of Foundation budget for data quality (includes staff time).

---

## Conclusion

The Mark Egly Foundation's Data Quality Standards ensure that every data point collected is accurate, complete, and reliable—worthy of the trust placed in the Foundation by patients, researchers, and donors. By treating data quality as a continuous process rather than a one-time task, the Foundation positions itself to generate credible insights, support high-quality research, and make evidence-based decisions that advance the Alpha-1 community's wellbeing.

**Key Implementation Steps (First Year):**

1. **Month 1**: Adopt Data Quality Standards; assign Data Quality Manager responsibilities (or COO interim)
2. **Month 2**: Develop/refine Data Dictionary with validation rules for each field
3. **Month 3**: Implement real-time validation in data entry systems; launch automated nightly validation checks
4. **Month 4**: Train all data entry staff on standards and procedures
5. **Month 5**: Conduct first accuracy audit (10% sample); calculate baseline metrics
6. **Month 6**: Launch data quality dashboard; begin monthly data quality reviews
7. **Month 9**: First quarterly data cleaning cycle; resolve duplicates
8. **Month 12**: Annual comprehensive cleaning; external data quality audit; evaluate Year 1 effectiveness

**Long-Term Vision**:

By Year 5, the Foundation's data quality system is mature:

- **99% accuracy** on critical data fields
- **98% completeness** on required fields
- **<0.5% duplicate rate**
- **Real-time dashboards** provide instant visibility into data quality
- **Automated processes** handle 80% of data quality tasks (validation, duplicate detection, standardization)
- **Skilled staff** efficiently manage remaining 20% requiring human judgment
- **External researchers** trust Foundation data as gold standard for Alpha-1 research
- **Funders** cite Foundation's data quality as exemplar for rare disease nonprofits

The Foundation's commitment to data quality excellence ensures that every patient enrolled, every research finding, and every program outcome is documented with precision—enabling the Foundation to maximize its impact on the Alpha-1 community for generations to come.

---

**Document 15 of 37 Complete**

_This data quality framework should be reviewed semi-annually and updated as new data systems, fields, or quality challenges emerge. Technology and methods should evolve to maintain state-of-the-art data quality practices._
