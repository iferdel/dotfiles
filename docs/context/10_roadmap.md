# Roadmap

Directional only. "May", "could", "explore" — no dates, no commitments.

## Near-term

### Parity enforcement

- Could add a lightweight check (a test harness, or a checklist commit hook) that flags when `bootstrap.sh` and `bootstrap.ps1` diverge, since parity is currently convention-only.
- May extract the symlink-pair list into a shared, declarative source both scripts read, so a new pair is added once.

### Publication safety

- May add a pre-commit secret scan so the publication checklist is partly automated rather than fully manual.
- Could review and parameterize the host-specific `[safe]` directory entries in `git/.gitconfig`.

## Medium-term

### Update path

- Could explore an explicit `update` mode that refreshes tool-owned copies (`~/.bash_aliases`, `~/.psqlrc`) on demand, since the skip-if-exists install path cannot push updates to them.
- May add a doctor / verify mode that detects dangling symlinks after a repo move.

### Tooling surface

- Could promote the context-project generator to a proper Claude Code skill, as its own README anticipates.
- May add a small set of synthetic fixtures so the bootstrap logic can be exercised in a container.

## Long-term

- Explore testing both bootstrap scripts in disposable containers / VMs in CI.
- Consider an uninstall path that removes the symlinks and shell-rc lines this repo added.
- Consider whether the portable `vim/.vimrc` and the full Neovim config can share a common core.

## Intentionally deferred

- **A profiles / templating system** — the repo encodes one person's environment on purpose; generality would add moving parts against principle 7.
- **`tmux` configuration** — Neovim already covers window and terminal management; adding it would only duplicate keymaps.
- **A tool installer / package manager** — installing the tools themselves is explicitly out of scope; `go.sh` stays a minimal opt-in exception.
- **OS-level version pinning** — only the Neovim plugin set is locked; pinning system packages is left to the OS package manager.

## Roadmap principle

A roadmap item earns its place only if it strengthens the central claim — *one safe, idempotent, non-destructive run* — or reduces a residual risk from `06_risk_model.md` (script drift, stale copies, dangling symlinks, secret leakage). Items that add configurability, generality, or new tools for their own sake are declined; fewer moving parts is the default.
