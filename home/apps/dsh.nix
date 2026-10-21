{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.dsh-nix.homeManagerModules.dsh
  ];

  programs.dsh = {
    enable = true;

    package = inputs.dsh-nix.packages.${pkgs.system}.dsh;

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
      ExecStart = "${config.programs.dsh.package}/bin/dsh web --port 3080 --no-open";
      Restart = "on-failure";
    };
  };
}
