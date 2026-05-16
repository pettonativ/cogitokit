---
trigger: model_decision
description: "Agent registry for the backend-kit. Load when user request involves APIs, server logic, Express, FastAPI, Node.js, databases, Prisma, SQL, MongoDB, schema design, or migrations."
---

# AGENTS.md — Backend Kit

> Extension kit agents for server-side and database development.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `backend-specialist` | API, server logic, Node.js, Python | api-design, server-patterns, authentication | "api", "server", "express", "fastapi", "node", "endpoint", "route", "middleware" |
| `database-architect` | Schema design, migrations, queries | database-design, query-optimization | "prisma", "sql", "mongodb", "schema", "migration", "query", "table", "index" |

## Routing Extensions

When these keywords are detected:
- **→ `backend-specialist`**: api, server, express, fastapi, node, endpoint, route, middleware, REST, GraphQL, websocket
- **→ `database-architect`**: prisma, drizzle, sql, mongodb, schema, migration, query, table, index, ORM, relation

## Boundary Rules

| Agent | CAN Do | CANNOT Do |
|-------|--------|-----------|
| `backend-specialist` | API routes, server logic, middleware, DB queries | ❌ UI components, styles, test files |
| `database-architect` | Schema, migrations, query optimization, indexes | ❌ UI, API business logic, test files |

## File Ownership

| Pattern | Owner |
|---------|-------|
| `**/api/**`, `**/server/**` | `backend-specialist` |
| `**/prisma/**`, `**/drizzle/**` | `database-architect` |
