---
name: retrospective
description: Sprint retrospective facilitation. Start-Stop-Continue, 4Ls, Sailboat frameworks, improvement backlog tracking. Use after sprints to drive continuous improvement.
---

# Retrospective

> Principles for running effective retrospectives that drive real improvement.

---

## When to Use

- End of every sprint (mandatory)
- After a major release or incident
- When team dynamics need attention
- Quarterly for bigger-picture reflection

---

## Core Principles

1. **Prime Directive:** "Regardless of what we discover, we understand that everyone did the best job they could, given what they knew and the situation."
2. **Psychological safety** is non-negotiable
3. **Action items > venting** — Every retro produces ≥1 improvement action
4. **Track improvements** — Don't repeat the same discussion

---

## Retrospective Frameworks

### 1. Start-Stop-Continue

Best for: **Regular sprints, simple format**

```markdown
## Retro — Sprint [N]

### 🟢 Start (things we should begin doing)

- [item]

### 🔴 Stop (things that aren't working)

- [item]

### 🔵 Continue (things going well, keep doing)

- [item]

### 🎯 Action Items

| #   | Action   | Owner | Due        |
| --- | -------- | ----- | ---------- |
| 1   | [action] | @name | Sprint N+1 |
```

### 2. 4Ls (Liked, Learned, Lacked, Longed For)

Best for: **Learning-focused teams, new teams**

```markdown
## Retro — Sprint [N]

### 😊 Liked (what went well)

- [item]

### 📚 Learned (new insights)

- [item]

### 😤 Lacked (what was missing)

- [item]

### 🌟 Longed For (what we wish we had)

- [item]

### 🎯 Action Items

| #   | Action   | Owner | Due        |
| --- | -------- | ----- | ---------- |
| 1   | [action] | @name | Sprint N+1 |
```

### 3. Sailboat

Best for: **Visual teams, bigger retrospectives**

```markdown
## Retro — Sprint [N] (Sailboat)

### 🏝️ Island (our goal / where we're heading)

- [goal]

### 💨 Wind (what's pushing us forward)

- [tailwind]

### ⚓ Anchor (what's slowing us down)

- [drag]

### 🪨 Rocks (risks ahead)

- [risk]

### 🎯 Action Items

| #   | Action   | Owner | Due        |
| --- | -------- | ----- | ---------- |
| 1   | [action] | @name | Sprint N+1 |
```

### 4. Mad-Sad-Glad

Best for: **Emotional check-in, team health**

```markdown
## Retro — Sprint [N]

### 😡 Mad (frustrating)

- [item]

### 😢 Sad (disappointing)

- [item]

### 😊 Glad (celebrations)

- [item]

### 🎯 Action Items

| #   | Action   | Owner | Due        |
| --- | -------- | ----- | ---------- |
| 1   | [action] | @name | Sprint N+1 |
```

---

## Facilitation Protocol

### Structure (60 min max)

| Phase             |  Time  | Activity                                      |
| ----------------- | :----: | --------------------------------------------- |
| Set the stage     | 5 min  | Check-in, prime directive, choose framework   |
| Gather data       | 15 min | Individual reflection, silent writing         |
| Generate insights | 15 min | Group discussion, dot voting on themes        |
| Decide actions    | 15 min | Select top 2-3 items, assign owners/deadlines |
| Close             | 5 min  | Appreciation round, confirm actions           |

### Facilitation Tips

1. **Rotate facilitator** — Not always the Scrum Master
2. **Silent writing first** — Prevents anchoring bias
3. **Dot voting** — Democratize priority (3 votes per person)
4. **Max 3 action items** — More = none get done
5. **Review previous actions first** — Accountability matters

---

## Improvement Backlog

Track retro actions across sprints:

```markdown
## Improvement Backlog

| Sprint | Action                   | Owner   |     Status     | Impact           |
| :----: | ------------------------ | ------- | :------------: | ---------------- |
|   S5   | Add PR template          | @dev1   |    ✅ Done     | Review time -20% |
|   S5   | Daily deploy to staging  | @devops | 🔵 In Progress | —                |
|   S4   | Reduce standup to 10 min | @SM     |    ✅ Done     | 5 min saved/day  |
|   S3   | Spike on caching         | @dev2   |  ❌ Abandoned  | —                |
```

---

## Anti-Patterns

- ❌ Skipping retros ("we're too busy")
- ❌ No action items (just venting)
- ❌ Blame-oriented discussion
- ❌ Same facilitator every time
- ❌ Never reviewing previous action items
- ❌ Actions without owners or deadlines
- ❌ More than 3 actions per retro (focus!)
