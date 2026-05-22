# Scope

## Objective

Maintain a single repository that installs and version-controls the owner's terminal environment — editor, shell, Git, terminal emulators, database client — on macOS, Linux, WSL2, and native Windows, through one idempotent bootstrap run per machine.

## Must implement

### Installation

- A `bootstrap.sh` that symlinks the config trees, copies tool-owned files, wires the shell rc, generates the `nvimf` wrapper, and sets Git's editor — skipping any destination that already exists.
- A `bootstrap.ps1` at feature parity, using Windows-native primitives.
- Platform detection (macOS / Linux / WSL2) selecting the correct shell rc.

### Configuration

- A complete Neovim configuration under an isolated `NVIM_APPNAME` namespace, with a committed plugin lock.
- Bash aliases and completions, Git config, Kitty and Ghostty configs, and a `psql` config.
- A dependency-free portable `vim/.vimrc` for foreign hosts.

### Safety

- No write touches a pre-existing destination.
- No secret or runtime-written file is tracked.

## Should include

- Windows Terminal settings.
- A publication checklist and data-handling guidance so the repo can be made public safely.
- This `docs/context/` design-context folder.
- `.claude/` tooling — settings, commands, workflows — and the context-project generator.

## Explicitly out of scope

- Installing the underlying tools (Neovim, Kitty, `delta`, Go) — only `delta` is named as a manual dependency and `go.sh` is an opt-in extra.
- Updating or merging pre-existing configuration on a machine.
- Uninstall / rollback.
- Multi-user, multi-profile, or templated configuration.
- `tmux` — deliberately omitted; Neovim covers the need.
- Pinning OS-level tool versions (only the Neovim plugin set is locked).

## Success criteria

1. Running `bootstrap.sh` on a fresh macOS / Linux / WSL2 machine yields a working environment in one pass with no manual file editing.
2. Running it a second time changes nothing and reports every step as skipped or up to date.
3. Running it on a machine with pre-existing configs leaves every pre-existing file untouched.
4. `bootstrap.ps1` produces an equivalent result on native Windows.
5. The custom Neovim config launches via `nvimf` without colliding with any system Neovim.
6. The repository passes `13_publication_checklist.md` — no secrets, no host-identifying data.
