---
name: langchain-patterns
description: LangChain and LLM agent development patterns. Agent architectures, chain composition, retrieval-augmented generation (RAG), tool design, memory patterns, prompt engineering. Use when building or reviewing LLM-powered agents or applications.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# LangChain & LLM Agent Patterns

> "Build agents that reason, retrieve, and act — reliably."

## 🎯 Selective Reading Rule

**This is a standalone skill. Read ONLY the sections relevant to the user's request.**

---

## 🔗 Related Skills

| Skill                        | Use For                                          |
| ---------------------------- | ------------------------------------------------ |
| `@[skills/mlops-evaluation]` | Evaluating agent responses (RAGAS, LLM-as-judge) |
| `@[skills/python-patterns]`  | Python async, project structure                  |
| `@[skills/api-patterns]`     | Agent-as-API design                              |
| `@[skills/architecture]`     | System-level architecture decisions              |

---

## 1. Agent Architecture Selection

### Decision Tree

```
What does the agent need to do?
│
├── Simple Q&A with context
│   └── RAG Chain (retriever + LLM)
│       └── No agent needed — use a chain
│
├── Single-domain tool use
│   └── ReAct Agent (reason + act loop)
│
├── Multi-step complex reasoning
│   └── Plan-and-Execute Agent
│       └── Planner + Executor separation
│
├── Multi-domain / Specialist routing
│   └── Multi-Agent Architecture
│       └── Router → Specialist agents
│
└── Conversational with memory
    └── Agent + Memory (buffer or summary)
```

### Architecture Comparison

| Pattern              | Complexity | Best For            | Limitations               |
| -------------------- | ---------- | ------------------- | ------------------------- |
| **RAG Chain**        | Low        | Q&A, search         | No tool use, no reasoning |
| **ReAct Agent**      | Medium     | Tool use, reasoning | Can loop, hard to debug   |
| **Plan-and-Execute** | High       | Complex multi-step  | Slower, more tokens       |
| **Multi-Agent**      | High       | Specialized domains | Coordination complexity   |
| **Custom Agent**     | Variable   | Specific workflows  | More code to maintain     |

---

## 2. Retrieval-Augmented Generation (RAG)

### RAG Architecture

```
User Query
    │
    ▼
┌──────────────┐
│ Query Engine │ ← Optional: query transformation, HyDE
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Retriever   │ ← Azure AI Search, FAISS, Chroma, Pinecone
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Reranker    │ ← Optional: cross-encoder reranking
└──────┬───────┘
       │
       ▼
┌──────────────┐
│    LLM       │ ← System prompt + retrieved context + user query
└──────┬───────┘
       │
       ▼
   Response
```

### Retriever Selection

| Retriever           | Best For                  | Managed? | Cost     |
| ------------------- | ------------------------- | -------- | -------- |
| **Azure AI Search** | Enterprise, hybrid search | ✅       | Medium   |
| **Pinecone**        | Serverless vector search  | ✅       | Medium   |
| **Chroma**          | Local dev, prototyping    | ❌       | Free     |
| **FAISS**           | High-performance local    | ❌       | Free     |
| **Weaviate**        | Multi-modal search        | ✅/❌    | Variable |

### RAG Quality Patterns

| Problem              | Solution                                      |
| -------------------- | --------------------------------------------- |
| **Low relevance**    | Hybrid search (keyword + semantic), reranking |
| **Missing context**  | Parent-child retrieval, document expansion    |
| **Hallucination**    | Faithfulness scoring, source citations        |
| **Too much context** | Top-K tuning, context compression             |
| **Stale data**       | Incremental indexing, TTL on documents        |

---

## 3. Tool Design Principles

### Tool Definition Pattern

```python
from langchain.tools import tool

@tool
def search_flights(query: str, date: str) -> str:
    """Search available flights by destination and date.

    Args:
        query: Destination city or airport code
        date: Travel date in YYYY-MM-DD format

    Returns:
        JSON string with flight options including price and times
    """
    # Implementation
    pass
```

### Tool Design Rules

| Rule                 | Why                                                |
| -------------------- | -------------------------------------------------- |
| **Clear docstring**  | LLM uses docstring to decide when to call the tool |
| **Typed parameters** | Pydantic validation prevents bad calls             |
| **String return**    | LLM consumes string output — serialize to JSON     |
| **Error handling**   | Return error messages, don't raise exceptions      |
| **Idempotent**       | Safe to retry on failure                           |
| **Scoped**           | One tool = one responsibility                      |

### Anti-Patterns

| ❌ Don't                           | ✅ Do                                    |
| ---------------------------------- | ---------------------------------------- |
| One mega-tool that does everything | Decompose into focused tools             |
| Vague docstrings                   | Detailed descriptions with examples      |
| Raw exception propagation          | Graceful error messages                  |
| Untyped parameters                 | Pydantic schemas for complex inputs      |
| Side effects without confirmation  | Read-only tools, or confirm before write |

---

## 4. Memory Patterns

### Memory Selection

