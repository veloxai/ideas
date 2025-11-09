# Feature #21B-3: Wearables & Remote Monitoring

**Part of Feature #21: Research Participation Platform (Advanced Data Collection)**

---

## Overview

Wearable devices and remote monitoring enable **continuous, passive data collection** outside clinical visits, capturing real-world disease burden that traditional episodic assessments miss. For AATD research, remote monitoring is transformative because:

1. **Daily FEV₁ monitoring** - Home spirometry detects decline 6-12 months earlier than quarterly clinic visits
2. **Oxygen saturation** - Pulse oximetry identifies nocturnal hypoxemia, exercise desaturation
3. **Physical activity** - Step counts, exercise minutes correlate with disease severity & prognosis
4. **Sleep quality** - Sleep disruption common in COPD, impacts quality of life
5. **Exacerbation prediction** - Symptom/activity changes precede clinical exacerbations by 3-7 days

Fair Underwriting's remote monitoring platform:

- **Device-agnostic** - Integrates 15+ device types (spirometers, oximeters, fitness trackers, smartwatches)
- **Real-time sync** - Data flows via Bluetooth → mobile app → cloud within 15 minutes
- **Early warning system** - ML models predict exacerbations 5 days in advance (75% sensitivity)
- **Adherence support** - Reminders, gamification to maintain 80%+ compliance
- **Research-grade data** - Validated devices with FDA/CE clearance

---

## Supported Device Categories

### Home Spirometry

```typescript
interface HomeSpirometerDevice {
  deviceId: string;
  participantId: string;

  // Device details
  manufacturer: string; // e.g., "SpiroHome", "MIR Spirobank Smart"
  model: string;
  serialNumber: string;

  // Validation
  fdaCleared: boolean;
  ceMarked: boolean;
  calibrationDate: Date;
  calibrationDueDate: Date;

  // Connection
  connectionType: 'bluetooth' | 'wifi' | 'cellular';
  pairedDeviceId?: string; // Mobile app device ID
  lastSync: Date;

  // Protocol
  testingFrequency: 'daily' | 'twice_daily' | 'weekly';
  testingTime: string; // e.g., "08:00" for morning tests
  remindersEnabled: boolean;

  // Quality control
  qualityThresholds: {
    minReproducibility: number; // FEV1 variance <5%
    minBlowTime: number; // Seconds
    requireMultipleAttempts: boolean;
  };
}

interface SpirometerReading {
  readingId: string;
  deviceId: string;
  participantId: string;

  // Timestamp
  timestamp: Date;
  timezone: string;

  // Measurements
  fev1: { value: number; unit: 'ml' };
  fvc: { value: number; unit: 'ml' };
  pef: { value: number; unit: 'l/min' }; // Peak Expiratory Flow
  fev1_fvc_ratio: number;
  fef25_75?: { value: number; unit: 'l/s' }; // Forced Expiratory Flow 25-75%

  // Attempt details
  attemptNumber: number; // 1, 2, 3 if multiple attempts
  blowDuration: number; // Seconds

  // Quality indicators
  qualityGrade: 'A' | 'B' | 'C' | 'D' | 'F';
  reproducible: boolean; // Attempts within 5% of each other
  acceptableEffort: boolean;
  flaggedForReview: boolean;
  flagReason?: string;

  // Context
  beforeMedication: boolean; // Pre-bronchodilator
  symptomatic: boolean; // Feeling unwell
  notes?: string;

  synced_at: Date;
}
```

### Pulse Oximetry

```typescript
interface PulseOximeterDevice {
  deviceId: string;
  participantId: string;

  manufacturer: string; // e.g., "Nonin", "Masimo"
  model: string;

  // Measurement modes
  measurementMode: 'spot_check' | 'continuous' | 'overnight';

  // Thresholds
  alertThresholds: {
    lowSpo2: number; // e.g., 88%
    lowHeartRate: number; // e.g., 50 bpm
    highHeartRate: number; // e.g., 120 bpm
  };
}

interface OximeterReading {
  readingId: string;
  deviceId: string;
  participantId: string;

  timestamp: Date;

  // Measurements
  spo2: number; // 0-100%
  heartRate: number; // bpm
  perfusionIndex?: number; // Signal quality indicator

  // Context
  activity: 'rest' | 'walking' | 'exercise' | 'sleeping';
  onOxygen: boolean;
  oxygenFlowRate?: number; // L/min

  // Alerts
  belowThreshold: boolean;

  synced_at: Date;
}

// Continuous overnight oximetry
interface OvernightOximetrySession {
  sessionId: string;
  participantId: string;
  deviceId: string;

  startTime: Date;
  endTime: Date;
  duration: number; // Hours

  // Summary statistics
  summary: {
    meanSpo2: number;
    minSpo2: number;
    maxSpo2: number;

    // ODI: Oxygen Desaturation Index (events per hour)
    odi3: number; // ≥3% drops from baseline
    odi4: number; // ≥4% drops

    percentTimeBelow90: number; // % of night <90% SpO2
    percentTimeBelow88: number;

    meanHeartRate: number;
    heartRateVariability: number;
  };

  // Time series data (stored separately for space)
  dataPoints: number; // Count of readings (1 per second = 3,600/hour)
  dataUrl: string; // S3 URL for full time series
}
```

