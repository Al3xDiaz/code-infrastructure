#Declare resources

provider "aws"{
    region = "us-east-1"
}

resource "aws_instance" "test" {
    ami = var.image_id
    instance_type = var.instance_type
    tags = var.tags
}

output "instance" {
   value = {
    id = aws_instance.test.id
    public_ip = aws_instance.test.public_ip
   }
    
}


