# Install Layout Contract (v1.0)

**Locked at v1.0.** Any breaking change to the paths, names, or guarantees below requires a version bump.

## Purpose

This system produces no data files. Its "output" is a set of filesystem placements — symlinks, copies, generated files, and one appended line — created in the user's home directory by a bootstrap run. This document locks those placements so that the `nvimf` wrapper, the shell rc, Git's editor setting, and any future tooling can depend on stable paths and names. If a destination path or generated name here changes, downstream references break.

## Scope

This spec covers:

- The destination paths the bootstrap scripts write.
- The name and namespace of the generated `nvimf` wrapper.
- The fixed shell-rc line.
- The skip/copy guarantees a re-run must honor.

It does not cover the *content* of the configuration files (that is each tool's own format) or the internal layout of the repository source trees.

## Filename and path conventions

Destinations are addressed relative to `$HOME` (`$env:USERPROFILE` on Windows). The locked destinations:

| Source (in repo) | Destination | Mechanism |
|---|---|---|
| `nvim/` | `~/.config/nvim.iferdel.git` | symlink |
| `git/.gitconfig` | `~/.gitconfig` | symlink |
| `kitty/` | `~/.config/kitty` | symlink |
| `ghostty/` | `~/.config/ghostty` | symlink |
| `bash/aliases.sh` | `~/.bash_aliases` | copy |
| `psql/.psqlrc` | `~/.psqlrc` | copy |
| (generated) | `~/bin/nvimf` | generate (POSIX) |

On Windows the symlink destinations are analogous under `$env:USERPROFILE`, and `nvimf` is a function in `$PROFILE` rather than a `~/bin` script.

## Field-name conventions

- The Neovim namespace is exactly `nvim.iferdel.git` — used as both `NVIM_APPNAME` and the config directory suffix. It is a literal, not a template.
- The generated launcher is exactly `nvimf` (no extension on POSIX).
- The bootstrap pair list uses `SRC|DEST` strings with a single `|` separator and no spaces around it.

## Categorical vocabularies (locked)

### Field `mechanism`

| Value | Meaning |
|---|---|
| `symlink` | `ln -s` (POSIX) / `New-Item -ItemType SymbolicLink` (Windows); repo is the live source. |
| `copy` | `cp` of a tool-owned file; performed only on content difference. |
| `generate` | A file created by the script (the `nvimf` wrapper). |
| `append-once` | The shell-rc source line, added if absent. |

### Field `platform`

| Value | Shell rc target |
|---|---|
| `macos` | `~/.zshrc` |
| `linux` | `~/.bashrc` |
| `wsl2` | `~/.bashrc` |
| `windows` | `$PROFILE` |

## Numeric / temporal conventions

Not applicable — the system writes no numeric or timestamped output. The conditional copy compares file content (`cmp -s`), never timestamps.

## Payload shapes

### Generated `nvimf` wrapper (POSIX)

A minimal executable shell script at `~/bin/nvimf` that launches Neovim with the locked namespace:

```sh
#!/usr/bin/env bash
NVIM_APPNAME=nvim.iferdel.git nvim "$@"
```

### Shell-rc appended line

Exactly one line, appended verbatim, matched as a fixed string on re-run:

```sh
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
```

### Git editor setting

`core.editor` is set to the absolute path of the generated `nvimf` wrapper.

## Versioning

A version bump is required when: a destination path changes, the `nvimf` name or namespace changes, the shell-rc line text changes, or the skip/copy guarantee changes. Non-breaking changes (no bump): adding a new symlink pair, editing the *content* of a config file, adding a new platform whose destinations follow the existing conventions.

## Rejection rules for consumers

- A consumer (a wrapper, a script, future tooling) MUST reference Neovim config via `NVIM_APPNAME=nvim.iferdel.git`, never by hard-coding `~/.config/nvim`.
- A consumer MUST treat a pre-existing destination as authoritative and MUST NOT overwrite it — the same skip-if-exists rule the bootstrap scripts apply.
- A consumer MUST NOT assume `~/.bash_aliases` or `~/.psqlrc` is a symlink; they are copies.
- A re-run MUST NOT duplicate the shell-rc line; it MUST be matched as a fixed string before appending.

## Status

v1.0, locked. Any breaking change to the paths, generated names, or skip/copy guarantees above requires a version bump.
