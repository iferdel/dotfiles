-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim into runtimepath of neovim
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
  {
    change_detection = {
      notify = false,
    },
    spec = {
      {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
          transparent = true,
        },
        config = function(_, opts)
          require("tokyonight").setup(opts)
          vim.cmd.colorscheme "tokyonight"
          -- Enable cursorline for CursorLineNr to work
          vim.opt.cursorline = true
          vim.opt.cursorlineopt = "number"
          -- Increase contrast for line numbers
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })  -- Current line number (bright orange)
          vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7aa2f7" })  -- Relative line numbers above cursor
          vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#7aa2f7" })  -- Relative line numbers below cursor
        end
      },
      -- import your plugins
      { import = "config.plugins" },
    },
  })
