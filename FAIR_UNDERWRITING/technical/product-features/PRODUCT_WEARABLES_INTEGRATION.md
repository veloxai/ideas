# Feature #4: Wearable & IoT Integration

**Category**: Critical Missing Feature
**Priority**: Phase 1 (MVP - Must Have)
**Status**: Not Started
**Estimated Effort**: 3-4 months
**Team Required**: 1 backend developer, 1 mobile developer, 1 data scientist

---

## Executive Summary

Wearable devices and IoT sensors provide continuous health monitoring that complements Fair Underwriting's periodic AAT testing. For MZ carriers and AATD patients, tracking lung function (SpO2, heart rate variability), sleep quality, activity levels, and environmental exposures creates a comprehensive picture of respiratory health between lab tests.

**Key Value Propositions**:
- **Continuous Monitoring**: Track lung health 24/7 between quarterly AAT tests
- **Early Warning System**: Detect declining respiratory function before symptoms appear
- **Lifestyle Insights**: Correlate activity, sleep, air quality with AAT levels
- **Environmental Alerts**: Warn users about poor air quality days (critical for lung health)
- **Behavioral Nudges**: Encourage healthy habits (exercise, smoking cessation)

**Business Impact**:
- Increase engagement: Customers check app 3x more often with wearable data
- Improve outcomes: Early detection of respiratory decline → proactive intervention
- Premium tier revenue: "AAT + Wearables" subscription ($15/month extra)
- Partner value: Insurance companies get continuous health data for better risk assessment

---

## Problem Statement

### Current Gaps

**Scenario 1: MZ Carrier with Subtle Respiratory Decline**
> "I'm an MZ carrier. My AAT levels are normal (tested quarterly), but I've noticed I'm more winded climbing stairs. My Apple Watch shows my resting heart rate has increased by 10 bpm over 3 months. Is this early COPD, or am I out of shape?"

**Currently impossible to connect wearable data to genetic risk** ❌

**Scenario 2: Seasonal Respiratory Triggers**
> "Every spring, my breathing gets worse (allergies + pollen). I want to correlate my symptoms with air quality data and see if my sleep quality (tracked by Fitbit) declines during high-pollen days."

**No air quality integration or symptom tracking** ❌

**Scenario 3: Exercise Optimization**
> "As a ZZ patient, I need to stay active for lung health. I want to know my safe exercise heart rate zones and track if my oxygen saturation drops during workouts (Apple Watch tracks SpO2)."

**No exercise guidance or SpO2 trend analysis** ❌

---

## Supported Devices & Platforms

### Priority 1: Official Platform APIs (Phase 1)

#### Apple Health (iOS)
**Data Types**:
- ✅ Heart Rate (resting, active, variability)
- ✅ Blood Oxygen (SpO2) - Available on Apple Watch Series 6+
- ✅ Respiratory Rate (breaths per minute)
- ✅ Walking Heart Rate Average
- ✅ VO2 Max (cardio fitness)
- ✅ Steps, Distance, Active Calories
- ✅ Sleep Analysis (duration, quality)
- ✅ Mindful Minutes (stress management)

**Integration Method**: HealthKit framework (iOS native)
**Authorization**: User grants permission via iOS system prompt
**Data Sync**: Real-time or batch (app controls frequency)

#### Google Fit (Android)
**Data Types**:
- ✅ Heart Rate
- ✅ Blood Oxygen (SpO2) - if device supports
- ✅ Respiratory Rate (estimated)
- ✅ Steps, Distance, Calories
- ✅ Sleep (duration, stages)
- ✅ Activity Sessions (walking, running, cycling)
- ✅ Weight, BMI

**Integration Method**: Google Fit API (REST + OAuth 2.0)
**Authorization**: OAuth consent screen
**Data Sync**: Batch sync (15-minute intervals)

### Priority 2: Direct Device Integration (Phase 2)

#### Fitbit
**Data Types**:
- Heart Rate Variability (HRV)
- Sleep Stages (REM, deep, light)
- Cardio Fitness Score
- Active Zone Minutes
- Skin Temperature (overnight trends)

**Integration Method**: Fitbit Web API (OAuth 2.0)
**Rate Limits**: 150 requests/hour per user

#### Garmin
**Data Types**:
- Advanced Running Dynamics
- Body Battery (energy level)
- Stress Score
- Pulse Ox (SpO2 during sleep)

**Integration Method**: Garmin Health API
**Requirements**: Garmin Developer Account, App approval

#### Oura Ring
**Data Types**:
- Sleep Score (highly accurate)
- Readiness Score
- HRV during sleep
- Body Temperature trends
- Respiratory Rate

**Integration Method**: Oura Cloud API (OAuth 2.0)
**Best for**: Sleep quality tracking (gold standard)

