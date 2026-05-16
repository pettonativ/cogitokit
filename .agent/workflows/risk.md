---
description: Risk assessment and management. Create risk registers, run risk analysis, track mitigations.
---

# /risk - Risk Management

$ARGUMENTS

---

## Purpose

Activate the `project-planner` agent with `risk-management` skill for identifying, assessing, and tracking project risks.

---

## Subcommands

| Command          | Action                                  |
| ---------------- | --------------------------------------- |
| `/risk identify` | Brainstorm and list risks               |
| `/risk assess`   | Score risks (probability × impact)      |
| `/risk register` | Create or update risk register          |
| `/risk review`   | Review existing risks and update status |

---

## Behavior

When `/risk` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `project-planner` agent** with `risk-management` skill
3. **Gather context** — Project type, phase, known concerns
4. **Apply risk-management protocols**
5. **Output risk register** with scored risks and mitigation plans

### Default (no subcommand)

```
What risk activity do you need?
1. 🔍 Identify risks for a project/feature
2. 📊 Assess and score existing risks
3. 📋 Create/update risk register
4. 🔄 Review and update risk status
```

---

## Output

Risk register with probability/impact matrix, mitigation strategies, and owners. Includes Mermaid heat map visualization.

---

## Examples

```
/risk identify "new API migration"
/risk assess
/risk register
/risk review
```
