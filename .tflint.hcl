plugin "aws" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Configure AWS provider version constraints
rule "terraform_required_providers" {
  enabled = true
}

# Enforce version constraints
rule "terraform_required_version" {
  enabled = true
}

# Naming conventions
rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

# Enforce consistent variable types
rule "terraform_typed_variables" {
  enabled = true
}


rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_db_instance_invalid_type" {
  enabled = true
}

rule "aws_instance_previous_type" {
  enabled = true
}