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
  fileSystems."/mnt/Tera" = {
    device = "/dev/disk/by-uuid/3B7DE3DD5A98E43C";
    options = ["users" "nofail" "x-gvfs-show"];
  };
}
