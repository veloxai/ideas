# Feature #21B-2: Patient-Reported Outcomes (PRO) Platform

**Part of Feature #21: Research Participation Platform (Advanced Data Collection)**

---

## Overview

Patient-Reported Outcomes (PROs) capture the patient's perspective on their health status, symptoms, functioning, and quality of life—information that cannot be obtained from clinical tests or EHR data alone. For AATD research, PROs are **essential** because:

1. **Symptom burden** - Daily dyspnea, cough, fatigue not captured in spirometry
2. **Treatment impact** - How augmentation therapy affects daily life beyond FEV₁
3. **Clinical trial endpoints** - FDA requires PROs for drug approvals (COPD Assessment Test)
4. **Quality of life** - Disease impact on work, social life, mental health
5. **Early signals** - Symptom worsening may precede measurable clinical decline

Fair Underwriting's PRO platform provides:

- **Adaptive surveys** - Branching logic based on responses, reducing burden
- **Multi-modal collection** - Web, mobile app, SMS, voice (IVR)
- **Real-time alerts** - Flag concerning symptoms for clinical follow-up
- **Longitudinal tracking** - Visualize symptom trends over time
- **Integration** - Link PRO data with clinical outcomes (FEV₁, exacerbations, hospitalizations)

---

## Validated PRO Instruments

### COPD-Specific Instruments

```typescript
interface PROInstrument {
  instrumentId: string;
  name: string;
  acronym: string;

  // Metadata
  diseaseArea: string; // 'COPD', 'General Health', 'Mental Health'
  purpose: string; // 'Health status', 'Symptom assessment', 'Quality of life'

  // Scoring
  scoringAlgorithm: string;
  scoreRange: { min: number; max: number };
  minimumClinicallyImportantDifference: number; // MCID
  interpretationGuide: {
    range: [number, number];
    severity: string;
    description: string;
  }[];

  // Administration
  questionCount: number;
  estimatedCompletionMinutes: number;
  recallPeriod: string; // e.g., "past 7 days", "today"
  recommendedFrequency: string; // 'weekly', 'monthly', 'quarterly'

  // Validation
  validated: boolean;
  validationStudies: string[]; // DOI or PMID
  reliability: { cronbachAlpha: number };
  validity: { constructValidity: string; criterionValidity: string };

  // Licensing
  licensingRequired: boolean;
  licenseProvider?: string;
  costPerUse?: number;
}

// CAT: COPD Assessment Test
const catInstrument: PROInstrument = {
  instrumentId: 'cat-v1',
  name: 'COPD Assessment Test',
  acronym: 'CAT',

  diseaseArea: 'COPD',
  purpose: 'Assess health status and impact of COPD on daily life',

  scoringAlgorithm: 'sum_of_items',
  scoreRange: { min: 0, max: 40 },
  minimumClinicallyImportantDifference: 2,
  interpretationGuide: [
    {
      range: [0, 10],
      severity: 'Low impact',
      description: 'COPD has minimal impact on your life'
    },
    {
      range: [11, 20],
      severity: 'Medium impact',
      description: 'COPD has moderate impact on your life'
    },
    {
      range: [21, 30],
      severity: 'High impact',
      description: 'COPD has severe impact on your life'
    },
    {
      range: [31, 40],
      severity: 'Very high impact',
      description: 'COPD has very severe impact on your life'
    }
  ],

  questionCount: 8,
  estimatedCompletionMinutes: 2,
  recallPeriod: 'today',
  recommendedFrequency: 'monthly',

  validated: true,
  validationStudies: ['10.1183/09031936.00102509'],
  reliability: { cronbachAlpha: 0.88 },
  validity: {
    constructValidity: 'Strong correlation with SGRQ (r=0.80)',
    criterionValidity: 'Discriminates GOLD stages'
  },

  licensingRequired: false, // Free to use
  licenseProvider: null,
  costPerUse: 0
};

// SGRQ: St. George's Respiratory Questionnaire
const sgrqInstrument: PROInstrument = {
  instrumentId: 'sgrq-v2.3',
  name: "St. George's Respiratory Questionnaire",
  acronym: 'SGRQ',

  diseaseArea: 'COPD',
  purpose: 'Measure health-related quality of life in respiratory disease',

  scoringAlgorithm: 'weighted_sum',
  scoreRange: { min: 0, max: 100 }, // 0 = best, 100 = worst
  minimumClinicallyImportantDifference: 4,
  interpretationGuide: [
    {
      range: [0, 25],
      severity: 'Minimal impairment',
      description: 'Excellent quality of life'
    },
    {
      range: [26, 50],
      severity: 'Moderate impairment',
      description: 'Good quality of life'
    },
    {
      range: [51, 75],
      severity: 'Severe impairment',
      description: 'Poor quality of life'
    },
    {
      range: [76, 100],
      severity: 'Very severe impairment',
      description: 'Very poor quality of life'
    }
  ],

  questionCount: 50,
  estimatedCompletionMinutes: 10,
  recallPeriod: 'past 4 weeks',
  recommendedFrequency: 'quarterly',

  validated: true,
  validationStudies: ['10.1164/ajrccm.145.6.1595997'],
  reliability: { cronbachAlpha: 0.92 },
  validity: {
    constructValidity: 'Strong correlation with 6MWD, FEV1',
    criterionValidity: 'Predicts exacerbations and mortality'
  },

  licensingRequired: true,
  licenseProvider: 'GSK',
  costPerUse: 0 // Free for academic research
};

// mMRC: Modified Medical Research Council Dyspnea Scale
const mmrcInstrument: PROInstrument = {
  instrumentId: 'mmrc-v1',
  name: 'Modified Medical Research Council Dyspnea Scale',
  acronym: 'mMRC',

  diseaseArea: 'COPD',
  purpose: 'Assess degree of baseline dyspnea',

  scoringAlgorithm: 'single_item',
  scoreRange: { min: 0, max: 4 },
  minimumClinicallyImportantDifference: 1,
  interpretationGuide: [
    {
      range: [0, 0],
      severity: 'Grade 0',
      description: 'Dyspnea only with strenuous exercise'
    },
    {
      range: [1, 1],
      severity: 'Grade 1',
      description: 'Dyspnea when hurrying or walking up slight hill'
    },
    {
      range: [2, 2],
      severity: 'Grade 2',
      description: 'Walks slower than peers or stops for breath'
    },
    {
      range: [3, 3],
      severity: 'Grade 3',
      description: 'Stops for breath after 100 yards or few minutes'
    },
    {
      range: [4, 4],
      severity: 'Grade 4',
      description: 'Too breathless to leave house'
    }
  ],

  questionCount: 1,
  estimatedCompletionMinutes: 1,
  recallPeriod: 'current state',
  recommendedFrequency: 'quarterly',

  validated: true,
  validationStudies: ['10.1378/chest.08-0345'],
  reliability: { cronbachAlpha: 0.95 },
  validity: {
    constructValidity: 'Correlates with FEV1, exercise capacity',
    criterionValidity: 'Predicts mortality'
  },

  licensingRequired: false,
  licenseProvider: null,
  costPerUse: 0
};
```

