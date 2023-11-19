locals {
  region       = var.region
  profile      = var.profile
  project_name = var.project_name
  environment  = var.environment
}

# create vpc module
module "vpc" {
  # source = "../modules/vpc"
  # source = "git@github.com:aosnotes77/terraform-modules.git//vpc" 
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//vpc?ref=terraform-dynamic"
  region       = local.region
  project_name = local.project_name
  environment  = local.environment

  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

#create nat-gateways
module "nat_gateway" {
  # source = "../modules/nat-gateway"
  # source = "git@github.com:aosnotes77/terraform-modules.git//nat-gateway" 
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//nat-gateway?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment

  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}

# create security group
module "security_group" {
  # source = "../modules/security-groups"
  # source = "git@github.com:aosnotes77/terraform-modules.git//security-groups" 
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//security-groups?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment

  vpc_id = module.vpc.vpc_id
  ssh_ip = var.ssh_ip
}

# # launch rds instance
# module "rds" {
#   # source = "../modules/rds"
#   # source = "git@github.com:aosnotes77/terraform-modules.git//rds" 
#   source = "git@github.com:OlegShevtsov1/ecs_example.git//rds?ref=terraform-dynamic"
#   project_name = local.project_name
#   environment  = local.environment

#   private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
#   private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
#   database_snapshot_dentifier = var.database_snapshot_dentifier
#   database_instance_class = var.database_instance_class
#   availability_zone_1 = module.vpc.availability_zone_1
#   database_instance_identifier = var.database_instance_identifier
#   multi_az_deployment = var.multi_az_deployment
#   database_security_group_id = module.security_group.database_security_group_id
# }

# request ssl certificate
module "ssl_certificate" {
  # source = "../modules/acm"
  # source = "git@github.com:aosnotes77/terraform-modules.git//acm" 
  source = "git@github.com:OlegShevtsov1/ecs_example.git//acm?ref=terraform-dynamic"

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
}

# crate application load balancer
module "application_load_balancer" {
  # source = "../modules/alb"
  # source = "git@github.com:aosnotes77/terraform-modules.git//alb"
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//alb?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment

  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  target_type           = var.target_type
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.ssl_certificate.certificate_arn
}

# create s3 bucket
module "s3_bucket" {
  # source = "../modules/s3"
  # source = "git@github.com:aosnotes77/terraform-modules.git//s3
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//s3?ref=terraform-dynamic"
  project_name = local.project_name

  env_file_bucket_name = var.env_file_bucket_name
  env_file_name        = var.env_file_name
}

# create ect task execution role
module "ecs_task_execution_role" {
  # source = "../modules/iam-role"
  # source = "git@github.com:aosnotes77/terraform-modules.git//iam-role
  source       = "git@github.com:OlegShevtsov1/ecs_example.git//iam-role?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment

  env_file_bucket_name = module.s3_bucket.env_file_bucket_name
}