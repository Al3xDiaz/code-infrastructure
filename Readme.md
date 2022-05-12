# ANSIBLE
## Create env file

#### Note: you must replace the variables with the values ​​of your servers

```bash
# SERVER_HOST= IP public,IP private, domain or sub-domain
# SERVER_USER= user for login in server
# SERVER_NAME= identifier by server i playbooks
echo "SERVER_HOST=192.168.0.200
SERVER_USER=ansible
SERVER_NAME=mi_pc
GIT_NAME=YOUR_NAME
GIT_EMAIL=YOUR_EMAIL" > .env
```

## Copy identity file 

```bash
# Note: enter server's passphrase
docker-compose run --rm ansible ssh-copy-id -i ssh-keys/ansible \$SERVER_USER@\$SERVER_NAME
```

## Ping all host
#### Note: if ping is UNREACHABLE! or Failed to connect to...
#### copy content by ./ansible/ssh-keys/ansible.pub in file ~/.ssh/authorized_keys in your server.

```bash
docker-compose up
```

## Commands available
### list all hosts

```bash
docker-compose run --rm ansible ansible all --list-hosts
```

## IN Container

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
