{ config, pkgs, ... }: {
  imports = [
    ./nvidia.nix
    ./locale.nix
    ./user.nix
  ];
  # system.stateVersion = "25.05";
  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
  # Desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  # PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # App
  programs.firefox.enable = true;
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };
  environment.systemPackages = with pkgs; [
    ghostty
    git
    vlc
    sublime4
    nautilus
    gnome-system-monitor
    input-remapper
    hydrapaper
  ];
}
