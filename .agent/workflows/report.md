---
description: Generate project status reports and dashboards. Weekly status, steering deck, milestone tracker.
---

# /report - PM Reporting

$ARGUMENTS

---

## Purpose

Activate the `project-planner` agent with `pm-reporting` and `metrics-analytics` skills to generate structured project reports.

---

## Subcommands

| Command             | Output                     |
| ------------------- | -------------------------- |
| `/report status`    | Weekly status report       |
| `/report steering`  | Steering committee summary |
| `/report milestone` | Milestone tracker          |
| `/report sprint`    | Sprint metrics summary     |

---

## Behavior

When `/report` is triggered:

1. **Identify report type** from `$ARGUMENTS`
2. **Activate `project-planner` agent** with reporting skills
3. **Gather project data** — Ask user for current status, metrics, blockers
4. **Generate report** using `pm-reporting` templates
5. **Include metrics** via `metrics-analytics` (charts in Mermaid)

### Default (no subcommand)

```
What report do you need?
1. 📋 Weekly Status Report
2. 🏛️ Steering Committee Summary
3. 🚩 Milestone Tracker
4. 📊 Sprint Metrics Summary
```

---

## Output

All reports follow `pm-reporting` skill templates with:

- RAG status indicators
- Quantified progress
- Blockers and risks highlighted
- Action items / decisions needed
- Mermaid charts where applicable

---

## Examples

```
/report status
/report steering
/report milestone
/report sprint
```
