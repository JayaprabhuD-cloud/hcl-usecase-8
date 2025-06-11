output "patient_repo_url" {
  value = aws_ecr_repository.patient.repository_url
}

output "appointment_repo_url" {
  value = aws_ecr_repository.appointment.repository_url
}

output "patient_repo_arn" {
  value = aws_ecr_repository.patient.arn
}

output "appointment_repo_arn" {
  value = aws_ecr_repository.appointment.arn
}