### Priority 3: Environmental Sensors (Phase 2)

#### Air Quality Monitoring
**Data Sources**:
- **PurpleAir** (real-time PM2.5 sensors worldwide)
- **AirNow API** (EPA official air quality data, US only)
- **OpenWeatherMap** (global air quality index)

**Alerts**:
- Push notification when local AQI > 100 (unhealthy for sensitive groups)
- "Stay indoors today" recommendations
- Historical correlation (poor air quality days vs. respiratory symptoms)

#### Home Air Quality Sensors
**Devices**:
- **Awair Element** (PM2.5, VOCs, CO2, humidity, temperature)
- **Airthings Wave** (radon, CO2, VOCs)

**Integration Method**: Device-specific APIs (REST)

---

## Technical Architecture

### System Components

```
┌─────────────────────────────────────────────────────────┐
│           Fair Underwriting Platform                     │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────────────────────────────────────┐       │
│  │           Mobile Apps                         │       │
│  │  iOS (HealthKit) | Android (Google Fit)      │       │
│  └──────────────┬───────────────────────────────┘       │
│                 │                                         │
│  ┌──────────────▼───────────────────────────────┐       │
│  │     Wearable Data Sync Service               │       │
│  │  (Node.js + Bull Queue for batch processing) │       │
│  └──────────────┬───────────────────────────────┘       │
│                 │                                         │
│    ┌────────────┼────────────┐                          │
│    │            │            │                          │
│  ┌─▼──────┐  ┌─▼────────┐  ┌▼────────────┐            │
│  │ Heart  │  │  SpO2    │  │   Sleep     │            │
│  │ Rate   │  │ Processor│  │  Analyzer   │            │
│  │ Analyzer│  │          │  │             │            │
│  └────┬───┘  └────┬─────┘  └──────┬──────┘            │
│       │           │                │                    │
│       └───────────┼────────────────┘                    │
│                   │                                      │
│  ┌────────────────▼────────────────────────┐           │
│  │  TimescaleDB (Time-series Database)     │           │
│  │  - Optimized for health metrics         │           │
│  │  - Automatic data aggregation           │           │
│  │  - Efficient querying (millions of pts) │           │
│  └────────────────┬────────────────────────┘           │
│                   │                                      │
│  ┌────────────────▼────────────────────────┐           │
│  │   Analytics & ML Pipeline               │           │
│  │   - Anomaly detection                   │           │
│  │   - Trend analysis                      │           │
│  │   - Risk scoring                        │           │
│  └────────────────┬────────────────────────┘           │
│                   │                                      │
│  ┌────────────────▼────────────────────────┐           │
│  │   Customer Dashboard (Web + Mobile)     │           │
│  │   - Charts, insights, alerts            │           │
│  └─────────────────────────────────────────┘           │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

### Database Schema

**TimescaleDB Tables** (optimized for time-series data):

```sql
-- Hypertable for wearable data points
CREATE TABLE wearable_data_points (
  time TIMESTAMPTZ NOT NULL,
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Data source
  source VARCHAR(50) NOT NULL, -- 'apple_health', 'google_fit', 'fitbit', 'garmin', 'oura'
  device_model VARCHAR(100), -- 'Apple Watch Series 9', 'Fitbit Charge 6'

  -- Metric type
  metric_type VARCHAR(50) NOT NULL, -- 'heart_rate', 'spo2', 'respiratory_rate', 'steps', 'sleep'

  -- Value (depends on metric_type)
  value_numeric DOUBLE PRECISION, -- For heart_rate (bpm), spo2 (%), steps (count)
  value_text TEXT, -- For sleep_stage ('awake', 'light', 'deep', 'rem')

  -- Metadata
  unit VARCHAR(20), -- 'bpm', '%', 'count', 'minutes'
  context VARCHAR(50), -- 'resting', 'active', 'sleeping', 'exercise'
  confidence DOUBLE PRECISION, -- 0.0-1.0 (data quality score)

  -- Sync info
  synced_at TIMESTAMPTZ DEFAULT NOW(),

  PRIMARY KEY (time, user_id, metric_type)
);

-- Convert to hypertable for time-series optimization
SELECT create_hypertable('wearable_data_points', 'time');

-- Continuous aggregates for performance (pre-compute hourly/daily averages)
CREATE MATERIALIZED VIEW wearable_hourly_averages
WITH (timescaledb.continuous) AS
SELECT
  time_bucket('1 hour', time) AS hour,
  user_id,
  metric_type,
  AVG(value_numeric) AS avg_value,
  MIN(value_numeric) AS min_value,
  MAX(value_numeric) AS max_value,
  COUNT(*) AS data_points
FROM wearable_data_points
WHERE value_numeric IS NOT NULL
GROUP BY hour, user_id, metric_type;

