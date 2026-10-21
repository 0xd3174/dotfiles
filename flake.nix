{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixpkgs-patcher = {
      url = "github:gepbird/nixpkgs-patcher";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    helium-browser = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dsh-nix = {
      url = "github:Samuka007/dsh-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, nixpkgs-patcher, ... }@inputs:

    let
      constants = import ./constants.nix;
    in

    {
      nixosConfigurations.${constants.hostname} = nixpkgs-patcher.lib.nixosSystem {
        system = "x86_64-linux";

        nixpkgsPatcher.nixpkgs = nixpkgs;

        specialArgs = inputs // { inherit inputs constants; };

        modules = [
          ./nix/configuration.nix
          ./overlays

          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.${constants.username} = import ./home/home.nix;

              backupFileExtension = "backup";

              extraSpecialArgs = { inherit inputs constants; };
            };
          }
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        packages = with nixpkgs.legacyPackages.x86_64-linux; [
          git
          nixpkgs-fmt
        ];
      };
    };
}

