# DevOps Kit

> **Add-on kit** for the [cogitokit](https://github.com/pettonativ/cogitokit) multi-kit AI agent system.

Provides **DevOps and Infrastructure** skills — CI/CD, Deployment, Release Management, and Performance Profiling.

---

## 🎯 Purpose

A dedicated ecosystem for managing releases, deployments, and infrastructure pipelines:

| Skill                       | Focus                                                | Status      |
| --------------------------- | ---------------------------------------------------- | ----------- |
| **`deployment-procedures`** | Safe deployment workflows, rollback and verification | ✅ Complete |
| **`release-planning`**      | Release trains, feature flags, go/no-go criteria     | ✅ Complete |
| **`performance-profiling`** | Performance analysis, metrics, optimization          | ✅ Complete |

---

## 🏗️ Architecture

```
devops-kit/
├── .agent/
│   ├── ARCHITECTURE.md
│   ├── agents/
│   │   ├── devops-engineer.md
│   │   ├── performance-optimizer.md
│   │   └── release-manager.md
│   └── skills/
│       ├── deployment-procedures/
│       ├── performance-profiling/
│       └── release-planning/
└── README.md
```

---

## 🔌 How to Use

1. **Included as submodule** of `cogitokit` under `extension-kits/devops-kit/`
2. Antigravity **auto-discovers** all skills when the workspace is open
3. Route queries related to deployment, release planning, and performance tuning to the `devops-engineer` or `release-manager`.

---

## 📄 License

Private repository. All rights reserved.
