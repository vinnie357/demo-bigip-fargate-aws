#!/bin/bash
echo "destroying demo"
read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    rm atc/do/terraform.tfstate
    rm atc/as3/terraform.tfstate
    terraform destroy --auto-approve
else
    echo "canceling"
fi