# Feature #23: Global Expansion & Multi-Country Support

**Category**: Platform Enhancement - Internationalization
**Priority**: Phase 3 (Year 2+ - Strategic Growth)
**Status**: Not Started
**Estimated Effort**: 6-8 months
**Team Required**: 1 i18n engineer, 1 backend developer, 1 legal/compliance specialist, 1 frontend developer, 0.5 FTE regional content manager

---

## Executive Summary

AATD is a **global disease** affecting 3-4 million people worldwide:

- **Europe**: 250,000+ diagnosed (UK, Germany, Spain, Nordic countries have high rates)
- **North America**: 100,000+ diagnosed in US/Canada
- **Asia**: Largely undiagnosed (different allele frequencies, limited awareness)
- **Latin America**: Growing awareness, particularly in Brazil/Argentina
- **Australia/NZ**: Active AATD registries, strong patient advocacy

Fair Underwriting currently operates **US-only**, leaving 70% of the global AATD market untapped. International expansion is essential for:

1. **Market opportunity**: $150M+ addressable market outside US
2. **Research diversity**: Genetic variants differ by region (need global datasets)
3. **Competitive positioning**: European competitors (e.g., Genomics England) expanding
4. **Mission fulfillment**: Fair underwriting for AATD patients worldwide

**Current barriers to international expansion:**

- ❌ UI/content only in English
- ❌ US-centric date/number/currency formats
- ❌ No multi-currency payment processing
- ❌ No international lab partnerships (outside US)
- ❌ HIPAA compliance only (not GDPR, PIPEDA, etc.)
- ❌ No regional regulatory approvals (CE marking, TGA, etc.)
- ❌ US timezone-only customer support
- ❌ No localized genetic counseling (Spanish, Mandarin, etc.)

**Global Expansion Strategy:**

- **Phase 1 (Year 2)**: English-speaking markets (UK, Canada, Australia) - Low regulatory barriers, shared language
- **Phase 2 (Year 3)**: Western Europe (Germany, Spain, France) - Strong AATD awareness, mature healthcare systems
- **Phase 3 (Year 4+)**: Asia/LatAm (Brazil, Japan) - High growth potential, requires significant localization

---

## Problem Scenarios

### Scenario 1: UK Patient Can't Access Platform

