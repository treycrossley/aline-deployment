
terraform {
  backend "s3" {
    bucket         = "aline-tfstate-tc"  # Replace with the name of your S3 bucket
    region         = "us-east-1"         # Ensure this matches your bucket's region
    dynamodb_table = "app-state"         # Replace with the name of your DynamoDB table
    encrypt        = true
    key            = "jenkins/terraform.tfstate"  # Adjust the key as needed for the network module
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

module "jenkins" {
  source    = "../modules/jenkins"
  vpc_id    = data.terraform_remote_state.network.outputs.vpc_id
  subnet_id = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
}