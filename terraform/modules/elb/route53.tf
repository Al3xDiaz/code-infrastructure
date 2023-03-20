resource "aws_route53_zone" "primary" {
	name = "chaoticteam.com"
}
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "chaoticteam.com"
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "all" {
	zone_id = aws_route53_zone.primary.zone_id
	name    = "*.chaoticteam.com"
	type    = "A"

	alias {
		name                   = aws_lb.lb.dns_name
		zone_id                = aws_lb.lb.zone_id
		evaluate_target_health = true
	}
}

resource "aws_ses_domain_identity" "domain" {
	domain = "chaoticteam.com"
}
resource "aws_ses_domain_dkim" "domain" {
	domain = aws_ses_domain_identity.domain.id
}

resource "aws_route53_record" "ses" {
	count  = 3
	zone_id = aws_route53_zone.primary.zone_id
	name    = "${element(aws_ses_domain_dkim.domain.dkim_tokens, count.index)}._domainkey"
	type    = "CNAME"
	ttl     = "600"
	records = ["${element(aws_ses_domain_dkim.domain.dkim_tokens, count.index)}.dkim.amazonses.com"]

}
