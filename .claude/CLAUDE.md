# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository managing Neovim, Bash, Git, Kitty, Ghostty, and PostgreSQL (`psql`) configurations. Also includes a portable `.vimrc` (`vim/`) for SSH/foreign servers and Windows Terminal settings (`windows-terminal/`). Uses symlinks to install configurations without modifying files directly (`.psqlrc` and bash aliases are copied, not symlinked).

## IMPORTANT: Script Execution Policy

**NEVER execute bootstrap.sh or any installation scripts.** These scripts modify the user's system and should only be run manually by the user. Claude's role is limited to:
- Helping modify or create shell scripts
- Editing configuration files
- Answering questions about the setup

**DO NOT run: bootstrap.sh, go.sh, or any setup/installation commands.**

## Key Scripts (Reference Only - DO NOT EXECUTE)

- `bootstrap.sh` - User's installation script that:
  - Creates symlink from `nvim/` to `~/.config/nvim.iferdel.git`
  - Creates symlink from `kitty/` to `~/.config/kitty`
  - Creates symlink from `ghostty/` to `~/.config/ghostty`
  - Symlinks `git/.gitconfig` to `~/.gitconfig`
  - Copies bash aliases to `~/.bash_aliases`
  - Copies `psql/.psqlrc` to `~/.psqlrc`
  - Creates `~/bin/nvimf` wrapper for custom Neovim instance, adds `~/bin` to PATH
  - Sets Git core.editor to nvimf
  - Platform-aware (macOS uses zsh, WSL2/Linux uses bash)

- `go.sh` - User's Go tooling setup script that installs:
  - goose (database migrations)
  - sqlc (SQL code generation)

## Neovim Configuration Architecture

### Structure
- `nvim/init.lua` - Entry point, loads lazy.nvim and sets global options/keymaps
- `nvim/lua/config/lazy.lua` - Plugin manager bootstrap and tokyonight setup
- `nvim/lua/config/plugins/*.lua` - Individual plugin configurations (lazy.nvim auto-imports)
- `nvim/lua/config/lang/go.lua` - Go utilities menu (loaded directly from init.lua)
- `nvim/lua/config/os/detection.lua` - OS detection helpers (mac/win/wsl/linux)
- `nvim/lua/config/telescope/multigrep.lua` - Custom telescope live multigrep picker
- `nvim/after/ftplugin/*.lua` - Filetype-specific settings (auto-loaded by vim on filetype detection)
- `nvim/plugin/*.lua` - Custom plugins (floaterminal, menu)

