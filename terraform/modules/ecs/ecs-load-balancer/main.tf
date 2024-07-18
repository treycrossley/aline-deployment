resource "aws_lb" "main" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
}


resource "aws_lb_target_group" "admin_portal_tg" {
  name        = "admin-portal-tg"
  port        = 3007
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "admin_portal_tg_attachment" {
  target_group_arn = aws_lb_target_group.admin_portal_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 3007
}


resource "aws_lb_target_group" "landing_portal_tg" {
  name        = "landing-portal-tg"
  port        = 3000
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "landing_portal_tg_attachment" {
  target_group_arn = aws_lb_target_group.landing_portal_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 3000
}


resource "aws_lb_target_group" "member_portal_tg" {
  name        = "member-portal-tg"
  port        = 4200
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "member_portal_tg_attachment" {
  target_group_arn = aws_lb_target_group.member_portal_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 4200
}

resource "aws_lb_target_group" "user_microservice_tg" {
  name        = "user-microservice-tg"
  port        = 8070
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "user_microservice_tg_attachment" {
  target_group_arn = aws_lb_target_group.user_microservice_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8070
}

resource "aws_lb_target_group" "underwriter_microservice_tg" {
  name        = "underwriter-microservice-tg"
  port        = 8071
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "underwriter_microservice_tg_attachment" {
  target_group_arn = aws_lb_target_group.underwriter_microservice_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8071
}

resource "aws_lb_target_group" "bank_microservice_tg" {
  name        = "bank-microservice-tg"
  port        = 8083
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "bank_microservice_tg_attachment" {
  target_group_arn = aws_lb_target_group.bank_microservice_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8083
}

resource "aws_lb_target_group" "transaction_microservice_tg" {  
  name        = "transaction-microservice-tg"
  port        = 8073
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
} 

resource "aws_lb_target_group_attachment" "transaction_microservice_tg_attachment" {
  target_group_arn = aws_lb_target_group.transaction_microservice_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8073
}

resource "aws_lb_target_group" "gateway_tg" {
  name        = "gateway-tg"
  port        = 8080
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "gateway_tg_attachment" {
  target_group_arn = aws_lb_target_group.gateway_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8080
}


resource "aws_lb_target_group" "account_microservice_tg" {
  name        = "account-microservice-tg"
  port        = 8072
  protocol    = var.protocol
  vpc_id      = var.vpc_id  # Replace with your VPC ID
}

resource "aws_lb_target_group_attachment" "account_microservice_tg_attachment" {
  target_group_arn = aws_lb_target_group.account_microservice_tg.arn
  target_id        = aws_lb.main.dns_name
  port             = 8072
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.landing_portal_tg.arn
  }
}

resource "aws_lb_listener_rule" "admin_portal_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.admin_portal_tg.arn
  }

  condition {
    path_pattern {
      values = ["/admin/*"]
    }
  }
}

resource "aws_lb_listener_rule" "landing_portal_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 90

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.landing_portal_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_lb_listener_rule" "user_microservice_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 80

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.user_microservice_tg.arn
  }

  condition {
    path_pattern {
      values = ["/user/*"]
    }
  }
}

resource "aws_lb_listener_rule" "underwriter_microservice_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 70

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.underwriter_microservice_tg.arn
  }

  condition {
    path_pattern {
      values = ["/underwriter/*"]
    }
  }
}

resource "aws_lb_listener_rule" "bank_microservice_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 60

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bank_microservice_tg.arn
  }

  condition {
    path_pattern {
      values = ["/bank/*"]
    }
  }
}

resource "aws_lb_listener_rule" "transaction_microservice_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 50

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.transaction_microservice_tg.arn
  }

  condition {
    path_pattern {
      values = ["/transaction/*"]
    }
  }
}

resource "aws_lb_listener_rule" "account_microservice_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 40

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.account_microservice_tg.arn
  }

  condition {
    path_pattern {
      values = ["/account/*"]
    }
  }
}

resource "aws_lb_listener_rule" "gateway_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gateway_tg.arn
  }

  condition {
    path_pattern {
      values = ["/gateway/*"]
    }
  }
}