---
name: estimation-techniques
description: Estimation methods for effort, complexity, and duration. Story points, T-shirt sizing, three-point estimation, velocity forecasting. Use when sizing work items or forecasting delivery.
---

# Estimation Techniques

> Principles for accurate, consistent effort estimation across teams.

---

## When to Use

- Sprint planning or backlog refinement
- Roadmap forecasting
- Stakeholder asks "when will it be done?"
- Comparing approaches by effort
- Capacity planning for upcoming work

---

## Core Principle

> **Estimate complexity, not duration.** Duration varies by person; complexity is team-relative but consistent.

---

## Technique 1: Story Points (Fibonacci)

### Scale

| Points | Meaning                              | Example                            |
| :----: | ------------------------------------ | ---------------------------------- |
|   1    | Trivial, well-understood             | Fix a typo, update config          |
|   2    | Simple, minimal unknowns             | Add a field to existing form       |
|   3    | Straightforward with some complexity | New API endpoint (CRUD)            |
|   5    | Moderate complexity, some unknowns   | Feature with 2-3 components        |
|   8    | Complex, multiple integration points | Cross-service feature              |
|   13   | Very complex, significant unknowns   | New subsystem or major refactor    |
|   21   | Epic-level, needs breakdown          | Should be split into smaller items |

### Rules

1. **Compare, don't calculate** — "Is this bigger or smaller than X?"
2. **Team calibration** — Reference stories establish the scale
3. **Fibonacci gaps** — Force commitment; no "6" hedging
4. **21+ = split** — If it's that big, break it down first

### Planning Poker Protocol

1. Product Owner presents the story
2. Team asks clarifying questions
3. Everyone reveals estimate simultaneously
4. If divergence > 2 levels: highest and lowest explain reasoning
5. Re-vote until convergence (max 3 rounds)
6. If no convergence: take the higher estimate + flag risk

---

## Technique 2: T-Shirt Sizing

Best for: **roadmap-level estimation** or **initial backlog grooming**

| Size | Relative Effort   | Typical Point Range |
| :--: | ----------------- | :-----------------: |
|  XS  | Trivial           |          1          |
|  S   | Small             |         2-3         |
|  M   | Medium            |          5          |
|  L   | Large             |          8          |
|  XL  | Very large        |         13          |
| XXL  | Epic — must split |         21+         |

### When to Prefer Over Story Points

- Early-stage backlog (not refined enough for points)
- Non-technical stakeholder discussions
- Quick relative sizing of large backlogs
- When precision isn't needed yet

---

## Technique 3: Three-Point Estimation

Best for: **risk-aware scheduling** and **commitment ranges**

### Formula (PERT)

```
Expected = (Optimistic + 4 × Most Likely + Pessimistic) / 6
Standard Deviation = (Pessimistic - Optimistic) / 6
```

### Example

| Scenario                               | Days |
| -------------------------------------- | :--: |
| Optimistic (everything goes perfectly) |  3   |
| Most Likely (normal conditions)        |  5   |
| Pessimistic (significant issues)       |  12  |

```
Expected = (3 + 4×5 + 12) / 6 = 5.8 days
StdDev = (12 - 3) / 6 = 1.5 days
```

**Confidence ranges:**

- 68% confidence: 4.3 — 7.3 days
- 95% confidence: 2.8 — 8.8 days

### When to Use

- External commitments or contract deadlines
- High-uncertainty work (new tech, integration)
- Risk reporting to stakeholders

---

## Velocity-Based Forecasting

### Calculating Velocity

```
Velocity = Sum of story points COMPLETED in a sprint
```

**Use rolling average of last 3-5 sprints** — not a single sprint.

### Forecasting Delivery

```
Sprints Remaining = Total Remaining Points / Average Velocity
```

### Forecasting Output Template

```markdown
## Delivery Forecast — [Feature/Epic]

| Metric                    | Value               |
| ------------------------- | ------------------- |
| Remaining Points          | 45                  |
| Avg Velocity (3 sprints)  | 18                  |
| Best Case (high velocity) | 2 sprints           |
| Expected                  | 2.5 sprints         |
| Worst Case (low velocity) | 3.5 sprints         |
| Confidence Range          | Sprint 5 — Sprint 7 |
```

---

## Estimation Facilitation Tips

1. **Anchor first** — Start with a well-known reference story
2. **Separate estimation from commitment** — Estimates are ranges, not promises
3. **Include everything** — Testing, review, deployment, documentation
4. **Re-estimate when learning** — It's OK to revise as you learn more
5. **Track accuracy** — Compare estimates vs actuals to improve

---

## Integration with Other Skills

| Skill                | Integration Point                         |
| -------------------- | ----------------------------------------- |
| `sprint-management`  | Velocity feeds sprint capacity            |
| `risk-management`    | Three-point estimation for risky items    |
| `metrics-analytics`  | Velocity trends, estimation accuracy      |
| `pm-reporting`       | Forecasting in status reports             |
| `project-scheduling` | Estimates feed timeline and critical path |

---

## Anti-Patterns

- ❌ Estimating in hours (creates false precision)
- ❌ One person estimates for the team
- ❌ Treating estimates as commitments
- ❌ Never re-calibrating the scale
- ❌ Padding estimates "just in case" instead of using three-point
- ❌ Ignoring historical velocity when forecasting
