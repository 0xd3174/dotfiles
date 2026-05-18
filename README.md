# ❄️ NixOS Dotfiles
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Wayland](https://img.shields.io/badge/Wayland-000000?style=for-the-badge&logo=wayland&logoColor=white)
![Niri](https://img.shields.io/badge/Niri-gray?style=for-the-badge)

![View of desktop](https://github.com/0xd3174/dotfiles/blob/master/assets/desktop.png)

## 📂 Project Structure

```
.
└── config/
    ├── assets/       - some media files
    │   └── bg.png
    ├── dotfiles/     - .config mostly files
    ├── home/         - home manager config
    ├── nix/          - nixos config
    ├── constans.nix  - username, hostname, etc...
    └── flake.nix     - ❤️
```

## 🚀 Setup and Usage

### 1. Hardware Config

- Replace `nix/hardware.nix` with your system's `/etc/nixos/hardware-configuration.nix`.
- Update `constants.nix` with your own `hostname` and `username`.

### 2. Set Password

```sh
sudo mkdir -p /etc/secrets
mkpasswd -m sha-512 | sudo tee /etc/secrets/<USERNAME>-pass > /dev/null
sudo chmod 600 /etc/secrets/<USERNAME>-pass
```

### 3. Mihomo Config

`mihomo` uses `/etc/secrets/config.yaml` as its config path.

### 4. Build & Apply

```bash
sudo nixos-rebuild switch --flake .#<USERNAME>
```
