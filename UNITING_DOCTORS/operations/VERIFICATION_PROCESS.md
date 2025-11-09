# Medical Professional Verification Process

## Executive Summary

The **Verification Process** ensures that only qualified healthcare professionals can contribute medical content on Uniting Doctors, establishing trust through rigorous credential validation while protecting user privacy and enabling anonymous participation.

---

## Verification Tiers

### Tier 1: Verified Physician (MD/DO)

**Requirements**:

- Medical degree from accredited institution
- Active medical license
- NPI number (US) or equivalent
- Board certification (preferred)

**Verification Methods**:

1. **Medical License Verification**
   - State medical board lookup
   - License number validation
   - Active status confirmation

2. **NPI Validation**
   - NPPES registry check
   - Matches name and credentials

3. **Institutional Email**
   - Hospital/clinic email verification
   - .edu domain for academic physicians

4. **Third-Party Services**
   - Doximity verification
   - CAQH ProView
   - Professional liability insurance carrier

**Verification Badge**: 🟢 **Verified Physician**

**Privileges**:

- Full platform access
- Create anonymous personas (up to 3)
- Vote on content quality
- Earn full reputation (0-1000)
- Participate in all discussions

### Tier 2: Verified Advanced Practice Provider

**Eligible Professionals**:

- Nurse Practitioners (NP, APRN)
- Physician Assistants (PA)
- Certified Registered Nurse Anesthetists (CRNA)
- Certified Nurse Midwives (CNM)

**Verification Methods**:

- State license verification
- National certification confirmation (NCCPA, AANP, etc.)
- Institutional affiliation

**Verification Badge**: 🔵 **Verified APP**

**Privileges**:

- Full platform access
- Anonymous personas (up to 2)
- Reputation cap: 800

### Tier 3: Verified Nurse

**Eligible Professionals**:

- Registered Nurses (RN)
- Licensed Practical Nurses (LPN)
- Clinical Nurse Specialists (CNS)

**Verification Methods**:

- Nursing license verification
- NURSYS verification
- Employment verification

**Verification Badge**: 🟣 **Verified Nurse**

**Privileges**:

- Specialty-specific forums
- Anonymous personas (up to 2)
- Reputation cap: 700

### Tier 4: Verified Allied Health Professional

**Eligible Professionals**:

- Pharmacists (PharmD, RPh)
- Clinical Psychologists (PhD, PsyD)
- Physical Therapists (DPT, PT)
- Occupational Therapists (OT)
- Speech-Language Pathologists (SLP)
- Respiratory Therapists (RRT)
- Medical Laboratory Scientists

**Verification Badge**: 🟡 **Verified Allied Health**

**Privileges**:

- Profession-specific forums
- Limited clinical discussions (labeled as non-physician)
- Reputation cap: 700

### Tier 5: Verified Researcher/Academic

**Eligible Professionals**:

- PhD in biomedical sciences
- Published researchers (peer-reviewed)
- Medical faculty

**Verification Badge**: 🟠 **Verified Researcher**

**Privileges**:

- Research forums
- Can comment on clinical topics (labeled as researcher)
- Limited clinical forum access

---

## Verification Process Flow

### Step 1: Account Creation

```
User Signs Up
    ↓
Email Verification
    ↓
Select Professional Category
├─ Physician (MD/DO)
├─ APP (NP/PA)
├─ Nurse (RN/LPN)
├─ Allied Health
├─ Researcher
└─ Patient/Other (separate path)
    ↓
Upload Credentials
```

### Step 2: Document Upload

**Required Documents**:

**For Physicians**:

- Medical license (front/back, redacted if needed)
- DEA certificate (optional, extra verification)
- Board certification (optional)
- Photo ID (name matching)

**Document Upload Interface**:

```
┌──────────────────────────────────────────────────┐
│ Credential Verification                          │
├──────────────────────────────────────────────────┤
│                                                  │
│ Step 1: Medical License                          │
│ [📎 Upload File] or [📷 Take Photo]             │
│                                                  │
│ ℹ️ Accepted formats: JPG, PNG, PDF              │
│ ℹ️ You may redact personal address/SSN          │
│                                                  │
│ Step 2: Photo ID                                │
│ [📎 Upload File]                                │
│ (Must match name on license)                     │
│                                                  │
│ Step 3: NPI Number (US only)                    │
│ [___________]                                    │
│                                                  │
│ 🔒 Your documents are encrypted and reviewed    │
│    by our verification team only. Deleted       │
│    after verification (30 days).                 │
│                                                  │
│ [Submit for Verification]                        │
└──────────────────────────────────────────────────┘
```

