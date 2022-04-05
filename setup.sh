cat /home/ansible/ssh-keys/ansible.pub || ssh-keygen -b 3072 -t rsa -f /home/ansible/ssh-keys/ansible -q -N '' -C ansible
exec $@