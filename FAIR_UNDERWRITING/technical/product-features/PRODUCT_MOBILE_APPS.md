# Feature #1: Native Mobile Applications

**Category**: Critical Missing Feature
**Priority**: Phase 1 (MVP - Must Have)
**Status**: Not Started
**Estimated Effort**: 6-9 months
**Team Required**: 2 mobile developers, 1 backend developer, 1 designer

---

## Executive Summary

Native iOS and Android applications are essential for Fair Underwriting's success. Mobile devices are the primary health management tool for 80%+ of users, and critical health alerts (4x AAT spikes) require push notifications that only native apps can reliably deliver.

**Key Value Propositions**:

- Push notifications for critical health alerts (time-sensitive)
- Biometric authentication (Face ID, Touch ID) for secure, convenient access
- Offline access to historical test results
- Camera-based test kit registration (barcode scanning)
- Better user engagement vs. mobile web

---

## User Stories

### Customer Portal Users

**As a Fair Underwriting customer**, I want to:

1. Receive instant push notifications when my AAT levels spike (critical health alert)
2. View my test results on my phone while discussing with my doctor
3. Log in quickly using Face ID/Touch ID instead of typing passwords
4. Register my test kit by scanning the barcode with my phone camera
5. Access my test history even when I don't have internet (airplane, rural area)
6. Set reminders for when to take my next test
7. Share my results with my healthcare provider directly from my phone

**As an MZ carrier**, I want to:

1. Track my lung health trends on the go
2. Get alerts about poor air quality days (environmental triggers)
3. Log symptoms quickly when I notice breathing issues
4. Access educational content about managing my condition

### Partner Portal Users

**As an insurance partner wellness coordinator**, I want to:

1. Check program enrollment statistics from my phone during meetings
2. Receive alerts when customers complete tests (hitting our quarterly targets)
3. View ROI dashboards on my tablet during executive presentations

---

## Technical Specifications

### Platform Support

**iOS**:

- Minimum iOS version: 15.0+
- Target devices: iPhone 8 and newer
- iPad support: Responsive layout (stretch goal)
- Apple Watch companion app: Phase 2

**Android**:

- Minimum Android version: 8.0 (API 26)+
- Target devices: All modern Android phones (2019+)
- Tablet support: Responsive layout (stretch goal)
- Wear OS companion app: Phase 3

### Technology Stack

**iOS**:

- **Language**: Swift 5.9+
- **Framework**: SwiftUI (native UI)
- **Architecture**: MVVM + Coordinator pattern
- **Networking**: URLSession with Alamofire wrapper
- **Local Storage**: CoreData + Keychain (encrypted)
- **Push Notifications**: APNs (Apple Push Notification service)
- **Biometrics**: LocalAuthentication framework (Face ID, Touch ID)
- **Camera**: AVFoundation (barcode scanning)
- **Analytics**: Firebase Analytics

**Android**:

- **Language**: Kotlin 1.9+
- **Framework**: Jetpack Compose (native UI)
- **Architecture**: MVVM + Clean Architecture
- **Networking**: Retrofit + OkHttp
- **Local Storage**: Room Database + EncryptedSharedPreferences
- **Push Notifications**: Firebase Cloud Messaging (FCM)
- **Biometrics**: BiometricPrompt API
- **Camera**: CameraX (barcode scanning with ML Kit)
- **Analytics**: Firebase Analytics

**Shared Backend**:

- GraphQL API (primary) - mobile-optimized queries
- REST API (fallback) - for webhooks, file uploads
- WebSocket - real-time notifications
- AWS S3 - test result PDFs, profile photos

---

## Feature Breakdown

### 1. Push Notifications

**Critical Health Alerts** (Highest Priority):

```json
{
  "type": "critical_alert",
  "title": "⚠️ AAT Level Alert",
  "body": "Your AAT level is 4x normal (820 mg/dL). Contact your doctor today.",
  "priority": "high",
  "sound": "critical_alert.wav",
  "badge": 1,
  "data": {
    "testId": "test_abc123",
    "aatLevel": 820,
    "normalRange": "100-200",
    "timestamp": "2025-11-07T14:30:00Z"
  }
}
```

**Routine Notifications**:

