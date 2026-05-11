{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    mutableUserSettings = false;
    mutableUserKeymaps = false;
  };
}
