#! /bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

sudo apt update; sudo apt install --yes curl wget apt-transport-https dirmngr

sudo cp -fi /etc/apt/sources.list /etc/apt/sources.list.backup

sudo cat > /etc/apt/sources.list <<EOF
deb http://debian.a1.bg/debian/ trixie main contrib non-free non-free-firmware
deb http://debian.a1.bg/debian/ trixie-updates main contrib non-free non-free-firmware
deb http://debian.a1.bg/debian-security trixie-security main contrib non-free non-free-firmware
deb http://debian.a1.bg/debian trixie-backports main contrib non-free non-free-firmware
EOF

sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
 
exit 0
