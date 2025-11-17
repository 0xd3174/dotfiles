{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
   		url = "github:0xc000022070/zen-browser-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }:

	let
		constants = import ./constants.nix {};
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

            extraSpecialArgs = { inherit zen-browser; };
          };
        }
      ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
