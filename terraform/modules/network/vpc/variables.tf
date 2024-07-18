variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {
    Name     = "aline_vpc_tc"
    Owner    = "Trey-Crossley"
    Schedule = "office-hours"
  }
}