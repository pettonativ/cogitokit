# cogitokit (Claude Code bridge)

This repository is **cogitokit**. Paths are relative to the repo root.

## P0 — routing and behavior

- `.agent/rules/CORE.md` — global behavior, classifier, tiers, operational modes
- `.agent/rules/AGENTS.md` — agent registry, routing, boundaries

## Personas (P1)

- `.agent/agents/*.md` — e.g. orchestrator, debugger, project-planner, explorer-agent

## Extension Kits

If `extension-kits/<kit>/` exists, load `.agent/rules/AGENTS-<kit>.md` when needed (e.g. `AGENTS-backend-kit.md`).

## Workflows

- `.agent/workflows/*.md` — procedures (plan, sprint, deploy, debug, report, etc.)

## Skills

Skills are located in `.agent/skills/` and in the respective `extension-kits/<kit>/.agent/skills/`. Only read the relevant `SKILL.md`, do not read the entire folder.
