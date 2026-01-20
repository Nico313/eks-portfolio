# Runbook — Deploy (infra → k8s)

## 1. Provision infrastructure
From repository root:

```bash
cd infra/envs/dev
terraform init
terraform plan
terraform apply