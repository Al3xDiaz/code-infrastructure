cat /home/ansible/.ssh/ansible.pub || ssh-keygen -b 3072 -t rsa -f /home/ansible/.ssh/ansible -q -N '' -C ansible
eval $(ssh-agent -s)
ssh-add /home/ansible/.ssh/ansible
#create inventory file
grep "^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)"  /home/ansible/hosts.csv | sed 's/^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)/[\1]\n\2 ansible_user=\3 git_name=\4 git_email=\5/g' > /home/ansible/inventory/inventory
grep "^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)"  /home/ansible/hosts.csv | sed 's/^\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\),\([^, ]\+\)/Host \1\n\tHostName \2\n\tUser \3/g' > /home/ansible/.ssh/config
echo "Host *\n
\tAddKeysToAgent yes\n
\tIdentityFile ~/.ssh/ansible" >> /home/ansible/.ssh/config
ln -s /home/ansible/.ssh/config /root/.ssh/config
exec $@