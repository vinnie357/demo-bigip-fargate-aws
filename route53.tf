resource aws_service_discovery_private_dns_namespace example {
  name        = "example.my-project.local"
  description = "example"
  vpc         = module.vpc.vpc_id
}

resource aws_service_discovery_service example {
  name = "example"
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