CREATE MATERIALIZED VIEW wearable_daily_averages
WITH (timescaledb.continuous) AS
SELECT
  time_bucket('1 day', time) AS day,
  user_id,
  metric_type,
  AVG(value_numeric) AS avg_value,
  STDDEV(value_numeric) AS stddev_value,
  COUNT(*) AS data_points
FROM wearable_data_points
WHERE value_numeric IS NOT NULL
GROUP BY day, user_id, metric_type;

-- Sleep sessions (distinct from individual data points)
CREATE TABLE sleep_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Time range
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER, -- Total time in bed

  -- Sleep stages (minutes)
  awake_minutes INTEGER DEFAULT 0,
  light_sleep_minutes INTEGER DEFAULT 0,
  deep_sleep_minutes INTEGER DEFAULT 0,
  rem_sleep_minutes INTEGER DEFAULT 0,

  -- Sleep quality
  sleep_score INTEGER, -- 0-100 (if provided by device)
  efficiency DOUBLE PRECISION, -- (sleep_minutes / duration_minutes) * 100
  interruptions INTEGER, -- Number of times woken up

  -- Respiratory data during sleep
  avg_respiratory_rate DOUBLE PRECISION, -- breaths/minute
  avg_heart_rate DOUBLE PRECISION, -- bpm during sleep
  avg_spo2 DOUBLE PRECISION, -- Oxygen saturation during sleep
  lowest_spo2 DOUBLE PRECISION, -- Detect sleep apnea risk

  -- Source
  source VARCHAR(50) NOT NULL,
  device_model VARCHAR(100),

  -- Sync
  synced_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_sleep_sessions_user_time ON sleep_sessions(user_id, start_time DESC);

-- Activity sessions (workouts, walks, runs)
CREATE TABLE activity_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Time range
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER,

  -- Activity type
  activity_type VARCHAR(50), -- 'walking', 'running', 'cycling', 'swimming', 'yoga'
  intensity VARCHAR(20), -- 'light', 'moderate', 'vigorous'

  -- Metrics
  distance_meters DOUBLE PRECISION,
  calories_burned INTEGER,
  avg_heart_rate DOUBLE PRECISION,
  max_heart_rate DOUBLE PRECISION,
  avg_spo2 DOUBLE PRECISION, -- Important for AATD patients
  min_spo2 DOUBLE PRECISION, -- Detect exercise-induced desaturation

  -- GPS data (optional)
  route_geojson JSONB, -- GeoJSON LineString
  elevation_gain_meters DOUBLE PRECISION,

  -- Source
  source VARCHAR(50) NOT NULL,
  device_model VARCHAR(100),

  -- Sync
  synced_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id)
);

CREATE INDEX idx_activity_sessions_user_time ON activity_sessions(user_id, start_time DESC);

-- User wearable connections
CREATE TABLE user_wearable_connections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL,

  -- Platform
  platform VARCHAR(50) NOT NULL, -- 'apple_health', 'google_fit', 'fitbit', 'garmin', 'oura'

  -- Authorization
  access_token TEXT, -- Encrypted (for platforms requiring OAuth)
  refresh_token TEXT, -- Encrypted
  token_expires_at TIMESTAMPTZ,
  scopes TEXT[], -- Permissions granted

  -- Connection status
  status VARCHAR(20) NOT NULL DEFAULT 'active', -- 'active', 'disconnected', 'expired'
  connected_at TIMESTAMPTZ DEFAULT NOW(),
  last_synced_at TIMESTAMPTZ,

  -- Sync settings
  sync_frequency VARCHAR(20) DEFAULT 'hourly', -- 'realtime', 'hourly', 'daily', 'manual'
  enabled_metrics TEXT[], -- ['heart_rate', 'spo2', 'sleep', 'activity']

  FOREIGN KEY (tenant_id, user_id) REFERENCES users(tenant_id, id),

  -- One connection per platform per user
  UNIQUE(tenant_id, user_id, platform)
);

-- Environmental data (air quality)
CREATE TABLE environmental_data (
  time TIMESTAMPTZ NOT NULL,
  location_id UUID NOT NULL, -- Reference to user's location

  -- Air quality
  aqi INTEGER, -- Air Quality Index (0-500)
  pm25 DOUBLE PRECISION, -- Particulate matter 2.5 (µg/m³)
  pm10 DOUBLE PRECISION, -- Particulate matter 10 (µg/m³)
  ozone DOUBLE PRECISION, -- O3 (ppb)
  no2 DOUBLE PRECISION, -- Nitrogen dioxide (ppb)
  co DOUBLE PRECISION, -- Carbon monoxide (ppm)

  -- Weather
  temperature DOUBLE PRECISION, -- °C
  humidity DOUBLE PRECISION, -- %

  -- Source
  data_source VARCHAR(50), -- 'purpleair', 'airnow', 'openweathermap'

  PRIMARY KEY (time, location_id)
);

