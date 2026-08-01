{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.sessionVariables = {
    STARSHIP_CONFIG = lib.mkForce "$HOME/.config/starship/starship.toml";
  };
}