### Activity Trackers & Smartwatches

```typescript
interface ActivityTrackerDevice {
  deviceId: string;
  participantId: string;

  manufacturer: string; // e.g., "Fitbit", "Apple", "Garmin"
  model: string;

  // Data types available
  capabilities: {
    steps: boolean;
    heartRate: boolean;
    sleep: boolean;
    exerciseMinutes: boolean;
    floors: boolean;
    calories: boolean;
    distance: boolean;
  };

  // Sync
  syncFrequency: 'realtime' | 'hourly' | 'daily';
}

interface DailyActivitySummary {
  summaryId: string;
  participantId: string;
  deviceId: string;

  date: Date;

  // Activity
  steps: number;
  activeMinutes: number; // Moderate + vigorous
  sedentaryMinutes: number;
  floorsClimbed?: number;
  distance: { value: number; unit: 'km' | 'mi' };
  caloriesBurned: number;

  // Heart rate
  restingHeartRate: number;
  avgHeartRate: number;
  maxHeartRate: number;
  heartRateZones?: {
    zone: string; // 'resting', 'fat_burn', 'cardio', 'peak'
    minutes: number;
  }[];

  // Sleep (if available)
  sleepData?: {
    totalSleepMinutes: number;
    deepSleepMinutes: number;
    lightSleepMinutes: number;
    remSleepMinutes: number;
    awakeMinutes: number;
    sleepEfficiency: number; // %
    bedtime: Date;
    wakeTime: Date;
  };

  // Goals
  metStepGoal: boolean;
  metActiveMinutesGoal: boolean;

  synced_at: Date;
}
```

---

## Device Integration Architecture

### Universal Device Connector

