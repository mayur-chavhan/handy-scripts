#!/bin/bash -uxe

echo ''
echo '███╗░░░███╗██████╗░░██████╗░██╗░░██╗░█████╗░░██████╗███████╗'
echo '████╗░████║██╔══██╗██╔════╝░██║░░██║██╔══██╗██╔════╝╚════██║'
echo '██╔████╔██║██████╔╝██║░░██╗░███████║██║░░██║╚█████╗░░░░░██╔╝'
echo '██║╚██╔╝██║██╔══██╗██║░░╚██╗██╔══██║██║░░██║░╚═══██╗░░░██╔╝░'
echo '██║░╚═╝░██║██║░░██║╚██████╔╝██║░░██║╚█████╔╝██████╔╝░░██╔╝░░'
echo '╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░░░╚═╝░░░'
echo ''
echo 'Github: https://github.com/mrGh0s7'
echo 'Facebook: https://www.facebook.com/techwhale.in'
echo ''

#
# One line execution : bash <(curl -fsSL https://github.com/mrGh0s7/handy-scripts/raw/master/prep_distro.sh)
#
install_pip () {
        curl https://bootstrap.pypa.io/get-pip.py | $SUDO $PYTHON_BIN
        $SUDO pip install setuptools -U
        $SUDO pip install netaddr -U
        $SUDO pip install dnspython -U
        $SUDO pip install passlib -U
        $SUDO pip install bcrypt -U
}

prepare_ubuntu() {
        $SUDO apt update -y
        $SUDO apt dist-upgrade -y
        $SUDO apt install software-properties-common curl git mc neofetch nano facter python python-apt aptitude -y
        [ $(uname -m) == "aarch64" ] && $SUDO apt install gcc python-dev libffi-dev htop libssl-dev make -y

        PYTHON_BIN=/usr/bin/python
        install_pip
        $SUDO pip install python-apt -U

        set +x
        echo
        echo "   Ubuntu Sytem ready for perfection."
        echo
}

prepare_debian() {
        $SUDO apt update -y
        $SUDO apt dist-upgrade -y
        $SUDO apt install dirmngr curl git mc nano facter python neofetch python-apt aptitude -y
        [ $(uname -m) == "aarch64" ] && $SUDO apt install gcc python-dev libffi-dev libssl-dev make -y

        PYTHON_BIN=/usr/bin/python
        install_pip
        $SUDO pip install python-apt -U

        set +x
        echo
        echo "   Debian Sytem ready for perfection."
        
}

prepare_raspbian() {
        $SUDO apt update -y
        $SUDO apt dist-upgrade -y
        $SUDO apt install dirmngr mc nano git libffi-dev curl neofetch facter -y
        PYTHON_BIN=/usr/bin/python
        install_pip

        set +x
        echo
        echo "   Rasbpian System ready for perfection."
        
}

prepare_centos() {
        $SUDO yum install epel-release -y
        $SUDO yum install git nano mc curl facter neofetch libselinux-python python -y
        $SUDO yum update -y

        PYTHON_BIN=/usr/bin/python
        install_pip

        set +x
        echo
        echo "   CentOS Sytem ready for perfection."
        
}

prepare_fedora() {
        $SUDO dnf install git nano mc curl facter neofetch libselinux-python python python3 python3-dnf -y
        $SUDO dnf update -y

        PYTHON_BIN=/usr/bin/python
        install_pip
        $SUDO dnf reinstall python3-pip -y

        set +x
        echo
        echo "   Fedora Sytem ready for perfection."
        
}

prepare_amzn() {
        $SUDO amazon-linux-extras install epel -y
        $SUDO yum install git nano mc curl facter libselinux-python python -y
        $SUDO yum update -y

        PYTHON_BIN=/usr/bin/python
        install_pip

        set +x
        echo
        echo "   Amazon Linux 2 ready for perfection."
        
}

usage() {
        echo
        echo "Linux distribution not detected."
        echo "Use: ID=[ubuntu|debian|centos|raspbian|amzn|fedora] prepare_system.sh"
        echo "Other distributions not yet supported."
        echo
}

if [  -f /etc/os-release ]; then
        . /etc/os-release
elif [ -f /etc/debian_version ]; then
        $ID=debian
fi

# root or not
if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

case $ID in
        'ubuntu')
                prepare_ubuntu
        ;;
        'debian')
                prepare_debian
        ;;
        'raspbian')
                prepare_raspbian
        ;;
        'centos')
                prepare_centos
        ;;
        'fedora')
                prepare_fedora
        ;;
        'amzn')
                prepare_amzn
        ;;

        *)
                usage
        ;;
esac

