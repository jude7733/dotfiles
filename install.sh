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
yay -S ttf-maple

yay -S bibata-cursor-theme-bin
sudo pacman -S zsh cmake wireplumber xarchiver lxappearance hyprpicker nwg-look arc-gtk-theme adapta-gtk-theme breeze-gtk thunar adwaita-icon-theme arc-icon-theme ristretto pavucontrol zathura zathura-pdf-poppler nwg-hello
yay -S materia-gtk-theme spicetify-cli safeeyes cava 

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

# nvim
sudo pacman -S neovim ripgrep lazygit btop npm nodejs webkit2gtk
# deno
curl -fsSL https://deno.land/install.sh | sh

# enable packages
# sudo pacman -S hyprwayland-scanner
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm enable hyprexpo

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
sudo pacman -S alsa-utils sof-firmware arandr
yay -S nwg-displays 
