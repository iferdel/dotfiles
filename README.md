# dotfiles

This repository houses my personal dotfiles for Neovim, Bash, Git, and Kitty terminal.
- tmux is not in the list since neovim covers what tmux is capable of and thus reducing the overwelming complexity of having more than needed keymaps and between two pieces of software.

## Installation

### macOS / Linux / WSL2

```bash
./bootstrap.sh
```

### Windows (PowerShell)

```powershell
.\bootstrap.ps1
```

**Note:** Symlinks on Windows require either:
- Running PowerShell as Administrator, OR
- Enabling Developer Mode in Windows Settings > Update & Security > For developers

## Maintaining Bootstrap Scripts

**IMPORTANT:** This repository maintains two bootstrap scripts that must be kept in sync:
- `bootstrap.sh` - For macOS, Linux, and WSL2
- `bootstrap.ps1` - For native Windows PowerShell

**When modifying functionality, update BOTH scripts to maintain feature parity.**

### Key Differences:
- **Paths:** bash uses `$HOME`, PowerShell uses `$env:USERPROFILE`
- **Shell Config:** bash targets `.bashrc`/`.zshrc`, PowerShell targets `$PROFILE`
- **Symlinks:** bash uses `ln -s`, PowerShell uses `New-Item -ItemType SymbolicLink`
- **nvimf wrapper:** bash creates shell script in `~/bin/`, PowerShell adds function to profile

## Dependencies

```bash
brew install git-delta
```
