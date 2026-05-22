# Product Principles

## 1. Never overwrite what already exists

The bootstrap script skips any destination that is already present — symlink, copy, or shell-rc line. A re-run must never destroy a machine's prior state or the user's later edits. When unsure whether to write, do not write; report the skip and move on.

## 2. Link by default, copy only when forced

Symlink configs so the repo is the single source of truth and `git pull` is the update mechanism. Copy a file *only* when a tool rewrites it at runtime or expects to own it (`~/.bash_aliases`, `~/.psqlrc`). Reach for a copy reluctantly, and document why each copy exists.

## 3. Edit in the repo, never in place

Installation places files; it does not modify them at their destination. Configuration changes happen in the repo and propagate through the symlink. This keeps history honest and the working tree authoritative.

## 4. The two bootstrap scripts move together

`bootstrap.sh` and `bootstrap.ps1` are one feature with two implementations. Any change to install behavior lands in both in the same commit. Drift between them is a bug, not a backlog item.

## 5. Coexist with the host environment

Install alongside whatever the machine already has. The Neovim config runs under `NVIM_APPNAME=nvim.iferdel.git` precisely so it never collides with a system Neovim. Append to shell rc files; never rewrite them.

## 6. Claude reads and edits, the user runs

Installation scripts modify the user's system, so Claude must never execute `bootstrap.sh`, `bootstrap.ps1`, or `go.sh`. Claude's role is to edit configs and scripts and answer questions; running them is always the user's action.

## 7. Prefer fewer moving parts

`tmux` is deliberately absent because Neovim already covers window and terminal management — a second tool would only add overlapping keymaps. When a capability is already met, do not add software to meet it again.

## 8. Keep a portable fallback

The full Neovim setup assumes plugins, a Nerd Font, and a managed runtime. For SSH and foreign servers none of that is wanted, so a dependency-free `vim/.vimrc` is maintained as a first-class artifact, not an afterthought.

## 9. Lock what would otherwise drift silently

The Neovim plugin set is pinned in `nvim/lazy-lock.json` and committed, so a fresh install resolves the same plugin versions. Lock the things whose silent drift would be hard to notice; leave the rest to the system package manager.

## 10. Match indentation to the language, not to a global rule

A global `shiftwidth` exists, but per-filetype `after/ftplugin/` files override it where the language community expects something else (Go uses tabs/2-space alignment, etc.). Respect the ecosystem's norm over a personal default.

## 11. Theme consistency across the stack

Kitty, Ghostty, and Neovim share the Tokyo Night palette on purpose. A consistent visual identity across the terminal stack reduces friction; when adding a tool with a theme, match it.