```typescript
interface DeviceConnector {
  connectorId: string;
  manufacturer: string;
  integrationMethod:
    | 'oauth_api'
    | 'bluetooth_direct'
    | 'hl7_fhir'
    | 'proprietary_sdk';

  // Authentication
  authConfig: {
    clientId?: string;
    clientSecret?: string;
    scopes?: string[];
    authUrl?: string;
    tokenUrl?: string;
  };

  // Data mapping
  dataMapping: {
    sourceField: string;
    targetField: string;
    transformation?: string; // e.g., "ml_to_l", "bpm_to_hr"
  }[];

  // Sync configuration
  syncConfig: {
    pollIntervalMinutes: number;
    batchSize: number;
    lookbackDays: number; // How far back to fetch data on initial sync
  };
}

class UniversalDeviceService {
  async connectDevice(
    participantId: string,
    manufacturer: string,
    authCode?: string
  ): Promise<DeviceConnection> {
    const connector = await this.getConnector(manufacturer);

    switch (connector.integrationMethod) {
      case 'oauth_api':
        return await this.connectViaOAuth(participantId, connector, authCode);

      case 'bluetooth_direct':
        return await this.connectViaBluetooth(participantId, connector);

      case 'hl7_fhir':
        return await this.connectViaFHIR(participantId, connector);

      default:
        throw new Error(
          `Unsupported integration method: ${connector.integrationMethod}`
        );
    }
  }

  async connectViaOAuth(
    participantId: string,
    connector: DeviceConnector,
    authCode: string
  ): Promise<DeviceConnection> {
    // Exchange auth code for access token
    const tokenResponse = await axios.post(connector.authConfig.tokenUrl, {
      grant_type: 'authorization_code',
      code: authCode,
      client_id: connector.authConfig.clientId,
      client_secret: connector.authConfig.clientSecret,
      redirect_uri: `${process.env.BASE_URL}/devices/callback`
    });

    const { access_token, refresh_token, expires_in } = tokenResponse.data;

    // Store connection
    const connection: DeviceConnection = {
      connectionId: uuidv4(),
      participantId,
      manufacturer: connector.manufacturer,
      status: 'active',

      credentials: {
        accessToken: await this.encrypt(access_token),
        refreshToken: await this.encrypt(refresh_token),
        expiresAt: new Date(Date.now() + expires_in * 1000)
      },

      lastSync: null,
      nextSync: new Date(),

      created_at: new Date()
    };

    await this.db.insert('device_connections', connection);

    // Initial data sync
    await this.syncDeviceData(connection.connectionId);

    return connection;
  }

  async syncDeviceData(connectionId: string): Promise<void> {
    const connection = await this.db.findById(
      'device_connections',
      connectionId
    );
    const connector = await this.getConnector(connection.manufacturer);

    // Get access token (refresh if needed)
    const accessToken = await this.getValidAccessToken(connection);

    // Fetch data from device API
    const lookback = connection.lastSync
      ? this.daysBetween(connection.lastSync, new Date())
      : connector.syncConfig.lookbackDays;

    const rawData = await this.fetchDeviceData(
      connector,
      accessToken,
      lookback
    );

    // Transform data to standard format
    const transformedData = this.transformData(rawData, connector.dataMapping);

    // Store in database
    await this.storeDeviceData(connection.participantId, transformedData);

    // Update connection
    await this.db.update('device_connections', connectionId, {
      last_sync: new Date(),
      next_sync: new Date(
        Date.now() + connector.syncConfig.pollIntervalMinutes * 60 * 1000
      )
    });
  }

  async fetchDeviceData(
    connector: DeviceConnector,
    accessToken: string,
    lookbackDays: number
  ): Promise<any> {
    // Example: Fitbit API
    if (connector.manufacturer === 'Fitbit') {
      const endDate = new Date().toISOString().split('T')[0];
      const startDate = new Date(
        Date.now() - lookbackDays * 24 * 60 * 60 * 1000
      )
        .toISOString()
        .split('T')[0];

      const response = await axios.get(
        `https://api.fitbit.com/1/user/-/activities/steps/date/${startDate}/${endDate}.json`,
        {
          headers: { Authorization: `Bearer ${accessToken}` }
        }
      );

      return response.data;
    }

    // Example: Apple Health via HealthKit (requires mobile app)
    else if (connector.manufacturer === 'Apple') {
      // Mobile app collects HealthKit data and uploads
      return await this.fetchFromMobileApp(connector, lookbackDays);
    }

    throw new Error(`Unsupported manufacturer: ${connector.manufacturer}`);
  }

  transformData(rawData: any, mapping: any[]): any {
    const transformed: any = {};

    for (const map of mapping) {
      let value = this.extractField(rawData, map.sourceField);

      // Apply transformation
      if (map.transformation) {
        value = this.applyTransformation(value, map.transformation);
      }

      this.setField(transformed, map.targetField, value);
    }

    return transformed;
  }

  applyTransformation(value: any, transformation: string): any {
    switch (transformation) {
      case 'ml_to_l':
        return value / 1000;
      case 'l_to_ml':
        return value * 1000;
      case 'bpm_to_hr':
        return value; // Already same unit
      case 'date_to_timestamp':
        return new Date(value).getTime();
      default:
        return value;
    }
  }
}
```

### Mobile App SDK

```typescript
// React Native SDK for direct Bluetooth connection
class FairUnderwritingDeviceSDK {
  async scanForDevices(
    deviceType: 'spirometer' | 'oximeter'
  ): Promise<Device[]> {
    // Use react-native-ble-manager
    const devices = await BleManager.scan([], 10); // 10 second scan

    // Filter by device type (based on advertised services)
    const filtered = devices.filter((device) => {
      if (deviceType === 'spirometer') {
        // Spirometers typically advertise 0x1822 (Pulse Oximeter Service - reused)
        return device.advertising.serviceUUIDs?.includes('1822');
      } else if (deviceType === 'oximeter') {
        return device.advertising.serviceUUIDs?.includes('1822');
      }
      return false;
    });

    return filtered.map((d) => ({
      id: d.id,
      name: d.name || 'Unknown Device',
      rssi: d.rssi
    }));
  }

  async connectDevice(deviceId: string): Promise<void> {
    await BleManager.connect(deviceId);

    // Discover services and characteristics
    await BleManager.retrieveServices(deviceId);
  }

