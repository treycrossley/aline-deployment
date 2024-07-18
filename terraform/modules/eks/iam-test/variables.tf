variable "provider_url" {
  description = "The URL of the OIDC provider"
  type        = string
}

variable "provider_arn" {
  description = "The ARN of the OIDC provider"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default = "test-oidc"
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
  default = "test-policy"
}

variable "policy_document" {
  description = "The IAM policy document"
  type        = any
  default = {
    Statement = [
      {
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::*"
      }
    ]
    Version = "2012-10-17"
  }
}
