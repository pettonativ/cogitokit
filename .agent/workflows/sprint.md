---
description: Sprint management command. Plan, run, and close sprints. Standup facilitation and sprint health checks.
---

# /sprint - Sprint Management

$ARGUMENTS

---

## Purpose

Activate the `scrum-master` agent for sprint lifecycle management.

---

## Subcommands

| Command           | Action                         | Skills                                   |
| ----------------- | ------------------------------ | ---------------------------------------- |
| `/sprint plan`    | Start sprint planning ceremony | sprint-management, estimation-techniques |
| `/sprint standup` | Run daily standup              | meeting-facilitation, sprint-management  |
| `/sprint review`  | Sprint review / demo prep      | sprint-management, metrics-analytics     |
| `/sprint close`   | Close sprint, record metrics   | sprint-management, metrics-analytics     |
| `/sprint health`  | Mid-sprint health check        | sprint-management, metrics-analytics     |

---

## Behavior

When `/sprint` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `scrum-master` agent**
3. **Load relevant skills** based on subcommand
4. **Follow sprint-management skill** protocols

### Default (no subcommand)

If no subcommand is provided, ask:

```
What sprint activity do you need?
1. 📋 Plan a new sprint
2. 🔄 Run a standup
3. 📊 Sprint health check
4. 🎯 Sprint review/demo
5. ✅ Close the sprint
```

---

## Sprint Planning Flow

1. Review prioritized backlog
2. Set sprint goal (one sentence)
3. Calculate team capacity
4. Select stories (respect velocity)
5. Verify DoR for each story
6. Output sprint plan document

## Sprint Close Flow

1. Verify DoD for completed items
2. Move incomplete items back to backlog
3. Calculate velocity
4. Generate burndown chart (Mermaid)
5. Prepare sprint review summary
6. Schedule retrospective

---

## Output

| Deliverable    | Format                                      |
| -------------- | ------------------------------------------- |
| Sprint Plan    | Markdown with goal, stories, capacity       |
| Standup Notes  | Markdown with completed/in-progress/blocked |
| Sprint Summary | Markdown with metrics, burndown, decisions  |
| Health Report  | RAG status with indicators                  |

---

## Examples

```
/sprint plan
/sprint standup
/sprint review
/sprint close
/sprint health
```
