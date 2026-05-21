---
trigger: always_on
---

# AGENTS.md — Agent Registry & Routing Rules

> Single source of truth for all agent definitions, routing logic, boundary enforcement, and kit mapping.
> This file is always loaded alongside `CORE.md`.

---

## 🤖 Agent Registry (Core — cogitokit)

These agents are **always available** regardless of which extension kits are loaded.

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `orchestrator` | Multi-agent coordination | parallel-agents, behavioral-modes, plan-writing | "orchestrate", "coordinate", complex tasks |
| `project-planner` | Discovery, task planning | brainstorming, plan-writing, architecture | "plan", "breakdown", "task", "milestone" |
| `product-manager` | Requirements, user stories | plan-writing, brainstorming | "requirements", "user story", "acceptance criteria", "PRD" |
| `product-owner` | Strategy, backlog, MVP | plan-writing, brainstorming | "backlog", "MVP", "prioritize", "roadmap" |
| `scrum-master` | Sprint ceremonies, Agile | sprint-management, estimation-techniques, metrics-analytics, retrospective | "sprint", "standup", "retro", "velocity", "burndown" |
| `debugger` | Methodical troubleshooting | systematic-debugging | "error", "bug", "crash", "not working", "broken", "fix" |
| `explorer-agent` | Codebase analysis | architecture, plan-writing | "analyze", "explore", "map", "audit" |
| `code-archaeologist` | Legacy code, refactoring | clean-code, code-review-checklist | "legacy", "refactor", "spaghetti", "explain codebase" |
| `documentation-writer` | Manuals, docs | documentation-templates | "README", "docs", "changelog", "document" (explicit request only) |

---

## 🔌 Agent Registry (Extension Kits)

These agents are available **only when their respective kit submodule is present** in `extension-kits/`.

| Kit | Agents | Trigger Keywords |
|-----|--------|-----------------|
| `frontend-kit` | `frontend-specialist` | "component", "react", "vue", "css", "html", "tailwind", "UI", "responsive", "animation" |
| `backend-kit` | `backend-specialist`, `database-architect` | "api", "server", "express", "fastapi", "node", "prisma", "sql", "mongodb", "schema", "migration" |
| `devops-kit` | `devops-engineer`, `release-manager`, `performance-optimizer` | "docker", "kubernetes", "ci/cd", "deploy", "pm2", "nginx", "release", "changelog", "rollout", "slow", "optimize" |
| `security-kit` | `security-auditor`, `penetration-tester` | "auth", "login", "jwt", "password", "security", "vulnerability", "exploit", "OWASP" |
| `qa-kit` | `test-engineer`, `qa-automation-engineer` | "test", "jest", "vitest", "playwright", "cypress", "coverage", "e2e" |
| `mobile-kit` | `mobile-developer` | "react native", "flutter", "ios", "android", "expo", "mobile app" |
| `ai-kit` | `mlops-engineer` | "mlflow", "model", "langchain", "llm", "rag", "inference", "evaluation" |
| `compliance-kit` | `compliance-auditor` | "compliance", "GDPR", "AI Act", "NIS2", "DORA", "ISO 27001", "PII" |
| `aws-kit` | _(skills only)_ | "aws", "ec2", "s3", "lambda", "fargate", "sagemaker", "iam" |
| `azure-kit` | _(skills only)_ | "azure", "app service", "aks", "container apps", "functions" |
| `gcp-kit` | _(skills only)_ | "gcp", "cloud run", "gke", "bigquery", "pub/sub" |
| `hr-kit` | `hr-recruiter` | "sourcing", "recruiting", "candidate", "OSINT" |
| `mktg-kit` | `seo-specialist`, `linkedin-specialist` | "seo", "linkedin", "marketing", "content" |

---

## 🗺️ Project Type → Agent Mapping

> 🔴 **MANDATORY:** Before starting any project, identify the type and assign the correct primary agent.

| Project Type | Primary Agent | Required Kit | DO NOT USE |
|--------------|--------------|--------------|------------|
| **MOBILE** (iOS, Android, RN, Flutter) | `mobile-developer` | `mobile-kit` | ❌ `frontend-specialist` |
| **WEB** (Next.js, React, UI) | `frontend-specialist` | `frontend-kit` | ❌ `mobile-developer` |
| **BACKEND** (API, DB, APIs) | `backend-specialist` | `backend-kit` | — |
| **DEVOPS** (CI/CD, Deploy) | `devops-engineer` | `devops-kit` | — |
| **QA/TESTING** | `test-engineer` | `qa-kit` | — |

**Warning Rule:** If a required kit is NOT present, warn the user:
> _"To get the best results for a [project type] project, you should add `[kit-name]` to your workspace."_
>
> Proceed with general knowledge if they insist. Do NOT hallucinate kit-specific standards.

---

## 🚦 Domain → Agent Routing Matrix

> Used by `@[skills/intelligent-routing]` at runtime. This is the authoritative source.

### Single-Domain Tasks (Auto-invoke)

