---
name: pm-reporting
description: Project management reporting templates. Weekly status, steering deck, RAG status, milestone tracker. Use when creating progress reports or stakeholder communications.
---

# PM Reporting

> Principles and templates for clear, actionable project status communication.

---

## When to Use

- Weekly status updates
- Steering committee / sponsor meetings
- Milestone tracking
- Escalation reports
- Executive summaries

---

## Core Principle

> **Reports should drive decisions, not just inform.** Every report needs: status, risks, and asks.

---

## RAG Status Convention

|    Color     | Meaning     | Criteria                                 |
| :----------: | ----------- | ---------------------------------------- |
| 🟢 **Green** | On track    | Schedule, scope, budget within ±10%      |
| 🟡 **Amber** | At risk     | Deviation 10-25%, mitigation plan exists |
|  🔴 **Red**  | Off track   | Deviation >25% or critical blocker       |
| 🔵 **Blue**  | Complete    | Delivered and accepted                   |
| ⚪ **White** | Not started | Future phase                             |

---

## Report Templates

### 1. Weekly Status Report

```markdown
# Weekly Status — [Project Name]

**Period:** [Date] — [Date]
**Overall Status:** 🟢/🟡/🔴

## Summary

[1-2 sentences: what happened this week and what's the outlook]

## Key Metrics

| Metric          |    Value     | Trend |
| --------------- | :----------: | :---: |
| Sprint Progress | X/Y pts (Z%) | 📈/📉 |
| Open Blockers   |      N       | 📈/📉 |
| Risks (High+)   |      N       | 📈/📉 |

## Completed This Week

- ✅ [deliverable 1]
- ✅ [deliverable 2]

## In Progress

- 🔵 [item] — ETA: [date]

## Blockers & Risks

| #   | Description | Impact | Owner | Action   | ETA    |
| --- | ----------- | ------ | ----- | -------- | ------ |
| 1   | [blocker]   | 🔴     | @name | [action] | [date] |

## Next Week Plan

- [ ] [planned item 1]
- [ ] [planned item 2]

## Decisions Needed

- ❓ [decision needed from stakeholder]
```

### 2. Steering Committee Summary

```markdown
# Steering Committee — [Project Name]

**Date:** [Date]
**Overall Status:** 🟢/🟡/🔴

## Executive Summary

[3-4 sentences max: status, key achievement, main risk, ask]

## Dimensions

| Dimension | Status | Note                          |
| --------- | :----: | ----------------------------- |
| Schedule  |   🟢   | On track for [milestone]      |
| Scope     |   🟡   | [change request] under review |
| Budget    |   🟢   | [X]% consumed, [Y]% complete  |
| Quality   |   🟢   | [defect rate / test coverage] |
| Risk      |   🟡   | [top risk summary]            |

## Milestone Tracker

| Milestone | Planned | Forecast | Status |
| --------- | ------- | -------- | :----: |
| [M1]      | [date]  | [date]   |   🟢   |
| [M2]      | [date]  | [date]   |   🟡   |
| [M3]      | [date]  | —        |   ⚪   |

## Top 3 Risks

| Risk     | Impact | Mitigation |
| -------- | ------ | ---------- |
| [risk 1] | 🔴     | [action]   |

## Decisions Required

1. [decision needed]
```

### 3. Milestone Tracker

```markdown
## Milestone Tracker — [Project Name]

| #   | Milestone | Planned | Actual/Forecast | Status | Dependencies |
| --- | --------- | ------- | --------------- | :----: | ------------ |
| M1  | [name]    | [date]  | [date]          |   🟢   | —            |
| M2  | [name]    | [date]  | [date]          |   🟡   | M1           |
| M3  | [name]    | [date]  | —               |   ⚪   | M2           |

### Timeline (Mermaid)

[gantt chart here]
```

---

## Report Cadence

| Report           | Audience          | Frequency         |  Detail Level   |
| ---------------- | ----------------- | ----------------- | :-------------: |
| Standup Notes    | Team              | Daily             |      High       |
| Sprint Summary   | Team + SM         | Per Sprint        |      High       |
| Weekly Status    | PM + Stakeholders | Weekly            |     Medium      |
| Steering Deck    | Sponsors + Execs  | Bi-weekly/Monthly | Low (executive) |
| Milestone Update | All               | On milestone      |     Medium      |

---

## Writing Guidelines

1. **Lead with status** — Green/Amber/Red immediately visible
2. **Quantify progress** — "3 of 5 features done" not "good progress"
3. **Highlight blockers first** — Bad news travels up, not sideways
4. **Include asks** — What do you need from the reader?
5. **Keep it scannable** — Tables > paragraphs, bullets > prose
6. **Consistent format** — Same template every time builds trust

---

## Anti-Patterns

- ❌ Status report without RAG summary
- ❌ All-green reports (be honest)
- ❌ Information dump without narrative
- ❌ Reports without action items or asks
- ❌ Different format every week
- ❌ Reporting metrics without context or trend
