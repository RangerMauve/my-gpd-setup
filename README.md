# my-gpd-setup
Here's my [GPD Win 4](https://www.gpd.hk/gpdwin4) setup with Arch linux.

## Operating System

I use [EndevourOS](https://endeavouros.com/) which is an [Arch](https://archlinux.org/) based distribution of Linux.

When installing from the live USB, 

## Desktop

I mostly followed this guide from [niri](https://github.com/YaLTeR/niri/wiki/Example-systemd-Setup)

```bash
yay -S \
  fuzzel \
  kanshi \
  kitty \
  mako \
  nerd-dictation-git \
  niri \
  swaybg \
  waybar \
  wl-clipboard \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  xwayland-satellite \
  ydotool
```

```bash
mkdir -p ~/.config/systemd/user/niri.service.wants

ln -s /usr/lib/systemd/user/mako.service ~/.config/systemd/user/niri.service.wants/
ln -s /usr/lib/systemd/user/waybar.service ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/xwayland-satellite.service ~/.config/systemd/user/niri.service.wants/
ln -s ~/.config/systemd/user/kanshi.service ~/.config/systemd/user/niri.service.wants/
```

## Configs

These configs will set my preferred keyboard bindings and color schemes

```bash
cp ./.agregorerc ~/
cp ./.bashrc ~/
cp ./.inputrc ~/
cp ./.profile ~/

# Mostly color schemes and keybindings
cp -R ./.config/. ~/.config/

# shell scripts I use elsewhere
cp -R ./.local/. ~/.local/
```

## Services

```bash
systemctl --user enable mako.service
systemctl --user start mako.service

# For supporting x11 programs in niri
systemctl --user enable xwayland-satellite.service 
systemctl --user start xwayland-satellite.service

# for adjusting to display changes
systemctl --user enable kanshi
systemctl --user start kanshi
```

## Applications

Here's a bunch of stuff I regularly use via the standard package manager.

```bash
yay -S \
  betterbird-bin \
  gapless \
  gearleverl \
  go \
  keysmith \
  nvm \
  rustup \
  vscodium-bin
```

Once I install `gearlever` I usually install the latest release of [Agregore](https://github.com/AgregoreWeb/agregore-browser/releases) via my package manager.

I use [ollama](https://ollama.com) for local LLMs so I usually install it from their install script:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```