---
name: release-planning
description: Release lifecycle management. Release trains, SemVer, feature flags, go/no-go criteria, rollout strategies. Use when planning releases or defining rollout approaches.
---

# Release Planning

> Principles for planning, executing, and validating software releases.

---

## When to Use

- Planning a major or minor release
- Defining go/no-go criteria
- Choosing rollout strategy
- Feature freeze / code freeze decisions
- Changelog and versioning

---

## Semantic Versioning (SemVer)

```
MAJOR.MINOR.PATCH

MAJOR → Breaking changes (API incompatible)
MINOR → New features (backward compatible)
PATCH → Bug fixes only
```

### Pre-release Tags

```
1.2.0-alpha.1  → Internal testing
1.2.0-beta.1   → External beta
1.2.0-rc.1     → Release candidate
1.2.0          → General availability
```

---

## Release Planning Process

### Inputs

1. Completed sprint increments
2. Backlog items tagged for release
3. Quality metrics (test coverage, defect rate)
4. Stakeholder commitments / external dates

### Release Plan Template

```markdown
## Release Plan — v[X.Y.Z]

| Field           | Value                           |
| --------------- | ------------------------------- |
| Version         | [X.Y.Z]                         |
| Target Date     | [date]                          |
| Release Type    | Major / Minor / Patch           |
| Release Manager | @name                           |
| Features        | [count] features, [count] fixes |

### Features Included

| #   | Feature   |  Status  | Risk |
| --- | --------- | :------: | :--: |
| 1   | [feature] | ✅ Ready |  🟢  |
| 2   | [feature] | 🔵 In QA |  🟡  |

### Go/No-Go Checklist

- [ ] All features code-complete
- [ ] Test coverage ≥ [X]%
- [ ] No P0/P1 open defects
- [ ] Performance benchmarks met
- [ ] Documentation updated
- [ ] Rollback plan verified
- [ ] Stakeholder sign-off

### Rollback Plan

[Steps to revert if critical issues found post-release]
```

---

## Rollout Strategies

| Strategy          |   Risk    |  Speed   | Best For                        |
| ----------------- | :-------: | :------: | ------------------------------- |
| **Big Bang**      |  🔴 High  |   Fast   | Small apps, low traffic         |
| **Canary**        |  🟢 Low   |   Slow   | High-traffic, critical services |
| **Blue-Green**    | 🟡 Medium |  Medium  | Zero-downtime requirement       |
| **Rolling**       | 🟡 Medium |  Medium  | Containerized deployments       |
| **Feature Flags** |  🟢 Low   | Flexible | Gradual feature rollout         |

### Feature Flag Decision

Use feature flags when:

- Feature needs A/B testing
- Gradual rollout to % of users
- Kill switch needed post-deploy
- Feature spans multiple releases

---

## Changelog Generation

### Format (Keep a Changelog)

```markdown
## [X.Y.Z] — YYYY-MM-DD

### Added

- [new feature description]

### Changed

- [modification description]

### Fixed

- [bug fix description]

### Removed

- [removed feature description]

### Security

- [security fix description]
```

---

## Release Cadence Options

| Cadence                 | When                  | Trade-off                     |
| ----------------------- | --------------------- | ----------------------------- |
| **Train** (fixed dates) | Every 2-4 weeks       | Predictable, may ship less    |
| **Feature-based**       | When feature complete | Flexible, less predictable    |
| **Continuous**          | Every merge to main   | Fast, needs strong automation |

---

## Anti-Patterns

- ❌ No go/no-go checklist (shipping hope)
- ❌ No rollback plan
- ❌ "We'll fix it in the next release"
- ❌ Manual changelog (should derive from commits/PRs)
- ❌ Big bang rollout for critical systems
