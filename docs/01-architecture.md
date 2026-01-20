# Architecture

## High-level design
The solution is split into two lifecycles:

1. **Cloud infrastructure lifecycle (`infra/`)**
   - AWS VPC + networking primitives
   - EKS control plane and node groups
   - Supporting AWS resources as needed

2. **Cluster lifecycle (`k8s/`)**
   - Baseline cluster configuration (namespaces, RBAC, add-ons)
   - Example workloads (services, deployments, ingress)

This separation prevents tool/lifecycle coupling and makes the repository reviewable.

## Environments
Terraform is organized as:
- `infra/modules/`: reusable Terraform modules (vpc, eks, ecr, dynamodb, …)
- `infra/envs/dev/`: an example environment wiring modules together

## Kubernetes layout
Kubernetes resources are organized by intent:
- `k8s/cluster-baseline/`: baseline resources required for cluster usability/operability
- `k8s/apps/`: workloads deployed to validate the platform

Some additional folders may exist due to iteration; the canonical paths are referenced above.