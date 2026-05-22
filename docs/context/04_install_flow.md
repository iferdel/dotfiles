# Install Flow

## Purpose

One "run" of this system is a single invocation of `bootstrap.sh` (or `bootstrap.ps1`) from inside a clone of the repository. The run walks a fixed sequence of placement steps and leaves the machine with the configuration installed. There is no daemon and no second phase — the run is the whole system in motion.

## Stages

```text
resolve repo dir → symlink configs → copy tool-owned files → wire shell rc → generate nvimf wrapper → set git editor
```

### 1. Resolve repository directory

`DOTFILES_DIR` is set to the current working directory (`$(pwd)` on POSIX). The script must therefore be run from inside the repo. Every later path is derived from this root, so an incorrect working directory is the one input that invalidates the whole run.

### 2. Symlink configuration trees

For each `SRC|DEST` pair (`nvim/` → `~/.config/nvim.iferdel.git`, `git/.gitconfig` → `~/.gitconfig`, `kitty/` → `~/.config/kitty`, `ghostty/` → `~/.config/ghostty`):

- Create the parent directory of `DEST` if missing.
- If `SRC` does not exist, report an error and skip that pair.
- If `DEST` already exists or is already a symlink, print a warning and skip.
- Otherwise create the symlink and report it.

### 3. Copy tool-owned files

`bash/aliases.sh` → `~/.bash_aliases` and `psql/.psqlrc` → `~/.psqlrc`. Each copy is conditional: the file is copied only if the destination is missing or its bytes differ from the source (`cmp -s`). Identical files report "already up to date".

### 4. Wire the shell rc

The line `if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi` is appended to the platform shell rc — `~/.zshrc` on macOS, `~/.bashrc` on Linux/WSL2, `$PROFILE` on Windows. The append is guarded by a fixed-string grep so a re-run does not duplicate it.

### 5. Generate the `nvimf` wrapper

On POSIX a small shell script is written to `~/bin/nvimf` that runs Neovim with `NVIM_APPNAME=nvim.iferdel.git`; `~/bin` is added to `PATH` via the shell rc. On Windows an equivalent `nvimf` function is added to the PowerShell `$PROFILE`. This is what isolates the custom Neovim namespace from any system Neovim.

### Output

After the run the machine has: live symlinks to the config trees, copied tool-owned files, a shell rc that sources the aliases and exposes `~/bin`, an `nvimf` launcher, and Git's `core.editor` pointed at that launcher. No file in the repo is modified; no pre-existing destination is changed.

## Determinism and replay

The output of a run is determined by two inputs: the repository contents and the pre-existing state of the destination machine. Given the same repo and the same machine state, a run produces the same result. Re-running on a machine the script already configured is a near-no-op: every symlink destination now exists, so step 2 skips everything; tool-owned copies match, so step 3 reports "up to date"; the shell-rc line is found, so step 4 skips. The only non-idempotent surface is a tool-owned file the user edited *in the home directory* after install — the next run will copy the repo version back over it, because the conditional copy compares bytes, not timestamps or ownership.

## Scoping

There are no flags that narrow a run — the script installs everything. The only scoping is platform detection: `bootstrap.sh` branches on `OSTYPE` and `/proc/version` to choose macOS vs. Linux vs. WSL2 behavior (chiefly which shell rc to target). `go.sh` is a separate, opt-in run that is never invoked by the bootstrap script.