### Survey Question Database

```sql
-- PRO instruments
CREATE TABLE pro_instruments (
  instrument_id VARCHAR(50) PRIMARY KEY,
  name TEXT NOT NULL,
  acronym VARCHAR(20) NOT NULL,
  disease_area VARCHAR(50),
  purpose TEXT,

  -- Scoring
  scoring_algorithm VARCHAR(50),
  score_min NUMERIC,
  score_max NUMERIC,
  mcid NUMERIC,
  interpretation_guide JSONB,

  -- Administration
  question_count INTEGER,
  estimated_minutes INTEGER,
  recall_period VARCHAR(50),
  recommended_frequency VARCHAR(50),

  -- Validation
  validated BOOLEAN DEFAULT false,
  validation_studies TEXT[],
  reliability JSONB,
  validity JSONB,

  -- Licensing
  licensing_required BOOLEAN DEFAULT false,
  license_provider VARCHAR(100),
  cost_per_use NUMERIC DEFAULT 0,

  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Survey questions
CREATE TABLE pro_questions (
  question_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  instrument_id VARCHAR(50) NOT NULL,

  question_number INTEGER NOT NULL,
  question_text TEXT NOT NULL,
  question_type VARCHAR(50), -- 'single_choice', 'multiple_choice', 'likert_scale', 'numeric', 'free_text'

  -- Response options
  response_options JSONB,
  /*
  [
    { "value": 0, "label": "Never" },
    { "value": 1, "label": "Rarely" },
    { "value": 2, "label": "Sometimes" },
    { "value": 3, "label": "Often" },
    { "value": 4, "label": "Always" }
  ]
  */

  -- Scoring
  scoring_weight NUMERIC DEFAULT 1.0,
  reverse_scored BOOLEAN DEFAULT false,

  -- Conditional logic (adaptive surveys)
  display_condition JSONB,
  /*
  {
    "if_question": "q3",
    "operator": ">=",
    "value": 2
  }
  */

  FOREIGN KEY (instrument_id) REFERENCES pro_instruments(instrument_id)
);

CREATE INDEX idx_pro_questions_instrument ON pro_questions(instrument_id, question_number);

-- Survey responses
CREATE TABLE pro_survey_responses (
  response_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  participant_id UUID NOT NULL,
  instrument_id VARCHAR(50) NOT NULL,

  -- Administration
  started_at TIMESTAMPTZ NOT NULL,
  completed_at TIMESTAMPTZ,
  status VARCHAR(20) NOT NULL, -- 'in_progress', 'completed', 'abandoned'

  -- Responses
  responses JSONB NOT NULL,
  /*
  {
    "q1": 2,
    "q2": 3,
    "q3": 1,
    ...
  }
  */

  -- Calculated scores
  score_summary JSONB,
  /*
  {
    "totalScore": 18,
    "domainScores": {
      "symptoms": 12,
      "activity": 6
    },
    "interpretation": "Medium impact"
  }
  */

  -- Metadata
  device_type VARCHAR(50), -- 'web', 'mobile_ios', 'mobile_android', 'sms', 'ivr'
  completion_time_seconds INTEGER,

  created_at TIMESTAMPTZ DEFAULT NOW(),

  FOREIGN KEY (participant_id) REFERENCES registry_participants(id),
  FOREIGN KEY (instrument_id) REFERENCES pro_instruments(instrument_id)
);

CREATE INDEX idx_pro_survey_responses_participant ON pro_survey_responses(participant_id, completed_at DESC);
CREATE INDEX idx_pro_survey_responses_instrument ON pro_survey_responses(instrument_id);
CREATE INDEX idx_pro_survey_responses_status ON pro_survey_responses(status);
```

