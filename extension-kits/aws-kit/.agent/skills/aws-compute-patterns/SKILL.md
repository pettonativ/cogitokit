---
name: aws-compute-patterns
description: AWS compute patterns for batch/async workloads. AWS Batch, Fargate, SageMaker Processing, EC2. Pricing models, job definitions, IAM, networking. Use when designing or implementing compute infrastructure on AWS.
allowed-tools: Read, Glob, Grep, Bash
---

# AWS Compute Patterns

> "Choose the right compute for the workload. Understand the cost before you deploy."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                      | Description                           | When to Read                      |
| ------------------------- | ------------------------------------- | --------------------------------- |
| `batch-fargate.md`        | AWS Batch + Fargate patterns          | Default choice for async jobs     |
| `batch-ec2.md`            | AWS Batch with EC2 compute            | Need GPU or custom AMI            |
| `sagemaker-processing.md` | SageMaker Processing Jobs             | ML-specific workloads             |
| `ec2-dedicated.md`        | Standalone EC2 workers                | Maximum control needed            |
| `spot-strategies.md`      | Spot instances, interruption handling | Cost optimization (interruptible) |
| `pricing-calculator.md`   | Cost formulas and comparison          | Budget planning                   |
| `iam-networking.md`       | Security, IAM roles, VPC config       | Security review                   |

---

## 🔗 Related Skills

| Skill                             | Use For                                 |
| --------------------------------- | --------------------------------------- |
| `@[skills/mlops-evaluation]`      | What to run on the compute (eval logic) |
| `@[skills/architecture]`          | ADR for compute selection               |
| `@[skills/deployment-procedures]` | Safe deployment of infra changes        |
| `@[skills/cost-management]`       | Budget tracking and forecasting         |

---

## Core Principle: Compute Selection

### Decision Tree

```
What's your workload?
│
├── Batch / Async job (no user waiting)
│   ├── Interruptible? → Spot Instances (cheapest)
│   ├── Must complete? Duration?
│   │   ├── < 15 min → Lambda (if < 15 min & < 10 GB RAM)
│   │   ├── 15 min – 24h → AWS Batch + Fargate (recommended)
│   │   └── > 24h → AWS Batch + EC2 On-Demand
│   └── ML-specific? → SageMaker Processing
│
├── Always-on service
│   ├── Predictable load → ECS/EKS + Fargate
│   └── Variable load → ECS + Fargate Spot + On-Demand mix
│
└── Need GPU?
    ├── Training → SageMaker Training Jobs
    └── Inference → SageMaker Endpoints or EC2 GPU
```

---

## AWS Batch (Recommended for Async Jobs)

### Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────────┐
│ Job Submitter│────▶│  Job Queue   │────▶│ Compute Env     │
│ (CLI/SDK/CI) │     │ (priority,   │     │ (Fargate or EC2)│
└─────────────┘     │  scheduling) │     └────────┬────────┘
                    └──────────────┘              │
                                                  ▼
                                         ┌────────────────┐
                                         │ Container Task  │
                                         │ (your code)     │
                                         └────────────────┘
```

### Key Concepts

| Concept                 | Description                                              |
| ----------------------- | -------------------------------------------------------- |
| **Job Definition**      | Template: container image, vCPU, memory, env vars, retry |
| **Job Queue**           | Priority-ordered queue, maps to compute environments     |
| **Compute Environment** | Fargate (managed) or EC2 (control)                       |
| **Array Job**           | Fan-out: run N copies with different parameters          |
| **Job Dependencies**    | Chain jobs: A must finish before B starts                |

### Batch + Fargate (Default Choice)

**Pros:**

- No EC2 management, no AMI patching
- Pay per-second of actual usage
- Elastic — scales to zero when idle
- Integrated with CloudWatch, EventBridge

**Cons:**

- Max 16 vCPU / 120 GB RAM per task
- No GPU support on Fargate
- Ephemeral storage max 200 GB

### Batch + EC2 On-Demand

**Pros:**

- Any instance type (including GPU)
- Custom AMI support
- Larger resource limits
- EBS volume mounting

**Cons:**

- Manages EC2 fleet (launch templates, scaling)
- Potential for over-provisioning
- More IAM complexity

### Pricing (AWS Batch)

> **AWS Batch itself is FREE.** You pay only for underlying compute.

#### Fargate Pricing (Linux/x86, us-east-1)

| Resource        | Price per second | Price per hour |
| --------------- | ---------------- | -------------- |
| vCPU            | $0.000011244     | ~$0.04048      |
| Memory (per GB) | $0.000001235     | ~$0.00445      |

**Common configurations:**

| Config          | $/hour  | 3h run | 20 runs/month |
| --------------- | ------- | ------ | ------------- |
| 2 vCPU / 8 GB   | ~$0.117 | ~$0.35 | ~$7.00        |
| 4 vCPU / 16 GB  | ~$0.233 | ~$0.70 | ~$13.98       |
| 8 vCPU / 32 GB  | ~$0.466 | ~$1.40 | ~$27.96       |
| 16 vCPU / 64 GB | ~$0.932 | ~$2.80 | ~$55.92       |

#### EC2 On-Demand (selected instances, us-east-1)

| Instance   | vCPU | RAM   | $/hour | 3h run | 20 runs/month |
| ---------- | ---- | ----- | ------ | ------ | ------------- |
| m5.large   | 2    | 8 GB  | $0.096 | $0.29  | $5.76         |
| m5.xlarge  | 4    | 16 GB | $0.192 | $0.58  | $11.52        |
| m5.2xlarge | 8    | 32 GB | $0.384 | $1.15  | $23.04        |
| c5.2xlarge | 8    | 16 GB | $0.340 | $1.02  | $20.40        |

---

## SageMaker Processing Jobs

### When to Use

- ML-specific workloads with SageMaker ecosystem
- Need managed input/output S3 channels
- Want built-in experiment tracking

### Architecture

```
┌────────────┐     ┌──────────────────┐     ┌────────────┐
│ SDK/Pipeline│────▶│ Processing Job   │────▶│ S3 Output  │
│ trigger     │     │ (managed container│     │ (results)  │
└────────────┘     │  on ml.* instance)│     └────────────┘
                    └──────────────────┘
