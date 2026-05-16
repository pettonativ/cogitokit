---
description: Run a sprint retrospective using structured frameworks. Facilitates team reflection and improvement.
---

# /retro - Sprint Retrospective

$ARGUMENTS

---

## Purpose

Activate the `scrum-master` agent with `retrospective` and `meeting-facilitation` skills to run a structured retrospective.

---

## Subcommands

| Command               | Framework                       |
| --------------------- | ------------------------------- |
| `/retro`              | Default (Start-Stop-Continue)   |
| `/retro 4ls`          | Liked-Learned-Lacked-Longed For |
| `/retro sailboat`     | Sailboat (visual)               |
| `/retro mad-sad-glad` | Emotional check-in              |

---

## Behavior

When `/retro` is triggered:

1. **Select framework** from `$ARGUMENTS` (default: Start-Stop-Continue)
2. **Activate `scrum-master` agent**
3. **Review previous retro actions** — Check improvement backlog
4. **Facilitate framework** — Guide through phases
5. **Capture action items** — Max 3, with owners and deadlines
6. **Update improvement backlog**

---

## Output

```markdown
## Retro — Sprint [N]

### Previous Actions Review

| Action            |  Status  |
| ----------------- | :------: |
| [previous action] | ✅/🔵/❌ |

### [Framework Sections]

[Based on selected framework]

### 🎯 Action Items

| #   | Action   | Owner | Due        |
| --- | -------- | ----- | ---------- |
| 1   | [action] | @name | Sprint N+1 |
```

---

## Examples

```
/retro
/retro 4ls
/retro sailboat
/retro mad-sad-glad
```