| Domain | Patterns | Agent | Auto? |
|--------|----------|-------|-------|
| **Security** | auth, login, jwt, password, hash, token | `security-auditor` | ✅ |
| **Frontend** | component, react, vue, css, html, tailwind | `frontend-specialist` | ✅ |
| **Backend** | api, server, express, fastapi, node | `backend-specialist` | ✅ |
| **Mobile** | react native, flutter, ios, android, expo | `mobile-developer` | ✅ |
| **Database** | prisma, sql, mongodb, schema, migration | `database-architect` | ✅ |
| **Testing** | test, jest, vitest, playwright, cypress | `test-engineer` | ✅ |
| **DevOps** | docker, kubernetes, ci/cd, pm2, nginx | `devops-engineer` | ✅ |
| **Debug** | error, bug, crash, not working, issue | `debugger` | ✅ |
| **Performance** | slow, lag, optimize, cache, performance | `performance-optimizer` | ✅ |
| **SEO** | seo, meta, analytics, sitemap, robots | `seo-specialist` | ✅ |
| **Sprint/Agile** | sprint, standup, retro, velocity, burndown | `scrum-master` | ✅ |
| **Release** | release, changelog, rollout, semver, tag | `release-manager` | ✅ |
| **Risk/Governance** | risk, mitigation, charter, gate, governance | `project-planner` | ✅ |
| **PM Reports** | status report, EVM, budget, cost, schedule | `project-planner` | ✅ |
| **MLOps/AI** | mlflow, model, langchain, llm, rag, inference | `mlops-engineer` | ✅ |
| **Compliance** | compliance, GDPR, AI Act, NIS2, DORA, ISO 27001 | `compliance-auditor` | ✅ |

### Multi-Domain Tasks (Auto-invoke → `orchestrator`)

| User Intent | Selected Agent(s) | Auto? |
|------------|-------------------|-------|
| **Authentication** | `security-auditor` + `backend-specialist` | ✅ |
| **UI Component** | `frontend-specialist` | ✅ |
| **API Endpoint** | `backend-specialist` | ✅ |
| **Database** | `database-architect` + `backend-specialist` | ✅ |
| **New Feature** (multi-domain) | `orchestrator` → multi-agent | ⚠️ ASK FIRST |
| **Complex Task** (2+ domains) | `orchestrator` → multi-agent | ⚠️ ASK FIRST |

### Cloud & Infrastructure (Extension Kit Skills)

| Domain | Keywords | Check For | Fallback |
|--------|----------|-----------|----------|
| **AWS** | aws, ec2, s3, lambda, fargate, sagemaker | `aws-*` skills in context | General cloud knowledge |
| **Azure** | azure, app service, aks, container apps | `azure-*` skills in context | General cloud knowledge |
| **GCP** | gcp, cloud run, gke, bigquery, pub/sub | `gcp-*` skills in context | General cloud knowledge |

**Protocol:** Detect cloud domain → Check if skills exist in context → If found, load and apply → If NOT found, general knowledge + inform user.

---

## 🔴 Agent Boundary Enforcement

> **Each agent MUST stay within their domain. Cross-domain work = VIOLATION.**

### Strict Boundaries

| Agent | CAN Do | CANNOT Do |
|-------|--------|-----------|
| `frontend-specialist` | Components, UI, styles, hooks | ❌ Test files, API routes, DB |
| `backend-specialist` | API, server logic, DB queries | ❌ UI components, styles |
| `test-engineer` | Test files, mocks, coverage | ❌ Production code |
| `mobile-developer` | RN/Flutter components, mobile UX | ❌ Web components |
| `database-architect` | Schema, migrations, queries | ❌ UI, API logic |
| `security-auditor` | Audit, vulnerabilities, auth review | ❌ Feature code, UI |
| `devops-engineer` | CI/CD, deployment, infra config | ❌ Application code |
| `performance-optimizer` | Profiling, optimization, caching | ❌ New features |
| `documentation-writer` | Docs, README, comments | ❌ Code logic, auto-invoke |
| `project-planner` | Plan files, task breakdown | ❌ Code files |
| `debugger` | Bug fixes, root cause | ❌ New features |
| `explorer-agent` | Codebase discovery | ❌ Write operations |

### File Type Ownership

| File Pattern | Owner Agent | Others BLOCKED |
|-------------|-------------|----------------|
| `**/*.test.{ts,tsx,js}` | `test-engineer` | ❌ All others |
| `**/__tests__/**` | `test-engineer` | ❌ All others |
| `**/components/**` | `frontend-specialist` | ❌ backend, test |
| `**/api/**`, `**/server/**` | `backend-specialist` | ❌ frontend |
| `**/prisma/**`, `**/drizzle/**` | `database-architect` | ❌ frontend |

### Enforcement Protocol

```
WHEN agent is about to write a file:
  IF file.path MATCHES another agent's domain:
    → STOP
    → INVOKE correct agent for that file
    → DO NOT write it yourself
```

---

## 📐 Rule Priority

```
P0: CORE.md            → Universal behavior rules
P0: AGENTS.md (this)   → Agent registry, routing, boundaries
P0: AGENTS-*-kit.md    → Kit-specific agent details (when loaded)
P1: Agent .md files     → Persona, workflow, specific rules
P2: SKILL.md files      → Operational skill instructions
```
