# infra/

Terraform code to provision AWS infrastructure and the EKS cluster.

## Scope
Includes: VPC/networking, EKS control plane, node groups, and supporting AWS resources.

## Boundaries
- No Kubernetes manifests here.
- Do not commit Terraform state (`*.tfstate`) or credentials.

## Entry point
- Environment wiring lives in `envs/dev/`
- Reusable modules live in `modules/`

