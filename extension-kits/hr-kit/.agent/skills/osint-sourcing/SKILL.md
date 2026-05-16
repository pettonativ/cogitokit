---
name: OSINT Sourcing & X-Ray Search
description: Teaches the agent how to build and execute boolean web searches to find candidates for any technology, role, or company.
---

# OSINT Sourcing Skill

This skill provides the methodology for finding candidate profiles programmatically using ONLY the `search_web` tool.

## 1. The X-Ray Search Pattern

To find public profiles (like LinkedIn) via a standard web search, use the `site:` operator combined with specific keywords.

### General Formula:

`site:linkedin.com/in/ "{Technology}" ("{Title1}" OR "{Title2}") "{Location}"`

**Example (Splunk in Milan):**
`site:linkedin.com/in/ "Splunk" ("Engineer" OR "Consultant" OR "Architect" OR "Analyst") "Milano" OR "Milan"`

### Remote and National Coverage Formula:

To find people open to remote work or across a broader national level (e.g. "Italia remoto"), combine location keywords with remote identifiers.
`site:linkedin.com/in/ "{Technology}" ("{Title1}" OR "{Title2}") ("Italia" OR "Italy") ("Remoto" OR "Remote" OR "Smart Working")`

**Example (Splunk in Italy Remote):**
`site:linkedin.com/in/ "Splunk" ("Engineer" OR "Consultant" OR "Cloud" OR "Architect") ("Italia" OR "Italy") ("Remoto" OR "Remote" OR "Smart Working")`

### Consulting Firm Formula:

To find people working for specific consulting firms who know a specific technology.
`site:linkedin.com/in/ "{Technology}" ("Accenture" OR "Reply" OR "Deloitte" OR "Capgemini" OR "Engineering" OR "NTT" OR "KPMG") "{Location}"`

### Direct Sourcing Strategy:

Exclude people who describe themselves broadly or as recruiters.
`site:linkedin.com/in/ "{Technology}" -intitle:"recruiter" -intitle:"HR" -intitle:"TA"`

## 2. Execution Strategy (Agentic / Local)

1. **Analyze Requirements**: Identify Technology, Location, and Titles.
2. **Construct Queries**: Build 2-3 boolean queries (e.g., `site:it.linkedin.com/in/ "Splunk" "Milano"`).
3. **Execute via Serper**:
   - Use the `run_command` tool to execute `.agent/scripts/serper_search.py`.
   - Command: `python3 .agent/scripts/serper_search.py "YOUR_BOOLEAN_QUERY" --num 10`
4. **Extract & Parse**:
   - Read the JSON results.
   - **Crucial**: Extract Name (from Title if needed), Role, and LinkedIn URL.
5. **Deduplicate & Report**:
   - Merge results from multiple queries.
   - Generate a Markdown report: `candidates_{Tech}_{Location}_report.md`.
   - **Template**:
     `| Name | Current Company | City | Role / Headline | LinkedIn URL | Match Evidence |`