---

## Adaptive Survey Engine

### Branching Logic

```typescript
interface AdaptiveSurvey {
  surveyId: string;
  instrumentId: string;
  participantId: string;

  // Survey state
  currentQuestionIndex: number;
  responses: { [questionId: string]: any };

  // Navigation
  questionFlow: string[]; // Question IDs in order (may change based on responses)
  skippedQuestions: string[]; // Questions skipped due to branching logic

  // Progress
  totalQuestions: number;
  answeredQuestions: number;
  percentComplete: number;
}

class AdaptiveSurveyEngine {
  async startSurvey(
    participantId: string,
    instrumentId: string
  ): Promise<AdaptiveSurvey> {
    // 1. Create survey response record
    const surveyId = uuidv4();
    await this.db.insert('pro_survey_responses', {
      response_id: surveyId,
      participant_id: participantId,
      instrument_id: instrumentId,
      started_at: new Date(),
      status: 'in_progress',
      responses: {}
    });

    // 2. Load questions
    const questions = await this.db.query(
      `
      SELECT question_id, question_number, question_text, question_type,
             response_options, display_condition
      FROM pro_questions
      WHERE instrument_id = $1
      ORDER BY question_number
    `,
      [instrumentId]
    );

    // 3. Initialize survey state
    const questionFlow = questions.map((q) => q.question_id);

    return {
      surveyId,
      instrumentId,
      participantId,
      currentQuestionIndex: 0,
      responses: {},
      questionFlow,
      skippedQuestions: [],
      totalQuestions: questions.length,
      answeredQuestions: 0,
      percentComplete: 0
    };
  }

  async answerQuestion(
    surveyId: string,
    questionId: string,
    answer: any
  ): Promise<AdaptiveSurvey> {
    // 1. Update response
    await this.db.query(
      `
      UPDATE pro_survey_responses
      SET
        responses = jsonb_set(responses, '{${questionId}}', $1::jsonb),
        updated_at = NOW()
      WHERE response_id = $2
    `,
      [JSON.stringify(answer), surveyId]
    );

    // 2. Get updated survey state
    const survey = await this.db.findById('pro_survey_responses', surveyId);
    const responses = survey.responses;

    // 3. Determine next question based on branching logic
    const nextQuestionIndex = await this.determineNextQuestion(
      survey.instrument_id,
      responses,
      survey.currentQuestionIndex + 1
    );

    // 4. Update progress
    const answeredCount = Object.keys(responses).length;
    const totalQuestions = await this.db.count('pro_questions', {
      instrument_id: survey.instrument_id
    });

    await this.db.update('pro_survey_responses', surveyId, {
      current_question_index: nextQuestionIndex,
      percent_complete: (answeredCount / totalQuestions) * 100
    });

    return await this.getSurveyState(surveyId);
  }

  async determineNextQuestion(
    instrumentId: string,
    responses: any,
    candidateIndex: number
  ): Promise<number> {
    // Get all questions for instrument
    const questions = await this.db.query(
      `
      SELECT question_id, question_number, display_condition
      FROM pro_questions
      WHERE instrument_id = $1
      ORDER BY question_number
    `,
      [instrumentId]
    );

    // Check each subsequent question for display conditions
    for (let i = candidateIndex; i < questions.length; i++) {
      const question = questions[i];

      if (!question.display_condition) {
        // No condition - always show
        return i;
      }

      // Evaluate condition
      const condition = question.display_condition;
      const dependentQuestionAnswer = responses[condition.if_question];

      if (dependentQuestionAnswer !== undefined) {
        const conditionMet = this.evaluateCondition(
          dependentQuestionAnswer,
          condition.operator,
          condition.value
        );

        if (conditionMet) {
          return i; // Show this question
        }
        // Else skip to next question
      } else {
        // Dependent question not answered yet - shouldn't happen with proper flow
        return i;
      }
    }

    // No more questions
    return questions.length;
  }

  evaluateCondition(answer: any, operator: string, value: any): boolean {
    switch (operator) {
      case '==':
        return answer == value;
      case '!=':
        return answer != value;
      case '>':
        return answer > value;
      case '>=':
        return answer >= value;
      case '<':
        return answer < value;
      case '<=':
        return answer <= value;
      case 'in':
        return Array.isArray(value) && value.includes(answer);
      case 'not_in':
        return Array.isArray(value) && !value.includes(answer);
      default:
        return false;
    }
  }

  async completeSurvey(surveyId: string): Promise<void> {
    // 1. Calculate scores
    const survey = await this.db.findById('pro_survey_responses', surveyId);
    const scoreSummary = await this.calculateScore(
      survey.instrument_id,
      survey.responses
    );

    // 2. Update survey
    await this.db.update('pro_survey_responses', surveyId, {
      completed_at: new Date(),
      status: 'completed',
      score_summary: scoreSummary,
      completion_time_seconds: Math.floor(
        (new Date().getTime() - new Date(survey.started_at).getTime()) / 1000
      )
    });

    // 3. Check for concerning scores (alerts)
    await this.checkForAlerts(surveyId, scoreSummary);
  }

  async calculateScore(instrumentId: string, responses: any): Promise<any> {
    const instrument = await this.db.findById('pro_instruments', instrumentId);
    const questions = await this.db.query(
      `
      SELECT question_id, scoring_weight, reverse_scored
      FROM pro_questions
      WHERE instrument_id = $1
    `,
      [instrumentId]
    );

    let totalScore = 0;

    // Simple sum (most common)
    if (instrument.scoring_algorithm === 'sum_of_items') {
      for (const question of questions) {
        const answer = responses[question.question_id];
        if (answer !== undefined && answer !== null) {
          let score = parseFloat(answer);

          // Reverse scoring if needed
          if (question.reverse_scored) {
            const maxValue = 5; // Assume 0-5 scale
            score = maxValue - score;
          }

          totalScore += score * question.scoring_weight;
        }
      }
    }

    // Weighted sum (SGRQ)
    else if (instrument.scoring_algorithm === 'weighted_sum') {
      // SGRQ has complex domain-specific scoring
      totalScore = await this.calculateSGRQScore(responses);
    }

    // Single item (mMRC)
    else if (instrument.scoring_algorithm === 'single_item') {
      totalScore = responses[questions[0].question_id];
    }

    // Interpretation
    const interpretation = instrument.interpretation_guide.find(
      (guide) => totalScore >= guide.range[0] && totalScore <= guide.range[1]
    );

    return {
      totalScore: Math.round(totalScore),
      interpretation: interpretation?.severity || 'Unknown',
      description: interpretation?.description || '',
      calculatedAt: new Date()
    };
  }

  async checkForAlerts(surveyId: string, scoreSummary: any): Promise<void> {
    const survey = await this.db.findById('pro_survey_responses', surveyId);
    const participant = await this.registryService.getParticipant(
      survey.participant_id
    );

    // CAT score >30 = very high impact
    if (survey.instrument_id === 'cat-v1' && scoreSummary.totalScore > 30) {
      await this.alertService.send({
        userId: participant.userId,
        type: 'concerning_cat_score',
        severity: 'high',
        title: 'Your COPD Symptoms May Need Attention',
        message: `Your CAT score is ${scoreSummary.totalScore}, indicating very high COPD impact. Consider contacting your provider.`,
        actionUrl: '/health/symptoms'
      });

      // Also alert provider
      if (participant.primaryCareProvider) {
        await this.alertService.send({
          userId: participant.primaryCareProvider,
          type: 'patient_concerning_pro',
          severity: 'medium',
          title: 'Patient Report High Symptom Burden',
          message: `${participant.demographics.firstName} ${participant.demographics.lastName} reported CAT score of ${scoreSummary.totalScore}`,
          actionUrl: `/patients/${participant.userId}/symptoms`
        });
      }
    }

    // mMRC grade 4 = too breathless to leave house
    if (survey.instrument_id === 'mmrc-v1' && scoreSummary.totalScore === 4) {
      await this.alertService.send({
        userId: participant.userId,
        type: 'severe_dyspnea',
        severity: 'high',
        title: 'Severe Breathlessness Reported',
        message:
          'You indicated severe breathlessness. Please contact your healthcare provider promptly.',
        actionUrl: '/health/emergency-contacts'
      });
    }
  }
}
```

