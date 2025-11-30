{ pkgs, ... }:

let
  constants = import ./../constants.nix { };
in

{
  imports = [
    ./dotfiles.nix
    ./apps.nix
    ./fonts.nix
  ];

  home.username = "${constants.username}";
  home.homeDirectory = "/home/${constants.username}";

  home.pointerCursor = {
    name = "Adwaita";

    package = pkgs.adwaita-icon-theme;
    size = 24; # This doesn't make any fucking sense bcz of sway config
  };

  home.stateVersion = "25.05";
}
