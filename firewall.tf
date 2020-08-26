#
# Create a security group for port 80 traffic
#
module web_server_sg {
  source              = "terraform-aws-modules/security-group/aws//modules/http-80"
  name                = format("%s-web-server-%s", var.prefix, random_id.id.hex)
  description         = "Security group for web-server with HTTP ports"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = [var.allowed_app_cidr]
}

#
# Create a security group for port 443 traffic
#
module web_server_secure_sg {
  source              = "terraform-aws-modules/security-group/aws//modules/https-443"
  name                = format("%s-web-server-secure-%s", var.prefix, random_id.id.hex)
  description         = "Security group for web-server with HTTPS ports"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = [var.allowed_app_cidr]
}

#
# Create a security group for SSH traffic
#
module ssh_secure_sg {
  source              = "terraform-aws-modules/security-group/aws//modules/ssh"
  name                = format("%s-ssh-%s", var.prefix, random_id.id.hex)
  description         = "Security group for SSH ports open within VPC"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = [var.allowed_mgmt_cidr]
}