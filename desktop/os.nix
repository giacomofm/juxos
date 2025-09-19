{ config, pkgs, ... }: {
  imports = [
    ./nvidia.nix
    ./user.nix
  ];
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
  # Config
  networking.hostName = "desknix";
  # App
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-system-monitor
    ghostty
    sublime4
    nautilus
    vlc
    input-remapper
    hydrapaper
    # https://wiki.nixos.org/wiki/Thumbnails
    ffmpegthumbnailer
    gdk-pixbuf
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ];
  networking.extraHosts = ''
    127.0.0.1 sublimetext.com # disable sublime update check
  '';
}