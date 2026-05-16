---
description: Run a daily standup. Quick team sync with completed/in-progress/blocked format.
---

# /standup - Daily Standup

$ARGUMENTS

---

## Purpose

Activate the `scrum-master` agent with `meeting-facilitation` and `sprint-management` skills for a quick daily sync.

---

## Behavior

When `/standup` is triggered:

1. **Activate `scrum-master` agent**
2. **Ask for updates** per team member or work item
3. **Structure output** in completed/in-progress/blocked format
4. **Flag sprint health** based on progress
5. **Capture blockers** with owners and actions

---

## Output

```markdown
## Daily Standup — [Date]

### 🟢 Completed

- [item] (@person)

### 🔵 In Progress

- [item] (@person) — ETA: [date]

### 🔴 Blocked

- [item] (@person) — Blocker: [description]
    - Action: [who will resolve, by when]

### Sprint Health

- Days remaining: X/Y
- Points completed: X/Z (X%)
- On track: ✅/⚠️/❌
```

---

## Rules

- **Max 15 minutes** — Timebox strictly
- **Focus on blockers** — Not a status report
- **Standing meeting** — Quick by design

---

## Examples

```
/standup
/standup "Alice: done auth, working on dashboard. Bob: blocked on API."
```
