# Public Data Model

## Overview

This project has no runtime data store. Its "data" is the static set of relationships the bootstrap script establishes between repository paths and home-directory destinations. The entities below describe those relationships — a symlink pair, a copy pair, and a shell-rc edit — as the bootstrap script reasons about them. All values are synthetic placeholders.

## Symlink pair

A source path inside the repo and the destination it is linked to. The bootstrap script holds these as a list of `SRC|DEST` strings.

```text
source:      <repo>/nvim
destination: ~/.config/nvim.iferdel.git
kind:        directory
action:      symlink
guard:       skip if destination exists or is already a symlink
```

```json
{
  "source": "<repo>/git/.gitconfig",
  "destination": "~/.gitconfig",
  "kind": "file",
  "action": "symlink",
  "guard": "skip-if-exists"
}
```

## Copy pair

A source file copied into the home directory because the destination is tool-owned.

```json
{
  "source": "<repo>/bash/aliases.sh",
  "destination": "~/.bash_aliases",
  "kind": "file",
  "action": "copy",
  "guard": "copy-if-missing-or-differs"
}
```

## Shell-rc edit

A single idempotent line appended to the platform shell rc.

```json
{
  "target": "~/.bashrc | ~/.zshrc | $PROFILE",
  "line": "if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi",
  "action": "append-once",
  "guard": "skip-if-line-present"
}
```

## Enums / categorical vocabularies

### `action`

| Value | Meaning |
|---|---|
| `symlink` | Destination is a symbolic link back to the repo; repo is the live source. |
| `copy` | Destination is an independent copy; refreshed only when bytes differ. |
| `append-once` | A line is appended to an existing file if not already present. |
| `generate` | A file is created from a template (the `nvimf` wrapper). |

### `guard`

| Value | Meaning |
|---|---|
| `skip-if-exists` | Do nothing if the destination is already present. |
| `copy-if-missing-or-differs` | Write only when destination is absent or content-differs from source. |
| `skip-if-line-present` | Append only when a fixed-string match for the line is absent. |

### `platform`

| Value | Detection | Shell rc |
|---|---|---|
| `macos` | `OSTYPE == darwin*` | `~/.zshrc` |
| `wsl2` | `/proc/version` mentions Microsoft | `~/.bashrc` |
| `linux` | otherwise on POSIX | `~/.bashrc` |
| `windows` | `bootstrap.ps1` invoked | `$PROFILE` |

## Relationships

Each symlink pair and copy pair is independent — there is no ordering dependency and no foreign key between them. The shell-rc edit is logically downstream of the copy pair (it sources `~/.bash_aliases`, which the copy creates) but the script does not enforce that order, because the sourced line tolerates a missing file. The `nvimf` wrapper references the `nvim/` symlink destination indirectly via `NVIM_APPNAME`; Git's `core.editor` references the `nvimf` wrapper path.

## Data minimization

Any artifact derived from this model and shared outside the project MUST NOT include:

- Absolute home paths that embed a real username or corporate machine ID (use `~` or `<repo>`).
- The real Git identity beyond what is already public in repo history.
- Real `~/.psql_history` contents or any database connection string.
- Real WSL2/Windows host paths (the `[safe]` directory entries in `git/.gitconfig` are an example of host-specific paths that should be reviewed before publication).
