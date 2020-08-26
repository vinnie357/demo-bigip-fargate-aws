#https://github.com/f5devcentral/terraform-aws-bigip/blob/master/examples/2_nic_with_new_vpc/main.tf
#
# Create a random id
#
resource random_id id {
  byte_length = 2
}

#
# Create random password for BIG-IP
#
resource random_password password {
  length           = 16
  special          = true
  override_special = " #%*+,-./:=?@[]^_~"
}

#
# Create Secret Store and Store BIG-IP Password
#
resource aws_secretsmanager_secret bigip {
  name = format("%s-bigip-secret-%s", var.prefix, random_id.id.hex)
}
resource aws_secretsmanager_secret_version bigip-pwd {
  secret_id     = aws_secretsmanager_secret.bigip.id
  secret_string = random_password.password.result
}


#
# Create BIG-IP
#
module bigip {
  #source             = "f5devcentral/bigip/aws"
  #version            = "0.1.4"
  source             = "./terraform-aws-bigip-0.1.4"
  f5_ami_search_name = var.bigip_ami
  prefix = format(
    "%s-bigip-2-nic_with_new_vpc-%s",
    var.prefix,
    random_id.id.hex
  )
  f5_instance_count           = length(local.bigip_azs)
  ec2_instance_type           = "m5.large"
  ec2_key_name                = var.ec2_key_name
  aws_secretmanager_secret_id = aws_secretsmanager_secret.bigip.id
  mgmt_subnet_security_group_ids = [
    module.web_server_secure_sg.this_security_group_id,
    module.ssh_secure_sg.this_security_group_id
  ]

  public_subnet_security_group_ids = [
    module.web_server_sg.this_security_group_id,
    module.web_server_secure_sg.this_security_group_id
  ]

  #  vpc_public_subnet_ids = module.vpc.public_subnets
  #  vpc_mgmt_subnet_ids   = module.vpc.database_subnets

  vpc_public_subnet_ids = slice(module.vpc.public_subnets, 0, 1)
  vpc_mgmt_subnet_ids   = slice(module.vpc.database_subnets, 0, 1)
}