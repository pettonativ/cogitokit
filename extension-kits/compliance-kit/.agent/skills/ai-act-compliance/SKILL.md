---
name: ai-act-compliance
description: EU AI Act (Regulation 2024/1689) compliance validation. Risk classification, transparency, bias testing, explainability, data provenance, model documentation, HITL mechanisms. Use when analyzing AI/ML systems for EU AI Act compliance.
version: 1.0.0
---

# AI Act Compliance — EU Regulation 2024/1689

> Validate AI/ML systems against the EU AI Act requirements. Full enforcement for High-Risk systems from August 2026.

**Prerequisite:** Load `compliance-core` for report template and information gathering protocol.

---

## 1. Regulatory Context

### Timeline

| Date     | Milestone                                   |
| -------- | ------------------------------------------- |
| Aug 2024 | AI Act enters into force                    |
| Feb 2025 | Prohibited AI practices apply               |
| Aug 2025 | GPAI model obligations apply                |
| Aug 2026 | **High-Risk AI system obligations apply**   |
| Aug 2027 | Full enforcement for Annex I listed systems |

### Risk Classification

```
UNACCEPTABLE (Prohibited — Art. 5)
├── Social scoring by governments
├── Real-time biometric identification in public spaces (exceptions apply)
├── Emotion recognition in workplace/education
└── Manipulation of vulnerable groups

HIGH RISK (Annex III — Art. 6)
├── Biometric identification/categorization
├── Critical infrastructure management
├── Education & vocational training (access, assessment)
├── Employment & workers management (recruitment, performance)
├── Essential services access (credit scoring, insurance)
├── Law enforcement
├── Migration, asylum, border control
└── Justice administration

LIMITED RISK (Transparency obligations — Art. 50)
├── Chatbots (must disclose AI nature)
├── Deepfakes (must label)
└── AI-generated content (must label)

MINIMAL RISK (No obligations)
└── Spam filters, games, etc.
```

---

## 2. Compliance Checks

### Check 1: Risk Classification Assessment

**Question:** Does the system fall under High-Risk (Annex III)?

| Signal                    | Look For                                    | Risk Level   |
| ------------------------- | ------------------------------------------- | ------------ |
| Biometric data processing | Face recognition, fingerprint, voice        | High Risk    |
| Healthcare decisions      | Diagnosis, triage, treatment recommendation | High Risk    |
| Credit/insurance scoring  | Financial decision models                   | High Risk    |
| HR/recruitment            | CV screening, candidate ranking             | High Risk    |
| Critical infrastructure   | Energy, water, transport management         | High Risk    |
| Education                 | Automated grading, admission decisions      | High Risk    |
| Chatbot / GenAI interface | User-facing conversational AI               | Limited Risk |
| Internal analytics        | Non-decision-making analytics               | Minimal Risk |

**Where to look:** `README.md`, architecture docs, domain-specific keywords in code

---

### Check 2: Transparency Declaration (Art. 50)

**Question:** Do chatbots/GenAI systems declare themselves as AI?

| Evidence                    | Location                                             |
| --------------------------- | ---------------------------------------------------- |
| AI disclosure in UI         | Frontend components, chat interfaces                 |
| API response headers/fields | API responses containing `is_ai: true` or disclaimer |
| Terms of service            | Documentation, legal pages                           |

**🔴 Critical if:** Chatbot or GenAI system has NO disclosure to users.

---

### Check 3: Technical Documentation (Art. 11)

**Question:** Is there a model card or equivalent technical documentation?

| Evidence                             | Location                                                               |
| ------------------------------------ | ---------------------------------------------------------------------- |
| `model_card.md` or `model_card.yaml` | Repository root, `/docs/`, `/models/`                                  |
| Model documentation in README        | `README.md` model section                                              |
| MLflow model registry with metadata  | MLflow configuration                                                   |
| Equivalent structured documentation  | Any documentation describing model purpose, limitations, training data |

**Required contents (for HR systems):**

- Model purpose and intended use
- Training data description and sources
- Performance metrics and limitations
- Known biases and mitigation measures
- Deployment constraints

**🔴 Critical if:** HR system with NO technical documentation.
**🟡 Warning if:** Documentation exists but is incomplete.

---

### Check 4: Bias Testing & Fairness (Art. 10, Art. 15)

**Question:** Are there automated bias/fairness tests?

| Evidence                                                              | Location                                                    |
| --------------------------------------------------------------------- | ----------------------------------------------------------- |
| **Libraries:** `fairlearn`, `aif360`, `alibi-detect`, `responsibleai` | `requirements.txt`, `pyproject.toml`, `Pipfile`, `setup.py` |
| **Test scripts:** bias test files                                     | `tests/`, evaluation scripts                                |
| **CI integration:** bias tests in pipeline                            | CI/CD configuration                                         |
| **Metrics:** fairness metrics logged                                  | MLflow, evaluation reports                                  |

**🔴 Critical if:** HR AI system with NO bias testing library or test scripts.
**🟡 Warning if:** Library present but not integrated in CI/CD.

