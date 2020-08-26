variable app_image {
  description = "Docker image to run in the ECS cluster"
  #default     = "ami-04c22ba97a0c063c4"
  default = "httpd:2.4"
}

variable command {
  default = "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
}

variable app_port {
  description = "Port exposed by the docker image to redirect traffic to"
  #. <-- we will need this value
  default = 80
}

variable app_count {
  description = "Number of docker containers to run"
  default     = "2"
}

variable fargate_cpu {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable fargate_memory {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

#
# Variable for the EC2 Key 
# Set via CLI or via terraform.tfvars file
#
variable ec2_key_name {
  description = "AWS EC2 Key name for SSH access"
}

variable prefix {
  description = "Prefix for resources created by this module"
  default     = "bigip-fargate"
}
variable allowed_mgmt_cidr {
  description = "cidr range for management acl"
  default     = "0.0.0.0/0"
}
variable allowed_app_cidr {
  description = "cidr range for app acl"
  default     = "0.0.0.0/0"
}
variable cidr {
  description = "cidr range vpc"
  default     = "10.0.0.0/16"
}
variable region {
  description = "region for resources created by this module"
  default     = "us-east-1"
}

variable bigip_ami {
  description = "default ami search string"
  default     = "*F5 BIGIP-15.1.0.4-0.0.6 PAYG-Best 200Mbps*"
}