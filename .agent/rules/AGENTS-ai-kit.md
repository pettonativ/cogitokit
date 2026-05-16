---
trigger: model_decision
description: "Agent registry for the ai-kit. Load when user request involves MLflow, LLMs, LangChain, RAG, model evaluation, inference, AI agents, or MLOps pipelines."
---

# AGENTS.md — AI Kit

> Extension kit agents for AI/ML operations.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `mlops-engineer` | MLOps, LLM integration, RAG | mlflow-patterns, langchain-integration, model-evaluation | "mlflow", "model", "langchain", "llm", "rag", "inference", "evaluation", "fine-tuning" |

## Routing Extensions

When these keywords are detected, route to `mlops-engineer`:
- mlflow, model, langchain, llm, rag, inference, evaluation, fine-tuning
- embeddings, vector store, prompt engineering, AI agent, scorer
