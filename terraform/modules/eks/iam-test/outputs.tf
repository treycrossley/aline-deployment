output "test_policy_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.test_oidc.arn
}
