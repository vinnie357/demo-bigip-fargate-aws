provider aws {
  region = var.region
}

provider bigip {
  alias    = "bigip_az1"
  address  = "https://${var.bigip_mgmt_ips.value[0]}"
  username = var.adminUsername
  password = data.aws_secretsmanager_secret_version.secret.secret_string
}
data aws_secretsmanager_secret_version secret {
  secret_id = var.aws_secretmanager_secret_name.value
}

#application services 3 template
data template_file as3_json {
  template = "${file("./templates/as3.json.tpl")}"
  vars = {
    uuid                   = uuid()
    virtualAddressExternal = var.bigip_public_ips.value[0]
    virtualAddressInternal = var.bigip_private_ips.value[0]
  }
}


resource bigip_as3 as3 {
  provider = bigip.bigip_az1
  as3_json = data.template_file.as3_json.rendered
}