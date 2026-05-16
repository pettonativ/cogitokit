---
trigger: model_decision
description: "Skills registry for the azure-kit. Load when user request involves Azure services like App Service, AKS, Container Apps, Azure Functions, or Azure DevOps."
---

# AGENTS.md — Azure Kit

> Extension kit skills for Microsoft Azure. No dedicated agents — provides skills used by `devops-engineer` or other agents.

## Skills Available

When `azure-kit` is present in the workspace, these skills are auto-discovered:
- Azure App Service deployment
- AKS (Azure Kubernetes Service) patterns
- Azure Container Apps configuration
- Azure Functions serverless patterns
- Azure DevOps pipelines

## Routing Protocol

1. Detect Azure keywords → Check if `azure-*` skills exist in session context
2. If found → Load and apply alongside `devops-engineer` or relevant agent
3. If NOT found → General cloud knowledge + inform user the kit is missing
