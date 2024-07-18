variable "role_name" {
    description = "The name of the IAM role for the autoscaler"
    type        = string
    default = "cluster-autoscaler"
}

variable "policy_name" {
    description = "The name of the IAM policy for the autoscaler"
    type        = string
    default = "eks-cluster-autoscaler-tc"
}

variable "provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster"
  type        = string
}

variable "service_account" {  
  description = "The name of the service account"
  type        = string
  default     = "cluster-autoscaler"
}