---
description: Verifica di compliance normativa. Analizza codice, pipeline, IaC e documentazione contro regolamenti EU (AI Act, NIS2, GDPR, DORA) e standard internazionali (ISO 27001).
---

# /compliance — Regulatory Compliance Audit

## Overview

Esegue un audit di compliance normativa su un progetto, identificando gap rispetto ai regolamenti selezionati.

## Workflow

### Step 1: Identificazione Scope

Chiedi all'utente:

1. **Quale directory/progetto vuoi analizzare?**
2. **Quali normative vuoi verificare?** (o "tutte" per un audit completo)
   - AI Act (sistemi AI/ML)
   - NIS2 (infrastruttura e cybersecurity)
   - GDPR (protezione dati personali)
   - DORA (resilienza operativa digitale — settore finanziario)
   - ISO 27001 (ISMS)

### Step 2: Classificazione Progetto

Analizza il progetto per determinare il dominio:

- Leggi `README.md` e documentazione architetturale
- Identifica il tipo di progetto (AI/ML, webapp, API, infrastruttura, ETL, ecc.)
- Suggerisci quali normative sono rilevanti in base al dominio

### Step 3: Information Gathering

Segui il protocollo di `compliance-core`:

- Scansiona file di dipendenze (`requirements.txt`, `package.json`, `pom.xml`, `pyproject.toml`)
- Scansiona pipeline CI/CD (`.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, `azure-pipelines.yml`)
- Scansiona IaC (`.tf`, `.yaml` Kubernetes, Helm charts)
- Leggi documentazione tecnica

### Step 4: Gap Analysis

Per ogni normativa selezionata:

1. Carica la skill specifica (es. `ai-act-compliance`)
2. Esegui i check definiti nella skill
3. Raccogli evidenze (trovate) e gap (mancanti)
4. Verifica le correlazioni cross-normativa tramite `compliance-core`

### Step 5: Report

Genera il report unificato usando il template di `compliance-core`:

- 🔴 CRITICITÀ (bloccanti)
- 🟡 WARNING (da mitigare)
- 🟢 CONTROLLI SUPERATI
- 🛠️ AZIONI DI REMEDIATION

### Step 6: Follow-up

Chiedi all'utente se vuole:

- Approfondire una specifica criticità
- Generare snippet di remediation per un gap specifico
- Salvare il report come artifact

## Notes

- Usa `@compliance-auditor` come agente
- Il workflow è interattivo: chiedi conferma prima di procedere con l'analisi
- Se il compliance-kit non è nel workspace, informa l'utente che deve aprirlo
