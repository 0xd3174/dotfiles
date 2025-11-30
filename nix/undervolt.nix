{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
		intel-undervolt
	];

	environment.etc,"intel-undervolt.conf".text = ''
		undervolt 0 'CPU' -1
		undervolt 1 'GPU' 0
		undervolt 2 'CPU Cache' 0
		undervolt 3 'System Agent' 0
		undervolt 4 'Analog I/O' 0
	'';
}
