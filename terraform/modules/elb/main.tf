data "aws_instance" "server" {
	filter {
		name = "instance-state-name"
		values = ["running"]
	}
}
data "aws_vpc" "main" {
	filter {
		name = "tag:Name"
		values = ["main"]
	}
}
data "aws_subnet" "public_0" {
	filter {
		name = "tag:Name"
		values = ["public-0"]
	}
}
data "aws_subnet" "public_1" {
	filter {
		name = "tag:Name"
		values = ["public-1"]
	}
}
data "aws_subnet" "private_0" {
	filter {
		name = "tag:Name"
		values = ["private-0"]
	}
}
data "aws_subnet" "private_1" {
	filter {
		name = "tag:Name"
		values = ["private-1"]
	}
}
data "aws_security_group" "main" {
	filter {
		name = "tag:Name"
		values = ["lb"]
	}
}

data "aws_elb_service_account" "main" {}

resource "aws_acm_certificate" "cert" {
  domain_name       = "chaoticteam.com"
	subject_alternative_names = ["*.chaoticteam.com"]
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "elb_logs" {
  bucket = "chaoticteam-elb-logs"
}
resource "aws_s3_bucket_policy" "elb_logs" {
	bucket = "${aws_s3_bucket.elb_logs.id}"
	policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::chaoticteam-elb-logs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_lb" "lb" {
	name = "lb"
	internal = false
	load_balancer_type = "application"
	security_groups = ["${data.aws_security_group.main.id}"]
	subnets = ["${data.aws_subnet.public_0.id}","${data.aws_subnet.public_1.id}"]
	

	access_logs {
    bucket   = "${aws_s3_bucket.elb_logs.bucket}"
    prefix = "load-balancer"
		enabled = true
  }
}
resource "aws_lb_target_group" "tg" {
	name_prefix = "lb-tg-"
	port = 9090
	protocol = "HTTP"
	vpc_id = "${data.aws_vpc.main.id}"
	target_type = "ip"
	health_check {
		interval = 30
		path = "/"
		port = "9090"
		protocol = "HTTP"
		timeout = 5
		unhealthy_threshold = 2
		healthy_threshold = 2
		matcher = "200,302"
	}
	lifecycle {
		create_before_destroy = true
	}
}
resource "aws_lb_listener" "listener-without-ssl" {
	load_balancer_arn = "${aws_lb.lb.arn}"
	port = "80"
	protocol = "HTTPS"
	ssl_policy = "ELBSecurityPolicy-2016-08"
	certificate_arn = "${aws_acm_certificate.cert.arn}"
	
	default_action {
		target_group_arn = "${aws_lb_target_group.tg.arn}"
		type = "forward"
	}
	# destroy before create aws_lb_target_group
}
resource "aws_lb_listener" "listener-with-ssl" {
	load_balancer_arn = "${aws_lb.lb.arn}"
	port = "443"
	protocol = "HTTPS"
	ssl_policy = "ELBSecurityPolicy-2016-08"
	certificate_arn = "${aws_acm_certificate.cert.arn}"
	
	default_action {
		target_group_arn = "${aws_lb_target_group.tg.arn}"
		type = "forward"
	}
	# destroy before create aws_lb_target_group
}

resource "aws_lb_target_group_attachment" "server" {
	target_group_arn = "${aws_lb_target_group.tg.arn}"
	target_id = "${data.aws_instance.server.private_ip}"
}
