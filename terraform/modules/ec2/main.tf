data "aws_security_group" "main" {
	name = "security_group_server"
}
data "aws_subnet" "main" {
	filter {
		name = "tag:Name"
		values = ["public-1"]
	}
}
data "http" "latest" {
	url = "https://raw.githubusercontent.com/Al3xDiaz/code-infrastructure/main/install-docker-debian.sh"
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
	tags = {
		Name = "server-${count.index}"
	}
	
	provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "root"
			private_key = file(split(".pub", var.id_public_key_path)[0])
			host = self.public_ip
		}
		inline = [
			# instal nginx
			"apt-get update -y",
			"apt-get install nginx -y",
			"systemctl start nginx",
			"systemctl enable nginx",
			# install docker and docker-compose
			"${data.http.latest.response_body}",
			"echo \"${file("${path.module}/nginx/nginx.conf")}\" > /etc/nginx/sites-available/cms.chaoticteam.com",
			"ln -s /etc/nginx/sites-available/cms.chaoticteam.com /etc/nginx/sites-enabled/",
			"systemctl restart nginx",
		]
	}
	provisioner "remote-exec" {
		connection {
			type = "ssh"
			user = "admin"
			private_key = file("~/${var.id_private_key_path}")
			host = self.public_ip
		}
		inline = [
			"echo create folder wordpress...",
			"mkdir -p /home/admin/wordpress",
			"cd /home/admin/wordpress",
			"echo create docker-compose.yml...",
			"echo \"${templatefile("${path.module}/wordpress/docker-compose.yml", {
				WORDPRESS_DB_HOST = data.aws_db_instance.main.address
				WORDPRESS_DB_NAME = data.aws_db_instance.main.db_name
				WORDPRESS_DB_USER = var.db_username
				WORDPRESS_DB_PASSWORD = var.db_password
			})}\" > /home/admin/wordpress/docker-compose.yml",
			"echo start docker-compose...",
			"docker-compose up -d",
		]
	}
	provisioner "local-exec" {
		command = "echo 'Host server-${count.index}-admin\n\tHostName ${self.public_ip}\n\tUser admin\n\tIdentityFile ~/${var.id_private_key_path}\n' >> ~/.ssh/config"
	}
	provisioner "local-exec" {
		command = "echo 'Host server-${count.index}-root\n\tHostName ${self.public_ip}\n\tUser root\n\tIdentityFile ~/${var.id_private_key_path}\n' >> ~/.ssh/config"
	}
}

output "instance" {
	value = aws_instance.server
}