- Test results ready (normal priority)
- Test kit shipped (low priority)
- Reminder to schedule next test (14 days before due)
- New educational content available
- Research study invitation

**Notification Categories**:

```swift
// iOS Categories
enum NotificationCategory: String {
    case criticalAlert = "CRITICAL_ALERT"
    case testResult = "TEST_RESULT"
    case reminder = "REMINDER"
    case educational = "EDUCATIONAL"
}

// Android Channels
- Critical Alerts (high importance, sound, vibration)
- Test Results (default importance, sound)
- Reminders (low importance, no sound)
- Educational (low importance, no sound)
```

**User Controls**:

- Enable/disable each notification category independently
- Quiet hours (e.g., 10 PM - 7 AM, except critical alerts)
- Notification preview on lock screen (on/off)

### 2. Biometric Authentication

**Face ID / Touch ID (iOS)**:

```swift
import LocalAuthentication

class BiometricAuthManager {
    func authenticateUser() async throws -> Bool {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            throw BiometricError.notAvailable
        }

        return try await context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Access your health data"
        )
    }
}
```

**Fingerprint / Face Unlock (Android)**:

```kotlin
import androidx.biometric.BiometricPrompt

class BiometricAuthManager(private val activity: FragmentActivity) {
    fun authenticateUser(onSuccess: () -> Unit, onError: (String) -> Unit) {
        val biometricPrompt = BiometricPrompt(activity, executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    onSuccess()
                }
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    onError(errString.toString())
                }
            }
        )

        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Access your health data")
            .setSubtitle("Use your fingerprint or face")
            .setNegativeButtonText("Use password")
            .build()

        biometricPrompt.authenticate(promptInfo)
    }
}
```

**Fallback**:

- If biometrics fail 3 times, fall back to password
- If biometrics not available, use PIN + password
- Session timeout: 15 minutes (require re-auth)

### 3. Offline Mode

**Cached Data**:

- Last 12 months of test results (encrypted locally)
- User profile information
- Educational content (downloaded on WiFi)
- Genetic counselor contact info

**Database Schema** (SQLite/CoreData/Room):

```sql
CREATE TABLE test_results (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    test_date TEXT NOT NULL,
    aat_level REAL,
    genotype TEXT,
    status TEXT,
    pdf_local_path TEXT,
    synced INTEGER DEFAULT 0,
    created_at TEXT,
    updated_at TEXT
);

CREATE TABLE offline_queue (
    id TEXT PRIMARY KEY,
    action TEXT NOT NULL,
    endpoint TEXT NOT NULL,
    payload TEXT NOT NULL,
    retry_count INTEGER DEFAULT 0,
    created_at TEXT
);
```

**Sync Strategy**:

- Auto-sync when app opens (if internet available)
- Background sync every 30 minutes (iOS: Background App Refresh)
- Manual "Pull to Refresh" on all screens
- Queue offline actions (e.g., mark result as read) for later sync

**Offline UI Indicators**:

- Banner at top: "Offline - showing cached data from [timestamp]"
- Grayed-out action buttons that require internet
- "Sync Now" button when connection restored

### 4. Barcode Scanning (Test Kit Registration)

**User Flow**:

1. Receive test kit in mail with barcode label
2. Open app → "Register New Test Kit"
3. Camera opens with viewfinder overlay
4. Scan barcode (Code 128 format)
5. Kit automatically registered → confirmation screen
6. Instructions displayed: "Send your sample to lab within 7 days"

**Barcode Format**:

```
Format: Code 128
Data: FU-KIT-[10 digits]-[checksum]
Example: FU-KIT-2025110701-X
```

**iOS Implementation**:

```swift
import AVFoundation

class BarcodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                       didOutput metadataObjects: [AVMetadataObject],
                       from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           metadataObject.type == .code128,
           let stringValue = metadataObject.stringValue,
           stringValue.starts(with: "FU-KIT-") {
            registerTestKit(barcode: stringValue)
        }
    }
}
```

**Android Implementation**:

```kotlin
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.common.InputImage

class BarcodeScannerFragment : Fragment() {
    private val barcodeScanner = BarcodeScanning.getClient()

    fun processImage(imageProxy: ImageProxy) {
        val mediaImage = imageProxy.image ?: return
        val inputImage = InputImage.fromMediaImage(mediaImage, imageProxy.imageInfo.rotationDegrees)

        barcodeScanner.process(inputImage)
            .addOnSuccessListener { barcodes ->
                barcodes.firstOrNull { it.rawValue?.startsWith("FU-KIT-") == true }?.let {
                    registerTestKit(it.rawValue!!)
                }
            }
    }
}
```

