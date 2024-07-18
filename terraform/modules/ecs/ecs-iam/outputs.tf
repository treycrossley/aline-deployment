output "role_id" {
  description = "The ID of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.id
}

output "role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "instance_role_id" {
  description = "The ID of the ECS task execution role"
  value       = aws_iam_role.ecs_instance_role.id
}

output "instance_role_name" {
  description = "The name of the ECS task execution role"
  value       = aws_iam_role.ecs_instance_role.name
}


output "instance_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_instance_role.arn
}
