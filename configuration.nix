{ config, lib, pkgs, ... }:

let
	constants = import ./constants.nix {};
in

{
  imports = [ ./hardware.nix ];

  ### Low Level System ###

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 3d";

  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;

  ### Peripherals ###

  services.libinput.touchpad.sendEventsMode = "disabled"; # Disable touchpad

  ### Networking ###

  networking.hostName = "t490nix";

  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.firewall.checkReversePath = "loose";
  networking.firewall.trustedInterfaces = [ "tun0" ]; # sing-box tun

  networking.firewall.allowedTCPPorts = [ 5173 ]; # vite --host

	### Sounds ###

	security.rtkit.enable = true;
	services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	};

	hardware.bluetooth.enable = true;

  ### Language ###

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Kaliningrad";

  ### High Level System ###

  users.users.${constants.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "input" ];
    hashedPassword = "!";
  };

  ### DE/WM

  services.displayManager.ly.enable = true;
  programs.sway = {
  	enable = true;
  	wrapperFeatures.gtk = true;
  };

  ## Packages

  environment.systemPackages = with pkgs; [
    alacritty
    wget
    git
    micro
    htop
    bind
    # intel-undervolt thinkfan lm_sensors
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.05";
}