**Error Handling**:

- Camera permission denied → show permission settings link
- Invalid barcode → "Not a Fair Underwriting test kit. Please check barcode."
- Already registered → "This kit is already registered on [date]"
- Network error → "Queue for sync when online"

### 5. App Features Parity Matrix

| Feature                     | iOS | Android | Priority |
| --------------------------- | --- | ------- | -------- |
| **Authentication**          |
| Login (email/password)      | ✅  | ✅      | P0       |
| Biometric login             | ✅  | ✅      | P0       |
| SSO (Google, Apple)         | ✅  | ✅      | P1       |
| **Dashboard**               |
| Latest test result          | ✅  | ✅      | P0       |
| Test history timeline       | ✅  | ✅      | P0       |
| AAT trend chart             | ✅  | ✅      | P0       |
| Quick actions               | ✅  | ✅      | P1       |
| **Test Results**            |
| View all results            | ✅  | ✅      | P0       |
| Result details              | ✅  | ✅      | P0       |
| Download PDF                | ✅  | ✅      | P0       |
| Share with provider         | ✅  | ✅      | P1       |
| **Test Ordering**           |
| Register test kit (barcode) | ✅  | ✅      | P0       |
| Manual kit registration     | ✅  | ✅      | P1       |
| Track kit status            | ✅  | ✅      | P0       |
| **Notifications**           |
| Push notifications          | ✅  | ✅      | P0       |
| Notification settings       | ✅  | ✅      | P0       |
| Notification history        | ✅  | ✅      | P1       |
| **Profile**                 |
| View/edit profile           | ✅  | ✅      | P0       |
| Privacy settings            | ✅  | ✅      | P0       |
| Subscription management     | ✅  | ✅      | P1       |
| **Education**               |
| Article library             | ✅  | ✅      | P1       |
| Video content               | ✅  | ✅      | P2       |
| Offline downloads           | ✅  | ✅      | P2       |
| **Support**                 |
| Chat with counselor         | ✅  | ✅      | P1       |
| Video consultation          | ✅  | ✅      | P2       |
| FAQ                         | ✅  | ✅      | P1       |

---

## API Requirements

### Mobile-Optimized GraphQL Queries

**Dashboard Query** (minimize payload size):

```graphql
query MobileDashboard($userId: ID!) {
  user(id: $userId) {
    id
    firstName
    latestTestResult {
      id
      testDate
      aatLevel
      status
      normalRange {
        min
        max
      }
    }
    testHistory(limit: 5) {
      id
      testDate
      aatLevel
    }
    pendingKits {
      id
      registeredAt
      status
    }
  }
}
```

**Result Details Query** (paginated):

```graphql
query TestResults($userId: ID!, $cursor: String, $limit: Int = 20) {
  testResults(userId: $userId, after: $cursor, first: $limit) {
    edges {
      node {
        id
        testDate
        aatLevel
        genotype
        pdfUrl
        interpretationSummary
      }
      cursor
    }
    pageInfo {
      hasNextPage
      endCursor
    }
  }
}
```

### REST Endpoints for Mobile

**Register Device Token** (push notifications):

```http
POST /api/v1/mobile/devices
Authorization: Bearer {jwt_token}

{
  "deviceToken": "apns:abc123...",
  "platform": "ios",
  "osVersion": "17.1",
  "appVersion": "1.0.0",
  "preferences": {
    "criticalAlerts": true,
    "testResults": true,
    "reminders": true,
    "educational": false
  }
}
```

**Upload Test Kit Photo** (multipart/form-data):

```http
POST /api/v1/test-kits/register
Authorization: Bearer {jwt_token}
Content-Type: multipart/form-data

barcode: FU-KIT-2025110701-X
photo: [binary]
```

---

## Design Specifications

### iOS Design System

**Colors**:

- Primary: `#0066CC` (Fair Underwriting blue)
- Secondary: `#00A86B` (success/healthy green)
- Critical: `#FF3B30` (alert red)
- Background: `#F5F5F7` (light gray)

