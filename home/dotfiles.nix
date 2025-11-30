{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  xdg.configFile."rofi" = {
    source = symlink "${dotfiles}/rofi/";
    recursive = true;
  };

  xdg.configFile."alacritty" = {
    source = symlink "${dotfiles}/alacritty/";
    recursive = true;
  };

  xdg.configFile."sway" = {
    source = symlink "${dotfiles}/sway/";
    recursive = true;
  };

  xdg.configFile."waybar" = {
    source = symlink "${dotfiles}/waybar/";
    recursive = true;
  };
}
