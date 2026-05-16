---
name: compliance-core
description: Shared compliance framework. Report template, information gathering protocol, severity matrix, cross-regulation correlation, and guardrails. Foundation for all regulation-specific skills.
version: 1.0.0
---

# Compliance Core — Shared Framework

> The foundation layer for all regulation-specific compliance skills. Defines how to gather, analyze, and report.

---

## 1. Information Gathering Protocol

### What to Scan

Before any regulation-specific analysis, collect evidence from:

| Category            | Files / Patterns                                                                                       | Purpose                                |
| ------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------- |
| **Dependencies**    | `requirements.txt`, `pyproject.toml`, `Pipfile`, `package.json`, `pom.xml`, `go.mod`                   | Identify security/privacy/ML libraries |
| **CI/CD Pipelines** | `.github/workflows/*.yml`, `.gitlab-ci.yml`, `Jenkinsfile`, `azure-pipelines.yml`, `.azure-pipelines/` | Identify automated checks              |
| **IaC**             | `*.tf`, `*.tfvars`, `k8s/*.yaml`, `helm/`, `docker-compose.yml`, `Dockerfile`                          | Infrastructure security posture        |
| **Documentation**   | `README.md`, `docs/`, `ARCHITECTURE.md`, `model_card.*`, `SECURITY.md`                                 | Process and design documentation       |
| **Data Pipelines**  | ETL scripts, ingestion code, data transformation                                                       | Data handling practices                |
| **Configuration**   | `.env*`, `config/`, secrets management                                                                 | Sensitive data handling                |
| **Logging**         | Log statements, logging configuration                                                                  | PII exposure risk                      |

### Domain Detection

Determine the project domain to auto-select relevant regulations:

| Signal                                                       | Domain         | Regulations                  |
| ------------------------------------------------------------ | -------------- | ---------------------------- |
| ML libraries (`torch`, `tensorflow`, `sklearn`, `langchain`) | AI/ML          | AI Act + GDPR + NIS2         |
| Financial keywords, payment processing                       | Finance        | DORA + NIS2 + GDPR           |
| Healthcare data, DICOM, HL7                                  | Healthcare     | GDPR + NIS2 (+ AI Act if ML) |
| Critical infrastructure IaC                                  | Infrastructure | NIS2 + GDPR                  |
| User data, forms, authentication                             | General Web    | GDPR + NIS2 (baseline)       |

---

## 2. Gap Analysis Engine

### Internal Question Protocol

For each check in a regulation-specific skill, ask:

```
1. Is there EVIDENCE of this control? (file, config, code)
   ├── YES → Check quality and completeness
   │         ├── Complete → ✅ PASSED
   │         └── Partial → 🟡 WARNING (describe gap)
   └── NO → 🔴 CRITICAL or 🟡 WARNING based on severity
```

### Severity Decision Tree

```
Is this a legal REQUIREMENT (MUST)?
├── YES → Is it a blocking violation?
│         ├── YES (e.g., HR AI system without bias testing) → 🔴 CRITICAL
│         └── NO (e.g., missing documentation section) → 🟡 WARNING
└── NO (SHOULD / best practice) → 🟡 WARNING or 🟢 INFO
```

---

## 3. Report Template

Always output findings using this unified structure:

```markdown
## 📊 Compliance Report — [Project Name]

**Regulations audited:** AI Act, NIS2, GDPR
**Date:** YYYY-MM-DD
**Scope:** [directories/files analyzed]
**Domain:** [detected project domain]

---

### 🔴 CRITICAL (Blocking)

| #   | Regulation | Finding                 | File/Location         | Remediation                            |
| --- | ---------- | ----------------------- | --------------------- | -------------------------------------- |
| 1   | GDPR       | PII logged in plaintext | `src/ingestion.py:42` | Use `presidio` analyzer before logging |

### 🟡 WARNING (To Mitigate)

| #   | Regulation | Finding                            | Location           | Remediation          |
| --- | ---------- | ---------------------------------- | ------------------ | -------------------- |
| 1   | AI Act     | No explainability library detected | `requirements.txt` | Add `shap` or `lime` |

### 🟢 PASSED

| #   | Regulation | Control                      | Evidence                                               |
| --- | ---------- | ---------------------------- | ------------------------------------------------------ |
| 1   | NIS2       | Vulnerability scanning in CI | `.github/workflows/security.yml:15` — trivy configured |

### 🛠️ REMEDIATION ACTIONS

#### Priority 1: [Critical finding title]

[Specific remediation with code snippet or tool recommendation]

#### Priority 2: [Warning finding title]

[Best practice guidance]
```

