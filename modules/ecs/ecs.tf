# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_name
  }
}

# CloudWatch Log Group for Patient
resource "aws_cloudwatch_log_group" "patient_service" {
  name              = var.patient_log_group_name
  retention_in_days = 7

  tags = {
    Name = var.patient_log_group_name
  }
}

# CloudWatch Log Group for Appointment
resource "aws_cloudwatch_log_group" "appointment_service" {
  name              = var.appoinment_log_group_name
  retention_in_days = 7

  tags = {
    Name        = var.appoinment_log_group_name
  }
}

# ECS Task Definition for Patient Service
resource "aws_ecs_task_definition" "patient_service" {
  family                   = var.patient-service
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn           = var.task_role_arn

  container_definitions = jsonencode([
    {
      name  = "patient-service"
      image = "${var.ecr_patient_repo_url}:latest"
      
      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      healthCheck = {
        command = [
          "CMD-SHELL",
          "curl -f http://localhost:${var.app_port}/health || exit 1"
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.patient_service.name
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment = [
        {
          name  = "NODE_ENV"
#          value = var.environment
        },
        {
          name  = "PORT"
          value = tostring(var.app_port)
        }
      ]

      essential = true
    }
  ])

  tags = {
    Name        = var.patient-service
    Service     = "patient-service"
  }
}

# ECS Task Definition for Appointment Service
resource "aws_ecs_task_definition" "appointment_service" {
  family                   = var.appointment-service-task
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn           = var.task_role_arn

  container_definitions = jsonencode([
    {
      name  = "appointment-service"
      image = "${var.ecr_appointment_repo_url}:latest"
      
      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      healthCheck = {
        command = [
          "CMD-SHELL",
          "curl -f http://localhost:${var.app_port}/health || exit 1"
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.appointment_service.name
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }

      environment = [
        {
          name  = "NODE_ENV"
#          value = var.environment
        },
        {
          name  = "PORT"
          value = tostring(var.app_port)
        }
      ]

      essential = true
    }
  ])

  tags = {
    Name        = var.appointment-service-task
  }
}
--------------------------------------------------
# ECS Service for Patient Service
resource "aws_ecs_service" "patient_service" {
  name            = "${var.project_name}-${var.environment}-patient-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient_service.arn
  desired_count   = var.desired_capacity
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_security_group_id]
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arns.patient_service
    container_name   = "patient-service"
    container_port   = var.app_port
  }

  depends_on = [var.target_group_arns]

  tags = {
    Name        = "${var.project_name}-${var.environment}-patient-service"
    Service     = "patient-service"
    Environment = var.environment
  }
}

# ECS Service for Appointment Service
resource "aws_ecs_service" "appointment_service" {
  name            = "${var.project_name}-${var.environment}-appointment-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment_service.arn
  desired_count   = var.desired_capacity
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_security_group_id]
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arns.appointment_service
    container_name   = "appointment-service"
    container_port   = var.app_port
  }

  depends_on = [var.target_group_arns]

  tags = {
    Name        = "${var.project_name}-${var.environment}-appointment-service"
    Service     = "appointment-service"
    Environment = var.environment
  }
}

# Data source for current AWS region
data "aws_region" "current" {}