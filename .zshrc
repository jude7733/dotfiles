# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/jude/.zsh/completions:"* ]]; then export FPATH="/home/jude/.zsh/completions:$FPATH"; fi
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export GODEBUG=cgocheck=0
#ENV
export BROWSER="firefox"
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

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
precmd() {print ""}

ZSH_THEME="random"

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/file

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git gh zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode zsh-autopair autoupdate sudo command-not-found git-auto-fetch web-search npm yarn archlinux pip python rust)

source $ZSH/oh-my-zsh.sh

# User configuration

#Fastfetch
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
else
    echo
    if [ -f /bin/hyprctl ]; then
        echo "Start Hyprland with command Hyprland"
    fi
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias v="kitty @ set-spacing padding=0 && nvim"
alias nvim="kitty @ set-spacing padding=0 && nvim"
alias :q="exit"
alias clean='sudo pacman -Rns $(pacman -Qdtq)'
alias cavabg='kitty -c ~/.config/kitty/kittybg.conf --detach --class='kitty-bg' ~/.config/hypr/scripts/cava.sh'
alias findphone="echo 'Private IP address:' $(ip addr show $(ip route | awk '/default/ {print $5}') | awk '/inet / {print $2}' | cut -d/ -f1)"
alias watchclear="watchman watch-del-all && watchman shutdown-server"
alias refresh="sudo reflector --verbose --sort rate -l 100 --save /etc/pacman.d/mirrorlist"

# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. "/home/jude/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jude/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jude/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jude/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jude/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# pnpm
export PNPM_HOME="/home/jude/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jude/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jude/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jude/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jude/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
