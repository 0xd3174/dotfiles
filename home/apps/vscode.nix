{ config, pkgs, ... }:

let
  solarized-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "solarized";
      publisher = "ryanolsonx";
      version = "3.0.0";
      sha256 = "sha256-/mcaH3ms8yqfzTlaejH8xiT7wi19P7PdUeWS/6R+Ezg=";
    };
  };

  sharedExtensions = with pkgs.vscode-extensions; [
    github.copilot
    github.copilot-chat
  ] ++ [
    solarized-theme
  ];
in

{
  imports = [
    (fetchTarball {
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
      sha256 = "sha256-0xjal4zcbmdjdaspfkjbpx1680q7390wfzmj7iad04kp3pc9syf8=";
    })
  ];

  services.vscode-server.enable = true;

  home.packages = with pkgs; [
    nim
    nimble
    nimlangserver
    nph
  ];

  programs.vscode = {
    enable = true;

    profiles.default.extensions = sharedExtensions;

    profiles.ts.extensions = with pkgs.vscode-extensions; [
      bradlc.vscode-tailwindcss
      esbenp.prettier-vscode
      styled-components.vscode-styled-components
    ] ++ sharedExtensions;

    profiles.nim.extensions = with  pkgs.vscode-extensions; [
      nimlang.nimlang
    ] ++ sharedExtensions;
  };
}
