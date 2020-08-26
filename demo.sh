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
terraform output --json > atc/do/admin.auto.tfvars.json
terraform output --json > atc/as3/admin.auto.tfvars.json
mgmtIp=$(terraform output --json | jq -r .bigip_mgmt_ips.value[0])
echo "wait max 10 minutes"
checks=0
while [[ "$checks" -lt 10 ]]; do
    echo "waiting on: https://$mgmtIp" 
    curl -sk --retry 10 --retry-connrefused --retry-delay 30 https://$mgmtIp
if [ $? == 0 ]; then
    echo "mgmt ready"
    break
fi
echo "mgmt not ready yet"
let checks=checks+1
sleep 120
done
cd atc/do
terraform init
terraform plan
# apply
read -p "Press enter to continue"
terraform apply --auto-approve
echo "wait 3 minutes"
sleep 180
cd ../as3
terraform init
terraform plan
# apply
read -p "Press enter to continue"
terraform apply --auto-approve