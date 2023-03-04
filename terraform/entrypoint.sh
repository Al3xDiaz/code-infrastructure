#! /bin/sh

[[ -f ~/.ssh/id_$USER ]] || ssh-keygen -t rsa -b 4096 -C "$USER@$(hostname)" -f ~/.ssh/id_$USER -N ""
export TF_VAR_id_public_key_path=.ssh/id_$USER.pub
export TF_VAR_id_private_key_path=.ssh/id_$USER
case "$1" in 
  -e)
    /bin/sh -c "$2 $3 $4 $5 $6 $7 $8 $9"
    ;;
  -i)
    exec terraform init
    ;;
  *)
    exec terraform "$@"
    ;;
esac
