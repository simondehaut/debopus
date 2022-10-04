#!/bin/bash

# @TODO : flag de montage de partitions

# @TODO : on garde ?
#CYANCOLOR='\033[0;36m'
#NOCOLOR='\033[0m'

# /etc/apt/sources.list
cat << EOF > /etc/apt/sources.list

deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb http://security.debian.org/debian-security bullseye-security main contrib non-free
deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free

deb http://security.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://security.debian.org/debian/ bullseye-updates main contrib non-free

EOF

# or :
# apt update -y
# apt install -y software-properties-common
# apt-add-repository non-free
# apt update -y

# update & upgrade
apt update -y
apt upgrade -y

# extend path env var with /usr/local/sbin and /usr/sbin and /sbin
echo "export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH" >> ~/.bashrc

# @TODO : oui ou non ?
# enabling syntax highlighting for nano
#echo 'include "/usr/share/nano/*.nanorc"' >> /etc/nanorc

# adding kernel parameters to grub
# ascii charcode for [!,',"] -> [\x21,\x27,\x22]
KPARAMREPLACEMENTPRE="GRUB_CMDLINE_LINUX_DEFAULT=\x22acpi_osi=\x21Linux acpi_osi=\x27Windows 2013\x27 loglevel=3\x22"
KPARAMREPLACEMENT=$(echo -e "$KPARAMREPLACEMENTPRE")
sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=.*/$KPARAMREPLACEMENT/" /etc/default/grub
echo "rebuilbing /boot/grub/grub.cfg after adding kernel params..."

# rebuilt grub config after editing /etc/default/grub
/sbin/grub-mkconfig -o /boot/grub/grub.cfg

# grub config
touch /boot/grub/custom.cfg
echo "set color_normal=white/black" >> /boot/grub/custom.cfg
echo "set color_highlight=red/black" >> /boot/grub/custom.cfg
echo "set menu_color_normal=white/black" >> /boot/grub/custom.cfg
echo "set menu_color_highlight=red/black" >> /boot/grub/custom.cfg
echo GRUB_BACKGROUND=\"\" >> /etc/default/grub
/sbin/update-grub

# enable ssd trim timer
systemctl enable fstrim.timer
systemctl start fstrim.timer

# enabling bluetooth service
systemctl enable bluetooth

# setting swap to init at >= 90% ram filled
echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf

# disable recommended and suggested package for apt
#echo 'APT::Install-Recommends "false";' > /etc/apt/10-no-install-recommends.conf
#echo 'APT::Install-Suggests "false"; ' >> /etc/apt/10-no-install-recommends.conf 

# show line numbers in nano for root and nomis user
echo 'set linenumbers' >> /root/.nanorc
echo 'set linenumbers' >> /home/nomis/.nanorc

# do regexp search by default in nano for root and nomis user
echo 'set regexp' >> /root/.nanorc
echo 'set regexp' >> /home/nomis/.nanorc

# active mouse cursor in nano for nomis user
echo 'set mouse' >> /home/nomis/.nanorc

# utils
apt install -y linux-headers-$(uname -r) -y
apt install -y software-properties-common -y

# firmwares and system prerequisites
apt install -y firmware-iwlwifi
apt install -y firmware-realtek
apt install -y laptop-mode-tools
apt install -y wireless-tools
apt install -y laptop-detect
apt install -y xbacklight

# firewall
apt install -y ufw
systemctl enable ufw
ufw enable
systemctl enable ufw.service
ufw default deny incoming
ufw default allow outgoing

# tlp
apt install -y tlp
systemctl start tlp.service
systemctl enable tlp.service

# some windows fs relative utils
apt install -y dosfstools
apt install -y ntfs-3g
apt install -y mtools
apt install -y exfat-utils

# installing fonts relative pkg
apt install -y font-inconsolata
apt install -y ttf-bitstream-vera
apt install -y fonts-dejavu
apt install -y fonts-liberation
apt install -y fonts-freefont-ttf
apt install -y fonts-roboto
apt install -y fonts-b612
apt install -y fonts-unifont
apt install -y ttf-mscorefonts-installer
apt install -y ttf-liberation

# miscs
apt install -y ffmpeg
apt install -y build-essential
apt install -y curl
apt install -y wget
apt install -y apt-transport-https
apt install -y htop
apt install -y acpi acpi-support acpica-tools acpid acpidump acpitail acpitool
apt install -y git
apt install -y ethtool
apt install -y neofetch
apt install -y p7zip-full
apt install -y testdisk
apt install -y dos2unix
apt install -y scrcpy
apt install -y jq
apt install -y scrcpy
apt install -y solaar

# power management
apt install -y powerdevil

# X
apt install -y xorg
#apt install -y xserver-xorg
#apt install -y xserver-xorg-core 
apt install -y xinput 
#apt install -y xinit
#apt install -y xserver-xorg-input-libinput

# config xinit for startx
touch /home/nomis/.xinitrc
echo 'export DESKTOP_SESSION=plasma' >> /home/nomis/.xinitrc
echo 'exec startplasma-x11' >> /home/nomis/.xinitrc
chown nomis /home/nomis/.xinitrc

# basically 'kde-plasma-desktop' package without sddm login manager
apt install -y kde-baseapps
apt install -y plasma-desktop
apt install -y plasma-workspace
apt install -y udisks2
apt install -y upower
apt install -y kwin-x11

