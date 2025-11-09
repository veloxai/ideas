# Feature #17: Accessibility Enhancements (WCAG 2.1 AAA Compliance)

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Must Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 accessibility specialist, 1 frontend developer, 0.5 FTE UX designer, 0.25 FTE content strategist

---

## Executive Summary

AATD disproportionately affects individuals 50+ years old, many with vision impairments, motor difficulties, or cognitive challenges. Current platform lacks comprehensive accessibility features, excluding 15-20% of potential users and exposing Fair Underwriting to ADA litigation risk. Implementing WCAG 2.1 AAA compliance ensures legal compliance, improves usability for all users, and demonstrates commitment to health equity.

**Key Value Propositions**:

- **WCAG 2.1 AAA Compliance**: Meet highest accessibility standard (beyond legal minimum)
- **Screen Reader Optimization**: Perfect NVDA, JAWS, VoiceOver compatibility
- **Keyboard Navigation**: Complete keyboard-only workflows (zero mouse required)
- **Vision Support**: High contrast modes, text scaling to 200%, screen magnifier compatibility
- **Motor Support**: Large click targets, voice control compatibility, reduced motion options
- **Cognitive Support**: Simple language mode, consistent navigation, focus indicators
- **Assistive Technology**: Compatibility with Dragon NaturallySpeaking, Switch Control, eye-tracking

**Business Impact**:

- **Legal Compliance**: Avoid ADA lawsuits ($75K average settlement + legal fees)
- **Market Expansion**: Serve 26% of US adults with disabilities (65M people)
- **Elderly Market**: 50+ age group represents 65% of AATD patients
- **Insurance Requirements**: Medicare Advantage plans increasingly require WCAG AA minimum
- **Reputation**: Position as inclusive healthcare technology leader

---

## Problem Statement

### Current Gaps

**Scenario 1: Blind Patient Using Screen Reader**

> "I'm blind and use JAWS screen reader. When I try to view my lab results, the table has no headers. JAWS just reads numbers with no context. I can't tell which number is my AAT level versus my liver enzymes. I had to call my daughter to read the screen."

**No semantic HTML, ARIA labels missing** ❌

**Scenario 2: Elderly Patient with Low Vision**

> "I'm 72 with macular degeneration. Even with my computer set to 150% zoom, your text is too small. When I zoom to 200%, the layout breaks—buttons overlap text. I can't read my appointment details."

**No responsive text scaling, poor contrast** ❌

**Scenario 3: Patient with Parkinson's (Motor Impairment)**

> "I have Parkinson's and my hands shake. The dropdown menus are too small—I keep clicking the wrong option. The touch targets need to be bigger. I also can't use a mouse well, but keyboard navigation doesn't work for many actions."

**Small click targets, incomplete keyboard support** ❌

**Scenario 4: Patient with Cognitive Impairment**

> "My 68-year-old father has early dementia from COPD. Your interface is confusing—too many options, inconsistent navigation. He clicks around randomly. We need simpler layouts and clearer instructions."

**Cognitive overload, inconsistent patterns** ❌

**Scenario 5: Deaf Patient Missing Telemedicine Audio**

> "I'm deaf. During telemedicine appointments, there are no live captions. I miss critical information from my pulmonologist. I need real-time captions or I can't use video visits."

**No closed captions, no visual alerts** ❌

---

## Feature Specifications

### 1. WCAG 2.1 AAA Compliance Framework

**Compliance Checklist**:

