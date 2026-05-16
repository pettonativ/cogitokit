# Compliance Kit Architecture

> Add-on kit for regulatory compliance validation — **Compliance-as-Code**

---

## 📋 Overview

Compliance Kit is an **add-on kit** in the cogitokit multi-kit system. It provides specialized skills for validating code, infrastructure, and documentation against European regulations and international standards.

### Kit Composition

- **1 Specialist Agent** — `compliance-auditor`
- **6 Skills** — 1 core framework + 5 domain-specific (3 complete, 2 skeleton)
- **1 Workflow** — `/compliance` slash command

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/
│   └── compliance-auditor.md   # Specialist agent
├── skills/
│   ├── compliance-core/         # Shared framework (report, workflow, guardrails)
│   ├── ai-act-compliance/       # EU AI Act (Reg. 2024/1689)
│   ├── nis2-compliance/         # NIS2 Directive
│   ├── gdpr-compliance/         # GDPR
│   ├── dora-compliance/         # DORA (skeleton)
│   └── iso27001-compliance/     # ISO 27001 (skeleton)
└── workflows/
    └── compliance.md            # /compliance slash command
```

---

## 🤖 Agent

| Agent                | Focus                          | Skills                                                                                                     |
| -------------------- | ------------------------------ | ---------------------------------------------------------------------------------------------------------- |
| `compliance-auditor` | Regulatory compliance analysis | compliance-core, ai-act-compliance, nis2-compliance, gdpr-compliance, dora-compliance, iso27001-compliance |

---

## 🧩 Skills (6)

### Core Framework

| Skill             | Description                                                                               |
| ----------------- | ----------------------------------------------------------------------------------------- |
| `compliance-core` | Shared workflow, report format, guardrails, severity matrix, cross-regulation correlation |

### Regulation-Specific

| Skill                 | Regulation                 | Status      | Checks    |
| --------------------- | -------------------------- | ----------- | --------- |
| `ai-act-compliance`   | EU AI Act (Reg. 2024/1689) | ✅ Complete | 10 checks |
| `nis2-compliance`     | NIS2 Directive             | ✅ Complete | 12 checks |
| `gdpr-compliance`     | GDPR                       | ✅ Complete | 11 checks |
| `dora-compliance`     | DORA                       | 🔲 Skeleton | 5 areas   |
| `iso27001-compliance` | ISO 27001:2022             | 🔲 Skeleton | 4 areas   |

---

## 🔗 Integration with cogitokit

### Auto-Discovery

Antigravity automatically discovers skills from this kit when it's open in the workspace. No manual configuration needed.

### Routing

The `intelligent-routing` skill in cogitokit routes compliance-related requests to `compliance-auditor` when this kit is present.

### Complementary Skills (in cogitokit)

| cogitokit Skill           | Relationship                                                           |
| ------------------------ | ---------------------------------------------------------------------- |
| `vulnerability-scanner`  | Complementary — technical security (OWASP) vs. regulatory requirements |
| `red-team-tactics`       | Complementary — offensive security vs. normative resilience testing    |
| `security-auditor` agent | Coexists — technical analysis vs. regulatory compliance                |
| `mlops-evaluation`       | Complementary — ML best practices vs. AI Act legal requirements        |

---

## 🔄 Workflow

| Command       | Description                        |
| ------------- | ---------------------------------- |
| `/compliance` | Guided regulatory compliance audit |

---

## 📊 Statistics

| Metric           | Value                                |
| ---------------- | ------------------------------------ |
| **Agent**        | 1                                    |
| **Skills**       | 6 (3 complete + 2 skeleton + 1 core) |
| **Workflows**    | 1                                    |
| **Total Checks** | 33+ (across 3 complete regulations)  |
