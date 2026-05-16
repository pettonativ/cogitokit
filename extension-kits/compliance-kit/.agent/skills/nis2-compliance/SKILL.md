---
name: nis2-compliance
description: NIS2 Directive compliance validation. Vulnerability scanning, IaC security, secret detection, RBAC, encryption, SBOM, incident response, supply chain security, logging, business continuity. Use when analyzing infrastructure and CI/CD for NIS2 compliance.
version: 1.0.0
---

# NIS2 Compliance — Network and Information Security Directive 2

> Validate infrastructure, CI/CD pipelines, and operational processes against NIS2 requirements for cyber resilience.

**Prerequisite:** Load `compliance-core` for report template and information gathering protocol.

---

## 1. Regulatory Context

### Scope

NIS2 applies to **essential** and **important** entities in sectors including:

| Essential Entities              | Important Entities     |
| ------------------------------- | ---------------------- |
| Energy                          | Postal services        |
| Transport                       | Waste management       |
| Banking                         | Chemical manufacturing |
| Financial market infrastructure | Food production        |
| Health                          | Digital providers      |
| Drinking water                  | Research               |
| Digital infrastructure          | Manufacturing          |
| ICT service management (B2B)    |                        |
| Public administration           |                        |
| Space                           |                        |

### Key Obligations

| Article       | Requirement                                              | Deadline                 |
| ------------- | -------------------------------------------------------- | ------------------------ |
| Art. 21       | Risk management measures                                 | Oct 2024 (transposition) |
| Art. 23       | Incident reporting (24h early warning, 72h notification) | Oct 2024                 |
| Art. 20       | Management body oversight and training                   | Oct 2024                 |
| Art. 21(2)(d) | Supply chain security                                    | Oct 2024                 |

---

## 2. Compliance Checks

### Check 1: Vulnerability Scanning in CI/CD (Art. 21(2)(e))

**Question:** Are automated vulnerability scans configured in the CI/CD pipeline?

| Evidence                                                            | Location                    |
| ------------------------------------------------------------------- | --------------------------- |
| **Container scanning:** `trivy`, `grype`, `snyk container`          | CI/CD pipeline config       |
| **Dependency scanning:** `snyk`, `npm audit`, `safety`, `pip-audit` | CI/CD pipeline config       |
| **Code scanning:** `bandit` (Python), `semgrep`, `CodeQL`           | CI/CD pipeline config       |
| **Scan results:** blocking on critical findings                     | Pipeline failure conditions |

**🔴 Critical if:** No vulnerability scanning in any CI/CD pipeline.
**🟡 Warning if:** Scanning exists but does not block on critical findings.

---

### Check 2: IaC Security Scanning (Art. 21(2)(e))

**Question:** Is Infrastructure as Code scanned for misconfigurations?

| Evidence                                                         | Location                         |
| ---------------------------------------------------------------- | -------------------------------- |
| **IaC scanners:** `checkov`, `tfsec`, `kics`, `terrascan`        | CI/CD pipeline, pre-commit hooks |
| **Policy-as-code:** OPA/Rego policies, Sentinel                  | Policy definitions               |
| **Scan scope:** Terraform, Kubernetes YAML, Helm, CloudFormation | IaC files                        |

**🟡 Warning if:** IaC exists but no automated scanning.

---

### Check 3: Secret Detection (Art. 21(2)(e))

**Question:** Are secrets/credentials prevented from entering the codebase?

| Evidence                                                                   | Location                                           |
| -------------------------------------------------------------------------- | -------------------------------------------------- |
| **Pre-commit:** `gitleaks`, `trufflehog`, `detect-secrets`                 | `.pre-commit-config.yaml`, CI/CD                   |
| **CI scanning:** secret scanning in pipeline                               | CI/CD pipeline config                              |
| **Secrets manager:** HashiCorp Vault, AWS Secrets Manager, Azure Key Vault | IaC config, application config                     |
| **No hardcoded secrets**                                                   | Search for patterns: `password=`, API keys, tokens |

