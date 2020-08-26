provider bigip {
  alias    = "bigip_az1"
  address  = "https://${var.mgmt_public_ip_01}"
  username = var.adminUsername
  password = data.aws_secretsmanager_secret_version.secret.secret_string
}
data aws_secretsmanager_secret_version secret {
  secret_id = var.secrets_manager_name
}

#application services 3 template
data template_file as3_json {
  template = "${file("./templates/as3.json.tpl")}"
  vars = {
    uuid                   = uuid()
    virtualAddressExternal = var.publicIp
    virtualAddressInternal = var.privateIp
  }
}


resource bigip_as3 as3 {
  provider = bigip.bigip_az1
  as3_json = data.template_file.as3_json.rendered
}