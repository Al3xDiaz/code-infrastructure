alias ping="ansible all --key-file ssh-keys/ansible -m ping"
alias playbook="ansible-playbook --key-file ssh-keys/ansible"
alias hosts="ansible all --list-hosts"

alias devopsPlaybook="playbook devopsPlaybook.yml --ask-become-pass --tags"
alias devtools="playbook devtools.yml --ask-become-pass --tags"
alias htopPlaybook="playbook htopPlaybook.yml --ask-become-pass --tags"
alias interpreters="playbook interpreters.yml --ask-become-pass --tags"
alias k8_master_node="playbook k8-master-node.yml --ask-become-pass --tags"
alias k8_nodes="playbook k8-nodes.yml --ask-become-pass --tags"
alias k8_workers_node="playbook k8-workers-node.yml --ask-become-pass --tags"
alias nginx="playbook nginx.yml --ask-become-pass --tags"
alias