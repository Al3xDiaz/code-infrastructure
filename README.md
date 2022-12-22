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

# TERRAFORM

terraform init
```

docker-compose run --rm  --entrypoint terraform terraform init #-migrate-state

```

```

#validate
docker-compose run --rm  --entrypoint terraform terraform validate

```

```

#plan
docker-compose run --rm  --entrypoint terraform terraform plan

```

```

# apply
docker-compose run --rm  --entrypoint terraform terraform apply -auto-approve

```

```

#Output
docker-compose run --rm --entrypoint terraform terraform output

```

```

# Destroy the infrastructure.
#docker-compose run --rm  --entrypoint terraform terraform apply -destroy -auto-approve

```

```
