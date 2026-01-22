variable "aws_region" {
  type        = string
  description = "AWS region for the dev environment."
}

variable "project_name" {
  type        = string
  description = "Project name used for naming/tagging."
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev)."
  default     = "dev"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}