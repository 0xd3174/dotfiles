{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, vscode-server, noctalia, ... }@inputs:

    let
      constants = import ./constants.nix { };
    in

    {
      nixosConfigurations.${constants.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./nix/configuration.nix

          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default

          {
            services.vscode-server.enable = true;

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
