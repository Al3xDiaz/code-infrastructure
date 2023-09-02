# listener 25, 110, 143, 465, 587, 993, 995, 4190 for mail configuration
variable listeners {
	type = list(string)
	default = ["25", "110", "143", "465", "587", "993", "995", "4190"]
}
resource "aws_lb_target_group" "tg-mail" {
	count = "${length(var.listeners)}"
	name_prefix = "lb-tg-"
	port = var.listeners[count.index]
	protocol = "HTTP"
	vpc_id = "${data.aws_vpc.main.id}"
	target_type = "ip"
	health_check {
		interval = 30
		path = "/"
		port = "${var.listeners[count.index]}"
		protocol = "HTTP"
		timeout = 5
		unhealthy_threshold = 2
		healthy_threshold = 2
		matcher = "200,302"
	}
}
resource "aws_lb_listener" "listener" {
	count = "${length(var.listeners)}"
	load_balancer_arn = "${aws_lb.lb.arn}"
	port = "${var.listeners[count.index]}"
	protocol = "HTTP"
	default_action {
		target_group_arn = "${aws_lb_target_group.tg-mail[count.index].arn}"
		type = "forward"
	}
}
resource "aws_lb_target_group_attachment" "tg_attachment" {
	count = "${length(var.listeners)}"
	target_group_arn = "${aws_lb_target_group.tg-mail[count.index].arn}"
	target_id = "${data.aws_instance.server.private_ip}"
}
