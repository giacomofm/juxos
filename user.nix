{ pkgs, ... }: {
  users.users.juk = {
    uid = 1000;
    isNormalUser = true;
    description = "Juk";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      jetbrains-toolbox
      qbittorrent
      spotify
    ];
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # Tera
  # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
  fileSystems."/mnt/Tera" = {
    device = "/dev/disk/by-uuid/3B7DE3DD5A98E43C";
    fsType = "ntfs3";
    options = [
      "nofail"
      "rw"
      "users"
      "uid=1000"
      "gid=100"
      "x-gvfs-show"
      "windows_names"
    ];
  };
}