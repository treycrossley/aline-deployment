resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group-nodes-${var.cluster_name}"

  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes_policies" {
  count = 3

  policy_arn = element([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ], count.index)

  role = aws_iam_role.eks_nodes.name
}


resource "aws_eks_node_group" "private_nodes" {
  cluster_name    = var.cluster_name
  node_group_name = "private-nodes-${var.cluster_name}"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = var.subnet_ids

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    node = "kubenode02"
  }


  tags = {
    "Name" = "tc-eks-node"
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.

  depends_on = [
    aws_iam_role.eks_nodes,
    aws_iam_role_policy_attachment.nodes_policies,
  ]
}
