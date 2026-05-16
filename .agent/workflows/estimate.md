---
description: Estimate work items using story points, T-shirt sizing, or three-point estimation. Forecasting delivery timelines.
---

# /estimate - Work Item Estimation

$ARGUMENTS

---

## Purpose

Activate the `product-owner` agent with `estimation-techniques` skill to size work items or forecast delivery.

---

## Subcommands

| Command                | Action                 | Technique       |
| ---------------------- | ---------------------- | --------------- |
| `/estimate points`     | Story point estimation | Fibonacci scale |
| `/estimate tshirt`     | T-shirt sizing         | XS to XXL       |
| `/estimate threepoint` | Risk-aware estimation  | PERT formula    |
| `/estimate forecast`   | Delivery forecasting   | Velocity-based  |

---

## Behavior

When `/estimate` is triggered:

1. **Identify technique** from `$ARGUMENTS`
2. **Activate `product-owner` agent** with `estimation-techniques` skill
3. **Gather items to estimate** — Ask user for backlog items or descriptions
4. **Apply technique** following skill protocols
5. **Output estimation table**

### Default (no subcommand)

If no subcommand or item list is provided, ask:

```
What do you need to estimate?
1. 🎯 Size specific work items (story points)
2. 👕 Quick relative sizing (T-shirt)
3. 📊 Risk-aware estimate (three-point / PERT)
4. 🔮 Forecast delivery date (velocity-based)

Please describe the work items or provide a list.
```

---

## Output Formats

### Story Points

```markdown
| #   | Item   | Complexity     | Unknowns        | Dependencies | Points |
| --- | ------ | -------------- | --------------- | ------------ | :----: |
| 1   | [item] | [low/med/high] | [few/some/many] | [none/some]  |   5    |
```

### Three-Point

```markdown
| #   | Item   | Optimistic | Most Likely | Pessimistic | Expected | StdDev |
| --- | ------ | :--------: | :---------: | :---------: | :------: | :----: |
| 1   | [item] |     3d     |     5d      |     12d     |   5.8d   |  1.5d  |
```

### Forecast

```markdown
| Metric           | Value          |
| ---------------- | -------------- |
| Remaining Points | [X]            |
| Avg Velocity     | [Y] pts/sprint |
| Best Case        | [N] sprints    |
| Expected         | [N] sprints    |
| Worst Case       | [N] sprints    |
```

---

## Examples

```
/estimate points "user authentication feature"
/estimate tshirt backlog items for Q2
/estimate threepoint API migration
/estimate forecast remaining epic work
```