  async startSpirometerTest(deviceId: string): Promise<SpirometerReading> {
    // Write to characteristic to start test
    const SERVICE_UUID = '1822';
    const CHARACTERISTIC_UUID = '2A5A'; // PLX Continuous Measurement

    await BleManager.write(
      deviceId,
      SERVICE_UUID,
      CHARACTERISTIC_UUID,
      [0x01] // Start measurement command
    );

    // Listen for measurement data
    return new Promise((resolve, reject) => {
      const timeout = setTimeout(() => {
        reject(new Error('Measurement timeout'));
      }, 60000); // 1 minute timeout

      BleManager.startNotification(
        deviceId,
        SERVICE_UUID,
        CHARACTERISTIC_UUID
      ).then(() => {
        // Handle incoming data
        this.onMeasurementData = (data) => {
          clearTimeout(timeout);

          const reading = this.parseSpirometerData(data);
          resolve(reading);
        };
      });
    });
  }

  parseSpirometerData(data: ArrayBuffer): SpirometerReading {
    // Parse binary data according to device protocol
    const view = new DataView(data);

    const fev1 = view.getUint32(0, true); // Little-endian, ml
    const fvc = view.getUint32(4, true);
    const pef = view.getUint32(8, true);
    const qualityFlag = view.getUint8(12);

    return {
      readingId: uuidv4(),
      deviceId: this.currentDeviceId,
      participantId: this.currentParticipantId,
      timestamp: new Date(),
      timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
      fev1: { value: fev1, unit: 'ml' },
      fvc: { value: fvc, unit: 'ml' },
      pef: { value: pef, unit: 'l/min' },
      fev1_fvc_ratio: fev1 / fvc,
      attemptNumber: 1,
      blowDuration: 0, // Extracted from another characteristic
      qualityGrade: this.mapQualityFlag(qualityFlag),
      reproducible: false, // Determined after multiple attempts
      acceptableEffort: qualityFlag === 0,
      flaggedForReview: qualityFlag !== 0,
      beforeMedication: true,
      symptomatic: false,
      synced_at: new Date()
    };
  }

  async uploadReading(reading: SpirometerReading): Promise<void> {
    await api.post('/devices/spirometry/readings', reading);
  }
}
```

---

## Exacerbation Prediction Model

### Early Warning Algorithm

```typescript
interface ExacerbationPredictionModel {
  modelId: string;
  participantId: string;

  // Input features (7-day rolling averages)
  features: {
    // Spirometry
    fev1_mean: number;
    fev1_variability: number; // Coefficient of variation
    fev1_trend: number; // Slope (ml/day)

    // Oximetry
    spo2_mean: number;
    spo2_min: number;
    nighttime_hypoxemia: number; // % time <90%

    // Activity
    steps_mean: number;
    steps_decline: number; // % decrease vs. baseline
    sedentary_minutes_increase: number;

    // Sleep
    sleep_hours: number;
    sleep_efficiency: number;

    // Symptoms (PRO)
    cat_score: number;
    dyspnea_score: number;
    cough_frequency: number;
  };

  // Prediction
  riskScore: number; // 0-100
  riskCategory: 'low' | 'medium' | 'high' | 'very_high';
  daysToExacerbation: number; // Predicted days until event
  confidence: number; // Model confidence 0-1

  // Action recommendations
  recommendations: {
    action: string;
    priority: 'low' | 'medium' | 'high';
  }[];

  predicted_at: Date;
}

class ExacerbationPredictionService {
  async predictExacerbation(
    participantId: string
  ): Promise<ExacerbationPredictionModel> {
    // 1. Collect recent data (past 7 days)
    const features = await this.extractFeatures(participantId, 7);

    // 2. Run ML model
    const prediction = await this.mlModel.predict(
      'exacerbation_risk',
      features
    );

    // 3. Calculate risk score & category
    const riskScore = prediction.probability * 100;
    const riskCategory = this.categorizeRisk(riskScore);

    // 4. Generate recommendations
    const recommendations = this.generateRecommendations(riskScore, features);

    // 5. Store prediction
    const model: ExacerbationPredictionModel = {
      modelId: uuidv4(),
      participantId,
      features,
      riskScore,
      riskCategory,
      daysToExacerbation: prediction.daysToEvent,
      confidence: prediction.confidence,
      recommendations,
      predicted_at: new Date()
    };

    await this.db.insert('exacerbation_predictions', model);

    // 6. Send alerts if high risk
    if (riskCategory === 'high' || riskCategory === 'very_high') {
      await this.sendExacerbationAlert(participantId, model);
    }

    return model;
  }