---

## Multi-Modal Collection

### Mobile App Integration

```typescript
// React Native component for mobile PRO collection
interface MobileSurveyComponentProps {
  surveyId: string;
  instrumentId: string;
  onComplete: () => void;
}

const MobileSurveyComponent: React.FC<MobileSurveyComponentProps> = ({
  surveyId,
  instrumentId,
  onComplete
}) => {
  const [survey, setSurvey] = useState<AdaptiveSurvey | null>(null);
  const [currentQuestion, setCurrentQuestion] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadSurvey();
  }, [surveyId]);

  const loadSurvey = async () => {
    const surveyState = await api.getSurveyState(surveyId);
    setSurvey(surveyState);

    const question = await api.getQuestion(
      instrumentId,
      surveyState.questionFlow[surveyState.currentQuestionIndex]
    );
    setCurrentQuestion(question);
    setLoading(false);
  };

  const handleAnswer = async (answer: any) => {
    setLoading(true);

    const updatedSurvey = await api.answerQuestion(
      surveyId,
      currentQuestion.question_id,
      answer
    );

    setSurvey(updatedSurvey);

    // Check if survey complete
    if (updatedSurvey.percentComplete >= 100) {
      await api.completeSurvey(surveyId);
      onComplete();
    } else {
      // Load next question
      const nextQuestion = await api.getQuestion(
        instrumentId,
        updatedSurvey.questionFlow[updatedSurvey.currentQuestionIndex]
      );
      setCurrentQuestion(nextQuestion);
    }

    setLoading(false);
  };

  if (loading) {
    return <LoadingSpinner />;
  }

  return (
    <View style={styles.container}>
      {/* Progress bar */}
      <ProgressBar progress={survey.percentComplete / 100} />

      {/* Question */}
      <Text style={styles.questionNumber}>
        Question {survey.answeredQuestions + 1} of {survey.totalQuestions}
      </Text>
      <Text style={styles.questionText}>{currentQuestion.question_text}</Text>

      {/* Response options */}
      {currentQuestion.question_type === 'likert_scale' && (
        <LikertScaleInput
          options={currentQuestion.response_options}
          onSelect={handleAnswer}
        />
      )}

      {currentQuestion.question_type === 'single_choice' && (
        <SingleChoiceInput
          options={currentQuestion.response_options}
          onSelect={handleAnswer}
        />
      )}

      {currentQuestion.question_type === 'numeric' && (
        <NumericInput
          min={currentQuestion.response_options.min}
          max={currentQuestion.response_options.max}
          onSubmit={handleAnswer}
        />
      )}
    </View>
  );
};
```

