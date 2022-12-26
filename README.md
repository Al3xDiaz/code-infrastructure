# Infrastructure Provider

## Setup
create .env

```bash
echo -e "AWS_ACCESS_KEY_Id=
aws_secret_access_key=" > .env
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
aws eks --region us-east-2 update-kubeconfig --name $(docker-compose run --rm  --entrypoint terraform terraform output -raw cluster_name)

```
