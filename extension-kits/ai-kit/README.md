# AI Kit

> **Add-on kit** for the [cogitokit](https://github.com/pettonativ/cogitokit) multi-kit AI agent system.

Provides **AI/ML development patterns** — LangChain agent architectures, MLOps evaluation pipelines, and MLOps engineering expertise.

---

## 🎯 Purpose

Specialized skills for building, evaluating, and deploying AI/ML systems:

| Skill                    | Focus                                                   | Status      |
| ------------------------ | ------------------------------------------------------- | ----------- |
| **`langchain-patterns`** | LangChain agents, RAG, chain composition, tools, memory | ✅ Complete |
| **`mlops-evaluation`**   | MLflow, RAGAS, async eval, LLM-as-judge                 | ✅ Complete |

---

## 🏗️ Architecture

```
ai-kit/
├── .agent/
│   ├── ARCHITECTURE.md
│   ├── agents/
│   │   └── mlops-engineer.md
│   └── skills/
│       ├── langchain-patterns/
│       └── mlops-evaluation/
└── README.md
```

---

## 🔌 How to Use

1. **Included as submodule** of `cogitokit` under `extension-kits/ai-kit/`
2. Antigravity **auto-discovers** all skills when the workspace is open
3. The `intelligent-routing` in cogitokit routes AI/ML requests to `mlops-engineer` when this kit is present

---

## 🤖 Agent

| Agent            | Focus                              | Skills                               |
| ---------------- | ---------------------------------- | ------------------------------------ |
| `mlops-engineer` | AI/ML system design and evaluation | langchain-patterns, mlops-evaluation |

---

## 📄 License

Private repository. All rights reserved.
