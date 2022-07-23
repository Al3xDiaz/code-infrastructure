#Declare resources

provider "aws"{
    region = "us-east-1"
}
resource "aws_instance" "test" {
    # ami for Ubuntu 22.04 LTS (HVM), SSD Volume Type
    ami = var.image_id
    instance_type = var.instance_type
    tags = var.tags
}