alias ping="ansible all --key-file ssh-keys/ansible -m ping"
alias playbook="ansible-playbook --key-file ssh-keys/ansible"
alias hosts="ansible all --list-hosts"
alias devtools-tags="playbook playbooks/devtools.yml --ask-become-pass --tags"