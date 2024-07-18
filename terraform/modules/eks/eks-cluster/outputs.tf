output "name" {
  description = "The name of the created EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "oidc_issuer" {
  description = "value of the OIDC issuer URL of the created EKS cluster"
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "endpoint" {
  description = "The endpoint of the created EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "certificate_authority" {
  description = "The certificate authority of the created EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

