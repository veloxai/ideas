# Feature #16: Multi‑Language Support (Internationalization / i18n)

**Category**: Important Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 frontend developer, 0.5 FTE localization engineer/project manager, 0.25 FTE UX writer

---

## Executive summary

Fair Underwriting serves a diverse patient population; language barriers reduce adoption, increase support costs, and worsen clinical outcomes. Implementing robust internationalization (i18n) and localization (l10n) enables the platform to support Spanish, French, Mandarin, Portuguese, and accessibility needs (RTL languages like Arabic), improving equity, adherence and market reach.

This feature delivers:

- Full UI and content translations for patient-, provider-, and caregiver-facing experiences
- Locale detection and routing (URL-based and accept-language fallback)
- Runtime translation loading with caching and offline fallbacks
- Right-to-left (RTL) layout support and locale-specific formatting (dates, numbers, phone numbers)
- Translation workflow (POEditor/Transifex + machine translation + human review)
- CI checks for missing/unused keys and automated pseudo-localization

Business impact:

- Reduce churn in non-English users by 30%
- Increase acquisition in target Spanish-speaking markets by 2–4x
- Reduce support calls for basic flows by 22%

---

## Problem scenarios

1. "My mother speaks only Spanish and could not complete the consent form; she gave up mid‑flow." — Enrollment lost.
2. "Our clinic in São Paulo can't onboard patients because the instructions and reimbursement forms are English-only." — Market expansion blocked.
3. "Translations were inconsistent: one screen says ‘appointment’, another says ‘visit’, confusing patients and caregivers." — Trust and usability degraded.
4. "Message templates (appointment reminders, PA requests) include PHI; translations must remain HIPAA-compliant." — Privacy and compliance risk.
5. "RTL languages break layout and accessibility (icons misplaced, truncated text)." — Accessibility and inclusion failure.

---

## Scope & success criteria (contract)

- Inputs: app UI text, CMS content, emails, SMS templates, PDF templates, admin UI, UX copy
- Outputs: localized UI (en, es, fr, zh, pt) with proper locale routing; RTL styling support; automated CI checks for i18n key coverage and pseudo-localization; translation memory with machine suggestions and human review
- Error modes: missing keys should fall back to English and log warnings; translations with PHI must remain encrypted and only handled by approved translators bound by BAA where required
- Success: 95% key coverage for the five target locales; <1% runtime missing key errors in production logs; user satisfaction for localized flows >4.5/5 in pilot clinics

Edge cases considered: empty/missing translations; legacy string concatenation; date/time formatting across time zones; text expansion (Spanish/Portuguese longer than English); languages with complex pluralization rules; right‑to‑left layout; voice‑to‑text and TTS integration for low-literacy users.

---

## Technical design

### 1) Overall approach

- Use a single source-of-truth for strings: namespace keys in code (e.g., `auth.login.title`) not raw English text.
- Frontend: i18next (React/Next.js friendly) with lazy-loaded namespaces and CDN caching for JSON translation bundles.
- Backend: Store canonical templates and server-side translations for emails/SMS/PDF generation. Use a translations table to store custom content editable in admin console.
- Translation workflow: integrate POEditor or Transifex for translators, with TM (translation memory) and MT (machine translation) to speed up human post-edit.
- CI: eslint plugin for i18n key usage, tests to ensure no missing keys in compiled pages, and pseudo-localization runs in staging to detect layout issues.

### 2) Frontend implementation (React / Next.js example)

- Use Next.js i18n routing (locale subpaths): `/en/patient/records`, `/es/patient/records`.
- Dynamic import of translation namespaces using `next-i18next` or `i18next` with backend plugin.
- Fallback language: `en`.
- Pseudo-code:

```ts
// next-i18next.config.js
module.exports = {
  i18n: {
    locales: ['en', 'es', 'fr', 'zh', 'pt'],
    defaultLocale: 'en',
    localeDetection: true
  },
  react: { useSuspense: false }
};

// Example React component
import { useTranslation } from 'next-i18next';

export default function ConsentForm() {
  const { t } = useTranslation('consent');
  return (
    <div>
      <h1>{t('title')}</h1>
      <p>{t('instructions.line1')}</p>
      <button aria-label={t('accept')}>{t('accept')}</button>
    </div>
  );
}
```

