{ pkgs, ... }:

{
  systemd.services.mihomo = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";

      LimitNPROC = 500;
      LimitNOFILE = 1000000;

      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH CAP_DAC_OVERRIDE";

      Restart = "always";

      ExecStartPre = "${pkgs.coreutils}/bin/sleep 1s";
      ExecStart = "${pkgs.mihomo}/bin/mihomo -d /etc/mihomo -f /etc/secrets/config.yaml";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
    };
  };
}
