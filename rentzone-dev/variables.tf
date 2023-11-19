# environment variables
variable "region" {}
variable "profile" {}
variable "project_name" {}
variable "environment" {}

# variable "backend_s3_bucket" {}
# variable "tfstate_key" {} 
# variable "dynamodb_table" {}

# vpc variables
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

# security group variables
variable "ssh_ip" {}

# # rds variables
# variable "database_snapshot_dentifier" {}
# variable "database_instance_class" {}
# variable "database_instance_identifier" {}
# variable "multi_az_deployment" {}

# acm variables
variable "domain_name" {}
variable "subject_alternative_names" {}