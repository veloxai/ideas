# Data Aggregation System

## Executive Summary

The **Data Aggregation System** for Uniting Doctors serves as the central nervous system for collecting, processing, and distributing medical information from diverse sources worldwide. This system enables real-time access to breaking medical news, research publications, regulatory updates, and clinical findings, ensuring that healthcare professionals have immediate access to the most current medical knowledge.

**Core Value**: Transform fragmented medical information scattered across journals, news sites, regulatory agencies, and research institutions into a unified, searchable, and contextualized knowledge stream that healthcare professionals can trust and act upon immediately.

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Data Sources](#data-sources)
3. [Aggregation Architecture](#aggregation-architecture)
4. [Content Processing Pipeline](#content-processing-pipeline)
5. [API Integration Strategy](#api-integration-strategy)
6. [Real-Time Data Streaming](#real-time-data-streaming)
7. [Quality Control & Validation](#quality-control--validation)
8. [Deduplication & Normalization](#deduplication--normalization)
9. [Metadata Enrichment](#metadata-enrichment)
10. [Content Distribution](#content-distribution)
11. [Performance & Scalability](#performance--scalability)
12. [Security & Compliance](#security--compliance)

---

## System Overview

### Purpose

The Data Aggregation System collects medical information from hundreds of sources globally and delivers it to healthcare professionals in a curated, verified, and contextualized format within minutes of publication.

### Key Capabilities

- **Multi-Source Integration**: Connect to 500+ medical journals, news outlets, regulatory agencies, and research databases
- **Real-Time Processing**: Process and publish breaking medical news within 2-5 minutes
- **Intelligent Filtering**: AI-powered relevance scoring and duplicate detection
- **Content Enrichment**: Automatic tagging, categorization, and metadata extraction
- **Personalized Delivery**: Specialty-specific feeds and custom alerts
- **Quality Assurance**: Multi-layer validation and source credibility scoring

### System Architecture Principles

1. **Distributed Processing**: Horizontal scaling for handling massive data volumes
2. **Event-Driven Design**: Asynchronous processing with message queues
3. **Microservices**: Independent services for each data source type
4. **Fault Tolerance**: Automatic retry mechanisms and graceful degradation
5. **Observability**: Comprehensive monitoring and alerting

---

## Data Sources

### Primary Medical Journals (Tier 1)

**Major Publishers**:

- PubMed Central / MEDLINE (5M+ articles)
- The Lancet family of journals
- New England Journal of Medicine (NEJM)
- JAMA and JAMA Network
- BMJ (British Medical Journal)
- Nature Medicine & Nature journals
- Science & Science Translational Medicine
- Cell Press journals
- Elsevier journals (via ScienceDirect API)
- Wiley Online Library
- Springer Nature

**Access Methods**:

- Official APIs (PubMed E-utilities, CrossRef API)
- RSS/Atom feeds
- Email alerts parsing
- Direct journal website scraping (with permission)

**Update Frequency**: Every 15 minutes during business hours, hourly off-hours

### Specialty Journals (Tier 2)

**Categories** (200+ journals):

- Cardiology (JACC, Circulation, European Heart Journal)
- Oncology (Cancer, JCO, Annals of Oncology)
- Neurology (Neurology, Brain, JNNP)
- Infectious Diseases (CID, JID, Lancet Infectious Diseases)
- Pediatrics (Pediatrics, JPEDS, Archives of Disease in Childhood)
- Psychiatry (AJP, BJP, JAMA Psychiatry)
- Surgery (Annals of Surgery, JACS, British Journal of Surgery)

**Access Strategy**:

- Priority-based polling (high-impact journals checked more frequently)
- Embargo-aware publishing (respect journal release schedules)
- Pre-print server integration (bioRxiv, medRxiv)

### Medical News Outlets

**Major Sources**:

- Reuters Health
- MedPage Today
- Medscape
- STAT News
- Healio
- Fierce Pharma / Fierce Biotech
- Medical News Today
- Endpoints News

**Social Media**:

- Twitter/X Medical News accounts
- LinkedIn healthcare influencers
- Reddit medical communities (r/medicine, specialty subreddits)

**Update Frequency**: Every 5 minutes for breaking news

### Regulatory & Government Sources

**FDA**:

- Drug approvals and safety alerts
- Medical device clearances
- Warning letters
- Clinical trial notifications

**CDC**:

- MMWR (Morbidity and Mortality Weekly Report)
- Health alerts and advisories
- Outbreak notifications
- Vaccination recommendations

**International**:

- EMA (European Medicines Agency)
- Health Canada
- TGA (Therapeutic Goods Administration - Australia)
- PMDA (Japan)
- WHO bulletins and alerts

**Update Frequency**: Every 30 minutes

### Clinical Trial Databases

**Sources**:

- ClinicalTrials.gov
- EU Clinical Trials Register
- WHO International Clinical Trials Registry
- Company-specific trial registries

**Data Points**:

- New trial registrations
- Results postings
- Protocol amendments
- Trial status changes

**Update Frequency**: Daily for new registrations, weekly for updates

### Conference & Symposia

**Major Events**:

- ASH (Hematology), ACC (Cardiology), ASCO (Oncology)
- AHA (Heart Association), AAN (Neurology)
- ID Week (Infectious Diseases)
- EASD (Diabetes), ADA (Diabetes)

**Data Sources**:

- Conference press releases
- Abstract databases
- Live presentation tracking
- Press coverage aggregation

**Special Handling**: Real-time coverage during major conferences (2-4 hours latency)

### Research Databases

**Academic Sources**:

- Google Scholar
- Microsoft Academic
- Semantic Scholar
- PubMed Similar Articles
- Citation networks (OpenCitations)

**Purpose**: Discovering related research and citation networks

---

## Aggregation Architecture

### High-Level System Design

```
┌─────────────────────────────────────────────────────────────┐
│                     Data Sources Layer                       │
│  Journals │ News │ Regulatory │ Trials │ Social Media        │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Source Adapters Layer                       │
│  API Clients │ Web Scrapers │ Feed Parsers │ Email Parsers  │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                   Message Queue (Kafka)                      │
│              Raw Content Stream (Partitioned)                │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│              Content Processing Pipeline                     │
│  Extract │ Parse │ Dedupe │ Enrich │ Classify │ Score       │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Storage & Indexing                          │
│  PostgreSQL │ Elasticsearch │ Redis Cache │ S3              │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                Distribution & Delivery                       │
│  API Endpoints │ Feed Generation │ Alerts │ Notifications   │
└─────────────────────────────────────────────────────────────┘
```

### Technology Stack

**Ingestion Layer**:

- Python (Beautiful Soup, Scrapy) for web scraping
- Node.js for API clients
- Apache Kafka for message streaming
- Redis for rate limiting and deduplication

**Processing Layer**:

- Apache Flink or Kafka Streams for stream processing
- Python (spaCy, scikit-learn) for NLP and classification
- PostgreSQL for structured data
- Elasticsearch for full-text search

**Delivery Layer**:

- GraphQL API (Apollo Server)
- REST API (Express.js)
- WebSocket for real-time updates
- Redis Pub/Sub for notification delivery

---

## Content Processing Pipeline

### Stage 1: Extraction

**Goal**: Extract raw content from various source formats

**Operations**:

1. **HTML Parsing**: Extract article body, title, authors, abstract
2. **PDF Processing**: Extract text from PDFs (using pdfplumber, PyPDF2)
3. **Image OCR**: Extract text from images (Tesseract OCR)
4. **Metadata Extraction**: DOI, PMID, publication date, journal info
5. **Reference Parsing**: Extract and link citations

**Technologies**:

- Beautiful Soup 4 / lxml for HTML
- PyMuPDF / pdfplumber for PDFs
- Tesseract / Google Cloud Vision API for OCR
- Regular expressions for structured data

### Stage 2: Parsing & Normalization

**Goal**: Convert extracted content into standardized format

**Schema**:

```json
{
  "id": "uuid",
  "source_id": "pubmed:12345678",
  "title": "string",
  "abstract": "string",
  "full_text": "string",
  "authors": ["array of author objects"],
  "publication_date": "ISO 8601 datetime",
  "journal": {
    "name": "string",
    "impact_factor": "float",
    "issn": "string"
  },
  "doi": "string",
  "pmid": "string",
  "keywords": ["array of strings"],
  "mesh_terms": ["array of MeSH headings"],
  "content_type": "research|news|regulatory|trial",
  "language": "ISO 639-1 code",
  "embargo_until": "ISO 8601 datetime (optional)"
}
```

**Normalization Tasks**:

- Date format standardization (ISO 8601)
- Author name disambiguation (ORCID linking)
- Journal name standardization (NLM catalog)
- Keyword normalization (MeSH term mapping)

### Stage 3: Deduplication

**Goal**: Identify and merge duplicate content

**Detection Methods**:

1. **Exact Match**: SHA-256 hash of full text
2. **Near-Duplicate**: SimHash or MinHash for similar content
3. **Title Similarity**: Levenshtein distance < 0.15
4. **DOI/PMID Match**: Same identifier = duplicate
5. **Content Fingerprinting**: TF-IDF cosine similarity > 0.95

**Merging Strategy**:

- Keep highest-quality version (peer-reviewed > pre-print > news)
- Merge metadata from all sources
- Track all source URLs
- Preserve version history

**Technologies**:

- Redis for in-memory hash lookups
- Elasticsearch for similarity searches
- Python datasketch library for LSH

### Stage 4: Classification & Categorization

**Goal**: Automatically tag and categorize content

**Medical Specialty Classification**:

- Multi-label classification (article can belong to multiple specialties)
- 50+ specialty categories (cardiology, oncology, infectious disease, etc.)
- Machine learning model (fine-tuned BERT or BioBERT)
- Training data: 100K+ manually tagged articles

**Content Type Classification**:

- Research Article (original research, clinical trial, meta-analysis)
- Review Article (systematic review, narrative review)
- Case Report / Case Series
- Editorial / Opinion
- News / Press Release
- Regulatory Alert
- Clinical Guideline

**Disease & Condition Tagging**:

- Named Entity Recognition (NER) for diseases, conditions, procedures
- SNOMED CT / ICD-11 code mapping
- Drug name extraction (RxNorm linking)

**Relevance Scoring**:

- Impact factor weighting
- Citation velocity (early citations for pre-prints)
- Social media engagement
- Editorial picks and featured articles

### Stage 5: Quality Validation

**Goal**: Assess content credibility and reliability

**Source Credibility Score** (0-100):

- Peer-reviewed journals: 80-100
- Pre-print servers: 60-80
- Reputable news outlets: 70-90
- Press releases: 50-70
- Social media: 30-60
- Unknown sources: 10-30

**Content Quality Checks**:

1. **Retraction Check**: Cross-reference with RetractionWatch database
2. **Predatory Journal Detection**: Check against Beall's List and DOAJ
3. **Plagiarism Detection**: Compare against existing corpus
4. **Data Integrity**: Check for image manipulation (using forensic analysis)
5. **Citation Verification**: Validate that cited sources exist

**Red Flags**:

- Extraordinary claims without strong evidence
- Conflicts of interest (COI) disclosure issues
- Statistical anomalies (p-hacking indicators)
- Pre-print without peer review (flagged clearly)

### Stage 6: Enrichment

**Goal**: Add valuable metadata and context

**Automatic Enrichment**:

1. **Citation Network**: Link to citing and cited papers
2. **Related Articles**: Find similar content via embedding similarity
3. **Author Profiles**: Link to ORCID, H-index, institutional affiliations
4. **Clinical Relevance**: Extract patient outcomes, treatment protocols
5. **Statistical Summary**: Extract key findings (effect sizes, p-values, confidence intervals)
6. **Media Coverage**: Track news articles covering the research
7. **Social Media Metrics**: Count shares, mentions, discussions

**Manual Enrichment** (for high-impact content):

- Editorial summaries (written by medical editors)
- Clinical pearls and takeaways
- Practice-changing designations
- Controversy flags and counterpoints

---

## API Integration Strategy

### PubMed / MEDLINE Integration

**API**: NCBI E-utilities (Entrez Programming Utilities)

**Endpoints Used**:

1. `ESearch`: Search PubMed for new articles
2. `EFetch`: Retrieve full article metadata and abstracts
3. `ELink`: Get related articles and citations

**Implementation**:

```python
# Pseudo-code for PubMed integration
class PubMedAggregator:
    def __init__(self, api_key, email):
        self.base_url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
        self.api_key = api_key
        self.email = email

    async def fetch_recent_articles(self, hours=24):
        # Search for articles published in last 24 hours
        search_query = f"({self.last_update_time}:{self.current_time}[dp])"
        search_url = f"{self.base_url}esearch.fcgi?db=pubmed&term={search_query}&retmax=1000&retmode=json&api_key={self.api_key}"

        pmids = await self.http_get(search_url)

        # Fetch full details for each article
        for pmid_batch in self.batch(pmids, size=200):
            fetch_url = f"{self.base_url}efetch.fcgi?db=pubmed&id={','.join(pmid_batch)}&retmode=xml&api_key={self.api_key}"
            articles = await self.http_get(fetch_url)
            await self.process_articles(articles)

    async def process_articles(self, articles):
        for article in articles:
            processed = {
                'pmid': article['MedlineCitation']['PMID'],
                'title': article['MedlineCitation']['Article']['ArticleTitle'],
                'abstract': article['MedlineCitation']['Article']['Abstract'],
                'authors': self.extract_authors(article),
                'mesh_terms': article['MedlineCitation']['MeshHeadingList'],
                'publication_date': self.parse_date(article),
                'journal': article['MedlineCitation']['Article']['Journal'],
                'doi': self.extract_doi(article)
            }
            await self.publish_to_queue(processed)
```

**Rate Limits**:

- Without API key: 3 requests/second
- With API key: 10 requests/second
- Implement exponential backoff on errors

**Update Schedule**:

- Incremental updates every 15 minutes
- Full resync weekly (to catch corrections/retractions)

### CrossRef API Integration

**Purpose**: Resolve DOIs and get publication metadata

**API**: REST API v1 (https://api.crossref.org)

**Use Cases**:

1. DOI resolution
2. Citation data
3. Pre-print to published version linking
4. Open access status checking

**Example**:

```javascript
async function fetchCrossRefMetadata(doi) {
  const url = `https://api.crossref.org/works/${doi}`;
  const response = await fetch(url, {
    headers: {
      'User-Agent': 'UnitingDoctors/1.0 (mailto:contact@unitingdoctors.com)'
    }
  });

  const data = await response.json();
  return {
    title: data.message.title[0],
    authors: data.message.author,
    published: data.message.published['date-parts'][0],
    journal: data.message['container-title'][0],
    references: data.message.reference,
    is_referenced_by_count: data.message['is-referenced-by-count']
  };
}
```

**Rate Limits**:

- Polite pool: 50 requests/second (with User-Agent and email)
- Plus pool: Enhanced features (requires registration)

### News API Integration

**Major News APIs**:

1. **NewsAPI.org**
   - 80,000+ news sources
   - Real-time breaking news
   - Medical keyword filtering
   - Rate limit: 1,000 requests/day (free), 250,000/day (paid)

2. **Bing News Search API**
   - Microsoft Azure Cognitive Services
   - Advanced filtering and categorization
   - Freshness: Real-time to 30 days old
   - Rate limit: 1,000 requests/month (free), unlimited (paid)

3. **RSS Feeds**
   - Individual news outlet RSS feeds
   - Parsed with feedparser (Python)
   - Polling every 5-15 minutes

**Implementation**:

```javascript
// News aggregation with NewsAPI
const NewsAPI = require('newsapi');
const newsapi = new NewsAPI(process.env.NEWS_API_KEY);

async function fetchMedicalNews() {
  const response = await newsapi.v2.everything({
    q: 'medicine OR healthcare OR clinical OR FDA OR drug approval',
    sources: 'medical-news-today,reuters,bbc-news',
    language: 'en',
    sortBy: 'publishedAt',
    pageSize: 100
  });

  for (const article of response.articles) {
    await processNewsArticle({
      title: article.title,
      description: article.description,
      url: article.url,
      source: article.source.name,
      published_at: article.publishedAt,
      content: article.content
    });
  }
}
```

### Clinical Trials API

**ClinicalTrials.gov API**:

- RESTful API for searching trials
- JSON and XML formats
- Filter by condition, intervention, status, location
- Update frequency: Daily

**Example Query**:

```
https://clinicaltrials.gov/api/query/study_fields?expr=AREA[Condition](diabetes)&fields=NCTId,Condition,BriefTitle,StartDate,CompletionDate,OverallStatus&fmt=json&max_rnk=100
```

**Data Extraction**:

- New trial registrations
- Results postings
- Protocol amendments
- Recruitment status changes

---

## Real-Time Data Streaming

### Event-Driven Architecture

**Apache Kafka Topics**:

1. **raw-content-stream**: Unprocessed content from all sources
2. **parsed-content-stream**: Normalized and structured content
3. **enriched-content-stream**: Fully processed and tagged content
4. **publication-stream**: Content ready for distribution
5. **alert-stream**: High-priority breaking news and alerts

**Kafka Configuration**:

- Partitioning: By content source (for parallelization)
- Replication factor: 3 (for fault tolerance)
- Retention: 7 days (for replay and debugging)

### Stream Processing

**Apache Flink Jobs**:

1. **Deduplication Job**: Real-time duplicate detection
2. **Classification Job**: Content categorization and tagging
3. **Enrichment Job**: Metadata augmentation
4. **Quality Control Job**: Credibility scoring and validation
5. **Alert Detection Job**: Identify breaking news and urgent updates

**Example Flink Job** (Simplified):

```java
// Real-time article classification
DataStream<Article> rawArticles = env
    .addSource(new FlinkKafkaConsumer<>("raw-content-stream", ...));

DataStream<ClassifiedArticle> classified = rawArticles
    .map(new ArticleNormalizer())
    .keyBy(article -> article.getSourceId())
    .flatMap(new DeduplicationFunction())
    .map(new SpecialtyClassifier())
    .map(new QualityScorer());

classified.addSink(new FlinkKafkaProducer<>("enriched-content-stream", ...));
```

### WebSocket Streaming

**Real-Time Updates to Clients**:

- WebSocket connections for live feeds
- Subscribe to specific specialties or keywords
- Server-Sent Events (SSE) as fallback
- Maximum latency: 3 seconds from publication

**Client Subscription**:

```javascript
const ws = new WebSocket('wss://api.unitingdoctors.com/stream');

ws.send(
  JSON.stringify({
    action: 'subscribe',
    filters: {
      specialties: ['cardiology', 'critical-care'],
      content_types: ['research', 'regulatory'],
      keywords: ['heart failure', 'myocardial infarction']
    }
  })
);

ws.onmessage = (event) => {
  const article = JSON.parse(event.data);
  displayNewArticle(article);
};
```

---

## Quality Control & Validation

### Multi-Layer Validation

**Layer 1: Source Verification**

- Whitelist of trusted sources (manually curated)
- Domain reputation scoring
- SSL certificate validation
- Robots.txt compliance check

**Layer 2: Content Validation**

- Schema validation (required fields present)
- Data type checking
- Date sanity checks (publication date not in future)
- URL accessibility verification

**Layer 3: Semantic Validation**

- Language detection (filter non-English if needed)
- Medical content detection (is this actually medical?)
- Spam/promotional content filtering
- Plagiarism detection

**Layer 4: Quality Scoring**

- Journal impact factor
- Source credibility rating
- Citation count
- Social media engagement
- Editorial review (for high-impact content)

### Retraction Monitoring

**Integration with RetractionWatch**:

- Daily sync with RetractionWatch database
- Automatic flagging of retracted articles
- Notification to users who saved/shared retracted content
- Prominent retraction notices

**Correction Tracking**:

- Monitor for corrections and errata
- Update articles with correction notices
- Link to corrected versions

---

## Deduplication & Normalization

### Deduplication Strategy

**Why Duplicates Occur**:

- Same article in multiple sources (pre-print → published version)
- Press releases vs. original research
- News coverage of the same study
- Syndicated content

**Detection Methods**:

1. **Exact Duplicate Detection**:
   - SHA-256 hash of full text
   - Redis cache for O(1) lookup

2. **Near-Duplicate Detection**:
   - SimHash algorithm (64-bit fingerprint)
   - Hamming distance < 3 = duplicate

3. **Semantic Duplicate Detection**:
   - TF-IDF vectorization + cosine similarity
   - Threshold: similarity > 0.95

4. **Identifier Matching**:
   - Same DOI = exact duplicate
   - Same PMID = exact duplicate
   - Title + author matching

**Duplicate Resolution**:

```python
class DuplicateResolver:
    def resolve(self, articles: List[Article]) -> Article:
        """
        Select the best version among duplicates
        Priority:
        1. Peer-reviewed journal article
        2. Pre-print with more citations
        3. Most recent version
        4. Longest/most complete content
        """
        scored = [(self.score(a), a) for a in articles]
        best = max(scored, key=lambda x: x[0])[1]

        # Merge metadata from all versions
        best.alternate_urls = [a.url for a in articles]
        best.all_sources = [a.source for a in articles]

        return best

    def score(self, article: Article) -> float:
        score = 0
        if article.is_peer_reviewed:
            score += 100
        if article.has_doi:
            score += 50
        score += article.citation_count
        score += len(article.full_text) / 1000  # Length bonus
        return score
```

### Data Normalization

**Author Name Normalization**:

- Handle variations: "J. Smith", "John Smith", "Smith, J."
- ORCID linking when available
- Institutional affiliation matching

**Date Normalization**:

- Convert all dates to ISO 8601 format
- Handle partial dates (year-month only)
- Timezone standardization (UTC)

**Journal Name Normalization**:

- Map abbreviations to full names
- Use NLM Catalog for standardization
- Handle name changes over time

**Keyword Normalization**:

- Map to MeSH (Medical Subject Headings)
- Synonym resolution
- Spelling correction

---

## Metadata Enrichment

### Citation Network Building

**Forward Citations** (Who cites this paper):

- Daily sync with OpenCitations, Crossref
- Track citation velocity (citations per month)
- Identify influential papers (high citation count early)

**Backward Citations** (What this paper cites):

- Extract references from full text
- Resolve citations to DOIs/PMIDs
- Build reference network graph

**Citation Graph**:

```
Article A
├── Cited by: [B, C, D]
├── Cites: [E, F, G]
└── Related via citations: [H, I, J]
```

**Neo4j Graph Database**:

```cypher
// Create article node
CREATE (a:Article {
  id: 'pmid:12345678',
  title: 'Novel Treatment for Disease X',
  published: date('2025-01-15')
})

// Create citation relationship
MATCH (citing:Article {id: 'pmid:87654321'})
MATCH (cited:Article {id: 'pmid:12345678'})
CREATE (citing)-[:CITES {date: date('2025-03-01')}]->(cited)

// Query: Find most cited recent papers in cardiology
MATCH (a:Article {specialty: 'cardiology'})<-[c:CITES]-()
WHERE a.published > date('2024-01-01')
RETURN a.title, count(c) as citation_count
ORDER BY citation_count DESC
LIMIT 10
```

### Social Media Metrics

**Altmetrics Integration**:

- Twitter/X mentions and retweets
- Facebook shares
- Reddit discussions
- Blog post mentions
- News article coverage

**Altmetric.com API**:

```javascript
async function fetchAltmetrics(doi) {
  const response = await fetch(`https://api.altmetric.com/v1/doi/${doi}`);
  const data = await response.json();

  return {
    score: data.score,
    twitter_mentions: data.cited_by_tweeters_count,
    news_mentions: data.cited_by_msm_count,
    blog_mentions: data.cited_by_feeds_count,
    reddit_mentions: data.cited_by_rdts_count,
    reader_count: data.readers_count
  };
}
```

### Author & Institution Enrichment

**ORCID Integration**:

- Fetch author profiles
- H-index and publication history
- Disambiguation of common names

**Institutional Affiliations**:

- Extract affiliations from article metadata
- Standardize institution names
- Rank by institutional reputation (QS Rankings, etc.)

### Clinical Relevance Extraction

**Key Findings Extraction**:

- Primary outcomes
- Effect sizes (hazard ratios, odds ratios)
- Statistical significance (p-values, confidence intervals)
- Patient populations studied
- Treatment protocols

**NLP for Key Sentence Extraction**:

```python
# Extract key clinical findings using NLP
import spacy
from scispacy.abbreviation import AbbreviationDetector

nlp = spacy.load("en_core_sci_lg")
nlp.add_pipe("abbreviation_detector")

def extract_clinical_findings(abstract):
    doc = nlp(abstract)

    findings = []

    # Look for sentences with statistical results
    for sent in doc.sents:
        if any(token.text in ['p', 'P', 'HR', 'OR', 'RR'] for token in sent):
            findings.append(sent.text)

    # Extract abbreviations
    abbreviations = {abrv.text: abrv._.long_form.text
                     for abrv in doc._.abbreviations}

    return {
        'key_findings': findings,
        'abbreviations': abbreviations
    }
```

---

## Content Distribution

### Feed Generation

**Personalized Feeds**:

- Specialty-specific feeds (cardiology, oncology, etc.)
- User-defined keyword alerts
- Following specific journals or authors
- Saved search queries

**Feed Types**:

1. **Chronological Feed**: All content, newest first
2. **Trending Feed**: Most engaged content (citations, shares, saves)
3. **Recommended Feed**: ML-powered personalization based on reading history
4. **Breaking News Feed**: Time-sensitive updates
5. **Journal Clubs**: Curated weekly digests

**Feed API**:

```graphql
query GetPersonalizedFeed($userId: ID!, $specialty: String, $limit: Int) {
  feed(userId: $userId, specialty: $specialty, limit: $limit) {
    articles {
      id
      title
      abstract
      publishedDate
      journal {
        name
        impactFactor
      }
      authors {
        name
        affiliation
      }
      relevanceScore
      engagementMetrics {
        views
        saves
        shares
        citations
      }
    }
    hasMore
    cursor
  }
}
```

### Alert System

**Alert Types**:

1. **Breaking News Alerts**:
   - FDA approvals/recalls
   - Major research breakthroughs
   - Public health emergencies
   - Retraction notices

2. **Keyword Alerts**:
   - User-defined keywords (e.g., "AATD", "alpha-1 antitrypsin")
   - Boolean search support (AND, OR, NOT)
   - Frequency: Real-time, daily digest, weekly digest

3. **Citation Alerts**:
   - When your published work is cited
   - When papers you've saved are cited

4. **Journal Table of Contents (TOC) Alerts**:
   - New issue published
   - Favorite journals

**Delivery Channels**:

- In-app push notifications
- Email digests
- SMS (for critical alerts only)
- Webhook integration (for institutions)

**Alert Management**:

```typescript
interface AlertConfiguration {
  userId: string;
  alertType: 'keyword' | 'citation' | 'journal_toc' | 'breaking_news';
  filters: {
    keywords?: string[];
    journals?: string[];
    specialties?: string[];
    authors?: string[];
  };
  frequency: 'realtime' | 'daily' | 'weekly';
  deliveryChannels: ('push' | 'email' | 'sms')[];
  active: boolean;
}

// Create alert
async function createAlert(config: AlertConfiguration) {
  await db.alerts.insert(config);
  await subscribeToRelevantTopics(config);
}

// Process incoming article for alerts
async function checkAlertsForArticle(article: Article) {
  const matchingAlerts = await db.alerts.find({
    active: true,
    $or: [
      { 'filters.keywords': { $in: article.keywords } },
      { 'filters.journals': article.journal.name },
      { 'filters.specialties': { $in: article.specialties } }
    ]
  });

  for (const alert of matchingAlerts) {
    await queueNotification(alert.userId, article, alert.deliveryChannels);
  }
}
```

### Export & Integration

**Data Export Formats**:

- JSON
- CSV
- RIS (Reference Manager format)
- BibTeX
- EndNote XML

**Third-Party Integrations**:

- Reference managers (Zotero, Mendeley, EndNote)
- RSS feed generation
- IFTTT integration
- Zapier webhooks

**API for Institutions**:

- Bulk data access for academic institutions
- Custom feeds for hospital systems
- Integration with EHR systems (HL7 FHIR)

---

## Performance & Scalability

### System Performance Targets

| Metric                                  | Target        | Current |
| --------------------------------------- | ------------- | ------- |
| Article ingestion rate                  | 10,000/hour   | -       |
| Processing latency (source → published) | < 5 minutes   | -       |
| Search query response time              | < 200ms (p95) | -       |
| Feed generation time                    | < 500ms       | -       |
| Real-time stream latency                | < 3 seconds   | -       |
| System uptime                           | 99.9%         | -       |

### Scalability Strategy

**Horizontal Scaling**:

- Kafka: Add brokers and partitions
- Flink: Increase parallelism and task managers
- PostgreSQL: Read replicas for analytics queries
- Elasticsearch: Add data nodes

**Caching Strategy**:

- Redis for hot data (recent articles, popular feeds)
- CDN for static content (full-text articles, PDFs)
- Materialized views for complex aggregations

**Database Sharding**:

- Shard articles by publication year
- Shard users by user ID hash
- Cross-shard queries via federated query engine

### Load Testing

**Scenarios**:

1. **Peak Conference Coverage**: 1,000 articles/hour during major medical conferences
2. **Breaking News**: 10,000 concurrent users reading same article
3. **Daily Digest Generation**: Generate 100,000 personalized email digests

**Tools**:

- Apache JMeter for API load testing
- Locust for realistic user behavior simulation
- Kafka performance testing tools

---

## Security & Compliance

### Data Security

**Encryption**:

- TLS 1.3 for all API communications
- Encrypted data at rest (AWS KMS, AES-256)
- Encrypted backups

**Access Control**:

- API authentication (OAuth 2.0, JWT tokens)
- Rate limiting (per user, per IP)
- API key rotation

**PII Protection**:

- No personal health information (PHI) in aggregated content
- Anonymization of case reports
- GDPR compliance for EU users

### Copyright & Fair Use

**Content Rights**:

- Abstracts: Fair use (publicly available)
- Full text: Licensed or open access only
- Images/figures: Require explicit permission
- Respect publisher embargoes

**Attribution**:

- Always link to original source
- Display journal name and authors prominently
- DOI/PMID links for traceability

**DMCA Compliance**:

- Copyright takedown request process
- Designated DMCA agent
- Content removal within 24 hours

### API Compliance

**Publisher API Terms**:

- Respect rate limits
- Proper User-Agent identification
- Non-commercial use declarations (where applicable)
- Usage reporting to publishers

**Data Usage Policies**:

- No reselling of aggregated data
- Academic and clinical use only
- Compliance with institutional licenses

---

## Monitoring & Operations

### System Monitoring

**Key Metrics**:

1. **Ingestion Health**:
   - Articles ingested per hour (by source)
   - Failed ingestion attempts
   - Source downtime

2. **Processing Performance**:
   - Kafka consumer lag
   - Flink job throughput
   - Processing error rates

3. **Data Quality**:
   - Duplicate detection rate
   - Classification accuracy
   - Enrichment completion rate

4. **API Performance**:
   - Request latency (p50, p95, p99)
   - Error rate
   - Cache hit rate

**Monitoring Tools**:

- Prometheus for metrics collection
- Grafana for dashboards
- ELK Stack (Elasticsearch, Logstash, Kibana) for log aggregation
- PagerDuty for alerting

**Example Dashboard**:

```
┌────────────────────────────────────────────────────────────┐
│  Data Aggregation System Dashboard                         │
├────────────────────────────────────────────────────────────┤
│  Articles Ingested (24h): 45,234                          │
│  Processing Latency (p95): 3.2 minutes                    │
│  Active Sources: 487 / 500                                │
│  Kafka Consumer Lag: 234 messages                         │
│  Elasticsearch Indexing Rate: 1,200/min                   │
│  API Request Rate: 8,450 req/min                          │
└────────────────────────────────────────────────────────────┘
```

### Error Handling & Recovery

**Retry Logic**:

- Exponential backoff for transient errors
- Circuit breaker pattern for failing sources
- Dead letter queue for unprocessable content

**Data Recovery**:

- Kafka retention allows replay of last 7 days
- Daily database backups (retained for 30 days)
- Point-in-time recovery

**Incident Response**:

- On-call rotation
- Runbooks for common issues
- Post-mortem analysis for major incidents

---

## Future Enhancements

### Planned Features

1. **Multilingual Support**:
   - Automatic translation of abstracts
   - Support for major medical languages (Spanish, German, French, Chinese, Japanese)
   - Language-specific source integration

2. **Video & Multimedia Content**:
   - Conference presentation videos
   - Surgical technique videos
   - Medical podcasts
   - Infographics and visual abstracts

3. **Preprint → Publication Tracking**:
   - Automatic linking of preprints to published versions
   - Notification when preprint is peer-reviewed
   - Version comparison

4. **Enhanced AI Features**:
   - Automatic summarization (BART, T5, GPT-4)
   - Question-answering over articles
   - Hypothesis generation from literature

5. **Institutional Repositories**:
   - Integration with hospital research repositories
   - University institutional repositories
   - Gray literature (thesis, dissertations)

6. **Patent Literature**:
   - Medical device patents
   - Pharmaceutical patents
   - Link patents to clinical research

### Research & Development

**Areas of Investigation**:

- Graph neural networks for citation prediction
- Federated learning for privacy-preserving personalization
- Knowledge graph construction from medical literature
- Automatic fact-checking for medical claims

---

## Conclusion

The Data Aggregation System is the foundational infrastructure that enables Uniting Doctors to fulfill its mission of democratizing medical information. By intelligently collecting, processing, and distributing content from hundreds of sources worldwide, we ensure that healthcare professionals have immediate access to the most current medical knowledge.

**Success Metrics**:

- **Coverage**: 95% of high-impact medical journals
- **Timeliness**: Breaking news within 5 minutes
- **Accuracy**: 99.9% deduplication accuracy
- **Reliability**: 99.9% system uptime

This system transforms the fragmented landscape of medical information into a unified, trustworthy, and immediately actionable knowledge stream.

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Technical Architecture Team
**Related Documents**:

- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [SEARCH_AND_DISCOVERY.md](./SEARCH_AND_DISCOVERY.md)
- [clinical/MEDICAL_CONTENT_STANDARDS.md](../clinical/MEDICAL_CONTENT_STANDARDS.md)
