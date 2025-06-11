output "cluster_id" {
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  value       = aws_ecs_cluster.main.name
}

output "cluster_arn" {
  value       = aws_ecs_cluster.main.arn
}

output "patient_service_task_definition_arn" {
  value       = aws_ecs_task_definition.patient_service.arn
}

output "appointment_service_task_definition_arn" {
  value       = aws_ecs_task_definition.appointment_service.arn
}

output "patient_service_service_name" {
  value       = aws_ecs_service.patient_service.name
}

output "appointment_service_service_name" {
  value       = aws_ecs_service.appointment_service.name
}

output "log_group_names" {
  description = "Names of CloudWatch log groups"
  value = {
    patient_service     = aws_cloudwatch_log_group.patient_service.name
    appointment_service = aws_cloudwatch_log_group.appointment_service.name
  }
}