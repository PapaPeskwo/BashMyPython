#!/usr/bin/env bash

if [ "$#" -lt 4 ]; then
  echo "Usage: sshsetup <key_path> <host_alias> <user> <hostname> [-c] [-p <port>]"
  echo "<key_path> has the ~/.ssh prefix"
  exit 1
fi

KEY_PATH="$1"
HOST_ALIAS="$2"
USER="$3"
HOSTNAME="$4"
CONNECT_AFTER=false
PORT=22
EMAIL="tomi.orlovac@gmail.com"

# Parse optional arguments
shift 4
while (( "$#" )); do
  case "$1" in
    -c)
      CONNECT_AFTER=true
      shift
      ;;
    -p)
      if [ -n "$2" ] && [ "$2" -eq "$2" ] 2>/dev/null; then
        PORT=$2
        shift 2
      else
        echo "Error: Argument for $1 is not a valid number" >&2
        exit 1
      fi
      ;;
    *)
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

ssh-keygen -t rsa -b 4096 -f ~/.ssh$KEY_PATH -N "" -C "$EMAIL"
cat ~/.ssh$KEY_PATH.pub | ssh -p $PORT $USER@$HOSTNAME 'umask 0077; mkdir -p .ssh; cat >> .ssh/authorized_keys && echo "Key copied"'
echo -e "\nHost $HOST_ALIAS\n\tHostName $HOSTNAME\n\tUser $USER\n\tIdentityFile ~/.ssh$KEY_PATH\n\tPort $PORT" >> ~/.ssh/config

if [ "$CONNECT_AFTER" == true ]; then
  ssh $HOST_ALIAS
fi
