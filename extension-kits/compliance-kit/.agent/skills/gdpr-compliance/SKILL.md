---
name: gdpr-compliance
description: GDPR compliance validation for code and data pipelines. PII sanitization, anonymization, data retention, logging audit, consent management, data subject rights, DPIA, privacy by design, breach notification. Use when analyzing data handling practices for GDPR compliance.
version: 1.0.0
---

# GDPR Compliance — General Data Protection Regulation

> Validate data handling practices, code, and pipelines against GDPR requirements for personal data protection.

**Prerequisite:** Load `compliance-core` for report template and information gathering protocol.

---

## 1. Regulatory Context

### Key Principles (Art. 5)

| Principle                       | Meaning                             | Technical Implication                                 |
| ------------------------------- | ----------------------------------- | ----------------------------------------------------- |
| **Lawfulness**                  | Legal basis for processing          | Consent mechanisms, legitimate interest documentation |
| **Purpose limitation**          | Process only for specified purposes | Data flow documentation, access controls              |
| **Data minimisation**           | Collect only what's necessary       | Schema design, field-level review                     |
| **Accuracy**                    | Keep data correct and up-to-date    | Update mechanisms, validation                         |
| **Storage limitation**          | Don't keep longer than needed       | Retention policies, automated deletion                |
| **Integrity & confidentiality** | Protect against unauthorized access | Encryption, access controls, audit logs               |
| **Accountability**              | Demonstrate compliance              | Documentation, DPIAs, records of processing           |

### Key Articles for Technical Teams

| Article    | Requirement                              | Focus                                         |
| ---------- | ---------------------------------------- | --------------------------------------------- |
| Art. 25    | Data protection by design and by default | Architecture, defaults                        |
| Art. 32    | Security of processing                   | Encryption, access control, resilience        |
| Art. 33    | Breach notification (72h to authority)   | Incident response                             |
| Art. 35    | DPIA for high-risk processing            | Risk assessment                               |
| Art. 15-22 | Data subject rights                      | API/tooling for access, deletion, portability |
| Art. 28    | Processor obligations                    | Third-party DPAs                              |
| Art. 30    | Records of processing activities         | Documentation                                 |

---

## 2. Compliance Checks

### Check 1: PII Sanitization in Data Pipelines (Art. 25, Art. 32)

**Question:** Is personal data sanitized/masked before processing or storage?

| Evidence                                                          | Location                              |
| ----------------------------------------------------------------- | ------------------------------------- |
| **Libraries:** `presidio`, `scrubadub`, `spacy` NER, custom regex | Dependency files                      |
| **Sanitization scripts:** PII masking in ETL                      | Data pipeline scripts, ingestion code |
| **Preprocessing step:** anonymization before model training       | ML pipeline config                    |
| **Regex patterns:** email, phone, SSN masking                     | Utility functions, data transformers  |

**🔴 Critical if:** Data ingestion pipeline processes PII without any sanitization step.
**🟡 Warning if:** Sanitization exists but not automated (manual process).

---

### Check 2: Data Anonymization/Pseudonymization (Art. 25(1))

**Question:** Are anonymization or pseudonymization techniques applied?

| Evidence                                               | Location                 |
| ------------------------------------------------------ | ------------------------ |
| **Anonymization:** k-anonymity, differential privacy   | Data processing scripts  |
| **Pseudonymization:** tokenization, hashing with salt  | Data transformation code |
| **Tools:** `ARX`, `sdcMicro`, `OpenDP`, `cape-privacy` | Dependency files         |
| **Documentation:** anonymization methodology described | Data processing docs     |

**🟡 Warning if:** No anonymization technique documented or implemented.

---

### Check 3: Data Retention Policies (Art. 5(1)(e))

**Question:** Are data retention policies defined and enforced?

| Evidence                                                   | Location                                 |
| ---------------------------------------------------------- | ---------------------------------------- |
| **TTL settings:** database TTL, object expiration          | Database config, cloud storage lifecycle |
| **Scheduled deletion:** cron jobs, automated cleanup       | Scheduled tasks, Lambda/Functions        |
| **Retention documentation:** defined periods per data type | Policy docs, data catalog                |
| **Archival process:** move to cold storage before deletion | Data lifecycle config                    |

**🔴 Critical if:** Personal data stored with no retention policy or deletion mechanism.
**🟡 Warning if:** Retention policy documented but not enforced in code.

