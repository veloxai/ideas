# UNITING DOCTORS - PLATFORM SPECIFICATIONS

**Last Updated**: November 8, 2025

---

## 📋 MVP Features (Phase 1: Months 1-6)

### Core User Features

#### 1. User Registration & Verification
- Email/OAuth registration (via Velox.ai auth)
- Profile creation (name, specialty, credentials, bio)
- Medical license verification (upload documents)
- Identity verification (government ID)
- Verification badge upon approval
- Multi-step onboarding flow

#### 2. User Profile
- Display name, username, bio
- Specialty and sub-specialty
- Credentials and certifications
- Verification status badge
- Reputation score (visible to user)
- Privacy settings
- Anonymous posting preferences

#### 3. Post Creation & Interaction
- **Post Types**: Text, image, link, question
- **Rich Text Editor**: Formatting, mentions, hashtags
- **Media Upload**: Images (max 10 per post), documents (PDF)
- **Tags**: Specialty tags, topic tags
- **Anonymous Option**: Toggle for anonymous posting
- **Group Posting**: Post to specific groups
- **Citation Attach**: Add research citations
- **Engagement**: Like, comment, share, save
- **Edit/Delete**: Within 24 hours

#### 4. Feed Algorithm
- **Home Feed**: Posts from followed users and groups
- **Trending Feed**: Popular posts across platform
- **Specialty Feed**: Posts in user's specialty
- **Group Feeds**: Posts in joined groups
- **Sorting**: Recent, popular, trending
- **Infinite Scroll**: Load more on scroll

#### 5. Comments
- Nested comments (2 levels)
- Like comments
- Anonymous commenting
- Rich text formatting
- Citations

#### 6. Groups
- **Browse Groups**: By specialty, topic, disease
- **Join/Leave**: Public groups (instant), private (request)
- **Group Feed**: Posts specific to group
- **Member List**: View group members
- **Create Group**: Professional tier feature
- **10 Initial Groups**: Cardiology, Pulmonology, Oncology, Neurology, Pediatrics, Emergency Medicine, Rare Diseases, AATD, Research, General Discussion

#### 7. Direct Messaging
- One-on-one messaging
- Message history
- Read receipts
- Typing indicators (Phase 2)
- File sharing (Phase 2)
- Encrypted (Phase 2)

#### 8. Search
- Search users by name, specialty
- Search posts by keywords
- Search groups by name
- Basic filters (specialty, date)

#### 9. Notifications
- In-app notifications (bell icon)
- Email notifications (configurable)
- Notification types: Likes, comments, follows, messages, group invites

#### 10. Mobile-Responsive Web App
- Fully responsive design
- PWA capabilities (Phase 2)
- Mobile-optimized UI

---

## 🚀 Phase 2 Features (Months 7-12)

### Research Integration
- **PubMed Feed**: Auto-aggregated research by specialty
- **Research Library**: Save and organize papers
- **Citation Manager**: Export to Zotero, Mendeley
- **Research Discussions**: Comment on papers
- **Research Alerts**: Notifications for new research

### Advanced Social Features
- **Poll Posts**: Create polls for community input
- **Event Posts**: Share conferences, webinars
- **Video Posts**: Upload short videos (max 5 min)
- **Story Feature**: 24-hour ephemeral posts
- **Bookmarks/Collections**: Organize saved content

### Off-Label Medication Database
- Browse medications with off-label uses
- Add experiences and outcomes
- Rate and comment on experiences
- Search by medication or condition
- Evidence level indicators
- Discussion threads per medication/use

### Professional Tier Launch
- Unlimited anonymous posts
- Advanced search filters
- Personal analytics
- Priority support
- Custom profile themes
- Download content

### Enhanced Moderation
- AI-assisted content moderation
- Community reporting
- Moderator dashboard
- Flagged content review
- Automated spam detection

---

## 🎯 Phase 3 Features (Year 2)

### Mobile Apps
- Native iOS app (React Native)
- Native Android app (React Native)
- Push notifications
- Offline mode
- App-specific features

### CME/CE Integration
- Partner with CME providers
- Earn credits for engagement
- Track CME hours
- Certificate generation

