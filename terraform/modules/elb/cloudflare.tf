terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
data "cloudflare_zone" "example" {
  name = "chaoticteam.com"
}
# Create CNAME for create certificate
resource "cloudflare_record" "cert" {
	zone_id = data.cloudflare_zone.example.id
	name    = replace(tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name,"/\\..*/", "")
	value   = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value
	type    = "CNAME"
	ttl     = 1
	proxied = false
}

# Create default A record default
resource "cloudflare_record" "default" {
	zone_id = data.cloudflare_zone.example.id
	name    = "*"
	value   = aws_lb.lb.dns_name
	type    = "CNAME"
	ttl     = 1
	proxied = true
}
# Create A record mx
resource "cloudflare_record" "root" {
	zone_id = data.cloudflare_zone.example.id
	name    = "@"
	value   = aws_lb.lb.dns_name
	type    = "CNAME"
	ttl     = 1
	proxied = true
}
# Create A record for mail,mx, spf, dmarc, smtp, pop, imap
resource "cloudflare_record" "mail" {
	zone_id = data.cloudflare_zone.example.id
	name    = "mail"
	value   = data.aws_instance.server.public_ip
	type    = "A"
	ttl     = 1
	proxied = false
}
resource "cloudflare_record" "mx" {
	zone_id = data.cloudflare_zone.example.id
	name    = "@"
	value   = "mail.chaoticteam.com"
	type    = "MX"
	ttl     = 14400
	proxied = false
	priority = 10
}
resource "cloudflare_record" "spf" {
	zone_id = data.cloudflare_zone.example.id
	name    = "@"
	value   = "v=spf1 mx ~all"
	type    = "TXT"
	ttl     = 14400
	proxied = false
}
resource "cloudflare_record" "dmarc" {
	zone_id = data.cloudflare_zone.example.id
	name    = "_dmarc"
	value   = "v=DMARC1; p=none; rua=mailto:dmarc-reports@chaoticteam.com"
	type    = "TXT"
	ttl     = 14400
	proxied = false
}
resource "cloudflare_record" "smtp" {
	zone_id = data.cloudflare_zone.example.id
	name    = "smtp"
	value   = "mail.chaoticteam.com"
	type    = "CNAME"
	ttl     = 1
	proxied = false
}
resource "cloudflare_record" "pop" {
	zone_id = data.cloudflare_zone.example.id
	name    = "pop"
	value   = "mail.chaoticteam.com"
	type    = "CNAME"
	ttl     = 1
	proxied = false
}
resource "cloudflare_record" "imap" {
	zone_id = data.cloudflare_zone.example.id
	name    = "imap"
	value   = "mail.chaoticteam.com"
	type    = "CNAME"
	ttl     = 1
	proxied = false
}