SELECT create_hypertable('environmental_data', 'time');

-- Indexes for query performance
CREATE INDEX idx_wearable_user_time ON wearable_data_points(user_id, time DESC);
CREATE INDEX idx_wearable_metric ON wearable_data_points(metric_type, time DESC);
```

### API Endpoints

**Wearable Connection Management**:

```typescript
// POST /api/v1/wearables/connect - Connect wearable platform
interface ConnectWearableRequest {
  platform: 'apple_health' | 'google_fit' | 'fitbit' | 'garmin' | 'oura';
  authorizationCode?: string; // For OAuth platforms (not needed for Apple Health)
  enabledMetrics: string[]; // ['heart_rate', 'spo2', 'sleep', 'activity']
  syncFrequency: 'realtime' | 'hourly' | 'daily' | 'manual';
}

interface ConnectWearableResponse {
  success: boolean;
  connectionId: string;
  platform: string;
  status: 'active';
  connectedAt: string;
  nextSyncAt: string;
}

// GET /api/v1/wearables/connections - List connected wearables
interface ListConnectionsResponse {
  connections: {
    id: string;
    platform: string;
    status: 'active' | 'disconnected' | 'expired';
    connectedAt: string;
    lastSyncedAt: string;
    enabledMetrics: string[];
    syncFrequency: string;
  }[];
}

// DELETE /api/v1/wearables/connections/:id - Disconnect wearable
// Returns: 204 No Content

// POST /api/v1/wearables/sync - Manually trigger sync
interface TriggerSyncRequest {
  connectionId: string;
  startDate?: string; // ISO date - sync from this date forward
  endDate?: string; // ISO date - sync up to this date
}

interface TriggerSyncResponse {
  success: boolean;
  syncJobId: string;
  estimatedCompletionSeconds: number;
  dataPointsToSync: number;
}
```

**Data Retrieval**:

```typescript
// GET /api/v1/wearables/data - Query wearable data
interface QueryWearableDataRequest {
  metricType: 'heart_rate' | 'spo2' | 'respiratory_rate' | 'steps' | 'sleep';
  startDate: string; // ISO date
  endDate: string; // ISO date
  aggregation?: 'raw' | 'hourly' | 'daily' | 'weekly'; // Default: 'hourly'
  includeContext?: boolean; // Include 'resting' vs 'active' context
}

interface QueryWearableDataResponse {
  metricType: string;
  unit: string;
  dataPoints: {
    timestamp: string;
    value: number;
    context?: string;
    source: string;
  }[];
  statistics: {
    average: number;
    min: number;
    max: number;
    stddev: number;
  };
}

// GET /api/v1/wearables/sleep - Get sleep sessions
interface QuerySleepRequest {
  startDate: string;
  endDate: string;
}

interface QuerySleepResponse {
  sessions: {
    id: string;
    startTime: string;
    endTime: string;
    durationMinutes: number;
    stages: {
      awake: number;
      light: number;
      deep: number;
      rem: number;
    };
    sleepScore: number;
    efficiency: number;
    avgRespiratoryRate: number;
    avgHeartRate: number;
    avgSpO2: number;
    lowestSpO2: number; // Flag if < 90% (sleep apnea risk)
  }[];
  insights: {
    averageSleepDuration: number;
    averageSleepScore: number;
    trend: 'improving' | 'stable' | 'declining';
  };
}

// GET /api/v1/wearables/activities - Get activity sessions
interface QueryActivitiesRequest {
  startDate: string;
  endDate: string;
  activityType?: string; // Filter by type
}

interface QueryActivitiesResponse {
  sessions: {
    id: string;
    startTime: string;
    endTime: string;
    durationMinutes: number;
    activityType: string;
    intensity: string;
    distanceMeters: number;
    caloriesBurned: number;
    avgHeartRate: number;
    maxHeartRate: number;
    avgSpO2: number;
    minSpO2: number; // Monitor for exercise-induced desaturation
  }[];
}
```

**Environmental Data**:

```typescript
// GET /api/v1/environment/air-quality - Get current air quality
interface AirQualityRequest {
  latitude: number;
  longitude: number;
  radiusMiles?: number; // Search radius, default 10
}

interface AirQualityResponse {
  aqi: number;
  category: 'good' | 'moderate' | 'unhealthy_sensitive' | 'unhealthy' | 'very_unhealthy' | 'hazardous';
  primaryPollutant: 'pm25' | 'pm10' | 'ozone' | 'no2';
  recommendations: {
    shouldStayIndoors: boolean;
    shouldWearMask: boolean;
    exerciseRecommendation: 'safe' | 'limited' | 'avoid';
    message: string; // e.g., "Air quality is unhealthy for sensitive groups. Limit outdoor activities."
  };
  pollutants: {
    pm25: number;
    pm10: number;
    ozone: number;
    no2: number;
    co: number;
  };
  timestamp: string;
  dataSource: string;
}

