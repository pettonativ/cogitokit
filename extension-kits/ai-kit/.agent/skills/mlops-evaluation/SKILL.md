---
name: mlops-evaluation
description: MLOps evaluation patterns. MLflow integration, RAGAS scorers, async eval design, testset management, LLM-as-judge. Cloud-agnostic. Use when designing or implementing model evaluation pipelines.
allowed-tools: Read, Glob, Grep
---

# MLOps Evaluation Framework

> "Measure what matters. Automate what repeats. Trust what's verified."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                         | Description                                      | When to Read                   |
| ---------------------------- | ------------------------------------------------ | ------------------------------ |
| `evaluation-patterns.md`     | Sync vs async, batch vs streaming eval           | Designing eval architecture    |
| `mlflow-integration.md`      | MLflow tracking, artifacts, model registry       | Implementing MLflow            |
| `scorer-design.md`           | RAGAS, custom judges, LLM-as-judge patterns      | Building or tuning scorers     |
| `testset-management.md`      | Versioning, generation, coverage strategies      | Managing evaluation data       |
| `async-eval-architecture.md` | Submit-and-detach, job queuing, status callbacks | Decoupling eval from CI/CD     |
| `metrics-output.md`          | Standard output formats, aggregation, reporting  | Defining eval output contracts |

---

## 🔗 Related Skills

| Skill                             | Use For                               |
| --------------------------------- | ------------------------------------- |
| `@[skills/architecture]`          | ADR for eval architecture decisions   |
| `@[skills/python-patterns]`       | Python async patterns, error handling |
| `@[skills/deployment-procedures]` | Deploying eval infrastructure         |
| `@[skills/cost-management]`       | Cost analysis of eval compute         |
| `@[skills/testing-patterns]`      | Testing the eval pipeline itself      |

---

## Core Principles

### 1. Evaluation is NOT Training

| Aspect           | Training                         | Evaluation                |
| ---------------- | -------------------------------- | ------------------------- |
| **Duration**     | Hours-Days                       | Minutes-Hours             |
| **Compute**      | GPU-heavy                        | CPU/API-heavy             |
| **Output**       | Model weights                    | Metrics + Reports         |
| **Failure mode** | Wasted compute                   | Wrong decisions           |
| **Priority**     | Can be interrupted (checkpoints) | Should NOT be interrupted |

### 2. Separation of Concerns

```
┌──────────────────────────────────────────┐
│ WHAT to evaluate (this skill)            │
│ ├── Scorers, metrics, testsets           │
│ ├── MLflow integration                   │
│ └── Output contracts                     │
├──────────────────────────────────────────┤
│ WHERE to evaluate (compute skill)        │
│ ├── AWS: aws-compute-patterns            │
│ ├── Azure: azure-compute                 │
│ └── GCP: gcp-compute                     │
├──────────────────────────────────────────┤
│ WHEN to evaluate (CI/CD skill)           │
│ ├── Pipeline triggers                    │
│ ├── Status callbacks                     │
│ └── Gate decisions                       │
└──────────────────────────────────────────┘
```

### 3. Eval Pipeline as Code

- Evaluation logic MUST be version-controlled
- Testsets MUST be versioned and immutable per run
- Scorer configurations MUST be declarative
- Results MUST be reproducible

---

## Evaluation Architecture Patterns

### Pattern A: Synchronous (Simple, Blocking)

```
Pipeline → Run Eval → Wait → Get Results → Continue
```

**When:** Eval < 15 min, dedicated compute, simple pipeline.
**Anti-pattern when:** Eval > 30 min, shared agent pools.

### Pattern B: Asynchronous Submit-and-Detach (Recommended)

```
Pipeline → Submit Job → Detach → [Job Queue] → Execute → Callback
                                                           ↓
Pipeline ← Status Check ←←←←←←←←←←←←←←←←←←←←←←←←← Store Results
```

**When:** Long-running eval, shared CI/CD agents, need scalability.

**Key components:**

1. **Job Submitter** — Lightweight client that enqueues the eval
2. **Job Queue** — Manages scheduling, retries, concurrency
3. **Eval Worker** — Executes the actual evaluation
4. **Result Store** — MLflow or equivalent for metrics/artifacts
5. **Status Reporter** — Callbacks to CI/CD system

### Pattern C: Event-Driven (Advanced)

```
Model Registry Event → Trigger Eval → Fan-Out Scorers → Aggregate → Notify
```

**When:** Continuous evaluation, multiple models, real-time scoring.

---

## MLflow Integration Principles

### Tracking Hierarchy

```
Experiment
└── Run (one per eval execution)
    ├── Parameters (model version, testset ID, scorer config)
    ├── Metrics (per-scorer aggregates)
    ├── Artifacts (detailed results, confusion matrices)
    └── Tags (eval_status, pipeline_id, trigger)
```

### Standard Parameter Set

| Parameter       | Example                    | Purpose              |
| --------------- | -------------------------- | -------------------- |
| `model_name`    | `alpigpt-flights-v2`       | Which model          |
| `model_version` | `42`                       | Which version        |
| `testset_id`    | `testset_202602161611`     | Which test data      |
| `testset_size`  | `97`                       | Number of test cases |
| `scorer_list`   | `correctness,semantic_sim` | Active scorers       |
| `eval_mode`     | `full\|quick\|smoke`       | Evaluation depth     |

