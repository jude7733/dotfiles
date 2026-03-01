if [[ ":$FPATH:" != *":/home/jude/.zsh/completions:"* ]]; then export FPATH="/home/jude/.zsh/completions:$FPATH"; fi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export GODEBUG=cgocheck=0
#ENV
export BROWSER="zen-browser"
export EDITOR="nvim"
export VISUAL="nvim"
export CDPATH=".:$HOME:$HOME/.config/:$HOME/coding/:$HOME/learning/"
export ANDROID_HOME=$HOME/Android/Sdk
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export JAVA_HOME=/opt/android-studio/jbr
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export IPEX_LLM_NPU_MTL=1
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
export ZSH_THEME_RANDOM_QUIET=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
precmd() {print ""}

ZSH_THEME="random"

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git gh zsh-autosuggestions zsh-syntax-highlighting zsh-interactive-cd vi-mode sudo command-not-found git-auto-fetch npm archlinux pip python uv themes rust web-search)

source $ZSH/oh-my-zsh.sh

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
alias v="kitty @ set-spacing padding=0 && nvim"
alias nvim="kitty @ set-spacing padding=0 && nvim"
alias :q="exit"
alias clean='sudo pacman -Rns $(pacman -Qdtq) && pnpm store prune'
alias cavabg='kitty -c ~/.config/kitty/kittybg.conf --detach --class='kitty-bg' ~/.config/hypr/scripts/cava.sh'
alias findphone="echo 'Private IP address:' $(ip addr show $(ip route | awk '/default/ {print $5}') | awk '/inet / {print $2}' | cut -d/ -f1)"
alias watchclear="watchman watch-del-all && watchman shutdown-server"
alias refresh="sudo reflector --verbose --sort rate -l 100 --save /etc/pacman.d/mirrorlist"
alias pachist="grep -i installed /var/log/pacman.log | tail -n 15"
alias weather="curl wttr.in/Kochi"
alias docker="sudo docker"
alias rstudio="rstudio --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias killport='f() { lsof -ti :$1 | xargs kill; }; f'

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

. "/home/jude/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit


# pnpm
export PNPM_HOME="/home/jude/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jude/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jude/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/jude/.lmstudio/bin"
# End of LM Studio CLI section


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
