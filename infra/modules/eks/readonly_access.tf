data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_readonly" {
  name = "${var.cluster_name}-readonly"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { AWS = data.aws_caller_identity.current.arn },
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_readonly_cluster_policy" {
  role       = aws_iam_role.eks_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}