# Search & Discovery System

## Executive Summary

The **Search & Discovery System** is the primary interface through which healthcare professionals access Uniting Doctors' vast medical knowledge base. This system combines advanced full-text search, semantic understanding, intelligent filtering, and personalized recommendations to help users find exactly what they need—whether it's a specific research paper, breaking news about a rare condition, or expert discussions on treatment protocols.

**Core Value**: Transform information overload into precise discovery by understanding medical context, recognizing relationships between concepts, and learning from user behavior to surface the most relevant and actionable content.

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Search Architecture](#search-architecture)
3. [Full-Text Search](#full-text-search)
4. [Semantic Search](#semantic-search)
5. [Medical Entity Recognition](#medical-entity-recognition)
6. [Advanced Filtering](#advanced-filtering)
7. [Tagging System](#tagging-system)
8. [Personalized Discovery](#personalized-discovery)
9. [Search Ranking & Relevance](#search-ranking--relevance)
10. [Auto-Complete & Suggestions](#auto-complete--suggestions)
11. [Saved Searches & Alerts](#saved-searches--alerts)
12. [Performance & Optimization](#performance--optimization)

---

## System Overview

### Search Capabilities

**Core Features**:
- **Full-Text Search**: Search across titles, abstracts, full text, and comments
- **Semantic Search**: Understand medical concepts and synonyms
- **Faceted Filtering**: Refine by specialty, date, content type, journal, etc.
- **Boolean Search**: Support for AND, OR, NOT, phrase matching
- **Citation Search**: Find papers that cite or are cited by a specific article
- **Author Search**: Find all works by specific authors
- **Similar Content**: "More like this" recommendations
- **Visual Search**: Search by image (future: pathology slides, radiology images)

**Search Types**:

1. **Quick Search**: Global search bar, instant results
2. **Advanced Search**: Complex queries with multiple filters
3. **Clinical Decision Search**: Symptom-based, diagnosis-focused
4. **Drug Information Search**: Medication names, interactions, protocols
5. **Guideline Search**: Clinical practice guidelines and protocols
6. **Image Search**: Medical images and figures

### User Experience Goals

- **Speed**: Results in < 200ms for 95% of queries
- **Precision**: Top 5 results relevant for 90% of queries
- **Recall**: Find rare conditions and edge cases
- **Personalization**: Learn from user behavior
- **Context-Awareness**: Understand medical terminology and synonyms

---

## Search Architecture

### Technology Stack

**Search Engine**: **Elasticsearch 8.x**
- Distributed, scalable full-text search
- Real-time indexing
- Advanced text analysis
- Aggregations for faceted search

**Vector Database**: **Pinecone or Weaviate**
- Semantic search via embeddings
- Similarity search for "more like this"
- Hybrid search (keyword + semantic)

**NLP & Embeddings**:
- **BioBERT** or **PubMedBERT** for medical text embeddings
- **SciBERT** for scientific literature
- **GPT-4** or **Claude** for query understanding and expansion

**Caching**: **Redis**
- Cache frequent queries
- Auto-complete suggestions
- Real-time trending topics

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     User Interface                           │
│        Search Bar │ Filters │ Results │ Suggestions          │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Search API Layer                            │
│   Query Parser │ Query Expansion │ Personalization          │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
┌───────▼────────┐          ┌─────────▼────────┐
│  Elasticsearch │          │ Vector Database   │
│  (Keyword)     │          │ (Semantic)        │
└───────┬────────┘          └─────────┬────────┘
        │                             │
        └──────────────┬──────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Ranking & Scoring                           │
│   Relevance │ Freshness │ Quality │ Personalization         │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Results Delivery                            │
│   Formatting │ Highlighting │ Related Content │ Ads         │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **User Query** → Parse and tokenize
2. **Query Understanding** → Expand with synonyms, correct spelling
3. **Parallel Search** → Elasticsearch (keyword) + Vector DB (semantic)
4. **Result Fusion** → Combine and re-rank results
5. **Personalization** → Adjust ranking based on user history
6. **Response** → Return top results with highlighting and suggestions

---

## Full-Text Search

### Elasticsearch Configuration

**Index Structure**:

```json
{
  "settings": {
    "number_of_shards": 5,
    "number_of_replicas": 2,
    "analysis": {
      "analyzer": {
        "medical_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "asciifolding",
            "medical_synonym",
            "english_stemmer",
            "stop_medical"
          ]
        }
      },
      "filter": {
        "medical_synonym": {
          "type": "synonym",
          "synonyms_path": "analysis/medical_synonyms.txt"
        },
        "english_stemmer": {
          "type": "stemmer",
          "language": "english"
        },
        "stop_medical": {
          "type": "stop",
          "stopwords": ["_english_", "patient", "study", "clinical"]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "id": { "type": "keyword" },
      "title": {
        "type": "text",
        "analyzer": "medical_analyzer",
        "fields": {
          "keyword": { "type": "keyword" },
          "ngram": { "type": "text", "analyzer": "ngram_analyzer" }
        }
      },
      "abstract": {
        "type": "text",
        "analyzer": "medical_analyzer"
      },
      "full_text": {
        "type": "text",
        "analyzer": "medical_analyzer"
      },
      "authors": {
        "type": "nested",
        "properties": {
          "name": { "type": "text", "fields": { "keyword": { "type": "keyword" } } },
          "affiliation": { "type": "text" },
          "orcid": { "type": "keyword" }
        }
      },
      "journal": {
        "type": "object",
        "properties": {
          "name": { "type": "keyword" },
          "impact_factor": { "type": "float" },
          "issn": { "type": "keyword" }
        }
      },
      "publication_date": { "type": "date" },
      "specialties": { "type": "keyword" },
      "mesh_terms": { "type": "keyword" },
      "keywords": { "type": "keyword" },
      "doi": { "type": "keyword" },
      "pmid": { "type": "keyword" },
      "content_type": { "type": "keyword" },
      "quality_score": { "type": "float" },
      "citation_count": { "type": "integer" },
      "view_count": { "type": "integer" },
      "save_count": { "type": "integer" },
      "embedding": {
        "type": "dense_vector",
        "dims": 768,
        "index": true,
        "similarity": "cosine"
      }
    }
  }
}
```

### Medical Synonym Dictionary

**Example Synonyms**:
```
# Cardiovascular
myocardial infarction, MI, heart attack, AMI
congestive heart failure, CHF, heart failure, HF
atrial fibrillation, AFib, AF, A-fib

# Respiratory
chronic obstructive pulmonary disease, COPD, emphysema, chronic bronchitis
alpha-1 antitrypsin deficiency, AATD, A1AD, alpha-1

# Diabetes
diabetes mellitus, DM, diabetes, T1D, T2D
diabetic ketoacidosis, DKA
hypoglycemia, low blood sugar

# Oncology
non-small cell lung cancer, NSCLC
small cell lung cancer, SCLC
acute myeloid leukemia, AML

# Medications
acetaminophen, paracetamol, tylenol
ibuprofen, advil, motrin
```

### Search Query DSL

**Simple Search**:
```json
{
  "query": {
    "multi_match": {
      "query": "alpha-1 antitrypsin deficiency treatment",
      "fields": ["title^3", "abstract^2", "full_text", "keywords^2"],
      "type": "best_fields",
      "operator": "or",
      "fuzziness": "AUTO"
    }
  },
  "highlight": {
    "fields": {
      "title": {},
      "abstract": {},
      "full_text": { "fragment_size": 150, "number_of_fragments": 3 }
    }
  },
  "size": 20,
  "from": 0
}
```

**Advanced Boolean Search**:
```json
{
  "query": {
    "bool": {
      "must": [
        {
          "multi_match": {
            "query": "heart failure",
            "fields": ["title", "abstract"]
          }
        }
      ],
      "should": [
        { "match": { "keywords": "treatment" } },
        { "match": { "keywords": "therapy" } }
      ],
      "must_not": [
        { "match": { "title": "pediatric" } }
      ],
      "filter": [
        { "range": { "publication_date": { "gte": "2020-01-01" } } },
        { "terms": { "content_type": ["research", "review"] } }
      ]
    }
  }
}
```

### Field Boosting Strategy

**Importance Weighting**:
- Title: 3x (most relevant)
- Keywords: 2x
- Abstract: 2x
- MeSH terms: 1.5x
- Full text: 1x (baseline)
- Comments: 0.5x

**Quality Boosting**:
- High-impact journals: +10%
- Recent publications (< 1 year): +5%
- High citation count: +2% per 100 citations (capped at +20%)
- Editorial picks: +15%

---

## Semantic Search

### Medical Text Embeddings

**Model**: BioBERT or PubMedBERT (768-dimensional embeddings)

**Why BioBERT?**
- Pre-trained on PubMed abstracts and PMC full-text articles
- Understands medical terminology and context
- Superior performance on biomedical NER, relation extraction, Q&A

**Embedding Generation**:
```python
from transformers import AutoTokenizer, AutoModel
import torch

# Load BioBERT model
tokenizer = AutoTokenizer.from_pretrained("dmis-lab/biobert-v1.1")
model = AutoModel.from_pretrained("dmis-lab/biobert-v1.1")

def generate_embedding(text):
    """Generate 768-dim embedding for medical text"""
    inputs = tokenizer(text, return_tensors="pt",
                      max_length=512, truncation=True, padding=True)

    with torch.no_grad():
        outputs = model(**inputs)

    # Use [CLS] token embedding as document representation
    embedding = outputs.last_hidden_state[:, 0, :].squeeze().numpy()

    return embedding

# Example
article_text = "Alpha-1 antitrypsin deficiency (AATD) is a genetic disorder..."
embedding = generate_embedding(article_text)
# Store in vector database with article ID
```

### Vector Search

**Similarity Search**:
```python
# Using Pinecone for vector search
import pinecone

pinecone.init(api_key="your-api-key", environment="us-west1-gcp")
index = pinecone.Index("medical-articles")

# Query for similar articles
query_embedding = generate_embedding("treatment options for AATD")

results = index.query(
    vector=query_embedding.tolist(),
    top_k=20,
    include_metadata=True,
    filter={
        "specialties": {"$in": ["pulmonology", "genetics"]},
        "publication_year": {"$gte": 2020}
    }
)

for match in results['matches']:
    print(f"ID: {match['id']}, Score: {match['score']:.3f}")
    print(f"Title: {match['metadata']['title']}")
```

### Hybrid Search (Keyword + Semantic)

**Fusion Strategy**: Combine Elasticsearch (keyword) and vector search results

**Reciprocal Rank Fusion (RRF)**:
```python
def reciprocal_rank_fusion(keyword_results, semantic_results, k=60):
    """
    Combine two ranked lists using RRF algorithm
    RRF score = sum(1 / (k + rank))
    """
    scores = {}

    # Score keyword results
    for rank, doc_id in enumerate(keyword_results, start=1):
        scores[doc_id] = scores.get(doc_id, 0) + 1 / (k + rank)

    # Score semantic results
    for rank, doc_id in enumerate(semantic_results, start=1):
        scores[doc_id] = scores.get(doc_id, 0) + 1 / (k + rank)

    # Sort by combined score
    ranked = sorted(scores.items(), key=lambda x: x[1], reverse=True)

    return [doc_id for doc_id, score in ranked]

# Example usage
es_results = ['doc1', 'doc2', 'doc3', 'doc5', 'doc8']
vector_results = ['doc2', 'doc4', 'doc5', 'doc7', 'doc9']

final_ranking = reciprocal_rank_fusion(es_results, vector_results)
# Result: ['doc2', 'doc5', 'doc1', 'doc3', 'doc4', ...]
```

**Weighted Hybrid**:
```python
def weighted_hybrid_search(query, alpha=0.7):
    """
    Combine keyword and semantic search with weighting
    alpha: weight for keyword search (1-alpha for semantic)
    """
    # Keyword search
    es_results = elasticsearch_search(query)

    # Semantic search
    query_embedding = generate_embedding(query)
    vector_results = vector_search(query_embedding)

    # Normalize scores to [0, 1]
    es_scores = normalize_scores(es_results)
    vector_scores = normalize_scores(vector_results)

    # Combine scores
    combined = {}
    for doc_id, score in es_scores.items():
        combined[doc_id] = alpha * score

    for doc_id, score in vector_scores.items():
        combined[doc_id] = combined.get(doc_id, 0) + (1 - alpha) * score

    # Sort and return
    return sorted(combined.items(), key=lambda x: x[1], reverse=True)
```

### Query Understanding

**Query Expansion with GPT-4**:
```python
async def expand_medical_query(query):
    """
    Use GPT-4 to understand medical query and generate synonyms/related terms
    """
    prompt = f"""
    Given this medical search query: "{query}"

    1. Identify the main medical concepts
    2. List medical synonyms and abbreviations
    3. Suggest related search terms
    4. Identify the likely specialty/field

    Output as JSON.
    """

    response = await openai.ChatCompletion.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )

    expansion = json.loads(response.choices[0].message.content)

    return {
        'original': query,
        'concepts': expansion['concepts'],
        'synonyms': expansion['synonyms'],
        'related_terms': expansion['related_terms'],
        'specialty': expansion['specialty']
    }

# Example
result = await expand_medical_query("AATD lung disease")
# Result:
# {
#   'original': 'AATD lung disease',
#   'concepts': ['Alpha-1 Antitrypsin Deficiency', 'Pulmonary Disease'],
#   'synonyms': ['A1AD', 'alpha-1', 'AAT deficiency'],
#   'related_terms': ['emphysema', 'COPD', 'protease inhibitor', 'augmentation therapy'],
#   'specialty': 'Pulmonology'
# }
```

---

## Medical Entity Recognition

### Named Entity Recognition (NER)

**Entity Types**:
- **Diseases & Conditions**: Diabetes, COPD, myocardial infarction
- **Symptoms**: Chest pain, dyspnea, fever
- **Medications**: Metformin, insulin, aspirin
- **Procedures**: Coronary artery bypass, angioplasty
- **Anatomy**: Heart, lungs, liver
- **Tests**: ECG, MRI, blood glucose
- **Genes**: SERPINA1, BRCA1, TP53

**NER Model**: scispaCy with BioBERT

```python
import spacy
from scispacy.linking import EntityLinker

# Load model
nlp = spacy.load("en_ner_bc5cdr_md")  # Disease and chemical entities
nlp.add_pipe("scispacy_linker", config={"resolve_abbreviations": True,
                                         "linker_name": "umls"})

def extract_medical_entities(text):
    """Extract and link medical entities to UMLS concepts"""
    doc = nlp(text)

    entities = []
    for ent in doc.ents:
        # Get UMLS concept ID
        umls_ents = ent._.kb_ents
        if umls_ents:
            cui = umls_ents[0][0]  # Concept Unique Identifier
            entities.append({
                'text': ent.text,
                'label': ent.label_,
                'cui': cui,
                'start': ent.start_char,
                'end': ent.end_char
            })

    return entities

# Example
text = "Patient with alpha-1 antitrypsin deficiency presenting with emphysema"
entities = extract_medical_entities(text)
# [
#   {'text': 'alpha-1 antitrypsin deficiency', 'label': 'DISEASE', 'cui': 'C0221757', ...},
#   {'text': 'emphysema', 'label': 'DISEASE', 'cui': 'C0034067', ...}
# ]
```

### Medical Concept Linking

**UMLS (Unified Medical Language System)**:
- Links medical terms to standardized concepts
- Enables semantic search across different terminologies
- Supports synonym expansion

**SNOMED CT Integration**:
- Clinical terminology standard
- Hierarchical relationships (is-a, part-of)
- Enable query expansion via concept hierarchy

**Example Query Expansion via UMLS**:
```
User Query: "heart attack"
↓
UMLS Concept: C0027051 (Myocardial Infarction)
↓
Synonyms: MI, AMI, cardiac infarction, coronary thrombosis
↓
Expanded Query: "heart attack" OR "myocardial infarction" OR "MI" OR "AMI"
```

---

## Advanced Filtering

### Faceted Search

**Available Facets**:

1. **Specialty** (Cardiology, Oncology, Neurology, etc.)
2. **Content Type** (Research, Review, Case Report, News, Guideline)
3. **Publication Date** (Last 7 days, 30 days, 1 year, 5 years, Custom range)
4. **Journal** (Top 50 journals as options)
5. **Open Access** (Yes/No)
6. **Study Type** (RCT, Cohort, Case-Control, Meta-Analysis)
7. **Patient Population** (Pediatric, Adult, Geriatric)
8. **Language** (English, Spanish, German, etc.)
9. **Citation Count** (Highly cited, >100, >50, >10)
10. **Quality Score** (High, Medium, Low)

**Elasticsearch Aggregation**:
```json
{
  "query": { "match": { "abstract": "heart failure" } },
  "aggs": {
    "by_specialty": {
      "terms": { "field": "specialties", "size": 20 }
    },
    "by_content_type": {
      "terms": { "field": "content_type" }
    },
    "by_year": {
      "date_histogram": {
        "field": "publication_date",
        "calendar_interval": "year"
      }
    },
    "by_journal": {
      "terms": { "field": "journal.name", "size": 50 }
    },
    "open_access": {
      "terms": { "field": "is_open_access" }
    },
    "citation_ranges": {
      "range": {
        "field": "citation_count",
        "ranges": [
          { "to": 10 },
          { "from": 10, "to": 50 },
          { "from": 50, "to": 100 },
          { "from": 100 }
        ]
      }
    }
  }
}
```

### Dynamic Facet UI

**User Interface**:
```
┌────────────────────────────────────────────────────────┐
│  Search: [heart failure treatment______________] 🔍     │
└────────────────────────────────────────────────────────┘

┌─────────────────┐  ┌──────────────────────────────────┐
│ FILTERS         │  │ RESULTS (12,345 found)           │
│                 │  │                                  │
│ Specialty       │  │ 1. Novel HFrEF Therapy Shows... │
│ ☑ Cardiology    │  │    JACC | 2025-01-15            │
│ ☐ Nephrology    │  │    ★★★★★ High Impact            │
│ ☐ Critical Care │  │                                  │
│                 │  │ 2. Meta-analysis of Beta-Block...│
│ Content Type    │  │    Circulation | 2024-11-30     │
│ ☑ Research      │  │    ★★★★☆                        │
│ ☑ Review        │  │                                  │
│ ☐ Guideline     │  │ 3. Heart Failure Guidelines... │
│                 │  │    ESC | 2024-08-22             │
│ Publication Date│  │    ★★★★★ Guideline              │
│ ● Last year     │  │                                  │
│ ○ Last 5 years  │  │ ...                             │
│ ○ All time      │  │                                  │
│                 │  │                                  │
│ Study Type      │  │ [Load More]                     │
│ ☑ RCT           │  │                                  │
│ ☐ Meta-Analysis │  │                                  │
└─────────────────┘  └──────────────────────────────────┘
```

### Smart Filters

**Context-Aware Filtering**:
- Auto-suggest specialty based on query terms
- Recommend relevant filters (e.g., "RCT" for treatment queries)
- Show most popular filter combinations

**Filter Combinations**:
```python
# Track popular filter combinations
filter_analytics = {
    ('cardiology', 'RCT', 'last_year'): 1245,  # usage count
    ('oncology', 'meta-analysis', 'highly_cited'): 892,
    ('neurology', 'review', 'last_5_years'): 654
}

def suggest_filters(user_query, current_filters):
    """Suggest additional filters based on query and current selections"""
    specialty = detect_specialty(user_query)

    # Find common filter combinations for this specialty
    suggestions = []
    for combo, count in filter_analytics.items():
        if specialty in combo and count > 500:
            missing_filters = set(combo) - set(current_filters)
            if missing_filters:
                suggestions.extend(missing_filters)

    return suggestions[:3]  # Top 3 suggestions
```

---

## Tagging System

### Automatic Tagging

**Tag Types**:

1. **Medical Specialty Tags**: Generated by ML classifier
2. **MeSH Terms**: From PubMed metadata
3. **Drug Tags**: Extracted via NER
4. **Disease Tags**: Extracted via NER + UMLS linking
5. **Methodology Tags**: RCT, cohort study, case report, etc.
6. **Population Tags**: Pediatric, geriatric, pregnant, etc.
7. **Outcome Tags**: Mortality, morbidity, quality of life, etc.

**Tag Generation Pipeline**:
```python
async def generate_tags(article):
    """Generate all tags for an article"""
    tags = {
        'specialties': await classify_specialty(article),
        'mesh_terms': article.get('mesh_terms', []),
        'diseases': await extract_disease_tags(article.abstract),
        'drugs': await extract_drug_tags(article.abstract),
        'methodologies': await detect_study_type(article),
        'populations': await extract_population_tags(article),
        'outcomes': await extract_outcome_tags(article)
    }

    # Flatten and deduplicate
    all_tags = []
    for tag_list in tags.values():
        all_tags.extend(tag_list)

    return list(set(all_tags))
```

### User-Generated Tags

**Community Tagging**:
- Allow verified medical professionals to add tags
- Voting system for tag relevance (upvote/downvote)
- Tag moderation to prevent spam

**Personal Tags**:
- Users can create private tags for personal organization
- Tag collections (reading lists, research topics, teaching materials)

### Tag Hierarchy & Relationships

**Hierarchical Tags** (Example):
```
Cardiology
├── Heart Failure
│   ├── HFrEF
│   ├── HFpEF
│   └── Acute Decompensated HF
├── Arrhythmias
│   ├── Atrial Fibrillation
│   ├── Ventricular Tachycardia
│   └── Heart Block
└── Coronary Artery Disease
    ├── Acute MI
    ├── Stable Angina
    └── Unstable Angina
```

**Tag Search Expansion**:
```python
def expand_tag_query(tag):
    """
    When user searches for parent tag, include child tags
    """
    tag_hierarchy = {
        'heart_failure': ['hfref', 'hfpef', 'acute_decompensated_hf'],
        'arrhythmias': ['atrial_fibrillation', 'vtach', 'heart_block'],
        'diabetes': ['type_1_diabetes', 'type_2_diabetes', 'gestational_diabetes']
    }

    children = tag_hierarchy.get(tag.lower(), [])
    return [tag] + children

# Search for "heart failure" includes HFrEF, HFpEF, etc.
```

---

## Personalized Discovery

### User Behavior Tracking

**Tracked Actions**:
- Articles viewed (with dwell time)
- Articles saved/bookmarked
- Articles shared
- Search queries
- Filters applied
- Comments and discussions

**User Profile Building**:
```python
class UserProfile:
    def __init__(self, user_id):
        self.user_id = user_id
        self.specialty_interests = {}  # {specialty: interest_score}
        self.topic_interests = {}      # {topic: interest_score}
        self.journal_preferences = {}  # {journal: preference_score}
        self.reading_history = []

    def update_from_interaction(self, article, interaction_type):
        """Update profile based on user interaction"""
        weight = {
            'view': 1.0,
            'save': 3.0,
            'share': 5.0,
            'cite': 10.0
        }.get(interaction_type, 1.0)

        # Update specialty interests
        for specialty in article.specialties:
            self.specialty_interests[specialty] = \
                self.specialty_interests.get(specialty, 0) + weight

        # Update topic interests
        for topic in article.keywords:
            self.topic_interests[topic] = \
                self.topic_interests.get(topic, 0) + weight

        # Update journal preferences
        journal = article.journal.name
        self.journal_preferences[journal] = \
            self.journal_preferences.get(journal, 0) + weight

        # Add to reading history
        self.reading_history.append({
            'article_id': article.id,
            'timestamp': datetime.now(),
            'interaction': interaction_type
        })
```

### Collaborative Filtering

**Similar User Discovery**:
```python
def find_similar_users(user_id, limit=50):
    """
    Find users with similar reading patterns
    Using Jaccard similarity on articles read
    """
    target_user_articles = set(get_user_reading_history(user_id))

    similarities = []
    for other_user_id in get_all_users():
        if other_user_id == user_id:
            continue

        other_articles = set(get_user_reading_history(other_user_id))

        # Jaccard similarity
        intersection = len(target_user_articles & other_articles)
        union = len(target_user_articles | other_articles)
        similarity = intersection / union if union > 0 else 0

        if similarity > 0.1:  # Threshold
            similarities.append((other_user_id, similarity))

    # Sort by similarity
    similarities.sort(key=lambda x: x[1], reverse=True)
    return similarities[:limit]

def recommend_from_similar_users(user_id, limit=20):
    """
    Recommend articles that similar users have read
    """
    similar_users = find_similar_users(user_id)
    target_user_articles = set(get_user_reading_history(user_id))

    recommendations = {}
    for similar_user_id, similarity in similar_users:
        their_articles = get_user_reading_history(similar_user_id)

        for article_id in their_articles:
            if article_id not in target_user_articles:
                score = recommendations.get(article_id, 0) + similarity
                recommendations[article_id] = score

    # Sort by score
    ranked = sorted(recommendations.items(), key=lambda x: x[1], reverse=True)
    return [article_id for article_id, score in ranked[:limit]]
```

### Content-Based Recommendations

**"More Like This"**:
```python
def recommend_similar_articles(article_id, limit=10):
    """
    Find articles similar to the given article
    Using embedding similarity + keyword overlap
    """
    source_article = get_article(article_id)
    source_embedding = source_article.embedding

    # Vector similarity search
    similar_by_embedding = vector_search(
        source_embedding,
        top_k=50,
        filters={'specialties': source_article.specialties}
    )

    # Keyword-based similarity
    similar_by_keywords = elasticsearch_more_like_this(
        article_id,
        fields=['keywords', 'mesh_terms', 'abstract']
    )

    # Combine using RRF
    combined = reciprocal_rank_fusion(similar_by_embedding, similar_by_keywords)

    return combined[:limit]
```

### Personalized Ranking

**Adjust Search Results Based on User Profile**:
```python
def personalized_ranking(search_results, user_profile):
    """
    Re-rank search results based on user interests
    """
    scored_results = []

    for article in search_results:
        base_score = article.relevance_score

        # Specialty boost
        specialty_boost = 0
        for specialty in article.specialties:
            interest = user_profile.specialty_interests.get(specialty, 0)
            specialty_boost += interest / 100  # Normalize

        # Topic boost
        topic_boost = 0
        for keyword in article.keywords:
            interest = user_profile.topic_interests.get(keyword, 0)
            topic_boost += interest / 100

        # Journal boost
        journal = article.journal.name
        journal_boost = user_profile.journal_preferences.get(journal, 0) / 100

        # Combined personalized score
        personalized_score = base_score * (1 + specialty_boost + topic_boost + journal_boost)

        scored_results.append((article, personalized_score))

    # Sort by personalized score
    scored_results.sort(key=lambda x: x[1], reverse=True)

    return [article for article, score in scored_results]
```

---

## Search Ranking & Relevance

### Relevance Scoring

**Multi-Factor Ranking**:

```python
def calculate_relevance_score(article, query, user_profile=None):
    """
    Comprehensive relevance scoring
    """
    score = 0

    # 1. Text Match Score (BM25 from Elasticsearch)
    text_score = article.es_score  # 0-10 range
    score += text_score * 10  # Weight: 10x

    # 2. Quality Score
    quality_score = calculate_quality_score(article)  # 0-100
    score += quality_score * 0.5  # Weight: 0.5x

    # 3. Recency Boost
    days_old = (datetime.now() - article.publication_date).days
    if days_old < 30:
        recency_boost = 10
    elif days_old < 365:
        recency_boost = 5
    else:
        recency_boost = 0
    score += recency_boost

    # 4. Citation Velocity
    if article.citation_count > 0 and days_old > 0:
        citations_per_day = article.citation_count / days_old
        citation_boost = min(citations_per_day * 10, 20)  # Cap at 20
        score += citation_boost

    # 5. Engagement Score
    engagement = (
        article.view_count * 0.01 +
        article.save_count * 0.5 +
        article.share_count * 1.0 +
        article.comment_count * 2.0
    )
    score += min(engagement, 30)  # Cap at 30

    # 6. Personalization Boost (if user profile provided)
    if user_profile:
        specialty_match = any(
            s in user_profile.specialty_interests
            for s in article.specialties
        )
        if specialty_match:
            score += 15

    return score

def calculate_quality_score(article):
    """
    Article quality score (0-100)
    """
    score = 50  # Base score

    # Journal impact factor
    if article.journal.impact_factor:
        score += min(article.journal.impact_factor * 2, 30)

    # Peer-reviewed
    if article.is_peer_reviewed:
        score += 10

    # Has DOI
    if article.doi:
        score += 5

    # Author reputation
    if article.has_high_profile_authors:
        score += 10

    # Institutional affiliation
    if article.has_top_institution:
        score += 5

    return min(score, 100)
```

### Learning to Rank (LTR)

**Machine Learning Model**:
- Train on historical search data
- Features: Query-article match, user engagement, article quality
- Model: LambdaMART, XGBoost, or Neural Network

**Feature Engineering**:
```python
def extract_ranking_features(query, article, user_profile):
    """
    Extract features for LTR model
    """
    features = {
        # Query-Article Match Features
        'bm25_score': article.es_score,
        'title_match': query_terms_in_title(query, article.title),
        'abstract_match': query_terms_in_abstract(query, article.abstract),
        'exact_phrase_match': exact_phrase_in_text(query, article.full_text),

        # Article Quality Features
        'journal_impact_factor': article.journal.impact_factor or 0,
        'citation_count': article.citation_count,
        'is_peer_reviewed': int(article.is_peer_reviewed),
        'is_open_access': int(article.is_open_access),

        # Recency Features
        'days_since_publication': (datetime.now() - article.publication_date).days,
        'is_recent': int((datetime.now() - article.publication_date).days < 365),

        # Engagement Features
        'view_count': article.view_count,
        'save_count': article.save_count,
        'share_count': article.share_count,
        'comment_count': article.comment_count,

        # Semantic Features
        'semantic_similarity': cosine_similarity(query_embedding, article.embedding),

        # Personalization Features (if user logged in)
        'user_specialty_match': specialty_overlap(user_profile, article),
        'user_topic_interest': topic_interest_score(user_profile, article),
        'user_journal_preference': journal_preference_score(user_profile, article)
    }

    return features
```

**Model Training**:
```python
import xgboost as xgb
from sklearn.model_selection import train_test_split

# Training data: (query, article, relevance_label)
# relevance_label: 0 (not clicked), 1 (clicked), 2 (saved), 3 (cited)

def train_ranking_model(training_data):
    """
    Train XGBoost Learning-to-Rank model
    """
    X = []  # Features
    y = []  # Relevance labels
    groups = []  # Query groups

    for query_id, results in training_data.items():
        group_size = len(results)
        groups.append(group_size)

        for article, label in results:
            features = extract_ranking_features(query_id, article, user_profile=None)
            X.append(list(features.values()))
            y.append(label)

    # Create DMatrix for XGBoost
    dtrain = xgb.DMatrix(X, label=y)
    dtrain.set_group(groups)

    # Training parameters
    params = {
        'objective': 'rank:pairwise',
        'eta': 0.1,
        'max_depth': 6,
        'eval_metric': 'ndcg@10'
    }

    model = xgb.train(params, dtrain, num_boost_round=100)

    return model

# Inference
def rerank_with_model(model, query, search_results, user_profile):
    """
    Re-rank search results using trained model
    """
    features_list = []
    for article in search_results:
        features = extract_ranking_features(query, article, user_profile)
        features_list.append(list(features.values()))

    dtest = xgb.DMatrix(features_list)
    scores = model.predict(dtest)

    # Sort by predicted score
    ranked_results = sorted(
        zip(search_results, scores),
        key=lambda x: x[1],
        reverse=True
    )

    return [article for article, score in ranked_results]
```

---

## Auto-Complete & Suggestions

### Query Auto-Completion

**Trie-Based Auto-Complete**:
```python
class AutoCompleter:
    def __init__(self):
        self.trie = {}
        self.popular_queries = {}  # {query: frequency}

    def add_query(self, query, frequency=1):
        """Add query to trie"""
        node = self.trie
        for char in query.lower():
            if char not in node:
                node[char] = {}
            node = node[char]
        node['$'] = query  # End marker
        self.popular_queries[query] = frequency

    def suggest(self, prefix, limit=10):
        """Get suggestions for prefix"""
        node = self.trie

        # Navigate to prefix
        for char in prefix.lower():
            if char not in node:
                return []
            node = node[char]

        # Collect all completions
        suggestions = []
        self._collect_suggestions(node, suggestions)

        # Sort by popularity
        suggestions.sort(
            key=lambda q: self.popular_queries.get(q, 0),
            reverse=True
        )

        return suggestions[:limit]

    def _collect_suggestions(self, node, results):
        """Recursively collect all queries from node"""
        if '$' in node:
            results.append(node['$'])

        for key, child in node.items():
            if key != '$':
                self._collect_suggestions(child, results)

# Usage
autocompleter = AutoCompleter()

# Load from popular queries
popular_queries = [
    ("heart failure treatment", 1500),
    ("heart attack symptoms", 1200),
    ("heart disease prevention", 980),
    ("alpha-1 antitrypsin deficiency", 650),
    ("diabetes management", 1100)
]

for query, freq in popular_queries:
    autocompleter.add_query(query, freq)

# Get suggestions
suggestions = autocompleter.suggest("heart")
# ['heart failure treatment', 'heart attack symptoms', 'heart disease prevention']
```

### Elasticsearch Auto-Completion

**Suggestion Index**:
```json
{
  "mappings": {
    "properties": {
      "suggest": {
        "type": "completion",
        "analyzer": "simple",
        "preserve_separators": true,
        "preserve_position_increments": true,
        "max_input_length": 50
      },
      "weight": {
        "type": "integer"
      }
    }
  }
}
```

**Query**:
```json
{
  "suggest": {
    "query-suggestion": {
      "prefix": "heart fa",
      "completion": {
        "field": "suggest",
        "size": 10,
        "fuzzy": {
          "fuzziness": 2
        }
      }
    }
  }
}
```

### Medical Term Suggestions

**Context-Aware Suggestions**:
- Suggest medical terms as user types
- Include synonyms and abbreviations
- Highlight matched portions

**Example UI**:
```
Search: [alpha-1 ant___]
         ↓
Suggestions:
• alpha-1 antitrypsin deficiency (AATD)
• alpha-1 antitrypsin [protein]
• alpha-1 antitrypsin augmentation therapy
• anti-alpha-1 antitrypsin antibodies
```

---

## Saved Searches & Alerts

### Saved Searches

**Save Complex Queries**:
```typescript
interface SavedSearch {
  id: string;
  userId: string;
  name: string;
  query: string;
  filters: {
    specialties?: string[];
    contentTypes?: string[];
    dateRange?: { from: string; to: string };
    journals?: string[];
  };
  alertFrequency: 'realtime' | 'daily' | 'weekly' | 'none';
  createdAt: Date;
  lastRun: Date;
}

// Save search
async function saveSearch(userId: string, searchConfig: SavedSearch) {
  await db.savedSearches.insert({
    ...searchConfig,
    userId,
    createdAt: new Date()
  });
}

// Run saved search
async function runSavedSearch(savedSearchId: string) {
  const config = await db.savedSearches.findById(savedSearchId);

  const results = await search({
    query: config.query,
    filters: config.filters,
    userId: config.userId
  });

  await db.savedSearches.update(savedSearchId, {
    lastRun: new Date()
  });

  return results;
}
```

### Search Alerts

**Alert on New Results**:
```python
async def check_saved_search_alerts():
    """
    Periodic job to check saved searches for new results
    Run every hour for daily alerts, once per day for weekly
    """
    saved_searches = await db.saved_searches.find({
        'alertFrequency': {'$ne': 'none'}
    })

    for search in saved_searches:
        # Get last alerted timestamp
        last_alerted = search.get('lastAlerted', search['createdAt'])

        # Search for new articles since last alert
        results = await search_api({
            'query': search['query'],
            'filters': {
                **search['filters'],
                'publication_date': {'$gte': last_alerted}
            }
        })

        if len(results) > 0:
            # Send alert
            await send_search_alert(
                user_id=search['userId'],
                search_name=search['name'],
                new_results=results
            )

            # Update last alerted
            await db.saved_searches.update(
                search['id'],
                {'lastAlerted': datetime.now()}
            )

async def send_search_alert(user_id, search_name, new_results):
    """
    Send email or push notification about new search results
    """
    user = await db.users.findById(user_id)

    if user.preferences.emailAlerts:
        await send_email(
            to=user.email,
            subject=f"New results for '{search_name}'",
            body=render_search_alert_email(search_name, new_results)
        )

    if user.preferences.pushNotifications:
        await send_push_notification(
            user_id=user_id,
            title=f"{len(new_results)} new results for '{search_name}'",
            body=new_results[0]['title'],  # First result as preview
            action_url=f"/searches/{search_name}/results"
        )
```

---

## Performance & Optimization

### Caching Strategy

**Redis Caching**:

1. **Query Result Cache**:
   - Cache top 100 search results for popular queries
   - TTL: 15 minutes
   - Invalidate on new content publication

2. **Auto-Complete Cache**:
   - Cache suggestion results
   - TTL: 1 hour
   - Pre-compute popular prefixes

3. **User Profile Cache**:
   - Cache user preferences and interests
   - TTL: 30 minutes
   - Invalidate on user profile updates

**Implementation**:
```python
import redis
import json

redis_client = redis.Redis(host='localhost', port=6379, db=0)

async def cached_search(query, filters, user_id=None):
    """
    Search with result caching
    """
    # Generate cache key
    cache_key = f"search:{hash(query)}:{hash(json.dumps(filters))}:{user_id}"

    # Check cache
    cached = redis_client.get(cache_key)
    if cached:
        return json.loads(cached)

    # Perform search
    results = await perform_search(query, filters, user_id)

    # Cache results (15 min TTL)
    redis_client.setex(
        cache_key,
        900,  # 15 minutes
        json.dumps(results)
    )

    return results
```

### Query Optimization

**Elasticsearch Performance**:

1. **Index Optimization**:
   - Shard strategy: 5 primary shards per index
   - Replicas: 2 for high availability
   - Refresh interval: 30s (balance between real-time and performance)

2. **Query Optimization**:
   - Use filters instead of queries when possible (cached)
   - Limit `from + size` to reasonable values (< 10,000)
   - Use scroll API for deep pagination
   - Avoid expensive operations (scripts, wildcards at start)

3. **Indexing Strategy**:
   - Bulk indexing for new content (batch size: 1000)
   - Async indexing (don't block user requests)
   - Index only searchable fields

**Example Optimized Query**:
```json
{
  "query": {
    "bool": {
      "must": [
        { "match": { "abstract": { "query": "heart failure", "operator": "and" } } }
      ],
      "filter": [
        { "term": { "specialties": "cardiology" } },
        { "range": { "publication_date": { "gte": "2020-01-01" } } }
      ]
    }
  },
  "_source": ["id", "title", "abstract", "authors", "publication_date"],
  "size": 20
}
```

### Load Testing Results

**Target Performance**:
- Search latency (p95): < 200ms
- Throughput: 1,000 queries/second
- Concurrent users: 10,000

**Optimization Techniques**:
- Connection pooling for Elasticsearch
- Read replicas for database queries
- CDN for static content
- Async processing where possible

---

## Conclusion

The Search & Discovery System is designed to help healthcare professionals quickly find relevant, high-quality medical information from millions of articles, news, and discussions. By combining traditional full-text search with modern semantic search, machine learning-powered ranking, and personalized recommendations, we ensure that users can discover the content most relevant to their practice and research interests.

**Key Success Metrics**:
- **Precision@10**: 90% (9 out of top 10 results are relevant)
- **Search Latency**: < 200ms (p95)
- **User Satisfaction**: 4.5+ stars
- **Query Abandonment**: < 10%

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Technical Architecture Team
**Related Documents**:
- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [DATA_AGGREGATION.md](./DATA_AGGREGATION.md)
- [REPUTATION_SYSTEM.md](./REPUTATION_SYSTEM.md)
