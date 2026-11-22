# Zsh configuration

- Put defaults for every interactive shell in `zshrc`. Dotbot links `~/.zshrc` to this file. Its final step sources `~/.zshrc.local` if readable.
- Put settings shared by a group of machines in `profiles/`. For example, `profiles/workstation.zsh` handles Flutter, Znap plugins, fzf, and tmux for the laptop and desktop.
- Use `~/.zshrc.local` for host-specific settings and profile selection. On a workstation, add `source "$HOME/.dotfiles/profiles/workstation.zsh"` to that file. On the HPC, it can contain cluster-specific settings or be absent to use only the shared defaults.
