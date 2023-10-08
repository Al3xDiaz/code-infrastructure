terraform {
  required_providers {
    mysql = {
      source = "petoju/mysql"
      version = "3.0.42"
    }
  }
}
provider "mysql" {
  endpoint = aws_db_instance.rds_instance.endpoint
  username = aws_db_instance.rds_instance.username
  password = aws_db_instance.rds_instance.password
}

# Create a second database, in addition to the "initial_db" created
# by the aws_db_instance resource above.
resource "mysql_database" "gorm" {
  name = "gorm"
}
resource "mysql_database" "wordpress" {
  name = "wordpress"
}