```typescript
interface WCAGCompliance {
  // Level A (Must Have)
  levelA: {
    textAlternatives: boolean; // All images have alt text
    keyboardAccessible: boolean; // All functionality via keyboard
    timing: boolean; // Adjustable time limits
    seizures: boolean; // No flashing content >3/sec
    navigable: boolean; // Skip links, page titles, focus order
    inputAssistance: boolean; // Error identification, labels
  };

  // Level AA (Should Have)
  levelAA: {
    colorContrast: boolean; // 4.5:1 for text, 3:1 for large text
    resizeText: boolean; // 200% zoom without loss of content
    reflow: boolean; // No horizontal scrolling at 320px width
    nonTextContrast: boolean; // 3:1 for UI components
    textSpacing: boolean; // Support custom spacing
    focusVisible: boolean; // Keyboard focus indicator
    languageOfParts: boolean; // Language changes marked
  };

  // Level AAA (Best Practice)
  levelAAA: {
    enhancedContrast: boolean; // 7:1 for text, 4.5:1 for large text
    noTimeout: boolean; // No session timeouts for reading/completion
    contextualHelp: boolean; // Help available throughout
    errorPrevention: boolean; // Confirm destructive actions
    sectionHeadings: boolean; // Proper heading hierarchy
    pronunciation: boolean; // Abbreviations explained
    readingLevel: boolean; // Lower secondary education level (A2/B1)
    focusAppearance: boolean; // Enhanced focus indicators (4px minimum)
  };
}

class AccessibilityService {
  async auditPage(url: string): Promise<AccessibilityReport> {
    // Use axe-core for automated testing
    const results = await axe.run(url, {
      runOnly: ['wcag2a', 'wcag2aa', 'wcag2aaa', 'wcag21a', 'wcag21aa']
    });

    return {
      violations: results.violations.map((v) => ({
        id: v.id,
        impact: v.impact,
        description: v.description,
        nodes: v.nodes.length,
        wcagLevel: this.getWCAGLevel(v.tags),
        remediation: this.getRemediationSteps(v.id)
      })),
      passes: results.passes.length,
      incomplete: results.incomplete.length,
      score: this.calculateAccessibilityScore(results)
    };
  }

  calculateAccessibilityScore(results: any): number {
    const totalTests = results.passes.length + results.violations.length;
    if (totalTests === 0) return 100;

    // Weight by impact
    const impactWeights = { critical: 10, serious: 5, moderate: 2, minor: 1 };
    const violationScore = results.violations.reduce(
      (sum, v) => sum + impactWeights[v.impact] * v.nodes.length,
      0
    );

    const maxPossibleScore = totalTests * 10;
    return Math.max(0, 100 - (violationScore / maxPossibleScore) * 100);
  }
}
```

### 2. Screen Reader Optimization

**Semantic HTML & ARIA Labels**:

```typescript
// Lab Results Table (Screen Reader Accessible)
interface LabResult {
  testName: string;
  value: number;
  unit: string;
  referenceRange: string;
  status: 'normal' | 'abnormal' | 'critical';
  date: Date;
}

function AccessibleLabResultsTable({ results }: { results: LabResult[] }) {
  return (
    <table role="table" aria-label="Lab Results">
      <caption className="sr-only">
        Recent lab test results with values, reference ranges, and status
      </caption>

      <thead>
        <tr>
          <th scope="col" aria-sort="none">Test Name</th>
          <th scope="col" aria-sort="none">Result</th>
          <th scope="col" aria-sort="none">Reference Range</th>
          <th scope="col" aria-sort="none">Status</th>
          <th scope="col" aria-sort="none">Date</th>
        </tr>
      </thead>

      <tbody>
        {results.map((result, index) => (
          <tr key={index} aria-describedby={`status-${index}`}>
            <th scope="row">{result.testName}</th>
            <td>
              <span aria-label={`${result.value} ${result.unit}`}>
                {result.value} {result.unit}
              </span>
            </td>
            <td>{result.referenceRange}</td>
            <td>
              <span
                id={`status-${index}`}
                role="status"
                aria-live="polite"
                className={`status-${result.status}`}
                aria-label={
                  result.status === 'critical'
                    ? 'Critical: Immediate attention required'
                    : result.status === 'abnormal'
                    ? 'Abnormal: Outside reference range'
                    : 'Normal: Within reference range'
                }
              >
                {result.status === 'critical' && '⚠️ '}
                {result.status === 'abnormal' && '⚡ '}
                {result.status === 'normal' && '✓ '}
                {result.status}
              </span>
            </td>
            <td>
              <time dateTime={result.date.toISOString()}>
                {new Intl.DateTimeFormat('en-US', {
                  year: 'numeric',
                  month: 'short',
                  day: 'numeric'
                }).format(result.date)}
              </time>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

// Screen reader only class (CSS)
const srOnlyCSS = `
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
`;

// Live region for dynamic updates
function DynamicNotifications() {
  const [notifications, setNotifications] = useState<string[]>([]);

  return (
    <>
      {/* Polite: Don't interrupt screen reader */}
      <div
        role="status"
        aria-live="polite"
        aria-atomic="true"
        className="sr-only"
      >
        {notifications[notifications.length - 1]}
      </div>

      {/* Assertive: For critical alerts */}
      <div
        role="alert"
        aria-live="assertive"
        aria-atomic="true"
        className="sr-only"
      >
        {/* Critical notifications only */}
      </div>
    </>
  );
}
```

