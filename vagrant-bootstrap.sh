#!/bin/bash

echo 'Github: https://github.com/mayur-chavhan'
echo 'Facebook: https://www.facebook.com/techwhale.in'
echo ''


# Enable ssh password authentication
echo "[TASK 2] Enable ssh password authentication"
sudo sed -i 's/.*PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Enable root ssh login
echo "[TASK 3] Enable ssh root login"
sudo sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

sudo systemctl reload sshd

# Set Root password
echo "[TASK 4] Set root password"
echo "vagrant" | passwd --stdin root >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

echo "[TASK 5] OS and CodeName"

OS=$(( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1)

echo  Distro = [ "$OS" ]
