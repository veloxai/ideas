# Uniting Doctors - API Specification

**Version**: 1.0
**Last Updated**: November 8, 2025
**Base URL**: `https://api.unitingdoctors.com/v1`
**Authentication**: OAuth 2.0 + JWT

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Authentication](#authentication)
3. [Common Patterns](#common-patterns)
4. [Endpoints](#endpoints)
   - [Authentication](#authentication-endpoints)
   - [Users](#user-endpoints)
   - [Posts](#post-endpoints)
   - [Comments](#comment-endpoints)
   - [Votes](#vote-endpoints)
   - [Groups](#group-endpoints)
   - [Research](#research-endpoints)
   - [Search](#search-endpoints)
   - [Notifications](#notification-endpoints)
   - [Moderation](#moderation-endpoints)
5. [Webhooks](#webhooks)
6. [Rate Limiting](#rate-limiting)
7. [Error Codes](#error-codes)
8. [SDK Libraries](#sdk-libraries)

---

## 🎯 Overview

The Uniting Doctors API is a RESTful API that enables medical professionals to interact with the platform programmatically. All endpoints return JSON responses and use standard HTTP status codes.

### Base URLs

| Environment     | URL                                         |
| --------------- | ------------------------------------------- |
| **Production**  | `https://api.unitingdoctors.com/v1`         |
| **Staging**     | `https://api-staging.unitingdoctors.com/v1` |
| **Development** | `http://localhost:3000/v1`                  |

### API Versioning

- API version is specified in the URL path (`/v1/`)
- Breaking changes will result in a new version (`/v2/`)
- Old versions supported for 12 months after deprecation

---

## 🔐 Authentication

### OAuth 2.0 Flow

Uniting Doctors uses OAuth 2.0 with Authorization Code flow for third-party applications.

#### Step 1: Authorization Request

```http
GET /oauth/authorize
  ?client_id={CLIENT_ID}
  &redirect_uri={REDIRECT_URI}
  &response_type=code
  &scope=read write
  &state={RANDOM_STATE}
```

**Scopes**:

- `read`: Read public and user's own content
- `write`: Create and update content
- `profile`: Access user profile information
- `admin`: Administrative actions (requires admin role)

#### Step 2: Authorization Code Exchange

```http
POST /oauth/token
Content-Type: application/json

{
  "grant_type": "authorization_code",
  "code": "AUTH_CODE",
  "client_id": "CLIENT_ID",
  "client_secret": "CLIENT_SECRET",
  "redirect_uri": "REDIRECT_URI"
}
```

**Response**:

```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "REFRESH_TOKEN",
  "scope": "read write"
}
```

### JWT Token Authentication

Once you have an access token, include it in the `Authorization` header:

```http
Authorization: Bearer {ACCESS_TOKEN}
```

### Token Refresh

```http
POST /oauth/token
Content-Type: application/json

{
  "grant_type": "refresh_token",
  "refresh_token": "REFRESH_TOKEN",
  "client_id": "CLIENT_ID",
  "client_secret": "CLIENT_SECRET"
}
```

---

## 🔄 Common Patterns

### Pagination

All list endpoints support cursor-based pagination:

**Request**:

```http
GET /v1/posts?limit=20&cursor=eyJpZCI6IjEyMyJ9
```

**Response**:

```json
{
  "data": [...],
  "pagination": {
    "next_cursor": "eyJpZCI6IjE0MyJ9",
    "has_more": true,
    "total": 1500
  }
}
```

**Parameters**:

- `limit` (integer, optional): Items per page (default: 20, max: 100)
- `cursor` (string, optional): Cursor for next page

### Filtering & Sorting

**Filtering**:

```http
GET /v1/posts?specialty=cardiology&evidence_level=1a
```

**Sorting**:

```http
GET /v1/posts?sort_by=upvotes&order=desc
```

Common sort fields: `created_at`, `updated_at`, `upvotes`, `relevance`

### Expansion

Use `expand` to include related resources in a single request:

```http
GET /v1/posts/123?expand=author,comments
```

### Standard Response Format

**Success Response**:

```json
{
  "success": true,
  "data": { ... }
}
```

**Error Response**:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": {
      "field": "email",
      "reason": "required"
    }
  }
}
```

---

## 📍 Endpoints

### Authentication Endpoints

#### POST /auth/register

Register a new user account

**Request**:

```json
{
  "email": "doctor@example.com",
  "password": "SecurePass123!",
  "display_name": "Dr. Anonymous",
  "specialty_ids": [1, 5],
  "practice_setting": "academic"
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "data": {
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "doctor@example.com",
      "display_name": "Dr. Anonymous",
      "verification_status": "pending",
      "reputation": 0,
      "created_at": "2025-11-08T10:30:00Z"
    },
    "access_token": "eyJhbGci...",
    "refresh_token": "..."
  }
}
```

#### POST /auth/login

Authenticate user

**Request**:

```json
{
  "email": "doctor@example.com",
  "password": "SecurePass123!"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbGci...",
    "refresh_token": "...",
    "expires_in": 3600,
    "user": { ... }
  }
}
```

#### POST /auth/logout

Invalidate current session

**Request**:

```json
{
  "refresh_token": "..."
}
```

**Response** (204 No Content)

#### POST /auth/forgot-password

Request password reset

**Request**:

```json
{
  "email": "doctor@example.com"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "message": "Password reset email sent"
}
```

---

### User Endpoints

#### GET /users/me

Get current user profile

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "doctor@example.com",
    "display_name": "Dr. Anonymous",
    "specialties": [
      {
        "id": 1,
        "name": "Cardiology",
        "category": "Medicine"
      }
    ],
    "verification_status": "verified",
    "reputation": 1250,
    "reputation_tier": "gold",
    "badges": [
      {
        "id": "educator",
        "name": "Educator",
        "description": "10 accepted answers",
        "earned_at": "2025-10-15T14:20:00Z"
      }
    ],
    "statistics": {
      "posts_count": 45,
      "comments_count": 234,
      "upvotes_received": 890,
      "questions_asked": 5,
      "answers_given": 67
    },
    "created_at": "2025-08-01T10:00:00Z",
    "updated_at": "2025-11-08T09:15:00Z"
  }
}
```

#### PATCH /users/me

Update current user profile

**Request**:

```json
{
  "display_name": "CardioExpert2024",
  "bio": "Interventional cardiologist interested in structural heart disease",
  "specialty_ids": [1, 15],
  "practice_setting": "academic",
  "notification_preferences": {
    "email_digest": "daily",
    "push_notifications": true,
    "comment_replies": true,
    "post_mentions": true
  }
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": { ... }
}
```

#### GET /users/:userId

Get public user profile

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "display_name": "Dr. Anonymous",
    "specialties": [...],
    "reputation": 1250,
    "reputation_tier": "gold",
    "badges": [...],
    "statistics": {
      "posts_count": 45,
      "upvotes_received": 890
    },
    "member_since": "2025-08-01T10:00:00Z"
  }
}
```

**Note**: Email and personal information are never exposed publicly.

#### POST /users/me/verification

Submit verification documents

**Request** (multipart/form-data):

```
document_type: "medical_license"
document_file: [binary file]
npi_number: "1234567890"
license_number: "MD-12345"
issuing_state: "CA"
```

**Response** (202 Accepted):

```json
{
  "success": true,
  "data": {
    "verification_request_id": "ver_abc123",
    "status": "pending",
    "estimated_review_time": "24-48 hours",
    "submitted_at": "2025-11-08T10:30:00Z"
  }
}
```

---

### Post Endpoints

#### GET /posts

List posts (feed)

**Query Parameters**:

- `limit` (integer): Posts per page (default: 20, max: 100)
- `cursor` (string): Pagination cursor
- `specialty` (string): Filter by specialty
- `evidence_level` (string): Filter by evidence level (1a, 1b, 2, 3, 4, 5)
- `sort_by` (string): `recent`, `top`, `trending` (default: `recent`)
- `is_question` (boolean): Filter questions only
- `is_answered` (boolean): Filter answered/unanswered questions

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "post_abc123",
      "author": {
        "id": "user_xyz789",
        "display_name": "CardioExpert2024",
        "reputation": 1250,
        "reputation_tier": "gold",
        "is_verified": true,
        "specialties": ["Cardiology"]
      },
      "content": "Novel approach to refractory AFib in ICU patients...",
      "content_html": "<p>Novel approach to refractory AFib...</p>",
      "is_anonymous": false,
      "is_question": false,
      "evidence_level": "4",
      "tags": [
        { "id": 1, "name": "Cardiology" },
        { "id": 45, "name": "Arrhythmia" }
      ],
      "statistics": {
        "upvotes": 234,
        "downvotes": 5,
        "comment_count": 67,
        "view_count": 2340,
        "bookmark_count": 89
      },
      "user_actions": {
        "has_upvoted": false,
        "has_downvoted": false,
        "has_bookmarked": true
      },
      "created_at": "2025-11-08T08:30:00Z",
      "updated_at": "2025-11-08T08:30:00Z"
    }
  ],
  "pagination": {
    "next_cursor": "eyJpZCI6IjE0MyJ9",
    "has_more": true
  }
}
```

#### POST /posts

Create a new post

**Request**:

```json
{
  "content": "Discussing novel AFib management...",
  "is_anonymous": false,
  "is_question": false,
  "evidence_level": "4",
  "tag_ids": [1, 45],
  "images": [
    {
      "url": "https://cdn.unitingdoctors.com/images/abc123.jpg",
      "alt_text": "EKG showing AFib with RVR"
    }
  ],
  "references": [
    {
      "type": "pubmed",
      "pmid": "12345678",
      "citation": "Smith J, et al. JAMA. 2023;329(5):456-463."
    }
  ]
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "data": {
    "id": "post_abc123",
    "author": { ... },
    "content": "Discussing novel AFib management...",
    "is_anonymous": false,
    "evidence_level": "4",
    "tags": [...],
    "created_at": "2025-11-08T10:30:00Z",
    "url": "https://unitingdoctors.com/posts/abc123"
  }
}
```

#### GET /posts/:postId

Get single post with details

**Query Parameters**:

- `expand` (string): Comma-separated list (`author`, `comments`, `references`)

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "id": "post_abc123",
    "author": { ... },
    "content": "...",
    "content_html": "<p>...</p>",
    "is_anonymous": false,
    "evidence_level": "4",
    "tags": [...],
    "images": [...],
    "references": [
      {
        "id": "ref_123",
        "type": "pubmed",
        "pmid": "12345678",
        "title": "Management of atrial fibrillation",
        "authors": ["Smith J", "Doe A"],
        "journal": "JAMA",
        "year": 2023,
        "citation": "Smith J, et al. JAMA. 2023;329(5):456-463.",
        "url": "https://pubmed.ncbi.nlm.nih.gov/12345678/"
      }
    ],
    "comments": [...],  // If expanded
    "statistics": {
      "upvotes": 234,
      "downvotes": 5,
      "comment_count": 67,
      "view_count": 2340,
      "bookmark_count": 89
    },
    "user_actions": {
      "has_upvoted": false,
      "has_downvoted": false,
      "has_bookmarked": true
    },
    "created_at": "2025-11-08T08:30:00Z",
    "updated_at": "2025-11-08T08:30:00Z"
  }
}
```

#### PATCH /posts/:postId

Update existing post

**Request**:

```json
{
  "content": "Updated content with new findings...",
  "evidence_level": "2",
  "tag_ids": [1, 45, 67]
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": { ... }
}
```

#### DELETE /posts/:postId

Delete post

**Response** (204 No Content)

---

### Comment Endpoints

#### GET /posts/:postId/comments

Get comments for a post

**Query Parameters**:

- `sort_by` (string): `best`, `newest`, `oldest` (default: `best`)
- `limit` (integer): Comments per page
- `cursor` (string): Pagination cursor

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "comment_xyz789",
      "post_id": "post_abc123",
      "parent_id": null,
      "author": {
        "id": "user_123",
        "display_name": "EmergencyMD",
        "reputation": 980,
        "reputation_tier": "silver",
        "is_verified": true,
        "specialties": ["Emergency Medicine"]
      },
      "content": "Great point! One caution...",
      "content_html": "<p>Great point! One caution...</p>",
      "statistics": {
        "upvotes": 89,
        "downvotes": 2,
        "reply_count": 3
      },
      "user_actions": {
        "has_upvoted": true,
        "has_downvoted": false
      },
      "is_accepted": false,
      "is_op_reply": false,
      "created_at": "2025-11-08T09:00:00Z",
      "updated_at": "2025-11-08T09:00:00Z",
      "replies": [
        {
          "id": "comment_abc456",
          "parent_id": "comment_xyz789",
          "author": { ... },
          "content": "Thanks for this insight...",
          "statistics": { ... },
          "created_at": "2025-11-08T09:15:00Z"
        }
      ]
    }
  ],
  "pagination": { ... }
}
```

#### POST /posts/:postId/comments

Create a comment

**Request**:

```json
{
  "content": "This is a great discussion...",
  "parent_id": null, // null for top-level, or comment_id for reply
  "references": [
    {
      "type": "pubmed",
      "pmid": "12345678"
    }
  ]
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "data": {
    "id": "comment_xyz789",
    "post_id": "post_abc123",
    "content": "This is a great discussion...",
    "author": { ... },
    "created_at": "2025-11-08T10:30:00Z"
  }
}
```

#### PATCH /comments/:commentId

Update comment

**Request**:

```json
{
  "content": "Updated comment text..."
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": { ... }
}
```

#### DELETE /comments/:commentId

Delete comment

**Response** (204 No Content)

#### POST /comments/:commentId/accept

Accept answer (for question posts, by OP only)

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "comment": { ... },
    "reputation_awarded": 50
  }
}
```

---

### Vote Endpoints

#### POST /posts/:postId/vote

Vote on a post

**Request**:

```json
{
  "vote_type": "up" // "up" or "down"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "vote_type": "up",
    "new_vote_count": 235
  }
}
```

#### DELETE /posts/:postId/vote

Remove vote

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "new_vote_count": 234
  }
}
```

#### POST /comments/:commentId/vote

Vote on a comment (same pattern as posts)

---

### Group Endpoints

#### GET /groups

List all groups

**Query Parameters**:

- `category` (string): Filter by category (`specialty`, `rare_disease`, `interest`)
- `member_count_min` (integer): Minimum members
- `sort_by` (string): `members`, `activity`, `name`

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "group_123",
      "name": "Cardiology",
      "description": "Discussions on all aspects of cardiology",
      "category": "specialty",
      "member_count": 2340,
      "post_count": 5670,
      "is_member": true,
      "is_moderator": false,
      "avatar_url": "https://cdn.unitingdoctors.com/groups/cardiology.jpg",
      "created_at": "2025-08-01T00:00:00Z"
    }
  ],
  "pagination": { ... }
}
```

#### POST /groups

Create a new group

**Request**:

```json
{
  "name": "AATD Awareness",
  "description": "Alpha-1 Antitrypsin Deficiency awareness and research",
  "category": "rare_disease",
  "is_private": false
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "data": {
    "id": "group_456",
    "name": "AATD Awareness",
    "description": "...",
    "category": "rare_disease",
    "member_count": 1,
    "created_at": "2025-11-08T10:30:00Z",
    "url": "https://unitingdoctors.com/groups/aatd-awareness"
  }
}
```

#### POST /groups/:groupId/join

Join a group

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "group": { ... },
    "joined_at": "2025-11-08T10:30:00Z"
  }
}
```

#### DELETE /groups/:groupId/leave

Leave a group

**Response** (204 No Content)

#### GET /groups/:groupId/posts

Get posts in a group (same format as /posts)

---

### Research Endpoints

#### GET /research/papers

Search research papers

**Query Parameters**:

- `query` (string): Search query
- `journal` (string): Filter by journal
- `year_min` (integer): Minimum publication year
- `year_max` (integer): Maximum publication year
- `study_type` (string): `rct`, `meta_analysis`, `systematic_review`, `case_series`
- `open_access` (boolean): Only open access papers

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "paper_123",
      "pmid": "12345678",
      "doi": "10.1001/jama.2023.12345",
      "title": "SGLT2 Inhibitors in Heart Failure with Preserved Ejection Fraction",
      "authors": [
        {"name": "Johnson A", "affiliation": "Mayo Clinic"},
        {"name": "Smith B", "affiliation": "Cleveland Clinic"}
      ],
      "journal": {
        "name": "JAMA",
        "volume": "329",
        "issue": "5",
        "pages": "456-463"
      },
      "publication_date": "2023-02-01",
      "abstract": "Background: The efficacy of SGLT2 inhibitors...",
      "study_type": "rct",
      "is_open_access": true,
      "full_text_url": "https://jamanetwork.com/...",
      "citation_count": 245,
      "altmetric_score": 89,
      "shared_count": 67,
      "discussion_count": 23,
      "created_at": "2023-02-01T00:00:00Z"
    }
  ],
  "pagination": { ... }
}
```

#### POST /research/papers

Share a research paper to platform

**Request**:

```json
{
  "pmid": "12345678",
  "commentary": "This changes practice for HFpEF patients...",
  "clinical_relevance": "practice_changing",
  "tag_ids": [1, 15]
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "data": {
    "post_id": "post_abc123",
    "paper": { ... },
    "created_at": "2025-11-08T10:30:00Z"
  }
}
```

#### GET /research/feed

Get personalized research feed

**Query Parameters**:

- `specialty` (string): Filter by specialty
- `limit` (integer): Papers per page

**Response**: Same format as `/research/papers`

---

### Search Endpoints

#### GET /search

Universal search across all content

**Query Parameters**:

- `q` (string, required): Search query
- `type` (string): `all`, `posts`, `comments`, `papers`, `users`, `groups`
- `specialty` (string): Filter by specialty
- `evidence_level` (string): Filter by evidence level
- `date_from` (string): ISO date
- `date_to` (string): ISO date
- `sort_by` (string): `relevance`, `recent`, `top`

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "posts": [
      {
        "id": "post_123",
        "type": "post",
        "title": "Refractory septic shock management",
        "excerpt": "...methylene blue in distributive shock...",
        "relevance_score": 0.95,
        "created_at": "2025-11-07T10:00:00Z",
        "url": "/posts/123"
      }
    ],
    "papers": [
      {
        "id": "paper_456",
        "type": "paper",
        "title": "Angiotensin II in Septic Shock (ATHOS-3)",
        "journal": "NEJM",
        "year": 2023,
        "relevance_score": 0.88,
        "url": "/research/papers/456"
      }
    ],
    "users": [...],
    "groups": [...]
  },
  "meta": {
    "query": "septic shock",
    "total_results": 156,
    "search_time_ms": 45
  }
}
```

