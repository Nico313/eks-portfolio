# k8s/

Kubernetes baseline configuration and example workloads applied after the EKS cluster exists.

## Scope
- `cluster-baseline/`: namespaces, RBAC, add-ons
- `apps/`: example workloads used to validate the platform

## Boundaries
- No AWS provisioning (Terraform) lives here.
- Keep secrets out of Git; use appropriate secret management approaches.

