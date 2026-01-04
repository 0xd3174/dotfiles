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
  home.packages = with pkgs; [
    nim
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