// POST /api/v1/environment/subscribe - Subscribe to air quality alerts
interface SubscribeAirQualityRequest {
  latitude: number;
  longitude: number;
  alertThreshold: number; // AQI threshold (e.g., 100)
  notificationMethods: ('push' | 'email' | 'sms')[];
}
```

---

## Feature Specifications

### 1. Apple Health Integration (iOS)

**HealthKit Implementation**:

```swift
import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()

    // Data types to read
    let typesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
        HKObjectType.quantityType(forIdentifier: .respiratoryRate)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .vo2Max)!,
        HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
        HKObjectType.workoutType()
    ]

    // Request authorization
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            completion(success, error)
        }
    }

    // Query heart rate data
    func queryHeartRate(from startDate: Date, to endDate: Date, completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion(nil, NSError(domain: "HealthKit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Heart rate type unavailable"]))
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            guard let samples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }
            completion(samples, nil)
        }

        healthStore.execute(query)
    }

    // Query SpO2 data (oxygen saturation)
    func querySpO2(from startDate: Date, to endDate: Date, completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        guard let spo2Type = HKQuantityType.quantityType(forIdentifier: .oxygenSaturation) else {
            completion(nil, NSError(domain: "HealthKit", code: 1, userInfo: [NSLocalizedDescriptionKey: "SpO2 type unavailable"]))
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: spo2Type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            guard let samples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }
            completion(samples, nil)
        }

        healthStore.execute(query)
    }

    // Observe real-time updates (background)
    func startObservingHeartRate() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }

        let query = HKObserverQuery(sampleType: heartRateType, predicate: nil) { [weak self] query, completionHandler, error in
            if error != nil {
                // Handle error
                completionHandler()
                return
            }

            // New heart rate data available - trigger sync
            self?.syncRecentData()
            completionHandler()
        }

        healthStore.execute(query)
    }

    // Background sync
    func syncRecentData() {
        let now = Date()
        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: now)!

        // Query and upload to Fair Underwriting API
        queryHeartRate(from: oneDayAgo, to: now) { samples, error in
            guard let samples = samples else { return }

            let dataPoints = samples.map { sample in
                return WearableDataPoint(
                    timestamp: sample.startDate,
                    metricType: "heart_rate",
                    value: sample.quantity.doubleValue(for: HKUnit(from: "count/min")),
                    unit: "bpm",
                    source: "apple_health",
                    deviceModel: sample.device?.model ?? "Unknown"
                )
            }

            FairUnderwritingAPI.uploadWearableData(dataPoints)
        }
    }
}
```

### 2. Google Fit Integration (Android)

**Google Fit API Implementation**:

```kotlin
import com.google.android.gms.fitness.Fitness
import com.google.android.gms.fitness.data.DataType
import com.google.android.gms.fitness.request.DataReadRequest
import java.util.concurrent.TimeUnit

class GoogleFitManager(private val context: Context) {

    private val fitnessOptions = FitnessOptions.builder()
        .addDataType(DataType.TYPE_HEART_RATE_BPM, FitnessOptions.ACCESS_READ)
        .addDataType(DataType.TYPE_OXYGEN_SATURATION, FitnessOptions.ACCESS_READ)
        .addDataType(DataType.TYPE_STEP_COUNT_DELTA, FitnessOptions.ACCESS_READ)
        .addDataType(DataType.TYPE_DISTANCE_DELTA, FitnessOptions.ACCESS_READ)
        .addDataType(DataType.TYPE_CALORIES_EXPENDED, FitnessOptions.ACCESS_READ)
        .addDataType(DataType.TYPE_SLEEP_SEGMENT, FitnessOptions.ACCESS_READ)
        .build()

    fun requestPermissions(activity: Activity) {
        if (!GoogleSignIn.hasPermissions(GoogleSignIn.getLastSignedInAccount(context), fitnessOptions)) {
            GoogleSignIn.requestPermissions(
                activity,
                GOOGLE_FIT_PERMISSIONS_REQUEST_CODE,
                GoogleSignIn.getLastSignedInAccount(context),
                fitnessOptions
            )
        }
    }

