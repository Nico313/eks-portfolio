# eks-portfolio

Portfolio repository demonstrating the build and operation of an AWS EKS platform using Infrastructure as Code (Terraform) plus Kubernetes platform baseline and example workloads.

## What this repo contains
- **Infrastructure (`infra/`)**: AWS networking + EKS cluster + supporting resources (Terraform modules and a `dev` environment).
- **Kubernetes (`k8s/`)**: Cluster baseline configuration and example workloads applied after the cluster exists.
- **Documentation (`docs/`)**: Architecture, phases, and runbooks to reproduce the setup.

## Repository structure (source of truth)
- `infra/` – Provision AWS resources and EKS (Terraform). No Kubernetes manifests here.
- `k8s/` – Apply cluster baseline and workloads (kubectl manifests). No AWS provisioning here.
- `docs/` – Architecture decisions and runbooks.

> Note: Some older files/folders may exist alongside the “source of truth” paths above; the docs referenced here are canonical.

## Golden path (high level)
1. Provision AWS infrastructure and EKS cluster (`infra/`).
2. Configure cluster access (kubeconfig).
3. Apply Kubernetes baseline and deploy workloads (`k8s/`).

## What this project demonstrates in practice
- A reproducible EKS platform built with Terraform and Kubernetes manifests
- Governance baseline: namespaces, RBAC, resource quotas, and Pod Security Admission
- Autoscaling using metrics-server and Horizontal Pod Autoscaler without ALB/Ingress costs
- Clean separation of authentication and authorization via EKS Access Entry and Kubernetes RBAC
- Cost-aware lifecycle: apply → demo → destroy with no standing resources

Detailed steps:
- Local prerequisites: `docs/03-runbook-local.md`
- Deployment runbook: `docs/04-runbook-deploy.md`

## Phases
Project execution is structured in phases to keep the repository reviewable and reproducible:
- `docs/02-phases.md`
- Each phase adds a concrete capability: baseline governance (Phase 3), workload + HPA (Phase 4), and IAM/RBAC least privilege via Access Entry (Phase 5).

## Assumptions
- AWS account and permissions to provision EKS-related resources
- Installed locally: Terraform, AWS CLI, kubectl