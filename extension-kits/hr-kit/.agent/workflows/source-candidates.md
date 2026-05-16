---
description: Run an automated OSINT search for IT candidates using X-Ray boolean logic.
---

# /source-candidates Command

Trigger the `hr-recruiter` agent to perform a programmatic candidate search without opening a browser.

**Usage:** `/source-candidates [technology] [location] [options]`

## Workflow Steps:

1. **Initialize**: Announce `🤖 **Applying knowledge of @[hr-recruiter]...**`
2. **Clarify Requirements**: Ensure `technology` and `location` are provided.
3. **Construct Queries**: Load `osint-sourcing` and build 2-3 boolean queries.
4. **Execute (Local)**: Run `python3 .agent/scripts/serper_search.py "QUERY" --num 10`.
5. **Autonomous Parsing**: Analyze raw outputs and deduplicate.
6. **Generate Report**: Write results to `candidates_{technology}_{location}_report.md`.
7. **Notify**: Inform the user about the local report availability.
