{ inputs, pkgs, ... }:

{
  imports = [
    ./noctalia.nix

    ./apps/syncthing.nix
    ./apps/zoxide.nix
    ./apps/vscode.nix
  ];

  programs.bash = {
    enable = true;

    shellAliases = {
      nixr = "sudo nixos-rebuild switch --flake .";
      nixup = "nix fmt . && git add . && git commit -am '🚧'";
    };
  };

  # Notif Daemon
  services.mako.enable = true;
  services.mako.settings =
    {
      default-timeout = 3000;
    };
  # Terminal Emulator
  programs.alacritty.enable = true;
  # App Launcher
  programs.fuzzel.enable = true;

  # Screen Recorder
  programs.obs-studio.enable = true;


  home.packages = with pkgs; [
    #aseprite # Pixel image editor

    ### System ###

    waybar # Status bar
    wl-clipboard # Clipboard

    bluetuith # Bluetooth tui

    ### Multimedia ###

    nautilus # File manager
    baobab # Disk analyzer
    loupe # Image viewer
    decibels # Audio files
    showtime # Video player
    papers # Document viewer
    kdePackages.ark # File (de)compression

    ### Screenshot ###

    grim # Screenshot for region
    slurp # Region chooser

    ### Code ###

    helix # Terminal code editor

    ### Flexing ###

    fastfetch # Fetch backend
    hyfetch # Fetch lgbt+ styles
    pipes # Screensaver

    ### Other ###

    sing-box # Proxy utility
    xray

    obsidian # Notes
  ] ++ [
    inputs.zen-browser.packages."${system}".default
  ];
}