### Standard Metric Set

| Metric                  | Type  | Description                  |
| ----------------------- | ----- | ---------------------------- |
| `eval_duration_seconds` | float | Wall-clock time              |
| `eval_status`           | tag   | `passed\|failed\|error`      |
| `total_predictions`     | int   | Number of predictions made   |
| `scorer_<name>_mean`    | float | Per-scorer average           |
| `scorer_<name>_p50`     | float | Per-scorer median            |
| `scorer_<name>_min`     | float | Per-scorer worst case        |
| `pass_rate`             | float | % of cases passing threshold |

---

## Scorer Design Principles

### Scorer Categories

| Category            | Examples                             | Cost Profile           |
| ------------------- | ------------------------------------ | ---------------------- |
| **Deterministic**   | Exact match, BLEU, ROUGE             | Free, fast             |
| **Embedding-based** | Semantic similarity, cosine distance | Embedding API cost     |
| **LLM-as-Judge**    | Correctness, relevance, faithfulness | LLM API cost (highest) |
| **Composite**       | RAGAS (combines multiple)            | Sum of components      |

### Cost Estimation Formula

```
Cost per run = Σ (n_cases × cost_per_scorer_call)

Where:
  n_cases = testset size
  cost_per_scorer_call = {
    deterministic: ~$0
    embedding: ~$0.0001/call
    llm_judge: ~$0.01-0.05/call (depends on model)
  }
```

### RAGAS-Specific Patterns

| Scorer               | What it Measures                       | Requires                      |
| -------------------- | -------------------------------------- | ----------------------------- |
| `answer_correctness` | Factual accuracy vs ground truth       | LLM judge + ground truth      |
| `answer_relevancy`   | Response relevance to query            | LLM judge                     |
| `faithfulness`       | Grounded in context (no hallucination) | LLM judge + retrieved context |
| `context_precision`  | Retrieved context quality              | LLM judge + ground truth      |
| `answer_similarity`  | Semantic similarity to reference       | Embedding model               |

### Scorer Parallelism

| Strategy            | How                              | When                         |
| ------------------- | -------------------------------- | ---------------------------- |
| **Sequential**      | Score each case one by one       | Debugging, rate-limited APIs |
| **Case-parallel**   | All scorers for one case at once | Default recommendation       |
| **Scorer-parallel** | One scorer across all cases      | When scorer has batch API    |
| **Full fan-out**    | All scorers × all cases          | Unlimited API budget         |

---

## Testset Management

### Versioning Rules

1. **Immutable per run** — Once an eval starts, testset is frozen
2. **Semantic versioning** — `testset_v1.2.0` (major.minor.patch)
3. **Tracked in MLflow** — testset_id as run parameter
4. **Storage** — S3, GCS, or artifact store (NOT in source code if large)

### Testset Quality Checklist

- [ ] Representative of production distribution
- [ ] Includes edge cases and failure modes
- [ ] Ground truth is verified by domain expert
- [ ] No data leakage from training set
- [ ] Size adequate for statistical significance
- [ ] Balanced across relevant categories

---

## Eval Output Contract

### Standard Output Schema

```json
{
    "eval_id": "uuid",
    "eval_status": "passed|failed|error",
    "model": { "name": "...", "version": "..." },
    "testset": { "id": "...", "size": 97 },
    "duration_seconds": 10800,
    "metrics": {
        "pass_rate": 0.92,
        "scorers": {
            "correctness": { "mean": 0.87, "p50": 0.91, "min": 0.32 },
            "semantic_similarity": { "mean": 0.94, "p50": 0.96, "min": 0.71 }
        }
    },
    "mlflow_run_url": "https://...",
    "timestamp": "ISO-8601"
}
```

### Gate Decision Logic

| Metric           | Threshold | Action                          |
| ---------------- | --------- | ------------------------------- |
| `pass_rate`      | ≥ 0.85    | ✅ Pass                         |
| `pass_rate`      | 0.70–0.84 | ⚠️ Review                       |
| `pass_rate`      | < 0.70    | ❌ Block                        |
| `any scorer min` | < 0.20    | ❌ Block (catastrophic failure) |
| `eval_status`    | `error`   | 🔄 Retry (max 2x)               |

---

## Anti-Patterns

| ❌ Don't                                  | ✅ Do                                  |
| ----------------------------------------- | -------------------------------------- |
| Run eval on shared CI/CD agents for hours | Decouple to dedicated compute          |
| Hardcode thresholds                       | Make thresholds configurable per model |
| Skip eval for "small changes"             | At minimum run smoke eval              |
| Use same testset forever                  | Review and update quarterly            |
| Ignore scorer costs                       | Budget scorer calls, use tiered eval   |
| Treat eval as binary pass/fail            | Track trends over time                 |

---

## Decision Checklist

Before implementing evaluation:

- [ ] **Eval mode defined?** (smoke / quick / full)
- [ ] **Scorers selected?** (match business value)
- [ ] **Cost budget calculated?** (compute + API calls)
- [ ] **Output contract agreed?** (schema, thresholds)
- [ ] **Async pattern if > 15 min?**
- [ ] **MLflow tracking configured?**
- [ ] **Testset versioned and frozen?**
- [ ] **Retry/failure handling defined?**

---

> **Remember:** Evaluation exists to prevent bad models from reaching production. It's insurance — under-investing is more expensive than the eval itself.
