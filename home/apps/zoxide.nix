{ pkgs, ... }:

{
	programs.bash = {
	  shellAliases = {
			cd = "z";
	  };
	};
	
	programs.zoxide = {
		enable = true;
		enableBashIntegration = true;
	};
}
