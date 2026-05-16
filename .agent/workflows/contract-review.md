---
description: Consistency check between technical proposal and signed contract. Structured extraction, delta analysis, risk assessment, and PM report. Generalized for any client and document type.
---

# /contract-review — Proposal vs Contract Consistency Check

$ARGUMENTS

---

## Purpose

Activate the `project-planner` agent with the `contract-review` skill (+ `risk-management`, `scope-management`, `change-management`) to conduct a structured consistency check between pre-contractual documents and the signed contract.

---

## Subcommands

| Command                    | Action                                                                    |
| -------------------------- | ------------------------------------------------------------------------- |
| `/contract-review full`    | Full process (6 phases) — from document classification to PM report       |
| `/contract-review intake`  | Only document classification and intake                                   |
| `/contract-review extract` | Only structured data extraction from documents                            |
| `/contract-review mapping` | Only cross-document correspondence matrix                                 |
| `/contract-review delta`   | Only analysis of identified deltas                                        |
| `/contract-review risk`    | Only risk assessment on deltas (P×I scoring)                              |
| `/contract-review report`  | Only final PM report generation                                           |

---

## Behavior

When `/contract-review` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `project-planner` agent** with skills: `contract-review`, `risk-management`, `scope-management`, `change-management`
3. **Gather documents** — Ask user for document paths if not provided
4. **Execute the 6-phase methodology** defined in `contract-review` skill SKILL.md:
    - Phase 1: Document Intake & Classification
    - Phase 2: Data Extraction (6 mandatory + optional dimensions)
    - Phase 3: Cross-Reference Mapping
    - Phase 4: Delta Analysis
    - Phase 5: Risk Assessment + Congruity Scorecard
    - Phase 6: PM Verification Report generation
5. **Output** — Produce structured report as artifact in the conversation

### Default (no subcommand)

```
Consistency Check — What would you like to do?
1. 📋 Full process (all 6 steps)
2. 📥 Classify and register documents
3. 📊 Extract structured data
4. 🔗 Create correspondence matrix
5. 🔍 Analyze deltas
6. ⚠️ Evaluate risks (Risk Assessment)
7. 📄 Generate the PM report
```

---

## Required Input

| Input            |  Required  | Description                                          |
| ---------------- | :--------: | ---------------------------------------------------- |
| Documents (path) |     ✅     | At least 2 documents: proposal/attachment + contract |
| Project name     |     ✅     | Project code or name (e.g. PS-049-26)                |
| Client name      | ⚠️ Advised | For report heading                                   |

---

## Output

- **Document Intake Log** — Classified list of analyzed documents
- **Extracted Data** — Structured tables for each document (6 dimensions)
- **Correspondence Matrix** — Cross-document mapping with alignment status
- **Delta Analysis** — List of deltas with type and impact
- **Risk Register** — Risks from deltas with P×I scoring and mitigations
- **Congruity Scorecard** — Overall score out of 5.0
- **PM Verification Report** — Complete final report

All outputs are generated as a single markdown artifact.

---

## Examples

```
/contract-review full
  → Documents: HO_GC_35-26.docx, AT_GC_35-26.pdf, 4500171498.pdf
  → Project: PS-049-26
  → Client: TIM

/contract-review delta
  → [resumes an already started check, analyzes only the deltas]

/contract-review risk
  → [generates risk register for already identified deltas]
```

---

## Integration

This workflow leverages multiple skills:

```
/contract-review
  └── project-planner (agent)
      ├── contract-review (skill) ← PRIMARY
      ├── risk-management (skill)
      ├── scope-management (skill)
      └── change-management (skill)
```
