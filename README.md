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

## configure aws 
## iam user
* create user with programmatic access
* create group with policy "AmazonEC2FullAccess" (or more restrictive)
* add user to group

## aws cost explorer
### create budget
#### create cost alarm
* aws > cost explorer > budget > create budget
* name: "terraform"
* budget type:  cost
* budgeted amount: $1

## Ansible
### commands

```bash
docker-compose run --rm ansible ansible-playbook main.yml --check
```