    fun queryHeartRate(startTime: Long, endTime: Long, callback: (List<DataPoint>) -> Unit) {
        val readRequest = DataReadRequest.Builder()
            .read(DataType.TYPE_HEART_RATE_BPM)
            .setTimeRange(startTime, endTime, TimeUnit.MILLISECONDS)
            .build()

        Fitness.getHistoryClient(context, GoogleSignIn.getLastSignedInAccount(context)!!)
            .readData(readRequest)
            .addOnSuccessListener { response ->
                val dataPoints = response.dataSets.flatMap { dataSet ->
                    dataSet.dataPoints.map { dataPoint ->
                        WearableDataPoint(
                            timestamp = dataPoint.getStartTime(TimeUnit.MILLISECONDS),
                            metricType = "heart_rate",
                            value = dataPoint.getValue(Field.FIELD_BPM).asFloat(),
                            unit = "bpm",
                            source = "google_fit",
                            deviceModel = dataPoint.originalDataSource.device?.model ?: "Unknown"
                        )
                    }
                }
                callback(dataPoints)
            }
            .addOnFailureListener { e ->
                Log.e("GoogleFit", "Failed to read heart rate data", e)
            }
    }

    fun querySpO2(startTime: Long, endTime: Long, callback: (List<DataPoint>) -> Unit) {
        val readRequest = DataReadRequest.Builder()
            .read(DataType.TYPE_OXYGEN_SATURATION)
            .setTimeRange(startTime, endTime, TimeUnit.MILLISECONDS)
            .build()

        Fitness.getHistoryClient(context, GoogleSignIn.getLastSignedInAccount(context)!!)
            .readData(readRequest)
            .addOnSuccessListener { response ->
                val dataPoints = response.dataSets.flatMap { dataSet ->
                    dataSet.dataPoints.map { dataPoint ->
                        WearableDataPoint(
                            timestamp = dataPoint.getStartTime(TimeUnit.MILLISECONDS),
                            metricType = "spo2",
                            value = dataPoint.getValue(Field.FIELD_PERCENTAGE).asFloat(),
                            unit = "%",
                            source = "google_fit"
                        )
                    }
                }
                callback(dataPoints)
            }
    }
}
```

### 3. Data Analysis & Insights

**Anomaly Detection** (Python backend):

```python
import numpy as np
from sklearn.ensemble import IsolationForest
from datetime import datetime, timedelta

class WearableAnomalyDetector:
    def __init__(self, user_id: str):
        self.user_id = user_id
        self.model = IsolationForest(contamination=0.1)  # 10% anomaly rate

    def detect_heart_rate_anomalies(self, days_lookback: int = 30):
        """Detect unusual heart rate patterns"""
        # Query last 30 days of resting heart rate
        data = query_wearable_data(
            user_id=self.user_id,
            metric_type='heart_rate',
            context='resting',
            start_date=datetime.now() - timedelta(days=days_lookback),
            end_date=datetime.now()
        )

        # Extract features
        features = []
        for day in data.groupby(data['timestamp'].dt.date):
            features.append([
                day['value'].mean(),  # Average resting HR
                day['value'].std(),   # Variability
                day['value'].max() - day['value'].min()  # Range
            ])

        # Train model
        self.model.fit(features)

        # Predict anomalies
        predictions = self.model.predict(features)
        anomaly_dates = [date for date, pred in zip(data['timestamp'].dt.date.unique(), predictions) if pred == -1]

        if len(anomaly_dates) > 0:
            # Alert user
            send_notification(
                user_id=self.user_id,
                title="Unusual Heart Rate Pattern Detected",
                body=f"Your resting heart rate has been elevated on {len(anomaly_dates)} days this month. Consider consulting your doctor."
            )

        return anomaly_dates

    def detect_spo2_desaturation(self, threshold: float = 92.0):
        """Detect low oxygen saturation events"""
        # Query recent SpO2 data
        data = query_wearable_data(
            user_id=self.user_id,
            metric_type='spo2',
            start_date=datetime.now() - timedelta(days=7),
            end_date=datetime.now()
        )

        # Find desaturation events (SpO2 < 92%)
        desaturations = data[data['value'] < threshold]

        if len(desaturations) > 5:  # More than 5 events in a week
            # Critical alert
            send_notification(
                user_id=self.user_id,
                title="⚠️ Low Oxygen Saturation Detected",
                body=f"Your SpO2 has dropped below {threshold}% multiple times this week. Contact your pulmonologist.",
                priority="critical"
            )

            # Auto-schedule telemedicine consultation
            offer_urgent_telemedicine(self.user_id)

        return desaturations

    def correlate_aat_with_activity(self):
        """Correlate AAT levels with activity patterns"""
        # Get AAT test results
        aat_tests = query_aat_tests(self.user_id, limit=5)

        correlations = []
        for test in aat_tests:
            # Get activity data 7 days before test
            activities = query_activities(
                user_id=self.user_id,
                start_date=test.test_date - timedelta(days=7),
                end_date=test.test_date
            )

            avg_daily_steps = np.mean([a.steps for a in activities])
            avg_active_minutes = np.mean([a.duration_minutes for a in activities])

            correlations.append({
                'test_date': test.test_date,
                'aat_level': test.aat_level,
                'avg_daily_steps': avg_daily_steps,
                'avg_active_minutes': avg_active_minutes
            })

        # Calculate correlation coefficient
        if len(correlations) >= 3:
            aat_levels = [c['aat_level'] for c in correlations]
            activity_levels = [c['avg_active_minutes'] for c in correlations]

            correlation = np.corrcoef(aat_levels, activity_levels)[0, 1]

            if correlation < -0.5:
                # Negative correlation: more activity → lower AAT (good!)
                insight = f"Your activity level correlates with healthier AAT levels. Keep it up!"
            elif correlation > 0.5:
                # Positive correlation: more activity → higher AAT (inflammation?)
                insight = f"Your AAT levels seem to rise with increased activity. This may indicate exercise-induced inflammation. Discuss with your doctor."
            else:
                insight = "No clear correlation between activity and AAT levels yet. Keep tracking!"

            return {
                'correlation': correlation,
                'insight': insight,
                'data': correlations
            }
