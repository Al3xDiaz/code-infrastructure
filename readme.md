# ANSIBLE
## Create inventory file
```sh
# SERVER_HOST= IP public,IP private, domain or sub-domain
# SERVER_USER= user for login in server
# SERVER_NAME= identifier by server in playbooks
rm -rf ansible/inventory || touch ansible/inventory
SERVER_HOST="192.168.0.200" && \
SERVER_USER="ansible" && \
SERVER_NAME="mi_pc" && \
echo "[$SERVER_NAME] 
$SERVER_HOST  ansible_user=$SERVER_USER" >> ansible/inventory
```
## up
```docker
#add ssh key
export YOUR_IP=192.168.0.12
export YOUR_USER=al3xdiaz
docker-compose run --rm ansible ssh-copy-id -i ssh-keys/ansible $YOUR_USER@$YOUR_IP
docker-compose up --build
```
## if ping is UNREACHABLE! or Failed to connect to...
copy content by ./ansible/ssh-keys/ansible.pub in file ~/.ssh/authorized_keys in your server.
## commands in container
```sh

# execute playbook
#note: 
# #add --ask-become-pass for use password
# #add --tags for exec one task
# #add -i $inventoryfilepath for 
# ping host:
ansible all --key-file ssh-keys/ansible -m ping

ansible-playbook playbooks/htopPlaybook.yml 
ansible-playbook playbooks/devopsPlaybook.yml 
ansible-playbook playbooks/devopsPlaybook.yml --tags "Install git"
ansible-playbook playbooks/interpreters.yml --tags "nodejs"
ansible-playbook playbooks/interpreters.yml --tags "python"

ansible-playbook playbooks/k8-master.yml --ask-become-pass

# get list host enabled
ansible all --list-hosts

```# Ansible
