# Feature #18: Advanced Reporting & Data Export

**Category**: Critical Missing Feature
**Priority**: Phase 2 (Year 1 - Should Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 data engineer, 0.5 FTE frontend developer, 0.25 FTE BI analyst

---

## Executive Summary

Patients, providers, and insurance partners need customizable reports and data exports for care coordination, compliance, research, and business intelligence. Current platform lacks flexible reporting—users can't generate longitudinal trends, export structured data for external analysis, or create custom dashboards. Advanced reporting enables better clinical decisions, regulatory compliance (HEDIS quality measures), and data-driven platform improvements.

**Key Value Propositions**:

- **Patient Reports**: Longitudinal health trends (FEV1 decline, AAT levels over time)
- **Provider Reports**: Panel management (all AATD patients, medication adherence rates)
- **Insurance Reports**: Quality measures (HEDIS), utilization, cost savings
- **Custom Dashboards**: Drag-and-drop widgets, saved views, role-based templates
- **Data Export**: CSV, Excel, JSON, FHIR bundles, PDF summaries
- **Scheduled Reports**: Automated weekly/monthly reports via email
- **API Access**: RESTful API for programmatic data extraction (with OAuth)

**Business Impact**:

- **Insurance Revenue**: Quality reporting enables value-based contracts (+$500K/year)
- **Provider Retention**: Panel management tools reduce churn (15% improvement)
- **Research Partnerships**: De-identified data exports generate licensing revenue ($150K+/year)
- **Regulatory Compliance**: HEDIS/CMS reporting reduces audit risk
- **Patient Engagement**: Visual progress reports increase adherence (+12%)

---

## Problem Statement

### Current Gaps

**Scenario 1: Patient Tracking Disease Progression**

> "I've been on augmentation therapy for 2 years. I want to see if my lung function is improving. I have 8 PFT results but they're scattered across different appointments. I can't see a trend line or export to show my doctor."

**No longitudinal visualizations, no data export** ❌

**Scenario 2: Pulmonologist Managing AATD Panel**

> "I have 45 AATD patients. I need a report showing who's due for annual PFTs, who's non-adherent to augmentation therapy, and who has declining FEV1. I can't get this from Fair Underwriting—I have to check each patient manually."

**No provider panel reports** ❌

**Scenario 3: Insurance Company Needs HEDIS Data**

> "We need quarterly HEDIS quality measures for our AATD disease management program: medication adherence rates, ER visits, hospitalizations. Fair Underwriting can't generate this report. We're considering switching vendors."

**No quality measure reporting** ❌

**Scenario 4: Researcher Requesting De-identified Data**

> "I'm studying FEV1 decline rates in MZ vs. ZZ patients. I need de-identified data (genotype, age range, FEV1 over time, smoking status) for 500+ patients. Fair Underwriting has no bulk export—I'd have to manually extract data."

**No research data export** ❌

**Scenario 5: CFO Needs Cost Savings Analysis**

> "We invested $2M in Fair Underwriting. I need to show board members ROI: reduced ER visits, fewer hospitalizations, medication adherence improvements. We have the data but no way to generate executive reports."

**No business intelligence reports** ❌

---

## Feature Specifications

### 1. Patient Longitudinal Reports

**Health Trend Visualizations**:

```typescript
interface HealthTrendReport {
  patientId: string;
  reportType:
    | 'fev1_trend'
    | 'aat_level_trend'
    | 'liver_enzyme_trend'
    | 'medication_adherence';

  // Date range
  startDate: Date;
  endDate: Date;

  // Data points
  dataPoints: {
    date: Date;
    value: number;
    unit: string;
    notes?: string;
  }[];

  // Statistical analysis
  statistics: {
    min: number;
    max: number;
    mean: number;
    median: number;
    stdDev: number;
    trend: 'improving' | 'stable' | 'declining';
    trendSlope: number; // Per year
    changePercent: number; // Total change over period
  };

  // Clinical interpretation
  interpretation: {
    summary: string;
    alerts: string[];
    recommendations: string[];
  };
}

class PatientReportService {
  async generateFEV1TrendReport(
    patientId: string,
    startDate: Date,
    endDate: Date
  ): Promise<HealthTrendReport> {
    // Fetch all PFT results
    const pfts = await this.db.query(
      `
      SELECT effective_date, structured_data->>'fev1_percent' as fev1
      FROM health_records
      WHERE user_id = $1
        AND record_type = 'observation'
        AND tags @> ARRAY['lung_function']
        AND effective_date BETWEEN $2 AND $3
      ORDER BY effective_date ASC
    `,
      [patientId, startDate, endDate]
    );

    const dataPoints = pfts.map((pft) => ({
      date: pft.effective_date,
      value: parseFloat(pft.fev1),
      unit: '% predicted',
      notes: null
    }));

    // Calculate statistics
    const values = dataPoints.map((dp) => dp.value);
    const statistics = this.calculateStatistics(values, dataPoints);

    // Clinical interpretation
    const interpretation = this.interpretFEV1Trend(statistics, dataPoints);

    return {
      patientId,
      reportType: 'fev1_trend',
      startDate,
      endDate,
      dataPoints,
      statistics,
      interpretation
    };
  }

  calculateStatistics(values: number[], dataPoints: any[]): any {
    const min = Math.min(...values);
    const max = Math.max(...values);
    const mean = values.reduce((a, b) => a + b, 0) / values.length;
    const median = this.calculateMedian(values);
    const stdDev = this.calculateStdDev(values, mean);

    // Linear regression to determine trend
    const { slope, rSquared } = this.linearRegression(dataPoints);

    // Annualized slope (mL/year or %/year)
    const daysSpan =
      (dataPoints[dataPoints.length - 1].date.getTime() -
        dataPoints[0].date.getTime()) /
      (1000 * 60 * 60 * 24);
    const yearsSpan = daysSpan / 365.25;
    const trendSlope = slope * (365.25 / (daysSpan / (dataPoints.length - 1))); // Annualized

    // Overall change
    const changePercent =
      ((values[values.length - 1] - values[0]) / values[0]) * 100;

    // Classify trend
    let trend: 'improving' | 'stable' | 'declining';
    if (trendSlope > 1 && rSquared > 0.3) {
      trend = 'improving';
    } else if (trendSlope < -1 && rSquared > 0.3) {
      trend = 'declining';
    } else {
      trend = 'stable';
    }

    return {
      min,
      max,
      mean,
      median,
      stdDev,
      trend,
      trendSlope,
      changePercent,
      rSquared
    };
  }

  interpretFEV1Trend(statistics: any, dataPoints: any[]): any {
    const alerts: string[] = [];
    const recommendations: string[] = [];

    // Alert if declining
    if (statistics.trend === 'declining') {
      alerts.push(
        `⚠️ FEV1 declining at ${Math.abs(statistics.trendSlope).toFixed(1)}% per year`
      );
      recommendations.push(
        'Schedule appointment with pulmonologist to discuss treatment optimization'
      );

      if (statistics.trendSlope < -3) {
        alerts.push(
          '🚨 Rapid decline (>3% per year) - urgent evaluation needed'
        );
        recommendations.push('Consider CT scan to assess disease progression');
        recommendations.push(
          'Review medication adherence and environmental exposures'
        );
      }
    }

    // Alert if low absolute value
    const latestFEV1 = dataPoints[dataPoints.length - 1].value;
    if (latestFEV1 < 50) {
      alerts.push('⚠️ Severe obstruction (FEV1 <50%)');
      recommendations.push(
        'Ensure optimal medical therapy including augmentation therapy'
      );
      recommendations.push('Consider pulmonary rehabilitation');
    }

    // Positive feedback if improving
    if (statistics.trend === 'improving') {
      alerts.push('✅ Lung function improving - great progress!');
      recommendations.push('Continue current treatment regimen');
    }

    // Summary
    const summary = `Over ${dataPoints.length} tests spanning ${Math.round((dataPoints[dataPoints.length - 1].date.getTime() - dataPoints[0].date.getTime()) / (1000 * 60 * 60 * 24 * 30))} months, FEV1 is ${statistics.trend} (${statistics.changePercent > 0 ? '+' : ''}${statistics.changePercent.toFixed(1)}% overall change).`;

    return {
      summary,
      alerts,
      recommendations
    };
  }

  linearRegression(dataPoints: any[]): {
    slope: number;
    intercept: number;
    rSquared: number;
  } {
    const n = dataPoints.length;
    const x = dataPoints.map((dp, i) => i); // Time index
    const y = dataPoints.map((dp) => dp.value);

    const sumX = x.reduce((a, b) => a + b, 0);
    const sumY = y.reduce((a, b) => a + b, 0);
    const sumXY = x.reduce((sum, xi, i) => sum + xi * y[i], 0);
    const sumX2 = x.reduce((sum, xi) => sum + xi * xi, 0);

    const slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    const intercept = (sumY - slope * sumX) / n;

    // Calculate R²
    const meanY = sumY / n;
    const ssTotal = y.reduce((sum, yi) => sum + Math.pow(yi - meanY, 2), 0);
    const ssResidual = y.reduce(
      (sum, yi, i) => sum + Math.pow(yi - (slope * i + intercept), 2),
      0
    );
    const rSquared = 1 - ssResidual / ssTotal;

    return { slope, intercept, rSquared };
  }
}
```

**PDF Report Generation**:

```typescript
import PDFDocument from 'pdfkit';
import { ChartJSNodeCanvas } from 'chartjs-node-canvas';

class PDFReportGenerator {
  async generatePatientProgressReport(
    patientId: string,
    startDate: Date,
    endDate: Date
  ): Promise<Buffer> {
    // Fetch data
    const [fev1Report, aatReport, medicationAdherence] = await Promise.all([
      this.reportService.generateFEV1TrendReport(patientId, startDate, endDate),
      this.reportService.generateAATLevelReport(patientId, startDate, endDate),
      this.reportService.getMedicationAdherence(patientId, startDate, endDate)
    ]);

    const patient = await this.getPatient(patientId);

    // Create PDF
    const doc = new PDFDocument({ size: 'LETTER', margin: 50 });
    const chunks: Buffer[] = [];

    doc.on('data', (chunk) => chunks.push(chunk));
    doc.on('end', () => {});

    // Header
    doc.fontSize(20).text('AATD Health Progress Report', { align: 'center' });
    doc.moveDown();
    doc.fontSize(12).text(`Patient: ${patient.name}`, { align: 'center' });
    doc.text(
      `Report Period: ${this.formatDate(startDate)} - ${this.formatDate(endDate)}`,
      { align: 'center' }
    );
    doc.text(`Generated: ${this.formatDate(new Date())}`, { align: 'center' });
    doc.moveDown(2);

    // FEV1 Trend Section
    doc.fontSize(16).text('Lung Function Trend (FEV1)', { underline: true });
    doc.moveDown();

    // Generate chart
    const fev1Chart = await this.generateLineChart(
      fev1Report.dataPoints.map((dp) => dp.date),
      fev1Report.dataPoints.map((dp) => dp.value),
      'FEV1 (% predicted)',
      { min: 0, max: 100 }
    );
    doc.image(fev1Chart, { width: 500, align: 'center' });
    doc.moveDown();

    // Statistics
    doc.fontSize(12);
    doc.text(`Trend: ${fev1Report.statistics.trend.toUpperCase()}`);
    doc.text(`Average: ${fev1Report.statistics.mean.toFixed(1)}% predicted`);
    doc.text(
      `Change: ${fev1Report.statistics.changePercent > 0 ? '+' : ''}${fev1Report.statistics.changePercent.toFixed(1)}%`
    );
    doc.text(
      `Rate: ${fev1Report.statistics.trendSlope > 0 ? '+' : ''}${fev1Report.statistics.trendSlope.toFixed(1)}% per year`
    );
    doc.moveDown();

    // Interpretation
    doc.fontSize(12).text(fev1Report.interpretation.summary);
    doc.moveDown();

    if (fev1Report.interpretation.alerts.length > 0) {
      doc.fontSize(14).text('Alerts:', { underline: true });
      fev1Report.interpretation.alerts.forEach((alert) => {
        doc.fontSize(11).text(`• ${alert}`);
      });
      doc.moveDown();
    }

    if (fev1Report.interpretation.recommendations.length > 0) {
      doc.fontSize(14).text('Recommendations:', { underline: true });
      fev1Report.interpretation.recommendations.forEach((rec) => {
        doc.fontSize(11).text(`• ${rec}`);
      });
      doc.moveDown();
    }

    // New page for AAT levels
    doc.addPage();

    // AAT Level Trend Section
    doc.fontSize(16).text('Alpha-1 Antitrypsin Levels', { underline: true });
    doc.moveDown();

    const aatChart = await this.generateLineChart(
      aatReport.dataPoints.map((dp) => dp.date),
      aatReport.dataPoints.map((dp) => dp.value),
      'AAT Level (mg/dL)',
      { min: 0, max: 200 }
    );
    doc.image(aatChart, { width: 500, align: 'center' });
    doc.moveDown();

    // Medication Adherence
    doc.addPage();
    doc.fontSize(16).text('Medication Adherence', { underline: true });
    doc.moveDown();

    doc.fontSize(12);
    doc.text(
      `Overall Adherence: ${medicationAdherence.overallRate.toFixed(1)}%`
    );
    doc.moveDown();

    medicationAdherence.medications.forEach((med) => {
      doc.text(
        `${med.name}: ${med.adherenceRate.toFixed(1)}% (${med.dosesTaken}/${med.dosesExpected} doses)`
      );
    });

    // Footer
    doc
      .fontSize(8)
      .text(
        'This report is for informational purposes only and does not constitute medical advice. Consult your healthcare provider.',
        50,
        doc.page.height - 50,
        { align: 'center' }
      );

    doc.end();

    return new Promise((resolve) => {
      doc.on('end', () => {
        resolve(Buffer.concat(chunks));
      });
    });
  }

  async generateLineChart(
    labels: Date[],
    data: number[],
    yAxisLabel: string,
    yAxisOptions?: { min?: number; max?: number }
  ): Promise<Buffer> {
    const width = 600;
    const height = 400;
    const chartCanvas = new ChartJSNodeCanvas({ width, height });

    const configuration = {
      type: 'line',
      data: {
        labels: labels.map((date) => this.formatDate(date)),
        datasets: [
          {
            label: yAxisLabel,
            data,
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            tension: 0.1
          }
        ]
      },
      options: {
        scales: {
          y: {
            title: {
              display: true,
              text: yAxisLabel
            },
            ...yAxisOptions
          }
        },
        plugins: {
          legend: {
            display: true,
            position: 'top'
          }
        }
      }
    };

    return chartCanvas.renderToBuffer(configuration as any);
  }
}
```

### 2. Provider Panel Management Reports

**Panel Dashboard**:

```typescript
interface ProviderPanelReport {
  providerId: string;
  reportDate: Date;

  // Summary statistics
  summary: {
    totalPatients: number;
    activePatients: number;
    newPatientsThisMonth: number;
    zzPhenotype: number;
    mzPhenotype: number;
    onAugmentationTherapy: number;
  };

  // Patients needing attention
  actionRequired: {
    overduePFTs: PatientSummary[];
    decliningFEV1: PatientSummary[];
    medicationNonadherent: PatientSummary[];
    missedAppointments: PatientSummary[];
    abnormalLabs: PatientSummary[];
  };

  // Quality metrics
  qualityMetrics: {
    annualPFTCompletionRate: number; // %
    medicationAdherenceRate: number; // %
    erVisitRate: number; // Per 1000 patient-months
    hospitalizationRate: number; // Per 1000 patient-months
  };
}

interface PatientSummary {
  patientId: string;
  name: string;
  age: number;
  phenotype: string;
  lastSeen: Date;
  alert: string;
  priority: 'low' | 'medium' | 'high' | 'urgent';
}

class ProviderPanelService {
  async generatePanelReport(providerId: string): Promise<ProviderPanelReport> {
    // Get all patients assigned to this provider
    const patients = await this.db.query(
      `
      SELECT u.id, u.name, u.date_of_birth, u.medical_data->>'phenotype' as phenotype
      FROM users u
      JOIN provider_patient_assignments ppa ON u.id = ppa.patient_id
      WHERE ppa.provider_id = $1 AND ppa.active = true
    `,
      [providerId]
    );

    // Summary statistics
    const summary = {
      totalPatients: patients.length,
      activePatients: patients.filter((p) => this.isActive(p.id)).length,
      newPatientsThisMonth: patients.filter((p) =>
        this.isNewThisMonth(p.created_at)
      ).length,
      zzPhenotype: patients.filter((p) => p.phenotype === 'ZZ').length,
      mzPhenotype: patients.filter((p) => p.phenotype === 'MZ').length,
      onAugmentationTherapy: await this.countOnAugmentation(
        patients.map((p) => p.id)
      )
    };

    // Identify patients needing attention
    const actionRequired = {
      overduePFTs: await this.findOverduePFTs(patients),
      decliningFEV1: await this.findDecliningFEV1(patients),
      medicationNonadherent: await this.findNonadherent(patients),
      missedAppointments: await this.findMissedAppointments(patients),
      abnormalLabs: await this.findAbnormalLabs(patients)
    };

    // Calculate quality metrics
    const qualityMetrics = await this.calculateQualityMetrics(patients);

    return {
      providerId,
      reportDate: new Date(),
      summary,
      actionRequired,
      qualityMetrics
    };
  }

  async findOverduePFTs(patients: any[]): Promise<PatientSummary[]> {
    const overdue: PatientSummary[] = [];

    for (const patient of patients) {
      const lastPFT = await this.getLastPFT(patient.id);
      const daysSinceLastPFT = lastPFT
        ? (Date.now() - lastPFT.effective_date.getTime()) /
          (1000 * 60 * 60 * 24)
        : 999;

      // ZZ patients: quarterly (90 days), MZ: annual (365 days)
      const dueInterval = patient.phenotype === 'ZZ' ? 90 : 365;

      if (daysSinceLastPFT > dueInterval) {
        overdue.push({
          patientId: patient.id,
          name: patient.name,
          age: this.calculateAge(patient.date_of_birth),
          phenotype: patient.phenotype,
          lastSeen: lastPFT?.effective_date || null,
          alert: `PFT overdue by ${Math.round(daysSinceLastPFT - dueInterval)} days`,
          priority: daysSinceLastPFT > dueInterval * 1.5 ? 'high' : 'medium'
        });
      }
    }

    return overdue.sort((a, b) =>
      b.priority === 'high' ? 1 : a.priority === 'high' ? -1 : 0
    );
  }

  async findDecliningFEV1(patients: any[]): Promise<PatientSummary[]> {
    const declining: PatientSummary[] = [];

    for (const patient of patients) {
      const fev1Trend = await this.reportService.generateFEV1TrendReport(
        patient.id,
        new Date(Date.now() - 365 * 24 * 60 * 60 * 1000), // Last year
        new Date()
      );

      // Alert if declining >50 mL/year or >3%/year
      if (
        fev1Trend.statistics.trend === 'declining' &&
        fev1Trend.statistics.trendSlope < -3
      ) {
        declining.push({
          patientId: patient.id,
          name: patient.name,
          age: this.calculateAge(patient.date_of_birth),
          phenotype: patient.phenotype,
          lastSeen: fev1Trend.dataPoints[fev1Trend.dataPoints.length - 1]?.date,
          alert: `FEV1 declining ${Math.abs(fev1Trend.statistics.trendSlope).toFixed(1)}% per year`,
          priority: fev1Trend.statistics.trendSlope < -5 ? 'urgent' : 'high'
        });
      }
    }

    return declining;
  }
}
```

### 3. Insurance Quality Measure Reports (HEDIS)

**HEDIS Report Generation**:

```typescript
interface HEDISReport {
  tenantId: string; // Insurance company
  reportingPeriod: {
    startDate: Date;
    endDate: Date;
  };

  // HEDIS measures for COPD/respiratory diseases
  measures: {
    // Medication Management (appropriate medications)
    medicationManagement: {
      numerator: number; // Patients on appropriate therapy
      denominator: number; // All eligible patients
      rate: number; // Percentage
      benchmark: number; // HEDIS benchmark
      meets: boolean; // Meets quality threshold
    };

    // Spirometry Testing
    spirometryTesting: {
      numerator: number; // Patients with annual PFT
      denominator: number;
      rate: number;
      benchmark: number;
      meets: boolean;
    };

    // Acute Exacerbations (lower is better)
    acuteExacerbations: {
      numerator: number; // ER visits + hospitalizations
      denominator: number; // Patient-months
      rate: number; // Per 1000 patient-months
      benchmark: number;
      meets: boolean;
    };

    // Medication Adherence (PDC - Proportion of Days Covered)
    medicationAdherence: {
      numerator: number; // Patients with PDC ≥80%
      denominator: number;
      rate: number;
      benchmark: number;
      meets: boolean;
    };
  };

  // Financial impact
  costSavings: {
    reducedERVisits: number;
    reducedHospitalizations: number;
    improvedAdherence: number;
    totalSavings: number;
  };
}

class HEDISReportService {
  async generateHEDISReport(
    tenantId: string,
    startDate: Date,
    endDate: Date
  ): Promise<HEDISReport> {
    const patients = await this.getEligiblePatients(
      tenantId,
      startDate,
      endDate
    );

    // Calculate each measure
    const medicationManagement = await this.calculateMedicationManagement(
      patients,
      startDate,
      endDate
    );
    const spirometryTesting = await this.calculateSpirometryTesting(
      patients,
      startDate,
      endDate
    );
    const acuteExacerbations = await this.calculateAcuteExacerbations(
      patients,
      startDate,
      endDate
    );
    const medicationAdherence = await this.calculateMedicationAdherence(
      patients,
      startDate,
      endDate
    );

    // Calculate cost savings
    const costSavings = await this.calculateCostSavings(
      tenantId,
      startDate,
      endDate,
      { acuteExacerbations, medicationAdherence }
    );

    return {
      tenantId,
      reportingPeriod: { startDate, endDate },
      measures: {
        medicationManagement,
        spirometryTesting,
        acuteExacerbations,
        medicationAdherence
      },
      costSavings
    };
  }

  async calculateMedicationAdherence(
    patients: any[],
    startDate: Date,
    endDate: Date
  ): Promise<any> {
    let adherentCount = 0;

    for (const patient of patients) {
      const pdc = await this.calculatePDC(patient.id, startDate, endDate);
      if (pdc >= 0.8) {
        adherentCount++;
      }
    }

    const rate = (adherentCount / patients.length) * 100;
    const benchmark = 75; // HEDIS benchmark

    return {
      numerator: adherentCount,
      denominator: patients.length,
      rate,
      benchmark,
      meets: rate >= benchmark
    };
  }

  async calculatePDC(
    patientId: string,
    startDate: Date,
    endDate: Date
  ): Promise<number> {
    // Proportion of Days Covered calculation
    const prescriptions = await this.db.query(
      `
      SELECT fill_date, days_supply
      FROM prescriptions
      WHERE patient_id = $1
        AND medication_name LIKE '%Prolastin%' OR medication_name LIKE '%Aralast%'
        AND fill_date BETWEEN $2 AND $3
      ORDER BY fill_date ASC
    `,
      [patientId, startDate, endDate]
    );

    if (prescriptions.length === 0) return 0;

    const totalDays =
      (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24);
    let daysCovered = 0;
    let currentCoverageEnd = startDate;

    for (const rx of prescriptions) {
      const fillDate = new Date(rx.fill_date);
      const coverageEnd = new Date(
        fillDate.getTime() + rx.days_supply * 24 * 60 * 60 * 1000
      );

      if (fillDate > currentCoverageEnd) {
        // Gap in coverage
        daysCovered +=
          (coverageEnd.getTime() - fillDate.getTime()) / (1000 * 60 * 60 * 24);
      } else {
        // Overlap or continuation
        daysCovered +=
          (coverageEnd.getTime() - currentCoverageEnd.getTime()) /
          (1000 * 60 * 60 * 24);
      }

      currentCoverageEnd = coverageEnd;
    }

    return Math.min(daysCovered / totalDays, 1.0);
  }
}
```

### 4. Data Export Formats

**Multi-Format Export Service**:

```typescript
class DataExportService {
  async exportData(
    userId: string,
    format: 'csv' | 'excel' | 'json' | 'fhir' | 'pdf',
    options: ExportOptions
  ): Promise<Buffer | string> {
    const data = await this.fetchData(userId, options);

    switch (format) {
      case 'csv':
        return this.exportCSV(data);
      case 'excel':
        return this.exportExcel(data);
      case 'json':
        return this.exportJSON(data);
      case 'fhir':
        return this.exportFHIR(data);
      case 'pdf':
        return this.exportPDF(data);
      default:
        throw new Error(`Unsupported format: ${format}`);
    }
  }

  exportCSV(data: any[]): string {
    const headers = Object.keys(data[0]);
    const rows = data.map((row) =>
      headers
        .map((header) => {
          const value = row[header];
          // Escape commas and quotes
          if (
            typeof value === 'string' &&
            (value.includes(',') || value.includes('"'))
          ) {
            return `"${value.replace(/"/g, '""')}"`;
          }
          return value;
        })
        .join(',')
    );

    return [headers.join(','), ...rows].join('\n');
  }

  async exportExcel(data: any[]): Promise<Buffer> {
    const ExcelJS = require('exceljs');
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Data');

    // Add headers
    const headers = Object.keys(data[0]);
    worksheet.addRow(headers);

    // Style header row
    worksheet.getRow(1).font = { bold: true };
    worksheet.getRow(1).fill = {
      type: 'pattern',
      pattern: 'solid',
      fgColor: { argb: 'FFE0E0E0' }
    };

    // Add data rows
    data.forEach((row) => {
      worksheet.addRow(Object.values(row));
    });

    // Auto-fit columns
    worksheet.columns.forEach((column) => {
      let maxLength = 0;
      column.eachCell({ includeEmpty: true }, (cell) => {
        const length = cell.value ? cell.value.toString().length : 10;
        if (length > maxLength) {
          maxLength = length;
        }
      });
      column.width = maxLength + 2;
    });

    return workbook.xlsx.writeBuffer();
  }

  exportFHIR(data: any): string {
    // Convert to FHIR Bundle
    const bundle = {
      resourceType: 'Bundle',
      type: 'collection',
      entry: data.map((record) => ({
        resource: this.convertToFHIRResource(record)
      }))
    };

    return JSON.stringify(bundle, null, 2);
  }
}
```

### 5. Custom Dashboards

**Drag-and-Drop Dashboard Builder**:

```typescript
interface DashboardWidget {
  widgetId: string;
  type:
    | 'line_chart'
    | 'bar_chart'
    | 'pie_chart'
    | 'metric'
    | 'table'
    | 'alert_list';
  title: string;

