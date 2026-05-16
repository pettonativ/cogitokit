# QA Kit

> **Add-on kit** for the [cogitokit](https://github.com/pettonativ/cogitokit) multi-kit AI agent system.

Provides **Quality Assurance and Testing** skills — Automation, E2E Testing, TDD, Linting, and Quality Gates.

---

## 🎯 Purpose

A dedicated ecosystem for ensuring software quality:

| Skill                    | Focus                                         | Status      |
| ------------------------ | --------------------------------------------- | ----------- |
| **`testing-patterns`**   | Unit, integration, mocking, component testing | ✅ Complete |
| **`webapp-testing`**     | E2E testing, Playwright, browser automation   | ✅ Complete |
| **`lint-and-validate`**  | Linting rules, static analysis, formatting    | ✅ Complete |
| **`quality-management`** | Quality gates, defect tracking, metrics       | ✅ Complete |
| **`tdd-workflow`**       | Test-Driven Development, Red-Green-Refactor   | ✅ Complete |

---

## 🏗️ Architecture

```
qa-kit/
├── .agent/
│   ├── ARCHITECTURE.md
│   ├── agents/
│   │   ├── qa-automation-engineer.md
│   │   └── test-engineer.md
│   └── skills/
│       ├── lint-and-validate/
│       ├── quality-management/
│       ├── tdd-workflow/
│       ├── testing-patterns/
│       └── webapp-testing/
└── README.md
```

---

## 🔌 How to Use

1. **Included as submodule** of `cogitokit` under `extension-kits/qa-kit/`
2. Antigravity **auto-discovers** all skills when the workspace is open
3. Route queries related to writing tests, validation, and QA frameworks to the `test-engineer` or `qa-automation-engineer`.

---

## 📄 License

Private repository. All rights reserved.
