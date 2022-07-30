provider "aws" {
  region = "us-east-1"
}
# terraform {
#     backend "s3"{
#         bucket = "terraform-state-123456789"
#         key = "dev"
#         region = "us-west-1"
#         encrypt = true
#         kms_key_id = " (known after apply)" #use the ARN of the KMS key output.resurces.aws_kms_key.key
#     }
# }


module s3 {
  source = "./modules/s3"
}

module instance {
  source = "./modules/instance"
}