```

### 4. Air Quality Integration

**PurpleAir API Integration**:

```typescript
interface PurpleAirSensor {
  id: number;
  name: string;
  latitude: number;
  longitude: number;
  pm2_5: number; // Current PM2.5 reading
  aqi: number; // Calculated AQI
  lastSeen: Date;
}

class AirQualityService {
  private purpleAirApiKey: string;

  async getNearestSensor(lat: number, lon: number, radiusMiles: number = 10): Promise<PurpleAirSensor | null> {
    const response = await fetch(
      `https://api.purpleair.com/v1/sensors?fields=name,latitude,longitude,pm2.5&location_type=outside&max_age=3600&nwlat=${lat + 0.15}&nwlng=${lon - 0.15}&selat=${lat - 0.15}&selng=${lon + 0.15}`,
      {
        headers: {
          'X-API-Key': this.purpleAirApiKey
        }
      }
    );

    const data = await response.json();

    if (data.data.length === 0) {
      return null;
    }

    // Find nearest sensor
    const sensors = data.data.map((sensor: any) => ({
      id: sensor[0],
      name: sensor[1],
      latitude: sensor[2],
      longitude: sensor[3],
      pm2_5: sensor[4],
      aqi: this.calculateAQI(sensor[4]),
      distance: this.haversineDistance(lat, lon, sensor[2], sensor[3])
    }));

    sensors.sort((a, b) => a.distance - b.distance);
    return sensors[0];
  }

  calculateAQI(pm25: number): number {
    // EPA AQI calculation for PM2.5
    const breakpoints = [
      { low: 0, high: 12.0, aqiLow: 0, aqiHigh: 50 },
      { low: 12.1, high: 35.4, aqiLow: 51, aqiHigh: 100 },
      { low: 35.5, high: 55.4, aqiLow: 101, aqiHigh: 150 },
      { low: 55.5, high: 150.4, aqiLow: 151, aqiHigh: 200 },
      { low: 150.5, high: 250.4, aqiLow: 201, aqiHigh: 300 },
      { low: 250.5, high: 500.4, aqiLow: 301, aqiHigh: 500 }
    ];

    for (const bp of breakpoints) {
      if (pm25 >= bp.low && pm25 <= bp.high) {
        return Math.round(
          ((bp.aqiHigh - bp.aqiLow) / (bp.high - bp.low)) * (pm25 - bp.low) + bp.aqiLow
        );
      }
    }

    return 500; // Hazardous
  }

  async checkAirQualityAndAlert(userId: string, lat: number, lon: number): Promise<void> {
    const sensor = await this.getNearestSensor(lat, lon);

    if (!sensor) {
      return;
    }

    const user = await getUser(userId);
    const alertThreshold = user.airQualityAlertThreshold || 100; // Default: unhealthy for sensitive groups

    if (sensor.aqi >= alertThreshold) {
      // Send push notification
      await sendPushNotification(userId, {
        title: `⚠️ Poor Air Quality Alert`,
        body: `AQI is ${sensor.aqi} (${this.getAQICategory(sensor.aqi)}). Limit outdoor activities.`,
        data: {
          aqi: sensor.aqi,
          pm25: sensor.pm2_5,
          sensorName: sensor.name,
          actionUrl: '/app/air-quality'
        }
      });

      // Log alert
      await logEnvironmentalAlert(userId, {
        type: 'air_quality',
        severity: sensor.aqi >= 150 ? 'high' : 'moderate',
        aqi: sensor.aqi,
        pm25: sensor.pm2_5,
        latitude: lat,
        longitude: lon,
        timestamp: new Date()
      });
    }
  }

