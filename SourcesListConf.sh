#! /bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

sudo apt update; sudo apt install --yes curl wget apt-transport-https dirmngr

sudo cp -fi /etc/apt/sources.list /etc/apt/sources.list.backup

sudo cat > /etc/apt/sources.list <<EOF
deb https://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb https://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb https://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb https://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware
EOF

sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
 
exit 0
