variable "key_name" {
  description = "Name for the key pair"
  type        = string
  default     = "ecs-key-pair"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "launch_template_name_prefix" {
  description = "Prefix for the launch template name"
  type        = string
  default     = "ecs-instance"
}
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t3.small"
}

variable "security_groups" {
  description = "Security groups for the EC2 instances"
  type        = list(string)
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the auto scaling group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Max size for the auto scaling group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Min size for the auto scaling group"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "Subnets for the auto scaling group"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for the EC2 instances"
  type        = string
  default     = "ecs-instance-tc"
}

variable "autoscaling_group_name" {
  description = "Name for the auto scaling group"
  type        = string
  default     = "ecs-autoscale-tc"
}

variable "instance_role_name"{
  description = "Name for the instance role"
  type        = string
}