  async extractFeatures(participantId: string, days: number): Promise<any> {
    const startDate = new Date(Date.now() - days * 24 * 60 * 60 * 1000);

    // Spirometry data
    const spirometry = await this.db.query(
      `
      SELECT fev1, timestamp
      FROM spirometer_readings
      WHERE participant_id = $1
        AND timestamp >= $2
      ORDER BY timestamp
    `,
      [participantId, startDate]
    );

    const fev1Values = spirometry.map((s) => s.fev1.value);
    const fev1_mean = this.mean(fev1Values);
    const fev1_variability = this.coefficientOfVariation(fev1Values);
    const fev1_trend = this.calculateTrendSlope(
      spirometry.map((s, i) => [i, s.fev1.value])
    );

    // Oximetry data
    const oximetry = await this.db.query(
      `
      SELECT spo2, timestamp, activity
      FROM oximeter_readings
      WHERE participant_id = $1
        AND timestamp >= $2
    `,
      [participantId, startDate]
    );

    const spo2Values = oximetry.map((o) => o.spo2);
    const spo2_mean = this.mean(spo2Values);
    const spo2_min = Math.min(...spo2Values);
    const nighttime_hypoxemia =
      (oximetry.filter((o) => o.activity === 'sleeping' && o.spo2 < 90).length /
        oximetry.filter((o) => o.activity === 'sleeping').length) *
      100;

    // Activity data
    const activity = await this.db.query(
      `
      SELECT steps, sedentary_minutes, date
      FROM daily_activity_summaries
      WHERE participant_id = $1
        AND date >= $2
      ORDER BY date
    `,
      [participantId, startDate]
    );

    const steps_mean = this.mean(activity.map((a) => a.steps));
    const baselineSteps = await this.getBaselineSteps(participantId);
    const steps_decline = ((baselineSteps - steps_mean) / baselineSteps) * 100;
    const sedentary_minutes_increase =
      this.mean(activity.map((a) => a.sedentary_minutes)) -
      (await this.getBaselineSedentaryMinutes(participantId));

    // Sleep data
    const sleep = await this.db.query(
      `
      SELECT total_sleep_minutes, sleep_efficiency
      FROM daily_activity_summaries
      WHERE participant_id = $1
        AND date >= $2
        AND sleep_data IS NOT NULL
    `,
      [participantId, startDate]
    );

    const sleep_hours = this.mean(sleep.map((s) => s.total_sleep_minutes)) / 60;
    const sleep_efficiency = this.mean(sleep.map((s) => s.sleep_efficiency));

    // Symptoms (PRO)
    const latestCAT = await this.db.queryOne(
      `
      SELECT score_summary->>'totalScore' AS cat_score
      FROM pro_survey_responses
      WHERE participant_id = $1
        AND instrument_id = 'cat-v1'
        AND status = 'completed'
        AND completed_at >= $2
      ORDER BY completed_at DESC
      LIMIT 1
    `,
      [participantId, startDate]
    );

    return {
      fev1_mean,
      fev1_variability,
      fev1_trend,
      spo2_mean,
      spo2_min,
      nighttime_hypoxemia,
      steps_mean,
      steps_decline,
      sedentary_minutes_increase,
      sleep_hours,
      sleep_efficiency,
      cat_score: latestCAT?.cat_score || null,
      dyspnea_score: null, // From symptom tracker
      cough_frequency: null
    };
  }

  categorizeRisk(riskScore: number): 'low' | 'medium' | 'high' | 'very_high' {
    if (riskScore < 25) return 'low';
    if (riskScore < 50) return 'medium';
    if (riskScore < 75) return 'high';
    return 'very_high';
  }

