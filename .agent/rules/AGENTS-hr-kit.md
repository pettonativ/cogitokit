---
trigger: model_decision
description: "Skills & Agents registry for the hr-kit. Load when user request involves sourcing, recruiting, candidate search, OSINT profiling, or talent acquisition."
---

# AGENTS.md — HR Kit

> Extension kit for human resources and recruiting, including OSINT candidate sourcing skills and the hr-recruiter agent.

## Agents Available

When `hr-kit` is present in the workspace, the following agent is auto-discovered:

| Agent | Focus | Key Skills | Trigger Keywords |
|-------|-------|------------|------------------|
| `hr-recruiter` | Technical IT Sourcing & OSINT Talent Acquisition | osint-sourcing, boolean-mastery | "sourcing", "recruiting", "candidate", "x-ray", "boolean search", "talent" |

## Skills Available

These skills are also auto-discovered:
- OSINT candidate sourcing (X-Ray search, Boolean query building)
- LinkedIn profile parsing and screening frameworks
- Automated recruiting script execution via Serper Search

## Routing Protocol

1. Detect recruiting/sourcing keywords → Route to `hr-recruiter` agent.
2. If only skills are needed → Load `osint-sourcing` and other HR skills into current session context.
3. If NOT found → Inform user that `hr-kit` is missing.
