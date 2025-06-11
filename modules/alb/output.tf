output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.usecase8_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.usecase8_alb.arn
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value = {
    patient_service     = aws_lb_target_group.patient_tg.arn
    appointment_service = aws_lb_target_group.appoinmrnt_tg.arn
  }
}

output "patient_service_target_group_arn" {
  description = "ARN of the patient service target group"
  value       = aws_lb_target_group.patient_tg.arn
}

output "appointment_service_target_group_arn" {
  description = "ARN of the appointment service target group"
  value       = aws_lb_target_group.appoinmrnt_tg.arn
}

output "listener_arn" {
  value       = aws_lb_listener.http.arn
}