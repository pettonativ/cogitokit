---
name: azure-diagnostics
description: Azure diagnostics and troubleshooting. App Service diagnostics, Container Apps logs, AKS debugging, performance issues. Use when debugging Azure service issues.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure Diagnostics

> "Diagnose systematically. Logs tell stories — learn to read them."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                     | Description                             | When to Read      |
| ------------------------ | --------------------------------------- | ----------------- |
| `app-service-diag.md`    | App Service diagnostics blade, Kudu     | Web app issues    |
| `container-apps-diag.md` | Container Apps log streaming, revisions | Container issues  |
| `aks-diag.md`            | AKS cluster diagnostics, pod debugging  | Kubernetes issues |
| `pipeline-diag.md`       | Azure DevOps pipeline failures          | CI/CD issues      |
| `networking-diag.md`     | NSG, DNS, VNet connectivity             | Network issues    |

---

## Diagnostic Decision Tree

```
What's the symptom?
│
├── Service unreachable (5xx, timeout)
│   ├── Check: Health endpoint → Is app running?
│   ├── Check: App Service diagnostics blade
│   ├── Check: Container crash logs (if Container Apps)
│   └── Check: NSG / VNet rules (if private)
│
├── Slow performance
│   ├── Check: Application Insights → Dependency map
│   ├── Check: CPU / Memory metrics
│   ├── Check: Database DTU / query performance
│   └── Check: Network latency (if cross-region)
│
├── Pipeline failure
│   ├── Check: Build logs → Exact error
│   ├── Check: Agent status → Is agent online?
│   ├── Check: Service connections → Expired token?
│   └── Check: Deployment logs → Slot swap failure?
│
└── Job didn't complete
    ├── Check: Container exit code → OOM? Timeout?
    ├── Check: Log Analytics → Error traces
    └── Check: Retry policy → Were retries exhausted?
```

---

## Common Issues & Solutions

### App Service

| Symptom                 | Likely Cause            | Fix                                   |
| ----------------------- | ----------------------- | ------------------------------------- |
| 503 Service Unavailable | App crashing on startup | Check Application logs in Kudu        |
| Slow cold start         | Large app, no Always On | Enable Always On                      |
| Intermittent 500        | Unhandled exception     | Check Application Insights exceptions |
| Deployment failed       | Slot swap timeout       | Increase swap timeout, check health   |
| High memory             | Memory leak             | Profile with App Insights, restart    |

### Container Apps

| Symptom                    | Likely Cause                            | Fix                            |
| -------------------------- | --------------------------------------- | ------------------------------ |
| Container CrashLoopBackOff | Bad entrypoint, missing env var         | Check system logs              |
| Revision not activating    | Image pull failure                      | Verify ACR credentials         |
| Job timeout                | Insufficient resources                  | Increase CPU/memory or timeout |
| Scale to zero not working  | Min replicas > 0, or active connections | Check scaling rules            |
| Ingress 502                | Container not ready                     | Add health probe               |

### Azure DevOps Pipelines

| Symptom            | Likely Cause                   | Fix                               |
| ------------------ | ------------------------------ | --------------------------------- |
| Agent offline      | VM stopped, agent service down | Restart VM/service                |
| Permission denied  | Service connection expired     | Renew service principal           |
| Build timeout      | Long-running step              | Increase timeout or async offload |
| Artifact not found | Wrong publish path             | Verify artifact path in logs      |
| Flaky tests        | Timing/ordering issues         | Add retries, fix test isolation   |

---

## Log Collection Methods

| Service            | Method         | Command                                    |
| ------------------ | -------------- | ------------------------------------------ |
| **App Service**    | Log stream     | `az webapp log tail -n $APP -g $RG`        |
| **Container Apps** | Console logs   | `az containerapp logs show -n $APP -g $RG` |
| **AKS**            | Pod logs       | `kubectl logs $POD -n $NS`                 |
| **ACI**            | Container logs | `az container logs -n $CONTAINER -g $RG`   |
| **All**            | Log Analytics  | KQL query in portal                        |

### Key KQL Queries for Diagnostics

```kql
// Container app failures (last hour)
ContainerAppConsoleLogs_CL
| where TimeGenerated > ago(1h)
| where Log_s contains "error" or Log_s contains "exception"
| project TimeGenerated, ContainerAppName_s, Log_s

// Pipeline failures
AzureDevOpsAuditing
| where OperationName == "Build.Completed"
| where Data.Result == "failed"
| project TimeGenerated, Data.BuildNumber, Data.DefinitionName

// App Service HTTP errors
AppServiceHTTPLogs
| where ScStatus >= 500
| summarize count() by ScStatus, CsUriStem, bin(TimeGenerated, 5m)
```

---

## Debugging Methodology

### The 4-Step Debug Cycle

1. **Reproduce** — Can you trigger the issue consistently?
2. **Isolate** — Where in the chain does it fail? (app, infra, network, dependency)
3. **Root Cause** — What changed? (deploy, config, traffic pattern)
4. **Verify Fix** — Does the fix resolve it without side effects?

### Investigation Priorities

| Priority | Check First            | Why                             |
| -------- | ---------------------- | ------------------------------- |
| 1        | **Recent deployments** | Most issues follow changes      |
| 2        | **Error logs**         | Direct evidence of failure      |
| 3        | **Resource metrics**   | CPU/memory/disk exhaustion      |
| 4        | **Dependencies**       | External service failures       |
| 5        | **Network**            | Connectivity, DNS, certificates |

---

## Anti-Patterns

| ❌ Don't                          | ✅ Do                                        |
| --------------------------------- | -------------------------------------------- |
| Guess the cause                   | Check logs first                             |
| Change multiple things at once    | One change at a time, verify                 |
| Ignore "it works on my machine"   | Compare environments systematically          |
| Skip the recent changes check     | Always check: what deployed recently?        |
| Restart without understanding why | Restart to restore service, then investigate |

---

## Decision Checklist

- [ ] **Symptom clearly described?**
- [ ] **Recent changes reviewed?** (deploys, config changes)
- [ ] **Logs collected from correct source?**
- [ ] **Metrics checked for anomalies?**
- [ ] **Scope isolated?** (single service, all services, network)
- [ ] **Root cause identified?** (not just symptom)
- [ ] **Fix verified without side effects?**
- [ ] **Post-mortem documented?** (if significant)

---

> **Remember:** The most common cause of production issues is "something changed." Always start there.
