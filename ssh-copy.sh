#!/usr/bin/env bash

user=vagrant
pass="vagrant"

pub_key="$(cat ~/.ssh/id_rsa.pub)"

function _addkey() {

    while read SERVER
    do
    echo "$pass" | ssh-copy-id $user@"${SERVER}" -f -o StrictHostKeyChecking=no

    done <<\EOF
    172.16.16.100
    172.16.16.101
    172.16.16.102
EOF
} >> output

function _delkey() {

    while read SERVER
    do
         #ssh -tt $user@"${SERVER}" 'stty raw -echo; sudo rm /home/vagrant/.ssh/id_rsa.pub'

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

#_delkey
