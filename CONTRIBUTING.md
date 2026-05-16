# Contributing to CogitoKit

First off, thank you for considering contributing to CogitoKit! It's people like you that make the open-source community such a powerful place to learn, inspire, and create.

This repository is built around a highly modular, multi-kit architecture. We welcome contributions that expand the framework's capabilities, add new Extension Kits, or improve the core management workflows.

## 🧠 Architectural Principles

Before contributing, please understand the core philosophy of this framework:

1. **The Socratic Gate**: AI should not blindly execute code. Agents must ask clarifying questions before writing code for complex tasks.
2. **Editor Agnosticism**: The core logic lives in `.agent/`. Bridge files (`CLAUDE.md`, `.cursor/rules/`, etc.) should NEVER contain business logic, only pointers.
3. **Modularity via Kits**: Core management features go in `cogitokit/.agent/`. Domain-specific technical capabilities (Frontend, AI, DevOps) must go in their respective `extension-kits/<name>-kit/`.
4. **Core = Thinking, Not Implementing**: The core kit handles *planning, coordinating, and managing* — never specific technical implementations. If your skill teaches how to write React code, it belongs in `frontend-kit`, not core.

## 🛠️ How to Contribute

### 1. Adding a New Skill

Skills are markdown files that teach the AI best practices.

- Identify the correct kit (e.g., `frontend-kit` for React, core `.agent/skills/` for PM/Agile/Architecture).
- Create a folder for your skill.
- Write a `SKILL.md` file using the established YAML frontmatter (`name`, `description`).
- Focus on *teaching principles and thinking*, rather than just providing copy-paste commands.

### 2. Adding a New Workflow

Workflows are step-by-step procedures triggered by `/slash` commands.

- Create a new `.md` file in `.agent/workflows/`.
- Follow the existing pattern: clear trigger, step-by-step instructions, agent references.
- Update the `README.md` to include your new workflow in the appropriate category.

### 3. Adding or Modifying an Agent

Agents are specialist personas with defined boundaries.

- Create a new `.md` file in `.agent/agents/` with the agent's persona, skills, and rules.
- Update `.agent/rules/AGENTS.md` to register the new agent in the routing matrix.
- Ensure clear **domain boundaries** — an agent should never write files outside its domain.

### 4. Creating a New Extension Kit

If you are adding a completely new domain (e.g., `gaming-kit`):

- Create the folder under `extension-kits/`.
- Mimic the structure: `.agent/skills/`, `.agent/rules/AGENTS-<name>-kit.md`.
- Ensure all skills use standard Markdown formatting.
- **CRITICAL**: Do NOT use absolute paths. All symlinks use relative paths like `../../extension-kits/...`.

### 5. Modifying Core Rules

- Any changes to core behavior must be made in `.agent/rules/CORE.md` or `.agent/rules/AGENTS.md`.
- Test your changes using multiple AI editors if possible.

## 📐 Naming Conventions

Consistency is critical for symlink resolution:

| Component | Convention | Example |
|-----------|-----------|---------|
| **Skills** | `kebab-case` | `risk-management`, `clean-code` |
| **Agents** | `kebab-case` | `project-planner`, `scrum-master` |
| **Workflows** | `kebab-case`, no prefix | `sprint.md`, `debug.md` |
| **Kit names** | `<domain>-kit` | `frontend-kit`, `qa-kit` |
| **Rule files** | `AGENTS-<kit-name>.md` | `AGENTS-backend-kit.md` |

## 🚦 Pre-Pull Request Checklist

Before submitting a Pull Request, **you must run the validation scripts**:

```bash
# Verify that all symlinks resolve correctly
python3 scripts/validate_symlinks.py

# (For Cursor users) Regenerate Cursor skill symlinks
python3 scripts/sync_cursor_workspace.py
```

If the validation script fails, your PR will not be accepted. Ensure all relative paths (especially `../../`) are correct.

## 📝 Opening a Pull Request

- Use a clear, descriptive title.
- Explain the *why* behind your change.
- Link to any relevant GitHub Issues.
- If adding a new skill or agent, include a brief description of the domain it covers.

Happy contributing!
