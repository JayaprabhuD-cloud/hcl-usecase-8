variable "cluster_name" {
  type = string
  default = "usecase8_cluster"
}

variable "patient_log_group_name" {
  type = string
  default = "patient_log_group"
}

variable "appoinment_log_group_name" {
  type = string
  default = "appoinment_log_group"
}

variable "appointment_service_task" {
  type = string
  default = "appointment_service_task_definition"
}

variable "patient_service_task_name" {
  type = string
  default = "patient_service_task_definition"
}


variable "patient_service_name" {
  type = string
  default = "patient_service_name"
}

#variable "target_group_arns.patient_service" {}
variable "appointment_service_name" {
  type = string
  default = "appointment_service_name"
}

variable "target_group_arns" {
  description = "Map of target group ARNs"
  type = object({
    patient_service     = string
    appointment_service = string
  })
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ID of the ECS security group"
  type        = string
}

variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "ecr_patient_repo_url" {
  description = "URL of the patient service ECR repository"
  type        = string
}

variable "ecr_appointment_repo_url" {
  description = "URL of the appointment service ECR repository"
  type        = string
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

variable "private_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}