### 3. Keyboard Navigation

**Complete Keyboard Workflows**:

```typescript
// Keyboard navigation manager
class KeyboardNavigationService {
  private focusableSelectors = [
    'a[href]',
    'button:not([disabled])',
    'input:not([disabled])',
    'select:not([disabled])',
    'textarea:not([disabled])',
    '[tabindex]:not([tabindex="-1"])',
    'details',
    'summary'
  ].join(',');

  // Focus trap for modals
  trapFocus(containerElement: HTMLElement) {
    const focusableElements = containerElement.querySelectorAll<HTMLElement>(
      this.focusableSelectors
    );

    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];

    containerElement.addEventListener('keydown', (e) => {
      if (e.key !== 'Tab') return;

      if (e.shiftKey) {
        // Shift + Tab
        if (document.activeElement === firstElement) {
          lastElement.focus();
          e.preventDefault();
        }
      } else {
        // Tab
        if (document.activeElement === lastElement) {
          firstElement.focus();
          e.preventDefault();
        }
      }
    });

    // Focus first element
    firstElement?.focus();
  }

  // Skip to main content
  addSkipLinks() {
    const skipLink = document.createElement('a');
    skipLink.href = '#main-content';
    skipLink.className = 'skip-link';
    skipLink.textContent = 'Skip to main content';
    skipLink.addEventListener('click', (e) => {
      e.preventDefault();
      const main = document.getElementById('main-content');
      main?.setAttribute('tabindex', '-1');
      main?.focus();
    });

    document.body.insertBefore(skipLink, document.body.firstChild);
  }

  // Keyboard shortcuts
  registerGlobalShortcuts() {
    document.addEventListener('keydown', (e) => {
      // Only if not in input/textarea
      if (
        document.activeElement?.tagName === 'INPUT' ||
        document.activeElement?.tagName === 'TEXTAREA'
      ) {
        return;
      }

      // Alt+H: Help
      if (e.altKey && e.key === 'h') {
        this.openHelp();
        e.preventDefault();
      }

      // Alt+M: Main menu
      if (e.altKey && e.key === 'm') {
        this.focusMainMenu();
        e.preventDefault();
      }

      // Alt+S: Search
      if (e.altKey && e.key === 's') {
        this.focusSearch();
        e.preventDefault();
      }

      // Escape: Close modal/dropdown
      if (e.key === 'Escape') {
        this.closeTopMost();
      }
    });
  }
}

// Accessible dropdown menu component
function AccessibleDropdown({ label, items }: DropdownProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [focusedIndex, setFocusedIndex] = useState(-1);
  const buttonRef = useRef<HTMLButtonElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);

  const handleKeyDown = (e: KeyboardEvent) => {
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        if (!isOpen) {
          setIsOpen(true);
          setFocusedIndex(0);
        } else {
          setFocusedIndex((prev) => (prev + 1) % items.length);
        }
        break;

      case 'ArrowUp':
        e.preventDefault();
        if (isOpen) {
          setFocusedIndex((prev) => (prev - 1 + items.length) % items.length);
        }
        break;

      case 'Enter':
      case ' ':
        e.preventDefault();
        if (isOpen && focusedIndex >= 0) {
          items[focusedIndex].action();
          setIsOpen(false);
        } else {
          setIsOpen(!isOpen);
        }
        break;

      case 'Escape':
        e.preventDefault();
        setIsOpen(false);
        buttonRef.current?.focus();
        break;

      case 'Home':
        e.preventDefault();
        setFocusedIndex(0);
        break;

      case 'End':
        e.preventDefault();
        setFocusedIndex(items.length - 1);
        break;
    }
  };

  return (
    <div className="dropdown" onKeyDown={handleKeyDown}>
      <button
        ref={buttonRef}
        aria-haspopup="true"
        aria-expanded={isOpen}
        onClick={() => setIsOpen(!isOpen)}
      >
        {label}
      </button>

      {isOpen && (
        <div
          ref={menuRef}
          role="menu"
          aria-label={label}
        >
          {items.map((item, index) => (
            <button
              key={index}
              role="menuitem"
              tabIndex={focusedIndex === index ? 0 : -1}
              onFocus={() => setFocusedIndex(index)}
              onClick={() => {
                item.action();
                setIsOpen(false);
              }}
            >
              {item.label}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
```

