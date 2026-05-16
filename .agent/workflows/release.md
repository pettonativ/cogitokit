---
description: Release management command. Plan releases, generate changelogs, run go/no-go checks.
---

# /release - Release Management

$ARGUMENTS

---

## Purpose

Activate the `release-manager` agent for release lifecycle management.

---

## Subcommands

| Command              | Action                                      |
| -------------------- | ------------------------------------------- |
| `/release plan`      | Create release plan with scope and timeline |
| `/release changelog` | Generate changelog from recent commits/PRs  |
| `/release go-nogo`   | Run go/no-go checklist                      |
| `/release rollback`  | Prepare or execute rollback plan            |

---

## Behavior

When `/release` is triggered:

1. **Identify subcommand** from `$ARGUMENTS`
2. **Activate `release-manager` agent**
3. **Load `release-planning` and `change-management` skills**
4. **Follow release-planning protocols**

### Default (no subcommand)

```
What release activity do you need?
1. 📋 Plan a release
2. 📝 Generate changelog
3. ✅ Go/No-Go check
4. ↩️ Rollback plan
```

---

## Examples

```
/release plan v2.0
/release changelog
/release go-nogo
/release rollback
```
