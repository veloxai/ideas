# Content Liability Framework

## Executive Summary

The **Content Liability Framework** establishes legal protections, disclaimers, and risk management strategies to protect Uniting Doctors, its users, and patients while enabling open medical discourse. This framework balances legal compliance with platform utility.

---

## Legal Foundation

### Platform Status: Interactive Computer Service

**Section 230 (US Communications Decency Act)**:

- Uniting Doctors is a "provider of an interactive computer service"
- NOT the publisher of user-generated content
- Generally not liable for user posts, even if moderated
- Protection applies to good faith moderation

**Key Provision**:

> "No provider or user of an interactive computer service shall be treated
> as the publisher or speaker of any information provided by another
> information content provider."

**Limits to Protection**:

- ✗ Federal criminal law violations
- ✗ Intellectual property infringement
- ✗ Electronic Communications Privacy Act violations
- ✗ Material we create ourselves

---

## Disclaimers

### Universal Medical Disclaimer

**Displayed on All Pages**:

```
⚠️ MEDICAL DISCLAIMER

Uniting Doctors is a professional medical information platform for healthcare
professionals. Content is for educational and informational purposes only.

NOT MEDICAL ADVICE: Information on this platform does not constitute medical
advice and should not be used to diagnose or treat any condition. Always seek
the advice of a qualified healthcare provider with any questions about a medical
condition.

PROFESSIONAL JUDGMENT: Healthcare professionals are responsible for their own
clinical decisions. Information here supplements, but does not replace, clinical
judgment and individualized patient care.

NO DOCTOR-PATIENT RELATIONSHIP: Use of this platform does not create a
doctor-patient relationship between users or with Uniting Doctors.

USER-GENERATED CONTENT: Content is provided by healthcare professionals and may
not reflect the views of Uniting Doctors. We do not endorse specific treatments,
products, or procedures discussed.

VERIFY INFORMATION: Always verify medical information through peer-reviewed
sources and clinical guidelines before applying to patient care.
```

### Content-Specific Disclaimers

**Off-Label Use**:

```
⚠️ OFF-LABEL USE DISCUSSION

This content discusses medication uses not FDA-approved for the discussed
indication. Off-label prescribing is legal but requires informed patient consent
and appropriate documentation. Consult institutional policies and pharmacy teams.
```

**Case Reports**:

```
⚠️ CASE REPORT / ANECDOTAL EVIDENCE

This represents a single case or limited experience. Results may not be
generalizable. Clinical decisions should be based on comprehensive evidence
including systematic reviews and clinical guidelines, not individual cases.
```

**Controversial Topics**:

```
⚠️ CONTROVERSIAL/EVOLVING EVIDENCE

This topic has conflicting evidence or expert opinions. Multiple perspectives
are presented. Use clinical judgment and current evidence when making treatment
decisions. Guidelines may vary by region and specialty society.
```

**Research Discussions**:

```
ℹ️ RESEARCH DISCUSSION

Discussion of research findings for educational purposes. Individual study
results should be considered in context of the broader literature. Consult
systematic reviews and meta-analyses when available.
```

---

## User Responsibilities

### Terms of Service Key Provisions

**User Representations**:

Users agree that they:

1. Are qualified healthcare professionals (if posting medical content)
2. Will not provide direct medical advice to patients
3. Will use professional judgment when applying information
4. Will verify information before clinical application
5. Will not rely solely on platform content for clinical decisions
6. Understand content is educational, not prescriptive
7. Will comply with local laws and regulations
8. Will maintain patient confidentiality (HIPAA)

**Indemnification Clause**:

```
USER INDEMNIFICATION

You agree to indemnify, defend, and hold harmless Uniting Doctors, its officers,
directors, employees, and agents from any claims, damages, losses, liabilities,
and expenses (including attorneys' fees) arising from:

• Your use of the platform
• Your violation of these Terms
• Your violation of any third-party rights
• Any medical decisions you make based on platform content
• Content you post on the platform
• Your breach of professional standards

This indemnification survives termination of your account.
```

**Limitation of Liability**:

```
LIMITATION OF LIABILITY

TO THE MAXIMUM EXTENT PERMITTED BY LAW:

• Platform provided "AS IS" without warranties
• No guarantee of accuracy, completeness, or timeliness
• No liability for medical outcomes resulting from platform use
• No liability for user-generated content
• No liability for technical failures or data loss
• Damages limited to amount paid (if any) for platform access

SOME JURISDICTIONS DO NOT ALLOW LIMITATION OF CERTAIN WARRANTIES OR DAMAGES.
IF THESE LAWS APPLY TO YOU, SOME LIMITATIONS MAY NOT APPLY.
```