```

### Pricing (selected instances, us-east-1)

| Instance      | vCPU | RAM   | $/hour | 3h run | 20 runs/month |
| ------------- | ---- | ----- | ------ | ------ | ------------- |
| ml.m5.large   | 2    | 8 GB  | $0.115 | $0.35  | $6.90         |
| ml.m5.xlarge  | 4    | 16 GB | $0.23  | $0.69  | $13.80        |
| ml.m5.2xlarge | 8    | 32 GB | $0.46  | $1.38  | $27.60        |

> SageMaker has a ~20% premium over EC2 for managed experience.

---

## Spot Instances

### When Appropriate

| ✅ Use Spot                 | ❌ Avoid Spot                            |
| --------------------------- | ---------------------------------------- |
| Interruptible workloads     | Must-complete jobs without checkpointing |
| Training with checkpoints   | Real-time serving                        |
| Batch processing with retry | Jobs with expensive startup              |
| Dev/test environments       | Regulated workloads                      |

### Interruption Handling

- **2-minute warning** via instance metadata
- Must implement checkpoint/restart logic
- Typical savings: **60-90%** vs On-Demand

---

## IAM & Networking Principles

### Minimum IAM for Batch

| Role                    | Purpose                                    |
| ----------------------- | ------------------------------------------ |
| **Batch Service Role**  | Allows Batch to manage compute             |
| **Task Execution Role** | Pulls container images, writes logs        |
| **Task Role**           | Your code's permissions (S3, MLflow, etc.) |

### Networking Decisions

| Requirement                 | Configuration                      |
| --------------------------- | ---------------------------------- |
| Public internet (API calls) | Public subnet + IGW or NAT Gateway |
| Private only                | Private subnet + VPC endpoints     |
| Access MLflow on EC2        | Same VPC or VPC peering            |
| Access Azure DevOps API     | NAT Gateway for outbound           |

### Security Checklist

- [ ] Task Role follows least-privilege
- [ ] Secrets in Secrets Manager (not env vars)
- [ ] Container image from private ECR
- [ ] VPC flow logs enabled
- [ ] CloudWatch log group with retention policy
- [ ] No SSH access to compute (use SSM if needed)

---

## Cross-Cloud Pattern: Azure DevOps → AWS

### Submit-and-Detach Architecture

```
┌──────────────┐                          ┌──────────────┐
│ Azure DevOps │  1. Submit job via SDK   │  AWS Batch   │
│ Pipeline     │─────────────────────────▶│  Job Queue   │
│              │  (boto3 / AWS CLI)        │              │
│              │                           └──────┬───────┘
│              │                                  │ 2. Execute
│  3. Poll or  │◀─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│
│  callback    │   (EventBridge → webhook)        ▼
│              │                           ┌──────────────┐
│  4. Report   │                           │ Eval Worker  │
│  status      │                           │ (container)  │
└──────────────┘                           └──────────────┘
```

### Implementation Options

| Method                                      | Complexity | Latency |
| ------------------------------------------- | ---------- | ------- |
| **Polling** (Azure task polls Batch status) | Low        | Minutes |
| **EventBridge → SNS → webhook**             | Medium     | Seconds |
| **Step Functions orchestration**            | High       | Seconds |

---

## Comparison Matrix

| Criterion                 | Batch+Fargate | Batch+EC2        | SageMaker          | EC2 Dedicated |
| ------------------------- | ------------- | ---------------- | ------------------ | ------------- |
| **Setup effort**          | Low           | Medium           | Medium             | High          |
| **Ops overhead**          | Low           | Medium           | Low                | High          |
| **Max resources**         | 16vCPU/120GB  | Unlimited        | Instance-dependent | Unlimited     |
| **GPU support**           | ❌            | ✅               | ✅                 | ✅            |
| **Cost (4vCPU/16GB, 3h)** | ~$0.70        | ~$0.58           | ~$0.69             | ~$0.58+       |
| **Scale to zero**         | ✅            | ✅ (with ASG)    | ✅                 | ❌            |
| **Retry/queue**           | ✅ native     | ✅ native        | ❌ manual          | ❌ manual     |
| **Best for**              | Default pick  | GPU/custom needs | ML ecosystem       | Max control   |

---

## Decision Checklist

Before choosing compute:

- [ ] **Workload duration estimated?**
- [ ] **Resource profile defined?** (vCPU, RAM, GPU, disk)
- [ ] **Interruptible or must-complete?**
- [ ] **Cost budget per run calculated?**
- [ ] **Network access requirements listed?** (APIs, DBs, MLflow)
- [ ] **IAM roles scoped to least-privilege?**
- [ ] **Monitoring and alerting configured?**
- [ ] **Cross-cloud integration pattern selected?** (if applicable)

---

> **Remember:** Start with Fargate. Move to EC2 only when Fargate limits are hit. SageMaker only if you're already in the ecosystem.
