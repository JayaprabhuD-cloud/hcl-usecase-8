# Creating target group for patient application

resource "aws_lb_target_group" "patient_tg" {
  name     = var.tg_name_patient
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
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
  vpc_id   = var.vpc_id
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
  security_groups    = var.alb_sg
  subnets            = var.public_subnets

  tags = {
    Name = var.alb_name
  }
}

# Creating listener for alb

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.usecase8_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "patients and appointments applications"
      status_code  = "404"
    }
  }
  tags = {
    Name = "usecase8_alb_listener"
  }
}

# Creating listener rule for patient service

resource "aws_lb_listener_rule" "patient" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 8

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patient_tg.arn
  }

  condition {
    path_pattern {
      values = ["/patients*"]
    }
  }
  tags = {
    Name = "patient_listener_rule"
  }
}

# Creating listener rule for appoinment service

resource "aws_lb_listener_rule" "appoinment" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appoinmrnt_tg.arn
  }

  condition {
    path_pattern {
      values = ["/appoinment*"]
    }
  }
  tags = {
    Name = "appoinment_listener_rule"
  }
}