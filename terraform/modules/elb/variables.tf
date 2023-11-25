variable cloudflare_api_token {
	default = ""
	description = "The Cloudflare API token to use for authentication"
}
variable	public_ip {
	default = ""
	description = "The IPv4 address of the instance to update"
}
variable target_groups {
	description = "The target groups to update"
	type = list(object({
		port = number
		path = string
		hosts = list(string)
		name = string
	}))
}