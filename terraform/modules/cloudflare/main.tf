terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
data "cloudflare_zone" "example" {
  name = "chaoticteam.com"
}
# Create default A record for wwww and @
resource "cloudflare_record" "www" {
	zone_id = data.cloudflare_zone.example.id
	name    = "www"
	value   = var.load_balancer_url
	type    = "A"
	ttl     = 1
	proxied = true
}
resource "cloudflare_record" "root" {
	zone_id = data.cloudflare_zone.example.id
	name    = "@"
	value   = var.load_balancer_url
	type    = "A"
	ttl     = 1
	proxied = true
}
