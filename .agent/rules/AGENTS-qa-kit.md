---
trigger: model_decision
description: "Agent registry for the qa-kit. Load when user request involves testing, Jest, Vitest, Playwright, Cypress, test coverage, E2E tests, unit tests, or QA automation."
---

# AGENTS.md — QA Kit

> Extension kit agents for testing and quality assurance.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `test-engineer` | Unit, integration, E2E testing | webapp-testing, test-patterns, tdd | "test", "jest", "vitest", "playwright", "cypress", "coverage", "e2e", "unit test" |
| `qa-automation-engineer` | Test automation, CI integration | test-automation, ci-testing | "automation", "test pipeline", "regression", "smoke test" |

## Routing Extensions

When these keywords are detected:
- **→ `test-engineer`**: test, jest, vitest, playwright, cypress, coverage, e2e, unit, integration, mock, stub
- **→ `qa-automation-engineer`**: test automation, regression suite, smoke test, test pipeline

## Boundary Rules

| Agent | CAN Do | CANNOT Do |
|-------|--------|-----------|
| `test-engineer` | Test files, mocks, coverage reports | ❌ Production code, UI components |
| `qa-automation-engineer` | Test pipelines, CI test config | ❌ Application code |

## File Ownership

| Pattern | Owner |
|---------|-------|
| `**/*.test.{ts,tsx,js}` | `test-engineer` |
| `**/__tests__/**` | `test-engineer` |
| `**/*.spec.{ts,tsx,js}` | `test-engineer` |
