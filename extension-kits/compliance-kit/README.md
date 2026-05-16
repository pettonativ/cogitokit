# Compliance Kit

> **Add-on kit** for the [cogitokit](https://github.com/pettonativ/cogitokit) multi-kit AI agent system.

Provides **regulatory compliance validation** skills for European regulations and international standards, following a **Compliance-as-Code** approach.

---

## 🎯 Purpose

Analyze code repositories, CI/CD pipelines, Infrastructure as Code, and technical documentation to identify **compliance gaps** against:

| Regulation / Standard                     | Skill                 | Status      |
| ----------------------------------------- | --------------------- | ----------- |
| **EU AI Act** (Reg. 2024/1689)            | `ai-act-compliance`   | ✅ Complete |
| **NIS2** (Resilience & Cybersecurity)     | `nis2-compliance`     | ✅ Complete |
| **GDPR** (Data Protection)                | `gdpr-compliance`     | ✅ Complete |
| **DORA** (Digital Operational Resilience) | `dora-compliance`     | 🔲 Skeleton |
| **ISO 27001** (ISMS)                      | `iso27001-compliance` | 🔲 Skeleton |

---

## 🏗️ Architecture

```
compliance-kit/
├── .agent/
│   ├── ARCHITECTURE.md
│   ├── agents/
│   │   └── compliance-auditor.md
│   ├── skills/
│   │   ├── compliance-core/         # Shared framework
│   │   ├── ai-act-compliance/       # EU AI Act
│   │   ├── nis2-compliance/         # NIS2
│   │   ├── gdpr-compliance/         # GDPR
│   │   ├── dora-compliance/         # DORA (skeleton)
│   │   └── iso27001-compliance/     # ISO 27001 (skeleton)
│   └── workflows/
│       └── compliance.md            # /compliance command
└── README.md
```

---

## 🔌 How to Use

1. **Clone this repository** alongside your `cogitokit`:

   ```bash
   cd ~/Documents/GitHub/personal
   git clone https://github.com/pettonativ/compliance-kit.git
   ```

2. **Open both kits** in your IDE workspace. Antigravity will auto-discover the skills.

3. **Use the `/compliance` command** or simply ask about compliance — the `intelligent-routing` in cogitokit will automatically route to the `compliance-auditor` agent.

---

## ⚖️ Compliance ≠ Security

| This Kit (Compliance)   | cogitokit (Security)       |
| ----------------------- | ------------------------- |
| Regulatory requirements | Technical vulnerabilities |
| Documentation gaps      | OWASP Top 10              |
| Process compliance      | Penetration testing       |
| Normative controls      | Code pattern analysis     |

The kits are **complementary**: a full audit may use both `security-auditor` (cogitokit) and `compliance-auditor` (this kit).

---

## 🚫 Guardrails

- **No legal advice** — This kit provides technical implementation guidance only (Compliance-as-Code)
- **No forensic analysis** — Identifies gaps, does not investigate incidents
- **Telegraphic output** — Points to exact files and lines with compliance gaps

---

## 📄 License

Private repository. All rights reserved.
