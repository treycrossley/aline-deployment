variable "name" {
  description = "The name of the load balancer"
  type        = string
  default     = "ecs-lb-tc"
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer (e.g., application, network)"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "The security groups associated with the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "The subnets associated with the load balancer"
  type        = list(string)
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default     = "lb-target-group-tc"
}

variable "target_group_port" {
  description = "The port on the target group"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "The protocol on the target group"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "The VPC ID associated with the load balancer"
  type        = string
}

variable "target_type" {
  description = "The type of target (e.g., instance, ip)"
  type        = string
  default     = "ip"
}
