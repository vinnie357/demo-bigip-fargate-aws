resource aws_service_discovery_private_dns_namespace example {
  name        = var.app_domain
  description = "example"
  vpc         = aws_vpc.terraform-vpc.id
}

resource aws_service_discovery_service example {
  name = var.app_name
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.example.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    # <-- we want multiple IP addresses returned.
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

}