# International Compliance Framework

## Executive Summary

The **International Compliance Framework** ensures Uniting Doctors operates legally and ethically across global jurisdictions. This framework addresses privacy regulations, healthcare laws, content regulations, and operational requirements for international medical professional platforms.

---

## Privacy & Data Protection

### GDPR (European Union)

**General Data Protection Regulation (EU 2016/679)**

**Lawful Basis for Processing**:

```
Primary Basis: Legitimate Interest (Art. 6(1)(f))
- Operating a professional medical information platform
- Balancing test: Platform utility vs. privacy risks

Secondary Basis: Consent (Art. 6(1)(a))
- Analytics cookies
- Marketing communications
- Optional features

Special Category Data: Healthcare professional data (Art. 9)
- Necessary for platform function
- Professional verification requires medical credentials
```

**GDPR Rights Implementation**:

1. **Right to Access (Art. 15)**:

   ```python
   def generate_data_export(user_id):
       """
       Complete data export in machine-readable format
       """
       export = {
           'personal_data': {
               'email': user.email,
               'name': user.name,
               'verification': user.verification_data,
               'created': user.created_at.isoformat()
           },
           'activity_data': {
               'posts': get_user_posts(user_id),
               'comments': get_user_comments(user_id),
               'votes': get_user_votes(user_id),
               'searches': get_user_searches(user_id),
               'viewed_content': get_viewed_content(user_id)
           },
           'technical_data': {
               'ip_logs': get_ip_logs(user_id),
               'device_info': get_device_info(user_id),
               'session_data': get_sessions(user_id)
           },
           'inferred_data': {
               'specialties': user.inferred_specialties,
               'interests': user.interest_tags,
               'reputation': user.reputation_score
           }
       }

       return json.dumps(export, indent=2)
   ```

2. **Right to Erasure / "Right to be Forgotten" (Art. 17)**:

   ```python
   def process_deletion_request(user_id, reason):
       """
       GDPR-compliant account deletion
       """
       user = get_user(user_id)

       # Exceptions to deletion
       if has_legal_hold(user_id):
           return {
               'status': 'denied',
               'reason': 'Legal obligation to retain data'
           }

       deletion_plan = {
           'immediate': [
               'personal_identifiers',  # Name, email, phone
               'profile_data',          # Bio, photo, location
               'device_identifiers',    # IP logs, device IDs
               'authentication'         # Passwords, tokens
           ],
           'anonymize': [
               'posts',                 # Replace author with [Deleted]
               'comments',              # Preserve content, remove attribution
               'votes'                  # Aggregate only
           ],
           'retain_90_days': [
               'moderation_logs',       # Appeal period
               'payment_records'        # Financial compliance
           ],
           'retain_legal': [
               'copyright_violations',  # DMCA records
               'terms_violations'       # Legal defense
           ]
       }

       execute_deletion(user_id, deletion_plan)

       return {
           'status': 'completed',
           'deletion_date': datetime.now(),
           'confirmation_code': generate_code()
       }
   ```

3. **Right to Rectification (Art. 16)**:
   - Users can edit profile data anytime
   - Verification data correction via re-verification
   - Activity data correction via content editing

4. **Right to Data Portability (Art. 20)**:
   - JSON export of all user data
   - Standard format for interoperability
   - Machine-readable, structured format

5. **Right to Object (Art. 21)**:
   - Object to direct marketing (opt-out)
   - Object to profiling for recommendations
   - Cannot object to core platform functions

**Data Protection Officer (DPO)**:

```
Data Protection Officer
Uniting Doctors, Inc.
Email: dpo@unitingdoctors.com
Address: [EU Representative Address]

EU Representative (Art. 27):
[Legal Entity Name]
[Address in EU Member State]
```

**Privacy Policy Transparency**:

- Plain language (not legalese)
- Available in all EU official languages
- Layered privacy notice (short + full version)
- Updated: Notify users 30 days before changes

**Cross-Border Data Transfers**:

```
DATA TRANSFER MECHANISMS (Chapter V)

Primary: Standard Contractual Clauses (SCCs)
- European Commission approved clauses
- Module 1: Controller to Controller
- Supplementary measures (encryption, access controls)

Secondary: Adequacy Decisions
- Transfer to adequate countries (UK, Switzerland, Japan, etc.)
- No additional safeguards needed

Fallback: Consent
- Explicit, informed consent for transfers
- One-time data exports only
```

**GDPR Penalties**: Up to €20M or 4% global revenue (whichever is higher)

---

### UK GDPR & Data Protection Act 2018

**Post-Brexit Compliance**:

