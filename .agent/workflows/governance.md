---
description: Project governance and stage gate management. Project charter, gate reviews, Go/No-Go decisions.
---

# /governance - Project Governance

$ARGUMENTS

---

## Purpose

Activate the `orchestrator` agent with `governance-pmo` and `scope-management` skills for governance decisions and gate reviews.

---

## Subcommands

| Command                 | Action                       |
| ----------------------- | ---------------------------- |
| `/governance charter`   | Create project charter       |
| `/governance gate`      | Run stage gate review        |
| `/governance go-nogo`   | Go/No-Go decision assessment |
| `/governance portfolio` | Portfolio-level project view |
| `/governance close`     | Project closure checklist    |

---

## Behavior

When `/governance` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `orchestrator` agent** with governance skills
3. **Gather project context**
4. **Apply governance-pmo protocols**
5. **Output structured governance artifact**

### Default (no subcommand)

```
What governance activity do you need?
1. 📜 Create project charter
2. 🚪 Stage gate review
3. ✅ Go/No-Go assessment
4. 📊 Portfolio dashboard
5. 🏁 Project closure
```

---

## Output

- Project charter document
- Gate review report with decisions
- Go/No-Go scorecard
- Portfolio dashboard
- Closure checklist

---

## Examples

```
/governance charter "New CRM Integration"
/governance gate 3
/governance go-nogo release
/governance portfolio
/governance close
```
