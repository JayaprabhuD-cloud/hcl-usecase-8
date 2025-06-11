module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block            = var.vpc_cidr_block
  public_subnet_1_cidr      = var.public_subnet_1_cidr
  public_subnet_2_cidr      = var.public_subnet_2_cidr
  private_subnet_1_cidr     = var.private_subnet_1_cidr
  private_subnet_2_cidr     = var.private_subnet_2_cidr
}

module "ecr" {
  source = "./modules/ecr"
  repo_name_1               = var.repo_name_1
  repo_name_2               = var.repo_name_2
}

module "security_groups" {
  source = "./modules/security_groups"
  alb_sg_name               = var.alb_sg_name
  app_sg_name               = var.app_sg_name
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  tg_name_patient           = var.tg_name_patient
  tg_name_appoinment        = var.tg_name_appoinment
  alb_name                  = var.alb_name
  alb_sg                    = module.security_groups.alb_sg
  public_subnets = [module.vpc.public_subnet_1, module.vpc.public_subnet_2]
}