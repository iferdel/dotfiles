# Glossary

## Bootstrap script

`bootstrap.sh` (POSIX) and `bootstrap.ps1` (Windows): the installers that place this repository's configuration onto a machine. One run per machine; safe to re-run.

## Copy pair

A source file copied — not symlinked — into the home directory because the destination is tool-owned. Refreshed only when content differs. The two are `bash/aliases.sh` and `psql/.psqlrc`.

## Dotfiles

Plain-text configuration files for command-line tools, conventionally named with a leading dot in the home directory. Here, the whole repository.

## Feature parity

The requirement that `bootstrap.sh` and `bootstrap.ps1` produce equivalent results. Any change to install behavior must land in both.

## Ghostty / Kitty

Terminal emulators configured by this repo; both themed with Tokyo Night to match Neovim.

## Idempotent run

A run that, repeated on an already-configured machine, changes nothing — guaranteed here by skip-if-exists guards on every write.

## NVIM_APPNAME

A Neovim environment variable that namespaces the config and state directories. Set to `nvim.iferdel.git` so the custom config never collides with a system Neovim.

## nvimf

The generated wrapper (a `~/bin` script on POSIX, a profile function on Windows) that launches Neovim with `NVIM_APPNAME=nvim.iferdel.git`. Also set as Git's `core.editor`.

## Portable vimrc

The dependency-free `vim/.vimrc`, carried manually to SSH or foreign hosts where the full Neovim setup is unwanted.

## Skip-if-exists

The guard rule: a write is performed only when its destination is absent. The mechanism behind the non-destructive, re-runnable install.

## Symlink pair

A `SRC|DEST` relationship where the destination is a symbolic link back into the repo, making the repo the live source of truth for that config.

## Tool-owned file

A destination a tool rewrites at runtime, so it is copied rather than symlinked. See *copy pair*.

## Preferred / discouraged language

Prefer:

- "links" / "copies" / "skips" — name the actual action.
- "skip-if-exists", "safe to re-run", "non-destructive".
- "tool-owned file" for a copied destination.

Avoid:

- "installs" used loosely — it places config, it does not install tools.
- "syncs" — there is no two-way synchronization.
- "idempotent" stated without the home-side-edit caveat (see `06_risk_model.md`, Mode D).
- "deploys" — overstates what a personal dotfiles run is.
