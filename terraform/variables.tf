# terraform state
variable "address" {
  type = string
  description = "Gitlab remote state file address"
}

variable "username" {
  type = string
  description = "Gitlab username to query remote state"
}

variable "password" {
  type = string
  description = "GitLab access token to query remote state"
}

variable default_tags {
	type = map(string)
	default = {
  "Terraform" = "true"
	}
}

#RDS
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
  default = "rds-terraform-mariadb"
}
variable "db_storage"{
  description = "allocated storage"
  default = 20
}
variable "db_instance_class" {
  description = "database instance class"
  default = "db.t2.micro"
}

#VPC
variable "instance_ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))
  default = []
}
variable "db_ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))
  default = [
		{
			from_port = "3306"
			to_port = "3306"
			protocol = "tcp"
		}
  ]
}
variable "lb_ingress_rules" {
	description = "Ingress rules"
	type = list(object({
		from_port = number
		to_port = number
		protocol = string
	}))
	default = [
		{
			from_port = "80"
			to_port = "80"
			protocol = "tcp"
		},
		{
			from_port = "443"
			to_port = "443"
			protocol = "tcp"
		}
	]
}
#EC2
variable id_public_key_path {
	description = "Path to the public key to be used for the instance"
}
variable id_private_key_path {
	description = "Path to the private key to be used for the instance"
}
variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}
variable "instance_count" {
  default = 1
  description = "Instances number create"
}
variable "image_id" {
  description = "AMI to use"
  default = "ami-053b0d53c279acc90"
}

variable cloudflare_api_token {
	default = ""
	description = "The Cloudflare API token to use for authentication"
}

# load balancer
variable target_groups {
	default = []
	description = "The target groups to update"
	type = list(object({
		hosts = list(string)
		port = number
		path = string
		name = string
	}))
}