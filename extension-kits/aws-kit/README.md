# AWS Kit

> Cloud-specific AI agent skills for AWS infrastructure design and operations.

## Overview

**AWS Kit** is a companion module for [cogitokit](https://github.com/pettonativ/cogitokit) that adds AWS-specific skills to the agent framework. It provides expert-level guidance on compute service selection, pricing analysis, IAM patterns, and cross-cloud architectures.

When combined with cogitokit, agents like `@backend-specialist`, `@devops-engineer`, and `@project-planner` gain deep AWS domain knowledge — automatically applied when the context involves AWS infrastructure.

---

## Skills

### `aws-compute-patterns`

> AWS compute patterns for batch and async workloads. AWS Batch, Fargate, SageMaker Processing, EC2.

#### Compute Decision Tree

```
What's your workload?
│
├── Batch / Async job (no user waiting)
│   ├── Interruptible?         → Spot Instances (cheapest)
│   ├── < 15 min?              → Lambda
│   ├── 15 min – 24h?          → AWS Batch + Fargate ★ recommended
│   └── > 24h or GPU?          → AWS Batch + EC2 On-Demand
│
├── ML-specific?
│   └── SageMaker Processing Jobs
│
└── Always-on service?
    ├── Predictable load        → ECS/EKS + Fargate
    └── Variable load           → ECS + Fargate Spot + On-Demand mix
```

#### Coverage Matrix

| Topic                    | Description                                                           |
| ------------------------ | --------------------------------------------------------------------- |
| **AWS Batch + Fargate**  | Managed serverless containers, pay-per-second, up to 16 vCPU / 120 GB |
| **AWS Batch + EC2**      | Custom AMI, GPU support, unlimited resources                          |
| **SageMaker Processing** | ML-specific with managed S3 I/O and experiment tracking               |
| **Spot Instances**       | 60-90% savings for interruptible workloads                            |
| **IAM & Networking**     | Least-privilege roles, VPC design, security checklist                 |
| **Pricing Calculator**   | Fargate vs EC2 vs SageMaker cost comparison tables                    |
| **Cross-Cloud Patterns** | Azure DevOps → AWS Batch submit-and-detach architecture               |

#### Service Comparison

| Criterion                 | Batch+Fargate | Batch+EC2     | SageMaker    | EC2 Dedicated |
| ------------------------- | ------------- | ------------- | ------------ | ------------- |
| **Setup effort**          | Low           | Medium        | Medium       | High          |
| **Ops overhead**          | Low           | Medium        | Low          | High          |
| **GPU support**           | ❌            | ✅            | ✅           | ✅            |
| **Cost (4vCPU/16GB, 3h)** | ~$0.70        | ~$0.58        | ~$0.69       | ~$0.58+       |
| **Scale to zero**         | ✅            | ✅ (with ASG) | ✅           | ❌            |
| **Best for**              | Default pick  | GPU/custom    | ML ecosystem | Max control   |

---

## Installation

Copy the skills into your project's `.agent/skills/` directory:

```bash
git clone https://github.com/pettonativ/aws-kit.git
cp -r aws-kit/.agent/skills/* /path/to/your/project/.agent/skills/
```

Or add as a git submodule:

```bash
git submodule add https://github.com/pettonativ/aws-kit.git .kits/aws-kit
ln -s .kits/aws-kit/.agent/skills/aws-compute-patterns .agent/skills/aws-compute-patterns
```

---

## Related Skills

These skills from [cogitokit](https://github.com/pettonativ/cogitokit) work well alongside aws-kit:

| Skill                   | Use For                                 |
| ----------------------- | --------------------------------------- |
| `mlops-evaluation`      | What to run on the compute (eval logic) |
| `architecture`          | ADR for compute selection               |
| `deployment-procedures` | Safe deployment of infra changes        |
| `cost-management`       | Budget tracking and forecasting         |

---

## Project Structure

```
.agent/
└── skills/
    └── aws-compute-patterns/
        └── SKILL.md    # Complete AWS compute knowledge base
```

---

## Author

**Vittorio Pettonati** ([@pettonativ](https://github.com/pettonativ))

## License

MIT
