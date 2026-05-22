# Scenarios

All scenarios use synthetic identifiers and placeholder paths.

## Scenario A: Fresh Linux machine

1. Install the prerequisite tools (`nvim`, `kitty` or `ghostty`, `git-delta`).
2. Clone the repository: `git clone <repo-url> ~/dotfiles && cd ~/dotfiles`.
3. Run `./bootstrap.sh`.
4. The script symlinks `nvim/`, `git/.gitconfig`, `kitty/`, `ghostty/` into place; copies `aliases.sh` → `~/.bash_aliases` and `.psqlrc` → `~/.psqlrc`; appends the source line to `~/.bashrc`; generates `~/bin/nvimf`; sets Git's editor.
5. Open a new shell, run `nvimf` — Neovim launches under `NVIM_APPNAME=nvim.iferdel.git` and lazy.nvim installs the locked plugin set.

Expected artifact: a working environment; every install step reported as "linked" or "copied".

## Scenario B: Re-running on an already-configured machine

1. From inside the existing clone, run `./bootstrap.sh` again.
2. Every symlink destination already exists — each pair prints a "destination already exists, skipping" warning.
3. The tool-owned files match their sources — each reports "already up to date".
4. The shell-rc source line is found — the append is skipped.

Expected artifact: zero changes to the machine; a run log of skips and "up to date" messages.

## Scenario C: Native Windows machine

1. Open PowerShell as Administrator (or with Developer Mode enabled, for symlink permission).
2. Clone the repository and `cd` into it.
3. Run `.\bootstrap.ps1`.
4. The script creates the symlinks with `New-Item -ItemType SymbolicLink`, targets `$PROFILE` for shell wiring, and adds an `nvimf` function to the profile.
5. Open a new PowerShell session and run `nvimf`.

Expected artifact: an environment equivalent to Scenario A, installed through Windows-native primitives.

## Scenario D: Editing config after install (the happy update loop)

1. On any configured machine, edit a file in the repo — e.g. add a keymap in `nvim/lua/config/plugins/telescope.lua`.
2. The change is live immediately, because `~/.config/nvim.iferdel.git` is a symlink into the repo.
3. Commit and push.
4. On a second machine, `git pull` inside the clone — the symlinked config is now current with no reinstall.

Expected artifact: a propagated config change with no bootstrap re-run for symlinked tools.

## Scenario E: Portable editor on a foreign SSH host

1. SSH into a server where the full Neovim setup is unwanted.
2. Copy `vim/.vimrc` to `~/.vimrc` on that host (or paste its contents).
3. Launch stock `vim` — it picks up the dependency-free config with no plugins or runtime to install.

Expected artifact: a usable editor on a throwaway host without touching the bootstrap flow.

## Avoid in public demos

- Real machine hostnames, corporate usernames, or absolute `$HOME` paths — use `~` and `<repo>`.
- The real `[safe]` directory entries from `git/.gitconfig` (they embed Windows host paths).
- Any `~/.psql_history` content or database connection string.
- Output of a run on a real corporate machine; use a synthetic transcript instead.
