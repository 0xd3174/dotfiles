{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  xdg.configFile."alacritty" = {
    source = symlink "${dotfiles}/alacritty/";
    recursive = true;
  };

  xdg.configFile."fuzzel" = {
    source = symlink "${dotfiles}/fuzzel/";
    recursive = true;
  };

  xdg.configFile."gtk-4.0" = {
    source = symlink "${dotfiles}/gtk-4.0/";
    recursive = true;
  };

  xdg.configFile."gtk-3.0" = {
    source = symlink "${dotfiles}/gtk-3.0/";
    recursive = true;
  };

  xdg.configFile."niri" = {
    source = symlink "${dotfiles}/niri/";
    recursive = true;
  };

  xdg.configFile."qt5ct" = {
    source = symlink "${dotfiles}/qt5ct/";
    recursive = true;
  };

  xdg.configFile."qt6ct" = {
    source = symlink "${dotfiles}/qt6ct/";
    recursive = true;
  };

  xdg.configFile."fastfetch" = {
    source = symlink "${dotfiles}/fastfetch/";
    recursive = true;
  };

  xdg.configFile."micro" = {
    source = symlink "${dotfiles}/micro/";
    recursive = true;
  };

  xdg.configFile."noctalia" = {
    source = symlink "${dotfiles}/noctalia/";
    recursive = true;
  };
}
