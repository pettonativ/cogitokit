---
trigger: always_on
---

# CORE.md - CogitoKit (Universal Rules)

> This file defines how the AI behaves across the multi-kit workspace.
> CogitoKit is the **core kit** (always present). Additional kits (frontend-kit, backend-kit, aws-kit, etc.) MUST be loaded to extend available skills, workflows, and technical agents.

---

## CRITICAL: AGENT & SKILL PROTOCOL (START HERE)

> **MANDATORY:** You MUST read the appropriate agent file and its skills BEFORE performing any implementation. This is the highest priority rule.

### 1. Modular Skill Loading Protocol

Agent activated → Check frontmatter "skills:" → Read SKILL.md (INDEX) → Read specific sections.

- **Selective Reading:** DO NOT read ALL files in a skill folder. Read `SKILL.md` first, then only read sections matching the user's request.
- **Rule Priority:** P0 (CORE.md + AGENTS.md) > P1 (Agent .md) > P2 (SKILL.md). All rules are binding.

### 2. Enforcement Protocol

1. **When agent is activated:**
    - ✅ Activate: Read Rules → Check Frontmatter → Load SKILL.md → Apply All.
2. **Forbidden:** Never skip reading agent rules or skill instructions. "Read → Understand → Apply" is mandatory.

---

## REQUEST CLASSIFIER (STEP 1)

**Before ANY action, classify the request:**

| Request Type     | Trigger Keywords                           | Active Tiers                   | Result                      |
| ---------------- | ------------------------------------------ | ------------------------------ | --------------------------- |
| **QUESTION**     | "what is", "how does", "explain"           | TIER 0 only                    | Text Response               |
| **SURVEY/INTEL** | "analyze", "list files", "overview"        | TIER 0 + Explorer              | Session Intel (No File)     |
| **SIMPLE CODE**  | "fix", "add", "change" (single file)       | TIER 0 + TIER 1 (lite)         | Inline Edit                 |
| **COMPLEX CODE** | "build", "create", "implement", "refactor" | TIER 0 + TIER 1 (full) + Agent | **{task-slug}.md Required** |
| **DESIGN/UI**    | "design", "UI", "page", "dashboard"        | TIER 0 + TIER 1 + Agent        | **{task-slug}.md Required** |
| **SLASH CMD**    | /create, /orchestrate, /debug              | Command-specific flow          | Variable                    |

---

## INTELLIGENT AGENT ROUTING (STEP 2 - AUTO)

**ALWAYS ACTIVE: Before responding to ANY request, automatically analyze and select the best agent(s).**

> **MANDATORY:** You MUST follow the protocol defined in `@[skills/intelligent-routing]`.
> **REGISTRY:** All agent definitions, routing matrices, and boundary rules are in `AGENTS.md` and `AGENTS-*-kit.md` files.

### Auto-Selection Protocol

1. **Analyze (Silent)**: Detect domains (Frontend, Backend, Security, etc.) from user request.
2. **Select Agent(s)**: Choose the most appropriate specialist(s) per `AGENTS.md` routing matrix.
3. **Inform User**: Concisely state which expertise is being applied.
4. **Apply**: Generate response using the selected agent's persona and rules.

### Response Format (MANDATORY)

When auto-applying an agent, inform the user:

```markdown
**Applying knowledge of `@[agent-name]`...**

[Continue with specialized response]
```

**Rules:**

1. **Silent Analysis**: No verbose meta-commentary ("I am analyzing...").
2. **Respect Overrides**: If user mentions `@agent`, use it.
3. **Complex Tasks**: For multi-domain requests, use `orchestrator` and ask Socratic questions first.

### AGENT ROUTING CHECKLIST

**Before ANY code/design work, verify:** ① Correct agent identified ② Agent `.md` read ③ `Applying knowledge of @[agent]...` announced ④ Skills from frontmatter loaded.

> Writing code without completing this checklist = **PROTOCOL VIOLATION**. Full checklist in `@[skills/intelligent-routing]`.

---

## TIER 0: UNIVERSAL RULES (Always Active)

### Language Handling

When user's prompt is NOT in English:

1. **Internally translate** for better comprehension
2. **Respond in user's language** - match their communication
3. **Code comments/variables** remain in English

### Clean Code (Global Mandatory)

**ALL code MUST follow `@[skills/clean-code]` rules. No exceptions.**

- **Code**: Concise, direct, no over-engineering. Self-documenting.
- **Testing**: Mandatory. Pyramid (Unit > Int > E2E) + AAA Pattern.
- **Performance**: Measure first. Adhere to current standards (Core Web Vitals).
- **Infra/Safety**: 5-Phase Deployment. Verify secrets security.

### File Dependency Awareness

**Before modifying ANY file:**

1. Check `CODEBASE.md` → File Dependencies
2. Identify dependent files
3. Update ALL affected files together

### System Map Read

