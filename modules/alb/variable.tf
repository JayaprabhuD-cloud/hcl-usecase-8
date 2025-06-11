#
#variable "alb_sg_name" {
#  description = "Name of the ALB security group"
#  type        = string
#}

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

variable "alb_sg" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}