**🔴 Critical if:** Hardcoded secrets found in codebase.
**🟡 Warning if:** No automated secret detection in CI/CD.

---

### Check 4: Access Control — RBAC (Art. 21(2)(i))

**Question:** Is Role-Based Access Control implemented?

| Evidence                                                  | Location                                     |
| --------------------------------------------------------- | -------------------------------------------- |
| **Kubernetes RBAC:** `Role`, `ClusterRole`, `RoleBinding` | K8s manifests                                |
| **Cloud IAM:** least-privilege policies                   | Terraform IAM, Azure RBAC                    |
| **Application RBAC:** role-based authorization            | Application code, middleware                 |
| **Service accounts:** dedicated, least-privilege          | K8s service accounts, cloud service accounts |

**🟡 Warning if:** No RBAC configuration detected.
**Cross-ref:** Also relevant for GDPR Art. 32(1)(b).

---

### Check 5: Encryption in Transit (Art. 21(2)(e))

**Question:** Is TLS/mTLS configured for all communications?

| Evidence                                                | Location                           |
| ------------------------------------------------------- | ---------------------------------- |
| **Ingress TLS:** TLS termination configured             | Ingress YAML, load balancer config |
| **mTLS:** service mesh (Istio, Linkerd) or mutual TLS   | Service mesh config                |
| **Certificate management:** cert-manager, Let's Encrypt | K8s config, IaC                    |
| **No plain HTTP:** all endpoints enforce HTTPS          | Application config, redirect rules |

**🔴 Critical if:** External-facing services without TLS.
**Cross-ref:** Also relevant for GDPR Art. 32(1)(a).

---

### Check 6: Encryption at Rest (Art. 21(2)(e))

**Question:** Is data encrypted at rest?

| Evidence                                            | Location                                    |
| --------------------------------------------------- | ------------------------------------------- |
| **Storage encryption:** enabled in cloud storage    | IaC (S3 SSE, Azure Storage encryption, GCS) |
| **Database encryption:** TDE, encrypted connections | Database config, connection strings         |
| **Disk encryption:** encrypted volumes              | IaC, VM/container config                    |

**🟡 Warning if:** Storage resources without encryption configuration.
**Cross-ref:** Also relevant for GDPR Art. 32(1)(a).

---

### Check 7: SBOM Generation (Art. 21(2)(e))

**Question:** Is a Software Bill of Materials generated?

| Evidence                                              | Location                          |
| ----------------------------------------------------- | --------------------------------- |
| **SBOM tools:** `syft`, `cyclonedx-cli`, `trivy sbom` | CI/CD pipeline                    |
| **SBOM format:** SPDX or CycloneDX                    | Pipeline artifacts                |
| **SBOM published:** accessible to stakeholders        | Artifact registry, release assets |

**🟡 Warning if:** No SBOM generation in CI/CD.

---

### Check 8: Incident Response Procedures (Art. 23)

**Question:** Is there a documented incident response plan with NIS2 timelines?

| Evidence                                           | Location                           |
| -------------------------------------------------- | ---------------------------------- |
| **IRP document:** incident response plan           | `/docs/`, `SECURITY.md`, runbooks  |
| **Timelines:** 24h early warning, 72h notification | IRP document                       |
| **Contacts:** CSIRT/authority notification process | IRP document                       |
| **Runbooks:** step-by-step response procedures     | `/docs/runbooks/`, operations docs |
| **Post-incident:** review and lessons learned      | IRP document                       |

**🔴 Critical if:** No incident response documentation exists.
**🟡 Warning if:** IRP exists but does not mention NIS2 timelines (24h/72h).

---

### Check 9: Supply Chain Security (Art. 21(2)(d))

**Question:** Are supply chain risks managed?

| Evidence                                           | Location                                           |
| -------------------------------------------------- | -------------------------------------------------- |
| **Lock files:** committed and up-to-date           | `package-lock.json`, `Pipfile.lock`, `poetry.lock` |
| **Dependency pinning:** exact versions, not ranges | Dependency files                                   |
| **Artifact signing:** Sigstore, cosign             | CI/CD pipeline, release process                    |
| **Private registry:** verified package sources     | npm/pip/Docker config                              |
| **Dependency review:** automated PR review         | GitHub Dependabot, Renovate                        |

