{ constants, pkgs, ... }:

{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "/home/${constants.username}/.bitwarden-ssh-agent.sock";
  };

  home.packages = with pkgs; [
    bitwarden-desktop
  ];
}
