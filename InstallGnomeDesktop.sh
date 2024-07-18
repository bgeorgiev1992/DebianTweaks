#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

## Install Minimal Gnome Desktop, Mesa 3D Graphics Library, Bluetooth support, Printer support, PC/SC driver for USB CCID smart card readers, Multimedia codecs, Flatpak support, LibreOffice, Roboto and Awesome fonts, RAR and ZIP support, Java, Ruby, ZSH shell.
sudo apt install --yes firmware-linux firmware-linux-free firmware-linux-nonfree firmware-amd-graphics firmware-realtek firmware-atheros firmware-ath9k-htc adwaita-icon-theme at-spi2-core baobab dconf-cli dconf-gsettings-backend eog evince evolution-data-server fonts-inter-variable gdm3 gkbd-capplet glib-networking gnome-backgrounds gnome-bluetooth-sendto gnome-calculator gnome-characters gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-online-accounts gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-software gnome-sushi gnome-system-monitor gnome-console gnome-text-editor gnome-themes-extra gnome-user-docs gnome-user-share gsettings-desktop-schemas gstreamer1.0-packagekit gstreamer1.0-plugins-base gstreamer1.0-plugins-good gvfs-backends gvfs-fuse libatk-adaptor libcanberra-pulse libglib2.0-bin libpam-gnome-keyring libproxy1-plugin-gsettings libproxy1-plugin-webkit librsvg2-common nautilus pipewire-audio sound-theme-freedesktop system-config-printer-common system-config-printer-udev totem tracker xdg-desktop-portal-gnome yelp zenity firefox-esr fonts-cantarell libproxy1-plugin-networkmanager low-memory-monitor cheese file-roller gnome-calendar gnome-clocks gnome-color-manager gnome-maps gnome-weather orca rygel-playbin rygel-tracker simple-scan avahi-daemon gnome-tweaks libgsf-bin libreoffice-gnome libreoffice-writer libreoffice-calc libreoffice-impress rhythmbox seahorse xdg-user-dirs-gtk cups-pk-helper gstreamer1.0-libav gstreamer1.0-plugins-ugly rhythmbox-plugins totem-plugins firefox-esr-l10n-all mesa-utils mesa-utils-extra vulkan-tools libvulkan1 libvulkan-dev mesa-vulkan-drivers vainfo libva-glx2 libva-dev libva-drm2 libva-x11-2 libva-wayland2 mesa-va-drivers vdpauinfo libvdpau1 libvdpau-dev mesa-vdpau-drivers ocl-icd-libopencl1 ocl-icd-opencl-dev mesa-opencl-icd clinfo libgl1-mesa-dri libglapi-mesa libgbm1 libwayland-egl1-mesa libd3dadapter9-mesa libosmesa6 mesa-drm-shim  ffmpeg gstreamer1.0-plugins-bad libavcodec-extra python3-opencv libopencv-dev gstreamer1.0-vaapi build-essential fonts-roboto fonts-font-awesome zip unzip unrar p7zip p7zip-full p7zip-rar libayatana-appindicator3-1 ufw gufw flatpak gnome-software-plugin-flatpak printer-driver-all hp-ppd foomatic-db-engine openprinting-ppds cups cups-browsed system-config-printer ipp-usb printer-driver-cups-pdf sane sane-utils pcscd libccid libpcsclite1 default-jdk meson sassc bluez-tools bluetooth ruby ruby-dev zsh gnome-software-plugin-fwupd gnome-boxes gnome-connections;

## Install latest firmware from git
git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
sudo cp -rfu linux-firmware/* /lib/firmware/
sudo update-initramfs -u -k all
rm -rf linux-firmware

## Install SublimeText.
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-pub.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/sublimehq-pub.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
sudo apt install --yes sublime-text;

## Install Google Chrome Web Browser.
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-linux_signing_key.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/google-linux_signing_key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
sudo apt install -y google-chrome-stable;

## Enable Flathub repo.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Enable Driverless Printing
cat >> /etc/cups/cups-browsed.conf <<EOF
CreateIPPPrinterQueues All
CreateRemoteCUPSPrinterQueues No
EOF

## Install Cascadia Code Fonts
wget https://github.com/microsoft/cascadia-code/releases/download/v2404.23/CascadiaCode-2404.23.zip
mkdir -p ~/CascadiaCode
unzip CascadiaCode-2404.23.zip -d ~/CascadiaCode
sudo mkdir -p /usr/share/fonts/CascadiaCode
sudo mv ~/CascadiaCode/ttf/static/* /usr/share/fonts/CascadiaCode
sudo fc-cache -v
sudo rm -rf ~/CascadiaCode CascadiaCode-2404.23.zip 

## View and manage network settings through Gnome Settings Panel.
sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf

exit 0