**🟡 Warning if:** Lock files not committed or dependencies not pinned.

---

### Check 10: Logging & Monitoring (Art. 21(2)(g))

**Question:** Is centralized logging and monitoring configured?

| Evidence                                                  | Location                          |
| --------------------------------------------------------- | --------------------------------- |
| **Log aggregation:** ELK, Loki, Azure Monitor, CloudWatch | IaC, application config           |
| **Alerting:** alert rules configured                      | Monitoring config, alerting rules |
| **Audit logging:** security events logged                 | Application code, middleware      |
| **Log retention:** retention policy defined               | Logging config                    |

**🟡 Warning if:** No centralized logging detected.
**Cross-ref:** Also relevant for GDPR Art. 30.

---

### Check 11: Business Continuity (Art. 21(2)(c))

**Question:** Are backup and disaster recovery procedures in place?

| Evidence                                             | Location                   |
| ---------------------------------------------------- | -------------------------- |
| **Backup configuration:** automated backups          | IaC, cloud provider config |
| **DR plan:** documented recovery procedures          | `/docs/`, runbooks         |
| **RTO/RPO:** defined targets                         | DR documentation           |
| **Backup testing:** regular restore tests documented | Operations docs            |

**🟡 Warning if:** No backup or DR documentation detected.

---

### Check 12: Access Review Process (Art. 21(2)(i))

**Question:** Is there a process for periodic access reviews?

| Evidence                                       | Location                           |
| ---------------------------------------------- | ---------------------------------- |
| **Review process:** documented periodic review | Operations docs, security policies |
| **Automation:** access review scripts/tools    | Scripts, IAM tools                 |
| **Audit trail:** access changes logged         | IAM audit logs                     |

**🟡 Warning if:** No access review process documented.

---

## 3. Remediation Toolkit

### Quick Wins

| Gap                       | Tool / Approach                                                         |
| ------------------------- | ----------------------------------------------------------------------- |
| No container scanning     | Add `trivy` to CI: `trivy image --exit-code 1 --severity CRITICAL,HIGH` |
| No IaC scanning           | Add `checkov` to CI: `checkov -d . --framework terraform`               |
| No secret detection       | Add `gitleaks` pre-commit hook                                          |
| No SBOM                   | Add `syft` to CI: `syft . -o cyclonedx-json > sbom.json`                |
| No incident response plan | Create `INCIDENT_RESPONSE.md` with NIS2 timelines                       |
| Missing lock files        | Run `npm ci` / `pip freeze > requirements.txt` and commit               |

### Example: Security Pipeline Stage

```yaml
# .github/workflows/security.yml
name: NIS2 Security Checks
on: [push, pull_request]
jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Vulnerability Scanning
      - name: Trivy Container Scan
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: "fs"
          exit-code: "1"
          severity: "CRITICAL,HIGH"

      # IaC Scanning
      - name: Checkov IaC Scan
        uses: bridgecrewio/checkov-action@master
        with:
          directory: ./infra

      # Secret Detection
      - name: Gitleaks
        uses: gitleaks/gitleaks-action@v2

      # SBOM Generation
      - name: Generate SBOM
        uses: anchore/sbom-action@v0
        with:
          format: cyclonedx-json
```

---

## 4. Anti-Patterns

| ❌ Don't                             | ✅ Do                                           |
| ------------------------------------ | ----------------------------------------------- |
| Run scans but ignore results         | Configure pipeline to fail on critical findings |
| Scan only at deploy time             | Shift-left: scan on every PR                    |
| Use broad IAM permissions            | Apply least-privilege                           |
| Keep incident response only on paper | Include automated alerting and runbooks         |

---

> **Remember:** NIS2 is about cyber resilience, not just security tools. The directive requires a holistic approach: risk management, incident response, supply chain security, and continuous improvement.
