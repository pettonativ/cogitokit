# 🧰 GCP Kit

**Reusable Terraform modules and best practices for Google Cloud Platform.**

A collection of opinionated, Scale-to-Zero Terraform modules designed for serverless workloads on GCP with strict budget constraints (< 8€/month).

## 📐 Design Principles

- **Scale-to-Zero**: Every resource supports zero idle costs. Only Cloud Run and Cloud Functions are used — no always-on instances.
- **Budget-first**: All modules are designed to stay within a 10 USD/month credit (~8€/month target).
- **Reusable**: Generic modules consumable by any project via `git::https://github.com/pettonativ/gcp-kit.git//modules/<module-name>`.

## 📦 Modules

### `cloud-run-service`

Deploys a containerized service to Cloud Run with Scale-to-Zero enforced.

**Features:**

- `min_instances = 0` (zero idle costs)
- Startup CPU Boost for cold start mitigation
- Configurable CPU, memory, environment variables
- Startup probe for heavy containers (ML models, etc.)
- Optional unauthenticated access

**Usage:**

```hcl
module "my_service" {
  source = "git::https://github.com/pettonativ/gcp-kit.git//modules/cloud-run-service"

  project_id = "my-project-id"
  name       = "my-service"
  image      = "europe-west1-docker.pkg.dev/my-project/my-repo/my-image:latest"

  cpu    = "1000m"
  memory = "512Mi"

  env_vars = [
    { name = "LOG_LEVEL", value = "INFO" },
  ]
}
```

### `artifact-registry`

Creates a Docker repository on Google Artifact Registry.

**Usage:**

```hcl
module "docker_registry" {
  source = "git::https://github.com/pettonativ/gcp-kit.git//modules/artifact-registry"

  project_id    = "my-project-id"
  repository_id = "my-repo"
  description   = "Docker repository for my service"
}
```

## 📁 Repository Structure

```
gcp-kit/
├── instructions.md          # Budget constraints and architectural rules
├── modules/
│   ├── cloud-run-service/   # Reusable Cloud Run module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── artifact-registry/   # Reusable Artifact Registry module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── .agents/
    └── skills/              # AI agent skills for GCP development
```

## 🔗 Projects Using GCP Kit

| Project                                                                | Description                                    |
| ---------------------------------------------------------------------- | ---------------------------------------------- |
| [mcp-privacy-server](https://github.com/pettonativ/mcp-privacy-server) | Document anonymization MCP server on Cloud Run |

## License

MIT