#### GET /search/autocomplete

Search suggestions

**Query Parameters**:

- `q` (string, required): Partial search query

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "suggestions": [
      "septic shock management",
      "septic shock vasopressors",
      "septic shock guidelines"
    ]
  }
}
```

---

### Notification Endpoints

#### GET /notifications

Get user notifications

**Query Parameters**:

- `unread_only` (boolean): Only unread notifications
- `type` (string): Filter by notification type
- `limit` (integer): Notifications per page

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "notif_123",
      "type": "post_reply",
      "title": "EmergencyMD replied to your post",
      "message": "\"Great point! One caution...\"",
      "is_read": false,
      "action_url": "/posts/abc123#comment-xyz789",
      "actor": {
        "id": "user_456",
        "display_name": "EmergencyMD",
        "avatar_url": "..."
      },
      "created_at": "2025-11-08T09:00:00Z"
    }
  ],
  "meta": {
    "unread_count": 5,
    "total_count": 234
  }
}
```

#### POST /notifications/:notificationId/read

Mark notification as read

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "id": "notif_123",
    "is_read": true
  }
}
```

#### POST /notifications/read-all

Mark all notifications as read

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "marked_read_count": 5
  }
}
```

---

### Moderation Endpoints

**(Requires admin or moderator role)**

#### GET /moderation/queue

