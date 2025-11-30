{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs:

    let
      constants = import ./constants.nix { };
    in

    {
      nixosConfigurations.${constants.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./nix/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${constants.username} = import ./home/home.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
