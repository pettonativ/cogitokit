---
trigger: model_decision
description: "Agent registry for the security-kit. Load when user request involves authentication, authorization, JWT, passwords, security audits, vulnerability scanning, penetration testing, or OWASP."
---

# AGENTS.md — Security Kit

> Extension kit agents for security auditing and penetration testing.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `security-auditor` | Security review, auth, OWASP | vulnerability-scanner, auth-patterns, owasp-top10 | "auth", "login", "jwt", "password", "security", "vulnerability", "OWASP" |
| `penetration-tester` | Active testing, red team | penetration-testing, exploit-analysis | "pentest", "exploit", "red team", "injection", "XSS", "CSRF" |

## Routing Extensions

When these keywords are detected:
- **→ `security-auditor`**: auth, login, jwt, password, hash, token, security, vulnerability, OWASP, encryption
- **→ `penetration-tester`**: pentest, exploit, red team, injection, XSS, CSRF, attack surface

## Boundary Rules

| Agent | CAN Do | CANNOT Do |
|-------|--------|-----------|
| `security-auditor` | Audit, vulnerability reports, auth review | ❌ Feature code, UI |
| `penetration-tester` | Security testing, exploit verification | ❌ Feature code, UI, production fixes |
