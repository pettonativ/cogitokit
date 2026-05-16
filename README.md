# CogitoKit (Core)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Agents](https://img.shields.io/badge/Agents-9-blueviolet)](#-core-agents) [![Skills](https://img.shields.io/badge/Core_Skills-31-green)](#-core-skills) [![Workflows](https://img.shields.io/badge/Workflows-20-orange)](#-core-workflows) [![Extension Kits](https://img.shields.io/badge/Extension_Kits-13-red)](#-extension-kits-technical--domain-expertise)

> Personal AI agent framework with Skills, Agents, and Workflows for AI-assisted coding and project management.

## Overview

**CogitoKit** is the **core framework** that supercharges AI-powered editors (Cursor, Continue, Claude Code, Gemini CLI, Antigravity, etc.) with domain-specific expertise. It provides **intelligent routing**, **specialist agents**, and **slash command workflows** — so every request gets an expert-level response automatically.

Following a major modular refactoring, this repository now serves as the **Pure Management Core**, providing Agnostic Architecture, Agile Project Management, Orchestration, and System Debugging. Extension kits are included directly in the `extension-kits/` directory.

All domain-specific implementations (Frontend, Backend, Devops, Security, AI) are now consolidated as optional **Extension Kits** within this Monorepo.

### 🧠 Why "CogitoKit"?
The name is derived from Descartes' famous proposition *“Cogito, ergo sum”* (I think, therefore I am). This perfectly encapsulates the core philosophy of the framework: the **Socratic Gate**. Unlike standard AI assistants that blindly generate code, CogitoKit forces the AI to stop, think, and ask strategic questions before taking action. It is a thoughtful, methodical, and modular *Kit*.

---

## ⚙️ How It Works

CogitoKit transforms your AI editor into a structured engineering team. It does this through four main layers:

1. **Rules & Intelligent Routing**: Every prompt goes through `.agent/rules/CORE.md`. The AI evaluates your request, determines the domain (e.g., Frontend, Database), and automatically summons the right **Agent**.
2. **Specialist Agents**: Personas (like `@frontend-specialist` or `@debugger`) that adopt specific behaviors, boundaries, and best practices for their domain.
3. **Skills**: Curated knowledge bases (e.g., `clean-code`, `react-best-practices`) loaded on demand by the Agents. The AI reads these Markdown files before writing code.
4. **Workflows**: Step-by-step standard operating procedures triggered by `/slash` commands (e.g., `/sprint`, `/debug`, `/plan`).

> **The Socratic Gate**: Before writing any code for complex tasks, the AI is instructed to stop and ask you clarifying questions (The Socratic Gate). This prevents hallucinations and ensures alignment.

---

## 💡 Practical Examples

To get the most out of CogitoKit, your prompts should leverage the automatic routing and slash commands. Here are real-world scenarios:

### 🌟 Scenario 1: Starting a New Feature
Don't jump straight to code; let the AI explore and plan first.

- **You say:** "We need to extract the user profile logic into a separate microservice. `/plan`"
- **What happens:** The `project-planner` agent wakes up. It asks you strategic questions (Socratic Gate). Once answered, it writes a detailed Markdown plan, breaks down the tasks, and stops. It won't write code until you approve the plan.

### 🛠️ Scenario 2: Building the Code
When it's time to build, hand it over to the orchestrator or specialists.

- **You say:** "`/create` a new landing page. Load the `frontend-kit` and use Tailwind v4 and React Server Components."
- **What happens:** The `orchestrator` coordinates with the `frontend-specialist`. It reads the `tailwind-patterns` skill, establishes the component structure, and writes clean, accessible code.

### 🐛 Scenario 3: Systematic Debugging
Stop guessing and use methodical troubleshooting.

- **You say:** "I have a weird bug where the login screen hangs. `/debug`"
- **What happens:** The `debugger` agent activates. Instead of wildly changing code, it follows a 4-phase systematic process: it asks to see the logs, forms hypotheses, tests them, and only then applies the fix.

### 📋 Scenario 4: Project Management
Use the PM and Agile personas for structured work.

- **You say:** "I've just finished the sprint. Run a `/retro` so we can track what went well."
- **What happens:** The `scrum-master` agent facilitates a structured retrospective (e.g., Start-Stop-Continue), analyzes team velocity, and updates the project documents.

### 🚨 What NOT to do

- **Bad:** "Write code for a mobile app" _(Too vague, bypasses the Socratic Gate)._
- **Bad:** "Act as a React expert and fix this." _(Unnecessary: the `intelligent-routing` will automatically summon the `frontend-specialist` if you ask to fix a React component)._

---

## 🏗️ Architecture & Discovery

