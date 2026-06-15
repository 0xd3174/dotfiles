{ inputs, pkgs, constants, ... }:

{


  home.packages = with pkgs; [
    ##############
    ### System ###
    ##############

    wl-clipboard # Clipboard

    ##################
    ### Multimedia ###
    ##################

    nautilus # File manager
    baobab # Disk analyzer
    loupe # Image viewer
    decibels # Audio files
    showtime # Video player
    papers # Document viewer

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

    mihomo # Vless compatible proxy utilities

    brave-origin
    obsidian
    xournalpp # Notes

    #######################
    ### University Slop ###
    #######################

    winboat # Run windows app like native

    zotero # References manager

    tlrc # Man for dummies

    restic # Backup utility

    antigravity-cli # Gemini AI CLI

    onlyoffice-desktopeditors # Office suite
  ] ++ [
    # inputs.zen-browser.packages."${pkgs.system}".default
  ];
}
