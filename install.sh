#!/bin/bash
set -e
set -x

sudo pacman -Syu

# install yay
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
rm -rf yay

# font
yay -S maplemono-nf

yay -S bibata-cursor-theme-bin
sudo pacman -S zsh bat cmake wireplumber file-roller lxappearance hyprpicker hyprland-guiutils nwg-look brightnessctl arc-gtk-theme adapta-gtk-theme breeze-gtk adwaita-icon-theme arc-icon-theme ristretto pavucontrol zathura zathura-pdf-poppler nwg-hello
yay -S materia-gtk-theme spicetify-cli breaktimer-bin cava kora-icon-theme converseen batsignal gnome-calculator

# Thunar and plugins
yay -S thunar thunar-archive-plugin thunar-volman thunar-megasync-bin

# Disk analyzer
yay -S baobab

# kde-connect
sudo pacman -S kdeconnect

# notification daemon
sudo pacman -S swaync

# clipboard
sudo pacman -S cliphist

# authentication agent
sudo pacman -S polkit-kde-agent

# hyprland plugins and packages
sudo pacman -S cpio meson swww waybar hypridle tuned
yay -S hyprshot hyprlock wlogout python-pywal16 waypaper hyprsunset

# OCR
yay -S tesseract tesseract-data-eng

# nvim
sudo pacman -S neovim ripgrep lazygit btop npm nodejs webkit2gtk
# sudo setcap cap_perfmon=+ep /usr/bin/btop

# USB automount
sudo pacman -S udiskie

# Docker
yay -S docker lazydocker docker-compose

# Postgesql
yay -S postgresql pgadmin4

# Zram
sudo pacman -S zram-generator
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<EOF
[zram0]
zram-size = ram / 4
EOF
sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo zramctl
sudo swapon --show

# deno
curl -fsSL https://deno.land/install.sh | sh

# enable packages
# sudo pacman -S hyprwayland-scanner
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo

hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# set Syslinks
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
ln -sf ~/.cache/wal/colors-btop.theme ~/.config/btop/themes/colors-btop.theme

# laptop packages
sudo pacman -S alsa-utils sof-firmware arandr tlp tlp-rdw tlp-pd
yay -S nwg-displays tlpui
yay -S linux-wifi-hotspot

# Latex
sudo pacman -S texlive-latex texstudio texlive-latexextra

# React native
sudo pacman -S jdk17-openjdk
yay -S android-studio

# Openvino
yay -S openvino openvino-intel-npu-plugin openvino-intel-gpu-plugin

# NPU
yay -S intel-npu-driver intel-npu-compiler

# Proton vpn with networkmanager
# go to https://account.protonvpn.com/downloads and download wireguard conf (edit allowed IP)
yay -S wireguard-tools
sudo nmcli connection import type wireguard file ~/Downloads/wg-JP-FREE-30.conf

# OBS
yay -S vpl-gpu-rt obs-studio

# Formatting
sudo pacman -S exfatprogs

# Gaming
# Enable multilib in /etc/pacman.conf
sudo pacman -S wine wine-mono winetricks
yay -S gamemode lib32-gamemode
yay -S mangohud lib32-mangohud

yay -S easyeffect python-autoeq
