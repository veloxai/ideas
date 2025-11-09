# Content Moderation

## Executive Summary

**Content Moderation** ensures Uniting Doctors remains a safe, professional, and high-quality platform through AI-assisted automated moderation, community reporting, and expert human review—protecting users while enabling open discourse.

---

## Moderation Philosophy

### Core Principles

1. **Safety First**: Prevent harmful medical misinformation and abuse
2. **Free Discourse**: Enable controversial but evidence-based discussions
3. **Transparency**: Clear rules, consistent enforcement
4. **Due Process**: Appeals and human review for edge cases
5. **Scale & Speed**: AI automation with human oversight

---

## Moderation Layers

### Layer 1: Automated Pre-Screening (AI)

**Before Publication**:

```python
async def pre_screen_content(post):
    checks = {
        'spam': detect_spam(post.content),
        'profanity': detect_profanity(post.content),
        'medical_danger': detect_dangerous_advice(post.content),
        'phi_violation': detect_patient_info(post.content),
        'plagiarism': check_plagiarism(post.content),
        'quality': assess_quality_score(post.content)
    }

    if checks['medical_danger'] or checks['phi_violation']:
        return 'BLOCK'  # Immediate block
    elif checks['spam'] or checks['quality'] < 40:
        return 'REVIEW'  # Queue for human review
    else:
        return 'PUBLISH'  # Auto-approve
```

**Actions**:

- ✅ **Auto-Approve**: 85% of content (high quality, no flags)
- ⏸️ **Queue for Review**: 12% of content (quality concerns, uncertain)
- 🚫 **Auto-Block**: 3% of content (clear violations)

### Layer 2: Community Reporting

**User Reporting System**:

```
Report Categories:
□ Spam or Promotional Content
□ Medical Misinformation
□ Harassment or Personal Attack
□ HIPAA / Patient Privacy Violation
□ Off-Topic Content
□ Plagiarism
□ Dangerous Medical Advice
□ Other (explain)

[Submit Report]
```

**Report Handling**:

- **1-2 reports**: Flagged for AI re-analysis
- **3-5 reports**: Queue for moderator review (Priority: Normal)
- **5+ reports**: Queue for moderator review (Priority: High)
- **10+ reports**: Automatic temporary removal pending review

### Layer 3: Human Moderators

**Moderator Team**:

- **Professional Moderators**: 10-15 full-time staff
- **Volunteer Medical Moderators**: 50-100 verified physicians (reputation >850)
- **Specialty Experts**: On-call for complex cases

**Review Queue Priority**:

1. **Critical** (Review within 1 hour):
   - Patient safety issues
   - HIPAA violations
   - Harassment/threats

2. **High** (Review within 4 hours):
   - Misinformation with high visibility
   - Multiple community reports

3. **Normal** (Review within 24 hours):
   - Quality concerns
   - Off-topic content

4. **Low** (Review within 72 hours):
   - Minor formatting issues
   - Edge case interpretations

### Layer 4: Appeals & Escalation

**Appeal Process**:

1. User submits appeal within 7 days
2. Different moderator reviews
3. If still disputed → Senior moderator panel
4. Final decision within 14 days

---

## Moderation Rules

### Immediate Removal Offenses

**🚫 Zero Tolerance**:

1. **Dangerous Medical Advice**
   - Recommending stopping essential medications without physician consultation
   - Unproven "cures" for serious conditions
   - Advising against life-saving treatments

2. **Patient Privacy Violations**
   - Sharing identifiable patient information
   - Posting medical records without consent
   - HIPAA violations

3. **Harassment & Abuse**
   - Personal attacks, threats
   - Doxxing (revealing personal information)
   - Hate speech, discrimination

4. **Illegal Content**
   - Prescription fraud advice
   - Controlled substance trafficking
   - Copyright infringement

5. **Spam & Fraud**
   - Commercial promotion without disclosure
   - Phishing, malware
   - Fake credentials

**Penalty**: Immediate content removal + 50-100 reputation points + suspension risk

### Warning-Level Offenses

**⚠️ First Offense = Warning**:

1. **Low-Quality Content**
   - Unsupported medical claims
   - Missing citations for clinical advice
   - Poor formatting, unclear

2. **Off-Topic Posts**
   - Non-medical content in clinical forums
   - Political/religious debates unrelated to medicine

3. **Minor Discourtesy**
   - Condescending tone
   - Dismissive of others' experiences
   - Unprofessional language

**Penalty**: Warning + 5-10 reputation points

### Misinformation Handling

**Medical Misinformation Tiers**:

**Tier 1: Clearly False & Dangerous**

- Example: "Vaccines cause autism"
- Action: Remove + Warning/Suspension
- Penalty: -50 reputation

**Tier 2: Outdated or Disproven**

- Example: Using deprecated treatment protocols
- Action: Flag with correction + Educational notice
- Penalty: -10 reputation

**Tier 3: Controversial But Debatable**

- Example: Debates on emerging treatments
- Action: Label as "Controversial" + Counterpoints added
- Penalty: None (allowed discussion)

---

## AI Moderation Systems

### GPT-4 Content Analysis

