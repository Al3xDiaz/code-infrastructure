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
resource "aws_ebs_volume" "ebs" {
	availability_zone = data.aws_subnet.main.availability_zone
	size = 4
	type = "gp2"
	tags = {
		Name = "ebs"
	}
}
resource "aws_volume_attachment" "ebs_att" {
	count = var.instance_count
	device_name = "/dev/sdh"
	volume_id = aws_ebs_volume.ebs.id
	instance_id = aws_instance.server[count.index].id
}

resource "aws_instance" "server" {
	count = var.instance_count
	ami = var.image_id
	instance_type = var.instance_type

	subnet_id = data.aws_subnet.main.id
	vpc_security_group_ids = [data.aws_security_group.main.id]

	user_data = <<-EOF
		#!/bin/bash
		echo "copy the public key to authorized_keys"
		mkdir -p /home/ubuntu/.ssh
		chmod 700 /home/ubuntu/.ssh
		echo "${file("~/${var.id_public_key_path}")}" >> /home/ubuntu/.ssh/authorized_keys
		chmod 600 /home/ubuntu/.ssh/authorized_keys
		chown -R ubuntu:ubuntu /home/ubuntu/.ssh
		echo "mount the ebs volume"
		sudo mkfs -t ext4 /dev/xvdh
		sudo mkdir -p /data
		sudo mount /dev/xvdh /data
	EOF

	# tags
	tags = {
		Name = "server-${count.index}"
	}
	lifecycle {
		create_before_destroy = false
	}
}

output "servers" {
	value = [ for server in aws_instance.server : "${server.public_ip}"]
}
output public_ip {
	value = aws_instance.server[0].public_ip
}