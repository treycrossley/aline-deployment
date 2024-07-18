variable "eip_name" {
  description = "The name of the Elastic IP"
  type        = string
  default     = "aline_nat_ip_tc"
}

variable "subnet_id" {
  description = "The ID of the subnet for the NAT Gateway"
  type        = string
}

variable "igw_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {
    Name     = "aline_nat_tc"
    Owner    = "Trey-Crossley"
    Schedule = "office-hours"
  }
}