{ pkgs, constants, ... }:

{
  imports = [
    ./dotfiles.nix
    ./packages.nix
    ./fonts.nix

    # Apps
    ./apps/alacritty.nix
    ./apps/bitwarden.nix
    ./apps/direnv.nix
    ./apps/fuzzel.nix
    ./apps/noctalia.nix
    ./apps/obs.nix
    ./apps/shell.nix
    ./apps/starship.nix
    ./apps/syncthing.nix
    ./apps/zed.nix
    ./apps/zoxide.nix
  ];

  home.username = "${constants.username}";
  home.homeDirectory = "/home/${constants.username}";

  home.pointerCursor = {
    name = "Adwaita";

    package = pkgs.adwaita-icon-theme;
  };

  home.stateVersion = "25.05";
}
