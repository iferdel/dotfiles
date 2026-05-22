# Risk Model

## Scope

This document covers *operational* risk — the ways a bootstrap run, or the repository itself, can leave a machine in a wrong or surprising state. It is not a security threat model in the adversarial sense: the repository is single-author, runs only when the owner invokes it, and has no network-exposed surface. The one genuine disclosure risk — committing a secret or a host-specific path to a public repo — is treated here and in `07_data_handling.md`.

## Assets

- A working terminal environment on each of the owner's machines.
- The user's *pre-existing* configuration on a machine being bootstrapped — must survive the run untouched.
- The repository's publishability — it can be made public only while it contains no secrets or host-identifying data.
- Feature parity between `bootstrap.sh` and `bootstrap.ps1`.

## Trust boundaries

### Partially trusted

- The destination machine's pre-existing state — assumed possibly non-empty; every write is guarded.
- The optional `go.sh`, which pulls Go tooling from upstream module hosts.
- The Neovim plugin set — pinned in `lazy-lock.json` but sourced from third-party repos.

### Not fully trusted

- Nothing is adversarially untrusted. The repo, the scripts, and the invoking user are all the owner.

## Threat actors / failure modes

### Mode A — Overwriting pre-existing configuration

A bootstrap run lands on a machine that already has a `~/.gitconfig` or a system Neovim setup.

Mitigation: every symlink destination is guarded by a skip-if-exists check; tool-owned files are copied only when content differs; the Neovim namespace is isolated under `NVIM_APPNAME=nvim.iferdel.git` so it cannot collide with a system `~/.config/nvim`.

### Mode B — Bootstrap-script drift

A change is made to `bootstrap.sh` but not `bootstrap.ps1` (or vice versa), so Windows and POSIX installs diverge.

Mitigation: the README and `CLAUDE.md` both state the parity rule explicitly; reviewers check both scripts on any install-behavior change. This mitigation is procedural, not enforced — see residual risks.

### Mode C — Secret or host-path leakage

A credential, token, history file, or corporate machine path is committed and the repo is later made public. The `[safe]` directory entries in `git/.gitconfig` already embed Windows host paths.

Mitigation: the publication checklist (`13_publication_checklist.md`) is run before any publish; `.psql_history` lives outside the repo; aliases and configs are reviewed for embedded secrets.

### Mode D — Stale tool-owned copy

A user edits `~/.bash_aliases` or `~/.psqlrc` in place after install; a later bootstrap run silently copies the repo version back over the edit.

Mitigation: the documented workflow is "edit in the repo, not in place" (`02_product_principles.md`, principle 3). For copied files this is convention only — the script does not detect a home-side edit as intentional.

### Mode E — Wrong working directory

The script is run from outside the repo, so `DOTFILES_DIR` resolves wrong and `SRC` paths do not exist.

Mitigation: each pair checks `SRC` existence and skips with an error rather than creating a broken symlink. The run fails loudly per-pair instead of corrupting destinations.

### Mode F — Broken or dangling symlink

A config tree is moved or the repo clone is deleted after install; the symlink destinations now dangle.

Mitigation: none automatic. The fix is to re-clone to the same path or re-run bootstrap after removing the dead links. This is an accepted residual risk.

## Attack / failure classes

- **Clobbering** — addressed by skip-if-exists guards (Mode A).
- **Drift** — both script-to-script drift (Mode B) and repo-vs-home copy drift (Mode D).
- **Staleness** — symlinks dangle when the repo path changes (Mode F); plugin lock can age.
- **Disclosure** — secrets or host paths committed to a publishable repo (Mode C).
- **Replay** — re-running is safe by design; not a risk class here.

## Residual risks

- Script parity is enforced by convention, not tooling — `bootstrap.sh` and `bootstrap.ps1` can still drift between reviews.
- A home-side edit to a copied file is indistinguishable from staleness; the next run overwrites it.
- Dangling symlinks after a repo move are not detected or repaired.
- The repo cannot prevent a future commit from introducing a secret; only the checklist stands between that and a public push.

## Preferred / discouraged language

Use:

- "skips an existing destination", "guarded write", "safe to re-run".
- "copies if content differs", "appends the line once".
- "isolated Neovim namespace".

Avoid:

- "installs" without qualification when "links or copies, skipping existing files" is meant.
- "syncs" — the script does not two-way sync; it places files once.
- "idempotent" stated absolutely — it is idempotent *except* for the home-side-edit case in Mode D.
