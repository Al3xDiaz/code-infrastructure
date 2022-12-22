provider "aws"{
    region = "us-east-1"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
  tags = var.bucket_tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.backend.id
  acl = var.bucket_alc
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.backend.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "local_file" "kms_key_output" {
  content  = aws_kms_key.mykey.arn
  filename = "${path.module}/kms_key_output.txt"
}


output "s3_bucket" {
   value = {
    aws_kms = {
      key =aws_kms_key.mykey.arn
    }
   }
}