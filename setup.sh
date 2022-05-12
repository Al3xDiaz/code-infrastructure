cat /home/ansible/ssh-keys/ansible.pub || ssh-keygen -b 3072 -t rsa -f /home/ansible/ssh-keys/ansible -q -N '' -C ansible
eval $(ssh-agent -s)
ssh-add /home/ansible/ssh-keys/ansible
#create inventory file
echo "[$SERVER_NAME]\n$SERVER_HOST  ansible_user=$SERVER_USER git_name=$GIT_NAME git_email=$GIT_EMAIL" > /home/ansible/inventory/inventory
exec $@