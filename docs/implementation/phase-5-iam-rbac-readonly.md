# Phase 5 — IAM ↔ Kubernetes RBAC (Read-only Access Entry)

## Objective
Demonstrate a clean separation between:
- **AWS IAM (AuthN):** who is allowed to authenticate?
- **Kubernetes RBAC (AuthZ):** what is this identity allowed to do inside the cluster?

Result: a dedicated IAM Role receives **read-only permissions** in the Kubernetes namespace `apps`.

## Implementation

### 1) IAM Role (AssumeRole)
Terraform creates a role `${cluster_name}-readonly` with a trust policy:
- only the current AWS principal (e.g., `aws-saa-training`) may use `sts:AssumeRole`.

An AWS managed policy attachment is added so that `aws eks update-kubeconfig` and DescribeCluster operations work.

### 2) EKS Access Entry (IAM → Kubernetes Group)
Terraform creates an `aws_eks_access_entry`:
- `principal_arn = <readonly role arn>`
- `kubernetes_groups = ["readonly"]`

Every session using this role is mapped to the Kubernetes group `readonly`.

### 3) Kubernetes RBAC (Namespace `apps`)
Inside namespace `apps`:
- `Role readonly` allows only `get/list/watch`
- `RoleBinding` binds Kubernetes group `readonly` to this role

## Verification

### Admin bootstrap (once per cluster lifecycle)

```bash
kubectl create namespace apps

kubectl label namespace apps \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/audit=baseline \
  pod-security.kubernetes.io/warn=baseline --overwrite

kubectl apply -f k8s/rbac/
```

### Create read-only context

```bash
aws eks update-kubeconfig \
  --name eks-portfolio-dev \
  --region eu-central-1 \
  --role-arn arn:aws:iam::<account-id>:role/eks-portfolio-dev-readonly \
  --alias eks-portfolio-dev-readonly

kubectl config use-context eks-portfolio-dev-readonly
```

### Validate identity and permissions

```bash
kubectl auth whoami
kubectl -n apps get pods
kubectl auth can-i create pods -n apps
```

Expected behavior:
- `kubectl auth whoami` shows groups `readonly` and `system:authenticated`
- `kubectl -n apps get pods` succeeds
- `kubectl auth can-i create pods -n apps` returns `no`

## Result
The read-only identity has:
- no cluster-scoped access (e.g., nodes or namespaces)
- no write permissions in namespace `apps`
- access implemented reproducibly via EKS Access Entry and Kubernetes RBAC