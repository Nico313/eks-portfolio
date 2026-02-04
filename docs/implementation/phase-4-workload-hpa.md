# Phase 4 – Workload & Scaling (cost-aware)

## Objective
Demonstrate that the governance and security baseline established in Phase 3 (namespaces, PSA baseline, resource governance, RBAC) supports real workloads — including Horizontal Pod Autoscaler (HPA) — without introducing cost-intensive components such as ALB/Ingress.

## Scope / Constraints
- The cluster is created only on demand and destroyed after testing (`terraform apply` → demo → `terraform destroy`)
- No ingress/ALB component in Phase 4 (access via ClusterIP + port-forward)
- Namespace separation is maintained: `platform` (add-ons), `apps` (workloads)
- PSA: `baseline` (enforce/audit/warn) on namespace `apps`

## Implementation

### Workload
- `k8s/apps/hello/deployment.yaml`
  - 1 replica (baseline)
  - requests/limits defined (CPU/Memory)
  - PSA-baseline compatible securityContext (no privileged mode, drop ALL caps, no privilege escalation)
- `k8s/apps/hello/service.yaml`
  - ClusterIP service as stable internal endpoint and for port-forward testing

### Autoscaling (HPA)
- Installation of `metrics-server` as minimal prerequisite for Metrics API
- `k8s/apps/hello/hpa.yaml`
  - minReplicas=1, maxReplicas=3
  - target CPU utilization 50%
  - `behavior.scaleDown` configured (stabilizationWindowSeconds=30) for predictable downscaling during demos

## Demo Runbook (short form)
1. Provision cluster: `terraform plan -out=tfplan` → `terraform apply tfplan`
2. kubectl access: `aws eks update-kubeconfig ...` → `kubectl get nodes`
3. Namespace + PSA:
   - `kubectl create ns apps`
   - `kubectl label ns apps pod-security...=baseline`
4. Deploy workload:
   - `kubectl apply -f k8s/apps/hello/`
   - Test via `kubectl -n apps port-forward svc/hello 8080:80` + `curl`
5. Metrics/HPA:
   - `kubectl apply -f https://.../metrics-server/.../components.yaml`
   - `kubectl top nodes`
   - `kubectl apply -f k8s/apps/hello/hpa.yaml`
6. Scale demo:
   - Generate load (busybox wget loop) → HPA scales up
   - Stop load → HPA scales down (controlled via behavior)
7. Cleanup:
   - Delete k8s resources, then `terraform destroy`

## Result
- End-to-end proof: workload deployment + HPA on EKS with Phase 3 governance
- Cost control: no ALB/Ingress; cluster operated only temporarily