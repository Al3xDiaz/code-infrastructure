terraform {
    backend "s3"{
        bucket = "terraform-state-123456789"
        key = "dev"
        region = "us-east-1"
        encrypt = true
        kms_key_id = "arn:aws:kms:us-east-1:651697194395:key/7001e577-664a-4768-9499-3356c8bbe37f"
    }
}
