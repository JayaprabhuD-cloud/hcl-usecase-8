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
  alb_sg                    = [module.security_groups.alb_sg]
  public_subnets = [module.vpc.public_subnet_1, module.vpc.public_subnet_2]
}

module "iam" {
  source = "./modules/iam"
  ecs-task-execution-role-name = var.ecs-task-execution-role-name
  ecs_task_execution_role_policy_name = var.ecs_task_execution_role_policy_name
  ecs_task_role = var.ecs_task_role
  ecs_task_role_policy = var.ecs_task_role_policy
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = var.cluster_name
  vpc_id                   = module.vpc.vpc_id
  private_subnets          = module.vpc.private_subnets
  ecs_security_group_id    = module.vpc.ecs_security_group_id
  task_execution_role_arn  = module.iam.ecs_task_execution_role_arn
  task_role_arn           = module.iam.ecs_task_role_arn
  ecr_patient_repo_url    = module.ecr.patient_service_repository_url
  ecr_appointment_repo_url = module.ecr.appointment_service_repository_url
  target_group_arns       = module.alb.target_group_arns
  container_cpu           = var.container_cpu
  container_memory        = var.container_memory
  app_port               = var.app_port
  desired_capacity       = var.desired_capacity
}