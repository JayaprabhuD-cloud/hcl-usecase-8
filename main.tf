module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "ecr" {
  source = "./modules/ecr"
  repo_name_1 = var.repo_name_1
  repo_name_2 = var.var.repo_name_2
}

module "security_groups" {
  source = "./modules/security_groups"
  repo_name_1 = var.repo_name_1
  repo_name_2 = var.var.repo_name_2
}