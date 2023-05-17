################################################################################
# VPC
################################################################################

resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = var.vpc_name
  }
}


###############################################################################
# Internet Gateway
###############################################################################

resource "aws_internet_gateway" "myIGW" {

  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = var.igw_tag
  }
}


###############################################################################
# Elastic IP
###############################################################################

resource "aws_eip" "eip" {

  depends_on = [aws_internet_gateway.myIGW]
}


###############################################################################
# Nat Gateway
###############################################################################


resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT_GW"
  }
}
# To ensure proper ordering, it is recommended to add an explicit dependency
# on the Internet Gateway for the VPC.




################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr_1
  availability_zone       = data.aws_availability_zones.available_1.names[0] #can directly mentiion "ap-south-1"
  map_public_ip_on_launch = var.map_public_ip_on_launch                      ###To convert any subnet into public 

  tags = {
    Name = var.public_subnet_tag_1
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr_2
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_tag_2
  }
}


################################################################################
# Private subnet (Database)
################################################################################

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_1
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_tag_1
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_2
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_tag_2
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_3
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_tag_3
  }
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_4
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_tag_4
  }
}

################################################################################
# Publiс routes
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.public_route_table_tag
  }
}

## Add Internet Gateway to public routes:

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id
}


################################################################################
# Private route table 
################################################################################

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = var.private_route_table_1_tag
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = var.private_route_table_2_tag
  }
}

## Add Nat Gateway to private route

resource "aws_route" "private_NAT_gateway1" {
  route_table_id         = aws_route_table.private_route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT_GW.id
}

resource "aws_route" "private_NAT_gateway2" {
  route_table_id         = aws_route_table.private_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT_GW.id
}
################################################################################
# Route table association with subnets
################################################################################

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}
resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_1.id
}
resource "aws_route_table_association" "private_route_table_association_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table_2.id
}
resource "aws_route_table_association" "private_route_table_association_4" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_route_table_2.id
}