### SMS-Based Collection

```typescript
class SMSSurveyService {
  async sendSMSSurvey(
    participantId: string,
    instrumentId: string
  ): Promise<void> {
    const participant =
      await this.registryService.getParticipant(participantId);

    // Only send if participant opted into SMS
    if (
      !participant.preferences?.smsNotifications ||
      !participant.phoneNumber
    ) {
      return;
    }

    // Start survey
    const survey = await this.adaptiveSurveyEngine.startSurvey(
      participantId,
      instrumentId
    );

    // Get first question
    const firstQuestion = await this.db.findById(
      'pro_questions',
      survey.questionFlow[0]
    );

    // Send SMS
    await this.smsService.send({
      to: participant.phoneNumber,
      message: `Fair Underwriting Health Check:\n\n${firstQuestion.question_text}\n\nReply with a number (${this.formatResponseOptions(firstQuestion.response_options)})`
    });

    // Store SMS survey session
    await this.db.insert('sms_survey_sessions', {
      session_id: uuidv4(),
      survey_id: survey.surveyId,
      participant_id: participantId,
      phone_number: participant.phoneNumber,
      status: 'awaiting_response',
      last_sent_at: new Date()
    });
  }

  async handleSMSResponse(phoneNumber: string, message: string): Promise<void> {
    // Find active SMS survey session
    const session = await this.db.findOne('sms_survey_sessions', {
      phone_number: phoneNumber,
      status: 'awaiting_response'
    });

    if (!session) {
      // No active survey
      return;
    }

    // Parse response
    const answer = this.parseResponse(message);

    if (answer === null) {
      // Invalid response
      await this.smsService.send({
        to: phoneNumber,
        message:
          'Invalid response. Please reply with a number from the options provided.'
      });
      return;
    }

    // Record answer
    const survey = await this.db.findById(
      'pro_survey_responses',
      session.survey_id
    );
    const currentQuestion = survey.questionFlow[survey.currentQuestionIndex];

    await this.adaptiveSurveyEngine.answerQuestion(
      session.survey_id,
      currentQuestion,
      answer
    );

    // Check if survey complete
    const updatedSurvey = await this.adaptiveSurveyEngine.getSurveyState(
      session.survey_id
    );

    if (updatedSurvey.percentComplete >= 100) {
      // Complete survey
      await this.adaptiveSurveyEngine.completeSurvey(session.survey_id);

      await this.smsService.send({
        to: phoneNumber,
        message: 'Survey complete! Thank you for your responses.'
      });

      await this.db.update('sms_survey_sessions', session.session_id, {
        status: 'completed'
      });
    } else {
      // Send next question
      const nextQuestion = await this.db.findById(
        'pro_questions',
        updatedSurvey.questionFlow[updatedSurvey.currentQuestionIndex]
      );

      await this.smsService.send({
        to: phoneNumber,
        message: `${nextQuestion.question_text}\n\nReply with a number (${this.formatResponseOptions(nextQuestion.response_options)})`
      });

      await this.db.update('sms_survey_sessions', session.session_id, {
        last_sent_at: new Date()
      });
    }
  }

  formatResponseOptions(options: any[]): string {
    return options.map((opt) => `${opt.value}=${opt.label}`).join(', ');
  }

  parseResponse(message: string): number | null {
    const trimmed = message.trim();
    const parsed = parseInt(trimmed);

    if (isNaN(parsed)) {
      return null;
    }

    return parsed;
  }
}
```

