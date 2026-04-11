{ inputs, pkgs, ... }:

{
  imports = [
    ./apps/syncthing.nix
    ./apps/zoxide.nix
    ./apps/vscode.nix
    ./apps/rider.nix
  ];

  programs.bash = {
    enable = true;

    shellAliases = {
      nixr = "sudo nixos-rebuild switch --flake .";
      nixup = "nix fmt . && git add . && git commit -am '🚧'";
    };
  };

  home.packages = with pkgs; [
    #aseprite # Pixel image editor

    prismlauncher-unwrapped

    obs-studio

    satty
    xray

    ### System ###

    alacritty
    waybar # Status bar
    wl-clipboard # Clipboard
    rofi # App Launcher

    bluetuith # Bluetooth tui

    ### Multimedia ###1

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

    obsidian # Notesi

    python315
  ] ++ [
    inputs.zen-browser.packages."${system}".default
  ];
}
