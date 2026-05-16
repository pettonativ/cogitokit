# Azure Kit

> Cloud-specific AI agent skills for Azure infrastructure design and operations.

## Overview

**Azure Kit** is a companion module for [cogitokit](https://github.com/pettonativ/cogitokit) that adds Azure-specific skills to the agent framework. It provides expert-level guidance on compute selection, cost optimization, deployment strategies, diagnostics, and observability.

When combined with cogitokit, agents like `@backend-specialist`, `@devops-engineer`, and `@project-planner` gain deep Azure domain knowledge — automatically applied when the context involves Azure infrastructure.

---

## Skills

### 1. `azure-compute`

> Azure compute service selection and patterns. VMs, App Service, Container Apps, AKS, Functions, ACI.

#### Compute Decision Tree

```
What's your workload?
│
├── Web App / API
│   ├── Code-based               → App Service
│   ├── Container                → Container Apps
│   └── Complex microservices    → AKS
│
├── Background Job / Batch
│   ├── Short (< 10 min)         → Azure Functions
│   ├── Medium (10 min - 24h)    → Container Apps Jobs
│   └── Long / heavy             → ACI or VM
│
├── Event-driven
│   ├── Simple trigger            → Azure Functions
│   └── Container + scaling       → Container Apps (KEDA)
│
└── Always-on service
    ├── Predictable               → App Service / VM
    └── Variable                  → Container Apps (auto-scale)
```

#### Service Comparison

| Feature           | App Service | Container Apps | AKS      | Functions        | ACI      | VMs       |
| ----------------- | ----------- | -------------- | -------- | ---------------- | -------- | --------- |
| **Scale to zero** | ❌          | ✅             | ❌       | ✅ (consumption) | N/A      | ❌        |
| **Auto-scale**    | ✅ (rules)  | ✅ (KEDA)      | ✅ (HPA) | ✅ (auto)        | ❌       | ✅ (VMSS) |
| **GPU**           | ❌          | ✅ (preview)   | ✅       | ❌               | ✅       | ✅        |
| **Ops overhead**  | Low         | Low            | High     | Very Low         | Very Low | High      |

**Also covers:** VM series guide (B/D/E/F/N/L), Container Apps job types, ACI pricing.

---

### 2. `azure-cost-optimization`

> Reserved instances, right-sizing, cost analysis, budgets, Azure Advisor recommendations.

#### The 5 Pillars

| Pillar           | Description                                       |
| ---------------- | ------------------------------------------------- |
| **Visibility**   | Know what you're spending (Cost Analysis, tags)   |
| **Right-Size**   | Match resources to actual usage                   |
| **Commitment**   | Reservations / Savings Plans for predictable work |
| **Elimination**  | Remove unused resources                           |
| **Architecture** | Design for cost efficiency                        |

**Also covers:** Tagging strategy, App Service plan optimization, reservation vs savings plan decision, Azure DevOps agent pool optimization, auto-shutdown patterns, common waste sources.

---

### 3. `azure-deploy`

> Azure deployment patterns with CI/CD. App Service, Container Apps, AKS, Functions.

#### Deployment Strategies

| Strategy               | Service        | Pattern                           |
| ---------------------- | -------------- | --------------------------------- |
| **Blue-Green (Slots)** | App Service    | Deploy to staging → verify → swap |
| **Canary (Revisions)** | Container Apps | Traffic split across revisions    |
| **Rolling Updates**    | AKS            | Helm, rolling updates, rollback   |
| **Submit-and-Detach**  | Any (async)    | Submit long job, free CI/CD agent |

**Also covers:** Azure DevOps pipeline patterns, slot settings (sticky vs swapped), status reporting via Azure DevOps API, Container Apps Jobs configuration.

---

### 4. `azure-diagnostics`

> Azure troubleshooting. App Service diagnostics, Container Apps logs, AKS debugging, pipeline failures.

#### Diagnostic Decision Tree

```
What's the symptom?
│
├── Service unreachable (5xx)    → Health endpoint → App diagnostics → NSG/VNet
├── Slow performance             → App Insights → CPU/Memory → DB DTU → Network
├── Pipeline failure             → Build logs → Agent status → Service connections
└── Job didn't complete          → Exit code → Log Analytics → Retry policy
```

**Also covers:** Common issues & solutions per service (App Service, Container Apps, Azure DevOps), log collection methods (`az webapp log tail`, `kubectl logs`, KQL queries), 4-step debug cycle methodology.

---

### 5. `azure-observability`

> Application Insights, Azure Monitor, Log Analytics, distributed tracing, alerting.

#### The Three Pillars on Azure

| Pillar      | Azure Service         | Purpose                                      |
| ----------- | --------------------- | -------------------------------------------- |
| **Metrics** | Azure Monitor Metrics | Numeric time-series (CPU, requests, latency) |
| **Logs**    | Log Analytics (KQL)   | Structured log storage and querying          |
| **Traces**  | Application Insights  | Distributed tracing across services          |

**Also covers:** Instrumentation patterns (.NET, Python, Node.js, Java), custom telemetry with OpenTelemetry, KQL essential queries, cross-cloud tracing (Azure ↔ AWS), alert severity levels, action groups, Azure Workbooks vs Dashboards.

---

## Installation

Copy the skills into your project's `.agent/skills/` directory:

```bash
git clone https://github.com/pettonativ/azure-kit.git
cp -r azure-kit/.agent/skills/* /path/to/your/project/.agent/skills/
```

Or add as a git submodule:

```bash
git submodule add https://github.com/pettonativ/azure-kit.git .kits/azure-kit
for skill in azure-kit/.agent/skills/*/; do
  ln -s "$(pwd)/$skill" ".agent/skills/$(basename $skill)"
done
```

---

## Related Skills

These skills from [cogitokit](https://github.com/pettonativ/cogitokit) work well alongside azure-kit:

| Skill                   | Use For                           |
| ----------------------- | --------------------------------- |
| `mlops-evaluation`      | Evaluation pipeline design        |
| `architecture`          | ADR for service selection         |
| `deployment-procedures` | Safe deployment principles        |
| `cost-management`       | Budget tracking and forecasting   |
| `server-management`     | Process management and monitoring |

---

## Project Structure

```
.agent/
└── skills/
    ├── azure-compute/
    │   └── SKILL.md
    ├── azure-cost-optimization/
    │   └── SKILL.md
    ├── azure-deploy/
    │   └── SKILL.md
    ├── azure-diagnostics/
    │   └── SKILL.md
    └── azure-observability/
        └── SKILL.md
```

---

## Author

**Vittorio Pettonati** ([@pettonativ](https://github.com/pettonativ))

## License

MIT
