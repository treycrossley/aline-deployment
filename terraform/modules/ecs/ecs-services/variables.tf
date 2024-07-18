variable "name" {
  description = "The name of the ECS service"
  type        = string
  default     = "aline-ecs-service-tc"
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "The ARN of the task definition to use for the service"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task to place and keep running"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  type        = string
  default     = "EC2"
}

variable "subnets" {
  description = "The subnets associated with the task or service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups associated with the task or service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the target group associated with the ECS service"
  type        = string
}

variable "container_name" {
  description = "The name of the container in the task to associate with the load balancer"
  type        = string
  default     = "aline_container"
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer"
  type        = number
  default     = 80
}
