## VPC
output vpc_id {
  value = aws_vpc.terraform-vpc.id
}

## app
output "appPort" {
  value = var.app_port
}
output "appFqdn" {
  value = "${aws_service_discovery_service.example.name}.${aws_service_discovery_private_dns_namespace.example.name}"
}
output "appDomain" {
  value = aws_service_discovery_private_dns_namespace.example.name
}
## BIG-IP
# BIG-IP Management Public IP Addresses
output bigip_mgmt_ips {
  value = module.bigip.mgmt_public_ips
}
# BIG-IP Traffic Private IP Addresses
output bigip_private_ips {
  value = module.bigip.traffic_private_ips
}
# BIG-IP Traffic Public IP Addresses
output bigip_public_ips {
  value = module.bigip.traffic_public_ips
}

# BIG-IP Management Public DNS Address
output bigip_mgmt_dns {
  value = module.bigip.mgmt_public_dns
}
# BIG-IP Management Private DNS Address
output bigip_mgmt_dns_private {
  value = module.bigip.mgmt_private_dns
}

# BIG-IP Management Port
output bigip_mgmt_port {
  value = module.bigip.mgmt_port
}

# BIG-IP Password Secret name
output aws_secretmanager_secret_name {
  value = aws_secretsmanager_secret.bigip.name
}
# BIG-IP external network cidr
output external_network_cidr {
  value = aws_subnet.public-a.cidr_block
}