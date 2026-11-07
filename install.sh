#!/bin/bash
set -e
set -x

sudo pacman -Syu --noconfirm

# install yay if not already installed
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git
  _yay_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$_yay_dir"
  (cd "$_yay_dir" && makepkg -si --noconfirm)
  rm -rf "$_yay_dir"
fi

# font
yay -S --needed maplemono-nf

yay -S --needed bibata-cursor-theme-bin
sudo pacman -S --needed zsh bat cmake wireplumber file-roller lxappearance hyprpicker hyprland-guiutils nwg-look brightnessctl arc-gtk-theme adapta-gtk-theme breeze-gtk adwaita-icon-theme arc-icon-theme ristretto pavucontrol zathura zathura-pdf-poppler nwg-hello
yay -S --needed materia-gtk-theme spicetify-cli breaktimer-bin cava kora-icon-theme converseen batsignal gnome-calculator

# Thunar and plugins
sudo pacman -S --needed thunar thunar-archive-plugin thunar-volman gvfs gvfs-mtp
yay -S --needed thunar-megasync-bin

# Disk analyzer
sudo pacman -S --needed baobab

# yazi
sudo pacman -S --needed yazi 7zip fzf

# kde-connect
sudo pacman -S --needed kdeconnect

# notification daemon
sudo pacman -S --needed swaync

# clipboard
sudo pacman -S --needed cliphist

# authentication agent
sudo pacman -S --needed hyprpolkitagent

# hyprland plugins and packages
sudo pacman -S --needed cpio meson awww waybar hypridle tuned
yay -S --needed hyprshot hyprlock wlogout python-pywal16 waypaper hyprsunset

# OCR
sudo pacman -S --needed tesseract tesseract-data-eng

# Players
sudo pacman -S --needed mpv
yay -S --needed strawberry

# nvim & dev
sudo pacman -S --needed neovim ripgrep lazygit btop npm nodejs webkit2gtk fnm
# sudo setcap cap_perfmon=+ep /usr/bin/btop
if command -v fnm &>/dev/null; then
  fnm install 22 || true
  fnm default 22 || true
fi

# USB automount
sudo pacman -S --needed udiskie

# Docker
sudo pacman -S --needed docker docker-compose docker-buildx
yay -S --needed lazydocker

# Postgresql
sudo pacman -S --needed postgresql
yay -S --needed pgadmin4

# Zram
sudo pacman -S --needed zram-generator
if [ ! -f /etc/systemd/zram-generator.conf ]; then
  sudo tee /etc/systemd/zram-generator.conf >/dev/null <<EOF
[zram0]
zram-size = ram / 4
EOF
  sudo systemctl daemon-reload
  sudo systemctl start /dev/zram0
fi

# deno
if ! command -v deno &>/dev/null; then
  curl -fsSL https://deno.land/install.sh | sh
fi

# enable hyprpm plugins
hyprpm update || true
hyprpm add https://github.com/hyprwm/hyprland-plugins 2>/dev/null || true
hyprpm enable hyprexpo || true

hyprpm add https://github.com/KZDKM/Hyprspace 2>/dev/null || true
hyprpm enable Hyprspace || true

# zsh & oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""
fi

clone_if_missing() {
  local repo="$1"
  local dest="$2"
  if [ ! -d "$dest" ]; then
    git clone --depth=1 "$repo" "$dest"
  fi
}

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$ZSH_CUSTOM/plugins/autoupdate"
clone_if_missing https://github.com/hlissner/zsh-autopair "$ZSH_CUSTOM/plugins/zsh-autopair"
clone_if_missing https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
clone_if_missing https://github.com/romkatv/zsh-defer "$HOME/.zsh/zsh-defer"

# set Symlinks
mkdir -p ~/.config/zathura ~/.config/btop/themes
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/zathurarc
ln -sf ~/.cache/wal/colors-btop.theme ~/.config/btop/themes/colors-btop.theme

# laptop packages
sudo pacman -S --needed alsa-utils sof-firmware arandr tlp tlp-rdw tlp-pd
yay -S --needed nwg-displays tlpui
yay -S --needed linux-wifi-hotspot

# Latex
sudo pacman -S --needed texlive-latex texstudio texlive-latexextra

# React native
sudo pacman -S --needed jdk17-openjdk
yay -S --needed android-studio

# Openvino
yay -S --needed openvino openvino-intel-npu-plugin openvino-intel-gpu-plugin

# NPU
yay -S --needed intel-npu-driver intel-npu-compiler

# Proton vpn with networkmanager
yay -S --needed wireguard-tools
if [ -f "$HOME/Downloads/wg-JP-FREE-30.conf" ]; then
  sudo nmcli connection import type wireguard file "$HOME/Downloads/wg-JP-FREE-30.conf" || true
else
  echo "Wireguard config ~/Downloads/wg-JP-FREE-30.conf not found, skipping nmcli import."
fi

# OBS
sudo pacman -S --needed obs-studio
yay -S --needed vpl-gpu-rt

# Formatting
sudo pacman -S --needed exfatprogs

# Gaming
# Enable multilib in /etc/pacman.conf
sudo pacman -S --needed wine wine-mono winetricks
yay -S --needed gamemode lib32-gamemode
yay -S --needed mangohud lib32-mangohud

# Audio & Tools
sudo pacman -S --needed easyeffects dotnet-runtime dotnet-sdk video-trimmer
yay -S --needed python-autoeq

# Developer tools
yay -S --needed antigravity-cli cursor-bin openai-codex-bin antigravity-ide
