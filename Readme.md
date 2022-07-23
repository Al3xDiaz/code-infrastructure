# ANSIBLE
## Create env file

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
docker-compose run --rm ansible ssh-copy-id  $SERVER_USER@$SERVER_HOST

```

## Ping all host
#### Note: if ping is UNREACHABLE! or Failed to connect to...
#### copy content by ./ansible/.ssh/ansible.pub in file ~/.ssh/authorized_keys in your server.

```bash
docker-compose up --build --remove-orphans
```

## Commands available
### list all hosts

```bash
docker-compose run --rm ansible ansible all --list-hosts
```

## In Container

```bash
# %%
#docker-compose run --rm ansible bash
# alias available:
sh ansible/alias.sh

## Ansible Flags
# -ask-become-pass #require server password
# --tags #exec one task by tag
# -i $inventoryfilepath #specify the path of the inventoriFle
```
