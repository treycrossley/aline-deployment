output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_service_id" {
  description = "The id of the created ECS service"
  value       = aws_ecs_service.ecs_service.id
}

output "ecs_service_arn" {
  description = "The arn of the created ECS service"
  value       = "arn:aws:ecs:us-east-1:590184030834:service/${aws_ecs_service.ecs_service.id}"
}
