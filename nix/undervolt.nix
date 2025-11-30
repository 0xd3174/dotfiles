{ pkgs, ... }:

{
	services.undervolt = {
		enable = true;
		
		coreOffset   = -100;
		
		gpuOffset    = 0;
		uncoreOffset = 0;
	};
}
