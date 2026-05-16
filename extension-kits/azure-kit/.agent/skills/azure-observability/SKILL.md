---
name: azure-observability
description: Azure observability patterns. Application Insights, Azure Monitor, Log Analytics, distributed tracing, alerting. Use when implementing monitoring, logging, or tracing on Azure.
allowed-tools: Read, Glob, Grep, Bash
---

# Azure Observability

> "You can't fix what you can't see. Instrument first, optimize second."

## 🎯 Selective Reading Rule

**Read ONLY files relevant to the request!** Check the content map, find what you need.

| File                     | Description                             | When to Read                |
| ------------------------ | --------------------------------------- | --------------------------- |
| `app-insights.md`        | Application Insights setup and patterns | Instrumenting applications  |
| `log-analytics.md`       | KQL queries, workspace design           | Querying and analyzing logs |
| `distributed-tracing.md` | Cross-service tracing, correlation      | Multi-service debugging     |
| `alerting.md`            | Alert rules, action groups, severity    | Setting up alerts           |
| `dashboards.md`          | Azure dashboards, workbooks             | Building monitoring views   |
| `cross-cloud.md`         | Monitoring hybrid/multi-cloud flows     | Azure ↔ AWS tracing         |

---

## The Three Pillars on Azure

| Pillar      | Azure Service         | Purpose                                      |
| ----------- | --------------------- | -------------------------------------------- |
| **Metrics** | Azure Monitor Metrics | Numeric time-series (CPU, requests, latency) |
| **Logs**    | Log Analytics (KQL)   | Structured log storage and querying          |
| **Traces**  | Application Insights  | Distributed tracing across services          |

---

## Application Insights

### What It Captures Automatically

| Data Type        | Examples                                   |
| ---------------- | ------------------------------------------ |
| **Requests**     | HTTP calls, response times, status codes   |
| **Dependencies** | SQL, HTTP, Azure services calls            |
| **Exceptions**   | Unhandled + tracked exceptions             |
| **Traces**       | Custom log messages (via ILogger, logging) |
| **Performance**  | CPU, memory, request rate                  |
| **Availability** | URL ping tests, multi-step web tests       |

### Instrumentation Patterns

| Language    | Method                                                  |
| ----------- | ------------------------------------------------------- |
| **.NET**    | `AddApplicationInsightsTelemetry()` (auto)              |
| **Python**  | `opencensus-ext-azure` or `azure-monitor-opentelemetry` |
| **Node.js** | `applicationinsights` SDK                               |
| **Java**    | Java agent (auto-instrumentation)                       |

### Custom Telemetry

```python
# Python example
from azure.monitor.opentelemetry import configure_azure_monitor
from opentelemetry import trace

configure_azure_monitor(connection_string="...")

tracer = trace.get_tracer(__name__)

with tracer.start_as_current_span("evaluate_model") as span:
    span.set_attribute("model_version", "42")
    span.set_attribute("testset_size", 97)
    # ... evaluation logic
    span.set_attribute("eval_status", "passed")
```

---

## Log Analytics & KQL

### Essential Queries

```kql
// Failed requests in last 24h
requests
| where timestamp > ago(24h)
| where success == false
| summarize count() by resultCode, bin(timestamp, 1h)
| render timechart

// Slow dependencies
dependencies
| where timestamp > ago(1h)
| where duration > 5000
| project timestamp, name, duration, resultCode
| order by duration desc

// Custom events (e.g., evaluation results)
customEvents
| where name == "EvaluationCompleted"
| extend model = tostring(customDimensions.model_name)
| extend status = tostring(customDimensions.eval_status)
| extend duration = todouble(customDimensions.duration_seconds)
| project timestamp, model, status, duration
```

### Workspace Design

| Approach               | When                            |
| ---------------------- | ------------------------------- |
| **Single workspace**   | Small team, single app          |
| **Per-environment**    | Dev/staging/prod isolation      |
| **Per-team**           | Large org, cross-charge billing |
| **Centralized + RBAC** | Enterprise, audit requirements  |

