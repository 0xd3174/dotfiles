{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserSettings = false;
    mutableUserKeymaps = false;

    #extraPackages = with pkgs; [ nodejs ];

    #extensions = [
    #  "nix"
    #  "dockerfile"
    #  "docker-compose"
    #  "latex"
    #  "rose-pine-theme"
    #  "oxc"
    #];
  };
}