### 4. Vision Support (High Contrast, Text Scaling)

**CSS Custom Properties for Theming**:

```css
/* Base theme */
:root {
  --color-text: #1a1a1a;
  --color-background: #ffffff;
  --color-primary: #0066cc;
  --color-error: #cc0000;
  --color-success: #008800;
  --color-border: #cccccc;

  /* Contrast ratios - AA minimum */
  --contrast-text: 4.5; /* Text: 4.5:1 */
  --contrast-large-text: 3; /* Large text: 3:1 */
  --contrast-ui: 3; /* UI components: 3:1 */
}

/* High contrast mode (AAA) */
[data-theme='high-contrast'] {
  --color-text: #000000;
  --color-background: #ffffff;
  --color-primary: #0000cc;
  --color-error: #cc0000;
  --color-success: #006600;
  --color-border: #000000;

  --contrast-text: 7; /* AAA: 7:1 */
  --contrast-large-text: 4.5; /* AAA: 4.5:1 */
}

/* Dark mode with high contrast */
[data-theme='dark-high-contrast'] {
  --color-text: #ffffff;
  --color-background: #000000;
  --color-primary: #6699ff;
  --color-error: #ff6666;
  --color-success: #66ff66;
  --color-border: #ffffff;
}

/* Support text scaling to 200% */
html {
  font-size: 16px; /* Base */
}

@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}

/* Ensure reflow at 320px (WCAG 2.1 AA) */
@media (max-width: 320px) {
  .container {
    max-width: 100%;
    padding: 1rem;
  }

  /* Stack elements vertically */
  .flex-container {
    flex-direction: column;
  }
}

/* Focus indicators (WCAG 2.1 AAA) */
:focus {
  outline: 4px solid var(--color-primary);
  outline-offset: 2px;
}

:focus:not(:focus-visible) {
  outline: none;
}

:focus-visible {
  outline: 4px solid var(--color-primary);
  outline-offset: 2px;
}

/* Windows High Contrast Mode */
@media (prefers-contrast: high) {
  button {
    border: 2px solid currentColor;
  }
}

/* Forced colors mode (Windows) */
@media (forced-colors: active) {
  button {
    border: 2px solid ButtonBorder;
  }

  .status-critical {
    forced-color-adjust: none;
    color: CanvasText;
    background: Mark;
  }
}
```

**Text Scaling Support**:

