---
trigger: model_decision
description: "Skills registry for the aws-kit. Load when user request involves AWS services like EC2, S3, Lambda, Fargate, SageMaker, IAM, VPC, or CloudFormation."
---

# AGENTS.md — AWS Kit

> Extension kit skills for Amazon Web Services. No dedicated agents — provides skills used by `devops-engineer` or other agents.

## Skills Available

When `aws-kit` is present in the workspace, these skills are auto-discovered:
- AWS deployment patterns (EC2, ECS, Fargate, Lambda)
- S3 storage patterns
- IAM and security best practices
- CloudFormation / CDK templates
- SageMaker ML workflows

## Routing Protocol

1. Detect AWS keywords → Check if `aws-*` skills exist in session context
2. If found → Load and apply alongside `devops-engineer` or relevant agent
3. If NOT found → General cloud knowledge + inform user the kit is missing
