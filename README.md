# TERRAFORM

terraform init

```bash
docker-compose run --rm  --entrypoint terraform terraform init #-migrate-state
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
# apply
docker-compose run --rm  --entrypoint terraform terraform apply -auto-approve
```

```bash
#Output
docker-compose run --rm --entrypoint terraform terraform output
```

```bash
# Destroy the infrastructure.
#docker-compose run --rm  --entrypoint terraform terraform apply -destroy -auto-approve
```
