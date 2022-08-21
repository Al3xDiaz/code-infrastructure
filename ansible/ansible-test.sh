#! /bin/bash
#without pass
ansible-playbook playbooks/withoutPass/configSystem.yml --syntax-check
ansible-playbook playbooks/withoutPass/testInclude.yml --syntax-check

#become pass
ansible-playbook playbooks/becomePass/devtools.yml --syntax-check
ansible-playbook playbooks/becomePass/htopPlaybook.yml --syntax-check
ansible-playbook playbooks/becomePass/interface.yml --syntax-check
ansible-playbook playbooks/becomePass/interpreters.yml --syntax-check

##kubernetes 
ansible-playbook playbooks/becomePass/k8-master-node.yml --syntax-check
ansible-playbook playbooks/becomePass/k8-workers-node.yml --syntax-check
ansible-playbook playbooks/becomePass/k8-nodes.yml --syntax-check

## devops
ansible-playbook playbooks/becomePass/nginx.yml --syntax-check
ansible-playbook playbooks/becomePass/docker.yml --syntax-check