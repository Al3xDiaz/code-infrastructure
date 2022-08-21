# CODE INFRASTRUCTURE

## Overview
This is a collection of scripts and tools to help with the development of the deployment of the code infrastructure.if you want to configure your machine with ansible, [Click here](#ansible).

note: It is recommended to install "Handy Dandy Notebook" extension for VS Code for run this document commands.
### Usage
To use the scripts, you need to have the following installed:
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Initialize project
#### Config .env file:

```bash
COMMAND="
cat .env && read -p \"the file .env exists, do you want to overwrite it? [y/N]\" overwrite && overwrite=\${overwrite:-n} && [[ \$overwrite = n ]] && exit 0

regex=\"^([^=]+)=\\\"?(.*)\\\"?\$\"
while read -r line; do
    if [[ \$line =~ \$regex ]]; then
        key=\${BASH_REMATCH[1]}
        value=\${BASH_REMATCH[2]}

        read -p \"Enter your \$key: \" new_value </dev/tty
        new_value=\${new_value:-\$value}

        echo \"\$key=\\\"\$new_value\\\"\" >> /tmp/.env
    fi
done < .env
cat /tmp/.env > .env && rm /tmp/.env && exit 0

read -p \"Enter your AWS_ACCESS_KEY_ID: \" AWS_ACCESS_KEY_ID
read -p \"Enter your AWS_SECRET_ACCESS_KEY: \" AWS_SECRET_ACCESS_KEY
echo -e \"AWS_ACCESS_KEY_ID=\\\"\$AWS_ACCESS_KEY_ID\\\"\nAWS_SECRET_ACCESS_KEY=\\\"\$AWS_SECRET_ACCESS_KEY\\\"\" > .env
"
x-terminal-emulator -e "bash -c '$COMMAND'"
```

### before you start, you need to executes the following commands:

```bash
docker-compose up --build --remove-orphans
```

### PACKER

#### validate

```bash
docker-compose run --rm  packer packer validate aws-ami.json
```

#### Build

```bash
docker-compose run --rm  packer packer build aws-ami.json
```

### TERRAFORM

##### Create terraform.tfvars file:

```bash
cat ./terraform/prod.tfvars || echo "# Declare variables
instance_type = \"t2.micro\"
image_id = \"ami-0b9c9d9c6b80f9f9e\"
tags = {
  Name = \"terraform-test\"
}" > ./terraform/prod.tfvars
```

##### Commands Terraform:
#### terraform-init ###

```bash
# Initialize the Terraform configuration.
docker-compose run --rm  --entrypoint terraform terraform init #-migrate-state
```

```bash
# Validate the configuration.
docker-compose run --rm  --entrypoint terraform terraform validate
```

```bash
# Generate a plan for the resources that Terraform would create.
docker-compose run --rm  --entrypoint terraform terraform plan
```

```bash
# Apply the plan to the infrastructure.
docker-compose run --rm  --entrypoint terraform terraform apply --auto-aprove
```

```bash
# Destroy the infrastructure.
docker-compose run --rm  --entrypoint terraform terraform apply -destroy --auto-aprove
```

### ANSIBLE

#### Create Hosts.csv
###### Note: you must replace the variables with the values ​​of your servers

```bash
ls ansible/hosts.csv || echo "Server Name,Server Host,Server User,Git Name,Git Email" > ansible/hosts.csv

COMMAND="
while [[ "\$EXIT_TERMINAL" != \"n\" ]]; do
    # Ask for the server name
    read -p \"what is the name of the server?[default: \"\$(hostname -s)\"] \" SERVER_NAME
    SERVER_NAME=\${SERVER_NAME:-\$(hostname -s)}

    # Ask for the server host
    read -p \"what is the host of the server?[default: \"\$(hostname -I | awk '{print \$1}')\"] \" SERVER_HOST
    SERVER_HOST=\${SERVER_HOST:-\$(hostname -I | awk '{print \$1}')}

    # Ask for the server user
    read -p \"what is the user of the server?[default: \"\$USER\"] \" SERVER_USER
    SERVER_USER=\${SERVER_USER:-\$USER}

    # Ask for the git name
    read -p \"what is the name of the git?[default: \"\$USER\"] \" GIT_NAME
    GIT_NAME=\${GIT_NAME:-\$USER}

    # Ask for the git email
    read -p \"what is the email of the git?[default: \"\$USER\"] \" GIT_EMAIL
    GIT_EMAIL=\${GIT_EMAIL:-\$USER}

    echo \"\$SERVER_NAME,\$SERVER_HOST,\$SERVER_USER,\$GIT_NAME,\$GIT_EMAIL\" >> ./ansible/hosts.csv

    read -p \"Do you want to add another server? (y/N)\" EXIT_TERMINAL
    EXIT_TERMINAL=\${EXIT_TERMINAL:-n}
done
"
x-terminal-emulator -e bash -c "$COMMAND"
```

#### Copy identity file

```bash
#!/bin/bash
# Matchs [ (hostname ) ( user ) ( git name ) ( git email ) ]
regex="^([^, ]+),([^, ]+),([^, ]+),([^, ]+),([^, ]+)$"
# read ansible/hosts.csv
while read -r line; do 
    if [[ $line =~ $regex ]] 
    then
        SERVER_HOST=${BASH_REMATCH[2]}
        SERVER_USER=${BASH_REMATCH[3]}
        x-terminal-emulator -e bash -c "docker-compose run --rm ansible ssh-copy-id -i /root/.ssh/ansible $SERVER_USER@$SERVER_HOST;"
    fi
done < ansible/hosts.csv
```

#### Commands available without server password

```bash
COMMAND="
echo \"
Menu Options:
1. list all hosts
2. Ping all hosts
3. Config System
4. List all tags
\"
read -p \"What would you like to do?\" MENU_OPTION

case \$MENU_OPTION in
    1)
        docker-compose run --rm ansible ansible all --list-hosts
        ;;
    2)
        docker-compose run --rm ansible ansible all --ping
        ;;
    3)
        docker-compose run --rm ansible ansible-playbook playbook/withoutPass/configSystem.yml
        ;;
    4)
        docker-compose run --rm ansible ansible-playbook playbook/withoutPass/configSystem.yml --list-tags
        ;;
    *)
        exit;
        ;;
esac
read -p \"exit?\"
"
x-terminal-emulator -e bash -c "$COMMAND"
```

#### Commands available with server password

```bash
COMMAND="
echo \"Menu:
Available options:
1. Config Interface
2. Dev Tools
3. Interpreters

##################KUBERNETES##################
4. K8s Node
5. K8s Master node
6. K8s Worker node

##################DEV OPS##################
7. nginx
8. docker
\"
read -p \"Select an option: \" OPTION
case $OPTION in
    \"1\")
        echo \"Config Interface\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/interface.yml --ask-become-pass
        ;;
    \"2\")
        echo \"Dev Tools\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/devTools.yml --ask-become-pass
        ;;
    \"3\")
        echo \"Interpreters\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/interpreters.yml --ask-become-pass
        ;;
    \"4\")
        echo \"K8s Node\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/k8-nodes.yml --ask-become-pass
        ;;
    \"5\")
        echo \"K8s Master node\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/k8-master-node.yml --ask-become-pass
        ;;
    \"6\")
        echo \"K8s Worker node\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/k8-workers-node.yml --ask-become-pass
        ;;
    \"7\")
        echo \"nginx\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/nginx.yml --ask-become-pass
        ;;
    \"8\")
        echo \"docker\"
        docker-compose run --rm ansible  ansible-playbook  playbooks/becomePass/docker.yml --ask-become-pass
        ;;    
"


x-terminal-emulator -e bash -c "$COMMAND"
```

## Test

```bash
docker-compose up --build
```
