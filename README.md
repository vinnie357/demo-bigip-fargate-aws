# demo-bigip-fargate-aws
BIG-IP fronting containers in aws fargate

## run 
 - set aws creds
    - export 
      ```bash
        export AWS_ACCESS_KEY_ID="mykeyid"
        export AWS_SECRET_ACCESS_KEY="mykeyvalue"
        export AWS_SESSION_TOKEN="mytokenvalue"
      ```
 - set aws key pair name in admin.auto.tfvars.example
 - set region in admin.auto.tfvars.example
 - set allowed_mgmt_cidr in admin.auto.tfvars.example
 - move example file so terraform picks it up
    ```bash
      mv admin.auto.tfvars.example admin.auto.tfvars
    ```
 ```bash
 . demo.sh
 ```

## cleanup
```bash
. cleanup.sh
```