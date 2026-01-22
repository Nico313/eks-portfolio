module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}

module "eks" {
  source = "../../modules/eks"

  cluster_name                         = var.cluster_name
  vpc_id                               = module.vpc.vpc_id
  subnet_ids                           = module.vpc.public_subnet_ids
  cluster_endpoint_public_access_cidrs = ["84.128.252.12/32"]
}

# Optional: keep these only if your module interfaces match
# module "ecr" {
#   source = "../../modules/ecr"
#   project_name = var.project_name
#   environment  = var.environment
# }
#
# module "dynamodb" {
#   source = "../../modules/dynamodb"
#   project_name = var.project_name
#   environment  = var.environment
# }