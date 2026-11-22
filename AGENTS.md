# Installation profiles

Run `./install hpc` (the default) or `./install workstation` from a plain clone. Both load `install.conf.yaml` first. Keep shared links there and role-specific tasks in `install.hpc.conf.yaml` or `install.workstation.conf.yaml`. The workstation install fetches the Neovim submodule, links Neovim and Kitty, and installs the workstation Zsh plugins.

## Zsh configuration

- Put defaults for every interactive shell in `zshrc`. Dotbot links `~/.zshrc` to this file. Its final step sources `~/.zshrc.local` if readable.
- Put settings shared by a group of machines in `profiles/`. For example, `profiles/workstation.zsh` handles Flutter, Znap plugins, fzf, and tmux for the laptop and desktop.
- Use `~/.zshrc.local` for host-specific settings and profile selection. On a workstation, add `source "$HOME/.dotfiles/profiles/workstation.zsh"` to that file. On the HPC, it can contain cluster-specific settings or be absent to use only the shared defaults.

## Codex configuration

Both install profiles link `codex/AGENTS.md` into Codex home (default `~/.codex`) for user-wide instructions. This repo's root `AGENTS.md` applies to the dotfiles checkout. Keep standalone skills and their companion files in `.agents/skills/<name>/`. Dotbot links each skill into `~/.agents/skills/`.

### Codex plugins

After Codex is available, run `scripts/sync-codex-plugins hpc` or `scripts/sync-codex-plugins workstation`. Add `--dry-run` to preview. Edit `codex/plugins.json` to change the common set, profile additions, or Git marketplace commit pins. The opaque workstation app ID is Todoist. Text-to-CAD requires its local marketplace to be provisioned by the CAD installer first.

Sync registers missing marketplaces, checks registered Git checkout revisions, and installs missing plugins. It reports disabled or extra installs and leaves those choices intact. Directory plugins use the version Codex offers. To adopt a different Git revision, update the pin and align the registered marketplace before syncing. Existing plugin versions stay in place during sync.

Use the Python Development plugin for Python code style and design patterns on both profiles. CAD skills come from Text-to-CAD on workstations. After changing skill providers, run Dotbot to clean stale skill links and refresh the user-managed skill inventory in `codex/skills.json`.
