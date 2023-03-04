terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.38.0"
    }
  }
}
provider aws {
  region = "us-west-2"
  profile = "default"
  default_tags {
    tags = {
      Terraform = "true"
      Owner = "alex"
    }
  }
}
module vpc {
  source = "./modules/vpc"
  instance_ingress_rules = var.instance_ingress_rules
	db_ingress_rules =var.db_ingress_rules
}

module ec2 {
  source = "./modules/ec2"
  id_public_key_path= var.id_public_key_path
	id_private_key_path = var.id_private_key_path
  instance_type = var.instance_type
  instance_count = var.instance_count
  image_id = var.image_id
	db_instance_identifier = var.db_identifier
	db_username = var.db_username
	db_password = var.db_password
	depends_on = [module.vpc,module.rds]
}
module rds {
  source = "./modules/rds"
  db_engine = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_storage = var.db_storage
  db_identifier = var.db_identifier
	depends_on = [module.vpc]
}
module elb {
  source = "./modules/elb"
	depends_on = [module.vpc, module.ec2, module.rds,]
}
output "db" {
	value ={
		db_endpoint = module.rds.rds_output.endpoint
		db_name = module.rds.rds_output.name
		db_port = module.rds.rds_output.port
		db_username = module.rds.rds_output.username
		db_password = module.rds.rds_output.password
	}
	sensitive = true
}
output "resources" {
  value = {
		ec2 = {
			ec2_public_ip = module.ec2.instance.*.public_ip
			ec2_private_ip = module.ec2.instance.*.private_ip
		}
		elb = {
			elb_dns_name = module.elb.aws_lb.dns_name
		}
		aws_route53_zone_name_servers = {
			name_servers = module.elb.aws_route53_zone.name_servers
		}
  }
	sensitive = true
}