data "aws_availability_zones" "available_zones" {
  state = "available"
}
resource "aws_vpc" "main" {
  cidr_block            = "10.32.0.0/16"
  enable_dns_hostnames  = true 
	enable_dns_support = true
	tags = {
		Name = "main"
	}
}

resource "aws_subnet" "public" {
  count                   = 2
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
	tags = {
		"Name" = "public-${count.index}"
	}
}

resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block,8 , count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id            = aws_vpc.main.id
	tags = {
		"Name" = "private-${count.index}"
	}
}

resource "aws_db_subnet_group" "main" {
	name       = "main"
	subnet_ids = flatten([aws_subnet.public.*.id, aws_subnet.private.*.id])
	tags = {
		VPC = aws_vpc.main.id
	}
}