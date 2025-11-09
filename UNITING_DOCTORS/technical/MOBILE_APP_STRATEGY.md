# Uniting Doctors - Mobile App Strategy

**Version**: 1.0
**Last Updated**: November 9, 2025
**Status**: Planning Phase (Target: Q2 2026)

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Strategic Rationale](#strategic-rationale)
3. [Platform Approach](#platform-approach)
4. [Core Features](#core-features)
5. [Mobile-Specific Features](#mobile-specific-features)
6. [Technical Architecture](#technical-architecture)
7. [Development Roadmap](#development-roadmap)
8. [User Experience](#user-experience)
9. [Offline Capabilities](#offline-capabilities)
10. [Push Notifications](#push-notifications)
11. [Performance Optimization](#performance-optimization)
12. [App Store Optimization](#app-store-optimization)
13. [Beta & Launch](#beta--launch)
14. [Analytics & Metrics](#analytics--metrics)

---

## 🎯 Overview

Mobile access is critical for busy medical professionals. Doctors need to consult peers, reference discussions, and stay updated during rounds, clinic, or on-call shifts.

### Mobile Vision

**"Knowledge in your pocket, whenever you need it"**

The Uniting Doctors mobile app provides full platform functionality optimized for on-the-go use, with offline capabilities and instant notifications.

### Success Criteria

- **Launch Timeline**: Q2 2026 (6-8 months development)
- **Initial Download Target**: 10,000+ in first 3 months
- **Active Usage**: 40%+ of total platform DAU from mobile
- **Rating**: 4.5+ stars on both app stores
- **Engagement**: 30%+ higher session frequency vs web

---

## 📱 Strategic Rationale

### Why Mobile Matters

#### User Research Insights

From beta user feedback:

- **67%** of doctors check medical content on mobile
- **42%** say mobile app is "must-have" for daily workflow
- **78%** would use mobile during clinical downtime (between patients, etc.)
- **89%** want push notifications for important discussions

#### Use Cases

1. **Clinical Rounds** (Morning)
   - Quick reference during patient care
   - Post quick questions between patients
   - Voice-to-text for rapid posting

2. **Commute** (Morning/Evening)
   - Catch up on overnight discussions
   - Read saved posts
   - Listen to audio summaries

3. **On-Call** (Night/Weekend)
   - Urgent clinical questions
   - Quick peer consultation
   - Reference discussions

4. **Breaks** (Throughout day)
   - Scroll feed during lunch
   - Respond to comments
   - Engage with community

5. **Home** (Evening)
   - Deeper reading
   - Long-form posts
   - CME content

### Competitive Landscape

| Platform     | Mobile App     | Key Features                          | Gaps                                  |
| ------------ | -------------- | ------------------------------------- | ------------------------------------- |
| **Doximity** | ✅ iOS/Android | Messaging, news feed, HIPAA-compliant | Limited discussion, no peer Q&A       |
| **Sermo**    | ✅ iOS/Android | Surveys, polls, news                  | Clunky UX, limited search             |
| **Figure 1** | ✅ iOS/Android | Case images, annotations              | Focused on visual cases only          |
| **UpToDate** | ✅ iOS/Android | Clinical references, offline          | Not community-driven                  |
| **Reddit**   | ✅ iOS/Android | Discussions, communities              | Not medical-specific, no verification |

**Opportunity**: Best-in-class mobile UX with full platform parity + mobile-first features.

---

## 🔧 Platform Approach

### Decision: React Native

**Rationale**:

- ✅ Single codebase for iOS + Android (faster development)
- ✅ 90%+ code sharing between platforms
- ✅ Team already familiar with React
- ✅ Large ecosystem (Expo, navigation, etc.)
- ✅ OTA updates (faster iteration)
- ✅ Good performance for our use case

**Alternatives Considered**:

- **Native (Swift/Kotlin)**: Higher quality but 2x development time
- **Flutter**: Great performance but team learning curve
- **Progressive Web App**: Easy but limited native features

### Technology Stack

```
┌────────────────────────────────────────────────┐
│  MOBILE APP STACK                              │
├────────────────────────────────────────────────┤
│  UI Framework: React Native 0.72+              │
│  State Management: Redux Toolkit + RTK Query   │
│  Navigation: React Navigation 6                │
│  UI Components: React Native Paper (Material)  │
│  Forms: React Hook Form                        │
│  Rich Text: react-native-render-html           │
│  Media: Expo Image Picker, Image Manipulator   │
│  Notifications: Expo Notifications + FCM       │
│  Storage: Expo SecureStore + AsyncStorage      │
│  Offline: Redux Persist + custom sync          │
│  Analytics: Mixpanel + Firebase Analytics      │
│  Crash Reporting: Sentry                       │
│  Testing: Jest + React Native Testing Library  │
│  CI/CD: EAS Build + EAS Submit                 │
└────────────────────────────────────────────────┘
```

### Development Environment

**Expo Managed Workflow**:

- Faster development
- OTA updates for non-native code
- Easy access to device features
- Can eject if needed

**Tooling**:

- TypeScript (100% type safety)
- ESLint + Prettier
- Husky (pre-commit hooks)
- GitHub Actions (CI/CD)

---

## ✨ Core Features

### Feature Parity with Web

All core web features available on mobile:

#### 1. Authentication

- ✅ Email/password login
- ✅ OAuth (Google, Apple Sign In)
- ✅ Biometric (Face ID, Touch ID, fingerprint)
- ✅ "Remember me" (secure token storage)

#### 2. Feed & Discovery

- ✅ Home feed (personalized algorithm)
- ✅ Specialty feeds
- ✅ Trending posts
- ✅ Infinite scroll with pull-to-refresh
- ✅ Post filtering (specialty, evidence level, date)

#### 3. Search

- ✅ Keyword search
- ✅ Semantic search
- ✅ Search filters
- ✅ Search history
- ✅ Saved searches

#### 4. Post Creation

- ✅ Text post (rich text editor)
- ✅ Case discussion
- ✅ Poll
- ✅ Image upload (from camera or gallery)
- ✅ Citation insertion (PubMed)
- ✅ Draft saving

#### 5. Engagement

- ✅ Upvote/downvote
- ✅ Comment
- ✅ Reply to comments
- ✅ Share (native share sheet)
- ✅ Save for later
- ✅ Report content

#### 6. Profile

- ✅ View profile
- ✅ Edit profile
- ✅ Verification status
- ✅ Reputation
- ✅ Post history
- ✅ Settings

#### 7. Notifications

- ✅ Push notifications
- ✅ In-app notification center
- ✅ Notification preferences

---

## 📲 Mobile-Specific Features

### Features that make mobile special

#### 1. Voice-to-Text Post Creation

**Use Case**: Doctors between patients, during commute

```typescript
import * as Speech from 'expo-speech';
import { Audio } from 'expo-av';

function VoicePostButton() {
  const [isRecording, setIsRecording] = useState(false);
  const [transcript, setTranscript] = useState('');

  const startRecording = async () => {
    const { status } = await Audio.requestPermissionsAsync();
    if (status !== 'granted') return;

    // Start speech recognition
    Speech.speak('Listening...', { voice: 'en-US' });

    // Use cloud speech-to-text (Google Cloud Speech API)
    const recording = await Audio.Recording.createAsync(
      Audio.RECORDING_OPTIONS_PRESET_HIGH_QUALITY
    );

    setIsRecording(true);
  };

  const stopRecording = async () => {
    setIsRecording(false);

    // Send audio to backend for transcription
    const transcript = await transcribeAudio(audioUri);
    setTranscript(transcript);

    // Auto-fill post form
    setPostContent(transcript);
  };

  return (
    <TouchableOpacity onPress={isRecording ? stopRecording : startRecording}>
      <Icon name={isRecording ? 'stop-circle' : 'microphone'} />
      <Text>{isRecording ? 'Recording...' : 'Voice Input'}</Text>
    </TouchableOpacity>
  );
}
```

**Features**:

- Tap to record
- Real-time transcription
- Auto-punctuation
- Medical terminology recognition
- Edit transcript before posting

#### 2. Quick Actions (Home Screen Widgets)

**iOS**: Widget for trending posts
**Android**: Quick action shortcuts

```typescript
// iOS Widget (using react-native-widget-extension)
function TrendingWidget() {
  return (
    <WidgetContainer>
      <WidgetHeader>Uniting Doctors - Trending</WidgetHeader>
      <TrendingPost title="New AFib guidelines" votes={234} />
      <TrendingPost title="COVID variants update" votes={189} />
      <TrendingPost title="Burnout discussion" votes={156} />
    </WidgetContainer>
  );
}

// Android Quick Actions
const quickActions = [
  { id: 'new-post', title: 'New Post', icon: 'edit' },
  { id: 'search', title: 'Search', icon: 'magnify' },
  { id: 'notifications', title: 'Notifications', icon: 'bell' }
];
```

#### 3. Offline Reading Mode

**Use Case**: Subway, airplane, poor hospital WiFi

- Auto-download feed posts for offline reading
- Queue actions (upvote, comment) to sync when online
- Offline indicator
- Saved posts always available offline

#### 4. Dark Mode (OLED optimization)

**Auto-switching**: Based on system settings or time of day

```typescript
import { useColorScheme } from 'react-native';

function App() {
  const colorScheme = useColorScheme(); // 'light' or 'dark'

  return (
    <PaperProvider theme={colorScheme === 'dark' ? DarkTheme : LightTheme}>
      <NavigationContainer theme={colorScheme === 'dark' ? DarkNav : LightNav}>
        <AppNavigator />
      </NavigationContainer>
    </PaperProvider>
  );
}
```

**Benefits**:

- Better for on-call night use
- Battery savings (OLED screens)
- Reduces eye strain

#### 5. Camera Integration for Case Posts

**Use Case**: Share X-rays, EKGs, skin lesions (with PHI removal)

```typescript
import * as ImagePicker from 'expo-image-picker';
import * as ImageManipulator from 'expo-image-manipulator';

async function captureImage() {
  // Request permissions
  const { status } = await ImagePicker.requestCameraPermissionsAsync();
  if (status !== 'granted') {
    Alert.alert('Permission needed', 'Camera access required for images');
    return;
  }

  // Take photo
  const result = await ImagePicker.launchCameraAsync({
    mediaTypes: ImagePicker.MediaTypeOptions.Images,
    allowsEditing: true,
    quality: 0.8
  });

  if (!result.canceled) {
    // Auto-detect and blur PHI
    const sanitized = await sanitizeImage(result.uri);

    // Compress for upload
    const compressed = await ImageManipulator.manipulateAsync(
      sanitized.uri,
      [{ resize: { width: 1200 } }],
      { compress: 0.7, format: ImageManipulator.SaveFormat.JPEG }
    );

    return compressed.uri;
  }
}
```

**PHI Detection**:

- Use ML model to detect text in images
- Auto-blur text regions
- Manual blur tool
- Warning before posting

#### 6. Haptic Feedback

**Use Case**: Tactile confirmation of actions

```typescript
import * as Haptics from 'expo-haptics';

function UpvoteButton({ onPress }) {
  const handlePress = () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    onPress();
  };

  return <IconButton icon="arrow-up" onPress={handlePress} />;
}
```

**Haptic Events**:

- Upvote/downvote
- Post saved
- New notification
- Pull-to-refresh
- Long-press actions

#### 7. Quick Reply from Notification

**Use Case**: Respond without opening app

```typescript
// iOS: Notification categories with text input
const notificationCategories = [
  {
    identifier: 'COMMENT',
    actions: [
      {
        identifier: 'REPLY',
        title: 'Reply',
        options: ['foreground'],
        textInput: {
          buttonTitle: 'Send',
          placeholder: 'Your reply...'
        }
      },
      {
        identifier: 'VIEW',
        title: 'View',
        options: ['foreground']
      }
    ]
  }
];

// Handle reply
async function handleNotificationResponse(response) {
  if (response.actionIdentifier === 'REPLY') {
    const text = response.userText;
    await submitComment(
      response.notification.request.content.data.postId,
      text
    );
  }
}
```

---

## 🏗️ Technical Architecture

### App Architecture

```
┌─────────────────────────────────────────────────┐
│  REACT NATIVE APP                               │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌─────────────────────────────────┐            │
│  │  UI Layer (React Components)    │            │
│  └────────────┬────────────────────┘            │
│               │                                 │
│  ┌────────────▼────────────────────┐            │
│  │  State Management (Redux)       │            │
│  │  • Auth slice                   │            │
│  │  • Posts slice                  │            │
│  │  • Notifications slice          │            │
│  │  • Offline queue slice          │            │
│  └────────────┬────────────────────┘            │
│               │                                 │
│  ┌────────────▼────────────────────┐            │
│  │  API Layer (RTK Query)          │            │
│  │  • REST endpoints               │            │
│  │  • WebSocket (notifications)    │            │
│  │  • Retry logic                  │            │
│  │  • Cache management             │            │
│  └────────────┬────────────────────┘            │
│               │                                 │
│  ┌────────────▼────────────────────┐            │
│  │  Native Modules                 │            │
│  │  • Biometric auth               │            │
│  │  • Push notifications           │            │
│  │  • Camera                       │            │
│  │  • File system                  │            │
│  └─────────────────────────────────┘            │
│                                                 │
└─────────────────────────────────────────────────┘
                     │
                     │ HTTPS / WSS
                     ▼
┌─────────────────────────────────────────────────┐
│  BACKEND API (Same as Web)                      │
│  • REST API                                     │
│  • WebSocket server (notifications)             │
│  • Authentication (JWT)                         │
│  • Rate limiting                                │
└─────────────────────────────────────────────────┘
```

### API Strategy

**Shared Backend**: Mobile uses same API as web

**Mobile-Specific Endpoints**:

```typescript
// Register device for push notifications
POST /api/v1/mobile/devices
{
  "device_id": "unique-device-id",
  "platform": "ios" | "android",
  "push_token": "fcm-or-apns-token",
  "app_version": "1.0.0",
  "os_version": "iOS 17.0"
}

// Fetch offline content
GET /api/v1/mobile/offline-bundle
Response: {
  "posts": [...], // Top 50 posts
  "user_saved": [...], // User's saved posts
  "user_profile": {...}
}

// Sync offline actions
POST /api/v1/mobile/sync
{
  "actions": [
    { "type": "upvote", "post_id": 123, "timestamp": "..." },
    { "type": "comment", "post_id": 456, "content": "...", "timestamp": "..." }
  ]
}
```

---

## 🚀 Development Roadmap

### Phase 1: MVP (Months 1-3)

**Goal**: Feature parity with web core functionality

**Sprint 1-2 (Setup & Auth)**:

- [ ] Project setup (Expo, TypeScript, navigation)
- [ ] Design system implementation
- [ ] Login / signup screens
- [ ] Biometric authentication
- [ ] Token management

**Sprint 3-4 (Core Features)**:

- [ ] Home feed
- [ ] Post detail view
- [ ] Comments
- [ ] Voting
- [ ] Search

**Sprint 5-6 (Creation & Profile)**:

- [ ] Post creation
- [ ] Image upload
- [ ] User profile
- [ ] Settings
- [ ] Push notifications setup

### Phase 2: Mobile-Specific (Month 4)

**Sprint 7**:

- [ ] Voice-to-text input
- [ ] Offline mode
- [ ] Dark mode
- [ ] Haptic feedback

**Sprint 8**:

- [ ] Camera integration
- [ ] Quick actions
- [ ] Widgets (iOS)
- [ ] Polish & bug fixes

### Phase 3: Beta Testing (Month 5)

**Sprint 9-10**:

- [ ] Closed beta (100 users)
- [ ] Bug fixes from feedback
- [ ] Performance optimization
- [ ] Crash fixes
- [ ] Accessibility improvements

### Phase 4: Launch Prep (Month 6)

**Sprint 11-12**:

- [ ] App Store / Play Store assets
- [ ] Marketing materials
- [ ] Press kit
- [ ] Final QA
- [ ] Soft launch (select regions)

### Phase 5: Public Launch (Month 7)

- [ ] Submit to app stores
- [ ] Marketing campaign
- [ ] PR push
- [ ] Monitor crash reports
- [ ] Rapid iteration

---

## 🎨 User Experience

### Navigation Structure

```
Tab Navigator (Bottom)
├── Home 🏠
│   ├── Feed
│   ├── Post Detail
│   └── Comments
├── Search 🔍
│   ├── Search Results
│   └── Filters
├── Create ➕
│   ├── New Post
│   ├── Take Photo
│   └── Voice Input
├── Notifications 🔔
│   └── Notification List
└── Profile 👤
    ├── My Profile
    ├── Settings
    └── Saved Posts
```

### Key Screens

#### 1. Home Feed

```
┌─────────────────────────────────────┐
│  ☰  Uniting Doctors       🔔  👤   │ ← Header
├─────────────────────────────────────┤
│  [Filter: All | Following | Saved] │ ← Tabs
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐ │
│  │ 👨‍⚕️ Dr. Smith • Cardiology   │ │
│  │                               │ │
│  │ New AFib guidelines 2025     │ │
│  │                               │ │
│  │ Has anyone reviewed the new  │ │
│  │ AFib guidelines from ACC?... │ │
│  │                               │ │
│  │ 🔼 234   💬 45   🔗 Share    │ │
│  └───────────────────────────────┘ │
│  ┌───────────────────────────────┐ │
│  │ 👨‍⚕️ Dr. Johnson • ER         │ │
│  │                               │ │
│  │ COVID variant update          │ │
│  │ ...                           │ │
│  └───────────────────────────────┘ │
│  ...                               │
├─────────────────────────────────────┤
│  🏠  🔍  ➕  🔔  👤               │ ← Bottom Tabs
└─────────────────────────────────────┘
```

#### 2. Post Detail

```
┌─────────────────────────────────────┐
│  ← Back          ...  Share  Save  │
├─────────────────────────────────────┤
│  👨‍⚕️ Dr. Smith • Cardiology        │
│     Verified ✓ • 1,234 reputation  │
│                                     │
│  New AFib guidelines 2025           │
│                                     │
│  Has anyone had a chance to review │
│  the new AFib guidelines? Key      │
│  changes seem to be...             │
│                                     │
│  [Evidence Level: Guidelines]      │
│  📎 ACC Guidelines 2025            │
│                                     │
│  🔼 234  🔽 2  💬 45  🔗 Share     │
├─────────────────────────────────────┤
│  💬 Comments (45)                   │
├─────────────────────────────────────┤
│  👨‍⚕️ Dr. Lee • Cardiology          │
│  Great points. The DOAC...         │
│  🔼 89  Reply                       │
│  ─────────────────────────────────  │
│    👨‍⚕️ Dr. Smith                   │
│    Agreed, though I'm curious...   │
│    🔼 45  Reply                     │
│  ─────────────────────────────────  │
│  ...                                │
└─────────────────────────────────────┘
```

### Gestures

- **Swipe Right**: Upvote
- **Swipe Left**: Save
- **Long Press**: Quick actions menu
- **Pull Down**: Refresh
- **Pinch**: Zoom images

---

## 📡 Offline Capabilities

### Offline Strategy

**Optimistic UI**: Actions appear instant, sync in background

```typescript
// Offline-aware upvote
function useOfflineUpvote() {
  const dispatch = useDispatch();
  const isOnline = useNetInfo().isConnected;

  const upvote = async (postId: number) => {
    // Optimistic update
    dispatch(incrementUpvote(postId));

    if (isOnline) {
      try {
        await api.upvotePost(postId);
      } catch (error) {
        // Rollback on error
        dispatch(decrementUpvote(postId));
        showToast('Upvote failed. Try again.');
      }
    } else {
      // Queue for later
      dispatch(
        queueAction({
          type: 'upvote',
          postId,
          timestamp: Date.now()
        })
      );
      showToast('Saved. Will sync when online.');
    }
  };

  return { upvote };
}
```

### Offline Features

**Available Offline**:

- ✅ Read downloaded posts
- ✅ Read saved posts
- ✅ View user profiles (cached)
- ✅ Upvote/downvote (queued)
- ✅ Comment (queued)
- ✅ Save posts

**Requires Connection**:

- ❌ Search
- ❌ Create post
- ❌ Upload images
- ❌ Real-time notifications

### Sync Strategy

```typescript
// Background sync when connection restored
function useOfflineSync() {
  const queuedActions = useSelector((state) => state.offline.queue);
  const isOnline = useNetInfo().isConnected;

  useEffect(() => {
    if (isOnline && queuedActions.length > 0) {
      syncQueuedActions(queuedActions);
    }
  }, [isOnline, queuedActions]);

  async function syncQueuedActions(actions) {
    for (const action of actions) {
      try {
        await executeAction(action);
        dispatch(removeFromQueue(action.id));
      } catch (error) {
        console.error('Sync failed:', action, error);
        // Keep in queue, retry later
      }
    }
  }
}
```

---

## 🔔 Push Notifications

### Notification Strategy

**Channels**:

1. **Mentions** - Someone mentions you
2. **Replies** - Reply to your post/comment
3. **Upvotes** - Your content gets upvoted (threshold: 10+ upvotes)
4. **Following** - Someone you follow posts
5. **Trending** - Post in your specialty is trending
6. **Announcements** - Platform updates

### Notification Preferences

**Granular Control**:

```typescript
interface NotificationSettings {
  mentions: {
    push: boolean;
    email: boolean;
    frequency: 'immediate' | 'daily_digest';
  };
  replies: {
    push: boolean;
    email: boolean;
    frequency: 'immediate' | 'daily_digest';
  };
  upvotes: {
    push: boolean;
    threshold: number; // e.g., notify after 10 upvotes
  };
  trending: {
    push: boolean;
    specialties: string[]; // Only certain specialties
  };
  quiet_hours: {
    enabled: boolean;
    start: string; // "22:00"
    end: string; // "07:00"
  };
}
```

### Implementation

```typescript
import * as Notifications from 'expo-notifications';
import * as Device from 'expo-device';

// Configure notification handler
Notifications.setNotificationHandler({
  handleNotification: async () => ({
    shouldShowAlert: true,
    shouldPlaySound: true,
    shouldSetBadge: true
  })
});

// Register for push notifications
async function registerForPushNotifications() {
  if (!Device.isDevice) {
    alert('Push notifications require a physical device');
    return;
  }

  const { status: existingStatus } = await Notifications.getPermissionsAsync();
  let finalStatus = existingStatus;

  if (existingStatus !== 'granted') {
    const { status } = await Notifications.requestPermissionsAsync();
    finalStatus = status;
  }

  if (finalStatus !== 'granted') {
    alert('Failed to get push token for notifications!');
    return;
  }

  const token = (await Notifications.getExpoPushTokenAsync()).data;

  // Send to backend
  await api.registerDevice({
    push_token: token,
    platform: Platform.OS,
    device_id: await Device.deviceId
  });

  return token;
}

// Handle notification tap
Notifications.addNotificationResponseReceivedListener((response) => {
  const { screen, params } = response.notification.request.content.data;

  // Navigate to relevant screen
  navigation.navigate(screen, params);
});
```

### Rich Notifications

**iOS**: Images, action buttons
**Android**: Expandable, action buttons

```typescript
// Example notification payload from backend
{
  "to": "ExponentPushToken[...]",
  "sound": "default",
  "title": "Dr. Johnson replied to your post",
  "body": "I agree with your assessment. Have you considered...",
  "data": {
    "screen": "PostDetail",
    "params": { "postId": 123 }
  },
  "categoryIdentifier": "COMMENT",
  "badge": 1
}
```

---

## ⚡ Performance Optimization

### Key Metrics

| Metric                | Target | Measurement            |
| --------------------- | ------ | ---------------------- |
| **App Start Time**    | <2s    | Time to interactive    |
| **Screen Transition** | <200ms | Navigation smoothness  |
| **List Scroll**       | 60 FPS | No jank during scroll  |
| **Image Load**        | <1s    | First contentful paint |
| **API Response**      | <500ms | P95 response time      |
| **Crash-Free Rate**   | >99.5% | Sentry tracking        |

### Optimization Techniques

#### 1. Image Optimization

```typescript
import FastImage from 'react-native-fast-image';

function PostImage({ uri }) {
  return (
    <FastImage
      source={{
        uri,
        priority: FastImage.priority.normal,
        cache: FastImage.cacheControl.immutable,
      }}
      resizeMode={FastImage.resizeMode.cover}
      style={styles.image}
    />
  );
}
```

**Strategy**:

- Use CDN with responsive images
- Lazy load images below fold
- Placeholder with blurhash
- Cache aggressively

#### 2. List Performance

```typescript
import { FlashList } from '@shopify/flash-list';

function Feed({ posts }) {
  const renderPost = useCallback(({ item }) => (
    <PostCard post={item} />
  ), []);

  return (
    <FlashList
      data={posts}
      renderItem={renderPost}
      estimatedItemSize={200}
      // Optimizations
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      updateCellsBatchingPeriod={50}
      windowSize={5}
    />
  );
}
```

**Use FlashList**: 10x faster than FlatList for long lists

#### 3. Code Splitting

```typescript
// Lazy load heavy screens
const ProfileScreen = lazy(() => import('./screens/ProfileScreen'));
const SearchScreen = lazy(() => import('./screens/SearchScreen'));

// Use Suspense
function App() {
  return (
    <Suspense fallback={<LoadingScreen />}>
      <Navigator />
    </Suspense>
  );
}
```

#### 4. Bundle Size

**Target**: <15MB initial download

**Techniques**:

- Tree-shaking unused code
- Compress images
- Use vector icons
- Lazy load non-critical features
- Hermes engine (faster startup)

---

## 📱 App Store Optimization

### App Store Listing (iOS)

**Name**: Uniting Doctors - Medical Community

**Subtitle**: Connect with Physicians Worldwide

**Description**:

```
Join 10,000+ verified medical professionals in the largest peer-to-peer
medical community.

• Ask clinical questions and get expert answers
• Discuss cases with specialists worldwide
• Stay updated on medical news and guidelines
• Access evidence-based discussions
• Connect with doctors in your specialty

FEATURES:
✓ Verified medical professionals only
✓ Evidence-based discussions
✓ PubMed integration
✓ Specialty-specific communities
✓ HIPAA-compliant platform
✓ CME opportunities

Perfect for:
- Residents seeking peer advice
- Attending physicians staying current
- Specialists sharing expertise
- Medical students learning from real cases

Download now and join the conversation!
```

**Keywords** (iOS):
doctors, medical community, physician network, clinical questions,
medical education, CME, residency, healthcare professionals,
medical cases, peer consultation

**Screenshots** (10 required):

1. Home feed (diverse medical discussions)
2. Post detail (high-quality medical discussion)
3. Create post (voice-to-text feature)
4. Search (finding specific topics)
5. Profile (verified doctor profile)
6. Specialty groups
7. Notifications
8. Saved posts
9. Dark mode
10. Testimonial overlay

### Play Store Listing (Android)

Similar content, optimized for Android users.

**Short Description** (80 chars):
Connect with verified doctors. Ask questions. Share knowledge. Join free.

**Category**: Medical

**Content Rating**: PEGI 3 (All ages, but target is professionals)

---

## 🧪 Beta & Launch

### Beta Testing Strategy

#### Closed Beta (Month 5)

**Platform**: TestFlight (iOS) + Internal Testing (Android)

**Participants**: 100 selected beta users from web platform

**Duration**: 3 weeks

**Focus**:

- Core functionality
- Performance
- Crashes
- UX feedback

**Feedback Collection**:

- In-app feedback widget
- Weekly surveys
- Crash reports (Sentry)
- Analytics (Mixpanel)

#### Open Beta (Month 6)

**Platform**: TestFlight (iOS) + Open Testing (Android)

**Participants**: 1,000+ from waitlist

**Duration**: 2 weeks

**Focus**:

- Scale testing
- Edge cases
- Final UX polish
- App store readiness

### Launch Plan

**Soft Launch** (Week 1):

- Select English-speaking countries
- Monitor metrics closely
- Fix critical issues

**Global Launch** (Week 2):

- All countries
- Marketing campaign begins
- PR push
- Product Hunt launch

**Post-Launch** (Week 3-4):

- Monitor crash reports
- Rapid bug fixes
- Gather user feedback
- Plan v1.1 features

---

## 📊 Analytics & Metrics

### Key Metrics

**Acquisition**:

- App Store impressions
- App Store conversions
- Install sources
- Cost per install (if paid ads)

**Activation**:

- Registration completion rate
- Verification rate
- First post rate
- Day 1 retention

**Engagement**:

- Daily Active Users (DAU)
- Session length
- Sessions per user
- Features used
- Content created

**Retention**:

- Day 1, 7, 30 retention
- Churn rate
- Reactivation rate

**Platform Split**:

- iOS vs Android usage
- Mobile vs web usage
- Feature usage by platform

### Analytics Implementation

```typescript
import mixpanel from 'mixpanel-react-native';

// Track events
function trackEvent(eventName: string, properties?: object) {
  mixpanel.track(eventName, {
    platform: Platform.OS,
    app_version: Constants.manifest.version,
    ...properties
  });
}

// Track screens
function useScreenTracking() {
  const navigation = useNavigation();

  useEffect(() => {
    const unsubscribe = navigation.addListener('state', () => {
      const currentScreen = navigation.getCurrentRoute().name;
      mixpanel.track('Screen View', { screen: currentScreen });
    });

    return unsubscribe;
  }, [navigation]);
}

// Example usage
function PostDetailScreen({ post }) {
  useEffect(() => {
    trackEvent('Post Viewed', {
      post_id: post.id,
      specialty: post.specialty,
      evidence_level: post.evidence_level
    });
  }, [post]);

  const handleUpvote = () => {
    trackEvent('Post Upvoted', { post_id: post.id });
    upvotePost(post.id);
  };

  // ...
}
```

---

## 📞 Resources & Contacts

**Mobile Development Team**:

- Mobile Lead: [TBD]
- iOS Developer: [TBD]
- Android Developer: [TBD]

**Tools**:

- Code: GitHub (uniting-doctors-mobile repo)
- Design: Figma (Mobile App Designs)
- Project Management: Linear
- CI/CD: EAS Build & Submit

**Documentation**:

- React Native Docs: https://reactnative.dev
- Expo Docs: https://docs.expo.dev
- API Docs: [Internal]

---

**Document Version**: 1.0
**Last Updated**: November 9, 2025
**Next Review**: Q1 2026 (before development starts)

**Related Documents**:

- [IMPLEMENTATION_ROADMAP.md](../technical/IMPLEMENTATION_ROADMAP.md)
- [API_SPECIFICATION.md](../technical/API_SPECIFICATION.md)
- [USER_FEEDBACK_STRATEGY.md](../operations/USER_FEEDBACK_STRATEGY.md)
- [LAUNCH_CHECKLIST.md](../operations/LAUNCH_CHECKLIST.md)
