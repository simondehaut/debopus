██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
█████████████▄─▄▄▀█─▄▄▄█▄─▄▄▀█─▄▄─█▄─▄▄─█▄─██─▄█─▄▄▄▄█
██████████████─██─█─▄▄███─▄▄─█─██─██─▄▄▄██─██─██▄▄▄▄─█
█████████████▄▄▄▄██▄▄▄▄█▄▄▄▄██▄▄▄▄█▄▄▄████▄▄▄▄██▄▄▄▄▄█

# nomis debian installer

- asus ux302l
- uefi, ext4 root, ext4 home, plasma, nvidia drivers
- 500GB SSD

## instructions

1. debian baremetal net install (dont select "debian desktop environnement")
- https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/
- partitions :
  - uefi: 256MB
  - root: 100GB ext4
  - swap: 8GB
  - home: ~remaining ext4
  - free: 1GB

2. connection
- eth wire up (usb<-->eth adapter)
- add following text to ``/etc/network/interfaces`` :
```
auto enx9cebe8126fe7
allow-hotplug enx9cebe8126fe7
iface enx9cebe8126fe7 inet dhcp
```
- then ``sudo systemctl restart networking``

3. ``sudo apt update``

4. ``sudo apt install git`` 

5. ``git clone https://github.com/simondehaut/debopus.git``

6. install setup as root

```bash
cd ./debopus
chmod +x ./install.sh
./install.sh
```
