# Virtual Event Platform Guide

**Mark Egly Foundation**
**Document Version:** 1.0
**Effective Date:** November 10, 2025
**Document Owner:** Director of Communications & Events
**Review Cycle:** Annually (or after major platform changes)
**Related Documents:**

- Event Safety & Risk Management
- Social Media Policy
- HIPAA Implementation Playbook
- Cybersecurity Program

---

## Table of Contents

1. [Philosophy & Overview](#philosophy--overview)
2. [Platform Selection Criteria](#platform-selection-criteria)
3. [Platform Comparison Matrix](#platform-comparison-matrix)
4. [Technical Setup & Testing](#technical-setup--testing)
5. [Registration System Integration](#registration-system-integration)
6. [Engagement Features & Best Practices](#engagement-features--best-practices)
7. [Accessibility Requirements](#accessibility-requirements)
8. [Data Privacy & HIPAA Compliance](#data-privacy--hipaa-compliance)
9. [Technical Support During Events](#technical-support-during-events)
10. [Presenter & Moderator Training](#presenter--moderator-training)
11. [Virtual Exhibit Hall & Sponsor Integration](#virtual-exhibit-hall--sponsor-integration)
12. [Recording Policies & Content Distribution](#recording-policies--content-distribution)
13. [Analytics & Performance Tracking](#analytics--performance-tracking)
14. [Budget & Cost Management](#budget--cost-management)
15. [Platform-Specific Guides](#platform-specific-guides)
16. [Troubleshooting & Contingency Planning](#troubleshooting--contingency-planning)
17. [Conclusion & Continuous Improvement](#conclusion--continuous-improvement)

---

## Philosophy & Overview

### Purpose

This Virtual Event Platform Guide provides comprehensive guidance for selecting, implementing, and managing virtual event platforms for the Mark Egly Foundation. Virtual events are a critical component of our outreach strategy, enabling us to:

- **Expand Geographic Reach**: Connect with AATD patients, caregivers, and medical professionals nationwide
- **Increase Accessibility**: Remove travel barriers for patients with respiratory limitations
- **Reduce Costs**: Eliminate venue, catering, and travel expenses
- **Improve Safety**: Protect immunocompromised patients during public health concerns
- **Enhance Engagement**: Leverage interactive features for deeper participation
- **Scale Education**: Deliver CME courses and training to larger audiences
- **Build Community**: Foster connections among geographically dispersed stakeholders

### Guiding Principles

**Patient-Centered Design**

- Prioritize ease of use for patients with varying technical proficiency
- Ensure accessibility for those with disabilities or health limitations
- Provide multiple support channels for technical assistance

**Privacy & Security First**

- Protect patient health information (PHI) under HIPAA regulations
- Implement robust data security measures
- Obtain proper consents for recording and data collection

**Professional Quality**

- Maintain high production standards that reflect organizational credibility
- Deliver seamless, glitch-free experiences
- Provide clear, timely communications

**Inclusive & Accessible**

- Meet ADA compliance standards (WCAG 2.1 AA minimum)
- Offer live captioning, ASL interpretation, and screen reader compatibility
- Design for various devices, bandwidths, and technical environments

**Measurable Impact**

- Track attendance, engagement, and satisfaction metrics
- Evaluate learning outcomes for educational programs
- Use data to continuously improve future events

### Virtual Event Types

The Foundation hosts several types of virtual events, each with unique platform requirements:

1. **Patient Education Webinars** (50-200 attendees)
   - Monthly educational sessions on living with AATD
   - Guest speakers (pulmonologists, genetic counselors, patients)
   - Q&A sessions with medical experts

2. **Support Group Meetings** (10-30 attendees)
   - Small, intimate peer support sessions
   - Breakout rooms for regional or demographic groups
   - Emphasis on privacy and psychological safety

3. **Medical Professional CME Courses** (100-500 attendees)
   - Continuing Medical Education (CME) accredited training
   - Interactive case studies and polling
   - Certification tracking and documentation

4. **Annual Virtual Conference** (300-1,000 attendees)
   - Multi-day, multi-track programming
   - Keynote speakers, breakout sessions, workshops
   - Virtual exhibit hall with sponsors and vendors
   - Networking lounges and social events

5. **Research Symposia** (50-150 attendees)
   - Scientific presentations and poster sessions
   - Academic audience (researchers, clinicians, students)
   - Publication-quality recordings

6. **Advocacy Training & Campaign Launches** (50-200 attendees)
   - Grassroots advocacy skill-building
   - Legislative updates and action alerts
   - Storytelling and message development

7. **Fundraising Galas** (100-500 attendees)
   - Virtual auctions and pledge drives
   - Entertainment and patient stories
   - Integration with payment processing systems

---

## Platform Selection Criteria

### Essential Requirements

When evaluating virtual event platforms, the following are **non-negotiable** requirements:

#### 1. HIPAA Compliance & Security

- **Business Associate Agreement (BAA)**: Platform must sign HIPAA BAA
- **Encryption**: End-to-end encryption for all data in transit and at rest
- **Access Controls**: Role-based permissions, multi-factor authentication
- **Data Residency**: Data storage in HIPAA-compliant facilities (US-based preferred)
- **Audit Logs**: Comprehensive logging of all access and activities
- **Breach Notification**: Clear procedures for security incident reporting

#### 2. Accessibility Features (ADA Compliance)

- **WCAG 2.1 AA Compliance**: Minimum standard for web accessibility
- **Screen Reader Compatible**: Full functionality with JAWS, NVDA, VoiceOver
- **Keyboard Navigation**: All features accessible without a mouse
- **Live Captioning**: Real-time closed captioning (human or high-quality AI)
- **ASL Interpretation**: Video window for sign language interpreters
- **Adjustable Text Size**: User-controlled font sizing
- **High Contrast Modes**: Support for visual impairments
- **Audio Descriptions**: For visual content when applicable

#### 3. Core Functionality

- **Video & Audio Quality**: HD video (1080p preferred, 720p minimum)
- **Reliability**: 99.9%+ uptime SLA
- **Scalability**: Support for largest anticipated audience (1,000+ attendees)
- **Cross-Platform**: Works on Windows, Mac, iOS, Android, Linux
- **Browser-Based**: No mandatory downloads (optional apps okay)
- **Low Bandwidth Mode**: Functional at 1-2 Mbps connections
- **Mobile Optimization**: Full-featured mobile experience

#### 4. Engagement Tools

- **Live Q&A**: Moderated question submission and upvoting
- **Polling & Surveys**: Real-time polls with instant result display
- **Chat**: Public chat, private messages, and moderated Q&A
- **Breakout Rooms**: Small group discussions (audio/video)
- **Reactions & Emojis**: Non-verbal feedback (clapping, thumbs up, etc.)
- **Networking Features**: 1-on-1 or small group video matching

#### 5. Administrative Controls

- **Registration Management**: Custom registration forms with conditional logic
- **Waiting Rooms**: Pre-event holding areas with branding
- **Co-Host/Panelist Roles**: Differentiated permissions for speakers and moderators
- **Recording Controls**: Ability to record, pause, and download sessions
- **Content Moderation**: Tools to remove disruptive participants
- **Reporting**: Attendance tracking, engagement metrics, survey results

### Evaluation Matrix Scoring

Score each platform on a 1-5 scale for each criterion:

| Criterion                | Weight | Zoom Events | Hopin   | Whova   | Microsoft Teams | Webex Events |
| ------------------------ | ------ | ----------- | ------- | ------- | --------------- | ------------ |
| HIPAA Compliance         | 10     | 5           | 4       | 3       | 5               | 5            |
| Accessibility            | 10     | 4           | 3       | 3       | 4               | 4            |
| Ease of Use (Attendees)  | 8      | 5           | 3       | 4       | 4               | 3            |
| Ease of Use (Admins)     | 6      | 4           | 3       | 4       | 4               | 3            |
| Engagement Tools         | 7      | 4           | 5       | 4       | 3               | 4            |
| Reliability              | 9      | 5           | 4       | 4       | 5               | 4            |
| Video/Audio Quality      | 8      | 5           | 4       | 3       | 4               | 4            |
| Scalability              | 7      | 5           | 5       | 4       | 5               | 5            |
| Registration Integration | 5      | 4           | 4       | 5       | 3               | 3            |
| Analytics & Reporting    | 6      | 4           | 5       | 4       | 3               | 4            |
| Technical Support        | 7      | 5           | 4       | 4       | 4               | 4            |
| Cost                     | 5      | 4           | 3       | 4       | 4               | 3            |
| **Weighted Total**       |        | **418**     | **362** | **358** | **382**         | **368**      |

_Scores are illustrative examples. Conduct your own evaluation based on current platform capabilities._

---

## Platform Comparison Matrix

### Recommended Platforms by Event Type

| Event Type                 | Primary Recommendation | Alternative     | Rationale                                                       |
| -------------------------- | ---------------------- | --------------- | --------------------------------------------------------------- |
| Patient Education Webinars | Zoom Webinars          | Microsoft Teams | Familiar interface, excellent reliability, strong accessibility |
| Support Groups             | Zoom Meetings          | Google Meet     | Intimate setting, breakout rooms, ease of use                   |
| CME Courses                | Zoom Events            | Webex Events    | Polling, Q&A, certification tracking, recording quality         |
| Annual Conference          | Hopin                  | Zoom Events     | Multi-track, virtual expo, networking, scalability              |
| Research Symposia          | Zoom Webinars          | Webex Events    | Recording quality, screen sharing, professional appearance      |
| Advocacy Training          | Zoom Events            | Microsoft Teams | Interactive tools, breakout rooms, accessibility                |
| Fundraising Galas          | Hopin                  | Zoom Events     | Auction integration, entertainment features, payment processing |

### Platform-Specific Strengths & Weaknesses

#### Zoom (Meetings, Webinars, Events)

**Strengths:**

- **Ubiquity**: Most familiar platform; low barrier to entry for attendees
- **Reliability**: Industry-leading uptime (99.99% SLA)
- **HIPAA Compliance**: BAA available; widely used in healthcare
- **Accessibility**: Strong screen reader support, live captioning (human and AI)
- **Video Quality**: Excellent HD video, stable connections even on lower bandwidth
- **Breakout Rooms**: Easy moderator assignment and rotation
- **Recordings**: Cloud and local recording options with automatic transcription
- **Cost-Effective**: Competitive pricing for basic and webinar licenses

**Weaknesses:**

- **Limited Networking**: Weaker 1-on-1 networking features compared to specialized platforms
- **No Native Expo Hall**: Requires workarounds for virtual exhibits
- **Basic Branding**: Limited customization of interface beyond logos
- **Session Switching**: Attendees must leave one meeting to join another (for multi-track events)

**Best For:** Patient webinars, support groups, CME courses, small-to-medium events (<500 attendees)

**Pricing:**

- Basic: Free (40-minute limit)
- Pro: $15.99/month/host (up to 100 participants, no time limit)
- Webinar Add-on: $79-$3,400/month (depending on capacity: 100-50,000 attendees)
- Zoom Events: $1,490/year (500 attendees), $2,900/year (1,000 attendees)

#### Hopin

**Strengths:**

- **All-in-One Conference Platform**: Multi-track stages, expo hall, networking lounges
- **Networking Features**: 1-on-1 video matching, virtual tables, speed networking
- **Virtual Expo**: Dedicated booths for sponsors with video, chat, downloads
- **Event Management**: Comprehensive registration, ticketing, and analytics
- **Branding**: Highly customizable interface and attendee experience
- **Engagement**: Gamification, leaderboards, and social features

**Weaknesses:**

- **Learning Curve**: More complex for first-time organizers and attendees
- **Cost**: Higher pricing tier for full features
- **HIPAA Compliance**: Requires enterprise plan and custom BAA negotiation
- **Reliability**: Occasional performance issues during peak usage
- **Technical Requirements**: Higher bandwidth needs for full experience

**Best For:** Annual conferences, multi-day events, large fundraisers with sponsors

**Pricing:**

- Starter: $99/month (100 registrations/month)
- Growth: $799/month (1,000 registrations/month)
- Business: Custom pricing (enterprise features, HIPAA BAA)

#### Whova

**Strengths:**

- **Conference Management**: Agenda building, speaker management, attendee engagement
- **Mobile App**: Excellent native mobile apps (iOS/Android)
- **Networking**: Community board, topic-based discussions, attendee profiles
- **Sponsor Features**: Virtual booths, lead retrieval, analytics for sponsors
- **Registration**: Robust registration with ticketing and payment processing
- **Engagement Tools**: Live polling, Q&A, surveys, gamification

**Weaknesses:**

- **HIPAA Compliance**: Not explicitly HIPAA-compliant; requires careful configuration
- **Video Quality**: Relies on Zoom integration for video (not native)
- **Accessibility**: Accessibility features less robust than Zoom or Microsoft
- **Setup Complexity**: Requires significant pre-event configuration

**Best For:** Conferences with strong networking emphasis, events requiring mobile app

**Pricing:**

- Virtual Event: $1,000-$5,000+ per event (depending on attendees and features)
- In-Person + Virtual: Custom pricing

#### Microsoft Teams Live Events

**Strengths:**

- **Enterprise Integration**: Seamless with Microsoft 365 ecosystem
- **HIPAA Compliance**: BAA included with Microsoft 365 Healthcare plans
- **Security**: Advanced security features, conditional access, DLP
- **Scalability**: Supports up to 10,000 live attendees, 100,000 on-demand
- **Accessibility**: Excellent accessibility features, live captions, immersive reader
- **Cost**: Included with many existing Microsoft licenses (minimal additional cost)

**Weaknesses:**

- **Limited Interactivity**: More broadcast-focused; less interactive than Zoom
- **No Breakout Rooms**: Limited small-group discussion options
- **Production Complexity**: Requires producer role for professional broadcasts
- **Attendee Experience**: Less intuitive interface for non-Microsoft users

**Best For:** Organizations already using Microsoft 365, large broadcast-style webinars

**Pricing:**

- Included with Microsoft 365 E3/E5, Business Premium
- Microsoft 365 standalone: $12.50-$35/user/month

#### Webex Events (formerly Socio)

**Strengths:**

- **Enterprise-Grade**: Cisco infrastructure, excellent security and reliability
- **HIPAA Compliance**: BAA available, widely used in healthcare
- **Conference Features**: Multi-track stages, breakout sessions, expo hall
- **Integration**: Strong integrations with CRM, marketing automation, registration platforms
- **Broadcasting**: Professional-grade live streaming to YouTube, Facebook, etc.
- **Analytics**: Detailed reporting and ROI metrics

**Weaknesses:**

- **Cost**: Premium pricing compared to Zoom
- **User Experience**: Interface less intuitive than Zoom
- **Market Share**: Smaller user base; attendees less familiar
- **Mobile Experience**: Mobile apps less polished than Zoom

**Best For:** Enterprise organizations, events requiring advanced security/compliance

**Pricing:**

- Webex Meetings: $13.50-$26.95/host/month
- Webex Events: Custom pricing (typically $5,000-$25,000 per event)

---

## Technical Setup & Testing

### Pre-Event Technical Checklist (4-6 Weeks Before)

#### Platform Account Configuration

- [ ] Sign HIPAA Business Associate Agreement (BAA)
- [ ] Configure SSO/MFA for administrative accounts
- [ ] Set up role-based access controls (organizers, moderators, speakers)
- [ ] Establish branding (logos, colors, backgrounds)
- [ ] Configure waiting room with branded messaging
- [ ] Set up automated email templates (confirmation, reminders, thank you)
- [ ] Integrate registration system (see Section 5)
- [ ] Test payment processing (if applicable)
- [ ] Configure analytics tracking and reporting

#### Equipment & Software Verification

- [ ] **Primary Production Computer**: High-performance laptop/desktop
  - Minimum: Intel i7 or equivalent, 16GB RAM, 20Mbps upload speed
  - Operating system updated to latest version
  - Platform software/app updated to latest version
  - Antivirus/firewall configured to allow platform
- [ ] **Backup Production Computer**: Secondary device fully configured
- [ ] **Video Cameras**: External webcams (1080p minimum) with tripod mounts
- [ ] **Audio Equipment**:
  - USB microphones with pop filters (Blue Yeti, Audio-Technica, Shure)
  - Headsets for moderators and tech support
  - Audio mixer (if multiple sources)
- [ ] **Lighting**: Ring lights or softbox lighting for presenters
- [ ] **Internet Connection**:
  - Primary: Wired ethernet (50+ Mbps upload)
  - Backup: Mobile hotspot or secondary ISP
- [ ] **Software**:
  - OBS Studio (for advanced production)
  - Teleprompter software (if scripted remarks)
  - Lower-thirds graphics templates
  - Presentation software (PowerPoint, Keynote, Google Slides)

#### Accessibility Services Coordination

- [ ] **Live Captioning Service**:
  - Book professional CART (Communication Access Realtime Translation) provider
  - Alternatives: Zoom Auto-Captions, Rev Live Captions ($1.50-$2/minute)
  - Provide script/agenda to captioner 48 hours in advance
  - Test caption display in platform
- [ ] **ASL Interpretation**:
  - Contract certified ASL interpreters (minimum 2 for shifts)
  - Provide materials and speaker notes 1 week in advance
  - Configure spotlight/pin video for interpreter visibility
  - Test interpreter video feed quality
- [ ] **Accessibility Testing**:
  - Test with screen reader (NVDA, JAWS)
  - Verify keyboard-only navigation
  - Check color contrast ratios (4.5:1 minimum)
  - Test on mobile devices

### Rehearsals & Run-Throughs

#### Tech Rehearsal Timeline

- **4 weeks before**: Platform setup complete, initial tech check
- **2 weeks before**: Full tech rehearsal with all speakers
- **1 week before**: Final run-through with full production team
- **Day before**: Quick connectivity check with key participants
- **1 hour before**: Final systems check and contingency review

#### Speaker/Moderator Tech Rehearsal (90 minutes)

**Agenda:**

1. **Login & Platform Orientation** (15 min)
   - How to join as panelist/speaker
   - Interface overview (mute, camera, share screen, reactions)
   - Chat vs. Q&A functionality
   - Breakout room mechanics (if applicable)

2. **Audio/Video Quality Check** (20 min)
   - Microphone level and clarity test
   - Camera framing, lighting, and background check
   - Eliminate echo and background noise
   - Test screenshare and presentation mode
   - Verify slide animations and embedded videos work

3. **Content Run-Through** (30 min)
   - Present first 3-5 slides to check flow
   - Practice transitions between speakers
   - Test polling, Q&A, and interactive elements
   - Verify co-host can manage attendee questions
   - Practice handing off screen share

4. **Contingency & Troubleshooting** (15 min)
   - Backup plan if speaker loses connection
   - How to rejoin quickly
   - Using backup device (phone) if computer fails
   - How to signal tech support for help

5. **Q&A & Final Questions** (10 min)

**Rehearsal Checklist for Each Speaker:**

- [ ] Logged in successfully as panelist/speaker
- [ ] Audio clear, no echo or background noise
- [ ] Video quality HD, proper lighting and framing
- [ ] Presentation slides load and display correctly
- [ ] Screenshare works without lag
- [ ] Understands mute/unmute protocol
- [ ] Knows how to respond to Q&A questions
- [ ] Has backup phone number for emergency contact
- [ ] Received event timeline and run-of-show document

### Network & Bandwidth Testing

#### Minimum Bandwidth Requirements

- **Speakers/Panelists**:
  - Upload: 5 Mbps (HD video + screen share)
  - Download: 3 Mbps
  - Wired connection strongly recommended
- **Moderators/Tech Support**:
  - Upload: 10 Mbps (monitoring multiple feeds)
  - Download: 5 Mbps
- **Attendees**:
  - Download: 2 Mbps (standard video quality)
  - 1 Mbps (low-bandwidth mode)

#### Network Testing Tools

- **Speedtest.net**: Measure upload/download speeds
- **PingPlotter**: Identify network stability and packet loss
- **Platform Built-in Tests**:
  - Zoom: zoom.us/test
  - Microsoft Teams: Connectivity test in settings
  - Webex: webex.com/test-meeting.html

#### Optimizing Connection Quality

1. **Use wired ethernet** instead of Wi-Fi whenever possible
2. **Close unnecessary applications** and browser tabs
3. **Disable automatic updates** during event time
4. **Pause cloud backups** (Dropbox, Google Drive, etc.)
5. **QoS Settings**: Prioritize video conferencing traffic on router
6. **Backup Internet**: Have mobile hotspot ready as failover

### Event Day Technical Setup (2 Hours Before)

#### Production Team Stations

1. **Event Host/Moderator**:
   - Primary production computer
   - Headset with microphone
   - Second monitor for monitoring chat/Q&A
   - Printed run-of-show and speaker notes

2. **Technical Director**:
   - Control laptop for platform administration
   - Monitoring dashboard (attendance, connection quality)
   - Backup slides and media files
   - Troubleshooting toolkit (see below)

3. **Chat/Q&A Moderator**:
   - Laptop or tablet for managing audience questions
   - List of FAQs and pre-approved responses
   - Contact info for speakers to relay questions

4. **Accessibility Coordinator** (for large events):
   - Monitor caption quality
   - Field accessibility accommodation requests
   - Coordinate with ASL interpreters

#### Systems Check Procedure (30 min before start)

- [ ] Log into platform as host/co-host
- [ ] Verify recording settings enabled
- [ ] Check waiting room functionality
- [ ] Test audio output to attendees
- [ ] Confirm live captioning service connected
- [ ] Verify ASL interpreter video feed
- [ ] Load and test all presentation slides
- [ ] Test polling questions
- [ ] Confirm sponsor logos/ads displaying (if applicable)
- [ ] Review contingency plan with production team
- [ ] Open technical support Slack/Teams channel

### Troubleshooting Toolkit

#### Common Issues & Solutions

**Problem: Speaker cannot hear audio**

- Solution: Check speaker output device selection in platform settings
- Check computer volume and mute status
- Test with different headset/speakers
- Have speaker rejoin session

**Problem: Speaker audio is echoey or has feedback**

- Solution: Mute all but one audio source
- Use headset instead of computer speakers
- Move microphone away from speakers
- Check for multiple devices connected to meeting

**Problem: Video is frozen or laggy**

- Solution: Turn off HD video in settings
- Close screen share temporarily
- Disable virtual background
- Switch to audio-only if necessary
- Rejoin with better internet connection

**Problem: Screen share not displaying correctly**

- Solution: Stop and restart screen share
- Share specific application window instead of entire screen
- Check that "Optimize for video clip" is unchecked for slides
- Verify attendees have "request remote control" disabled

**Problem: Platform crashes or freezes**

- Solution: Have backup host take over immediately
- Restart platform software and rejoin
- Switch to backup computer
- If persistent: move to backup platform (communicate via email/social)

**Problem: Too many attendees for capacity**

- Solution: Upgrade license in real-time (if possible)
- Enable livestream to YouTube/Facebook as overflow
- Record and send link to those unable to join

**Emergency Contact Numbers**

- Platform Technical Support Hotline: [Insert 24/7 number]
- IT Support Team Lead: [Insert mobile number]
- Executive Director: [Insert mobile number]
- Captioning Service: [Insert emergency contact]
- ASL Interpreter: [Insert mobile number]

---

## Registration System Integration

### Registration Platform Options

#### Integrated Platform Registration

Many virtual event platforms include built-in registration:

- **Zoom Events**: Native registration with custom forms
- **Hopin**: Comprehensive ticketing and registration
- **Webex Events**: Full registration and badge printing

**Pros:**

- Single platform reduces complexity
- Automatic attendee sync
- Simplified reporting

**Cons:**

- Less flexibility in form design
- Limited marketing automation integration
- May require upgrading to higher-tier platform plan

#### Third-Party Registration Platforms

Specialized event registration systems with virtual event integration:

**Eventbrite**

- Wide adoption, attendee trust
- Free for free events; 3.5% + $1.59 per ticket for paid
- Integrates with Zoom, Hopin, others via API
- Strong marketing tools (email campaigns, social promotion)

**Cvent**

- Enterprise-grade event management
- Robust data collection and custom fields
- Excellent reporting and CRM integration
- Higher cost ($3,000-$10,000+ per event)

**Whova**

- Conference-specific features
- Agenda building and session selection
- Mobile app for attendees
- Moderate pricing ($1,000-$5,000 per event)

**Givebutter** (for fundraising events)

- Designed for nonprofit fundraising
- P2P fundraising, auctions, pledges
- 0% platform fee (optional tips)
- Integrates with Zoom and streaming platforms

**Recommendation for Mark Egly Foundation:**

- **Small events (<100 attendees)**: Use platform native registration (Zoom, etc.)
- **Large/complex events**: Eventbrite for marketing + platform integration
- **Fundraising events**: Givebutter for donation processing + Zoom for video

### Registration Form Design

#### Essential Fields

- **Name**: First and Last (separate fields for personalization)
- **Email**: Primary communication method (validate format)
- **Affiliation**: Patient, Caregiver, Medical Professional, Researcher, Advocate, Other

#### Conditional Fields Based on Affiliation

**For Patients:**

- [ ] AATD Genotype (if comfortable sharing): ZZ, SZ, MZ, Other, Not tested, Prefer not to say
- [ ] Years since diagnosis: <1, 1-3, 3-5, 5-10, 10+ years
- [ ] Interested in support group? Yes/No
- [ ] Accessibility accommodations needed? (Live captioning, ASL, large print, other)

**For Medical Professionals:**

- [ ] Profession: Physician, NP/PA, RN, Respiratory Therapist, Genetic Counselor, Other
- [ ] Specialty: Pulmonology, Hepatology, Primary Care, Genetics, Other
- [ ] CME Credit desired? Yes/No
- [ ] Medical license number (if CME): **\*\***\_\_\_\_**\*\***
- [ ] State of licensure: **\*\***\_\_\_\_**\*\***

**For Caregivers:**

- [ ] Relationship to patient: Spouse/Partner, Parent, Child, Other family, Friend
- [ ] Years in caregiving role: <1, 1-3, 3-5, 5-10, 10+
- [ ] Support needs: Caregiver support group, Educational materials, Respite resources

**For All Registrants:**

- [ ] How did you hear about this event? (Dropdown: Email, Social Media, Website, Referral, Other)
- [ ] Topics of interest: (Multi-select: Treatment options, Genetic counseling, Advocacy, Research updates, etc.)
- [ ] Communication preferences: Email, SMS, Phone, Prefer email only
- [ ] Time zone: (Auto-detect or dropdown)
- [ ] Dietary restrictions (if providing meals): Vegan, Vegetarian, Gluten-free, Allergies, None

#### Privacy & Consent Checkboxes

- [ ] **Required**: "I agree to the Privacy Policy and Terms of Use"
- [ ] **Required**: "I understand this event will be recorded and may be shared publicly/privately [specify]"
- [ ] Optional: "I consent to appearing on camera if unmuted/sharing video"
- [ ] Optional: "I would like to receive email updates about future Foundation events and programs"
- [ ] Optional: "I am willing to share my story with the Foundation for advocacy purposes" (patient stories consent)

### Automated Communication Sequences

#### Confirmation Email (Immediate)

**Subject:** You're Registered! [Event Name] on [Date]

**Content:**

- Thank you for registering
- Event details (date, time, time zone)
- "Add to Calendar" button (ICS file)
- Platform access instructions
- What to expect (agenda overview)
- Accessibility accommodations confirmation (if requested)
- Contact information for questions

#### Reminder Email #1 (1 Week Before)

**Subject:** One Week Until [Event Name]!

**Content:**

- Event reminder with date/time
- Featured speakers or session highlights
- Tech check instructions (test link)
- How to submit questions in advance
- Invitation to follow on social media

#### Reminder Email #2 (24 Hours Before)

**Subject:** Tomorrow: [Event Name] - Final Details

**Content:**

- "This time tomorrow" framing
- Join link (prominent CTA button)
- Advice: Join 10 minutes early for tech check
- What to prepare (questions, notepad, etc.)
- Reminder of CME credit process (if applicable)

#### Reminder Email #3 (1 Hour Before)

**Subject:** Starting Soon: [Event Name]

**Content:**

- "Join now" button (allow early entry)
- Mobile app download link (if applicable)
- Technical support contact info
- Last-minute logistics

#### Follow-Up Email (24 Hours After)

**Subject:** Thank You for Attending [Event Name]!

**Content:**

- Thank you message
- Recording link (if available) with expiration date
- Presentation slides download
- Survey link for feedback (very important)
- CME certificate download (for professionals)
- Upcoming events preview
- Ways to stay engaged (support groups, advocacy, donations)
- Social media highlights and photos

### Integration Technical Setup

#### Zoom + Eventbrite Integration

1. **Eventbrite Setup:**
   - Create event and registration form
   - Enable "Online Event" option
   - Copy unique registration webhook URL

2. **Zoom Setup:**
   - Create Zoom Meeting or Webinar
   - Enable registration within Zoom
   - In Eventbrite, paste Zoom join link in "Event Location" field

3. **Zapier/Make.com Automation** (recommended):
   - Trigger: New Eventbrite registration
   - Action: Add registrant to Zoom meeting
   - Action: Send confirmation email with Zoom link
   - Filter: Apply different Zoom links for different ticket types (VIP, General, etc.)

4. **Testing:**
   - Complete test registration
   - Verify Zoom link received
   - Confirm registration shows in both systems
   - Test reminder emails deliver correctly

#### Tracking & Attribution

- **UTM Parameters**: Add to all marketing links
  - Source: utm_source=email, facebook, linkedin, etc.
  - Medium: utm_medium=social, email, paid
  - Campaign: utm_campaign=aatd_webinar_nov2025
- **Registration Source Tracking**: Ask "How did you hear about us?" to measure channel effectiveness
- **Google Analytics Integration**: Track registration page conversions
- **CRM Sync**: Integrate with donor database (Salesforce, Bloomerang, etc.) to track constituent engagement

---

## Engagement Features & Best Practices

### Interactive Polling

**When to Use Polls:**

- **Icebreakers**: "Where are you joining from?" (builds community)
- **Knowledge Checks**: Pre/post-learning assessment for CME courses
- **Audience Segmentation**: "Are you a patient, caregiver, or medical professional?"
- **Decision Making**: "Which topic should we cover first?" (empowers attendees)
- **Engagement Boosters**: Break up lecture content every 10-15 minutes

**Poll Best Practices:**

- Keep questions short (10 words or less)
- Limit to 3-5 answer options
- Use multiple choice rather than open-ended (for live results)
- Share results immediately after voting closes
- Have moderator comment on interesting findings
- Pre-load all polls before event starts
- Assign a team member to launch polls on cue

**Sample Polls for AATD Events:**

_Patient Education Webinar:_

1. "How long have you been living with AATD?" (Icebreaker)
2. "What topic are you most interested in today?" (Priorities)
3. "Do you currently receive augmentation therapy?" (Segmentation)
4. "After this presentation, I understand [concept] better." (Learning outcome)

_Medical Professional Training:_

1. "How many AATD patients have you diagnosed in your career?" (Baseline knowledge)
2. "Which symptom would prompt you to test for AATD?" (Case study)
3. "True or False: MZ carriers can have clinical symptoms." (Knowledge check)
4. "I plan to implement [strategy] in my practice." (Commitment to action)

### Q&A Management

**Moderation Workflow:**

1. **Attendee Submits Question**: Via Q&A feature (not public chat)
2. **Moderator Reviews**: Check for relevance, appropriateness, duplicates
3. **Moderator Actions**:
   - Upvote good questions (surfaces to top)
   - Mark as "Answered" if already addressed
   - Edit for clarity (grammar, remove personal info)
   - Answer directly in text (for simple factual questions)
   - Forward to speaker (for complex/expert questions)
   - Park for offline follow-up (if time constrained)
4. **Speaker Responds**: Verbally or in writing
5. **Post-Event**: Compile unanswered questions for email follow-up

**Q&A Best Practices:**

- **Announce Q&A Protocol**: At start, explain how to submit questions
- **Allocate Time**: Reserve 15-30 minutes for live Q&A
- **Prioritize Upvoted Questions**: Democracy in action
- **Read Question Aloud**: Before speaker answers (for recording clarity)
- **Answer Anonymously**: Do not read attendee names (privacy)
- **Group Similar Questions**: "Several people asked about..." (saves time)
- **Defer Medical Advice**: "For specific medical questions, please consult your physician"
- **Capture All Questions**: Export Q&A log for follow-up email

**Sample Q&A Guidelines for Speakers:**
"Please avoid providing individual medical advice. Frame responses as general education. If unsure, defer to: 'That's a great question for your personal physician who knows your medical history.'"

### Chat Features

**Chat Configuration:**

- **Public Chat**: Enabled, but moderated (remove offensive content)
- **Private Chat**: Disabled (prevents side conversations, maintains focus)
- **Save Chat Transcript**: Enable for post-event review

**Chat Etiquette Guidelines (Share with Attendees):**

- Be respectful and supportive
- No promotional content or spam
- Protect privacy: Do not share personal health information
- Keep comments relevant to the presentation
- Use Q&A feature for speaker questions (not chat)
- Moderators may remove inappropriate messages

**Moderator Chat Monitoring:**

- Assign dedicated chat moderator (separate from Q&A moderator)
- Respond to technical questions quickly ("I can't hear audio" → "Check your speaker settings")
- Highlight insightful comments to speaker ("Great point in chat about...")
- Share resources (links to factsheets, registration pages)
- Foster community by welcoming people ("Welcome, Sarah from Ohio!")

### Breakout Rooms

**Use Cases for Breakout Rooms:**

- **Support Group Discussions**: Small groups by diagnosis stage, geography, or demographics
- **Workshop Activities**: Case study analysis, advocacy training exercises
- **Networking**: Random assignment for informal conversation
- **Regional Meetings**: State-specific advocacy strategy sessions

**Breakout Room Best Practices:**

- **Pre-Assign Groups** when possible (vs. random/self-select)
- **Optimal Size**: 5-8 people per room (allows everyone to speak)
- **Clear Instructions**: Provide written prompt/discussion questions
- **Time Limits**: 10-20 minutes (attention span)
- **Warning Notifications**: Send 2-minute warning before closing rooms
- **Facilitator in Each Room**: Assign staff or trained volunteers
- **Debrief in Main Room**: Have each group share key takeaways (1-2 minutes each)

**Breakout Room Assignment Strategies:**

_Random Assignment:_

- Good for: Networking, icebreakers
- Zoom feature: Automatically split attendees

_Pre-Assigned:_

- Good for: Skill-based groups, regional discussions
- Requires: Registration data to segment (e.g., by state, role)

_Self-Select:_

- Good for: Topic-based discussions
- Attendees choose room based on interest

**Technical Tips:**

- Enable "Allow participants to return to main session at any time" (if they need to leave)
- Disable "Allow participants to choose room" (unless self-select)
- Use co-hosts to monitor multiple rooms
- Record individual breakout rooms if discussions are part of official program

### Reactions & Non-Verbal Feedback

**Platform Reaction Features:**

- Zoom: Raise hand, thumbs up, clapping, heart, laugh, surprised, etc.
- Teams: Like, love, applaud, laugh, surprised
- Webex: Raise hand, thumbs up, applause

**When to Encourage Reactions:**

- "Give me a thumbs up if you can hear me clearly." (Tech check)
- "React with a heart if you've experienced diagnostic delay." (Empathy/connection)
- "Applause for our speaker!" (Appreciation)
- "Raise your hand if you have a question." (Engagement metric)

**Moderator Use of Reactions:**

- Provides visual feedback in large events where speaking is limited
- Creates sense of community and participation
- Use sparingly to avoid distraction

### Gamification & Prizes

**Strategies to Boost Engagement:**

**Attendance Incentives:**

- Raffle entry for staying entire event
- Early-bird prizes for first 50 to join
- Perfect attendance across multi-day conference

**Participation Prizes:**

- Most upvoted question wins book/resource
- Poll participation: Every 10th voter wins prize
- Chat engagement: Most helpful commenter

**Social Media Contests:**

- Share event on social media with #Alpha1Awareness → entry to win
- Post selfie with virtual background → feature on Foundation page

**Knowledge Challenges:**

- Trivia questions throughout event
- Leaderboard for correct answers (if platform supports)
- Grand prize for highest score

**Prize Ideas:**

- Foundation merchandise (t-shirts, tote bags)
- Books on AATD or health advocacy
- Amazon gift cards ($25-$100)
- Donations made in attendee's name
- Free registration to future events

**Legal/Ethical Considerations:**

- Ensure contests comply with sweepstakes laws (no purchase necessary)
- HIPAA: Do not require health information disclosure to enter
- Collect winner contact info separately from event registration (data privacy)

### Virtual Networking Features

**1-on-1 Video Matching (Hopin, Airmeet):**

- Algorithm pairs attendees for 5-10 minute video chats
- Based on shared interests (from registration data)
- Speed networking format

**Networking Lounges/Tables:**

- Virtual rooms attendees can drop into
- Organized by topic, geography, or role
- Video + chat enabled

**Attendee Profiles:**

- Optional: Photo, bio, LinkedIn, interests
- Searchable directory
- Privacy controls (opt-in to networking)

**Best Practices:**

- Make networking optional, not required
- Provide clear instructions on how to participate
- Have staff/volunteers in networking rooms to facilitate
- Schedule dedicated networking time (not during main sessions)
- Follow up with LinkedIn group or ongoing community forum

---

## Accessibility Requirements

### Legal & Ethical Foundation

**Americans with Disabilities Act (ADA) - Title III**

- Virtual events are "places of public accommodation"
- Must be accessible to people with disabilities
- Applies to nonprofits offering services to public
- Failure to comply can result in DOJ complaints and lawsuits

**Web Content Accessibility Guidelines (WCAG 2.1)**

- International standard for digital accessibility
- Levels: A (minimum), AA (standard), AAA (enhanced)
- **Target: WCAG 2.1 Level AA** for all Foundation events

**Section 508 (if federal funding)**

- Federal agencies and grantees must meet Section 508 standards
- Largely aligned with WCAG 2.0 Level AA

**Ethical Imperative**

- AATD patients may have mobility or respiratory challenges
- Inclusion is core to Foundation values
- Accessibility benefits all attendees (captions help in noisy environments, etc.)

### Live Captioning (CART)

**Communication Access Realtime Translation (CART)**

- Professional stenographers provide real-time captions
- 98-99% accuracy (far superior to AI auto-captions)
- Display directly in platform or separate window

**When to Use CART vs. Auto-Captions:**

- **CART (Professional Human Captioning):**
  - Legal/CME events requiring accuracy
  - Medical terminology-heavy content
  - Events with significant deaf/HoH attendance
  - Multi-speaker panels with cross-talk
  - Budget allows ($150-$250/hour)

- **AI Auto-Captions (Zoom, Teams, Google):**
  - Informal webinars with clear single speaker
  - Budget constraints (<$100 event budget)
  - Backup to CART (redundancy)
  - Quick internal meetings
  - 80-90% accuracy (adequate for some contexts)

**CART Provider Selection Criteria:**

- Certified by NCRA (National Court Reporters Association)
- Experience with medical terminology
- Familiarity with platform (Zoom, Teams, etc.)
- Turnaround time for transcript delivery (24-48 hours)
- Backup stenographer in case of emergency

**Recommended CART Providers:**

- **Caption First**: (888) 766-7404, captionfirst.com
- **Caption Access**: (877) 999-9934, captionaccess.com
- **White Coat Captioning**: (866) 424-3627, whitecoatcaptioning.com (medical specialist)

**CART Setup Process:**

1. Book provider 2-4 weeks in advance
2. Provide agenda, speaker bios, and terminology list
3. Share slides/scripts 48 hours before event
4. Test caption display 1 week before event
5. Connect captioner 15 minutes before start time
6. Monitor caption quality during event
7. Request transcript file after event (for archiving/sharing)

**Budget:**

- **CART**: $150-$250 per hour (2-hour minimum typical)
- **Rev Live Captions**: $1.50-$2.00 per minute ($90-$120/hour)
- **AI Auto-Captions**: Free (Zoom, Teams) or included in platform

### ASL Interpretation

**When to Provide ASL:**

- Requested by registrant (must accommodate)
- Large public events (recommended proactively for 100+ attendees)
- Content-heavy presentations (lectures, medical education)

**Number of Interpreters:**

- **1 interpreter**: Events < 30 minutes
- **2 interpreters**: Events 30-90 minutes (tag team, alternate every 15-20 min)
- **3+ interpreters**: Full-day conferences (rotations to prevent fatigue)

**Interpreter Qualifications:**

- Certified by RID (Registry of Interpreters for the Deaf) or NAD
- Medical interpreting experience (CDI-M: Certified Deaf Interpreter - Medical)
- Familiarity with AATD terminology

**ASL Setup in Platform:**

1. **Spotlight/Pin Video**: Ensure interpreter always visible
2. **High-Quality Video**: 1080p camera for interpreter (facial expressions critical)
3. **Good Lighting**: Even, bright lighting on interpreter
4. **Plain Background**: Solid color (not distracting)
5. **Interpreter Positioning**: Upper body fully visible, hands in frame
6. **Dual Screen Option**: Some attendees may want interpreter on second monitor

**Interpreter Preparation:**

- Provide slides, script, and terminology list 1 week in advance
- Schedule 15-minute pre-event briefing with speakers
- Clarify acronyms and proper nouns
- Allow interpreter to ask questions

**Budget:**

- $50-$150 per hour per interpreter (2-hour minimum)
- Travel/lodging if in-person event

### Screen Reader Compatibility

**Key Platform Considerations:**

- **Keyboard Navigation**: All features accessible via keyboard (no mouse required)
- **Alt Text**: Images and graphics have descriptive alt text
- **ARIA Labels**: Proper HTML labeling for screen readers
- **Heading Structure**: Logical H1, H2, H3 hierarchy
- **Focus Indicators**: Visible outline on focused elements

**Testing with Screen Readers:**

- **NVDA** (Free, Windows): nvaccess.org
- **JAWS** (Paid, Windows): freedomscientific.com/products/software/jaws
- **VoiceOver** (Built-in, Mac/iOS): Apple Accessibility settings
- **TalkBack** (Built-in, Android): Android Accessibility settings

**Test Checklist:**

- [ ] Can navigate between UI elements with Tab key
- [ ] Buttons and links are announced clearly
- [ ] Chat/Q&A messages are read in order
- [ ] Participant list is accessible
- [ ] Captions can be toggled on/off with keyboard
- [ ] Screen reader announces when someone starts speaking
- [ ] Polls and reactions are accessible

### Document Accessibility

**Presentation Slides (PowerPoint, Google Slides):**

- **Alt Text**: Add descriptions to images ("Graph showing 7-8 year diagnostic delay")
- **Color Contrast**: Minimum 4.5:1 for text on background (use WebAIM Contrast Checker)
- **Font Size**: Minimum 24pt for body text, 36pt+ for titles
- **Sans-Serif Fonts**: Arial, Calibri, Helvetica (easier to read than serif fonts)
- **Avoid Color-Only Information**: Use patterns or labels in addition to color
- **Reading Order**: Ensure slide elements read in logical sequence
- **Headings**: Use built-in heading styles (not just large text)

**PDFs and Handouts:**

- **Accessible PDF**: Use "Save as PDF" with accessibility tags (not "Print to PDF")
- **OCR Text Layer**: Scanned documents must have text layer for screen readers
- **Bookmarks**: For long documents (>5 pages), add navigation bookmarks
- **Form Fields**: Use proper form fields (not fillable text boxes)

**Website/Event Page:**

- **Semantic HTML**: Use proper tags (<nav>, <main>, <article>, etc.)
- **Skip Links**: "Skip to main content" link at top of page
- **Video Captions**: All pre-recorded videos must have captions
- **Transcripts**: Provide text transcripts for audio/video content

### Additional Accommodations

**Visual Impairments:**

- Large-print handouts (18pt+ font)
- High-contrast mode in platform
- Allow service animals (if in-person/hybrid)
- Provide descriptive audio for visual content

**Hearing Impairments:**

- Live captions (CART)
- ASL interpretation
- Transcript provided after event
- Visual cues for audio alerts (e.g., flashing screen for "speaker muted" alert)

**Mobility Impairments:**

- Keyboard-only navigation
- Voice control compatibility (Dragon NaturallySpeaking, etc.)
- Extended time for interactive activities
- No time-limited activities (or provide extensions)

**Cognitive/Learning Disabilities:**

- Plain language (avoid jargon, explain acronyms)
- Visual aids and graphics
- Slides provided in advance
- Recording available for review
- Breaks during long events

**Language Access:**

- Interpretation for non-English speakers (if significant population)
- Bilingual materials
- Language selection in registration

### Requesting Accommodations

**Registration Form Question:**
"Do you require any accessibility accommodations to fully participate in this event? (Examples: live captioning, ASL interpretation, large print materials, extended time for activities, dietary restrictions, other)"

- [ ] Open text field for specific requests
- [ ] Contact info: "Please contact [accessibility coordinator email/phone] at least 2 weeks before the event to discuss accommodations."

**Response Process:**

1. **Acknowledge Request**: Within 24 hours, confirm receipt
2. **Clarify Needs**: Schedule call if complex accommodation
3. **Arrange Services**: Book CART, ASL, or other providers
4. **Confirm with Attendee**: 1 week before event, verify accommodation is arranged
5. **Day-of Check-In**: Connect with attendee 15 minutes before start to ensure accommodation works

**Budget for Accommodations:**

- Build 5-10% of event budget for accessibility services
- For $5,000 event: $250-$500 accessibility budget
- Never charge attendees for accommodations (covered by organization)

---

## Data Privacy & HIPAA Compliance

### HIPAA Requirements for Virtual Events

**When HIPAA Applies:**

- Foundation is a "Covered Entity" or "Business Associate" under HIPAA
- Virtual events collect, store, or transmit Protected Health Information (PHI)
- Examples of PHI in virtual events:
  - Registration forms asking about diagnosis, genotype, symptoms
  - Support group discussions where patients share health experiences
  - Chat/Q&A where attendees disclose medical information
  - Recordings that contain patient faces, voices, or stories

**Business Associate Agreements (BAA):**

- Platform vendor must sign BAA before handling PHI
- BAA required for: Zoom, Hopin, Webex, Microsoft Teams, registration platforms
- Review BAA terms carefully (data storage, breach notification, audit rights)
- Keep signed BAAs on file (compliance audit requirement)

**Minimum Necessary Standard:**

- Only collect health information necessary for event purpose
- Support groups: May ask about diagnosis (relevant to participation)
- Networking events: Do not ask about health details (not necessary)
- Registration forms: Make health questions optional when possible

### Platform Security Configuration

#### Zoom Security Settings

- [ ] **Enable Waiting Room**: Prevents uninvited guests
- [ ] **Require Registration**: Know who is attending
- [ ] **Disable Join Before Host**: Prevent unsupervised sessions
- [ ] **Lock Meeting**: Once all expected attendees have joined
- [ ] **Disable Screen Sharing**: For attendees (only host/co-host)
- [ ] **Disable File Transfer**: Prevent malware/inappropriate content
- [ ] **Enable Encryption**: End-to-end encryption (if available)
- [ ] **Require Password**: Additional barrier to entry
- [ ] **Disable "Allow Removed Participants to Rejoin"**: For disruptive individuals
- [ ] **Enable Reporting**: Allow attendees to report inappropriate behavior

#### Webex Security Settings

- [ ] **Locked Meeting**: After start time
- [ ] **Require Sign-In**: Email verification
- [ ] **Encrypted Sessions**: TLS 1.2+
- [ ] **Co-Host Controls**: Limit who can manage participants
- [ ] **Session Recording Controls**: Limit to host only

#### Microsoft Teams Security

- [ ] **Meeting Options**: Who can bypass lobby (only organizers and co-organizers)
- [ ] **Disable Anonymous Join**: Require sign-in
- [ ] **Participant Permissions**: Disable screen share, chat, reactions for attendees
- [ ] **Meeting Sensitivity Labels**: Mark as "Confidential" if discussing PHI

### Data Collection & Storage

**Registration Data:**

- Store in HIPAA-compliant database (encrypted at rest)
- Limit access to authorized staff only (role-based access)
- Retain only as long as necessary (define retention period: e.g., 3 years post-event)
- Secure deletion process (overwrite, not just "delete")

**Recording Storage:**

- Store on encrypted cloud storage with access controls (Google Drive Enterprise, OneDrive for Business with BAA)
- Never store recordings on personal devices
- Password-protect recordings (Zoom allows password on recordings)
- Limit sharing: Unlisted links (not public indexing)
- Expiration dates: Set recordings to auto-delete after 90 days (unless archival purpose)

**Chat/Q&A Logs:**

- Treat as PHI if health information disclosed
- Review logs before sharing (redact personal health details)
- Do not publish full transcripts without redaction
- Save logs in secure location (not email attachments)

### Consent & Disclosures

**Event Registration Consent Language:**

"By registering for this event, you acknowledge:

- This event will be recorded and may be shared [publicly/with other participants/internally only].
- If you share video or speak, your image and voice will be recorded.
- Chat and Q&A messages may be reviewed by staff and shared in follow-up materials.
- The Mark Egly Foundation will handle your information in accordance with HIPAA regulations and our Privacy Policy.
- Please do not share personal health information in public chat. Use Q&A for medical questions."

**Verbal Reminder at Event Start:**
"Welcome! A quick reminder that today's session is being recorded. Please be mindful of sharing personal health information in chat. For specific medical questions, use the Q&A feature, and our team will follow up privately if needed."

**Recording Notice:**

- Display "This session is being recorded" notification
- Verbal announcement at start
- Visual indicator (red "REC" badge in corner)

### Breach Response Plan

**If PHI is Disclosed Inappropriately:**

**Immediate Actions (0-24 hours):**

1. **Stop Recording**: If live and breach is occurring
2. **Remove Participant**: If individual is disclosing others' PHI without consent
3. **Delete Content**: Remove chat message or disable Q&A temporarily
4. **Document Incident**: What was disclosed, by whom, to how many people

**Short-Term Actions (24-72 hours):**

1. **Risk Assessment**: Evaluate scope of breach (number of individuals affected, type of PHI disclosed)
2. **Notify Privacy Officer**: Foundation's HIPAA Privacy Officer initiates investigation
3. **Notify Platform Vendor**: If breach due to platform security failure
4. **Secure Evidence**: Save logs, recordings, screenshots

**Notification Requirements:**

- **Individuals Affected**: Notify within 60 days (if breach affects 500+ individuals, notify HHS and media immediately)
- **HHS Office for Civil Rights**: If breach affects 500+ individuals, report within 60 days
- **Annual Report**: Breaches affecting <500 individuals reported annually

**Mitigation:**

- Offer credit monitoring (if financial info exposed)
- Provide resources (identity theft protection, support services)
- Conduct training to prevent future breaches
- Review and update policies

### Privacy-Enhancing Practices

**Anonymization Strategies:**

- Allow attendees to use first name only or pseudonyms (in display name)
- Blur backgrounds to hide location/home details
- Disable attendee list visibility (only host sees full list)
- Provide option to participate audio-only (no video)

**De-Identification for Recordings:**

- Blur faces in post-production (if sharing externally)
- Edit out names and identifying details
- Use voice alteration for testimonials
- Obtain written consent from anyone identifiable in shared recordings

**Limited Data Retention:**

- Delete recordings after defined period (30-90 days unless archival purpose)
- Purge registration data after 1 year (unless needed for longitudinal analysis)
- Regularly audit and delete old files

**Access Controls:**

- Multi-factor authentication (MFA) for platform admin accounts
- Role-based access (not everyone needs host privileges)
- Audit logs: Review who accessed recordings and when
- Offboard process: Remove access immediately when staff leaves

### GDPR Considerations (International Attendees)

If European Union residents may attend:

**Consent:**

- Explicit opt-in (not pre-checked boxes)
- Clear purpose for data collection
- Right to withdraw consent

**Data Subject Rights:**

- Right to access (attendee can request their data)
- Right to deletion ("right to be forgotten")
- Right to data portability (export data in machine-readable format)

**Data Processing Agreement (DPA):**

- Similar to HIPAA BAA, but for GDPR
- Required if platform processes EU resident data

**International Data Transfers:**

- Standard Contractual Clauses (SCCs) if data stored outside EU
- Ensure platform complies with EU-US Data Privacy Framework

---

## Technical Support During Events

### Support Team Structure

#### Roles & Responsibilities

**1. Event Host/Primary Moderator**

- Welcomes attendees and sets expectations
- Introduces speakers and manages transitions
- Monitors overall event flow and timing
- Makes executive decisions (e.g., extending Q&A)

**2. Technical Director**

- Monitors platform health (bandwidth, connection quality)
- Manages recording start/stop
- Handles platform admin tasks (admit from waiting room, spotlight speakers)
- Troubleshoots technical issues with speakers

**3. Chat/Q&A Moderator**

- Monitors and responds to chat messages
- Curates Q&A questions for speakers
- Answers logistical questions in real-time
- Escalates urgent issues to Technical Director

**4. Accessibility Coordinator (for events with CART/ASL)**

- Monitors caption quality
- Checks in with ASL interpreters
- Responds to accommodation requests during event

**5. Backup Host**

- Logged in but on standby
- Can take over if primary host has technical failure
- Familiar with run-of-show and able to step in seamlessly

### Tech Support Channels

**Pre-Event (1 Hour Before):**

- **Email**: support@markeglyfoundation.org (monitored by tech team)
- **Phone/SMS Hotline**: Dedicated number for speaker tech issues
- **Test Session**: Open early to help attendees troubleshoot

**During Event:**

- **In-Platform Chat**: "@TechSupport" mentions flagged for immediate response
- **Backchannel (Staff Only)**: Slack/Teams channel for coordination
- **Phone**: Backup for speaker emergencies

**Post-Event:**

- **Follow-Up Email**: FAQs and tech tips for future events
- **Survey**: "Did you experience any technical issues?"

### Common Support Requests & Responses

| Issue              | Attendee Message            | Support Response                                                                                                     |
| ------------------ | --------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Can't hear audio   | "I can't hear anything"     | "Click the speaker icon in bottom left. Check your computer volume. Try headphones."                                 |
| Can't see video    | "Screen is black"           | "Check your internet connection. Try turning off HD video in settings. Refresh your browser."                        |
| Login problems     | "Can't log in with my link" | "Verify you're using the correct email. Check spam folder for confirmation. Try this backup link: [link]"            |
| Camera not working | "My video won't turn on"    | "Check if another app is using your camera. Grant browser permission. Restart platform."                             |
| Screenshare issues | "I can't share my screen"   | "Ensure you're a panelist/speaker. Check 'Share Screen' button in toolbar. Grant screen recording permission (Mac)." |
| Accessibility      | "I need captions"           | "Click 'CC' button in bottom toolbar. Captions are provided by [CART service name]."                                 |

### Pre-Scripted Chat Responses

Save these as macros for quick deployment:

**Welcome Message:**
"Welcome to [Event Name]! We'll begin in a few minutes. Please test your audio and video. Use Q&A for speaker questions and Chat for community engagement. For technical help, type @TechSupport."

**Event Starting:**
"We're about to begin! Please find your seat, mute your microphone, and turn off video unless speaking. Enjoy the event!"

**Recording Reminder:**
"Reminder: This session is being recorded. Please avoid sharing personal health information in public chat."

**Q&A Instructions:**
"To ask a question, use the Q&A button (not Chat). Upvote questions you'd like answered. We'll address as many as time allows."

**Break Announcement:**
"We'll take a 10-minute break. We'll resume at [time]. Stay logged in! Use this time to stretch, grab a drink, and visit our virtual sponsor booths."

**Technical Difficulties:**
"We're experiencing technical difficulties. Please stand by while we resolve this. Thank you for your patience."

**Closing Message:**
"Thank you for attending! The recording and slides will be emailed within 24 hours. Please complete our 2-minute survey: [link]. Follow us on social media @MarkEglyFoundation."

### Contingency Communication Plan

**If Platform Fails Completely:**

**Immediate Actions:**

1. **Announce on Social Media**: "We're experiencing technical difficulties with [Event Name]. Stand by for updates."
2. **Email Blast**: Use registration list to send update: "We're working to restore service. Please refresh your browser and try rejoining."
3. **Backup Platform**: If primary platform down >10 minutes, switch to backup (e.g., Zoom backup webinar link)

**Communication Channels:**

- Twitter/X: @MarkEglyFoundation
- Facebook: Facebook.com/MarkEglyFoundation
- Email: registration list (use mail merge for fast send)
- Website Banner: "Event Delayed - Check Email"

**Decision Tree:**

- <5 min outage: Wait and resume
- 5-15 min outage: Take break, switch to backup platform if not resolved by 15 min
- > 15 min outage: Reschedule event, notify all attendees, offer makeup date

### Post-Event Technical Debrief

**Debrief Meeting (30 min, within 24 hours of event):**

**Agenda:**

1. **What Went Well?** (Celebrate successes)
2. **What Issues Occurred?** (Document problems)
3. **Root Cause Analysis** (Why did issues happen?)
4. **Action Items** (How to prevent recurrence)
5. **Update Documentation** (Revise this guide based on learnings)

**Metrics to Review:**

- Number of tech support requests
- Average response time to support requests
- Platform uptime/downtime
- Audio/video quality ratings
- Survey feedback on technical experience

**Document Updates:**

- Add new troubleshooting entries
- Update equipment recommendations if better options identified
- Refine scripts based on common questions
- Revise timeline if tasks took longer/shorter than planned

---

## Presenter & Moderator Training

### Pre-Event Training Session (60-90 minutes)

**Training Objectives:**

- Familiarize presenters with platform interface
- Establish professional presentation standards
- Practice interactive features (polls, Q&A, screenshare)
- Build confidence and reduce day-of stress

**Training Agenda:**

**1. Platform Overview (15 min)**

- How to join as panelist/speaker
- Interface walkthrough (mute, camera, screenshare, reactions)
- Difference between host, co-host, panelist, and attendee roles
- Where attendees will see you (video layout options)

**2. Audio/Video Best Practices (15 min)**

- Microphone setup and audio testing
- Camera angle and framing (eye level, arms-length away)
- Lighting techniques (face the light source)
- Background considerations (professional or branded virtual background)
- Dress code (solid colors, avoid patterns, professional attire from waist up)

**3. Presentation Skills for Virtual Events (20 min)**

- **Engagement**: Look at camera (not screen) to simulate eye contact
- **Energy**: Speak with more enthusiasm than in-person (video flattens emotion)
- **Pacing**: Slower pace than in-person, allow time for processing
- **Pauses**: Pause for tech lag before transitions
- **Visuals**: Use slides to maintain interest (change slide every 60-90 seconds)

**4. Interactive Features Practice (20 min)**

- Launching polls and discussing results
- Responding to Q&A questions
- Using chat to engage (sparingly)
- Screensharing: Entire screen vs. specific app
- Annotation tools (whiteboard, highlighting)

**5. Troubleshooting & Contingency Plans (10 min)**

- What to do if you lose connection
- Backup plan: rejoin via phone if computer fails
- How to signal for help (private chat to tech director)
- Handling disruptive participants (host will manage)

**6. Q&A for Speakers (10 min)**

### Speaker Preparation Checklist

**1 Week Before Event:**

- [ ] Attend tech rehearsal
- [ ] Submit final slides to organizers (for backup)
- [ ] Review Q&A guidelines (avoid medical advice)
- [ ] Test microphone and camera
- [ ] Choose location for presenting (quiet, private, professional)

**24 Hours Before:**

- [ ] Test internet speed (5+ Mbps upload)
- [ ] Update platform software to latest version
- [ ] Close unnecessary apps and browser tabs
- [ ] Charge laptop and have power cord ready
- [ ] Prepare glass of water (off-camera)
- [ ] Silence phone and notifications

**1 Hour Before:**

- [ ] Log in to platform as panelist
- [ ] Test audio and video with tech team
- [ ] Load presentation and verify slide animations work
- [ ] Final bathroom break
- [ ] Review opening and closing remarks

**During Event:**

- [ ] Mute when not speaking
- [ ] Look at camera when speaking
- [ ] Advance slides smoothly
- [ ] Monitor time and pace accordingly
- [ ] Engage with Q&A at designated time

### Virtual Presentation Best Practices

**Slide Design for Virtual Events:**

- **Simple is Better**: One idea per slide
- **Large Fonts**: Minimum 24pt body text, 36pt titles
- **High Contrast**: Dark text on light background (or reverse)
- **Minimal Text**: Use bullet points, not paragraphs (aim for 6 words per line, 6 lines per slide)
- **Visuals**: Photos, icons, and graphics to maintain interest
- **Branded**: Include Foundation logo on each slide
- **Accessibility**: Alt text for images, captions for videos

**Speaking Techniques:**

- **Introduce Yourself**: Name, credentials, and why you're qualified (for attendees joining late)
- **Signpost**: "First, I'll cover... Then we'll discuss... Finally, I'll..."
- **Ask Rhetorical Questions**: "Have you ever wondered why...?" (engages thinking)
- **Tell Stories**: Personal anecdotes and patient narratives (more memorable than facts)
- **Check for Understanding**: "Can everyone hear me okay?" "Give me a thumbs up if that makes sense"
- **Summarize Frequently**: "To recap: the three key points are..."

**Avoiding Zoom Fatigue:**

- **Vary Delivery**: Mix slides, video clips, live demo, and discussion
- **Build in Breaks**: 10 min break every 45-60 minutes
- **Encourage Movement**: "Stand up and stretch" breaks
- **Rest Eyes**: Invite attendees to turn off video during presentations (listen only)
- **Shorter Sessions**: 60-90 min max before break (vs. 2-3 hours in-person)

### Moderator Training

**Moderator Role:**

- Timekeeping (start on time, keep speakers on schedule)
- Facilitating Q&A (selecting questions, managing time)
- Handling disruptions (muting disruptive attendees)
- Monitoring chat for questions or issues
- Ensuring accessibility (checking caption quality)

**Moderator Script Templates:**

**Opening:**
"Good [morning/afternoon/evening], and welcome to [Event Name], hosted by the Mark Egly Foundation. My name is [Name], and I'll be your moderator today. Before we begin, a few housekeeping items:

- This session is being recorded and will be available at [location]
- Please mute your microphone and turn off video unless speaking
- Use the Q&A feature to submit questions for our speakers
- Live captions are available by clicking the 'CC' button
- For technical support, type @TechSupport in the chat
  We'll begin in just a moment."

**Introducing Speakers:**
"I'm pleased to introduce our speaker, Dr. [Name]. Dr. [Name] is a [credentials] and [relevant experience]. Today, [he/she/they] will discuss [topic]. Please join me in welcoming Dr. [Name]."

**Transitions:**
"Thank you, Dr. [Name], for that insightful presentation. Next, we'll hear from [Next Speaker]..."

**Q&A Facilitation:**
"We have time for questions now. I'll read questions from the Q&A feature. Our first question is: '[Question].' Dr. [Name], would you like to address this?"

**Closing:**
"That concludes our program for today. Thank you to our speakers, [names], and to all of you for attending. The recording and slides will be emailed within 24 hours. Please take 2 minutes to complete our survey [link]. We look forward to seeing you at our next event on [date]. Have a great day!"

### Speaker Agreement & Expectations

**Pre-Event Agreement (Send 2 Weeks Before):**

"Thank you for agreeing to present at [Event Name]. By participating, you agree to:

- Attend the tech rehearsal on [date/time]
- Submit your final slides by [date]
- Avoid providing individual medical advice
- Be respectful and professional in all interactions
- Adhere to HIPAA guidelines (do not share patient information without consent)
- Allow the Foundation to record and share your presentation
- Disclose any conflicts of interest related to your topic"

**Conflict of Interest Disclosure:**
"Do you have any financial relationships (employment, consulting, speaking fees, research funding) related to the topic of your presentation? If yes, please disclose: **\*\***\_**\*\***"

(Conflicts do not disqualify speakers, but must be disclosed to audience)

**Honorarium/Compensation:**

- Determine if speakers will be paid (consider budget)
- Typical range: $0 (volunteer), $250-$1,000 for medical professionals, $1,000-$5,000 for keynote speakers
- If unpaid, provide acknowledgment (certificate, Foundation swag, LinkedIn recommendation)

---

## Virtual Exhibit Hall & Sponsor Integration

### Sponsor Packages for Virtual Events

**Tier 1: Platinum Sponsor ($10,000+)**

- Logo on all event materials (website, emails, slides)
- 10-minute speaking slot or sponsored session
- Premium virtual booth with video, chat, downloads
- Access to attendee list (with opt-in consent)
- Social media promotion (3+ posts)
- Post-event metrics report (booth visits, downloads)

**Tier 2: Gold Sponsor ($5,000-$9,999)**

- Logo on event website and emails
- Standard virtual booth
- 5-minute welcome or closing remarks
- Social media mention (2 posts)
- Lead retrieval (attendees who visit booth)

**Tier 3: Silver Sponsor ($2,500-$4,999)**

- Logo on event website
- Virtual booth (basic)
- Listing in event program
- Social media mention (1 post)

**Tier 4: Bronze Sponsor ($1,000-$2,499)**

- Logo on event website
- Listing in event program

**In-Kind Sponsors:**

- Platform donation (Zoom credits)
- CART services
- Graphic design
- Promotional items for attendees

### Virtual Booth Features

**Platform Options:**

- **Hopin**: Native expo hall with booth builder
- **Whova**: Virtual exhibit hall with sponsor profiles
- **Zoom**: No native booths; use breakout rooms as booth "visits"
- **Custom Landing Page**: Create dedicated sponsor page on Foundation website

**Booth Components:**

**1. Branding:**

- Company logo (high-resolution PNG)
- Banner image (1920x1080px)
- Brand colors

**2. Content:**

- About Us: 150-word company description
- Products/Services: What do you offer AATD patients/providers?
- Resources: Downloadable PDFs, brochures, case studies
- Videos: Product demos, testimonials (2-3 minutes each)
- Links: Website, social media, contact form

**3. Engagement:**

- **Live Chat**: Staff available to answer questions
- **Video Call**: Click-to-connect for 1-on-1 conversations
- **Meeting Scheduler**: Book post-event follow-up calls
- **Polls/Surveys**: "What AAT therapy do you currently use?"
- **Prize Drawing**: Entry form for booth visitors

**4. Analytics:**

- Booth visits (unique and total)
- Time spent in booth
- Downloads (which resources most popular)
- Video views
- Chat interactions
- Contact form submissions

### Sponsor Coordination Process

**3 Months Before Event:**

- [ ] Finalize sponsorship agreements (contract signed, payment received)
- [ ] Send sponsor welcome packet (booth specs, deadlines, logos, contact info)
- [ ] Assign sponsor liaison (staff point person)

**6 Weeks Before:**

- [ ] Request booth materials (logos, descriptions, videos, downloads)
- [ ] Deadline for materials: 4 weeks before event
- [ ] Provide sponsor training on platform (how booth works, analytics)

**4 Weeks Before:**

- [ ] Build sponsor booths in platform
- [ ] Send preview link for sponsor review
- [ ] Make revisions based on feedback
- [ ] Promote sponsors on social media (#ThankYou posts)

**2 Weeks Before:**

- [ ] Final booth approval from sponsors
- [ ] Coordinate staffing schedule (who will monitor chat during event?)
- [ ] Test video calls and chat functionality
- [ ] Add sponsor logos to event slides and emails

**1 Week Before:**

- [ ] Send sponsor reminder email (event details, booth access link)
- [ ] Provide talking points for sponsored speaking slots
- [ ] Coordinate A/V needs for sponsor presentations

**Event Day:**

- [ ] Sponsors log in 30 min early to test booths
- [ ] Promote booths during event ("Visit our sponsors during the break!")
- [ ] Monitor booth activity and alert sponsors to hot leads

**Post-Event:**

- [ ] Send sponsor analytics report (within 3 days)
- [ ] Provide attendee list (opt-in contacts only)
- [ ] Thank-you email with photo recap
- [ ] Request sponsor feedback survey
- [ ] Nurture for next event: "Would you like to sponsor again?"

### Sponsor Presentations & Product Demos

**Guidelines for Sponsor Speakers:**

- **Time Limit**: 5-10 minutes (strictly enforced)
- **Content Balance**: 70% education, 30% product/company
- **No Hard Sells**: Focus on value to attendees, not sales pitch
- **Disclosures**: Clearly identify as sponsored content
- **Approved Topics**: Must be relevant to AATD (no off-topic products)
- **Review Process**: Slides must be approved by Foundation 1 week before event

**Example Good Sponsor Presentation:**
"Managing AATD: Treatment Options and Patient Support" by [Pharma Company]

- Overview of augmentation therapy
- Patient assistance programs
- Q&A with medical science liaison

**Example Bad Sponsor Presentation:**
"Why [Our Drug] is Superior to Competitors" ❌ (Too salesy)

### Ethical Considerations for Sponsors

**Industry Relationships:**

- Be transparent about pharmaceutical and medical device company sponsorships
- Maintain editorial independence (sponsors do not control content)
- Ensure educational content is evidence-based, not promotional
- CME events: Follow ACCME guidelines (no product branding in CME-accredited sessions)

**Patient Advocacy Standards:**

- Patient Advocate Foundation guidelines for corporate partnerships
- National Health Council Standards of Excellence
- Disclose industry funding in annual report

**Avoiding Conflicts of Interest:**

- Speakers with industry ties must disclose
- Multiple sponsors for balance (not exclusive to one company)
- Foundation retains right to refuse sponsors not aligned with mission

---

## Recording Policies & Content Distribution

### Recording Decision Framework

**When to Record:**

- Educational webinars (for on-demand access)
- CME courses (required for certification)
- Conference keynotes and sessions
- Medical professional training
- Research presentations

**When NOT to Record:**

- Support group meetings (confidential, safe space)
- Sensitive patient discussions
- Executive Board meetings
- Donor cultivation events (privacy)
- Advocacy strategy sessions (proprietary)

**Consent Requirements:**

- Notify attendees at registration: "This event will be recorded"
- Verbal reminder at event start
- Visual "Recording" indicator in platform
- Opt-out option: "If you prefer not to be recorded, please keep video off and do not speak"

### Recording Best Practices

**Platform Settings:**

- **Record to Cloud**: Easier to manage and share than local files
- **Record Active Speaker**: Automatically focuses on whoever is speaking
- **Record Gallery View**: Shows all participants (use for small group discussions)
- **Separate Audio**: Record each speaker separately (allows post-production editing)
- **Capture Captions**: Include live captions in recording
- **Capture Chat/Q&A**: Optional; useful for context but review for privacy

**Quality Settings:**

- **Resolution**: 1080p HD preferred, 720p minimum
- **Audio**: 48 kHz, stereo when possible
- **File Format**: MP4 (most compatible) or M4A (audio-only)

**Backup Recording:**

- Always record with 2 methods simultaneously
- Platform cloud recording (primary)
- Local recording on tech director's computer (backup)
- Third-party service (StreamYard, Restream) for redundancy

### Post-Production Editing

**Basic Editing Tasks:**

- Trim beginning/end (remove technical setup and post-event chatter)
- Remove long pauses or technical difficulties
- Add title slide and closing slide (Foundation logo, "Thank You for Watching")
- Add lower-thirds with speaker names and titles
- Insert sponsored logos (if applicable)
- Correct audio levels (normalize volume)

**Advanced Editing:**

- Cut out irrelevant Q&A or off-topic discussions
- Add chapter markers for easy navigation
- Enhance lighting and color correction
- Add B-roll footage (visuals of Foundation work)
- Create short highlight clips for social media

**Editing Tools:**

- **Free**: iMovie (Mac), Windows Video Editor, DaVinci Resolve
- **Paid**: Adobe Premiere Pro ($20/mo), Final Cut Pro ($300 one-time), Camtasia ($250 one-time)
- **AI Tools**: Descript (auto-transcription + editing by text), Kapwing (online video editor)

**Budget:**

- DIY editing: $0 (staff time only)
- Software subscription: $20-$50/month
- Outsource to freelancer: $50-$200/hour (Fiverr, Upwork)

### Captioning & Transcription

**Methods:**

**1. AI Auto-Generated Captions** (Free/Low-Cost)

- Zoom, YouTube, Otter.ai
- 80-90% accuracy
- Requires manual review and correction
- Best for: informal content, tight budgets

**2. Professional Captioning Services**

- Rev.com: $1.50/minute ($90/hour)
- 3Play Media: $2.50-$5/minute
- 99% accuracy
- Turnaround: 24-48 hours
- Best for: CME courses, public-facing content, compliance requirements

**3. Edited AI Captions** (Hybrid Approach)

- Generate AI captions, then hire editor to clean up
- Cost: $0.50-$1/minute
- Balances cost and quality

**Caption File Formats:**

- **SRT**: Most common, works with YouTube, Vimeo, website players
- **VTT**: Web standard, supports styling
- **SCC**: Broadcast standard (for TV/cable distribution)

**Transcript Uses:**

- SEO (search engines index transcript text)
- Accessibility (screen readers, downloadable PDF)
- Content repurposing (blog posts, social media quotes)
- Translation into other languages

### Hosting & Distribution Platforms

**YouTube**

- **Pros**: Free, unlimited storage, massive reach, excellent SEO, built-in captions
- **Cons**: Public by default (requires unlisted/private for proprietary content), ads (unless YouTube Premium)
- **Best For**: Public education content, promotional videos
- **Branding**: Create Foundation YouTube channel, custom thumbnail, description with links

**Vimeo**

- **Pros**: Professional appearance, no ads, privacy controls, password protection
- **Cons**: Storage limits (500GB/year on Plus plan), lower discoverability than YouTube
- **Cost**: $7-$75/month depending on plan
- **Best For**: Member-only content, CME courses, high-quality presentations

**Foundation Website (Self-Hosted)**

- **Pros**: Full control, branded experience, integrate with CRM/LMS
- **Cons**: Bandwidth costs, requires video player plugin, lower SEO than YouTube
- **Tools**: WordPress with video plugin (Presto Player), Wistia (embedding), Vimeo embedded
- **Best For**: Exclusive member content, gated access (email required)

**Learning Management System (LMS)**

- **Platforms**: Thinkific, Teachable, Moodle, LearnDash (WordPress)
- **Features**: Quizzes, certificates, progress tracking, discussion forums
- **Cost**: $39-$499/month
- **Best For**: CME courses with certification, structured learning paths

**Private Access Strategies:**

- **Password-Protected**: Single password shared with registrants
- **Unlisted Link**: Not indexed by search engines, only accessible via link
- **Email-Gated**: Require email to access (builds mailing list)
- **Membership Site**: Login required (WordPress memberships, Patreon)

### Content Repurposing Strategy

**From One 60-Minute Webinar, Create:**

1. **Full Recording** (60 min) - YouTube/Vimeo
2. **Highlight Reel** (3-5 min) - Social media teaser
3. **Individual Segments** (5-10 min each) - "Key Takeaway" series
4. **Audio Podcast Episode** (60 min) - Apple Podcasts, Spotify
5. **Transcript Blog Post** (2,000-5,000 words) - SEO-optimized article
6. **Social Media Quotes** (10-15 graphics) - Instagram/Twitter cards
7. **Infographic** (visual summary) - Pinterest, LinkedIn
8. **Email Newsletter** (500 words) - Key insights + watch link
9. **Press Release** (if newsworthy findings)
10. **Slide Deck** (SlideShare) - Educational resource

**Content Calendar:**

- Day 1: Email recording link to attendees
- Day 3: Post full video to YouTube
- Week 1: Publish blog post with embedded video
- Week 2-4: Share social media clips (2-3 per week)
- Month 2: Launch podcast episode
- Month 3: Feature in newsletter

### Retention & Deletion Policy

**Retention Schedule:**

- **Public Educational Content**: Indefinite (or until outdated)
- **CME Courses**: 6 years (ACCME requirement)
- **Support Group Recordings**: Do not record (or delete immediately if accidental)
- **Internal Trainings**: 3 years
- **Fundraising Events**: 1 year (for testimonials and highlights)

**Deletion Process:**

1. Calendar reminder: 30 days before deletion date
2. Review for archival value: Does historical significance warrant keeping?
3. Backup: If deleting from platform, save to external drive first
4. Secure deletion: Overwrite files (not just "move to trash")
5. Document: Log what was deleted, when, and by whom (compliance)

**Storage Management:**

- Audit storage quarterly
- Compress old files (reduce bitrate for archival copies)
- Migrate to long-term storage (AWS Glacier, Google Archive) for cost savings
- Budget: $0.01/GB/month for archival storage

---

## Analytics & Performance Tracking

### Key Performance Indicators (KPIs)

**Registration & Attendance Metrics:**

- **Registration Rate**: Total registrants ÷ marketing reach
- **Attendance Rate**: Actual attendees ÷ total registrants (Target: 40-60%)
- **Peak Concurrent Attendees**: Maximum attendees at one time
- **Average Session Duration**: How long attendees stayed
- **Drop-off Rate**: Where attendees left (identify weak points)
- **Late Arrivals**: % joining after start (indicates time zone issues or unclear start time)

**Engagement Metrics:**

- **Chat Messages**: Total and per attendee
- **Q&A Questions Submitted**: Indicates interest
- **Poll Participation Rate**: % who voted in polls
- **Reaction Usage**: Likes, claps, thumbs up
- **Breakout Room Participation**: % who joined breakouts
- **Resource Downloads**: Slide deck, factsheets
- **Sponsor Booth Visits**: Engagement with exhibitors

**Satisfaction Metrics:**

- **Net Promoter Score (NPS)**: "How likely are you to recommend this event?" (0-10 scale)
- **Overall Satisfaction**: "How satisfied were you?" (1-5 stars)
- **Content Quality**: "The content was relevant and useful." (Agree/Disagree)
- **Speaker Effectiveness**: "Speakers were knowledgeable and engaging."
- **Technical Quality**: "Audio and video quality were excellent."
- **Likelihood to Attend Future Events**: "I would attend another Foundation event."

**Impact Metrics:**

- **Knowledge Gain** (for educational events): Pre/post-test scores
- **Behavior Change**: "I plan to implement [strategy]" (% agree)
- **CME Credits Earned**: Number of participants who completed requirements
- **Leads Generated**: New donors, volunteers, or partners identified
- **Media Mentions**: Press coverage from event announcements

**Financial Metrics:**

- **Revenue** (if paid event): Ticket sales, sponsorships, donations
- **Cost Per Attendee**: Total event cost ÷ attendees
- **Return on Investment (ROI)**: (Revenue - Cost) ÷ Cost
- **Fundraising Impact** (if applicable): Donations pledged or secured

### Platform Analytics Dashboards

**Zoom Analytics:**

- Dashboard: Reports → Usage → Meetings/Webinars
- Metrics: Attendees, duration, participants list, Q&A, polls, registration sources
- Export: CSV for further analysis

**Hopin Analytics:**

- Dashboard: Event → Analytics
- Metrics: Registrations, attendance, session views, booth visits, networking connections
- Real-time: Monitor live during event
- Export: PDF report or CSV

**Webex Analytics:**

- Dashboard: Reports → Webinars
- Metrics: Attendance, engagement score, survey responses
- Export: Excel

**Custom Analytics Stack:**

- Google Analytics: Track event page visits, registration conversions
- CRM Integration: Sync attendee data to Salesforce/HubSpot for lifecycle tracking
- Survey Tools: Google Forms, Typeform, SurveyMonkey (post-event surveys)
- Data Visualization: Google Data Studio, Tableau (create dashboards)

### Post-Event Survey Design

**Survey Timing:**

- Send within 24 hours (while event is fresh)
- Deadline: 7 days (send reminder at day 5)
- Incentive: Raffle entry for $50 Amazon gift card (boosts response rate)

**Survey Length:**

- Target: 2-3 minutes (8-10 questions)
- Balance: Quantitative (ratings) + qualitative (open-ended)
- Optional: Detailed questions for those wanting to provide more feedback

**Sample Survey Questions:**

**1. Overall Satisfaction** (Required)
"How would you rate your overall experience at [Event Name]?"
☐ Excellent ☐ Good ☐ Fair ☐ Poor

**2. Net Promoter Score** (Required)
"On a scale of 0-10, how likely are you to recommend Mark Egly Foundation events to others?"
0 - Not at all likely ... 10 - Extremely likely

**3. Content Quality** (Required)
"The content was relevant and useful to me."
☐ Strongly Agree ☐ Agree ☐ Neutral ☐ Disagree ☐ Strongly Disagree

**4. Speaker Effectiveness** (Required)
"The speaker(s) were knowledgeable and engaging."
☐ Strongly Agree ☐ Agree ☐ Neutral ☐ Disagree ☐ Strongly Disagree

**5. Technical Quality** (Required)
"The audio and video quality were excellent."
☐ Strongly Agree ☐ Agree ☐ Neutral ☐ Disagree ☐ Strongly Disagree

**6. Accessibility** (Required)
"The event was accessible and inclusive (captions, ASL, etc.)."
☐ Strongly Agree ☐ Agree ☐ Neutral ☐ Disagree ☐ Strongly Disagree ☐ N/A

**7. Future Attendance** (Required)
"I would attend another Mark Egly Foundation event."
☐ Definitely ☐ Probably ☐ Maybe ☐ Probably Not ☐ Definitely Not

**8. Topic Interests** (Optional)
"What topics would you like to see in future events?" (Multi-select)
☐ Treatment options ☐ Genetic counseling ☐ Caregiver support ☐ Advocacy training ☐ Research updates ☐ Other: ****\_\_\_****

**9. Best Part** (Optional, open-ended)
"What was the best part of the event?"

**10. Improvements** (Optional, open-ended)
"How could we improve future events?"

**11. Follow-Up Interest** (Optional)
"I'm interested in: (check all that apply)"
☐ Joining a support group ☐ Volunteering ☐ Making a donation ☐ Becoming an advocate ☐ None at this time

### Reporting & Stakeholder Communication

**Internal Debrief Report** (Within 3 Days)

- Executive summary (1 page)
- Key metrics vs. goals
- What went well / What needs improvement
- Action items for next event
- Budget actual vs. projected

**Board Report** (Within 2 Weeks)

- Event overview (purpose, audience, topic)
- Attendance and engagement highlights
- Testimonials and success stories
- Financial summary (revenue, expenses, ROI)
- Impact on mission (lives touched, knowledge shared)

**Sponsor Report** (Within 3 Days)

- Thank you for partnership
- Attendance numbers
- Sponsor booth analytics (visits, downloads, engagement)
- Lead list (opt-in attendees)
- Social media mentions and reach
- Photos and video clips featuring sponsor
- Invitation to sponsor next event

**Public Report** (Within 1 Month)

- Blog post or newsletter article
- Highlight key insights from speakers
- Attendee testimonials
- Photos and video clips
- Recording link (if public)
- Upcoming events announcement

### Benchmarking & Goal Setting

**Industry Benchmarks (Nonprofit Virtual Events):**

- **Attendance Rate**: 40-60% of registrants show up
- **Engagement**: 30-50% participate in polls/Q&A
- **Survey Response Rate**: 20-30%
- **NPS Score**: 30-50 (good), 50-70 (excellent), 70+ (world-class)
- **Drop-off**: 20-30% leave before end (60-min webinar)

**SMART Goals for Next Event:**

- **Specific**: "Increase attendance rate from 45% to 55%"
- **Measurable**: Track via registration and platform analytics
- **Achievable**: Based on past performance and improvements
- **Relevant**: Supports Foundation's goal to reach more AATD patients
- **Time-bound**: For next quarterly webinar (3 months)

**Continuous Improvement Loop:**

1. **Measure**: Collect data on current performance
2. **Analyze**: Identify gaps vs. goals or benchmarks
3. **Hypothesize**: "If we send more reminder emails, attendance will increase"
4. **Test**: Implement change for next event
5. **Evaluate**: Did the change work? Why or why not?
6. **Iterate**: Keep what works, refine what doesn't

---

## Budget & Cost Management

### Typical Virtual Event Costs

#### Small Webinar (50-100 Attendees)

**Platform Costs:**

- Zoom Pro + Webinar Add-on (100): $95/month = **$95**
- Registration (Eventbrite Free): **$0**
- **Subtotal: $95**

**Production Costs:**

- Staff time (10 hours @ $25/hr): $250
- Speaker honorarium: $0-$500 (often volunteer)
- CART Captions (1 hour): $180
- Graphic design (promotional images): $100
- **Subtotal: $530-$1,030**

**Marketing:**

- Email marketing (Mailchimp): Included
- Social media ads: $50-$200
- **Subtotal: $50-$200**

**Total: $675-$1,325**
**Cost Per Attendee: $7-$26** (assuming 50 attendees)

#### Medium Conference (200-500 Attendees)

**Platform Costs:**

- Zoom Events (500 attendees): $1,490/year = **$125/event** (if monthly)
- OR Hopin (500 attendees): **$800/event**
- Eventbrite (free for free events): **$0**
- **Subtotal: $125-$800**

**Production Costs:**

- Staff time (40 hours @ $25/hr): $1,000
- Speaker honorariums (3 speakers x $500): $1,500
- CART Captions (3 hours): $540
- ASL Interpreters (2 x 3 hrs x $75/hr): $450
- Graphic design & branding: $300
- Video editing (post-production): $500
- **Subtotal: $4,290**

**Marketing:**

- Email campaigns: $100
- Social media ads: $300-$500
- Influencer partnerships: $200
- **Subtotal: $600-$800**

**Sponsorship (Offset):**

- 2 sponsors x $2,500: -$5,000

**Net Cost: $815-$1,890** (after sponsorships)
**Cost Per Attendee: $2-$9** (assuming 200 attendees)

#### Large Multi-Day Conference (500-1,000 Attendees)

**Platform Costs:**

- Hopin (Business plan): **$5,000**
- Custom branding & setup: **$1,000**
- **Subtotal: $6,000**

**Production Costs:**

- Staff time (120 hours @ $30/hr): $3,600
- Speaker honorariums (10 speakers x $1,000): $10,000
- CART Captions (12 hours): $2,160
- ASL Interpreters (4 interpreters x 12 hrs x $75/hr): $3,600
- Graphic design, branding, video production: $2,000
- Video editing (post-event): $1,500
- Technical director (contractor, 20 hrs @ $50/hr): $1,000
- **Subtotal: $23,860**

**Marketing:**

- Email campaigns: $300
- Social media ads: $1,000-$2,000
- PR agency (media outreach): $2,000
- Influencer partnerships: $500
- **Subtotal: $3,800-$4,800**

**Sponsorship (Offset):**

- 5 sponsors (average $7,500 each): -$37,500

**Net Revenue: +$3,840 to +$4,840** (profitable event!)
**Or, if no sponsorships:**
**Net Cost: $33,660-$34,660**
**Cost Per Attendee: $34-$69** (assuming 500 attendees)

### Budget Templates

**Annual Virtual Events Budget (Foundation-Wide)**

| Event                                  | Frequency | Attendees | Cost Per Event | Annual Cost  |
| -------------------------------------- | --------- | --------- | -------------- | ------------ |
| Monthly Patient Webinar                | 12x/year  | 75        | $800           | $9,600       |
| Quarterly Support Groups               | 4x/year   | 30        | $400           | $1,600       |
| CME Course (Medical Professionals)     | 4x/year   | 200       | $2,000         | $8,000       |
| Annual Conference                      | 1x/year   | 500       | $30,000        | $30,000      |
| Advocacy Training                      | 2x/year   | 100       | $1,200         | $2,400       |
| **Total Annual Virtual Events Budget** |           |           |                | **$51,600**  |
| **Less: Sponsorships**                 |           |           |                | **-$20,000** |
| **Net Annual Cost**                    |           |           |                | **$31,600**  |

### Cost-Saving Strategies

**1. Leverage Volunteers:**

- Recruit tech-savvy volunteers for moderator roles
- Patient advocates as co-hosts (reduces staff burden)
- Retired professionals for pro bono speaker roles

**2. Use Free/Low-Cost Tools:**

- Zoom Basic (free for <40 min meetings) for small support groups
- Google Meet (free for <60 min, unlimited attendees)
- Canva (free graphic design) vs. hiring designer
- YouTube (free hosting) vs. paid Vimeo
- Google Forms (free surveys) vs. SurveyMonkey

**3. Negotiate Vendor Discounts:**

- Nonprofit discounts (many platforms offer 10-30% off)
- Annual plans vs. monthly (typically 20% savings)
- Bundle services (CART + transcription from same vendor)
- In-kind sponsorships (platform credits, CART services)

**4. Repurpose Content:**

- One live event = 10+ pieces of content (see Section 12)
- Reduces need for constant new content creation
- Maximizes value per dollar spent

**5. Shared Resources:**

- Partner with other AATD organizations to co-host events (split costs)
- Join purchasing cooperatives (group buying power)

**6. DIY Where Possible:**

- Staff-produced graphics (Canva templates)
- Internal video editing (iMovie, DaVinci Resolve)
- Social media management (no agency fees)

**7. Measure and Optimize:**

- Cut underperforming marketing channels
- Focus budget on high-ROI activities
- Track cost per attendee and reduce over time

### Pricing Strategy for Paid Events

**When to Charge:**

- CME courses (professionals expect to pay for credits)
- Premium content (celebrity speakers, exclusive research)
- Multi-day conferences with extensive programming
- Fundraising galas (ticket price is donation)

**When to Keep Free:**

- Patient education (accessibility and mission alignment)
- Support groups (remove barriers to participation)
- Advocacy training (want maximum participation)
- Webinars funded by sponsors (no need to charge)

**Pricing Tiers:**

- **Early Bird**: $25 (first 100 registrants, 4+ weeks before)
- **Standard**: $50 (2-4 weeks before)
- **Late/Day-of**: $75 (0-2 weeks before)
- **Group Rate**: $40/person (5+ attendees from same organization)
- **Nonprofit/Student**: $20 (discounted for limited budgets)
- **Patient/Caregiver**: $0-$10 (subsidized or free)

**Financial Aid:**

- "No one turned away for lack of funds" policy
- Scholarship applications (simple form, no extensive justification required)
- Anonymous donation fund to cover scholarships

### Grant Funding for Virtual Events

**Grant Opportunities:**

- **Patient-Centered Outcomes Research Institute (PCORI)**: Engagement awards
- **National Organization for Rare Disorders (NORD)**: Patient organization grants
- **Pharmaceutical Company Sponsorships**: Educational grants (unrestricted)
- **Corporate Foundations**: Technology access grants (Google, Microsoft, Zoom)
- **Local Community Foundations**: Health education programs

**Grant Application Tips:**

- Emphasize reach and impact (how many patients served)
- Highlight accessibility (captions, ASL, underserved populations)
- Demonstrate sustainability (how event series continues long-term)
- Include evaluation plan (how you'll measure success)

---

## Platform-Specific Guides

### Zoom: Step-by-Step Setup

**Account Setup:**

1. Sign up at zoom.us with Foundation email
2. Choose Pro plan ($15.99/month) minimum
3. Enable Single Sign-On (SSO) if using Google Workspace
4. Set up two-factor authentication (2FA)

**Security Settings:** 5. Go to Settings → Security 6. Enable: Waiting room, passcode, encryption 7. Disable: Join before host, file transfer 8. Set screen sharing to "Host only" by default

**Webinar Setup (for large events):** 9. Purchase Webinar add-on (pricing by capacity) 10. Schedule New Webinar 11. Configure: Date, time, duration, panelists 12. Enable: Registration, Q&A, polls, live stream (if applicable) 13. Customize: Registration form fields, email templates 14. Add panelists/speakers by email 15. Create polls in advance 16. Set up practice session (for rehearsal)

**Day-of Checklist:** 17. Start webinar 30 minutes early 18. Admit panelists from waiting room 19. Test audio/video with each panelist 20. Start recording (to cloud) 21. Admit attendees 10 minutes before start 22. Welcome message in chat 23. Begin on time with host introduction

**Post-Event:** 24. Stop recording 25. Export Q&A and poll reports 26. Download recording from cloud (within 30 days) 27. Generate attendee report (email, join time, duration)

### Hopin: Conference Setup

**Event Creation:**

1. Sign up at hopin.com
2. Create new event → Choose "Multi-track" or "Single-track"
3. Set event name, date, time zone, URL
4. Design event page (branding, description, cover image)

**Build Event Structure:** 5. Add Stages (main sessions, tracks) 6. Add Sessions (individual presentations within stages) 7. Add Expo booths (sponsors/exhibitors) 8. Add Networking area 9. Set up registration form

**Speaker/Sponsor Management:** 10. Invite speakers as "Organizers" (they get backstage access) 11. Invite sponsors as "Exhibitors" (they get booth access) 12. Provide guidelines and training materials

**Attendee Experience:** 13. Test attendee view (use separate email/incognito mode) 14. Ensure navigation is clear (Reception → Stages → Expo) 15. Customize lobby with welcome message and schedule

**Day-of Management:** 16. Go live 1 hour early for tech checks 17. Monitor real-time analytics dashboard 18. Assign moderators to each stage 19. Check sponsor booths are staffed 20. Make announcements via broadcast feature

**Post-Event:** 21. Export analytics (attendance, engagement, leads) 22. Download recordings from each stage 23. Send sponsor reports (booth visits, interactions) 24. Survey attendees

### Microsoft Teams Live Events

**Prerequisites:**

1. Microsoft 365 E3 or E5 license
2. Teams admin enables Live Events feature
3. Producer role assigned to organizers

**Schedule Live Event:** 4. Teams → Calendar → New Meeting → Live Event 5. Choose permissions (Org-wide, Public, or People & Groups) 6. Set date, time, presenters, producers 7. Enable: Q&A, recording, captions

**Customize:** 8. Upload custom event image 9. Add attendee engagement report 10. Set event options (video on-demand after live)

**Produce Event:** 11. Join as Producer 30 min early 12. Invite presenters to green room 13. Check audio/video in queue 14. Share screens or video feeds to live audience 15. Moderate Q&A in producer view 16. End broadcast

**Post-Event:** 17. Recording available in Stream (Microsoft video platform) 18. Generate attendee and engagement report 19. Download Q&A transcript

---

## Troubleshooting & Contingency Planning

### Common Technical Issues

**Problem: Platform Outage**
**Symptoms**: Cannot log in, service unavailable error
**Solution**:

- Check platform status page (e.g., status.zoom.us)
- Switch to backup platform (pre-scheduled backup Zoom link)
- Communicate via email and social media
- Reschedule if outage persists >15 minutes

**Problem: Poor Internet Connection**
**Symptoms**: Frozen video, choppy audio, dropped calls
**Solution**:

- Speaker switches to wired ethernet (if on Wi-Fi)
- Turn off HD video, disable virtual background
- Close all other applications
- Switch to backup device or hotspot
- Audio-only mode as last resort

**Problem: Audio Echo/Feedback**
**Symptoms**: Echo, screeching sound
**Solution**:

- Identify source: someone has both computer speakers and phone dial-in active
- Mute all participants except speaker
- Speaker uses headphones (not computer speakers)
- Check for multiple devices in same room connected to meeting

**Problem: Screen Share Not Working**
**Symptoms**: Attendees see black screen, "Share Screen" button grayed out
**Solution**:

- Stop and restart screen share
- Share specific application window (not entire screen)
- Check screen recording permissions (Mac System Preferences)
- Grant browser permission to share screen
- Use alternative method: upload slides to platform in advance

**Problem: Presenter No-Show**
**Symptoms**: Speaker doesn't join 5 minutes before scheduled time
**Solution**:

- Call/text speaker immediately
- Stall with ice-breaker poll or video
- Backup host delivers presentation (have backup slides)
- Reschedule segment if critical content
- Always have backup speaker identified

**Problem: Disruptive Participant**
**Symptoms**: Spamming chat, inappropriate content, shouting
**Solution**:

- Mute participant
- Disable their video
- Remove from meeting
- Enable "Mute upon entry" for all future attendees
- Report to platform if serious violation

### Crisis Communication Templates

**Platform Failure Announcement (Social Media):**
"We're experiencing technical difficulties with today's [Event Name]. Our team is working to resolve this. Please stand by, and check your email for updates. We apologize for the inconvenience."

**Postponement Email:**
**Subject**: [Event Name] Rescheduled to [New Date]

Dear [Name],

Due to unforeseen technical issues, we've decided to reschedule [Event Name] from [Original Date] to [New Date] at [New Time].

Your registration remains valid for the new date. If you cannot attend the new date, please reply to this email for a refund [if paid event].

We apologize for any inconvenience and look forward to seeing you on [New Date].

Best regards,
[Name]
Mark Egly Foundation

### Emergency Contact List

**Internal Team:**

- Executive Director: [Phone]
- Director of Communications: [Phone]
- IT Manager: [Phone]
- Backup Host: [Phone]

**External Vendors:**

- Zoom Technical Support: 1-888-799-9666
- CART Captioning Service: [Phone]
- ASL Interpreter: [Phone]
- Platform Account Manager: [Phone]

**Keep This List:**

- Printed and available during all events
- Saved in team shared drive
- Accessible on mobile devices

---

## Conclusion & Continuous Improvement

### Document Review & Updates

**Review Schedule:**

- **Quarterly**: Minor updates (new features, pricing changes)
- **Annually**: Major revision (reflect lessons learned from past year)
- **After Major Platform Changes**: Update relevant sections immediately
- **Post-Incident**: If significant technical issue, update troubleshooting section

**Ownership:**

- **Document Owner**: Director of Communications & Events
- **Contributors**: IT Manager, Accessibility Coordinator, Event Staff
- **Approval**: Executive Director

**Version Control:**

- Maintain version history (v1.0, v1.1, v2.0)
- Log changes in header (e.g., "v1.1 - Updated Zoom pricing, added Teams guide")
- Archive old versions for reference

### Continuous Learning

**Stay Current:**

- Attend webinars on virtual event best practices
- Join professional associations (Professional Convention Management Association, Event Leadership Institute)
- Follow thought leaders (Brandt Krueger, Tahira Endean, Will Curran)
- Test new platforms and features quarterly

**Benchmark Against Others:**

- Attend other nonprofits' virtual events (observe what works)
- Survey attendees: "What other virtual events have you enjoyed?"
- Industry reports (Markletic, Bizzabo, EventMB annual surveys)

**Foster Innovation:**

- Encourage staff to experiment with new engagement techniques
- Budget for pilot projects (test new platforms with small events first)
- Create feedback loop: Staff → Attendees → Continuous improvement

### Final Thoughts

Virtual events have transformed how the Mark Egly Foundation connects with AATD patients, caregivers, and medical professionals. By following the guidelines in this document, we can deliver high-quality, accessible, and impactful virtual experiences that advance our mission to end diagnostic delays and improve outcomes.

**Remember:**

- **Patient-Centered**: Every decision should benefit those we serve
- **Accessible**: Inclusion is non-negotiable
- **Professional**: Quality reflects our credibility
- **Measurable**: Track and optimize based on data
- **Adaptable**: Stay flexible and embrace new technologies

**Questions or Suggestions?**
Contact: [Director of Communications email]
Last Updated: November 10, 2025

---

## Appendices

### Appendix A: Sample Run-of-Show Template

**Event**: [Event Name]
**Date**: [Date]
**Duration**: [Total Time]
**Platform**: [Zoom/Hopin/Other]
**Recording**: Yes/No

| Time     | Duration | Activity                | Responsible        | Notes                       |
| -------- | -------- | ----------------------- | ------------------ | --------------------------- |
| 9:00 AM  | 30 min   | Pre-event tech check    | Tech Director      | Speakers test A/V           |
| 9:30 AM  | 10 min   | Waiting room opens      | Host               | Welcome message in chat     |
| 9:40 AM  | 5 min    | All staff join          | All                | Final coordination          |
| 9:45 AM  | 5 min    | Attendees admitted      | Host               | Music playing               |
| 9:50 AM  | 3 min    | Welcome & housekeeping  | Host               | Mute, Q&A, captions         |
| 9:53 AM  | 2 min    | Introduce Speaker 1     | Host               | Read bio                    |
| 9:55 AM  | 20 min   | Presentation: Speaker 1 | Speaker 1          | "AATD Basics"               |
| 10:15 AM | 5 min    | Poll #1                 | Tech Director      | "How long since diagnosis?" |
| 10:20 AM | 15 min   | Q&A for Speaker 1       | Host + Speaker 1   | Mod selects questions       |
| 10:35 AM | 5 min    | Break                   | Host               | "Back at 10:40"             |
| 10:40 AM | 20 min   | Presentation: Speaker 2 | Speaker 2          | "Treatment Options"         |
| 11:00 AM | 5 min    | Poll #2                 | Tech Director      | "Current treatment?"        |
| 11:05 AM | 15 min   | Q&A for Speaker 2       | Host + Speaker 2   |                             |
| 11:20 AM | 5 min    | Closing remarks         | Executive Director | Thank sponsors, survey link |
| 11:25 AM | 5 min    | End event               | Host               | Stop recording              |

### Appendix B: Virtual Event Checklist

**8 Weeks Before:**

- [ ] Define event goals and target audience
- [ ] Choose date and time (check conflicts)
- [ ] Select platform and register account
- [ ] Sign HIPAA BAA (if applicable)
- [ ] Confirm speakers and topics
- [ ] Create event budget

**6 Weeks Before:**

- [ ] Design promotional graphics
- [ ] Set up registration page
- [ ] Launch marketing campaign (email, social)
- [ ] Book CART captioning service
- [ ] Book ASL interpreters (if needed)

**4 Weeks Before:**

- [ ] Collect speaker bios and headshots
- [ ] Request presentation slides
- [ ] Schedule tech rehearsal
- [ ] Create polls and Q&A questions
- [ ] Finalize sponsor agreements

**2 Weeks Before:**

- [ ] Send reminder email #1 to registrants
- [ ] Conduct tech rehearsal with speakers
- [ ] Finalize run-of-show document
- [ ] Prepare moderator scripts
- [ ] Test accessibility features

**1 Week Before:**

- [ ] Send reminder email #2
- [ ] Provide final instructions to speakers
- [ ] Test platform with full production team
- [ ] Prepare backup plans
- [ ] Print emergency contact list

**24 Hours Before:**

- [ ] Send final reminder email (#3)
- [ ] Confirm CART and ASL services
- [ ] Load all materials into platform
- [ ] Charge all devices
- [ ] Prepare physical space (lighting, camera, etc.)

**Event Day (2 Hours Before):**

- [ ] Production team logs in
- [ ] Systems check (recording, captions, polls)
- [ ] Speakers log in (30 min before)
- [ ] Open waiting room (15 min before)
- [ ] Start recording
- [ ] Begin event on time

**Post-Event (24-48 Hours):**

- [ ] Send thank-you email with recording link
- [ ] Send post-event survey
- [ ] Provide sponsor reports
- [ ] Download and backup recording
- [ ] Export analytics
- [ ] Conduct team debrief
- [ ] Pay invoices (speakers, CART, etc.)
- [ ] Update this guide with lessons learned

### Appendix C: Equipment Shopping List

**Recommended Equipment for Foundation Event Production:**

**Video:**

- Logitech Brio 4K Webcam ($200)
- Elgato Cam Link (capture DSLR as webcam, $130)
- Elgato Key Light (lighting, $200)

**Audio:**

- Blue Yeti USB Microphone ($130)
- Audio-Technica ATR2100x-USB ($100)
- Sony MDR-7506 Headphones ($100)

**Accessories:**

- Boom arm for microphone ($30)
- Pop filter ($15)
- Green screen backdrop ($50)
- Tripod for camera ($40)

**Backup:**

- Mobile hotspot device ($100 + data plan)
- Backup laptop ($500-$1,000)

**Total Investment: ~$1,600-$2,100** (one-time cost for high-quality setup)

### Appendix D: Platform Comparison Spreadsheet

[Link to Google Sheet: Foundation Virtual Event Platform Comparison]
(This would be a living document tracking pricing, features, and reviews of all major platforms)

---

**End of Virtual Event Platform Guide**

_Mark Egly Foundation | Version 1.0 | November 10, 2025_
