---
name: resource-management
description: Team capacity planning, skill matrix, workload balancing, and resource allocation. Use when planning team assignments, assessing capacity, or managing workload distribution.
---

# Resource Management

> Principles for planning, allocating, and optimizing team resources.

---

## When to Use

- Sprint or project capacity planning
- Team formation or restructuring
- Workload balancing
- Skill gap identification
- Hiring or training decisions

---

## Skill Matrix

Map team capabilities to project needs:

```markdown
## Skill Matrix — [Team Name]

| Member | Frontend | Backend | DevOps |   QA   | Architecture |   PM   |
| ------ | :------: | :-----: | :----: | :----: | :----------: | :----: |
| @dev1  |  ⭐⭐⭐  |  ⭐⭐   |   ⭐   |   ⭐   |      ⭐      |   —    |
| @dev2  |    ⭐    | ⭐⭐⭐  |  ⭐⭐  |   ⭐   |     ⭐⭐     |   —    |
| @dev3  |   ⭐⭐   |  ⭐⭐   | ⭐⭐⭐ |   ⭐   |     ⭐⭐     |   —    |
| @qa1   |    ⭐    |   ⭐    |   —    | ⭐⭐⭐ |      —       |   —    |
| @pm1   |    ⭐    |   ⭐    |   —    |   ⭐   |     ⭐⭐     | ⭐⭐⭐ |

⭐ = Basic | ⭐⭐ = Proficient | ⭐⭐⭐ = Expert
```

### Identifying Risks

- **Single point of failure:** Only one ⭐⭐⭐ in a critical area
- **Skill gap:** No one above ⭐ in a required area
- **Bottleneck:** Too many tasks depend on one person

---

## Capacity Planning

### Sprint Capacity

```
Individual Capacity = Available Days × Focus Hours/Day × Focus Factor

Focus Factor:
- Meetings/overhead: 0.8
- On-call rotation: 0.6
- Part-time on project: adjusted per %
```

### Capacity Template

```markdown
## Sprint [N] Capacity

| Member    | Available Days | Focus Factor  | Capacity (hrs) |   Allocated   |
| --------- | :------------: | :-----------: | :------------: | :-----------: |
| @dev1     |       10       |      0.8      |       48       |   45 (94%)    |
| @dev2     | 8 (2 days PTO) |      0.8      |       38       |   35 (92%)    |
| @dev3     |       10       | 0.6 (on-call) |       36       |   30 (83%)    |
| @qa1      |       10       |      0.8      |       48       |   40 (83%)    |
| **Total** |                |               |    **170**     | **150 (88%)** |

Target allocation: 80-90% (leave buffer for unplanned work)
```

---

## Workload Balancing

### Indicators

| Signal                              | Action                                     |
| ----------------------------------- | ------------------------------------------ |
| Someone consistently >95% allocated | Reduce scope or redistribute               |
| Someone consistently <60% allocated | Assign more or pair with overloaded member |
| Bus factor = 1 for critical path    | Cross-train or pair program                |
| WIP per person > 3                  | Enforce WIP limits                         |

### Balancing Strategies

1. **Pair programming** — Share knowledge, reduce bus factor
2. **Rotation** — Move people across areas quarterly
3. **Cross-training** — Dedicated time for skill development
4. **Swarming** — Entire team focuses on one bottleneck item

---

## Resource Allocation Matrix

```markdown
| Project/Feature |  @dev1   |  @dev2   |  @dev3   |   @qa1   |
| --------------- | :------: | :------: | :------: | :------: |
| Feature A       |   60%    |    —     |   20%    |   40%    |
| Feature B       |    —     |   80%    |    —     |   30%    |
| Maintenance     |   20%    |   20%    |   20%    |   30%    |
| On-call         |    —     |    —     |   60%    |    —     |
| Training        |   20%    |    —     |    —     |    —     |
| **Total**       | **100%** | **100%** | **100%** | **100%** |
```

---

## Anti-Patterns

- ❌ Allocating 100% of capacity (no buffer)
- ❌ Ignoring skill gaps until they block delivery
- ❌ Bus factor of 1 for critical systems
- ❌ Not accounting for meetings, on-call, PTO
- ❌ Treating all team members as interchangeable
