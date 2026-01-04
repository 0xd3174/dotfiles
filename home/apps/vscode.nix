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
in

{
  home.packages = with pkgs; [
    nim
  ];

  programs.vscode = {
    enable = true;

    profiles.default.extensions = [
      solarized-theme
      github.copilot
      github.copilot-chat
    ];

    profiles.ts.extensions = with pkgs.vscode-extensions; [
      bradlc.vscode-tailwindcss
      esbenp.prettier-vscode
      styled-components.vscode-styled-components
    ];

    profiles.nim.extensions = with  pkgs.vscode-extensions; [
      nimlang.nimlang
    ];
  };
}