- Translation JSON (namespace: `consent`):

```json
{
  "title": "Consent to Genetic Testing",
  "instructions": {
    "line1": "We will collect a blood sample...",
    "line2": "This will be used for..."
  },
  "accept": "I consent"
}
```

- For server-rendered pages, ensure `getStaticProps` / `getServerSideProps` call `serverSideTranslations(locale, ['consent','common'])`.

### 3) Localization of emails/SMS/PDFs

- Emails and SMS use server-side templates keyed by locale. Example `templates/email/appointment_reminder/{locale}.mjml` or handlebars templates.
- When a user sets preferred language, use that locale for all outbound comms. If no preference, use Accept-Language then fallback to English.
- PDFs: use HTML templates with localized strings, ensure fonts support character sets (CJK fonts for Chinese; Noto Sans family preferred). Embed fonts in PDF generation to avoid missing glyphs.

### 4) Locale detection & routing

Order of locale determination:

1. User explicit setting (profile.locale)
2. URL locale (e.g., `/es`)
3. Cookie (last chosen locale)
4. `Accept-Language` header
5. Fallback to `en`

Persist user's explicit choice to profile, used for emails and SMS.

### 5) Pluralization, interpolation, and ICU

- Use ICU message format (formatjs or i18next with ICU) to handle plural rules and complex interpolation (dates, gender, units).
- Example ICU string:

```
"notifications": "You have {count, plural, one {# new message} other {# new messages}}"
```

- Use `formatjs` in React for date/time/number formatting with user's locale and timezone.

### 6) RTL support

- CSS strategy: use logical properties (margin-inline-start/end), or maintain separate CSS generated via `postcss-rtl` for RTL transforms.
- Ensure icons mirror correctly, input alignment, and text truncation.
- At runtime add `dir="rtl"` and swap `lang` attribute.

### 7) Accessibility and low‑literacy modes

- Provide simplified language variant (A2/B1 reading level) for consent forms and critical instructions.
- Implement TTS (text-to-speech) support via browser APIs or server-side audio generation for low-literacy users; localized audio files stored per-locale.

### 8) Handling PHI in translation

- Mark templates that contain PHI (e.g., test results) and avoid sending raw PHI to external MT engines unless the MT provider signs a BAA. Prefer in‑house/human translators for PHI-containing strings.
- For templated messages that include PHI placeholders (e.g., `{patient_name}`, `{a1_level}`), translate the static text but never send full PHI content to third-party MT without proper safeguards.

---

## Code examples & helpers

### Translation helper (TypeScript)

```ts
export function translateWithFallback(
  key: string,
  locale: string,
  defaultLocale = 'en'
) {
  try {
    const t = i18next.getFixedT(locale);
    const result = t(key);
    if (result === key) {
      // missing key, fallback to default
      return i18next.getFixedT(defaultLocale)(key);
    }
    return result;
  } catch (err) {
    console.warn('i18n error', err, key, locale);
    return key; // last-resort
  }
}
```

### Pseudo-localization script (CI check)

- Run a pseudo-localization step during staging builds that replaces characters with wider equivalents and inserts brackets to check UI overflow and string concatenation bugs.
- Example: `I consent` -> `[!!! Î ĩ ç ô ń ś ē ñ ţ !!!]`.

### Unit test for missing keys

- A test run enumerates all `i18n` keys from source and checks existence across all target locales; fail CI on >1% missing keys.

---

## Database schema changes

```sql
-- Table for editable admin-managed translations (overrides)
CREATE TABLE translations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  locale VARCHAR(10) NOT NULL, -- 'en', 'es', 'fr', 'zh', 'pt'
  namespace VARCHAR(100) NOT NULL, -- 'consent', 'common', 'emails'
  key VARCHAR(300) NOT NULL, -- 'consent.title'
  value TEXT NOT NULL,
  source VARCHAR(50) DEFAULT 'poeditor', -- 'poeditor','mt','human','override'
  locked BOOLEAN DEFAULT false, -- prevent auto-updates
  created_by UUID, -- admin user
  updated_by UUID,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (locale, namespace, key)
);

CREATE INDEX idx_translations_locale_ns ON translations(locale, namespace);

-- Searchable localized content (for i18n-aware search)
CREATE TABLE localized_search_index (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  resource_type VARCHAR(50),
  resource_id UUID,
  locale VARCHAR(10),
  text TEXT,
  tsv tsvector,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_localized_search_tsv ON localized_search_index USING GIN(tsv);
```