### Advanced Analytics
- User content analytics (views, engagement)
- Audience demographics
- Trending topics
- Personal impact metrics

### Institutional Features
- Team accounts
- Institutional branding
- Admin dashboards
- Usage analytics
- Custom integrations
- SSO (Single Sign-On)

### Job Board Launch
- Post jobs (free tier: 1/year, paid: unlimited)
- Browse jobs by specialty, location
- Apply to jobs
- Track applications
- Recruiter tools

### Video Features
- Live streaming (AMAs, lectures)
- Video calls (1-on-1, group)
- Webinar hosting

---

## 📱 User Flows

### New User Onboarding
1. Land on homepage
2. Click "Join Uniting Doctors"
3. Sign up with email or OAuth (Google, LinkedIn)
4. Create profile (name, username, specialty)
5. Upload verification documents
6. Wait for verification (1-3 business days)
7. Browse as unverified (limited access)
8. Get verified → Full access unlocked
9. Follow suggested users and groups
10. Create first post

### Posting Flow
1. Click "Create Post" button
2. Select post type (text, question, link, image)
3. Write content in rich text editor
4. Add tags (specialty, topics)
5. Toggle anonymous (if desired)
6. Add citations (optional)
7. Select group to post in (optional)
8. Preview post
9. Click "Post"
10. View post in feed

### Anonymous Posting Flow
1. Toggle "Post Anonymously" before posting
2. Confirm anonymity preference
3. Post is published without user attribution
4. Reputation points still attributed to user account (backend)
5. User can view their anonymous posts in their profile (only they can see)

---

## 🎨 Design System

### Color Palette
- **Primary**: Medical blue (#0066CC)
- **Secondary**: Teal (#00A896)
- **Accent**: Warm orange (#FF6B35) - for AATD/rare disease content
- **Neutral**: Grays (#F8F9FA, #E9ECEF, #6C757D, #343A40)
- **Success**: Green (#28A745)
- **Warning**: Yellow (#FFC107)
- **Error**: Red (#DC3545)

### Typography
- **Headings**: Inter or DM Sans (bold, clear)
- **Body**: Inter or system fonts (readable, accessible)
- **Code/Medical Terms**: Monospace (when needed)

### Components (shadcn/ui)
- Buttons, inputs, cards, modals, dropdowns
- Toast notifications
- Loading skeletons
- Empty states
- Error states

---

## 🔒 Privacy & Security Features

### User Privacy Controls
- **Profile Privacy**: Public, private, or connections-only
- **Post Privacy**: Public, group-only, or followers-only
- **Anonymous Settings**: Default to anonymous or not
- **Search Visibility**: Opt out of search indexing
- **Data Export**: Download all user data
- **Account Deletion**: Permanently delete account and data

### Anonymity System
- **True Anonymity**: Posts don't reveal user identity to anyone (except admins in case of violations)
- **Reputation Attribution**: Backend tracks reputation without frontend exposure
- **User Dashboard**: Users can see their own anonymous posts
- **Moderation**: Admins can trace anonymous posts if necessary (logged and audited)

### Content Moderation
- **AI Pre-Screening**: Automatically flag inappropriate content
- **Community Reports**: Users can report posts/comments
- **Moderator Review**: Human review of flagged content
- **Appeals Process**: Users can appeal moderation decisions
- **Transparency**: Public moderation guidelines

---

## 📊 Analytics & Metrics

### User Metrics
- Profile views
- Post impressions
- Engagement rate
- Follower growth
- Reputation score
- Content saves

### Platform Metrics
- DAU/MAU
- Posts per day
- Comments per post
- Average session time
- Retention rates
- Conversion rates (free to paid)

---

## 🌐 Internationalization (Phase 4)

### Language Support
- English (default)
- Spanish
- German
- French
- Mandarin (future)

### Regional Features
- Local news feeds
- Regional groups
- Time zone support
- Currency localization (for paid features)

---

**Next Steps**:
1. Create detailed wireframes
2. Build design system in Figma
3. Prioritize features for MVP
4. Create technical task breakdown
