output "node_group_name" {
  description = "Name of the created EKS node group"
  value       = aws_eks_node_group.private_nodes.node_group_name
}
