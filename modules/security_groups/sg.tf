# Creating security group for ALB
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.alb_sg_name
  }
}

# Creating security group for Application containers
resource "aws_security_group" "app_sg" {
  name   = var.app_sg_name
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
  Name = var.app_sg_name
  }
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "app_sg" {
  value = aws_security_group.app_sg.id
}