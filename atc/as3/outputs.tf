output "appAddress" {
  value = "https://${var.bigip_public_ips.value[0]}"
}