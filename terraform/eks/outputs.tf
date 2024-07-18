output "name" {
  description = "The name of the created EKS cluster"
  value       = module.eks_cluster.name
}

output "oidc_issuer" {
  description = "value of the OIDC issuer URL of the created EKS cluster"
  value       = module.eks_cluster.oidc_issuer
}

output "endpoint" {
  description = "The endpoint of the created EKS cluster"
  value       = module.eks_cluster.endpoint
}

output "certificate_authority" {
  description = "The certificate authority of the created EKS cluster"
  value       = module.eks_cluster.certificate_authority
}