```
How long are conversations?
│
├── Short (< 10 turns)
│   └── ConversationBufferMemory (keep all)
│
├── Medium (10-50 turns)
│   └── ConversationSummaryMemory (summarize old)
│
├── Long (50+ turns)
│   └── ConversationSummaryBufferMemory (hybrid)
│
└── Need semantic recall
    └── VectorStoreMemory (embed + search)
```

### Token Budget Strategy

```
Available context window (e.g., 128K tokens)
├── System prompt:     ~500-2000 tokens (fixed)
├── Retrieved context: ~2000-8000 tokens (from RAG)
├── Conversation history: ~1000-4000 tokens (from memory)
├── Tool results:      ~500-2000 tokens (variable)
└── Response budget:   ~500-4000 tokens (for generation)
```

---

## 5. Prompt Engineering for Agents

### System Prompt Structure

```
ROLE: Who is the agent?
CAPABILITIES: What tools/knowledge does it have?
CONSTRAINTS: What should it NOT do?
FORMAT: How should it respond?
EXAMPLES: Few-shot examples of good responses
```

### Prompt Management

| Approach                   | Best For                | Versioning        |
| -------------------------- | ----------------------- | ----------------- |
| **MLflow Prompt Registry** | Production, A/B testing | ✅ Built-in       |
| **File-based (YAML/JSON)** | Simple projects         | Git versioning    |
| **Database**               | Dynamic, multi-tenant   | Custom versioning |
| **Hardcoded**              | ❌ Never in production  | ❌ None           |

### Prompt Anti-Patterns

| ❌ Don't                        | ✅ Do                                      |
| ------------------------------- | ------------------------------------------ |
| Hardcode prompts in Python code | Use MLflow prompt registry or config files |
| One giant system prompt         | Modular sections, compose dynamically      |
| Skip few-shot examples          | Include 2-3 examples of expected behavior  |
| Ignore prompt testing           | Test prompts against evaluation testsets   |

---

## 6. Streaming Patterns

### Why Stream?

| Metric                  | Without Streaming   | With Streaming     |
| ----------------------- | ------------------- | ------------------ |
| **Time to first token** | 5-30s               | < 1s               |
| **Perceived speed**     | Slow                | Fast               |
| **User experience**     | Wait → wall of text | Progressive reveal |

### Implementation Pattern

```python
# LangChain streaming with callbacks
async def stream_response(query: str):
    async for chunk in agent.astream({"input": query}):
        if "output" in chunk:
            yield chunk["output"]

# MLflow predict_stream pattern
def predict_stream(self, context, model_input):
    for event in agent.stream(input):
        if hasattr(event, "content"):
            yield event.content
```

---

## 7. Error Handling & Resilience

### Agent Failure Modes

| Failure            | Cause                     | Mitigation                            |
| ------------------ | ------------------------- | ------------------------------------- |
| **Infinite loop**  | Agent keeps calling tools | Max iterations limit (default: 15)    |
| **Tool error**     | External API failure      | Retry with backoff, fallback response |
| **Token overflow** | Too much context          | Truncation, summarization             |
| **Hallucination**  | Insufficient context      | Faithfulness evaluation, RAG quality  |
| **Wrong tool**     | Ambiguous docstrings      | Better tool descriptions, few-shot    |

### Resilience Patterns

```python
# Max iterations
agent = AgentExecutor(
    agent=agent,
    tools=tools,
    max_iterations=15,
    early_stopping_method="generate",
    handle_parsing_errors=True,
)

# Custom error handler
def handle_tool_error(error: Exception) -> str:
    return f"Tool encountered an error: {str(error)}. Please try a different approach."
```

---

## 8. Testing LLM Agents

### Testing Strategy

| Level           | What to Test           | How                     |
| --------------- | ---------------------- | ----------------------- |
| **Unit**        | Tool functions         | Standard pytest         |
| **Integration** | Agent + tools          | Mock LLM, real tools    |
| **Evaluation**  | Response quality       | RAGAS scorers, testsets |
| **E2E**         | Full conversation flow | MLflow evaluate         |

### Testset Design

```
Good testset includes:
├── Happy path queries (60%)
├── Edge cases (20%)
├── Adversarial inputs (10%)
├── Multi-turn conversations (10%)

Each test case:
├── user_input: "What flights to Rome on March 15?"
├── expected_output: (ground truth or reference)
├── retrieved_contexts: (for RAG evaluation)
└── metadata: { category, difficulty, domain }
```

---

## 9. Decision Checklist

Before building an LLM agent:

- [ ] **Architecture selected?** (RAG chain vs ReAct vs Plan-and-Execute)
- [ ] **Retriever chosen?** (Azure AI Search, FAISS, etc.)
- [ ] **Tools designed?** (clear docstrings, typed, scoped)
- [ ] **Memory strategy?** (buffer, summary, vector)
- [ ] **Prompt managed?** (registry, not hardcoded)
- [ ] **Streaming implemented?** (for user-facing agents)
- [ ] **Error handling?** (max iterations, tool errors, fallbacks)
- [ ] **Evaluation pipeline?** (RAGAS scorers, testset)
- [ ] **Token budget calculated?** (context window allocation)
- [ ] **Cost estimated?** (LLM API calls per request)

---

> **Remember:** An LLM agent is only as good as its tools, prompts, and evaluation. Build the evaluation pipeline before building the agent.
