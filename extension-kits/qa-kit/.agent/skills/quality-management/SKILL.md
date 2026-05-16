---
name: quality-management
description: Quality gates, acceptance criteria validation, defect tracking, and Definition of Done. Use when defining quality standards, reviewing deliverables, or tracking defect metrics.
---

# Quality Management

> Principles for ensuring project deliverables meet defined quality standards.

---

## When to Use

- Defining quality standards at project start
- Sprint DoD review
- Quality gate assessments
- Defect analysis and trending
- Acceptance criteria validation

---

## Quality Gates

Checkpoints where deliverables must meet criteria before proceeding:

```markdown
## Quality Gates — [Project Name]

| Gate | Phase        | Criteria                                           | Approver    |
| ---- | ------------ | -------------------------------------------------- | ----------- |
| G1   | Requirements | Requirements reviewed, acceptance criteria defined | PO          |
| G2   | Design       | Architecture reviewed, security assessment done    | Tech Lead   |
| G3   | Development  | Code reviewed, unit tests pass, coverage ≥ X%      | Dev Lead    |
| G4   | Testing      | Integration tests pass, no P0/P1 defects open      | QA Lead     |
| G5   | Pre-Release  | UAT passed, go/no-go checklist complete            | PM + PO     |
| G6   | Release      | Monitoring verified, rollback tested               | Release Mgr |
```

### Gate Review Template

```markdown
## Gate Review — [Gate Name]

| Criterion     | Status  | Evidence            |
| ------------- | :-----: | ------------------- |
| [criterion 1] | ✅ Pass | [link/reference]    |
| [criterion 2] | ❌ Fail | [issue description] |
| [criterion 3] | ✅ Pass | [link/reference]    |

**Decision:** ✅ Proceed / ❌ Rework / ⏸️ Conditional proceed
**Conditions (if any):** [conditions to be met by date]
```

---

## Definition of Done (DoD) — Project Level

Beyond the sprint DoD, define project-level quality:

```markdown
## Project DoD

### Code Quality

- [ ] Peer reviewed (≥1 reviewer)
- [ ] No linting errors or warnings
- [ ] No known security vulnerabilities (scan passed)
- [ ] No TODO/FIXME for shipped features

### Testing

- [ ] Unit test coverage ≥ [X]%
- [ ] Integration tests passing
- [ ] E2E tests for critical paths
- [ ] Performance benchmarks met

### Documentation

- [ ] API documentation up to date
- [ ] User-facing documentation updated
- [ ] Architecture Decision Records (if applicable)

### Deployment

- [ ] Deployed to staging successfully
- [ ] Smoke tests passing in staging
- [ ] Monitoring and alerting configured
```

---

## Defect Tracking

### Defect Severity

|   Severity    | Definition                              |     SLA     |
| :-----------: | --------------------------------------- | :---------: |
| P0 — Critical | System down, data loss, security breach |    4 hrs    |
|   P1 — High   | Major feature broken, no workaround     |    1 day    |
|  P2 — Medium  | Feature broken, workaround exists       |   3 days    |
|   P3 — Low    | Minor issue, cosmetic                   | Next sprint |

### Defect Metrics

| Metric                    | Formula                                      | Target |
| ------------------------- | -------------------------------------------- | :----: |
| Defect Density            | Defects / KLOC                               |  < 5   |
| Defect Removal Efficiency | Defects found before release / Total defects | > 85%  |
| Open/Close Rate           | New defects / Resolved defects per sprint    | < 1.0  |
| Mean Time to Fix          | Avg time from reported to resolved           |   —    |

### Defect Dashboard Template

```markdown
## Defect Dashboard — Sprint [N]

| Severity | Open | Fixed | Deferred | Total |
| :------: | :--: | :---: | :------: | :---: |
|    P0    |  0   |   0   |    0     |   0   |
|    P1    |  1   |   2   |    0     |   3   |
|    P2    |  3   |   5   |    1     |   9   |
|    P3    |  5   |   3   |    2     |  10   |

**Trend:** Open defects 📉 (improving)
**DRE:** 88% ✅
```

---

## Acceptance Criteria Validation

### Format (Given-When-Then)

```
Given [precondition]
When [action]
Then [expected result]
```

### Validation Checklist

```markdown
| Story  | AC# | Description                                                       | Result |
| ------ | :-: | ----------------------------------------------------------------- | :----: |
| US-001 | AC1 | Given logged in, When click profile, Then see settings            |   ✅   |
| US-001 | AC2 | Given not logged in, When access /profile, Then redirect to login |   ✅   |
| US-002 | AC1 | Given cart items, When checkout, Then order created               |   ❌   |
```

---

## Anti-Patterns

- ❌ No quality gates (hope-driven development)
- ❌ DoD that nobody enforces
- ❌ Not tracking defect trends
- ❌ "We'll fix quality later" → tech debt spiral
- ❌ Testing only at the end
- ❌ No acceptance criteria on stories
