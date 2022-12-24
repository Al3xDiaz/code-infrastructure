provider "aws" {
  region = "us-east-1"
}

module rds {
  source = "./modules/rds"
}

module eks {
  source = "github.com/hashicorp/learn-terraform-provision-eks-cluster"
}