---

## Longitudinal PRO Visualization

### Symptom Trends Dashboard

```typescript
interface PROTrendAnalysis {
  participantId: string;
  instrumentId: string;

  // Time series
  timeSeries: {
    date: Date;
    score: number;
    interpretation: string;
  }[];

  // Trend analysis
  trend: {
    direction: 'improving' | 'stable' | 'worsening';
    slope: number; // Change per month
    confidence: number; // 0-1
  };

  // Comparisons
  comparison: {
    previousPeriod: { meanScore: number; period: string };
    currentPeriod: { meanScore: number; period: string };
    percentChange: number;
  };

  // Clinical correlation
  clinicalCorrelation: {
    fev1Correlation: number; // Pearson r
    exacerbationCorrelation: number;
    treatmentChanges: {
      date: Date;
      change: string;
      scoreImpact?: number;
    }[];
  };
}

class PROTrendService {
  async analyzeTrends(
    participantId: string,
    instrumentId: string,
    timeframeMonths: number = 12
  ): Promise<PROTrendAnalysis> {
    // 1. Get PRO data
    const responses = await this.db.query(
      `
      SELECT completed_at, score_summary->>'totalScore' AS score,
             score_summary->>'interpretation' AS interpretation
      FROM pro_survey_responses
      WHERE
        participant_id = $1
        AND instrument_id = $2
        AND status = 'completed'
        AND completed_at >= NOW() - INTERVAL '${timeframeMonths} months'
      ORDER BY completed_at
    `,
      [participantId, instrumentId]
    );

    const timeSeries = responses.map((r) => ({
      date: r.completed_at,
      score: parseFloat(r.score),
      interpretation: r.interpretation
    }));

    // 2. Calculate trend (linear regression)
    const trend = this.calculateTrend(timeSeries);

    // 3. Period comparison
    const midpoint = Math.floor(timeSeries.length / 2);
    const firstHalf = timeSeries.slice(0, midpoint);
    const secondHalf = timeSeries.slice(midpoint);

    const comparison = {
      previousPeriod: {
        meanScore: this.mean(firstHalf.map((t) => t.score)),
        period: `${this.formatDate(firstHalf[0].date)} - ${this.formatDate(firstHalf[firstHalf.length - 1].date)}`
      },
      currentPeriod: {
        meanScore: this.mean(secondHalf.map((t) => t.score)),
        period: `${this.formatDate(secondHalf[0].date)} - ${this.formatDate(secondHalf[secondHalf.length - 1].date)}`
      },
      percentChange: 0
    };
    comparison.percentChange =
      ((comparison.currentPeriod.meanScore -
        comparison.previousPeriod.meanScore) /
        comparison.previousPeriod.meanScore) *
      100;

    // 4. Clinical correlation
    const clinicalCorrelation = await this.correlatewithClinicalData(
      participantId,
      timeSeries
    );

    return {
      participantId,
      instrumentId,
      timeSeries,
      trend,
      comparison,
      clinicalCorrelation
    };
  }

  calculateTrend(timeSeries: any[]): any {
    if (timeSeries.length < 2) {
      return { direction: 'stable', slope: 0, confidence: 0 };
    }

    // Convert dates to months since first measurement
    const firstDate = timeSeries[0].date;
    const x = timeSeries.map((t) => this.monthsBetween(firstDate, t.date));
    const y = timeSeries.map((t) => t.score);

    // Linear regression
    const { slope, rSquared } = this.linearRegression(x, y);

    // Determine direction
    let direction: 'improving' | 'stable' | 'worsening';
    if (Math.abs(slope) < 0.5) {
      direction = 'stable';
    } else if (slope < 0) {
      // For CAT/SGRQ: lower score = better
      direction = 'improving';
    } else {
      direction = 'worsening';
    }

    return {
      direction,
      slope: Math.round(slope * 100) / 100,
      confidence: rSquared
    };
  }

  async correlateWithClinicalData(
    participantId: string,
    proTimeSeries: any[]
  ): Promise<any> {
    // Get FEV1 data
    const fev1Data = await this.db.query(
      `
      SELECT test_date, pre_fev1_percent
      FROM registry_spirometry
      WHERE participant_id = $1
      ORDER BY test_date
    `,
      [participantId]
    );

    // Align time series (match PRO dates with closest FEV1)
    const alignedData = this.alignTimeSeries(proTimeSeries, fev1Data, 60); // Within 60 days

    // Calculate correlation
    const fev1Correlation = this.pearsonCorrelation(
      alignedData.map((d) => d.pro_score),
      alignedData.map((d) => d.fev1_percent)
    );

    // Get exacerbation data
    const exacerbations = await this.db.query(
      `
      SELECT event_date
      FROM registry_exacerbations
      WHERE participant_id = $1
      ORDER BY event_date
    `,
      [participantId]
    );

    // Check if PRO scores spike around exacerbations
    const exacerbationCorrelation = this.calculateExacerbationCorrelation(
      proTimeSeries,
      exacerbations
    );

    // Treatment changes
    const treatmentChanges = await this.gettreatmentChanges(participantId);

    return {
      fev1Correlation,
      exacerbationCorrelation,
      treatmentChanges
    };
  }

  calculateExacerbationCorrelation(
    proTimeSeries: any[],
    exacerbations: any[]
  ): number {
    // For each PRO measurement, check if exacerbation within 30 days before
    let correlatedCount = 0;

    for (const pro of proTimeSeries) {
      const hadRecentExacerbation = exacerbations.some((ex) => {
        const daysDiff = this.daysBetween(ex.event_date, pro.date);
        return daysDiff >= 0 && daysDiff <= 30; // Exacerbation 0-30 days before PRO
      });

      // High PRO score (worse symptoms)
      if (hadRecentExacerbation && pro.score > 20) {
        // Threshold for CAT
        correlatedCount++;
      }
    }

    return correlatedCount / proTimeSeries.length;
  }
}
```

