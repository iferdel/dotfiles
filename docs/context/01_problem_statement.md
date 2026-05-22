# Problem Statement

## Problem

A working terminal environment is an accumulation of dozens of small decisions — an editor config, shell aliases, a Git setup, a terminal-emulator theme, a database-client prompt. On a single machine these decisions are invisible because they already exist. The problem appears the moment there is a *second* machine: a new laptop, a reinstalled OS, a corporate Windows host, a WSL2 instance. Reproducing the environment by hand is slow, error-prone, and drifts — the second machine ends up subtly different from the first, and neither is authoritative.

The standard fix is to keep the config files in a Git repository. That solves *storage* and *history* but not *installation*: the files still have to land at the specific paths each tool expects (`~/.config/nvim`, `~/.gitconfig`, `~/.psqlrc`, and so on), and they have to do so without destroying whatever the machine already had.

This repository is one person's environment treated as that problem: a flat tree of config files plus a bootstrap script that places them.

## Why a naive approach is not enough

- **Copy the files in.** Copies go stale immediately — every later edit has to be copied again, and there is no single source of truth. Editing the live file and editing the repo diverge silently.
- **Symlink everything unconditionally.** Some files are rewritten by the tools themselves (`~/.psqlrc` is fine to link, but `~/.bash_aliases` is copied because the home file is treated as a derived artifact, and a shell-managed file should not be a repo symlink). A blanket symlink also overwrites whatever already exists, destroying a machine's prior setup with no warning.
- **One script per OS, written independently.** macOS/Linux/WSL2 and native Windows genuinely need different mechanics (`ln -s` vs `New-Item -SymbolicLink`, `$HOME` vs `$env:USERPROFILE`, `.bashrc`/`.zshrc` vs `$PROFILE`). Letting the two scripts evolve independently guarantees they drift out of feature parity.
- **Assume a clean machine.** A new machine is rarely truly clean — there is often a stock shell config, a default Git identity, a system Neovim. The installer must coexist with those, not assume their absence.

## Design challenge

1. **Single source of truth vs. tool-managed files** — most configs should be live-linked, but files a tool rewrites at runtime must be copied.
2. **Idempotence vs. updating** — a re-run must be safe, which means it skips existing destinations, which means it also cannot push updates to them. Update is `git pull`, not re-bootstrap.
3. **Coexistence vs. ownership** — the setup must install alongside a machine's existing environment (system Neovim, stock shell rc) rather than overwriting it.
4. **Cross-platform parity vs. platform-honest mechanics** — `bootstrap.sh` and `bootstrap.ps1` must deliver the same outcome while using genuinely different primitives.
5. **Full environment vs. portable minimum** — the rich Neovim config is unwanted on a throwaway SSH session; a dependency-free `.vimrc` has to exist for that case.

## Central claim

Given the tools already installed, one run of the bootstrap script brings a machine to a working, version-controlled terminal environment without editing any file in place and without overwriting anything that already exists; and because every destination is created only when absent, a second run is a safe no-op and a partial run is resumable. The claim holds even if individual steps are skipped — each symlink, copy, and shell-rc edit is independent, so a skipped or failed step leaves the rest of the install valid.
