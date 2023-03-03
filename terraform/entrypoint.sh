#! /bin/sh
export ID_PUBLIC_KEY=`ls -la ~/.ssh/ | grep -o -m 1 '[[:alnum:]_]\+\.pub'`
export ID_PRIVATE_KEY=`echo $ID_PUBLIC_KEY | sed 's/.pub//'`
export TF_VAR_id_public_key_path=~/.ssh/$ID_PUBLIC_KEY
export TF_VAR_id_private_key_path=.ssh/$ID_PRIVATE_KEY
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
