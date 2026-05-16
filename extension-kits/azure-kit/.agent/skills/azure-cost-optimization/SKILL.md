---
name: azure-cost-optimization
description: Azure cost optimization patterns. Reserved instances, right-sizing, cost analysis, budgets, Azure Advisor recommendations. Use when optimizing Azure spend or planning budgets.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure Cost Optimization

> "Every dollar saved on infrastructure is a dollar invested in product."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                  | Description                          | When to Read               |
| --------------------- | ------------------------------------ | -------------------------- |
| `right-sizing.md`     | VM/service right-sizing analysis     | Reducing over-provisioning |
| `reservations.md`     | Reserved instances, savings plans    | Committing for discounts   |
| `budgets-alerts.md`   | Budget setup, cost alerts            | Cost governance            |
| `advisor.md`          | Azure Advisor cost recommendations   | Quick wins                 |
| `tagging-strategy.md` | Resource tagging for cost allocation | Cost attribution           |

---

## Cost Optimization Framework

### The 5 Pillars

```
1. VISIBILITY    → Know what you're spending (Cost Analysis, tags)
2. RIGHT-SIZE    → Match resources to actual usage
3. COMMITMENT    → Reservations/Savings Plans for predictable workloads
4. ELIMINATION   → Remove unused resources
5. ARCHITECTURE  → Design for cost efficiency
```

---

## Visibility: Cost Analysis

### Essential Views

| View                  | Purpose                                  |
| --------------------- | ---------------------------------------- |
| **By Resource Group** | Team/project cost attribution            |
| **By Service**        | Which services cost most                 |
| **By Tag**            | Environment (dev/staging/prod) breakdown |
| **By Meter**          | Granular usage breakdown                 |
| **Forecast**          | Projected spend at current rate          |

### Tagging Strategy (Mandatory)

| Tag             | Example            | Purpose                |
| --------------- | ------------------ | ---------------------- |
| `environment`   | dev, staging, prod | Environment cost split |
| `project`       | alpigpt, analytics | Project attribution    |
| `team`          | platform, data     | Team charge-back       |
| `cost-center`   | CC-1234            | Finance allocation     |
| `auto-shutdown` | true               | Automation trigger     |

---

## Right-Sizing

### When to Right-Size

| Signal             | Action                          |
| ------------------ | ------------------------------- |
| Average CPU < 20%  | Downsize VM/App Service plan    |
| Memory < 30% used  | Reduce memory allocation        |
| DTU < 20% average  | Downsize SQL Database tier      |
| Storage IOPS < 50% | Switch to Standard from Premium |

### App Service Plan Optimization

| Plan             | Use When                    |
| ---------------- | --------------------------- |
| **Free/Shared**  | Dev/test only               |
| **Basic B1**     | Low-traffic staging         |
| **Standard S1**  | Production (slots, scale)   |
| **Premium P1v3** | High perf, VNet integration |

### Azure DevOps Agent Pool Optimization

| Pattern                               | Cost Impact                         |
| ------------------------------------- | ----------------------------------- |
| **Self-hosted on dedicated VM**       | Fixed cost, potentially wasted      |
| **Self-hosted on scale-set**          | Auto-scale, pay for usage           |
| **Microsoft-hosted**                  | Pay per minute, no maintenance      |
| **Async offload to external compute** | Free agent faster, reduce pool need |

---

## Commitment Discounts

### Azure Reservations

| Service          | Discount (1yr) | Discount (3yr) |
| ---------------- | -------------- | -------------- |
| **VMs**          | ~30-40%        | ~55-65%        |
| **SQL Database** | ~30%           | ~50%           |
| **Cosmos DB**    | ~20-30%        | ~40%           |
| **App Service**  | ~30%           | ~50%           |

### Azure Savings Plans

| Type                     | Scope               | Flexibility                     |
| ------------------------ | ------------------- | ------------------------------- |
| **Compute Savings Plan** | All compute         | High (VMs, AKS, Container Apps) |
| **Reservation**          | Specific SKU/region | Low (locked to config)          |

### Decision: Reservation vs Savings Plan

```
Workload predictable + same SKU for 1-3 years?
├── Yes → Reservation (higher discount)
└── No → Savings Plan (more flexible)
```

---

## Elimination: Unused Resources

### Common Waste Sources

| Resource                    | How to Detect          | Savings            |
| --------------------------- | ---------------------- | ------------------ |
| **Unattached disks**        | Advisor recommendation | $5-100/month each  |
| **Idle VMs**                | CPU < 5% for 14 days   | $50-500/month each |
| **Old snapshots**           | > 90 days old          | Variable           |
| **Unused Public IPs**       | Not associated         | ~$4/month each     |
| **Dev/test left running**   | No auto-shutdown tag   | Significant        |
| **Oversized Log Analytics** | Retention > needed     | $2.76/GB/month     |

### Auto-Shutdown Pattern

```bash
# Apply auto-shutdown to dev/test VMs
az vm auto-shutdown -g $RG -n $VM --time 1900 --timezone "Romance Standard Time"
```

---

## Architecture Decisions for Cost

### Compute Right-Sizing for Eval Workloads

| Scenario                   | Recommendation                       | Why                               |
| -------------------------- | ------------------------------------ | --------------------------------- |
| Eval 3h/run, 20 runs/month | Container Apps Job or external (AWS) | 60h/month compute, don't pay 24/7 |
| Always-on API              | App Service Standard                 | Stable, predictable               |
| Burst traffic              | Container Apps                       | Scale to zero                     |
| Batch processing           | ACI or Container Apps Jobs           | Pay per execution                 |

### Cost of Blocking CI/CD Agent

```
Agent pool VM (e.g., D4s_v3): ~$140/month (always on)

If eval blocks agent 3h × 20 runs = 60h/month of blocked capacity
→ Other pipelines queue or need MORE agents
→ Potential cost: +$140/month per extra agent

Async offload to Fargate: ~$14/month for same 60h
→ Net saving: $126+/month + faster CI/CD
```

---

## Budgets & Alerts

### Budget Configuration

| Level              | Scope            | Alert Thresholds    |
| ------------------ | ---------------- | ------------------- |
| **Subscription**   | Overall spend    | 50%, 75%, 90%, 100% |
| **Resource Group** | Project/team     | 80%, 100%, 120%     |
| **Service**        | Specific service | 100%, 150%          |

---

## Anti-Patterns

| ❌ Don't                                | ✅ Do                             |
| --------------------------------------- | --------------------------------- |
| Leave dev VMs running 24/7              | Auto-shutdown or scale to zero    |
| Buy reservations without usage analysis | Analyze 30+ days of usage first   |
| Ignore Azure Advisor                    | Review weekly                     |
| No tags on resources                    | Enforce tagging policy            |
| Premium tier "just in case"             | Start Standard, upgrade if needed |

---

## Decision Checklist

- [ ] **Cost Analysis reviewed this month?**
- [ ] **Tags applied to all resources?**
- [ ] **Azure Advisor checked for recommendations?**
- [ ] **Right-sizing analysis done?** (CPU/memory utilization)
- [ ] **Unused resources identified and removed?**
- [ ] **Budget alerts configured?**
- [ ] **Reservation/Savings Plan evaluated?**
- [ ] **Dev/test auto-shutdown enabled?**

---

> **Remember:** Cost optimization is continuous, not one-time. Review monthly, act on quick wins immediately.
