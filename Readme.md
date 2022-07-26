# TERRAFORM


### Config .env file:

```bash
cat .env || echo AWS_ACCESS_KEY_ID=""\nAWS_SECRET_ACCESS_KEY="" > .env
```

### Create terraform.tfvars file:

```bash
cat ./terraform/dev.tfvars || echo "# Declare variables
instance_type = \"t2.micro\"
image_id = \"ami-0b9c9d9c6b80f9f9e\"
tags = {
  Name = \"terraform-test\"
}" > ./terraform/dev.tfvars
```

### Commands Terraform:

```bash
terraform init # Initialize the Terraform configuration.
terraform plan # Generate a plan for the resources that Terraform would create.
terraform plan -var-file=variables.tfvars # Generate a plan for the resources that Terraform would create.
terraform apply # Apply the plan to the infrastructure.
terraform destroy # Destroy the infrastructure.
terraform output # Display the output values of the plan.
terraform validate # Validate the configuration.
```

# ANSIBLE

## Create Hosts.csv

#### Note: you must replace the variables with the values ​​of your servers

```bash
ls ansible/hosts.csv || echo "Server Name,Server Host,Server User,Git Name,Git Email" > ansible/hosts.csv
# SERVER_HOST= IP public,IP private, domain or sub-domain
# SERVER_USER= user for login in server
# SERVER_NAME= identifier by server i playbooks
SERVER_NAME=$(hostname -s)
SERVER_HOST=$(hostname -I | awk '{print $1}')
SERVER_USER=$USER
GIT_NAME=YOUR_NAME
GIT_EMAIL=YOUR_EMAIL
echo "$SERVER_NAME,$SERVER_HOST,$SERVER_USER,$GIT_NAME,$GIT_EMAIL" >> ansible/hosts.csv
#Handy dandy extension will try open file in vs code
code ansible/hosts.csv

```

## Build image

```bash
docker-compose build
```

## Copy identity file 

```bash
# Note: don't execute this script with handy cany extension, it will be executed with terminal
#docker-compose run --rm ansible ssh-copy-id  $SERVER_USER@$SERVER_HOST
```

## Commands available without server password

```bash
# list all hosts
docker-compose run --rm ansible ansible all --list-hosts
#Ping all hosts
docker-compose run --rm ansible  ansible all -m ping
```

## Commands available with server password

```bash
# Note: don't execute this script with handy cany extension, it will be executed with terminal
# devopsPlaybook
# ansible-playbook playbooks/devopsPlaybook.yml --ask-become-pass --tags
# devtools
# ansible-playbook playbooks/devtools.yml --ask-become-pass --tags
# htopPlaybook
# ansible-playbook playbooks/htopPlaybook.yml --ask-become-pass --tags
# interpreters
# ansible-playbook playbooks/interpreters.yml --ask-become-pass --tags
# k8_master_node
# ansible-playbook playbooks/k8-master-node.yml --ask-become-pass --tags
# k8_nodes
# ansible-playbook playbooks/k8-nodes.yml --ask-become-pass --tags
# k8_workers_node
# ansible-playbook playbooks/k8-workers-node.yml --ask-become-pass --tags
# nginx
# ansible-playbook playbooks/nginx.yml --ask-become-pass --tags
```
