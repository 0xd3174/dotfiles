{ config, lib, pkgs, constants, ... }:

{
  imports = [
    ./hardware.nix
    ./undervolt.nix
    ./mihomo.nix
  ];

  ########################
  ### Low Level System ###
  ########################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  security.polkit.enable = true;

  services.tuned.enable = true;
  services.upower.enable = true;

  programs.nix-ld.enable = true;

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "${constants.username}" ];
    persist = true;
    setEnv = [ "PATH" "NIX_PATH" "HOME" ];
  }];

  ##################
  ### Networking ###
  ##################

  networking.hostName = "${constants.hostname}";

  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.firewall.checkReversePath = "loose";
  networking.firewall.trustedInterfaces = [ "utun0" "tun0" ]; # tun interfaces

  networking.nftables.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };
  virtualisation.docker.enable = true;

  ##############
  ### Sounds ###
  ##############

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;

  ################
  ### Language ###
  ################

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Kaliningrad";

  #########################
  ### High Level System ###
  #########################

  users.users.${constants.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" "docker" ];
    hashedPasswordFile = "/etc/secrets/${constants.username}-pass";
  };

  #############
  ### DE/WM ###
  #############

  services.displayManager.ly.enable = true;

  programs.niri = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  ################
  ### Packages ###
  ################

  programs.git.enable = true;
  programs.git.config = {
    safe.directory = "/home/${constants.username}/config";
  };

  programs.htop.enable = true;

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "sudo" "exec doas \"$@\"")

    xwayland-satellite

    brightnessctl

    wget
    micro
    bind
    net-tools
    jq
  ];

  system.stateVersion = "25.05";
}