**Typography**:

- Title: SF Pro Display, 28pt, Bold
- Headline: SF Pro Text, 17pt, Semibold
- Body: SF Pro Text, 15pt, Regular
- Caption: SF Pro Text, 13pt, Regular

**Navigation**:

- Tab Bar (bottom navigation):
  - Home 🏠
  - Results 📊
  - Test Kit 🧪
  - Profile 👤

### Android Design System

**Material Design 3**:

- Primary: `#0066CC`
- Secondary: `#00A86B`
- Error: `#B3261E`
- Surface: `#FFFFFF`

**Typography**:

- Display Large: Roboto, 57sp
- Headline Medium: Roboto, 28sp
- Body Large: Roboto, 16sp
- Label Medium: Roboto, 12sp

**Navigation**:

- Bottom Navigation Bar:
  - Home
  - Results
  - Test Kit
  - Profile

---

## Security Considerations

### Data Encryption

**At Rest**:

- iOS: Store sensitive data in Keychain (AES-256)
- Android: EncryptedSharedPreferences + EncryptedFile
- Local database: SQLCipher encryption

**In Transit**:

- TLS 1.3 for all API calls
- Certificate pinning (prevent MITM attacks)
- JWT tokens with short expiration (15 min access, 7 day refresh)

### Secure Coding Practices

**iOS**:

- No hardcoded secrets (use Xcode Config files)
- Obfuscate API keys with Swift Package
- Jailbreak detection (optional, for high-security features)

**Android**:

- ProGuard/R8 obfuscation
- Root detection (SafetyNet API)
- Store secrets in NDK (native C++ library)

---

## Performance Requirements

### Load Time Targets

- **Cold Start**: < 2 seconds (app launch to dashboard)
- **Warm Start**: < 1 second
- **Network Requests**: < 500ms (API response time)
- **Image Loading**: < 200ms (profile photos, result charts)

### Battery Optimization

- **Background Sync**: Max once every 30 minutes
- **Location Services**: Only when needed (air quality alerts)
- **Network Usage**: Batch requests, use HTTP/2 multiplexing
- **CPU Usage**: < 10% average (prevent overheating)

### Memory Management

- **iOS**: < 150 MB RAM usage (prevent app kill on older devices)
- **Android**: < 200 MB RAM usage
- **Image Cache**: Max 50 MB
- **Database Size**: < 100 MB (auto-cleanup old data > 2 years)

---

## Testing Strategy

### Unit Tests

- ViewModels (business logic)
- API clients (mock responses)
- Data parsers (JSON decoding)
- Encryption/decryption utilities
- Target: 80% code coverage

### Integration Tests

- API integration (staging environment)
- Database CRUD operations
- Biometric authentication flow
- Push notification handling

### UI Tests

- XCTest (iOS) / Espresso (Android)
- Login flow
- Test result viewing
- Barcode scanning (mock camera input)
- Offline mode behavior

### Beta Testing

- **TestFlight (iOS)**: 100 beta users, 2 weeks
- **Google Play Beta (Android)**: 100 beta users, 2 weeks
- Focus: Real-world usage, crash reports, user feedback

---

## Launch Plan

### Phase 1: MVP (Months 1-3)

**Features**:

- Authentication (email/password, biometric)
- Dashboard (latest result, test history)
- View test results (list, details, PDF download)
- Push notifications (critical alerts, test results)
- Profile management

**Goal**: Launch to pilot partner customers (500 users)

### Phase 2: Enhancement (Months 4-6)

**Features**:

- Barcode scanning (test kit registration)
- Offline mode (cached results)
- Test kit tracking (shipment status)
- Educational content library
- Notification preferences

**Goal**: Expand to all pilot partners (2,500 users)

### Phase 3: Scale (Months 7-9)

**Features**:

- Genetic counselor chat
- Video consultations (in-app)
- Family sharing (view family member results with consent)
- Wearable integration (Apple Health, Google Fit)
- Localization (Spanish support)

**Goal**: General availability (10,000+ users)

---

## Success Metrics (KPIs)

### Adoption

- **App Install Rate**: 60% of enrolled customers within 30 days
- **Daily Active Users (DAU)**: 30% of enrolled customers
- **Monthly Active Users (MAU)**: 70% of enrolled customers

