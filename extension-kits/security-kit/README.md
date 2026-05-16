# Security Kit

> **Add-on kit** for the [cogitokit](https://github.com/pettonativ/cogitokit) multi-kit AI agent system.

Provides **Cybersecurity validation** skills — Penetration Testing, Red Team Tactics, and Vulnerability Scanning.

---

## 🎯 Purpose

Identify technical vulnerabilities, attack surfaces, and apply OWASP guidelines across code and infrastructure:

| Skill                       | Focus                                                          | Status      |
| --------------------------- | -------------------------------------------------------------- | ----------- |
| **`vulnerability-scanner`** | Advanced vulnerability analysis, OWASP 2025, Supply Chain, SCA | ✅ Complete |
| **`red-team-tactics`**      | Offensive security tactics, detection evasion, MITRE ATT&CK    | ✅ Complete |

---

## 🏗️ Architecture

```
security-kit/
├── .agent/
│   ├── ARCHITECTURE.md
│   ├── agents/
│   │   ├── penetration-tester.md
│   │   └── security-auditor.md
│   └── skills/
│       ├── red-team-tactics/
│       └── vulnerability-scanner/
└── README.md
```

---

## 🔌 How to Use

1. **Included as submodule** of `cogitokit` under `extension-kits/security-kit/`
2. Antigravity **auto-discovers** all skills when the workspace is open
3. Route queries related to security flaws, pentesting, and OWASP to this kit's agents.

---

## 🤖 Agents

| Agent                | Focus                                                   | Skills                |
| -------------------- | ------------------------------------------------------- | --------------------- |
| `security-auditor`   | Code security checks, OWASP compliance, static analysis | vulnerability-scanner |
| `penetration-tester` | Active vulnerability exploitation, Red Teaming          | red-team-tactics      |

---

## 📄 License

Private repository. All rights reserved.
