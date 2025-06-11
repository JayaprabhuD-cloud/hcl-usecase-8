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
  description = "Variable created for patient ecr repo"
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