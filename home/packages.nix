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
    #aseprite # Pixel image editor

    ### System ###

    wl-clipboard # Clipboard

    ### Multimedia ###

    nautilus # File manager
    baobab # Disk analyzer
    loupe # Image viewer
    decibels # Audio files
    showtime # Video player
    papers # Document viewer
    kdePackages.ark # File (de)compression

    ### Code ###

    helix # Terminal code editor

    ### Flexing ###

    fastfetch # Fetch backend
    pipes # Screensaver

    ### Other ###

    sing-box # Proxy utility
    xray

    obsidian # Notes
    xournalpp

    kdlfmt

    brightnessctl
    pulseaudio

    winboat

    (texlive.combine {
      inherit (texlive) scheme-medium
        biblatex biblatex-gost
        extsizes
        titlesec
        tocloft
        biber
        enumitem;
    })
    corefonts # windows-fonts (especially Times New Roman)
    zotero # reference-manager
  ] ++ [
    inputs.zen-browser.packages."${system}".default
  ];
}
