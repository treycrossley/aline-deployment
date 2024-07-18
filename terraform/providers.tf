terraform {

  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }

  backend "s3" {
    bucket         = "aline-tfstate-tc"  # Replace with the name of your S3 bucket
    region         = "us-east-1"                    # Ensure this matches your bucket's region
    dynamodb_table = "app-state"              # Replace with the name of your DynamoDB table
    encrypt        = true
    key            = "terraform.tfstate"
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}
