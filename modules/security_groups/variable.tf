variable "alb_sg_name" {
  description = "sg for alb"
  type = string
}

variable "app_sg_name" {
  description = "sg for application containers"
  type = string
}

variable "vpc_id" {
  description = "refering vpc"
  type = string
}