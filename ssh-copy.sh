#!/usr/bin/env bash

#
# AUTHOR : Mayur Chavhan
#
#This script will install and remove ssh-key from remote server.
echo ""
echo "      ============================================== "
echo "      ||                                          || "
echo "      ||    █▀▄▀█ █▀█ █▀▀ █░█ █▀█ █▀ ▀▀█          || "
echo "      ||    █░▀░█ █▀▄ █▄█ █▀█ █▄█ ▄█ ░░█          || "
echo "      ||                                          || "
echo "      ||   https://github.com/mayur-chavhan       || "
echo "      ============================================== "
echo ""

user=vagrant
pass="vagrant"

#pub_key="$(cat ~/.ssh/id_rsa.pub)"

function _addkey() {

    while read SERVER
    do
    
    # Check if you have installed sshpass on your machine.
    echo "$pass" | sshpass ssh-copy-id $user@"${SERVER}" -f -o StrictHostKeyChecking=no

    done <<\EOF

    172.16.16.100  # Change these Server IPS to remote servers you want to connect
    172.16.16.101
    172.16.16.102
EOF
} >> output

function _delkey() {

    while read SERVER
    do
         ssh -tt $user@"${SERVER}" 'stty raw -echo; sudo echo "" > ~/.ssh/authorized_keys'

         ssh-keygen -R "${SERVER}"

         
    done <<\EOF
    172.16.16.100
    172.16.16.101
    172.16.16.102
EOF
} >> output



if [ $1 == "addkey" ]; then

    _addkey

elif [ $1 == "rmkey" ]; then

    _delkey

else
    echo -e "\n ===>| Oopps!! Invalid command argument |<=== \n\n try - \n\n addkey => add key to remote host \n\n rmkey => Remove key from remote host \n "

fi

