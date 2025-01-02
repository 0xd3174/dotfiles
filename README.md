# Installation

You must first install all the necessary packages
```bash
yay -S hyprland waybar wofi dunst \
	cliphist slurp grim micro \
	stow uwsm hyprpolkitagent \
	pipewire wireplumber flatpak \
	qt6-wayland qt5-wayland \
	xdg-desktop-portal xdk-desktop-portal-hyprland xdg-desktop-portal-wlr
```

Clone this repository and run this command inside cloned folder
```bash
stow alacritty hypr waybar wofi micro dunst
```

Also install Cantarell font from utils folder as well as [date.h](https://github.com/HowardHinnant/date) and [pwvucontrol](https://github.com/saivert/pwvucontrol).

After add Hyprland launch from uwsm to .bash_profile
```bash
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
```

# Other
Set preferred ozone platform in `chrome://flags` to avoid asshole scaling.
