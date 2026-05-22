# System Architecture

## Overview

```text
                 dotfiles repository (source of truth)
  ┌──────────────────────────────────────────────────────────────┐
  │ nvim/  bash/  git/  kitty/  ghostty/  psql/  vim/              │
  │ windows-terminal/  .claude/                                    │
  └──────────────────────────────────────────────────────────────┘
            │                          │
   bootstrap.sh (POSIX)        bootstrap.ps1 (Windows)
            │                          │
   ┌────────┴─────────┐        ┌────────┴─────────┐
   │ symlink  │ copy  │        │ symlink │ profile │
   ▼          ▼       ▼        ▼         ▼         ▼
 ~/.config/  ~/.bash_aliases  ~/.config/  $PROFILE function
 nvim.iferdel.git  ~/.psqlrc  (analogous)
 ~/.gitconfig
 ~/.config/{kitty,ghostty}
            │
   ~/bin/nvimf wrapper  ──► launches Neovim with NVIM_APPNAME

   go.sh (optional, separate) ──► installs goose, sqlc
```

## Modules

### Configuration trees (`nvim/`, `kitty/`, `ghostty/`, `git/`)

Directories and files that are symlinked wholesale into their destination. Editing them in the repo edits the live config. `nvim/` is the largest: a Lua tree with its own internal structure (entry point, plugin specs, filetype settings, custom plugins) described in `15_implementation_notes.md`.

### Tool-owned copies (`bash/aliases.sh`, `psql/.psqlrc`)

Files copied — not linked — into the home directory because the destination is treated as tool-managed. `bash/aliases.sh` becomes `~/.bash_aliases`; `psql/.psqlrc` becomes `~/.psqlrc`. The copy is conditional: it runs only when source and destination differ.

### Bootstrap scripts (`bootstrap.sh`, `bootstrap.ps1`)

The two installers. They perform the same logical steps — symlink configs, copy tool-owned files, wire shell rc, generate the `nvimf` wrapper, set Git's editor — using platform-appropriate primitives. They must be kept at feature parity.

### Portable fallback (`vim/`)

A standalone `.vimrc` with no plugin or runtime dependency, plus a `Dockerfile` to test it in isolation. Not touched by the bootstrap scripts; carried manually to foreign hosts.

### Auxiliary tooling (`go.sh`, `.claude/`, `claude/context-project-generator/`)

`go.sh` is an optional, independent installer for Go database tooling (goose, sqlc). `.claude/` holds Claude Code settings, commands, and workflows. `claude/context-project-generator/` is the scaffolder that produced this very `docs/context/` folder.

## Data flow

```text
1. User clones the repo and runs bootstrap.sh (or bootstrap.ps1) from inside it.
2. The script resolves DOTFILES_DIR to the current directory.
3. For each (source, destination) symlink pair: if the destination is absent,
   create the symlink; otherwise print a warning and skip.
4. For each tool-owned file: if destination is missing or differs from source,
   copy it; otherwise report it up to date.
5. Append a "source ~/.bash_aliases" line to the platform shell rc
   (.bashrc / .zshrc / $PROFILE) if that line is not already present.
6. Generate the ~/bin/nvimf wrapper (POSIX) or an nvimf profile function
   (Windows); ensure ~/bin is on PATH.
7. Set Git core.editor to the nvimf wrapper.
8. Each step reports linked / copied / skipped; the run ends without
   touching anything it found already in place.
```

## Trust boundary

The repository contents are trusted: they are the user's own configuration under version control, reviewed through normal Git history. The bootstrap script trusts that it is run from inside the repo (it derives `DOTFILES_DIR` from the working directory) and that the user invokes it deliberately.

The script does *not* trust the destination machine to be empty. Every write is guarded by an existence check, and an already-present destination is treated as authoritative — the script yields to it rather than overwriting. This is the core verification point: the boundary between "what the repo wants to install" and "what the machine already has" is enforced once, at write time, by the skip-if-exists rule. There is no privileged execution and no network trust surface beyond the optional `go.sh`, which downloads Go tooling from upstream module hosts.
