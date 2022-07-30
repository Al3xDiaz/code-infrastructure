#variables
#providers
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


#aws instance
  # vars for ami Ubuntu 22.04 LTS (HVM), SSD Volume Type
variable "instance_type" {
    description = "Instance type"
    default = "t2.micro"    
}
variable "image_id" {
    description = "AMI to use"
    default = "ami-0b9c9d9c6b80f9f9e"
}
variable "tags" {
    description = "Tags to apply to the instance"
    type = map
    default = {
        Name = "terraform-test"
    }
}