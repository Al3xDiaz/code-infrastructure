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

	# tags
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
		]
	}
}
resource null_resource remote_nginx_config {
	count = length(var.settings_domains)
	depends_on = [aws_instance.server]
	connection {
		type = "ssh"
		user = "root"
		private_key = file("~/${var.id_private_key_path}")
		host = aws_instance.server[0].public_ip
	}
	provisioner "remote-exec" {		
		inline = [
			"echo \"${templatefile("${path.module}/nginx/nginx.conf",{
				domain_name = var.settings_domains[count.index].domain_name,
				service_port = var.settings_domains[count.index].service_port,
			})}\" > /etc/nginx/sites-available/${var.settings_domains[count.index].domain_name}",
			"ln -fs /etc/nginx/sites-available/${var.settings_domains[count.index].domain_name} /etc/nginx/sites-enabled/",
			"systemctl restart nginx",
			"echo create folder wordpress...",
			"mkdir -p /home/admin/${split(".", var.settings_domains[count.index].domain_name)[0]}",
			"cd /home/admin/${split(".", var.settings_domains[count.index].domain_name)[0]}",
			"echo create docker-compose.yml...",
			"echo \"${templatefile("${path.module}/wordpress/docker-compose.yml", {
				WORDPRESS_DB_HOST = data.aws_db_instance.main.address
				WORDPRESS_DB_NAME = var.settings_domains[count.index].domain_db_name
				WORDPRESS_DB_USER = var.db_username
				WORDPRESS_DB_PASSWORD = var.db_password
				WORDPRESS_SERVICE_PORT = var.settings_domains[count.index].service_port,
			})}\" > /home/admin/${split(".",var.settings_domains[count.index].domain_name)[0]}/docker-compose.yml",
			"echo start docker-compose...",
			"docker-compose up -d",
		]
	}
}
resource null_resource ssh_config_admin {
	count = length(aws_instance.server)
	provisioner "local-exec" {
		command ="grep -oP 'Host ${aws_instance.server[count.index].public_ip}' ~/.ssh/config || echo 'Host ${aws_instance.server[count.index].public_ip}\n\tHostName ${aws_instance.server[count.index].id}\n\tUser admin\n\tIdentityFile ~/${var.id_private_key_path}\n' >> ~/.ssh/config]}"
	}
}
resource null_resource ssh_config_root{
	count = length(aws_instance.server)
	provisioner "local-exec" {
		command ="grep -oP 'Host ${aws_instance.server[count.index].public_ip}' ~/.ssh/config || echo 'Host ${aws_instance.server[count.index].public_ip}\n\tHostName ${aws_instance.server[count.index].id}\n\tUser root\n\tIdentityFile ~/${var.id_private_key_path}\n' >> ~/.ssh/config]}"
	}
}