Get moderation queue

**Query Parameters**:

- `status` (string): `pending`, `approved`, `rejected`
- `risk_score_min` (float): Minimum AI risk score (0-1)
- `sort_by` (string): `risk_score`, `report_count`, `created_at`

**Response** (200 OK):

```json
{
  "success": true,
  "data": [
    {
      "id": "mod_item_123",
      "content_type": "post",
      "content_id": "post_abc123",
      "content_preview": "For Type 1 diabetics, try stopping insulin...",
      "author": {
        "id": "user_789",
        "display_name": "AnonymousDoc",
        "reputation": 120,
        "previous_violations": 2
      },
      "reports": [
        {
          "id": "report_456",
          "reporter_id": "user_123",
          "reporter_reputation": 450,
          "reason": "dangerous_misinformation",
          "notes": "Stopping insulin for T1DM is life-threatening",
          "created_at": "2025-11-08T10:00:00Z"
        }
      ],
      "ai_assessment": {
        "risk_score": 0.89,
        "risk_factors": [
          "recommends_stopping_medication",
          "no_citations",
          "contradicts_standard_of_care"
        ],
        "suggested_action": "remove"
      },
      "status": "pending",
      "created_at": "2025-11-08T10:00:00Z"
    }
  ],
  "pagination": { ... }
}
```

