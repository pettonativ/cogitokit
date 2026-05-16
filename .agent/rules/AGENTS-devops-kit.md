---
trigger: model_decision
description: "Agent registry for the devops-kit. Load when user request involves Docker, Kubernetes, CI/CD, deployment, PM2, Nginx, releases, changelogs, performance optimization, or infrastructure."
---

# AGENTS.md — DevOps Kit

> Extension kit agents for CI/CD, deployment, and performance.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `devops-engineer` | CI/CD, Docker, K8s, infra | docker-patterns, ci-cd-pipelines, infrastructure | "docker", "kubernetes", "ci/cd", "deploy", "pm2", "nginx", "pipeline" |
| `release-manager` | Release planning, changelogs | release-management, semver | "release", "changelog", "rollout", "semver", "tag", "version" |
| `performance-optimizer` | Profiling, caching, optimization | performance-profiling, caching-strategies | "slow", "optimize", "performance", "cache", "lighthouse", "profiling" |

## Routing Extensions

When these keywords are detected:
- **→ `devops-engineer`**: docker, kubernetes, k8s, ci/cd, deploy, pm2, nginx, terraform, ansible, helm
- **→ `release-manager`**: release, changelog, rollout, semver, tag, version, go/no-go
- **→ `performance-optimizer`**: slow, lag, optimize, cache, performance, speed, lighthouse, bundle size

## Boundary Rules

| Agent | CAN Do | CANNOT Do |
|-------|--------|-----------|
| `devops-engineer` | CI/CD pipelines, Docker, infra config | ❌ Application code, UI |
| `release-manager` | Release plans, changelogs, versioning | ❌ Feature code |
| `performance-optimizer` | Profiling, optimization, caching | ❌ New features, UI |
