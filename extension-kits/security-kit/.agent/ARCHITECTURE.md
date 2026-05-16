# Security Kit Architecture

> Add-on kit for Cybersecurity and technical vulnerability validation

---

## 📋 Overview

Security Kit is an **add-on kit** in the cogitokit system. It handles the "technical security" aspect of the system, distinct from the regulatory checks performed by `compliance-kit`.

### Kit Composition

- **2 Specialist Agents** — `penetration-tester`, `security-auditor`
- **2 Skills** — Vulnerability Scanner, Red Team Tactics

---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/
│   ├── penetration-tester.md  # Offensive security, exploits
│   └── security-auditor.md    # Defensive security, OWASP audits
└── skills/
    ├── red-team-tactics/      # MITRE ATT&CK, attack phases
    └── vulnerability-scanner/ # OWASP, SCA, supply chain security
```

---

## 🤖 Agents

| Agent                | Focus                                                                    | Skills                |
| -------------------- | ------------------------------------------------------------------------ | --------------------- |
| `penetration-tester` | Offensive strategies, exploiting vulnerabilities, simulating adversaries | red-team-tactics      |
| `security-auditor`   | Identifying flaws, code reviews, CVEs, OWASP Top 10                      | vulnerability-scanner |

---

## 🧩 Skills (2)

| Skill                   | Description                                                                                                      |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `red-team-tactics`      | Tactical offensive guidelines based on MITRE ATT&CK. Execution, persistence, discovery.                          |
| `vulnerability-scanner` | Advanced technical vulnerability analysis (OWASP, Supply Chain, attack surface). Includes security scan scripts. |

---

## 🔗 Integration with cogitokit

### Auto-Discovery

Antigravity automatically discovers skills from this kit when it's open in the workspace.

### Complementary Skills (in compliance-kit)

| compliance-kit Skill  | Relationship                                                                                                       |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `nis2-compliance`     | NIS2 also requires securing infra, but focuses on the regulation (reporting, policies) vs pure technical patching. |
| `iso27001-compliance` | ISMS controls vs. technical security flaws.                                                                        |

---

## 📊 Statistics

| Metric        | Value |
| ------------- | ----- |
| **Agents**    | 2     |
| **Skills**    | 2     |
| **Workflows** | 0     |
