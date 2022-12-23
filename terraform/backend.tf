terraform {
  backend "http" {
  }
}

data "terraform_remote_state" "example" {
  backend = "http"

  config = {
    address = var.example_remote_state_address
    username = var.example_username
    password = var.example_access_token
  }
}