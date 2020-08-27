variable prefix { default = "mytest" }
variable region { default = "us-east-1" }
variable allowed_mgmt_cidr {
  description = "cidr range for management acl"
  default     = "0.0.0.0/0"
}
variable allowed_app_cidr {
  description = "cidr range for app acl"
  default     = "0.0.0.0/0"
}