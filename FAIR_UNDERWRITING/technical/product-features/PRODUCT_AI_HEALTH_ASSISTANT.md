# Feature #19: AI Health Assistant (AATD Chatbot)

**Category**: Advanced Feature
**Priority**: Phase 3 (Year 2+ - Nice to Have)
**Status**: Not Started
**Estimated Effort**: 4-5 months
**Team Required**: 1 ML engineer, 1 backend developer, 0.5 FTE medical content reviewer, 0.25 FTE HIPAA compliance officer

---

## Executive Summary

AATD patients have countless questions about their condition, treatment, lifestyle modifications, and test results. Support staff can't scale to answer 24/7, and patients often search unreliable sources (Dr. Google). An AI-powered health assistant trained on AATD-specific knowledge can provide instant, accurate, personalized answers while maintaining HIPAA compliance and knowing when to escalate to human providers.

**Key Value Propositions**:

- **24/7 Availability**: Instant answers to AATD questions anytime
- **Personalized Responses**: Context-aware (knows patient's phenotype, medications, test results)
- **Medical Accuracy**: Trained on peer-reviewed AATD research and clinical guidelines
- **Safe Escalation**: Recognizes urgent symptoms and routes to human providers
- **Multi-Modal**: Text, voice, and visual explanations (charts, diagrams)
- **Privacy-Preserving**: HIPAA-compliant, encrypted conversations, no data shared with OpenAI

**Business Impact**:

- **Reduce Support Costs**: Handle 60% of common questions automatically (-$180K/year)
- **Improve Engagement**: 3.5x increase in platform usage (daily check-ins)
- **Better Outcomes**: Patients who use chatbot have 18% better medication adherence
- **Competitive Moat**: Only AATD platform with specialized medical AI
- **Data Insights**: Aggregate questions reveal patient education gaps

---

## Problem Statement

### Current Gaps

**Scenario 1: Late-Night Anxiety About Symptoms**

> "It's 2 AM and I'm having chest tightness. Is this normal AATD symptoms or should I go to the ER? I can't call my pulmonologist until morning. I'm panicking and searching Google, finding scary information."

**No 24/7 medical guidance** ❌

**Scenario 2: Medication Questions**

> "I just started Prolastin infusions. Can I drink alcohol? What about taking ibuprofen? My infusion is tomorrow and I can't reach my nurse. I don't want to skip my dose but I'm worried about interactions."

**No instant medication information** ❌

**Scenario 3: Test Results Confusion**

> "My lab report says 'AAT 32 mg/dL' and 'phenotype ZZ.' What does this mean for me? Is this good or bad? The doctor explained it but I didn't understand everything."

**No patient-friendly result interpretation** ❌

**Scenario 4: Lifestyle Guidance**

> "I have MZ AATD. Can I exercise? What about living at high altitude? Should I avoid dusty environments? I have so many questions but don't want to bother my doctor for every small thing."

**No lifestyle guidance for rare disease** ❌

**Scenario 5: Language Barrier**

> "My mother speaks only Spanish and has AATD. She has questions about her treatment but can't communicate with English-only support staff. She's frustrated and confused."

**No multilingual support** ❌

---

## Feature Specifications

### 1. AI Architecture (Privacy-First Design)

**Self-Hosted LLM with RAG (Retrieval Augmented Generation)**:

```typescript
interface AIHealthAssistant {
  // Core components
  llm: 'llama-3-70b' | 'mistral-large' | 'gpt-4' | 'claude-3'; // Self-hosted or API
  vectorDB: 'pinecone' | 'weaviate' | 'qdrant'; // For knowledge base embeddings

  // Knowledge sources
  knowledgeBase: {
    medicalGuidelines: string[]; // ATS, ERS AATD guidelines
    peerReviewedPapers: string[]; // PubMed articles on AATD
    patientEducation: string[]; // Patient-friendly content
    medications: string[]; // Drug information (Prolastin, Aralast, etc.)
    faq: string[]; // Common questions and answers
  };

  // Patient context
  patientContext: {
    phenotype?: 'ZZ' | 'MZ' | 'SZ' | 'MS' | 'SS';
    aatLevel?: number;
    fev1?: number;
    medications?: string[];
    allergies?: string[];
    recentSymptoms?: string[];
  };

  // Safety features
  safetyGuards: {
    urgentSymptomDetection: boolean;
    medicationInteractionCheck: boolean;
    disclaimerRequired: boolean;
    humanEscalationThreshold: number; // Confidence threshold
  };
}

class AIHealthAssistantService {
  private llm: LanguageModel;
  private vectorStore: VectorStore;
  private conversationMemory: ConversationMemory;

  async chat(
    userId: string,
    message: string,
    conversationId: string
  ): Promise<ChatResponse> {
    // 1. Load patient context (HIPAA-compliant)
    const patientContext = await this.getPatientContext(userId);

    // 2. Check for urgent symptoms
    const urgencyCheck = await this.detectUrgency(message);
    if (urgencyCheck.isUrgent) {
      return this.generateUrgentResponse(urgencyCheck);
    }

    // 3. Retrieve relevant knowledge (RAG)
    const relevantDocs = await this.retrieveRelevantKnowledge(
      message,
      patientContext
    );

    // 4. Build context-aware prompt
    const prompt = this.buildPrompt(message, patientContext, relevantDocs);

    // 5. Generate response
    const response = await this.llm.generate(prompt, {
      temperature: 0.3, // Lower = more conservative/factual
      maxTokens: 500,
      stopSequences: ['Human:', 'Patient:']
    });

    // 6. Safety checks
    const safetyCheck = await this.checkResponseSafety(response);
    if (!safetyCheck.safe) {
      return this.generateSafeResponse(message);
    }

    // 7. Add disclaimer
    const finalResponse = this.addDisclaimer(response);

    // 8. Store conversation (encrypted)
    await this.storeConversation(
      userId,
      conversationId,
      message,
      finalResponse
    );

    // 9. Check if human escalation needed
    if (safetyCheck.confidence < 0.7) {
      await this.notifyHumanSupport(userId, message, response);
    }

    return {
      message: finalResponse,
      confidence: safetyCheck.confidence,
      sources: relevantDocs.map((doc) => doc.source),
      suggestedActions: this.generateSuggestedActions(message, patientContext)
    };
  }

  buildPrompt(
    userMessage: string,
    patientContext: PatientContext,
    relevantDocs: Document[]
  ): string {
    return `
You are a specialized medical AI assistant for Alpha-1 Antitrypsin Deficiency (AATD).

Patient Context:
- Phenotype: ${patientContext.phenotype || 'Unknown'}
- AAT Level: ${patientContext.aatLevel ? patientContext.aatLevel + ' mg/dL' : 'Unknown'}
- FEV1: ${patientContext.fev1 ? patientContext.fev1 + '% predicted' : 'Unknown'}
- Current Medications: ${patientContext.medications?.join(', ') || 'None listed'}

Relevant Medical Knowledge:
${relevantDocs
  .map(
    (doc) => `
Source: ${doc.source}
Content: ${doc.content}
`
  )
  .join('\n')}

Patient Question: ${userMessage}

Instructions:
1. Provide accurate, evidence-based information specific to AATD
2. Use patient-friendly language (avoid medical jargon)
3. Reference the patient's specific context when relevant
4. If the question involves symptoms that could be urgent, advise seeking immediate medical attention
5. Never provide specific medical advice or diagnosis - only general education
6. Always remind the patient to consult their healthcare provider for personalized advice
7. Keep response concise (under 300 words)

Response:
    `.trim();
  }

  async detectUrgency(message: string): Promise<UrgencyCheck> {
    // Use fine-tuned classifier or rule-based detection
    const urgentKeywords = [
      'chest pain',
      "can't breathe",
      'severe shortness of breath',
      'coughing up blood',
      'hemoptysis',
      'severe chest tightness',
      'unconscious',
      'passing out',
      'severe allergic reaction',
      'anaphylaxis',
      'severe liver pain',
      'jaundice'
    ];

    const messageLower = message.toLowerCase();
    const foundUrgent = urgentKeywords.filter((keyword) =>
      messageLower.includes(keyword)
    );

    if (foundUrgent.length > 0) {
      return {
        isUrgent: true,
        keywords: foundUrgent,
        recommendation: 'Call 911 or go to emergency room immediately'
      };
    }

    // Use ML classifier for more nuanced detection
    const urgencyScore = await this.urgencyClassifier.predict(message);

    return {
      isUrgent: urgencyScore > 0.8,
      keywords: [],
      recommendation:
        urgencyScore > 0.8 ? 'Contact your healthcare provider soon' : null
    };
  }

  async retrieveRelevantKnowledge(
    query: string,
    patientContext: PatientContext
  ): Promise<Document[]> {
    // Generate embedding for query
    const queryEmbedding = await this.embeddings.embed(query);

    // Add context to query
    const contextualQuery = `
      ${query}
      Patient phenotype: ${patientContext.phenotype}
      On augmentation therapy: ${patientContext.medications?.some((m) => m.includes('Prolastin'))}
    `;

    // Semantic search in vector database
    const results = await this.vectorStore.similaritySearch(contextualQuery, {
      limit: 5,
      filter: {
        type: ['guideline', 'peer_reviewed', 'patient_education'],
        relevance_score: { $gte: 0.7 }
      }
    });

    return results.map((result) => ({
      content: result.pageContent,
      source: result.metadata.source,
      relevance: result.score
    }));
  }

  async checkResponseSafety(response: string): Promise<SafetyCheck> {
    // Check for harmful content
    const harmfulPatterns = [
      /stop taking.*medication/i,
      /don't.*see.*doctor/i,
      /ignore.*symptoms/i,
      /diagnose.*with/i,
      /cure.*aatd/i
    ];

    const foundHarmful = harmfulPatterns.filter((pattern) =>
      pattern.test(response)
    );

    if (foundHarmful.length > 0) {
      return {
        safe: false,
        confidence: 0.0,
        issues: ['Potentially harmful advice detected']
      };
    }

    // Check confidence in response (based on retrieval scores)
    const confidence = this.calculateConfidence(response);

    return {
      safe: true,
      confidence,
      issues: []
    };
  }

  addDisclaimer(response: string): string {
    return `
${response}

---
*This information is for educational purposes only and does not constitute medical advice. Always consult your healthcare provider for personalized guidance about your AATD treatment.*
    `.trim();
  }
}
```

### 2. Knowledge Base Construction

**AATD-Specific Training Data**:

```typescript
class KnowledgeBaseBuilder {
  async buildAATDKnowledgeBase(): Promise<void> {
    // 1. Ingest medical guidelines
    await this.ingestGuidelines([
      {
        source: 'ATS/ERS Guidelines on AATD (2003)',
        url: 'https://www.thoracic.org/statements/...',
        content: '...complete guideline text...'
      },
      {
        source: 'Alpha-1 Foundation Clinical Guidelines',
        url: 'https://alpha1.org/...',
        content: '...complete guidelines...'
      }
    ]);

    // 2. Ingest peer-reviewed research
    await this.ingestPubMedArticles([
      'PMID:12345678', // "Augmentation therapy efficacy in ZZ AATD"
      'PMID:87654321' // "FEV1 decline rates in MZ carriers"
      // ... 100+ relevant articles
    ]);

    // 3. Ingest patient education materials
    await this.ingestPatientEducation([
      {
        topic: 'What is AATD?',
        content: 'Alpha-1 Antitrypsin Deficiency is a genetic condition...',
        readingLevel: 'grade-8'
      },
      {
        topic: 'Understanding your phenotype',
        content: 'ZZ phenotype means you inherited two deficient genes...',
        readingLevel: 'grade-8'
      }
      // ... 200+ educational articles
    ]);

    // 4. Ingest medication information
    await this.ingestMedicationData([
      {
        name: 'Prolastin',
        genericName: 'Alpha-1 Proteinase Inhibitor',
        indications:
          'Treatment of emphysema in adults with AATD and ZZ phenotype',
        dosage: '60 mg/kg IV weekly',
        sideEffects: ['Headache', 'Dizziness', 'Nausea', 'Fatigue'],
        interactions: ['No major drug interactions known'],
        contraindications: ['IgA deficiency with antibodies']
      }
      // ... all AATD medications
    ]);

    // 5. Generate embeddings
    await this.generateEmbeddings();

    // 6. Store in vector database
    await this.storeInVectorDB();
  }

  async ingestPubMedArticles(pmids: string[]): Promise<void> {
    for (const pmid of pmids) {
      // Fetch abstract from PubMed API
      const article = await this.fetchPubMedArticle(pmid);

      // Chunk into smaller segments
      const chunks = this.chunkText(article.abstract, 500);

      for (const chunk of chunks) {
        await this.knowledgeBase.add({
          content: chunk,
          metadata: {
            source: `PubMed ${pmid}`,
            title: article.title,
            authors: article.authors,
            year: article.year,
            type: 'peer_reviewed'
          }
        });
      }
    }
  }
}
```

### 3. Conversation UI

**Chat Interface**:

```typescript
function AATDChatbot() {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const [conversationId] = useState(() => uuidv4());

  const sendMessage = async () => {
    if (!input.trim()) return;

    // Add user message
    const userMessage: Message = {
      id: uuidv4(),
      role: 'user',
      content: input,
      timestamp: new Date()
    };
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setLoading(true);

    try {
      // Call AI assistant API
      const response = await fetch('/api/ai-assistant/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: input,
          conversationId
        })
      });

      const data = await response.json();

      // Add assistant message
      const assistantMessage: Message = {
        id: uuidv4(),
        role: 'assistant',
        content: data.message,
        confidence: data.confidence,
        sources: data.sources,
        suggestedActions: data.suggestedActions,
        timestamp: new Date()
      };
      setMessages(prev => [...prev, assistantMessage]);

      // If low confidence, show escalation option
      if (data.confidence < 0.7) {
        setMessages(prev => [...prev, {
          id: uuidv4(),
          role: 'system',
          content: 'Would you like to speak with a human support specialist?',
          actions: [
            { label: 'Yes, connect me', action: 'escalate' },
            { label: 'No, continue with AI', action: 'continue' }
          ],
          timestamp: new Date()
        }]);
      }
    } catch (error) {
      console.error('Chat error:', error);
      setMessages(prev => [...prev, {
        id: uuidv4(),
        role: 'system',
        content: 'Sorry, I encountered an error. Please try again or contact support.',
        timestamp: new Date()
      }]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="chatbot-container">
      {/* Welcome message */}
      {messages.length === 0 && (
        <div className="welcome">
          <h2>👋 Hi! I'm your AATD Health Assistant</h2>
          <p>I can help answer questions about:</p>
          <ul>
            <li>AATD symptoms and treatment</li>
            <li>Medications and side effects</li>
            <li>Test results and what they mean</li>
            <li>Lifestyle recommendations</li>
            <li>Insurance and financial assistance</li>
          </ul>
          <p className="disclaimer">
            💡 I provide general education only. For medical advice, always consult your healthcare provider.
          </p>

          {/* Suggested questions */}
          <div className="suggestions">
            <button onClick={() => setInput('What is my phenotype and what does it mean?')}>
              What does my phenotype mean?
            </button>
            <button onClick={() => setInput('Can I exercise with AATD?')}>
              Can I exercise with AATD?
            </button>
            <button onClick={() => setInput('What are the side effects of Prolastin?')}>
              Prolastin side effects?
            </button>
          </div>
        </div>
      )}

      {/* Messages */}
      <div className="messages">
        {messages.map(msg => (
          <div key={msg.id} className={`message message-${msg.role}`}>
            <div className="message-avatar">
              {msg.role === 'user' ? '👤' : msg.role === 'assistant' ? '🤖' : 'ℹ️'}
            </div>
            <div className="message-content">
              <ReactMarkdown>{msg.content}</ReactMarkdown>

              {/* Show sources */}
              {msg.sources && msg.sources.length > 0 && (
                <details className="sources">
                  <summary>📚 Sources ({msg.sources.length})</summary>
                  <ul>
                    {msg.sources.map((source, i) => (
                      <li key={i}>{source}</li>
                    ))}
                  </ul>
                </details>
              )}

              {/* Suggested actions */}
              {msg.suggestedActions && msg.suggestedActions.length > 0 && (
                <div className="suggested-actions">
                  <p>You might also want to:</p>
                  {msg.suggestedActions.map((action, i) => (
                    <button key={i} onClick={() => handleAction(action)}>
                      {action.label}
                    </button>
                  ))}
                </div>
              )}

              {/* System actions */}
              {msg.actions && (
                <div className="actions">
                  {msg.actions.map((action, i) => (
                    <button key={i} onClick={() => handleSystemAction(action)}>
                      {action.label}
                    </button>
                  ))}
                </div>
              )}

              {/* Confidence indicator (for debugging) */}
              {msg.confidence !== undefined && (
                <div className="confidence">
                  Confidence: {(msg.confidence * 100).toFixed(0)}%
                </div>
              )}

              <time>{formatTime(msg.timestamp)}</time>
            </div>
          </div>
        ))}

        {loading && (
          <div className="message message-assistant">
            <div className="message-avatar">🤖</div>
            <div className="message-content">
              <div className="typing-indicator">
                <span></span><span></span><span></span>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Input */}
      <form className="input-form" onSubmit={(e) => { e.preventDefault(); sendMessage(); }}>
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Ask me anything about AATD..."
          disabled={loading}
          aria-label="Chat message"
        />
        <button type="submit" disabled={loading || !input.trim()}>
          Send
        </button>
      </form>
    </div>
  );
}
```

### 4. Voice Interface

**Speech-to-Text and Text-to-Speech**:

```typescript
class VoiceAssistant {
  private recognition: SpeechRecognition;
  private synthesis: SpeechSynthesis;

  startListening(onResult: (text: string) => void) {
    this.recognition = new webkitSpeechRecognition();
    this.recognition.continuous = false;
    this.recognition.interimResults = false;
    this.recognition.lang = 'en-US';

    this.recognition.onresult = (event) => {
      const transcript = event.results[0][0].transcript;
      onResult(transcript);
    };

    this.recognition.onerror = (event) => {
      console.error('Speech recognition error:', event.error);
    };

    this.recognition.start();
  }

  speak(text: string, lang: string = 'en-US') {
    // Remove markdown formatting
    const cleanText = text
      .replace(/\*\*/g, '')
      .replace(/\*/g, '')
      .replace(/\[([^\]]+)\]\([^\)]+\)/g, '$1')
      .replace(/^#+\s/gm, '');

    const utterance = new SpeechSynthesisUtterance(cleanText);
    utterance.lang = lang;
    utterance.rate = 0.9; // Slightly slower for clarity
    utterance.pitch = 1.0;

    this.synthesis.speak(utterance);
  }

  stopSpeaking() {
    this.synthesis.cancel();
  }
}
```

### 5. Database Schema

```sql
-- AI conversations (encrypted)
CREATE TABLE ai_conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  conversation_id UUID NOT NULL,

  -- Message
  role VARCHAR(20) NOT NULL, -- 'user', 'assistant', 'system'
  message TEXT NOT NULL, -- Encrypted

  -- Metadata
  confidence NUMERIC(3, 2), -- 0.00-1.00
  sources JSONB, -- List of knowledge base sources cited

  -- Safety
  urgency_detected BOOLEAN DEFAULT false,
  escalated_to_human BOOLEAN DEFAULT false,
  escalation_reason TEXT,

  -- Analytics
  response_time_ms INTEGER,
  tokens_used INTEGER,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_ai_conversations_user ON ai_conversations(user_id, conversation_id, created_at);
CREATE INDEX idx_ai_conversations_escalated ON ai_conversations(escalated_to_human) WHERE escalated_to_human = true;

-- Common questions (for analytics and improvement)
CREATE TABLE ai_common_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Question clustering
  question_cluster VARCHAR(200), -- "medication_side_effects", "exercise_guidelines"
  example_question TEXT,

  -- Frequency
  count INTEGER DEFAULT 1,
  last_asked TIMESTAMPTZ DEFAULT NOW(),

  -- Quality metrics
  avg_confidence NUMERIC(3, 2),
  escalation_rate NUMERIC(3, 2), -- % of times this question type is escalated

  -- Improvement tracking
  needs_improvement BOOLEAN DEFAULT false,
  improvement_notes TEXT,

  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_ai_common_questions_cluster ON ai_common_questions(question_cluster);
CREATE INDEX idx_ai_common_questions_needs_improvement ON ai_common_questions(needs_improvement) WHERE needs_improvement = true;
```

### 6. Multi-Language Support

```typescript
class MultilingualAssistant {
  async chat(message: string, language: string = 'en'): Promise<string> {
    // 1. Translate input to English (if needed)
    const englishMessage =
      language === 'en'
        ? message
        : await this.translate(message, language, 'en');

    // 2. Process in English (knowledge base is English)
    const englishResponse = await this.aiAssistant.chat(englishMessage);

    // 3. Translate response back to user's language
    const translatedResponse =
      language === 'en'
        ? englishResponse
        : await this.translate(englishResponse, 'en', language);

    return translatedResponse;
  }

  async translate(text: string, from: string, to: string): Promise<string> {
    // Use translation API (DeepL, Google Translate)
    // For medical content, prefer human-reviewed translations
    const response = await fetch('https://api.deepl.com/v2/translate', {
      method: 'POST',
      headers: { Authorization: `DeepL-Auth-Key ${process.env.DEEPL_API_KEY}` },
      body: new URLSearchParams({
        text,
        source_lang: from.toUpperCase(),
        target_lang: to.toUpperCase(),
        formality: 'default'
      })
    });

    const data = await response.json();
    return data.translations[0].text;
  }
}
```

---

## Success Metrics

### Usage & Engagement

- **Active Users**: 55% use chatbot at least monthly
- **Messages/User**: Average 12 messages/month
- **Session Duration**: 8.5 minutes average
- **Return Rate**: 68% use chatbot again within 7 days

### Quality & Safety

- **Response Accuracy**: 91% (human review of sample conversations)
- **Appropriate Escalations**: 95% of urgent symptoms correctly identified
- **Patient Satisfaction**: 4.4/5 stars
- **False Positives** (unnecessary escalations): <5%

### Business Impact

- **Support Cost Reduction**: 60% of questions handled by AI (-$180K/year)
- **Medication Adherence**: +18% for chatbot users
- **Platform Engagement**: 3.5x increase in daily active users
- **Patient Education**: 85% report better understanding of AATD

---

## Budget Estimate

### Development (4-5 months)

- **ML Engineer** (LLM fine-tuning, RAG pipeline): $170K/year × 0.42 = $71,400
- **Backend Developer** (API, safety checks, integration): $140K/year × 0.42 = $58,800
- **Medical Content Reviewer** (0.5 FTE, validate responses): $130K/year × 0.5 = $65,000
- **HIPAA Compliance Officer** (0.25 FTE, privacy review): $120K/year × 0.25 = $30,000

**Total Development**: ~$225,200

### Annual Operations

- **LLM API Costs** (OpenAI/Anthropic or self-hosted inference): $48,000/year
- **Vector Database** (Pinecone/Weaviate): $12,000/year
- **Translation API** (DeepL for multilingual): $6,000/year
- **Human Review** (0.25 FTE, QA sample conversations): $32,500/year
- **Medical Content Updates** (quarterly guideline updates): $20,000/year

**Total Operations**: ~$118,500/year

### Annual Infrastructure

- **GPU Compute** (if self-hosting LLM): $36,000/year
- **Conversation Storage** (encrypted): $4,800/year
- **Monitoring & Logging**: $7,200/year

**Total Infrastructure**: ~$48,000/year

### **GRAND TOTAL (First Year)**: ~$391,700

### **Ongoing (Year 2+)**: ~$166,500/year

**Value Created**:

- Support cost savings: $180K/year (60% of questions automated)
- Improved medication adherence: 200 patients × $2,400/year avoided costs = $480K/year
- Platform engagement: Increased retention worth $150K/year
  **Total Value**: $810K/year

**Net Benefit (Year 2+)**: +$643K/year

---

## Risks & Mitigations

### Risk 1: Medical Misinformation

**Impact**: AI provides incorrect health advice, patient harm
**Mitigation**: Conservative responses, strong disclaimers, confidence thresholds, human review of low-confidence answers, regular audits of response quality

### Risk 2: Missed Urgent Symptoms

**Impact**: AI doesn't escalate true emergency, delayed care
**Mitigation**: Aggressive urgency detection (high sensitivity), always err on side of escalation, train on emergency symptom datasets, quarterly review of missed escalations

### Risk 3: HIPAA Violation

**Impact**: Conversations leak patient data to third parties
**Mitigation**: End-to-end encryption, self-hosted LLM option, no conversation data sent to OpenAI unless sanitized, BAAs with all vendors, access logging

### Risk 4: Hallucinations (LLM Making Up Facts)

**Impact**: AI confidently states incorrect information
**Mitigation**: RAG (retrieval augmented generation) forces citations, confidence scoring, if no good sources found → escalate to human, regular audits

### Risk 5: Over-Reliance (Patients Skip Doctor Visits)

**Impact**: Patients use chatbot instead of seeing providers
**Mitigation**: Strong disclaimers, suggest provider visits for complex questions, track usage patterns and intervene if excessive, integrate with telemedicine scheduling

---

**Document Owner**: Head of Product, ML Engineering Lead, Chief Medical Officer
**Last Updated**: November 7, 2025
**Status**: Awaiting Approval

**Technical Dependencies**:

- LLM: Llama 3 70B (self-hosted) or GPT-4/Claude-3 (API)
- Vector DB: Pinecone or Weaviate for knowledge base
- Encryption: AES-256 for conversation storage
- Translation: DeepL API (medical-grade translations)
