
#aws s3 bucket
variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "terraform-state-123456789"
}
variable "bucket_alc" {
  description = "S3 bucket ACL"
  default = "private"
}
variable "bucket_tags" {
  description = "S3 bucket tags"
  type = map
  default = {
    Environment = "dev"
    CreatedBy = "terraform"
  }
}