  // Position/size
  x: number;
  y: number;
  width: number;
  height: number;

  // Data query
  dataSource: {
    table: string;
    filters: Record<string, any>;
    aggregation?: 'sum' | 'avg' | 'count' | 'min' | 'max';
    groupBy?: string;
  };

  // Visualization settings
  settings: {
    xAxis?: string;
    yAxis?: string;
    color?: string;
    showLegend?: boolean;
    showGrid?: boolean;
  };

  // Refresh
  refreshInterval?: number; // seconds
}

interface Dashboard {
  dashboardId: string;
  userId: string;
  name: string;
  description?: string;

  widgets: DashboardWidget[];

  // Sharing
  isPublic: boolean;
  sharedWith: string[]; // User IDs

  created_at: Date;
  updated_at: Date;
}

class DashboardService {
  async saveDashboard(dashboard: Dashboard): Promise<void> {
    await this.db.insert('dashboards', dashboard);
  }

  async renderWidget(widget: DashboardWidget, userId: string): Promise<any> {
    // Fetch data based on widget configuration
    const data = await this.fetchWidgetData(widget.dataSource, userId);

    // Transform for visualization
    return {
      widgetId: widget.widgetId,
      type: widget.type,
      title: widget.title,
      data,
      settings: widget.settings
    };
  }
}
```

### 6. Database Schema

```sql
-- Saved reports
CREATE TABLE saved_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,

  -- Report metadata
  name VARCHAR(300) NOT NULL,
  description TEXT,
  report_type VARCHAR(50) NOT NULL,
  -- 'patient_progress', 'panel_management', 'hedis', 'custom'

  -- Report configuration (JSONB)
  config JSONB NOT NULL,
  /*
  {
    "dateRange": { "start": "2024-01-01", "end": "2024-12-31" },
    "filters": { "phenotype": "ZZ", "onAugmentation": true },
    "metrics": ["fev1_trend", "aat_levels", "adherence"]
  }
  */

  -- Schedule
  scheduled BOOLEAN DEFAULT false,
  schedule_frequency VARCHAR(20), -- 'daily', 'weekly', 'monthly'
  schedule_day_of_week INTEGER, -- 0-6 for weekly
  schedule_day_of_month INTEGER, -- 1-31 for monthly
  last_run_date TIMESTAMPTZ,
  next_run_date TIMESTAMPTZ,

  -- Delivery
  email_recipients TEXT[],

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_saved_reports_user ON saved_reports(user_id);
CREATE INDEX idx_saved_reports_schedule ON saved_reports(next_run_date) WHERE scheduled = true;

