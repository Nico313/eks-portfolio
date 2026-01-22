variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "vpc_id" {
  type        = string
  description = "VPC id for the cluster."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the cluster and node groups (public subnets for variant A)."
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types for the managed node group."
  default     = ["t3.medium"]
}

variable "desired_size" {
  type        = number
  default     = 2
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 3
}

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to reach the public EKS endpoint."
  default     = []
}