# Data Handling

## Data classes

| Class | Where it lives | Public-safe? |
|---|---|---|
| Configuration files | `nvim/`, `kitty/`, `ghostty/`, `git/`, `psql/`, `vim/`, `bash/`, `windows-terminal/` | Yes — these are the point of the repo |
| Git identity | `git/.gitconfig` (`user.email`, `user.name`) | Yes — already public in commit history |
| Host-specific paths | `[safe]` directory entries in `git/.gitconfig`; absolute editor path | Borderline — review before publishing |
| Plugin lock | `nvim/lazy-lock.json` | Yes — public plugin commit pins |
| Shell history | `~/.psql_history`, shell history files | No — never in the repo, lives in `$HOME` only |
| Credentials / tokens | not present | No — must never be committed |

## Data-handling model

The repository is plain text under Git. There is no encryption layer and no access control beyond the hosting platform's repo visibility — which means the only real control is *what gets committed in the first place*. Configuration files are committed because they are the deliverable. Anything a tool writes at runtime — `psql` query history, shell history, LSP caches, the Neovim plugin install directory — lives in the home directory and is never tracked. The Git identity in `git/.gitconfig` is treated as already-public information, since it appears in every commit anyway.

## What must NOT appear in the repo

- API keys, tokens, passwords, SSH private keys, TLS certs.
- Database connection strings or `~/.pgpass` contents.
- `~/.psql_history` or any shell history.
- Corporate machine identifiers, internal hostnames, or employee IDs embedded in paths.
- Absolute paths that encode a real username on a corporate host.

## What CAN appear

- All editor, terminal, shell, Git, and database-client configuration.
- The Neovim Lua tree, custom plugins, and `lazy-lock.json`.
- The Git identity already present in commit history.
- Synthetic example values in documentation.
- Structural configuration: keymaps, themes, aliases, prompt strings.

## Aggregation principle

This project produces no datasets, so row-level vs. aggregate does not apply directly. The analogous rule: documentation and examples should describe *shapes and conventions* (a `SRC|DEST` pair, a prompt format) rather than reproduce a real machine's exact home-directory layout with its real username. Use `~` and `<repo>` placeholders instead of literal absolute paths.

## Acceptable-use boundaries

The project is intended to install and version one person's terminal environment, and to be browsed by others for ideas. It is not intended to be run by a third party against their own machine as a turnkey installer — it encodes personal preferences and a specific `NVIM_APPNAME`. Forking and adapting is fine; running the owner's `bootstrap.sh` unmodified on someone else's machine is not the intended use.

## Honest limitation statement

Nothing in the repository technically enforces the "no secrets" rule — Git will commit whatever it is told to. The protection is entirely operational: the publication checklist in `13_publication_checklist.md`, a secret scan before publishing, and the discipline of keeping runtime-written files out of the tree. If those practices lapse, the repo has no second line of defense. Treat every commit to a publishable dotfiles repo as a publish.