---

## 4. Cross-Regulation Correlation Matrix

Some requirements overlap across regulations. Map them to avoid duplicate findings:

| Requirement                  | NIS2              | GDPR           | AI Act  | DORA             | ISO 27001     |
| ---------------------------- | ----------------- | -------------- | ------- | ---------------- | ------------- |
| **Encryption in transit**    | Art. 21(2)(e)     | Art. 32(1)(a)  | —       | Art. 9(3)        | A.8.24        |
| **Encryption at rest**       | Art. 21(2)(e)     | Art. 32(1)(a)  | —       | Art. 9(3)        | A.8.24        |
| **Access control (RBAC)**    | Art. 21(2)(i)     | Art. 32(1)(b)  | —       | Art. 9(4)        | A.5.15, A.8.3 |
| **Incident response**        | Art. 23 (24h/72h) | Art. 33 (72h)  | —       | Art. 19 (4h/72h) | A.5.24-5.28   |
| **Logging & monitoring**     | Art. 21(2)(g)     | Art. 30        | Art. 12 | Art. 10          | A.8.15-8.16   |
| **Data integrity**           | Art. 21(2)(e)     | Art. 5(1)(d)   | Art. 10 | Art. 9           | A.8.10        |
| **Vulnerability management** | Art. 21(2)(e)     | —              | —       | Art. 9(2)        | A.8.8         |
| **Supply chain security**    | Art. 21(2)(d)     | Art. 28        | —       | Art. 28-30       | A.5.19-5.22   |
| **Risk assessment**          | Art. 21(1)        | Art. 35 (DPIA) | Art. 9  | Art. 6           | A.5.1, 8.8    |
| **Training & awareness**     | Art. 21(2)(g)     | —              | —       | Art. 13          | A.6.3         |
| **Business continuity**      | Art. 21(2)(c)     | —              | —       | Art. 11          | A.5.29-5.30   |

### How to Use

When a finding touches multiple regulations:

1. Report it **once** under the most relevant regulation
2. Add a **cross-reference note**: "Also relevant for: NIS2 Art.21, GDPR Art.32"
3. Do NOT duplicate the same finding across regulation sections

---

## 5. Guardrails

### MUST

| Rule                                 | Rationale                                 |
| ------------------------------------ | ----------------------------------------- |
| Point to exact files and lines       | Actionable, verifiable findings           |
| Use the report template above        | Consistent, structured output             |
| Separate facts from recommendations  | Clarity between "missing" vs "should add" |
| State which regulations were checked | Scope transparency                        |

### MUST NOT

| Rule                             | Rationale                                   |
| -------------------------------- | ------------------------------------------- |
| Provide legal opinions or advice | We are engineers, not lawyers               |
| Perform forensic investigation   | We identify gaps, not investigate breaches  |
| Guarantee compliance             | An automated scan cannot certify compliance |
| Generate verbose prose           | Be telegraphic: file, line, gap, fix        |
| Audit regulations not selected   | Respect scope                               |

---

## 6. Severity Matrix

| Level        | Icon | Criteria                                                  | Action                                  |
| ------------ | ---- | --------------------------------------------------------- | --------------------------------------- |
| **Critical** | 🔴   | Legal MUST requirement missing; immediate regulatory risk | Block deployment; remediate immediately |
| **High**     | 🟠   | Important control absent; significant gap                 | Remediate before next release           |
| **Medium**   | 🟡   | Best practice missing; partial implementation             | Plan remediation; add to backlog        |
| **Low**      | 🟢   | Informational; minor improvement opportunity              | Consider in next iteration              |

---

> **Remember:** Compliance-core is the shared foundation. It defines HOW to audit, not WHAT to check. The regulation-specific skills define the WHAT.
