# DevOps Kit Architecture

> Add-on kit for DevOps, release management, and platform engineering

---

## 📋 Overview

DevOps Kit is an **add-on kit** in the cogitokit system. It houses the technical workflow and process skills necessary to run CI/CD, release management, and infrastructure optimizations.

### Kit Composition

- **3 Specialist Agents** — `devops-engineer`, `release-manager`, `performance-optimizer`
- **3 Skills** — Deployment Procedures, Performance Profiling, Release Planning

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/
│   ├── devops-engineer.md     # Infrastructure & scaling
│   ├── performance-optimizer.md# Profiling and bottlenecks
│   └── release-manager.md     # Go/No-go and release trains
└── skills/
    ├── deployment-procedures/ # Safe deployments and rollbacks
    ├── performance-profiling/ # Optimization techniques
    └── release-planning/      # Feature flags, semantic versioning
```

---

## 🤖 Agents

| Agent                   | Focus                                              | Skills                                       |
| ----------------------- | -------------------------------------------------- | -------------------------------------------- |
| `devops-engineer`       | Infrastructure optimization, pipeline architecture | deployment-procedures, performance-profiling |
| `release-manager`       | Release lifecycle and semantic versioning          | release-planning, deployment-procedures      |
| `performance-optimizer` | Bottlenecks, caching, process management           | performance-profiling                        |

---

## 📊 Statistics

| Metric        | Value |
| ------------- | ----- |
| **Agents**    | 3     |
| **Skills**    | 3     |
| **Workflows** | 0     |
