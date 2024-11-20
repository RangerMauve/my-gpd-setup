# my-gpd-setup
Here's my [GPD Win 4](https://www.gpd.hk/gpdwin4) setup with Arch linux.

## Operating System

I use [EndevourOS](https://endeavouros.com/) which is an [Arch](https://archlinux.org/) based distribution of Linux.

When installing from the live USB, I selected the option that lacks a GUI so I could build up an env from scratch.

I also made sure to enable LUKS disk encryption.

## Desktop

I mostly followed this guide from [niri](https://github.com/YaLTeR/niri/wiki/Example-systemd-Setup)

```bash
yay -S \
  brillo \
  dotool \
  fuzzel \
  kanshi \
  kitty \
  mako \
  nerd-dictation-git \
  niri \
  swaybg \
  ttf-fira-code \
  ttf-font-awesome \
  waybar \
  wl-clipboard \
  wofi-emoji \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  xwayland-satellite \
  ydotool
```

This lets us adjust screen brightness by scrolling on item in waybar.

```bash
sudo usermod -a -G video $LOGNAME
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

# I use nano for terminal editing
wget https://raw.githubusercontent.com/RangerMauve/nanorc/refs/heads/master/.nanorc
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

## MDNS

For some reason Arch Linux people don't value `.local` domains being resolvable out of the box so it's always a massive pain figuring out what to do.
Luckily for EndevourOS it just requires some minor tinkering.

```bash
yay -S nss-mdns avahi
sudo systemctl enable avahi-dnsconfd.service 
sudo systemctl start avahi-dnsconfd.service 
sudo firewall-cmd --permanent --add-service=mdns
sudo firewall-cmd --reload
```

## Applications

Here's a bunch of stuff I regularly use via the standard package manager.

```bash
yay -S \
  betterbird-bin \
  gapless \
  gearlever \
  go \
  keysmith \
  nvm \
  rustup \
  vscodium-bin
```

Once I install `gearlever` I usually install the latest release of [Agregore](https://github.com/AgregoreWeb/agregore-browser/releases) via my package manager.

I've also got my setttings for VSCodium in `vscodium-settings.json`. I use the `Purple Void` theme.

## LLMs

I use [ollama](https://ollama.com) for local LLMs so I usually install it from their install script:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

For GPU acceleration I have AMD ROCm libraries installed:

```bash
yay -S rocm-hip-sdk rocm-opencl-sdk
```

I also found I needed to edit `/etc/systemd/system/ollama.service` to add an extra environment variable to force a ROCm version.

```bash
Environment="HSA_OVERRIDE_GFX_VERSION=11.0.0"
```

I sometimes use this in tandem with the [continue.dev](https://www.continue.dev/) extension in VSCodium as it's an offline and open source alternative to copilot.

Usually I use [Hermes3:8b](https://nousresearch.com/hermes3/) since it's decent all around.

# Music

I use gapless for music playback, and generally I keep an offline copy of my SoundCloud likes using this script:

```bash
 scdl -l https://soundcloud.com/user890794315 -f -c --download-archive progress 
```

## Voice Control

I use [nerd-dictation](https://github.com/ideasman42/nerd-dictation) for speech to text so I can type messages and sometimes even do programming without needing to type.

First I set up my customizations:

```bash
mkdir ~/.config/nerd-dictation
z ~/.config/nerd-dictation
git clone git@github.com:RangerMauve/mauve-dictation.git .
```

Then I download and extract the recognition model.
I use the [vosk-model-small-en-us](https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip) model to conserve battery, and it ends up being good enough.
After downloading the model I extract it to the nerd-dictation folder.

After that you can toggle nerd-dictation with either `SUPER+ENTER` or with the `toggle-nerd.sh` command.

If you're having issues being able to "create a virtual keyboard device", you'll need to add yourself to the `input` group and reboot.

```bash
sudo usermod -a -G input $USER
reboot
```