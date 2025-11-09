# Research Integration

## Executive Summary

**Research Integration** connects Uniting Doctors directly with the world's medical research infrastructure—PubMed, clinical trial registries, preprint servers, and institutional repositories—enabling healthcare professionals to access, discuss, and apply the latest research findings in real-time.

---

## Table of Contents

1. [Integration Overview](#integration-overview)
2. [PubMed & MEDLINE Integration](#pubmed--medline-integration)
3. [Clinical Trials Integration](#clinical-trials-integration)
4. [Preprint Server Integration](#preprint-server-integration)
5. [Journal Direct Access](#journal-direct-access)
6. [Citation Networks](#citation-networks)
7. [Research Alerts & Notifications](#research-alerts--notifications)
8. [Institutional Repository Access](#institutional-repository-access)

---

## Integration Overview

### Connected Research Databases

**Primary Integrations**:

- **PubMed/MEDLINE**: 35+ million citations, abstracts, full-text links
- **ClinicalTrials.gov**: 450,000+ registered clinical trials
- **bioRxiv/medRxiv**: Preprint servers for early research access
- **Cochrane Library**: Systematic reviews and meta-analyses
- **Embase**: Pharmaceutical and biomedical database
- **Google Scholar**: Broader academic search
- **Institutional Repositories**: University and hospital research

### Integration Benefits

**For Healthcare Professionals**:

- One-stop access to all major research databases
- Unified search across multiple sources
- Automatic citation linking and formatting
- Real-time alerts for new relevant research
- Discussion threads linked to original research
- Save and organize research across platforms

**For Researchers**:

- Increased visibility for published work
- Direct engagement with clinical community
- Real-world feedback on research findings
- Collaboration opportunities
- Track clinical impact of research

---

## PubMed & MEDLINE Integration

### API Integration

**NCBI E-utilities API**:

```python
class PubMedIntegration:
    def __init__(self, api_key, email):
        self.base_url = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
        self.api_key = api_key
        self.email = email

    async def search_pubmed(self, query, max_results=100):
        """Search PubMed for articles"""
        search_url = f"{self.base_url}esearch.fcgi"
        params = {
            'db': 'pubmed',
            'term': query,
            'retmax': max_results,
            'retmode': 'json',
            'api_key': self.api_key
        }

        response = await self.http_get(search_url, params)
        pmids = response['esearchresult']['idlist']

        # Fetch detailed records
        return await self.fetch_details(pmids)

    async def fetch_details(self, pmids):
        """Fetch full article details"""
        fetch_url = f"{self.base_url}efetch.fcgi"
        params = {
            'db': 'pubmed',
            'id': ','.join(pmids),
            'retmode': 'xml',
            'api_key': self.api_key
        }

        response = await self.http_get(fetch_url, params)
        return self.parse_pubmed_xml(response)
```

### Features

**1. One-Click PubMed Import**:

- Import articles by PMID, DOI, or URL
- Automatic metadata extraction
- Full citation formatting
- Abstract and MeSH terms included

**2. Inline Article Display**:

```
┌─────────────────────────────────────────────────┐
│ 📄 Beta-Blockers in Heart Failure: A Meta-...  │
│                                                 │
│ Authors: Smith J, et al.                        │
│ Journal: JAMA Cardiol. 2024;9(5):543-551      │
│ PMID: 38234567 | DOI: 10.1001/jamac...        │
│                                                 │
│ [Abstract ▼] [Full Text] [Save] [Discuss]     │
│                                                 │
│ Key Findings:                                   │
│ • 35% reduction in mortality (HR 0.65)         │
│ • NNT = 25 over 2 years                        │
│ • 23 RCTs, n=25,000+ patients                  │
│                                                 │
│ 💬 127 comments | 🔖 453 saves                 │
└─────────────────────────────────────────────────┘
```

**3. Related Articles**:

- PubMed's "Similar Articles" algorithm
- Citation network visualization
- Trending related research

**4. Article Metrics**:

- Citation count (PubMed Central, Crossref)
- Altmetric scores (social media mentions)
- PlumX metrics (usage, captures, mentions)

---

## Clinical Trials Integration

### ClinicalTrials.gov API

**Trial Data Access**:

```python
async def search_clinical_trials(condition, intervention=None):
    """Search ClinicalTrials.gov"""
    base_url = "https://clinicaltrials.gov/api/query/study_fields"

    query = f"AREA[Condition]({condition})"
    if intervention:
        query += f" AND AREA[Intervention]({intervention})"

    fields = [
        'NCTId', 'BriefTitle', 'Condition', 'Intervention',
        'Phase', 'StudyStatus', 'StartDate', 'CompletionDate',
        'EnrollmentCount', 'LocationCountry', 'ResultsFirstPostDate'
    ]

    params = {
        'expr': query,
        'fields': ','.join(fields),
        'fmt': 'json',
        'max_rnk': 100
    }

    response = await http_get(base_url, params)
    return parse_trial_data(response)
```

### Trial Information Display

**Trial Card**:

```
┌─────────────────────────────────────────────────────────┐
│ 🔬 Clinical Trial: NCT05234567                          │
│                                                         │
│ Title: Efficacy of Drug X in Advanced Heart Failure    │
│                                                         │
│ Status: ⏳ Active, Recruiting                           │
│ Phase: Phase III                                        │
│ Enrollment: 500 patients (target)                       │
│                                                         │
│ Primary Outcome: All-cause mortality at 2 years        │
│ Expected Completion: December 2026                      │
│                                                         │
│ Locations: 45 sites in USA, Europe                     │
│                                                         │
│ [View Full Protocol] [Patient Eligibility] [Alerts ON] │
│                                                         │
│ 💬 Discussion: 23 physicians discussing this trial      │
└─────────────────────────────────────────────────────────┘
```

### Trial Alerts

**Notification Types**:

- New trials registered for conditions of interest
- Trial status changes (recruiting, completed, results posted)
- Results publication
- Protocol amendments

---

## Preprint Server Integration

### bioRxiv & medRxiv

**Why Preprints Matter**:

- Access to research months before peer review
- Early warning of breakthrough findings
- Opportunity to provide pre-publication feedback
- Track evolution from preprint to published version

**Preprint Warning Label**:

```
⚠️ PREPRINT - NOT PEER-REVIEWED

This research has not yet undergone peer review. Findings are preliminary
and subject to change. Use caution when applying clinically.

[Track Publication Status] [Set Alert for Peer Review]
```

**Preprint Tracking**:

```python
async def track_preprint_to_publication(preprint_doi):
    """
    Monitor preprint for peer-reviewed publication
    """
    # Check Crossref for published version
    published = await check_crossref_for_doi(preprint_doi)

    if published:
        # Notify users who saved/discussed preprint
        await notify_preprint_published(preprint_doi, published)

        # Link preprint to published version
        await link_versions(preprint_doi, published['doi'])

        # Update discussions with peer-review status
        await update_discussion_status(preprint_doi, 'peer_reviewed')
```

---

## Journal Direct Access

### Publisher Partnerships

**Integrated Journals** (Target 100+ partnerships):

- Nature Publishing Group
- JAMA Network
- New England Journal of Medicine
- The Lancet
- BMJ
- Elsevier journals
- Wiley Online Library
- Springer Nature

### Open Access Detection

**Automatic OA Identification**:

```python
async def check_open_access(doi):
    """
    Check if article is open access
    Sources: Unpaywall API, DOAJ, PMC
    """
    # Check Unpaywall
    unpaywall_url = f"https://api.unpaywall.org/v2/{doi}"
    response = await http_get(unpaywall_url)

    if response['is_oa']:
        return {
            'is_open_access': True,
            'oa_url': response['best_oa_location']['url'],
            'version': response['best_oa_location']['version'],  # published/accepted/submitted
            'license': response['best_oa_location']['license']
        }

    # Check PubMed Central
    pmc_available = await check_pmc(doi)

    return {
        'is_open_access': pmc_available,
        'oa_url': pmc_available['url'] if pmc_available else None
    }
```

### Article Access Options

**Display**:

```
📄 Article Access Options:

✅ Open Access - Free Full Text
   └─ Read Now (PMC) | Download PDF

🔓 Institutional Access
   └─ Check your institution's access
   └─ [Login via Institution]

💰 Purchase Options
   └─ $35 - Single article purchase (Publisher)
   └─ $19.95 - DeepDyve rental (24 hours)

📧 Request from Author
   └─ [Email corresponding author]
   └─ ResearchGate available

📚 Interlibrary Loan
   └─ [Request via your library]
```

---

## Citation Networks

### Visualization

**Citation Graph**:

```
                     Smith 2020 (Cited by 45)
                            ↑
                            │
            ┌───────────────┼───────────────┐
            │               │               │
     Jones 2019      Anderson 2021      Lee 2022
    (Cited by 89)   (Cited by 23)    (Cited by 12)
         ↑
         │
    ┌────┴────┐
Williams  Chen
  2018    2017
```

**Interactive Features**:

- Click to explore citing papers
- Filter by specialty, year, journal impact
- Identify seminal papers (highly cited by others)
- Track citation velocity (recent citation rate)

### Citation Alerts

**Notification When**:

- Your saved papers are cited
- Papers you authored are cited
- High-impact papers cite your research
- Citation milestones (50, 100, 500 citations)

---

## Research Alerts & Notifications

### Custom Alert Types

**1. Keyword Alerts**:

```
Alert: "alpha-1 antitrypsin deficiency" OR "AATD"
Sources: PubMed, Clinical Trials, bioRxiv
Frequency: Real-time
Filters: Only RCTs and systematic reviews
```

**2. Journal TOC Alerts**:

- New issue published
- Favorite journals
- Email digest with abstracts

**3. Author Alerts**:

- Track specific researchers
- Notify on new publications
- Include co-authored papers

**4. Trending Research**:

- Most discussed papers this week
- Highest Altmetric scores
- Breaking medical news

### Alert Management Interface

```
┌──────────────────────────────────────────────────┐
│ Your Research Alerts                             │
├──────────────────────────────────────────────────┤
│                                                  │
│ ✉️ AATD Research (37 new articles)              │
│    Keywords: alpha-1 antitrypsin deficiency      │
│    Last 7 days | Delivered: Daily digest        │
│    [Edit] [Pause] [Delete]                      │
│                                                  │
│ 📘 NEJM Table of Contents (New issue)           │
│    Journal: N Engl J Med                        │
│    Delivered: On publication                    │
│    [Edit] [Pause] [Delete]                      │
│                                                  │
│ 👤 Dr. Jane Smith Publications (1 new)          │
│    Tracking: Publications + Citations           │
│    [Edit] [Pause] [Delete]                      │
│                                                  │
│ + Create New Alert                              │
└──────────────────────────────────────────────────┘
```

---

## Institutional Repository Access

### University & Hospital Repositories

**Integration with**:

- DSpace repositories
- EPrints archives
- Fedora repositories
- Institutional IRs via OAI-PMH protocol

**Benefits**:

- Access to thesis/dissertation research
- Hospital clinical research archives
- Departmental working papers
- Grey literature

### Repository Search

**Cross-Repository Search**:

```python
async def search_institutional_repos(query):
    """
    Search across institutional repositories
    Using OAI-PMH protocol
    """
    repositories = [
        'https://dspace.mit.edu/oai/request',
        'https://dash.harvard.edu/oai/request',
        'https://repository.upenn.edu/do/oai/',
        # ... 500+ repositories
    ]

    results = []
    for repo_url in repositories:
        repo_results = await oai_pmh_search(repo_url, query)
        results.extend(repo_results)

    return deduplicate_and_rank(results)
```

---

## Implementation Timeline

### Phase 1: Core Integrations (Months 1-3)

- ✅ PubMed/MEDLINE API integration
- ✅ ClinicalTrials.gov integration
- ✅ Open Access detection (Unpaywall)
- ✅ Basic citation import

### Phase 2: Enhanced Features (Months 4-6)

- ✅ bioRxiv/medRxiv preprint tracking
- ✅ Citation network visualization
- ✅ Research alerts system
- ✅ Journal TOC alerts

### Phase 3: Advanced Integrations (Months 7-12)

- ✅ Institutional repository search
- ✅ Publisher direct partnerships
- ✅ Semantic Scholar integration
- ✅ Automated research summaries (AI)

---

## Success Metrics

**Usage Metrics**:

- Research articles accessed: Target 500K/month
- Citations imported: Target 50K/month
- Active research alerts: Target 100K users
- Clinical trial views: Target 100K/month

**Engagement Metrics**:

- Average time on research content: >5 minutes
- Articles saved per user: >10/month
- Discussion threads per article: >5
- Alert CTR (click-through rate): >25%

**Quality Metrics**:

- User satisfaction with research access: >4.5/5
- Accuracy of metadata extraction: >98%
- Research alert relevance: >90%

---

## Conclusion

Research Integration transforms Uniting Doctors into a comprehensive research platform, connecting healthcare professionals directly with the world's medical literature. By integrating with PubMed, clinical trials, preprints, and institutional repositories, we eliminate barriers to accessing and discussing the latest research.

---

**Document Version**: 1.0
**Last Updated**: November 8, 2025
**Owner**: Research Integration Team
**Related Documents**:

- [DATA_AGGREGATION.md](../technical/DATA_AGGREGATION.md)
- [MEDICAL_CONTENT_STANDARDS.md](./MEDICAL_CONTENT_STANDARDS.md)
