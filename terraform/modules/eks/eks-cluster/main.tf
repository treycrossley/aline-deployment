resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role-${var.eks_cluster_name}"
  
  tags = {
    Name     = "eks-cluster-role-${var.eks_cluster_name}"
    Owner    = "Trey-Crossley"
    Schedule = "office-hours"
  }

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action    = [
          "sts:AssumeRole",
          "sts:AssumeRoleWithWebIdentity"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.vpc_subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy_attachment]
}

data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}
