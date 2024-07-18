variable "family" {
  description = "The family of the ECS task definition"
  type        = string
  default     = "aline-ecs"
}

variable "network_mode" {
  description = "The network mode of the ECS task definition"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "The launch type compatibility requirements"
  type        = list(string)
  default     = ["EC2"]
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows ECS tasks to make calls to other AWS services"
  type        = string
}

variable "container_definitions" {
  description = "A list of container definitions in JSON format that describe the different containers that make up your task"
  type        = list(object({
    name         = string
    image        = string
    essential    = bool
    portMappings = list(object({
      containerPort = number
      hostPort      = number
    }))
    environment = optional(list(object({
      name  = string
      value = string
    })))
  }))
}
