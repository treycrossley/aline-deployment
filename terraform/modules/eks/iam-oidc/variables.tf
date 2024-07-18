variable "cluster_oidc_issuer" {
  description = "The OIDC issuer URL of the EKS cluster"
  type        = string
}

variable "client_id_list" {
  description = "List of client IDs for the IAM OpenID Connect provider"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}
