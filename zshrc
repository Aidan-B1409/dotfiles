export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export PATH=$PATH:$CUDA_HOME/bin
export PATH=$HOME/bin:~/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH
export LANG="en_US.UTF-8"
export TERM=screen-256color
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WIN="/mnt/c/Users/Aidan"
export ZLE_RPROMPT_INDENT=0


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/theta/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/theta/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/theta/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/theta/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
[ -x "$(command -v tmux)" ] \
    && [ -z "${TMUX}" ] \
    && { tmux attach || tmux; } >/dev/null 2>&1


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt notify
setopt share_history
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#Keybinds

alias ls="lsd"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

eval "$(sheldon source)"

# FZF mappings and options
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse-list --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'"

# Aliases
alias reload="exec zsh"
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias nv='nvim'
alias lt='ls --tree --depth 3'
alias lctree="colorls  --tree --sd"
alias emacs="emacs -nw"
alias yeet="rm -rf"
alias transfer="rsync -r --info=progress2"
alias pip="pip3"
alias ml="locate"
alias e="emacsclient -a ''"
alias mkrepo="~/.scripts/ritual.sh"
alias zshconfig="nv ~/.zshrc"
alias gc="git commit -am"
alias cp="rsync -a --info=progress2"
alias cat="bat -pp"
alias e="emacsclient -a ''"
alias vpn="sudo openvpn --config /etc/openvpn/ca_vancouver.ovpn --daemon"
alias vpndc="sudo killall openvpn"
alias htop="btm -b"
alias du="dust"
# -- Robert's Git Aliases
alias gs='git status'
alias gco='git checkout'
alias gck='git checkout'
alias gc='git commit'
alias gp='git push'
alias gup='git pull'
alias gpu='git pull'
alias gpl='git pull'
function gfp () { # git fetch / prune -- deletes branches deleted upstream
    git fetch -p
    git branch --v | grep -q "\[gone\]" && git branch --v | grep "\[gone\]" | cut -d' ' -f3 | xargs git branch -D
}
alias gfpl='gfp; gpl'
alias ga='git add'
alias gaa='git add -A'
function gac () { # add commit message if given, otherwise prompt
    gaa
    if [ $# -gt 0 ]; then
        gc -m "$*"
    else
        gc
    fi
}
function gacp () { # add commit message if given, otherwise prompt
    gaa
    if [ $# -gt 0 ]; then
        gc -m "$*"
    else
        gc
    fi
    gp
}
function gcl () {
        # clone git directory and cd into it
        # credit: https://stackoverflow.com/a/44361555
        git clone $* && cd "$(ls -t | head -1)"
}
alias master='git checkout master'


autoload zmv