---

## Distributed Tracing

### Cross-Service Correlation

```
User Request → API Gateway → Service A → Service B → Database
     │              │             │            │          │
     └──────────────┴─────────────┴────────────┴──────────┘
                    Same Operation ID (W3C TraceContext)
```

### Cross-Cloud Tracing (Azure ↔ AWS)

| Challenge                 | Solution                                         |
| ------------------------- | ------------------------------------------------ |
| Different tracing systems | Use W3C TraceContext standard                    |
| Azure DevOps → AWS Batch  | Pass `traceparent` header in job metadata        |
| Correlating logs          | Use shared `operation_id` in both systems        |
| Viewing unified trace     | Export to common backend (Jaeger, Grafana Tempo) |

---

## Alerting

### Alert Severity Levels

| Severity                  | Description                       | Response                  |
| ------------------------- | --------------------------------- | ------------------------- |
| **Sev 0 - Critical**      | Service down, data loss           | Immediate, wake people up |
| **Sev 1 - Error**         | Degraded service, high error rate | Respond within 30 min     |
| **Sev 2 - Warning**       | Approaching limits, slow perf     | Respond within 4h         |
| **Sev 3 - Informational** | Notable event, non-urgent         | Review next business day  |
| **Sev 4 - Verbose**       | Debug information                 | No response required      |

### Essential Alerts

| Alert                   | Metric            | Threshold              |
| ----------------------- | ----------------- | ---------------------- |
| **Service down**        | Availability      | < 99% over 5 min       |
| **High error rate**     | Failed requests % | > 5% over 5 min        |
| **Slow responses**      | P95 latency       | > 3s over 10 min       |
| **Resource exhaustion** | CPU/Memory %      | > 85% over 15 min      |
| **Eval job failed**     | Custom event      | eval_status == "error" |

### Action Groups

| Channel                    | Use For                                  |
| -------------------------- | ---------------------------------------- |
| **Email**                  | Non-urgent, audit trail                  |
| **SMS**                    | On-call rotation                         |
| **Azure DevOps Work Item** | Auto-create bugs                         |
| **Webhook**                | Integration with Slack, Teams, PagerDuty |
| **Logic App**              | Complex automated response               |

---

## Dashboards & Workbooks

### Azure Workbook vs Dashboard

| Feature           | Dashboard      | Workbook                     |
| ----------------- | -------------- | ---------------------------- |
| **Interactivity** | Static tiles   | Dynamic, parameterized       |
| **Data sources**  | Azure Monitor  | Multiple (KQL, REST, custom) |
| **Sharing**       | Portal only    | Portal + link                |
| **Complexity**    | Simple         | Can be very complex          |
| **Best for**      | Quick overview | Deep analysis                |

---

## Anti-Patterns

| ❌ Don't                                      | ✅ Do                                   |
| --------------------------------------------- | --------------------------------------- |
| Log everything at Verbose level in production | Use Warning+ in prod, Debug in dev      |
| Ignore sampling                               | Configure adaptive sampling             |
| Alert on every error                          | Alert on error RATE exceeding threshold |
| Use only portal for queries                   | Version KQL queries in source control   |
| Monitor only infrastructure                   | Monitor business metrics too            |

---

## Decision Checklist

- [ ] **Application Insights configured?** (connection string, SDK)
- [ ] **Custom telemetry for business events?**
- [ ] **Log retention policy set?** (cost vs compliance)
- [ ] **Essential alerts configured?** (availability, errors, latency)
- [ ] **Cross-service correlation working?** (operation ID)
- [ ] **Dashboards/workbooks for team?**
- [ ] **Cost of monitoring estimated?** (ingestion volume)

---

> **Remember:** Observability is not optional. The cost of not seeing a problem is always higher than the cost of monitoring.
