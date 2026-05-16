---
name: cost-management
description: Cost estimation, budget tracking, Earned Value Management (EVM), and financial forecasting. Use when managing project budgets, tracking costs, or reporting financial status.
---

# Cost Management

> Principles for estimating, budgeting, tracking, and controlling project costs.

---

## When to Use

- Project initiation (budget estimation)
- Monthly budget tracking
- Earned Value analysis for status reports
- Variance analysis and forecasting
- Cost-benefit analysis for decisions

---

## Cost Estimation Methods

| Method          | Accuracy | When to Use                               |
| --------------- | :------: | ----------------------------------------- |
| **Analogous**   | ±25-50%  | Early stage, similar past projects        |
| **Parametric**  | ±15-25%  | Historical data available ($/story point) |
| **Bottom-Up**   |  ±5-15%  | Detailed WBS available                    |
| **Three-Point** | ±10-20%  | Uncertainty, need confidence ranges       |

### Bottom-Up Template

```markdown
| WBS Item          | Hours | Rate (€/hr) |  Cost (€)  |
| ----------------- | :---: | :---------: | :--------: |
| [task 1]          |  40   |     75      |   3,000    |
| [task 2]          |  80   |     75      |   6,000    |
| **Subtotal**      |       |             | **9,000**  |
| Contingency (15%) |       |             |   1,350    |
| **Total**         |       |             | **10,350** |
```

---

## Budget Tracking

### Budget Status Template

```markdown
## Budget Status — [Project Name]

**Period:** [Month/Sprint]

| Category       |   Budget    |   Actual    |  Variance   | % Used  |
| -------------- | :---------: | :---------: | :---------: | :-----: |
| Development    |   €50,000   |   €42,000   |   +€8,000   |   84%   |
| Infrastructure |   €10,000   |   €11,500   |   -€1,500   | 115% ⚠️ |
| Testing        |   €15,000   |   €12,000   |   +€3,000   |   80%   |
| **Total**      | **€75,000** | **€65,500** | **+€9,500** | **87%** |

Project Completion: 75%
Budget Health: 🟢 Under budget
```

---

## Earned Value Management (EVM)

### Key Metrics

| Metric                           | Formula             | Meaning                    |
| -------------------------------- | ------------------- | -------------------------- |
| **PV** (Planned Value)           | Budget × % planned  | What should be done by now |
| **EV** (Earned Value)            | Budget × % complete | What IS done by now        |
| **AC** (Actual Cost)             | Sum of actual costs | What it actually cost      |
| **SPI** (Schedule Performance)   | EV / PV             | Schedule efficiency        |
| **CPI** (Cost Performance)       | EV / AC             | Cost efficiency            |
| **SV** (Schedule Variance)       | EV - PV             | Ahead/behind schedule (€)  |
| **CV** (Cost Variance)           | EV - AC             | Under/over budget (€)      |
| **EAC** (Estimate at Completion) | BAC / CPI           | Forecasted total cost      |
| **ETC** (Estimate to Complete)   | EAC - AC            | Remaining cost             |

### Interpreting EVM

| SPI | CPI | Status                                |
| :-: | :-: | ------------------------------------- |
| > 1 | > 1 | 🟢 Ahead of schedule AND under budget |
| > 1 | < 1 | 🟡 Ahead but over budget              |
| < 1 | > 1 | 🟡 Behind but under budget            |
| < 1 | < 1 | 🔴 Behind AND over budget             |

### EVM Dashboard Template

```markdown
## EVM Dashboard — Sprint [N]

| Metric                     |  Value   |           Status            |
| -------------------------- | :------: | :-------------------------: |
| BAC (Budget at Completion) | €100,000 |              —              |
| PV (Planned Value)         | €60,000  |              —              |
| EV (Earned Value)          | €55,000  |              —              |
| AC (Actual Cost)           | €52,000  |              —              |
| SPI                        |   0.92   |     🟡 Slightly behind      |
| CPI                        |   1.06   |       🟢 Under budget       |
| SV                         | -€5,000  | Behind by €5K worth of work |
| CV                         | +€3,000  |        Under by €3K         |
| EAC                        | €94,340  |      Forecasted total       |
| ETC                        | €42,340  |     Remaining to spend      |
```

---

## Cost-Benefit Analysis

```markdown
| Factor               | Option A | Option B |
| -------------------- | :------: | :------: |
| Development Cost     | €30,000  | €45,000  |
| Maintenance (annual) | €10,000  |  €5,000  |
| Time to Market       | 6 weeks  | 8 weeks  |
| Risk Level           |    🟡    |    🟢    |
| 3-Year TCO           | €60,000  | €55,000  |
| **Recommendation**   |          |  **✅**  |
```

---

## Anti-Patterns

- ❌ No budget tracking until project end
- ❌ Ignoring EVM signals (SPI/CPI < 0.8)
- ❌ Contingency as "extra budget" not risk buffer
- ❌ Sunk cost fallacy (continuing because we already spent)
- ❌ Not separating capital vs operational costs
