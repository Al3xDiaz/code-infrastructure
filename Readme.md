# TERRAFORM

### Config .env file:

```bash
sed -i 's/^\(AWS_ACCESS_KEY_ID\)=\(.*\)/\1="\\nAWS_SECRET_ACCESS_KEY"#\2/g' .env || echo AWS_ACCESS_KEY_ID="\"\\nAWS_SECRET_ACCESS_KEY\"" > .env
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
docker-compose run --rm terraform init # Initialize the Terraform configuration.
# docker-compose run --rm terraform plan # Generate a plan for the resources that Terraform would create.
# docker-compose run --rm terraform plan -var-file=dev.tfvars # Generate a plan for the resources that Terraform would create.
# docker-compose run --rm terraform apply # Apply the plan to the infrastructure.
# docker-compose run --rm terraform destroy # Destroy the infrastructure.
# docker-compose run --rm terraform output # Display the output values of the plan.
# docker-compose run --rm terraform validate # Validate the configuration.
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
#Config System
docker-compose run --rm ansible  ansible-playbook  playbooks/withoutPass/configSystem.yml --check
```

## Commands available with server password

```bash
# Note: don't execute this script with handy cany extension, it will be executed with terminal. because it will need to enter the password
#use --tags=<tag> to run specific playbook
#interface 
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/interface.yml --ask-become-pass


# devopsPlaybook
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/devopsPlaybook.yml --ask-become-pass --tags
# devtools
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/devtools.yml --ask-become-pass --tags
# htopPlaybook
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/htopPlaybook.yml --ask-become-pass --tags
# interpreters
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/interpreters.yml --ask-become-pass --tags
# k8_master_node
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/k8-master-node.yml --ask-become-pass --tags
# k8_nodes
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/k8-nodes.yml --ask-become-pass --tags
# k8_workers_node
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/k8-workers-node.yml --ask-become-pass --tags
# nginx
# docker-compose run --rm ansible ansible-playbook playbooks/becomePass/nginx.yml --ask-become-pass --tags
```
