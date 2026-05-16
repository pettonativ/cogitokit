---
description: Project scheduling and timeline management. Gantt charts, critical path, milestone tracking.
---

# /schedule - Project Scheduling

$ARGUMENTS

---

## Purpose

Activate the `project-planner` agent with `project-scheduling` and `cost-management` skills for timeline and budget planning.

---

## Subcommands

| Command                   | Action                                   |
| ------------------------- | ---------------------------------------- |
| `/schedule timeline`      | Create project timeline with Gantt chart |
| `/schedule critical-path` | Identify and analyze critical path       |
| `/schedule milestone`     | Define or review milestones              |
| `/schedule compress`      | Analyze schedule compression options     |

---

## Behavior

When `/schedule` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `project-planner` agent** with scheduling skills
3. **Gather project data** — tasks, durations, dependencies
4. **Generate timeline** and/or analysis
5. **Output Mermaid Gantt chart** and critical path

### Default (no subcommand)

```
What scheduling activity do you need?
1. 📅 Create project timeline (Gantt)
2. 🔗 Analyze critical path
3. 🚩 Define/review milestones
4. ⏱️ Schedule compression analysis
```

---

## Output

- Mermaid Gantt chart
- Critical path table
- Milestone tracker
- Schedule risk assessment

---

## Examples

```
/schedule timeline "API migration project"
/schedule critical-path
/schedule milestone
/schedule compress
```
