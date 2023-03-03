resource "aws_security_group" "server" {
	name = "security_group_server"
	vpc_id = aws_vpc.main.id
	dynamic "ingress" {
	for_each = var.instance_ingress_rules
	content {
		from_port = ingress.value.from_port
		to_port = ingress.value.to_port
		protocol = ingress.value.protocol
		cidr_blocks = ingress.value.cidr_blocks
	}
	}
	egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
	tags = {
		Name = "main"
	}
	lifecycle {
		ignore_changes = [
			ingress
		]
	}
}
resource "aws_security_group_rule" "server" {
	type = "ingress"
	from_port = 0
	to_port = 0
	protocol = "-1"
	security_group_id = aws_security_group.server.id
	source_security_group_id = aws_security_group.db.id
}
resource "aws_security_group" "db" {
	name = "security_group_db"
	vpc_id = aws_vpc.main.id
	dynamic "ingress" {
	for_each = var.db_ingress_rules
	content {
		from_port = ingress.value.from_port
		to_port = ingress.value.to_port
		protocol = ingress.value.protocol
		cidr_blocks = ingress.value.cidr_blocks
	}
	}
	egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
	tags = {
		Name = "db"
	}
}