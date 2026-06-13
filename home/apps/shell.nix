{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      nixr = "doas nixos-rebuild switch --flake .";
      nixup = "nix fmt . && git add . && git commit -am '🚧'";
      nixpush = "git reset --soft origin/master && nixup && git push origin master";
    };
  };
}
