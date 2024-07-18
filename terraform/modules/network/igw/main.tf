# Define Internet Gateway resource
resource "aws_internet_gateway" "aline_igw_tc" {
  vpc_id = var.vpc_id

  tags = {
    Name     = "aline-igw-tc"
    Owner    = "Trey-Crossley"
    Schedule = "office-hours"
  }
}
