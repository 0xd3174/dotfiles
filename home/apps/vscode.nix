{ config, pkgs, ... }:

let
  latex-workshop = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "latex-workshop";
      publisher = "james-yu";
      version = "10.14.1";
      sha256 = "sha256-lsbiKzZTlkq/9K7ptLg0kHAd4i5OyNh2pLGGYUOJS9A=";
    };
  };

  solarized-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "solarized";
      publisher = "ryanolsonx";
      version = "3.0.0";
      sha256 = "sha256-/mcaH3ms8yqfzTlaejH8xiT7wi19P7PdUeWS/6R+Ezg=";
    };
  };

  shared = with pkgs.vscode-extensions; [
    github.copilot
    github.copilot-chat
  ] ++ [
    solarized-theme
  ];
in

{
  home.packages = with pkgs; [
    ###########
    ### Nim ###
    ###########
    nim
    nimble
    nimlangserver
    nph
    ##############
    ### Python ###
    ##############
    python313
    uv
    rustc
    cargo
    gcc
    #############
    ### Latex ###
    #############
    (texlive.combine {
      inherit (texlive) scheme-medium
        biblatex biblatex-gost
        extsizes
        titlesec
        tocloft
        biber;
    })
    corefonts # windows-fonts (especially Times New Roman)
    zotero # reference-manager
  ];

  programs.vscode = {
    enable = true;

    profiles.default.extensions = shared;

    profiles.ts.extensions = with pkgs.vscode-extensions; [
      bradlc.vscode-tailwindcss
      esbenp.prettier-vscode
      styled-components.vscode-styled-components
    ] ++ shared;

    profiles.nim.extensions = with  pkgs.vscode-extensions; [
      nimlang.nimlang
    ] ++ shared;

    profiles.python.extensions = with  pkgs.vscode-extensions; [
      ms-python.python
      ms-python.vscode-pylance
    ] ++ shared;

    profiles.latex.extensions = with pkgs.vscode-extensions; [

    ] ++ [ latex-workshop ] ++ shared;
  };
}
