# NordVPN install from source:
# https://github.com/NordSecurity/nordvpn-linux/issues/355#issuecomment-2486424885

{ config, pkgs, ... }: {
  systemd.sockets.nordvpnd = {
    description = "NordVPN Daemon Socket";
    listenStreams = [ "/run/nordvpn/nordvpnd.sock" ];
    partOf = [ "nordvpnd.service" ];
    socketConfig = {
      NoDelay = true;
      DirectoryMode = "0750";
      SocketMode = "0770";
      SocketUser = "nordvpn";
      SocketGroup = "nordvpn";
    };
    wantedBy = [ "sockets.target" ];
  };
}