### Important Configuration Details
- Uses `NVIM_APPNAME=nvim.iferdel.git` for namespace isolation (run via `nvimf` alias)
- Leader key: `<space>`, local leader: `\`
- Plugin manager: lazy.nvim
- Colorscheme: tokyonight (transparent mode disabled; custom line-number highlights)
- LSP servers configured: lua_ls, gopls, pylsp, ccls, dockerls, yamlls
  - Uses Neovim 0.11+ native `vim.lsp.config` / `vim.lsp.enable` API
  - pylsp launched via `uv run pylsp`, with ruff enabled for lint/format
  - yamlls uses SchemaStore + Kustomize schemas
- Auto-format on save when LSP supports formatting
- Auto-organize imports on save for Go and Python files

### Key Plugins
- blink.cmp - Autocompletion with LSP integration (disabled for markdown)
- telescope.nvim - Fuzzy finder
- oil.nvim - Directory viewer (not a file tree)
- harpoon - File navigation
- dbee - Database UI (with vim-dadbod-completion for SQL)
- nvim-dap - Debugging
- mini.nvim - Collection of small utilities
- git-conflict.nvim - Merge conflict resolution
- bufferline.nvim - Tab-style bufferline (mode = "tabs")
- lualine.nvim - Statusline (tokyonight theme, global statusline)
- which-key.nvim - Keymap hint popups
- treesitter - Syntax highlighting/parsing
- noice.nvim - UI enhancements

### Custom Features
- `<space>st` - Open bottom terminal (10 lines high)
- `<space>sc` - Open terminal in current window
- `<space>gos` - Telescope picker for Go stdlib source code (GOROOT)
- `<space>gom` - Telescope picker for Go modules in GOPATH
- `<space>goc` - Open Go Cookbook in browser
  - Go utilities defined in `lua/config/lang/go.lua`; falls back to `vim.ui.select` if which-key is absent
- `<space><space>x` - Execute entire Lua file
- `<space>x` - Execute current line (normal mode) or selection (visual mode)

### Filetype Settings (after/ftplugin/)
- Go: 2-space indentation, line wrapping disabled
- Python, Lua, Shell, SQL, YAML, JSON, C, HTML, JavaScript, Markdown: Custom settings per file

## Development Workflow

### Testing Neovim Config Changes
1. Edit Lua files in `nvim/` directory
2. In Neovim: `<space><space>x` to source current file
3. Or restart Neovim with changes

### Adding New Plugins
1. Create file in `nvim/lua/config/plugins/<plugin-name>.lua`
2. Return table with plugin spec (lazy.nvim format)
3. Lazy.nvim auto-discovers and loads it

### Adding Filetype Settings
1. Create `nvim/after/ftplugin/<filetype>.lua`
2. Use `vim.opt_local` for buffer-local settings
3. Vim auto-loads on filetype detection

## LSP Configuration

LSP setup in `nvim/lua/config/plugins/lsp.lua`:
- Capabilities connected to blink.cmp for autocompletion
- Auto-format on BufWritePre when server supports formatting
- Auto-organize imports for Go on save
- Diagnostic display: virtual text, signs, underline enabled

### Checking LSP
- `:echo executable('gopls')` should return 1 if LSP found
- `:checkhealth` for plugin diagnostics

## Bash Configuration

Aliases defined in `bash/aliases.sh`:
- `nvimf` - Launch Neovim with custom config (NVIM_APPNAME=nvim.iferdel.git)

Platform-specific shell config sourcing handled by bootstrap.sh (user runs manually).

## Git Configuration

Config in `git/.gitconfig` (symlinked to `~/.gitconfig`). Git editor set to `~/bin/nvimf` wrapper by bootstrap.sh (user runs manually). Uses `delta` as pager/diff filter, `histogram` diff algorithm, `zdiff3` conflict style, rebase-on-pull, and `rerere` enabled.

## PostgreSQL Configuration

`psql/.psqlrc` copied to `~/.psqlrc` by bootstrap.sh. Enables expanded auto display, verbose errors, and null display formatting.

## Kitty Terminal Configuration

Configuration file: `kitty/kitty.conf`

### Features
- Full-featured setup with Tokyo Night color scheme matching Neovim theme
- Custom keymaps with `ctrl+shift` prefix
- Tab bar with powerline style
- Background opacity: 0.95
- Editor set to `nvimf` for integration with custom Neovim
- Remote control enabled via Unix socket at `/tmp/kitty`

### Key Settings
- Font: JetBrainsMono Nerd Font, 11pt
- Layout: splits and stack layouts enabled
- Scrollback: 10,000 lines
- Clear all default shortcuts enabled, custom keymaps defined

### Notable Keymaps
- `ctrl+shift+f2` - Edit config file
- `ctrl+shift+f5` - Reload config
- `ctrl+shift+enter` - New window
- `ctrl+shift+t` - New tab
- `ctrl+shift+e` - Hints mode (text selection)

## Ghostty Terminal Configuration

Configuration file: `ghostty/config`

Symlinked to `~/.config/ghostty/config` by bootstrap.sh.

## Platform Support

- macOS: Uses zsh, targets `~/.zshrc`
- WSL2: Uses bash, targets `~/.bashrc`
- Linux: Uses bash, targets `~/.bashrc`

bootstrap.sh detects platform via OSTYPE and /proc/version checks.

## Workarounds

- Treesitter compatibility: `vim.hl = vim.highlight` workaround for neovim issue #31675 (init.lua:10)
- Terminal insert mode exit: `<C-Space>` (and `<F3>` for Windows compatibility) mapped to `<C-\><C-n>`
