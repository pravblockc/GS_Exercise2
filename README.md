# GS_Exercise2 - Create terraform script

- Following the are guidelines to create VPC, public and private testnet, EC2 t2 small instance 

- step1: Download and install terraform based on the OS. The version tried was v0.13.2
- step2: Git clone https://github.com/pravblockc/GS_Exercise2.git
- step3: update the `access_key` and 'security_key` in the script vpc.tf
- step4: Provide the public key, region and availability_zone through variables.tf

# Steps to run the script

`terraform init`
'terraform plan` for sanity test 
`terraform apply' for configuration
'terraform destroy` to destroy the created instance etc