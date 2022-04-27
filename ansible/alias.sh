alias ping="ansible all --key-file ssh-keys/ansible -m ping"
alias playbook="ansible-playbook --key-file ssh-keys/ansible"
alias hosts="ansible all --list-hosts"
alias fonts="playbook playbooks/devtools.yml --tags fonts --ask-become-pass"