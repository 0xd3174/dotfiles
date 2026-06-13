{ pkgs, ... }:

{
  systemd.services.mihomo = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      LimitNPROC = 500;
      LimitNOFILE = 1000000;

      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE";

      Restart = "always";
      RestartSec = 1;

      ExecStart = "${pkgs.mihomo}/bin/mihomo -d /etc/mihomo -f /etc/secrets/config.yaml";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
    };
  };
}
