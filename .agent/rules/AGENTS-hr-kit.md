---
trigger: model_decision
description: "Skills registry for the hr-kit. Load when user request involves sourcing, recruiting, candidate search, OSINT profiling, or talent acquisition."
---

# AGENTS.md — HR Kit

> Extension kit skills for human resources and recruiting. No dedicated agents — provides skills for sourcing and candidate research.

## Skills Available

When `hr-kit` is present in the workspace, these skills are auto-discovered:
- OSINT candidate sourcing (X-Ray search, Boolean queries)
- LinkedIn profile analysis
- Candidate screening frameworks
- Job description generation

## Routing Protocol

1. Detect HR/recruiting keywords → Check if `hr-*` skills exist in session context
2. If found → Load and apply
3. If NOT found → General knowledge + inform user the kit is missing
