#variables
#providers
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