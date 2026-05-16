---
name: azure-devops-pipelines
description: Azure DevOps Pipeline patterns. YAML pipelines, multi-stage CI/CD, templates, variable groups, environments, approvals, artifact publishing. Use when designing or reviewing Azure DevOps pipelines.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure DevOps Pipeline Patterns

> "Pipelines are infrastructure. Version them. Test them. Review them."

## 🎯 Selective Reading Rule

**This is a standalone skill. Read ONLY the sections relevant to the user's request.**

---

## 🔗 Related Skills

| Skill                             | Use For                                               |
| --------------------------------- | ----------------------------------------------------- |
| `@[skills/azure-deploy]`          | Deployment targets (App Service, Container Apps, AKS) |
| `@[skills/azure-compute]`         | Compute selection for pipeline-triggered workloads    |
| `@[skills/deployment-procedures]` | General CI/CD philosophy                              |
| `@[skills/mlops-evaluation]`      | ML evaluation pipeline patterns                       |

---

## 1. Pipeline Architecture

### YAML Pipeline Structure

```yaml
# azure-pipelines.yml (or pipelines/<name>.yml)
trigger: # When to run automatically
pr: # When to run on pull requests
pool: # Agent pool (Microsoft-hosted or self-hosted)
variables: # Pipeline variables (inline or groups)
stages: # Build → Test → Deploy stages
  - stage: Build
    jobs:
      - job: BuildJob
        steps:
          - task: ...
```

### Pipeline Type Selection

```
What do you need?
│
├── Simple build + test
│   └── Single-stage pipeline (jobs only, no stages)
│
├── Build → Deploy (one env)
│   └── Two-stage pipeline (Build + Deploy)
│
├── Build → Staging → Prod
│   └── Multi-stage pipeline with environments
│
├── Reusable across repos
│   └── Template pipelines (extends/templates)
│
└── ML model lifecycle
    └── CI (build) → Eval (test) → Register → CD (deploy)
```

---

## 2. Trigger Patterns

### Trigger Comparison

| Trigger       | Pattern               | When                             |
| ------------- | --------------------- | -------------------------------- |
| **CI**        | `trigger: [main]`     | Push to branch                   |
| **PR**        | `pr: [main]`          | Pull request to branch           |
| **Scheduled** | `schedules: [cron]`   | Recurring (nightly, weekly)      |
| **Manual**    | `trigger: none`       | User-initiated only              |
| **Pipeline**  | `resources.pipelines` | After another pipeline completes |
| **Webhook**   | Service hook          | External event                   |

### Best Practices

```yaml
# CI: Only trigger on relevant paths
trigger:
  branches:
    include: [main, release/*]
  paths:
    include: [src/*, pipelines/*]
    exclude: [docs/*, README.md]

# PR: Validate before merge
pr:
  branches:
    include: [main]
  paths:
    include: [src/*]
```

---

## 3. Variable Management

### Variable Hierarchy (Override Order)

```
Pipeline YAML variables (lowest priority)
    ↓ overridden by
Variable Groups (linked from Library)
    ↓ overridden by
Pipeline-level variables (UI)
    ↓ overridden by
Stage/Job-level variables
    ↓ overridden by
Runtime parameters (highest priority)
```

### Variable vs Parameter vs Secret

| Type                | Defined In          | Use For                 | Encrypted? |
| ------------------- | ------------------- | ----------------------- | ---------- |
| **Variable**        | YAML or UI          | Non-sensitive config    | ❌         |
| **Variable Group**  | Library             | Shared across pipelines | Optional   |
| **Secret Variable** | Library/UI          | Passwords, tokens, keys | ✅         |
| **Key Vault link**  | Variable Group → KV | Enterprise secrets      | ✅         |
| **Parameter**       | YAML `parameters:`  | User input at runtime   | ❌         |

### Pattern: Environment-Specific Variables

```yaml
variables:
  - group: "common-vars" # Shared settings
  - ${{ if eq(variables['Build.SourceBranch'], 'refs/heads/main') }}:
      - group: "prod-vars" # Production settings
  - ${{ else }}:
      - group: "dev-vars" # Dev settings
```

---

## 4. Multi-Stage Pipeline Patterns

### Standard CI/CD Pipeline

```yaml
stages:
  - stage: Build
    displayName: "Build & Test"
    jobs:
      - job: BuildJob
        pool:
          vmImage: "ubuntu-latest"
        steps:
          - task: UsePythonVersion@0
            inputs:
              versionSpec: "3.10"
          - script: pip install -r requirements.txt
          - script: pytest tests/
          - task: Docker@2
            inputs:
              command: buildAndPush
              repository: $(containerRegistry)/$(imageName)
              tags: $(Build.BuildId)

  - stage: DeployStaging
    displayName: "Deploy to Staging"
    dependsOn: Build
    condition: succeeded()
    jobs:
      - deployment: DeployStaging
        environment: "staging"
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureCLI@2
                  inputs:
                    azureSubscription: $(azureServiceConnection)
                    scriptType: bash
                    inlineScript: |
                      az containerapp update \
                        --name $(appName) \
                        --resource-group $(rgName) \
                        --image $(containerRegistry)/$(imageName):$(Build.BuildId)

  - stage: DeployProd
    displayName: "Deploy to Production"
    dependsOn: DeployStaging
    condition: succeeded()
    jobs:
      - deployment: DeployProd
        environment: "production" # Has approval gate
        strategy:
          runOnce:
            deploy:
              steps:
                - template: templates/deploy-steps.yml
                  parameters:
                    envName: "prod"
```

