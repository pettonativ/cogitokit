---
name: azure-compute
description: Azure compute service selection and patterns. Virtual Machines, App Service, Container Apps, AKS, Functions, ACI. Use when choosing or configuring compute on Azure.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure Compute Patterns

> "Right compute for the right workload. Not everything needs a VM."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                   | Description                          | When to Read            |
| ---------------------- | ------------------------------------ | ----------------------- |
| `service-selection.md` | Decision tree for compute choice     | Starting a new workload |
| `vms.md`               | VM series, sizing, availability sets | IaaS workloads          |
| `container-apps.md`    | Container Apps, KEDA, scaling        | Container workloads     |
| `aks.md`               | AKS cluster design, node pools       | Kubernetes              |
| `functions.md`         | Functions plans, triggers, limits    | Serverless              |
| `batch-aci.md`         | Batch/async/job workloads            | Background processing   |

---

## Compute Decision Tree

```
What's your workload?
│
├── Web App / API
│   ├── Code-based → App Service
│   ├── Container → Container Apps
│   └── Complex microservices → AKS
│
├── Background Job / Batch
│   ├── Short (< 10 min) → Azure Functions
│   ├── Medium (10 min - 24h) → Container Apps Jobs
│   ├── Long / heavy compute → ACI or VM
│   └── ML-specific → Azure ML Compute
│
├── Event-driven
│   ├── Simple trigger → Azure Functions
│   └── Container + scaling → Container Apps (KEDA)
│
└── Always-on service
    ├── Predictable → App Service / VM
    └── Variable → Container Apps (auto-scale)
```

## Service Comparison

| Feature           | App Service    | Container Apps | AKS        | Functions        | ACI       | VMs       |
| ----------------- | -------------- | -------------- | ---------- | ---------------- | --------- | --------- |
| **Deploy unit**   | Code/container | Container      | Container  | Code             | Container | Anything  |
| **Scale to zero** | ❌             | ✅             | ❌         | ✅ (consumption) | N/A       | ❌        |
| **Auto-scale**    | ✅ (rules)     | ✅ (KEDA)      | ✅ (HPA)   | ✅ (auto)        | ❌        | ✅ (VMSS) |
| **GPU**           | ❌             | ✅ (preview)   | ✅         | ❌               | ✅        | ✅        |
| **Max timeout**   | ∞              | ∞              | ∞          | 10 min / ∞       | ∞         | ∞         |
| **VNet**          | ✅             | ✅             | ✅         | ✅ (premium)     | ✅        | ✅        |
| **Cost model**    | Plan-based     | Per-use        | Node-based | Per-execution    | Per-use   | Per-hour  |
| **Ops overhead**  | Low            | Low            | High       | Very Low         | Very Low  | High      |

---

## VM Series Guide

| Series | Optimized For   | Use Case                         |
| ------ | --------------- | -------------------------------- |
| **B**  | Burstable       | Dev/test, low-traffic            |
| **D**  | General purpose | Most workloads                   |
| **E**  | Memory          | In-memory caching, databases     |
| **F**  | Compute         | CPU-intensive processing         |
| **N**  | GPU             | ML training/inference, rendering |
| **L**  | Storage         | Big data, data warehousing       |

### Naming Convention

```
Standard_D4s_v5
         │││ │
         │││ └── Version (v5 = latest gen, most efficient)
         ││└──── s = Premium SSD capable
         │└───── 4 = vCPUs
         └────── D = Series (General Purpose)
```

---

## Container Apps for Jobs

### Job Types

| Type             | Trigger              | Use Case               |
| ---------------- | -------------------- | ---------------------- |
| **Manual**       | API call, CLI        | CI/CD triggered eval   |
| **Scheduled**    | Cron expression      | Daily batch processing |
| **Event-driven** | Queue message, event | Reactive processing    |

### Key Configuration

| Setting             | Description            | Recommendation                  |
| ------------------- | ---------------------- | ------------------------------- |
| `replicaTimeout`    | Max time per execution | Set to 1.5x expected duration   |
| `replicaRetryLimit` | Number of retries      | 2 for eval jobs                 |
| `parallelism`       | Concurrent replicas    | 1 for sequential, N for fan-out |
| `resources.cpu`     | CPU cores              | Start with 2, observe           |
| `resources.memory`  | Memory                 | Start with 4Gi, observe         |

---

## Azure Container Instances (ACI)

### When to Use ACI

| ✅ Use ACI                       | ❌ Avoid ACI                          |
| -------------------------------- | ------------------------------------- |
| Simple, single-container jobs    | Complex multi-container orchestration |
| Quick spin-up needed             | Long-running services                 |
| No orchestration overhead wanted | Need auto-scaling                     |
| CI/CD triggered batch tasks      | High-availability requirements        |

### Pricing (per-second billing)

| Resource        | Per-second Price |
| --------------- | ---------------- |
| vCPU            | ~$0.0000130      |
| Memory (per GB) | ~$0.0000014      |

---

## Anti-Patterns

| ❌ Don't                            | ✅ Do                           |
| ----------------------------------- | ------------------------------- |
| Use AKS for a single service        | Use Container Apps              |
| Use VMs for serverless workloads    | Use Functions or Container Apps |
| Over-provision "just in case"       | Right-size based on metrics     |
| Ignore latest VM generations        | v5 series = better price/perf   |
| Run batch jobs on always-on compute | Use jobs/ACI (scale to zero)    |

---

## Decision Checklist

- [ ] **Workload type identified?** (web, batch, event-driven)
- [ ] **Duration and resource needs estimated?**
- [ ] **Scale-to-zero required?**
- [ ] **VNet integration needed?**
- [ ] **GPU required?**
- [ ] **Cost model matches usage pattern?**
- [ ] **Availability requirements defined?**

---

> **Remember:** Start with the simplest compute that meets your requirements. You can always move up.
