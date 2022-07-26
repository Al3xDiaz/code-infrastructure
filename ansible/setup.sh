cat /root/.ssh/ansible.pub || ssh-keygen -b 3072 -t rsa -f /root/.ssh/ansible -q -N '' -C ansible
#create inventory file

grep "^\(\([^, ]\+\),\?\)\{5\}$"  /root/ansible/hosts.csv | sed 's/^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)/Host \1\n\tHostName \2\n\tUser \3/g' > /root/.ssh/config
echo "Host *
\tAddKeysToAgent yes
\tIdentityFile ~/.ssh/ansible\n" >> /root/.ssh/config

grep "^\(\([^, ]\+\),\?\)\{5\}$"  /root/ansible/hosts.csv | sed 's/^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)/[\1]\n\2 ansible_user=\3 git_name=\4 git_email=\5/g' > /root/ansible/inventory/inventory

exec $@