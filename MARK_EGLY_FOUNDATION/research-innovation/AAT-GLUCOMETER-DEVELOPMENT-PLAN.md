# AAT 'Glucometer' Device Development Plan

**Document Version**: 1.0
**Last Updated**: November 7, 2025
**Owner**: Chief Innovation Officer
**Purpose**: Development plan for point-of-care AAT testing device

---

## 📋 Table of Contents

1. [Device Vision](#device-vision)
2. [Clinical Need & Market Opportunity](#clinical-need--market-opportunity)
3. [Technical Requirements](#technical-requirements)
4. [Development Roadmap](#development-roadmap)
5. [Regulatory Pathway](#regulatory-pathway)
6. [Partnership Strategy](#partnership-strategy)
7. [Business Model](#business-model)
8. [Financial Projections](#financial-projections)
9. [Success Metrics](#success-metrics)

---

## Device Vision

### The Problem

**Current AATD Testing is Cumbersome**:

- Requires doctor visit → blood draw → lab processing → wait 1-2 weeks for results
- Cost: $100-$400
- Low testing rates: Only ~10% of COPD patients ever tested
- Diagnostic delay: Average 7-8 years from symptoms to diagnosis

**What if AATD testing was as easy as checking blood sugar?**

---

### The Solution: AAT "Glucometer"

**Vision**: Point-of-care device for rapid AAT level testing

**Like a blood glucose meter, but for AAT**:

- Fingerstick blood sample
- Insert test strip into handheld device
- Results in 5-15 minutes
- Display AAT level (mg/dL)
- Built-in interpretation (normal, borderline, low)

**Use Cases**:

1. **Doctor's offices**: Test during routine visit, immediate results
2. **Pulmonologist offices**: Test all COPD patients at diagnosis
3. **Health fairs & screening events**: Community screening
4. **Pharmacies**: Walk-in testing (like blood pressure kiosks)
5. **Home use**: Self-monitoring (less critical initially)

---

### Device Name & Branding

**Working Names**:

- **Alpha1Check**
- **AAT-Tester**
- **QuickAlpha**
- **AlphaScreen**

**Tagline**: "Know Your Alpha-1 Status in Minutes"

---

## Clinical Need & Market Opportunity

### Why This Device is Needed

**Current Testing Gaps**:

- Most COPD patients never tested (90% missed)
- Physicians forget to order test
- Patients don't follow through (hassle of lab visit)
- Results delay (1-2 weeks) → lost to follow-up

**Point-of-Care Testing Solves This**:

- ✅ Immediate results → immediate diagnosis
- ✅ Test during routine visit (no extra appointment)
- ✅ Removes barriers (convenience)
- ✅ Physician sees result → discusses next steps same visit

**Impact**: Could **double or triple AATD diagnosis rates**

---

### Target Market

**Primary Market: Doctor's Offices**

**Target Users**:

- Pulmonologists (5,000 in US)
- Primary care physicians (200,000 in US)
- Specialty clinics (COPD, asthma, allergy)

**Testing Volume**:

- COPD patients: 16 million in US, ~1 million newly diagnosed/year
- If 50% tested → 500,000 tests/year (vs. ~20,000 currently)

---

**Secondary Market: Screening Programs**

**Target Settings**:

- Health fairs and community events
- Occupational health (firefighters, military, miners)
- Pharmacies (CVS, Walgreens minute clinics)
- Direct-to-consumer (home testing kits)

**Testing Volume**:

- Occupational: 2 million high-risk workers × 10% tested = 200,000/year
- Community screening: 50,000/year
- Pharmacies: 100,000/year
- Home use: 50,000/year

**Total Addressable Market: 1 million tests/year (US alone)**

---

### Market Size & Revenue Potential

**Test Pricing**:

- Device cost: $200-$500 (one-time purchase by clinic)
- Test strip cost: $30-$50 per test (similar to glucose test strips)

**Revenue Model** (focus on test strips, not device):

- Similar to printer/ink model: Device cheap, strips recurring revenue

**Revenue Potential**:

- US market: 1M tests/year × $40/test = **$40M/year**
- International market: 2M tests/year × $40/test = **$80M/year**
- **Total: $120M/year at maturity**

**Foundation Revenue**:

- Royalty (10-15% of sales): $12-18M/year
- Alternative: Sell device company for $200-500M (8-10 years)

---

### Competitive Landscape

**Current AATD Testing**:

- Lab-based AAT level test (Quest, LabCorp): $100-$400, 1-2 weeks
- Genotype test (DNA analysis): $200-$500, 1-3 weeks
- No point-of-care tests exist yet

**Similar POC Devices (Other Conditions)**:

- Glucose meters (diabetes): Ubiquitous, ~$20-50
- INR meters (warfarin monitoring): $600-1,500
- Hemoglobin A1c meters (diabetes): $40/test
- Cholesterol meters: $100-$200

**Why No AAT Meter Yet?**:

- Small market (AATD perceived as rare)
- Technical challenges (AAT measurement more complex than glucose)
- Lack of awareness/demand

**Our Advantage**:

- Foundation drives demand (education, CME, AATD Aware certification)
- Larger market than perceived (1M+ tests/year with screening)
- Technical feasibility (immunoassay technology exists)

---

## Technical Requirements

### Performance Specifications

**Accuracy**:

- Correlation with lab test: r >0.95
- Sensitivity: Detect low AAT (<80 mg/dL) with >95% accuracy
- Specificity: Correctly identify normal AAT (>150 mg/dL) >95%

**Precision**:

- CV (coefficient of variation): <10%
- Repeatability: Same sample, same result 95% of time

**Measurement Range**:

- 20-300 mg/dL (covers ZZ to normal)
- May need dilution for very high levels (rare)

**Time to Result**: 5-15 minutes (target: <10 minutes)

**Sample Type**: Fingerstick blood (50-100 µL, similar to glucose test)

---

### Device Features

**Hardware**:

- Handheld device (size of glucose meter)
- Rechargeable battery or disposable batteries
- LCD display (shows AAT level, interpretation)
- Test strip slot (single-use strips)
- Bluetooth connectivity (optional, syncs to app/EMR)

**Software/Display**:

- AAT level (mg/dL)
- Color-coded interpretation:
  - Green: Normal (>150 mg/dL) - "No AATD detected"
  - Yellow: Borderline (100-150 mg/dL) - "Possible carrier, confirm with genotype"
  - Red: Low (<100 mg/dL) - "AATD suspected, confirm with genotype"
- Test history (stores last 100 results)
- QR code for patient report

**Test Strips**:

- Single-use, disposable
- Immunoassay-based (lateral flow or electrochemical)
- Shelf life: 12-18 months
- Requires refrigeration: No (room temperature stable)

---

### Technology Platform

**Options**:

**1. Lateral Flow Immunoassay (LFA)** (Preferred):

- Similar to COVID rapid test or pregnancy test
- AAT binds to antibody → color change → quantified optically
- Pros: Simple, cheap, room temperature stable
- Cons: Lower accuracy than lab (but acceptable for screening)

**2. Electrochemical Immunoassay**:

- AAT binds to antibody → electrical signal → quantified
- Pros: More accurate, similar to glucose meters
- Cons: More complex, higher cost

**3. Microfluidic Chip**:

- Blood sample flows through microchannels, AAT detected via fluorescence or electrochemistry
- Pros: Highly accurate, small sample volume
- Cons: Expensive, requires specialized manufacturing

**Recommendation**: Start with LFA (cheaper, faster development), then upgrade to electrochemical (better performance)

---

### Regulatory Classification

**FDA Classification**: Class II Medical Device

- Requires 510(k) premarket notification (not full PMA)
- Predicate devices: Other immunoassay POC tests (e.g., INR meters, A1c meters)
- Timeline: 6-12 months review

**CLIA Waiver** (Goal):

- CLIA = Clinical Laboratory Improvement Amendments
- Waived tests can be performed in doctor's office without lab certification
- Requires: Simple, accurate, low risk of error
- If CLIA-waived → broader adoption (any doctor can use)

---

## Development Roadmap

### Phase 1: Feasibility & Proof of Concept (Year 1, 2026)

**Q1-Q2: Technology Selection**:

- Evaluate LFA vs. electrochemical platforms
- Partner with diagnostics company or university lab
- Develop prototype test strips
- Bench testing (lab samples)

**Q3-Q4: Proof of Concept**:

- Test 100 patient samples (known AAT levels)
- Compare POC device to lab test (gold standard)
- Assess accuracy, precision, time to result
- **Go/No-Go Decision**: Proceed only if r >0.90 vs. lab test

**Funding**: $200K (pilot grant or industry partner)

**Deliverable**: Prototype device + feasibility data

---

### Phase 2: Device Optimization & Validation (Year 2-3, 2027-2028)

**2027: Optimization**:

- Improve accuracy (target r >0.95)
- Optimize sample volume, time to result
- User interface design (display, instructions)
- Manufacturing scale-up (test strips)

**2028: Clinical Validation**:

- **Study Design**: Multi-site clinical trial
- **N**: 500 patients (COPD clinics, pulmonology offices)
- **Comparison**: POC device vs. lab test (gold standard)
- **Endpoints**: Accuracy, precision, user satisfaction, time savings
- **Duration**: 6 months

**Funding**: $1-2M (foundation grant + industry partner)

**Deliverable**: Clinical validation data for FDA submission

---

### Phase 3: FDA Submission & Approval (Year 4, 2029)

**Q1-Q2: 510(k) Preparation**:

- Compile validation data
- Write 510(k) submission
- Identify predicate device
- Pre-submission meeting with FDA (optional)

**Q3: FDA Submission**:

- Submit 510(k) to FDA
- FDA review: 90 days (standard) or 180 days (if questions)

**Q4: FDA Clearance**:

- Address FDA questions (if any)
- Receive 510(k) clearance
- **Device can now be marketed in US**

**CLIA Waiver Application** (Parallel):

- Apply for CLIA waiver (makes device easier to use)
- Requires additional studies (non-lab personnel can use correctly)
- FDA/CDC review: 6-12 months

**Funding**: $500K (regulatory consulting, FDA fees)

**Deliverable**: FDA 510(k) clearance

---

### Phase 4: Manufacturing & Launch (Year 5, 2030)

**Q1-Q2: Manufacturing Scale-Up**:

- Partner with contract manufacturer (devices + test strips)
- Produce 10,000 devices, 100,000 test strips
- Quality control and batch testing

**Q3: Commercial Launch**:

- Sales team (direct to pulmonologists, then PCPs)
- Distribution partnerships (medical supply companies)
- Marketing campaign (target doctors, not patients initially)
- Launch at medical conferences (ATS, CHEST)

**Q4: Early Adopters**:

- Place devices in 100-200 clinics (early adopters)
- Collect user feedback
- Reimbursement strategy (CPT code application)

**Funding**: $5-10M (manufacturing, launch)

**Deliverable**: Device on market, 10,000+ tests performed

---

### Phase 5: Market Expansion (Year 6-10, 2031-2035)

**2031-2032: Primary Care Expansion**:

- Expand to primary care physicians
- Pharmacy partnerships (CVS, Walgreens minute clinics)
- International markets (Europe, Asia)

**2033-2035: Direct-to-Consumer**:

- Home testing kits (patients can buy online)
- Employer wellness programs
- Screening campaigns (firefighters, military)

**Funding**: Funded by product sales (breakeven by Year 6)

**Deliverable**: 50,000+ tests/year, $2-5M annual revenue

---

### Phase 6: Next-Generation Device (Year 8+, 2033+)

**Enhancements**:

- Combined AAT level + genotype test (fingerstick → full diagnosis in 30 min)
- Smartphone integration (results sent to app, shared with doctor)
- AI interpretation (risk stratification, treatment recommendations)
- Expanded panel (AAT + other biomarkers for COPD)

**Potential Exit**: Sell device company to diagnostics company (Roche, Abbott, Quidel) for $200-500M

---

## Regulatory Pathway

### FDA 510(k) Process

**Step 1: Predicate Device Identification**:

- Find similar device already FDA-cleared (e.g., INR meter, A1c meter)
- Demonstrate our device is "substantially equivalent"

**Step 2: Clinical Validation Study**:

- Multi-site trial (N=500)
- Compare POC device to lab test (gold standard)
- Show accuracy, precision, user performance

**Step 3: 510(k) Submission**:

- Device description and specifications
- Validation data
- Labeling (instructions for use, warnings)
- Manufacturing and quality control

**Step 4: FDA Review**:

- FDA reviews submission: 90-180 days
- May request additional information
- Interactive review (FDA calls with questions)

**Step 5: Clearance**:

- If approved → 510(k) clearance letter
- Device can be marketed

**Timeline**: 12-18 months from validation study to clearance

---

### CLIA Waiver Application

**Why It Matters**:

- CLIA-waived devices can be used in doctor's offices without lab certification
- Easier for doctors to adopt (no extra paperwork)
- Expands market significantly

**Requirements**:

- Simple to perform (minimal training)
- Low risk of error
- Clear instructions
- Validation in non-lab personnel hands

**Process**:

- Apply to FDA after 510(k) clearance
- Submit additional studies (user performance)
- FDA/CDC review: 6-12 months

**Foundation will pursue CLIA waiver** (even if delays launch slightly)

---

### Reimbursement Strategy (CPT Code)

**Challenge**: Insurance needs to cover test for widespread adoption

**Solution**: Apply for CPT code (billing code)

- Submit to AMA CPT Editorial Panel
- Demonstrate clinical utility and cost-effectiveness
- If approved → Medicare/Medicaid will reimburse

**Expected Reimbursement**: $50-$100 per test (similar to other POC tests)

**Timeline**: 2-3 years after device launch

---

## Partnership Strategy

### Development Partners (Phase 1-3)

**Option 1: Diagnostics Company** (Preferred):

- **Candidates**: Roche, Abbott, Quidel, Siemens, Ortho Clinical Diagnostics
- **Model**: Co-development (foundation provides clinical expertise, company provides technology/manufacturing)
- **Pros**: Expertise, infrastructure, funding, regulatory experience
- **Cons**: Slower decision-making, foundation has less control

**Option 2: Academic/Research Lab**:

- **Candidates**: MIT, Stanford, UCSF (bioengineering/microfluidics labs)
- **Model**: Foundation funds research, university develops prototype
- **Pros**: Innovation, flexibility
- **Cons**: Slower, less commercial focus, need separate manufacturer

**Option 3: Device Startup**:

- **Model**: Foundation co-founds startup or provides seed funding
- **Pros**: Speed, entrepreneurial
- **Cons**: Higher risk, requires significant capital

**Recommendation**: Partner with diagnostics company (Roche or Abbott) for faster path to market

---

### Commercial Partners (Phase 4-5)

**Manufacturing**:

- Contract manufacturer (CMO) for devices and test strips
- Examples: Sanmina, Flex, Jabil (device assembly)

**Distribution**:

- Medical supply distributors: Henry Schein, McKesson, Cardinal Health
- Direct sales initially (pulmonologists), then distributors (scale to PCPs)

**Pharmacy Partners**:

- CVS Health, Walgreens, Walmart (minute clinics)
- Place devices in stores for walk-in testing

---

### Licensing Model

**Foundation's IP**:

- Device design and specifications (patent pending)
- Clinical validation data
- AATD awareness and education (drives demand)

**License Terms**:

- Exclusive license to manufacturing partner (10-year term)
- Foundation receives:
  - Upfront payment: $1-5M
  - Milestone payments: $5-10M (FDA clearance, sales targets)
  - Royalties: 10-15% of device/strip sales
  - Or: Foundation retains ownership, partner manufactures/distributes for fee

**Alternative**: Foundation owns device company, seeks venture capital funding, eventual exit (sale or IPO)

---

## Business Model

### Revenue Streams

**1. Device Sales**:

- Sell devices to clinics/doctors: $200-$500 each
- Low margin (or break-even) to drive test strip adoption

**2. Test Strip Sales** (PRIMARY REVENUE):

- Recurring revenue: $30-$50 per test
- High margin: 60-70%
- This is where profit comes from (printer/ink model)

**3. Data Services** (Future):

- Aggregate de-identified test data
- Sell insights to pharma, researchers
- Subscription model: $10K-$50K/year per customer

---

### Pricing Strategy

**Launch Pricing**:

- Device: $300 (competitive with other POC devices)
- Test strips: $40 per test (similar to A1c tests)

**Volume Discounts**:

- > 100 tests/year: $35/test
- > 500 tests/year: $30/test
- Encourages high-volume testing

**Reimbursement**:

- Patient pays: $40-$50 (if no insurance or high deductible)
- Insurance pays: $50-$100 (foundation advocates for CPT code + reimbursement)
- Doctor's office: Pays wholesale ($25-$30/test), bills insurance ($80-$100), keeps margin

---

### Cost Structure

**Device COGS** (Cost of Goods Sold):

- Components: $80-$120
- Assembly: $20-$40
- Packaging: $10
- Total: $110-$170 per device
- **Margin**: 30-40% at $300 price

**Test Strip COGS**:

- Materials (antibodies, substrate, plastic): $8-$12
- Manufacturing: $3-$5
- Packaging: $2
- Total: $13-$19 per strip
- **Margin**: 50-65% at $40 price

**Operating Expenses**:

- Sales & marketing: 30% of revenue
- R&D: 15%
- G&A: 10%
- Regulatory & quality: 5%

---

## Financial Projections

### Revenue Forecast (10-Year, Conservative)

| Year  | Devices Sold | Tests/Year | Device Revenue | Strip Revenue | Total Revenue |
| ----- | ------------ | ---------- | -------------- | ------------- | ------------- |
| 2030  | 500          | 10,000     | $150K          | $400K         | $550K         |
| 2031  | 1,500        | 50,000     | $450K          | $2M           | $2.45M        |
| 2032  | 3,000        | 120,000    | $900K          | $4.8M         | $5.7M         |
| 2033  | 5,000        | 250,000    | $1.5M          | $10M          | $11.5M        |
| 2034  | 7,500        | 500,000    | $2.25M         | $20M          | $22.25M       |
| 2035+ | 10,000+      | 1M+        | $3M+           | $40M+         | $43M+         |

**Foundation Royalty (15% of revenue)**: $6-7M/year at maturity (Year 10+)

**Alternative Exit** (Year 8-10): Sell device business for $200-500M

---

### Investment Required

**Phase 1 (Feasibility)**: $200K
**Phase 2 (Development)**: $1.5M
**Phase 3 (FDA)**: $500K
**Phase 4 (Launch)**: $5M
**Phase 5 (Scale)**: $10M (or funded by sales)

**Total: $7-17M over 5-10 years**

**Funding Sources**:

- Foundation research budget: $2M
- Industry partner co-funding: $3-5M
- Venture capital (if independent device company): $10-20M

---

## Success Metrics

### Development Milestones

**Year 1**: Prototype device, feasibility data (r >0.90 vs. lab test)
**Year 2**: Optimized device (r >0.95)
**Year 3**: Clinical validation complete (N=500)
**Year 4**: FDA 510(k) clearance
**Year 5**: Commercial launch, 10,000 tests performed
**Year 7**: CLIA waiver obtained, 100,000 tests/year
**Year 10**: 1 million tests/year, $40M revenue

---

### Impact Metrics

**Diagnostic Delay Reduction**:

- Baseline: 7-8 years (2025)
- Goal: 3-4 years (2035)
- Device contribution: 30-50% of improvement

**Testing Rates**:

- Baseline: 10% of COPD patients tested (2025)
- Goal: 50% tested (2035)
- Device contribution: 2-3x increase in testing

**Revenue for Foundation**:

- Year 5: $100K/year (royalties)
- Year 10: $6M/year (royalties) OR $200-500M (exit)

---

## Summary: Why This Device Matters

**The AAT glucometer could be a game-changer**:

- ✅ Eliminates #1 barrier to AATD diagnosis (testing inconvenience)
- ✅ Doubles or triples testing rates
- ✅ Reduces diagnostic delays from 7-8 years to 3-4 years
- ✅ Generates $5-10M/year for foundation (sustainable funding)
- ✅ Helps 100,000+ people get diagnosed earlier

**Strategic Priorities (Years 1-3)**:

1. Partner with diagnostics company (Roche, Abbott)
2. Develop and validate prototype device
3. Complete clinical trial (N=500)
4. Submit to FDA for 510(k) clearance
5. Secure reimbursement (CPT code)

**This device could be as transformative as home glucose testing was for diabetes.**

---

**Questions or Partnership Opportunities?**

**Mark Egly Foundation**
📧 Email: innovation@markeglyfoundation.org
🌐 Website: MarkEglyFoundation.org/glucometer

---

**Approved by**: Board of Directors & Innovation Committee
**Effective Date**: January 1, 2026
**Review Date**: Annually
**Version**: 1.0

---

_"Making AATD testing as easy as checking your blood sugar."_

**— Mark Egly Foundation**
