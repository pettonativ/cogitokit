---
name: meeting-facilitation
description: Meeting facilitation techniques. Agenda templates, timeboxing, decision logs, parking lot. Use when running structured meetings or capturing decisions.
---

# Meeting Facilitation

> Principles for running efficient, outcome-driven meetings.

---

## When to Use

- Any structured meeting (planning, review, retro, kickoff)
- Decision-making sessions
- Workshops or brainstorming
- Stakeholder presentations

---

## Core Principle

> **No agenda, no meeting.** Every meeting needs a purpose, a structure, and an expected output.

---

## Meeting Preparation

### Agenda Template

```markdown
## Meeting: [Title]

**Date:** [date] | **Time:** [time] | **Duration:** [X] min

### Purpose

[One sentence: why are we meeting?]

### Attendees

| Name  | Role           |
| ----- | -------------- |
| @name | Facilitator    |
| @name | Decision maker |
| @name | Contributor    |

### Agenda

| #   | Topic   | Owner | Time | Type          |
| --- | ------- | ----- | :--: | ------------- |
| 1   | [topic] | @name | 10m  | 📢 Info       |
| 2   | [topic] | @name | 15m  | 💬 Discussion |
| 3   | [topic] | @name | 10m  | ✅ Decision   |

### Pre-read

- [document or context to review before meeting]
```

---

## Timeboxing

| Meeting Type       | Max Duration | Cadence           |
| ------------------ | :----------: | ----------------- |
| Daily Standup      |    15 min    | Daily             |
| Sprint Planning    |   2 hours    | Per sprint        |
| Sprint Review      |    1 hour    | Per sprint        |
| Retrospective      |    1 hour    | Per sprint        |
| Backlog Refinement |    1 hour    | Weekly            |
| 1:1                |    30 min    | Weekly            |
| Steering           |    1 hour    | Bi-weekly/Monthly |

### Timebox Rules

1. Set a visible timer
2. Warn at 2 minutes remaining
3. If not resolved: parking lot or schedule follow-up
4. Never extend without explicit group consent

---

## Decision Log

Capture decisions during or after meetings:

```markdown
## Decision Log

| #   | Date   | Decision           | Context | Made By | Impact                |
| --- | ------ | ------------------ | ------- | ------- | --------------------- |
| D1  | [date] | [what was decided] | [why]   | @name   | [scope/schedule/tech] |
| D2  | [date] | [what was decided] | [why]   | @name   | [scope/schedule/tech] |
```

### Decision-Making Methods

| Method        | When to Use                   | Speed  |
| ------------- | ----------------------------- | :----: |
| **Consent**   | No major objection = proceed  |  Fast  |
| **Consensus** | Everyone agrees               |  Slow  |
| **HIPPO**     | Highest Paid Person's Opinion |  Fast  |
| **Voting**    | Democratic, equal weight      | Medium |
| **Delegate**  | Expert decides                |  Fast  |

Default: **Consent** (move fast, address objections only).

---

## Parking Lot

For topics that arise but don't fit the current agenda:

```markdown
## 🅿️ Parking Lot

| #   | Topic            | Raised By | Follow-up                 |
| --- | ---------------- | --------- | ------------------------- |
| 1   | [off-topic item] | @name     | Schedule separate meeting |
| 2   | [future concern] | @name     | Add to backlog            |
```

---

## Meeting Notes Template

```markdown
## Meeting Notes — [Title]

**Date:** [date] | **Attendees:** [names]

### Decisions Made

- [decision 1]
- [decision 2]

### Action Items

| #   | Action   | Owner | Due    |
| --- | -------- | ----- | ------ |
| 1   | [action] | @name | [date] |

### Parking Lot

- [item for later]

### Next Meeting

[date/time if recurring]
```

---

## Anti-Patterns

- ❌ Meetings without agendas
- ❌ No time limits (meetings expand to fill time)
- ❌ Decisions made but not recorded
- ❌ Too many attendees (>7 for decision meetings)
- ❌ "Let's take this offline" without scheduling follow-up
- ❌ Recurring meetings that no longer serve a purpose
