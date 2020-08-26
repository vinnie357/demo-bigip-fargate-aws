variable dns_server { default = "8.8.8.8" }
variable ntp_server { default = "0.us.pool.ntp.org" }
variable timezone { default = "UTC" }
variable adminUsername { default = "admin" }
variable region { default = "us-east-1" }
variable bigip_mgmt_ips {}
variable aws_secretmanager_secret_name {}
variable bigip_private_ips {}
variable bigip_mgmt_dns_private {}


# optional
variable "vpc_id" {
  description = "vpc_id"
}
variable "bigip_mgmt_dns" {
  description = "bigip_mgmt_dns"
}
variable "bigip_mgmt_port" {
  description = "bigip_mgmt_port"
}