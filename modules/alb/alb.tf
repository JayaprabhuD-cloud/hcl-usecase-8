
# Creating target group for patient application

resource "aws_lb_target_group" "patient_tg" {
  name     = var.tg_name_patient
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path     = "/health"
    protocol = "HTTP"
  }

  tags = {
    Name = "patient_tg"
  }
}


# Creating target group for appointment application

resource "aws_lb_target_group" "appoinmrnt_tg" {
  name     = var.tg_name_appoinment
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path     = "/health"
    protocol = "HTTP"
  }

  tags = {
    Name = "appoinmrnt_tg"
  }
}


# Creating Application Load Balancer

resource "aws_lb" "usecase8_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups = var.alb_sg
  subnets            = var.public_subnets
}