data "aws_security_group" "main" {
	name = "security_group_server"
}
data "aws_subnet" "main" {
	filter {
		name = "tag:Name"
		values = ["public-1"]
	}
}
data "aws_db_instance" "main" {
	db_instance_identifier = var.db_instance_identifier
}


resource "aws_key_pair" "deployer" {
	key_name	= "user-key"
	public_key = file("~/${var.id_public_key_path}")
}

resource "aws_instance" "server" {
	count = var.instance_count
	ami = var.image_id
	instance_type = var.instance_type
	key_name = aws_key_pair.deployer.key_name

	subnet_id = data.aws_subnet.main.id
	vpc_security_group_ids = [data.aws_security_group.main.id]

	# tags
	tags = {
		Name = "server-${count.index}"
	}
}