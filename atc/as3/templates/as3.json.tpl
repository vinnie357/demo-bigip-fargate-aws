{
    "class": "AS3",
    "action": "deploy",
    "persist": true,
    "declaration": {
      "class": "ADC",
      "schemaVersion": "3.13.0",
      "id": "${uuid}",
      "label": "ingress",
      "remark": "An HTTPS sample application",
      "controls": {
        "trace": true
      },
      "demo": {
        "class": "Tenant",
        "app": {
          "class": "Application",
          "template": "https",
          "serviceMain": {
            "class": "Service_HTTPS",
            "virtualAddresses": [
              "${virtualAddressExternal}",
              "${virtualAddressInternal}"
            ],
            "pool": "web_pool",
            "serverTLS": "webtls",
            "profileMultiplex": {
              "bigip": "/Common/oneconnect"
            }
          },
          "web_pool": {
            "class": "Pool",
            "monitors": [
              "tcp"
            ],
            "members": [
                    {
                        "servicePort": 80,
                        "addressDiscovery": "fqdn",
                        "autoPopulate": true,
                        "hostname": "example.example.my-project.local"
                    }
            ]
          },
          "webtls": {
            "class": "TLS_Server",
            "ciphers": "HIGH",
            "certificates": [{
                "certificate": "certificate_default"
            }]
          },
          "certificate_default": {
            "class": "Certificate",
            "certificate": {
                "bigip": "/Common/default.crt"
            },
            "privateKey": {
                "bigip": "/Common/default.key"
            }
         }
        }
      }
    }
  }