> **Situation**: Sarah in London has AATD (diagnosed via NHS). She wants to use Fair Underwriting to track her health data and connect with research studies. She finds the website but can't proceed.
>
> **Current Barriers**:
>
> - Prices in USD only (doesn't know GBP cost)
> - Payment requires US billing address
> - Phone verification needs +1 US phone number
> - Genetic counseling slots show EST timezone (confusing for GMT)
> - Privacy policy references HIPAA but not UK GDPR/Data Protection Act
> - Test kit shipping unavailable to UK addresses
>
> **Impact**: ❌ Sarah gives up. Fair Underwriting loses potential customer + research participant.

**Solution**: Multi-currency support (GBP), international address validation, timezone localization, UK-specific privacy policy, partnership with UK lab (TDL/Synlab), GDPR compliance certification.

### Scenario 2: Spanish Speaker Misunderstands Results

> **Situation**: Carlos in Barcelona receives genetic test results. English is his second language. The result says "Heterozygous Pi\*MZ" but he reads the risk interpretation incorrectly, thinking he has severe disease when he's just a carrier.
>
> **Current System**: All content in English only. "Request translation" option leads to Google Translate (medical terminology translated incorrectly).
>
> **Impact**: Carlos panics, books unnecessary pulmonologist appointment (€200), experiences anxiety for 3 weeks until Spanish-speaking genetic counselor clarifies. 1-star review citing "confusing results."

**Solution**: Professional medical translation in Spanish/Catalan, localized educational content explaining Pi\*MZ in Spanish terms patients understand, native Spanish-speaking genetic counselors, cultural adaptation (not just literal translation).

### Scenario 3: Brazilian Lab Partnership Fails

> **Situation**: Fair Underwriting partners with Brazilian lab to process AATD tests locally (faster than shipping to US). Lab uses different reference ranges for AAT levels (mg/dL vs µmol/L). Results import to platform with wrong units, flagging normal results as abnormal.
>
> **Current System**: Hard-coded US lab reference ranges, no unit conversion, assumes CLIA-certified labs only (Brazil uses different accreditation).
>
> **Impact**: 50 Brazilian patients receive incorrect risk assessments. Platform suspended by Brazilian health authority (ANVISA) pending investigation. $500K in refunds + legal fees.

**Solution**: Configurable reference ranges per country/lab, automatic unit conversion, support for international lab accreditations (ISO 15189, not just CLIA), regulatory compliance checks pre-launch.

### Scenario 4: GDPR Violation in Germany

> **Situation**: German patient requests data deletion (GDPR "Right to Erasure"). Platform deletes account but retains genetic data in research database "for scientific purposes" without proper legal basis.
>
> **Current System**: HIPAA-compliant deletion (de-identify after 6 years) but doesn't meet GDPR's stricter requirements (delete within 30 days unless exemption applies).
>
> **Impact**: German data protection authority (BfDI) fines Fair Underwriting €2M. Required to appoint EU Data Protection Officer, undergo costly audit.

**Solution**: GDPR-compliant data deletion workflow, separate consent for research vs. clinical use (GDPR Article 9), EU representative appointment, data processing agreements (DPAs) with EU labs, data residency (store EU patient data in EU servers).

### Scenario 5: Timezone Chaos for Australian Customers

> **Situation**: Australian patient books genetic counseling appointment. Website shows "Available slots: 10am, 2pm, 5pm" (US Eastern Time). She books "10am" thinking it's 10am Sydney time. Actual call is 1am Sydney time. She misses it, charged no-show fee.
>
> **Current System**: All times displayed in US ET. No timezone detection or conversion.
>
> **Impact**: 40% no-show rate for international appointments. Customer complaints about "confusing scheduling." Lost revenue from missed appointments.

**Solution**: Detect user timezone automatically (IP geolocation + browser timezone), display all times in user's local timezone, send calendar invites with correct timezone (IANA format), 24/7 customer support (or regional support hours).

---

## Technical Specifications

### 1. Internationalization (i18n) Framework

```typescript
interface LanguageConfiguration {
  languageCode: string; // ISO 639-1 (e.g., 'en', 'es', 'de')
  countryCode?: string; // ISO 3166-1 alpha-2 (e.g., 'US', 'GB', 'ES')
  locale: string; // BCP 47 (e.g., 'en-US', 'es-ES', 'de-DE')

  // Display names
  name: string; // Native name (e.g., 'Español', 'Deutsch')
  englishName: string; // English name (e.g., 'Spanish', 'German')

  // Text direction
  direction: 'ltr' | 'rtl'; // Left-to-right or right-to-left (for Arabic/Hebrew)

  // Formatting preferences
  formats: {
    date: string; // e.g., 'MM/DD/YYYY' (US) vs 'DD/MM/YYYY' (UK)
    time: string; // e.g., '12h' (US) vs '24h' (Europe)
    number: {
      decimalSeparator: string; // '.' (US) vs ',' (Europe)
      thousandsSeparator: string; // ',' (US) vs '.' (Europe)
    };
    currency: {
      code: string; // ISO 4217 (e.g., 'USD', 'EUR', 'GBP')
      symbol: string; // '$', '€', '£'
      position: 'before' | 'after'; // '$100' vs '100€'
    };
  };

  // Translation status
  translationCompleteness: number; // 0-100%
  lastUpdated: Date;

  // Regional settings
  timezone: string; // IANA timezone (e.g., 'Europe/London')
  measurementSystem: 'metric' | 'imperial'; // For height/weight

  // Availability
  enabled: boolean;
  betaRelease: boolean; // Available to limited users for testing
}

// Supported languages at launch
const supportedLanguages: LanguageConfiguration[] = [
  {
    languageCode: 'en',
    countryCode: 'US',
    locale: 'en-US',
    name: 'English',
    englishName: 'English',
    direction: 'ltr',
    formats: {
      date: 'MM/DD/YYYY',
      time: '12h',
      number: { decimalSeparator: '.', thousandsSeparator: ',' },
      currency: { code: 'USD', symbol: '$', position: 'before' }
    },
    translationCompleteness: 100,
    lastUpdated: new Date('2025-01-01'),
    timezone: 'America/New_York',
    measurementSystem: 'imperial',
    enabled: true,
    betaRelease: false
  },
  {
    languageCode: 'en',
    countryCode: 'GB',
    locale: 'en-GB',
    name: 'English (UK)',
    englishName: 'English (UK)',
    direction: 'ltr',
    formats: {
      date: 'DD/MM/YYYY',
      time: '24h',
      number: { decimalSeparator: '.', thousandsSeparator: ',' },
      currency: { code: 'GBP', symbol: '£', position: 'before' }
    },
    translationCompleteness: 95, // Some US-specific terms need localization
    lastUpdated: new Date('2025-06-01'),
    timezone: 'Europe/London',
    measurementSystem: 'metric',
    enabled: true,
    betaRelease: false
  },
  {
    languageCode: 'es',
    countryCode: 'ES',
    locale: 'es-ES',
    name: 'Español',
    englishName: 'Spanish',
    direction: 'ltr',
    formats: {
      date: 'DD/MM/YYYY',
      time: '24h',
      number: { decimalSeparator: ',', thousandsSeparator: '.' },
      currency: { code: 'EUR', symbol: '€', position: 'after' }
    },
    translationCompleteness: 85, // In progress
    lastUpdated: new Date('2025-09-01'),
    timezone: 'Europe/Madrid',
    measurementSystem: 'metric',
    enabled: true,
    betaRelease: true
  },
  {
    languageCode: 'de',
    countryCode: 'DE',
    locale: 'de-DE',
    name: 'Deutsch',
    englishName: 'German',
    direction: 'ltr',
    formats: {
      date: 'DD.MM.YYYY',
      time: '24h',
      number: { decimalSeparator: ',', thousandsSeparator: '.' },
      currency: { code: 'EUR', symbol: '€', position: 'after' }
    },
    translationCompleteness: 80,
    lastUpdated: new Date('2025-10-01'),
    timezone: 'Europe/Berlin',
    measurementSystem: 'metric',
    enabled: true,
    betaRelease: true
  }
  // Add: French, Portuguese, Mandarin, Japanese, etc.
];

class InternationalizationService {
  async getUserLanguage(userId: string): Promise<LanguageConfiguration> {
    // 1. Check user preference (explicitly set)
    const userPreference = await this.db.queryOne(
      `
      SELECT language_preference
      FROM users
      WHERE user_id = $1
    `,
      [userId]
    );

    if (userPreference?.language_preference) {
      return this.getLanguageConfig(userPreference.language_preference);
    }

    // 2. Detect from browser Accept-Language header
    const browserLanguage = this.detectBrowserLanguage();
    if (browserLanguage) {
      return this.getLanguageConfig(browserLanguage);
    }

    // 3. Detect from IP geolocation
    const ipCountry = await this.geolocateIP();
    const countryLanguage = this.getDefaultLanguageForCountry(ipCountry);
    if (countryLanguage) {
      return this.getLanguageConfig(countryLanguage);
    }

    // 4. Fallback to English (US)
    return this.getLanguageConfig('en-US');
  }

  async translateText(
    key: string,
    locale: string,
    variables?: any
  ): Promise<string> {
    // Load translation from database or JSON files
    const translation = await this.db.queryOne(
      `
      SELECT translation_text
      FROM translations
      WHERE translation_key = $1 AND locale = $2
    `,
      [key, locale]
    );

    if (!translation) {
      // Fallback to English
      console.warn(`Missing translation: ${key} for locale ${locale}`);
      const englishTranslation = await this.db.queryOne(
        `
        SELECT translation_text
        FROM translations
        WHERE translation_key = $1 AND locale = 'en-US'
      `,
        [key]
      );

      return englishTranslation?.translation_text || key;
    }

    // Replace variables (e.g., "Hello, {{name}}")
    let text = translation.translation_text;
    if (variables) {
      for (const [varName, varValue] of Object.entries(variables)) {
        text = text.replace(
          new RegExp(`{{${varName}}}`, 'g'),
          String(varValue)
        );
      }
    }

    return text;
  }

  formatNumber(value: number, locale: string): string {
    const config = this.getLanguageConfig(locale);

    return new Intl.NumberFormat(locale, {
      minimumFractionDigits: 0,
      maximumFractionDigits: 2
    }).format(value);
  }

  formatCurrency(amount: number, locale: string): string {
    const config = this.getLanguageConfig(locale);

    return new Intl.NumberFormat(locale, {
      style: 'currency',
      currency: config.formats.currency.code
    }).format(amount);
  }

  formatDate(
    date: Date,
    locale: string,
    formatType: 'short' | 'medium' | 'long' = 'medium'
  ): string {
    return new Intl.DateTimeFormat(locale, {
      dateStyle: formatType
    }).format(date);
  }

  formatTime(date: Date, locale: string): string {
    const config = this.getLanguageConfig(locale);

    return new Intl.DateTimeFormat(locale, {
      hour: 'numeric',
      minute: '2-digit',
      hour12: config.formats.time === '12h'
    }).format(date);
  }

  convertToUserTimezone(utcDate: Date, userTimezone: string): Date {
    // Convert UTC timestamp to user's local timezone
    const formatter = new Intl.DateTimeFormat('en-US', {
      timeZone: userTimezone,
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false
    });

    const parts = formatter.formatToParts(utcDate);
    const values: any = {};
    for (const part of parts) {
      if (part.type !== 'literal') {
        values[part.type] = part.value;
      }
    }

    return new Date(
      `${values.year}-${values.month}-${values.day}T${values.hour}:${values.minute}:${values.second}`
    );
  }
}
```

### 2. Multi-Currency Payment Processing

```typescript
interface CurrencyConfiguration {
  code: string; // ISO 4217
  symbol: string;
  name: string;

  // Exchange rate (relative to USD)
  exchangeRate: number; // Updated daily
  lastUpdated: Date;

  // Pricing strategy
  roundingRule: 'nearest_5' | 'nearest_10' | 'nearest_99' | 'none';
  // e.g., €99.99 looks better than €101.37

  // Payment processing
  stripeEnabled: boolean;
  paypalEnabled: boolean;
  localPaymentMethods: string[]; // e.g., ['giropay', 'sepa_debit'] for Germany

  // Regulations
  vatRate?: number; // VAT/GST percentage (e.g., 20% for UK)
  taxInclusive: boolean; // Display prices with VAT included (Europe) or exclusive (US)
}

class MultiCurrencyService {
  async convertPrice(
    amountUSD: number,
    targetCurrency: string
  ): Promise<{ amount: number; currency: string; formatted: string }> {
    const currencyConfig = await this.getCurrencyConfig(targetCurrency);

    // Apply exchange rate
    let convertedAmount = amountUSD * currencyConfig.exchangeRate;

    // Apply rounding rule
    convertedAmount = this.applyRoundingRule(
      convertedAmount,
      currencyConfig.roundingRule
    );

    // Add VAT if applicable
    if (currencyConfig.vatRate && currencyConfig.taxInclusive) {
      convertedAmount *= 1 + currencyConfig.vatRate / 100;
    }

    // Format
    const formatted = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: targetCurrency
    }).format(convertedAmount);

    return {
      amount: convertedAmount,
      currency: targetCurrency,
      formatted
    };
  }

  applyRoundingRule(amount: number, rule: string): number {
    switch (rule) {
      case 'nearest_99':
        // Round to X.99 (psychological pricing)
        return Math.ceil(amount) - 0.01;

      case 'nearest_5':
        // Round to nearest 5 (e.g., 103 → 105)
        return Math.round(amount / 5) * 5;

      case 'nearest_10':
        // Round to nearest 10
        return Math.round(amount / 10) * 10;

      default:
        return Math.round(amount * 100) / 100; // Round to 2 decimals
    }
  }

  async processInternationalPayment(
    userId: string,
    amountUSD: number,
    currency: string,
    paymentMethodId: string
  ): Promise<PaymentResult> {
    const currencyConfig = await this.getCurrencyConfig(currency);
    const convertedPrice = await this.convertPrice(amountUSD, currency);

    // Use Stripe for international payments
    const paymentIntent = await stripe.paymentIntents.create({
      amount: Math.round(convertedPrice.amount * 100), // Convert to cents
      currency: currency.toLowerCase(),
      payment_method: paymentMethodId,
      customer: await this.getStripeCustomerId(userId),
      metadata: {
        userId,
        originalAmountUSD: amountUSD,
        exchangeRate: currencyConfig.exchangeRate
      }
    });

    return {
      paymentId: paymentIntent.id,
      status: paymentIntent.status,
      amount: convertedPrice.amount,
      currency,
      receiptUrl: paymentIntent.charges.data[0]?.receipt_url
    };
  }

  async updateExchangeRates(): Promise<void> {
    // Fetch latest rates from exchange rate API (e.g., Open Exchange Rates)
    const response = await axios.get(
      'https://openexchangerates.org/api/latest.json',
      {
        params: {
          app_id: process.env.EXCHANGE_RATE_API_KEY,
          base: 'USD'
        }
      }
    );

    const rates = response.data.rates;

    // Update database
    for (const [currencyCode, rate] of Object.entries(rates)) {
      await this.db.query(
        `
        UPDATE currency_configurations
        SET exchange_rate = $1, last_updated = NOW()
        WHERE code = $2
      `,
        [rate, currencyCode]
      );
    }

    console.log(
      `Updated exchange rates for ${Object.keys(rates).length} currencies`
    );
  }
}
```

### 3. International Lab Network

```typescript
interface InternationalLabPartner {
  labId: string;
  labName: string;

  // Location
  country: string; // ISO 3166-1 alpha-2
  city: string;
  address: string;

  // Capabilities
  testTypesOffered: string[]; // ['aatd_genotype', 'aat_quantitative', 'liver_panel']

  // Accreditation
  accreditations: {
    type: string; // 'CLIA', 'CAP', 'ISO15189', 'UKAS', 'DAkkS'
    number: string;
    expiresAt: Date;
  }[];

  // Reference ranges (localized)
  referenceRanges: {
    test: string;
    unit: string; // 'mg/dL', 'µmol/L', 'g/L'
    normalRange: { min: number; max: number };
    population: string; // 'European', 'Asian', 'Global'
  }[];

  // Logistics
  specimenTypes: string[]; // ['blood_spot', 'serum', 'saliva']
  turnaroundTimeDays: number;
  shippingPartners: string[];

  // Integration
  apiEndpoint?: string;
  apiKey?: string;
  hl7Interface?: boolean;
  manualResultEntry: boolean;

  // Regulatory
  regulatory_approvals: {
    authority: string; // 'FDA', 'MHRA', 'EMA', 'TGA'
    approval_number: string;
    approval_date: Date;
  }[];

  // Pricing
  testPricing: {
    test: string;
    price: number;
    currency: string;
  }[];

  // Status
  active: boolean;
  onboarded_at: Date;
}

class InternationalLabService {
  async findLabForCountry(
    countryCode: string,
    testType: string
  ): Promise<InternationalLabPartner> {
    // Find lab in same country (fastest shipping)
    let lab = await this.db.queryOne(
      `
      SELECT *
      FROM international_lab_partners
      WHERE country = $1
        AND $2 = ANY(test_types_offered)
        AND active = true
      ORDER BY turnaround_time_days ASC
      LIMIT 1
    `,
      [countryCode, testType]
    );

    if (lab) {
      return lab;
    }

    // Fallback: Find lab in same region (e.g., EU labs can serve multiple EU countries)
    const region = this.getRegionForCountry(countryCode);
    lab = await this.db.queryOne(
      `
      SELECT *
      FROM international_lab_partners
      WHERE country = ANY($1)
        AND $2 = ANY(test_types_offered)
        AND active = true
      ORDER BY turnaround_time_days ASC
      LIMIT 1
    `,
      [region.countries, testType]
    );

    if (lab) {
      return lab;
    }

    // Last resort: US lab (international shipping)
    return await this.db.queryOne(
      `
      SELECT *
      FROM international_lab_partners
      WHERE country = 'US'
        AND $1 = ANY(test_types_offered)
        AND active = true
      ORDER BY turnaround_time_days ASC
      LIMIT 1
    `,
      [testType]
    );
  }

  async convertLabResult(
    result: any,
    sourceUnit: string,
    targetUnit: string
  ): Promise<number> {
    // Unit conversion for AAT levels
    const conversions: { [key: string]: { [key: string]: number } } = {
      'mg/dL': {
        'µmol/L': 18.2, // 1 mg/dL = 18.2 µmol/L
        'g/L': 0.01
      },
      'µmol/L': {
        'mg/dL': 0.055,
        'g/L': 0.00055
      },
      'g/L': {
        'mg/dL': 100,
        'µmol/L': 1820
      }
    };

    if (sourceUnit === targetUnit) {
      return result.value;
    }

    const conversionFactor = conversions[sourceUnit]?.[targetUnit];
    if (!conversionFactor) {
      throw new Error(
        `No conversion available from ${sourceUnit} to ${targetUnit}`
      );
    }

    return result.value * conversionFactor;
  }

  async standardizeLabResult(
    labId: string,
    testType: string,
    rawResult: any
  ): Promise<StandardizedResult> {
    const lab = await this.db.findById('international_lab_partners', labId);
    const refRange = lab.referenceRanges.find((r) => r.test === testType);

    // Convert to standard unit (mg/dL for AAT)
    const standardValue = await this.convertLabResult(
      rawResult,
      refRange.unit,
      'mg/dL'
    );

    // Determine clinical interpretation
    const interpretation = this.interpretResult(standardValue, testType);

    return {
      test: testType,
      value: standardValue,
      unit: 'mg/dL',
      originalValue: rawResult.value,
      originalUnit: refRange.unit,
      labId,
      interpretation,
      collectedAt: rawResult.collectedAt,
      reportedAt: new Date()
    };
  }
}
```

### 4. GDPR & International Compliance

```typescript
interface GDPRComplianceConfig {
  region: 'EU' | 'UK' | 'US' | 'CA' | 'AU' | 'BR';

  // Data residency
  dataResidencyRequired: boolean; // Must store data in-region
  approvedDatacenters: string[]; // AWS regions (e.g., 'eu-west-1', 'eu-central-1')

  // Consent requirements
  consentModel: 'opt-in' | 'opt-out';
  explicitConsentRequired: boolean; // For sensitive data (genetic info)
  granularConsent: boolean; // Separate consent for each purpose

  // Data subject rights
  rightToAccess: boolean; // User can request data copy
  rightToRectification: boolean; // User can correct errors
  rightToErasure: boolean; // "Right to be forgotten"
  rightToPortability: boolean; // Export data in machine-readable format
  rightToObject: boolean; // Object to automated decision-making

  // Retention limits
  maxRetentionMonths: number; // How long data can be stored
  anonymizationRequired: boolean; // After retention period

  // Legal basis for processing
  legalBases: (
    | 'consent'
    | 'contract'
    | 'legal_obligation'
    | 'vital_interests'
    | 'legitimate_interests'
  )[];

  // Data transfer restrictions
  transferMechanisms: (
    | 'standard_contractual_clauses'
    | 'adequacy_decision'
    | 'binding_corporate_rules'
  )[];

  // Breach notification
  breachNotificationHours: number; // 72 hours for GDPR
  supervisoryAuthority: string; // ICO (UK), CNIL (FR), etc.
}

class GDPRComplianceService {
  async handleDataAccessRequest(userId: string): Promise<DataPackage> {
    // User requests copy of all their data (GDPR Article 15)

    // Collect all data
    const userData = await this.db.query(
      `
      SELECT * FROM users WHERE user_id = $1
    `,
      [userId]
    );

    const geneticData = await this.db.query(
      `
      SELECT * FROM genetic_test_results WHERE user_id = $1
    `,
      [userId]
    );

    const healthData = await this.db.query(
      `
      SELECT * FROM health_records WHERE user_id = $1
    `,
      [userId]
    );

    const activityData = await this.db.query(
      `
      SELECT * FROM audit_logs WHERE user_id = $1
    `,
      [userId]
    );

    // Package as JSON
    const dataPackage = {
      requestDate: new Date(),
      personalData: userData[0],
      geneticData,
      healthData,
      activityLogs: activityData,
      consentHistory: await this.getConsentHistory(userId),
      thirdPartySharing: await this.getThirdPartySharing(userId)
    };

    // Generate downloadable file
    const filename = `fair-underwriting-data-${userId}-${Date.now()}.json`;
    await this.storageService.upload(
      filename,
      JSON.stringify(dataPackage, null, 2)
    );

    // Send email with download link
    await this.emailService.send({
      to: userData[0].email,
      subject: 'Your Personal Data Request',
      template: 'gdpr-data-access',
      data: {
        downloadUrl: await this.storageService.getSignedUrl(filename, 7), // 7-day expiry
        expiresIn: '7 days'
      }
    });

    // Log request (compliance audit trail)
    await this.auditLog({
      userId,
      action: 'gdpr_data_access_request',
      completedAt: new Date()
    });

    return dataPackage;
  }

  async handleDataErasureRequest(userId: string): Promise<void> {
    // User requests account deletion (GDPR Article 17 "Right to be Forgotten")

    // Check if erasure is permitted
    const canErase = await this.checkErasureEligibility(userId);
    if (!canErase.eligible) {
      throw new Error(`Cannot erase data: ${canErase.reason}`);
      // Reasons: legal obligation to retain (e.g., financial records for tax),
      // ongoing litigation, public health interest
    }

    // Anonymize rather than delete (research exemption - GDPR Recital 33)
    await this.anonymizeResearchData(userId);

    // Delete identifiable data
    await this.db.transaction(async (trx) => {
      // Personal info
      await trx.query('DELETE FROM users WHERE user_id = $1', [userId]);
      await trx.query('DELETE FROM user_profiles WHERE user_id = $1', [userId]);

      // Health data
      await trx.query('DELETE FROM health_records WHERE user_id = $1', [
        userId
      ]);
      await trx.query('DELETE FROM appointments WHERE user_id = $1', [userId]);

      // Genetic data (keep if consented to research, but de-identify)
      const researchConsent = await this.hasResearchConsent(userId);
      if (!researchConsent) {
        await trx.query('DELETE FROM genetic_test_results WHERE user_id = $1', [
          userId
        ]);
      } else {
        // Replace user_id with anonymous research participant ID
        await trx.query(
          `
          UPDATE genetic_test_results
          SET user_id = NULL, research_participant_id = gen_random_uuid()
          WHERE user_id = $1
        `,
          [userId]
        );
      }

      // Financial data (retain for 7 years - legal requirement)
      await trx.query(
        `
        UPDATE payment_transactions
        SET user_email = 'deleted@example.com', user_name = 'Deleted User'
        WHERE user_id = $1
      `,
        [userId]
      );

      // Audit log (keep for compliance, but anonymize)
      await trx.query(
        `
        UPDATE audit_logs
        SET user_id = NULL, user_email = NULL
        WHERE user_id = $1
      `,
        [userId]
      );
    });

    // Notify data processors (labs, insurance partners)
    await this.notifyDataProcessors(userId, 'erasure_request');

    // Send confirmation email (before deleting email address!)
    await this.emailService.send({
      to: await this.getUserEmail(userId),
      subject: 'Account Deletion Confirmed',
      template: 'account-deleted'
    });

    // Log deletion (compliance audit trail)
    await this.auditLog({
      userId,
      action: 'gdpr_erasure_completed',
      completedAt: new Date()
    });
  }

  async checkDataResidency(userId: string): Promise<string> {
    // Determine which AWS region to use based on user location
    const user = await this.db.findById('users', userId);
    const country = user.country;

    const residencyRules: { [key: string]: string } = {
      // EU/EEA countries → EU data centers only
      DE: 'eu-central-1', // Germany → Frankfurt
      FR: 'eu-west-3', // France → Paris
      UK: 'eu-west-2', // UK → London
      ES: 'eu-west-1', // Spain → Ireland (no Spain region)
      IT: 'eu-south-1', // Italy → Milan

      // Other regions
      US: 'us-east-1',
      CA: 'ca-central-1',
      AU: 'ap-southeast-2', // Sydney
      BR: 'sa-east-1', // São Paulo
      JP: 'ap-northeast-1' // Tokyo
    };

    return residencyRules[country] || 'us-east-1'; // Default to US
  }
}
```

---

## Launch Strategy by Region

### Phase 1: English-Speaking Markets (6-9 months)

**Target Countries**: UK, Canada, Australia, New Zealand

**Rationale**:

- Low localization effort (already in English)
- Familiar regulatory environment (similar to US)
- Strong AATD awareness & patient advocacy groups
- Established lab partnerships possible (TDL, LifeLabs, Sonic Healthcare)

**Launch Steps**:

1. **Regulatory** (3 months):
   - UK: MHRA registration, UKCA marking
   - Canada: Health Canada license (Class II medical device)
   - Australia: TGA listing (Class IIb medical device)
2. **Lab Partnerships** (2 months):
   - UK: TDL (The Doctors Laboratory)
   - Canada: LifeLabs or Dynacare
   - Australia: Sonic Healthcare
3. **Compliance** (2 months):
   - GDPR compliance (UK)
   - PIPEDA compliance (Canada)
   - Privacy Act compliance (Australia)
4. **Localization** (2 months):
   - British English spelling (colour, centre, authorise)
   - NHS terminology integration
   - Local insurance systems (NHS, Medicare, PBS)
5. **Go-to-Market** (1 month):
   - Partner with UK Alpha-1 Foundation
   - Launch in London, expand to Manchester/Edinburgh

**Projected Revenue**: $8M Year 1 (2,000 customers × $4K average)

### Phase 2: Western Europe (12-15 months)

**Target Countries**: Germany, Spain, France, Netherlands, Nordic countries

**Rationale**:

- High AATD prevalence (Pi\*Z allele common in Northern Europe)
- Strong healthcare systems with genetic testing coverage
- Active research communities (German AATD Registry, Spanish AATD Registry)

**Launch Steps**:

1. **Professional Translation** (4 months):
   - German: 15,000 words of medical content
   - Spanish: 15,000 words
   - French: 15,000 words
   - Quality assurance by native-speaking genetic counselors
2. **Regulatory** (6 months):
   - CE marking (applies to all EU + EEA)
   - Notified Body assessment (TÜV SÜD or BSI)
   - MDR compliance (Medical Device Regulation)
3. **Local Genetic Counselors** (3 months):
   - Hire German-speaking counselors
   - Hire Spanish-speaking counselors
   - Hire French-speaking counselors
4. **Lab Partnerships**:
   - Germany: MVZ Labor Dr. Limbach
   - Spain: Labco Quality Diagnostics
   - France: Cerba HealthCare
5. **Currency/Payment**:
   - EUR pricing
   - SEPA direct debit
   - German Giropay, Dutch iDEAL

**Projected Revenue**: $25M Year 2 (6,000 customers × $4.2K average)

### Phase 3: Asia & Latin America (18-24 months)

**Target Countries**: Brazil, Japan, Singapore, South Korea

**Challenges**:

- Low AATD awareness (underdiagnosed)
- Different allele frequencies (need region-specific reference data)
- Language/cultural barriers (need native counselors)
- Complex regulatory (ANVISA in Brazil, PMDA in Japan)

**Projected Revenue**: $15M Year 3 (3,000 customers × $5K average)

---

## Budget & Success Metrics

### Development Costs (6-8 months)

- **i18n Engineer** (framework, translation integration): $150K/year × 0.67 = $100,500
- **Backend Developer** (multi-currency, regional compliance): $140K/year × 0.67 = $93,800
- **Frontend Developer** (UI localization, RTL support): $140K/year × 0.50 = $70,000
- **Legal/Compliance Specialist** (GDPR, international regulations): $130K/year × 0.50 = $65,000
- **Professional Translation Services**: $0.15/word × 30,000 words × 5 languages = $22,500

**Total Development**: ~$351,800

### Annual Operations (per region)

- **Regional Genetic Counselors** (2 FTE per language): $100K × 2 = $200,000
- **Customer Support** (24/7 multilingual): $150,000/year
- **Lab Partnerships** (contracts, integration): $80,000/year
- **Regulatory Maintenance** (annual renewals, audits): $50,000/year
- **Translation Updates** (new features): $30,000/year
- **Currency Exchange Fees**: $20,000/year

**Total Operations per Region**: ~$530,000/year

### Success Metrics

**Adoption Metrics**

- International customers: 10,000+ within 3 years
- Revenue from non-US: 40% of total by Year 3
- Customer satisfaction (non-US): 4.5/5 stars

**Localization Quality**

- Translation accuracy: 98%+ (medical terminology)
- UI rendering: Zero layout issues in all languages
- Cultural appropriateness: Zero cultural sensitivity complaints

**Regulatory Compliance**

- GDPR violations: Zero
- Regulatory approvals: 100% success rate (UK, EU, CA, AU)
- Data residency compliance: 100%

**Operational Efficiency**

- International lab turnaround: <10 days (same as US)
- Payment processing success: 98%+ (all currencies)
- Customer support response time: <2 hours (all regions)

---

**Document Status:** Complete
**Next:** Feature #24 - Platform Infrastructure & DevOps Automation
