{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  home.sessionVariables = {
    STARSHIP_CONFIG = lib.mkForce "$HOME/.config/starship/starship.toml";
  };
}
