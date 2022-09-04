export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export PATH=$PATH:$CUDA_HOME/bin
export PATH=$HOME/bin:~/.local/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH
export LANG="en_US.UTF-8"
export TERM=screen-256color
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export WIN="/mnt/c/Users/Aidan"

# WSL2 patch - Go to linux home instead of windows home
[[ $SHLVL -eq 1 ]] && cd ~/

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
setopt notify
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

#-------------------------------------
# Begin ZPLUG config 
#-------------------------------------

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "unixorn/fzf-zsh-plugin"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "unixorn/fzf-zsh-plugin"
zplug "plugins/pip", from:oh-my-zsh
zplug "z-shell/fast-syntax-highlighting"
zplug "bckim92/zsh-autoswitch-conda"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "ael-code/zsh-colored-man-pages"
zplug "zshzoo/cd-ls"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load

#----------------------------------
# End Zplug config
#----------------------------------

# FZF mappings and options
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse-list --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'"

# Aliases
alias reload="exec zsh"
alias bat="batcat"
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



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("${HOME}/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env
