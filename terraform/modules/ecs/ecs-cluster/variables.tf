variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "aline-ecs-cluster-tc"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Name     = "aline-ecs-cluster-tc"
    Owner    = "Trey-Crossley"
    Schedule = "office-hours"
  }
}