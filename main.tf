terraform {
  required_version = ">= 0.12"
}

provider aws {
  region = var.region
}

#
# Create a random id
#
resource random_id id {
  byte_length = 2
}
