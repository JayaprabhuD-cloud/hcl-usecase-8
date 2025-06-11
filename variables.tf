variable "vpc_cidr_block" {
  description = "vpc cidr value"
  type = string
}

variable "public_subnet_1_cidr" {
  description = "public subnet 1 cidr value"
  type = string
}

variable "public_subnet_2_cidr" {
  description = "public subnet 2 cidr value"
  type = string 
}

variable "private_subnet_1_cidr" {
  description = "private subnet 1 cidr value"
  type = string
}
variable "private_subnet_2_cidr" {
  description = "private subnet 2 cidr value"
  type = string
}

variable "repo_name_1" {
  description = "Variable created for patient ecr repo"
  type = string
}

variable "repo_name_2" {
  description = "Variable created for appoinment ecr repo"
  type = string
}

variable "alb_sg_name" {
  description = "sg for alb"
  type = string
}

variable "app_sg_name" {
  description = "sg for application containers"
  type = string
}

variable "tg_name_patient" {
  description = "Name of the target group for patient"
  type        = string
}

variable "tg_name_appoinment" {
  description = "Name of the target group for appointment"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "ecs-task-execution-role-name" {
  type = string
}

variable "ecs_task_execution_role_policy_name" {
  type = string
}
variable "ecs_task_role" {
  type = string
}

variable "ecs_task_role_policy" {
  type = string
}

variable "container_cpu" {
  description = "CPU units for containers"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory for containers"
  type        = number
  default     = 512
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 3000
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 1
}

variable "cluster_name" {
  type = string
  default = "usecase8_cluster"
}

variable "appoinment_log_group_name" {
  type = string
  default = "appoinment_log_group"
}

variable "appointment_service_task" {
  type = string
  default = "appointment_service_task_definition"
}

variable "patient_service_name" {
  type = string
  default = "patient_service_name"
}

#variable "appointment_service_task" {
#  type = string
#  default = "appointment_service_name"
#}

variable "patient_service_task_name" {
  type = string
  default = "patient_service_task_definition"
}

variable "patient_log_group_name" {
  type = string
  default = "patient_log_group"
}

variable "appointment_service_name" {
  type = string
  default = "appointment_service_name"
}

variable "vpc_id" {
  type = string
}