# AI Kit Architecture

> Add-on kit for AI/ML development patterns and MLOps evaluation

---

## 📋 Overview

AI Kit is an **add-on kit** in the cogitokit multi-kit system. It provides specialized skills for building LLM-powered applications and evaluating ML models.

### Kit Composition

- **1 Specialist Agent** — `mlops-engineer`
- **2 Skills** — LangChain patterns + MLOps evaluation

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/
│   └── mlops-engineer.md      # Specialist agent
└── skills/
    ├── langchain-patterns/    # LangChain/LLM agent development
    └── mlops-evaluation/      # MLflow, RAGAS, eval pipelines
```

---

## 🤖 Agent

| Agent            | Focus                                                       | Skills                               |
| ---------------- | ----------------------------------------------------------- | ------------------------------------ |
| `mlops-engineer` | AI/ML system design, evaluation pipelines, model deployment | langchain-patterns, mlops-evaluation |

---

## 🧩 Skills (2)

| Skill                | Description                                                                                             |
| -------------------- | ------------------------------------------------------------------------------------------------------- |
| `langchain-patterns` | LangChain agent architectures, chain composition, RAG, tool design, memory patterns, prompt engineering |
| `mlops-evaluation`   | MLflow integration, RAGAS scorers, async eval design, testset management, LLM-as-judge. Cloud-agnostic  |

---

## 🔗 Integration with cogitokit

### Auto-Discovery

Antigravity automatically discovers skills from this kit when it's open in the workspace.

### Complementary Skills (in cogitokit)

| cogitokit Skill    | Relationship                                         |
| ----------------- | ---------------------------------------------------- |
| `python-patterns` | Python is the primary language for AI/ML development |
| `api-patterns`    | AI services often expose REST/GraphQL APIs           |
| `database-design` | Vector stores, embeddings storage                    |

### Complementary Skills (in compliance-kit)

| compliance-kit Skill          | Relationship                                     |
| ----------------------------- | ------------------------------------------------ |
| `ai-act-compliance`           | EU AI Act regulatory requirements for AI systems |
| `mlflow-model-cards`          | Model documentation and transparency             |
| `presidio-data-anonymization` | PII sanitization in AI pipelines                 |

---

## 📊 Statistics

| Metric        | Value |
| ------------- | ----- |
| **Agent**     | 1     |
| **Skills**    | 2     |
| **Workflows** | 0     |
