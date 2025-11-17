{ pkgs, ... }:

let
	constants = import ./constants.nix {};
in

{
  imports = [
  	./home/dotfiles.nix
  	./home/apps.nix
  	./home/fonts.nix
  ];

  home.username = "${constants.username}";
  home.homeDirectory = "/home/${constants.username}";

  programs.git.enable = true;
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
    };
  };

  home.pointerCursor = {
		name = "Adwaita";

		package = pkgs.adwaita-icon-theme;
  	size = 24; # This doesn't make any fucking sense bcz of sway config
  };

  fonts.fontconfig.enable = true;
}