```typescript
function AccessibilitySettings() {
  const [textScale, setTextScale] = useState(100); // 100% = 16px base
  const [contrastMode, setContrastMode] = useState<'normal' | 'high' | 'dark-high'>('normal');

  useEffect(() => {
    // Apply text scaling
    document.documentElement.style.fontSize = `${16 * (textScale / 100)}px`;

    // Apply contrast theme
    document.documentElement.setAttribute('data-theme', contrastMode);
  }, [textScale, contrastMode]);

  return (
    <section aria-labelledby="accessibility-heading">
      <h2 id="accessibility-heading">Accessibility Settings</h2>

      {/* Text Size */}
      <div>
        <label htmlFor="text-scale">
          Text Size: {textScale}%
        </label>
        <input
          id="text-scale"
          type="range"
          min="100"
          max="200"
          step="10"
          value={textScale}
          onChange={(e) => setTextScale(Number(e.target.value))}
          aria-valuemin={100}
          aria-valuemax={200}
          aria-valuenow={textScale}
          aria-valuetext={`${textScale} percent`}
        />
        <div className="scale-preview">
          <button onClick={() => setTextScale(100)}>Reset (100%)</button>
          <button onClick={() => setTextScale(150)}>Large (150%)</button>
          <button onClick={() => setTextScale(200)}>Extra Large (200%)</button>
        </div>
      </div>

      {/* Contrast Mode */}
      <fieldset>
        <legend>Contrast Mode</legend>
        <div role="radiogroup" aria-labelledby="contrast-label">
          <label>
            <input
              type="radio"
              name="contrast"
              value="normal"
              checked={contrastMode === 'normal'}
              onChange={() => setContrastMode('normal')}
            />
            Normal (AA)
          </label>
          <label>
            <input
              type="radio"
              name="contrast"
              value="high"
              checked={contrastMode === 'high'}
              onChange={() => setContrastMode('high')}
            />
            High Contrast (AAA)
          </label>
          <label>
            <input
              type="radio"
              name="contrast"
              value="dark-high"
              checked={contrastMode === 'dark-high'}
              onChange={() => setContrastMode('dark-high')}
            />
            Dark High Contrast
          </label>
        </div>
      </fieldset>
    </section>
  );
}
```

### 5. Motor Support (Large Touch Targets, Voice Control)

**Touch Target Sizing (WCAG 2.1 AAA)**:

```css
/* Minimum 44×44px touch targets (WCAG 2.1 AAA) */
button,
a,
input[type='checkbox'],
input[type='radio'],
select {
  min-width: 44px;
  min-height: 44px;
  padding: 0.75rem 1.5rem;
}

/* Exception for inline links in text */
p a,
li a {
  /* Inline links can be smaller but should have adequate spacing */
  display: inline-block;
  padding: 0.25rem 0.5rem;
  margin: -0.25rem -0.5rem;
}

/* Larger targets for primary actions */
.btn-primary,
.btn-submit {
  min-width: 60px;
  min-height: 60px;
  font-size: 1.125rem;
}

/* Spacing between interactive elements */
button + button,
a + a {
  margin-left: 1rem;
}
```

**Voice Control Compatibility**:

```typescript
// Ensure all interactive elements have accessible names
function VoiceControlCompatible() {
  return (
    <div>
      {/* ✓ Voice Control: "Click Save" */}
      <button>Save</button>

      {/* ✓ Voice Control: "Click Close Button" */}
      <button aria-label="Close">✕</button>

      {/* ✓ Voice Control: "Click Profile Menu" */}
      <button aria-label="Profile Menu">
        <img src="/avatar.png" alt="" role="presentation" />
      </button>

      {/* ❌ Voice Control: Can't activate (no accessible name) */}
      {/* <div onClick={handleClick}><span>×</span></div> */}

      {/* ✓ Better: Use semantic button */}
      <button onClick={handleClick} aria-label="Close dialog">
        <span aria-hidden="true">×</span>
      </button>
    </div>
  );
}

// Dragon NaturallySpeaking commands
// Users can say:
// - "Click [button label]"
// - "Show links" (highlights all links with numbers)
// - "Press [link number]"
// - "Scroll down"
// - "Go to top"
```

### 6. Cognitive Support (Simple Language, Consistent UI)

**Simple Language Mode**:

```typescript
interface ContentVersion {
  standard: string;
  simple: string; // A2/B1 reading level
}

const contentLibrary: Record<string, ContentVersion> = {
  'consent.intro': {
    standard: 'Fair Underwriting will analyze your genetic material to determine your Alpha-1 Antitrypsin phenotype and quantify serum AAT concentration via nephelometry.',
    simple: 'We will test your blood to check for the Alpha-1 gene. This test shows if you have low levels of the Alpha-1 protein.'
  },
  'treatment.augmentation': {
    standard: 'Augmentation therapy involves intravenous infusions of pooled human plasma-derived AAT concentrate administered weekly to maintain target trough levels above 11 μM.',
    simple: 'Treatment means getting Alpha-1 protein through an IV once a week. This helps protect your lungs.'
  }
};

function SimpleLanguageToggle() {
  const [useSimple, setUseSimple] = useState(false);

  const t = (key: string) => {
    const content = contentLibrary[key];
    return useSimple ? content.simple : content.standard;
  };

  return (
    <div>
      <label>
        <input
          type="checkbox"
          checked={useSimple}
          onChange={(e) => setUseSimple(e.target.checked)}
        />
        Use simple language
      </label>

      <p>{t('consent.intro')}</p>
    </div>
  );
}
```