Notes:

- Prefer storing canonical English resources in files for frontend bundling and use DB translations as admin overrides and CMS content.
- For large-scale content (educational articles), store translations in CMS (headless) with locale tagging and caching CDN.

---

## Translation workflow & CI

- Extraction: use `i18next-scanner` to extract keys to `.pot/.json` files.
- Push to POEditor/Transifex via API; translators work in web UI.
- MT pass: get machine suggestions (Google Translate or DeepL with BAA if PHI required) then human post-edit.
- Pull translations back into repo or store in translations DB via sync job.
- CI checks:
  - Missing keys threshold (fail build if >1% missing)
  - Pseudo-localization run to catch layout breakage
  - Font coverage tests for candidate locales (CJK, RTL)

---

## UI/UX considerations

- Avoid string concatenation; prefer composition via ICU templates.
- Reserve space for text expansion (20–35% extra width for some languages).
- Use `aria-lang` and `lang` attributes appropriately.
- Use `lang` on server-rendered HTML for proper screen reader voice selection.
- Maintain a glossary of clinical terms and preferred translations for accuracy (e.g., "augmentation therapy" → standardized localized term).

---

## Success metrics

- Coverage: 95% of UI keys translated into target locales within pilot launch
- Runtime missing-key errors: <1% across sessions
- User satisfaction for localized flows: >4.5/5 in pilot
- Support ticket decrease for translated flows: -22%
- Market adoption lift in Spanish-speaking regions: +2–4x new signups in pilot clinics

---

## Budget estimate

### Development (3-4 months)

- Frontend engineer (i18n wiring, RTL, CI): $140K/year × 0.33 = $46,200
- Backend engineer (translations DB, templates, email/PDF locales): $140K/year × 0.33 = $46,200
- Localization engineer / PM (integration with POEditor, glossaries, QA): $120K/year × 0.5 = $60,000
- UX writer (0.25 FTE): $110K/year × 0.25 = $27,500

Total development: ~$180,000

### Annual operations

- Translation vendor (POEditor/Transifex + TM/MT credits): $18,000/year
- Human translation hours for updates & content: $40,000/year (variable)
- Font licensing (CJK, RTL): $6,000/year
- CI infrastructure for pseudo-localization and tests: $4,000/year

Total operations: ~$68,000/year

### GRAND TOTAL (First Year)

~$248,000

Ongoing (Year 2+): ~$68,000/year (plus translation labor variable)

---

## Risks & mitigations

1. Risk: Poor translations leading to clinical misunderstandings.
   - Mitigation: Clinical glossary, medical review by bilingual clinicians, restrict MT on PHI templates.

2. Risk: Layout breakage in RTL/CJK.
   - Mitigation: Pseudo-localization in CI, manual RTL QA passes, responsive UI design.

3. Risk: Exposing PHI to third-party MT providers.
   - Mitigation: Only use MT when translators have BAA or use internal human translators for PHI-containing templates; mask PHI placeholders before sending to MT.

4. Risk: High ongoing translation costs for frequently changing UI.
   - Mitigation: Minimize copy changes, separate static content (docs) from dynamic UI strings, reuse TM and prioritize critical flows.

5. Risk: Missing keys at runtime.
   - Mitigation: Strict CI checks, logging and alerting for missing keys, auto-fallback to English, and quick patch process.

---

## Rollout plan

1. Phase 0: Preparation (2 weeks) — extract keys, set up i18next scaffolding, create glossary.
2. Phase 1: Core UI (6-8 weeks) — localize registration, login, consent flow, basic dashboard (en + es).
3. Phase 2: Communications (2-4 weeks) — localize emails, SMS, PDF templates.
4. Phase 3: Pilot (4 weeks) — deploy to select clinics (Spanish + Portuguese) and collect metrics.
5. Phase 4: Expand (ongoing) — add more locales, continuous translation sync.

---

**Document owner**: Head of Product, Localization PM
**Last updated**: November 7, 2025
**Status**: Draft — awaiting review and localization team input
