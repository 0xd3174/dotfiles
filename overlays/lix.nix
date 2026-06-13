# https://lix.systems

{ ... }:

(final: prev: {
  nix = prev.lix;

  nixpkgs-review = prev.lixPackageSets.stable.nixpkgs-review;
  nix-eval-jobs = prev.lixPackageSets.stable.nix-eval-jobs;
  nix-fast-build = prev.lixPackageSets.stable.nix-fast-build;
  colmena = prev.lixPackageSets.stable.colmena;
})
