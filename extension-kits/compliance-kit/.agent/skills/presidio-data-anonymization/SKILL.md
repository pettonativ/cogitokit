---
name: presidio-data-anonymization
description: PII and PHI data sanitization using Microsoft Presidio. Implementation patterns for anonymizing sensitive data in prompts, logs, and datasets to ensure GDPR compliance (Art. 25, 32).
version: 1.0.0
---

# Presidio Data Anonymization

> Implement structured PII/PHI masking in Python applications using Microsoft Presidio, ensuring GDPR compliance for logs, analytics, and LLM prompts.

## 1. Core Principles

- **Privacy by Design:** Sanitize data _before_ it leaves the application boundary (e.g., to logs, external LLMs, or MLflow).
- **Graceful Degradation:** If anonymization fails, fail secure (block the request) or redact heavily.
- **Context Preservation:** Replace PII with entity types (e.g., `[EMAIL]` instead of `***`) to maintain context for LLMs.

## 2. Presidio Architecture Overview

Microsoft Presidio consists of two main components:

1.  **Presidio Analyzer:** Uses NLP (spaCy/Stanza) and regular expressions to detect PII entities.
2.  **Presidio Anonymizer:** Replaces detected entities according to configured rules (e.g., replace, mask, hash, encrypt).

## 3. Basic Implementation Pattern

```python
from presidio_analyzer import AnalyzerEngine
from presidio_anonymizer import AnonymizerEngine

# Initialize engines (do this once, as initialization is heavy)
analyzer = AnalyzerEngine()
anonymizer = AnonymizerEngine()

def sanitize_text(text: str, language: str = "it") -> str:
    """Detect and anonymize PII in the given text."""
    if not text:
        return text

    # 1. Analyze
    results = analyzer.analyze(text=text, entities=[], language=language)

    # 2. Anonymize
    anonymized_result = anonymizer.anonymize(text=text, analyzer_results=results)

    return anonymized_result.text

# Example Usage
prompt = "Sono Mario Rossi e il mio numero è 333-1234567"
safe_prompt = sanitize_text(prompt)
print(safe_prompt)
# Output: "Sono <PERSON> e il mio numero è <PHONE_NUMBER>"
```

## 4. Custom Recognizers (e.g., PNR Codes)

Presidio allows adding custom regular expressions for domain-specific data, such as flight PNRs (Passenger Name Records).

```python
from presidio_analyzer import PatternRecognizer, Pattern

# Define a regex pattern for a 6-character alphanumeric PNR
pnr_pattern = Pattern(
    name="pnr_pattern",
    regex=r"\b[A-Z0-9]{6}\b",
    score=0.5
)

pnr_recognizer = PatternRecognizer(
    supported_entity="PNR_CODE",
    patterns=[pnr_pattern],
    context=["prenotazione", "volo", "pnr", "biglietto"]
)

# Add custom recognizer to the analyzer
analyzer.registry.add_recognizer(pnr_recognizer)
```

## 5. Integration Points

### Logging Middleware

Ensure all user inputs are sanitized before being written to standard output or log files.

### LLM Prompt Interception

For applications using LangChain or similar frameworks, intercept the prompt _before_ it is sent to the LLM agent.

```python
# Pseudo-code for LangChain integration
def anonymize_prompt(prompt_text):
    return sanitize_text(prompt_text)

# Apply this before calling the LLM chain or before tracking in MLflow
safe_prompt = anonymize_prompt(user_input)
mlflow.log_param("user_query_safe", safe_prompt)
response = llm.invoke(safe_prompt)
```

## 6. Deployment Considerations

- **Dependencies:** Presidio requires `presidio-analyzer`, `presidio-anonymizer`, and an NLP model (e.g., `python -m spacy download it_core_news_lg`).
- **Performance:** Analyzing text adds latency. For real-time applications (like chatbots), test latency impact and consider using smaller spaCy models (`_sm` instead of `_lg`) if accuracy is acceptable.
- **Docker:** Ensure the spaCy model download step is included in the `Dockerfile`.

```dockerfile
# Example Dockerfile snippet
RUN pip install presidio-analyzer presidio-anonymizer
RUN python -m spacy download it_core_news_lg
```

## 7. When to Use This Skill

- When auditing code for GDPR compliance and finding plaintext PII logging.
- When building GenAI applications that process user data before sending it to external models (e.g., OpenAI).
- When asked to "anonymize data", "mask PII", or "implement privacy by design".
