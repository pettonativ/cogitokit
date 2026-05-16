---
name: dora-compliance
description: DORA (Digital Operational Resilience Act) compliance validation skeleton. ICT risk management, incident reporting, resilience testing, third-party risk, information sharing. For financial sector entities. Use when analyzing financial services for DORA compliance.
version: 0.1.0
---

# DORA Compliance — Digital Operational Resilience Act (Reg. EU 2022/2554)

> Skeleton skill for DORA compliance validation. Applicable to financial entities (banks, insurance, investment firms, payment institutions, crypto-asset providers).

**Status:** 🔲 Skeleton — Core areas defined, detailed checks to be expanded.

**Prerequisite:** Load `compliance-core` for report template and information gathering protocol.

---

## 1. Regulatory Context

### Scope

DORA applies to financial entities including:

- Credit institutions
- Investment firms
- Insurance/reinsurance undertakings
- Payment institutions
- Crypto-asset service providers
- ICT third-party service providers (for critical functions)

### Timeline

| Date     | Milestone                 |
| -------- | ------------------------- |
| Jan 2023 | DORA enters into force    |
| Jan 2025 | **Full application date** |

---

## 2. Pillars (Art. 5-44)

### Pillar 1: ICT Risk Management (Art. 5-16)

| Area                    | Requirements                         | Checks (TODO)           |
| ----------------------- | ------------------------------------ | ----------------------- |
| ICT Risk Framework      | Documented risk management framework | Risk assessment docs    |
| Business Continuity     | BCP and DRP for ICT                  | DR plans, backup config |
| ICT Asset Management    | Inventory of ICT assets              | Asset documentation     |
| Incident Detection      | Monitoring and alerting              | Observability config    |
| Protection & Prevention | Security controls                    | Security architecture   |
| Recovery & Restoration  | Recovery procedures and testing      | Runbooks, DR tests      |

### Pillar 2: ICT Incident Reporting (Art. 17-23)

| Area                 | Requirements                           | Checks (TODO)            |
| -------------------- | -------------------------------------- | ------------------------ |
| Classification       | Major incident classification criteria | IRP documentation        |
| Initial Notification | 4 hours for major incidents            | IRP timelines            |
| Intermediate Report  | 72 hours                               | IRP documentation        |
| Final Report         | 1 month                                | IRP documentation        |
| Voluntary Reporting  | Significant cyber threats              | Threat sharing processes |

### Pillar 3: Digital Operational Resilience Testing (Art. 24-27)

| Area                    | Requirements                                                      | Checks (TODO)       |
| ----------------------- | ----------------------------------------------------------------- | ------------------- |
| Basic Testing           | Vulnerability assessments, network security, open-source analysis | Test documentation  |
| Advanced Testing (TLPT) | Threat-Led Penetration Testing (for critical entities)            | TLPT reports        |
| Scenario Testing        | ICT scenario-based testing                                        | Test plans, results |

### Pillar 4: ICT Third-Party Risk (Art. 28-44)

| Area                   | Requirements                      | Checks (TODO)        |
| ---------------------- | --------------------------------- | -------------------- |
| Due Diligence          | Pre-contract risk assessment      | Vendor documentation |
| Contractual Provisions | Mandatory contract clauses        | Contract review      |
| Concentration Risk     | Dependency analysis               | Vendor mapping       |
| Exit Strategies        | Migration and exit plans          | Documentation        |
| Oversight Framework    | Supervision of critical providers | Monitoring processes |

### Pillar 5: Information Sharing (Art. 45)

| Area                | Requirements                          | Checks (TODO)        |
| ------------------- | ------------------------------------- | -------------------- |
| Threat Intelligence | Participation in sharing arrangements | Documentation, feeds |
| Reporting           | Anonymized incident data sharing      | Policies             |

---

## 3. Cross-References

| DORA Requirement                 | NIS2 Equivalent                   | GDPR Equivalent                    |
| -------------------------------- | --------------------------------- | ---------------------------------- |
| ICT risk management (Art. 6)     | Risk management (Art. 21)         | Security of processing (Art. 32)   |
| Incident reporting (Art. 19: 4h) | Incident reporting (Art. 23: 24h) | Breach notification (Art. 33: 72h) |
| Encryption (Art. 9)              | Cybersecurity measures (Art. 21)  | Security measures (Art. 32)        |
| Third-party risk (Art. 28)       | Supply chain (Art. 21(2)(d))      | Processor obligations (Art. 28)    |

---

## 4. Expansion Roadmap

To complete this skill, expand each pillar with:

1. Specific file/code checks (like ai-act-compliance)
2. Detection patterns
3. Remediation toolkit
4. CI/CD integration examples

---

> **Note:** This is a skeleton skill. Detailed checks will be added based on project needs. The framework structure follows the same pattern as the complete skills.
