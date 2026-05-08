# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# System Variables
export PATH="$PATH:/home/theta/.local/bin"
export PATH="$PATH:/home/theta/Android/flutter/bin"
export FZF_BASE=/usr/share/fzf
export HISTFILE=/home/theta/.zsh_history
# export FZF_PATH="/bin/usr/fzf"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Enable completions
autoload -U compinit && compinit

# pipx completions
eval "$(register-python-argcomplete pipx)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth

setopt append_history
setopt share_history

# Don't add certain commands to the history file.
# export HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND":x


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# ZSH Options
unsetopt beep

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Aliases

alias ls=lsd
# alias l = ls -l
alias nv=nvim
alias lt='ls --tree --depth 3'
alias cp="rsync -a --info=progress2"
alias transfer="rsync -r --info=progress2"
alias cd=z
alias top=bt
alias grep=rg

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Plugins

# Enable zoxide 
eval "$(zoxide init zsh)"

# Enable starship
eval "$(starship init zsh)"

# Enable fzf
# source <(fzf --zsh)
# source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Enable znap plugin manager
# Download Znap, if it's not there yet.
[[ -r ~/.dotfiles/zsh_plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.dotfiles/zsh_plugins/znap
source ~/.dotfiles/zsh_plugins/znap/znap.zsh  # Start Znap

znap source zshzoo/cd-ls 
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting
ZVM_INIT_MODE=sourcing
znap source jeffreytse/zsh-vi-mode
znap source zsh-users/zsh-history-substring-search

source /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Tmux
if [[ -z "$TMUX" ]] then
    tmux attach-session -t default || tmux new-session -s default
fi


fastfetch --logo arch

. "$HOME/.local/share/../bin/env"
