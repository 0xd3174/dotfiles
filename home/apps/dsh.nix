{ inputs, pkgs, ... }:

let
  dshWithTimeout = inputs.dsh-nix.packages.${pkgs.system}.dsh.override {
    fetchPnpmDeps = args: pkgs.fetchPnpmDeps (args // {
      pnpmInstallFlags = [
        "--fetch-timeout=600000"
        "--fetch-retries=10"
      ];
    });
  };
in
{
  imports = [
    inputs.dsh-nix.homeManagerModules.dsh
  ];

  programs.dsh = {
    enable = true;

    package = dshWithTimeout;

    homePatchesFile = ./cordis.patch.yml;

    profiles.web = {
      plugins = [
        "@deepseek-ai/dsh-base"
        "@deepseek-ai/dsh-web-app"
      ];
    };

    profiles.headless = {
      plugins = [
        "@deepseek-ai/dsh-base"
        "@deepseek-ai/dsh-headless"
      ];
    };
  };

  home.file.".dsh/AGENTS.md".source = ./AGENTS.md;

  systemd.user.services.dsh = {
    Unit = {
      Description = "DeepSeek Harness Web Server";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "${dshWithTimeout}/bin/dsh web --port 3080";
      Restart = "on-failure";
    };
  };
}
