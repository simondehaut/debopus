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

2. connection

- eth wire up

3. git clone this repo

4. install setup as root

```bash
chmod +x ./install.sh
./install.sh
```

5. config

- import dotfiles and files... 