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
          style          = "moon",
          transparent    = false,
          dim_inactive   = true,
          lualine_bold   = true,
          on_highlights = function(hl, c)
            hl.CursorLineNr             = { fg = c.orange, bold = true }
            hl.LineNrAbove              = { fg = c.blue }
            hl.LineNrBelow              = { fg = c.blue }
            hl.WinSeparator             = { fg = c.fg_gutter }
            hl["@function.builtin.lua"] = { fg = c.yellow }
          end,
        },
        config = function(_, opts)
          require("tokyonight").setup(opts)
          vim.cmd.colorscheme "tokyonight"
          vim.opt.cursorline = true
          vim.opt.cursorlineopt = "number"
        end
      },
      -- import your plugins
      { import = "config.plugins" },
    },
  })