  generateRecommendations(riskScore: number, features: any): any[] {
    const recommendations = [];

    if (riskScore >= 50) {
      recommendations.push({
        action: 'Contact your healthcare provider within 24 hours',
        priority: 'high'
      });
    }

    if (features.fev1_decline > 10) {
      recommendations.push({
        action: 'FEV₁ has declined significantly. Schedule spirometry test.',
        priority: 'high'
      });
    }

    if (features.spo2_min < 88) {
      recommendations.push({
        action: 'Low oxygen levels detected. Check oxygen therapy settings.',
        priority: 'high'
      });
    }

    if (features.steps_decline > 30) {
      recommendations.push({
        action:
          'Physical activity has decreased. Try gentle exercise if feeling well.',
        priority: 'medium'
      });
    }

    if (riskScore >= 25) {
      recommendations.push({
        action: 'Ensure you have rescue medications available',
        priority: 'medium'
      });

      recommendations.push({
        action: 'Monitor symptoms closely and record daily',
        priority: 'medium'
      });
    }

    return recommendations;
  }

  async sendExacerbationAlert(
    participantId: string,
    prediction: ExacerbationPredictionModel
  ): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);

    // Alert patient
    await this.notificationService.send({
      userId: participant.userId,
      type: 'exacerbation_warning',
      severity: 'high',
      title: 'Exacerbation Risk Alert',
      message: `Your recent health data suggests increased risk of an exacerbation. Risk level: ${prediction.riskCategory}.`,
      actionUrl: '/health/exacerbation-risk',
      priority: 'high'
    });

    // Alert provider
    if (participant.primaryCareProvider) {
      await this.notificationService.send({
        userId: participant.primaryCareProvider,
        type: 'patient_exacerbation_risk',
        severity: 'high',
        title: 'Patient at High Risk of Exacerbation',
        message: `${participant.demographics.firstName} ${participant.demographics.lastName} has elevated exacerbation risk (${prediction.riskScore}/100). Predicted event in ${prediction.daysToExacerbation} days.`,
        actionUrl: `/patients/${participant.userId}/risk-assessment`
      });
    }
  }
}
```

---

## Adherence & Engagement

### Compliance Monitoring

```typescript
interface DeviceComplianceMetrics {
  participantId: string;
  deviceId: string;
  deviceType: string;

  // Compliance period
  periodStart: Date;
  periodEnd: Date;
  daysInPeriod: number;

  // Expected usage
  expectedReadings: number; // Based on protocol (e.g., daily spirometry = 30 readings/month)

  // Actual usage
  actualReadings: number;
  complianceRate: number; // 0-100%

  // Pattern analysis
  patterns: {
    consecutiveDaysMissed: number;
    longestStreak: number;
    averageReadingsPerDay: number;
    preferredTimeOfDay?: string; // 'morning', 'afternoon', 'evening'
  };

  // Quality
  quality: {
    validReadings: number; // Grade A or B
    invalidReadings: number; // Grade D or F
    averageQualityGrade: string;
  };

  // Barriers
  identifiedBarriers: {
    barrier: string; // 'forgot', 'traveling', 'device_malfunction', 'feeling_well'
    frequency: number;
  }[];
}

class ComplianceMonitoringService {
  async calculateCompliance(
    participantId: string,
    deviceId: string,
    periodDays: number = 30
  ): Promise<DeviceComplianceMetrics> {
    const periodStart = new Date(Date.now() - periodDays * 24 * 60 * 60 * 1000);
    const periodEnd = new Date();

    const device = await this.db.findById('devices', deviceId);
    const protocol = await this.getDeviceProtocol(device.deviceType);

    // Calculate expected readings
    const expectedReadings = periodDays * protocol.readingsPerDay;

    // Get actual readings
    const readings = await this.db.query(
      `
      SELECT *
      FROM ${this.getReadingsTable(device.deviceType)}
      WHERE participant_id = $1
        AND device_id = $2
        AND timestamp BETWEEN $3 AND $4
      ORDER BY timestamp
    `,
      [participantId, deviceId, periodStart, periodEnd]
    );

    const actualReadings = readings.length;
    const complianceRate = (actualReadings / expectedReadings) * 100;

    // Pattern analysis
    const patterns = this.analyzePatterns(readings, periodDays);

    // Quality analysis
    const quality = this.analyzeQuality(readings);

    // Identify barriers
    const barriers = await this.identifyBarriers(
      participantId,
      readings,
      periodDays
    );

    return {
      participantId,
      deviceId,
      deviceType: device.deviceType,
      periodStart,
      periodEnd,
      daysInPeriod: periodDays,
      expectedReadings,
      actualReadings,
      complianceRate,
      patterns,
      quality,
      identifiedBarriers: barriers
    };
  }

