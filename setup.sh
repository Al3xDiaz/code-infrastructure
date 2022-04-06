cat /home/ansible/ssh-keys/ansible.pub || ssh-keygen -b 3072 -t rsa -f /home/ansible/ssh-keys/ansible -q -N '' -C ansible
echo "usuario: $HOST_USER"
groupadd $HOST_USER && useradd -g $HOST_USER $HOST_USER && chown -R $HOST_USER:$HOST_USER /home/ansible/ssh-keys/ansible.pub && chown -R $HOST_USER:$HOST_USER /home/ansible/ssh-keys/ansible || echo "no se pudo crear tu usuario :c"
exec $@