-- Custom dashboards
CREATE TABLE dashboards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,

  -- Dashboard metadata
  name VARCHAR(300) NOT NULL,
  description TEXT,

  -- Widgets (JSONB array)
  widgets JSONB NOT NULL DEFAULT '[]'::jsonb,
  /*
  [
    {
      "widgetId": "widget-1",
      "type": "line_chart",
      "title": "FEV1 Trend",
      "x": 0,
      "y": 0,
      "width": 6,
      "height": 4,
      "dataSource": {
        "table": "health_records",
        "filters": { "recordType": "observation", "tags": ["lung_function"] }
      },
      "settings": { "xAxis": "date", "yAxis": "fev1" }
    }
  ]
  */

  -- Sharing
  is_public BOOLEAN DEFAULT false,
  shared_with UUID[],

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_dashboards_user ON dashboards(user_id);

-- Report execution history
CREATE TABLE report_executions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  report_id UUID,
  user_id UUID NOT NULL,

  -- Execution details
  executed_at TIMESTAMPTZ DEFAULT NOW(),
  execution_time_ms INTEGER,
  status VARCHAR(20), -- 'success', 'failed'
  error_message TEXT,

  -- Output
  output_format VARCHAR(10), -- 'pdf', 'csv', 'excel', 'json'
  output_file_url TEXT, -- S3 URL
  output_size_bytes INTEGER,

  -- Retention (auto-delete after 90 days)
  expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '90 days',

  FOREIGN KEY (report_id) REFERENCES saved_reports(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_report_executions_report ON report_executions(report_id, executed_at DESC);
CREATE INDEX idx_report_executions_expires ON report_executions(expires_at) WHERE status = 'success';
```

---

## Success Metrics

### Report Usage

- **Active Report Users**: 70% generate at least 1 report/month
- **Scheduled Reports**: 35% set up automated reports
- **Export Downloads**: 1,200+ exports/month (CSV, Excel, PDF)
- **Custom Dashboards**: 25% create custom dashboards

### Provider Adoption

- **Panel Reports**: 85% of providers use panel management reports
- **Clinical Decision Support**: Reports drive 40% of outreach to at-risk patients
- **Time Savings**: 2 hours/week saved on manual data compilation

### Insurance Value

- **HEDIS Reporting**: 100% compliance with quality measure reporting
- **Value-Based Contracts**: Unlock $500K+/year in quality bonuses
- **Cost Savings Documentation**: $3.5M/year savings quantified and reported

---

## Budget Estimate

### Development (3-4 months)

- **Backend Developer** (report engine, export formats): $140K/year × 0.33 = $46,200
- **Data Engineer** (data pipelines, HEDIS calculations): $150K/year × 0.33 = $49,500
- **Frontend Developer** (0.5 FTE, dashboards, visualizations): $140K/year × 0.5 = $70,000
- **BI Analyst** (0.25 FTE, report templates): $120K/year × 0.25 = $30,000

**Total Development**: ~$195,700

### Annual Operations

- **Report Storage** (S3): $12,000/year
- **Data Processing** (compute for large reports): $18,000/year
- **Chart Rendering** (ChartJS Node Canvas): $6,000/year

**Total Operations**: ~$36,000/year

### **GRAND TOTAL (First Year)**: ~$231,700

### **Ongoing (Year 2+)**: ~$36,000/year

**Value Created**:

- Value-based contract bonuses: $500K/year
- Research data licensing: $150K/year
- Provider retention (reduced churn): $180K/year
  **Total Value**: $830K/year

**Net Benefit (Year 2+)**: +$794K/year (massive ROI)

---

## Risks & Mitigations

### Risk 1: PHI in Reports/Exports

**Impact**: Unsecured reports expose patient data
**Mitigation**: Encrypt exports, access logging, expire after 90 days, watermark PDFs with recipient info

### Risk 2: Performance Issues with Large Datasets

**Impact**: Reports timeout or crash
**Mitigation**: Async job processing, pagination, data sampling for previews, caching, database query optimization

### Risk 3: Incorrect HEDIS Calculations

**Impact**: Insurance quality reports show wrong metrics
**Mitigation**: Double-check logic against HEDIS specs, external audit, unit tests for all calculations

### Risk 4: Data Export Enables Competitor Analysis

**Impact**: Competitors reverse-engineer our algorithms
**Mitigation**: Limit export granularity, aggregate data, rate limiting, terms of service restrictions

### Risk 5: Report Overload (Too Many Options)

**Impact**: Users confused by complex reporting UI
**Mitigation**: Template library (pre-built reports), guided workflows, progressive disclosure, training materials

---

**Document Owner**: Head of Product, Data Engineering Lead
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