  analyzePatterns(readings: any[], periodDays: number): any {
    // Create daily buckets
    const dailyReadings = new Map<string, number>();

    for (const reading of readings) {
      const day = reading.timestamp.toISOString().split('T')[0];
      dailyReadings.set(day, (dailyReadings.get(day) || 0) + 1);
    }

    // Consecutive days missed
    let currentStreak = 0;
    let maxMissedStreak = 0;
    let maxComplianceStreak = 0;
    let currentComplianceStreak = 0;

    for (let i = 0; i < periodDays; i++) {
      const date = new Date(Date.now() - i * 24 * 60 * 60 * 1000);
      const dateStr = date.toISOString().split('T')[0];
      const hadReading = dailyReadings.has(dateStr);

      if (hadReading) {
        currentStreak = 0;
        currentComplianceStreak++;
        maxComplianceStreak = Math.max(
          maxComplianceStreak,
          currentComplianceStreak
        );
      } else {
        currentStreak++;
        currentComplianceStreak = 0;
        maxMissedStreak = Math.max(maxMissedStreak, currentStreak);
      }
    }

    // Time of day analysis
    const hourCounts = new Map<number, number>();
    for (const reading of readings) {
      const hour = reading.timestamp.getHours();
      hourCounts.set(hour, (hourCounts.get(hour) || 0) + 1);
    }

    const mostCommonHour = Array.from(hourCounts.entries()).sort(
      (a, b) => b[1] - a[1]
    )[0]?.[0];

    let preferredTimeOfDay;
    if (mostCommonHour >= 6 && mostCommonHour < 12)
      preferredTimeOfDay = 'morning';
    else if (mostCommonHour >= 12 && mostCommonHour < 18)
      preferredTimeOfDay = 'afternoon';
    else preferredTimeOfDay = 'evening';

    return {
      consecutiveDaysMissed: maxMissedStreak,
      longestStreak: maxComplianceStreak,
      averageReadingsPerDay: readings.length / periodDays,
      preferredTimeOfDay
    };
  }

  async identifyBarriers(
    participantId: string,
    readings: any[],
    periodDays: number
  ): Promise<any[]> {
    const barriers = [];

    // Check for extended gaps (traveling, device issues)
    const gaps = this.findGaps(readings);
    for (const gap of gaps) {
      if (gap.days >= 7) {
        // Check if participant reported reason
        const reason = await this.db.queryOne(
          `
          SELECT reason
          FROM device_compliance_notes
          WHERE participant_id = $1
            AND date BETWEEN $2 AND $3
        `,
          [participantId, gap.start, gap.end]
        );

        barriers.push({
          barrier: reason?.reason || 'unknown',
          frequency: 1
        });
      }
    }

    // Low compliance without gaps = forgetting
    if (readings.length < periodDays * 0.5 && gaps.length === 0) {
      barriers.push({
        barrier: 'forgot',
        frequency: periodDays - readings.length
      });
    }

    // High invalid reading rate = device issues
    const invalidRate =
      readings.filter((r) => r.qualityGrade === 'D' || r.qualityGrade === 'F')
        .length / readings.length;

    if (invalidRate > 0.3) {
      barriers.push({
        barrier: 'device_malfunction',
        frequency: Math.floor(readings.length * invalidRate)
      });
    }

    return barriers;
  }

  async sendComplianceReminder(
    participantId: string,
    deviceType: string
  ): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);

    await this.notificationService.send({
      userId: participant.userId,
      type: 'device_reminder',
      title: `Time for Your ${deviceType} Reading`,
      message: `Don't forget to complete today's ${deviceType} measurement. Your consistent data helps track your health.`,
      actionUrl: '/devices',
      priority: 'medium'
    });
  }
}
```

### Gamification for Adherence

```typescript
interface DeviceEngagementBadges {
  badgeId: string;
  name: string;
  description: string;
  icon: string;

  // Criteria
  criteria: {
    deviceType: string;
    metricType: 'compliance_streak' | 'total_readings' | 'quality_score';
    threshold: number;
  };

  // Reward
  pointsAwarded: number;
}

