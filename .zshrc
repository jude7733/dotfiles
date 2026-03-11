source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh
if [[ ":$FPATH:" != *":/home/jude/.zsh/completions:"* ]]; then export FPATH="/home/jude/.zsh/completions:$FPATH"; fi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export GODEBUG=cgocheck=0
#ENV
export BROWSER="zen-browser"
export EDITOR="nvim"
export VISUAL="nvim"

cdpath=(
.
$HOME
$HOME/.config
$HOME/coding
$HOME/learning
)

export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/28.1.13356709"
export JAVA_HOME="/opt/android-studio/jbr"

path+=(
$ANDROID_HOME/emulator
$ANDROID_HOME/platform-tools
)

export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export IPEX_LLM_NPU_MTL=1
export ZSH_THEME_RANDOM_QUIET=true
export DISABLE_MAGIC_FUNCTIONS=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="random"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git sudo vi-mode archlinux)
# unused plugins: gh command-not-found npm pip python uv rust

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
source $ZSH/oh-my-zsh.sh

zsh-defer source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
zsh-defer source $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
zsh-defer source $ZSH/plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
zsh-defer source $ZSH/plugins/web-search/web-search.plugin.zsh

# User configuration

#Fastfetch
# if [[ $(tty) == *"pts"* ]]; then
#     fastfetch
# else
#     echo
#     if [ -f /bin/hyprctl ]; then
#         echo "Start Hyprland with command Hyprland"
#     fi
# fi

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
  else
   export EDITOR='nvim'
 fi

# For a full list of active aliases, run `alias`.
alias v="kitty @ set-spacing padding=0; nvim"
alias :q="exit"
alias clean='sudo pacman -Rns $(pacman -Qdtq) && pnpm store prune'
alias cavabg='kitty -c ~/.config/kitty/kittybg.conf --detach --class='kitty-bg' ~/.config/hypr/scripts/cava.sh'
alias findphone="echo 'Private IP address:' $(ip addr show $(ip route | awk '/default/ {print $5}') | awk '/inet / {print $2}' | cut -d/ -f1)"
alias watchclear="watchman watch-del-all && watchman shutdown-server"
alias refresh="sudo reflector --verbose --sort rate -l 100 --save /etc/pacman.d/mirrorlist"
alias pachist="grep -i installed /var/log/pacman.log | tail -n 15"
alias weather="curl wttr.in/Kochi"
alias rstudio="rstudio --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias killport='f() { lsof -ti :$1 | xargs kill; }; f'

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# . "/home/jude/.deno/env"
# # Initialize zsh completions (added by deno install script)

# pnpm
export PNPM_HOME="/home/jude/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/jude/.lmstudio/bin"
# End of LM Studio CLI section

zsh-defer eval "$(zoxide init zsh)"
