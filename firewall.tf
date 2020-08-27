resource aws_security_group f5_management {
  name = format("%s-f5_management-%s", var.prefix, random_id.id.hex)

  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_mgmt_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_mgmt_cidr]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allowed_mgmt_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource aws_security_group f5_data {
  name = format("%s-f5_data-%s", var.prefix, random_id.id.hex)

  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_app_cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.allowed_app_cidr]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }

  ingress {
    from_port   = 1026
    to_port     = 1026
    protocol    = "udp"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }

  ingress {
    from_port   = 4353
    to_port     = 4353
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.allowed_app_cidr]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource aws_security_group fargate_sg {
  name = format("%s-fargate_sg-%s", var.prefix, random_id.id.hex)

  vpc_id = aws_vpc.terraform-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.terraform-vpc.cidr_block]
  }
}


# #
# # Create a security group for port 80 traffic
# #
# module web_server_sg {
#   source              = "terraform-aws-modules/security-group/aws//modules/http-80"
#   name                = format("%s-web-server-%s", var.prefix, random_id.id.hex)
#   description         = "Security group for web-server with HTTP ports"
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = [var.allowed_app_cidr]
# }

# #
# # Create a security group for port 443 traffic
# #
# module web_server_secure_sg {
#   source              = "terraform-aws-modules/security-group/aws//modules/https-443"
#   name                = format("%s-web-server-secure-%s", var.prefix, random_id.id.hex)
#   description         = "Security group for web-server with HTTPS ports"
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = [var.allowed_app_cidr]
# }
# module fargate_secure_sg {
#   source             = "terraform-aws-modules/security-group/aws//modules/https-443"
#   name               = format("%s-fargate-secure-%s", var.prefix, random_id.id.hex)
#   vpc_id             = module.vpc.vpc_id
#   ingress_cidr_blocks = [module.vpc.public_subnets_cidr_blocks[0]]
#   egress_cidr_blocks = [var.allowed_app_cidr]
# }
# #
# # Create a security group for SSH traffic
# #
# module ssh_secure_sg {
#   source              = "terraform-aws-modules/security-group/aws//modules/ssh"
#   name                = format("%s-ssh-%s", var.prefix, random_id.id.hex)
#   description         = "Security group for SSH ports open within VPC"
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = [var.allowed_mgmt_cidr]
# }