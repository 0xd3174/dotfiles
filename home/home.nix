{ pkgs, constants, ... }:

{
  imports = [
    ./dotfiles.nix
    ./packages.nix
    ./fonts.nix
  ];

  home.username = "${constants.username}";
  home.homeDirectory = "/home/${constants.username}";

  home.pointerCursor = {
    name = "Adwaita";

    package = pkgs.adwaita-icon-theme;
  };

  home.stateVersion = "25.05";
}
