{ config, pkgs, ... }:

let
  solarized-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "solarized";
      publisher = "ryanolsonx";
      version = "3.0.0";
      sha256 = "sha256-/mcaH3ms8yqfzTlaejH8xiT7wi19P7PdUeWS/6R+Ezg=";
    };
  };
in

{
	programs.vscode = {
		enable = true;

		profiles.default.extensions = [
			solarized-theme
		];

		profiles.godot.extensions = with pkgs.vscode-extensions; [
			ms-dotnettools.csharp
			ms-dotnettools.csdevkit

			github.copilot
			github.copilot-chat
		];
	};
}
