# QA Kit Architecture

> Add-on kit for Quality Assurance, Automated Testing, and Validations

---

## 📋 Overview

QA Kit is an **add-on kit** in the cogitokit system. It houses the tools and processes for systematic testing and quality management.

### Kit Composition

- **2 Specialist Agents** — `test-engineer`, `qa-automation-engineer`
- **5 Skills** — Testing Patterns, WebApp Testing, Lint & Validate, Quality Management, TDD Workflow

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/
│   ├── qa-automation-engineer.md  # E2E and automation logic
│   └── test-engineer.md           # Unit/Integration/TDD
└── skills/
    ├── lint-and-validate/   # Static analysis definitions
    ├── quality-management/  # Metrics and quality gates
    ├── tdd-workflow/        # RED-GREEN-REFACTOR
    ├── testing-patterns/    # Mocking and structuring tests
    └── webapp-testing/      # UI and End-to-End frameworks
```

---

## 🤖 Agents

| Agent                    | Focus                                        | Skills                                                                |
| ------------------------ | -------------------------------------------- | --------------------------------------------------------------------- |
| `test-engineer`          | Core test implementations, Test-driven logic | testing-patterns, tdd-workflow, lint-and-validate, quality-management |
| `qa-automation-engineer` | End-to-end setups, browser orchestration     | webapp-testing, quality-management                                    |

---

## 📊 Statistics

| Metric        | Value |
| ------------- | ----- |
| **Agents**    | 2     |
| **Skills**    | 5     |
| **Workflows** | 0     |
