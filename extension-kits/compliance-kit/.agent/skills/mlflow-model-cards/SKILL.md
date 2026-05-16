---
name: mlflow-model-cards
description: MLflow Model Cards generation and integration. Automated creation of model_card.md based on HuggingFace and EU AI Act standards. Integrates with MLflow Model Registry to attach documentation as artifacts.
version: 1.0.0
---

# MLflow Model Cards

> Generate standardized Model Cards for AI/ML systems to comply with the EU AI Act (Art. 11) and MLOps best practices.

## 1. Core Principles

- **Transparency:** Clearly document model purpose, limitations, and intended use.
- **Traceability:** Link the model card to specific MLflow experiments and run IDs.
- **Compliance:** Ensure the content meets regulatory requirements for technical documentation.
- **Automation:** Integrate model card generation into the CI/CD or training pipelines.

## 2. Model Card Structure (EU AI Act Compliant)

A standard `model_card.md` should include the following sections:

### 1. Model Details

- **Name:** [Model Name]
- **Version:** [Model Version]
- **Type:** [e.g., LLM, Classifier, Regression]
- **Architect/Developer:** [Team or Individual]
- **Date:** [Release Date]
- **References:** [Links to papers, repos, or internal design docs]

### 2. Intended Use

- **Primary Use Cases:** What the model is designed to do.
- **Out-of-Scope Use Cases:** Explicitly state what the model should NOT be used for.

### 3. Factors (Context)

- **Relevant Factors:** Demographics, environmental conditions, or data sources.
- **Evaluation Factors:** Subpopulations or conditions tested during evaluation.

### 4. Metrics

- **Performance Metrics:** Accuracy, Precision, Recall, F1, latency, token throughput.
- **Fairness Metrics:** Bias testing results (e.g., disparate impact, demographic parity).

### 5. Evaluation Data

- **Datasets:** Description of the datasets used for evaluation.
- **Motivation:** Why these datasets were chosen.
- **Preprocessing:** Any sanitization or masking applied before evaluation.

### 6. Training Data

- **Datasets:** Description of the training datasets.
- **Provenance:** Sources and collection methodology.

### 7. Quantitative Analyses

- Detailed performance breakdowns across different conditions or subpopulations.

### 8. Ethical Considerations

- **Data Risk:** Risk of PII exposure.
- **Human-in-the-Loop (HITL):** Describe any manual oversight mechanisms.
- **Mitigation:** Steps taken to mitigate identified risks.

### 9. Caveats and Recommendations

- Known limitations and recommendations for consumers of the model.

## 3. Integration with MLflow

To automate the inclusion of the model card in MLflow:

1.  **Generate `model_card.md`** locally (manually or via a template engine like Jinja2).
2.  **Log the artifact** during the MLflow run:

```python
import mlflow

with mlflow.start_run() as run:
    # ... training code ...

    # Log the model card as an artifact
    mlflow.log_artifact("model_card.md", artifact_path="model_documentation")

    # Register the model
    mlflow.sklearn.log_model(model, "my_model", registered_model_name="MyModel")
```

3.  **Update Model Registry Description (Optional):**
    You can also update the model version description in the registry with the contents of the model card.

```python
from mlflow.tracking import MlflowClient

client = MlflowClient()
with open("model_card.md", "r") as f:
    model_card_content = f.read()

client.update_model_version(
    name="MyModel",
    version=1,
    description=model_card_content
)
```

## 4. When to Use This Skill

- When auditing an ML project for AI Act compliance and finding missing documentation.
- When setting up a new MLflow registry and establishing MLOps standards.
- When asked to "document the model", "create a model card", or "make this AI Act compliant".
