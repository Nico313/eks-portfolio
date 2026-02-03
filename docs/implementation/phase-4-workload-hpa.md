# Phase 4 – Workload & Skalierung (kostenbewusst)

## Ziel
Nachweis, dass die in Phase 3 etablierte Governance- und Security-Baseline (Namespaces, PSA baseline, Resource Governance, RBAC) reale Workloads trägt – inklusive Horizontal Pod Autoscaler (HPA) – ohne kostenintensive Komponenten wie ALB/Ingress.

## Scope / Leitplanken
- Cluster wird nur bei Bedarf erstellt und nach Tests wieder zerstört (`terraform apply` → Demo → `terraform destroy`)
- Keine Ingress/ALB-Komponente in Phase 4 (Zugriff über ClusterIP + Port-Forward)
- Namespace-Trennung bleibt: `platform` (Add-ons), `apps` (Workloads)
- PSA: `baseline` (enforce/audit/warn) auf `apps`

## Implementierung

### Workload
- `k8s/apps/hello/deployment.yaml`
  - 1 Replica (Baseline)
  - Requests/Limits gesetzt (CPU/Memory)
  - PSA-baseline-kompatibler SecurityContext (kein Privileged, drop ALL caps, no privilege escalation)
- `k8s/apps/hello/service.yaml`
  - ClusterIP Service als stabiler Endpoint für interne Kommunikation und Port-Forward

### Autoscaling (HPA)
- Installation `metrics-server` als minimale Voraussetzung für Metrics API
- `k8s/apps/hello/hpa.yaml`
  - minReplicas=1, maxReplicas=3
  - target CPU utilization 50%
  - `behavior.scaleDown` konfiguriert (stabilizationWindowSeconds=30) für nachvollziehbares Downscaling in Demos

## Demo Runbook (Kurzform)
1. Cluster provisionieren: `terraform plan -out=tfplan` → `terraform apply tfplan`
2. kubectl Zugriff: `aws eks update-kubeconfig ...` → `kubectl get nodes`
3. Namespace + PSA:
   - `kubectl create ns apps`
   - `kubectl label ns apps pod-security...=baseline`
4. Deploy Workload:
   - `kubectl apply -f k8s/apps/hello/`
   - Test via `kubectl -n apps port-forward svc/hello 8080:80` + `curl`
5. Metrics/HPA:
   - `kubectl apply -f https://.../metrics-server/.../components.yaml`
   - `kubectl top nodes`
   - `kubectl apply -f k8s/apps/hello/hpa.yaml`
6. Scale-Demo:
   - Load erzeugen (busybox wget loop) → HPA skaliert hoch
   - Load stoppen → HPA skaliert runter (durch behavior planbar)
7. Cleanup:
   - k8s Ressourcen löschen, dann `terraform destroy`

## Ergebnis
- E2E-Nachweis: Workload-Deployment + HPA auf EKS mit Phase-3-Governance
- Kostenkontrolle: kein ALB/Ingress; Cluster wird nur kurzzeitig betrieben und wieder entfernt
