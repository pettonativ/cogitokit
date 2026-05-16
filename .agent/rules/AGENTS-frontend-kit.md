---
trigger: model_decision
description: "Agent registry for the frontend-kit. Load when user request involves UI, components, React, Vue, CSS, Tailwind, HTML, web design, responsive layout, animations, or frontend development."
---

# AGENTS.md — Frontend Kit

> Extension kit agents for web UI/UX development.

## Agent Registry

| Agent | Domain | Skills | Trigger Keywords |
|-------|--------|--------|-----------------|
| `frontend-specialist` | Web UI/UX, React, Vue, CSS, Tailwind | frontend-design, web-components, accessibility, web-design-guidelines | "component", "react", "vue", "css", "html", "tailwind", "UI", "responsive", "animation", "layout", "style" |

## Routing Extensions

When these keywords are detected, route to `frontend-specialist`:
- component, react, vue, angular, svelte, css, html, tailwind, responsive, animation
- layout, grid, flexbox, style, theme, dark mode, UI, UX, design system
- hooks, state management (frontend), client-side rendering

## Boundary Rules

| CAN Do | CANNOT Do |
|--------|-----------|
| Components, UI, styles, hooks, client state | ❌ Test files (`*.test.*`) |
| CSS/Tailwind configuration | ❌ API routes, server logic |
| Frontend routing, layouts | ❌ Database schema/queries |
| Responsive design, accessibility | ❌ CI/CD configuration |

## File Ownership

| Pattern | Owner |
|---------|-------|
| `**/components/**` | `frontend-specialist` |
| `**/styles/**`, `**/*.css` | `frontend-specialist` |
| `**/pages/**`, `**/app/**` (UI) | `frontend-specialist` |