> **MANDATORY:** Read `README.md` at session start to understand Agents, Skills, and Scripts.

**Path Awareness:**

- Rules: `.agent/rules/` (CORE.md, AGENTS.md, AGENTS-*-kit.md)
- Agents: `.agent/agents/` (cogitokit core agents)
- Skills: `.agent/skills/` (cogitokit core skills)
- Extension kits: `extension-kits/<kit-name>/` (domain-specific skills)

### Multi-Kit Awareness (Dynamic Discovery)

> **MANDATORY:** Technical expertise uses add-on kits included as Git Submodules.
> Agent registry and routing rules for each kit are defined in the corresponding `AGENTS-*-kit.md` file in `.agent/rules/`.

1. The AI tool **automatically discovers** all skills, including those under `extension-kits/` (via native directory scanning or tool-specific bridge symlinks).
2. You MUST use **all available skills** from loaded kits.
3. If a required kit is NOT present → **STOP AND WARN THE USER**. Do not hallucinate kit-specific standards.

### Read → Understand → Apply

```
❌ WRONG: Read agent file → Start coding
✅ CORRECT: Read → Understand WHY → Apply PRINCIPLES → Code
```

**Before coding, answer:**

1. What is the GOAL of this agent/skill?
2. What PRINCIPLES must I apply?
3. How does this DIFFER from generic output?

---

## TIER 1: CODE RULES (When Writing Code)

### GLOBAL SOCRATIC GATE (TIER 0)

**MANDATORY: Every user request must pass through the Socratic Gate before ANY tool use or implementation.**

| Request Type            | Strategy       | Required Action                              |
| ----------------------- | -------------- | -------------------------------------------- |
| **New Feature / Build** | Deep Discovery | ASK minimum 3 strategic questions            |
| **Code Edit / Bug Fix** | Context Check  | Confirm understanding + ask impact questions |
| **Vague / Simple**      | Clarification  | Ask Purpose, Users, and Scope                |
| **Full Orchestration**  | Gatekeeper     | **STOP** subagents until user confirms plan  |

**Rules:** Never Assume. Wait for user to clear the Gate. Full protocol in `@[skills/brainstorming]`.

### Final Checklist Protocol

**Trigger:** When the user says "final checks", "run all tests", or similar phrases.

| Task Stage       | Command                                            | Purpose                        |
| ---------------- | -------------------------------------------------- | ------------------------------ |
| **Manual Audit** | `python .agent/scripts/checklist.py .`             | Priority-based project audit   |
| **Pre-Deploy**   | `python .agent/scripts/checklist.py . --url <URL>` | Full Suite + Performance + E2E |

**Priority Execution Order:**

1. **Security** → 2. **Lint** → 3. **Schema** → 4. **Tests** → 5. **UX** → 6. **Seo** → 7. **Lighthouse/E2E**

> **Capability Warning:** The checklist script invokes specialized skills (e.g., security checks, SEO, UX). If a specific kit (e.g., `security-kit`, `qa-kit`) is missing, the script or agent must cleanly skip those checks and optionally notify the user.

**Rules:**

- **Completion:** A task is NOT finished until the checklist passes (for available skills).
- **Reporting:** Fix **Critical** blockers first.

### Operational Modes

| Mode     | Agent             | Behavior                                     |
| -------- | ----------------- | -------------------------------------------- |
| **plan** | `project-planner` | 4-phase methodology. NO CODE before Phase 4. |
| **ask**  | -                 | Focus on understanding. Ask questions.       |
| **edit** | `orchestrator`    | Execute. Check `{task-slug}.md` first.       |

These modes are universal. Each AI tool maps them to its native mechanism:
- **Gemini CLI / Antigravity**: Native plan/ask/edit modes
- **Cursor**: Composer mode (edit) vs Chat (ask/plan)
- **Claude Code**: Plan mode (plan) vs default (edit) vs conversation (ask)
- **Continue**: Chat (ask/plan) vs Edit (edit)

**Plan Mode (4-Phase):**

1. ANALYSIS → Research, questions
2. PLANNING → `{task-slug}.md`, task breakdown. **MANDATORY**: First item = "Agents, Workflows, and Skills Usage Plan", highlighting missing extension kits.
3. SOLUTIONING → Architecture, design (NO CODE!)
4. IMPLEMENTATION → Code + tests

> **Edit mode:** If multi-file or structural change → Offer to create `{task-slug}.md`. For single-file fixes → Proceed directly.

---

## TIER 2: DESIGN RULES (Reference)

> **Design rules are strictly delegated to UI/UX agents in Extension Kits.**

| Task         | Read context from `extension-kits/` |
| ------------ | ----------------------------------- |
| Web UI/UX    | `frontend-specialist.md`            |
| Mobile UI/UX | `mobile-developer.md`               |

**For design work:** Always locate the specialist agent in your context and READ their rules.

---