---

## Content Moderation & Liability

### Good Faith Moderation

**Protected Activities** (Section 230(c)(2)):

```
Uniting Doctors may moderate, remove, or restrict access to content that we
determine in good faith to be:

• Obscene, lewd, lascivious, filthy, excessively violent, harassing
• Dangerous medical misinformation
• Otherwise objectionable

This moderation does NOT create liability for content we do not remove.
```

**Moderation Does NOT Equal Endorsement**:

- Approving content ≠ verifying accuracy
- Leaving content up ≠ endorsing views
- Moderator review ≠ medical peer review

### DMCA Safe Harbor (Copyright)

**Copyright Infringement Procedure**:

1. **Copyright Agent Designated**:

   ```
   DMCA Agent
   Uniting Doctors, Inc.
   [Address]
   Email: copyright@unitingdoctors.com
   ```

2. **Takedown Process**:
   - Copyright holder submits takedown notice
   - We remove content within 24 hours
   - Notify user of removal
   - User may submit counter-notice
   - Content restored if no lawsuit filed (10-14 days)

3. **Repeat Infringer Policy**:
   - Three copyright strikes = account termination
   - Appeals allowed for good faith disputes

---

## Patient Privacy & HIPAA

### HIPAA Compliance

**Business Associate Status**:

- Uniting Doctors is NOT a covered entity
- Users (healthcare providers) are responsible for HIPAA compliance
- Platform provides tools to prevent PHI sharing

**Platform Safeguards**:

1. **PHI Detection**:

   ```python
   def detect_phi(content):
       """
       Automated PHI detection before publication
       """
       phi_found = []

       # Names + medical context
       if detect_name_with_diagnosis(content):
           phi_found.append('patient_name')

       # Dates + medical events
       if detect_specific_dates(content):
           phi_found.append('dates')

       # Medical record numbers
       if re.search(r'\bMRN\s*:?\s*\d{6,}', content):
           phi_found.append('mrn')

       # Geographic details + small populations
       if detect_rare_location(content):
           phi_found.append('location')

       if phi_found:
           return {
               'warning': 'Possible PHI detected',
               'elements': phi_found,
               'action': 'BLOCK_PUBLICATION'
           }

       return {'status': 'clear'}
   ```

2. **User Warnings**:

   ```
   ⚠️ POSSIBLE PATIENT INFORMATION DETECTED

   Your post may contain identifiable patient information:
   • Patient name and diagnosis
   • Specific dates
   • Medical record number

   HIPAA requires de-identification before sharing cases.

   [Edit Post] [Cancel] [Override (Not Recommended)]
   ```

3. **Case Report Guidelines**:

   ```
   SAFE CASE SHARING CHECKLIST

   ☐ Remove patient name
   ☐ Remove specific dates (use "approximately" or year only)
   ☐ Remove medical record numbers
   ☐ Remove small geographic details
   ☐ Remove unique identifying features
   ☐ Combine features of multiple patients if needed
   ☐ Get patient consent if case is unique/recognizable
   ```

**HIPAA Violation Response**:

- Immediate content removal
- User education
- Reputation penalty (-100 points)
- Repeat violations → account suspension
- Serious violations → report to covered entity compliance officer

---

## Misinformation & Patient Safety

### Dangerous Medical Advice

**Platform Liability Concerns**:

- Section 230 protects platform from user content
- BUT: Duty to remove known dangerous content
- Good faith moderation is protected

**Our Approach**:

```
Three-Tier Response to Medical Misinformation:

Tier 1: CLEARLY FALSE & DANGEROUS
Example: "Vaccines cause autism" / "Stop insulin for diabetes"
Action: Remove immediately + warn/suspend user
Justification: Patient safety risk

Tier 2: OUTDATED OR LOW-QUALITY
Example: Using deprecated treatment protocols
Action: Label as outdated + add correction
Justification: Educational, not dangerous

Tier 3: CONTROVERSIAL BUT DEBATABLE
Example: Debates on emerging treatments
Action: Label as controversial + add context
Justification: Legitimate discourse
```

**Misinformation Disclaimer**:

```
🚫 CONTENT REMOVED: DANGEROUS MEDICAL MISINFORMATION

This content was removed because it contained medical misinformation that
could endanger patient safety. This violates our Community Guidelines.

Examples of dangerous misinformation:
• Recommending stopping life-saving medications
• Promoting unproven "cures" for serious conditions
• Discouraging evidence-based treatments

[Appeal Removal] [Review Community Guidelines]
```

