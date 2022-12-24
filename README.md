# Infrastructure Provider

## Setup
create .env

```bash
echo -e "AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=" > .env
```

create backend remote

```bash
KMS_KEY_ID=`cat ./terraform/modules/s3/kms_key_output.txt`
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

```bash
docker-compose run --rm  --entrypoint terraform terraform init -upgrade
```

```bash
#validate
docker-compose run --rm  --entrypoint terraform terraform validate

```

```bash
#plan
docker-compose run --rm  --entrypoint terraform terraform plan
```

```bash
#apply
docker-compose run --rm  --entrypoint terraform terraform apply --auto-approve
```

```bash
#Output
docker-compose run --rm --entrypoint terraform terraform output
```

```bash
# Destroy the infrastructure.
docker-compose run --rm  --entrypoint terraform terraform apply -destroy -auto-approve
```

```bash
#configure kubectl
aws eks --region $(docker-compose run --rm  --entrypoint terraform terraform output -raw region) update-kubeconfig --name $(docker-compose run --rm  --entrypoint terraform terraform output -raw cluster_name)

```
