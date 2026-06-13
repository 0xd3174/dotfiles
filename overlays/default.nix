/*
  Example overlay file format (e.g., custom-pkg.nix):

  { pkgs, ... }:
  (final: prev: {
  # Replace a package with a custom version or configuration
  # my-pkg = prev.my-pkg.overrideAttrs (old: { ... });
  })
*/

{ pkgs, ... }@args:

{
  nixpkgs.overlays = builtins.map
    (f: (import (./. + "/${f}") args))
    (builtins.filter
      (f: f != "default.nix")
      (builtins.attrNames (builtins.readDir ./.)));
}
