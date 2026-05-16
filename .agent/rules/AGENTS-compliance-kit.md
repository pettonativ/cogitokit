---
trigger: model_decision
description: "Agent registry for the compliance-kit. Load when user request involves compliance, GDPR, AI Act, NIS2, DORA, ISO 27001, regulatory requirements, PII, or data protection."
---

# AGENTS.md — Compliance Kit

> Extension kit agents for regulatory compliance auditing.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `compliance-auditor` | Regulatory compliance, GDPR, AI Act | compliance-frameworks, data-protection, regulatory-analysis | "compliance", "GDPR", "AI Act", "NIS2", "DORA", "ISO 27001", "PII", "data protection" |

## Routing Extensions

When these keywords are detected, route to `compliance-auditor`:
- compliance, GDPR, AI Act, NIS2, DORA, ISO 27001, regulatory, PII
- SBOM, data protection, conformità, privacy policy, DPA