```plaintext
Workspace (multi-kit)
├── cogitokit/                  # CORE (always present)
│   └── .agent/
│       ├── agents/            # Core Management Agents
│       ├── skills/            # Universal Management Skills
│       ├── workflows/         # Management Slash Commands
│       ├── rules/             # Rules
│       │   ├── CORE.md        #   Universal behavior (always_on)
│       │   ├── AGENTS.md      #   Agent registry & routing (always_on)
│       │   └── AGENTS-*-kit.md #  Per-kit agent rules (model_decision)
│       └── scripts/           # Master Validation Scripts
│
├── extension-kits/
│   ├── ai-kit/                # ADD-ON (Langchain, MLops)
│   ├── aws-kit/               # ADD-ON (AWS Patterns)
│   ├── azure-kit/             # ADD-ON (Azure Patterns)
│   ├── backend-kit/           # ADD-ON (APIs, Databases, Node/Python)
│   ├── compliance-kit/        # ADD-ON (AI Act, NIS2, GDPR)
│   ├── devops-kit/            # ADD-ON (CI/CD, Deploy, Performance)
│   ├── frontend-kit/          # ADD-ON (React, Tailwind, UI/UX)
│   ├── gcp-kit/               # ADD-ON (Google Cloud Patterns)
│   ├── hr-kit/                # ADD-ON (OSINT Sourcing, Recruiting)
│   ├── mktg-kit/              # ADD-ON (SEO, Linkedin)
│   ├── mobile-kit/            # ADD-ON (iOS, Android, React Native)
│   ├── qa-kit/                # ADD-ON (Automation, WebApp testing, TDD)
│   └── security-kit/          # ADD-ON (Pentesting, OWASP)
```

### How Multi-Kit Discovery Works

1. **The AI tool auto-discovers** all `.agent/skills/` directories across the entire repository, including everything under `extension-kits/`.
2. Skills from add-on kits appear in the session context alongside core skills.
3. The AI uses **all available skills** regardless of which kit provides them.
4. **Agent registry**: Core agents and routing rules are in `.agent/rules/AGENTS.md`. Kit-specific agent details are in `AGENTS-*-kit.md` files, loaded on-demand.

### 🌉 100% Editor-Agnostic Tool Bridges

This framework is built to be completely independent of the AI editor you choose. It achieves this through **"Bridge Files"** — thin configuration files that contain **zero business logic**. Instead, they act strictly as "road signs" directing the specific AI tool to the Single Source of Truth (`.agent/rules/CORE.md`).

If you update a rule or add an agent, you do it once in `.agent/`, and it instantly propagates to all editors.

| Tool | Bridge File | How it works under the hood |
|------|------------|-----------------------------|
| **Cursor** | `.cursor/rules/cogitokit-cursor-bridge.mdc` | Uses `alwaysApply: true` to force reading the core rules. A Python script maps the `.agent/skills` to `.cursor/skills/` via symlinks so Cursor's indexing works natively. |
| **Claude Code** | `CLAUDE.md` | Standard entry point for Claude. It explicitly maps the routing logic (P0), personas (P1), and extension kits directories so Claude knows where to look without scanning irrelevant folders. |
| **Continue** | `.continuerules` | Mirrors the `CLAUDE.md` logic, leveraging Continue.dev's native workspace context injection to load the same core `.md` files. |
| **Gemini / Antigravity** | `.agent/rules/CORE.md` | Native integration. The framework injects the rules directly into the system prompt context, bypassing the need for an intermediate text file. |

---

## 📦 What's Included (Core Kit)

| Component     | Count | Description                                            |
| ------------- | ----- | ------------------------------------------------------ |
| **Agents**    | 9     | Orchestrators, Planners, Agile Masters, and Debuggers  |
| **Skills**    | 31    | Project Management, Universal Architecture, Clean Code |
| **Rules**     | 15    | `CORE.md` + `AGENTS.md` + 13 `AGENTS-*-kit.md`        |
| **Workflows** | 20    | Slash command procedures for PM, Planning, and more    |

### 🤖 Core Agents

The system **automatically detects and applies the right specialist(s)**. The Core Agents focus on management and system design:

| Agent                  | Focus                                                |
| ---------------------- | ---------------------------------------------------- |
| `orchestrator`         | Multi-agent coordination and execution               |
| `project-planner`      | Discovery, architecture, 4-phase planning            |
| `debugger`             | Systematic 4-phase debugging and root cause analysis |
| `product-manager`      | Product strategy, requirements, user stories         |
| `product-owner`        | Backlog management, MVP definition                   |
| `scrum-master`         | Agile ceremonies, sprints, retrospectives            |
| `explorer-agent`       | Codebase exploration and survey                      |
| `code-archaeologist`   | Legacy code analysis, refactoring                    |
| `documentation-writer` | Technical documentation                              |

