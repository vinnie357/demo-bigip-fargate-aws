provider aws {
  region = var.region
}

provider bigip {
  alias    = "bigip_az1"
  address  = "https://${var.bigip_mgmt_ips.value[0]}"
  username = var.adminUsername
  password = data.aws_secretsmanager_secret_version.secret.secret_string
}

#Declarative Onboarding template 01
data aws_secretsmanager_secret_version secret {
  secret_id = var.aws_secretmanager_secret_name.value
}

data template_file do_json {
  template = file("./templates/standalone.json.tpl")

  vars = {
    local_host      = var.bigip_mgmt_dns_private.value[0]
    local_selfip    = "${var.bigip_private_ips.value[0]}/24"
    dns_server      = var.dns_server
    ntp_server      = var.ntp_server
    timezone        = var.timezone
    appDomain       = var.appDomain.value
    default_gateway = cidrhost(var.external_network_cidr.value, 1)

  }
}

resource bigip_do bigip_01 {
  provider = bigip.bigip_az1
  do_json  = data.template_file.do_json.rendered
}