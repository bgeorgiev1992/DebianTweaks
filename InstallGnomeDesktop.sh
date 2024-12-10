#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

## Install Minimal Gnome Desktop, Mesa 3D Graphics Library, Bluetooth support, Printer support, PC/SC driver for USB CCID smart card readers, Multimedia codecs, Flatpak support, LibreOffice, Roboto and Awesome fonts, RAR and ZIP support, Ruby, ZSH shell.
apt install --yes -t bookworm-backports firmware-linux firmware-linux-free firmware-linux-nonfree firmware-amd-graphics firmware-realtek firmware-atheros firmware-ath9k-htc gdm3 gnome-backgrounds gnome-bluetooth-sendto gnome-control-center gnome-keyring gnome-menus gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-user-docs orca gnome-sushi tecla adwaita-icon-theme glib-networking gsettings-desktop-schemas baobab evince gnome-calculator gnome-calendar gnome-characters gnome-connections gnome-console gnome-disk-utility gnome-font-viewer gnome-logs gnome-software gnome-system-monitor gnome-text-editor gnome-weather loupe nautilus simple-scan gnome-snapshot totem yelp cups evolution-data-server fonts-cantarell gstreamer1.0-packagekit gstreamer1.0-plugins-base gstreamer1.0-plugins-good gvfs-backends gvfs-fuse libatk-adaptor libcanberra-pulse libglib2.0-bin libpam-gnome-keyring pipewire-audio system-config-printer-common system-config-printer-udev zenity network-manager avahi-daemon file-roller gnome-tweaks libgsf-bin libreoffice-calc libreoffice-impress libreoffice-gnome libreoffice-gtk3 libreoffice-writer rhythmbox seahorse xdg-user-dirs-gtk cups-pk-helper gstreamer1.0-libav gstreamer1.0-plugins-ugly rhythmbox-plugins rhythmbox-plugin-cdrecorder totem-plugins libreoffice-help-en-us mythes-en-us hunspell-en-us hyphen-en-us network-manager-gnome mythes-bg hunspell-bg hyphen-bg libreoffice-l10n-bg gnome-software-plugin-deb gnome-software-plugin-flatpak gnome-software-plugin-fwupd gnome-remote-desktop gnome-user-share rygel-playbin rygel-tracker low-memory-monitor gnome-shell-extension-prefs chrome-gnome-shell mesa-utils vulkan-tools libvulkan1 libvulkan-dev mesa-vulkan-drivers vainfo libva-glx2 libva-dev libva-drm2 libva-x11-2 libva-wayland2 mesa-va-drivers vdpauinfo libvdpau1 libvdpau-dev mesa-vdpau-drivers ocl-icd-libopencl1 ocl-icd-opencl-dev mesa-opencl-icd clinfo libgl1-mesa-dri libglapi-mesa libgbm1 libwayland-egl1 libd3dadapter9-mesa libosmesa6 mesa-drm-shim ffmpeg gstreamer1.0-plugins-bad libavcodec-extra python3-opencv libopencv-dev gstreamer1.0-vaapi build-essential fonts-roboto fonts-font-awesome zip unzip unrar p7zip p7zip-full p7zip-rar git libayatana-appindicator3-1 ufw gufw flatpak hp-ppd foomatic-db-engine openprinting-ppds cups cups-browsed system-config-printer ipp-usb printer-driver-cups-pdf sane-utils pcscd libccid libpcsclite1 meson sassc bluez-tools bluetooth ruby ruby-dev zsh google-chrome-stable nautilus-sendto firefox firefox-l10n-bg plymouth plymouth-themes libplymouth5;

## Install latest firmware from git
#git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
#sudo cp -rfu linux-firmware/* /lib/firmware/
#sudo update-initramfs -u -k all
#rm -rf linux-firmware

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

## Install Cascadia Mono NerdFonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaMono.zip
mkdir -p ~/CascadiaMonoNerdFonts
unzip CascadiaMono.zip -d ~/CascadiaMonoNerdFonts
sudo mv ~/CascadiaMonoNerdFonts /usr/share/fonts/
sudo fc-cache -v
sudo rm -rf CascadiaMono.zip

## View and manage network settings through Gnome Settings Panel.
sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
echo > /etc/network/interfaces

exit 0