#### POST /moderation/:itemId/action

Take moderation action

**Request**:

```json
{
  "action": "remove", // "remove", "warn", "ban", "approve"
  "reason": "Dangerous medical misinformation",
  "ban_duration_days": null, // For ban action
  "public_explanation": "This content recommends stopping life-saving medication..."
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "data": {
    "item_id": "mod_item_123",
    "action_taken": "remove",
    "content_removed": true,
    "user_notified": true,
    "reputation_penalty": -50,
    "timestamp": "2025-11-08T10:30:00Z"
  }
}
```

---

## 🔔 Webhooks

Webhooks allow you to receive real-time notifications when events occur.

### Webhook Events

| Event                | Description                |
| -------------------- | -------------------------- |
| `post.created`       | New post published         |
| `post.updated`       | Post edited                |
| `post.deleted`       | Post removed               |
| `comment.created`    | New comment added          |
| `user.verified`      | User verification approved |
| `moderation.flagged` | Content flagged for review |

### Webhook Payload

All webhooks send a POST request with this structure:

```json
{
  "event": "post.created",
  "timestamp": "2025-11-08T10:30:00Z",
  "data": {
    "post": {
      "id": "post_abc123",
      "author_id": "user_xyz789",
      "content": "...",
      "created_at": "2025-11-08T10:30:00Z"
    }
  },
  "signature": "sha256=abc123..."
}
```

