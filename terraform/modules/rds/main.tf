data "aws_security_group" "rds_sg" {
	filter {
		name = "tag:Name"
		values = ["db"]
	}
}
resource "aws_db_instance" "rds_instance" {
	allocated_storage = var.db_storage
	identifier = var.db_identifier
	storage_type = "gp2"
	engine = var.db_engine
	engine_version = var.db_engine_version
	instance_class = var.db_instance_class
	name = var.db_name
	username = var.db_username
	password =  var.db_password
	publicly_accessible    = true
	skip_final_snapshot    = true
	vpc_security_group_ids = [data.aws_security_group.rds_sg.id]
}

output "rds_output" {
  value = aws_db_instance.rds_instance
}