### Engagement

- **Session Frequency**: 2.5 times per week average
- **Session Duration**: 4 minutes average
- **Feature Usage**: 80% view test results, 40% read educational content

### Retention

- **30-Day Retention**: 70%
- **90-Day Retention**: 60%
- **Churn Rate**: < 5% per quarter

### Technical

- **Crash-Free Rate**: > 99.5%
- **Average Rating**: > 4.5 stars (App Store, Google Play)
- **API Success Rate**: > 99.9%

---

## Budget Estimate

### Development Costs (6-9 months)

- **iOS Developer** (Senior): $150K/year × 1 person × 0.75 years = $112,500
- **Android Developer** (Senior): $150K/year × 1 person × 0.75 years = $112,500
- **Backend Developer** (Mobile API): $140K/year × 1 person × 0.5 years = $70,000
- **UI/UX Designer**: $120K/year × 1 person × 0.5 years = $60,000
- **QA Engineer**: $100K/year × 1 person × 0.5 years = $50,000

**Total Development**: ~$405,000

### Infrastructure Costs (Annual)

- **Push Notifications** (Firebase/APNs): $500/month × 12 = $6,000
- **Mobile Analytics** (Firebase): $200/month × 12 = $2,400
- **Crash Reporting** (Sentry): $300/month × 12 = $3,600
- **CDN** (images, videos): $500/month × 12 = $6,000
- **Mobile Device Testing** (BrowserStack): $400/month × 12 = $4,800

**Total Infrastructure**: ~$23,000/year

### Third-Party Services

- **Apple Developer Account**: $99/year
- **Google Play Developer Account**: $25 one-time
- **Code Signing Certificates**: $400/year

**Total Services**: ~$500/year

### **GRAND TOTAL (First Year)**: ~$428,500

---

## Risks & Mitigations

### Risk 1: App Store Rejection

**Risk**: Apple/Google reject app for health data policies
**Probability**: Medium
**Impact**: High (delays launch by 2-4 weeks)
**Mitigation**:

- Review App Store guidelines early
- Consult with app store review team
- Have legal counsel review health data handling
- Submit beta version for pre-review

### Risk 2: Biometric Authentication Failure

**Risk**: Face ID/Touch ID doesn't work reliably
**Probability**: Low
**Impact**: Medium (user frustration)
**Mitigation**:

- Always provide password fallback
- Test on wide range of devices (old iPhones, various Android models)
- Clear error messages explaining alternatives

### Risk 3: Push Notification Delivery Issues

**Risk**: Critical alerts don't reach users (APNs/FCM outage)
**Probability**: Low
**Impact**: Critical (health risk)
**Mitigation**:

- Redundant notification channels (push + SMS + email)
- Monitor notification delivery rates
- User setting: "Always send SMS for critical alerts"

### Risk 4: High Battery Drain

**Risk**: App drains battery, users uninstall
**Probability**: Medium
**Impact**: High (poor reviews, churn)
**Mitigation**:

- Extensive battery testing
- Limit background processes
- Use Apple/Google battery optimization APIs
- User setting: "Low power mode" (disable background sync)

---

## Next Steps

### Immediate Actions (Week 1-2)

1. [ ] Hire iOS developer
2. [ ] Hire Android developer
3. [ ] Create detailed UI mockups (Figma)
4. [ ] Set up Apple Developer + Google Play accounts
5. [ ] Design mobile-specific API endpoints (GraphQL schema)

### Short-term (Month 1)

6. [ ] Set up CI/CD pipelines (Fastlane for iOS, GitHub Actions for Android)
7. [ ] Implement authentication module
8. [ ] Build dashboard (MVP version)
9. [ ] Integrate push notification services
10. [ ] Create beta testing plan

### Medium-term (Months 2-3)

11. [ ] Implement test result viewing
12. [ ] Build offline mode
13. [ ] Add biometric authentication
14. [ ] Implement barcode scanning
15. [ ] Internal testing (dogfooding)

### Long-term (Months 4-6)

16. [ ] Beta launch to pilot partners
17. [ ] Collect feedback, iterate
18. [ ] Performance optimization
19. [ ] App Store submission
20. [ ] Public launch

---

**Document Owner**: CTO, Mobile Lead
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval
