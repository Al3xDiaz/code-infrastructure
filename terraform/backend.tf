terraform {
	backend "s3"{
      bucket = "chaoticteam-buket"
      key = "states/chaoticteam.tfstate"
      region = "us-east-1"
    }
}
