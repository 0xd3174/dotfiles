{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/config/dotfiles";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = [
    "foot"
    "gtk-4.0"
    "gtk-3.0"
    "niri"
    "qt5ct"
    "qt6ct"
    "fastfetch"
    "micro"
    "noctalia"
    "zed"
  ];
in

{
  xdg.configFile = builtins.listToAttrs
    (map
      (name: {
        inherit name;
        value = {
          source = symlink "${dotfiles}/${name}";
        };
      })
      configs) // {
    "starship.toml".source = symlink "${dotfiles}/starship/starship.toml";
    "starship/starship.toml".source = symlink "${dotfiles}/starship/starship.toml";
  };
}

