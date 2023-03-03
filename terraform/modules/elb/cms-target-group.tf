# resource "aws_lb_target_group" "cms" {
# 	name_prefix = "lb-tg-"
# 	port = 8080
# 	protocol = "HTTP"
# 	vpc_id = "${data.aws_vpc.main.id}"
# 	target_type = "instance"
# 	health_check {
# 		interval = 30
# 		path = "/"
# 		port = "8080"
# 		protocol = "HTTP"
# 		matcher = "200,302"
# 		timeout = 5
# 		unhealthy_threshold = 2
# 		healthy_threshold = 2
# 	}
# 	lifecycle {
# 		create_before_destroy = true
# 	}
# }
# resource "aws_lb_listener_rule" "rule" {
# 	listener_arn = "${aws_lb_listener.listener-without-ssl.arn}"
# 	action {
# 		type = "forward"
# 		target_group_arn = "${aws_lb_target_group.cms.arn}"
# 	}
# 	condition {
# 		host_header {
# 			values = ["cms.chaoticteam.com"]
# 		}
# 	}
# }
# resource "aws_lb_target_group_attachment" "cms" {
# 	target_group_arn = "${aws_lb_target_group.cms.arn}"
# 	target_id = "${data.aws_instance.server.id}"
# }