### Step 3: Automated Validation

**Immediate Checks**:

```python
async def auto_validate_credentials(application):
    """
    Automated credential validation
    """
    results = {}

    # Check NPI (if US physician)
    if application.npi:
        npi_valid = await validate_npi(
            npi=application.npi,
            name=application.name,
            specialty=application.specialty
        )
        results['npi'] = npi_valid

    # Check medical license
    if application.license_number and application.state:
        license_valid = await check_medical_board(
            state=application.state,
            license_number=application.license_number,
            name=application.name
        )
        results['license'] = license_valid

    # Check Doximity (if user opts in)
    if application.doximity_profile:
        doximity_match = await verify_doximity(application.doximity_profile)
        results['doximity'] = doximity_match

    # Calculate auto-verification confidence
    confidence = calculate_confidence(results)

    if confidence > 0.95:
        return 'AUTO_APPROVE'
    elif confidence > 0.70:
        return 'MANUAL_REVIEW_LOW_PRIORITY'
    else:
        return 'MANUAL_REVIEW_HIGH_PRIORITY'
```

**Data Sources**:

- NPPES (National Plan & Provider Enumeration System)
- State medical board databases (all 50 states)
- FSMB (Federation of State Medical Boards)
- Doximity API
- Hospital credentialing databases

### Step 4: Human Review

**Review Team**:

- Dedicated verification specialists
- Medical professionals on staff for complex cases
- 24-48 hour turnaround goal

**Review Checklist**:

```
□ Documents clear and legible
□ Name matches across all documents
□ License active and not expired
□ License number matches state database
□ Specialty matches claimed specialty
□ No disciplinary actions found
□ Photo ID matches license name
□ NPI matches (if applicable)
□ Red flags check (sanctions, fraud history)
```

### Step 5: Approval or Rejection

**Approved**:

```
✅ Verification Complete!

Your credentials have been verified. Welcome to Uniting Doctors!

Verification Tier: 🟢 Verified Physician
Specialty: Cardiology
Experience: 12+ years

Your verification badge will appear on your profile and posts.

Next Steps:
• Complete your profile
• Join specialty communities
• Create anonymous persona (optional)

[Complete Profile]
```

**Additional Information Needed**:

```
⚠️ Additional Information Required

We need clarification on:
• License expiration date unclear in photo
• NPI number doesn't match name exactly

Please re-upload a clearer photo or provide additional documentation.

[Upload Additional Documents]
```

**Rejected**:

```
❌ Verification Unsuccessful

Reason: License number not found in [State] medical board database

You may:
• Resubmit with correct information
• Contact support for assistance
• Appeal decision

[Resubmit] [Contact Support]
```

---

## Privacy & Security

### Data Protection

**Encryption**:

- Documents encrypted at rest (AES-256)
- TLS 1.3 for transmission
- Access restricted to verification team only

**Data Retention**:

- Verification documents deleted after 30 days
- Only verification status and basic credentials retained
- Audit log of verification maintained

**Access Controls**:

- Role-based access (verification team only)
- Two-factor authentication required
- Activity logging and monitoring

### Privacy Considerations

**What We Store Long-Term**:

- ✅ Name (required for account)
- ✅ Specialty
- ✅ Years of experience (range)
- ✅ Verification tier
- ✅ Verification date

**What We Delete**:

- ❌ License numbers
- ❌ Photos of documents
- ❌ Personal addresses
- ❌ SSN/Date of birth
- ❌ NPI number (after verification)

**Anonymous Personas**:

- Cryptographically separated from identity
- Platform cannot reverse-engineer identity from anonymous posts
- See [ANONYMITY_FRAMEWORK.md](../legal/ANONYMITY_FRAMEWORK.md)

---

## Re-Verification

### Periodic Re-Verification

**Frequency**:

