# Project Summary

## One-line summary

A personal dotfiles repository that installs Neovim, Bash, Git, Kitty, Ghostty, and PostgreSQL client configuration onto a new machine through a single idempotent bootstrap script.

## Core concept

The narrow primitive this project explores is: *how do you move a fully-formed terminal environment onto an unfamiliar machine without editing files in place, and without clobbering whatever is already there?*

The answer is a flat repository of plain configuration files plus a bootstrap script that links — rather than copies — most of them into their expected home locations. Neovim, Kitty, Ghostty, and Git config are symlinked, so editing a file in the repo is the same as editing the live config; a `git pull` updates the environment with no reinstall step. The two files that tools rewrite at runtime (`~/.bash_aliases`, `~/.psqlrc`) are copied instead, so the repo stays clean. The bootstrap script refuses to overwrite anything that already exists, which makes a re-run safe and a partial install resumable.

A deliberate second axis is *namespace isolation*: the Neovim config runs under `NVIM_APPNAME=nvim.iferdel.git`, invoked through a generated `nvimf` wrapper, so it coexists with any system Neovim setup instead of replacing it.

The honest claim: re-running `bootstrap.sh` on a machine that is already set up is a safe no-op, and a fresh machine reaches a working environment in one pass with no manual file editing.

## What the system can help do

- Stand up a known-good terminal environment on a new macOS, Linux, or WSL2 machine in one command.
- Keep an already-configured machine current — edit-in-repo plus `git pull` is the whole update loop for symlinked tools.
- Carry a minimal, dependency-free editor (`vim/.vimrc`) onto SSH or foreign servers where the full Neovim setup is not wanted.
- Mirror the same setup onto native Windows through a parity-maintained PowerShell script.

## What the system does not promise

- It does not install the underlying tools (Neovim, Kitty, `delta`, Go toolchain) — only their configuration.
- It does not update or remove configuration that already exists at a destination; existing files are skipped, not merged.
- It does not uninstall or roll back; removing the environment is manual.
- It does not pin tool versions — only the Neovim plugin set is locked (`nvim/lazy-lock.json`).
- It is not multi-user or multi-profile; it encodes one person's preferences.

## Intended use

The primary reader is the repository owner, setting up or refreshing a personal machine. Consumption is ad-hoc: run once on a new machine, then effectively never again — ongoing updates happen through `git pull` against the symlinked configs. The PowerShell path serves the same person on a corporate Windows host.

A secondary reader is anyone browsing the repository for configuration ideas. For them the output is reference material: the Neovim Lua tree, the Git aliases, the `psql` prompt. They are expected to copy selectively, not to run the bootstrap script.

## Non-goals

- Not a general-purpose, parameterized dotfiles *framework* (no profiles, no templating engine).
- Not a tool installer or package manager.
- Not a backup or sync service for machine state beyond these config files.
- Not a teaching resource, though it is readable enough to borrow from.
