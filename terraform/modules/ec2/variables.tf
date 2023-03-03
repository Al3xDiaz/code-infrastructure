variable "instance_type" {
    description = "Instance type" 
}
variable "instance_count" {
    description = "Instances number create"
}
variable "image_id" {
    description = "AMI to use"
}

variable id_public_key_path {
    description = "Path to the public key to use for SSH access"
}
variable id_private_key_path {
		description = "Path to the private key to use for SSH access"
}
variable "db_instance_identifier"{ 
		description = "DB instance identifier"
}
variable "db_username" {
    description = "database user name"
}
variable "db_password"{
    description = "database password"
}