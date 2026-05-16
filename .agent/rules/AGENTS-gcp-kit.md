---
trigger: model_decision
description: "Skills registry for the gcp-kit. Load when user request involves Google Cloud services like Cloud Run, GKE, BigQuery, Pub/Sub, or Cloud Functions."
---

# AGENTS.md — GCP Kit

> Extension kit skills for Google Cloud Platform. No dedicated agents — provides skills used by `devops-engineer` or other agents.

## Skills Available

When `gcp-kit` is present in the workspace, these skills are auto-discovered:
- Cloud Run deployment patterns
- GKE (Google Kubernetes Engine) configuration
- BigQuery data warehouse patterns
- Pub/Sub messaging patterns
- Cloud Functions serverless patterns

## Routing Protocol

1. Detect GCP keywords → Check if `gcp-*` skills exist in session context
2. If found → Load and apply alongside `devops-engineer` or relevant agent
3. If NOT found → General cloud knowledge + inform user the kit is missing
