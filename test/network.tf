provider aws {
  region = var.region
}
#
# Create a random id
#
resource random_id id {
  byte_length = 2
}

resource aws_vpc terraform-vpc {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name        = format("%s-vpc-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

resource aws_subnet f5-management-a {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.101.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.region}a"

  tags = {
    Name        = format("%s-management-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

resource aws_subnet f5-management-b {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.102.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.region}b"

  tags = {
    Name        = format("%s-management-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

resource aws_subnet public-a {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.region}a"

  tags = {
    Name        = format("%s-public-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}
resource aws_subnet public-b {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.region}b"

  tags = {
    Name        = format("%s-public-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}


resource aws_internet_gateway gw {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name        = format("%s-internet-gateway-%s", var.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

resource aws_route_table rt1 {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name                    = format("%s-rt1-%s", var.prefix, random_id.id.hex)
    f5_cloud_failover_label = "mydeployment"
    Terraform               = "true"
    Environment             = "dev"
    #f5_self_ips tag used by f5 cloud failover iControl LX
    #f5_self_ips = "${var.bigip1_private_ip[0]},${var.bigip2_private_ip[0]}"
  }
}

resource aws_main_route_table_association association-subnet {
  vpc_id         = aws_vpc.terraform-vpc.id
  route_table_id = aws_route_table.rt1.id
}