### Webhook Signature Verification

```javascript
const crypto = require('crypto');

function verifyWebhook(payload, signature, secret) {
  const hmac = crypto.createHmac('sha256', secret);
  const digest = 'sha256=' + hmac.update(JSON.stringify(payload)).digest('hex');
  return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(digest));
}
```

---

## ⚡ Rate Limiting

Rate limits protect the API from abuse.

### Rate Limit Tiers

| Tier              | Requests/Minute | Requests/Hour |
| ----------------- | --------------- | ------------- |
| **Anonymous**     | 10              | 100           |
| **Authenticated** | 60              | 1000          |
| **Premium**       | 300             | 5000          |
| **Institutional** | 1000            | 20000         |

### Rate Limit Headers

```http
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 45
X-RateLimit-Reset: 1636354800
```

### Rate Limit Exceeded Response

```http
HTTP/1.1 429 Too Many Requests
Content-Type: application/json

{
  "success": false,
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Rate limit exceeded. Retry after 30 seconds.",
    "retry_after": 30
  }
}
```

---

## ❌ Error Codes

### HTTP Status Codes

| Code  | Meaning                                 |
| ----- | --------------------------------------- |
| `200` | OK - Request succeeded                  |
| `201` | Created - Resource created              |
| `204` | No Content - Success, no response body  |
| `400` | Bad Request - Invalid request           |
| `401` | Unauthorized - Authentication required  |
| `403` | Forbidden - Insufficient permissions    |
| `404` | Not Found - Resource doesn't exist      |
| `422` | Unprocessable Entity - Validation error |
| `429` | Too Many Requests - Rate limit exceeded |
| `500` | Internal Server Error - Server error    |
| `503` | Service Unavailable - Maintenance       |

