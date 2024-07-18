# Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.private_subnet_availability_zones[count.index]

  tags = {
    Name                                     = "aline_private_subnet_tc${count.index + 1}"
    Owner                                    = "Trey-Crossley"
    Schedule                                 = "office-hours"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/aline_cluster_tc" = "owned"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.public_subnet_availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "aline_public_subnet_tc${count.index + 1}"
    Owner                                    = "Trey-Crossley"
    Schedule                                 = "office-hours"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/aline_cluster_tc" = "owned"
  }
}
