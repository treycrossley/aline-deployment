#!/bin/bash

# Define directories
NETWORK_DIR="network"
JENKINS_DIR="jenkins"
RDS_DIR="rds"  # Add RDS directory
EKS_DIR="eks"   # Add EKS directory

# Function to run terraform destroy with confirmation

# Function to run terraform destroy
destroy_terraform() {
  DIR=$1
  echo "Destroying resources in $DIR..."
  cd $DIR
  terraform destroy -auto-approve
  cd -
  echo "Resources destroyed in $DIR."
}

# Prompt for confirmation once at the beginning
read -r -p "This script will destroy resources in all defined directories (network, jenkins, rds, eks). Are you sure you want to proceed? (y/N) " response
case "$response" in
  [yY]*)
    echo "Proceeding with Terraform destroy..."
    # Destroy resources in each directory without further prompt
   
    destroy_terraform $EKS_DIR
    destroy_terraform $RDS_DIR
    destroy_terraform $JENKINS_DIR
    destroy_terraform $NETWORK_DIR
    echo "Terraform destroy completed for all specified directories."
    ;;
  *)
    echo "Terraform destroy cancelled."
    ;;
esac
