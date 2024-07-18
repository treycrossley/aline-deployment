
terraform {
  backend "s3" {
    bucket         = "aline-tfstate-tc"  # Replace with the name of your S3 bucket
    region         = "us-east-1"         # Ensure this matches your bucket's region
    dynamodb_table = "app-state"         # Replace with the name of your DynamoDB table
    encrypt        = true
    key            = "eks/terraform.tfstate"  # Adjust the key as needed
  }
}


data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "aline-tfstate-tc"
    region = "us-east-1"
    key    = "network/terraform.tfstate"
  }
}



module "eks_cluster" {
  source         = "../modules/eks/eks-cluster"
  vpc_subnet_ids = data.terraform_remote_state.network.outputs.all_subnet_ids
}

module "eks_node_group" {
  source       = "../modules/eks/nodes"
  cluster_name = module.eks_cluster.name
  subnet_ids   = data.terraform_remote_state.network.outputs.all_subnet_ids
}

module "eks_iam_oidc" {
  source              = "../modules/eks/iam-oidc"
  cluster_oidc_issuer = module.eks_cluster.oidc_issuer
}

# module "iam_test" {
#   source       = "../modules/eks/iam-test"
#   provider_url = module.eks_iam_oidc.openid_connect_provider_url
#   provider_arn = module.eks_iam_oidc.openid_connect_provider_arn

# }

module "eks_autoscaler" {
  source       = "../modules/eks/iam-autoscaler"
  provider_url = module.eks_iam_oidc.openid_connect_provider_url
  provider_arn = module.eks_iam_oidc.openid_connect_provider_arn
}


provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority)
    config_path    = ""
    config_context = ""

      exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        command     = "aws"
        args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.name]
      }
  }
}

module "nginx_ingress_controller" {
  source = "../modules/eks/nginx-ingress-controller"
}