### React Component: PRO Trend Visualization

```tsx
interface PROTrendChartProps {
  trendAnalysis: PROTrendAnalysis;
}

const PROTrendChart: React.FC<PROTrendChartProps> = ({ trendAnalysis }) => {
  // Prepare chart data
  const chartData = {
    labels: trendAnalysis.timeSeries.map((t) => formatDate(t.date)),
    datasets: [
      {
        label: 'CAT Score',
        data: trendAnalysis.timeSeries.map((t) => t.score),
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1,
        fill: false
      }
    ]
  };

  // Add trend line
  const trendLine = trendAnalysis.timeSeries.map((t, idx) => ({
    x: t.date,
    y: trendAnalysis.trend.slope * idx + trendAnalysis.timeSeries[0].score
  }));

  chartData.datasets.push({
    label: 'Trend',
    data: trendLine,
    borderColor: 'rgba(255, 99, 132, 0.5)',
    borderDash: [5, 5],
    pointRadius: 0
  });

  return (
    <div className='pro-trend-chart'>
      <h3>CAT Score Over Time</h3>

      {/* Trend indicator */}
      <div className={`trend-indicator trend-${trendAnalysis.trend.direction}`}>
        <span className='trend-icon'>
          {trendAnalysis.trend.direction === 'improving' && '↓'}
          {trendAnalysis.trend.direction === 'stable' && '→'}
          {trendAnalysis.trend.direction === 'worsening' && '↑'}
        </span>
        <span className='trend-text'>
          {trendAnalysis.trend.direction === 'improving' && 'Improving'}
          {trendAnalysis.trend.direction === 'stable' && 'Stable'}
          {trendAnalysis.trend.direction === 'worsening' && 'Worsening'}
        </span>
        <span className='trend-slope'>
          {Math.abs(trendAnalysis.trend.slope).toFixed(1)} points/month
        </span>
      </div>

      {/* Line chart */}
      <Line
        data={chartData}
        options={{
          responsive: true,
          plugins: {
            annotation: {
              annotations: [
                // Threshold lines
                {
                  type: 'line',
                  yMin: 10,
                  yMax: 10,
                  borderColor: 'rgba(0, 255, 0, 0.3)',
                  borderWidth: 2,
                  label: {
                    content: 'Low Impact',
                    enabled: true,
                    position: 'start'
                  }
                },
                {
                  type: 'line',
                  yMin: 20,
                  yMax: 20,
                  borderColor: 'rgba(255, 255, 0, 0.3)',
                  borderWidth: 2,
                  label: {
                    content: 'Medium Impact',
                    enabled: true,
                    position: 'start'
                  }
                },
                {
                  type: 'line',
                  yMin: 30,
                  yMax: 30,
                  borderColor: 'rgba(255, 0, 0, 0.3)',
                  borderWidth: 2,
                  label: {
                    content: 'High Impact',
                    enabled: true,
                    position: 'start'
                  }
                }
              ]
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              max: 40,
              title: { display: true, text: 'CAT Score' }
            }
          }
        }}
      />

      {/* Period comparison */}
      <div className='period-comparison'>
        <div className='period'>
          <strong>Previous:</strong>{' '}
          {trendAnalysis.comparison.previousPeriod.meanScore.toFixed(1)}
          <span className='period-label'>
            ({trendAnalysis.comparison.previousPeriod.period})
          </span>
        </div>
        <div className='period'>
          <strong>Current:</strong>{' '}
          {trendAnalysis.comparison.currentPeriod.meanScore.toFixed(1)}
          <span className='period-label'>
            ({trendAnalysis.comparison.currentPeriod.period})
          </span>
        </div>
        <div
          className={`change ${trendAnalysis.comparison.percentChange < 0 ? 'positive' : 'negative'}`}
        >
          {trendAnalysis.comparison.percentChange > 0 ? '+' : ''}
          {trendAnalysis.comparison.percentChange.toFixed(1)}%
        </div>
      </div>

      {/* Clinical correlation */}
      <div className='clinical-correlation'>
        <h4>Clinical Correlations</h4>
        <div className='correlation-item'>
          <span>FEV₁:</span>
          <span className='correlation-value'>
            r = {trendAnalysis.clinicalCorrelation.fev1Correlation.toFixed(2)}
          </span>
        </div>
        <div className='correlation-item'>
          <span>Exacerbations:</span>
          <span className='correlation-value'>
            {(
              trendAnalysis.clinicalCorrelation.exacerbationCorrelation * 100
            ).toFixed(0)}
            % of scores follow exacerbations
          </span>
        </div>
      </div>
    </div>
  );
};
```

