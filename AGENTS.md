# Installation profiles

Run `./install hpc` (the default) or `./install workstation` from a plain clone. Both load `install.conf.yaml` first. Keep shared links there and role-specific tasks in `install.hpc.conf.yaml` or `install.workstation.conf.yaml`. The workstation install fetches the Neovim submodule, links Neovim and Kitty, and installs the workstation Zsh plugins.

## Zsh configuration

- Put defaults for every interactive shell in `zshrc`. Dotbot links `~/.zshrc` to this file. Its final step sources `~/.zshrc.local` if readable.
- Put settings shared by a group of machines in `profiles/`. For example, `profiles/workstation.zsh` handles Flutter, Znap plugins, fzf, and tmux for the laptop and desktop.
- Use `~/.zshrc.local` for host-specific settings and profile selection. On a workstation, add `source "$HOME/.dotfiles/profiles/workstation.zsh"` to that file. On the HPC, it can contain cluster-specific settings or be absent to use only the shared defaults.
