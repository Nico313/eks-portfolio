# Phases

## Phase 0 — Repository initialization
- Establish clean Git history and default branch (`main`)
- Ensure repository can be pushed/pulled and reviewed

## Phase 1 — Repository skeleton and boundaries
- Freeze top-level structure (`docs/`, `infra/`, `k8s/`)
- Define responsibility boundaries and “golden path”
- Add canonical documentation entry points and runbook structure

## Phase 2 — Infrastructure provisioning (Terraform)
- Confirm `infra/envs/dev` provisions VPC/EKS successfully
- Validate outputs and access patterns (kubeconfig)
- Ensure state handling is correct (no state committed to Git)

## Phase 3 — Kubernetes baseline
- Apply namespaces/RBAC and essential add-ons
- Validate cluster health and baseline observability

## Phase 4 — Workloads and validation
- Deploy example workloads
- Validate ingress/networking/service discovery
- Document expected outcomes and verification steps

## Phase 5 — Hardening and polish (portfolio-ready)
- Tighten docs, troubleshooting, and reproducibility
- Optional: security and operational improvements where appropriate