---

## International Compliance

### Multi-Jurisdiction Considerations

**European Union (GDPR)**:

- Right to be forgotten (delete account/data)
- Data portability
- Consent for data processing
- Privacy by design

**UK**:

- Similar to GDPR (UK GDPR)
- ICO registration required

**Canada (PIPEDA)**:

- Consent for personal information collection
- Right to access personal data
- Cross-border data transfer restrictions

**Australia**:

- Privacy Act 1988 compliance
- AHPRA regulations for healthcare professionals

**Approach**:

- Global privacy standards (GDPR-level for all users)
- Regional terms for specific markets
- Local data residency where required

---

## Professional Liability

### Individual User Liability

**User's Professional Responsibility**:

```
⚠️ PROFESSIONAL LIABILITY NOTICE

You are personally responsible for:
• Clinical decisions you make
• Advice you provide to patients
• Prescriptions you write
• Procedures you perform

Information on Uniting Doctors supplements your medical knowledge but does not
replace your professional judgment or training. Your medical malpractice insurance
and professional licenses govern your liability for patient care decisions.

If you apply information from this platform to patient care:
• Verify through peer-reviewed sources
• Consider individual patient circumstances
• Document your decision-making process
• Obtain appropriate consent
• Follow institutional policies
```

**Platform Position**:

- We do NOT provide medical advice
- We do NOT verify every clinical claim
- Users are responsible for their own decisions
- No physician-patient relationship via platform

### Institutional Liability

**For Healthcare Institutions**:

```
INSTITUTIONAL NOTICE

Healthcare organizations whose employees use Uniting Doctors should:

• Include platform use in social media policies
• Clarify that employee posts don't represent institution
• Remind employees of confidentiality obligations
• Consider anonymous participation for sensitive topics
• Monitor for HIPAA violations if concerned

Uniting Doctors is not responsible for employee posts made on the platform.
Institutions should address policy violations through internal processes.
```

---

## Dispute Resolution

### Arbitration Clause

**Binding Arbitration**:

```
DISPUTE RESOLUTION

Any dispute arising from your use of Uniting Doctors shall be resolved through:

1. Informal Resolution: Contact us to attempt resolution (30 days)
2. Binding Arbitration: AAA rules, individual arbitration only
3. Class Action Waiver: No class arbitrations or representative actions
4. Exception: Small claims court allowed (<$10,000)

Arbitration location: User's state/country of residence
Governing law: Delaware (US users) / Local law (international)

RIGHT TO OPT-OUT: You may opt out of arbitration within 30 days of account
creation by emailing legal@unitingdoctors.com with "Arbitration Opt-Out"
in the subject line.
```

---

## Risk Management

### Insurance Coverage

**Platform Insurance**:

- General Liability: $5M
- Cyber Liability: $10M (data breach, network security)
- Errors & Omissions: $5M (professional liability)
- Directors & Officers: $5M

**User Reminders**:

- Verify your malpractice insurance covers online activities
- Check if moonlighting/side work is covered
- Consider cyber liability if sharing EMR screenshots
- Confirm anonymous posts are covered

### Regular Legal Review

**Quarterly Reviews**:

- Terms of Service updates
- Privacy Policy updates
- Compliance with new regulations
- Emerging case law analysis
- Insurance coverage adequacy

**Annual Audits**:

- Legal compliance audit
- Risk assessment
- User agreement enforceability
- International law changes

---

## Conclusion

The Content Liability Framework protects Uniting Doctors and its users through:

- Clear legal status as platform, not publisher
- Comprehensive disclaimers
- Good faith moderation
- Patient privacy safeguards
- Risk management strategies

**Key Protections**:

- ✓ Section 230 safe harbor (US)
- ✓ DMCA safe harbor (copyright)
- ✓ Good faith moderation protection
- ✓ Comprehensive user agreements
- ✓ Insurance coverage

**User Responsibilities**:

- Professional judgment required
- Verify information independently
- Maintain patient confidentiality
- Comply with local regulations
- Accept personal liability for clinical decisions

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Legal Team
**Related Documents**:

- [ANONYMITY_FRAMEWORK.md](./ANONYMITY_FRAMEWORK.md)
- [INTERNATIONAL_COMPLIANCE.md](./INTERNATIONAL_COMPLIANCE.md)
- [MEDICAL_CONTENT_STANDARDS.md](../clinical/MEDICAL_CONTENT_STANDARDS.md)
