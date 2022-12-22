provider "aws" {
  region = "us-east-1"
}

module s3 {
  source = "./modules/s3"
}

module rds {
  source = "./modules/rds"
}
