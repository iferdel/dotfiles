# Implementation Notes

## Purpose

Code-level guidance for working in this repository — where a run starts, how the bootstrap scripts are structured, and how the Neovim config is laid out. It is the public-safe counterpart to the install steps in `04_install_flow.md`; it names actual files and does not repeat the data shapes from `05_data_model.md`.

## Orchestration

A run starts at `bootstrap.sh` (POSIX) or `bootstrap.ps1` (Windows), invoked from inside the repo clone. There is no other entry point — no daemon, no library API. `go.sh` is a separate, independent script for installing Go database tooling (goose, sqlc) and is never called by bootstrap.

`bootstrap.sh` is a flat, top-to-bottom script with numbered comment-banner sections: symlink setup, alias copy, `.psqlrc` copy, shell-rc wiring, `nvimf` wrapper, Git editor. Failures are isolated per unit: each symlink pair and each copy is independently guarded, so a skip or error in one does not abort the rest. Only a missing dotfiles-aliases source file is fatal (`exit 1`).

## Module shape

### `bootstrap.sh` / `bootstrap.ps1`

Same logical contract, platform-specific primitives. Keep them at parity (see `README.md` and `02_product_principles.md`). Key differences: `$HOME` vs `$env:USERPROFILE`; `ln -s` vs `New-Item -ItemType SymbolicLink`; `.bashrc`/`.zshrc` vs `$PROFILE`; a `~/bin/nvimf` script vs an `nvimf` profile function.

### `nvim/` Neovim configuration

- `init.lua` — entry point: loads `config.lazy` and `config.lang.go`, sets global options and keymaps.
- `lua/config/lazy.lua` — lazy.nvim bootstrap and colorscheme.
- `lua/config/plugins/*.lua` — one file per plugin, auto-imported by lazy.nvim.
- `lua/config/lang/go.lua` — Go utilities menu, loaded directly from `init.lua`.
- `lua/config/os/detection.lua` — OS detection helpers.
- `after/ftplugin/*.lua` — per-filetype buffer-local settings, auto-loaded on filetype detection.
- `plugin/*.lua` — custom in-tree plugins (`floaterminal.lua`, `menu.lua`).

### `vim/.vimrc`

Standalone, no dependency on the Neovim tree. `vim/Dockerfile` exists to test it in isolation.

## Key algorithms

The repository has no algorithms in the computational sense. The two pieces of logic whose correctness matters:

1. **Guarded write.** Before any symlink, check `[ -e "$DEST" ] || [ -L "$DEST" ]` and skip if true. This single check is what makes the run non-destructive and re-runnable — it must never be weakened. Note the `-L` test: a *dangling* symlink still counts as existing and is skipped.
2. **Conditional copy.** For tool-owned files, copy only when the destination is missing or `cmp -s` reports a content difference. This compares bytes, not timestamps, so it is clock-skew-immune — but it also means a home-side edit is silently overwritten on the next run (`06_risk_model.md`, Mode D).

## Configuration knobs

- `NVIM_APPNAME=nvim.iferdel.git` — set by the `nvimf` wrapper; the namespace isolating this Neovim config. Changing it changes the config/state directory names.
- `SYMLINK_PAIRS` array in `bootstrap.sh` — the list of `SRC|DEST` pairs. Adding a config tree means adding a pair here (and its equivalent in `bootstrap.ps1`).
- Global `shiftwidth` in `nvim/init.lua`, overridden per language in `after/ftplugin/`.
- `nvim/lazy-lock.json` — the committed plugin version lock; changing it means a deliberate plugin update.

## Testing

There is no automated test suite. Verification is manual: the bootstrap scripts are exercised on real target machines, and the success criteria in `09_scope.md` are the de-facto test plan. `vim/Dockerfile` allows the portable `.vimrc` to be checked in a clean container. Any future fixtures must be synthetic — never a real home directory.

## Repo hygiene

- Runtime-written files (shell/`psql` history, Neovim plugin install and state directories, LSP caches) live in `$HOME` and are never tracked.
- No secrets in the tree — see `07_data_handling.md` and `13_publication_checklist.md`.
- The Neovim plugin set is pinned via `lazy-lock.json`, which *is* committed.
- Claude must never execute `bootstrap.sh`, `bootstrap.ps1`, or `go.sh` — edit-and-answer only (`02_product_principles.md`, principle 6).

## Future directions

The implementation is heading toward making the parity rule and the publication rule less reliant on human discipline — a shared declarative pair list, a secret-scan hook, a container-based exercise of both bootstrap scripts. See `10_roadmap.md`; the guiding constraint is to add such tooling only where it removes a residual risk, not to add configurability.