  getAQICategory(aqi: number): string {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }
}
```

---

## User Experience

### Dashboard Widgets

**Heart Rate Trends**:
```
┌────────────────────────────────────────────┐
│  ❤️ Resting Heart Rate                    │
├────────────────────────────────────────────┤
│  Current: 68 bpm  ↓ 3 bpm (vs last week)  │
│                                             │
│   80 │                   ╱╲               │
│   75 │         ╱╲       ╱  ╲              │
│   70 │  ╱╲    ╱  ╲  ╱╲╱    ╲             │
│   65 │╱   ╲╱     ╲╱          ╲            │
│   60 └───────────────────────────────     │
│      Mon Tue Wed Thu Fri Sat Sun         │
│                                             │
│  ✅ Your resting HR is trending down.     │
│     Great sign of improving fitness!       │
└────────────────────────────────────────────┘
```

**SpO2 Monitoring**:
```
┌────────────────────────────────────────────┐
│  🫁 Oxygen Saturation (SpO2)               │
├────────────────────────────────────────────┤
│  Last 24 hours: 97% average                │
│                                             │
│  100% ┐                                    │
│   98% │ ████████████████████████████       │
│   96% │                                    │
│   94% │                                    │
│   92% │                    ⚠️ Low          │
│   90% └────────────────────────────       │
│       12AM  6AM  12PM  6PM  12AM          │
│                                             │
│  ⚠️ SpO2 dropped to 91% at 3 AM.          │
│     Possible sleep apnea. Book sleep study?│
│     [Schedule Consultation]                │
└────────────────────────────────────────────┘
```

**Air Quality Alert**:
```
┌────────────────────────────────────────────┐
│  🌫️ Air Quality - Unhealthy               │
├────────────────────────────────────────────┤
│  Current AQI: 165 (Unhealthy)             │
│  Primary Pollutant: PM2.5 (42 µg/m³)      │
│                                             │
│  🚫 Recommendations:                       │
│  • Stay indoors if possible               │
│  • Close windows                           │
│  • Use air purifier                        │
│  • Avoid outdoor exercise                  │
│                                             │
│  📍 Boston, MA                             │
│  Updated: 2 minutes ago                    │
│                                             │
│  [View Map] [Set Alert Threshold]          │
└────────────────────────────────────────────┘
```

---

## Success Metrics

### Adoption
- **Connection Rate**: 55% of users connect at least one wearable
- **Multi-Device Users**: 25% connect 2+ devices (watch + fitness tracker)
- **Daily Sync Rate**: 80% of connected wearables sync daily

### Engagement
- **Dashboard Views**: 3x increase in daily logins with wearable data
- **Data Review**: 60% of users view wearable insights weekly
- **Action Rate**: 40% of users take action on alerts (schedule appointment, etc.)

### Health Outcomes
- **Early Detection**: 15% of anomalies detected lead to medical intervention
- **Lifestyle Changes**: 35% of users improve sleep quality after tracking
- **Exercise Adherence**: 50% increase in activity minutes among engaged users

### Business
- **Premium Tier Conversion**: 30% upgrade to "AAT + Wearables" plan ($15/month extra)
- **Partner Value**: Wearable data improves risk models by 20% (vs. AAT alone)
- **Retention**: Users with wearables have 90% annual retention (vs. 75% without)

---

## Budget Estimate

### Development (3-4 months)
- **Backend Developer**: $140K/year × 0.33 years = $46,200
- **Mobile Developer** (iOS & Android): $150K/year × 0.33 years = $49,500
- **Data Scientist** (ML models): $160K/year × 0.25 years = $40,000

**Total Development**: ~$135,700

### Annual Infrastructure
- **TimescaleDB** (managed hosting): $500/month × 12 = $6,000
- **PurpleAir API**: $250/month × 12 = $3,000
- **AirNow API**: Free (EPA public API)
- **Data Storage** (S3, time-series data): $200/month × 12 = $2,400
- **Compute** (data processing jobs): $300/month × 12 = $3,600

**Total Infrastructure**: ~$15,000/year

### **GRAND TOTAL (First Year)**: ~$150,700

---

## Risks & Mitigations

### Risk 1: Data Volume
**Impact**: Millions of data points per user → high storage/compute costs
**Mitigation**: Use TimescaleDB compression (10:1 ratio), downsample old data

### Risk 2: Device Compatibility
**Impact**: Not all users have compatible wearables
**Mitigation**: Support manual entry, start with Apple/Google (80% market share)

### Risk 3: Privacy Concerns
**Impact**: Users fear sharing sensitive health data
**Mitigation**: Opt-in only, clear value proposition, end-to-end encryption

### Risk 4: Alert Fatigue
**Impact**: Too many notifications → users disable alerts
**Mitigation**: Smart thresholds (ML-based), user-configurable sensitivity

---

**Document Owner**: CTO, Chief Medical Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
