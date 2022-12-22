# Infrastructure Provider

## Setup
create .env

```bash
echo -e "AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=" > .env
```

create backend remote

```bash
KMS_KEY_ID=`cat kms_key_output.txt`
echo "terraform {
    backend \"s3\"{
        bucket = \"terraform-state-123456789\"
        key = \"dev\"
        region = \"us-east-1\"
        encrypt = true
        kms_key_id = \"$KMS_KEY_ID\"
    }
}" > terraform/backend.tf
```