- UK GDPR (retained EU law with amendments)
- Same principles as EU GDPR
- ICO (Information Commissioner's Office) enforcement

**Key Differences**:

- UK representative required (if no UK establishment)
- ICO registration: £40-2,900 annual fee
- Brexit: No free flow with EU (requires adequacy decision or SCCs)

**ICO Registration**:

```
Organization: Uniting Doctors UK Ltd
Registration #: [ICO Registration Number]
Data Protection Fee: Tier 2 (£60/year for <250 employees)
Renewal: Annual
```

---

### PIPEDA (Canada)

**Personal Information Protection and Electronic Documents Act**

**10 Fair Information Principles**:

1. Accountability – Designate privacy officer
2. Identifying Purposes – Clear data use statements
3. Consent – Meaningful, not bundled
4. Limiting Collection – Only necessary data
5. Limiting Use, Disclosure, Retention – Purpose limitation
6. Accuracy – Keep data current
7. Safeguards – Security measures
8. Openness – Transparent practices
9. Individual Access – Data access requests
10. Challenging Compliance – Complaint mechanism

**Provincial Laws**:

- Alberta: PIPA (Personal Information Protection Act)
- British Columbia: PIPA
- Quebec: Law 25 (stricter than PIPEDA)

**Cross-Border Considerations**:

```
CANADIAN DATA RESIDENCY

Health data may be subject to provincial requirements:
- BC: Health data must stay in Canada (FIPPA)
- Quebec: Consent required for transfer outside Quebec

Approach:
- Canadian data center option (AWS Canada)
- Consent for US data transfers
- Encryption in transit and at rest
```

---

### CCPA/CPRA (California, USA)

**California Consumer Privacy Act (CCPA) + California Privacy Rights Act (CPRA)**

**Consumer Rights**:

- Right to Know (data collected)
- Right to Delete
- Right to Opt-Out of Sale
- Right to Correct inaccurate data (CPRA)
- Right to Limit Use of Sensitive Personal Information (CPRA)

**"Do Not Sell My Personal Information"**:

```
Uniting Doctors does NOT sell personal information.

We share data with:
• Service providers (hosting, analytics)
• As required by law
• With user consent

We do NOT share data with:
• Data brokers
• Advertisers for targeted ads
• Third parties for their marketing

Users can still submit opt-out requests, which we honor.
```

**CPRA Sensitive Personal Information**:

- Health data
- Precise geolocation
- Racial/ethnic origin
- Religious beliefs
- Genetic data

**Approach**: Limit use to necessary business purposes only

**Verification for Data Requests**:

```python
def verify_california_request(email, verification_code):
    """
    Two-step verification for CCPA/CPRA requests
    """
    # Step 1: Email verification
    if not verify_email_code(email, verification_code):
        return {'error': 'Invalid verification code'}

    # Step 2: Account challenge question (for sensitive requests)
    if request_type == 'deletion':
        if not verify_challenge_question():
            return {'error': 'Additional verification required'}

    # Step 3: Process request
    process_ccpa_request(email, request_type)
```

---

### Other Jurisdictions

**Australia (Privacy Act 1988)**:

- 13 Australian Privacy Principles (APPs)
- Notifiable Data Breaches scheme
- Cross-border disclosure rules

**Brazil (LGPD)**:

- Lei Geral de Proteção de Dados
- Similar to GDPR
- ANPD (Data Protection Authority)

**India (Digital Personal Data Protection Act 2023)**:

- Consent-based framework
- Data localization requirements
- Right to erasure and correction

**Japan (APPI)**:

- Act on Protection of Personal Information
- Similar to GDPR (adequacy decision from EU)
- Anonymization allowed without consent

**Singapore (PDPA)**:

- Personal Data Protection Act
- Consent and purpose limitation
- Data breach notification

---

## Medical & Healthcare Regulations

### FDA (United States)

**FDA Jurisdiction**:

```
Does Uniting Doctors fall under FDA regulation?

Analysis:
• NOT a medical device (no diagnosis/treatment functions)
• NOT a drug or biologic
• NOT making medical claims
• Platform for professional discourse

Conclusion: Outside FDA jurisdiction as information platform

BUT: Monitor "Clinical Decision Support" features
• If we add diagnostic algorithms → May be regulated
• If we recommend treatments → May be regulated
• Current design avoids this
```

**Off-Label Discussions (First Amendment)**:

- Healthcare professionals CAN discuss off-label uses
- Platforms CAN host these discussions
- We do NOT promote off-label uses (users do)

---

### EMA (European Medicines Agency)

**Pharmacovigilance Requirements**:

```
Do we need to report adverse drug reactions?

Analysis:
• Healthcare professionals have obligation to report ADRs
• Platforms generally do NOT have reporting obligation
• BUT: If we systematically collect ADR data → May have duty

Approach:
• Encourage users to report ADRs to national systems
• Provide links to Yellow Card (UK), VigiBase (WHO), etc.
• Do NOT structure platform as ADR collection system
• If user posts serious ADR, flag for visibility
```

**EMA Countries**: EU member states + Iceland, Liechtenstein, Norway

---

### MHRA (UK Medicines and Healthcare products Regulatory Agency)

**Similar to FDA/EMA**:

- Monitor for medical device claims
- Yellow Card scheme for ADR reporting
- Off-label discussion allowed

---

### TGA (Therapeutic Goods Administration, Australia)

**Advertising Code**:

- Cannot advertise prescription medicines to public
- Healthcare professional communications exempt
- Platform must verify users are professionals

---

### Health Canada

**Medical Device Regulations**:

- Similar analysis to FDA
- Currently outside scope

**Natural Health Products**:

- If users discuss NHPs, ensure proper disclaimers

---

## Content Moderation Laws

### Digital Services Act (EU)

**DSA Categories**:

```
Uniting Doctors classification:

❓ Online Platform (>45M EU users)
  → Requires: Content moderation, transparency reports, user appeals

❓ Very Large Online Platform (>45M EU users)
  → Requires: Risk assessments, external audits, systemic risk mitigation

Current: Smaller platform (not VLOP yet)
Future: May reach VLOP threshold
```

**DSA Requirements**:

1. **Illegal Content Removal**:
   - Notice-and-action mechanism
   - Remove illegal content promptly
   - Notify uploader with reason

2. **Terms of Service Enforcement**:
   - Clear, accessible terms
   - Content moderation explained
   - User appeals process

3. **Transparency Reports (Annual)**:

   ```json
   {
     "content_moderation": {
       "total_reports": 5420,
       "content_removed": 1240,
       "removal_reasons": {
         "misinformation": 520,
         "harassment": 340,
         "spam": 280,
         "other": 100
       },
       "average_response_time_hours": 18,
       "appeals": {
         "total": 180,
         "upheld": 45,
         "overturned": 135
       }
     },
     "automated_moderation": {
       "percentage_automated": 0.65,
       "human_review_percentage": 0.35
     }
   }
   ```

4. **Risk Assessment (VLOPs only)**:
   - Systemic risks (disinformation, mental health, etc.)
   - Mitigation measures
   - Independent audit

**Penalties**: Up to 6% global turnover

---

### Online Safety Bill (UK)

**Duty of Care**:

- Protect users from illegal content
- Protect children (age verification if needed)
- Risk assessments
- Ofcom regulation

**Healthcare Professional Platform**:

- Adults-only (18+)
- Professional verification reduces risk
- Medical misinformation addressed via clinical standards

---

### Section 230 (United States)

**Covered extensively in CONTENT_LIABILITY.md**

Summary:

- Platform immunity for user content
- Good faith moderation protected
- Exceptions: Federal crimes, IP, ECPA

---

## Accessibility Requirements

### WCAG 2.1 AA Compliance

**Web Content Accessibility Guidelines**:

- Perceivable (text alternatives, captions, adaptable)
- Operable (keyboard accessible, enough time, seizure-safe)
- Understandable (readable, predictable, input assistance)
- Robust (compatible with assistive technologies)

**Legal Requirements**:

- **US**: ADA Title III (public accommodations)
- **EU**: European Accessibility Act (June 2025)
- **UK**: Equality Act 2010
- **Canada**: Accessible Canada Act (AODA)

**Implementation**:

```html
<!-- Semantic HTML -->
<nav aria-label="Main navigation">
  <ul>
    <li><a href="/feed">Feed</a></li>
  </ul>
</nav>

<!-- ARIA labels -->
<button aria-label="Upvote post" onclick="vote('up')">↑</button>

<!-- Alt text -->
<img
  src="chart.png"
  alt="Bar chart showing medication efficacy: Drug A 75%, Drug B 60%, Placebo 20%"
/>

<!-- Keyboard navigation -->
<div role="button" tabindex="0" onkeypress="handleKey(event)">
  Click or press Enter
</div>
```

---

## Tax & Business Registration

### International Operations

**Corporate Structure**:

```
Uniting Doctors, Inc. (Delaware C-Corp)
├── Uniting Doctors EU B.V. (Netherlands)
│   └── GDPR compliance, EU operations
├── Uniting Doctors UK Ltd (United Kingdom)
│   └── Post-Brexit UK operations
├── Uniting Doctors Canada Inc. (Ontario)
│   └── Canadian operations
└── Uniting Doctors Pty Ltd (Australia)
    └── Australian operations
```

**VAT/GST Registration**:

- **EU**: VAT registration if €10k threshold exceeded
- **UK**: VAT registration if £85k threshold exceeded
- **Canada**: GST/HST registration required (no threshold for non-residents)
- **Australia**: GST registration if AU$75k threshold exceeded

**Tax Compliance**:

- Transfer pricing (intercompany transactions)
- Permanent establishment analysis
- Digital services taxes (France, UK, etc.)

---

## Employment & Labor Laws

### Remote Healthcare Professionals

**Contractor vs. Employee**:

```
Uniting Doctors users: Independent contractors (not employees)
- No employment relationship
- Users control their own work
- No benefits, no minimum wage
- IRS Form 1099 (US) / equivalent

Platform staff: Employees
- Follow local employment laws
- Benefits, minimum wage, etc.
```

**Moderators**:

- Healthcare professionals (paid contractors)
- Follow employment laws in their jurisdiction
- Proper classification critical

---

## Compliance Monitoring

### Regulatory Change Tracking

**Monitoring Systems**:

```python
regulatory_tracking = {
    'sources': [
        'IAPP (International Association of Privacy Professionals)',
        'DLA Piper Data Protection Laws',
        'OneTrust Regulatory Tracker',
        'National law firm updates',
        'Government agency newsletters'
    ],
    'jurisdictions': [
        'EU', 'UK', 'US', 'Canada', 'Australia',
        'Brazil', 'India', 'Singapore', 'Japan'
    ],
    'areas': [
        'Privacy/data protection',
        'Healthcare regulations',
        'Content moderation',
        'Accessibility',
        'Employment law'
    ],
    'review_frequency': 'Monthly',
    'escalation': 'Legal counsel for significant changes'
}
```

**Quarterly Compliance Reviews**:

- New regulations enacted
- Enforcement actions in industry
- Platform policy updates needed
- Training for compliance team

---

## International Launch Checklist

### Market Entry Requirements

**Phase 1: Core Markets (US, UK, EU)**

- ✓ GDPR compliance
- ✓ UK GDPR + ICO registration
- ✓ CCPA compliance (California)
- ✓ Accessibility (WCAG 2.1 AA)
- ✓ Terms of Service (region-specific)
- ✓ Privacy Policy (GDPR-compliant)
- ✓ Cookie consent (GDPR)

**Phase 2: Expansion (Canada, Australia)**

- ✓ PIPEDA compliance (Canada)
- ✓ Provincial privacy laws (Quebec, BC)
- ✓ Privacy Act compliance (Australia)
- ✓ TGA guidelines (Australia)
- ✓ Local business registration
- ✓ Tax registration (VAT/GST)

**Phase 3: Global (Brazil, India, Singapore, Japan)**

- ✓ LGPD compliance (Brazil)
- ✓ DPDPA compliance (India)
- ✓ PDPA compliance (Singapore)
- ✓ APPI compliance (Japan)
- ✓ Local language support
- ✓ Regional medical standards

---

## Incident Response

### Data Breach Notification

**GDPR (72 hours to DPA)**:

```
BREACH NOTIFICATION PROCEDURE

Within 72 hours:
1. Notify lead supervisory authority (Ireland if EU HQ there)
2. Include:
   • Nature of breach
   • Categories and number of affected users
   • Likely consequences
   • Measures taken/proposed

To Users (if high risk):
• Direct notification
• Clear, plain language
• Advice on protective measures
```

**Other Jurisdictions**:

- **UK**: 72 hours to ICO
- **California**: "Without unreasonable delay"
- **Canada**: ASAP if real risk of significant harm
- **Australia**: Notifiable Data Breaches (NDB) scheme

**Breach Response Team**:

- CTO (technical investigation)
- Legal counsel (notification obligations)
- DPO (privacy assessment)
- Communications (public relations)

---

## Conclusion

The International Compliance Framework ensures Uniting Doctors operates legally across jurisdictions through:

- **Privacy**: GDPR, UK GDPR, PIPEDA, CCPA/CPRA compliance
- **Healthcare**: Monitoring FDA/EMA regulations, ADR reporting guidance
- **Content**: DSA, Online Safety Bill, Section 230 compliance
- **Accessibility**: WCAG 2.1 AA across all markets
- **Business**: Corporate structure, tax compliance, employment law

**Key Principles**:

- Privacy by design (GDPR-level for all users)
- Regional expertise (local counsel in each market)
- Proactive monitoring (regulatory change tracking)
- User transparency (clear policies, accessible language)
- Compliance as competitive advantage

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Legal & Compliance Team
**Related Documents**:

- [CONTENT_LIABILITY.md](./CONTENT_LIABILITY.md)
- [ANONYMITY_FRAMEWORK.md](./ANONYMITY_FRAMEWORK.md)
- [DATA_AGGREGATION.md](../technical/DATA_AGGREGATION.md)
