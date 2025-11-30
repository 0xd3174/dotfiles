{ pkgs, ... }:

{
  home.packages = with pkgs; [
    godotPackages_4_5.godot-mono
    jetbrains.rider
    dotnet-sdk_8
  ];
}
