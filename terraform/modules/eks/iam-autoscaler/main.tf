data "aws_iam_policy_document" "autoscaler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    principals {
      identifiers = [var.provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.autoscaler_assume_role_policy.json
  name               = var.role_name
}

resource "aws_iam_policy" "autoscaler_policy" {
  name   = var.policy_name
  policy = jsonencode({
    Statement = [{
      Action   = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions",
        "eks:DescribeNodegroup",
        "eks:DescribeCluster",
        "eks:ListNodegroups",
        "sts:AssumeRoleWithWebIdentity"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version   = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "autoscaler_attach" {
  role       = aws_iam_role.autoscaler.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn
}

