variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "ingress_from_port" {
  description = "The starting port for incoming traffic"
  type        = number
  default     = 80
}

variable "ingress_to_port" {
  description = "The ending port for incoming traffic"
  type        = number
  default     = 80
}

variable "ingress_protocol" {
  description = "The protocol for incoming traffic (e.g., tcp, udp, icmp)"
  type        = string
  default     = "tcp"
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks to allow incoming traffic from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  description = "The starting port for outgoing traffic"
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "The ending port for outgoing traffic"
  type        = number
  default     = 0
}

variable "egress_protocol" {
  description = "The protocol for outgoing traffic (e.g., tcp, udp, icmp)"
  type        = string
  default     = "-1"
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks to allow outgoing traffic to"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