---

## Budget & Success Metrics

### Development Costs (3-4 months)

- **Backend Developer** (survey engine, scoring algorithms): $140K/year × 0.33 = $46,200
- **Frontend Developer** (mobile app, web surveys): $140K/year × 0.33 = $46,200
- **UX Designer** (survey UI/UX, mobile design): $110K/year × 0.25 = $27,500
- **Clinical Psychometrician** (instrument selection, validation): $120K/year × 0.17 = $20,400

**Total**: ~$140,300

### Annual Operations

- **Survey Licensing** (SGRQ, other): $10,000/year
- **SMS Gateway** (text surveys): $5,000/year
- **Mobile App Maintenance**: $15,000/year
- **Data Storage**: $5,000/year

**Total**: ~$35,000/year

### Success Metrics

**Survey Completion**

- Response rate: 80% (invited participants complete survey)
- Completion rate: 95% (started surveys completed)
- Average completion time: <5 minutes for CAT, <12 minutes for SGRQ

**Data Quality**

- Missing data: <5% of items
- Longitudinal compliance: 70% complete surveys at recommended frequency over 2 years
- Multi-modal usage: 40% use mobile app, 30% SMS, 30% web

**Clinical Integration**

- Alert response rate: 60% of high-severity PRO alerts result in provider contact within 7 days
- PRO-clinical correlation: r > 0.5 between PRO scores and clinical outcomes (FEV₁, exacerbations)
- Treatment adjustments: 25% of treatment changes preceded by PRO score worsening

---

**Document Status:** Complete
**Next Document:** MISSING_FEATURES_21B3_WEARABLES_REMOTE_MONITORING.md
