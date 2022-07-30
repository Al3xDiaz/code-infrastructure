#Declare resources

# terraform {
#     backend "s3"{
#         bucket = "terraform-state-123456789"
#         key = "dev"
#         region = "us-west-1"
#     }
# }

provider "aws"{
    region = "us-east-1"
}
resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
    tags = var.bucket_tags
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.backend.id
    acl = var.bucket_alc
}

resource "aws_instance" "test" {
    ami = var.image_id
    instance_type = var.instance_type
    tags = var.tags
}