---

### Check 4: PII in Application Logs (Art. 5(1)(f), Art. 32)

**Question:** Do application logs contain personal data in plaintext?

| Evidence                               | Detection Method                                                   |
| -------------------------------------- | ------------------------------------------------------------------ |
| **Log statements** with user data      | `grep` for `log.*email`, `log.*name`, `log.*phone`, `log.*address` |
| **Request logging** with full body     | Middleware logging configuration                                   |
| **Error logs** with user context       | Error handling code                                                |
| **Structured logging** with PII fields | Log format configuration                                           |

**🔴 Critical if:** Logs print PII in plaintext (email, name, phone, address, IP).
**🟡 Warning if:** Logging exists but no explicit PII filtering/masking configured.

### Detection Patterns

Search for these patterns in log statements:

```
log.*(email|name|phone|address|ssn|birth|passport|credit.?card)
print.*(user|customer|patient|employee)
logger.*(personal|private|sensitive)
console.log.*(email|password|token)
```

---

### Check 5: Consent Management (Art. 6, Art. 7)

**Question:** Are consent mechanisms implemented for data collection?

| Evidence                                          | Location                        |
| ------------------------------------------------- | ------------------------------- |
| **Consent UI:** cookie banners, consent forms     | Frontend code, components       |
| **Consent storage:** consent records database     | Database schema, API endpoints  |
| **Consent API:** endpoints for granting/revoking  | API routes, controllers         |
| **Granular consent:** per-purpose consent options | Frontend/backend implementation |

**🟡 Warning if:** User-facing application with no consent mechanism.

---

### Check 6: Data Subject Rights Implementation (Art. 15-22)

**Question:** Are technical mechanisms in place for data subject rights?

| Right             | Article | Technical Implementation                     |
| ----------------- | ------- | -------------------------------------------- |
| **Access**        | Art. 15 | API to export user's data                    |
| **Rectification** | Art. 16 | API to update personal data                  |
| **Erasure**       | Art. 17 | API to delete user + cascading deletion      |
| **Portability**   | Art. 20 | Export in machine-readable format (JSON/CSV) |
| **Restriction**   | Art. 18 | Mechanism to restrict processing             |
| **Objection**     | Art. 21 | Opt-out mechanism                            |

| Evidence                  | Location                            |
| ------------------------- | ----------------------------------- |
| Admin/user API endpoints  | API routes, controllers             |
| Data export functionality | Admin tools, user dashboard         |
| Account deletion flow     | Application code, database cascades |

**🟡 Warning if:** Application handles personal data but has no data subject rights endpoints.

---

### Check 7: DPIA — Data Protection Impact Assessment (Art. 35)

**Question:** Is a DPIA documented for high-risk processing?

| High-Risk Processing Triggers                         |
| ----------------------------------------------------- |
| Systematic evaluation of personal aspects (profiling) |
| Large-scale processing of special categories of data  |
| Systematic monitoring of publicly accessible areas    |
| Automated decision-making with legal effects          |
| Combination of datasets from different sources        |
| New technologies applied to personal data             |

| Evidence            | Location                    |
| ------------------- | --------------------------- |
| DPIA document       | `/docs/`, compliance folder |
| Risk assessment     | Security documentation      |
| Mitigation measures | DPIA document               |

**🟡 Warning if:** High-risk processing detected with no DPIA document.

---

### Check 8: Privacy by Design (Art. 25)

**Question:** Are privacy-first architectural patterns implemented?

| Pattern                | Look For                                       |
| ---------------------- | ---------------------------------------------- |
| **Data minimization**  | Collecting only necessary fields               |
| **Purpose separation** | Separate databases/services per purpose        |
| **Default privacy**    | strictest settings as default                  |
| **Access control**     | field-level access restrictions                |
| **Encryption**         | personal data encrypted at rest and in transit |

| Evidence                                      | Location                           |
| --------------------------------------------- | ---------------------------------- |
| Architecture documentation mentioning privacy | Architecture docs                  |
| Field-level encryption                        | Database models, encryption config |
| Data classification scheme                    | Documentation, code comments       |

**🟡 Warning if:** No privacy-by-design patterns evident in architecture.
**Cross-ref:** NIS2 Art. 21(2)(e) for encryption requirements.

---

### Check 9: Data Breach Notification Process (Art. 33, Art. 34)

