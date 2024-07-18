output "openid_connect_provider_arn" {
  description = "The ARN of the IAM OpenID Connect provider"
  value       = aws_iam_openid_connect_provider.eks-provider-tc.arn
}

output "openid_connect_provider_url" {
  description = "The URL of the IAM OpenID Connect provider"
  value       = aws_iam_openid_connect_provider.eks-provider-tc.url
}
