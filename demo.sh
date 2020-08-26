#!/bin/bash
# setup
terraform init
terraform fmt
terraform validate
terraform plan
# apply
read -p "Press enter to continue"
terraform apply --auto-approve
## atc
## do
#cd atc/do
# 

#cd ../as3
