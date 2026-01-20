# Runbook — Local prerequisites

## Required tools
- AWS CLI
- Terraform
- kubectl
- (Optional) Helm

## Authentication
- Ensure AWS credentials are configured (e.g., via AWS SSO or access keys)
- Confirm access by running: `aws sts get-caller-identity`

## Conventions
- All provisioning is run from `infra/envs/dev/`
- All Kubernetes applies are run from `k8s/`