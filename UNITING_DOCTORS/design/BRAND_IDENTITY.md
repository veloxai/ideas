# Brand Identity

## Executive Summary

The **Brand Identity** establishes Uniting Doctors' visual and verbal identity as a trusted platform for medical professionals. This document defines the brand's personality, voice, visual elements, and guidelines for consistent communication.

---

## Brand Positioning

### Mission Statement

> "Democratizing medical information in real-time, connecting healthcare professionals globally through anonymous, evidence-based discourse."

### Vision

> "A world where every healthcare professional has instant access to the collective wisdom of the medical community, improving patient outcomes through shared knowledge."

### Tagline

**"Where Doctors Share Real Medicine"**

**Alternative Taglines**:

- "Real Medicine, Real Time"
- "Evidence Shared, Patients Helped"
- "Anonymous Expertise, Open Knowledge"

---

## Brand Values

### 1. **Evidence-Based** 🔬

We prioritize peer-reviewed research, clinical guidelines, and rigorous evidence over anecdote or opinion.

### 2. **Anonymous & Safe** 🛡️

Healthcare professionals can speak freely without fear of retribution, maintaining career safety while sharing knowledge.

### 3. **Professional Excellence** ⚕️

We maintain high standards through verification, moderation, and reputation systems, ensuring quality discourse.

### 4. **Global Community** 🌍

Connecting doctors worldwide, transcending geographic and institutional boundaries to share medical knowledge.

### 5. **Patient-Centered** ❤️

All discussions ultimately serve to improve patient care and outcomes through better-informed clinicians.

---

## Brand Personality

### Archetype: **The Sage**

- **Characteristics**: Wise, knowledgeable, thoughtful, evidence-based
- **Not**: Elitist, ivory tower, condescending
- **Tone**: Authoritative but approachable

### Human Traits (If Uniting Doctors were a person):

- **Professor colleague**: Brilliant but humble
- **Late-night rounds mentor**: Teaching practical wisdom
- **Journal club leader**: Evidence-focused but open-minded
- **Trusted consultant**: Always available for a curbside consult

---

## Voice & Tone

### Voice (Constant)

- **Professional**: Medical terminology used appropriately
- **Clear**: Plain language when possible
- **Evidence-Based**: Citations and references valued
- **Inclusive**: Welcoming to all specialties and career stages

### Tone (Adapts by Context)

| Context                  | Tone                      | Example                                                                                           |
| ------------------------ | ------------------------- | ------------------------------------------------------------------------------------------------- |
| **Onboarding**           | Welcoming, Supportive     | "Welcome! Let's verify your credentials so you can join thousands of healthcare professionals..." |
| **Educational Content**  | Authoritative, Clear      | "Level 1a evidence from systematic reviews shows..."                                              |
| **Community Guidelines** | Firm, Fair                | "Medical misinformation violates our core values and will be removed."                            |
| **Error Messages**       | Helpful, Non-Judgmental   | "We couldn't find that post. It may have been removed or the link is incorrect."                  |
| **Success Messages**     | Encouraging, Positive     | "Great question! We've notified 234 cardiologists."                                               |
| **Moderation**           | Professional, Transparent | "This content was removed because it contradicts evidence-based standards. [Appeal]"              |

---

## Visual Identity

### Logo Concepts

#### Primary Logo: The Stethoscope Network

```
      ⊕
     ╱│╲
    ╱ │ ╲
   ⊕──⊕──⊕
    ╲ │ ╱
     ╲│╱
      ⊕

  UNITING DOCTORS
```

**Concept**:

- **Stethoscope bell** (⊕) at nodes representing doctors
- **Connected network** lines showing global community
- **Medical symbol** integrated with network topology
- **Clean, modern** sans-serif typography

**Color Version**:

