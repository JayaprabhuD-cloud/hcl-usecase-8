# Creating first repo for patient docker image

resource "aws_ecr_repository" "Patient" {
  name                 = var.repo_name_1
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = var.repo_name_1
  }
}

# Creating first repo for appointment docker image

resource "aws_ecr_repository" "appointment" {
  name                 = var.repo_name_2
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = var.repo_name_2
  }
}