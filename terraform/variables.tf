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
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port = "22"
      to_port = "22"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port = "443"
      to_port = "443"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
#EC2
variable "db_ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = [
		{
			from_port = "3306"
			to_port = "3306"
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
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
  default = "ami-0c1b4dff690b5d229"
}
variable "settings_domains" {
	type = list(object({domain_name = string, service_port = number,domain_db_name = string}))
	description = "domain name and port"
	default = [
		{
			domain_name = "cms.chaoticteam.com"
			service_port = 8080,
			domain_db_name = "example"			
		}
	]
}

variable cloudflare_api_token {
	default = ""
	description = "The Cloudflare API token to use for authentication"
}