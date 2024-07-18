variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "aline-cluster-tc"
}

variable "subnet_ids" {
  description = "List of IDs of subnets where the node group will be deployed"
  type        = list(string)
}
