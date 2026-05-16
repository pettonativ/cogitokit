---
name: iso27001-compliance
description: ISO 27001:2022 compliance validation skeleton. Organizational, people, physical, and technological controls from Annex A. Use when verifying ISMS controls in code and infrastructure.
version: 0.1.0
---

# ISO 27001 Compliance — Information Security Management System (ISO/IEC 27001:2022)

> Skeleton skill for ISO 27001:2022 compliance validation, focused on Annex A controls that can be verified in code and infrastructure.

**Status:** 🔲 Skeleton — Control categories defined, detailed checks to be expanded.

**Prerequisite:** Load `compliance-core` for report template and information gathering protocol.

---

## 1. Standard Context

### ISO 27001:2022 Structure

| Clause      | Focus                                       |
| ----------- | ------------------------------------------- |
| 4-10        | ISMS requirements (management system)       |
| **Annex A** | **93 controls in 4 themes** (what we check) |

### Annex A Control Themes

```
ISO 27001:2022 Annex A (93 controls)
├── A.5  Organizational Controls (37 controls)
├── A.6  People Controls (8 controls)
├── A.7  Physical Controls (14 controls)
└── A.8  Technological Controls (34 controls)
```

> **Focus:** This skill primarily checks **A.8 Technological Controls** and select **A.5 Organizational Controls** that are verifiable in code/infrastructure.

---

## 2. Control Areas

### A.5 — Organizational Controls (Selected)

| Control | Title                                             | Checks (TODO)                         |
| ------- | ------------------------------------------------- | ------------------------------------- |
| A.5.1   | Policies for information security                 | Security policy documentation         |
| A.5.2   | Information security roles                        | RACI matrix, role documentation       |
| A.5.8   | Information security in project management        | Security requirements in project docs |
| A.5.15  | Access control                                    | RBAC implementation                   |
| A.5.19  | Information security in supplier relationships    | DPA, vendor assessment                |
| A.5.22  | Monitoring, review of supplier services           | Supplier monitoring                   |
| A.5.24  | Information security incident management planning | IRP documentation                     |
| A.5.28  | Collection of evidence                            | Audit logging, evidence preservation  |
| A.5.29  | Information security during disruption            | BCP, DR plans                         |
| A.5.36  | Compliance with policies, rules and standards     | Compliance audit processes            |

### A.6 — People Controls (Selected)

| Control | Title                                                      | Checks (TODO)          |
| ------- | ---------------------------------------------------------- | ---------------------- |
| A.6.3   | Information security awareness, education and training     | Training documentation |
| A.6.5   | Responsibilities after termination or change of employment | Offboarding process    |

### A.7 — Physical Controls

> Physical controls are generally not verifiable in code. Marked as out-of-scope for automated checks.

### A.8 — Technological Controls

| Control | Title                                                       | Checks (TODO)                      |
| ------- | ----------------------------------------------------------- | ---------------------------------- |
| A.8.1   | User endpoint devices                                       | Endpoint management config         |
| A.8.3   | Information access restriction                              | RBAC, field-level access           |
| A.8.4   | Access to source code                                       | Repository access controls         |
| A.8.5   | Secure authentication                                       | MFA, password policy               |
| A.8.7   | Protection against malware                                  | Antimalware in pipeline            |
| A.8.8   | Management of technical vulnerabilities                     | Vulnerability scanning             |
| A.8.9   | Configuration management                                    | IaC, config baselines              |
| A.8.10  | Information deletion                                        | Data retention, secure deletion    |
| A.8.11  | Data masking                                                | PII masking in code                |
| A.8.12  | Data leakage prevention                                     | DLP controls                       |
| A.8.15  | Logging                                                     | Centralized logging                |
| A.8.16  | Monitoring activities                                       | Alerting, monitoring               |
| A.8.20  | Networks security                                           | Network segmentation, firewalls    |
| A.8.21  | Security of network services                                | Service mesh, TLS                  |
| A.8.23  | Web filtering                                               | URL filtering, WAF                 |
| A.8.24  | Use of cryptography                                         | Encryption at rest and in transit  |
| A.8.25  | Secure development life cycle                               | SDLC documentation, security gates |
| A.8.26  | Application security requirements                           | Security requirements in specs     |
| A.8.27  | Secure system architecture and engineering principles       | Security architecture docs         |
| A.8.28  | Secure coding                                               | Code review, SAST                  |
| A.8.29  | Security testing in development and acceptance              | Security testing in CI/CD          |
| A.8.31  | Separation of development, test and production environments | Environment separation             |
| A.8.32  | Change management                                           | Change management process          |
| A.8.33  | Test information                                            | Test data management               |
| A.8.34  | Protection of information systems during audit testing      | Audit environment isolation        |

---

## 3. Cross-References

| ISO 27001 Control              | NIS2 Equivalent | GDPR Equivalent |
| ------------------------------ | --------------- | --------------- |
| A.5.24 Incident management     | Art. 23         | Art. 33         |
| A.5.29 Business continuity     | Art. 21(2)(c)   | —               |
| A.8.3 Access restriction       | Art. 21(2)(i)   | Art. 32(1)(b)   |
| A.8.8 Vulnerability management | Art. 21(2)(e)   | —               |
| A.8.15-16 Logging/Monitoring   | Art. 21(2)(g)   | Art. 30         |
| A.8.24 Cryptography            | Art. 21(2)(e)   | Art. 32(1)(a)   |
| A.8.25 Secure SDLC             | Art. 21(2)(e)   | Art. 25         |

---

## 4. Expansion Roadmap

To complete this skill:

1. Add specific file/code checks for each A.8 control
2. Add detection patterns (grep patterns, file existence checks)
3. Add remediation toolkit per control
4. Prioritize controls by SOA (Statement of Applicability) relevance

---

> **Note:** ISO 27001 is a management system standard. Many controls require organizational (non-technical) evidence. This skill focuses on controls verifiable in code, configuration, and infrastructure. A full ISO 27001 audit requires additional non-technical assessment.