**Consistent Navigation & Breadcrumbs**:

```typescript
function ConsistentNavigation() {
  return (
    <>
      {/* Breadcrumbs for orientation */}
      <nav aria-label="Breadcrumb">
        <ol>
          <li><a href="/">Home</a></li>
          <li><a href="/health">Health Records</a></li>
          <li aria-current="page">Lab Results</li>
        </ol>
      </nav>

      {/* Consistent main navigation */}
      <nav aria-label="Main">
        <ul>
          <li><a href="/dashboard">Dashboard</a></li>
          <li><a href="/health">Health Records</a></li>
          <li><a href="/medications">Medications</a></li>
          <li><a href="/appointments">Appointments</a></li>
          <li><a href="/messages">Messages</a></li>
        </ul>
      </nav>

      {/* Contextual help */}
      <aside aria-labelledby="help-heading">
        <h2 id="help-heading">Need Help?</h2>
        <p>This page shows your recent lab test results.</p>
        <button>Watch Tutorial Video</button>
        <button>Chat with Support</button>
      </aside>
    </>
  );
}
```

### 7. Database Schema (User Preferences)

```sql
-- User accessibility preferences
CREATE TABLE user_accessibility_preferences (
  user_id UUID PRIMARY KEY,

  -- Visual
  text_scale INTEGER DEFAULT 100, -- 100-200%
  contrast_mode VARCHAR(20) DEFAULT 'normal', -- 'normal', 'high', 'dark-high'
  reduce_motion BOOLEAN DEFAULT false,

  -- Language
  simple_language BOOLEAN DEFAULT false,
  preferred_language VARCHAR(10) DEFAULT 'en',

  -- Audio/Video
  auto_play_videos BOOLEAN DEFAULT true,
  closed_captions BOOLEAN DEFAULT false,
  audio_descriptions BOOLEAN DEFAULT false,

  -- Cognitive
  show_help_tips BOOLEAN DEFAULT true,
  confirm_destructive_actions BOOLEAN DEFAULT true,

  -- Navigation
  keyboard_shortcuts BOOLEAN DEFAULT true,
  skip_animations BOOLEAN DEFAULT false,

  -- Assistive Technology
  screen_reader_mode BOOLEAN DEFAULT false,
  voice_control_mode BOOLEAN DEFAULT false,

  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### 8. Automated Testing

**Axe-core Integration (CI Pipeline)**:

```typescript
// tests/accessibility.test.ts
import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test.describe('Accessibility Tests', () => {
  test('Homepage should not have accessibility violations', async ({
    page
  }) => {
    await page.goto('/');

    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
      .analyze();

    expect(accessibilityScanResults.violations).toEqual([]);
  });

  test('Lab results page should be keyboard navigable', async ({ page }) => {
    await page.goto('/health/labs');

    // Tab through all interactive elements
    await page.keyboard.press('Tab');
    await expect(page.locator(':focus')).toHaveAttribute('aria-label');

    // Should be able to activate with Enter
    await page.keyboard.press('Enter');
    await expect(page).toHaveURL(/.*labs.*/);
  });

  test('Forms should have proper labels', async ({ page }) => {
    await page.goto('/register');

    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2a'])
      .analyze();

    const labelViolations = accessibilityScanResults.violations.filter(
      (v) => v.id === 'label'
    );

    expect(labelViolations).toHaveLength(0);
  });

  test('Color contrast should meet WCAG AAA', async ({ page }) => {
    await page.goto('/');

    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2aaa'])
      .analyze();

    const contrastViolations = accessibilityScanResults.violations.filter(
      (v) => v.id === 'color-contrast-enhanced'
    );

    expect(contrastViolations).toHaveLength(0);
  });
});
```

---

## Success Metrics

### Compliance

- **WCAG 2.1 AAA Score**: 95+ (axe-core automated tests)
- **Manual Testing**: 0 critical violations in quarterly audits
- **Screen Reader Testing**: 100% of critical workflows pass NVDA/JAWS tests
- **Keyboard Navigation**: 100% of features accessible without mouse

### User Adoption

- **Accessibility Settings Usage**: 18% of users customize settings
- **High Contrast Mode**: 12% adoption
- **Text Scaling**: 22% use 125%+ zoom
- **Simple Language**: 15% enable for complex content

### Business Impact

- **ADA Complaints**: 0 (vs. industry average 2-3/year for healthcare sites)
- **Elderly User Retention**: +15% (better UX for 65+ age group)
- **Support Tickets**: -18% (clearer UI reduces confusion)
- **Medicare Advantage Contracts**: Unlock $2M+ market (WCAG AA required)

---

## Budget Estimate

### Development (4-5 months)

- **Accessibility Specialist** (audit, remediation guidance): $150K/year × 0.42 years = $63,000
- **Frontend Developer** (implementation, testing): $140K/year × 0.42 years = $58,800
- **UX Designer** (0.5 FTE, high contrast themes, layouts): $130K/year × 0.5 = $65,000
- **Content Strategist** (0.25 FTE, simple language): $110K/year × 0.25 = $27,500

**Total Development**: ~$214,300

### Annual Operations

- **Quarterly Accessibility Audits**: $20,000/year
- **Screen Reader Testing Service** (UserWay, AudioEye): $8,000/year
- **Assistive Technology Licenses** (JAWS, Dragon): $3,000/year
- **User Testing** (participants with disabilities): $12,000/year

**Total Operations**: ~$43,000/year

### Annual Infrastructure

- **Accessibility Monitoring** (automated scanning): $6,000/year
- **Captioning Service** (Rev, 3Play): $8,000/year

**Total Infrastructure**: ~$14,000/year

### **GRAND TOTAL (First Year)**: ~$271,300

### **Ongoing (Year 2+)**: ~$57,000/year

**Value Created**:

- Avoided ADA lawsuits: $75K average settlement + $50K legal fees = $125K/year risk mitigation
- Medicare Advantage contracts: $2M+ addressable market
- Elderly retention: 200 patients × $600/year = $120K/year

**Net Benefit**: +$195K/year risk avoidance + market expansion

---

## Risks & Mitigations

### Risk 1: Automated Testing Misses Issues

**Impact**: Ship accessibility bugs despite passing CI
**Mitigation**: Combine automated (axe-core) + manual testing + user testing with people who have disabilities, quarterly audits by accessibility specialist

### Risk 2: Content Team Creates Inaccessible Content

**Impact**: CMS content violates WCAG (images without alt text, poor contrast)
**Mitigation**: CMS validation rules, content team training, accessibility checklist, pre-publish automated scans

### Risk 3: Third-Party Components Non-Compliant

**Impact**: Vendor widgets (chat, scheduling) fail accessibility tests
**Mitigation**: Audit vendors before integration, require VPAT (Voluntary Product Accessibility Template), fallback to accessible alternatives

### Risk 4: Accessibility Regressions in Updates

**Impact**: New features break existing accessibility
**Mitigation**: Mandatory accessibility tests in CI, block PRs with violations, quarterly regression testing

### Risk 5: WCAG AAA Too Restrictive for Some Features

**Impact**: Can't implement desired UX while meeting AAA
**Mitigation**: Meet AA minimum (legal requirement), target AAA where feasible, document exceptions with rationale, provide alternative pathways

---

**Document Owner**: Head of Product, Accessibility Lead
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval

**Related Standards**:

- WCAG 2.1: https://www.w3.org/WAI/WCAG21/quickref/
- Section 508: https://www.section508.gov/
- ADA Title III: https://www.ada.gov/
