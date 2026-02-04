resource "aws_eks_access_entry" "eks_readonly" {
  cluster_name      = var.cluster_name
  principal_arn     = aws_iam_role.eks_readonly.arn
  kubernetes_groups = ["readonly"]

  # optional, aber explizit:
  type = "STANDARD"
}