---

## 5. Template Patterns

### Template Types

| Type                 | Use                    | Syntax                            |
| -------------------- | ---------------------- | --------------------------------- |
| **Step template**    | Reusable steps         | `- template: steps.yml`           |
| **Job template**     | Reusable jobs          | `- template: jobs.yml`            |
| **Stage template**   | Reusable stages        | `- template: stages.yml`          |
| **Extends template** | Full pipeline skeleton | `extends: template: pipeline.yml` |

### Step Template Example

```yaml
# templates/python-build-steps.yml
parameters:
  - name: pythonVersion
    type: string
    default: "3.10"

steps:
  - task: UsePythonVersion@0
    inputs:
      versionSpec: ${{ parameters.pythonVersion }}
  - script: pip install -r requirements.txt
    displayName: "Install dependencies"
  - script: pytest tests/ --junitxml=results.xml
    displayName: "Run tests"
  - task: PublishTestResults@2
    inputs:
      testResultsFiles: "results.xml"
```

### Extends Template (Enforced)

```yaml
# templates/base-pipeline.yml (in central repo)
parameters:
  - name: stages
    type: stageList

stages:
  - stage: SecurityScan
    jobs:
      - job: Scan
        steps:
          - script: echo "Mandatory security scan"
  - ${{ each stage in parameters.stages }}:
      - ${{ stage }}

# Consumer pipeline
extends:
  template: templates/base-pipeline.yml@pipeline-templates
  parameters:
    stages:
      - stage: Build
        jobs:
          - job: BuildJob
            steps:
              - script: echo "My build"
```

---

## 6. Environments & Approvals

### Environment Strategy

| Environment    | Purpose                   | Approval    | Auto-deploy? |
| -------------- | ------------------------- | ----------- | ------------ |
| **dev**        | Development testing       | None        | ✅ Yes       |
| **staging**    | Pre-production validation | Optional    | ✅ Yes       |
| **production** | Live traffic              | ✅ Required | ❌ No        |

### Approval Configuration

- Configure approvals in **Azure DevOps → Environments → Approvals and checks**
- Add **branch control** (only from `main`)
- Add **business hours** check (no prod deploys on Friday)
- Add **required reviewers** (at least 1 approval)

---

## 7. ML/AI Pipeline Patterns

### Model CI/CD Pipeline

```yaml
stages:
  - stage: Build
    displayName: "Build & Unit Test"
    jobs:
      - job: Build
        steps:
          - script: pip install -r requirements.txt
          - script: pytest tests/unit/

  - stage: Evaluate
    displayName: "Model Evaluation"
    dependsOn: Build
    jobs:
      - job: Evaluate
        pool:
          vmImage: "ubuntu-latest"
        timeoutInMinutes: 120 # Eval can be long
        steps:
          - script: |
              python mlflow_eval.py \
                --testset testset.csv \
                --model-name $(modelName) \
                --eval-mode full
            displayName: "Run evaluation"
          - task: PublishPipelineArtifact@1
            inputs:
              targetPath: "eval_results/"
              artifact: "eval-results"

  - stage: Register
    displayName: "Register Model"
    dependsOn: Evaluate
    condition: succeeded()
    jobs:
      - job: Register
        steps:
          - script: python register__model.py

  - stage: Deploy
    displayName: "Deploy Model"
    dependsOn: Register
    jobs:
      - deployment: DeployModel
        environment: "model-serving"
        strategy:
          runOnce:
            deploy:
              steps:
                - script: |
                    az containerapp update \
                      --name $(servingApp) \
                      --image $(registry)/model-server:$(Build.BuildId)
```

---

## 8. Anti-Patterns

| ❌ Don't                              | ✅ Do                                         |
| ------------------------------------- | --------------------------------------------- |
| Store secrets in YAML                 | Use Key Vault-linked variable groups          |
| One massive pipeline file             | Split into templates                          |
| Skip environment approvals for prod   | Configure approval gates                      |
| Hardcode image tags                   | Use `$(Build.BuildId)` or semantic versioning |
| Run long eval jobs on hosted agents   | Use self-hosted agents or submit-and-detach   |
| Duplicate pipeline logic across repos | Centralize in a pipeline-templates repo       |
| Ignore path filters on triggers       | Use `paths.include/exclude`                   |

---

## 9. Decision Checklist

Before implementing a pipeline:

- [ ] **Pipeline type selected?** (single-stage, multi-stage, extends)
- [ ] **Trigger strategy defined?** (CI, PR, scheduled, manual)
- [ ] **Variables organized?** (groups, secrets in Key Vault)
- [ ] **Templates used?** (for reusable steps/stages)
- [ ] **Environments configured?** (dev, staging, prod with approvals)
- [ ] **Artifacts published?** (for downstream stages)
- [ ] **Timeouts set?** (especially for eval/test stages)
- [ ] **Path filters active?** (avoid unnecessary runs)
- [ ] **Service connections secured?** (least privilege)
- [ ] **Branch policies configured?** (required checks on PRs)

---

> **Remember:** A pipeline is code that deploys code. Treat it with the same rigor — review it, test it, version it.
