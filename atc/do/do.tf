provider bigip {
  alias    = "bigip_az1"
  address  = "https://${var.mgmt_public_ip_01}"
  username = var.adminUsername
  password = data.aws_secretsmanager_secret_version.secret.secret_string
}

#Declarative Onboarding template 01
data aws_secretsmanager_secret_version secret {
  secret_id = var.secrets_manager_name
}

data template_file do_json {
  template = file("./templates/standalone.json.tpl")

  vars = {
    local_host   = var.internal_hostname
    local_selfip = var.privateIp
    gateway      = "10.0.0.1"
    dns_server   = var.dns_server
    ntp_server   = var.ntp_server
    timezone     = var.timezone
  }
}

resource bigip_do bigip_01 {
  provider = bigip.bigip_az1
  do_json  = data.template_file.do_json.rendered
}