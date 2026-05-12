{ inputs, pkgs, ... }:

{
  imports = [
    ./apps/noctalia.nix
    ./apps/shell.nix
    ./apps/zoxide.nix
    ./apps/zed.nix
    ./apps/syncthing.nix
  ];

  # Terminal Emulator
  programs.alacritty.enable = true;
  # App Launcher
  programs.fuzzel.enable = true;

  # Screen recording software
  programs.obs-studio.enable = true;

  # Direnv
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    ##############
    ### System ###
    ##############

    wl-clipboard # Clipboard

    brightnessctl
    pulseaudio # Multimedia support

    ##################
    ### Multimedia ###
    ##################

    nautilus # File manager
    baobab # Disk analyzer
    loupe # Image viewer
    decibels # Audio files
    showtime # Video player
    papers # Document viewer
    kdePackages.ark # File (de)compression

    ############
    ### Code ###
    ############

    helix # Terminal code editor

    ###############
    ### Larping ###
    ###############

    fastfetch # Fetch backend
    pipes # Screensaver

    #############
    ### Other ###
    #############

    #aseprite # Pixel image editor

    kdlfmt # Formatter for niri

    sing-box
    xray # Vless compatible proxy utilities

    obsidian
    xournalpp # Notes

    #######################
    ### University Slop ###
    #######################

    winboat # Run windows app like native

    zotero # References manager
  ] ++ [
    inputs.zen-browser.packages."${system}".default
  ];
}
