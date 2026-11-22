if [[ -d "$HOME/Android/flutter/bin" ]]; then
    path+=("$HOME/Android/flutter/bin")
fi

# Run scripts/setup-zsh --workstation once to install these checkouts.
if [[ -r "$HOME/.dotfiles/zsh_plugins/znap/znap.zsh" ]]; then
    source "$HOME/.dotfiles/zsh_plugins/znap/znap.zsh"
    ZVM_INIT_MODE=sourcing
    for workstation_plugin in ${(f)"$(<"$HOME/.dotfiles/profiles/workstation-plugins")"}; do
        if [[ -d "$HOME/.dotfiles/zsh_plugins/$workstation_plugin/.git" ]]; then
            znap source "${workstation_plugin:t}"
        fi
    done
    unset workstation_plugin
fi

if (( $+commands[fzf] )); then
    if [[ -r /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh ]]; then
        source /usr/share/zsh/plugins/zsh-fzf-plugin/fzf.plugin.zsh
    elif [[ $(fzf --help) == *--zsh* ]]; then
        source <(fzf --zsh)
    fi
fi

if [[ -z ${TMUX:-} && -t 0 && -t 1 ]] && (( $+commands[tmux] )); then
    tmux new-session -A -s default
fi