---

### Check 5: Explainability (Art. 13)

**Question:** Are there explainability/interpretability mechanisms?

| Evidence                                                 | Location                     |
| -------------------------------------------------------- | ---------------------------- |
| **Libraries:** `shap`, `lime`, `captum`, `eli5`, `alibi` | Dependency files             |
| **Scripts:** explanation generation                      | Evaluation/inference scripts |
| **Output:** feature importance, attention visualization  | Model outputs, reports       |

**🟡 Warning if:** No explainability library or mechanism detected.
**🟢 Note:** Explainability level should be proportionate to risk level.

---

### Check 6: Data Provenance & Quality (Art. 10)

**Question:** Is training data versioned, documented, and traceable?

| Evidence                                        | Location                             |
| ----------------------------------------------- | ------------------------------------ |
| **DVC:** `.dvc/` directory, `.dvc` files        | Repository root                      |
| **MLflow:** data versioning, dataset tracking   | MLflow configuration                 |
| **Data documentation:** data dictionary, schema | `/docs/data/`, data catalog          |
| **Data quality checks:** validation scripts     | Pipeline scripts, Great Expectations |

**🔴 Critical if:** HR AI system with NO data provenance tracking.
**🟡 Warning if:** Data is versioned but not documented (no data dictionary).

---

### Check 7: Model Versioning & Registry (Art. 12)

**Question:** Are models versioned and registered with full lineage?

| Evidence                                  | Location                      |
| ----------------------------------------- | ----------------------------- |
| **MLflow:** model registry configured     | `mlflow` config, tracking URI |
| **DVC:** model files tracked              | `.dvc` files for models       |
| **Weights & Biases:** experiment tracking | `wandb` configuration         |
| **Custom registry:** model catalog        | Documentation, scripts        |

**🟡 Warning if:** No model versioning/registry detected.

---

### Check 8: Human-in-the-Loop (HITL) Mechanisms (Art. 14)

**Question:** Is there a human oversight mechanism or manual fallback?

| Evidence                                | Location                                |
| --------------------------------------- | --------------------------------------- |
| HITL workflow documented                | Architecture docs, workflow definitions |
| Confidence threshold with manual review | Inference code, configuration           |
| Manual override capability              | Admin interfaces, API endpoints         |
| Escalation procedures                   | Runbooks, documentation                 |

**🔴 Critical if:** HR decision system with NO human oversight documented.
**🟡 Warning if:** HITL exists but only in documentation, not enforced in code.

---

### Check 9: Risk Management System (Art. 9)

**Question:** Is there a documented risk management process for the AI system?

| Evidence                    | Location                   |
| --------------------------- | -------------------------- |
| AI risk assessment document | `/docs/`, risk register    |
| Risk mitigation measures    | Documentation, test suites |
| Residual risk acceptance    | Documentation              |

**🟡 Warning if:** No AI-specific risk assessment documented.

---

### Check 10: Post-Market Monitoring (Art. 72)

**Question:** Is there monitoring in production for model performance and drift?

| Evidence                    | Location                                        |
| --------------------------- | ----------------------------------------------- |
| Model monitoring configured | Observability config, dashboards                |
| Drift detection             | Monitoring scripts, `evidently`, `alibi-detect` |
| Performance tracking        | Metrics collection, alerting                    |
| Feedback loop               | User feedback mechanisms                        |

**🟡 Warning if:** No post-deployment monitoring detected for HR AI system.

---

## 3. Remediation Toolkit

### Quick Wins

| Gap                | Tool / Approach                                                                                    |
| ------------------ | -------------------------------------------------------------------------------------------------- |
| Missing model card | Create `model_card.md` with [Model Card Toolkit](https://github.com/tensorflow/model-card-toolkit) |
| No bias testing    | Add `fairlearn` + integrate `MetricFrame` in test suite                                            |
| No explainability  | Add `shap` + generate SHAP summary plots in evaluation                                             |
| No data versioning | Initialize DVC (`dvc init`) or use MLflow dataset tracking                                         |
| No HITL            | Implement confidence threshold + manual review queue                                               |
| No monitoring      | Add `evidently` or `alibi-detect` for drift detection                                              |

### Example: Bias Test Integration (CI/CD)

```yaml
# .github/workflows/bias-test.yml
name: Bias Testing
on: [push, pull_request]
jobs:
  bias-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"
      - run: pip install fairlearn scikit-learn
      - run: python tests/test_bias.py
```

---

## 4. Anti-Patterns

| ❌ Don't                                      | ✅ Do                              |
| --------------------------------------------- | ---------------------------------- |
| Classify every AI system as High Risk         | Assess based on Annex III criteria |
| Require full explainability for minimal risk  | Proportionate to risk level        |
| Ignore GPAI obligations                       | Check if using foundation models   |
| Treat AI Act as only a documentation exercise | It requires technical controls too |

---

> **Remember:** The AI Act is risk-based. The higher the risk, the more controls required. Minimal risk systems have almost no obligations. Focus your audit on the risk classification first.