- Every 2 years for all users
- Triggered by license expiration date
- On user request (credential updates)

**Process**:

- Email notification 30 days before due
- Simplified re-verification (confirm license still active)
- Automatic for users with NPI on file
- Account restricted if re-verification overdue (60 days)

### Continuous Monitoring

**Automated Checks**:

```python
async def continuous_credential_monitoring():
    """
    Daily checks for credential status changes
    """
    users = await get_verified_users()

    for user in users:
        # Check if license is still active
        if user.has_license_number():
            status = await check_license_status(
                state=user.state,
                license_number=user.license_number
            )

            if status != 'active':
                await flag_for_review(user, reason='license_inactive')

        # Check NPDB (National Practitioner Data Bank) for sanctions
        if user.has_npi():
            sanctions = await check_npdb(user.npi)
            if sanctions:
                await flag_for_review(user, reason='sanctions_found')
```

**Triggers for Manual Review**:

- License expiration
- State disciplinary action
- OIG exclusion list addition
- NPDB adverse action report

---

## International Verification

### Supported Countries

**Phase 1** (Launch):

- 🇺🇸 United States
- 🇨🇦 Canada
- 🇬🇧 United Kingdom
- 🇦🇺 Australia

**Phase 2** (Year 2):

- 🇩🇪 Germany
- 🇫🇷 France
- 🇮🇳 India
- 🇯🇵 Japan

### Country-Specific Processes

**United Kingdom**:

- GMC (General Medical Council) registration
- GMC number verification
- BMA membership (optional)

**Canada**:

- Provincial medical license
- CPSO, CPSBC, or other provincial regulator
- CMA membership (optional)

**Australia**:

- AHPRA registration
- Medical registration number
- RACGP/RACP membership (optional)

---

## Verification Support

### Help Desk

**Common Issues**:

1. **License not found in database**
   - Recent license renewal (not yet in system)
   - Name change (married/divorced)
   - Out-of-state license

2. **Name mismatch**
   - Middle name/initial differences
   - Hyphenated names
   - International characters

3. **Expired credentials**
   - Renewal in process
   - Temporary/locum license

**Resolution**:

- Support ticket system
- Phone verification available
- Alternative documentation accepted

### Appeals Process

**Rejected Application Appeal**:

1. User submits appeal with additional information
2. Senior verification specialist reviews
3. May request additional documentation
4. Decision within 5 business days
5. Final decision by medical director if still disputed

---

## Verification Badges

### Badge Display

**On Profile**:

```
Dr. Sarah Johnson
🟢 Verified Cardiologist
★★★★☆ 4.6/5.0 (872 reputation)
12+ years experience
```

**On Posts (Identified)**:

```
Dr. Sarah Johnson, MD, FACC
🟢 Verified Cardiologist
Posted 2 hours ago
```

**On Anonymous Posts**:

```
Anon#7392
🟢 Verified Cardiologist
★★★★☆ 4.6/5.0
12+ years experience
Posted 2 hours ago
```

### Badge Revocation

**Grounds for Revocation**:

- License lapse/revocation
- Fraudulent credentials discovered
- Multiple violations of community guidelines
- Criminal conviction (medical-related)

**Process**:

- Immediate badge removal
- Account restricted to read-only
- User notified of reason
- Can re-apply if credential issue resolved

---

## Success Metrics

**Verification KPIs**:

- Verification completion rate: >90%
- Average verification time: <48 hours
- False positive rate: <1%
- False negative rate: <0.1%
- User satisfaction with process: >4.5/5.0

**Security Metrics**:

- Zero credential data breaches
- Zero successful fraudulent verifications
- Quarterly security audits passed

---

## Conclusion

The Verification Process establishes trust on Uniting Doctors by ensuring only qualified healthcare professionals contribute medical content, while protecting user privacy and enabling anonymous participation for sensitive discussions.

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Identity & Verification Team
**Related Documents**:

- [REPUTATION_SYSTEM.md](../technical/REPUTATION_SYSTEM.md)
- [ANONYMITY_FRAMEWORK.md](../legal/ANONYMITY_FRAMEWORK.md)
- [COMMUNITY_GUIDELINES.md](./COMMUNITY_GUIDELINES.md)
