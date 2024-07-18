output "load_balancer_arn" {
  description = "The ARN of the created load balancer"
  value       = aws_lb.main.arn
}


output "load_balancer_dns_name" {
  description = "The DNS name of the created load balancer"
  value       = aws_lb.main.dns_name
}

output "admin_portal_tg_arn" {
  value = aws_lb_target_group.admin_portal_tg.arn
}

output "landing_portal_tg_arn" {
  value = aws_lb_target_group.landing_portal_tg.arn
}

output "member_portal_tg_arn" {
  value = aws_lb_target_group.member_portal_tg.arn
}

output "user_microservice_tg_arn" {
  value = aws_lb_target_group.user_microservice_tg.arn
}

output "underwriter_microservice_tg_arn" {
  value = aws_lb_target_group.underwriter_microservice_tg.arn
}

output "bank_microservice_tg_arn" {
  value = aws_lb_target_group.bank_microservice_tg.arn
}

output "transaction_microservice_tg_arn" {
  value = aws_lb_target_group.transaction_microservice_tg.arn
}

output "gateway_tg_arn" {
  value = aws_lb_target_group.gateway_tg.arn
}

output "account_microservice_tg_arn" {
  value = aws_lb_target_group.account_microservice_tg.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.alb_listener.arn
}
