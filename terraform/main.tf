provider "aws"{
    region = "us-east-1"
}
resource "aws_instance" "test" {
    # ami for Ubuntu 22.04 LTS (HVM), SSD Volume Type
    ami = "ami-052efd3df9dad4825"
    instance_type = "t2.micro"
    tags = {
        Name = "test-instance"
        Environment = "Development"
    }
}