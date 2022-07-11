# ANSIBLE
## Create env file

#### Note: you must replace the variables with the values ​​of your servers

```bash
# SERVER_HOST= IP public,IP private, domain or sub-domain
# SERVER_USER= user for login in server
# SERVER_NAME= identifier by server i playbooks
cat .env || echo "SERVER_HOST=$(hostname -I | awk '{print $1}')
SERVER_USER=$USER
SERVER_NAME=$(hostname -s)
GIT_NAME=YOUR_NAME
GIT_EMAIL=YOUR_EMAIL" > .env
```

## Build image

```bash
docker-compose build
```

## Copy identity file 

```bash
# Note: don't execute this script with handy cany extension, it will be executed with terminal
docker-compose run --rm ansible

```

## Ping all host
#### Note: if ping is UNREACHABLE! or Failed to connect to...
#### copy content by ./ansible/ssh-keys/ansible.pub in file ~/.ssh/authorized_keys in your server.

```bash
docker-compose run  --rm --entrypoint ansible ansible all --key-file ssh-keys/ansible -m ping 
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
