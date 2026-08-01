{ pkgs, ... }:

{
  programs.fish = {
    shellAliases = {
      cd = "z";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
