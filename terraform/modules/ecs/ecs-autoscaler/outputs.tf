output "autoscaling_group_name" {
  description = "Name of the Auto Scaling group"
  value       = aws_autoscaling_group.ecs_instances.name
}

output "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling group"
  value       = aws_autoscaling_group.ecs_instances.arn
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.ecs_instance.id
}
