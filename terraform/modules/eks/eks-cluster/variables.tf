variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "aline_cluster_tc"
}

variable "vpc_subnet_ids" {
  description = "List of IDs of subnets where the EKS cluster will be deployed"
  type        = list(string)
}
