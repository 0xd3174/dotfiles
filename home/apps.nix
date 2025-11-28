{ pkgs, zen-browser, ... }:

{
	imports = [ 
		./apps/syncthing.nix
		./apps/zoxide.nix
	];

	programs.bash = {
	  enable = true;
	  
	  shellAliases = {
	  	nixr  = "sudo nixos-rebuild switch --flake .";
	  	nixup = "git add . && git commit -am '🚧'";

	    btw = "echo I use nixos, btw";
	  };
	};
	
	home.packages = with pkgs; [
	  #aseprite # Pixel image editor

	  godotPackages_4_5.godot-mono

	  zen-browser.packages."${system}".default
	  satty

	  ### System ###

	  waybar       # Status bar
	  wl-clipboard # Clipboard
	  rofi         # App Launcher

	  bluetuith    # Bluetooth tui

	  ### Multimedia ###1

	  nautilus    # File manager
	  baobab      # Disk analyzer
	  loupe       # Image viewer
	  decibels    # Audio files
	  showtime    # Video player
	  papers      # Document viewer
	  kdePackages.ark # File (de)compression

	  ### Screenshot ###

	  grim  # Screenshot for region
	  slurp # Region chooser

		### Code ###

	  vscode # Main code editor
	  helix  # Terminal code editor

	  ### Flexing ###

	  fastfetch # Fetch backend
	  hyfetch   # Fetch lgbt+ styles
	  pipes     # Screensaver

	  ### Other ###

	  sing-box # Proxy utility

	  obsidian # Notes
	];
}