- Nodes: Medical Blue (#1E40AF)
- Connections: Light Blue (#3B82F6)
- Text: Dark Gray (#1F2937)

#### Alternative: The Caduceus Constellation

```
    ★
   ★ ★
  ★   ★
   ★ ★
    ★

  UNITING
  DOCTORS
```

**Concept**:

- Stars representing individual doctors
- Constellation forming caduceus shape
- Global/universal theme
- Aspirational, reaching for excellence

---

### Color Palette

#### Primary Colors

**Medical Blue**

```
Primary:       #1E40AF  ███████  Main brand color, buttons, links
Primary Light: #3B82F6  ███████  Hover states, accents
Primary Dark:  #1E3A8A  ███████  Headers, emphasis
```

**Why Blue?**

- **Trust**: Most trusted color in healthcare
- **Professional**: Medical institutions worldwide
- **Calm**: Reduces anxiety, promotes clear thinking
- **Universal**: Works across cultures

#### Secondary Colors

**Success Green** (Verification, Positive Actions)

```
#10B981  ███████  Verified badges, success messages
```

**Warning Amber** (Caution, Attention)

```
#F59E0B  ███████  Low evidence levels, warnings
```

**Danger Red** (Errors, Dangerous Content)

```
#EF4444  ███████  Errors, content removal, critical alerts
```

**Info Cyan** (Informational, Research)

```
#06B6D4  ███████  Research papers, educational content
```

#### Neutral Palette

```
Slate 900:  #0F172A  ███████  Headings, primary text
Slate 700:  #334155  ███████  Body text
Slate 500:  #64748B  ███████  Secondary text, captions
Slate 300:  #CBD5E1  ███████  Borders, dividers
Slate 100:  #F1F5F9  ███████  Background, cards
White:      #FFFFFF  ███████  Canvas, primary background
```

#### Reputation Tier Colors

```
Bronze:   #CD7F32  ███████  New contributors (0-250 rep)
Silver:   #C0C0C0  ███████  Active members (250-1000 rep)
Gold:     #FFD700  ███████  Trusted experts (1000-5000 rep)
Diamond:  #B9F2FF  ███████  Senior experts (5000+ rep)
```

---

### Typography

#### Primary Typeface: **Inter**

**Why Inter?**

- **Legibility**: Optimized for screens, tall x-height
- **Professional**: Clean, modern sans-serif
- **Open Source**: Free for commercial use
- **Variable Font**: Single file, multiple weights

**Usage**:

```css
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Headings */
H1: Inter, 36px, 700 weight, -0.02em letter-spacing
H2: Inter, 30px, 600 weight, -0.01em letter-spacing
H3: Inter, 24px, 600 weight, 0 letter-spacing
H4: Inter, 20px, 600 weight, 0 letter-spacing

/* Body Text */
Body: Inter, 16px, 400 weight, 0 letter-spacing, 1.5 line-height
Small: Inter, 14px, 400 weight
Caption: Inter, 12px, 500 weight, 0.05em letter-spacing, uppercase
```

#### Monospace Typeface: **JetBrains Mono**

**Usage**:

- Code snippets
- Medical record numbers (when needed)
- Technical documentation
- API examples

```css
font-family: 'JetBrains Mono', 'Courier New', monospace;
code:
  JetBrains Mono,
  14px,
  400 weight;
```

#### Fallback Stack

```css
font-family:
  'Inter',
  -apple-system,
  /* iOS, macOS */ BlinkMacSystemFont,
  /* macOS */ 'Segoe UI',
  /* Windows */ 'Roboto',
  /* Android */ 'Helvetica Neue',
  /* Older macOS */ Arial,
  /* Universal fallback */ sans-serif; /* Generic */
```

---

### Iconography

#### Style: **Heroicons (Outline)**

**Why Heroicons?**

- Consistent with modern web design
- Open source (MIT license)
- Multiple sizes (16px, 20px, 24px)
- Outline and solid variants

**Icon Usage**:

```
🏠  Home / Feed
🔍  Search
🔔  Notifications
👤  Profile / User
⬆  Upvote / Like
💬  Comments / Discussion
📚  Research / Papers
⚕️  Verified / Medical
📊  Evidence Level / Data
🏷  Tags / Categories
📤  Share
🔖  Save / Bookmark
⚙️  Settings
❓  Question
✓  Accepted Answer / Verified
🚨  Report / Warning
🛡️  Moderation
```

#### Custom Icons

**Reputation Tiers**:

```
Bronze:   ◆  (Copper diamond)
Silver:   ◇  (Silver diamond)
Gold:     ♦  (Gold filled diamond)
Diamond:  💎  (Crystal diamond)
```

**Evidence Levels**:

```
Level 1a: ●●●●● (5 filled circles)
Level 1b: ●●●●○ (4 filled, 1 empty)
Level 2:  ●●●○○ (3 filled, 2 empty)
Level 3:  ●●○○○ (2 filled, 3 empty)
Level 4:  ●○○○○ (1 filled, 4 empty)
Level 5:  ○○○○○ (0 filled, 5 empty)
```

---

### Photography & Imagery

#### Style Guidelines

**DO**:

- ✓ Use high-quality medical imagery
- ✓ Show diverse healthcare professionals
- ✓ Authentic clinical settings (not stock photo "hospital")
- ✓ Close-ups of medical equipment (stethoscope, X-rays, charts)
- ✓ Abstract medical patterns (EKG traces, molecular structures)
- ✓ Muted, professional color grading

**DON'T**:

- ✗ Generic stock photos of smiling doctors
- ✗ Patient faces (PHI concerns)
- ✗ Overly staged scenes
- ✗ Bright, cheerful colors (too consumer-facing)
- ✗ Cartoonish medical illustrations

#### Image Treatment

```css
/* Subtle blue overlay for brand consistency */
filter: sepia(0.2) hue-rotate(180deg) saturate(0.8);

/* Optional: Duotone effect */
filter: grayscale(1) contrast(1.1) brightness(0.9);
mix-blend-mode: multiply;
background-color: #1e40af; /* Medical blue */
```

#### Illustration Style (When Needed)

**Characteristics**:

- Line art style (not flat/colorful)
- Medical blue accent color
- Anatomically accurate (not cartoonish)
- Technical drawing aesthetic
- Similar to medical textbook illustrations

---

## Brand Applications

### Website Header

```
┌───────────────────────────────────────────────────────────────┐
│  ⊕  UNITING DOCTORS     🔍 Search...    🔔  Login / Sign Up   │
│                                                               │
│  Where Doctors Share Real Medicine                            │
└───────────────────────────────────────────────────────────────┘
```

### Email Templates

#### Welcome Email

```
Subject: Welcome to Uniting Doctors 👋

────────────────────────────────────────────

  ⊕  UNITING DOCTORS

────────────────────────────────────────────

Hi [Name],

Welcome to Uniting Doctors, where thousands of healthcare
professionals share evidence-based medicine in real-time.

Your account is ready, but we need to verify your credentials
to ensure the highest quality discussions.

[Verify My Credentials]

Once verified, you'll be able to:
✓ Ask questions and get expert answers
✓ Share research and clinical experiences
✓ Build your reputation as a trusted expert

Questions? Reply to this email.

────────────────────────────────────────────
Uniting Doctors | Real Medicine, Real Time
Unsubscribe | Privacy Policy
────────────────────────────────────────────
```

### Social Media

#### Twitter/X Profile

**Bio**:
"Connecting healthcare professionals globally through anonymous, evidence-based discourse. Where doctors share real medicine. 🩺"

**Header Image**:
Abstract network visualization with medical blue color scheme, showing nodes (doctors) connected globally.

#### LinkedIn Profile

**Headline**:
"Uniting Doctors | Professional Medical Knowledge Platform"

**About**:
"Uniting Doctors is a platform for healthcare professionals to share evidence-based medical knowledge anonymously. We connect physicians, nurses, pharmacists, and allied health professionals worldwide to improve patient care through collaborative learning."

---

## Messaging Framework

### Value Propositions

**For Individual Doctors**:

- "Get expert answers to your clinical questions in minutes, not days"
- "Share your experiences anonymously without career risk"
- "Build your reputation as a trusted medical expert"

**For Healthcare Institutions**:

- "Empower your physicians with collective wisdom of global medical community"
- "Supplement CME with real-time, peer-to-peer learning"
- "Foster a culture of evidence-based medicine"

**For Medical Students/Residents**:

- "Learn from practicing physicians' real-world experiences"
- "Ask questions without judgment"
- "Prepare for clinical practice with practical insights"

### Key Messages

#### Differentiation from Social Media

❌ **Not This**: "Medical Facebook" or "Healthcare Twitter"
✅ **This**: "Professional medical knowledge platform with peer review and evidence standards"

#### Differentiation from UpToDate/Medical Journals

❌ **Not This**: "Replacing clinical guidelines"
✅ **This**: "Supplementing formal education with real-time, practical experience from frontline clinicians"

#### Differentiation from Reddit/SDN

❌ **Not This**: "Anonymous forum with no quality control"
✅ **This**: "Anonymous platform with verified professionals, reputation systems, and medical moderation"

---

## Brand Guidelines

### Logo Usage

#### Minimum Size

- Digital: 120px width
- Print: 0.75 inches width

#### Clear Space

Maintain clear space around logo equal to height of "U" in "UNITING"

#### Incorrect Usage

```
✗ Don't stretch or distort
✗ Don't change colors (except approved variants)
✗ Don't add effects (shadows, gradients, etc.)
✗ Don't place on busy backgrounds
✗ Don't rotate
✗ Don't outline
```

### Color Usage

#### Digital (RGB)

```
Medical Blue:   rgb(30, 64, 175)  | #1E40AF
Success Green:  rgb(16, 185, 129) | #10B981
Warning Amber:  rgb(245, 158, 11) | #F59E0B
Danger Red:     rgb(239, 68, 68)  | #EF4444
```

#### Print (CMYK)

```
Medical Blue:   C100 M75 Y0 K0
Success Green:  C70 M0 Y80 K0
Warning Amber:  C0 M40 Y100 K0
Danger Red:     C0 M80 Y75 K0
```

#### Accessibility

All color combinations meet WCAG 2.1 AA standards:

- Text on background: 4.5:1 minimum
- Large text: 3:1 minimum
- Interactive elements: 3:1 minimum

### Typography Hierarchy

```
Page Title (H1):    36px/700/Medical Blue
Section Title (H2): 30px/600/Slate 900
Subsection (H3):    24px/600/Slate 900
Body Text:          16px/400/Slate 700
Small Text:         14px/400/Slate 500
Caption:            12px/500/Slate 500/UPPERCASE
```

---

## Content Guidelines

### Writing for Uniting Doctors

#### Medical Terminology

**DO**: Use appropriate medical terminology

```
✓ "Administer epinephrine 1mg IV push for anaphylaxis"
✓ "Consider PERC rule for PE risk stratification"
```

**DON'T**: Dumb down for general audience (we're professionals)

```
✗ "Give the medicine for allergic reactions"
✗ "Check if the patient might have a blood clot in the lungs"
```

#### Evidence & Citations

**DO**: Cite sources appropriately

```
✓ "The VASST trial showed no mortality difference between
    vasopressin and norepinephrine (NEJM 2008;358:877)"
```

**DON'T**: Make unsupported claims

```
✗ "Vasopressin is definitely better than norepinephrine"
```

#### Disclaimers

Always include appropriate disclaimers:

```
⚠️ "This information is for educational purposes only.
Clinical decisions should be individualized to each patient."
```

---

## Brand Voice Examples

### Platform Communications

#### Onboarding

```
Welcome Screen:
"Welcome to Uniting Doctors

Thousands of healthcare professionals use this platform to
share evidence-based medicine and improve patient care.

Let's verify your credentials so you can join the discussion."

[Verify Credentials] [Learn More]
```

#### Content Moderation

```
Removal Notice:
"Content Removed: Medical Misinformation

This post was removed because it recommended stopping
life-saving medication without evidence.

We prioritize patient safety and evidence-based medicine.

[Appeal Decision] [Review Guidelines]"
```

#### Success Messages

```
Question Posted:
"✓ Question posted successfully!

We've notified 234 Emergency Medicine specialists.
Most questions receive answers within 2 hours.

[View Your Question]"
```

---

## Competitive Positioning

### Competitive Matrix

| Platform            | Focus                   | Anonymous        | Verified | Evidence-Based  |
| ------------------- | ----------------------- | ---------------- | -------- | --------------- |
| **Uniting Doctors** | ✓ Medical Professionals | ✓ Yes            | ✓ Yes    | ✓ Yes           |
| UpToDate            | Clinical reference      | ✗ No interaction | N/A      | ✓ Yes           |
| PubMed              | Research search         | ✗ No interaction | N/A      | ✓ Yes           |
| Reddit r/medicine   | Medical discussions     | ✓ Partial        | ✗ No     | ✗ Variable      |
| Doximity            | Professional network    | ✗ Public profile | ✓ Yes    | ✗ Not focused   |
| Sermo               | Physician surveys       | ✓ Partial        | ✓ Yes    | ✗ Opinion-based |

**Uniting Doctors' Unique Position**:
The only platform that combines **anonymity** + **verification** + **evidence-based standards** in a **real-time discussion format**.

---

## Launch Messaging

### Phase 1: Alpha/Beta (Closed)

**Target**: 1,000 early adopters
**Message**: "Join an exclusive community of healthcare professionals shaping the future of medical knowledge sharing."

### Phase 2: Public Launch

**Target**: 50,000 users
**Message**: "Where doctors share real medicine. Anonymous, verified, evidence-based."

### Phase 3: Growth

**Target**: 500,000+ users
**Message**: "Join [X]00,000 healthcare professionals democratizing medical information."

---

## Brand Extensions

### Future Sub-Brands

#### Uniting Doctors Research

```
⊕  UNITING DOCTORS
   RESEARCH

"Collaborative research platform for medical professionals"
Color: Info Cyan (#06B6D4)
```

#### Uniting Doctors CME

```
⊕  UNITING DOCTORS
   CME

"Earn CME credits through evidence-based discussions"
Color: Success Green (#10B981)
```

#### Uniting Doctors Conference

```
⊕  UNITING DOCTORS
   CONFERENCE 2025

"Annual gathering of medical minds"
Color: Medical Blue (#1E40AF)
```

---

## Brand Assets

### Digital Asset Library

**File Structure**:

```
brand/
├── logos/
│   ├── primary/
│   │   ├── uniting-doctors-logo.svg
│   │   ├── uniting-doctors-logo.png (1x, 2x, 3x)
│   │   └── uniting-doctors-logo-white.svg
│   ├── icon/
│   │   ├── icon-blue.svg
│   │   ├── icon-white.svg
│   │   └── favicon.ico
│   └── lockup/
│       ├── horizontal.svg
│       └── vertical.svg
├── colors/
│   ├── color-palette.ase (Adobe Swatch)
│   └── color-palette.json
├── typography/
│   ├── Inter-VariableFont.ttf
│   └── JetBrainsMono-Regular.ttf
├── icons/
│   └── heroicons/ (imported)
├── templates/
│   ├── email/
│   ├── social-media/
│   └── presentations/
└── guidelines/
    └── brand-guidelines.pdf (this document)
```

---

## Conclusion

The Uniting Doctors brand represents:

- **Trust**: Medical blue, professional tone, evidence-based
- **Anonymity**: Network symbolism, safe space for open discourse
- **Excellence**: High standards, verification, quality moderation
- **Community**: Global connections, collaborative learning

**Core Principle**: Always prioritize **patient safety** and **evidence-based medicine** in all brand communications.

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Brand & Marketing Team
**Related Documents**:

- [WIREFRAMES.md](./WIREFRAMES.md)
- [USER_FLOWS.md](./USER_FLOWS.md)
- [MEDICAL_CONTENT_STANDARDS.md](../clinical/MEDICAL_CONTENT_STANDARDS.md)
