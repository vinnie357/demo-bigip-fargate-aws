variable adminUsername { default = "admin" }
variable region { default = "us-east-1" }
variable bigip_mgmt_ips {}
variable aws_secretmanager_secret_name {}
variable bigip_private_ips {}
variable bigip_public_ips {}
variable appPort {
  description = "app service port"
}
variable appFqdn {
  description = "app fqdn"
}