
# # ECS STUFF

# # module "ecs_iam" {
# #   source = "./modules/ecs/ecs-iam"
# # }

# # module "ecs_service_security_group" {
# #   source = "./modules/ecs/ecs-security-groups"
# #   vpc_id = module.vpc.vpc_id
# # }

# # module "ecs_cluster" {
# #   source = "./modules/ecs/ecs-cluster"
# # }

# # module "ec2_instances" {
# #   source             = "./modules/ecs/ecs-autoscaler"
# #   security_groups    = [module.ecs_service_security_group.security_group_id]
# #   cluster_name       = module.ecs_cluster.cluster_name
# #   cluster_id         = module.ecs_cluster.cluster_id
# #   subnets            = module.subnets.public_subnet_ids
# #   instance_role_name = module.ecs_iam.instance_role_name
# # }



# # module "ecs_lb" {
# #   source          = "./modules/ecs/ecs-load-balancer"
# #   security_groups = [module.ecs_service_security_group.security_group_id]
# #   subnets         = module.subnets.public_subnet_ids
# #   vpc_id          = module.vpc.vpc_id
# # }

# # module "admin_portal_task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "admin-portal"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name      = "admin-portal"
# #       image     = "590184030834.dkr.ecr.us-east-1.amazonaws.com/admin-portal-tc:v2"
# #       essential = true
# #       portMappings = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           name  = "REACT_APP_MEMBER_DASHBOARD_URL"
# #           value = "${module.ecs_lb.load_balancer_dns_name}/member"
# #         },
# #         {
# #           name  = "REACT_APP_API_URL"
# #           value = "/api"
# #         },
# #         {
# #           name  = "LANDING_PORTAL_PORT"
# #           value = "3000"
# #         },
# #         {
# #           name  = "EXTEND_ESLINT"
# #           value = "true"
# #         },
# #         {
# #           name  = "REACT_APP_TOKEN_NAME"
# #           value = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJxeTNvOG4wRHVXajE3OEdXaW9XQk5BUEYiLCJleHAiOjE2MjO2MjI5NjQsImlhdCI6MTYzNjQxNDM2NH0.SflKxwRJSMeKTF2Q4fwpeJf36POk675gRqw5c"
# #         },
# #         {
# #           name  = "REACT_APP_API_BASEURL"
# #           value = "/api"
# #         },
# #         {
# #           name  = "REACT_APP_BROKER_URL"
# #           value = "/"
# #         },
# #         {
# #           name  = "SONAR_TOKEN"
# #           value = ""
# #         },
# #         {
# #           name  = "SONAR_HOST_URL"
# #           value = ""
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "landing_portal_task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "landing-portal"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "landing-portal"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/landing-portal-tc:v2"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       env             = [
# #         {
# #           name  = "REACT_APP_MEMBER_DASHBOARD_URL"
# #           value = "${module.ecs_lb.load_balancer_dns_name}/member"
# #         },
# #         {
# #           name  = "REACT_APP_API_URL"
# #           value = "/api"
# #         },
# #         {
# #           name = "PORT"
# #           value = "3000"
# #         }

# #       ]
# #     }
# #   ]
# # }

# # module "member_portal_task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "member-portal"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "member-portal"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/member-dashboard-tc:v4"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "gateway_task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "gateway"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "gateway"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/gateway-tc:v3"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "APP_PORT",
# #           "value": "8080"
# #         },
# #         {
# #           "name": "PORTAL_LANDING",
# #           "value": "/"
# #         },
# #         {
# #           "name": "PORTAL_DASHBOARD",
# #           "value": "http://${module.ecs_lb.load_balancer_dns_name}/member"
# #         },
# #         {
# #           "name": "PORTAL_ADMIN",
# #           "value": "/admin"
# #         },
# #         {
# #           "name": "APP_SERVICE_HOST",
# #           "value": "${module.ecs_lb.load_balancer_dns_name}"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "user-microservice-task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "user-microservice"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "user-microservice"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/user-microservice-tc:latest"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "JWT_SECRET_KEY",
# #           "value": "x2wOrQfY6RQIfE1ETwZtpflC19KyfN9N"
# #         },
# #         {
# #           "name": "ENCRYPT_SECRET_KEY",
# #           "value": "mf5ZIxRkF6IJj1AIVreII2ZQ4uhtJ8zC"
# #         },
# #         {
# #           "name": "DB_USERNAME",
# #           "value": "admin"
# #         },
# #         {
# #           "name": "DB_PASSWORD",
# #           "value": "Password123!"
# #         },
# #         {
# #           "name": "DB_NAME",
# #           "value": "aline"
# #         },
# #         {
# #           "name": "DB_HOST",
# #           "value": "aline-db-tc.cdw6w0asquiq.us-east-1.rds.amazonaws.com"
# #         },
# #         {
# #           "name": "DB_PORT",
# #           "value": "3306"
# #         },
# #         {
# #           "name": "APP_PORT",
# #           "value": "8070"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "underwriter-microservice-task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "underwriter-microservice"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "underwriter-microservice"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/underwriter-microservice-tc:latest"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "JWT_SECRET_KEY",
# #           "value": "x2wOrQfY6RQIfE1ETwZtpflC19KyfN9N"
# #         },
# #         {
# #           "name": "ENCRYPT_SECRET_KEY",
# #           "value": "mf5ZIxRkF6IJj1AIVreII2ZQ4uhtJ8zC"
# #         },
# #         {
# #           "name": "DB_USERNAME",
# #           "value": "admin"
# #         },
# #         {
# #           "name": "DB_PASSWORD",
# #           "value": "Password123!"
# #         },
# #         {
# #           "name": "DB_NAME",
# #           "value": "aline"
# #         },
# #         {
# #           "name": "DB_HOST",
# #           "value": "aline-db-tc.cdw6w0asquiq.us-east-1.rds.amazonaws.com"
# #         },
# #         {
# #           "name": "DB_PORT",
# #           "value": "3306"
# #         },
# #         {
# #           "name": "APP_PORT",
# #           "value": "8071"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "account-microservice-task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "account-microservice"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "account-microservice"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/account-microservice-tc:latest"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "JWT_SECRET_KEY",
# #           "value": "x2wOrQfY6RQIfE1ETwZtpflC19KyfN9N"
# #         },
# #         {
# #           "name": "ENCRYPT_SECRET_KEY",
# #           "value": "mf5ZIxRkF6IJj1AIVreII2ZQ4uhtJ8zC"
# #         },
# #         {
# #           "name": "DB_USERNAME",
# #           "value": "admin"
# #         },
# #         {
# #           "name": "DB_PASSWORD",
# #           "value": "Password123!"
# #         },
# #         {
# #           "name": "DB_NAME",
# #           "value": "aline"
# #         },
# #         {
# #           "name": "DB_HOST",
# #           "value": "aline-db-tc.cdw6w0asquiq.us-east-1.rds.amazonaws.com"
# #         },
# #         {
# #           "name": "DB_PORT",
# #           "value": "3306"
# #         },
# #         {
# #           "name": "APP_PORT",
# #           "value": "8072"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "transaction-microservice-task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "transaction-microservice"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "transaction-microservice"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/transaction-microservice-tc:latest"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "JWT_SECRET_KEY",
# #           "value": "x2wOrQfY6RQIfE1ETwZtpflC19KyfN9N"
# #         },
# #         {
# #           "name": "ENCRYPT_SECRET_KEY",
# #           "value": "mf5ZIxRkF6IJj1AIVreII2ZQ4uhtJ8zC"
# #         },
# #         {
# #           "name": "DB_USERNAME",
# #           "value": "admin"
# #         },
# #         {
# #           "name": "DB_PASSWORD",
# #           "value": "Password123!"
# #         },
# #         {
# #           "name": "DB_NAME",
# #           "value": "aline"
# #         },
# #         {
# #           "name": "DB_HOST",
# #           "value": "aline-db-tc.cdw6w0asquiq.us-east-1.rds.amazonaws.com"
# #         },
# #         {
# #           "name": "DB_PORT",
# #           "value": "3306"
# #         },
# #         {
# #           "name": "APP_PORT",
# #           "value": "8073"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "bank-microservice-task" {
# #   source             = "./modules/ecs/ecs-tasks"
# #   family             = "bank-microservice"
# #   execution_role_arn = module.ecs_iam.role_arn
# #   container_definitions = [
# #     {
# #       name            = "bank-microservice"
# #       image           = "590184030834.dkr.ecr.us-east-1.amazonaws.com/bank-microservice-tc:latest"
# #       essential       = true
# #       portMappings    = [
# #         {
# #           containerPort = 80
# #           hostPort      = 80
# #         }
# #       ]
# #       environment = [
# #         {
# #           "name": "JWT_SECRET_KEY",
# #           "value": "x2wOrQfY6RQIfE1ETwZtpflC19KyfN9N"
# #         },
# #         {
# #           "name": "ENCRYPT_SECRET_KEY",
# #           "value": "mf5ZIxRkF6IJj1AIVreII2ZQ4uhtJ8zC"
# #         },
# #         {
# #           "name": "DB_USERNAME",
# #           "value": "admin"
# #         },
# #         {
# #           "name": "DB_PASSWORD",
# #           "value": "Password123!"
# #         },
# #         {
# #           "name": "DB_NAME",
# #           "value": "aline"
# #         },
# #         {
# #           "name": "DB_HOST",
# #           "value": "aline-db-tc.cdw6w0asquiq.us-east-1.rds.amazonaws.com"
# #         },
# #         {
# #           "name": "DB_PORT",
# #           "value": "3306"
# #         },
# #         {
# #           "name": "APP_PORT",
# #           "value": "8083"
# #         }
# #       ]
# #     }
# #   ]
# # }

# # module "admin_portal_service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "admin-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.admin_portal_task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.admin_portal_tg_arn
# #   container_name      = "admin-portal"
# # }

# # module "landing_portal_service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "landing-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.landing_portal_task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.landing_portal_tg_arn
# #   container_name      = "landing-portal"
# # }

# # module "member-portal-service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "member-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.member_portal_task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.member_portal_tg_arn
# #   container_name      = "member-portal"
# # }

# # module "user-microservice-service" {  
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "user-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.user-microservice-task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.user_microservice_tg_arn
# #   container_name      = "user-microservice"
# # }

# # module "bank-microservice-service" {  
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "bank-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.bank-microservice-task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]   
# #   target_group_arn    = module.ecs_lb.bank_microservice_tg_arn
# #   container_name      = "bank-microservice"
# # } 

# # module "gateway-service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "gateway-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.gateway_task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.gateway_tg_arn
# #   container_name      = "gateway-service"
# # }

# # module "underwriter-microservice-service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "underwriter-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.underwriter-microservice-task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.underwriter_microservice_tg_arn
# #   container_name      = "underwriter-microservice"
# # }

# # module "account-microservice-service" {
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "account-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.account-microservice-task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.account_microservice_tg_arn
# #   container_name      = "account-microservice"
# # }

# # module "transaction-microservice-service" { 
# #   source              = "./modules/ecs/ecs-services"
# #   name                = "transaction-service"
# #   cluster_id          = module.ecs_cluster.cluster_id
# #   task_definition_arn = module.transaction-microservice-task.task_definition_arn
# #   subnets             = concat(module.subnets.private_subnet_ids, module.subnets.public_subnet_ids)
# #   security_groups     = [module.ecs_service_security_group.security_group_id]
# #   target_group_arn    = module.ecs_lb.transaction_microservice_tg_arn
# #   container_name      = "transaction-microservice"
# # }