const deviceBadges: DeviceEngagementBadges[] = [
  {
    badgeId: 'spirometry_streak_7',
    name: '7-Day Spirometry Streak',
    description: 'Completed spirometry for 7 consecutive days',
    icon: '🏆',
    criteria: {
      deviceType: 'spirometer',
      metricType: 'compliance_streak',
      threshold: 7
    },
    pointsAwarded: 50
  },
  {
    badgeId: 'spirometry_streak_30',
    name: '30-Day Spirometry Champion',
    description: 'Completed spirometry for 30 consecutive days',
    icon: '🥇',
    criteria: {
      deviceType: 'spirometer',
      metricType: 'compliance_streak',
      threshold: 30
    },
    pointsAwarded: 200
  },
  {
    badgeId: 'quality_master',
    name: 'Quality Master',
    description: '100 Grade A spirometry readings',
    icon: '⭐',
    criteria: {
      deviceType: 'spirometer',
      metricType: 'quality_score',
      threshold: 100
    },
    pointsAwarded: 150
  },
  {
    badgeId: 'activity_tracker_1000',
    name: '1000 Days Tracked',
    description: 'Wore activity tracker for 1000 days',
    icon: '📈',
    criteria: {
      deviceType: 'activity_tracker',
      metricType: 'total_readings',
      threshold: 1000
    },
    pointsAwarded: 500
  }
];
```

---

## Budget & Success Metrics

### Development Costs (4-5 months)

- **IoT Engineer** (device integrations, Bluetooth protocols): $150K/year × 0.42 = $63,000
- **Mobile Developer** (iOS/Android SDK): $140K/year × 0.42 = $58,800
- **Backend Developer** (data pipelines, APIs): $140K/year × 0.33 = $46,200
- **Data Scientist** (exacerbation prediction model): $160K/year × 0.33 = $52,800
- **Clinical Specialist** (device validation, protocols): $120K/year × 0.25 = $30,000

**Total**: ~$250,800

### Annual Operations

- **Device Provisioning** (subsidized devices for participants): $150/device × 1,000 = $150,000
- **Data Storage** (time-series data): $20,000/year
- **API Integrations** (Fitbit, Apple, etc.): $15,000/year
- **ML Model Operations**: $10,000/year
- **Device Support & Troubleshooting**: $40,000/year

**Total**: ~$235,000/year

### Device Costs (Per Participant)

- **Home Spirometer**: $150 (subsidized; retail $300-500)
- **Pulse Oximeter**: $50 (subsidized; retail $80-150)
- **Activity Tracker**: $0 (many participants already own; Fitbit/Apple Watch)

**Total per participant**: ~$200

### Success Metrics

**Device Adoption**

- Enrollment rate: 60% of registry participants connect ≥1 device
- Multi-device users: 30% connect ≥2 device types

**Compliance**

- Spirometry adherence: 80% complete ≥80% of expected readings
- Oximetry adherence: 70% for overnight monitoring
- Activity tracker sync: 90% daily sync rate

**Clinical Utility**

- Exacerbation prediction: 75% sensitivity, 80% specificity at 5-day lead time
- Early intervention: 40% of predicted exacerbations prevented via early treatment
- FEV₁ decline detection: Identify 50ml/year decline 6 months earlier than quarterly clinic visits

**Research Impact**

- Data completeness: 95% for participants with devices (vs. 70% without)
- Continuous monitoring studies: Enable 5+ studies using real-time data
- Publications: 10+ papers using wearable/remote monitoring data within 3 years

---

## Feature 21B Complete Summary

### Total Budget (All 3 Documents)

**Development Costs:**

- 21B-1: RWE Generation - $279,300
- 21B-2: Patient-Reported Outcomes - $140,300
- 21B-3: Wearables & Remote Monitoring - $250,800
  **Total Development**: ~$670,400 (11-13 months)

**Annual Operations:**

- 21B-1: RWE - $90,000/year
- 21B-2: PRO - $35,000/year
- 21B-3: Wearables - $235,000/year
  **Total Operations**: ~$360,000/year

### Success Metrics Summary

**Data Quality & Completeness**

- Multi-source integration: 85% completeness (EHR + claims + PRO + wearables)
- Data sync latency: <48 hours
- PRO response rate: 80%
- Device compliance: 80%

**Clinical Outcomes**

- Exacerbation prediction: 75% sensitivity, 5-day lead time
- Early intervention: 40% of predicted exacerbations prevented
- Treatment adjustment: 25% of changes preceded by PRO/wearable signals

**Research Productivity**

- CER studies: 3-5/year
- Time to publication: 18-24 months (vs. 36-48 traditional)
- Cost per study: 50% savings vs. traditional

---

**Document Status:** Complete
**Feature 21B Status:** Complete (3/3 documents finished)
**Overall Progress:** Features #14-20 + 21A (5 docs) + 21B (3 docs) = 15 major features complete
**Next:** Feature 21C (Research Federation - 3 documents)
