# Deploy Two-tier Application on AWS using Terraform

This repository will help you deploy Wordpress application in a Multi-AZ environment on AWS

Custom modules have been created for this development
- network module: creates vpc, subnets, route table and internet gaetway
- security module: creates security groups
- rds module: creates rds database
- ec2 module: creates ec2 instances and sets up wordpress on docker
- alb module: creates Load Balances listening on port 80

### Pre-requisites to run this terraform code
- Create a S3 bucket to store remote backend and specify the bucket name in ```backend.tf``` file.
- Create a Dynamo DB with Partition key as ```LockID``` and specify the DB name in ```backend.tf``` file.
- Create a ```secrets.tfvars``` and specify the password in the file as ```database_password = <your password>```

### Run the code
```terraform init```<br>
```terraform plan -var-file="secret.tfvars"```<br>
```terraform apply -var-file="secret.tfvars"```<br>

- You will get an output at the end of the code run "ELB_DNS". Use that as URL on your browser