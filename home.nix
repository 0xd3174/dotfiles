{ config, pkgs, zen-browser, ... }:

let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  imports = [ ];

  home.username = "delta";
  home.homeDirectory = "/home/delta";

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

  home.packages = with pkgs; [
    #aseprite # Pixel image editor

    zen-browser.packages."${system}".default

    ### System ###

    waybar       # Status bar
    wl-clipboard # Clipboard
    rofi         # App Launcher

    bluetuith    # Bluetooth tui

    ### Multimedia ###

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

    ### Fonts ###

		nerd-fonts.jetbrains-mono
    adwaita-fonts
  ];

	xdg.portal.configPackages = with pkgs; [
		xdg-desktop-portal-wlr
		xdg-desktop-portal-gtk
		xdg-desktop-portal-gnome
	];

  xdg.configFile."rofi" = {
    source = symlink "${dotfiles}/rofi/";
    recursive = true;
  };

  xdg.configFile."alacritty" = {
    source = symlink "${dotfiles}/alacritty/";
    recursive = true;
  };

  xdg.configFile."sway" = {
    source = symlink "${dotfiles}/sway/";
    recursive = true;
  };

  xdg.configFile."waybar" = {
      source = symlink "${dotfiles}/waybar/";
      recursive = true;
    };
}
