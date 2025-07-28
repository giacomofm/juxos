# NixOS

[nix.dev](https://nix.dev/)  
[NixOS](https://nixos.org/manual/nixos/stable/)  
[Appendix A. Configuration Options](https://nixos.org/manual/nixos/stable/options)

## Installazione

### Partitioning
```
lsblk # Per controllare i dischi
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -8GB
parted /dev/sda -- mkpart swap linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on
```
### Formatting
```
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
```
### Installing
```
mount /dev/disk/by-label/nixos /mnt
# (for UEFI)
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```

`nixos-generate-config --root /mnt` per creare la base  
clona `git clone https://github.com/giacomofm/juxos.git` (•̀ᴗ•́)و
edita `/mnt/etc/nixos/configuration.nix`  

`nixos-install`

(NOPE) Alla fine password per l'utente:
`nixos-enter --root /mnt -c 'passwd juk'`

`reboot`


## Upgrading

[Upgrading NixOS](https://nixos.org/manual/nixos/stable/#sec-upgrading)

`nixos-rebuild switch --upgrade`

## Cleaning

`nixos-rebuild list-generations`  
`sudo nix-collect-garbage -d`
