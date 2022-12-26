provider "aws" {
  region = "us-east-2"
}

module eks {
  source = "github.com/hashicorp/learn-terraform-provision-eks-cluster"
}

module rds {
  source = "./modules/rds"
}