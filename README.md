# NixOS

[nix.dev](https://nix.dev/)  
[NixOS](https://nixos.org/manual/nixos/stable/)  
[Appendix A. Configuration Options](https://nixos.org/manual/nixos/stable/options)

## Installazione

`sudo su`

### Partitioning
```
lsblk # Per controllare i dischi
parted /dev/sdX -- mklabel gpt
parted /dev/sdX -- mkpart root ext4 512MB -8GB
parted /dev/sdX -- mkpart swap linux-swap -8GB 100%
parted /dev/sdX -- mkpart ESP fat32 1MB 512MB
parted /dev/sdX -- set 3 esp on
```
### Formatting
```
mkfs.ext4 -L nixos /dev/sdX1
mkswap -L swap /dev/sdX2
mkfs.fat -F 32 -n boot /dev/sdX3
```
### Installing
```
mount /dev/disk/by-label/nixos /mnt
# (for UEFI)
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```

`nixos-generate-config --root /mnt` per creare la base  
`cd /mnt/etc/nixos`  
clona `git clone https://github.com/giacomofm/juxos.git` (•̀ᴗ•́)و  
edita `/mnt/etc/nixos/configuration.nix` (negli import: `./juxos/os.nix`)  

`nixos-install`

Alla fine password per l'utente:  
`nixos-enter --root /mnt -c 'passwd juk'`

`reboot`

## Edit

Per aggiungere i permessi di scrittura:  
`sudo setfacl -R -m u:juk:rwx /etc/nixos/juxos`

## Upgrading

[Upgrading NixOS](https://nixos.org/manual/nixos/stable/#sec-upgrading)

`nixos-rebuild switch --upgrade`

## Cleaning

`nixos-rebuild list-generations`  
`sudo nix-collect-garbage -d`
