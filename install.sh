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
sudo pacman -S zsh bat cmake wireplumber xarchiver lxappearance hyprpicker nwg-look brightnessctl arc-gtk-theme adapta-gtk-theme breeze-gtk thunar adwaita-icon-theme arc-icon-theme ristretto pavucontrol zathura zathura-pdf-poppler nwg-hello
yay -S materia-gtk-theme spicetify-cli stretchly-bin cava kora-icon-theme

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
yay -S hyprshot hyprlock wlogout python-pywal16 waypaper hyprshade

# OCR
yay -S tesseract tesseract-data-eng

# nvim
sudo pacman -S neovim ripgrep lazygit btop npm nodejs webkit2gtk
# sudo setcap cap_perfmon=+ep /usr/bin/btop

# USB automount
sudo pacman -S udiskie

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
sudo pacman -S alsa-utils sof-firmware arandr tlp tlp-rdw
yay -S nwg-displays tlpui

#Latex
sudo pacman -S texlive-latex texstudio texlive-latexextra

#React native
sudo pacman -S jdk17-openjdk
yay -S android-studio

# Openvino
yay -S openvino openvino-intel-npu-plugin openvino-intel-gpu-plugin

# NPU
yay -S intel-npu-driver intel-npu-compiler
