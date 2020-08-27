{
    "schemaVersion": "1.0.0",
    "class": "Device",
    "async": true,
    "Common": {
        "class": "Tenant",
        "hostname": "${local_host}",
        "dbvars": {
          "class": "DbVariables",
          "ui.advisory.enabled": true,
          "ui.advisory.color": "green",
          "ui.advisory.text": "/Common/hostname"
      },
        "myDns": {
          "class": "DNS",
          "nameServers": [
              "10.0.0.2",
              "169.254.169.254",
              "${dns_server}"
          ],
          "search": [
              "${appDomain}",
              "ec2.internal",
              "compute-1.internal"
          ]
      },
        "myNtp": {
          "class": "NTP",
          "servers": [
              "${ntp_server}",
              "0.pool.ntp.org",
              "1.pool.ntp.org"
          ],
          "timezone": "${timezone}"
      },
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal",
            "asm": "nominal"
        },
        "external": {
            "class": "VLAN",
            "tag": 10,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.1",
                    "tagged": false
                }
            ]
        },
        "external-self": {
            "class": "SelfIp",
            "address": "${local_selfip}",
            "vlan": "external",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "default": {
            "class": "Route",
            "gw": "${default_gateway}",
            "network": "default"
        }
    }
  }