### Application Error Codes

| Code                       | HTTP | Description                         |
| -------------------------- | ---- | ----------------------------------- |
| `VALIDATION_ERROR`         | 422  | Request validation failed           |
| `AUTHENTICATION_REQUIRED`  | 401  | Not authenticated                   |
| `INSUFFICIENT_PERMISSIONS` | 403  | Missing required permissions        |
| `RESOURCE_NOT_FOUND`       | 404  | Resource doesn't exist              |
| `DUPLICATE_RESOURCE`       | 400  | Resource already exists             |
| `RATE_LIMIT_EXCEEDED`      | 429  | Too many requests                   |
| `CONTENT_POLICY_VIOLATION` | 400  | Content violates policies           |
| `PHI_DETECTED`             | 400  | Patient health information detected |
| `VERIFICATION_REQUIRED`    | 403  | User must be verified               |
| `REPUTATION_TOO_LOW`       | 403  | Insufficient reputation             |

---

## 📚 SDK Libraries

### Official SDKs

**JavaScript/TypeScript**

```bash
npm install @unitingdoctors/api-client
```

```typescript
import { UnitingDoctorsClient } from '@unitingdoctors/api-client';

const client = new UnitingDoctorsClient({
  accessToken: 'YOUR_ACCESS_TOKEN'
});

// Get posts
const posts = await client.posts.list({
  specialty: 'cardiology',
  limit: 20
});

// Create post
const newPost = await client.posts.create({
  content: 'Discussing AFib management...',
  is_anonymous: false,
  tag_ids: [1, 45]
});
```

**Python**

```bash
pip install uniting-doctors
```

```python
from uniting_doctors import Client

client = Client(access_token='YOUR_ACCESS_TOKEN')

# Get posts
posts = client.posts.list(specialty='cardiology', limit=20)

# Create post
new_post = client.posts.create(
    content='Discussing AFib management...',
    is_anonymous=False,
    tag_ids=[1, 45]
)
```

---

## 📝 Changelog

### Version 1.0 (2025-11-08)

- Initial API release
- Authentication via OAuth 2.0
- Core endpoints (users, posts, comments, votes)
- Research integration
- Search functionality
- Moderation endpoints

---

## 📞 Support

**API Documentation**: [https://docs.unitingdoctors.com/api](https://docs.unitingdoctors.com/api)
**Developer Portal**: [https://developers.unitingdoctors.com](https://developers.unitingdoctors.com)
**Support Email**: api-support@unitingdoctors.com
**Status Page**: [https://status.unitingdoctors.com](https://status.unitingdoctors.com)

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Related Documents**:

- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [IMPLEMENTATION_ROADMAP.md](./IMPLEMENTATION_ROADMAP.md)
- [SECURITY_ARCHITECTURE.md](./SECURITY_ARCHITECTURE.md)
