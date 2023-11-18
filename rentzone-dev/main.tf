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
  source = "git@github.com:OlegShevtsov1/ecs_example.git//nat-gateway?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment
  
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  internet_gateway = module.vpc.internet_gateway
  public_subnet_az2_id = module.vpc.public_subnet_az2_id
  vpc_id = module.vpc.vpc_id
  private_app_subnet_az1_id = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}

# create security group
module "security_group" {
  # source = "../modules/security-groups"
  # source = "git@github.com:aosnotes77/terraform-modules.git//security-groups" 
  source = "git@github.com:OlegShevtsov1/ecs_example.git//security-groups?ref=terraform-dynamic"
  project_name = local.project_name
  environment  = local.environment

  vpc_id = module.vpc.vpc_id
  ssh_ip = var.ssh_ip
}