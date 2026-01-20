
---

### 7) `docs/05-troubleshooting.md`
```md
# Troubleshooting

## Terraform issues
- Re-run `terraform init` after provider/version changes
- If auth fails: confirm `aws sts get-caller-identity`

## Kubernetes access issues
- Confirm kubeconfig context: `kubectl config current-context`
- Re-run `aws eks update-kubeconfig ...`

## Common signals
- `kubectl get pods -A` to identify failing system components
- `kubectl describe <resource>` for events

