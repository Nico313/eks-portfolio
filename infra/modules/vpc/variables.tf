variable "project_name" {
  type        = string
  description = "Project name used for naming/tagging."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev)."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "az_count" {
  type        = number
  description = "How many AZs to use."
  default     = 2
}

variable "enable_nat_gateway" {
  type        = bool
  description = "If true, create a NAT Gateway for private subnets (costs money)."
  default     = false
}