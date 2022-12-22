variable "db_engine" {
    description = "engine type"
    default = "mysql"    
}

variable "db_engine_version"{
    description = "engine version"
    default = "8.0.28"
}

variable "db_name" {
    description = "database name"
    default = "example"
}
variable "db_username" {
    description = "database user name"
    default = "admin"
}
variable "db_password"{
    description = "database password"
    default = "password"
}
variable "db_identifier" {
    description = "database identifier"
    default = "rds-terraform"
}
variable "db_storage"{
    description = "allocated storage"
    default = 20
}
variable "db_instance_class" {
    description = "database instance class"
    default = "db.t2.micro"
}