**Question:** Is there a breach notification process with GDPR timelines?

| Requirement               | Timeline            | To Whom                                       |
| ------------------------- | ------------------- | --------------------------------------------- |
| Authority notification    | 72 hours            | Supervisory authority (Garante Privacy in IT) |
| Data subject notification | Without undue delay | Affected individuals (if high risk)           |

| Evidence                 | Location                     |
| ------------------------ | ---------------------------- |
| Breach notification plan | Security docs, `SECURITY.md` |
| 72h timeline documented  | Incident response plan       |
| Communication templates  | Documentation                |

**🟡 Warning if:** No breach notification process documented.
**Cross-ref:** NIS2 Art. 23 (24h/72h incident reporting).

---

### Check 10: Third-Party Data Processing Agreements (Art. 28)

**Question:** Are DPAs in place with data processors?

| Evidence                    | Location                            |
| --------------------------- | ----------------------------------- |
| DPA documentation           | Legal/compliance docs               |
| Vendor list with DPA status | Documentation                       |
| Sub-processor notification  | Documentation                       |
| Data flow to third parties  | Architecture docs, integration code |

**🟡 Warning if:** Third-party integrations exist without documented DPAs.

---

### Check 11: Cross-Border Data Transfers (Art. 44-49)

**Question:** Are mechanisms in place for data transfers outside the EU/EEA?

| Evidence                                                | Location                              |
| ------------------------------------------------------- | ------------------------------------- |
| **Cloud region:** EU-only deployment                    | IaC config, cloud settings            |
| **SCCs:** Standard Contractual Clauses                  | Legal documentation                   |
| **Adequacy decisions:** transfers to adequate countries | Documentation                         |
| **Data residency:** configuration for EU data residency | Cloud storage config, database config |

**🟡 Warning if:** Cloud resources deployed outside EU with no transfer mechanism documented.

---

## 3. Remediation Toolkit

### Quick Wins

| Gap                 | Tool / Approach                                        |
| ------------------- | ------------------------------------------------------ |
| No PII sanitization | Add `presidio` analyzer + anonymizer in ETL pipeline   |
| PII in logs         | Implement log scrubbing middleware with regex/presidio |
| No retention policy | Add TTL to database records + scheduled cleanup jobs   |
| No data export      | Create `/api/user/data-export` endpoint returning JSON |
| No account deletion | Create `/api/user/delete` with cascading cleanup       |
| No DPIA             | Use ICO's DPIA template as starting document           |

### Example: PII-Safe Logging Middleware (Python)

```python
import re
import logging

class PIIFilter(logging.Filter):
    """Filter PII from log records."""

    PATTERNS = [
        (r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', '[EMAIL_REDACTED]'),
        (r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b', '[PHONE_REDACTED]'),
        (r'\b\d{2}/\d{2}/\d{4}\b', '[DATE_REDACTED]'),
        (r'\b[A-Z]{2}\d{7}\b', '[PASSPORT_REDACTED]'),
    ]

    def filter(self, record):
        msg = record.getMessage()
        for pattern, replacement in self.PATTERNS:
            msg = re.sub(pattern, replacement, msg)
        record.msg = msg
        record.args = ()
        return True

# Usage
logger = logging.getLogger(__name__)
logger.addFilter(PIIFilter())
```

### Example: Data Retention Cron (SQL)

```sql
-- Delete personal data older than retention period
DELETE FROM user_data
WHERE created_at < NOW() - INTERVAL '2 years'
AND data_category = 'personal';

-- Archive before deletion (optional)
INSERT INTO user_data_archive
SELECT * FROM user_data
WHERE created_at < NOW() - INTERVAL '2 years'
AND data_category = 'personal';
```

---

## 4. Anti-Patterns

| ❌ Don't                             | ✅ Do                                       |
| ------------------------------------ | ------------------------------------------- |
| Log full request/response bodies     | Log only non-PII metadata                   |
| Store PII "just in case"             | Apply data minimization                     |
| Anonymize only at display layer      | Anonymize at ingestion/storage              |
| Use plain deletion only              | Implement cryptographic erasure for backups |
| Treat consent as a one-time checkbox | Track consent per purpose, allow withdrawal |

---

> **Remember:** GDPR applies to ANY system processing personal data of EU residents, regardless of where the system is hosted. When in doubt, assume personal data is present.
