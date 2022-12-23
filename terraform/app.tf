provider "aws" {
  region = "us-east-1"
}

module rds {
  source = "./modules/rds"
}