---
name: azure-deploy
description: Azure deployment patterns. App Service, Container Apps, AKS, Azure Functions. CI/CD with Azure DevOps and GitHub Actions. Slot deployments, traffic routing, rollback. Use when deploying to Azure.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure Deployment Patterns

> "Deploy safely. Route traffic smartly. Roll back instantly."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                  | Description                              | When to Read             |
| --------------------- | ---------------------------------------- | ------------------------ |
| `app-service.md`      | Web Apps, deployment slots, swap         | Standard web deployments |
| `container-apps.md`   | Container Apps, revisions, traffic split | Container workloads      |
| `aks-deployment.md`   | AKS, Helm, rolling updates               | Kubernetes workloads     |
| `functions.md`        | Azure Functions deployment               | Serverless               |
| `devops-pipelines.md` | Azure DevOps pipeline patterns           | CI/CD integration        |
| `slot-strategies.md`  | Blue-green, canary via slots             | Zero-downtime deploys    |

---

## Core Deployment Services

### Decision Tree

```
What are you deploying?
│
├── Web App (code)
│   └── App Service (Web App) + Deployment Slots
│
├── Container (single/few)
│   └── Container Apps (serverless containers)
│
├── Containers (orchestrated)
│   └── AKS (Kubernetes)
│
├── Serverless functions
│   └── Azure Functions
│
├── Static site
│   └── Static Web Apps
│
└── Batch / async jobs
    ├── Container Apps Jobs
    └── Azure Container Instances (ACI)
```

### Comparison

| Service             | Best For              | Scale to Zero    | Deploy Speed | Complexity |
| ------------------- | --------------------- | ---------------- | ------------ | ---------- |
| **App Service**     | Web apps, APIs        | ❌ (always on)   | Fast (slots) | Low        |
| **Container Apps**  | Microservices, jobs   | ✅               | Fast         | Low-Medium |
| **AKS**             | Complex orchestration | ❌               | Medium       | High       |
| **Functions**       | Event-driven          | ✅ (consumption) | Fast         | Low        |
| **Static Web Apps** | SPA, static sites     | ✅               | Fast         | Very Low   |

---

## Deployment Slot Strategy (App Service)

### Pattern: Blue-Green via Slots

```
Production Slot ← Live traffic
                    ↑ swap
Staging Slot    ← Deploy here first, test, then swap
```

### Swap Workflow

1. **Deploy** to staging slot
2. **Verify** staging (health checks, smoke tests)
3. **Warm up** staging slot (auto-swap warm-up)
4. **Swap** staging ↔ production
5. **Verify** production
6. **Keep old** version in staging (instant rollback)

### Slot Settings vs App Settings

| Type                       | Swapped? | Use For                          |
| -------------------------- | -------- | -------------------------------- |
| **App Settings** (default) | ✅ Yes   | App config that follows code     |
| **Slot Settings** (sticky) | ❌ No    | Connection strings, env-specific |

---

## Azure DevOps Pipeline Patterns

### Standard Deploy Pipeline

```yaml
stages:
  - stage: Build
    jobs:
      - job: BuildAndTest
        steps:
          - task: Build
          - task: Test
          - task: PublishArtifact

  - stage: DeployStaging
    dependsOn: Build
    jobs:
      - deployment: DeployToStaging
        environment: staging
        strategy:
          runOnce:
            deploy:
              steps:
                - task: DeployToSlot

  - stage: DeployProd
    dependsOn: DeployStaging
    jobs:
      - deployment: DeployToProd
        environment: production
        strategy:
          runOnce:
            deploy:
              steps:
                - task: SwapSlots
```

### Submit-and-Detach Pattern (for long jobs)

```yaml
# Pipeline submits async job and exits — does NOT wait
steps:
  - task: AzureCLI@2
    inputs:
      scriptType: bash
      scriptLocation: inlineScript
      inlineScript: |
        # Submit to external compute (AWS Batch, Container Apps Job, etc.)
        JOB_ID=$(submit_job ...)
        echo "##vso[task.setvariable variable=JOB_ID]$JOB_ID"
        # Pipeline exits here — agent is freed

# Separate pipeline triggered by callback/webhook
trigger: none
steps:
  - task: CheckJobStatus
    inputs:
      jobId: $(JOB_ID)
```

### Status Reporting via Azure DevOps API

```bash
# Report status back to Azure DevOps from external compute
curl -X PATCH \
  "https://dev.azure.com/{org}/{project}/_apis/build/builds/{buildId}?api-version=7.0" \
  -H "Authorization: Bearer $AZURE_PAT" \
  -H "Content-Type: application/json" \
  -d '{"status": "completed", "result": "succeeded"}'
```

---

## Container Apps Deployment

### Revision-Based Deployment

```
Revision v1 ← 100% traffic
Deploy → Revision v2 ← 0% traffic (test)
Traffic split → v1: 80%, v2: 20% (canary)
Promote → v2: 100%, v1: deactivated
```

### Container Apps Jobs (for Batch)

| Feature            | Description                      |
| ------------------ | -------------------------------- |
| **Manual trigger** | Via API, CLI, or DevOps pipeline |
| **Schedule**       | Cron-based execution             |
| **Event-driven**   | Queue messages, events           |
| **Timeout**        | Configurable per job             |
| **Retry**          | Configurable retry policy        |

---

## Anti-Patterns

| ❌ Don't                                 | ✅ Do                              |
| ---------------------------------------- | ---------------------------------- |
| Deploy directly to production slot       | Deploy to staging, swap            |
| Use same connection strings in all slots | Use slot-sticky settings           |
| Skip health checks after swap            | Verify health endpoint post-swap   |
| Block agent for long async jobs          | Submit-and-detach pattern          |
| Hardcode env-specific config             | Use App Configuration or Key Vault |

---

## Decision Checklist

- [ ] **Deployment target identified?** (App Service, Container Apps, AKS)
- [ ] **Slot/revision strategy defined?**
- [ ] **Pipeline stages configured?** (build → staging → prod)
- [ ] **Health checks configured?**
- [ ] **Rollback plan ready?** (swap back, revert revision)
- [ ] **Secrets in Key Vault?** (not in pipeline variables)
- [ ] **Monitoring configured?** (Application Insights)

---

> **Remember:** The fastest rollback is swapping back to the previous slot. Always keep it warm.
