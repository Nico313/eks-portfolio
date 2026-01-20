# Overview

This repository is a portfolio-grade implementation of an AWS EKS platform, emphasizing reproducibility, clear responsibility boundaries, and operational clarity.

## Goals
- Provision an EKS cluster and supporting AWS resources using Terraform.
- Establish a Kubernetes “baseline” (namespaces/RBAC/add-ons) after cluster creation.
- Deploy example workloads to validate platform functionality.
- Document decisions and provide runbooks to reproduce the system end-to-end.

## Non-goals
- Building a feature-rich application or microservice product.
- Advanced production hardening for all edge cases (this is intentionally scoped).
- Storing secrets in Git or committing infrastructure state.

## Responsibility boundaries
- `infra/`: AWS resources and EKS provisioning (Terraform). Ends when the cluster exists.
- `k8s/`: Everything applied inside the cluster (baseline + workloads). Assumes the cluster exists.
- `docs/`: Architecture and runbooks that explain and reproduce the setup.