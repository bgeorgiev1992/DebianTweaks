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
deb https://deb.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb https://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware
EOF

sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y

## Add Google Chrome repo
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-linux_signing_key.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/google-linux_signing_key.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y

## Add Mozilla Firefox repo
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

## Disable auto installation of recommended and suggested packages
#sudo touch /etc/apt/apt.conf.d/99no-recommends
#sudo cat > /etc/apt/apt.conf.d/99no-recommends <<EOF
#APT::Install-Recommends "false";
#APT::Install-Suggests "false";

sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y

exit 0