```python
async def ai_moderate_post(post):
    prompt = f"""
    Analyze this medical forum post for moderation:

    POST:
    {post.content}

    Check for:
    1. Dangerous medical advice (yes/no + explanation)
    2. Patient privacy violations (yes/no + PHI detected)
    3. Spam or promotional content (yes/no + confidence)
    4. Medical accuracy (accurate/uncertain/inaccurate + reasoning)
    5. Professional tone (appropriate/borderline/inappropriate)
    6. Overall content quality (0-100)

    Return JSON with assessment and recommended action (approve/review/block).
    """

    response = await gpt4_analyze(prompt)
    return response
```

### Dangerous Content Detection

**Medical Safety Classifier**:

- Training data: 50K+ medical posts (manually labeled)
- Model: Fine-tuned BERT for medical safety
- Categories: Safe, Caution Required, Dangerous

**Example Detections**:

- ✅ Safe: "Beta-blockers reduce mortality in heart failure (MERIT-HF)"
- ⚠️ Caution: "Consider stopping beta-blocker if heart rate <50"
- 🚫 Dangerous: "Just stop your heart medication, you'll feel better"

### PHI Detection

**HIPAA Compliance Scanning**:

```python
def detect_phi(text):
    """
    Detect Protected Health Information
    """
    phi_detected = []

    # Names + medical context
    if detect_names_with_medical_context(text):
        phi_detected.append('patient_name')

    # Medical record numbers
    if re.search(r'MRN[\s:]+\d{6,}', text):
        phi_detected.append('mrn')

    # Dates + specific medical events
    if detect_dates_with_medical_events(text):
        phi_detected.append('dates')

    # Location + specific facility
    if detect_specific_facility(text):
        phi_detected.append('location')

    # Unique identifiers (SSN, etc.)
    if detect_unique_identifiers(text):
        phi_detected.append('unique_id')

    return phi_detected
```

---

## Moderator Training

### Training Program

**Required Training**:

1. **Platform Guidelines** (2 hours)
   - Community standards
   - Medical content policies
   - Off-label use framework

2. **Medical Safety** (3 hours)
   - Recognizing dangerous advice
   - Misinformation identification
   - Evidence evaluation

3. **HIPAA Compliance** (1 hour)
   - PHI recognition
   - De-identification standards
   - Violation handling

4. **Conflict Resolution** (2 hours)
   - De-escalation techniques
   - Handling appeals
   - Bias awareness

**Ongoing Education**:

- Monthly case reviews
- Quarterly policy updates
- Annual re-certification

### Moderator Tools

**Moderation Dashboard**:

```
┌────────────────────────────────────────────────────────┐
│ MODERATION QUEUE                                       │
├────────────────────────────────────────────────────────┤
│                                                        │
│ 🔴 CRITICAL (3)                                        │
│  • Possible patient privacy violation (5 min ago)      │
│  • Dangerous COVID advice (12 min ago)                 │
│  • Harassment report (23 min ago)                      │
│                                                        │
│ 🟠 HIGH PRIORITY (12)                                  │
│  • Misinformation - widely viewed (1 hr ago)           │
│  • Multiple spam reports (2 hr ago)                    │
│  ...                                                   │
│                                                        │
│ 🟡 NORMAL (45)                                         │
│ 🟢 LOW (23)                                            │
│                                                        │
│ [View All] [AI Suggestions] [Reports Analytics]       │
└────────────────────────────────────────────────────────┘
```

**Moderation Actions**:

- ✅ Approve
- 📝 Approve with Edit
- ⚠️ Warn User
- 🔒 Remove Content
- 🚫 Suspend User (1/7/30 days)
- ⛔ Permanent Ban

---

## Transparency Reports

### Public Reporting

**Quarterly Transparency Report**:

```
Q4 2025 Moderation Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Posts: 2,456,789
Total Comments: 8,234,567

Content Reviewed: 312,456 (3.8%)
├─ AI Pre-Screening: 295,123
├─ Community Reports: 12,334
└─ Proactive Review: 4,999

Actions Taken: 18,234
├─ Warnings: 12,456
├─ Content Removed: 4,123
├─ Suspensions: 1,234
└─ Permanent Bans: 421

Top Violation Categories:
1. Low-Quality Content (42%)
2. Spam (23%)
3. Medical Misinformation (18%)
4. Harassment (9%)
5. HIPAA Violations (4%)
6. Other (4%)

Appeals:
├─ Submitted: 892
├─ Overturned: 234 (26%)
└─ Upheld: 658 (74%)

Response Times:
├─ Critical: 47 min (avg)
├─ High: 2.3 hr (avg)
├─ Normal: 14 hr (avg)
```

---

## Success Metrics

**Moderation KPIs**:

- False positive rate: <5%
- False negative rate: <2%
- Average response time (critical): <1 hour
- User satisfaction with moderation: >4.0/5.0
- Appeal overturn rate: <30%

**Community Health**:

- Toxic content: <1% of posts
- User reports per 1000 posts: <5
- Moderator agreement rate: >90%

---

## Conclusion

Content Moderation balances platform safety with free discourse, using AI automation, community oversight, and expert human judgment to maintain Uniting Doctors as a trusted professional medical community.

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Trust & Safety Team
**Related Documents**:

- [COMMUNITY_GUIDELINES.md](./COMMUNITY_GUIDELINES.md)
- [REPUTATION_SYSTEM.md](../technical/REPUTATION_SYSTEM.md)
- [MEDICAL_CONTENT_STANDARDS.md](../clinical/MEDICAL_CONTENT_STANDARDS.md)
