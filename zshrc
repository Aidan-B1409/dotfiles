typeset -U path fpath
# Drop the alternate spelling inherited from older shells.
path=("$HOME/.local/bin" "${(@)path:#$HOME/.local/share/../bin}")
export BALENARC_BALENA_URL="compostsense.com"

# setup-zsh generates pipx completions here when argcomplete is installed.
if [[ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions" ]]; then
    fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions" "${fpath[@]}")
fi
autoload -Uz compinit && compinit

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_IGNORE_DUPS
unsetopt BEEP

if (( $+commands[lsd] )); then
    alias ls=lsd
    alias lt='lsd --tree --depth 3'
fi
(( $+commands[nvim] )) && alias nv=nvim
(( $+commands[btm] )) && alias top=btm
(( $+commands[rsync] )) && alias transfer='rsync -r --info=progress2'

if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    (( $+functions[z] )) && alias cd=z
fi
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

if [[ -r "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
