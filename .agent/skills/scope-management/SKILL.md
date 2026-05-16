---
name: scope-management
description: Scope baseline, WBS, scope creep monitoring, and scope change control. Use when defining project boundaries, tracking scope changes, or validating deliverables.
---

# Scope Management

> Principles for defining, validating, and controlling project scope.

---

## When to Use

- Project initiation (scope definition)
- Requirements review
- Mid-project scope change requests
- Scope creep monitoring
- Deliverable validation

---

## Scope Statement Template

```markdown
## Project Scope Statement — [Project Name]

### In Scope

- [deliverable 1]
- [deliverable 2]
- [deliverable 3]

### Out of Scope

- [explicitly excluded item 1]
- [explicitly excluded item 2]

### Assumptions

- [assumption 1]
- [assumption 2]

### Constraints

- [constraint 1 — e.g., budget, timeline, technology]
- [constraint 2]

### Acceptance Criteria

- [criterion 1]
- [criterion 2]
```

> **Rule:** "Out of Scope" is as important as "In Scope". Be explicit.

---

## Scope Baseline

The approved version of scope = **Scope Statement + WBS + WBS Dictionary**.

Once baselined:

- Changes require **change control process** (`change-management` skill)
- All deviations are tracked and justified
- Re-baseline only with sponsor approval

---

## Scope Creep Detection

### Warning Signs

| Signal                                        | Severity | Action                     |
| --------------------------------------------- | :------: | -------------------------- |
| "While we're at it..." requests               |    ⚠️    | Route to change management |
| Requirements growing without formal approval  |    🔴    | Freeze and review          |
| Gold plating (team adds unrequested features) |    🟡    | Review DoD, enforce scope  |
| Stakeholder "just one more thing"             |    ⚠️    | Log as CR, assess impact   |

### Scope Change Tracking

```markdown
## Scope Change Log

| #   | Change            | Source      |     Impact      |   Status    |  CR#   |
| --- | ----------------- | ----------- | :-------------: | :---------: | :----: |
| 1   | Add OAuth login   | Stakeholder | +5 pts, +3 days | ✅ Approved | CR-001 |
| 2   | Dashboard export  | Dev team    | +3 pts, +1 day  | ❌ Rejected | CR-002 |
| 3   | Mobile responsive | PM          | +8 pts, +5 days | ⏸️ Deferred | CR-003 |
```

---

## Scope Validation

### Process

1. **Define acceptance criteria** during planning (in scope statement)
2. **Review deliverables** against criteria at each milestone
3. **Formal acceptance** by Product Owner or sponsor
4. **Document** accepted deliverables

### Validation Checklist

```markdown
| Deliverable   | Acceptance Criteria | Validated | Accepted By |  Date  |
| ------------- | ------------------- | :-------: | :---------: | :----: |
| [deliverable] | [criteria]          |   ✅/❌   |    @name    | [date] |
```

---

## Integration with Other Skills

| Skill                   | Integration Point                         |
| ----------------------- | ----------------------------------------- |
| `change-management`     | Scope changes routed through CR process   |
| `estimation-techniques` | Estimate impact of scope changes          |
| `risk-management`       | Scope risks (creep, unclear requirements) |
| `pm-reporting`          | Scope status in reports                   |

---

## Anti-Patterns

- ❌ No "Out of Scope" section (infinite boundary)
- ❌ Verbal scope agreements (not documented)
- ❌ No scope baseline (can't measure creep)
- ❌ Accepting scope changes without impact analysis
- ❌ Gold plating (building features nobody asked for)