> Technical agents (`frontend-specialist`, `backend-specialist`, etc.) are provided by [Extension Kits](#-extension-kits-technical--domain-expertise).

### 🧩 Core Skills

Core skills focus strictly on processes, management, architecture, and cross-cutting orchestration concerns.

**Project Management & Agile:**
`sprint-management`, `estimation-techniques`, `risk-management`, `cost-management`, `metrics-analytics`, `pm-reporting`, `retrospective`, `stakeholder-management`, `change-management`, `meeting-facilitation`, `resource-management`, `project-scheduling`, `scope-management`, `governance-pmo`, `contract-review`, `quality-management`, `release-planning`.

**Architecture & Engineering:**
`app-builder`, `architecture`, `plan-writing`, `brainstorming`, `clean-code`, `systematic-debugging`, `code-review-checklist`, `bash-linux`, `powershell-windows`, `documentation-templates`, `mcp-builder`.

**System & Orchestration (internal):**
`intelligent-routing`, `behavioral-modes`, `parallel-agents`.

> **What's NOT Core:** Technical implementation skills (React, Tailwind, i18n, web-design-guidelines, databases, deployment, etc.) live in their respective [Extension Kits](#-extension-kits-technical--domain-expertise). The core is strictly about *thinking, planning, and coordinating* — never about *implementing*.

### 🔄 Core Workflows

Slash command procedures. Invoke with `/command`.

**Planning & Design:** `/brainstorm`, `/create`, `/enhance`, `/debug`, `/orchestrate`, `/plan`
**Project Management:** `/sprint`, `/estimate`, `/retro`, `/report`, `/standup`, `/risk`, `/contract-review`, `/schedule`, `/governance`, `/status`
**Operations:** `/deploy`, `/release`, `/preview`, `/test`

---

## 🔌 Extension Kits (Technical & Domain Expertise)

This framework is radically modular. Technical coding capabilities are provided by the official Extension Kits located in the `extension-kits/` directory:

| Kit                                                                | Focus                                                |
| ------------------------------------------------------------------ | ---------------------------------------------------- |
| [**frontend-kit**](./extension-kits/frontend-kit)     | Web UI/UX, React/Next.js expert, Tailwind Patterns   |
| [**backend-kit**](./extension-kits/backend-kit)       | APIs, Node.js, Python, Rust, Database Architecture   |
| [**mobile-kit**](./extension-kits/mobile-kit)         | Mobile UI/UX, iOS, Android, React Native             |
| [**devops-kit**](./extension-kits/devops-kit)         | CI/CD, Deployment, Release Management, Profiling     |
| [**security-kit**](./extension-kits/security-kit)     | Red Team Tactics, Vulnerability Scanning, Pentesting |
| [**qa-kit**](./extension-kits/qa-kit)                 | Automation, WebApp testing, TDD, Quality Gates       |
| [**ai-kit**](./extension-kits/ai-kit)                 | LangChain, MLOps evaluation, AI Agents               |
| [**aws-kit**](./extension-kits/aws-kit)               | AWS compute patterns, Batch, Fargate, SageMaker      |
| [**azure-kit**](./extension-kits/azure-kit)           | Azure compute, cost, deploy, observability           |
| [**compliance-kit**](./extension-kits/compliance-kit) | EU AI Act, NIS2, GDPR, DORA compliance               |
| [**gcp-kit**](./extension-kits/gcp-kit)               | Cloud Run, GKE, BigQuery, Pub/Sub                    |
| [**hr-kit**](./extension-kits/hr-kit)                 | OSINT Sourcing, Recruiting, Candidate Research       |
| [**mktg-kit**](./extension-kits/mktg-kit)             | SEO, LinkedIn Content, Marketing Strategy            |

---

## 🚀 Quick Start

After cloning, verify the framework is correctly set up:

```bash
# Clone the complete CogitoKit Monorepo
git clone https://github.com/pettonativ/cogitokit.git
cd cogitokit

# Validate all skill symlinks resolve correctly
python3 scripts/validate_symlinks.py

# (For Cursor users) Regenerate Cursor skill symlinks
python3 scripts/sync_cursor_workspace.py
```

### Using with AI Editors

1. **Cursor**: Open the repo as workspace root. The `.cursor/rules/` bridge auto-loads.
2. **Claude Code**: The `CLAUDE.md` file is auto-detected.
3. **Continue**: The `.continuerules` file is auto-detected.
4. **Gemini CLI / Antigravity**: The `.agent/rules/CORE.md` trigger loads automatically.

### `.gitignore` Note
Do **not** add `.agent/` to `.gitignore` — the IDE needs to index it for rules and skills. Instead, use `.git/info/exclude` to keep it local.

### Using as a Sub-workspace
To add cogitokit to an existing project:

```bash
# Copy or symlink the .agent/ directory to your project root
cp -R path/to/cogitokit/.agent /your/project/.agent

# Copy the appropriate bridge file for your AI tool
cp path/to/cogitokit/CLAUDE.md /your/project/   # For Claude Code
```

## Credits

Based on [antigravity-kit](https://github.com/vudovn/antigravity-kit) by [vudovn](https://github.com/vudovn) — MIT License.
Extensively refactored, extended, and modularized by **Vittorio Pettonati** ([@pettonativ](https://github.com/pettonativ)).

## License

MIT
