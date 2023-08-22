output "aws_lb" {
	value = "${aws_lb.lb}"
}
output "aws_acm_certificate_dns_validation" {
	value = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
}