# some plasma environnement package
apt install -y kwrite
apt install -y ark
apt install -y kde-spectacle
apt install -y kwalletmanager
apt install -y plasma-dataengines-addons
apt install -y plasma-pa
apt install -y polkit-kde-agent-1
apt install -y plasma-nm
apt install -y filelight
apt install -y kompare
apt install -y okteta
apt install -y kdevelop
apt install -y partitionmanager
apt install -y xdg-desktop-portal-kde
apt install -y plasma-browser-integration
apt install -y kfind
apt install -y kinfocenter
apt install -y kscreen
apt install -y systemsettings
apt install -y kimageformat-plugins
apt install -y kde-config-gtk-style
apt install -y bluedevil
#apt install -y plasma-widgets-addons

# modify system default target to prevent X to start at boot
systemctl set-default multi-user.target

# audio relative pkg
apt install -y alsa-utils
apt install -y gstreamer1.0-libav
apt install -y pulseaudio-module-bluetooth
apt install -y phonon4qt5
#pacman -S --noconfirm gst-plugins-{base,good,bad,ugly}
#pacman -S --noconfirm pulseaudio-alsa lib32-libpulse
#pacman -S --noconfirm lib32-alsa-plugins

# configuring bluetooth
usermod -aG lp nomis
echo 'load-module module-bluetooth-policy' >> /etc/pulse/system.pa
echo 'load-module module-bluetooth-discover' >> /etc/pulse/system.pa

# miscs drivers and utils
apt install -y mesa-vulkan-drivers
apt install -y vulkan-tools

#pacman -S --noconfirm mesa vulkan-intel vulkan-tools mesa-demos
#pacman -S --noconfirm lib32-mesa lib32-mesa-demos lib32-vulkan-intel

# X
#pacman -S --noconfirm xorg-{server,xinit,apps,xinput} xf86-input-libinput

# nvidia drivers and utils
#https://wiki.debian.org/fr/NvidiaGraphicsDrivers
apt install -y nvidia-legacy-390xx-driver
apt install -y nvidia-settings-legacy-390xx
apt install -y nvidia-vulkan-common
apt install -y nvidia-opencl-common
apt install -y firmware-misc-nonfree

# @TODO : oui ou non ?
#pacman -S --noconfirm xorg-server-devel nvidia-lts
#pacman -S --noconfirm nvidia-utils lib32-nvidia-utils
#pacman -S --noconfirm opencl-nvidia lib32-opencl-nvidia
#pacman -S --noconfirm nvidia-settings nvidia-prime

# multimedia
apt install -y filezilla
apt install -y kolourpaint
apt install -y inkscape
apt install -y pdfsam
apt install -y firefox-esr firefox-esr-l10n-fr
apt install -y ghostwriter
apt install -y vlc vlc-l10n
apt install -y libreoffice

# java
apt install -y default-jre

# qview
wget https://github.com/jurplel/qView/releases/download/5.0/qview_5.0.1-focal4_amd64.deb
apt install -y ./qview_5.0.1-focal4_amd64.deb
rm ./qview_5.0.1-focal4_amd64.deb

# teamviewer
#wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#apt install -y ./teamviewer_amd64.deb
#rm ./teamviewer_amd64.deb

# veracrypt
wget https://launchpad.net/veracrypt/trunk/1.25.9/+download/veracrypt-1.25.9-Debian-11-amd64.deb
apt install -y ./veracrypt-1.25.9-Debian-11-amd64.deb
rm ./veracrypt-1.25.9-Debian-11-amd64.deb

# pdfsam
wget https://github.com/torakiki/pdfsam/releases/download/v4.2.10/pdfsam_4.2.10-1_amd64.deb
apt install -y ./pdfsam_4.2.10-1_amd64.deb
rm ./pdfsam_4.2.10-1_amd64.deb

# gitahead
wget https://github.com/gitahead/gitahead/releases/download/v2.6.3/GitAhead-2.6.3.sh
chmod +x ./GitAhead-2.6.3.sh
./GitAhead-2.6.3.sh
rm ./GitAhead-2.6.3.sh

# visual studio codium
#wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --#dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
#echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://#download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
#apt update -y
#apt install -y codium
#vscodium --install-extension wayou.vscode-todo-highlight
#vscodium --install-extension svelte.svelte-vscode

# insomnia
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
sudo apt-get update
sudo apt-get install insomnia

# brave
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install -y brave-browser

# flatpak
#apt install -y flatpak
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# android studio
# flatpak install flathub com.google.AndroidStudio

# nodejs
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
apt install -y npm

# peerflix
npm -g install --quiet peerflix

# copy files from git to home folder and init
cp -R /home/nomis/debopus/home/{.,}* /home/nomis/

# give to Caesar what belongs to Caesar
chown -R nomis /home/nomis/{,.}*

# @TODO : oui ou non ?
# hercules ?
# ttf-ubuntu-font-family ?
# yay -S ttf-ms-fonts ttf-vista-fonts
# fstab flags ?
# update-init-ramfs- yk -j all après changement /etc/fstab ?

# install docker
apt install -y ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
chmod a+r /etc/apt/keyrings/docker.gpg
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin









# mount -o defaults,ssd,noatime,nodiratime,compress=zstd,subvol=@opt /dev/sda2 /mnt/opt
# mount -o defaults,ssd,noexec,nosuid,nodev,noatime,nodiratime,compress=zstd,subvol=@tmp /dev/sda2 /mnt/tmp
# mount -o defaults,ssd,noatime,nodiratime,compress=zstd,subvol=@.snapshots /dev/sda2 /mnt/.snapshots
# mount -o defaults,ssd,nodatacow,noatime,nodiratime,compress=zstd,subvol=@var /dev/sda2 /mnt/var

# echo "mounting efi partition..."
# mount -o ssd,noatime,nodiratime /dev/sda1 /mnt/boot

# echo "/home partition..."
# mount -o defaults,ssd,noatime,nodiratime /dev/sda4 /mnt/home
