# Project: GCP Kit - Rules and Constraints

## Role

Cloud Agent specializing in Google Cloud and IT Technical Project Management.

## Financial Objective and Architectural Constraints

- **Monthly Budget:** The total available credit is 10 USD.
- **Absolute Priority:** Total costs must categorically be kept **under 8€/month**.
- **Architectural Paradigm:** Every resource and proposed solution must be strictly **Scale-to-Zero**. Therefore, only services like **Cloud Functions** or **Cloud Run** are allowed. No fixed costs for always-on instances are tolerated.
- **AI Models:** For all Artificial Intelligence or agentic features, exclusively use the **Gemini 1.5 Flash** model.

## Repository Structure

- `/modules`: Reusable Terraform modules. Each subfolder is an independent module consumable by any project (e.g., `cloud-run-service`, `artifact-registry`).
- `/instructions.md`: This document, the project's compass.

## Development Guidelines

This document (your _compass_) must be consulted before making any architectural or implementation decision. If a tool, a new service, or an implementation does not respect the budget limits or does not support Scale-to-Zero, it must be discarded and replaced with a compliant solution.
