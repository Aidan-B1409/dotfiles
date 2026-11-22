typeset -U path fpath
# Drop the alternate spelling inherited from older shells.
path=("$HOME/.local/bin" "${(@)path:#$HOME/.local/share/../bin}")
export BALENARC_BALENA_URL="compostsense.com"

# Some desktop terminals start a regular interactive shell even at first login.
() {
    local session_dir=''
    if [[ -n ${XDG_SESSION_ID:-} && -d ${XDG_RUNTIME_DIR:-} ]]; then
        session_dir="$XDG_RUNTIME_DIR/dotfiles-pull-$XDG_SESSION_ID"
        [[ -d $session_dir ]] && return
        # Claim this login before checking Git so concurrent shells warn only once.
        mkdir -m 700 -- "$session_dir" 2>/dev/null || return
    elif [[ ! -o login || -n ${TMUX:-} ]]; then
        return
    fi

    if [[ -n $(git --no-optional-locks -C "$HOME/.dotfiles" status --porcelain --untracked-files=normal --ignore-submodules=none 2>/dev/null) ]]; then
        typeset -g _dotfiles_login_warning='Dotfiles have uncommitted changes. Run: git -C ~/.dotfiles status --short'
    fi

    (
        if [[ -n $session_dir ]]; then
            exec >"$session_dir/pull.log" 2>&1
        fi
        builtin cd -q -- "$HOME/.dotfiles" || exit 1
        git rev-parse --verify --quiet '@{upstream}' >/dev/null || exit 0
        export GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND='ssh -o BatchMode=yes -o ConnectTimeout=10'
        flock -n . git pull --ff-only --no-autostash --no-recurse-submodules
    ) </dev/null >/dev/null 2>&1 &!
}

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

if [[ -n ${_dotfiles_login_warning:-} ]]; then
    print -ru2 -- "$_dotfiles_login_warning"
    unset _dotfiles_login_warning
fi
