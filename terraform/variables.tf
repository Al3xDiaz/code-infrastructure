#variables
variable "instance_type" {
    description = "Instance type"
}
variable "image_id" {
    description = "AMI to use"
}
variable "tags" {
    description = "Tags to apply to the instance"
    type = map
    default = {
        Name = "HelloWorld"
    }
}