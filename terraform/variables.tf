variable "aws_region" {
  description = "AWS region in which to create the EKS cluster"
  type        = string
  default     = "eu-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "voting-app-cluster"
}
